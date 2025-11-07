Return-Path: <linux-kernel+bounces-890181-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B2E55C3F6A4
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 11:26:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 70DAB3B0A18
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Nov 2025 10:26:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A72AD305071;
	Fri,  7 Nov 2025 10:25:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="n22hTG2P";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="XLyyb7ZT"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 622593043D5
	for <linux-kernel@vger.kernel.org>; Fri,  7 Nov 2025 10:25:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762511157; cv=none; b=K9zzt1rv//t+YDgA8yZIXBW0f6YllrCCw/As6x7qvqBbTL/ITWM4tP3dMJ3YNGtdtOPm+4KTjJB8pE8yoPLZx+ghetAGZ9nsYukxffREoSh+N7WXfUKt3eALzKknCLYA8mqkWFP1OiePR/hXk4YPuhy7L9dE3Yx/h9lPH570DJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762511157; c=relaxed/simple;
	bh=TfqVBbE95iBGfqw4ThDJ4Ix4Y/sO9BB/7GhORuIN2B8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Z1mLRULeloRDLxu6DCQMKLttSAypLKlklMDw01jCka75/PQ2j9NFophNSEx1bDPGQiEMpDUDeexOIsmO+0sHSSdnW5ssGtY5Rtv/nzzCKQM9+fQOWq5MKQ7q0R0DNrImbgKOI2jgEqJ+lq8bKIW0x8m0ATDv4H7uyywBLlEFPLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=n22hTG2P; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=XLyyb7ZT; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5A749s4b583970
	for <linux-kernel@vger.kernel.org>; Fri, 7 Nov 2025 10:25:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	N0g2bzgjrGduYTi0M77+HVdu59jcso00dA0UqQXUwnk=; b=n22hTG2P7JZiFA+g
	v4aZBSEYx1v4NED+z1Qv/3C8HbRWSla/52Jo200AXr1FM3e7i7KqVNIma3GHNduH
	ePp/JujVaWa0U140adurEmofmxaBqgEXfNOPOnM6xYFWvPg5JN00OT7qEQa0RGta
	3n/tvXzhRG/scn9ZNDxo3wnpRA1ssY4mk1pp1ti8G++/vHjhAbuB/gAgBQhOl7jq
	JsnSjMnF1LvApUk95u3ngzSHxctjljAhr6WjH+UdhevbeqyBcLMkFNqwb8batD0B
	E/wS/N5j9feAVt4Ai0ahrymnJZSzLh7+KPdbcHTFW+tZiibSzV+GfYfjHFqC/E8X
	vYXyhw==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a8yktjqgw-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 07 Nov 2025 10:25:55 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-295592eb5dbso6610245ad.0
        for <linux-kernel@vger.kernel.org>; Fri, 07 Nov 2025 02:25:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1762511155; x=1763115955; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=N0g2bzgjrGduYTi0M77+HVdu59jcso00dA0UqQXUwnk=;
        b=XLyyb7ZTTl+FkhJjGKrfdNQDOrIj01X+cztPjNd+W9lWB/J4v/t3Yow9ddbAGyBHr3
         t6XnsDdXdwJymDY8KSwzRqvfkms93AgLKcZB0nbA1U6AAxuDKEeFs1UBd92dIKG+9wxF
         IBakTwPcHq3QaRN51D5/18iQ0ElBdd61V77Rql7eb3FuWyCSAfmEj9ib8g51VZAieKoK
         RfXVe5Tx2iW7BnQO7DCS6IIHT8pOBHSgMvehPSsoRmBehzFOVyWN4nct3pCAv2Mnj640
         HbCwvWUbQbXLTv6eljC72B2gGlVGzAC6Vv9oD9qS0wZcsi4/VE6QXydoze4m3CDaxfnQ
         An7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762511155; x=1763115955;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=N0g2bzgjrGduYTi0M77+HVdu59jcso00dA0UqQXUwnk=;
        b=eFyZz6yTccs84cbdFB65c7PWDKNdrkX1JIY+YJSzqvaTWNaXlAH2bRu6bYxq4JSR+8
         cH/kMPwo7BhmgLbSbKzFRT8khctoZZS4UB7n2T0tb6xaEdi6fezAHR/97L7ep9jO0aF6
         9BGZ0XW3kDDXKbCG0S6pXkxZ/+p3fErLiEvyF9fRFnPYpvhOOU1bn6zF5N1bdxVjC7+g
         LSwPyaahXhwiIrgC+9IKn9xWroVBkJkvXczPR11itHdWIZ9ivbOsN7dIVad5r+zKtnI0
         imLdXHAaIvLR3RENdXQO+T/O9molemk2qmVGRYipypXEZdJJJSYzMrEhenoU5LA9fdg/
         YNEA==
X-Forwarded-Encrypted: i=1; AJvYcCWp2znK2HoYlfc7ZFBVFgyjBQJy2MO3tLmWmz2xruo+zmnzV5HVzQUmA1ShHQb2H9pDsvZrU7JeN1AtKys=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzyquu808tFX5uarh7tv1iaSpmLqIr5UhaPXCApQhZ6KepfR7gv
	QWXCuZPlrenr20LOMnuB+vDFvZgp1ueJnMfHllGrD1SnNi9I0UB7u8mObLGSQ7JKprZVLVilSpN
	isiXzhP+6FVn8ZxskMV3d6rN88L/Ge6QKoxKpuXhBJ8g4ZgOC8RTpCo7/uLcnNrhPo4M=
X-Gm-Gg: ASbGncv/ryJU9kaoYNR6qyAI2owGZzyzJ2vzuOveFhYCyeQZH3bnF/XQqSAWTfbtudQ
	eC6yW+DN5E1wHCziC2BbYD07ndpAB05uTBlWL1z+OXkY2UZUhDx0qEaqAVe7L53N+vEVyxuuFXK
	x+rq899N+2GBG7oUgdIbFRM7LxpH+uHhbtBTpV7s7KjTj5VeUWtGA5iywfWMWjFQ4/UtEO2OhAv
	KjlbHgNROOj6++1CHjxZ6d8pFx4t0Jqys6XcKV6xguAD/8/IG78I5MeTlf0GdKA3U8b2ZchXq/j
	eWjKAvCdQdmTBMah+rwrskVStr0ytom0xnoQND4PfywSsMWrOznvbGfWN5UkQau0Mc+0n60uLLM
	wzP9CR6CYvH12a5ntJf3+tL3cJp+9KhU=
X-Received: by 2002:a17:903:2305:b0:294:ccc6:ccfd with SMTP id d9443c01a7336-297c03e59b2mr38789905ad.24.1762511154837;
        Fri, 07 Nov 2025 02:25:54 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH1tMrg3W/RNIxDscOnZnps3MrCElLCpEcVd1QI5sytXqXnRNUDDFD2lrX1/cHKqttfpe64XQ==
X-Received: by 2002:a17:903:2305:b0:294:ccc6:ccfd with SMTP id d9443c01a7336-297c03e59b2mr38789475ad.24.1762511154289;
        Fri, 07 Nov 2025 02:25:54 -0800 (PST)
Received: from [10.0.0.3] ([106.222.229.252])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2965096dbe4sm55763195ad.11.2025.11.07.02.25.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Nov 2025 02:25:53 -0800 (PST)
Message-ID: <1728c571-1e25-59e2-beae-124d9976fb3f@oss.qualcomm.com>
Date: Fri, 7 Nov 2025 15:55:49 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v4 2/6] media: qcom: iris: Improve crop_offset handling
 for encoder
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
 <20251106-iris_encoder_enhancements-v4-2-5d6cff963f1b@oss.qualcomm.com>
From: Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>
In-Reply-To: <20251106-iris_encoder_enhancements-v4-2-5d6cff963f1b@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=bOgb4f+Z c=1 sm=1 tr=0 ts=690dc933 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=L4UNg9I9cQSOxNpRiiGXlA==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=-McpUROWq26EwQPLxNQA:9
 a=QEXdDO2ut3YA:10 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-ORIG-GUID: DSd3kEc6RhltBUpO2GmLhdLIMa4KozEg
X-Proofpoint-GUID: DSd3kEc6RhltBUpO2GmLhdLIMa4KozEg
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA3MDA4MyBTYWx0ZWRfXx0ojhV7PP7Nl
 EUD14w0dYSZMx20Wi1XbqsN2Z7pr6TO9xKrlExvH01SrfmJSDZGfrnv6rWa/WAQfOOB8d5sxvyC
 Dn5XucYUiUE9/APeuUMmXYVOvL8wpFlVdtmPU+4pKYMMTPjfeuCRnGHUbNL4DlQfI10AVXdVeIu
 e692gYzNReksR620y+veOhrRSGDEEMXq4w6f784vFT/JYAkXOhMau41X+SzuFHtJPknkD1RNRJ+
 gCejJTTidCNSCVrnnpuRW06feZIy2mUL/7fn1E8Qry9g3iI4u3HoXlb/Rh5shWbZ/vulMI2wE1t
 tnwzwD0kgjFgYTyVpzCtvWPaU5U3Yt9rA0ettrXFxJJp9ZmV5zQJ+5RF+sDJR34mHka9FCRY56u
 wTK95Nr6KBIm6GXZ72qP8418BXj0LA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-07_02,2025-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 lowpriorityscore=0 spamscore=0 clxscore=1015
 impostorscore=0 malwarescore=0 phishscore=0 adultscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511070083



On 11/6/2025 9:00 AM, Wangao Wang wrote:
> The setting of HFI_PROP_CROP_OFFSETS for the OUTPUT port is correct,
> but on the CAPTURE port it is used to inform the firmware about the
> ROI, so crop_offset needs to be handled accordingly.
> 
> Signed-off-by: Wangao Wang <wangao.wang@oss.qualcomm.com>

Does CROP use case work with just this patch and first one?

Since you are enabling different features in your series, pls make sure
features are working with individual patches.

Thanks,
Dikshita
> ---
>  .../media/platform/qcom/iris/iris_hfi_gen2_command.c   | 18 ++++++++++++++----
>  drivers/media/platform/qcom/iris/iris_venc.c           |  4 ++--
>  2 files changed, 16 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/media/platform/qcom/iris/iris_hfi_gen2_command.c b/drivers/media/platform/qcom/iris/iris_hfi_gen2_command.c
> index aaa79dfe2db281bb77be7274233f093b0086b5d4..69034e1ea8eb64440646776a40dcc657453916db 100644
> --- a/drivers/media/platform/qcom/iris/iris_hfi_gen2_command.c
> +++ b/drivers/media/platform/qcom/iris/iris_hfi_gen2_command.c
> @@ -215,8 +215,11 @@ static int iris_hfi_gen2_set_crop_offsets(struct iris_inst *inst, u32 plane)
>  	u32 port = iris_hfi_gen2_get_port(inst, plane);
>  	u32 bottom_offset, right_offset;
>  	u32 left_offset, top_offset;
> +	u32 codec_align;
>  	u32 payload[2];
>  
> +	codec_align = inst->codec == V4L2_PIX_FMT_HEVC ? 32 : 16;
> +
>  	if (inst->domain == DECODER) {
>  		if (V4L2_TYPE_IS_OUTPUT(plane)) {
>  			bottom_offset = (inst->fmt_src->fmt.pix_mp.height - inst->crop.height);
> @@ -230,10 +233,17 @@ static int iris_hfi_gen2_set_crop_offsets(struct iris_inst *inst, u32 plane)
>  			top_offset = inst->compose.top;
>  		}
>  	} else {
> -		bottom_offset = (inst->fmt_dst->fmt.pix_mp.height - inst->enc_raw_height);
> -		right_offset = (inst->fmt_dst->fmt.pix_mp.width - inst->enc_raw_width);
> -		left_offset = inst->crop.left;
> -		top_offset = inst->crop.top;
> +		if (V4L2_TYPE_IS_OUTPUT(plane)) {
> +			bottom_offset = (inst->enc_raw_height - inst->crop.height);
> +			right_offset = (inst->enc_raw_width - inst->crop.width);
> +			left_offset = inst->crop.left;
> +			top_offset = inst->crop.top;
> +		} else {
> +			bottom_offset = (inst->fmt_dst->fmt.pix_mp.height - inst->enc_raw_height);
> +			right_offset = (inst->fmt_dst->fmt.pix_mp.width - inst->enc_raw_width);
> +			left_offset = 0;
> +			top_offset = 0;
> +		}
>  	}
>  
>  	payload[0] = FIELD_PREP(GENMASK(31, 16), left_offset) | top_offset;
> diff --git a/drivers/media/platform/qcom/iris/iris_venc.c b/drivers/media/platform/qcom/iris/iris_venc.c
> index 50a3eb975a2523abf1c2df128a66a762a1ed35c6..7ad747d2272f029e69a56572a188a032f898a3fb 100644
> --- a/drivers/media/platform/qcom/iris/iris_venc.c
> +++ b/drivers/media/platform/qcom/iris/iris_venc.c
> @@ -62,8 +62,8 @@ int iris_venc_inst_init(struct iris_inst *inst)
>  
>  	inst->crop.left = 0;
>  	inst->crop.top = 0;
> -	inst->crop.width = f->fmt.pix_mp.width;
> -	inst->crop.height = f->fmt.pix_mp.height;
> +	inst->crop.width = DEFAULT_WIDTH;
> +	inst->crop.height = DEFAULT_HEIGHT;
>  
>  	inst->operating_rate = DEFAULT_FPS;
>  	inst->frame_rate = DEFAULT_FPS;
> 

