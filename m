Return-Path: <linux-kernel+bounces-873524-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id AA4E4C14231
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 11:40:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6B6284F6F1E
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 10:40:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E0E8304BC1;
	Tue, 28 Oct 2025 10:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ZcTYS5wb"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 370F4305E1B
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 10:39:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761647993; cv=none; b=cru0U0j4K4YHPdAdaqDaBRmm/NB1/xcQ4k43b1gEtyNZm/Xvsw1JEnMmBW7oBfZ2TIBI9Ht+NtRnYTGdiCzaIotuGyealvIYOLPZTFPYjJGVg8kiASdyhRFSKbzhRvL9PEmalraCENXjZUeX9SlEckitB7XVKqRJXe3MkBHnxM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761647993; c=relaxed/simple;
	bh=3NGjtgZxPgWtmH709RDRDfk7uFifY5OiY7B1EJWWpsc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MHzZxkr70q1KtBuK47UMEoFFuL3wKSeikOQvo7+K92Fy/CHVgPIpjxcoKr/0LNTF3y+7mT6M75msn7alTrBFRMzYEzVhaEtAoWAXl3qsurcl6UNTRPtIRekiDeGgGTialuDW6fX6uO4IPDtFGLnlC6H9vDvxPXmoyJQgRvAX3TY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ZcTYS5wb; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59SA4Q5E353682
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 10:39:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	hakPLjvlb1x1mh1I+hwpkg3sAPbblZiTbfuHFvfq7VE=; b=ZcTYS5wbGBjroiRs
	Oe3hNC/poxLYE5cdIShOTQnO2ck3B0SA2YF76Q5N5TEQ66BR/0YxS5wOOA8w4vfD
	7f4Z7RvuQ5Q7byey9tn/1RsDUCtxZPi+wqm37ILaQ7aCM6FxPHk7iVE3AaSqh0t4
	j1UAM4l0JCpjf0AciJNZFCFJmEefjnl28zuX7j6LgwFexVYdp5v7iE3koq4rxH/y
	WcOpX018WI6HEvGQ2AfmrNjSHvbkOYb6wPkvsHBhiEhGyxosvs6mrebZkIPebutL
	m197HJxhnqakE2KcI88aHZvkOwSw8Ht2hGLWeXSBk24OrI9JNct1Up2N+1GbWLjH
	PGkkVA==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a2njrs9au-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 10:39:51 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-b522037281bso3651034a12.3
        for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 03:39:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761647991; x=1762252791;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hakPLjvlb1x1mh1I+hwpkg3sAPbblZiTbfuHFvfq7VE=;
        b=Hzw/8LWQauLpyBvpM4R+kpJWs4x58mMdNv2Z3KOVIMG09mLCd1BKiven59BIQFp8s/
         Bc5kbgDLuj4PhtP2ZtOXqasgXEKrPm+uS65F+5R9lSgbdLE9dzVL0A5kQ8pp+ydUoxS0
         pM/7+yYo+yGJs+EK88m4dal7LDbxx5AjE0QuuENMr6PiQwyHyPO8uyKHsiVLz9tQDpej
         lWB+mIcXabpKGnbiK4FUgbLc6W1s9elJfBVCwkBkVwvH6zPnGYmONZHHR+HlLMUxV5ip
         PUb+ZWe5nyTxxCON2Zgec9sQE5F3C0FT9FiEAQaYSoIkJQ+621t2Llu+YoWSdWNzo7ZQ
         I2uQ==
X-Forwarded-Encrypted: i=1; AJvYcCWwThemACd8b8zmvdE/TY0r71a0FD6eCyy29hRXm219JwGqGJGb8Ead8x7NutZ1xM/5HEP09E2UZzCRLKk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzl2ceAmtWn9hXS0I8ckTIkwYawaArA3BPAjEVv7Wgv6wEVQShv
	czSNw6/IjokX8xVEThBRMMjAjyIRO+R/lHtJCH4SA2Y2Xir5vrpyn3eK0+b7e1J6HdvfHzjoZJw
	lm9A31PYdj49deISXZcSviJv+otd7oLm3Oo5fXD60FRC5YJFdM8pRj9PpMRUR758cvSE=
X-Gm-Gg: ASbGnctfTnkbvvk6al+Y3yZBnv1419gulOmio2z5AsNhdT7kkw8QQcZJ7myTg0cSbbl
	Kda5DthOCuhuDFl3z3FpwFpuudjWle/DbqE5ZW8cS8haLTwBo5t9Ru0+vsLyhXAuiVsxm7fqFG2
	hfkgiH59ZA9F9VISO3mSYMLqobi8QpokCVWe120KyCZvEdzr+Qfe6PKwHYQHwQsRESS24fsG3vq
	7/c3YAQStMcxx05bpC1W9YYDRC4z3ab69KNRlYrs1Kb43ZX6oM9DokQuYC04qFcOMBSXyL7kEkn
	oBq34gKDb1IeJI4nOlNDNPfP8OFBV1c9TF+ifd4QReTz9yH5o3GM7ly2N1fW+ZUd06i4zmVVCoo
	PjCOWJ/bp4TcZQyazXgYe+yPHmOzYvU4=
X-Received: by 2002:a05:6a21:3397:b0:2dc:40f5:3c6c with SMTP id adf61e73a8af0-344d403a01cmr3981140637.54.1761647990653;
        Tue, 28 Oct 2025 03:39:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGYuP8hwnRXCriOHq1znAqj/6unUwBm2UU+kXa9k/iRY2/grJHUUtm0DNhi4dw2IYstv7N44A==
X-Received: by 2002:a05:6a21:3397:b0:2dc:40f5:3c6c with SMTP id adf61e73a8af0-344d403a01cmr3981110637.54.1761647990221;
        Tue, 28 Oct 2025 03:39:50 -0700 (PDT)
Received: from [10.206.101.41] ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a4140492f9sm11100899b3a.30.2025.10.28.03.39.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Oct 2025 03:39:49 -0700 (PDT)
Message-ID: <2898f1bc-c014-b196-705a-cd797be92dce@oss.qualcomm.com>
Date: Tue, 28 Oct 2025 16:09:44 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v1 1/4] media: qcom: iris: Add support for scale and
 improve format alignment
Content-Language: en-US
To: Wangao Wang <wangao.wang@oss.qualcomm.com>,
        dikshita.agarwal@oss.qualcomm.com, abhinav.kumar@linux.dev,
        bod@kernel.org, mchehab@kernel.org
Cc: linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_qiweil@quicinc.com,
        quic_renjiang@quicinc.com
References: <20251015092708.3703-1-wangao.wang@oss.qualcomm.com>
 <20251015092708.3703-2-wangao.wang@oss.qualcomm.com>
From: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
In-Reply-To: <20251015092708.3703-2-wangao.wang@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=dqvWylg4 c=1 sm=1 tr=0 ts=69009d77 cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=tP2Na-aPhhGfs1T55DUA:9 a=QEXdDO2ut3YA:10
 a=_Vgx9l1VpLgwpw_dHYaR:22
X-Proofpoint-GUID: idjbx8gDPd6jkOvEAkcY3hMB5WZCAWvl
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDI4MDA5MCBTYWx0ZWRfX5O050r447MCv
 R96Idz/1czN2vMB7Y+kJmtnZQfZDl+ylx+4LbcS4QzDazSU6PrHzDhsCyfVSmCYm7dlEfTW/hYb
 0VooKfuadclN5wuCHkzsOusS6y21NGJkrmtSkrohFDR0Kaw6sDkKwNzkIMYf6ivHbofAUyhK2k7
 LK3MBvp+QL/6nNKs17qhbADiX+TIaPw01BFso+ftAd/eAla+cQGstU9pj1EXJ37BsaWIFBZTyQi
 HdQRyKUj5xol/crbUXIq8ka52cRafQIwgaYt71rcJ9+coeXo1XKCUoAf0jlTg7UuUIXrUXN4Z2M
 q4/Ash6MdPuy7OVasyj6PzQM0o3Dlty4YVFEfp8tnEyFlQY9ehlhBDM5ynuXwyNy412YwdDzdMM
 dDoXKkF143c7kbaExg0UJKIu/jPL9g==
X-Proofpoint-ORIG-GUID: idjbx8gDPd6jkOvEAkcY3hMB5WZCAWvl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-28_04,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 clxscore=1015 impostorscore=0 priorityscore=1501
 lowpriorityscore=0 bulkscore=0 spamscore=0 suspectscore=0 malwarescore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2510020000
 definitions=main-2510280090


On 10/15/2025 2:57 PM, Wangao Wang wrote:
> Add output width and height settings in iris_venc_s_fmt_output to
> enable scaling functionality.
> 
> Add members enc_raw_width, enc_raw_height, enc_bitstream_width and
> enc_bitstream_height to the struct iris_inst to support codec
> alignment requirements.
> 
> HFI_PROP_CROP_OFFSETS is used to inform the firmware of the region
> of interest, rather than indicating that the codec supports crop.
> Therefore, the crop handling has been corrected accordingly.
> 
> Signed-off-by: Wangao Wang <wangao.wang@oss.qualcomm.com>
> ---
>  .../qcom/iris/iris_hfi_gen2_command.c         | 18 ++++++++----
>  .../media/platform/qcom/iris/iris_instance.h  |  8 ++++++
>  drivers/media/platform/qcom/iris/iris_venc.c  | 28 ++++++++++++++++---
>  3 files changed, 44 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/media/platform/qcom/iris/iris_hfi_gen2_command.c b/drivers/media/platform/qcom/iris/iris_hfi_gen2_command.c
> index 4ce71a142508..c2258dfb2a8a 100644
> --- a/drivers/media/platform/qcom/iris/iris_hfi_gen2_command.c
> +++ b/drivers/media/platform/qcom/iris/iris_hfi_gen2_command.c
> @@ -168,9 +168,12 @@ static int iris_hfi_gen2_session_set_property(struct iris_inst *inst, u32 packet
>  
>  static int iris_hfi_gen2_set_raw_resolution(struct iris_inst *inst, u32 plane)
>  {
> -	u32 resolution = inst->fmt_src->fmt.pix_mp.width << 16 |
> -		inst->fmt_src->fmt.pix_mp.height;
>  	u32 port = iris_hfi_gen2_get_port(inst, plane);
> +	u32 resolution, codec_align;
> +
> +	codec_align = inst->codec == V4L2_PIX_FMT_HEVC ? 32 : 16;
> +	resolution = ALIGN(inst->enc_raw_width, codec_align) << 16 |
> +		ALIGN(inst->enc_raw_height, codec_align);

HFI_PROP_RAW_RESOLUTION interface expects actual YUV resolution. It is not
suppose to be aligned while configuring it to firmware.

>  
>  	return iris_hfi_gen2_session_set_property(inst,
>  						  HFI_PROP_RAW_RESOLUTION,
> @@ -195,8 +198,8 @@ static int iris_hfi_gen2_set_bitstream_resolution(struct iris_inst *inst, u32 pl
>  		payload_type = HFI_PAYLOAD_U32;
>  	} else {
>  		codec_align = inst->codec == V4L2_PIX_FMT_HEVC ? 32 : 16;
> -		resolution = ALIGN(inst->fmt_dst->fmt.pix_mp.width, codec_align) << 16 |
> -			ALIGN(inst->fmt_dst->fmt.pix_mp.height, codec_align);
> +		resolution = ALIGN(inst->enc_bitstream_width, codec_align) << 16 |
> +			ALIGN(inst->enc_bitstream_height, codec_align);

Do we really need *bitstream variable here ? What is the concern in using the
instance capture fmt height and width ?

>  		inst_hfi_gen2->dst_subcr_params.bitstream_resolution = resolution;
>  		payload_type = HFI_PAYLOAD_32_PACKED;
>  	}
> @@ -216,8 +219,11 @@ static int iris_hfi_gen2_set_crop_offsets(struct iris_inst *inst, u32 plane)
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
> @@ -231,8 +237,8 @@ static int iris_hfi_gen2_set_crop_offsets(struct iris_inst *inst, u32 plane)
>  			top_offset = inst->compose.top;
>  		}
>  	} else {
> -		bottom_offset = (inst->fmt_src->fmt.pix_mp.height - inst->crop.height);
> -		right_offset = (inst->fmt_src->fmt.pix_mp.width - inst->crop.width);
> +		bottom_offset = (ALIGN(inst->enc_raw_height, codec_align) - inst->enc_raw_height);
> +		right_offset = (ALIGN(inst->enc_raw_width, codec_align) - inst->enc_raw_width);

I would suggest as below:
S_FMT (output) -> Keep the driver fmt same as what client sets in s_fmt.
So crop setting here could be "inst->fmt_src->fmt.pix_mp.height - inst->crop.height"

without the need of additional variable ?

Could you fix s_fmt and other places and run through compliance/ffmpeg to see it
works well ?

Regards,
Vikash

