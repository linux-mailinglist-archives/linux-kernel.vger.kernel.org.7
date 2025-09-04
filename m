Return-Path: <linux-kernel+bounces-800354-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF73EB436B2
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 11:09:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 85B025A0A13
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 09:09:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 476852E1C7A;
	Thu,  4 Sep 2025 09:09:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="YdyfcqvE"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05BEA2D12ED
	for <linux-kernel@vger.kernel.org>; Thu,  4 Sep 2025 09:09:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756976975; cv=none; b=UtN2BElz+78c6EVy7Lbe8QhxLLQh9rw4zpUCEBuUkhGFIhSS4fFvZJT8Um25xDu3ciOCVlUoWptzTeH/KSFP3xtgWyvKbUcmLfckZ1Z/PfYk83MLR/3lPkKHF4/V1cJVg+XuvCOhpynYeKUwaKuNWFQJ7DctvkmHsdowR5Pd7F0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756976975; c=relaxed/simple;
	bh=4ptoiSOZlq45IhzsxQ+TLFRPqh1OeqRTDKOR1x62hAk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=T1AwMo1thtwjLJJB9byrMz7GpNouoa0wVVfdZociO/IoIrQwgaq4RTyJAaskXJPCprLZPZoAtwcWJ6DFp5Q3GOcjIpk1ukgA2T8cCUAz6C1fvqqX3A5F1JBA+l+KOBXMY6mBuFkeoOU7ZulFMsFSM8muAu2G2HcQxw6d27Abvgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=YdyfcqvE; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58404AtB005224
	for <linux-kernel@vger.kernel.org>; Thu, 4 Sep 2025 09:09:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	oEtWTL0H62zWsGIet+ROceeIy3NbZhQkPlZImunblTw=; b=YdyfcqvEQkV3GQI0
	5/Q5nyeSW796cd8nuFJMf1mMsFXX8lL1nN3UddTSu1RKF4WMY8VACOV3xbeQaeQY
	AFgeUOFnro1tN8gDcyFD2b/c2W2AhfyqXCxInzlXaqI5ScSesFf30CpylM3oqh95
	eiQjGZ5jJyLGsVSfp7oyWtLSCniWXwnbealRBWTEa+5ri3P9eCjKaeM+mppxZSSy
	dLCKqJk1YUK6VoxqQJn+NpvA2z4p8phxmagr23o8rqtXnOKmuukoW/8vAbcCVPaf
	P1+mM6iCRn23T3oNd0YdnVbfDZ3CZs0iUuC9DJZLA57028CqArENLKyldcbBPZWr
	jQGCMg==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48urmjpv82-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 04 Sep 2025 09:09:32 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-b4e9b55baceso875401a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 04 Sep 2025 02:09:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756976971; x=1757581771;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oEtWTL0H62zWsGIet+ROceeIy3NbZhQkPlZImunblTw=;
        b=agN3SxB4W330QyWf3uMzdHy+PcupmpEgh/F1fA6eecPA0cIWuVhCQKqMAprryMrL0q
         iV1D1H5TwA5t6YufPuAN/1OWbYdU4sfZ/D3SZaqvlyoJOZ/qHkDyJ4zx5Tk16cZab9Nk
         u3Gf70oDv5NTwA6Q8l6BFrxNBeNuOOksGUQKsxQq1eDJAWbQVp38uHdwhLZPy5m/5l8U
         b3L9ZFVIIzaC6fC287wyG87Iz6bj/YL9yAiXlGlP1Etf+7Q1TVlPy8n7YMSGrmpWp2Vm
         7yrg8T/Da4e9/6Vl/2OAvV66MZmN7zK3x306CHh8rpwTzaboTf1EQAsDAKo0fY3dMKut
         /fBQ==
X-Forwarded-Encrypted: i=1; AJvYcCUO78lDmEwjuOE5BUMPVokSroJ8iNxXwSond8AKzJa2a3+ySosRstiUlPg6m0Z+ZyzVDwdMSGmsp0WfqvE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0PpDMRkItLjjVncBywuoJS4bxJVUw9kqWySni00B8JuCf0rTp
	x+XcDSwPcUmI9bpHICpomDT7PRGIRolrQhb01o33usl4QNjQWX1CZEhqoK7PmkQwqpfpeq+uXZM
	BStpNS8sJDGa1+pR778rFdmO8aJ60J3vLy5+rePbwjLzG5WlQaVS05plLMq8ZwP6F65I1zJ4kme
	0=
X-Gm-Gg: ASbGncvW3bOynFGkTcaac1yebzuM3BAoj2urr180DvSmVMGh0w6j/QbcA+WJh8u/hHu
	tjuV7yHFB953n4yA0Opw1AqxKP1Z4lfbMUGULKMQPOqteer/ybgG84kEnwecolBVvXocIq1j4oO
	mUsaf9JY5FuVDkEOON6tU3QabOcYZHUG/aHCcD+LXu0wKyWgxKUFY9EBclNmNSkU3ePpRJ1DJzR
	Q9bZY1pWCyZIsR+1wJ48NoIKqP0TYcgfn4rnPZENkoEdtTO7DV89LDvmjGw9Da1ghWV5+aYVQWY
	oaaoJHgHX+56XhOpkVuvyxIRXoEKah4wHDMTQqTCAjj5DZBavs2iHwO4C/BoB73tnWal
X-Received: by 2002:a05:6a20:3d05:b0:246:5be:ca74 with SMTP id adf61e73a8af0-24605becd4emr8441771637.31.1756976971043;
        Thu, 04 Sep 2025 02:09:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHLv+hn51mr8k9PeObgZVml5EeyzkCqh5Ccxi7rWL5vvE9UtLeMLYyJeRakW3elUbjIcyYVeA==
X-Received: by 2002:a05:6a20:3d05:b0:246:5be:ca74 with SMTP id adf61e73a8af0-24605becd4emr8441738637.31.1756976970531;
        Thu, 04 Sep 2025 02:09:30 -0700 (PDT)
Received: from [10.218.10.142] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7722a4bf561sm18976292b3a.59.2025.09.04.02.09.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Sep 2025 02:09:29 -0700 (PDT)
Message-ID: <745a2b9c-078d-45eb-97a7-3a27a4bc5191@oss.qualcomm.com>
Date: Thu, 4 Sep 2025 14:39:26 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] usb: dwc3: Log dwc3 instance name in traces
To: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20250825114433.3170867-1-prashanth.k@oss.qualcomm.com>
 <20250828224852.ukelgargocektp3z@synopsys.com>
 <5b30f63a-5999-48f1-972f-93f02fcc0ec2@oss.qualcomm.com>
 <20250902234450.vdair2jjrtpmpdal@synopsys.com>
 <67329e66-2221-426b-88a4-eece06d694ec@oss.qualcomm.com>
 <20250904000003.b4j7fnucronjf6ej@synopsys.com>
Content-Language: en-US
From: Prashanth K <prashanth.k@oss.qualcomm.com>
In-Reply-To: <20250904000003.b4j7fnucronjf6ej@synopsys.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=OemYDgTY c=1 sm=1 tr=0 ts=68b9574c cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=VI8qmIfRFIV6H3Uo1AcA:9
 a=QEXdDO2ut3YA:10 a=_Vgx9l1VpLgwpw_dHYaR:22
X-Proofpoint-GUID: bBmPS6S19CxbuuFlZR-z5l7yDAmKQo0x
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAyNCBTYWx0ZWRfX6jiLhXm5SRSG
 XECxJRng7fEOD4Y49ueCGENeVomTRiIp6XnL1ROM81WFJoayxZYJvaGFoJLp+K4yX5uzF99hZ4L
 afEcef96G4hqJsKF4xjvRtxs6bNCPk5X8QdAbodmlbGn9go4OUH2miwRN3xRBovOA94MUOY+XV0
 fDwd8itoQZCqFTEWhrbC/Szx2S/Mf8gHm03qK4PAKt4C2WUwMRBK0We5niqF5Ihe59MyjvDGV9K
 RSp6F/JLfRdxccvIJRSMxIwJR3FkodHDEUGx3U8u5EOZet69CEEpIxr7E9Kk1T/M2apseEzTR+H
 0fAA79SXDUEQwmKLxfobe0IrS7+TcO23tFgnKXfDpOmm2BenD/S1Kj6BoXId8Zaqn0qEEbMQsCh
 uKyLis7u
X-Proofpoint-ORIG-GUID: bBmPS6S19CxbuuFlZR-z5l7yDAmKQo0x
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-04_03,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 spamscore=0 bulkscore=0 priorityscore=1501
 adultscore=0 clxscore=1015 phishscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508300024



On 9/4/2025 5:30 AM, Thinh Nguyen wrote:
> On Wed, Sep 03, 2025, Prashanth K wrote:
>>
>>
>> On 9/3/2025 5:14 AM, Thinh Nguyen wrote:
>>> On Mon, Sep 01, 2025, Prashanth K wrote:
>>>>
>>>>
>>>> On 8/29/2025 4:18 AM, Thinh Nguyen wrote:
>>>>> Hi,
>>>>>
>>>>> On Mon, Aug 25, 2025, Prashanth K wrote:
>>>>>> When multiple DWC3 controllers are being used, trace events from
>>>>>> different instances get mixed up making debugging difficult as
>>>>>> there's no way to distinguish which instance generated the trace.
>>>>>>
>>>>>> Append the device name to trace events to clearly identify the
>>>>>> source instance.
>>>>>
>>>>> Can we print the base address instead of the device name? This will be
>>>>> consistent across different device names, and it will be easier to
>>>>> create filter.
>>>>>
>>>> Did you mean to print the iomem (base address) directly?
>>>> I think using device name is more readable, in most cases device name
>>>> would contain the base address also. Let me know if you are pointing to
>>>> something else.>>
>>>
>>> Yes, I mean the device base address. PCI devices won't have the base
>>> address as part of the device name.
>>>
>> But the base address (void __iomem *base) wouldn't be helpful.
>> Using the base address, i guess we would be able to differentiate the
>> traces when there are multiple instances, but it wouldn't help us
>> identify which controller instance generated which trace.
>>
>> And for PCI devices, i agree that it doesn't have  address in device
>> name, but i think we should be able to identify the correct instance
>> based on the bus/device numbers, right ?
>>
> 
> We may not have the PCI domain numbers if it's a child device as in the
> case of dwc3-pci or dwc3-haps.
> 
> The base address _does_ tell you exactly which device the tracepoints
> correspond to. The device name is inconsistent between different device
> types and only relevant if we have access to the system to know which
> name belongs to which instance.

Yes, I agree that device name would be inconsistent for different for
PCI (and HAPS) devices. But IMO using base address (virtual) would just
make it more harder to read and identify the instance.

Perhaps we can cache the register addr and use it, what do you think?
Here we can at least differentiate the instances based on HW addr.

snprintf(dwc->inst, sizeof(dwc->inst), "0x%08llx", (unsigned long
long)res->start);
dev_info(dwc->dev, "addr:%s\n", dwc->inst);

Output --> [    4.521746] dwc3 a600000.usb: addr:0x0a600000
Regards,
Prashanth K

