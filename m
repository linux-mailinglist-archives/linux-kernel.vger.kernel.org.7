Return-Path: <linux-kernel+bounces-885627-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 764FEC33800
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 01:46:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 59139462C0B
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 00:46:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 768D3128819;
	Wed,  5 Nov 2025 00:46:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="OoXws1Wc";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="C7XbrWaF"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3259B2248A4
	for <linux-kernel@vger.kernel.org>; Wed,  5 Nov 2025 00:46:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762303572; cv=none; b=Fr2hX1o+gqvzunwWzAV/qtbkkm+QJalkDVfSpRvcnkizLsh7YxZaaDG6ljYZoX2tYP7z88I6re/HmiNE6hvo55f4yxsiAxt0LgvCLRtUZ5SheEm4ouEgLMES8Ni6zlZFNIfofA520bohdPgRUgIMSxWPTd9N1hfIFYiVGMmaLyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762303572; c=relaxed/simple;
	bh=7T7aL22RX9GpDnYaiiUc+H26sq7SXpfu7cYU+xDC4hg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sOmWqnd6VUurvOhncCrDIQ9xBn3OENijrs4M2kOPcCLR1JnT3XMNFEhfMBiEcSMEDI4yRJZMewlVut7klvOgLQdvszKIm81NrVsjxkUOPJv6LfXvXCrW4BaULseAQAQnGAZtjYvIKPSWjmzyFV//b40cK7twDFS4I2ZRopsjYb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=OoXws1Wc; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=C7XbrWaF; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5A4LUo133114829
	for <linux-kernel@vger.kernel.org>; Wed, 5 Nov 2025 00:46:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=aLWcO0d8F+Y82Vhk0yQ9jtdy
	rVhv/PJ9LgP07EI36wY=; b=OoXws1WcQz6JBL2b2LlgGyszwyq4a9PQh3HirPpU
	h7+cjnRd1YJj8mYx6GA3fZA3McP3GSw03CzdwEs7jX1eOAf/p8/hIFCF1h/Jw+aR
	N8KQJNdYjRtpyACbHoRXfek0Y+1cySZrplO9CTAdB+hpgaQExTdwUbgLEDVFyosv
	9nVUhCW5DSMkXJJZWlSC7xEjNn3q5JUvcjeKIITjWPuJS86OJvYCl5p/BxzqglXW
	Dg8//C62uzUmJTRE/mCEa4F1AFD7KYIU/NSmBmKfgXHxn+OBxOSItHsU368gWwNm
	TjMuSo5nG8eothkCwxL5Kx+KnbIWvmyW45qsPVoyzrvGTA==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a7sfdrfkv-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 05 Nov 2025 00:46:10 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-4eb7853480dso174513691cf.0
        for <linux-kernel@vger.kernel.org>; Tue, 04 Nov 2025 16:46:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1762303569; x=1762908369; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=aLWcO0d8F+Y82Vhk0yQ9jtdyrVhv/PJ9LgP07EI36wY=;
        b=C7XbrWaF7Q9A3gPfgdphqr9Z+bqcFxldUvtp35ogcX8GmFNqEsPdDWu7Vx+EAUNBcN
         avyCzjYxR9dWhJBOPQNPKcucj9cigkEbQMkspLdLpYIFoI9C0WmuplX1SbmF5n3YVFKb
         D9UJRghB6z4sdXRvshZk3Gz5U37XSYhSaCyZ1hlLOR9grN9bZYyx2BFM3GJwRbWt3DRA
         VIaOEaGmORAzCfu1FxESKTxxYfjOBntuoEliNUgJs5qN9QAOMBsd+5XNCYMjcPvBZesC
         CZW880C0tMhWiN5rVPzAlKLB/JADrPCs4UsJTYAlWUoZXtwfATnFKrdeC8ehnGn52OmC
         DDsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762303569; x=1762908369;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aLWcO0d8F+Y82Vhk0yQ9jtdyrVhv/PJ9LgP07EI36wY=;
        b=pa8EdYF4dt+Y7JuWtyQXP8QTrhva1BUDWUY4JZ7w75rE2LAEacvv2E8cN2ORX7t1Zu
         Khfq80El3+n6oWVjM42kJJwtbZW9LjncGTcxqlmlOyv4OP6egfaYGM/hh9hayUVh2vSk
         dyFNJEbv87YiTfy0t0RyTVJtZo+o+/if7LVfV+eJEQK0OQN6Ov75jFuIftsMf2/BaIhi
         bMJ+3fNfFWy1HqHuCniooZXsbuVBdNlyP7bTo7z0HA2OJNA+6c6lYkzrlIRals2qrF4k
         tRlr2LE4CSj1Je9nf/jlPCw2wk640x24fQl+gSjgUz4MgswKY05MUycuXAXC30YTmksG
         aPBg==
X-Forwarded-Encrypted: i=1; AJvYcCUMLqF6FDOqDB2bkEai707LTrgZzlMLgzdY2+TdeBthV1VVs3n7bJprwZ//VGPC7tGeIXlcgmE3LwF0vBk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8gnXmv0+RL09Hu0sTIPEwaIGuhc07lNaUoxfPYafEq0aTqfly
	Zv420LLZYw76+2DMJss3KKFiiCaOmIsiuwrKpXR3feNTgYWaXhCpHwVA7Whv8Jdi/3mb5kegTO0
	n3WuQn+yHh2CCXNj1AQZ52VGcjkc4JvfrCnQC+CJEJaGYIv7Aihwo4v3yEAWxzzI1XA0=
X-Gm-Gg: ASbGnctqRJvLEDAE7M8Sxg9bgMF2NET94PJchgNsvbshSxVdsFVHwklRlo4UIbSzrYu
	ddid4q9yrS+uOsAwHv1l7mSbX8torqh9MTDFWnufIK85IKLiHqZx0CQy1CefZrKcFkfXyCU4vxX
	IdInc6xCL/pt4qXsBPHpkvFIAqf3+/bUpQT5xqLm2Op1/4UGKjC4XKPKMYiHuVecOdwVIdzHprk
	pWEHhtqJx8LbkkPBf6jvTlBOvDawylY/W+sAoOS+L88yrGWaL873AsxP3+NpIwD5NkdFZHR5Mbu
	acIRCYUGQL1n6P2dJngZAXB6rHsZ34trWQqqUYtUc03IcyGmXEJUpxZQzaHtOsi8M8P8E7TRq5m
	zHyt5LQzr3MlgCtk7W5N+aBJ+e1wrxJ6VwPiBnMnfUADEa87aAkMsxtVjwPA//A7uAH4GDJF75m
	EAC6vSZVO6N8m0
X-Received: by 2002:ac8:7d8c:0:b0:4e8:a7d6:bc07 with SMTP id d75a77b69052e-4ed72628c9dmr18858531cf.71.1762303569088;
        Tue, 04 Nov 2025 16:46:09 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEWNMNBfUTT4rg1Cfryk8ANuc5CyRy+3uj/V1/C0sa5odRgWZsOoF8OUbkVS4NNLvdrFtR6wQ==
X-Received: by 2002:ac8:7d8c:0:b0:4e8:a7d6:bc07 with SMTP id d75a77b69052e-4ed72628c9dmr18858281cf.71.1762303568485;
        Tue, 04 Nov 2025 16:46:08 -0800 (PST)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5943443db22sm1174829e87.66.2025.11.04.16.46.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Nov 2025 16:46:06 -0800 (PST)
Date: Wed, 5 Nov 2025 02:46:03 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>
Cc: Vikash Garodia <vikash.garodia@oss.qualcomm.com>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Bryan O'Donoghue <bod@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil@kernel.org>,
        Stefan Schmidt <stefan.schmidt@linaro.org>,
        linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Val Packett <val@packett.cool>
Subject: Re: [PATCH v2] media: iris: Refine internal buffer reconfiguration
 logic for resolution change
Message-ID: <5vjvhg7xph34e5mg5q2yrytj6ugyokz7forfvhidjqhzta55st@uvgbfrvkzrxm>
References: <20251104-iris-seek-fix-v2-1-c9dace39b43d@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251104-iris-seek-fix-v2-1-c9dace39b43d@oss.qualcomm.com>
X-Proofpoint-ORIG-GUID: 43DEZAvx7AX0_XbNgcE6yl8ktCWq4xsK
X-Authority-Analysis: v=2.4 cv=MMFtWcZl c=1 sm=1 tr=0 ts=690a9e52 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=e5mUnYsNAAAA:8 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=ip-fXVA9LE2ppvREXl4A:9
 a=CjuIK1q_8ugA:10 a=uxP6HrT_eTzRwkO_Te1X:22 a=Vxmtnl_E_bksehYqCbjh:22
X-Proofpoint-GUID: 43DEZAvx7AX0_XbNgcE6yl8ktCWq4xsK
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA1MDAwNCBTYWx0ZWRfX2FKqFNhhNzk0
 jVicwIIz7yDbNTj+RPr8Ko0I6vkEKm18zclEVBPEbmTj1Y/JWFvhc1DMD9MMMd/LQ9YtqQu+J+k
 BInmqRRghfVzZjlM8Fi8864pMbBD5TgMEFKKKLvNMGGWmwTDGEUcoynGl5ytGnXcBZcXTmHDKJh
 YF9rLJlYN/irHEWpIUXH2X4L2NWtVvPvLS8w9Dv65mqq03xxUHZP+ijuCfC7LxUgvKkD8Z7kzZ6
 XEx3BLvAc/kkp8z7k3lHOZvatVYvXkIUqrIcyB2tZKf9HUK+bwL7ipnd+RrvxsWOPGhHLr7Ogd0
 633DPu+U3TnrgQK7ZG3+Hd8ViONyZG+1GEz//lpoav7v79+66PnxTPecXPS4i7Z5sdf4R2ngUJX
 HN4R1hrLRWvaMhQAuCrxJ/Rb2CMj/w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-05_01,2025-11-03_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 phishscore=0 adultscore=0 lowpriorityscore=0
 malwarescore=0 suspectscore=0 spamscore=0 priorityscore=1501 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511050004

On Tue, Nov 04, 2025 at 10:41:05AM +0530, Dikshita Agarwal wrote:
> Improve the condition used to determine when input internal buffers need
> to be reconfigured during streamon on the capture port. Previously, the
> check relied on the INPUT_PAUSE sub-state, which was also being set
> during seek operations. This led to input buffers being queued multiple
> times to the firmware, causing session errors due to duplicate buffer
> submissions.
> 
> This change introduces a more accurate check using the FIRST_IPSC and
> DRC sub-states to ensure that input buffer reconfiguration is triggered
> only during resolution change scenarios, such as streamoff/on on the
> capture port. This avoids duplicate buffer queuing during seek
> operations.
> 
> Fixes: c1f8b2cc72ec ("media: iris: handle streamoff/on from client in dynamic resolution change")
> Reported-by: Val Packett <val@packett.cool>
> Closes: https://gitlab.freedesktop.org/gstreamer/gstreamer/-/issues/4700
> Signed-off-by: Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>
> ---
> Changes in v2:
> - Removed spurious space and addressed other comments (Nicolas)
> - Remove the unnecessary initializations (Self) 
> - Link to v1: https://lore.kernel.org/r/20251103-iris-seek-fix-v1-1-6db5f5e17722@oss.qualcomm.com
> ---
>  drivers/media/platform/qcom/iris/iris_common.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/media/platform/qcom/iris/iris_common.c b/drivers/media/platform/qcom/iris/iris_common.c
> index 9fc663bdaf3fc989fe1273b4d4280a87f68de85d..ee377131c8419c434c85ec8e4321db39bbdecda0 100644
> --- a/drivers/media/platform/qcom/iris/iris_common.c
> +++ b/drivers/media/platform/qcom/iris/iris_common.c
> @@ -91,12 +91,13 @@ int iris_process_streamon_input(struct iris_inst *inst)
>  int iris_process_streamon_output(struct iris_inst *inst)
>  {
>  	const struct iris_hfi_command_ops *hfi_ops = inst->core->hfi_ops;
> -	bool drain_active = false, drc_active = false;
>  	enum iris_inst_sub_state clear_sub_state = 0;
>  	int ret = 0;
>  
>  	iris_scale_power(inst);
>  
> +	first_ipsc = inst->sub_state & IRIS_INST_SUB_FIRST_IPSC;
> +
>  	drain_active = inst->sub_state & IRIS_INST_SUB_DRAIN &&
>  		inst->sub_state & IRIS_INST_SUB_DRAIN_LAST;
>  
> @@ -108,7 +109,8 @@ int iris_process_streamon_output(struct iris_inst *inst)
>  	else if (drain_active)
>  		clear_sub_state = IRIS_INST_SUB_DRAIN | IRIS_INST_SUB_DRAIN_LAST;
>  
> -	if (inst->domain == DECODER && inst->sub_state & IRIS_INST_SUB_INPUT_PAUSE) {
> +	/* Input internal buffer reconfiguration required in case of resolution change */
> +	if (first_ipsc || drc_active) {
>  		ret = iris_alloc_and_queue_input_int_bufs(inst);
>  		if (ret)
>  			return ret;

After this line comes manual writing of STAGE and PIPE. Could you please
point out where is the driver updating the resolution in the firmware?
And if it does, why do we need to write STAGE and PIPE again?

> 
> ---
> base-commit: 163917839c0eea3bdfe3620f27f617a55fd76302
> change-id: 20251103-iris-seek-fix-7a25af22fa52
> 
> Best regards,
> -- 
> Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>
> 

-- 
With best wishes
Dmitry

