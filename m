Return-Path: <linux-kernel+bounces-757584-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A060CB1C3E5
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 11:57:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B3D987A076C
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 09:56:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE97C257AD3;
	Wed,  6 Aug 2025 09:57:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="OsJ6d9NW"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD483221F0C
	for <linux-kernel@vger.kernel.org>; Wed,  6 Aug 2025 09:57:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754474257; cv=none; b=LIkBPnQsLYvsK1gnFxUW+ISZg0/OsC6UKag8c9Bs/ixE5scXdlGCbkGG+8nZZZRut6XV7kGkxyDB+qpe03MTIucnSDtCsNXyc5LbLsIq3eyh4UTB7yj2nNB6hKmHMe7bxbGV/p6F0OmpBXKGkBCvgWvuzhg456bOdmK7eLBnSeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754474257; c=relaxed/simple;
	bh=lsYFOYME95FfYHQgxD2fXes4j/sNpClVL4HShdy3UpQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bz8PJAkbg4EPQxsBkSmU6ec7pw2GZ2Uca0BY/DkJiRnfkA8hSky0cgV7kuyR/1CDxPh/y1FsOlFCyJ3BjF7cEAjryn8WTN6ZBwXRjP4ZjiUn+lFkyXtuWBVAiraEpRXUM5xj60NVOAUxhzwGSrcay7cjztey/JdvzovetqxM7zM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=OsJ6d9NW; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5765FdU0019916
	for <linux-kernel@vger.kernel.org>; Wed, 6 Aug 2025 09:57:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	IqxXBbq7cPgkYcO7MMpR2qxt2qS4qD02969cwFn8hIk=; b=OsJ6d9NWKHJkMZoa
	hswbPYW7K9UASdz9PiijZCTgAMlVGh6jlG1/CShuLCAd3YwCCmKUoXO4qtn7bJ9L
	M/N4wGTswbUQzraUQD25IqWF0JAIUIaE9zCy/VFuL3x9C8WKNOeQXjm8L92UV/5G
	QBSdlA30mx9SiuY3mdQYnlNDIExNRl2YasdrSG12Hluh3BtlXwwjPdd2yfpjCQv9
	T+TgBjbHSVOmsFPXmp81Yv1MRqVxjem/jt2wJfH9g4XZUScn4DAIe0aq7lOT7BFq
	BkgSm+MjcqfEmCXlxcwvbFwtl26XSn1k7McNKHkdp8YC5HyxfeHREY7RctRd1GI3
	QPtZEw==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48bpw1ab42-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 06 Aug 2025 09:57:34 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-b31f112c90aso693541a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 06 Aug 2025 02:57:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754474253; x=1755079053;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IqxXBbq7cPgkYcO7MMpR2qxt2qS4qD02969cwFn8hIk=;
        b=Rkk4/6ErE3lMTqx143ItVxmMPNgxYKKxEmiycoGqaW6a+af7tsYMpoCYyUKoL8NZ5g
         MxLJZvotfHGZSbWjhhikN7zkX8d2jbOpc/xTwnczqO3e7b2FuUcJ2XeK4BWB7kuiWKWq
         obhfxt70OO9cXvAIuECWOdwM/KhvrLL/C37KsZIhY//QU7y7AECFjEMutiL37OBzHYHs
         9itgveEdLMJffbhbjI5QDRV3iIBNdKkBPUGODhoglNOjZDM9fee+aEuo2O7sCOG6kIl6
         ReGGp2FKhHS4ZfPswC4K6zvhTIP4DE79wkoVw+98WpPoGtzDX29qwlnjK63eTJxyKg9g
         nqMw==
X-Forwarded-Encrypted: i=1; AJvYcCXH/TlVA3aDrNyF7TsIS3c9kHt94zYbXDXj0wiVVm/iSZsiS1h7LesjXy/WcprRHsbE6BJRMhn62+YY3ZI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8i/r2S0ZGeaaXNAqv30ptCSGfoZF66RQEKsI50TY2DuD//1Ti
	u7kuulaGUB+++vTYxbAganXFJlBXOJ2CuVQsNYi2Qa3FMlfw7Q510UeGfET/cG8kV/QL5a7ZsA5
	ZqkLRBIEfH0IM6BstG75Q0xfoa/VrrG2785WNQUUcdkRIihMKps6tZ1t5zfsFZXNViNI=
X-Gm-Gg: ASbGncsHABYYS5DBtvrjLqU9MVb2sVUlzqPHw5bHg7YO+3atUSNURfp8RG8Ya2Mi5hw
	RomMfnloEUdem9z9rSXJULHjAEMbWwCUN53hgl8fd+mnYzQty03Z35rcXzYddGQxNmF8C5HaOz2
	0rXmypo4MmvbD3qyM6oOS4NaAO8CdMdF3nPB6cC0qO+kZJLohxD5pGE96x/TsrkD0baNhiAB8Bu
	1B/1HSencweiokTUI0mLRqArOfa+U1dX7uFasZIiPaZQUa/TowktCckvwQCUnaygjEzWvHqokBI
	TC9rAsEt1fIEn5VU67E4rZdGJxVttGgaO9HPLxnBUgPzWvPCsNtwEK665q4iNVHfNGE=
X-Received: by 2002:a05:6a21:9989:b0:240:1132:6ff with SMTP id adf61e73a8af0-2403193f793mr4134205637.7.1754474253333;
        Wed, 06 Aug 2025 02:57:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFvOm29N4CcerImZ0VqJXj8dtUuBPdLJmLmcso/logCxwkr3fV34DG4P2Oi7ic0GJV//FM8EA==
X-Received: by 2002:a05:6a21:9989:b0:240:1132:6ff with SMTP id adf61e73a8af0-2403193f793mr4134150637.7.1754474252843;
        Wed, 06 Aug 2025 02:57:32 -0700 (PDT)
Received: from [10.217.216.26] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b422bac0b57sm13036378a12.31.2025.08.06.02.57.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Aug 2025 02:57:32 -0700 (PDT)
Message-ID: <5d75904a-05f5-4cee-9ff3-821b692f6a6f@oss.qualcomm.com>
Date: Wed, 6 Aug 2025 15:27:26 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/7] dt-bindings: clock: qcom: Document the Glymur TCSR
 Clock Controller
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: kernel@oss.qualcomm.com, Pankaj Patil <quic_pankpati@quicinc.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd
 <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Taniya Das <quic_tdas@quicinc.com>, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20250729-glymur-gcc-tcsrcc-rpmhcc-v3-0-227cfe5c8ef4@oss.qualcomm.com>
 <20250729-glymur-gcc-tcsrcc-rpmhcc-v3-2-227cfe5c8ef4@oss.qualcomm.com>
 <20250730-mottled-myrtle-bull-3ae03c@kuoka>
 <9cb06263-2a61-4acd-a9cc-157abb832d62@oss.qualcomm.com>
 <48610dd9-16c0-48ec-9997-2de9e0f7b3b6@kernel.org>
Content-Language: en-US
From: Taniya Das <taniya.das@oss.qualcomm.com>
In-Reply-To: <48610dd9-16c0-48ec-9997-2de9e0f7b3b6@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA2MDAwOSBTYWx0ZWRfX7242KnOsTMI6
 rsmyKe9ZNkpGvgbIwWvZz90VRSbaGMfZ9sEwLSJOVl3QMfegjZssGotI6gvDr5scqBrjmUoryNo
 3Kn3J8ql+JzfditfWql5a40gL1a0/tSKA+HD4MtHvdldukxjyXrHaIjEJlLAyV5hgbqzQIeIXVh
 wPGHClMD5eDixaHL+zqPQd8an047k+b4JFfPPFhXGHHwLm19oIOtoCxNGEOe9m32mV2x34QO9rf
 hh33J7IIe9vtEEb1MwX6wC3z4RdwzdJvsIcuILqnXl+bbHXjXhbj2F0d05Dl2+3FExLWvb81txA
 AXmPn60Vg7eUDOa0KwlZpI6tUBTXvjlLr6Ecg3OpdRYRGrz0Mz4opKrVN0M2KiLUn3ufRzEqhL6
 kPMz+ROh
X-Authority-Analysis: v=2.4 cv=Ha4UTjE8 c=1 sm=1 tr=0 ts=6893270e cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=xJKRXGaZASgMo-ZfVxMA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=_Vgx9l1VpLgwpw_dHYaR:22
X-Proofpoint-ORIG-GUID: K6iTRAJZIriP7ARTkZkFFZgPNERt-Dh6
X-Proofpoint-GUID: K6iTRAJZIriP7ARTkZkFFZgPNERt-Dh6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-06_02,2025-08-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 malwarescore=0 clxscore=1015 phishscore=0
 bulkscore=0 adultscore=0 suspectscore=0 spamscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508060009



On 8/1/2025 2:40 PM, Krzysztof Kozlowski wrote:
> On 01/08/2025 06:14, Taniya Das wrote:
>>
>>
>> On 7/30/2025 12:47 PM, Krzysztof Kozlowski wrote:
>>> On Tue, Jul 29, 2025 at 11:12:36AM +0530, Taniya Das wrote:
>>>> Add bindings documentation for the Glymur TCSR Clock Controller.
>>>
>>> Same question as for v1, what is Glymur?
>>
>> Glymur is the Qualcomm's next gen compute SoC.
> 
> Explain it in at least one commit msg, not in reply to me.
> 

Yes, I will explain it in my next patchset.

>>
>>>
>>> Where is any DTS using this (or explanation of lack of DTS)?
>>>
>>
>> Krzysztof, the DTS will be posted separately once the driver and
>> bindings are reviewed.
> 
> Hm? That's not what I was told thus I ask. I am sure that above is not
> true, but if you insist and put it that way it is incorrect. You cannot
> send DTS because you wait with drivers to be reviewed. We want to see
> entire picture.
> 

Sorry for the confusion, Krzysztof. What I meant to convey is that we
plan to post the DTS after the public announcement of the SoC, which is
expected to happen within the next couple of months. In the meantime,
we’re hoping to get the code reviewed.

-- 
Thanks,
Taniya Das


