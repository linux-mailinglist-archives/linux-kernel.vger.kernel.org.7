Return-Path: <linux-kernel+bounces-860784-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id BB686BF0EEC
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 13:54:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 749A44EF203
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 11:54:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EA60305057;
	Mon, 20 Oct 2025 11:54:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="iFRnPDvJ"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4A482FD7A4
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 11:54:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760961253; cv=none; b=h/YPypeLl/FIFpxcLcbVHWMQ5B0QGLE5laPd0oJ0g3giRpu7WtItEG4JcW6K1q4TAlWHX5ACJGRWfYxghBpGbUOxvA/Xx8p4qOeAHsuTAyQW0237H3GFJfcR/TNVaHRcJP15UoIoVt7vczeaDScFmNWJliQ73+8w4tWBZlSUyjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760961253; c=relaxed/simple;
	bh=XOIoFcLWk/VxuwfLj/ZGuAxaYM5SP7XocY36ApNKCWI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HOZecnwJUPogOqvp9OsLd3xfpkz36RSoQbMAv1hxVKWoVbKLiYHd5YdUztShGBNggHAuhrRQw3PnFAYnjPdi0oNvJ0l6mMX9BgMbqelbjrsc4mkEn6geL5g9s5fMbPPCHIYMczG0VnpgemBIZJ4eyagcGoUv2HadgRe0XgTXWvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=iFRnPDvJ; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59K7aeB1021601
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 11:54:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	XcShWWRo4S23fgER/KylWBMkTNjMeFbimZyf7xwZHKU=; b=iFRnPDvJf7Ns1pah
	vuoBBsX5XlQaV58G0SQaZaudlkk96rrMaCUnYQ2aNRMk6yvDzGIp7VX7n13VhKPR
	dLr0c6QkMAvwgtIYLD82LEFR7ZpnNLAvT6m5zuklfKUnLYB3W9Qf+oXNKDmwSHvO
	piDOAZ0zLplDJPN9+PD0uAcaxai6aAwzJC0QN8fyCyIwqSXJftxbxXM+Vg22/Gqy
	55of4x153hYrdFeenxCQiqjxx0bvEn22NtmbFBXy27uLGzz9f9IepmOCtimpHhYJ
	vpETB560L3YYti6nV6eZSCle6qof8mTSzXQMcB0+HPF2o8CGq5fCzfjDHUCe3/BB
	nrxxEg==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com [209.85.219.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49v0kfcvrb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 11:54:10 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-87bb67409e1so15780236d6.0
        for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 04:54:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760961249; x=1761566049;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XcShWWRo4S23fgER/KylWBMkTNjMeFbimZyf7xwZHKU=;
        b=LWpzjOC9gxrEngJ/b0PUqrgOnIkXllwkxE5+Yr4O/fYPrpwAoerPTLiUJatL3zIfdg
         W12yBcKYL8mE9rQNB7FgLOeDFsBN0+7pjG1/kP9D7OuiRRj9FZ2cvvMeR/w9QtVuyGSM
         IY8zY00HKJ2ygjZy0I6b3qYlSWfC/MHnEh+KD6fZX8gLcFPWIvISEDVan/1at3KFi6sr
         TfaRFwb8e2BPKFD/L8U7j5s5DWITQeBUa4/KaST2TR6IgVErYBSdXGONNd+inorByFzU
         JWMUt78HdpV6WKw8JVoqzMGToFE1yiRQXSC9orh+BsPpLdqH4WuyLzWGJb2E+5cRsU65
         2FOA==
X-Forwarded-Encrypted: i=1; AJvYcCXAwIsniN2zmpkt/w3pu9cmBP9Ue6lWBqOHyLwhCNctjGDzdvIttwPCEC5KHV3pUt4LHD3nXx8x1coM/ag=@vger.kernel.org
X-Gm-Message-State: AOJu0YwnpbShT7xkUy8ZaQEIqmLT/1x6+cq0YmM8pZyBJ7nRh2T+Yak/
	M9ZIzdunGSNOqiVhzK2regajoCiwqxrBBOPRbpG8zhJyUwa215hv3F+fhRgpW52dlI7nhpVz4yu
	qvVUAxXUSE+N5IQE3ujRVFPI6BNLnP3KYCMMGMjJiD0q0fPCfbsnNvzviifhpCwaysmA=
X-Gm-Gg: ASbGncsInKQP2vBebsUE2eLixt7+ecGfum59us4ljX7BWtZpuDaFkFkmHjW+99Ogn9O
	W7cOY09jw447L5ARyUBH40+4iWS7Z/gQRZf8J0RvPjnEkXMsxKKosSUzwJambZRh+MPCLgB8A/7
	+xc7wn5arGN+SMOHgh0j95lZ4qSzsT/huy6k/2VmVld8/lNkHh23DXdydGMawn95yC+ru7jrCoV
	BN71suww9nwIlYEp4c/Gg4SOOADnrjxzGrL23vPSI4JmcR7w7hIl+yQ9i1Qu9VClGl7j/u7bQEX
	BbrE6ttaY9KRyqq1xj6OLNGIqtAKxvzL/LeG5z1Qh81mR+r6ICjHA3QBPr8dKmSOIb+Sr1K8B81
	K2FzImEqnL+pwgpUsbXgrznmvh6KGwm/YMUOshKtacTzeOT/XIMzxenLj
X-Received: by 2002:a05:622a:118d:b0:4e8:b634:1a1d with SMTP id d75a77b69052e-4e8b6341e2fmr58090241cf.11.1760961249527;
        Mon, 20 Oct 2025 04:54:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFrkoRTdssi+cLEdmRJ0a9TfppCSguJ/4ySe0r9bIdiNLEhlqFKb+7lyYFQTE9qy3WdUHwtVQ==
X-Received: by 2002:a05:622a:118d:b0:4e8:b634:1a1d with SMTP id d75a77b69052e-4e8b6341e2fmr58090071cf.11.1760961249059;
        Mon, 20 Oct 2025 04:54:09 -0700 (PDT)
Received: from [192.168.119.202] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b65eb0366casm784827966b.47.2025.10.20.04.54.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Oct 2025 04:54:08 -0700 (PDT)
Message-ID: <70ffe530-87a6-4045-a319-b7becb5831ac@oss.qualcomm.com>
Date: Mon, 20 Oct 2025 13:54:06 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 17/24] arm64: dts: qcom: glymur-crd: Avoid RTC probe
 failure
To: Kamal Wadhwa <kamal.wadhwa@oss.qualcomm.com>
Cc: Krzysztof Kozlowski <krzk@kernel.org>,
        Pankaj Patil <pankaj.patil@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250925-v3_glymur_introduction-v1-0-24b601bbecc0@oss.qualcomm.com>
 <20250925-v3_glymur_introduction-v1-17-24b601bbecc0@oss.qualcomm.com>
 <CAJKOXPdi0+c_FqinVA0gzoyqG6FVFp0jq5WSLsWWKiT12VVs3Q@mail.gmail.com>
 <CADhhZXaB310hVo_w8_CoJLQ3j9dy1eeTwbmk0q=vUV2ga1PAYA@mail.gmail.com>
 <8f81289d-7672-42e6-b841-6514607cdb38@oss.qualcomm.com>
 <20251013110407.dqpjdrdaw4gzpcy4@hu-kamalw-hyd.qualcomm.com>
 <49004d3e-7914-48ee-8705-ee86d1944166@oss.qualcomm.com>
 <20251014123658.sobt6ab6gnbafyme@hu-kamalw-hyd.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20251014123658.sobt6ab6gnbafyme@hu-kamalw-hyd.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=E6LAZKdl c=1 sm=1 tr=0 ts=68f622e2 cx=c_pps
 a=wEM5vcRIz55oU/E2lInRtA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=dw0t6H4-AAAA:8 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=-vGuBvw500s2EirlLaYA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=OIgjcC2v60KrkQgK7BGD:22
 a=wVJa4CU9-Z26yuRAZDil:22
X-Proofpoint-ORIG-GUID: D-3w0mMOe6Lqveh0jOJz2upPRs4dHYzg
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE4MDAwMiBTYWx0ZWRfX4qRl7Ha9gwI1
 8ltCf2cQkCgTqLAubXn5wYvBUXn5GJPXPwFQdE2olc2nXvEbQ+0UnkZHJLFX8JX7wh7Ea2EqjQO
 p+xrWspAnw/4wnuB9Q1+z2Nor5ZpHd/r1fTiQCkyc7RZV4g6e0F2nJ2HpKrneLWBVgIzFFAKKtE
 1ab9w4WJODVDiWZqc+acJAUjkeqk/V8e4WrzVNuyGrBtRz+lH5K44yuGkD7Uv9FIhGx8zocMLJB
 UFZL5rYnudage4N/GwaI4TRnCaUIQhzd8tAwzBIEFL0dT0FbQZ9PS4ZJEUn+o5hFEvJ0wp61DLs
 1fGI2htNXx4D/KunYil1zSQXATI/8HI+pxvADXsb4q7H1oSPToMrO+efdf5txNw3JQddddnHD1W
 Eizzw+VKkB7zhosQkwzjyiDp4Pz+zw==
X-Proofpoint-GUID: D-3w0mMOe6Lqveh0jOJz2upPRs4dHYzg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-20_02,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 bulkscore=0 priorityscore=1501 spamscore=0
 phishscore=0 impostorscore=0 malwarescore=0 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510180002

On 10/14/25 2:36 PM, Kamal Wadhwa wrote:
> Hi Konrad, 
> 
> On Tue, Oct 14, 2025 at 12:23:23PM +0200, Konrad Dybcio wrote:
>> On 10/13/25 1:04 PM, Kamal Wadhwa wrote:
>>> On Mon, Oct 06, 2025 at 04:28:59PM +0200, Konrad Dybcio wrote:
>>>> On 10/1/25 2:23 PM, Kamal Wadhwa wrote:
>>>>> Hi Krzysztof,
>>>>>
>>>>> On Thu, Sep 25, 2025 at 1:41 PM Krzysztof Kozlowski <krzk@kernel.org> wrote:
>>>>>>
>>>>>> On Thu, 25 Sept 2025 at 15:34, Pankaj Patil
>>>>>> <pankaj.patil@oss.qualcomm.com> wrote:
>>>>>>>
>>>>>>> From: Kamal Wadhwa <kamal.wadhwa@oss.qualcomm.com>
>>>>>>>
>>>>>>> On Glymur boards, the RTC alarm interrupts are routed to SOCCP
>>>>>>> subsystems and are not available to APPS. This can cause the
>>>>>>> RTC probe failure as the RTC IRQ registration will fail in
>>>>>>> probe.
>>>>>>>
>>>>>>> Fix this issue by adding `no-alarm` property in the RTC DT
>>>>>>> node. This will skip the RTC alarm irq registration and
>>>>>>> the RTC probe will return success.
>>>>>>
>>>>>>
>>>>>> This is ridiculous. You just added glymur CRD and you claim now that
>>>>>> it's broken and you need to fix it. So just fix that commit!
>>>>>
>>>>> I'm afraid, but this is an actual limitation we have for Glymur
>>>>> (compared to Kaanapali).
>>>>> The RTC is part of the pmk8850.dtsi that is common between Kaanapali and
>>>>> Glymur. On Glymur (unlike Kaanapali) the APPS processor does *not* have the RTC
>>>>> IRQ permission for the RTC peripheral.
>>>>
>>>> This is interesting.. is that a physical limitation, or some sort of
>>>> a software security policy?
>>>
>>> This is mostly a limitation for all compute targets(like Glymur). On compute
>>> targets we need to support ACPI TAD feature[1] this feature uses the RTC alarm.
>>> In a nutshell, this feature implements 2 times - AC ( adaptor power) and
>>> DC (battery power) timers, and based on active power source(AC or DC?) at the
>>> time of timer expiry device will either go for a full bootup or stay in power
>>> down.
>>>
>>> This feature is implemented on a different subsystem (SoCCP subsystem), and
>>> since the SPMI `IRQ` permissions can only be assigned to only one subsystem,
>>> so we can't use the alarms on APPS. This is why we use no-alarms DT to register
>>> RTC device without alarm-irq support.
>>>
>>> [1] TAD specification - https://uefi.org/sites/default/files/resources/ACPI_5.pdf
>>> section 9.18
>>
>> Hm, is there maybe some sort of an interface to talk to the SoCCP
>> and set the RTC as we wish, from the OS?
> 
> Yes, the developement is almost done and we have done some testing as well, but
> that kernel driver needs some more cleanup and testing before posting to
> upstream. This will be added in future.

Thank you. Like Dmitry mentioned, please leave a comment about this

Konrad

