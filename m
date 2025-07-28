Return-Path: <linux-kernel+bounces-747340-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 48206B132BF
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 03:09:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7102F170CE4
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 01:09:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 279841684B0;
	Mon, 28 Jul 2025 01:09:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Kyth0jA/"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA7C272636
	for <linux-kernel@vger.kernel.org>; Mon, 28 Jul 2025 01:09:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753664946; cv=none; b=ah8PZdUSwCu3CyLIAVn7NHf1/jUH3evbTXIO3RABuNAhDrfwU9s9VMHGucEi/vPnnLHXBOW45D079m1kCPplumacRvXeGNg7X5ewjUCUik+0ET4nPNh21MYVWTUmiWjS7qZOlLpmavhpKsrwaeDh3w7YlBCrDwJIwAdI751N2vs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753664946; c=relaxed/simple;
	bh=FjK326jnHvjwFx808KFt5yd2WXN/sAEkFru3nBqH234=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cTblNKddgLPQyuQQ37B8XxD7x/iX/gI3EL3H+/cGBBTS16NBnZBq95fDAWwhQvl4LEKGlEuSNEVZcm6upmdSApPCf3Rc9fJXmVZZbgx+M//94QMvxJGYJWqctkeBG47nUiYeuQwJyPXjNSOCXRPLoKIt3H7VQidrSFHiB/3uIwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Kyth0jA/; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56RNAKQl002545
	for <linux-kernel@vger.kernel.org>; Mon, 28 Jul 2025 01:09:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	4+yvE7Zc9m9grQX8Who+7K4FyDxflGcLsbflzzwtT3k=; b=Kyth0jA/gnFttWj9
	JIXmsod7UCWDn1iTISYqHJTV123OhHBQ+Vs1kzCnSm5R3AU4dlFAes+bGSq61T1d
	GczUKUXSnqEEiKdvA4VDWiaMX9VD6uNBs6n2ikORaimTexAlbPAfBozQ90zcIAJ/
	tTOvyRLzZG9/SYJ8kpUWRNQAOW8uo07OzOPQs86nbjte1tWcknKnn4NcGDDdGo2G
	zZ4Dd5UftMtomtRz7uxcGBPXAqv6C1flc0LVZ3CTBNFnyhCpzWf6RahaF3buThXg
	CC0Ewav4diYz76BmTwr6ALD7b1Qifs7CwgpfuYT/ytFMQx2GRCS2JSbfMr+fWubC
	WIKtSA==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 484qsk2t3d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 28 Jul 2025 01:09:03 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-23fed1492f6so15720515ad.2
        for <linux-kernel@vger.kernel.org>; Sun, 27 Jul 2025 18:09:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753664943; x=1754269743;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4+yvE7Zc9m9grQX8Who+7K4FyDxflGcLsbflzzwtT3k=;
        b=avtkbZMG/gM+2ey6gIIGx3dA9I4nKR2eNeAFiOkdoSUY0je7Y9XlkkSoE0UF42RyfB
         9C6Lb5a2ds9Rn4M8HHXd+qpOqNf81G+1NjVgZWbLJ4jiwLp6UtjlqTOZyKPaKPltteMO
         EH4Na6wSeSim5GoLD9C6qKG1wFqTaDbPmMifGxz6GOieEm87EG5tQ4Be7m2p588r8E0e
         b9my2ckxCzcmufk5Ez/hAaB5fxx8oGN4CVlQgW46Zm0AwN26TsK2NJAru7m2wdYSAsUK
         GXQAxBIHenx0aUlnMmsnX6ApK9GwPLAfU3EPGtp8mbgGTkTPQ00uKxGCPwkOnZC80Qib
         AYmw==
X-Forwarded-Encrypted: i=1; AJvYcCUZL6axnCDU92jVkb1sDJuiPH6dnS3fNdN0thMgqtremSItBHjuus8wnahBt07YjgU74ZEWny7LBJ9W5WY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxi7U3v+nBDvOCE0obEjm6vhh/fJPhHLjT6mDnge9N5ax9/TYib
	ACSe4OsbXOXAUGIQyuFPnz9yVQjQjrwI38VhZi/JGg+ktOCaCm0SvFVi/k6eVMLPhpWn3VU4Zu3
	VNObDgfZQDJ4Uq7IA7KnTPszFZnjnKHflS6LA60dGDKISZrG4AvdAaYTMv5+LxETRxPQ=
X-Gm-Gg: ASbGncuYjARbzWM0JIXRMl/dn4f1FMWy1JBsHNR6geNQNq5265OCHkzVjpv2BdHaOjL
	tmsMaLREPDP1TBKJwS5Wl02zO21xJEAvh+XSJrRvUOmFxjgXcYUT52s1VZzsOIA3LWIl58UoQZ6
	T28dYTNCp+Hl0aQCg1A0kDxPRvx6BuilNIaPRLFEnYZCjF4Z8lSQeQ7S4EgbAyxPx9ATX+0w0tY
	Xx3hpGZaADsMosnSHyfoSNtxprl6n5t4DCOwo1LZ41egZA3Zr4O3FwK4nuGdvmzbVWQMtY4zBDs
	0SfS8mLteDppsx851AGVetyLmXoRyQg/m3PyZfF/ju857/cTl8iHv4K5d0kTrg73sBGmBfEb45l
	uDG+Q5XivJg/eyJBczFWyFYE=
X-Received: by 2002:a17:902:e541:b0:23f:8bcc:e4f3 with SMTP id d9443c01a7336-23fb30ab8bbmr165783235ad.32.1753664942911;
        Sun, 27 Jul 2025 18:09:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHYCOfj1YqosY7nSWEJrErxiJ8bZl5MREmTEz579acUrZUOuf481S+vvg1qLmm7Mee+b84wXg==
X-Received: by 2002:a17:902:e541:b0:23f:8bcc:e4f3 with SMTP id d9443c01a7336-23fb30ab8bbmr165782755ad.32.1753664942447;
        Sun, 27 Jul 2025 18:09:02 -0700 (PDT)
Received: from [10.133.33.67] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2401e95208bsm12447405ad.112.2025.07.27.18.08.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 27 Jul 2025 18:09:01 -0700 (PDT)
Message-ID: <c6f74d55-6ea8-498f-a05a-000599f93ac6@oss.qualcomm.com>
Date: Mon, 28 Jul 2025 09:08:57 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/2] Enable CTCU device for QCS8300
To: Jie Gan <jie.gan@oss.qualcomm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach
 <mike.leach@linaro.org>,
        James Clark <james.clark@linaro.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20250624095905.7609-1-jie.gan@oss.qualcomm.com>
 <c7cca483-f1d3-45b4-abef-ec5019ad57dd@oss.qualcomm.com>
Content-Language: en-US
From: Jie Gan <jie.gan@oss.qualcomm.com>
In-Reply-To: <c7cca483-f1d3-45b4-abef-ec5019ad57dd@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=KdDSsRYD c=1 sm=1 tr=0 ts=6886cdaf cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=gW6MYXlkPblPBwbZtHMA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-GUID: QNXN4_ZEp7msMswM43hA3KVByrzT62Hg
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzI4MDAwNCBTYWx0ZWRfX2AaTlcP1+0ap
 oIQsDhpIIvblWLeycYByFfBKuyG+AimC/F30hfGfmA5Joo0tDxyO0UNRsGTUCG/qSi7YlQNGRMQ
 v8pHOp/UCPIgIMj8gU2y4w9aZtNkM64z8CVNNduci2xqx24Vo0nNg8aTqKKcQ/8Na3UaJLnM75L
 ixQaD0DpdIe8ScvEw+iNZmzaDbFuk9QutVNBi5H9xyl03tajX41dhH6hQhxtiBkSNvFIkt97+KH
 fJqH//RLGGUb1j72Sxi6jrToA88vTvmjCavTH3Ypf8z0DmNZf0LpvW7DKRO650KHkzmDZcKn4AN
 4XZvDYV2ApQ9bLHdibOqIIwC6+scLDLnhj804WTxs4DUM40BasDgnLM2Al1WlrFq9qmN0wgBvXn
 WHpPRhkzrconjetG5sdiPLha2vtD0s+2+nukiwfSUonhljpf+YmgZS+zxQgwhqaxpblWNBcJ
X-Proofpoint-ORIG-GUID: QNXN4_ZEp7msMswM43hA3KVByrzT62Hg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-28_01,2025-07-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 impostorscore=0 mlxscore=0 spamscore=0 bulkscore=0
 adultscore=0 priorityscore=1501 malwarescore=0 mlxlogscore=953
 lowpriorityscore=0 phishscore=0 clxscore=1015 classifier=spam authscore=0
 authtc=n/a authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507280004



On 7/15/2025 8:41 AM, Jie Gan wrote:
> 
> 
> On 6/24/2025 5:59 PM, Jie Gan wrote:
>> Enable CTCU device for QCS8300 platform. Add a fallback mechnasim in 
>> binding to utilize
>> the compitable of the SA8775p platform becuase the CTCU for QCS8300 
>> shares same
>> configurations as SA8775p platform.
> 
> Gentle ping.

Gentle ping.

Thanks,
Jie

> 
> Hi Suzuki, Mike, James, Rob
> 
> Can you plz help to review the patch from Coresight view?
> 
> Thanks,
> Jie
> 
>>
>> Changes in V2:
>> 1. Add Krzysztof's R-B tag for dt-binding patch.
>> 2. Add Konrad's Acked-by tag for dt patch.
>> 3. Rebased on tag next-20250623.
>> 4. Missed email addresses for coresight's maintainers in V1, loop them.
>> Link to V1 - https://lore.kernel.org/all/20250327024943.3502313-1- 
>> jie.gan@oss.qualcomm.com/
>>
>> Jie Gan (2):
>>    dt-bindings: arm: add CTCU device for QCS8300
>>    arm64: dts: qcom: qcs8300: Add CTCU and ETR nodes
>>
>>   .../bindings/arm/qcom,coresight-ctcu.yaml     |   9 +-
>>   arch/arm64/boot/dts/qcom/qcs8300.dtsi         | 153 ++++++++++++++++++
>>   2 files changed, 160 insertions(+), 2 deletions(-)
>>
> 
> 


