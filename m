Return-Path: <linux-kernel+bounces-889989-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 26E0CC3F03C
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 09:47:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 203A74EC2AA
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Nov 2025 08:46:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AC7226529A;
	Fri,  7 Nov 2025 08:46:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="pJI9s/GX";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Ad1uyS8A"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 190CA1459FA
	for <linux-kernel@vger.kernel.org>; Fri,  7 Nov 2025 08:46:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762505176; cv=none; b=Ajp/gI8JaqEyyFBdrAcT7nGBQXEkccTWqr3yh2vQ2hbLMbsK9t/VtM/fKEhLZklIF3E/K2flCAMBtm0jkX423TR/24DeN3lDR1dIHPQarsnLZYNpSwE8+wzVdMtqtTQVAA1epu2q4hs4ZCVm5+Io4Iqzy9KzFtNRwcfxFOsvpMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762505176; c=relaxed/simple;
	bh=qTwy9fXU73+YLUnSpqa3s+LUPiZe3cDYU9NTKfskAMQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=b1j83AKYQGJw/9HTfWDntfl9QDgIxiubAfeBS4CvY2L7LGU6duKUANUNZMNL8ndQX8MHDTpruHoQ6ZAYgYTWquTrbmUue+mvh2TX1Bs3ESANPF+4SoojkXstMjmWt32TSHxc/NvXMinzn2I14dQQEBcq+9TXqP8mx5du5lLv35E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=pJI9s/GX; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Ad1uyS8A; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5A74oXGo568002
	for <linux-kernel@vger.kernel.org>; Fri, 7 Nov 2025 08:46:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	2J7yLmUuCyaBbnvYbvDFzyQvcT7qSwPg6DZ/rKC+PAY=; b=pJI9s/GX7BJzPE4g
	6LWrk7kW9uF2KJt7N+NwYUQVujA4yP5N8/TVd5GvQhvsQW2VXJISlIoxannBjWJ0
	OHS8nGmQwmORR1YKJ8WG5yCd70lBlPZ5XnnUK1D6gu0HhzPJKDK8R/nFtD24aGXR
	eT/lH7AUZ2vIiRaglaBQXb5PXeFjjuPhR2iyq4I+k6/aDYCQLMznk2tEr9QYFlb/
	y+fCaCFC50EowjQgqKPapF/AHsdYjPW5Rq4USWIROQQhOc+1tz7c31212zBtLHhG
	PVXNQ4KC1zTIClTAYaFegq6gazSP0MpeR+MFS/btGBhk4etwnK0Ni9ZZEkpiRkIo
	glr4qQ==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a905qja1f-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 07 Nov 2025 08:46:14 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-7b0e73b0e81so682780b3a.0
        for <linux-kernel@vger.kernel.org>; Fri, 07 Nov 2025 00:46:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1762505174; x=1763109974; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2J7yLmUuCyaBbnvYbvDFzyQvcT7qSwPg6DZ/rKC+PAY=;
        b=Ad1uyS8Aq41bPSsPAeSVdbIqL1VYxKzNSktGwEEshEbgBWjEiOcrOVQXiDEsqnQAjc
         YloShxQkFwMBuuE76F2un45bAk8lSSVA5IYiTyQfUCr8EwRnzXPxSzfG7Dj/RLoSnLcQ
         D/+yNNFalqht0WzqqY+ymnoDrt5p3SXlF2VGAF+ESyfpeWyaivY5eaYiBgo7Ne/kVSyb
         X1mzShY4Es2Rl9J/3S04SteNyTqvjdp8S4dEi7a/FnO43ealANY3F73p9bPxve8brWZU
         VmeSPRZZfr2jd63oFMYx5pQzkCax3n2yb5OiWRlGiWnASMiva/Qof5jhRz+7tOjSj/Q3
         3dBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762505174; x=1763109974;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2J7yLmUuCyaBbnvYbvDFzyQvcT7qSwPg6DZ/rKC+PAY=;
        b=iWdJmBC+6d7cye+IOGlR75ffr/e6ti6awgiZRVvh3sDT8P6xAPSyAUb/EocfcyWlRX
         Bo0h+ynr9+V8pgKtP72uvFeuYSK/zpA6ihVUyPXimREXxca3mins0vss8vxwxQbz11Qr
         OrdT0vqDGfReOrCvrCAcUGqDVmMMl8P8nuNJJ+NzuRT65YMt8Wz6XoxnM0LNE39jsYWz
         KWQK3zH7gQk2ejknsc3F7L24nH0d4+LW0HRtItos8Pnd5kJEHiO91AjDqf3Asfkp5zMb
         kk00YZNuDHYREBqrJF1wE5aAxfb9FSVzWN3jBas51zY7O26CqXoGfUyDbgzxbiFqWNqG
         Dw9g==
X-Forwarded-Encrypted: i=1; AJvYcCVzrs9npty2l/X22p8N1LEHXxWMizNq/5N8Eoxk1G2/jkSoAskhVA46KUQSF6Ttrukir6PrIejMWQEFYNw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4opLmFfXkKWfeN45Yhn1UZZtssXsRrOEmHsgDUiBYbZBBmQAq
	A+UVJUGoMLDNKBXcWx9zMLL8P4FFXD3IR1Xh1dpmTXaHqmo78b3/WNgrNnSfyselcMgYs0l0LVe
	PsiMtO7rS5Dwhq5c3lQvTWditOzgVlALv61PGCWLk/zMgJdPOju39sIrsBx12z21/JWY=
X-Gm-Gg: ASbGncusTPNTztM0ftCJmJq9FK9sUlimPCycpW/XBRKc6hr0gY2jrksgDAzwTr2qJTL
	2MB+uWTJyje5hKdtkXJ9QlawJuXy2AfSc32W9Bmoz2EC+ydA0H/NLlz9dzGTGRFkuZzmaaCH6iu
	ze1C224R0GOKYttIHmHBkyvi0vQkXKSKojYO1UynEoRBcsr0KWjztBhHUzwdxwsz7w/4OXmLpGk
	Cs7hUCyVH3GKVCkrx7DMAeOIkkTNk++BjqBdgyu6J5woEecV5MWq9upNAk34LNSIeQiFkonkHl8
	Z7C24/Cv+m95OCkyUoCy9xktg/4B3m3Yew6e8Oe9NqJ9HwTx14A7UVkBuU986KLoxuLtq37cfYU
	X6jDVOWeCsFIz8iZzts3LN0bffiPzeVA=
X-Received: by 2002:a05:6a20:7d86:b0:344:8ef7:7a03 with SMTP id adf61e73a8af0-3522ae7608bmr3570394637.56.1762505173551;
        Fri, 07 Nov 2025 00:46:13 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE4daP1kib/Z3Zsv1e3eRc7cpLPd2g1GESz+2gnnbNugqt9DICJpxnLqdCYhgfcWLH6IYcV4Q==
X-Received: by 2002:a05:6a20:7d86:b0:344:8ef7:7a03 with SMTP id adf61e73a8af0-3522ae7608bmr3570370637.56.1762505173048;
        Fri, 07 Nov 2025 00:46:13 -0800 (PST)
Received: from [10.0.0.3] ([106.222.229.252])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-ba8f8c880c5sm4718213a12.6.2025.11.07.00.46.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Nov 2025 00:46:12 -0800 (PST)
Message-ID: <0d73b172-cb94-dacd-bd9e-a0061b65ce38@oss.qualcomm.com>
Date: Fri, 7 Nov 2025 14:16:07 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v4 5/6] media: qcom: iris: Add flip support for encoder
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
 <20251106-iris_encoder_enhancements-v4-5-5d6cff963f1b@oss.qualcomm.com>
From: Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>
In-Reply-To: <20251106-iris_encoder_enhancements-v4-5-5d6cff963f1b@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: YmwjqtT-VKotuF2VLm7PoiEbYDWcLcaF
X-Proofpoint-GUID: YmwjqtT-VKotuF2VLm7PoiEbYDWcLcaF
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA3MDA2OSBTYWx0ZWRfXwT216zAuFoaC
 2zLBeWXMvTuk3pbHns9l0qKN5kX9WwYozBVPVLbFjjX5T5fomUCgwA9CTR0g/PxvoJzgqIhHD2L
 1D4dCU+wUt4JGx/Q3FcXP8i3ZZ1/2G3jQWDCwTWtfKRJRzdszBxKvTDzSW55ULhAoYcdng4hJz/
 r2w16Op590xgd0qE2qLGk7dpSK7tU2jLa6Iwd9ef/5uUbMzU7s7T7K1OCrQ6eFfSD7BWIrqMMBO
 QwbyAuFjFXVwb46ixxAHSz3ghQkvg2sjoviOPcFcamya2woZ3l7ReqRulxI9uNtmK9yVG5f2O4S
 /MDjL18g6GGPvfz/v/Cdk7ZQs9GFEAk5RpWPvucHhSLauUw2DGR812UiW+mtKYdCtA9cbGOqn2E
 WbRhaXrveDhTPVjPlG9yLOGMJWKFcQ==
X-Authority-Analysis: v=2.4 cv=D6lK6/Rj c=1 sm=1 tr=0 ts=690db1d6 cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=L4UNg9I9cQSOxNpRiiGXlA==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8
 a=47cB15JwpupiNioDY5AA:9 a=QEXdDO2ut3YA:10 a=2VI0MkxyNR6bbpdq8BZq:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-07_02,2025-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1015 suspectscore=0 spamscore=0 bulkscore=0
 phishscore=0 lowpriorityscore=0 impostorscore=0 priorityscore=1501
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2510240001
 definitions=main-2511070069



On 11/6/2025 9:00 AM, Wangao Wang wrote:
> Add support for V4L2_CID_HFLIP and V4L2_CID_VFLIP controls in encoder.
> 
> Tested-by: Neil Armstrong <neil.armstrong@linaro.org> # on SM8650-HDK
> Signed-off-by: Wangao Wang <wangao.wang@oss.qualcomm.com>
> ---
>  drivers/media/platform/qcom/iris/iris_ctrls.c      | 27 ++++++++++++++++++++++
>  drivers/media/platform/qcom/iris/iris_ctrls.h      |  1 +
>  .../platform/qcom/iris/iris_hfi_gen2_defines.h     |  8 +++++++
>  .../platform/qcom/iris/iris_platform_common.h      |  2 ++
>  .../media/platform/qcom/iris/iris_platform_gen2.c  | 22 ++++++++++++++++++
>  5 files changed, 60 insertions(+)
> 

Reviewed-by: Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>

Thanks,
Dikshita
> diff --git a/drivers/media/platform/qcom/iris/iris_ctrls.c b/drivers/media/platform/qcom/iris/iris_ctrls.c
> index 00949c207ddb0203e51df359214bf23c3d8265d0..8f74c12f2f41f23d75424819c707aff61ea61b33 100644
> --- a/drivers/media/platform/qcom/iris/iris_ctrls.c
> +++ b/drivers/media/platform/qcom/iris/iris_ctrls.c
> @@ -100,6 +100,10 @@ static enum platform_inst_fw_cap_type iris_get_cap_id(u32 id)
>  		return B_FRAME_QP_HEVC;
>  	case V4L2_CID_ROTATE:
>  		return ROTATION;
> +	case V4L2_CID_HFLIP:
> +		return HFLIP;
> +	case V4L2_CID_VFLIP:
> +		return VFLIP;
>  	default:
>  		return INST_FW_CAP_MAX;
>  	}
> @@ -189,6 +193,10 @@ static u32 iris_get_v4l2_id(enum platform_inst_fw_cap_type cap_id)
>  		return V4L2_CID_MPEG_VIDEO_HEVC_B_FRAME_QP;
>  	case ROTATION:
>  		return V4L2_CID_ROTATE;
> +	case HFLIP:
> +		return V4L2_CID_HFLIP;
> +	case VFLIP:
> +		return V4L2_CID_VFLIP;
>  	default:
>  		return 0;
>  	}
> @@ -917,6 +925,25 @@ int iris_set_rotation(struct iris_inst *inst, enum platform_inst_fw_cap_type cap
>  					     &hfi_val, sizeof(u32));
>  }
>  
> +int iris_set_flip(struct iris_inst *inst, enum platform_inst_fw_cap_type cap_id)
> +{
> +	const struct iris_hfi_command_ops *hfi_ops = inst->core->hfi_ops;
> +	u32 hfi_id = inst->fw_caps[cap_id].hfi_id;
> +	u32 hfi_val = HFI_DISABLE_FLIP;
> +
> +	if (inst->fw_caps[HFLIP].value)
> +		hfi_val |= HFI_HORIZONTAL_FLIP;
> +
> +	if (inst->fw_caps[VFLIP].value)
> +		hfi_val |= HFI_VERTICAL_FLIP;
> +
> +	return hfi_ops->session_set_property(inst, hfi_id,
> +					     HFI_HOST_FLAGS_NONE,
> +					     iris_get_port_info(inst, cap_id),
> +					     HFI_PAYLOAD_U32_ENUM,
> +					     &hfi_val, sizeof(u32));
> +}
> +
>  int iris_set_properties(struct iris_inst *inst, u32 plane)
>  {
>  	const struct iris_hfi_command_ops *hfi_ops = inst->core->hfi_ops;
> diff --git a/drivers/media/platform/qcom/iris/iris_ctrls.h b/drivers/media/platform/qcom/iris/iris_ctrls.h
> index 3ea0a00c7587a516f19bb7307a0eb9a60c856ab0..355a592049f3fcc715a1b9df44b4d1398b052653 100644
> --- a/drivers/media/platform/qcom/iris/iris_ctrls.h
> +++ b/drivers/media/platform/qcom/iris/iris_ctrls.h
> @@ -33,6 +33,7 @@ int iris_set_max_qp(struct iris_inst *inst, enum platform_inst_fw_cap_type cap_i
>  int iris_set_frame_qp(struct iris_inst *inst, enum platform_inst_fw_cap_type cap_id);
>  int iris_set_qp_range(struct iris_inst *inst, enum platform_inst_fw_cap_type cap_id);
>  int iris_set_rotation(struct iris_inst *inst, enum platform_inst_fw_cap_type cap_id);
> +int iris_set_flip(struct iris_inst *inst, enum platform_inst_fw_cap_type cap_id);
>  int iris_set_properties(struct iris_inst *inst, u32 plane);
>  
>  #endif
> diff --git a/drivers/media/platform/qcom/iris/iris_hfi_gen2_defines.h b/drivers/media/platform/qcom/iris/iris_hfi_gen2_defines.h
> index 4edcce7faf5e2f74bfecfdbf574391d5b1c9cca5..0f92468dca91cbb2ca9b451ebce255180066b3a4 100644
> --- a/drivers/media/platform/qcom/iris/iris_hfi_gen2_defines.h
> +++ b/drivers/media/platform/qcom/iris/iris_hfi_gen2_defines.h
> @@ -92,6 +92,14 @@ enum hfi_rotation {
>  };
>  
>  #define HFI_PROP_ROTATION			0x0300014b
> +
> +enum hfi_flip {
> +	HFI_DISABLE_FLIP    = 0x00000000,
> +	HFI_HORIZONTAL_FLIP = 0x00000001,
> +	HFI_VERTICAL_FLIP   = 0x00000002,
> +};
> +
> +#define HFI_PROP_FLIP				0x0300014c
>  #define HFI_PROP_SIGNAL_COLOR_INFO		0x03000155
>  #define HFI_PROP_PICTURE_TYPE			0x03000162
>  #define HFI_PROP_DEC_DEFAULT_HEADER		0x03000168
> diff --git a/drivers/media/platform/qcom/iris/iris_platform_common.h b/drivers/media/platform/qcom/iris/iris_platform_common.h
> index 9a4232b1c64eea6ce909e1e311769dd958b84c6e..284d6bde6d6bcdf70016646d1c92e6ae7f067efc 100644
> --- a/drivers/media/platform/qcom/iris/iris_platform_common.h
> +++ b/drivers/media/platform/qcom/iris/iris_platform_common.h
> @@ -141,6 +141,8 @@ enum platform_inst_fw_cap_type {
>  	B_FRAME_QP_H264,
>  	B_FRAME_QP_HEVC,
>  	ROTATION,
> +	HFLIP,
> +	VFLIP,
>  	INST_FW_CAP_MAX,
>  };
>  
> diff --git a/drivers/media/platform/qcom/iris/iris_platform_gen2.c b/drivers/media/platform/qcom/iris/iris_platform_gen2.c
> index c1f83e179d441c45df8d6487dc87e137e482fb63..e74bdd00a4bb2f457ec9352e0acaebc820dae235 100644
> --- a/drivers/media/platform/qcom/iris/iris_platform_gen2.c
> +++ b/drivers/media/platform/qcom/iris/iris_platform_gen2.c
> @@ -598,6 +598,28 @@ static struct platform_inst_fw_cap inst_fw_cap_sm8550_enc[] = {
>  		.flags = CAP_FLAG_OUTPUT_PORT,
>  		.set = iris_set_rotation,
>  	},
> +	{
> +		.cap_id = HFLIP,
> +		.min = 0,
> +		.max = 1,
> +		.step_or_mask = 1,
> +		.value = 0,
> +		.hfi_id = HFI_PROP_FLIP,
> +		.flags = CAP_FLAG_OUTPUT_PORT | CAP_FLAG_INPUT_PORT |
> +			CAP_FLAG_DYNAMIC_ALLOWED,
> +		.set = iris_set_flip,
> +	},
> +	{
> +		.cap_id = VFLIP,
> +		.min = 0,
> +		.max = 1,
> +		.step_or_mask = 1,
> +		.value = 0,
> +		.hfi_id = HFI_PROP_FLIP,
> +		.flags = CAP_FLAG_OUTPUT_PORT | CAP_FLAG_INPUT_PORT |
> +			CAP_FLAG_DYNAMIC_ALLOWED,
> +		.set = iris_set_flip,
> +	},
>  };
>  
>  static struct platform_inst_caps platform_inst_cap_sm8550 = {
> 

