Return-Path: <linux-kernel+bounces-879569-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 10438C237CE
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 08:02:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 4A65F34C98A
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 07:02:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BE11257832;
	Fri, 31 Oct 2025 07:02:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="k0qEBBMP";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="dBV51U/W"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5732F214A64
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 07:02:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761894141; cv=none; b=dAZY7aDHTCAUEXJEMij/damxgDcyizJ9x8967O9uCgVQdTWKUSc0ih07zKakUR8E5p2KlmVg2+bwzTSLz+HzLPmz9qo5MiJpcAvSGmznb15EecRhyN65v6IWRGWGnyjx0Y40/AUfxxuCRpQfnUhUTNOUCePspY4QC67y/59oHQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761894141; c=relaxed/simple;
	bh=3VA/JP5N74/+QURC8lvECwgrL5VwU+hARhls54ewH0Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=I86XWSU6QgLCGcheR8P48X6EahKWKnSPSmBHKicEK7PvRGdQWBFpIQ5udMDJjVJn7Ign8YibBgB4VkHUxyvewwUao5QcLVm/g8iXyR5supv1p5O2YmvuEyGfUQlTFctYKK+qLxzZ7Tn0S+nKeR6RZMFEbvQfMEolgw5ZCR2rIfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=k0qEBBMP; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=dBV51U/W; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59V4M3jc1827685
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 07:02:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	KXQpzLFJXh+E+d7yWUIENb/c5cswdUeinkrB0pk5JuY=; b=k0qEBBMPvG0dpn1q
	sdMyF4Y55fQCal/dx3M+1gm9tC2/hFGVjKoACGlx5xCYhw6ZVf9wyFZknmc185cQ
	C2W776MWnnEXB+GOLEOHn5VSX6QRzpikss9cLJgIY7+RN6jjc7kBEuQqwoYWxVEn
	V1gp3FaUgkvSMBE+BrT+D0TeBgncYWnfvkPH7FSqEIFcPxH6PSmhCEg+WeP04A6h
	XrJjZTC8jGNKywlM4AvptU6yf6tvEcEmugEB3hFV7GGO6LFAiE6w8HRZrrgJdRO1
	XnS5VxSpHHbF/jHx7I3GBvko3LSKw9xdQaGeURrGmC4z2zmxkLe7gSXUdIeln4MD
	iILQTg==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a4p11rb4t-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 07:02:17 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2930e2e8e7fso17715675ad.2
        for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 00:02:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1761894137; x=1762498937; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KXQpzLFJXh+E+d7yWUIENb/c5cswdUeinkrB0pk5JuY=;
        b=dBV51U/WVflfmbhGGpm1Hc+N5MZ5CUDNU6Jm+suMDJqJLH0CpL2vQv3V5/2xKzWTXQ
         F0wWZsHt8cQUFMcDVI7thAuiByrivjHTvzH8vAPHxOP6Erda16lVIwQ1VGhXpzqI8hZt
         b1mS5GrqgvEkEptU9CDvEAYM085++QROURgYk3gDvOtgmdLvGirtMroafSpsdrHsZCc3
         x8OLoACzXpWB6xmhrrT3+7CufMcbbAJ/+AejDh4P+Wps9/0wSJ2OuDzUoqjOnIo2sWdJ
         tqzirZJu6kyjxNMD/sL66OlFXusIarFDKOBsM2JyPoPvbdlevcOUCjXOgYRfK9Wel9Nn
         tdIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761894137; x=1762498937;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KXQpzLFJXh+E+d7yWUIENb/c5cswdUeinkrB0pk5JuY=;
        b=ny0WqCzHTvWZA16rPDBRxB7jbMMSI/ZQXwzGu1yg2Ack0bAydNmVHOokSlPpg5Or4V
         MTDnUqjjxq+3mXLa4fC57Veu2V9D2vxyslxdxpvUeaOAhnM/PU0O1KM9Idpaa045W3Fh
         d4r8J+u7iBJHdarAIoW/SUoecIJOK1FjEz/4otwhQ3Z8ecoNKYzaSAokOrBRXmk60K1g
         pIxZxj1ImW5NN5x0j9h0qoPlfOIGi1V/l4kmr2kz6ppcfmurBmldgyDlNMRCuMHkYP9M
         Qnn9dW++LOrzT1mxWul2Aqs9tmSk5tgkGeQVVTa5oo6BflPQDtj2gsJKPtX30sSjbuQE
         qRbg==
X-Forwarded-Encrypted: i=1; AJvYcCUR4QaDMPOYgLxjLBTNRf6HPVaYP47uIavJHeZVfRyuYwQhIQpVw1FJKLOAYkgCVutoEEiohAr0juCR3BI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwHuQ2iqPg6s75z4jXLLqrwj53IvTgrjPov1v+TUh81irfxsWC9
	l5gHjnFYThS3+i6a1HNTCbKLJLFw0BBHjgcMbzGkSdKL8Em+74Ufpg+NQRnnUOgUqoVUvzTbX66
	gEdGsezLaRrRK3pbS3/nAEerEDawtY5vyCludRbi2i2l6t5O+QOtln366KgMRdPyGNiA=
X-Gm-Gg: ASbGncvwxiA0Yur+6ompCxgPY7noYdUcsFo+ekJvCAGs9XVsEMM++g6FytTQUIJZ5iy
	pJ81rMvpAqJ/L+kN/JQvc0egj9PDjuS2++YFlmtfBCHS4S42IO+WcumiyXVKsfgDBeuBR39lX60
	SMYw66eHIJZWhSXAX8pV8ObXYswnry02vZ0G/9rHQ7xZ6Aq0VIt1SI4nPUYDbmFkGhr0eUq+QX9
	xVGQBUKvalysCtqyji9sAwzJbu0jRGTOpGf9DK2MQYLzBNk30APzy/2TLshlTEQZBdm0G0RZnoo
	C3+9nkaA7ACEndKgJBDrVQW/ZrJT5IwTeKVWtQYP4X5o3D/Zdp6wMPJrjp6kcpZ9opPHP8zZekG
	Oi1QGtGiDzRv0+dcNVQ2D6N65wveCRWA=
X-Received: by 2002:a17:902:f54c:b0:294:f745:fe7f with SMTP id d9443c01a7336-2951a4935e9mr34274365ad.38.1761894136521;
        Fri, 31 Oct 2025 00:02:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEQutvspZLKYBSr0XkKmfMKKVl2kzqj4MOiD4B9YAEjI8OaoI5KxGJo9ixY0mKdP+ykwrUAHQ==
X-Received: by 2002:a17:902:f54c:b0:294:f745:fe7f with SMTP id d9443c01a7336-2951a4935e9mr34274005ad.38.1761894135947;
        Fri, 31 Oct 2025 00:02:15 -0700 (PDT)
Received: from [10.0.0.3] ([106.222.229.252])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2952d0314cdsm6798965ad.26.2025.10.31.00.02.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 31 Oct 2025 00:02:15 -0700 (PDT)
Message-ID: <9f03f29d-f667-648e-1383-d6a9883541df@oss.qualcomm.com>
Date: Fri, 31 Oct 2025 12:32:11 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v3 3/5] media: iris: Add support for AV1 format in iris
 decoder
To: Deepa Guthyappa Madivalara <deepa.madivalara@oss.qualcomm.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Vikash Garodia <vikash.garodia@oss.qualcomm.com>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Bryan O'Donoghue <bod@kernel.org>
Cc: linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, kernel test robot <lkp@intel.com>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>
References: <20251030-av1d_stateful_v3-v3-0-a1184de52fc4@oss.qualcomm.com>
 <20251030-av1d_stateful_v3-v3-3-a1184de52fc4@oss.qualcomm.com>
Content-Language: en-US
From: Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>
In-Reply-To: <20251030-av1d_stateful_v3-v3-3-a1184de52fc4@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: vtd-4PqklS7vUpOfUPx5QUdDtnDj5iiq
X-Authority-Analysis: v=2.4 cv=RbCdyltv c=1 sm=1 tr=0 ts=69045ef9 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=L4UNg9I9cQSOxNpRiiGXlA==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8
 a=s5kO0R1Z4orJ4Q5W7-IA:9 a=QEXdDO2ut3YA:10 a=324X-CrmTo6CU4MGRt3R:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: vtd-4PqklS7vUpOfUPx5QUdDtnDj5iiq
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDMxMDA2MyBTYWx0ZWRfXxFXwDSwBArVd
 WVXvezaS5CiKalabzLXVHQZygTM8Q5mLiE2kkpjAr9sh2D0RwBVSdsadoTanpSB81Op3/wIaY1B
 vvcEig48GOkE+f9SNznErU+J0PTvoWaLsnyk+enszs/lVO3vxSEdtd3vITTTI6st5xKHbhIFViw
 9AM9B89VqCMdJLCpw05kvd49kMdrOUX74Wxyg+9SBKwSfvhtRWrkaQc3U6+BnMINkxAcsm1BMRr
 twiDm0TsRaABC+jNdS9l+FlomtRnjKtvqd9YQI02bpXhiDEJQ6ZHQS7RDNJ8wF1ESdpRQSttSFl
 qKDCqy0vthxcThhJJhZxdsITnKJO3y/k8IyIEYAF9+vA8WJ9+AqtMlxi2xt7RT8fsX+vSq2zaGt
 RjlDzN21APjVoiWN1rCfhpU7AZvbrw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-10-31_01,2025-10-29_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 suspectscore=0 phishscore=0 lowpriorityscore=0
 adultscore=0 bulkscore=0 clxscore=1015 priorityscore=1501 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2510310063



On 10/30/2025 12:30 PM, Deepa Guthyappa Madivalara wrote:
> Extend iris decoder driver to support format V4L2_PIX_FMT_AV1.
> This change updates the format enumeration (VIDIOC_ENUM_FMT)
> and allows setting AV1 format via VIDIOC_S_FMT for gen2 and beyond.
> Gen1 iris hardware decoder does not support AV1 format.
> 
> Reviewed-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
> Signed-off-by: Deepa Guthyappa Madivalara <deepa.madivalara@oss.qualcomm.com>
> ---
>  .../platform/qcom/iris/iris_hfi_gen2_defines.h     |  1 +
>  drivers/media/platform/qcom/iris/iris_instance.h   |  1 +
>  .../platform/qcom/iris/iris_platform_common.h      |  2 ++
>  .../media/platform/qcom/iris/iris_platform_gen2.c  | 23 ++++++++++++++++++++++
>  .../platform/qcom/iris/iris_platform_sm8250.c      | 17 ++++++++++++++++
>  drivers/media/platform/qcom/iris/iris_vdec.c       | 23 ++++------------------
>  6 files changed, 48 insertions(+), 19 deletions(-)
> 
> diff --git a/drivers/media/platform/qcom/iris/iris_hfi_gen2_defines.h b/drivers/media/platform/qcom/iris/iris_hfi_gen2_defines.h
> index 1b6a4dbac828ffea53c1be0d3624a033c283c972..3d56f257bc5620aacec2bb7e11253dc7c83b7db9 100644
> --- a/drivers/media/platform/qcom/iris/iris_hfi_gen2_defines.h
> +++ b/drivers/media/platform/qcom/iris/iris_hfi_gen2_defines.h
> @@ -139,6 +139,7 @@ enum hfi_codec_type {
>  	HFI_CODEC_DECODE_HEVC			= 3,
>  	HFI_CODEC_ENCODE_HEVC			= 4,
>  	HFI_CODEC_DECODE_VP9			= 5,
> +	HFI_CODEC_DECODE_AV1			= 7,
>  };
>  
>  enum hfi_picture_type {
> diff --git a/drivers/media/platform/qcom/iris/iris_instance.h b/drivers/media/platform/qcom/iris/iris_instance.h
> index 62fbb30691ff967212022308fa53ff221fa24ce9..7e4f5f1dd8921c57db039fbd4bc2f321891348db 100644
> --- a/drivers/media/platform/qcom/iris/iris_instance.h
> +++ b/drivers/media/platform/qcom/iris/iris_instance.h
> @@ -19,6 +19,7 @@ enum iris_fmt_type_out {
>  	IRIS_FMT_H264,
>  	IRIS_FMT_HEVC,
>  	IRIS_FMT_VP9,
> +	IRIS_FMT_AV1,
>  };
>  
>  enum iris_fmt_type_cap {
> diff --git a/drivers/media/platform/qcom/iris/iris_platform_common.h b/drivers/media/platform/qcom/iris/iris_platform_common.h
> index 58d05e0a112eed25faea027a34c719c89d6c3897..9aca70b4c0690f0d8d799e2a9976bd20d6bb8c94 100644
> --- a/drivers/media/platform/qcom/iris/iris_platform_common.h
> +++ b/drivers/media/platform/qcom/iris/iris_platform_common.h
> @@ -214,6 +214,8 @@ struct iris_platform_data {
>  	u64 dma_mask;
>  	const char *fwname;
>  	u32 pas_id;
> +	struct iris_fmt *inst_iris_fmts;
> +	u32 inst_iris_fmts_size;
>  	struct platform_inst_caps *inst_caps;
>  	struct platform_inst_fw_cap *inst_fw_caps_dec;
>  	u32 inst_fw_caps_dec_size;
> diff --git a/drivers/media/platform/qcom/iris/iris_platform_gen2.c b/drivers/media/platform/qcom/iris/iris_platform_gen2.c
> index 69c952c68e939f305f25511e2e4763487ec8e0de..3b61723dbf27e9ba8d427686e44cf048a0ab7c5b 100644
> --- a/drivers/media/platform/qcom/iris/iris_platform_gen2.c
> +++ b/drivers/media/platform/qcom/iris/iris_platform_gen2.c
> @@ -19,6 +19,25 @@
>  #define VIDEO_ARCH_LX 1
>  #define BITRATE_MAX				245000000
>  
> +static struct iris_fmt platform_fmts_sm8550_dec[] = {
> +	[IRIS_FMT_H264] = {
> +		.pixfmt = V4L2_PIX_FMT_H264,
> +		.type = V4L2_BUF_TYPE_VIDEO_OUTPUT_MPLANE,
> +	},
> +	[IRIS_FMT_HEVC] = {
> +		.pixfmt = V4L2_PIX_FMT_HEVC,
> +		.type = V4L2_BUF_TYPE_VIDEO_OUTPUT_MPLANE,
> +	},
> +	[IRIS_FMT_VP9] = {
> +		.pixfmt = V4L2_PIX_FMT_VP9,
> +		.type = V4L2_BUF_TYPE_VIDEO_OUTPUT_MPLANE,
> +	},
> +	[IRIS_FMT_AV1] = {
> +		.pixfmt = V4L2_PIX_FMT_AV1,
> +		.type = V4L2_BUF_TYPE_VIDEO_OUTPUT_MPLANE,
> +	},
> +};
> +
>  static struct platform_inst_fw_cap inst_fw_cap_sm8550_dec[] = {
>  	{
>  		.cap_id = PROFILE_H264,
> @@ -761,6 +780,8 @@ struct iris_platform_data sm8550_data = {
>  	.dma_mask = 0xe0000000 - 1,
>  	.fwname = "qcom/vpu/vpu30_p4.mbn",
>  	.pas_id = IRIS_PAS_ID,
> +	.inst_iris_fmts = platform_fmts_sm8550_dec,
> +	.inst_iris_fmts_size = ARRAY_SIZE(platform_fmts_sm8550_dec),
>  	.inst_caps = &platform_inst_cap_sm8550,
>  	.inst_fw_caps_dec = inst_fw_cap_sm8550_dec,
>  	.inst_fw_caps_dec_size = ARRAY_SIZE(inst_fw_cap_sm8550_dec),
> @@ -853,6 +874,8 @@ struct iris_platform_data sm8650_data = {
>  	.dma_mask = 0xe0000000 - 1,
>  	.fwname = "qcom/vpu/vpu33_p4.mbn",
>  	.pas_id = IRIS_PAS_ID,
> +	.inst_iris_fmts = platform_fmts_sm8550_dec,
> +	.inst_iris_fmts_size = ARRAY_SIZE(platform_fmts_sm8550_dec),
>  	.inst_caps = &platform_inst_cap_sm8550,
>  	.inst_fw_caps_dec = inst_fw_cap_sm8550_dec,
>  	.inst_fw_caps_dec_size = ARRAY_SIZE(inst_fw_cap_sm8550_dec),
> diff --git a/drivers/media/platform/qcom/iris/iris_platform_sm8250.c b/drivers/media/platform/qcom/iris/iris_platform_sm8250.c
> index 16486284f8acccf6a95a27f6003e885226e28f4d..8342a0b6f825b385192baedfc67c50bba7661470 100644
> --- a/drivers/media/platform/qcom/iris/iris_platform_sm8250.c
> +++ b/drivers/media/platform/qcom/iris/iris_platform_sm8250.c
> @@ -17,6 +17,21 @@
>  #define BITRATE_PEAK_DEFAULT	(BITRATE_DEFAULT * 2)
>  #define BITRATE_STEP		100
>  
> +static struct iris_fmt platform_fmts_sm8250_dec[] = {
> +	[IRIS_FMT_H264] = {
> +		.pixfmt = V4L2_PIX_FMT_H264,
> +		.type = V4L2_BUF_TYPE_VIDEO_OUTPUT_MPLANE,
> +	},
> +	[IRIS_FMT_HEVC] = {
> +		.pixfmt = V4L2_PIX_FMT_HEVC,
> +		.type = V4L2_BUF_TYPE_VIDEO_OUTPUT_MPLANE,
> +	},
> +	[IRIS_FMT_VP9] = {
> +		.pixfmt = V4L2_PIX_FMT_VP9,
> +		.type = V4L2_BUF_TYPE_VIDEO_OUTPUT_MPLANE,
> +	},
> +};
> +
>  static struct platform_inst_fw_cap inst_fw_cap_sm8250_dec[] = {
>  	{
>  		.cap_id = PIPE,
> @@ -337,6 +352,8 @@ struct iris_platform_data sm8250_data = {
>  	.dma_mask = 0xe0000000 - 1,
>  	.fwname = "qcom/vpu-1.0/venus.mbn",
>  	.pas_id = IRIS_PAS_ID,
> +	.inst_iris_fmts = platform_fmts_sm8250_dec,
> +	.inst_iris_fmts_size = ARRAY_SIZE(platform_fmts_sm8250_dec),
>  	.inst_caps = &platform_inst_cap_sm8250,
>  	.inst_fw_caps_dec = inst_fw_cap_sm8250_dec,
>  	.inst_fw_caps_dec_size = ARRAY_SIZE(inst_fw_cap_sm8250_dec),
> diff --git a/drivers/media/platform/qcom/iris/iris_vdec.c b/drivers/media/platform/qcom/iris/iris_vdec.c
> index 69ffe52590d3acf8d595f856fb1dbd81f3073721..bf7b9c621cb7255367c06f144c03c3faa69372e0 100644
> --- a/drivers/media/platform/qcom/iris/iris_vdec.c
> +++ b/drivers/media/platform/qcom/iris/iris_vdec.c
> @@ -67,21 +67,6 @@ void iris_vdec_inst_deinit(struct iris_inst *inst)
>  	kfree(inst->fmt_src);
>  }
>  
> -static const struct iris_fmt iris_vdec_formats_out[] = {
> -	[IRIS_FMT_H264] = {
> -		.pixfmt = V4L2_PIX_FMT_H264,
> -		.type = V4L2_BUF_TYPE_VIDEO_OUTPUT_MPLANE,
> -	},
> -	[IRIS_FMT_HEVC] = {
> -		.pixfmt = V4L2_PIX_FMT_HEVC,
> -		.type = V4L2_BUF_TYPE_VIDEO_OUTPUT_MPLANE,
> -	},
> -	[IRIS_FMT_VP9] = {
> -		.pixfmt = V4L2_PIX_FMT_VP9,
> -		.type = V4L2_BUF_TYPE_VIDEO_OUTPUT_MPLANE,
> -	},
> -};
> -
>  static const struct iris_fmt iris_vdec_formats_cap[] = {
>  	[IRIS_FMT_NV12] = {
>  		.pixfmt = V4L2_PIX_FMT_NV12,
> @@ -101,8 +86,8 @@ find_format(struct iris_inst *inst, u32 pixfmt, u32 type)
>  	unsigned int i;
>  	switch (type) {
>  	case V4L2_BUF_TYPE_VIDEO_OUTPUT_MPLANE:
> -		fmt = iris_vdec_formats_out;
> -		size = ARRAY_SIZE(iris_vdec_formats_out);
> +		fmt = inst->core->iris_platform_data->inst_iris_fmts;
> +		size = inst->core->iris_platform_data->inst_iris_fmts_size;
>  		break;
>  	case V4L2_BUF_TYPE_VIDEO_CAPTURE_MPLANE:
>  		fmt = iris_vdec_formats_cap;
> @@ -131,8 +116,8 @@ find_format_by_index(struct iris_inst *inst, u32 index, u32 type)
>  
>  	switch (type) {
>  	case V4L2_BUF_TYPE_VIDEO_OUTPUT_MPLANE:
> -		fmt = iris_vdec_formats_out;
> -		size = ARRAY_SIZE(iris_vdec_formats_out);
> +		fmt = inst->core->iris_platform_data->inst_iris_fmts;
> +		size = inst->core->iris_platform_data->inst_iris_fmts_size;
>  		break;
>  	case V4L2_BUF_TYPE_VIDEO_CAPTURE_MPLANE:
>  		fmt = iris_vdec_formats_cap;
> 

Reviewed-by: Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>

Thanks,
Dikshita

