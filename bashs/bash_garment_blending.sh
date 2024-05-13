#!/bin/bash
# 是一个函数的名称，通常用于显示程序或脚本的使用说明。这个函数通常会在用户提供的参数不正确或不完整时被调用，以提供使用该程序或脚本的正确语法和选项。在这个函数中，你可以包含程序或脚本的帮助文本，并指导用户如何正确地使用它。
usage() {
  echo "Usage: ${0} [-g|--gpu] [-c|--case] [-s|--sparse_weight]  [-lr|--learning_rate]  [-lr_geo|--learning_rate_geo]"  1>&2
  exit 1
}
# shift 2表示将参数列表中的参数向左移动两个位置
# 右括号）用于闭合case语句中每个选项的条件,*)用于case语句中的默认分支
# 在Shell脚本中，;;用于表示case语句中的一个分支结束。它表示当前分支的处理结束，程序将继续执行case语句后面的代码，而不会继续检查后续分支。;;通常用于case语句的每个分支的结尾处。
# 在Shell脚本中，while后面通常不需要分号。然而，如果在一行中写下了while和do ，那么while与do之间就必须使用分号来分隔它们，以标识while语句的开始。这种写法通常用于将多个命令放在同一行中时，以提高代码的紧凑性。
while [[ $# -gt 0 ]];do
  key=${1}
  case ${key} in
    -c|--case)
      CASE=${2}
      shift 2
      ;;
    -g|--gpu)
      GPU=${2}
      shift 2
      ;;
    -s|--sparse_weight)
      SPARSE_WEIGHT=${2}
      shift 2
      ;;
      -t|--threshold)
      SPARSE_WEIGHT=${2}
      shift 2
      ;;
    -lr|--learning_rate)
      LR=${2}
      shift 2
      ;;
    -lr_geo|--learning_rate_geo)
      LR_GEO=${2}
      shift 2
      ;;
    *)
      usage
      shift
      ;;
  esac
# 在Shell脚本中，esac是case的倒序，用于标记case语句的结束。
done

# 这段命令是在Linux环境下使用CUDA_VISIBLE_DEVICES环境变量来指定GPU设备，并运行Python脚本exp_runner_blending.py      --mode validate_mesh   --is_continue
CUDA_VISIBLE_DEVICES=${GPU} python exp_runner_blending.py --conf ./confs/udf_garment_blending.conf \
--case ${CASE} --threshold 0.01 --resolution 256 --vis_ray --reg_weights_schedule --sparse_weight ${SPARSE_WEIGHT}