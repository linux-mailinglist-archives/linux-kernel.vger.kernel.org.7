Return-Path: <linux-kernel+bounces-885245-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B4B8C325CE
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 18:34:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1CA2B1889CF6
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 17:34:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5581333A028;
	Tue,  4 Nov 2025 17:33:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="JT8C8owM";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="TXZCY90j"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4836338912
	for <linux-kernel@vger.kernel.org>; Tue,  4 Nov 2025 17:33:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762277636; cv=none; b=WVhj9rtpbnHMpnoRnFLuUa6T8DK2DqH93jXY34hZIogxI7anhwlwY7ahuxfa+J1rbMOjOlMeWYAKk55DxmHIRWH8e8ReijYDujWyzjag4mBYxLiLB5S/AhP/cSpmnjAOjyclnMv/Ysezh0BWzeYsrWO4kTdJ3+uQSiO67ym6WU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762277636; c=relaxed/simple;
	bh=KFvjz0cCCOJBoQSCD85u71EH/JU99I4A+NIvx/VMOTw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=miplPUqf5owS/8L9gyIqmuu6p2rkUBFJi/kJbCB5FwE8D24OGiFq+eP+Tf85XMMFzPWsipu1KAPkdsfjJVOdmGzRPBccgjWEgIC8GCXljBKVLpZ0FcDpfXMCx6s+qmWsd2fOjUhi/kVm4hvCqnKtc3FYrqFgi6RsU3bsZQMr0H4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=JT8C8owM; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=TXZCY90j; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5A4GgAZp2482729
	for <linux-kernel@vger.kernel.org>; Tue, 4 Nov 2025 17:33:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	aqZ9yfny6oAzxmXiKferFQ7liegXvYnBU8DVU4CAdfs=; b=JT8C8owMtH0dtdHH
	avdy3GC0PGU1LxkxoWlxeDOyeSmhOpkaDYO0ri9ia6WpLwKPnm5TLRVXS//kfZLY
	9iVeJ1jSEgmJESSbwKKUNaICoteG8XMxGyMwH/1zEk0HtJFyNE29KQ803TnqWO92
	OfGcLP30SERbqZnNOhCHU8+F15a3qydKi22eWRQbKU1Nj+dYdGjzK+p4sJBq9zIQ
	+T0gtYnScZNvyFhfnz44oABNHchzgurNd6UYGClUN2PeExbvB74fgtNSEOjmNpKt
	q//87dZeux3nPufYMT/2vi3EWyxZO+Zaek1nrqG2tfJ+79NFEtanPu8sSn+/xxui
	S0A82A==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a7heagx0u-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 04 Nov 2025 17:33:52 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-4ed6a906c52so1026201cf.2
        for <linux-kernel@vger.kernel.org>; Tue, 04 Nov 2025 09:33:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1762277632; x=1762882432; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aqZ9yfny6oAzxmXiKferFQ7liegXvYnBU8DVU4CAdfs=;
        b=TXZCY90jLOCK//3gnwcP+U8paekG/zN4GjHY6Dsz6wW2Zi+72zTw4Qv3VJ1Ha4oCdr
         kO/W322us/EcivWBSNxL4CdlIkqL7+y5xn2eJ9i9024K0f6WxeMx9PvRlELmJkNsQ3P0
         NUkEyx7gx81Mn3eumQNLYOlupcLKbodtaSviuwp2WueI570yHP8v5CgSUDL72z8dozAC
         6pANdMvs3g14MjhvAkeinLpl7xZ5AM7TPfghZtI30MZspp7qyTNXb9P8WqFhw6YIs17N
         o/dcAMXjhUDR/emdKoenL/dpMaEnR9n96yJqq+HMqkjA3arzJkMg01Q4do3+5x9hu4wk
         iW9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762277632; x=1762882432;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aqZ9yfny6oAzxmXiKferFQ7liegXvYnBU8DVU4CAdfs=;
        b=r1UDTNBqGHa+H0WGT1fMquvaBtomeFGfdxVntlpkF6QV5ByFlvRWXjlJWdvWR8idDh
         NbIVZxQcBuMlPV9pDK2XG1bAKjgeV6jt76WtDAEPqoFDQdTVHS70D8ld4u0rf0/ibQxK
         bT4f+u/jqRln/vVx3GjGiAsyrGOxhxGPKpVflaPF+LHg+9RR0yDQKztAJRX2d8KrZqav
         MW2GolLQdv9bRR0IUh7ybIw5xg2IGvfcsY4Bf4DBhAf0kV6UXEja6acuMgWfNtX1GE6q
         asP04s3dA1OPqFCVmbQ2OeDJSqzHtPqnuC3SV9j3kjbaOq//+0XPqSTz91UFyF+clEbd
         Iz7A==
X-Forwarded-Encrypted: i=1; AJvYcCUUqY3NEpPhCy2l86rd3ASfOsa5HKyy/eSY6MDXTve88vNcL7BEBfMDqEAFqpQzHt7dBXnOKVB4dGY+pzQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzinknO0E2QGyw1IRFbuTpfWF7hPQb7zzETob+bPsPfuF8KsK4X
	hZfnnD8P6uNc0RG6ubvb8ztTgvoWpV2skFSEcTkTExH07iCkf0uUa1tM81FmAbnPwSGnHGEt66E
	wbV5Ig5a8YP3C+gUo/+yNNEGnk2PGOGBJjmB6P0tWa2tSXRavQiummmP7s3QxtYD/7QI=
X-Gm-Gg: ASbGnctnADwbkImZV3VpWoy8/X8XRwXcnT1Go0q2iAILw9b2XdXgESXAxXHykfurEf3
	L2yIrLsCqJb9AOmr0JCEAeso/2dHWhQWLvaPIjz5xB7444dDHJfqW8eEdLFP5hGCwSyJykwmS0V
	nkdZgvEV5AquLZZ0yc2p2vvi19oHwQc1a/Rwrb3rmExRWet59BGgnyANOpxXhTWC/Ws5lh0L9HP
	AhAE6X3aarftwecgJtlMgAXJ6EV7967O7CEhbuL2JVe4ilynPDv+AQdRx+rr9qwbGyHboGmQQrg
	zBsoJzyHg85c7hCBsNTh7pmcQnD6LdZyZJlzlUpGDAHAGMahYEZ+fd+pVEaQ+OAj8m7sm2HIPly
	ZJ4M5meBipQ2gAGonIdlc2I9yFx1QarXLA8ffJ2aVmHAbONqY6B8Nb1QK
X-Received: by 2002:a05:622a:306:b0:4ed:1603:9504 with SMTP id d75a77b69052e-4ed719128a5mr3277271cf.0.1762277631849;
        Tue, 04 Nov 2025 09:33:51 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGW4Fzu7h1aS6jL7fg0IN2U5tLZI4K3C0D5I77oLa9b8QEcRdS4uAvBjPC1sDrWLjCqoMK2uw==
X-Received: by 2002:a05:622a:306:b0:4ed:1603:9504 with SMTP id d75a77b69052e-4ed719128a5mr3276881cf.0.1762277631241;
        Tue, 04 Nov 2025 09:33:51 -0800 (PST)
Received: from [192.168.119.202] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b723f6e4089sm274335066b.44.2025.11.04.09.33.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Nov 2025 09:33:50 -0800 (PST)
Message-ID: <fc8beead-566d-463b-aebe-407429adf156@oss.qualcomm.com>
Date: Tue, 4 Nov 2025 18:33:49 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 05/14] remoteproc: pas: Replace metadata context with
 PAS context structure
To: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20251104-kvm_rproc_v6-v6-0-7017b0adc24e@oss.qualcomm.com>
 <20251104-kvm_rproc_v6-v6-5-7017b0adc24e@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20251104-kvm_rproc_v6-v6-5-7017b0adc24e@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=GekaXAXL c=1 sm=1 tr=0 ts=690a3900 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=mTvibLGk-GZogn_PrgYA:9
 a=QEXdDO2ut3YA:10 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA0MDE0NyBTYWx0ZWRfX8zTKd/0/dhBw
 Apjc1dNDmR+nihxD2yFA3OB/mDSxMm/sOixKaflTip9wEdFudED7bIynyjcj79wX8tanvkiPB38
 RpBx/U/eGDD82BWZ9thFQtdt2I4/vHzhRagULCWBqAVyMp38vaVouYMXKaG1ZW2qQ42ZD89c1le
 iOqwrin0j/yNts6y0e1UygEIKh9c8d17ExT73FTbBuWIFyazlhjWAm4XJT+SpBxSV+/MvG1M+hx
 0QxIydM/EFS4nlHK0bHlSxDrx6zc7dJPTywdWBdkO26AC92cexHP93TbFuVW+MPHrcmRsvCye7P
 V/lTafCjKdApmONfrMXMY36OOjoI9wDAmvR3uggagcw58EJAdstask1MKMwjN4ryU6P4DDN/wsA
 dk2yKjzjq+I74wU6/OJQRTokU61ajQ==
X-Proofpoint-GUID: AgatfhOdhwG8Bj9OsMxY_gGLsamkEX7B
X-Proofpoint-ORIG-GUID: AgatfhOdhwG8Bj9OsMxY_gGLsamkEX7B
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-04_02,2025-11-03_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 adultscore=0 spamscore=0 malwarescore=0
 phishscore=0 priorityscore=1501 suspectscore=0 clxscore=1015 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511040147

On 11/4/25 8:35 AM, Mukesh Ojha wrote:
> As a superset of the existing metadata context, the PAS context
> structure enables both remoteproc and non-remoteproc subsystems to
> better support scenarios where the SoC runs with or without the Gunyah
> hypervisor. To reflect this, relevant SCM and metadata functions are
> updated to incorporate PAS context awareness.
> 
> Signed-off-by: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
> ---
>  drivers/firmware/qcom/qcom_scm.c       | 25 +++++++++++++---------
>  drivers/remoteproc/qcom_q6v5_pas.c     | 38 ++++++++++++++++++++++++----------
>  drivers/soc/qcom/mdt_loader.c          |  4 ++--
>  include/linux/firmware/qcom/qcom_scm.h |  4 ++--
>  include/linux/soc/qcom/mdt_loader.h    |  6 +++---
>  5 files changed, 49 insertions(+), 28 deletions(-)
> 
> diff --git a/drivers/firmware/qcom/qcom_scm.c b/drivers/firmware/qcom/qcom_scm.c
> index 5a525dbd0a2e..9cdd152da592 100644
> --- a/drivers/firmware/qcom/qcom_scm.c
> +++ b/drivers/firmware/qcom/qcom_scm.c
> @@ -603,7 +603,7 @@ EXPORT_SYMBOL_GPL(devm_qcom_scm_pas_context_init);
>   *		and optional blob of data used for authenticating the metadata
>   *		and the rest of the firmware
>   * @size:	size of the metadata
> - * @ctx:	optional metadata context
> + * @ctx:	optional pas context
>   *
>   * Return: 0 on success.
>   *
> @@ -612,8 +612,9 @@ EXPORT_SYMBOL_GPL(devm_qcom_scm_pas_context_init);
>   * qcom_scm_pas_metadata_release() by the caller.
>   */
>  int qcom_scm_pas_init_image(u32 pas_id, const void *metadata, size_t size,
> -			    struct qcom_scm_pas_metadata *ctx)
> +			    struct qcom_scm_pas_context *ctx)
>  {
> +	struct qcom_scm_pas_metadata *mdt_ctx;

This is never initialized

>  	dma_addr_t mdata_phys;
>  	void *mdata_buf;
>  	int ret;
> @@ -665,9 +666,10 @@ int qcom_scm_pas_init_image(u32 pas_id, const void *metadata, size_t size,
>  	if (ret < 0 || !ctx) {
>  		dma_free_coherent(__scm->dev, size, mdata_buf, mdata_phys);
>  	} else if (ctx) {
> -		ctx->ptr = mdata_buf;
> -		ctx->phys = mdata_phys;
> -		ctx->size = size;
> +		mdt_ctx = ctx->metadata;
> +		mdt_ctx->ptr = mdata_buf;
> +		mdt_ctx->phys = mdata_phys;
> +		mdt_ctx->size = size;

So this will always cause stack corruption

>  	}
>  
>  	return ret ? : res.result[0];
> @@ -676,16 +678,19 @@ EXPORT_SYMBOL_GPL(qcom_scm_pas_init_image);
>  
>  /**
>   * qcom_scm_pas_metadata_release() - release metadata context
> - * @ctx:	metadata context
> + * @ctx:	pas context
>   */
> -void qcom_scm_pas_metadata_release(struct qcom_scm_pas_metadata *ctx)
> +void qcom_scm_pas_metadata_release(struct qcom_scm_pas_context *ctx)
>  {
> -	if (!ctx->ptr)
> +	struct qcom_scm_pas_metadata *mdt_ctx;

Is the existence of this struct any useful after you introduced
pas_context?

Konrad

