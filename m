Return-Path: <linux-kernel+bounces-889986-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ED85FC3F012
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 09:45:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 727EC188CF6C
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Nov 2025 08:45:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48F9D25F7B9;
	Fri,  7 Nov 2025 08:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="EhCNlyn8";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="F/mwyaRH"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF2AB26A0DD
	for <linux-kernel@vger.kernel.org>; Fri,  7 Nov 2025 08:45:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762505119; cv=none; b=G2BIzGcZSVUEvkPl0rFYZUnbaSKchzeFAIddivjLVwruqGM26PpZxHc9RIsqLFwnhWmpQE+IokkrUj93jx4lFzIMoYhf5wVsArT5HrMIR3DWIngtUwlYO17AjqT1FLiLeIsjYO3amvDg12RaBKBjiXKPf8PddQxjGOGKGwVyz6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762505119; c=relaxed/simple;
	bh=JLXcj3Nw9jtU1GLnUV0qqBPHSxD3M60YlYbAi9Zs3aY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=a3uAWZ7fCdVrkSB00WsL/O3BRMxxpD3ETqXMFXMFzNsVwaPjoH79bv4Ue5Ls5xvwqNkyi1r1nFJdYlv4vRM8nu66bW66E/ifWfB/PZMuvjqfBS7MG2RQRFrQwJM47OAXBgY4XMzPQJ6CNzra1Jl7WszcBnUsWLDlJ53iRHg5aO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=EhCNlyn8; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=F/mwyaRH; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5A753aiH2280814
	for <linux-kernel@vger.kernel.org>; Fri, 7 Nov 2025 08:45:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	t4ufeC/WE7LMof6aI2LD9onxDMqiyIQGU0Mw2AX+MZk=; b=EhCNlyn8XNwb1lls
	BFBWzkrPrwUiNt97cNXsr98VThx5ZLlrWU92dIIFUlzeuWJLnNgS4GaCpPmmqK9U
	AJcroD6CDmFs4zWgSGjfESBD0PXeY83x9wDau15spZobHy7XlmE/h6r6aTFZFy8p
	91c2mjwQa2F7orxoVFDZ9LoCpaubSEYz2ex6uNt+3DUHVusOzbJcXQU39rM/81TX
	N/ucjOMmwm1/YEOrMK/HyqIlVQ04hFTn1SwqB9wstXz3IiUZan8aEh5oSgwd/t24
	OK/X09zipBltbKCL8cdmk8P2jaMbWHuZ4c2mAWXlEUqGbUsSaBSzOGpBUydWjGcZ
	EoVevw==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a9a9sgjuk-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 07 Nov 2025 08:45:16 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2953deecdaeso13218745ad.2
        for <linux-kernel@vger.kernel.org>; Fri, 07 Nov 2025 00:45:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1762505115; x=1763109915; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=t4ufeC/WE7LMof6aI2LD9onxDMqiyIQGU0Mw2AX+MZk=;
        b=F/mwyaRHBmn4a0gWxrh7Kd0cfUhTEOk4bXAyxWT6q+InX36ZJxrgl2FniCvfzFt3JP
         lq0XppZwM59UhYifYbPJMcKnrRRJMa04HQM35dIjPH/YSe4k5eSY83HrJ9pMxXziGv7P
         JquGq8PUz+sb8dOtlamBFrG3vjS+Z/EgqAMkK5MupC2tljxRTU7P0HQ1gFGTCd6caCO7
         srQqSebuta7CWJDKM86g7k4tA4eAvCW0YR5ejAPX+92CB0IwVQgvRe+KIr0maiu2b4Y6
         sciVw2QuzrLymysUU+9Y0UV2FTtaQat3eMwQ1Iflqh19Osc8LCWlDMBWKiSBjqXG2GVu
         NRYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762505115; x=1763109915;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=t4ufeC/WE7LMof6aI2LD9onxDMqiyIQGU0Mw2AX+MZk=;
        b=oOXG8eao9yvSSgxUrv4SrNnkvh6SSp0X4KZgXTTSN99TcD1eqO8ldBzZTepU65kyzq
         AOLEgnEEu6SqtR0JV+0GqJIJ2MmxXfAXXhRVEI2dyP29yPU08ye59bH/IIZcgAenXFRo
         dzHRr0UWlHAdufkab9ieV1Nb5Fpv+M8aFMlKqQeFzS8zWnIZYFuKg2KaokBtD+V+CDRR
         WqOO3WK9t9mXst0D78IV1yrOLGxUOn/5RdtD/pRpT5WW3FCtsnxzB7fLL7uBwsKqAuHX
         akj3Vg2MQhti2OxpPRu3BgeUjkfm58+8Km+PFHiv9IV+Dtu3QMp+RB3dojIvGZlui+1Z
         KhOg==
X-Forwarded-Encrypted: i=1; AJvYcCXxA3dEauxBhhncm38CBRxRK8sbdLDUg4hV6Uaf8Y7FVcZzTcxv/4PCy22PaLsr9s6VaClw5mgy6U/9Ltc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzmuemyKH4ccGp3y0+49hOSwA9peU1TWUJDmkwv/+YyAEbyY6Yp
	V52bLYMDbYNJllhrgRIE8kf7rPPC39UTjP3MH/bCii16AD8oYVwnvSzvvkjvLxXAMV0nDUVMiwa
	zSk2/YyaFq1DrEgcn80cBaUpB8TKJlSeIfBkf2P9fnzQ4rtw2X7OPZWVXjmz9rkclEEy+OrbHyk
	o=
X-Gm-Gg: ASbGncs34pZMmOHfF/bsHDIvkMpwmcR3JmeS2txikQvfWGIXK5wj/92XS0vUm5txAup
	Ym2DLAIxQBMG6mcTbF6cesPI7SHc5cS5efILknQusqXImMji42gKqm77+r6Uh9zmfrhqzFE9S5I
	wqPriO98G2AtxJgMYSEyt/mCY/y/fY6cavnqwlOCnTlCKH9j9sPgEEf2Rh3/Klr6yz9Og9t3dZ2
	zUIQYtIaW4FmP7tX9vElUvSErbvywHPnOAb1mIJKuUhsj49P1eRAjY5150XEoMfGepN4GS4yqt+
	72GRspoeVuR+5uhK5DYxY8Ocj2fI5CB0EZRw/z19UMCzoC7htFMRY0oc1x3y5PQMtq7MA5JPbAH
	wCmT5hGbfvW3D2WKZEiweEWElISVqz8g=
X-Received: by 2002:a17:902:da85:b0:28d:18d3:46ca with SMTP id d9443c01a7336-297c047567fmr38059075ad.49.1762505115156;
        Fri, 07 Nov 2025 00:45:15 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGkgwYu59V4chCbAr5ylsPYsyN6E4jey08udRygWC4pIZOpCkj6YcKHfW4mZx4hk/3fdRN7KQ==
X-Received: by 2002:a17:902:da85:b0:28d:18d3:46ca with SMTP id d9443c01a7336-297c047567fmr38058635ad.49.1762505114467;
        Fri, 07 Nov 2025 00:45:14 -0800 (PST)
Received: from [10.0.0.3] ([106.222.229.252])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29651cd0ee9sm53228285ad.112.2025.11.07.00.45.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Nov 2025 00:45:14 -0800 (PST)
Message-ID: <a4e2609a-0fef-41a3-baa4-5d7297b186a9@oss.qualcomm.com>
Date: Fri, 7 Nov 2025 14:15:09 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v4 4/6] media: qcom: iris: Add rotation support for
 encoder
Content-Language: en-US
To: Wangao Wang <wangao.wang@oss.qualcomm.com>,
        Vikash Garodia <vikash.garodia@oss.qualcomm.com>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Bryan O'Donoghue <bod@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Neil Armstrong <neil.armstrong@linaro.org>, quic_qiweil@quicinc.com,
        quic_renjiang@quicinc.com
References: <20251106-iris_encoder_enhancements-v4-0-5d6cff963f1b@oss.qualcomm.com>
 <20251106-iris_encoder_enhancements-v4-4-5d6cff963f1b@oss.qualcomm.com>
From: Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>
In-Reply-To: <20251106-iris_encoder_enhancements-v4-4-5d6cff963f1b@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=CdgFJbrl c=1 sm=1 tr=0 ts=690db19c cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=L4UNg9I9cQSOxNpRiiGXlA==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8
 a=7WLilky2Wt_WIXxIBaQA:9 a=QEXdDO2ut3YA:10 a=GvdueXVYPmCkWapjIL-Q:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA3MDA2OSBTYWx0ZWRfX7266F7MBZoD1
 F004rKKov+UaDnDpEUCUmYhB6NJbXJE8mlDFH+CCPd7O6D/njkCwORBmSBYweRPbK82ghin2+t9
 80rKqpv4nEoUgRNZx5am3Xhb8HC3UFGxWza9iWADKmkMzqLolHgz2s8eCbCgTPq5WfHE7/G7VnW
 BY1gu87Uy9XBtKE3iaXnJZ3VLD0CHccWuzUeuvbOJfv1To+VbQ2kj2xb+e1sk7wKq/sYEMYHPHy
 Jlb7jYx0KJmJQROd9TTUKOLt/VmpHePJmctoxosWIqpjmiVObWOKAANs7XuJCTlrb2lLxoA/oze
 uZ9n6QFGV3VWRMVZZl429FM8O0fgSIyFXYsbXoCSDr/UIDyoqjd9LPnH2d1ZeRrd+3CU6ajWJ7z
 CKrf4iTAsgKsNsEZufNSBQZi6l0plw==
X-Proofpoint-ORIG-GUID: 4yU3fKXo8aXTimvWL-uWsLKjTjMrsY1n
X-Proofpoint-GUID: 4yU3fKXo8aXTimvWL-uWsLKjTjMrsY1n
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-07_02,2025-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 adultscore=0 malwarescore=0 spamscore=0 bulkscore=0
 phishscore=0 lowpriorityscore=0 clxscore=1015 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511070069



On 11/6/2025 9:00 AM, Wangao Wang wrote:
> Add rotation control for encoder, enabling V4L2_CID_ROTATE and handling
>  90/180/270 degree rotation.
> 
> Co-developed-by: Neil Armstrong <neil.armstrong@linaro.org>
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> Tested-by: Neil Armstrong <neil.armstrong@linaro.org> # on SM8650-HDK
> Signed-off-by: Wangao Wang <wangao.wang@oss.qualcomm.com>
> ---
>  drivers/media/platform/qcom/iris/iris_ctrls.c      | 34 +++++++++++++++
>  drivers/media/platform/qcom/iris/iris_ctrls.h      |  1 +
>  .../platform/qcom/iris/iris_hfi_gen2_command.c     | 41 ++++++++++++-----
>  .../platform/qcom/iris/iris_hfi_gen2_defines.h     |  9 ++++
>  .../platform/qcom/iris/iris_platform_common.h      |  1 +
>  .../media/platform/qcom/iris/iris_platform_gen2.c  | 10 +++++
>  drivers/media/platform/qcom/iris/iris_utils.c      |  6 +++
>  drivers/media/platform/qcom/iris/iris_utils.h      |  1 +
>  drivers/media/platform/qcom/iris/iris_vpu_buffer.c | 51 +++++++++++++---------
>  9 files changed, 123 insertions(+), 31 deletions(-)
> 

Reviewed-by: Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>

Thanks,
Dikshita

> diff --git a/drivers/media/platform/qcom/iris/iris_ctrls.c b/drivers/media/platform/qcom/iris/iris_ctrls.c
> index 754a5ad718bc37630bb861012301df7a2e7342a1..00949c207ddb0203e51df359214bf23c3d8265d0 100644
> --- a/drivers/media/platform/qcom/iris/iris_ctrls.c
> +++ b/drivers/media/platform/qcom/iris/iris_ctrls.c
> @@ -98,6 +98,8 @@ static enum platform_inst_fw_cap_type iris_get_cap_id(u32 id)
>  		return B_FRAME_QP_H264;
>  	case V4L2_CID_MPEG_VIDEO_HEVC_B_FRAME_QP:
>  		return B_FRAME_QP_HEVC;
> +	case V4L2_CID_ROTATE:
> +		return ROTATION;
>  	default:
>  		return INST_FW_CAP_MAX;
>  	}
> @@ -185,6 +187,8 @@ static u32 iris_get_v4l2_id(enum platform_inst_fw_cap_type cap_id)
>  		return V4L2_CID_MPEG_VIDEO_H264_B_FRAME_QP;
>  	case B_FRAME_QP_HEVC:
>  		return V4L2_CID_MPEG_VIDEO_HEVC_B_FRAME_QP;
> +	case ROTATION:
> +		return V4L2_CID_ROTATE;
>  	default:
>  		return 0;
>  	}
> @@ -883,6 +887,36 @@ int iris_set_qp_range(struct iris_inst *inst, enum platform_inst_fw_cap_type cap
>  				     &range, sizeof(range));
>  }
>  
> +int iris_set_rotation(struct iris_inst *inst, enum platform_inst_fw_cap_type cap_id)
> +{
> +	const struct iris_hfi_command_ops *hfi_ops = inst->core->hfi_ops;
> +	u32 hfi_id = inst->fw_caps[cap_id].hfi_id;
> +	u32 hfi_val;
> +
> +	switch (inst->fw_caps[cap_id].value) {
> +	case 0:
> +		hfi_val = HFI_ROTATION_NONE;
> +		return 0;
> +	case 90:
> +		hfi_val = HFI_ROTATION_90;
> +		break;
> +	case 180:
> +		hfi_val = HFI_ROTATION_180;
> +		break;
> +	case 270:
> +		hfi_val = HFI_ROTATION_270;
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	return hfi_ops->session_set_property(inst, hfi_id,
> +					     HFI_HOST_FLAGS_NONE,
> +					     iris_get_port_info(inst, cap_id),
> +					     HFI_PAYLOAD_U32,
> +					     &hfi_val, sizeof(u32));
> +}
> +
>  int iris_set_properties(struct iris_inst *inst, u32 plane)
>  {
>  	const struct iris_hfi_command_ops *hfi_ops = inst->core->hfi_ops;
> diff --git a/drivers/media/platform/qcom/iris/iris_ctrls.h b/drivers/media/platform/qcom/iris/iris_ctrls.h
> index 30af333cc4941e737eb1ae83a6944b4192896e23..3ea0a00c7587a516f19bb7307a0eb9a60c856ab0 100644
> --- a/drivers/media/platform/qcom/iris/iris_ctrls.h
> +++ b/drivers/media/platform/qcom/iris/iris_ctrls.h
> @@ -32,6 +32,7 @@ int iris_set_min_qp(struct iris_inst *inst, enum platform_inst_fw_cap_type cap_i
>  int iris_set_max_qp(struct iris_inst *inst, enum platform_inst_fw_cap_type cap_id);
>  int iris_set_frame_qp(struct iris_inst *inst, enum platform_inst_fw_cap_type cap_id);
>  int iris_set_qp_range(struct iris_inst *inst, enum platform_inst_fw_cap_type cap_id);
> +int iris_set_rotation(struct iris_inst *inst, enum platform_inst_fw_cap_type cap_id);
>  int iris_set_properties(struct iris_inst *inst, u32 plane);
>  
>  #endif
> diff --git a/drivers/media/platform/qcom/iris/iris_hfi_gen2_command.c b/drivers/media/platform/qcom/iris/iris_hfi_gen2_command.c
> index 815e3e435fbc5a36efb633bc0cc330ff8e86ad47..2f6a3c0e51134f0ef24336a66f34b4b61882554b 100644
> --- a/drivers/media/platform/qcom/iris/iris_hfi_gen2_command.c
> +++ b/drivers/media/platform/qcom/iris/iris_hfi_gen2_command.c
> @@ -180,22 +180,36 @@ static int iris_hfi_gen2_set_raw_resolution(struct iris_inst *inst, u32 plane)
>  						  sizeof(u32));
>  }
>  
> +static inline u32 iris_hfi_get_aligned_resolution(struct iris_inst *inst, u32 width, u32 height)
> +{
> +	u32 codec_align = inst->codec == V4L2_PIX_FMT_HEVC ? 32 : 16;
> +
> +	return (ALIGN(width, codec_align) << 16 | ALIGN(height, codec_align));
> +}
> +
>  static int iris_hfi_gen2_set_bitstream_resolution(struct iris_inst *inst, u32 plane)
>  {
>  	struct iris_inst_hfi_gen2 *inst_hfi_gen2 = to_iris_inst_hfi_gen2(inst);
>  	u32 port = iris_hfi_gen2_get_port(inst, plane);
>  	enum hfi_packet_payload_info payload_type;
> -	u32 resolution, codec_align;
> +	u32 width, height;
> +	u32 resolution;
>  
>  	if (inst->domain == DECODER) {
> -		resolution = inst->fmt_src->fmt.pix_mp.width << 16 |
> -			inst->fmt_src->fmt.pix_mp.height;
> +		width = inst->fmt_src->fmt.pix_mp.width;
> +		height = inst->fmt_src->fmt.pix_mp.height;
> +		resolution = iris_hfi_get_aligned_resolution(inst, width, height);
>  		inst_hfi_gen2->src_subcr_params.bitstream_resolution = resolution;
>  		payload_type = HFI_PAYLOAD_U32;
>  	} else {
> -		codec_align = inst->codec == V4L2_PIX_FMT_HEVC ? 32 : 16;
> -		resolution = ALIGN(inst->enc_scale_width, codec_align) << 16 |
> -			ALIGN(inst->enc_scale_height, codec_align);
> +		if (is_rotation_90_or_270(inst)) {
> +			width = inst->enc_scale_height;
> +			height = inst->enc_scale_width;
> +		} else {
> +			width = inst->enc_scale_width;
> +			height = inst->enc_scale_height;
> +		}
> +		resolution = iris_hfi_get_aligned_resolution(inst, width, height);
>  		inst_hfi_gen2->dst_subcr_params.bitstream_resolution = resolution;
>  		payload_type = HFI_PAYLOAD_32_PACKED;
>  	}
> @@ -239,10 +253,17 @@ static int iris_hfi_gen2_set_crop_offsets(struct iris_inst *inst, u32 plane)
>  			left_offset = inst->crop.left;
>  			top_offset = inst->crop.top;
>  		} else {
> -			bottom_offset = (ALIGN(inst->enc_scale_height, codec_align) -
> -					inst->enc_scale_height);
> -			right_offset = (ALIGN(inst->enc_scale_width, codec_align) -
> -				       inst->enc_scale_width);
> +			if (is_rotation_90_or_270(inst)) {
> +				bottom_offset = (ALIGN(inst->enc_scale_width, codec_align) -
> +						inst->enc_scale_width);
> +				right_offset = (ALIGN(inst->enc_scale_height, codec_align) -
> +					       inst->enc_scale_height);
> +			} else {
> +				bottom_offset = (ALIGN(inst->enc_scale_height, codec_align) -
> +						inst->enc_scale_height);
> +				right_offset = (ALIGN(inst->enc_scale_width, codec_align) -
> +					       inst->enc_scale_width);
> +			}
>  			left_offset = 0;
>  			top_offset = 0;
>  		}
> diff --git a/drivers/media/platform/qcom/iris/iris_hfi_gen2_defines.h b/drivers/media/platform/qcom/iris/iris_hfi_gen2_defines.h
> index aa1f795f5626c1f76a32dd650302633877ce67be..4edcce7faf5e2f74bfecfdbf574391d5b1c9cca5 100644
> --- a/drivers/media/platform/qcom/iris/iris_hfi_gen2_defines.h
> +++ b/drivers/media/platform/qcom/iris/iris_hfi_gen2_defines.h
> @@ -83,6 +83,15 @@ enum hfi_seq_header_mode {
>  };
>  
>  #define HFI_PROP_SEQ_HEADER_MODE		0x03000149
> +
> +enum hfi_rotation {
> +	HFI_ROTATION_NONE = 0x00000000,
> +	HFI_ROTATION_90   = 0x00000001,
> +	HFI_ROTATION_180  = 0x00000002,
> +	HFI_ROTATION_270  = 0x00000003,
> +};
> +
> +#define HFI_PROP_ROTATION			0x0300014b
>  #define HFI_PROP_SIGNAL_COLOR_INFO		0x03000155
>  #define HFI_PROP_PICTURE_TYPE			0x03000162
>  #define HFI_PROP_DEC_DEFAULT_HEADER		0x03000168
> diff --git a/drivers/media/platform/qcom/iris/iris_platform_common.h b/drivers/media/platform/qcom/iris/iris_platform_common.h
> index 58d05e0a112eed25faea027a34c719c89d6c3897..9a4232b1c64eea6ce909e1e311769dd958b84c6e 100644
> --- a/drivers/media/platform/qcom/iris/iris_platform_common.h
> +++ b/drivers/media/platform/qcom/iris/iris_platform_common.h
> @@ -140,6 +140,7 @@ enum platform_inst_fw_cap_type {
>  	P_FRAME_QP_HEVC,
>  	B_FRAME_QP_H264,
>  	B_FRAME_QP_HEVC,
> +	ROTATION,
>  	INST_FW_CAP_MAX,
>  };
>  
> diff --git a/drivers/media/platform/qcom/iris/iris_platform_gen2.c b/drivers/media/platform/qcom/iris/iris_platform_gen2.c
> index d3306189d902a1f42666010468c9e4e4316a66e1..c1f83e179d441c45df8d6487dc87e137e482fb63 100644
> --- a/drivers/media/platform/qcom/iris/iris_platform_gen2.c
> +++ b/drivers/media/platform/qcom/iris/iris_platform_gen2.c
> @@ -588,6 +588,16 @@ static struct platform_inst_fw_cap inst_fw_cap_sm8550_enc[] = {
>  		.flags = CAP_FLAG_OUTPUT_PORT,
>  		.set = iris_set_u32,
>  	},
> +	{
> +		.cap_id = ROTATION,
> +		.min = 0,
> +		.max = 270,
> +		.step_or_mask = 90,
> +		.value = 0,
> +		.hfi_id = HFI_PROP_ROTATION,
> +		.flags = CAP_FLAG_OUTPUT_PORT,
> +		.set = iris_set_rotation,
> +	},
>  };
>  
>  static struct platform_inst_caps platform_inst_cap_sm8550 = {
> diff --git a/drivers/media/platform/qcom/iris/iris_utils.c b/drivers/media/platform/qcom/iris/iris_utils.c
> index 85c70a62b1fd2c409fc18b28f64771cb0097a7fd..97465dfbdec1497b1111b9069fd56dff286b2d0e 100644
> --- a/drivers/media/platform/qcom/iris/iris_utils.c
> +++ b/drivers/media/platform/qcom/iris/iris_utils.c
> @@ -124,3 +124,9 @@ int iris_check_core_mbps(struct iris_inst *inst)
>  
>  	return 0;
>  }
> +
> +bool is_rotation_90_or_270(struct iris_inst *inst)
> +{
> +	return inst->fw_caps[ROTATION].value == 90 ||
> +		inst->fw_caps[ROTATION].value == 270;
> +}
> diff --git a/drivers/media/platform/qcom/iris/iris_utils.h b/drivers/media/platform/qcom/iris/iris_utils.h
> index 75740181122f5bdf93d64d3f43b3a26a9fe97919..b5705d156431a5cf59d645ce988bc3a3c9b9c5e2 100644
> --- a/drivers/media/platform/qcom/iris/iris_utils.h
> +++ b/drivers/media/platform/qcom/iris/iris_utils.h
> @@ -51,5 +51,6 @@ void iris_helper_buffers_done(struct iris_inst *inst, unsigned int type,
>  int iris_wait_for_session_response(struct iris_inst *inst, bool is_flush);
>  int iris_check_core_mbpf(struct iris_inst *inst);
>  int iris_check_core_mbps(struct iris_inst *inst);
> +bool is_rotation_90_or_270(struct iris_inst *inst);
>  
>  #endif
> diff --git a/drivers/media/platform/qcom/iris/iris_vpu_buffer.c b/drivers/media/platform/qcom/iris/iris_vpu_buffer.c
> index db5adadd1b39c06bc41ae6f1b3d2f924b3ebf150..1e54ace966c74956208d88f06837b97b1fd48e17 100644
> --- a/drivers/media/platform/qcom/iris/iris_vpu_buffer.c
> +++ b/drivers/media/platform/qcom/iris/iris_vpu_buffer.c
> @@ -556,6 +556,22 @@ static u32 iris_vpu_dec_scratch1_size(struct iris_inst *inst)
>  		iris_vpu_dec_line_size(inst);
>  }
>  
> +static inline u32 iris_vpu_enc_get_bitstream_width(struct iris_inst *inst)
> +{
> +	if (is_rotation_90_or_270(inst))
> +		return inst->fmt_dst->fmt.pix_mp.height;
> +	else
> +		return inst->fmt_dst->fmt.pix_mp.width;
> +}
> +
> +static inline u32 iris_vpu_enc_get_bitstream_height(struct iris_inst *inst)
> +{
> +	if (is_rotation_90_or_270(inst))
> +		return inst->fmt_dst->fmt.pix_mp.width;
> +	else
> +		return inst->fmt_dst->fmt.pix_mp.height;
> +}
> +
>  static inline u32 size_bin_bitstream_enc(u32 width, u32 height,
>  					 u32 rc_type)
>  {
> @@ -638,10 +654,9 @@ static inline u32 hfi_buffer_bin_enc(u32 width, u32 height,
>  static u32 iris_vpu_enc_bin_size(struct iris_inst *inst)
>  {
>  	u32 num_vpp_pipes = inst->core->iris_platform_data->num_vpp_pipe;
> +	u32 height = iris_vpu_enc_get_bitstream_height(inst);
> +	u32 width = iris_vpu_enc_get_bitstream_width(inst);
>  	u32 stage = inst->fw_caps[STAGE].value;
> -	struct v4l2_format *f = inst->fmt_dst;
> -	u32 height = f->fmt.pix_mp.height;
> -	u32 width = f->fmt.pix_mp.width;
>  	u32 lcu_size;
>  
>  	if (inst->codec == V4L2_PIX_FMT_HEVC)
> @@ -676,9 +691,8 @@ u32 hfi_buffer_comv_enc(u32 frame_width, u32 frame_height, u32 lcu_size,
>  
>  static u32 iris_vpu_enc_comv_size(struct iris_inst *inst)
>  {
> -	struct v4l2_format *f = inst->fmt_dst;
> -	u32 height = f->fmt.pix_mp.height;
> -	u32 width = f->fmt.pix_mp.width;
> +	u32 height = iris_vpu_enc_get_bitstream_height(inst);
> +	u32 width = iris_vpu_enc_get_bitstream_width(inst);
>  	u32 num_recon = 1;
>  	u32 lcu_size = 16;
>  
> @@ -958,9 +972,8 @@ u32 hfi_buffer_non_comv_enc(u32 frame_width, u32 frame_height,
>  static u32 iris_vpu_enc_non_comv_size(struct iris_inst *inst)
>  {
>  	u32 num_vpp_pipes = inst->core->iris_platform_data->num_vpp_pipe;
> -	struct v4l2_format *f = inst->fmt_dst;
> -	u32 height = f->fmt.pix_mp.height;
> -	u32 width = f->fmt.pix_mp.width;
> +	u32 height = iris_vpu_enc_get_bitstream_height(inst);
> +	u32 width = iris_vpu_enc_get_bitstream_width(inst);
>  	u32 lcu_size = 16;
>  
>  	if (inst->codec == V4L2_PIX_FMT_HEVC) {
> @@ -1051,9 +1064,8 @@ u32 hfi_buffer_line_enc_vpu33(u32 frame_width, u32 frame_height, bool is_ten_bit
>  static u32 iris_vpu_enc_line_size(struct iris_inst *inst)
>  {
>  	u32 num_vpp_pipes = inst->core->iris_platform_data->num_vpp_pipe;
> -	struct v4l2_format *f = inst->fmt_dst;
> -	u32 height = f->fmt.pix_mp.height;
> -	u32 width = f->fmt.pix_mp.width;
> +	u32 height = iris_vpu_enc_get_bitstream_height(inst);
> +	u32 width = iris_vpu_enc_get_bitstream_width(inst);
>  	u32 lcu_size = 16;
>  
>  	if (inst->codec == V4L2_PIX_FMT_HEVC) {
> @@ -1069,9 +1081,8 @@ static u32 iris_vpu_enc_line_size(struct iris_inst *inst)
>  static u32 iris_vpu33_enc_line_size(struct iris_inst *inst)
>  {
>  	u32 num_vpp_pipes = inst->core->iris_platform_data->num_vpp_pipe;
> -	struct v4l2_format *f = inst->fmt_dst;
> -	u32 height = f->fmt.pix_mp.height;
> -	u32 width = f->fmt.pix_mp.width;
> +	u32 height = iris_vpu_enc_get_bitstream_height(inst);
> +	u32 width = iris_vpu_enc_get_bitstream_width(inst);
>  	u32 lcu_size = 16;
>  
>  	if (inst->codec == V4L2_PIX_FMT_HEVC) {
> @@ -1292,9 +1303,8 @@ static inline u32 hfi_buffer_scratch1_enc(u32 frame_width, u32 frame_height,
>  static u32 iris_vpu_enc_scratch1_size(struct iris_inst *inst)
>  {
>  	u32 num_vpp_pipes = inst->core->iris_platform_data->num_vpp_pipe;
> -	struct v4l2_format *f = inst->fmt_dst;
> -	u32 frame_height = f->fmt.pix_mp.height;
> -	u32 frame_width = f->fmt.pix_mp.width;
> +	u32 frame_height = iris_vpu_enc_get_bitstream_height(inst);
> +	u32 frame_width = iris_vpu_enc_get_bitstream_width(inst);
>  	u32 num_ref = 1;
>  	u32 lcu_size;
>  	bool is_h265;
> @@ -1390,9 +1400,8 @@ static inline u32 hfi_buffer_scratch2_enc(u32 frame_width, u32 frame_height,
>  
>  static u32 iris_vpu_enc_scratch2_size(struct iris_inst *inst)
>  {
> -	struct v4l2_format *f = inst->fmt_dst;
> -	u32 frame_width = f->fmt.pix_mp.width;
> -	u32 frame_height = f->fmt.pix_mp.height;
> +	u32 frame_height = iris_vpu_enc_get_bitstream_height(inst);
> +	u32 frame_width = iris_vpu_enc_get_bitstream_width(inst);
>  	u32 num_ref = 1;
>  
>  	return hfi_buffer_scratch2_enc(frame_width, frame_height, num_ref,
> 

