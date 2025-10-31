Return-Path: <linux-kernel+bounces-879580-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id AE7B3C2381F
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 08:13:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 3326234DD5D
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 07:13:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8803D327203;
	Fri, 31 Oct 2025 07:12:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ig3J1HMh";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="I83SuFAv"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D54523271F9
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 07:12:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761894776; cv=none; b=fVNyY/Zpx7QNxFMhVtZZs6GpjKnx2tnXIfcd7mDbqFplzXuU+wZuWq+ab53WV8pyqoe5mBXrAmyHWrdpxwxASAeb8jMGV5EScnd1umHwzeOQ3d8diLVss/mA3jmrWh/iAy36AU3qat/+yyfWxBKtmcF8C+JPRzOmcHXPUhsOALE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761894776; c=relaxed/simple;
	bh=dDKWrhsiiyt4gngOhWkZfsh8pT1NRHZxaH5TkY9fIAo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UCKk5ez2UWRgqz4lnqMeUwJTNUwNvLKQ5UvGo5QxINLmNqFEjNLtqq/87IqQoTlpnWk+MKaCf/+wGq3WUzin/cwkBc6ZUHScV7p9hy1bQVRSD6H0SfySzq22JPJUCokxJjm/stgopp8SHqbU4dRgIytPoFs7nPZn5Lht4N0QPCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ig3J1HMh; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=I83SuFAv; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59V1n3KC1572066
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 07:12:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	5ooCWPS7joz5A65vto5/5X624ZOR87hrJBWp2Ets3u4=; b=ig3J1HMhj4kwxE36
	A4Oj8IjynE1Yow0R+qMtJkq20vhfPb2C87RGr8O/VUfq0Er/mSqejtM3JUOl5jMA
	avsyg7MRCfu7ARXxWERu9LxBwg/7J2XQT1W/87jKM9HGtdmDI8bDwlLfHuWcaC/Z
	dvmc7DRwmeijhJet2DhAyBYgUwSUGehFlSNb1PJNn1dS2rxnT+a0rO1w6JaeCpad
	IclhrSLOPMscy6MNEnanrX0PNIDb6Jl+iHM7TETfGdjyoVn/cZ8gE80dqtUGuPX+
	nGOp2ENHj9Mq8ypAW3QUFRZLS/qSsmCa4ZTLaxrZht0rQhNTpX0nLTr1zeUaaj1f
	6muEBg==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a4ksc0pkr-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 07:12:53 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-3408686190eso1355784a91.3
        for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 00:12:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1761894773; x=1762499573; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5ooCWPS7joz5A65vto5/5X624ZOR87hrJBWp2Ets3u4=;
        b=I83SuFAvEo1hgXkwVvK2MxAbFjnSqeoFfONQJdfl0BPw6iDutPNRaU3BS0EUsb4H5H
         xjCVQO9ILKUcGyQVSjXwLQcAe1NZnWHZiKcbGHsvLYapWexqAL5pIadd+M0jPTaDCDIv
         IpLL2n0vG4J0FTZsDum6WIS7y9Cw5XJZT+4w/UEMX/u74BpRnWZky47tA3dIE0anv/p5
         Kk3FtZNs/AmWrO5SfFmhRlzE7u3gEZYH/PSnSYjiqRfwZ8h+KfX7AsaVujHwDuLYT5vX
         CQDWDZ7J1812sBez7N2Drjp/w8kHY8EmFMDJZ/L3UWOdso/lJIZ/JS+rjy3Lhyqo8GjP
         M8ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761894773; x=1762499573;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5ooCWPS7joz5A65vto5/5X624ZOR87hrJBWp2Ets3u4=;
        b=cxFGlFCDRqKB1G2bFUc6U4DZGDnB69eywmLOA9Nb/vTQk84EIZT8Dt7P6ycG8PUlrO
         mBbZVdvfi7XcMdBewLLHv1chkhV2Ci1LNhBO9qqeEF2BFH0dofZoNuzXqdGzTvH7DeID
         ZpK6FrezKUv/GF6ihT/gi490uQa5fc8PFbrCZhx7u7+PULMiwVIHuE/U+8G19xlTZtQE
         UAa7RoNKdMcNnuUjwNfyiXVSIGu9xxlb5rw7b3JWUCUN91yA0W1qIttQ1pj7NqC/cp49
         Gz8LuIOfLne3F18VczrdxwE4BQpHbhsxUHp5dbNkIlHtZ28229YsRYOS9jSs9qdj7eCI
         Qidg==
X-Forwarded-Encrypted: i=1; AJvYcCWZkWBL9NmOkNzb07UK//YEV6uOst/BsLB4dm55E8AO8UMq5fXE+1XMDCD6+gjPmHKDZ/yJ1WtjRFAjCCY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyve6qPFkr7HS/MX0lvTClFN+qR/xHYeN+k6LkUS+g5yxCXZDCd
	2j8HwC6A+qnRkPwwxPjkFEadsBlB+2nX3pceEKPhCGMqKr3fnG5S0xxjrOMF1RLeYSPBRIrLdqn
	msjh3UwrT086QowZsauxtTPGhxtAAiHD7eRp5cQ7j6blDvJ4F4eih3vs/Ph53ABj6mQY=
X-Gm-Gg: ASbGncv4ao7nw0Rnm9nMNIDW1EoAOp4sX0eVNdjJVfdSjDIij5zoJ1KeQVijLSeq/gk
	1NYAwB/8rbAqhJXNKpcfZa6GCEleN2JJ+xEMYNRbVfuZiSYqPYZA+/h1MitoFO7L4o5Dy9Pc17H
	fEG1sIVqibJKz1KsKdp5tccp2hjAVTu3sJwP1d4j0o/9s7bBaJ+D3ZXv/QXmFKX9B9QUhjB8wWY
	ed01WFNshk4616+TipiTulhUFud8jQm2blJrugF5h1klyzTaC0MEgjOKxHz9Ql+YdaXWDpxjMKv
	XvXuCys2lb0sxtTkVFiRNwhZmiWCPuFGKD517LRsdKPWDF0JW5cgBEGa+Ph4khA8fEJbzS2EOhv
	/MFaz1AE7ArsiEiH2QlP16BFsgXEOqRk=
X-Received: by 2002:a17:90b:2792:b0:33e:2d0f:478e with SMTP id 98e67ed59e1d1-34082fc651bmr3480201a91.3.1761894772640;
        Fri, 31 Oct 2025 00:12:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF0PmjMJsVD/nICGvMD3F6gbXOJ+0TRUprUO3h6jktUSJpPvn69R5Hojj06flgoshnoVGj52w==
X-Received: by 2002:a17:90b:2792:b0:33e:2d0f:478e with SMTP id 98e67ed59e1d1-34082fc651bmr3480164a91.3.1761894772127;
        Fri, 31 Oct 2025 00:12:52 -0700 (PDT)
Received: from [10.0.0.3] ([106.222.229.252])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-34092d4b041sm1101266a91.16.2025.10.31.00.12.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 31 Oct 2025 00:12:51 -0700 (PDT)
Message-ID: <206d943a-0171-5f75-78fb-25cd1cd1c087@oss.qualcomm.com>
Date: Fri, 31 Oct 2025 12:42:47 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v1 1/4] media: qcom: iris: Add support for scale and
 improve format alignment
Content-Language: en-US
To: Wangao Wang <wangao.wang@oss.qualcomm.com>,
        vikash.garodia@oss.qualcomm.com, abhinav.kumar@linux.dev,
        bod@kernel.org, mchehab@kernel.org
Cc: linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_qiweil@quicinc.com,
        quic_renjiang@quicinc.com
References: <20251015092708.3703-1-wangao.wang@oss.qualcomm.com>
 <20251015092708.3703-2-wangao.wang@oss.qualcomm.com>
From: Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>
In-Reply-To: <20251015092708.3703-2-wangao.wang@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDMxMDA2NSBTYWx0ZWRfXywRkxtcrdi74
 3nvjD0fz5HDlJKgub8zvPy5BNv1av/CadGyYCB+cn5JornaI6DxB4pfaJRKX07X+XRVMpsT4tDM
 LV1P+TmBuxiItUvCAd33eOY2ZQzBkv5hf6t8VHhHlg5CyCWOy0VyIF1ylR34aMeuMUFaD4an8YQ
 m7D0DyKpIGLVRo6K+adahRe8B8LizF36g3XjxXrqqMIwk+8BC7uBhKGL3z9fTF2v7DbVtcFTKwa
 kC2Lm7phbx4BJqXPn0CE9i+lroGX0bZYYEGNy34S1RBxqCcWZu8f4j1z1K5j2vhwz9aIRVt48Z1
 jh5GDUenuAkKCudSwhLoAWzJFbh2rST0tkJJnplPN8YjdzowpJt4l5LPiAgzKVErLx7eoZ7025J
 TQaKH5ZcssEgNQFJUNCOvVgQvuATxg==
X-Authority-Analysis: v=2.4 cv=Q8PfIo2a c=1 sm=1 tr=0 ts=69046175 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=L4UNg9I9cQSOxNpRiiGXlA==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=cuqx5Vh6MJc6xawovOEA:9
 a=QEXdDO2ut3YA:10 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-ORIG-GUID: g49ZqVBhq0WX4wy73gpJ2Wygr9ukptxI
X-Proofpoint-GUID: g49ZqVBhq0WX4wy73gpJ2Wygr9ukptxI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-10-31_01,2025-10-29_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 priorityscore=1501 adultscore=0 malwarescore=0 suspectscore=0
 spamscore=0 lowpriorityscore=0 impostorscore=0 phishscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2510310065



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

This shouldn't need to be aligned, pls check.

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
>  		left_offset = inst->crop.left;
>  		top_offset = inst->crop.top;
>  	}
> diff --git a/drivers/media/platform/qcom/iris/iris_instance.h b/drivers/media/platform/qcom/iris/iris_instance.h
> index 5982d7adefea..f371b1cbef47 100644
> --- a/drivers/media/platform/qcom/iris/iris_instance.h
> +++ b/drivers/media/platform/qcom/iris/iris_instance.h
> @@ -64,6 +64,10 @@ struct iris_fmt {
>   * @frame_rate: frame rate of current instance
>   * @operating_rate: operating rate of current instance
>   * @hfi_rc_type: rate control type
> + * @enc_raw_width: raw image width for encoder instance
> + * @enc_raw_height: raw image height for encoder instance
> + * @enc_bitstream_width: bitstream width for encoder instance
> + * @enc_bitstream_height: bitstream height for encoder instance
>   */
>  
>  struct iris_inst {
> @@ -102,6 +106,10 @@ struct iris_inst {
>  	u32				frame_rate;
>  	u32				operating_rate;
>  	u32				hfi_rc_type;
> +	u32				enc_raw_width;
> +	u32				enc_raw_height;
> +	u32				enc_bitstream_width;
> +	u32				enc_bitstream_height;

As enc_bitstream_with/height is used for scaling, rename them accordingly.

>  };
>  
>  #endif
> diff --git a/drivers/media/platform/qcom/iris/iris_venc.c b/drivers/media/platform/qcom/iris/iris_venc.c
> index 099bd5ed4ae0..25c05123dee4 100644
> --- a/drivers/media/platform/qcom/iris/iris_venc.c
> +++ b/drivers/media/platform/qcom/iris/iris_venc.c
> @@ -68,6 +68,11 @@ int iris_venc_inst_init(struct iris_inst *inst)
>  	inst->operating_rate = DEFAULT_FPS;
>  	inst->frame_rate = DEFAULT_FPS;
>  
> +	inst->enc_raw_width = DEFAULT_WIDTH;
> +	inst->enc_raw_height = DEFAULT_HEIGHT;
> +	inst->enc_bitstream_width = DEFAULT_WIDTH;
> +	inst->enc_bitstream_height = DEFAULT_HEIGHT;
> +
>  	memcpy(&inst->fw_caps[0], &core->inst_fw_caps_enc[0],
>  	       INST_FW_CAP_MAX * sizeof(struct platform_inst_fw_cap));
>  
> @@ -185,15 +190,27 @@ int iris_venc_try_fmt(struct iris_inst *inst, struct v4l2_format *f)
>  
>  static int iris_venc_s_fmt_output(struct iris_inst *inst, struct v4l2_format *f)
>  {
> +	const struct iris_fmt *venc_fmt;
>  	struct v4l2_format *fmt;
> +	u32 codec_align;
>  
>  	iris_venc_try_fmt(inst, f);
>  
> -	if (!(find_format(inst, f->fmt.pix_mp.pixelformat, f->type)))
> +	venc_fmt = find_format(inst, f->fmt.pix_mp.pixelformat, f->type);
> +	if (!venc_fmt)
>  		return -EINVAL;
>  
> +	codec_align = venc_fmt->pixfmt == V4L2_PIX_FMT_HEVC ? 32 : 16;
> +
>  	fmt = inst->fmt_dst;
>  	fmt->type = V4L2_BUF_TYPE_VIDEO_CAPTURE_MPLANE;> +	if (f->fmt.pix_mp.width != fmt->fmt.pix_mp.width ||
> +	    f->fmt.pix_mp.height != fmt->fmt.pix_mp.height) {

pls add a comment here, as this is for scaling specific usecase

> +		fmt->fmt.pix_mp.width = ALIGN(f->fmt.pix_mp.width, codec_align);
> +		fmt->fmt.pix_mp.height = ALIGN(f->fmt.pix_mp.height, codec_align);
> +		inst->enc_bitstream_width = f->fmt.pix_mp.width;
> +		inst->enc_bitstream_height = f->fmt.pix_mp.height;
> +	}
>  	fmt->fmt.pix_mp.num_planes = 1;
>  	fmt->fmt.pix_mp.plane_fmt[0].bytesperline = 0;
>  	fmt->fmt.pix_mp.plane_fmt[0].sizeimage = iris_get_buffer_size(inst, BUF_OUTPUT);
> @@ -249,6 +266,11 @@ static int iris_venc_s_fmt_input(struct iris_inst *inst, struct v4l2_format *f)
>  	inst->buffers[BUF_INPUT].min_count = iris_vpu_buf_count(inst, BUF_INPUT);
>  	inst->buffers[BUF_INPUT].size = fmt->fmt.pix_mp.plane_fmt[0].sizeimage;
>  
> +	inst->enc_raw_width = f->fmt.pix_mp.width;
> +	inst->enc_raw_height = f->fmt.pix_mp.height;
> +	inst->enc_bitstream_width = f->fmt.pix_mp.width;
> +	inst->enc_bitstream_height = f->fmt.pix_mp.height;
> +
>  	if (f->fmt.pix_mp.width != inst->crop.width ||
>  	    f->fmt.pix_mp.height != inst->crop.height) {
>  		inst->crop.top = 0;
> @@ -329,9 +351,7 @@ int iris_venc_s_selection(struct iris_inst *inst, struct v4l2_selection *s)
>  		inst->crop.top = s->r.top;
>  		inst->crop.width = s->r.width;
>  		inst->crop.height = s->r.height;
> -		inst->fmt_dst->fmt.pix_mp.width = inst->crop.width;
> -		inst->fmt_dst->fmt.pix_mp.height = inst->crop.height;
> -		return iris_venc_s_fmt_output(inst, inst->fmt_dst);
> +		return 0;
>  	default:
>  		return -EINVAL;
>  	}

