Return-Path: <linux-kernel+bounces-884957-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 39817C3193B
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 15:42:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CA996188923C
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 14:36:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 451CB32F75B;
	Tue,  4 Nov 2025 14:35:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="SLxzbp6p";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="CFCj6eFa"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C89CB32F760
	for <linux-kernel@vger.kernel.org>; Tue,  4 Nov 2025 14:35:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762266913; cv=none; b=uBNvDoXrroDQw90214gLc74gAmKpXBHNZCc68bWkk6OeFVl7rrm4xTVPFbQl9naN/ZPNpfo4PMyS0NgUIzQS7cMyITTCy2PxxqcTSB8/Hl0NIYhAfZYmmhKSHy8LKyMrSceEK5mJ5//RcpX7dOY7iD4VQYyOy9maYfGdee3bxHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762266913; c=relaxed/simple;
	bh=eJOwZZlKALtaagzRqBufBHXC1+5j5XJaugc6j/OpDmI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RBZ6fMxe+Pmx/3hkhZ1hWAZXsM07yp/Y0KzuB/Ti2IorWyicmegqifLmQhi5zkwwo3L0zvE9C/M2TEh5Ukf3mMoEZhq00jI4VAJo4N/JmN/bLLEBzwwEEL0gbc8d+7JvtOn91xz923NXRocjJMwIQuC5pnXuFw8+B4HtbDX6pT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=SLxzbp6p; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=CFCj6eFa; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5A4CftMW2043100
	for <linux-kernel@vger.kernel.org>; Tue, 4 Nov 2025 14:35:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	K072T6HPRjWjuMsTp0+7aI7AP9Wh/nbTI4zMnE9UlUk=; b=SLxzbp6psmmLL0hH
	tUfIizOt1naDCPDnhbZmgE8JgppE5vzPm4mfO8J/1nVPvlQV/3kc45JhVf7MfNDc
	ebS4CNbBlMoxw+Y+p0imsXBJlFsLmb9oP48+lTOdG3w6oac6WkuqqLTz++WPx3DW
	DPYrP/tibu3K3iOXTzWCSiISohl1kGBocBpa37jJuRAdDNXqxQq5hV3pTubPT4Qp
	bX5h7Dz3MKKAGQsk5050UuO2h7DrzVtZwHRpxK1WRNpnSP39yUu0Yi8hdRQXj/eZ
	BWYHLQxZnrTmqTzsanU5du96Pm74lMxQvwIIScU92d/OvHCYP/SwKuuDr8lTrcRd
	e9k4aw==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a7fgrgn4r-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 04 Nov 2025 14:35:10 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-8b10c2ea0b5so40261585a.0
        for <linux-kernel@vger.kernel.org>; Tue, 04 Nov 2025 06:35:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1762266910; x=1762871710; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=K072T6HPRjWjuMsTp0+7aI7AP9Wh/nbTI4zMnE9UlUk=;
        b=CFCj6eFaqtrSWxq+lIEASLwWwcb2xCEfbX6mh7+QD3YfUuzMwSMpbibUg0EqpUjMo4
         FQGaAhaBrmoyJXlvo0JW+UNI6ZbCuSFMSbElYLyvdxJd+6JzBBcfIKi9RZX+u4Z89doh
         Kadyc1VHWhu7a6CJrdGItYJqBIM8rbC3ydcbtR4DuCHC+f+6mpnBVSlqwsp4jOjyGmr/
         ivGqBu6VDPkPF4+wK0oojdeKUUBD56TIsBHuRUlwhDoqi25Wg96XtqyAJa9J/fWURiv1
         IasjUnDpCV5C5A0pHtBPLr6OgPXjLTTgBat+Ebg6yqyemcESmzrKy8o1fMgkGf/yW5Qp
         6kXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762266910; x=1762871710;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=K072T6HPRjWjuMsTp0+7aI7AP9Wh/nbTI4zMnE9UlUk=;
        b=IyPC0Au7i7lUnVkFm0JWcB48WXcljWU/YCqygLyoGhqpYnQxYEtTt3QxbiUcuO3cfa
         1GjqjZFaYWFZSLHe9T3n2d6JvZvLEVH7wFynPdQ6161eMZmWgoYUKSXLUdBPnS6FKbw3
         JsIKFqcW8VtgQUaYtk1KEKUS0g/TXuG/cpdDo24d8s/mE/FtT84lifv9vo615UeOMCfc
         kMsZJXUpha5N9rUPInjMQidFw2NdngkMrO+bXOpWHjnnSo0VK8mNOfkoUVEsh40niMv8
         n6Jac8ZlugV4uqhdABu+AsHocbBDrdbQA+WhcrV7oH0TXEXS15uUtIKZXby00ka9d1Ip
         Wavw==
X-Forwarded-Encrypted: i=1; AJvYcCUyIheX1rqm/vwfDIXA4kSQ428u825omgqPicpC5heu3wB+BARYbfi83U8ofNZI64XSJXuzVh2roLgZNN8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzmZUcial8HVhPJqTMbP91D8TsrCJQYYHpGsTWEKH3awvbwiJvB
	lCAstnT5UQ3ZVgW2bAZw786ifA56mceYIL0NjpfXCvmZ2Fph/BdiFSSclx743LeWaEdMYPwS9wH
	42RTIfu2DI6ikMrX0uPoVCZ5fF26HsouZsIGV6JrqyE2TwsZ5WQKfDmgUvYqZowwHv7I=
X-Gm-Gg: ASbGncs3zAd7aThDW7p2fhKo3CKdHQXUtbBiN6YrHjHHdQkcPLbh0bEZtdPOMsQslCv
	CFUYkg0cDGbDg4qUQ3XAxBsguNERZMJ5NbSogpwRjCkSiPdKXxwHfRdzg4dpqrBlX0AzJ/hAXH+
	/d/VJgaT2UCCrxmG2SM533sOTuOsL0WS1IYRaQTO6+OkBrAc3k5z2+6Up6oNJGu3p7j5xdmV2cO
	hsO7qYa/Tdq/qZdKrl9UWk20v/LY6Q9uauUiXol96aMAE3aZCh7vpZYhP3KhNNWpEMJ11AXURGQ
	BZoWLFs5nAQ4RgfrUVU36q1Jv4Q57g9xacrbleDHsHllgjvmZbPGm6vX3RR20GVoX8YytzZ2Cjb
	S9mW+qaNC4L8W2WVPMS6XXmVy3N2372uo3WtgqeiHY+JWEKf+h+K26Yl3
X-Received: by 2002:a05:620a:1714:b0:89f:5a1b:1ec9 with SMTP id af79cd13be357-8ab987f9141mr1481686785a.1.1762266909608;
        Tue, 04 Nov 2025 06:35:09 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF1XzC3wbZ67GP0Nl0ebGlvlejXlA0B4O0jm0PW4QKewOgOItP0mbeyAej7UDqRG76Ml735vQ==
X-Received: by 2002:a05:620a:1714:b0:89f:5a1b:1ec9 with SMTP id af79cd13be357-8ab987f9141mr1481681585a.1.1762266908854;
        Tue, 04 Nov 2025 06:35:08 -0800 (PST)
Received: from [192.168.119.202] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b723fa03d3esm238316566b.53.2025.11.04.06.35.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Nov 2025 06:35:07 -0800 (PST)
Message-ID: <9ee07db9-508e-4c08-8f79-6ccfd9b646ab@oss.qualcomm.com>
Date: Tue, 4 Nov 2025 15:35:05 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/2] dt-bindings: soc: qcom: Add qcom,kaanapali-imem
 compatible
To: Krzysztof Kozlowski <krzk@kernel.org>,
        Jingyi Wang <jingyi.wang@oss.qualcomm.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Robert Marko <robimarko@gmail.com>,
        Das Srinagesh <quic_gurus@quicinc.com>, aiqun.yu@oss.qualcomm.com,
        tingwei.zhang@oss.qualcomm.com, trilok.soni@oss.qualcomm.com,
        yijie.yang@oss.qualcomm.com, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20251102-knp-soc-binding-v3-0-11255ec4a535@oss.qualcomm.com>
 <20251102-knp-soc-binding-v3-1-11255ec4a535@oss.qualcomm.com>
 <20251104-glaring-rebel-pillbug-a467ca@kuoka>
 <790ca394-cee2-412b-97d8-c6416b843010@oss.qualcomm.com>
 <b6717831-1840-4b9a-aade-ab2248e3f75d@kernel.org>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <b6717831-1840-4b9a-aade-ab2248e3f75d@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: MOOSPZWoHDazpQp1oFbHNfpPASCzC22l
X-Proofpoint-GUID: MOOSPZWoHDazpQp1oFbHNfpPASCzC22l
X-Authority-Analysis: v=2.4 cv=b7O/I9Gx c=1 sm=1 tr=0 ts=690a0f1e cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=L0PDfkbdR_nvDvRPFewA:9 a=QEXdDO2ut3YA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA0MDEyMSBTYWx0ZWRfX29XL0ZYvriNL
 p1AWHBNU6lTlSVdVR/nPwl3n2OfTkQ6RkCFK4MyPKJckF4qcwqNz8oNRoxaSJVP174g9PtCrwHN
 wcF/ctOpzsjIhEJLkThF2DlANuDDPvQnfMypXddIFQoUaGYSfd9rIr+94+xpSUFF+BFJRLHlBqH
 5Cx+HZZLdTApHTT7UoC9W6dNIT5AwW0nUVFjXS9A3PeiKKgviDGnZUiTB2vkqX0XXWsrOLCxvBy
 AA5lxDpCPsoVea9oxUsyrAREOmiHzv5+laxlrVdEFhUT9nWiXuNRsvdzHXBkV+LfTfERMLM6alv
 qZCIOkesB70XMXa7UooeW8Md9eO5J/oCmtr0DwTjwHc5b+cWEnN29DP4/SP0GyJPUsHzOr+1uPv
 n4EJyEe9CTMtK5tBj8w9oPDNkHYT1w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-04_01,2025-11-03_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 priorityscore=1501 malwarescore=0 clxscore=1015
 phishscore=0 spamscore=0 bulkscore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511040121

On 11/4/25 3:26 PM, Krzysztof Kozlowski wrote:
> On 04/11/2025 13:32, Konrad Dybcio wrote:
>> On 11/4/25 9:16 AM, Krzysztof Kozlowski wrote:
>>> On Sun, Nov 02, 2025 at 11:25:06PM -0800, Jingyi Wang wrote:
>>>> Document qcom,kaanapali-imem compatible. Kaanapali IMEM is not a syscon or
>>>> simple-mfd, also "reboot reason" is not required on Kaanapali like some
>>>
>>> I do not see correlation. Something is not a syscon, so you add a new
>>> generic compatible? No.
>>>
>>>> other platforms. So define a common "qcom,imem" binding and fallback to it.
>>>
>>> You did not define fallback to it!
>>>
>>> ...
>>>
>>>> +      - items:
>>>> +          - enum:
>>>> +              - qcom,kaanapali-imem
>>>> +          - const: qcom,imem
>>>
>>> I do not understand what this generic compatible is supposed to express,
>>> not explained in commit msg. Considering this wasn't before, it is a
>>> major and really undesired change. It also makes no sesne. There was no
>>> generic compatible before but "if not syscon" now this must have generic
>>> compatible, what?
>>
>> So IMEM (or SYSTEM_IMEM more specifically as opposed to BOOT_IMEM which
>> you can take your guesses what it's used for) is to the best of our
>> understanding just a piece of SRAM that's accessible by multiple
>> processors/subsystems on the SoC.
>>
>> A smaller region within it ("shared IMEM") is a little bit of a dumping
>> ground for various (incl. runtime) configuration and debug magic data
>> and that's usually what Linux is concerned with.
>>
>> IMEM is currently described as a simple-mfd+syscon, which it is clearly
>> not. The former, as we've established in the past, was used as a hack to
>> have something call of_platform_populate().
>>
>> I think that in turn is only necessary for the old arm32 DTs which have
>> a syscon-reboot-mode node under IMEM (and I think that's where the syscon
>> compatible comes from).
>>
>> Should we make the switch to mmio-sram and settle this discussion?
>> It would probably require convincing the sram maintainer to add that
>> of_platform_populate() call in its probe func and making syscon-reboot
>> not depend on a syscon (not like it's very hard)
> 
> This I got, but nothing here explains why you need generic compatible.
> To re-iterate: there was no generic compatible before, now there is.
> Writing bindings and numerous reviews from DT maintainers ask not to use
> generic compatibles.

OK so let's not worry about a generic compatible. IMEM exists since
MSM8974 and it only had major hw updates with SM8550. They don't
impact the software interface though, so qcom,msm8974-imem is OK.

There's a separate control/status register address space for each
instance of this IP (usually far apart from the actual SRAM pool),
which Linux doesn't have to care about.

Konrad

