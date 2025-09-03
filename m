Return-Path: <linux-kernel+bounces-798155-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 82F8DB41A1A
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 11:32:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 015CD7B3D9D
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 09:30:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD5EE2AE66;
	Wed,  3 Sep 2025 09:32:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="c6N4G+q2"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5E9E22E3E9
	for <linux-kernel@vger.kernel.org>; Wed,  3 Sep 2025 09:32:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756891923; cv=none; b=dEsHAvvm505BAldhfb6/9PuKHPL/E+MjTiQxwGzTABNM5VHR6X7rWmiPz8918d4tEh8o0jtQM8azc72vYAfEn2PLNDZZ/P9E0JAc3BRdKWA0qtMvA7F8UVVNcQSDs3tbo/wBHtbeWG/upD5S4kRi+uZIsPBB/R1M3KPL3AyOiUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756891923; c=relaxed/simple;
	bh=f9dwC+mgX7pffl+TR2sx1UfCW1VDF+yFerQJW4M3mi0=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=fasiROnBR/KsQQqAnMhBqFl5Dh47xpE8ah+u4O7OXxattAEmefxOr4TLCPOk9RrqVh3Y0sSjKlG1Qe10t6pb3CO0yWJW0lJmZjqDiFmfSximUBob/FM1+r1NFLEZCqiQpEQdB+6FkvFECs2owfKqusiyIseuRA8RwRTG2hqPxLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=c6N4G+q2; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5831an15023422
	for <linux-kernel@vger.kernel.org>; Wed, 3 Sep 2025 09:32:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	uTJRGhJx/cb5W68b/kzmKsQxYzcRko2SczTJfWZS1Ic=; b=c6N4G+q2c/S/+FYG
	m455NKQjK4th6h+2LB9tRMsXdKqVmaLj0xs60eVQ6F0TeW/8WWe6u6x9tDfw1pB4
	pdLyfSZoCTiZ95zwn8ES20C6RBcQXpXn7FTA6FBVISb6iEIThFLRy17f5c7jcENs
	jjUZTQxT3h6TCcp8rxRGADqMxdpZuP447oBMm4/hqkxIwIlPyaF6D66GNPqahO8D
	CbJzHTd9NT2xn9xhHkV1Wf/4mQVWzwWDt7hID2g/a5RX4ed55JbGerFM5OoaFDDW
	UaTmdnnrgrGgG2jVLvBmNTtiCy3Kq9/zcFRLuv0OEwxKjbaqcxFfX+xm4HjYdrWv
	0B2sVw==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com [209.85.219.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48upnpb77r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 03 Sep 2025 09:32:00 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-71f2e7244c7so2763316d6.0
        for <linux-kernel@vger.kernel.org>; Wed, 03 Sep 2025 02:32:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756891919; x=1757496719;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uTJRGhJx/cb5W68b/kzmKsQxYzcRko2SczTJfWZS1Ic=;
        b=NbmIy+aHT6B8ykhxXt2b+4FU8aW3LDKnHQGxF8Yh+5u2BUoYBTxMC7/3BwkREmOW1R
         53RJaPMqarOWW19oFZLfHb5/8k2z2kRr4H+JpLpLtLvMlynN75LZS5tEP6Xj92vjzSl2
         oGVRjMVU2G7Q1qd2VKJyiq57O5FS050GGRbkFSQXx9FCfAdfTEz3S1nfRTMElme86H39
         8uy8I/5pqaaCalQ2OIOG50B+/xqZfR/BnvbFwdK8jc7HBTNLJ286hn6GY/hCk+Hx0648
         AOKNJGxOJy+YGwTQSTY8CdD+AQIuBXKbeU2k+9x2cmTKMEgEVcGX/N4Jc5Gs0aBKt+ww
         ijpA==
X-Forwarded-Encrypted: i=1; AJvYcCVByZhAEY8sqQD3SV8uzQtzHYickI+XgF4eRC/RxOq9KoXg6mrbnEpHs54nRvCMct5f0IbW6YKafpmWPeE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz13snT9VSw5/SbtXgjWqRP5ZlghGi3I1Ao5f9kDZk8fS1cNOtX
	ViJP+oPHiXuB7OJwyEpi4OCyQNZpuEjq+iQa3Lu8jC9J6PUG2nyT9rfbzPeSwiotVCSdYNX5lF+
	ZI4kH7ydMJ3zQdHkJMSbhspYrO982uOKR43QLtmp44JJ4rlyjFpsSEP+ysFfFCcw0LHw=
X-Gm-Gg: ASbGnctO3pzhMYfohz+gtGmdyGvU0oVK+G8/sPETa7vI2tg7h0oAQQQB5ejIwRQ7op5
	D3IRE5KSq4WhEL+o4qgqKHgsjcWVHfK5vT2gAbk0d/cyRPTBdQeg6qSJRenzdeZH8wQ23FbMZHE
	sE36RAdCt4F1rpAi7eZM/KPIYO7MR0mgBfC/QdPKrTKtMDEhDtDUWT8C3sPhVzuI0Hv31/jSc2A
	ZfKoQXuKgOU/vEUVhwBru1j+A+bHr06O3zhMsP8LspE3N6KWUZ2ljJs1X4t+qPrbn2s5tzpUH48
	ApcnJO1GupllJ6vsH2E3A0ONovnSrJOvMAJLqgpgcykT+d4ErmVel0cW1Q11gnRcEmQ54NN8n/X
	Akho2aHuuSxdhcIgg5eCIWA==
X-Received: by 2002:a05:6214:29ee:b0:718:93bd:f208 with SMTP id 6a1803df08f44-71893bdf258mr71701646d6.0.1756891919485;
        Wed, 03 Sep 2025 02:31:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH/DTmcbgLY9RBZ4w2iRzSeSUgH6/An2dVsN0QDNQK9nr/GKn1lX7eOnhkKaQl7A1U+RdSxsA==
X-Received: by 2002:a05:6214:29ee:b0:718:93bd:f208 with SMTP id 6a1803df08f44-71893bdf258mr71701446d6.0.1756891918980;
        Wed, 03 Sep 2025 02:31:58 -0700 (PDT)
Received: from [192.168.149.223] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-61cfc4e58aesm11242665a12.36.2025.09.03.02.31.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Sep 2025 02:31:58 -0700 (PDT)
Message-ID: <d2d01b40-677c-4ad7-9742-29a40082f40a@oss.qualcomm.com>
Date: Wed, 3 Sep 2025 11:31:56 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] ASoC: qcom: audioreach: Add support for Speaker
 Protection module
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Srinivas Kandagatla <srini@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        linux-sound@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20250821141625.131990-3-krzysztof.kozlowski@linaro.org>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250821141625.131990-3-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: 5QKTWcXMWHErXRI8iyhn0hn0y2ERSS1c
X-Authority-Analysis: v=2.4 cv=Jt/xrN4C c=1 sm=1 tr=0 ts=68b80b10 cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=KKAkSRfTAAAA:8 a=AFvlZMtuCSXtLM_4ds4A:9
 a=QEXdDO2ut3YA:10 a=1HOtulTD9v-eNWfpl4qZ:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: 5QKTWcXMWHErXRI8iyhn0hn0y2ERSS1c
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAwMSBTYWx0ZWRfX071B7SEMm3HI
 CBsOk3MWxl6fMp4SGGyXy5tJt9/0hf9XNYlKF8Ti09axDrDioklltEWQfs641WZgeEtZZUeiQoL
 Qdx0YHk8dvt0hJEQ3SsuqeLmVPtoaDSimIboOtbQhpQnpcF0mBcq+0E0fdkWJ3R2wESJOxxBjzP
 xSwO34dkHOpM3oak35YyKTpIuY6n5nfZTQhUVb6K0YwiY1oyFUAYIKeLJrQdTkYMxrZvNBcZwlW
 F8IfaHHbVQdfXNC/UFemDjtBt02h1lkfuvSN6B8kkMzwIS1+XSUosJzS14O2heaKhgzKnfnDijK
 nzujxYk3hIW9dgLNIz2qp/6D19scSQptsHJ31aoBspta5Mq3xYZNKFSuZoYRw7ru6JVwuAQOkqr
 CAvbTyYA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-03_05,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 clxscore=1015 bulkscore=0 impostorscore=0
 spamscore=0 phishscore=0 suspectscore=0 malwarescore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508300001

On 8/21/25 4:16 PM, Krzysztof Kozlowski wrote:
> Speaker Protection is capability of ADSP to adjust the gain during
> playback to different speakers and their temperature.  This allows good
> playback without blowing the speakers up.

exciting!
> 
> Implement parsing MODULE_ID_SPEAKER_PROTECTION from Audioreach topology
> and sending it as command to the ADSP.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---

[...]

> +struct param_id_sp_op_mode {
> +	uint32_t operation_mode;

"u32"

Konrad

