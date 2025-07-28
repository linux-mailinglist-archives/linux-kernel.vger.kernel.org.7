Return-Path: <linux-kernel+bounces-747876-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A876EB1396E
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 13:02:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C4D4817B9C4
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 11:02:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE50A19AD70;
	Mon, 28 Jul 2025 11:02:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="frPYx53x"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61FD51C7009
	for <linux-kernel@vger.kernel.org>; Mon, 28 Jul 2025 11:02:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753700535; cv=none; b=iFdRwN+UYDIG5DOgM3ZJeNAQtw8NsHHwv1OvT8xh0KXcta2uLFvSOpPnF1LIhk4Ac8rm3GLBcULczB3vC78TAtcBSLSUqX36vNllvXcCGtVoi52kG0WOSDAgRrpsmAqyHJHC23IQM/61XQwGtqP6lxeHYLKAEy8Gy3xQbmbnGfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753700535; c=relaxed/simple;
	bh=QTMRuquNtkVF7801cvDRB8V3A6EINsz1F+qf1uDU7N0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HcfBiE9jj+4mu/wHh7iwoQXEb64slf/fnD5GfuUfMDxiGIukDJ6lAHWNBsPr4cGWH6NEWk+ooVB5ps3lvOncsyxLzV/luAl+EcZyVO39OieopD0KUdMNTWizD0me05fqjnxIefii/X0srvkNCwm1fGBWGz08bKWx12uTUd661So=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=frPYx53x; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56SAlNZS028215
	for <linux-kernel@vger.kernel.org>; Mon, 28 Jul 2025 11:02:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	tkOmERj2A/upJpeVadcUk/yz4v7zZx5u22OaAAkVIQ0=; b=frPYx53xW8xjyAwY
	iu3awnkfSND/Krjea0qeDHUldMRhw9jEwAazzOcP4RE6Ovbw45RrY6VDy/EdHhOU
	M09zEmmP+Xm3EjpePYMbRGqFtwM+K0SPQHot7TqHA6gcPDvb+jIOO5ue1fovYMom
	+XXbJ0W/njAJmmwTorqKzmtnVjYIJ+ZkNxItWA/Jx+MuOyuthG7OqvRXqhzZd63M
	RCAb+DFFF0g7oLWgAd+a3IaL2UmhvJztSVvOqkyQiCXmzM6WTJQkm/MrwAupvnNX
	H6Z0ZFbkMm6MeLsg1bvI1g3tif6JSivamMaJFP43mbLnOcSFyoHxJgJvDAdu00zQ
	0EveqQ==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 484pm2c9c3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 28 Jul 2025 11:02:12 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-7dfeacb6dbdso7430185a.2
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jul 2025 04:02:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753700531; x=1754305331;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tkOmERj2A/upJpeVadcUk/yz4v7zZx5u22OaAAkVIQ0=;
        b=ZqvIm/HfGgWcX4g/xC/KBEBY90nRcc1LI5gSvQgKjCjsjbBFp5bmbnv1Qh/5XkCvVx
         bO0yHPy6ElEdkomxj/52sCvTZzbKH4wN8PArI/F/6OknmDruQodJ/j8PE6zuXjRDTQIs
         skKkGaJgOx+Gip4ukWTmkOVar5XVwZB9pvw8+RBRXQ+0ldXrqFw7lQnBXlgq/BlJ+UIt
         eb8n/K9MX/SGfE3NFSe/BnzHQZBeew59LmGrDJymhkpi64RQJ5ksY5iEauHDvoco54Ef
         tkSKGIGLD9tWpx9KsmYjrM+y3P4WI1EIjdDcqWMWYPtRVKV0bEreJczNhXDmMBEgxJdF
         KxGw==
X-Forwarded-Encrypted: i=1; AJvYcCWMxUsmErSmh9JodtkipulBbXYIbzJXtH/wEpBAyqwKvz83SSMQ6H/1zMDwm9oE3Qs0uXu7Y83P7V0pg4Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJmx6uB1sQWjI0y1ASsD70hq0yBzV8AYFFUdq0/iPApu6d0HMy
	zrf9ieKJsjDgbHMYhbOaoRAj9+Bp8RfZxu5MOQW6CFspU5NvndvHhoSOZOhW3rhlA2+r5+/igZe
	Ji3dauUH9Ybp9fVJUpQXsVLE9BAWaBsPlDMDuJAvgcMBr1qLeM/wpiGOatKA0g4cbFEI=
X-Gm-Gg: ASbGncs8PZIeLbtugrl4FdMf2VGEbM9uFlpmDzBmLENULxN8iRkfiuihhY8ps6Dc6ip
	gl75Jw4LsisJoWdBvyEra8lnZc87mBQ+7mLoVDyfgyC6qqE3r/iJZOnfdk+c7bgIYV+ngjMGZ9C
	XN7v2491V3TooTIdQTLYHZLK3ZQGejRSDfHl6NDy90pCxE8bO0NvMfImKiPxZa9QRU7GjMzVAKR
	z1glBa87A+b006IkVP1eNYxUaXtZsMZsUlACDN2UwsVV2MSB/pZkheqnDsSmoK2efdX05uNAV/X
	ytFJVgxx67uaVqWr8sgkjbY38Kxxce1oIC5BV2f5U31hLwgTQDzh/GaDeY1CZV2j1d9RROFOedV
	ARDAnfHP3I7uoWQAVmw==
X-Received: by 2002:a05:620a:a00b:b0:7e6:3c4f:6e44 with SMTP id af79cd13be357-7e63c4f6e8cmr594470385a.7.1753700531142;
        Mon, 28 Jul 2025 04:02:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFUIgDqBhwTM69wrpR7rB+q9FoIvwjatH6qNVoaRQs0g4MWIANkOEW6KBTVIFmEb1l0QgxQIg==
X-Received: by 2002:a05:620a:a00b:b0:7e6:3c4f:6e44 with SMTP id af79cd13be357-7e63c4f6e8cmr594467285a.7.1753700530518;
        Mon, 28 Jul 2025 04:02:10 -0700 (PDT)
Received: from [192.168.43.16] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af635af3c15sm406076066b.127.2025.07.28.04.02.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Jul 2025 04:02:09 -0700 (PDT)
Message-ID: <dda5b873-4721-4734-89f4-a0d9aeb5bdab@oss.qualcomm.com>
Date: Mon, 28 Jul 2025 13:02:07 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] dt-bindings: clock: qcom: Add SM8750 GPU clocks
To: Krzysztof Kozlowski <krzk@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: Bjorn Andersson <andersson@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd
 <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250723-topic-8750_gpucc-v2-0-56c93b84c390@oss.qualcomm.com>
 <20250723-topic-8750_gpucc-v2-1-56c93b84c390@oss.qualcomm.com>
 <20250724-blazing-therapeutic-python-1e96ca@kuoka>
 <54b617c1-bd1b-4244-b75d-57eaaa2c083d@oss.qualcomm.com>
 <5b8d42d5-d034-4495-9d28-27478a606d62@kernel.org>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <5b8d42d5-d034-4495-9d28-27478a606d62@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: kCBC_liHfEfaEkBr48xTGZpvmuxExWjh
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzI4MDA4MSBTYWx0ZWRfX4RV3oqzZEZ71
 MYP7Q8Hs//Sw0UOuU84rLtX8fFQ4rQoGHL0bL0b619kXjEUsWewfSBXb5JQmXob61LZcG+aLbKA
 Qzl9mR9NXwnMg/QljSZgxv4f/I6AtbbfRQLeLUh5nD2zTV6g/FA0pW5wACuxpKiPAvEvpD7f2CV
 7CetY1FJ5kY5EaGk3cftnayk5eCgdCFzd/i7MalGkiUg/P9txEvCbL0mZFWsB9IO0lgGVrm3EkG
 ous6+6IpSJ5wEyfoL18Y6zmI9T4JwGIGhboJgen28LkYitZj0ctZ8fF9ZJLHAMYvirLTL9KWA35
 ztvIl+w9JSwCbGoBlX6Zs1/iW+pbN+h1Dg7i4fRG7C7bamRFSeOnKJ0ZVZIE7ma9/Br8CwUqtxR
 QJWF0wif3k6hk4vr5J+QPvza6lKTbGP3JhgAbYbahEKJdPdJiBmcm9v8GQCSW5E9dxlIe/L4
X-Authority-Analysis: v=2.4 cv=HfYUTjE8 c=1 sm=1 tr=0 ts=688758b4 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=N0DHfeS2NgGftJ_ZqQEA:9
 a=QEXdDO2ut3YA:10 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-ORIG-GUID: kCBC_liHfEfaEkBr48xTGZpvmuxExWjh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-28_03,2025-07-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 clxscore=1015 bulkscore=0 suspectscore=0 impostorscore=0
 spamscore=0 lowpriorityscore=0 adultscore=0 mlxlogscore=999 phishscore=0
 priorityscore=1501 malwarescore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507280081

On 7/28/25 7:01 AM, Krzysztof Kozlowski wrote:
> On 25/07/2025 11:30, Konrad Dybcio wrote:
>>>>  
>>>> @@ -40,6 +42,9 @@ properties:
>>>>        - description: GPLL0 main branch source
>>>>        - description: GPLL0 div branch source
>>>>  
>>>> +  power-domains:
>>>> +    maxItems: 1
>>>
>>> This should be a different binding or you need to restrict other
>>> variants here.
>>
>> Actually looks like this is the same case as the recent videocc changes
>> (15 year old technical debt catching up to us..)
>>
>> I'll send a mass-fixup for this.
>>
>> Some platforms require 2 and some require 3 entries here. Do I have to
>> restrict them very specifically, or can I do:
>>
>> power-domains:
>>   description:
>>     Power domains required for the clock controller to operate
>>   minItems: 2
>>   items:
>>     - description: CX power domain
>>     - description: MX power domain
>>     - description: MXC power domain
>>
>> ?
> 
> This is correct and should be in top level, but you still need to
> restrict them per each variant (minItems: 3 or maxItems: 2).

So I was happy about how simple it was, until I realized we also need
to poke the VDD_GFX domain. It does however not necessarily exist on
all platforms and I don't want the binding to become a spaghetti of ifs..

CX & MX is present on all(?) platforms
GFX & MXC's (any combination of those, unfortunately) presence varies

Is there anything better I can do than creating a separate case for:

* CX_MX
* CX_MX_GFX
* CX_MX_MXC
* CX_MX_GFX_MXC

?

Konrad

