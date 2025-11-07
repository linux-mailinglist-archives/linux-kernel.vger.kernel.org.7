Return-Path: <linux-kernel+bounces-889983-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 57087C3EFDF
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 09:42:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B24D1188C98C
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Nov 2025 08:42:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E75BF311964;
	Fri,  7 Nov 2025 08:42:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="VdgCORg4";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ksl7wNHu"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D92B310768
	for <linux-kernel@vger.kernel.org>; Fri,  7 Nov 2025 08:42:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762504935; cv=none; b=X4VXvMYLnisyFy/X+rKp6KDo0PTffhssz7Gh+g/zCz0O5dwHxu4ZGs4ASjqDONrF0j84dbw1C0gN1CCb/4F3fNgjuxRI6VlMGXr3yVFbFMILPJrX4G92qKadzVI4zd9VIGGz/vcwjKc7GP9x7dxdLCyTj5MXxmBqWCidqNV8uCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762504935; c=relaxed/simple;
	bh=S9bH/TKmKdf5uh2YHjvOIPRcwHCE4tFXg5FBvDD++H8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=W9NPceJ6l9x/SJNcLhyHW5TxF0xENG2skIu3G0PS3Mk/+hPWdpVQfNazaEULsDTo5irpoRkRbICpjEDcRBCeSLPUhUSreNJfEAAaobAvRh8/AkARKrrAUyq9eoxA6jsUMbwggz3OOjaCC07hDItefjNetfvnrAdadHQ7sJ/XS9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=VdgCORg4; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ksl7wNHu; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5A74uNKK567434
	for <linux-kernel@vger.kernel.org>; Fri, 7 Nov 2025 08:42:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	8xubnv5//NqDUWt+dCp/lmOt4NXUCFS3NkSxR7MIkk4=; b=VdgCORg4U5cxCGnF
	iI8kmsDBsL/ihGpmq7rrDlMOAequw6fPXuECCBSE65kF1qc4RQhG2rBngXaPrrN5
	i9Bo89EkThteQgNxhFF14sSbLTvYQawsImNHx/KH6Ln6fxIBftmrUrnMCRdVorU0
	PdhvqNoZSIyIjx9rPfJqo9L/maCAl1NFrh3uy1u8VwOJzqS0VLzrBq5nL6Spedf4
	yA/k4BrPYTyHCuhQxZFrKTZtCdaQC4c3HMobtXkADA8glTsdY2+vGI8c0bM2Chqq
	UhwC+VkXycFdKoD6N31ooin4ytU9B0ocmaupmEECPz3FYpiDx6ALkvTW0NYjTgB3
	0q5zJA==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a905qj9k6-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 07 Nov 2025 08:42:12 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-3418ad76023so1492310a91.0
        for <linux-kernel@vger.kernel.org>; Fri, 07 Nov 2025 00:42:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1762504932; x=1763109732; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8xubnv5//NqDUWt+dCp/lmOt4NXUCFS3NkSxR7MIkk4=;
        b=ksl7wNHuO/xyWNlkoc4r+2tR+n+Fx2i30j7C1l9plYD1BEDesWTfbh/sTzhTyTtVCh
         /IlFCBtvcdfntr7rxC1DKaG2scrFIuPvMrDWOak5XyzN6/sIDluVFOY/sxQKG8osubgm
         SvLdvRz9dpA4aLIZnSH04BB4XunSikISWl+Ccg6APvqImKexoGD6a1hGNt7/Sw057SbE
         ujv9IlBMEFj6nxfNfYaiAbW6xpmiQJq8p7Bqi8XTtslghm5kWFeWXHclVCl2aszny+L+
         Sq0ie1jylhufQCDv6JB9w+RFBu7pBdG4T5yhBj2HliLZVDAwBkYMp/WBbsLNWbBua0Si
         RedQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762504932; x=1763109732;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8xubnv5//NqDUWt+dCp/lmOt4NXUCFS3NkSxR7MIkk4=;
        b=DzLq/Ncg+ycUEkxT4ftZbfvhrkcacKAiUQ3EiJrTHM5eAIXf0AVYzJzb+4t1mFIN4Q
         SgQtVx0p9ga4XSqeoAHOVtY5O/AS1mOCFKLOoJDIiRtAZRIu7HI1/zJsqxCEPZaJE6As
         gCsHrm23weSMQ96aR96+S6SkbX/uOghJ0aCOa+wpLFlKmqrgArEaqEc6uBSfXmlU+h01
         R6LRM8nlmtJyNIC4pUyv9aWAA+4UzF1Ffgt0pqkWype0cI+AQyB9mStgNbJ1KyDva/0x
         +fWHHy9/iAn1PQFOduhr5JdGafIFTZ92YQ69g3hfZQY/6sesCQfLCKyY73Ucnvo+OcGG
         8ENg==
X-Forwarded-Encrypted: i=1; AJvYcCUu538AzRJjNWaFfvDYVDtk7N4UcxMBDGndriPD/nFNzqcP39g19FJBzAzh4Bdz5r2U/nRhlKVFR6vZpEI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzOCezGRqMl3YrtNJ9sUu2PEGZXuajNdLKr7AGgc6piHm6smYdi
	bvNpaNZkXeuKIGHFgl6uzAcGr3O6PwgeRn1hIZkMe+VhzbuVCRKu8c8UuGyL64cGNfAG4TShXTs
	2w4dNOFbvCdU/JYVsIDNwuQ65Ws4ySQHWfP1k4ADpKEBkti0V8RnucTAM6BT7en8U014=
X-Gm-Gg: ASbGncu4zsQXNJ8HJ9oqdFZGKNqxtmIwjoXGhFePA3lpqi4m3qSq+yrXEPhTGrnVNRP
	rCr0DypSxBWxtxq3/LigCyhGKuTjtCQMLAb6/R8m6zAm6d06J5JfJU0taBqyhMqPaeP0FN0X4pV
	Tay33+MgVS+Z2fWmfaFazq/98ysrlmHqKpRjfDdPCdyBlCg8wlTpgGmu2kc6asIkPNsWNTp1eMw
	DyxWXbiqwEQ/kIt1yarA4hJbD7jjP5ZOvZZUwXvWCHSunlIM86o0MgSOyDm4qL1w7VX2ur6Dwcl
	sGojz5JYIa0ioQjfYA211Uzv69qmCUvhdUhv02KfCEkcPPKyHn29XSRFDQsBEkmV6QOU8/ubS8S
	jYzqRscgKQBxERh2GBBg/B4jBb+ZI6AM=
X-Received: by 2002:a17:90b:2e07:b0:339:d1f0:c740 with SMTP id 98e67ed59e1d1-3434c4e4544mr2878384a91.1.1762504931777;
        Fri, 07 Nov 2025 00:42:11 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGEYePyLAW421YBIDNXUvEueqrFfEU1Vf+EsVEDsho5VA692tbFIIfBroi5al+r3GC8LfyldQ==
X-Received: by 2002:a17:90b:2e07:b0:339:d1f0:c740 with SMTP id 98e67ed59e1d1-3434c4e4544mr2878339a91.1.1762504931234;
        Fri, 07 Nov 2025 00:42:11 -0800 (PST)
Received: from [10.0.0.3] ([106.222.229.252])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-341a68bf37bsm8756692a91.7.2025.11.07.00.42.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Nov 2025 00:42:10 -0800 (PST)
Message-ID: <df169cde-39db-ec6c-7294-04939575498b@oss.qualcomm.com>
Date: Fri, 7 Nov 2025 14:12:06 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v4 1/6] media: qcom: iris: Improve format alignment for
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
 <20251106-iris_encoder_enhancements-v4-1-5d6cff963f1b@oss.qualcomm.com>
From: Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>
In-Reply-To: <20251106-iris_encoder_enhancements-v4-1-5d6cff963f1b@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: yUV0oH0X7B7jjRtwqI3CD08AlIuwAc7q
X-Proofpoint-GUID: yUV0oH0X7B7jjRtwqI3CD08AlIuwAc7q
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA3MDA2OSBTYWx0ZWRfX9ZjyWcQCtS+S
 DMzxOTsOZ0dNPcTcg8babP+gwjCfp6885x6/6R4UyssR+16xObuMFu6wb7wPwueBk9C58KPimtI
 VrIAcLQqJdsNgq2koAFBgOJmxm1781OIvu0RbaS8Jqv16J3KoZRQbJ6NkITVXoLc024HY2pRFK8
 CquxLH5oABj9AKVlOgM9/FN1jOtaVmUEx/+SXoulNgABGL7Lv7XriLgdthf6atnlebFgvHCvDYS
 QFOaZmFun/7vb4CScdMUl4kIyWBfg6Adk+vtp43LxmIQe/d7BUKgp0RxCYLwXiqkMFzrpx/86+8
 vP1di27kw4fNmi97ElYaAqo+cVs3bAJmrCLGhpeG4kEsUjfR0euNaMGl8LMJc5tKJ1UUjuicjt4
 Cr+C5rit7PQCLHtGQfWJXI0eB1Q8bw==
X-Authority-Analysis: v=2.4 cv=D6lK6/Rj c=1 sm=1 tr=0 ts=690db0e4 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=L4UNg9I9cQSOxNpRiiGXlA==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8
 a=29lyQ8C1osYPmbkIuUMA:9 a=QEXdDO2ut3YA:10 a=iS9zxrgQBfv6-_F4QbHw:22
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
> Add members enc_raw_width, enc_raw_height to the struct iris_inst to
> support codec alignment requirements.
> 
> HFI_PROP_RAW_RESOLUTION needs to be set to the actual YUV resolution.
> 
> Tested-by: Neil Armstrong <neil.armstrong@linaro.org> # on SM8650-HDK
> Signed-off-by: Wangao Wang <wangao.wang@oss.qualcomm.com>
> ---
>  drivers/media/platform/qcom/iris/iris_hfi_gen2_command.c | 7 +++----
>  drivers/media/platform/qcom/iris/iris_instance.h         | 4 ++++
>  drivers/media/platform/qcom/iris/iris_venc.c             | 6 ++++++
>  3 files changed, 13 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/media/platform/qcom/iris/iris_hfi_gen2_command.c b/drivers/media/platform/qcom/iris/iris_hfi_gen2_command.c
> index 4ce71a14250832440099e4cf3835b4aedfb749e8..aaa79dfe2db281bb77be7274233f093b0086b5d4 100644
> --- a/drivers/media/platform/qcom/iris/iris_hfi_gen2_command.c
> +++ b/drivers/media/platform/qcom/iris/iris_hfi_gen2_command.c
> @@ -168,8 +168,7 @@ static int iris_hfi_gen2_session_set_property(struct iris_inst *inst, u32 packet
>  
>  static int iris_hfi_gen2_set_raw_resolution(struct iris_inst *inst, u32 plane)
>  {
> -	u32 resolution = inst->fmt_src->fmt.pix_mp.width << 16 |
> -		inst->fmt_src->fmt.pix_mp.height;
> +	u32 resolution = inst->enc_raw_width << 16 | inst->enc_raw_height;
>  	u32 port = iris_hfi_gen2_get_port(inst, plane);
>  
>  	return iris_hfi_gen2_session_set_property(inst,
> @@ -231,8 +230,8 @@ static int iris_hfi_gen2_set_crop_offsets(struct iris_inst *inst, u32 plane)
>  			top_offset = inst->compose.top;
>  		}
>  	} else {
> -		bottom_offset = (inst->fmt_src->fmt.pix_mp.height - inst->crop.height);
> -		right_offset = (inst->fmt_src->fmt.pix_mp.width - inst->crop.width);
> +		bottom_offset = (inst->fmt_dst->fmt.pix_mp.height - inst->enc_raw_height);
> +		right_offset = (inst->fmt_dst->fmt.pix_mp.width - inst->enc_raw_width);

This should be move to 2nd patch where you clean the CROP offset property
setting.

Thanks,
Dikshita
>  		left_offset = inst->crop.left;
>  		top_offset = inst->crop.top;
>  	}
> diff --git a/drivers/media/platform/qcom/iris/iris_instance.h b/drivers/media/platform/qcom/iris/iris_instance.h
> index 5982d7adefeab80905478b32cddba7bd4651a691..a9892988c10bc28e9b2d8c3b5482e99b5b9af623 100644
> --- a/drivers/media/platform/qcom/iris/iris_instance.h
> +++ b/drivers/media/platform/qcom/iris/iris_instance.h
> @@ -64,6 +64,8 @@ struct iris_fmt {
>   * @frame_rate: frame rate of current instance
>   * @operating_rate: operating rate of current instance
>   * @hfi_rc_type: rate control type
> + * @enc_raw_width: source image width for encoder instance
> + * @enc_raw_height: source image height for encoder instance
>   */
>  
>  struct iris_inst {
> @@ -102,6 +104,8 @@ struct iris_inst {
>  	u32				frame_rate;
>  	u32				operating_rate;
>  	u32				hfi_rc_type;
> +	u32				enc_raw_width;
> +	u32				enc_raw_height;
>  };
>  
>  #endif
> diff --git a/drivers/media/platform/qcom/iris/iris_venc.c b/drivers/media/platform/qcom/iris/iris_venc.c
> index 099bd5ed4ae0294725860305254c4cad1ec88d7e..50a3eb975a2523abf1c2df128a66a762a1ed35c6 100644
> --- a/drivers/media/platform/qcom/iris/iris_venc.c
> +++ b/drivers/media/platform/qcom/iris/iris_venc.c
> @@ -68,6 +68,9 @@ int iris_venc_inst_init(struct iris_inst *inst)
>  	inst->operating_rate = DEFAULT_FPS;
>  	inst->frame_rate = DEFAULT_FPS;
>  
> +	inst->enc_raw_width = DEFAULT_WIDTH;
> +	inst->enc_raw_height = DEFAULT_HEIGHT;
> +
>  	memcpy(&inst->fw_caps[0], &core->inst_fw_caps_enc[0],
>  	       INST_FW_CAP_MAX * sizeof(struct platform_inst_fw_cap));
>  
> @@ -249,6 +252,9 @@ static int iris_venc_s_fmt_input(struct iris_inst *inst, struct v4l2_format *f)
>  	inst->buffers[BUF_INPUT].min_count = iris_vpu_buf_count(inst, BUF_INPUT);
>  	inst->buffers[BUF_INPUT].size = fmt->fmt.pix_mp.plane_fmt[0].sizeimage;
>  
> +	inst->enc_raw_width = f->fmt.pix_mp.width;
> +	inst->enc_raw_height = f->fmt.pix_mp.height;
> +
>  	if (f->fmt.pix_mp.width != inst->crop.width ||
>  	    f->fmt.pix_mp.height != inst->crop.height) {
>  		inst->crop.top = 0;
> 

