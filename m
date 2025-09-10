Return-Path: <linux-kernel+bounces-809674-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E62B2B51091
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 10:09:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D295A3A79C7
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 08:08:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A637F310635;
	Wed, 10 Sep 2025 08:05:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="WKy+c70t"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B7C630DD3B
	for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 08:05:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757491538; cv=none; b=Weqb47nDxrdvQBd37eXIvwdetuAZ4LO5ok7jZvfP4ajc9WN2/LcML3TgHkUauodQpY/waPyirqsRU9eeFz4TqpomGTRyPzfnYJaI8KexBkHFbHCoHLkwfEFtpiptl5TVmkhTL0taS9p3X/m8JZ+h3A8L+wJmJ2od2q83bph49IA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757491538; c=relaxed/simple;
	bh=ySbA2sA/2khOOpH2bz6CV6pqwbh86FHJpVx+tx+Cv/k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XZ2RgdNEMNsqfO7NtLmwSwbVvdJenEaXWTCZXouDfOMgMvh/QRWcbZYlre+3ofsmggHi/rodoRp14dTkf1KoywleCBj2pNa0+wdAN48LYYXjcWm9PoSYPHHw1aJk1Y5N5BvibHUr1Hv4dvf9p26XrMYe7grdunrlCutK/LGbQMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=WKy+c70t; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58A7cl0w023096
	for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 08:05:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	XYaeBpAktxucT5u8cP6K6PPyq3Cmk7hqCqU4GrGeJiQ=; b=WKy+c70tm3Inh/q2
	E9pT6dbBplwbEmHFziyVUXXyfjA51xiaLojEPOY6oL6CYb3M/kv1bZPDGyr6hqta
	qU6VNFfrub2z0V2ooxIzAXzJqjfcQ2p1p/IQBq1BuypVa9IA4TSDOlfhX6fyx7Hl
	kJ/Em4OhN3leMM4g+c43OLItOJW2qqjoNCWm77jAWWQkJ+BAxgya3DbOrwFBrR3t
	k+xTzWb72X0oXc7d/bHRJ+luiij5EeB7kysruUuzd/nDN6CUMa1BpYyFJLy1O82M
	9S6MOxlPSrij7bzSoM6yCByp0bbA2mJk29RYYWlIYI4pFu7WN5h6lWKZRx2OSsYF
	30K6jA==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 490dqg2w66-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 08:05:36 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-32db3d5f20aso1076478a91.1
        for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 01:05:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757491536; x=1758096336;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XYaeBpAktxucT5u8cP6K6PPyq3Cmk7hqCqU4GrGeJiQ=;
        b=WO7J4E0Y2fEThDiSt5NG76jQot2go06qzn6s572YSI4cmcy/uDuO1wJmPuE7e5yp/q
         8p/M18hvE48m6SVhKuvul6+KmKvsCSzb5p8HJx4d08363RF4HiPfODrL2HEMzR7B8+Vc
         T8b2PZVKflh0HN/e/PB03a0Q1J0dGQRjdOc9DDVxc26xzRkmBKPUwITy9a7phg7CTMtX
         GeaMQ1wtaLU3XH/mO9af1+x5W5LDF1vzMSTJFb6G21VzYGPegdy/ep2Ci7AdxPhB086Y
         /SGu+AgE3Z91GTCgInm+1v19JqifUafq5oZUkRA7VzP4WUlvb00VwBF8Lli4iILsBwgE
         PPww==
X-Forwarded-Encrypted: i=1; AJvYcCWRtafLJ/+Wajne3XCIy/Wc9dSQ5T0PXphKtGE9JoNKVPUQnxu4ys8Eu4Rhh+FJXkEIGyfSMDAH4Y/pHPE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzjQzWFv3OAdMMXxw+IvM02QaeA6iYBPFsMZ3f3PGpwqk0iQ9vj
	qA+URTog3iGKtRBs1pJwC+aHArF1rKRnpbJJYxBuxQAERyC16n+EG0lCKY9O1K6EjYFg3Xnv5bX
	ZfQX+omMaSpIzAh4brzqJye4s3Cxx4S1M9nAP7v6ZV8E2sZPVccUPWEdoZ/9zejKgMf0=
X-Gm-Gg: ASbGncuFExLY92X3yxo9piCoF/GZLwfXc6+CB96J5pu5Ijrt0LbAZ6EIGIwh06DBzqm
	MbiwlC2aMgCBGeII1DLXpfoySsvT5rf1YMNJr8E9RFdCqCHCVLrqLU8DZiWr1eXTG/iEAJJ7OpV
	Bswe3QPCiE+hWUTFq/YuqH2j3FOeBqJDESwH0UzmL4XTfXESB6k9Nd3HCFQt/6NMaWjsHHk+GzH
	l8zl6ZXvna/oB3qHLD8AR6DkJbKp3nIdBOjoZNP9l7l6sqJ3VRBCtz0yKwg7maRSZ4s6tyZJ5ci
	KGBwsT/Meo5Y+LyXPZlBID2uaqSug53f9/X+aX+X5ghyFz2RhOYMVHkPVW83AxzoX7lhrFwtY2S
	6dA==
X-Received: by 2002:a17:90b:2790:b0:32b:95b9:3eb0 with SMTP id 98e67ed59e1d1-32d43dfeba4mr20454141a91.0.1757491535177;
        Wed, 10 Sep 2025 01:05:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHwpBIFx5Xpby4qmNhy57ZfSegfbBowNYPbtWU+5wKfhmtUyGL3qm0r094IiFctzCJY6Z+uaA==
X-Received: by 2002:a17:90b:2790:b0:32b:95b9:3eb0 with SMTP id 98e67ed59e1d1-32d43dfeba4mr20454097a91.0.1757491534672;
        Wed, 10 Sep 2025 01:05:34 -0700 (PDT)
Received: from [10.92.178.42] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-32dbb5f3deesm1590684a91.14.2025.09.10.01.05.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Sep 2025 01:05:34 -0700 (PDT)
Message-ID: <abc66798-dc91-4860-b0b4-de39a58b5745@oss.qualcomm.com>
Date: Wed, 10 Sep 2025 13:35:28 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/2] ASoC: dt-bindings: qcom,sm8250: Add QCS8300 sound
 card
To: Krzysztof Kozlowski <krzk@kernel.org>,
        Srinivas Kandagatla <srini@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>, Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>
Cc: linux-arm-msm@vger.kernel.org, linux-sound@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel@oss.qualcomm.com, prasad.kumpatla@oss.qualcomm.com,
        ajay.nandam@oss.qualcomm.com
References: <20250905142647.2566951-1-mohammad.rafi.shaik@oss.qualcomm.com>
 <20250905142647.2566951-2-mohammad.rafi.shaik@oss.qualcomm.com>
 <43090acb-ea36-4015-b14f-78d44d789d42@kernel.org>
 <a9507045-b900-49ee-8841-0f8fd30816ba@kernel.org>
Content-Language: en-US
From: Mohammad Rafi Shaik <mohammad.rafi.shaik@oss.qualcomm.com>
In-Reply-To: <a9507045-b900-49ee-8841-0f8fd30816ba@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: 3YLRNvgDkgl_S4KfDO7mWOLIabPcugY8
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA2MDAzNSBTYWx0ZWRfX8qT84N/mw9Tp
 YtDOohHnEh/g37wlO5V9brhg73wnpkFb54ALydVMxZLPkIdfSk+Wami/vNoYffuJXu6rGcLYnRK
 QXbvPPeyIQvSvPQKdVOT1V42ZwTcGX56Ko/iQsHYG4kYmAlsmmtvl3RSVAh77LWFsiFYLAR7ZyH
 j6+jtPFZM1SerovrMX6efv3Ym7YMzk41GOF35lWHwvuKBBRXLSINd1Z23WHAUG1LNkE3Ub6B3Xn
 SUWPu0rEWBdFFrQFiPk7yaw0xfL39nr7a/0QjHaVBdNRgkwSyWiMgAgO8TeoShu2j6llTiCNl8K
 Nl0iX65OP7Y+CTRcH6LxP2Aiaw76inFWQRS85azbtEZ7raxVxmCwZ6c6WVpeiiTfN85M3qIbEuz
 fvjL0ats
X-Proofpoint-GUID: 3YLRNvgDkgl_S4KfDO7mWOLIabPcugY8
X-Authority-Analysis: v=2.4 cv=N8UpF39B c=1 sm=1 tr=0 ts=68c13150 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=8rL0g7Y-MTaYnKc9o8EA:9 a=QEXdDO2ut3YA:10 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-09_03,2025-09-10_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 spamscore=0 malwarescore=0 clxscore=1015 bulkscore=0
 suspectscore=0 priorityscore=1501 impostorscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509060035



On 9/10/2025 1:09 PM, Krzysztof Kozlowski wrote:
> On 10/09/2025 09:26, Krzysztof Kozlowski wrote:
>>> diff --git a/Documentation/devicetree/bindings/sound/qcom,sm8250.yaml b/Documentation/devicetree/bindings/sound/qcom,sm8250.yaml
>>> index 8ac91625dce5..eebf80c1d79a 100644
>>> --- a/Documentation/devicetree/bindings/sound/qcom,sm8250.yaml
>>> +++ b/Documentation/devicetree/bindings/sound/qcom,sm8250.yaml
>>> @@ -35,6 +35,7 @@ properties:
>>>             - qcom,qcm6490-idp-sndcard
>>>             - qcom,qcs6490-rb3gen2-sndcard
>>>             - qcom,qcs8275-sndcard
>>
>> So what is the point of this compatible? There is no user of it and I
>> think you added QCS8275 for this case exactly...
>>
>> Shall I start reverting commits from Qualcomm because you post patches
>> "just in case" and turns out they are completely not needed? No single
>> user of such code?
> 
> 
> @Mark,
> 
> In case it wasn't obvious, please do not merge the patch till we get
> some clarification. For sure it is wrong one way or another: either
> incomplete or just duplicated.
> 

The device tree currently uses qcs8275 as the sound compatible, and
the corresponding Device tree changes have already been applied and merged.

Reverting this now would break the ABI.

A new device tree patch with qcs8300 is currently under review:

https://lore.kernel.org/linux-arm-msm/20250910044512.1369640-1-mohammad.rafi.shaik@oss.qualcomm.com/

Once the machine driver and device tree patch with qcs8300 are accepted 
and merged,

I will promptly submit a cleanup patch to remove of discontinued 
compatibles from the machine driver.

> Best regards,
> Krzysztof


