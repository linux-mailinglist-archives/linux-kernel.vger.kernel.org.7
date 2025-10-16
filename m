Return-Path: <linux-kernel+bounces-856103-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BA67BE315B
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 13:32:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4B7EE5042D2
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 11:32:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC51F31A7FA;
	Thu, 16 Oct 2025 11:31:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="JxQ/3mQo"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DBDD3203BB
	for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 11:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760614263; cv=none; b=u+SmIteWMdfmqyqcT3IkZvrcvETEEUS7sfA5dpr3VRV36+yL+NpCFhL5+G09ZWoje83aaHRDQUdjuW8zyJJo5yr04jMk86VcpAPHa8lPMwqBkRwaw5ZAQkHTaWG7Oi8qlI94KubPjrX9xhocXoLo+HuKnsqI98pU52wdgMLq1A0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760614263; c=relaxed/simple;
	bh=MQYL3NqvOxkDXPW1F/Y50YQmsakcGgmXXf7C3SN+7uw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LkWM2ZLwuiKi8TqMxIxWXQHWzsvyIhMrOqvKeIwale8FQ73jghxleE0Te3dpb9URSF41e2rvMNomjJOMN1r8A3ohLasXDnrtw7KxQG5J4hTrUuWOAn3q1/CyGaW95AjoFlfFjBq0W7QxSMnWv+OOX49rpF0PcMa6bBLumoCELiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=JxQ/3mQo; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59G7rLko002559
	for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 11:30:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	3r81d4YusFHYu/ym3wjxA+mceYkkZtl0xDn0GBFN3Ls=; b=JxQ/3mQoBcIzo8mK
	p6Ok8qLnoc1XZ9YE5BT4jmfoSVq6re4PEShhVnRr4Ju/s8wpf7EYtBhqKpIrOban
	AaM2xnO6OwV/mDdZ8/FdzQ5lwkYihps/Ojb3YO19LPWVTsaDokPgjr7+UB1JuXuB
	xMTWcaGeA5dOzfUsrk2qBw1oF74r4oCGF6gO+T4+HBUDrPLFdx5Hg5Es54q3eKky
	b46iRn4mVru0IOO3OLc6qvhFuu14Iyrj4Fb8VKkmYP2YW+GRVK5SynFHt3hD4Pfj
	av8+ZOC5qAPTzFCsr5Fx8wurffVysXWvlmHlFXvcYwmS13+BTi8rXSZ/1p2nmfES
	sIqBSQ==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com [209.85.219.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49qfa8g561-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 11:30:59 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-850553dfef2so2487066d6.0
        for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 04:30:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760614258; x=1761219058;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3r81d4YusFHYu/ym3wjxA+mceYkkZtl0xDn0GBFN3Ls=;
        b=kuSZEfN7z77XerNVeYAc2VGW1JHl2jX8fYpA7BLNdhAnF8CvnQRqSVk+5S2uS6UnL4
         sRbMTPEXfKjNCdrfrwk1IljerVoeIF73/o1t0e2x5WLsnIktS6Ihm4Ysqxu77pGU1qVV
         z+L8r/mzcdTeA8FLLurMDjlUT7XZGX4WVroD3GPKfqdPdYRtU5plrjbAWV7StbmXPhGE
         0vaDZ64ilaxvQi4OiBMTWyLFb3KbRHmIwi0OYz2RnFNeksfVQC+ky9X7A19SQtNbyu6o
         7kDBE83sjDvTyC6WS0LiRoW6rRHs+7x6hUxa8di7tOSF91tFmW2uoGorvY7bfq7RwT/1
         DU8A==
X-Forwarded-Encrypted: i=1; AJvYcCWhtwGFsdBVu6wnGrQV/T/gAhei/tF+XAw9FeuYyfmKf07N3MhHRZhWkpIyIlRQ7Ugo9Prd/xM7OXC8LFY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzpW9vbAMut7G1SrwsF4bD3U7VAQCcOwRm2TiNhxleSQNG6cypX
	HXgRhZ6DQ95wo4MAgi0aMHVZhQqs/tlqVYaHcaLWzuESgghjjNcvwPdOA+uQUOfnUg4E+gL0N6a
	PbvKomFD0Z6kLrUdmWWCkCQQk+nackCgZGu2H5QGLhO9IbgegacQlAbgAdm1HXJco8YM=
X-Gm-Gg: ASbGncuY4a5A8p5lZCpV5so6YM2VeJn3RFFaOmWL0ogCKWHMjNPYABKPbIF7ZMqNVqx
	ZsgC1uszuzw5qoRJM+8M2IYnxXw6Iiv2ObLmwImzybwrcWgw/0doKUNd3ImDeyIYgRNmjMRm6tg
	SvjOb1B1dZbVnDmBFAeZ8t/9zxPni5NQUvCyyAxqCkgJuW+WhEXB/MIs2RGiZbdyU53RzP97hV3
	Fb89jgdRT4ZhBbtr6Td6chCdZXbbQ/fdmtyRl8RWHuargUDXmwv3UjVq4eGKA6KVhc1bSsoS8Hs
	tWXbUEM9XVmuNafakXtX2NTj77dTNNZ+ra7Gg6CycRdqdcva98LQw1gZ7DuwLwi1ubvQ7jSeRm2
	CAc7qEeHrYRjiCRMTYEOOVLSHnTatEUsQRHW/np7PL/JIwwbWHjTHuN3g
X-Received: by 2002:a05:622a:14ce:b0:4b2:b591:4602 with SMTP id d75a77b69052e-4e6ead2c674mr300272751cf.9.1760614258037;
        Thu, 16 Oct 2025 04:30:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGQWo8LtrsilfoDkj8zqUn2LLSGLFdpY5oWuNZtrX6Xq2eIwSXcZU7XpjJTwnWEYu+0reTT4g==
X-Received: by 2002:a05:622a:14ce:b0:4b2:b591:4602 with SMTP id d75a77b69052e-4e6ead2c674mr300272231cf.9.1760614257381;
        Thu, 16 Oct 2025 04:30:57 -0700 (PDT)
Received: from [192.168.119.202] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b5ccd39f1fbsm487237966b.70.2025.10.16.04.30.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Oct 2025 04:30:56 -0700 (PDT)
Message-ID: <bc0caeb8-c99b-4bef-a69e-5ce433e6b890@oss.qualcomm.com>
Date: Thu, 16 Oct 2025 13:30:54 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] media: qcom: camss: Enable setting the rate to
 camnoc_rt_axi clock
To: Krzysztof Kozlowski <krzk@kernel.org>,
        Hangxiang Ma <hangxiang.ma@oss.qualcomm.com>,
        Loic Poulain <loic.poulain@oss.qualcomm.com>,
        Robert Foss
 <rfoss@kernel.org>, Andi Shyti <andi.shyti@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Todor Tomov <todor.too@gmail.com>,
        Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Cc: linux-i2c@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org
References: <20251014-add-new-clock-in-vfe-matching-list-v1-1-0d965ccc8a3a@oss.qualcomm.com>
 <9984bc23-05ef-4d46-aeb8-feb0a18e5762@kernel.org>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <9984bc23-05ef-4d46-aeb8-feb0a18e5762@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: n2Dssja86lfvJ-XwYVhmkT642oqna54j
X-Proofpoint-ORIG-GUID: n2Dssja86lfvJ-XwYVhmkT642oqna54j
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDExMDAxNyBTYWx0ZWRfX4bfqDCR3Mjur
 yhGHk3oQjf0lReJja5IwDAb6WFad5o5d8CVeNQ4pA/kNYxVANy/FbB9xj2O6BEWROm9BbnJBMVg
 XtcVEI4BIBQKiaD/u+cnKX0kaiwsXRnJbNuyfn2lrcVVYpjftykj4d8QEn0yzFHaoN/DByKSbiV
 YxDyo8T1PoFCIOjy0UZQ/SSi6rUdI5pHNmPUuZNEdbAjuOYTd9YgJYsH34O5j/MmWlk25J3IxXo
 ddeReCUUALMGLdbtNkJRFLT8wz3WzXdsKPNxedqsl1uWDVG+QoX5O0TU/3nitg2Yrcxzf4j/nKA
 gAJstML2mFrZFb51l6diMtBfUg1Xk0HhRHUnqrZvWV6e7zjojQBE1f3dZ4dzD3oAasTBSzGppOU
 G4VL7Utmufzjy3pcoLPSmz9DabZQMw==
X-Authority-Analysis: v=2.4 cv=JLw2csKb c=1 sm=1 tr=0 ts=68f0d773 cx=c_pps
 a=wEM5vcRIz55oU/E2lInRtA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=_kPKrX3CkssKu2g54qAA:9 a=QEXdDO2ut3YA:10
 a=OIgjcC2v60KrkQgK7BGD:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-16_01,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 phishscore=0 adultscore=0 bulkscore=0 priorityscore=1501
 impostorscore=0 suspectscore=0 malwarescore=0 spamscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510110017

On 10/16/25 7:54 AM, Krzysztof Kozlowski wrote:
> On 15/10/2025 04:43, Hangxiang Ma wrote:
>> On hardware architectures where a single CAMNOC module is split into
>> two, one for each of the real time (RT) and non real time (NRT) modules
>> within camera sub system, processing VFE output over the AXI bus
>> requires enabling and setting the appropriate clock rate for the RT
>> CAMNOC. This change lays the groundwork for supporting such
>> configurations.
>>
>> Signed-off-by: Hangxiang Ma <hangxiang.ma@oss.qualcomm.com>
>> ---
>> This change lays the groundwork for supporting configurations for
>> hardware architectures that split a single CAMNOC module into real time
>> (RT) and non real time (NRT).
>> ---
>>  drivers/media/platform/qcom/camss/camss-vfe.c | 3 ++-
>>  1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/media/platform/qcom/camss/camss-vfe.c b/drivers/media/platform/qcom/camss/camss-vfe.c
>> index ee08dbbddf88..09b29ba383f1 100644
>> --- a/drivers/media/platform/qcom/camss/camss-vfe.c
>> +++ b/drivers/media/platform/qcom/camss/camss-vfe.c
>> @@ -914,7 +914,8 @@ static int vfe_match_clock_names(struct vfe_device *vfe,
>>  	return (!strcmp(clock->name, vfe_name) ||
>>  		!strcmp(clock->name, vfe_lite_name) ||
>>  		!strcmp(clock->name, "vfe_lite") ||
>> -		!strcmp(clock->name, "camnoc_axi"));
>> +		!strcmp(clock->name, "camnoc_axi") ||
>> +		!strcmp(clock->name, "camnoc_rt_axi"));
> 
> Just use camnoc_axi for both. Look at your bindings - why do you keep
> different names for same signal?

I think the correct question to ask is:

Is camnoc_axi going to represent the other (NRT) clock in this
setting?

Konrad

