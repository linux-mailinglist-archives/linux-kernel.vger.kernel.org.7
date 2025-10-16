Return-Path: <linux-kernel+bounces-855484-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 421E2BE162A
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 05:47:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1403519C34E7
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 03:47:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CB18218ACA;
	Thu, 16 Oct 2025 03:46:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="eIQbq1SI"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D09042A1CF
	for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 03:46:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760586409; cv=none; b=o3xnV1n/gcvbs1Ay6JY/uV/7zW1B3UnrXu0OKETjn22nBv6RrhCNiyziW3ov+Mvh0kM5vU26yDurWlxcBEMXiPLci7ziaAS1+xc1aGQU12PWyaGteZ0eG53bgqQXJwrhsAI1NPBg1qSPqFlyWimwBzoguHmHJMqhqX1IXSmm+ys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760586409; c=relaxed/simple;
	bh=bJPo7L8epy+g4bqxcLXBIlhestqPQYX6FEF5Gq1U5pw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RUpVKhIWL56sHjQH3So3k5i5lxFZ9BtENvx+fo3hW2gMY6MeElruf/KW3ka6J7x3I7IO/3qlY/Ukwagab3Awln5ebbpJnQCh/CtbymabTZS18wx6axEDFqYAmAuIHzWMKKqm9Oo5yViyS76orJkWxIQtUxAyYwekps9UAcGaUEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=eIQbq1SI; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59FKog4l005263
	for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 03:46:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	MGTgW6j4BwUGWXfqHUc5yYYRAKlvIbby7H5r4Mivrcs=; b=eIQbq1SICN9HG5wf
	stkAI1Wt3m7VqM9Xf9HOrJiRN4baTQQuCoCoVvmzhm+RitAwVdxJKwRuBed93xI9
	A6Txh/o4po8N3rlUq7U+dWYt4zQet+Rxv+ExmnbOY+HZbI5GRHstrGTvWcynU6S+
	s3Ik/gVqk+bKNAWvYuKo6LYRnC3DOQNu9KXduP6d91kXAX49Yh/kGuaNI1UEPLIg
	EeJ7fpnx56MFrRGjXlwQFIVKNYLCv5r4r1kbJMnf3GZm6c1PIPusaJIW7FAQH2KW
	oiTBqLwPIvXykAiZECsONLURDdMiDBJJPV0c/9NQqpS+wOiNhX8YNKHDAiqNVjg2
	oGSLRA==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49rw1ak47e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 03:46:47 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-28a5b8b12bbso7285685ad.2
        for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 20:46:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760586406; x=1761191206;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MGTgW6j4BwUGWXfqHUc5yYYRAKlvIbby7H5r4Mivrcs=;
        b=GL9/kqroL34ArmMMtOwas+jzTjWM7wIuZWCU//G8AJISMOnV4X+W9WMEvHAuVFt6vK
         RoZXg4vuQ9Rpi6BInGsENid4V7Ko+i995K4Z6pH9cmQvXeBvoGVIBeJiXIdd8r9+3Khm
         Ioi+1l6IHwVT5kIer50Nv0UJg5ge5262Eb/Wjbhi52FDYuN+ohDLqEdgUeDo6w7XmDvE
         L9xfsaHGVJIUZtGsHxPH93yLo7vz/YdJpWNzZHuVubMnpJbqSZvEMIZc3gapbIn86F9o
         CmUzImYgos9ZwZmFeDDRNZlP2o334e1wrF3ZuC34ANxrBrTtg/ZyzdJISuTlnToLmgSP
         0rYg==
X-Forwarded-Encrypted: i=1; AJvYcCUAFGHdgD4v4/VxHzMb4Bo0OI2i+qxdHPhQMKEbrWkGbzdUOMlkJkTDi57r1qRG7h1SMvHNjQrGXNsuguk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzLVs8rmjMEvSGxPkrklWm/5l/COvW0ZmA47SRpcDHByjdVXYNS
	1cpRpvNflskNeOJ4rgI5eUZMx9T9iWPKhjmpqP+C6ezJetOofFVut416WQFHYUzoJC5ZgeR/LHy
	lhM2OUrxkIdVAlpSANPH2hyaZMBcTBHEC4n9ZrQd/pt8AIEs9n0dg0nT9+JOrk/ShnY4=
X-Gm-Gg: ASbGncvQxzA83i7VxR84k4aGOsnFYwfTDhqn0/S2PSRXvTSVETt7UZLnN+0b1X189aq
	31nxA7PgUkyq1UYcgj/mtNhdSulbMYDyBgOSreIh8OcoTEh2y/ulnM9F92NTI6Qwrb2o7Wx0GY6
	EsiYch+QFjZ9jZbXXpEDrLD8DKczcYasqCoHkFB4Zwxgax++N/4UAhm01ijATvmrKCoKBq2MQxE
	jp3T4sNA2XdfmDlrLVN1/rB+vzNXypE9pQHLyZfKddpjlwZvi8esrboo96VaCKxx1pqYt75NT/y
	wTuIGzChXzHj5qlYTtZy30o82DgIZ6+vPSc5Iro3cH2RM3CgKCjalMOd0nV1wl3hoeozPJWCNFW
	qiM3ba9ou1afX0B19Bm1EsZ/0fzsLfw==
X-Received: by 2002:a17:903:2c0d:b0:269:b2ff:5c0e with SMTP id d9443c01a7336-290273ffa54mr419948615ad.46.1760586406216;
        Wed, 15 Oct 2025 20:46:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IECrjW1cqPBNCEcpo2wlLgL0bF8Aw5ZIvKRkZrZUayiubVGdoGasv05AYsxFUK4g/KjMzTWFg==
X-Received: by 2002:a17:903:2c0d:b0:269:b2ff:5c0e with SMTP id d9443c01a7336-290273ffa54mr419948165ad.46.1760586405736;
        Wed, 15 Oct 2025 20:46:45 -0700 (PDT)
Received: from [192.168.1.57] ([98.148.145.183])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29099aba3fcsm12296275ad.99.2025.10.15.20.46.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Oct 2025 20:46:45 -0700 (PDT)
Message-ID: <62a3f09b-50d6-4ace-8229-d71585378ae1@oss.qualcomm.com>
Date: Wed, 15 Oct 2025 20:46:42 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/6] dt-bindings: media: camss: Add
 qcom,kaanapali-camss binding
To: Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Hangxiang Ma <hangxiang.ma@oss.qualcomm.com>,
        Loic Poulain <loic.poulain@oss.qualcomm.com>,
        Robert Foss
 <rfoss@kernel.org>, Andi Shyti <andi.shyti@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Todor Tomov <todor.too@gmail.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: linux-i2c@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, aiqun.yu@oss.qualcomm.com,
        tingwei.zhang@oss.qualcomm.com, trilok.soni@oss.qualcomm.com,
        yijie.yang@oss.qualcomm.com,
        Jingyi Wang <jingyi.wang@oss.qualcomm.com>,
        Atiya Kailany <atiya.kailany@oss.qualcomm.com>
References: <20251014-add-support-for-camss-on-kaanapali-v2-0-f5745ba2dff9@oss.qualcomm.com>
 <20251014-add-support-for-camss-on-kaanapali-v2-2-f5745ba2dff9@oss.qualcomm.com>
 <dce1018c-6165-407c-8f3d-40859cb36b11@linaro.org>
 <0b6c157a-3d8d-4251-a704-31f8369f6a4e@linaro.org>
 <a0d9389b-67a5-458a-858b-ffdd95f7ccc6@linaro.org>
Content-Language: en-US
From: Vijay Kumar Tumati <vijay.tumati@oss.qualcomm.com>
In-Reply-To: <a0d9389b-67a5-458a-858b-ffdd95f7ccc6@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=K88v3iWI c=1 sm=1 tr=0 ts=68f06aa7 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=BiHMn5M11h/vNwziJwzFrg==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=CagpHDX3wZ8s8GLuJqoA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-GUID: mT2gXbBEiv50lyuDhbffa-n4xAvh0WhQ
X-Proofpoint-ORIG-GUID: mT2gXbBEiv50lyuDhbffa-n4xAvh0WhQ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDEzMDAzNSBTYWx0ZWRfX/Z8ATaAGanly
 bCZNJ2FQOejGCIyjFZXZVRoers20jhIdJBosjCi7Mwnpu4ppSZqFpSpbVswGdWPYP1z7rml4DVc
 Q3b8v3X+YpqONpbLArn3F53LbIOsBLITzix1ow4H3HnDNR+sCy8fGxxp3qLIWZpDtB2vBwhvk9I
 lv6I5MSnrhpst54nQuIht/dZg63rTaZTVqZaVWryLC+QCo9vwu4WDgbsn08BAXKbG4grCMfb9ta
 pWc2tQvHWd3vu53QTMMKgxT1D70IidsS5B0OUdUMW3VM+Xx8B4amatxBVnA58iOhfwCiM796uj5
 uVtrfz5ZpKrmlQn68qvAsczk3kJMg5Mx0s4l1NYixahVAvngc2Yy+yntcYn+jf87/UVhrD/TwAF
 R7HsRyVT06EMD64sTIlIC1VavKG+JQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-15_07,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 impostorscore=0 priorityscore=1501 phishscore=0
 adultscore=0 clxscore=1011 bulkscore=0 suspectscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510130035


On 10/15/2025 4:32 PM, Vladimir Zapolskiy wrote:
> On 10/16/25 00:43, Bryan O'Donoghue wrote:
>> On 15/10/2025 20:45, Vladimir Zapolskiy wrote:
>>>> +  power-domains:
>>>> +    items:
>>>> +      - description:
>>>> +          TFE0 GDSC - Thin Front End, Global Distributed Switch
>>>> Controller.
>>>> +      - description:
>>>> +          TFE1 GDSC - Thin Front End, Global Distributed Switch
>>>> Controller.
>>>> +      - description:
>>>> +          TFE2 GDSC - Thin Front End, Global Distributed Switch
>>>> Controller.
>>>> +      - description:
>>>> +          Titan GDSC - Titan ISP Block Global Distributed Switch
>>>> Controller.
>>>> +
>>>> +  power-domain-names:
>>>> +    items:
>>>> +      - const: tfe0
>>>> +      - const: tfe1
>>>> +      - const: tfe2
>>>
>>> Please remove all 'tfeX' power domains, they are not going to be 
>>> utilized
>>> any time soon.
>>>
>>> When 'power-domains' list is just a single Titan GDSC, 
>>> 'power-domain-names'
>>> property is not needed.
>>
>> Each one of these TFEs powers an individually power-collapsible TFEs.
>>
>> This is also so with the other xFE power-domains on previous SoC
>> generations.
>
> This is false, for instance there is no management of SFEx power domains
> in SM8550 or X1E80100 CAMSS in the upstrem, neither there is no 
> management
> of SBI, IPE, BPS, CPP and so on GDSC power domans given by CAMCCs.
>
> TFEx is no more special, if it's unused, then it should not be added.
I agree with Bryan, if I understood the original comment correctly. This 
is no different to the IFE0/1/2 GDSCs on SM8550. All the other modules 
listed above (SFE, IPE, BPS etc.) are not supported by the CAMSS driver 
and hence there is no management. However, we need to manage the TOP and 
TFE0/1/2 GDSCs for the real time RDI paths.
>
>
>>
>> You'll need the TFEx power-domain to process any data on TFEx with the
>> 'lite' versions being tied to the TOP GDSC.
>
> When it is needed, the documentation will be updated accordingly, 
> right now
> it is unknown what a data processing on TFEx looks like, it might happen
> that there will be separate device tree nodes for TFEx.
>
> TFEx power domains shall be removed right now, unti; a usecase in the 
> upstream
> CAMSS appears to use them, I haven't seen such code at the moment.
>
We attach these power power domains by name in the corresponding driver. 
For instance, the VFE driver attaches the TFE power domains mentioned 
here and are exercised from vfe_set_power() -> vfe_get() 
->vfe_pm_domain_on(). You can also see the related codes with '.has_pd' 
and '.pd_name' properties in the CAMSS subdev resource structures. Hope 
this clarifies.


