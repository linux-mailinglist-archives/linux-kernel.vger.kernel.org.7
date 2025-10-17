Return-Path: <linux-kernel+bounces-857081-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE738BE5DDC
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 02:16:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 134D35E5B12
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 00:16:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7993D1FBC91;
	Fri, 17 Oct 2025 00:15:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="NFJNagzG"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33C951C2BD
	for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 00:15:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760660154; cv=none; b=GLnnkgGKMfaD+bcZXmirZojm4633w44IVLPl0bP7hdRyNvTH96YwRac45+FQDNAEWiBZYoULgfX8uIP3HZXE4LyABF0fHlgjXP1hdBikBMn/WBOM+aE+KiIiK4RRqH76uWlaL9twh1clPhC2rewUmflVuz8BUwmnZt2YXRFVDWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760660154; c=relaxed/simple;
	bh=dO4zPO78xPFJZCKd6Pi8qyXAaa2Q2Zu6U74fmgX7mkw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=chZelKLPO4S0JoO60VZ08ly2BM+fH63YpBaySooBNCEILTTBvx9EcMW8wZDU/IXsfzFm/hTz8UCIM1ENI84UMDgYS1UWVMLeHTFT/i2HqOd8SV2n02xamBwfwnkGXsJvqpsQjWmo67+NGZR8B1kSW+gHbJcbdd9lsivCUarF1K4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=NFJNagzG; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59GKLP2R022201
	for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 00:15:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	dJ64cn4Jw2zoNd68Hcx2TgTpp/C+dSWYlA18Bl1jUjA=; b=NFJNagzG1l9y5lzX
	OPI+OcCYKz+fOxIKaZKO+hU6Q4zfOgf8tsGHHvoIGibPaXfurH2nW7rpONXpOXoF
	NpGolOJ4IqlY0dsXhRNUdbWg8KXjeGpTwqvGInfvZQuXtEXCYAxw9fh1WTxd3F6U
	Nwb/F6xtNeKEKTWCLhQflwSgBg2MYEap3dAuRBipNqnTbBOdx2pgzM3Z/PwmNDh1
	0YwXYfm1WtWfGJ7dx8xBVmOB4vqnfsXD2EP/hphrBijCN0R9gDPethI5ED7v2im7
	By0Gps3oZcIT3W/dLFhEZ5JBY+ALy95ivBl6ZM+RxxxGgyD62EL5PyYkC7uMzir1
	Pa5cqw==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49rtrtf6mn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 00:15:52 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-339ee7532b9so2833392a91.3
        for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 17:15:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760660151; x=1761264951;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dJ64cn4Jw2zoNd68Hcx2TgTpp/C+dSWYlA18Bl1jUjA=;
        b=tiFYxMBT/cIV7JU49u0xH9esQ3G+x3eq8Eh6PSy+OvUxfudqby3LxgaIesQhn+znRN
         k5B5d/xEgYbbfWx6jM/rt1Tcul4vlrer7z3IE9bCti2ChjrP2yRhonnNLGB4QpRf+LnX
         inbUtS++daew20s++Qg5TYsSGHFOONErNcrvUyjOGcT+tAu7DkB9wVCsb0kHEg+rUq2B
         7LBPrxrXhZran1rvnV+K1o33ITITZzRGnDgCokstX+5+M1aoM0ExWc+3tRUZkloaVVVa
         UAlWXnh67kFqduYuQGSoeK58ClPZ4KcKpO3Pi5ncY+EDaTxcPSmb8SBM6EzTK6dXw/aK
         iphw==
X-Forwarded-Encrypted: i=1; AJvYcCU2c5R0axitytGYPMVtP10PO/p1MEpE2q9pPX9dCeQ3Kkpl8pCPNrgP5IOnzJDlQ1f57YqT8kjIKnCPYO8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzuAnPKUEfF++2A7gIdZhY7MUyz/RoRb8OoGrW3VVAwYIK5gNjL
	/pHmMx0sv2od3QNk1+3KCPeLsrNmWCF+SfNkmTXAeDJUuuAEdFQyRoM+bSTmyc3IUfKk30b9gzB
	UwOTNnk1VMirxhlzRkM18FJFccyuXfwiJc+4Is3AfP8Wbn2vdhsdO6WXzlkFNzPSI+/8=
X-Gm-Gg: ASbGncsTOfTiTrskiJwwTkfJJIvLoVeNcoOuNkJ161UyDekjwUKWbUPXoYbp5DLKW7h
	nK13OXsjtOTDBwKf8YJY6OsNSuJ6KItTIzYDwFo9VuLg7st7Fal6o4sy7MrAgkVpu74jGcMYfjI
	KI+a1n1LMUXohC3RBATwcMP7LzSvXMMGq7CbMnhEwy3xq7oUy0Gs/34tVu+1D/vX+08eW4uNOhu
	R4rDk2C6viYxjIZ5+jSCJWD/FuPfuSlzfsd7c6C8KVRPNAXDA3OI1TWuEte1BmMM0pFVTmpsHCZ
	T+vtXX5Ean0dnOMGHQmq4U6hgJH2WmHFoHLUV9AO5IEJrNvv8ghNDYjio9tQhAo0RJ+pEwRan2i
	B+wyjG/F9YN5H79/tG1MU2Bh0rx0cE8rpUDa0AWqy
X-Received: by 2002:a17:90b:3848:b0:32e:e18a:368c with SMTP id 98e67ed59e1d1-33bcf84e18emr2015508a91.7.1760660150939;
        Thu, 16 Oct 2025 17:15:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFchSn8iE1CbOL7qzU83o7j4yN2YGWnh+JCQIrTf0Qed/q51JsPPPVJjhMi3h/XLUNj365KXA==
X-Received: by 2002:a17:90b:3848:b0:32e:e18a:368c with SMTP id 98e67ed59e1d1-33bcf84e18emr2015486a91.7.1760660150520;
        Thu, 16 Oct 2025 17:15:50 -0700 (PDT)
Received: from [10.73.53.19] (pat_11.qualcomm.com. [192.35.156.11])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33bb6522fc6sm3313879a91.2.2025.10.16.17.15.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Oct 2025 17:15:49 -0700 (PDT)
Message-ID: <b2b68430-5127-5eca-6bd8-4af31eb9fbed@oss.qualcomm.com>
Date: Thu, 16 Oct 2025 17:15:48 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v5 02/10] dt-bindings: phy: qcom,qmp-usb: Add Glymur USB
 UNI PHY compatible
To: Krzysztof Kozlowski <krzk@kernel.org>, krzk+dt@kernel.org,
        conor+dt@kernel.org, konrad.dybcio@oss.qualcomm.com,
        dmitry.baryshkov@oss.qualcomm.com, kishon@kernel.org, vkoul@kernel.org,
        gregkh@linuxfoundation.org, robh@kernel.org
Cc: linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20251006222002.2182777-1-wesley.cheng@oss.qualcomm.com>
 <20251006222002.2182777-3-wesley.cheng@oss.qualcomm.com>
 <f5e4ae02-b8fa-4406-b2e0-3602b07b7e23@kernel.org>
 <00408896-2e25-2dd1-6e6e-2195317ee7fb@oss.qualcomm.com>
 <14bc2a85-0f1d-3834-9b9c-32654348603a@oss.qualcomm.com>
 <387c707e-613d-433b-a76d-16ef10dabc59@kernel.org>
 <2a70f878-269c-1b40-2e8c-77b5851de9a1@oss.qualcomm.com>
 <99ab26d3-eb44-401d-8a7c-1d9efd2a1a10@kernel.org>
Content-Language: en-US
From: Wesley Cheng <wesley.cheng@oss.qualcomm.com>
In-Reply-To: <99ab26d3-eb44-401d-8a7c-1d9efd2a1a10@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: Mqrt7tBMgfEoOYsSRzueXTlb_epy7pja
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDEzMDAyMiBTYWx0ZWRfX0bpjFn8N/VeN
 sTd/AmWGsy0YGvntCeNsTT9IDaIZYfbCpAYr4LGKwSMmJFAhv+ff8Ap6c43sZmtnpXV0ME2C4tM
 RvT66a+MIvX86FxhlK08lW3D3nln3Qxb42xOWb1s2wlO3/XNTAdj09k8LJYHESR9kc5XkGHtosC
 JQRz6JTF1xg+qAvI6lzjDqeny2LH+3I5MAGfj26BGXuSsr+NdOCnZB8AFq9jLl5B6LN/WHuiUCO
 /LvpWOX5Py8oAl0vV+eyYuelRLlyE28OPeA5P9RXaWWTmxojRhkRB4JsaZpoG0NZg2ox8LwRwIS
 VQaNBaKzA8mct2Sz4TPS0MBBJfaD2nt33czAPWEgSY5v50v44fm+f7e7x56UeRRnulLueEOxycq
 es5K+JqCPcP2ord2epfwkRqnm7iukg==
X-Authority-Analysis: v=2.4 cv=SfD6t/Ru c=1 sm=1 tr=0 ts=68f18ab8 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=ZdW6uxA9NKXbfdqeeS2OGA==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=pJ4duzi49VOVWyagjcoA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-GUID: Mqrt7tBMgfEoOYsSRzueXTlb_epy7pja
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-16_04,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015 adultscore=0 phishscore=0 lowpriorityscore=0
 bulkscore=0 impostorscore=0 priorityscore=1501 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510130022



On 10/13/2025 9:36 PM, Krzysztof Kozlowski wrote:
> On 14/10/2025 03:16, Wesley Cheng wrote:
>>>>
>>>>>>> +          maxItems: 5
>>>>>>> +        clock-names:
>>>>>>> +          items:
>>>>>>> +            - const: aux
>>>>>>> +            - const: clkref
>>>>>>> +            - const: ref
>>>>>>
>>>>>> What is the difference between these two? Which block INPUTs
>>>>>> (important!) they represent?
>>>>>>
>>>>>
>>>>> clkref is the TCSR reference clock switch, and the ref is the actual CXO
>>>>> handle.
>>>
>>>
>>> Then this should be named somehow differently. CXO is clock. Reference
>>> clock is clock... To me it feels like you are describing the same clock,
>>> just missing some gate in TCSR. But in case these are not the same
>>> clocks, you need to name it accurately.
>>>
>>
>> Technically its all handling the same clock branch (CXO), we have the
>> TCSR clkref register that allows us to gate the CXO to the USB PHY, as
> 
> 
> Ah, exactly. Then clkref is not a clock. You need rather proper clock
> hierarchy.
> 
>> CXO is shared across several HW blocks, so it allows us to properly
>> powerdown the PHY even though other clients are voting for CXO on.  Then
>> we obviously have to remove our vote to the overall CXO, so that it can
>> potentially be shutdown.
>>
>> Maybe we can rename it to "clkref" for the CXO handle and
>> "clkref_switch" for the TCSRCC handle?
> 
> Naming is better, but it is still not correct. This is not independent
> clock signal. It is the same clock.
> 

Hmmm... I guess that's why I kept the same clkref tag, to denote that 
its the same clock, but one is a switch/gate for it.  Would you happen 
to have any suggestions you might have that makes it clearer for 
everyone to understand?

Thanks
Wesley Cheng

