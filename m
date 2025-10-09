Return-Path: <linux-kernel+bounces-846560-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 49B95BC8591
	for <lists+linux-kernel@lfdr.de>; Thu, 09 Oct 2025 11:41:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A5C2E4F8D28
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 09:41:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D52372D94A7;
	Thu,  9 Oct 2025 09:41:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="dLuQV1FK"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C02C2D73B9
	for <linux-kernel@vger.kernel.org>; Thu,  9 Oct 2025 09:41:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760002879; cv=none; b=cBEGaMMKWvMW4IqMMMrMZJE/tYJvf5woz3HDWgIJSXCEMaEjqRddN21PeBdbNF0sOwmcBG0Ru5lv7LuJEqZR8Z4cyYLVoTPbOOB4Mn+t+SNPm/KhVqMGRaiPHwDvVSt2pzWgmYrpi5mOmkE4yjP9BrDgUYjvXa8RkQ4kHe6n97g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760002879; c=relaxed/simple;
	bh=cUHx9qgZFQYGZ/HN+MbTOeqQQ1J5kKxuW1Jd5pKcnEM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hQ0UoH1jv2XzLzXKDy6DLJ9fck5RWqzJgsAHRZgGegBbpwybDC0iTOeXnsebGiC1lneqpx0FJ+EpBUxWRmvYvH25G554xaGEfkAqDvl1DB3mBmRwVcbqVOC6qUcYSLks6LRObENt1GjVJ8gLHc7RXNoWOhAP22qfM92xICc3Jr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=dLuQV1FK; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5996FSmk006842
	for <linux-kernel@vger.kernel.org>; Thu, 9 Oct 2025 09:41:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	HifFETgbzrd86Mja8ubAMcZowhzvoZfzV3gSLqhMB/k=; b=dLuQV1FKz6rJlEi8
	k482NDgHQgwX1JIVXe+T0mgfdWCpEFVuAGd2P8FeMYvcHlMaJfFx5PYX5kHWEIue
	DZct4qToTOiZDO1p2AxZGJd3ghTiPu1fCudxHu5V9c701yuHKv9s100hftyyKxXC
	DoKav/eeZ4AAxV0B0i/e/ir1WFeorOlCSAF+EzmcrSp2BPe4yH5aHiAoE2YiZgcQ
	bw/k7GWFrmvV6FNtRl4U8RdgzIFDguMtvE82QsQeZSPtpRPIOADvH/fcW66aibcr
	jvD3EvHVJzJGY9QpmqqEQ0EGmG0e0QvlSE67ubfHEuCcfy5GKGOV40zPRfzuGemZ
	igSZtg==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49nv4u29kp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 09 Oct 2025 09:41:16 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-819d2492a75so41768685a.1
        for <linux-kernel@vger.kernel.org>; Thu, 09 Oct 2025 02:41:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760002875; x=1760607675;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HifFETgbzrd86Mja8ubAMcZowhzvoZfzV3gSLqhMB/k=;
        b=CJAemrhB9W+n+X1KaTnGCXFgCEfEPjkH6/3UZmq7XmKoGWdxBnSs/gDzqfY9s6k+MT
         Xi3lRSfF8FlEMvUoTuiTXbS/mEe/OseruXENIG6l0c1AszjjChsIGL9+ozxwmrk+YLac
         7Ai7VB7izxW5zVAj/nO+vg1p0URoGnRZ5xd3AdZmGYiQmGx3PXWMYV0d+T8rOunQVNv7
         +mLEz99tvxLyiBfttFhUqaagpSHzf3gC62UYPtL2DTPugHPSgVSIMZx1kHQWDMFLNweR
         Mb6sKPo08YLdixbINeNagy6ATQ4kyJMgYmwp7y8SB+QH7g5Jxp2U/V+GFJbz4hulALX0
         582g==
X-Forwarded-Encrypted: i=1; AJvYcCXI28tCDIHNCrDqaP4miQza4ywEQWaRukCFZRSwCdulrH+X3qjSPQdcJk/nj6BtIdEydnMHPwjA7h89Amc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzE7MI1aK6E4Hq7jfQLCSeCkefOXV/RHDaP+O6qyY4p4719EMTX
	X2wfsUJuQfKgJqh4KeruxXhW73sz34OZjaYucg0Arju2DUmAk3RAjx7FonViTWBdO0wz6vwWwhO
	vSgQwcxgcshj0i+7dEs/NtxfwjwBYNcCLlv2I/w/ijyuwLa+rmf/ic7Nl7J5ekG7Aecc=
X-Gm-Gg: ASbGnctrDrm290y7QT57cnj4w0eE9Hrh6api1Bwz3qtA0GskDmOUfr15M5J9FApq1uX
	+mZ4g9IiGGxy56SbajuRiWznvYxjH2U208smtZ6cXbccwyAkANBdkrOpduI95TRNqjd6NnJKCE+
	uiacWmZipCejU1XLGWQprxj3HpF7WDvOIDrf0zwKCyvZkS5Yh+4Xskp3kO+KGyjOiSDunHw5YTN
	7sZoAVbQkgMCeH04ZSaIj20IOCK4ru2hLnyAjYVfbMonV3yGzduJmi6l8KRm6dn2/qfQKW9TIhk
	/6sQefMoWmqHafxAEl0173M7PrQ0kjba2k+nl6OJXV8VN9jq8nsWJt033Y6H9tk1AufGJE5Nr6E
	ZMKYPAIa7lIEp1G3s6Awc8QVGRa4=
X-Received: by 2002:a05:620a:269a:b0:7e6:9e2b:6140 with SMTP id af79cd13be357-883541153abmr646448485a.8.1760002875418;
        Thu, 09 Oct 2025 02:41:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF9TW5+PphA9Jk49AdyjnYbWQHthAzam3yq3zLm797shLwnfsPjaDRo3Y89qy+Sz47r2yOFPA==
X-Received: by 2002:a05:620a:269a:b0:7e6:9e2b:6140 with SMTP id af79cd13be357-883541153abmr646445885a.8.1760002874779;
        Thu, 09 Oct 2025 02:41:14 -0700 (PDT)
Received: from [192.168.149.223] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b4865e7e8cdsm1867720966b.38.2025.10.09.02.41.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Oct 2025 02:41:14 -0700 (PDT)
Message-ID: <630bb2b0-0ab4-4083-96a2-9aa485041797@oss.qualcomm.com>
Date: Thu, 9 Oct 2025 11:41:12 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v2 3/6] ASoC: soc: qcom: sc8280xp: add support for I2S
 clocks
To: Neil Armstrong <neil.armstrong@linaro.org>,
        Srinivas Kandagatla <srini@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-sound@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <20251008-topic-sm8x50-next-hdk-i2s-v2-0-6b7d38d4ad5e@linaro.org>
 <20251008-topic-sm8x50-next-hdk-i2s-v2-3-6b7d38d4ad5e@linaro.org>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20251008-topic-sm8x50-next-hdk-i2s-v2-3-6b7d38d4ad5e@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=Vrcuwu2n c=1 sm=1 tr=0 ts=68e7833c cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=KKAkSRfTAAAA:8 a=hmOrbv2CecBtpEyMAQYA:9
 a=QEXdDO2ut3YA:10 a=PEH46H7Ffwr30OY-TuGO:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: UaYGNfoQ1oFO-KIML2c126wgCXMWbD_M
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA4MDEyMSBTYWx0ZWRfXwVimMpz5LBU3
 wbmVHwqIeYJbRukpCz6S5bWjwb9mRCxbz6Ww7LmoEebpGCH2WYAYv0nJ80iI5e6pmC318eXJFFO
 ka/StS/AdJvjgHE0g+/6jq1hqyEvo/rcOkZF13cjBLr6LGcbhfxdNWPq9P0wqh59If2+YjMABhQ
 RgZcFPhrLtCThkoUmey80X2scYm/4aq4InQJNRfxDvB6PyELxCjGrOrcTa4QB8vL/R8QVjpiQiz
 Z1GFFkiqo2oUjVgmiI8EXM2Q4LsnGwZRmbiG0JUO6UMYKscI8BpNwVIiBoSaML36Bfh1sgSfEGh
 2ic6kSoNdhgQjaqT+i5dWPKBnPeFmGFx/mWtr82hm4bmmpUef/IXSlLcvOACWDMaewGWdnZPPzv
 F4B04xYCXBhUn9mxdY8Asd1A/Yhx3g==
X-Proofpoint-ORIG-GUID: UaYGNfoQ1oFO-KIML2c126wgCXMWbD_M
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-09_03,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 impostorscore=0 clxscore=1015 adultscore=0
 bulkscore=0 spamscore=0 suspectscore=0 malwarescore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510080121

On 10/8/25 8:56 PM, Neil Armstrong wrote:
> Add support for getting the I2S clocks used for the MI2S
> interfaces, and enable/disable the clocks on the PCM
> startup and shutdown card callbacks.
> 
> The rate can be easily calculated since the card forces 48Hz,
> 2 channels at 16bit slot size.
> 
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> ---

[...]

> +static int sc8280xp_snd_i2s_index(struct snd_soc_dai *dai)
> +{
> +	switch (dai->id) {
> +	case PRIMARY_MI2S_RX...PRIMARY_MI2S_TX:

I have mixed feelings about the range syntax here.. it's only 2 entries
per and it's quite error-prone (no errors in this case, but it
encourages the thinking that things are always contiguous)..

[...]

>  	switch (cpu_dai->id) {
>  	case PRIMARY_MI2S_RX...QUATERNARY_MI2S_TX:
>  	case QUINARY_MI2S_RX...QUINARY_MI2S_TX:

whereas e.g. here we see that it's not really the case, but it's
tempting for someone trying to 'clean up' the code to change it to:

case PRIMARY_MI2S_RX...QUINARY_MI2S_TX 

and the reviewers may not catch it

Konrad

