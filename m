Return-Path: <linux-kernel+bounces-856927-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 54402BE578C
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 22:54:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1FCB15802E8
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 20:54:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26F682E229E;
	Thu, 16 Oct 2025 20:54:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="WoSA+VSd"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B98B8239E9B
	for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 20:53:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760648039; cv=none; b=ZslLpJnHEgsmJAlEuab7FWiO0L75ee6tOxXqzh4idQuAxQWl9beRG6E/eiAZZ7SpO6iJheyLcDN725ZxoHqzIpFLxXQHC/FQ20ZCozYyh4usda5svyVJwG11t9UerS674gfoX5XsjK3w5DOO9HQD3qIJn6556df15l/L/tBlQx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760648039; c=relaxed/simple;
	bh=Udrnr7zsByH6KLjxhsN87MtBRxRelXCMBoWGB9rkoA8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nLU/+ANxGKwNS7pZSnvB/sEHkIWQaF+dgTxSKa+xI9EskI3XPD7o6lPeQgk4/WJWleqU4zzVAeLoWT5w1MrtyyhiMdUvOWLOUpT6uxmGuOSf8QVmG/QGJ98JgMA8Ud9s+f7fvRj+eCg6RTk3yyoRCiymOCIriD2T7WMGhafpSFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=WoSA+VSd; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59GKLU6Y020254
	for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 20:53:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	qgCMtCx/K6Kh3F2qwSWRg2l/1DtLN3DnQEQF5tPebn4=; b=WoSA+VSdSjUJHnHp
	LjcPcFFX1wSHqk2aoYJUEQP7lqW9pIDqIup+8BYFRJM1NSOpU6iE0TDKrIXIYi0w
	Iwue59i5og604ngqx+vRxzLlREltlDMjI0Pj3j7Vc/GICCBCNA2BRITIz6NGy8mE
	X4hXDjABRaudRVl7ZNBRPpEyqTc2Tyr0Df7IBJZAxaOmlqMRI1GZxp6AnyJZgHGT
	mk+PyMjPlWBI4SoRR4zD0FKnZzTFtG2lZWJVQ3L01jfvz4zUd4q0oNKzbQJh7zZi
	schHlzb2VgvHN0aAKDeiGsWIkZrI+pmcPLMzdC3RMVVDy/EfhPBD1HpGe8UNDVEU
	fTfTQA==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49tqvpk47c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 20:53:56 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-77f610f7325so1100761b3a.1
        for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 13:53:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760648035; x=1761252835;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qgCMtCx/K6Kh3F2qwSWRg2l/1DtLN3DnQEQF5tPebn4=;
        b=jkQhHjzmi79c7If2S53UKmWZUBtsyEHPQ5McDgz3n0bJaq+56PPYjcISJvnhOeP7ZJ
         Vzp7Cwd8NKWC1dV2pvH6swE800nfNwe8sQoOzDfMQQpFkYrkc2ZNPrWFOQxHOijXy8Rn
         2FynuxsvB/iAJe4rLmDWsIW0ZC0qyuFOaEuZgKTfcJIV0sxg7d+SJWHm+n+azW4YcL9F
         aCH877IO0rBi41Db5VcPE2el+dDJ21/8QpUdvIEVWbHTBGb41UJQHBOjpB/Xw65DxF7t
         dh0P+3/aGwwdCSlkL1nQeX2qaawEtfalcN5fHD0UFEmGSEqDIycrEs5m4iUzW16UJdgY
         zy2g==
X-Forwarded-Encrypted: i=1; AJvYcCXov3P3XyMxdjxd6iLeF9j1hF2keIiGFnbf/8P8dnuxmSi0BHKuOLmSoaNNaVQV86HdmxbbU4cwp2HSyI0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwYc0toD0gaXSL/lUC56/qhe0WaKg4GnFDglQ3b257BGeXbldHp
	SuFMgtimXMfAUvn3Vsg3vvR8gy4fy0WTFB6mrvQWj5jdkzdbYq6W75CEGQmoIkIzW/UsPaV865n
	w2Pn3St3lQwqtp0mqmSex8rAwoun8I1SyqqXfH3p6s7jq4mDPmpUZVOFxtInxJeW4J5A=
X-Gm-Gg: ASbGncvp/mC3ssju9E45eGIR0saQO+VUBXvjQzmOe1fEts5IJOYhfGPEw+X5a+M1QTK
	pVVhlcwMR8QK28CcOaDyzoVyO1C3WEO65Sarba6hjQj997j5AMxn0IPDDlBdIH4xRNF4jqw8Vbx
	7eWM9BNO+/hgpZ4aCW+fUFXxr0+Inmv/YQdnFmZB8Zt19zRXFgtpV7dHZlBcymF5eC028OBeidd
	lnwSQty3U4R0AvPcIma/VfZmZYmVBerEgCA3qF1q5IV5Q8JxhFGH8K01XjFrGLTMzH1/3s9Uz1n
	8JRQUb0MOeLzCtMYiCRWQQodgRA+gAiEhGjgTxg7QSqgHq7aLar6DjWfmGc/2ETc3Wlvs7qqizp
	jHHoQQhccCAcoZufksGFYcvm7zPfhS1/gSmcRRXlS8iDGzqqohJw1rw==
X-Received: by 2002:a05:6a20:a10d:b0:334:96ed:7a75 with SMTP id adf61e73a8af0-334a857d68fmr1493395637.24.1760648035332;
        Thu, 16 Oct 2025 13:53:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE5mRGSF6MOY+KE8kOcpaayw5EGAYOyEe+RBAIZ8AS1gA8vmlY9wRA8SywCGt3c/wiwBmt+Gg==
X-Received: by 2002:a05:6a20:a10d:b0:334:96ed:7a75 with SMTP id adf61e73a8af0-334a857d68fmr1493364637.24.1760648034883;
        Thu, 16 Oct 2025 13:53:54 -0700 (PDT)
Received: from [10.62.37.19] (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b6a22bd473esm3767155a12.41.2025.10.16.13.53.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Oct 2025 13:53:54 -0700 (PDT)
Message-ID: <ab43c5c9-edc5-459e-8ef7-2aa8bec559c0@oss.qualcomm.com>
Date: Thu, 16 Oct 2025 13:53:53 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] media: qcom: camss: Enable setting the rate to
 camnoc_rt_axi clock
To: Bryan O'Donoghue <bod@kernel.org>,
        Loic Poulain <loic.poulain@oss.qualcomm.com>
Cc: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Hangxiang Ma <hangxiang.ma@oss.qualcomm.com>,
        Robert Foss
 <rfoss@kernel.org>, Andi Shyti <andi.shyti@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Todor Tomov <todor.too@gmail.com>,
        Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>, linux-i2c@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org
References: <20251014-add-new-clock-in-vfe-matching-list-v1-1-0d965ccc8a3a@oss.qualcomm.com>
 <9984bc23-05ef-4d46-aeb8-feb0a18e5762@kernel.org>
 <bc0caeb8-c99b-4bef-a69e-5ce433e6b890@oss.qualcomm.com>
 <c4fd6bfc-cc9a-4f37-99b3-f36466691a1e@linaro.org>
 <CAFEp6-2=GJL-gc+PSyAL4=prp_sXdZJS=Ewg5nP2kcp_Gu85Fw@mail.gmail.com>
 <33513b43-f6d1-4c76-887b-39611a75e1f4@kernel.org>
Content-Language: en-US
From: Vijay Kumar Tumati <vijay.tumati@oss.qualcomm.com>
In-Reply-To: <33513b43-f6d1-4c76-887b-39611a75e1f4@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=aPD9aL9m c=1 sm=1 tr=0 ts=68f15b64 cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=GlW_DMp2rsBEHzm2z1QA:9 a=QEXdDO2ut3YA:10 a=zc0IvFSfCIW2DFIPzwfm:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE2MDAxNyBTYWx0ZWRfX0S3w76hcNcGc
 F7kQE94MWE3qq/4W08+tI7RDf/MqUMOPZ77VzkP2VUs4iuk2E+CQ9+tcYnPImr3nmfIXLM3d9Zq
 /Zq6ScGb8Up21P67pgyWdE8xS5VpTMgtN56mjP3Or4EuR9QJIc8cU3vAcv9O+iUPDK+89zKNzjA
 91m9sx6a0tyG30rx/u1eIO7GxiZL40M8gmI2PLF8EKZeUaaLj+ROVp2XanaFwHXSe83jwF93uCN
 //1SYirtuI3JaIYTxJWgLqNEWQb6iUL7cYsunLpleXhSvtU+mpLOzeKFEMxCGpCkhsP9Rmi2b64
 hsbK5YIwiRUfgJMI2yrNZtcBXFwe2xS5JcQJi32T/ELzSjy4287pRVp3BKHgbeomiviwnq4iMPz
 wuxVgZWVOjQg+TKyeodM9FfQVyRpkA==
X-Proofpoint-ORIG-GUID: waOTU4qcuf1HAdwt_jFdnX-ygXYxziEI
X-Proofpoint-GUID: waOTU4qcuf1HAdwt_jFdnX-ygXYxziEI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-16_04,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 impostorscore=0 lowpriorityscore=0 clxscore=1015
 bulkscore=0 suspectscore=0 malwarescore=0 phishscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510160017


On 10/16/2025 8:31 AM, Bryan O'Donoghue wrote:
> On 16/10/2025 13:22, Loic Poulain wrote:
>>> I'm - perhaps naively - assuming this clock really is required ... and
>>> that both will be needed concurrently.
>> AFAIU, the NRT clock is not in use for the capture part, and only
>> required for the offline processing engine (IPE, OPE), which will
>> likely be described as a separated node.
>
> Maybe yeah though we already have bindings.
>
> @Hangxiang I thought we had discussed this clock was required for your 
> setup.
>
> Can you confirm with a test and then
>
> 1. Repost with my RB - I assume you included this on purpose
> 2. Respond that you can live without it.
>
> ---
> bod
>
@Bryan and others, sorry, I am just trying to understand the exact ask 
here. Just to add a bit more detail here, On certain architectures, 
there is one CAMNOC module that connects all of the camera modules (RT 
and NRT) to MMNOC. In these, there is one 'camnoc_axi' clock that needs 
to be enabled for it's operation. However, on the newer architectures, 
this single CAMNOC is split into two, one for RT modules (TFEs and IFE 
Lites) and the other for NRT (IPE and OFE). So, on a given architecture, 
we either require 'camnoc_axi' or 'camnoc_rt_axi' for RT operation, not 
both. And yes, one of them is a must. As you know, adding the support 
for the newer clock in "vfe_match_clock_names" will only enable the 
newer chip sets to define this in it's resource information and set the 
rate to it based on the pixel clock. In kaanapali vfe resources, we do 
not give the 'camnoc_axi_clk'. Hopefully we are all on the same page 
now, is it the suggestion to use 'camnoc_axi_clk' name for 
CAM_CC_CAMNOC_RT_AXI_CLK ? We thought it would be clearer to use the 
name the matches the exact clock. Please advise and thank you.

