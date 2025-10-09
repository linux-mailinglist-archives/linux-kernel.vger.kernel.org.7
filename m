Return-Path: <linux-kernel+bounces-846297-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A68C5BC77D5
	for <lists+linux-kernel@lfdr.de>; Thu, 09 Oct 2025 08:09:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7FB8C188E7F4
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 06:09:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F51B296BC4;
	Thu,  9 Oct 2025 06:09:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ccAdLBht"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9928717A31C
	for <linux-kernel@vger.kernel.org>; Thu,  9 Oct 2025 06:09:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759990144; cv=none; b=JgoTsv9zrX8h/FXan2tGgobFKeZicAlznpX6S9fsOyTqk3oWeyZON6fepNsYiwltUgqXmVt3JORDQQN8tBli9NCeYQdzp6Km+wd6rpigwj1LNnEaLjWyFa3hXrC/RaWx2Ewt3nwVCL1SkvGDxu0Gj8Gft2NeCoaXY1FkzleUB9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759990144; c=relaxed/simple;
	bh=IMVK40sm2NcG5ZRmo+Oju9RpeHsPjuUbEtnoHjf7C2A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=reB7GopcxOkJoNuFIhgOn44j33ivtZ9Q8OJlOuDb4//GuRu8SdTLZj2Rn4zojqLG6AQYPbLCrqq/Z2gutBUF9md/gPCDfZWoGhlrG2Q/wcrSJFotSl14XZ2DFoaGd0IdSxpgpRyhG9CyzNsjVfmZlFFICYjiD00f2OmvOmRX+Xg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ccAdLBht; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 598I5Ku9029223
	for <linux-kernel@vger.kernel.org>; Thu, 9 Oct 2025 06:09:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	5VNYivDnUfLZTl7bMdUNMetQ/vZqVVN7I186AOfTvuM=; b=ccAdLBht9ARxvcBK
	9ifZEihC9Ti1n/pVIV9w9o+V/b/0A8ycvz9c/0NmGPozI+W/nk6ZZ6ull/ED6CLD
	AG/Zw6lLW+xj3RIu7U2xg/2IoBpkQPCLNC3mq1sWhyTS1dRZjKM1FRVoMqtk8NLS
	gNC8tj1vWj5L2CCr0KZLAYdtQjQ9FIlo5ycmeKD4LBzGvnEr3PYxlV906kEHrWV+
	XnOQY8UbxdqsS0eFjDW2vxvkE4biFDUqmT4Alh8zSc6/kwQ7KvwuiQjfFbIj3+qh
	CxXUCUBp9/pC/RBqn4hJcVOJcR9BK/9N3p5c9kjPUgU3eBmp7J/DYHj0067wJflQ
	KmG+oA==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49nv4shn7u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 09 Oct 2025 06:09:01 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-b55735710f0so1204535a12.2
        for <linux-kernel@vger.kernel.org>; Wed, 08 Oct 2025 23:09:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759990140; x=1760594940;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5VNYivDnUfLZTl7bMdUNMetQ/vZqVVN7I186AOfTvuM=;
        b=QeweszTakxSSdQ7MCCpf8dLxL3MYiyHjuMRqI9IsV5eYn/IpcQ1Rwui0xFNtw4dTEa
         jE4gb+SFTV2io76Gs5Miwhx2zAdCQaoUJoIAk71/1TFEUyY3tb879UNoSPsN5qWTz6xM
         raQ8TOKnG7cRUWslY1eBqLQBjrf/117CXatzfkLznK0Tz+tU24Skukr+NWz41Sa0FNnQ
         CYDzQEKziqBB+oXLS5lGgvjBqFSuQYXlcTLFxis4CH6p/ASrGcon7dKIoJcCeszmWFxN
         HaQSy2cTWnVhBtbaDra0f5Ey3zGqM5cHY7XRVn/MVbDz8YAZJO3OKcX2RCuWF1pXtXt5
         FVQQ==
X-Forwarded-Encrypted: i=1; AJvYcCVdI4Ak/9TbJZcBX0doDHSEA291PCuyKOWb1tNU4gMnibhqc3b/SZEYewd531Va9EGyrSya+N7c7bbZSso=@vger.kernel.org
X-Gm-Message-State: AOJu0YxgRPTIKulU99F76V3WKRoaTKy5ZE+ODJRINpvSwHcYPz0NWZF5
	Ubkm43PCr7UUDEdDv5EOyyflnAnWBiDCzPtoUl7ZighrQzN+XPx2qzBL7vHD9uLGx5qil4XnZ6M
	Uv4mPNup1IUhehHJC3aaQkXaQw0kWRM7cGInVl97C9HMohJkePYEN3s8zOxGnbvSL920=
X-Gm-Gg: ASbGncuxTNKL7peczmSN5Flay+Iz3S0aK2aJ8mIXDWLOFblGhQ1gGknJKQx8er+YhZr
	bnaAKL3c1bf7P85viGlmcth22Dq9jy+sDGknoUsrKrpxQxTZR8yIlCFIALIGlkIVenOZuIrh8of
	LSHk/ZVLpw8EeMb0RdiZ51jcLigmdb2ribSAnP/b933xT/KN29Vxgy9WbvgspLuHwzzdZRPy1Ma
	1BYAMZw4gIXF5xylFbn0yul9vaYjGEYqM3lFg/NGANokzAc3P7m0ElCRSpwxnrB669TMIbF4i5C
	A7+KDOc8y0WTROkECfYvpSnBaowVpkO68UUfWVua07rFDxp3G7nebP6y/1lnqtdM2zAUg5ZfDFq
	58g==
X-Received: by 2002:a05:6a20:7291:b0:2fc:a1a1:4839 with SMTP id adf61e73a8af0-32da80da6dfmr8474799637.10.1759990140071;
        Wed, 08 Oct 2025 23:09:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGoguXu0CzQN5H5zRwQz23DknYXLZsw40ludZKkvNZtteCPuXC5RG+TdbBcFj6VRg4s0Wgg1Q==
X-Received: by 2002:a05:6a20:7291:b0:2fc:a1a1:4839 with SMTP id adf61e73a8af0-32da80da6dfmr8474752637.10.1759990139503;
        Wed, 08 Oct 2025 23:08:59 -0700 (PDT)
Received: from [10.0.0.3] ([106.222.229.252])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-794d510d55fsm1694334b3a.32.2025.10.08.23.08.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Oct 2025 23:08:58 -0700 (PDT)
Message-ID: <206dad42-7a7e-5293-55a0-d6d5bc702c07@oss.qualcomm.com>
Date: Thu, 9 Oct 2025 11:38:54 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 1/8] media: iris: turn platform caps into constants
Content-Language: en-US
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Vikash Garodia <vikash.garodia@oss.qualcomm.com>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Bryan O'Donoghue <bod@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Cc: linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20251008-iris-sc7280-v1-0-def050ba5e1f@oss.qualcomm.com>
 <20251008-iris-sc7280-v1-1-def050ba5e1f@oss.qualcomm.com>
From: Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>
In-Reply-To: <20251008-iris-sc7280-v1-1-def050ba5e1f@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: b31iqSdjntAl8y7lJVgQQ11OIsfuESLE
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA4MDEyMSBTYWx0ZWRfXzAJSJVrYJlOE
 Hr8ny/ChafABvLr+9BhHjVFZdg8ZXX/CZCmxOuq+wNlE1sGq+h/46y9KuG3jNP1yJWlhtOkpSq0
 mLCq9dSnH7EImbeopOI/9g738DTaytmhuD2bsGIXsa+aH5odZZLCz7C0z3lsO4cKkugIzIsXydC
 ZykqCjw0Lr0umAGdLdP9Snh63CJRaAS07rW+pwgBCx5eXNX3eFBqThu8mzrs18VXMaR8PSXTSsL
 9ZpC9MLHCGNjhvb/T+FAdGBcu6qHWFvns+ZGWV3ijzGfpgtZB3A20/di6EZCQ9vASDKeCGVfRnc
 HebXa+MNqjgsJnpZ1E+xkDcHEQos7wJW7hd+5mmv1R25CztrbqFttRf/QEPe+EwQUYoDNQcFxXH
 slxP3e4G0w9Ae2/RoH5vZIXR4bugcQ==
X-Authority-Analysis: v=2.4 cv=SfL6t/Ru c=1 sm=1 tr=0 ts=68e7517d cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=L4UNg9I9cQSOxNpRiiGXlA==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=EUspDBNiAAAA:8 a=JkJZgjudll8f3RTsVYkA:9
 a=QEXdDO2ut3YA:10 a=_Vgx9l1VpLgwpw_dHYaR:22
X-Proofpoint-ORIG-GUID: b31iqSdjntAl8y7lJVgQQ11OIsfuESLE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-09_01,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1015 malwarescore=0 bulkscore=0 priorityscore=1501
 suspectscore=0 impostorscore=0 lowpriorityscore=0 phishscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510080121



On 10/8/2025 10:02 AM, Dmitry Baryshkov wrote:
> Make all struct platform_inst_fw_cap instances constant, they are not
> modified at runtime.
> 
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> ---
>  drivers/media/platform/qcom/iris/iris_ctrls.c            | 2 +-
>  drivers/media/platform/qcom/iris/iris_platform_common.h  | 4 ++--
>  drivers/media/platform/qcom/iris/iris_platform_gen2.c    | 4 ++--
>  drivers/media/platform/qcom/iris/iris_platform_qcs8300.h | 4 ++--
>  drivers/media/platform/qcom/iris/iris_platform_sm8250.c  | 4 ++--
>  5 files changed, 9 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/media/platform/qcom/iris/iris_ctrls.c b/drivers/media/platform/qcom/iris/iris_ctrls.c
> index 754a5ad718bc37630bb861012301df7a2e7342a1..9da050aa1f7ce8152dfa46a706e2c27adfb5d6ce 100644
> --- a/drivers/media/platform/qcom/iris/iris_ctrls.c
> +++ b/drivers/media/platform/qcom/iris/iris_ctrls.c
> @@ -301,7 +301,7 @@ int iris_ctrls_init(struct iris_inst *inst)
>  
>  void iris_session_init_caps(struct iris_core *core)
>  {
> -	struct platform_inst_fw_cap *caps;
> +	const struct platform_inst_fw_cap *caps;
>  	u32 i, num_cap, cap_id;
>  
>  	caps = core->iris_platform_data->inst_fw_caps_dec;
> diff --git a/drivers/media/platform/qcom/iris/iris_platform_common.h b/drivers/media/platform/qcom/iris/iris_platform_common.h
> index 58d05e0a112eed25faea027a34c719c89d6c3897..17ed86bf78bb3b0bc3f0862253fba6505ac3d164 100644
> --- a/drivers/media/platform/qcom/iris/iris_platform_common.h
> +++ b/drivers/media/platform/qcom/iris/iris_platform_common.h
> @@ -215,9 +215,9 @@ struct iris_platform_data {
>  	const char *fwname;
>  	u32 pas_id;
>  	struct platform_inst_caps *inst_caps;
> -	struct platform_inst_fw_cap *inst_fw_caps_dec;
> +	const struct platform_inst_fw_cap *inst_fw_caps_dec;
>  	u32 inst_fw_caps_dec_size;
> -	struct platform_inst_fw_cap *inst_fw_caps_enc;
> +	const struct platform_inst_fw_cap *inst_fw_caps_enc;
>  	u32 inst_fw_caps_enc_size;
>  	struct tz_cp_config *tz_cp_config_data;
>  	u32 core_arch;
> diff --git a/drivers/media/platform/qcom/iris/iris_platform_gen2.c b/drivers/media/platform/qcom/iris/iris_platform_gen2.c
> index 36d69cc73986b74534a2912524c8553970fd862e..cbf38e13f89e5c4c46e759fbb86777854d751552 100644
> --- a/drivers/media/platform/qcom/iris/iris_platform_gen2.c
> +++ b/drivers/media/platform/qcom/iris/iris_platform_gen2.c
> @@ -19,7 +19,7 @@
>  #define VIDEO_ARCH_LX 1
>  #define BITRATE_MAX				245000000
>  
> -static struct platform_inst_fw_cap inst_fw_cap_sm8550_dec[] = {
> +static const struct platform_inst_fw_cap inst_fw_cap_sm8550_dec[] = {
>  	{
>  		.cap_id = PROFILE_H264,
>  		.min = V4L2_MPEG_VIDEO_H264_PROFILE_BASELINE,
> @@ -203,7 +203,7 @@ static struct platform_inst_fw_cap inst_fw_cap_sm8550_dec[] = {
>  	},
>  };
>  
> -static struct platform_inst_fw_cap inst_fw_cap_sm8550_enc[] = {
> +static const struct platform_inst_fw_cap inst_fw_cap_sm8550_enc[] = {
>  	{
>  		.cap_id = PROFILE_H264,
>  		.min = V4L2_MPEG_VIDEO_H264_PROFILE_BASELINE,
> diff --git a/drivers/media/platform/qcom/iris/iris_platform_qcs8300.h b/drivers/media/platform/qcom/iris/iris_platform_qcs8300.h
> index 35ea0efade73caa687d300779c5b1dc3b17a0128..87517361a1cf4b6fe53b8a1483188670df52c7e7 100644
> --- a/drivers/media/platform/qcom/iris/iris_platform_qcs8300.h
> +++ b/drivers/media/platform/qcom/iris/iris_platform_qcs8300.h
> @@ -5,7 +5,7 @@
>  
>  #define BITRATE_MAX				245000000
>  
> -static struct platform_inst_fw_cap inst_fw_cap_qcs8300_dec[] = {
> +static const struct platform_inst_fw_cap inst_fw_cap_qcs8300_dec[] = {
>  	{
>  		.cap_id = PROFILE_H264,
>  		.min = V4L2_MPEG_VIDEO_H264_PROFILE_BASELINE,
> @@ -189,7 +189,7 @@ static struct platform_inst_fw_cap inst_fw_cap_qcs8300_dec[] = {
>  	},
>  };
>  
> -static struct platform_inst_fw_cap inst_fw_cap_qcs8300_enc[] = {
> +static const struct platform_inst_fw_cap inst_fw_cap_qcs8300_enc[] = {
>  	{
>  		.cap_id = PROFILE_H264,
>  		.min = V4L2_MPEG_VIDEO_H264_PROFILE_BASELINE,
> diff --git a/drivers/media/platform/qcom/iris/iris_platform_sm8250.c b/drivers/media/platform/qcom/iris/iris_platform_sm8250.c
> index 16486284f8acccf6a95a27f6003e885226e28f4d..e29cba993fde922b579eb7e5a59ae34bb46f9f0f 100644
> --- a/drivers/media/platform/qcom/iris/iris_platform_sm8250.c
> +++ b/drivers/media/platform/qcom/iris/iris_platform_sm8250.c
> @@ -17,7 +17,7 @@
>  #define BITRATE_PEAK_DEFAULT	(BITRATE_DEFAULT * 2)
>  #define BITRATE_STEP		100
>  
> -static struct platform_inst_fw_cap inst_fw_cap_sm8250_dec[] = {
> +static const struct platform_inst_fw_cap inst_fw_cap_sm8250_dec[] = {
>  	{
>  		.cap_id = PIPE,
>  		.min = PIPE_1,
> @@ -38,7 +38,7 @@ static struct platform_inst_fw_cap inst_fw_cap_sm8250_dec[] = {
>  	},
>  };
>  
> -static struct platform_inst_fw_cap inst_fw_cap_sm8250_enc[] = {
> +static const struct platform_inst_fw_cap inst_fw_cap_sm8250_enc[] = {
>  	{
>  		.cap_id = STAGE,
>  		.min = STAGE_1,
> 

Reviewed-by: Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>

Thanks,
Dikshita

