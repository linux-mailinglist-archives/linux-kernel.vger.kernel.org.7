Return-Path: <linux-kernel+bounces-747922-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C89E5B13A49
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 14:15:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F366A17C2DC
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 12:15:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83986EEBB;
	Mon, 28 Jul 2025 12:15:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="D9jdOPch"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6934F21D3F0
	for <linux-kernel@vger.kernel.org>; Mon, 28 Jul 2025 12:15:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753704936; cv=none; b=dBQilsBCl9dkV3SXtMsJeq2M+KXQgcBkOJRcxIe/kVasnF2jjDnWzRPQUCwusGnJvltXpKgTH+b0gy2l6Iwuyl2btphhY6OsupDtO0mpfSQdd2Rsw8pat0MG+536h6iPyGZvIA/jioUF93aimNUeKhTnsm2sZRrUchrr5YrsrSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753704936; c=relaxed/simple;
	bh=pdDl8nLT0rFDnk4KkdktFdEnsyajVbvBfHRG2jgKTUE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=S3o5TU1pR91PWQF4j34wm0jS+UybuCbzTvAw2XbWFh7sYSTwc3uMOhvykmOoBoRFI2HNG+nFgltIvWREO0GL04+qoWd19Nyf8+WYSObZwzJ/h1gG/elKJnHQyJphS2IvjPjhQVsq3jpq+aJ9pS9X4dVDnA9y/SbtuWJNO4ERKF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=D9jdOPch; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56SAlNt1005104
	for <linux-kernel@vger.kernel.org>; Mon, 28 Jul 2025 12:15:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	x2gviWJmNpeCplZxjlsp3nVn1LXu8j3oj2AUy90cz3Y=; b=D9jdOPchnnnuai+E
	+RE2tKZv1xMAHmGwwUgD0U7jp032uGeLVIEfJT6kxorHc8AbXi0+BGz1Ja99r1R+
	q8TTGXN6wmD9bSfyAGr+/14tCKI4dAz7WQFBnCOHWTa6iqtwLZxEHNmq51LPlZ1v
	3NRMeFbB9V8g3/Nf2FkACxCeRHdHcEzC+l/NhFvxYMwj1OavQS5IRnZ15kFCPP3F
	VkEMx9UlSwKwriXupM9CmqZzBEgHloT0/dumY2SCVDi0AY1+Saf4N/nyeOZFf9Bc
	X3ECYLfRTgjrsUYYnlb5ELdbuebaQS9dIEPX2NvV87U+psvpwr3tZKxfdkgGwV5x
	O2z6oA==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 484nytvpwr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 28 Jul 2025 12:15:34 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-7e34ba64a9fso8048485a.1
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jul 2025 05:15:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753704933; x=1754309733;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=x2gviWJmNpeCplZxjlsp3nVn1LXu8j3oj2AUy90cz3Y=;
        b=WbpWB1WRsbPsHanNwQufiGM21UxxRyA6dltUcdM4CVkUQRWIgqwQncn8UbaBxseh2k
         6yFhYsYHV4nl+TNX+Xpf4A8OwvfjwwOI2AGYNYXVHMcw3NA4mv6XqLKpmWF7F8iBS+6J
         6uCarOGzCZ3PILf3CD3fjPdXogfPPFVgReC02gRjkuzIWbnMGgfsjVP1vRNXMJTNGbOe
         if4FVXJm55+3ZAbTZ8leNBTTEhna7uV81Zj/YGO/ZiZe/QS1XKAUG9kAXHiT84AS+YK8
         oQWSTpbtc9CXCAZdfHoXPnE0GrqA0iaLMFSh/bXZJ1zkKkU/42fZu2Qqp1yGt7kR4O7V
         3wsg==
X-Forwarded-Encrypted: i=1; AJvYcCWl81qkZ3EoCTTen2p+LnbpXS02WmquzNpoBZgGkaoS/immxOjeDjqOGpXGEdBy5W7CL2zKxUUqLedWxfQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwziolD1019oFThvbj0f+lLMD648qWy88d2b2i9Jt+RV8UOxvrV
	+4dUs3v88JYSQNY0wZvqSxGuKAciXZmjLsjAim4tdgG7VmD/uGqUnH0dlcW9uczOR3/u3Ef6Gld
	XiC3/aWVNpG+UoK+HSbtw8Kpj18/wrB+jSRf1aP6fyzzHOnstv6I4eUmAvFZD+vuvCYM=
X-Gm-Gg: ASbGnct/kTt3JHIEAIpZ8tV4f+Irylo9TRh7oQTsdWhm8UQkPryFrhIW2Xaf2+pGQOE
	o17IijJb5V2qqZPJ8Ef+8JvZwB05x1fT4RE3v8QykbeX7IojFW0XGk/TOIgFrozAG4FzaVXiKc2
	faD6UenbCI5ahgd2k0PzBWcyItsHHNyNFGbYW0pcnl7fffLpH2eTj/zdjzwfIaWFsYSTm1Jzx+s
	xNUhmV7c50ndwCRRlcpF9sa3EI6S8H56hr25X1n+G+4WgQycl5SGFyHFr7KWs48cGVy7K1AN+wa
	7Jc66PJpRY42JFWd565ZxIWLLop3SWBfaaP8TIO7DdqFCh7aq00IxsktQVvMJD1tiqDh8XxsgZ4
	vjDvtuqli6Yx+CdDI2Q==
X-Received: by 2002:a05:620a:470d:b0:7e6:28a9:db0d with SMTP id af79cd13be357-7e63be3f76emr623984485a.1.1753704933081;
        Mon, 28 Jul 2025 05:15:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEUoYr5uioDlZfrjVtli7EFzl5Qyf/iN/jG9k6w+bh0ZrxI9cy2a6TTlnzT3lV9S/AskSiU4Q==
X-Received: by 2002:a05:620a:470d:b0:7e6:28a9:db0d with SMTP id af79cd13be357-7e63be3f76emr623980485a.1.1753704932407;
        Mon, 28 Jul 2025 05:15:32 -0700 (PDT)
Received: from [192.168.43.16] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af635a62acfsm417921466b.66.2025.07.28.05.15.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Jul 2025 05:15:31 -0700 (PDT)
Message-ID: <f508e576-38d2-4040-82fa-4cba108d511a@oss.qualcomm.com>
Date: Mon, 28 Jul 2025 14:15:28 +0200
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
 <dda5b873-4721-4734-89f4-a0d9aeb5bdab@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <dda5b873-4721-4734-89f4-a0d9aeb5bdab@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: _m1wXJruFNQiw5LNcBFNhYuY8yK_WpOE
X-Proofpoint-ORIG-GUID: _m1wXJruFNQiw5LNcBFNhYuY8yK_WpOE
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzI4MDA4OSBTYWx0ZWRfXx09CqM27NjGX
 vLpiTzRIVrR5Jv/3l1vppQ6Nvr/DOf1YelKLoSNBGoydRcBz5Oj/bfCLtQke1AszR2AGk66HKS7
 xuENFXs2wIgvj3tJ9R8n3Hum+I+e3kaeKObGvJ4tM6IsZqR/cYmvV5Nl0PgGyulgNMoJppXaKtb
 eSwdaIyfc5uCrLRgTkr6VZDpyDICYi9FL0wP1cY5v4sCI/v9UtRqBNIZSooJvoYT7ixF0GRUq8M
 kkyyUvvdamaxSqLXQSbHaihOVFFmWcoL/UBFizCI7SD8sfkSTvpVTIHC3GwD9VrjPO5jEwVIP1z
 gJVWXeJnOmpbW2b4IqhRyNuOFsMuUhYlIIAMr13imav9J6WtpospnPhptOnYXoQ96GNo9dxNOyA
 NcSgtwwSlMKraILLYkiXQpQ0bXQn4olEjW6b3nYm75VWyMwBrYglT2CHzC0f/Yvwf3PiMJzN
X-Authority-Analysis: v=2.4 cv=CLoqXQrD c=1 sm=1 tr=0 ts=688769e6 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=WpjJ9PWMYFXYRfV5F1YA:9
 a=QEXdDO2ut3YA:10 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-28_03,2025-07-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 adultscore=0 suspectscore=0 mlxlogscore=999 spamscore=0
 priorityscore=1501 phishscore=0 lowpriorityscore=0 malwarescore=0 bulkscore=0
 clxscore=1015 impostorscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507280089

On 7/28/25 1:02 PM, Konrad Dybcio wrote:
> On 7/28/25 7:01 AM, Krzysztof Kozlowski wrote:
>> On 25/07/2025 11:30, Konrad Dybcio wrote:
>>>>>  
>>>>> @@ -40,6 +42,9 @@ properties:
>>>>>        - description: GPLL0 main branch source
>>>>>        - description: GPLL0 div branch source
>>>>>  
>>>>> +  power-domains:
>>>>> +    maxItems: 1
>>>>
>>>> This should be a different binding or you need to restrict other
>>>> variants here.
>>>
>>> Actually looks like this is the same case as the recent videocc changes
>>> (15 year old technical debt catching up to us..)
>>>
>>> I'll send a mass-fixup for this.
>>>
>>> Some platforms require 2 and some require 3 entries here. Do I have to
>>> restrict them very specifically, or can I do:
>>>
>>> power-domains:
>>>   description:
>>>     Power domains required for the clock controller to operate
>>>   minItems: 2
>>>   items:
>>>     - description: CX power domain
>>>     - description: MX power domain
>>>     - description: MXC power domain
>>>
>>> ?
>>
>> This is correct and should be in top level, but you still need to
>> restrict them per each variant (minItems: 3 or maxItems: 2).
> 
> So I was happy about how simple it was, until I realized we also need
> to poke the VDD_GFX domain. It does however not necessarily exist on
> all platforms and I don't want the binding to become a spaghetti of ifs..
> 
> CX & MX is present on all(?) platforms
> GFX & MXC's (any combination of those, unfortunately) presence varies
> 
> Is there anything better I can do than creating a separate case for:
> 
> * CX_MX
> * CX_MX_GFX
> * CX_MX_MXC
> * CX_MX_GFX_MXC

Doesn't seem like it, turned out this wasn't as terrible a mess as
I had imagined..

Konrad

