Return-Path: <linux-kernel+bounces-800812-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 29F3FB43C5E
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 15:02:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8C2231C24D4E
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 13:01:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB896301036;
	Thu,  4 Sep 2025 12:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="HWXbA4T9"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB5972FE053
	for <linux-kernel@vger.kernel.org>; Thu,  4 Sep 2025 12:59:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756990786; cv=none; b=kXWVBW5KuwU4uXkyfVpm2lU5Z7YRqcKZb/1kI1z4pTGkspBT50vAU+QniLnLCAMfg3yhXJcb5mYC4zv9znOon2Qh1sNf3b42ONpHtfrtbLXVszxWWF7Qss8j/AjSLSF7cEnEaq1KVLbqVDQSVAvJ9EJvpKT9VskBu+WPLNeKrZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756990786; c=relaxed/simple;
	bh=HGRZFwd49tFfYWB9SUlChD9l0RfYHNSiyeeXd+GpDu8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FXAhx4gGl1EabCmwJI6BhF/BdqZuouftBj06Hg93JDtI6LK9cQP1vxUaN2KJSZ0vT+7iq4WOFlDhxe1G51OkS5jKK+KN2RvkDBtNMzfygGmPCv05G6n/t9+gJGFA/rlmRKSfMHgzHWWUeyJ4egZMWrEEHgyg5kzgpj1T03juYvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=HWXbA4T9; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5849X8OU012118
	for <linux-kernel@vger.kernel.org>; Thu, 4 Sep 2025 12:59:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	YrnPjMXXm4RKHlJrdtGIK0fP8Rj/KwUrIvqQDVckTVc=; b=HWXbA4T9cfiakpA8
	HMr9BVStDLMzpW8OsgkJHaMl7o/r7xsh+CTuF2qEQTbWkb1APsBypqyHZcK5N9X/
	rCsyzc+FL0no0pUxM1arWbG8Gy0D5l1wknfmNxIXaigwa8JsIRmlhdrANUwOyhAj
	teVXby0v9LPmhV+XOabManMLZBHH8rDgtBer0Zvo+8IklWQhp8iJchBxb1bDZUZc
	9u+ii7hDuom/gZI1poh4t7IxCBkM3+hVIkbb0Qz2pmE0ThOr57njPpB20C4iQcec
	ALN1WWiXsrpjQGRvkX96xbGsR+MyYaPvoylnn/RMywd9NVdbGHtxJx8NJcr/6ROv
	t0hW4A==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48xmxj41ff-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 04 Sep 2025 12:59:43 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-b49da7c3ff6so638805a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 04 Sep 2025 05:59:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756990783; x=1757595583;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YrnPjMXXm4RKHlJrdtGIK0fP8Rj/KwUrIvqQDVckTVc=;
        b=vD+BdnXUJr6TA0gILnXHprvimIfoUiA2CX1EacK0Rh7zZtFZTPsUPlNUvrokt8qI1g
         ulyzF8je2ehurHIRA2nYa5QM8TGC/w8w5Ysr1hRxxg/89QtMMwg3O9YcwiQbpsSlI6hm
         e5vYE4e7KMBTycb2qJoWH758dbtz6aJK28XlRTOfNWOsehaLAd475679LHCL4dROGmx1
         rdhag7HLmvhMXczh8h7+dE0hZgd70QN/UrCqwghwQ4CEg1m1SD+d11B0Vs5feQ6SZWiM
         vN1Ep1cImU8zv/p6TvyF5zKXg8NCIDoJiNyS2lQOMAvuPRakJoCECrRsmIHFHehiiUYB
         IBxg==
X-Forwarded-Encrypted: i=1; AJvYcCVfQXjKd+Ez6h63HOUlBz8R6kTL7cTrQCWd4nHzPXfTvBYky3jNVQEfMC9Mf2yhRbna1NlyDrCxEVKVq/U=@vger.kernel.org
X-Gm-Message-State: AOJu0YzOtLzSfILylzRRCf/RA1isOfAPGdKZbByRspi+CEWdR4X+m7e2
	HVx9/eGTQy6Dh0hnVsjr7cebJumMmmObG3J07SxLLVk1fQ4p9rIfM/Sj2rIv3D3DkUPg3b9DSEb
	HoTt7sLcHGgL4Uwscpbh0CZ3dqvsFcz8S3uLnpB69FVDoh/4aQAnZJutdzJlulo06XJE6QmsvHp
	A=
X-Gm-Gg: ASbGncv87WawWbore2mLmyfV0AtXlxue+YSacd2z3FT5TW183dwMVIDiDLLKt8zAFOA
	rq01bgfBJSy6LAbd2gZsZWiqFAJ2lonXcqLzIwkWDaXH+74zoO5rpOc6l5wx6IxxdjdTPHSMn8V
	uwkreW8kQ5ILIQUAyAest+jKAVUA8uCR31zosG0u5gTaaSkMig+OSQewQWY/rSGBFBQtlKMrkYY
	rOzB0SkikcrU99kb45K5YmAJwRGZpDHglBaccUkR9h/uaj7ldLpLp109MCjY8AZVeqVcJkO2WSx
	6qQhLD6nlA7heAO6AUv30B2F8ZMHG3Htg9HTk+FYCJxO2YPU9wgBgFEJR+ywDFgQqsteggckFdx
	VZ7EgL5KlL4Ar/4CCy0tuPElyJwoYgnRms1joSsKNy6FHhWRDMpQhTAKU
X-Received: by 2002:a17:903:2441:b0:24a:b86b:fc4d with SMTP id d9443c01a7336-24ab86c16a0mr194843225ad.22.1756990782922;
        Thu, 04 Sep 2025 05:59:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEDs555ipRvC1ST73yAjE3u8OV2Q+43GBd/Kx6p1J0zf61ODiAveluuSUk6VqxqWJkCV5TZJw==
X-Received: by 2002:a17:903:2441:b0:24a:b86b:fc4d with SMTP id d9443c01a7336-24ab86c16a0mr194842835ad.22.1756990782410;
        Thu, 04 Sep 2025 05:59:42 -0700 (PDT)
Received: from [10.50.21.161] (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-24c829d9114sm51930465ad.57.2025.09.04.05.59.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Sep 2025 05:59:41 -0700 (PDT)
Message-ID: <6be45464-0b54-4fe7-aded-96d6c7d38da7@oss.qualcomm.com>
Date: Thu, 4 Sep 2025 18:29:32 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/2] dt-bindings: pinctrl: qcom: Add Glymur pinctrl
 bindings
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Krzysztof Kozlowski <krzk@kernel.org>
Cc: andersson@kernel.org, linus.walleij@linaro.org, robh@kernel.org,
        krzk+dt@kernel.org, conor+dt@kernel.org,
        rajendra.nayak@oss.qualcomm.com, linux-arm-msm@vger.kernel.org,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20250813065533.3959018-1-pankaj.patil@oss.qualcomm.com>
 <20250813065533.3959018-2-pankaj.patil@oss.qualcomm.com>
 <bdfb09a2-0053-4a07-85d6-5e15b8bc126a@kernel.org>
 <d35s5ldfswavajxkj7cg3erd75s2pcyv725iblyfya4mk4ds4g@hekhirg4fz65>
 <bbf60240-4d84-47fc-ae35-483e55968643@kernel.org>
 <hxwrmoyik5bzgtxufw2trjwz5oqn7jut5wsej4v5xqdk5ho6hi@jic2xbti5jn6>
Content-Language: en-US
From: Pankaj Patil <pankaj.patil@oss.qualcomm.com>
In-Reply-To: <hxwrmoyik5bzgtxufw2trjwz5oqn7jut5wsej4v5xqdk5ho6hi@jic2xbti5jn6>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTAzMDExNyBTYWx0ZWRfX4ZfRAi3+whTX
 JZMTd8JCF+utyzTahOtKVby+LYUv5/armN1UN8yRAxeT8KK/NJgBAfSMuyqHpKFNMPZGmRklqM8
 1Y8xorMb9LKl6lipaNKrazVAxZp3s5a+GGzQ9lhOWW1f6+7BhC4S2tMdp68KEsmsRVZY+euEVg3
 giszLX7MTnIe3clNmSTtrnSg9qMkmQPxxjNsoZGCNnQHUtCjC+Xu2p6+gK4T/GKjSGGIdjwx+J9
 EvfLU7lCxZOtwfrjc2DeLoCHljBShdaiGrNGIRarGkJZm42ZFZpvKRSOD104pE6CNlA56lu5X4z
 FlopdEbpMxH0FTRy8whPjkCaq1bKb11uiRqDd517ugxXX9nkHZx6WuLTs3TKM+ht6oe6V0PN04V
 uiP3E1CA
X-Authority-Analysis: v=2.4 cv=a5cw9VSF c=1 sm=1 tr=0 ts=68b98d3f cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=tCOUNiJIdlxrdUxpUMYA:9
 a=QEXdDO2ut3YA:10 a=x9snwWr2DeNwDh03kgHS:22
X-Proofpoint-GUID: cxeEi7tTayXc-oK6aGsSxWFWk_Np8pZj
X-Proofpoint-ORIG-GUID: cxeEi7tTayXc-oK6aGsSxWFWk_Np8pZj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-04_04,2025-09-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 clxscore=1015 bulkscore=0 priorityscore=1501
 phishscore=0 impostorscore=0 adultscore=0 spamscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2509030117

On 9/3/2025 5:52 PM, Dmitry Baryshkov wrote:
> On Wed, Sep 03, 2025 at 01:28:43PM +0200, Krzysztof Kozlowski wrote:
>> On 03/09/2025 13:01, Dmitry Baryshkov wrote:
>>>>> +  interrupts:
>>>>> +    maxItems: 1
>>>>> +
>>>>> +  gpio-reserved-ranges:
>>>>> +    minItems: 1
>>>>> +    maxItems: 119
>>>> 124, I guess
>> ...
>>
>>>>> +    properties:
>>>>> +      pins:
>>>>> +        description:
>>>>> +          List of gpio pins affected by the properties specified in this
>>>>> +          subnode.
>>>>> +        items:
>>>>> +          oneOf:
>>>>> +            - pattern: "^gpio([0-9]|[1-9][0-9]|1[0-9][0-9]|2[0-4][0-9])$"
>>> If it's up to 124, then this pattern is incorrect.
>> So 125.
> I think so
>
Pattern is for gpio-line-names max items which is 250 [0-249]
I'll update the gpio-reserved-ranges max items in the next rev

