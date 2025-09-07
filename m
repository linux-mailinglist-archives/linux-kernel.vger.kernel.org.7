Return-Path: <linux-kernel+bounces-804600-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 11D17B47A4E
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Sep 2025 12:00:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B775D16CC4C
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Sep 2025 10:00:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 371A423BF9F;
	Sun,  7 Sep 2025 10:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ROsvt3gP"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B75E7238C33
	for <linux-kernel@vger.kernel.org>; Sun,  7 Sep 2025 10:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757239224; cv=none; b=toGy+MA0ZLL446yxl0rCHg8RMZQB+aziT0jeV1LIYpER4zKLL3BsMKs4RAAUX3VD9uGax3W2LPobvLOD9K4nF1JSCxU6/yrn0WgTpYJZc/iV/F4k7Z1RZLGWLZKp2L5H8xebd6EsVHe5sQEFr0m6H94hDnSJIzXpJDs9nfMFt5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757239224; c=relaxed/simple;
	bh=JdRGVx4bHeaB9hxsshS++UJcE2XQe4YXg/1/cdY5kpc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gtp45A7eXFDlcScz2BtESHcDi4PQzGDt2gea/OLRAv0DJVIOm0cprMO3gnXF9BG6QqH5DGxYW3AvTU3AxZp85MIuv5osStFpurzvXufem9in1RmolyBVR/DfP1RyUF/bN7uSQXzaAmNyqiAvCTzz0R/T7KmZRP9jEB1GpqTX04s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ROsvt3gP; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5878w3br024585
	for <linux-kernel@vger.kernel.org>; Sun, 7 Sep 2025 10:00:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	qr3Czd9PwhhylBpPVieXHwCBf6HZ/rEjYpqLSCwU1MQ=; b=ROsvt3gPtum96m7O
	O+9R4aaL8zNmbnZ+R/3AfPkim2F6zAIbHwZq1T5fz/KNVz4e9KfKVXQhGVbESLb6
	m7iX3fXPgiMe59J1CbZJhtQp5nQ2hf7bdQDAWynMIqjnT+3Cq46IFcW+7f2ra7dk
	mUo3UwG1xETfod5qzQIyZpf+WCbg4V62gOa17zkTWQCjNDQv6boB/ojppi3UM1Y/
	/tsvSboIWkAaUBRpYUY5Tq/Sw3GyO8BTqLcQdIbgwTNWveXlCD76nMsoPc73uvVo
	kviLF5HEdr6HLO5uxptPcTtzMhPJhQ+PchDdTvJ4enNTGUcPsOwvZ45gWPjD5QYY
	o3K5ug==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com [209.85.219.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 490c9j2065-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Sun, 07 Sep 2025 10:00:20 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-718c2590e94so106224416d6.1
        for <linux-kernel@vger.kernel.org>; Sun, 07 Sep 2025 03:00:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757239220; x=1757844020;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qr3Czd9PwhhylBpPVieXHwCBf6HZ/rEjYpqLSCwU1MQ=;
        b=BywJI5mGArJ/QJd2OiQt7p6gNzpUXbea/w45iyB0yIhJU8pDaft/Rnbltfs7zBnVNy
         DS30M2+Zu/dUA41cdcXt1IIhFRq1bg5Y4PquHTOWKFkw2/PjJkMqjxttP+HN/3Ax9asB
         4Zu7I8YXCXGn8EUEgdTVE9w5Yay0R+2zDUqHX2p3mLliIj3d/I7+SCZh0wb8QRqKbHWw
         wt76xDMpuiNNSrU22X56yMIgi/bLZn/XES6zekoWq7MEhasu8Vqbr7pBrXYRwyquBD3G
         3F7+7sr/OfpKBDPtBe4NOzCWXOYb1ytl4MjEgV9yhbDIBlsHhUPbCUJP1LYai8BcVulg
         elcw==
X-Forwarded-Encrypted: i=1; AJvYcCU4Axac70vIEh0+P9jOPGGEUBu+dHtFTnGjY/rNpfvXhRyYf6ghaVfufz9rofMZrtCOWdjel/wh4hxzTGs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQsZI5SlS3jsL78m93qLp0f++StFo6crCWCOC7mmSlGfNdewGQ
	D2dUCYqDeYeP6JAug0K5r0gDobopbJdahZLGtO2j9brE2B+7Mo7m8Y5SSknEVoP8o0w/FKflHOq
	oiHty56lbuqxwicDwFT4ceI9pzeuvIADX3kYbJLWAPWf6CxuYe648V0/NO1IcpJ/4HOY=
X-Gm-Gg: ASbGncuU4xvr87kYWnxWi7b5Zam5/KN4lygmamPgHPDDRwUrMbICjDCWC97SBRyfUe4
	xt8YvJF3RlE256NtR9nz2U7nZ9VSojvYq4xaJudOtAY+ke6Sq+/dWuKUr853xybzX0uBVFDrVIg
	h2uAajw01Pv5zuTpWtYiPAjE1C+tQEpo6nnt4VnJFoa66QFkTfPGld9Wr45zilx6GiUwZXYox9o
	Qwq+Y5m4RJpUENTUowdQsKR3zGmB3H9X/4Ql6RfW9V4VZEFgvoMDjTwXpMPwgVNdt7o9fz3KEpx
	2MLkdrTAH/yBxutMcELewB9qlBIh2MBeULvZo1b/ZUq24B4qs9vdFN/8fqMBJHQT/cM=
X-Received: by 2002:a05:6214:2462:b0:70d:ae61:7ddd with SMTP id 6a1803df08f44-72bc5842ebcmr122738886d6.31.1757239219434;
        Sun, 07 Sep 2025 03:00:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHZRn6PmHHN0WVzaevPq6eNyd0NSdg9SA4KKI1yKwL5vha/Px9Z7l0N1LQNsS6IGy0U+cad0g==
X-Received: by 2002:a05:6214:2462:b0:70d:ae61:7ddd with SMTP id 6a1803df08f44-72bc5842ebcmr122738456d6.31.1757239218799;
        Sun, 07 Sep 2025 03:00:18 -0700 (PDT)
Received: from [192.168.68.119] ([5.133.47.210])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-45dd296ed51sm141015435e9.3.2025.09.07.03.00.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 07 Sep 2025 03:00:18 -0700 (PDT)
Message-ID: <899db9f0-27f5-4404-8357-4985e084ac99@oss.qualcomm.com>
Date: Sun, 7 Sep 2025 11:00:17 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/3] ASoC: qcom: sc8280xp: Fix DAI format setting for
 MI2S interfaces
To: Mohammad Rafi Shaik <mohammad.rafi.shaik@oss.qualcomm.com>,
        Srinivas Kandagatla <srini@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.dev>
Cc: linux-sound@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        kernel@oss.qualcomm.com, prasad.kumpatla@oss.qualcomm.com,
        ajay.nandam@oss.qualcomm.com
References: <20250905150445.2596140-1-mohammad.rafi.shaik@oss.qualcomm.com>
 <20250905150445.2596140-4-mohammad.rafi.shaik@oss.qualcomm.com>
Content-Language: en-US
From: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
In-Reply-To: <20250905150445.2596140-4-mohammad.rafi.shaik@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA2MDAyMiBTYWx0ZWRfX8SnvVX/qBM28
 yshSor8glYtJgeuisf5MPNLkleVXwZvo0AiywnkqAOhzWirWgdFNv7taSThTHFBVjsCviFOlqCN
 t6SqA9BvwiVCFtLzN2gNy4tMeIaHkYFQjN8KcgLwuhuQ0aTHC74HEbQ8OiHChUAtjaHYKfpwl/Y
 4UklA/GvQRLGPUnMAA42doBjHTPTcy+9Pvkz0EgsCrMKkCL1vBBj4J+dNNF80zEOODRFflE2sq7
 QDXuWf/vMtHjgJbcdsSdbu9JFSwSZS79AnPEnMucMoGehDs7B56sk25pT2XiVkuRJi9LwPYl+hi
 /7ZSq1ne0ExoqkRs73V3sW7fW2alHqw5PKcNstanqP3oFw1XK0REpfO3d73zv0h9tcd4WVXgsyt
 DmqezU6I
X-Proofpoint-ORIG-GUID: 9GSGiG7TiKVtPHRXVVcv4s5-LeS9CKdb
X-Authority-Analysis: v=2.4 cv=PpOTbxM3 c=1 sm=1 tr=0 ts=68bd57b4 cx=c_pps
 a=wEM5vcRIz55oU/E2lInRtA==:117 a=ZsC4DHZuhs/kKio7QBcDoQ==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=VTWOZG3uf4wZYCvkMeEA:9 a=QEXdDO2ut3YA:10 a=OIgjcC2v60KrkQgK7BGD:22
X-Proofpoint-GUID: 9GSGiG7TiKVtPHRXVVcv4s5-LeS9CKdb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-07_03,2025-09-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 spamscore=0 bulkscore=0 clxscore=1015
 malwarescore=0 adultscore=0 impostorscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509060022

On 9/5/25 4:04 PM, Mohammad Rafi Shaik wrote:
> The current implementation does not configure the CPU DAI format for
> MI2S interfaces, resulting in -EIO errors during audio playback and
> capture. This prevents the correct clock from being enabled for the
> MI2S interface. Configure the required DAI format to enable proper
> clock settings. Tested on Lemans evk platform.
> 
> Fixes: 295aeea6646ad ("ASoC: qcom: add machine driver for sc8280xp")

Am really not sure if this is a fix, because sc8280xp does not have any
Mi2S support. If you have added support for MI2S on any other platform
that uses sc8280xp machine driver, then that is the right fixes tag.

--srini
> Cc: <stable@vger.kernel.org>
> Reviewed-by: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
> Signed-off-by: Mohammad Rafi Shaik <mohammad.rafi.shaik@oss.qualcomm.com>
> ---
>  sound/soc/qcom/sc8280xp.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/sound/soc/qcom/sc8280xp.c b/sound/soc/qcom/sc8280xp.c
> index 73f9f82c4e25..3067b95bcdbb 100644
> --- a/sound/soc/qcom/sc8280xp.c
> +++ b/sound/soc/qcom/sc8280xp.c
> @@ -32,6 +32,10 @@ static int sc8280xp_snd_init(struct snd_soc_pcm_runtime *rtd)
>  	int dp_pcm_id = 0;
>  
>  	switch (cpu_dai->id) {
> +	case PRIMARY_MI2S_RX...QUATERNARY_MI2S_TX:
> +	case QUINARY_MI2S_RX...QUINARY_MI2S_TX:
> +		snd_soc_dai_set_fmt(cpu_dai, SND_SOC_DAIFMT_BP_FP);
> +		break;
>  	case WSA_CODEC_DMA_RX_0:
>  	case WSA_CODEC_DMA_RX_1:
>  		/*


