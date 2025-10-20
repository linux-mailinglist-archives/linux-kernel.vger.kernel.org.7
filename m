Return-Path: <linux-kernel+bounces-860929-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C6DDBF15AC
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 14:53:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5217C4E2693
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 12:53:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39C06313278;
	Mon, 20 Oct 2025 12:53:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="dgo10asf"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A17D02ED872
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 12:53:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760964800; cv=none; b=JE6CMSQR8jnKeph8P46c7CDG5JOrtXhiUW1PpuVJbjM80XnZI1BcW3IQVdPB9PJzas4CffQpHWfbPzfxGHAug0we3zflHSSCOcugZyy2G+xlzR485rlzZuWekYHcyV3tsxnvqTL5GCXTIG6k91iZ1JTJOuh/JV0QA0a0tQOtoAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760964800; c=relaxed/simple;
	bh=b1Ho41wPbtTkT4EBGbCu60ljlAVIsBmQU8YjFD4CUz0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ClVkkM7L/2LYiZcNII34r7TMQck127MYiTdoKAiw4coeeZpuoHppmk3UMvRtDRuAcbPpDXwNLSg8ZeIjACGAivhkaRZGcCaXyC4JjCBz3RCdUfEpD71qaJfJokE1jdUZGi3U9Q1TrgmdG0WRvfuFaQs0p34VoNXNXvG+15DY67k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=dgo10asf; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59K7vld0004476
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 12:53:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	EF+mB/bpa3oyIOPYc2W7+74/IY9ayvbAnqsJ0d+UfCQ=; b=dgo10asfv6ehTpQ6
	GPUZA00FWZy3SY8YQRLCV0DCmGaJMBlgNSkjdK4gs5z9fXW6YwDWUhiiZQeW/joQ
	//TSDT3sFm7j69wh/ga7DGp8WXjRg/wVxWQYEaOc2/F2CACObQL6Pc9PRFC6eLpB
	ZrlQB0EN7wIzAs6sEpsJkf2Fvki87uZfquFfpkamW6qVW2s6dEmSHkOGA2r5SSdp
	b7++T0eKWDVGaAU5OtwYBFzOxVSuJjyohD64EeaLS1MaxZIO3oSn4hXyYpZE/5WU
	r+VAtIzVn+G5L1SAlN85yIUtQooplbnd20CKBywLkdcV6oe+ELsW8a4lu5tyCY+l
	Smv43A==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49v469cq14-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 12:53:17 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-88e452b04d5so144055385a.3
        for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 05:53:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760964796; x=1761569596;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EF+mB/bpa3oyIOPYc2W7+74/IY9ayvbAnqsJ0d+UfCQ=;
        b=isyZktVxB2WrhQ71OZaz/q9CdAYjy3lpaDhIu2S89vPOXl00gz/+KqlwcCjp4IZfLL
         spLmRtEETXQFFbKGsmqnPOObOsz95DiOk3Wrt2vCeqPAIYp4fyZtUdECCWJ1M5VjlziC
         fNtGrYENCjWzJOyqqoJHX0VgSTmLcT1XJBWKRO8G9DWXTm+jLQ9lr2GPwFNfUbEvHL1h
         AY0sP53JCQcydxH/g18P+gOvcX0bxWndhK3HXjYXpwR0DRge1192+ZU59C1AzPQE4Vh4
         vlqN+293ciabHApEtpsiRb1ZdFI0c3WN7hSKfJOqr6SIMWa8/3hAyqm0lL2YpINxt7Ye
         MBng==
X-Gm-Message-State: AOJu0YzWGAC7j2Qo763sfNOGqmmdpSLYNz3aN7f2IgqkYNYGNoBhDbYt
	W3yOOamLtrbtdFM0vYHeXDFct4pEdzF2WfvNKNSf38n/FI+ECD6cQSh/1HfF7dPc9VgOeDdyVjQ
	evBQbwkxTbv1+++Y5a1K2XU18Uc8+bkiMDG+sAgsgxih9bp7c4WyPP4medq1IvAI57pI=
X-Gm-Gg: ASbGncvl3rEIxzOn2GqLA3mCQ4xt/HXaCeUzDp2lRTXiE5T5bREgRquQAy/u0MBpw/R
	ivc7ERN/SKjkx3lbWzDyqPWJUEJhZCDHbwm60NvZodKBUcQvvZyKkxC4mtkCpawGg8B/R1MwtGC
	mNVcT34RzFLGorGTBdHaHii0LMePFgIvIWTPE4SlGB9zI80JUms0zZae3OeraZomQxZQ50gAKWS
	0tPJGyTphcAUAip++JwS4NzYNtlzcmtys2uFlsSaqNNAoKZ4JX9Ln/mQpMLKXKQHLUtzHweXQga
	Zhtr/d9GxMYv1aJGc4/Pgookcpi8Sbv1yB8bB7jtrzSVO6k02WN4wyJlmQ2/y5o8G7DZrwu19g5
	O+xSYIOSwnTVogLymaMmaNWmZ5LyHWXLgDEi6AoqLtjauqrNXPBJSURp+
X-Received: by 2002:ac8:7f88:0:b0:4b5:a0fb:59a4 with SMTP id d75a77b69052e-4e89d204a5amr104645541cf.1.1760964796363;
        Mon, 20 Oct 2025 05:53:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGMUijr7zh7WDC9Ju5q9CPUNhL99y4KT2cXZBubsxI6OQ3z4vNYFwHW90nzecqKoXWsctT9TQ==
X-Received: by 2002:ac8:7f88:0:b0:4b5:a0fb:59a4 with SMTP id d75a77b69052e-4e89d204a5amr104645301cf.1.1760964795892;
        Mon, 20 Oct 2025 05:53:15 -0700 (PDT)
Received: from [192.168.119.202] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b65eb9523a7sm802235066b.71.2025.10.20.05.53.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Oct 2025 05:53:15 -0700 (PDT)
Message-ID: <9631ca0a-9944-4322-ab05-25b46ed27c07@oss.qualcomm.com>
Date: Mon, 20 Oct 2025 14:53:13 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/3] media: qcom: camss: Add common TPG support
To: Wenmeng Liu <wenmeng.liu@oss.qualcomm.com>,
        Robert Foss
 <rfoss@kernel.org>, Todor Tomov <todor.too@gmail.com>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
References: <20251017-camss_tpg-v5-0-cafe3ad42163@oss.qualcomm.com>
 <20251017-camss_tpg-v5-1-cafe3ad42163@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20251017-camss_tpg-v5-1-cafe3ad42163@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: gLx9Xg1GibKGGmzYrBZIiKsPy8cWB1qj
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE4MDAzMiBTYWx0ZWRfX0ZCR6N04GPau
 2l/6FmN1VN0kSD0WLMiv6/CQr54+Fi2OG8vIXlvvxzMQrUKZXlcPE0yAD8c1ITsZo05xQ66t8N0
 W9KY0hMJcy3gVjA0yNq2fsZCYshgBpE8GAz5hOnrTOknoYLoD0eOPewq77XbTFyTDpP8ZdxTZ/i
 8gi0r5XxnMgx3gqIknSQafnSoJQjTHSI7kvoqO6ZwTleyWuGY0Z4Ihb5kRM6LOibImbb/u/Ujz6
 pLMoKtFkz9UCheb4pmJRwgf/gDjQLPxNgvn/PpVWVGqu0vYJ01yvmXuRfVu+Ads5N5Pr4bHe5eI
 urMRvGVO3P/vTkedcQTVc2kFKS1ov312tSaWi2DjyfzK2wD3LeM1TVxiVOja7Q5qu5xsxtJTHcu
 dcs0DndBuGAMQDmI08ovxyYn4BJ49g==
X-Authority-Analysis: v=2.4 cv=U8qfzOru c=1 sm=1 tr=0 ts=68f630bd cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=Hdz6Az-7eOjHTHoZ_0EA:9 a=QEXdDO2ut3YA:10
 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-GUID: gLx9Xg1GibKGGmzYrBZIiKsPy8cWB1qj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-20_04,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 bulkscore=0 malwarescore=0 priorityscore=1501
 spamscore=0 clxscore=1015 lowpriorityscore=0 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510180032

On 10/17/25 7:06 AM, Wenmeng Liu wrote:
> Introduce a new common Test Pattern Generator (TPG) implementation for
> Qualcomm CAMSS. This module provides a generic interface for pattern
> generation that can be reused by multiple platforms.
> 
> Unlike CSID-integrated TPG, this TPG acts as a standalone block
> that emulates both CSIPHY and sensor behavior, enabling flexible test
> patterns without external hardware.
> 
> Signed-off-by: Wenmeng Liu <wenmeng.liu@oss.qualcomm.com>
> ---

[...]

> +const struct tpg_format_info *tpg_get_fmt_entry(struct tpg_device *tpg,
> +						const struct tpg_format_info *formats,
> +						unsigned int nformats,
> +						u32 code)
> +{
> +	struct device *dev = tpg->camss->dev;
> +	size_t i;
> +
> +	for (i = 0; i < nformats; i++)
> +		if (code == formats[i].code)
> +			return &formats[i];
> +
> +	dev_warn_once(dev, "Unknown format\n");

It would probably be useful to denote which format is invalid (i.e.
print its code or so), and _once doesn't seem like a right choice,
because the user may choose 2 different invalid formats and only
the first one would cause a descriptive warning

Konrad

