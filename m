Return-Path: <linux-kernel+bounces-845357-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 72CDABC4917
	for <lists+linux-kernel@lfdr.de>; Wed, 08 Oct 2025 13:30:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 650E93B3370
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Oct 2025 11:30:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 310AA1C5D7D;
	Wed,  8 Oct 2025 11:30:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Z7s9GJzB"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4FDF19D8BC
	for <linux-kernel@vger.kernel.org>; Wed,  8 Oct 2025 11:30:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759923041; cv=none; b=ru4RodMOXmQikZ9oHIiwTm00CwmDYezyR6syYiDKyTHzJcH1GpFLLpN9yZ57VE5BJMKitzp5+I7O/jjaR/M68ze/fNq/gYW0hl4GQHrEZwfJ3gP0BE8SLDOcPyAlsRuvcEpGxrYWUA0VnB75NKPvWNoCFiywAoLFnLxRcE0+qZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759923041; c=relaxed/simple;
	bh=nhpi83JznvSwAdgmbRAiGKVw0NVvV3h7g4Wp4+iFfq8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nMybMcdNWhqoiPJX02TRge3o2tLn0YoQUSvyft6Pci4vZxSRLNYw3jnlPc+Qo0yBcxbZ3RLdg9X2N9nMpa3p81BnnoQKe9UW4yNMzWucqkjgyaVOz9V7aKW8GQOjP53+7uXSIKxn0+Ce7l2e+PXAxVn6LJ282S4ILHnB6r/7e2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Z7s9GJzB; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59890Smu028975
	for <linux-kernel@vger.kernel.org>; Wed, 8 Oct 2025 11:30:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	p3dB7DImcsn8ypdPvXx1SaULRrictHxPEcCfKBFsYI4=; b=Z7s9GJzB3SROL95j
	yRJTCjmY7o2yEyJifMGqgDaUyzgnShW/E859p+/L0E58ut+i8Un84kHH0uI95iyq
	0dLBPAs39Tj8dw+nVyPJ2mWVrZEQLBOIrH6ZHImsUTkxsmLS8F3zMWODMdvb5ZaM
	+uqtIbcjl6uPTwen1Q15GxQROPMIqaTiVDtyNsXviZmN+m25oibmHiHS+Va/gYgk
	PgKXAg8zpvkniDb7epqCvZfDHNH2u1CQlXAak2emv5Jo5R6izijsajEFBdjJShTo
	wJz/0Cl8gWOfJb9GgTr4WD+KjSOgMD20dyIODfS92l7+0PKK9r+wzxUdendKIevb
	Hdwa2A==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49js9e2e0w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 08 Oct 2025 11:30:39 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-85e23ce41bdso173987285a.3
        for <linux-kernel@vger.kernel.org>; Wed, 08 Oct 2025 04:30:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759923038; x=1760527838;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=p3dB7DImcsn8ypdPvXx1SaULRrictHxPEcCfKBFsYI4=;
        b=IrTQ7RoJF0Lj5O7hUhWMScPF2qP9B2olabhfljCYwFTs08UHWN9FK7c7BgmPc2ATBP
         YuB9ShCERMFFFPcaBmGvSHnUZZoNG1shet8h7XRQKgdGpsdbyFFU8RlpkYwya/iqnH9U
         h1Clp4Icec3tL2hkTdNdva4YhSZ3jsZFqnq5KXaS2jRHYEpI/W35qyRLxeERDDnlf2Sc
         Ee3XGSNEPLHauD8K2+dfUn1cibKDkxrQ2X86iZkF4SLXNbuIEtTpzrCJdWqieDB6SYMD
         FSPP69mENokURT0k0JgQuLwwZt4mbEVTJf+97Aa8ES8jHh3v6OemHryD+qjrWj8/6/z4
         UAMA==
X-Forwarded-Encrypted: i=1; AJvYcCW7xFR/5F/5eN3kjw/U7pdubVxMJpRodmpk4b+2wogYNpXPYSzun2khWA9j8bc71Zu8OqlUJ2C1hEKWSkU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzko/08Nucss24FEmTPaaxuCY8FAWrgcJxRPC8u+DlPGj3S6hHk
	yzuKiM9w/IZO2WIUXsJEB6g89ARVDGfl5negjFyLJiJcsFLXfvnZejxI1PjAgiGNP/jlu5pFfiI
	lFSWQ5iE4smXEBmpZEBCNDRpKcPv/4OeTc4Ru6qzWb2rdcmy4428x8mzyaWrUSqKQDYE=
X-Gm-Gg: ASbGncuY6D4KYqGEa/VgjI/ZXeUoOfVP2iNFjL3SkGWcCQBb5vZoh53fvjuC+yRPkgd
	gWW6i3rrRrzsmGFsCthW7fYcufzQ5QIZ6NuSTXX/pgb6v5Lo8RmJOQI4q0fXCJNQHwiLCQmaJDO
	1DsHjIOlPBuhSiLCZNMlKsBQCfM3y//OBZz7cD2I0IqD1IionI4KCntzVx43Bb3qMSKBT1YVs0m
	dejNR8XMWTj9pH2JX6tpz/6Rm6lqy/0PpdNhmFSmnMo0nSpZMXR+JCBClNrJUhrJn9w4jfLsZss
	Z/UTFhod69xpvwHlPD0X3F7CdLv4KX0QPfYNOWwILZv7+MOu7jBnE0CZBlgVsuXjf2GTyw7KlOu
	jwspnPmw1QR3ef8MrP/kHGvRzZ64=
X-Received: by 2002:ac8:58d2:0:b0:4b6:2efe:2f73 with SMTP id d75a77b69052e-4e6eacd5b7cmr27615111cf.1.1759923037736;
        Wed, 08 Oct 2025 04:30:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF6uuOJkmzqkpWxNRJcrKpuJOzIOVtnFzI7SgSZotUMBOtnoIvLxg5u1HtsT32WaiX1nRyRuA==
X-Received: by 2002:ac8:58d2:0:b0:4b6:2efe:2f73 with SMTP id d75a77b69052e-4e6eacd5b7cmr27614781cf.1.1759923037299;
        Wed, 08 Oct 2025 04:30:37 -0700 (PDT)
Received: from [192.168.149.223] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b4865a83f5fsm1646099066b.32.2025.10.08.04.30.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Oct 2025 04:30:36 -0700 (PDT)
Message-ID: <7ef31348-78ca-4abc-9eaf-5041e2e6be82@oss.qualcomm.com>
Date: Wed, 8 Oct 2025 13:30:34 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 18/20] arm64: dts: qcom: kaanapali-mtp: Add audio support
 (WSA8845, WCD9395, DMIC)
To: Krzysztof Kozlowski <krzk@kernel.org>,
        Prasad Kumpatla <prasad.kumpatla@oss.qualcomm.com>,
        Jingyi Wang <jingyi.wang@oss.qualcomm.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        aiqun.yu@oss.qualcomm.com, tingwei.zhang@oss.qualcomm.com,
        trilok.soni@oss.qualcomm.com, yijie.yang@oss.qualcomm.com
References: <20250924-knp-dts-v1-0-3fdbc4b9e1b1@oss.qualcomm.com>
 <20250924-knp-dts-v1-18-3fdbc4b9e1b1@oss.qualcomm.com>
 <CAJKOXPfY-CpE_aKd910PQ2+u9ux2EvuVEt9ArzhdVCJcTQJUQQ@mail.gmail.com>
 <51637d37-aa5e-492a-851c-e5d6bfbe421e@oss.qualcomm.com>
 <43ba93bd-0dba-415b-8a7e-cdc4d954f79d@kernel.org>
 <392d2e9a-dc31-4916-ab8a-680b2ec4dca5@oss.qualcomm.com>
 <19639c5e-7aa8-4e75-812d-93d805802cd3@kernel.org>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <19639c5e-7aa8-4e75-812d-93d805802cd3@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=Hrl72kTS c=1 sm=1 tr=0 ts=68e64b5f cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=EUspDBNiAAAA:8 a=209rYu4UdfZk2wwxGmMA:9
 a=QEXdDO2ut3YA:10 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-GUID: opFPW1ICbsNY_CeLfofTInnWg4nJ4Le_
X-Proofpoint-ORIG-GUID: opFPW1ICbsNY_CeLfofTInnWg4nJ4Le_
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA0MDAwNCBTYWx0ZWRfX3ZRxm79Dxu55
 Qan3kz8fBBNMpJRHY/YzDIgtyPd6AZUkq+He8XNmsmm4gPyrPUQQhpd/p5C8ZWiIR0cex49TNmR
 fs5hvtn+NZ83hU9RONk+OQHLAZmzXp2/IX2ox9IIULSOv8zGOtOkZyT4yshWNkrF/0NV6vEW4cy
 4YU1Pex8kxSf8w1d6vsh2OYB3eSFemGfzO0HCPhcI5zardAxqiBANR1Mm8vynbSZP03tepCpqZ1
 pZA1cyO/LUTIB2v3KXoSikUUSKwIPgChoL6Gq0S23UD5rYLwgXFX7twrMUvS31i2KyiHuhRi9e4
 LCMf0Pwv1SzDlktJzl8qGE4HuNR0bT/d0X0cg6Rtl4lkHrfJ5pNN3PHKfF7c66eOS9fO+4T2T/Q
 G70JsKqlV3p/Rp+mNc7t2n4b6yeYFg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-08_03,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 spamscore=0 adultscore=0 lowpriorityscore=0
 bulkscore=0 priorityscore=1501 malwarescore=0 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2509150000 definitions=main-2510040004

On 10/8/25 12:51 PM, Krzysztof Kozlowski wrote:
> On 08/10/2025 19:20, Konrad Dybcio wrote:
>> On 10/6/25 10:48 AM, Krzysztof Kozlowski wrote:
>>> On 30/09/2025 21:06, Prasad Kumpatla wrote:
>>>>
>>>> On 9/25/2025 6:56 PM, Krzysztof Kozlowski wrote:
>>>>> On Thu, 25 Sept 2025 at 09:18, Jingyi Wang <jingyi.wang@oss.qualcomm.com> wrote:
>>>>>> From: Prasad Kumpatla <prasad.kumpatla@oss.qualcomm.com>
>>>>>>
>>>>>> Add support for audio on the Kaanapali MTP platform by introducing device
>>>>>> tree nodes for WSA8845 smart speaker amplifier for playback, DMIC
>>>>>> microphone for capture, and sound card routing. The WCD9395 codec is add
>>>>>> to supply MIC-BIAS, for enabling onboard microphone capture.
>>>>>>
>>>>>> Signed-off-by: Prasad Kumpatla <prasad.kumpatla@oss.qualcomm.com>
>>>>>> Signed-off-by: Jingyi Wang <jingyi.wang@oss.qualcomm.com>
>>>>>> ---
>>>>>>   arch/arm64/boot/dts/qcom/kaanapali-mtp.dts | 226 +++++++++++++++++++++++++++++
>>>>>>   1 file changed, 226 insertions(+)
>>>>>>
>>>>> Audio is not a separate feature from USB.
>>>>
>>>> I didn't understand this, Could you please help me to provide more 
>>>> context on it?
>>>> Is this regarding Audio over Type-c?
>>>
>>> USB depends on ADSP, so your split of patches into separate audio commit
>>> is just incorrect.
>>
>> No, this is no longer the case on Kaanapali.
>>
>> PMIC_GLINK is now served by the SoCCP rproc
> 
> Hm, ok.... so there is no WCD93xx USB mux anymore?

I see there's a WCD9395 onboard which has that hw block

I'll try to find some schematics to confirm..

Konrad

