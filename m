Return-Path: <linux-kernel+bounces-852350-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 710C3BD8BEB
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 12:24:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9CFDD4FD250
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 10:24:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52D812F8BF3;
	Tue, 14 Oct 2025 10:23:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="XHDK2r3o"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 168AF2F7457
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 10:23:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760437411; cv=none; b=NaQDZ0ktnAd7F+PWIoHlmNbx2bnhAr/5D+92D9QwzI7f3r0RbIb85cJLmu0VSvn5eFere9zvcg33MzrFXv2QUn4FbPjEe0d9OF2T9DsLVBdT+Oiusa7H5yCEX/jXjq7X5CY4w8rAW3zRZIxhs0/uKNnIRW/GsGfqNEcDLHk7HkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760437411; c=relaxed/simple;
	bh=bKxqC7Urx8BIjnGRET3RTd4P1I214hzlRG3kPzTTWhY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=E8N4mfeiQu5H2kkxF0LCQssmKThITEF6PQhrWl7dw+S0dSorE2BPwCIYfqmfsjDVIdr6vklbM288bJF5pr/p8NYxsp3BzoXNDWcK3ah9FGamOw6YLey4dzMAbX18fAGlpTJhUrBh++H9+7m413MpXMBFTSIda89iMFN6Rgzzkhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=XHDK2r3o; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59E87Gfr019855
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 10:23:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	syFSpr3eCh99bFPl9T/VouB+NcW33TkqI4ZtatFCBVw=; b=XHDK2r3oIjrw4w34
	9O5IOphziKK/7yQymh2KsEmHn2Xa1nn9VmcOWhcRccKASzi+6kFJeRteaOXYSkE4
	A9SwKfMt51aMCrcZT9thYKj1RyTN97ZG7OkVOpnXIe25YZ4cxlQ6KBOjszUU+u7a
	CKxLDvk5sAj1+46qCDtxk6PrAGEaMO9YYau8z0gYxv8D36NelPvvqQi9A/t1qY0v
	emfg96JL+j/LnVSO2uTtk5A2nijNDOsU4SObulARmfEmFx3fWvfz5b5LbpownBS4
	fm/rE5kjDqnhOKcU0HR70JnUMq8zcDQ+uExRkblzLSw7BxObX2eBmh7mjXPf3u6F
	RNSd5Q==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com [209.85.219.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49qg0c026m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 10:23:28 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-798447d6dd6so26423166d6.1
        for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 03:23:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760437407; x=1761042207;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=syFSpr3eCh99bFPl9T/VouB+NcW33TkqI4ZtatFCBVw=;
        b=UwF2VRfP7jUISm9SoXlfQHIOQLQRE2N7kTVkrz17oMr3nMFmhMDSFRygDkyXnHNy8L
         Jgjo3ednSDwjRLU4vCVXO9287v6O5R8MKEZ+eB45D1mHJnqGCWJcgvT4omvcMy3ZhGNp
         /MjlzgHrLvsKH+O8UxbuEFprKBP0VjFXZ3B86E9algO8w3h0I0UuMxaZErrfo8uvOi2t
         nUkf12/J53SfyPVmr6vHKmKxhlnvZElpRgUOj+PnVOmMBFuAngAF/nSDBnSShUCwInXT
         ROUe/DXGh8tkBmK8LDputUrlZbs7ARNjw+Hs01cNbofvckjjrvFUjMfoATj4Bx9nU6ye
         FdLA==
X-Forwarded-Encrypted: i=1; AJvYcCVcwDwEkKqmTXtFQWwCPbBNkNbC1uSevnUhxEBHLogDGbJ0L8ztVWDHnls/KcAuUfgLcdtusfPvUobam/I=@vger.kernel.org
X-Gm-Message-State: AOJu0YwwJ94vfsCmiJKYFLY154Ln7CC3u95zh6TICxcku4GviRpbwshQ
	GZpddD4zPuhy386gfGqYe/XrGNK+H8aAKTkc9zmb4vKLn2klKo/9cGFparH2mRKIk1GvoHHVV7y
	tmT5Dwf3IotbHUIEh6qClGE4zBefCZEzn2hlX1Hs+EhuNGklLQp8VIhkooQY20EQpONlmJycCsa
	I=
X-Gm-Gg: ASbGncv5hnDggQct17N6lWGCUrP1cX11KFGggTEbiDYIY7vB5LxHGp7wx6sPYZH4BQ1
	B2CNC08GR3DGzkgRRPx5LbtORy1+k1z7DCUcmQg67ZyYt9xD8pP0vpMpRnLNqvoqfkj7rm88Cas
	IhCQC9SNFHYv9kBFuclWNedk1Pg5dI2BFztq48An9mAg4fofIWkc4Xx2gB75c/zckLmGZGyUzC3
	WR/frGhkEXt1v8RzimtNQnXHOt1sukFxyw/FK8WyHwTl1Lpri+xSkJIsENSWu6mZs+sxeuvS0a4
	2pDMEBnVujfafVuvSoJ5fKlYi5CwREdbf2lCUFuf/hi+QzvmGy2U6WYwKyaVQTLn9MDPKCj8DKg
	HnoJ/j02SNGrcrHgh2xBQ/g==
X-Received: by 2002:ad4:5d6e:0:b0:797:1974:b824 with SMTP id 6a1803df08f44-87b20ff9b4bmr223114976d6.2.1760437407125;
        Tue, 14 Oct 2025 03:23:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEKxzrsLzDobgemeKdhYZPqXgWpoyRHcy59dE7ifDngcUZZgvHwzQzsiHxDFmOXhQjkcSYcbw==
X-Received: by 2002:ad4:5d6e:0:b0:797:1974:b824 with SMTP id 6a1803df08f44-87b20ff9b4bmr223114816d6.2.1760437406612;
        Tue, 14 Oct 2025 03:23:26 -0700 (PDT)
Received: from [192.168.149.223] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-63a5c3218a8sm11273684a12.40.2025.10.14.03.23.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Oct 2025 03:23:26 -0700 (PDT)
Message-ID: <49004d3e-7914-48ee-8705-ee86d1944166@oss.qualcomm.com>
Date: Tue, 14 Oct 2025 12:23:23 +0200
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
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20251013110407.dqpjdrdaw4gzpcy4@hu-kamalw-hyd.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: Q9yWBL54pWWsvXL9uZ7h6zddqCt5dOiL
X-Proofpoint-ORIG-GUID: Q9yWBL54pWWsvXL9uZ7h6zddqCt5dOiL
X-Authority-Analysis: v=2.4 cv=eaIwvrEH c=1 sm=1 tr=0 ts=68ee24a0 cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=dw0t6H4-AAAA:8 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=42BIMu8lzX7HwdldZjoA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=iYH6xdkBrDN1Jqds4HTS:22
 a=wVJa4CU9-Z26yuRAZDil:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDExMDAyMiBTYWx0ZWRfX4ATiIsGHUTaA
 CVlGvMHfZudq9kdFmIjC0qYrx4iOqEfKQrR8UxN8911k5RZti9sT2nkAldQ85Ar5jstBvK7+ZfN
 Zn51wSezzNxqPenZmvz7C2+1wpzzKwthpha857/Xlp7fc5N/DzcyaNGBWho7FS9tRkP7EBTAWAr
 kfXfZkTRU00AuZ7/1kWj5ENZ8qLlUjyLYEYRc+dtBwGmglWzGcBzSZxR1fl0whsjvrgZSRBc+pN
 ryy/15tFWfulTupmp6qj9eO6JEtDvsdx9HVuBzqjZVvaY+X5MSvgNvQ0YCMnMOKlZnlvf7YdO8E
 k/VVasEY+zGL/WXOEItEy69SKbnh2np/GIn5gC11RqbhoorqVafjcVd8DSIOp9no96Zf8ebf1Ed
 UfdVSfiK7JnvubNn2VsSkMVg7LGNfQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-14_02,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 priorityscore=1501 spamscore=0 impostorscore=0 phishscore=0
 adultscore=0 lowpriorityscore=0 clxscore=1015 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510110022

On 10/13/25 1:04 PM, Kamal Wadhwa wrote:
> On Mon, Oct 06, 2025 at 04:28:59PM +0200, Konrad Dybcio wrote:
>> On 10/1/25 2:23 PM, Kamal Wadhwa wrote:
>>> Hi Krzysztof,
>>>
>>> On Thu, Sep 25, 2025 at 1:41 PM Krzysztof Kozlowski <krzk@kernel.org> wrote:
>>>>
>>>> On Thu, 25 Sept 2025 at 15:34, Pankaj Patil
>>>> <pankaj.patil@oss.qualcomm.com> wrote:
>>>>>
>>>>> From: Kamal Wadhwa <kamal.wadhwa@oss.qualcomm.com>
>>>>>
>>>>> On Glymur boards, the RTC alarm interrupts are routed to SOCCP
>>>>> subsystems and are not available to APPS. This can cause the
>>>>> RTC probe failure as the RTC IRQ registration will fail in
>>>>> probe.
>>>>>
>>>>> Fix this issue by adding `no-alarm` property in the RTC DT
>>>>> node. This will skip the RTC alarm irq registration and
>>>>> the RTC probe will return success.
>>>>
>>>>
>>>> This is ridiculous. You just added glymur CRD and you claim now that
>>>> it's broken and you need to fix it. So just fix that commit!
>>>
>>> I'm afraid, but this is an actual limitation we have for Glymur
>>> (compared to Kaanapali).
>>> The RTC is part of the pmk8850.dtsi that is common between Kaanapali and
>>> Glymur. On Glymur (unlike Kaanapali) the APPS processor does *not* have the RTC
>>> IRQ permission for the RTC peripheral.
>>
>> This is interesting.. is that a physical limitation, or some sort of
>> a software security policy?
> 
> This is mostly a limitation for all compute targets(like Glymur). On compute
> targets we need to support ACPI TAD feature[1] this feature uses the RTC alarm.
> In a nutshell, this feature implements 2 times - AC ( adaptor power) and
> DC (battery power) timers, and based on active power source(AC or DC?) at the
> time of timer expiry device will either go for a full bootup or stay in power
> down.
> 
> This feature is implemented on a different subsystem (SoCCP subsystem), and
> since the SPMI `IRQ` permissions can only be assigned to only one subsystem,
> so we can't use the alarms on APPS. This is why we use no-alarms DT to register
> RTC device without alarm-irq support.
> 
> [1] TAD specification - https://uefi.org/sites/default/files/resources/ACPI_5.pdf
> section 9.18

Hm, is there maybe some sort of an interface to talk to the SoCCP
and set the RTC as we wish, from the OS?

Konrad

