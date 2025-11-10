Return-Path: <linux-kernel+bounces-893305-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 62E6CC4708C
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 14:52:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B60DB188348E
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 13:53:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAFD73101DB;
	Mon, 10 Nov 2025 13:52:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="pZMjzBcO";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Bv5x/gwb"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80DA834D3AC
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 13:52:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762782769; cv=none; b=mlS7ybdJqxqwwFEk0ekUOw04C09erO8yhO2BCdQQV/iwiyh8ppqqc2XPN572Mz0uE429JxlP9JMmT1rpgteNuJXN0Y2meutxS4S2yPg+ALCpU52wR6lQi85gIswCc+ktsTxqU3l99SfeNXHYyWYhVLgl02B1mIaTIrYfRgY7S2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762782769; c=relaxed/simple;
	bh=WBxcVvNlpdV/47lFT4a9Zk5x0dPAfC/lBVpWsjj6dEI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qte9PPDiJfedDyYaFerjXNcRn+aYbYudltIJEpnlgsUp9Lr5FBNKdM5lntcIO/+ZyKh+lqZ6obrTLdR8Jk/ziTYqI9wO5UzlHHcCZXD1Q27F0QLDqGpkyVo/iHqAlMrBIIpLR34sdkBbxUYQ9LGrFq3oteb4ADpFiiCfdMoVn4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=pZMjzBcO; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Bv5x/gwb; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AA8qLQJ1795143
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 13:52:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	rFrYi9xcQkzZEVjlswAhIybBIzLSSz1edyCnLv9Yw0k=; b=pZMjzBcODeRL8jCt
	HH5y/Ojifdbrv+TeyrNhCcsKn56rbXrzejw9+IwgVe0VdZ/RXObTU8DqT9IAYB6l
	tcNrsw+4v7oRgnC4kCT1u0oD6WsavhhhFZmNmYIAWSLr9f7Ve1gCjGb+scA9gSgp
	n2FabQ+P8WxPHKysx2/vZ2bc5az0X/ZwinereaqYGqFtTMq7jRv/wZmsTa5M3CPZ
	dNLnXbcCqtuAzqhIpgPcSQiARL912tJvD7SuNDqK51vQDD5F8AVcGzpEVMdTrsPg
	gNRgxnsSA6zDP2AVw5qm62Skef+Njje9F63LXjb5aA2N84P8hAaEMTEI8qjVWntx
	pYVUTw==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a9xvjcwws-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 13:52:46 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-34176460924so2961181a91.3
        for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 05:52:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1762782765; x=1763387565; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rFrYi9xcQkzZEVjlswAhIybBIzLSSz1edyCnLv9Yw0k=;
        b=Bv5x/gwbUcailH8u8ByfsfveDbDhzrWFCFdzYZNyVUtnRg2WTnHteTW2kOTK36ID7i
         CpjnX2ZPsZlmwRjYYgueo+8/Owzr/t370r2Se8tq7WYEMQX/9K579Osc5XcA1OR7DYDr
         IGiltRdnO6EceSv5VxbMvPnJkN4VFBzxU58cgK3WIQ2h86TClMIZZ2sg0fmVPfEIGLGk
         5uUJAptPMI0TsVZxPqHK/Wa3IwWKuYQRnZ0x9Lo7XSKMwQg4dtVJWT00rDynEJxzGf7E
         8wbfTYsijk3Nf91K0VvW8lrfm+4G5JtRWYTT3miI6/tGt90pSl4OlX64wbKzZ2TIZdfx
         ajTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762782765; x=1763387565;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rFrYi9xcQkzZEVjlswAhIybBIzLSSz1edyCnLv9Yw0k=;
        b=aGb93LJRKpF6xDBjCbPXtFLS8xGDWSh1MV/eChwcgar4RWrFbQWmk2Rp09Vy8vWA5Z
         5Y1gmBoYzyhUn7QOemJMLCbHPwyftUzr3sEtZAUeuYoGLjn7LvrxnlG/roMmsB9losR7
         1ZiXHsXy33wj1/RZTtE08D5nnORBhPyLxiUT6NAVAf034MJPHN5XrP8CM49x9xxbwku2
         zD8WwPm9vU4/5mSzDcQ4LmzZl0w0c2GOTBYuFowTLRS1btHVPZoGJ07eECWvMbLAMQR9
         gLGieJhZhSHfQc6imkl5mJ/pFF6zEVqRhT9ZsGzHlnHLhdkeWW5pF+xiVOrhp0dLRGgJ
         G8dQ==
X-Forwarded-Encrypted: i=1; AJvYcCUTcLr09ayXa0aq6WdvIznvKEr21ggbeU1RAlmg6T6cfYG4VNI2mZF1y+RwePujLION7OVpc5EpRF5Lz34=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/fkA7Z7j3pLEhd0rsFS+pCRNf985YaILesYDydZ2f7YB0lnFn
	UTLAYuY+au02rmmvqVV6xUWkTDKxGXLYs4Jb1qFIm0VgwCDG094JEEU6oL4LILXYz1OdwgJ592C
	RQFBAu+NW2SNw1a2g3SHuWz9EakHPNArCIHg2zCZCZiqUHueHGrDufbXid8ejLSwRgH8=
X-Gm-Gg: ASbGncsGGzNSonrXZGkazA2G1OEoGQwMugzl6Ymsb3DBJJJGon1a+b4NHua/8+U2kCT
	jFcsj6N2jUniUcIbuppQ4OoNWOcoPQoO9zUYn7HQW03tTa8gT0g01dKgpTp+SjTHFUftZbbxumt
	MN3OgXxvmX6/9tkP1VUdrGvYn32+cjVLx3T+dB4PhcI1WbG6ov2H1k4r5xneA8o9IAUV70yUAqa
	RNr4IsRrrGiNq+4BCQ6ZQjeCZOv5FFHxdCZmDjyAi6Xd9ow5oaLBDvLp0AOO1liX1Nm1+AQ7Ri4
	p4gzKzLH4eLCHswwBmygeCE2qQYtiYrJIE0azl9keJd3Fqu6G9eN6c4Yn1e7sikVosUKC9uMrP2
	CayPasBBTp+Q0uG5Hdzjkn2hT51vdz8E=
X-Received: by 2002:a17:90b:3145:b0:340:d1b5:bfda with SMTP id 98e67ed59e1d1-3436cb0d072mr9855907a91.3.1762782765383;
        Mon, 10 Nov 2025 05:52:45 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFRRC1j4SGk2DWY0f5zxpy/vhSZdkDH0wAwoUOj5ecb/T3Idsogg4Amw1gqXtJva0EceBP6Gg==
X-Received: by 2002:a17:90b:3145:b0:340:d1b5:bfda with SMTP id 98e67ed59e1d1-3436cb0d072mr9855867a91.3.1762782764852;
        Mon, 10 Nov 2025 05:52:44 -0800 (PST)
Received: from [10.0.0.3] ([106.222.229.252])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3436b9fa1c2sm7941681a91.14.2025.11.10.05.52.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Nov 2025 05:52:44 -0800 (PST)
Message-ID: <d2f6d9f0-dc12-048b-7d5a-92c1b0e85000@oss.qualcomm.com>
Date: Mon, 10 Nov 2025 19:22:39 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v5 1/6] media: qcom: iris: Improve format alignment for
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
References: <20251110-iris_encoder_enhancements-v5-0-1dbb19968bd5@oss.qualcomm.com>
 <20251110-iris_encoder_enhancements-v5-1-1dbb19968bd5@oss.qualcomm.com>
From: Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>
In-Reply-To: <20251110-iris_encoder_enhancements-v5-1-1dbb19968bd5@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=QuxTHFyd c=1 sm=1 tr=0 ts=6911ee2e cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=L4UNg9I9cQSOxNpRiiGXlA==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8
 a=pSuam4OevfOGhOpoTx8A:9 a=QEXdDO2ut3YA:10 a=rl5im9kqc5Lf4LNbBjHf:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: enh9bqhTcWHYxuSUbPk5NGugezR5qN-W
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTEwMDEyMSBTYWx0ZWRfX/f5nx6UK/hyb
 FkMfYsnyD0SSTO737ozSCWq2bptCaH5ypwfXTWpEyCWvv5qftWofKq34oV7OB64LUVGE5bh2TaV
 oCbcl6kMqMiKo0eYXB7wpy51ARz+9UIRmLL54S/tqTOOH9IO7nVkxwfwAAzT1Lc8gnnFVNgA4Z5
 JSGsgFtxW8nPg2L4vh7Q+V0iM3z3zMkOCm16lna602Ktm1csFh/lD202jetwL3nlPh46NCIUijq
 mwcViuw+a1fP34zkBoJFTMVaSt+L7cDNPNWO2/s+s4vj5HzhkgMI5ML0smbSpUxaOUMY28oF3AS
 jOphljXIs7f99O6DS31F5+BKO39kwSjQ+o9D4Vo0/+P8DjEQZGSAaCgDyCq1ieGiNDzttiS1rBI
 W5hcVq4/Fnp6/yi5qTxqdB8XUdRdKw==
X-Proofpoint-GUID: enh9bqhTcWHYxuSUbPk5NGugezR5qN-W
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-10_05,2025-11-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 priorityscore=1501 adultscore=0 phishscore=0
 spamscore=0 impostorscore=0 malwarescore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511100121



On 11/10/2025 3:53 PM, Wangao Wang wrote:
> Add members enc_raw_width, enc_raw_height to the struct iris_inst to
> support codec alignment requirements.
> 
> HFI_PROP_RAW_RESOLUTION needs to be set to the actual YUV resolution.
> 
> Tested-by: Neil Armstrong <neil.armstrong@linaro.org> # on SM8650-HDK
> Signed-off-by: Wangao Wang <wangao.wang@oss.qualcomm.com>
> ---
>  drivers/media/platform/qcom/iris/iris_hfi_gen2_command.c | 3 +--
>  drivers/media/platform/qcom/iris/iris_instance.h         | 4 ++++
>  drivers/media/platform/qcom/iris/iris_venc.c             | 6 ++++++
>  3 files changed, 11 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/media/platform/qcom/iris/iris_hfi_gen2_command.c b/drivers/media/platform/qcom/iris/iris_hfi_gen2_command.c
> index 4ce71a14250832440099e4cf3835b4aedfb749e8..48962d2e4962935bbc24244edfbbdcd42dab151f 100644
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

Reviewed-by: Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>

Thanks,
Dikshita

