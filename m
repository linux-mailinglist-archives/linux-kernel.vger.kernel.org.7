Return-Path: <linux-kernel+bounces-797807-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AD18B41599
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 08:52:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0C7D71B6224F
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 06:52:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FB592D8DD1;
	Wed,  3 Sep 2025 06:52:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="XQDvF9wB"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6205C2D94BD
	for <linux-kernel@vger.kernel.org>; Wed,  3 Sep 2025 06:52:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756882334; cv=none; b=BkxlPGkBCuuOOEtEkBgKOaZ2Y+epneaCRC/csF2xAB/Q8gLM+GBGQTXbcq8fwJL+5djle2AN3OoMSl3j8orClte1rhnlknxv5qK4DwOggVmihLRr73cZWAKV3tbey80wlyhAYAuurxJ6bokg8cvFGmm/sTTiHc9PWK6Vh3QkTYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756882334; c=relaxed/simple;
	bh=QHyI31iXOsXHQnr+3AzHnSOgkcOzBaLTCdzD2n8E34A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ft1KTO7YVZ5qZRqqiqgeBpuMo31NBbjJONRVmchHQq0ox7FfpuowCwngJ/wcpMtvO9btfdlm+lNx5p9pCo5mfq2KMokdCTptQpABvFShNlLKA4P4Ie7Qk+HSu8OApM2DOqGlAbEmhzzrRxqeGAmjyMTyT66GNElijXrqZSH9yEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=XQDvF9wB; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58329TWr019572
	for <linux-kernel@vger.kernel.org>; Wed, 3 Sep 2025 06:52:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Xh06HkTHgX0IXaOaZlgESddUPOj5qIUQ3p3Th2I8MiM=; b=XQDvF9wBcIRTT8MT
	taZneGfSYagOEw1rJJoH5mmX5QrcgoreB0soLZy8sD5MUOfSxjTX1T31eN5AEVX/
	+NHxZk+S5F79NA0oCyKMVT204r4n6BhI+PwQby2vZYRgiQy/ALq8N9OaJgwlCHST
	fK1M9lHfFt0D7D6sTQTOkNmhJmuxRh5Jwu2Gy/GEurQDHx/ysMGEKY3juKDBGdXZ
	sfN/eFWN7pb8MiAWY/UhfHEvh+6dFi84CAS/DYY4HuSPncblQM1nYissru2iOPYF
	C9/yydygRHFnxWu8OWjWvTUX0aGvosXyYfXdEiJf5trDmXu7TKLTeXJljfKgKAUO
	G+B6yQ==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48urw02j7b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 03 Sep 2025 06:52:11 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-772642f9fa3so621472b3a.1
        for <linux-kernel@vger.kernel.org>; Tue, 02 Sep 2025 23:52:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756882330; x=1757487130;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Xh06HkTHgX0IXaOaZlgESddUPOj5qIUQ3p3Th2I8MiM=;
        b=H9yLcyGHZ0nrUNdI77zwov8aNaaDqPAjrsCQj3impeTiszfj2ueQxOCq1HS05Eahrp
         vcLNpIyYeU4b3wyaXJxsJwRHxt3/UXxncHfAs1bdJKwfUfgB2/f2Pn51eovNNWsrYJR8
         BnJ9U8/ff59A+hfx+8SVhZWH6kP49koFmITuseEXZheab6CXx+MQIrxoVUG3/CJR0HCI
         ZsDxDrTZV+gz0s6WQFaP4eixXF331RnxwX26qblvBMC+4ATS1AOlNE2szhN2sCIWYhC1
         0Xu/u9NAqxhnproNwacixLDYxIqC+t1yAq/t7cIv1953itQN2A7ghe3yfNuKiZVH/T1f
         q11g==
X-Forwarded-Encrypted: i=1; AJvYcCWoMo3cDHNT0GwdqHcj4sD4AP6wPd22ScoQ4/lnSLXZYL/EYNG9jB1NmURV6ia29jZf3Dr3jNW4eCZNbUo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxk6O+WU5Y35ufOst+7RsHlK0+pSa2TG0hBNpdKh46zk1k6V5cG
	Zgo3EEaOwYUAyADbXi4DkzhODCxlMXHhjkUXaCrsFr4TQXw3UEqjjelOSUeeHCeAn2T8LWQl+s2
	iUsCMGOOeOM67BlXaff9DT/P5994hautR1j1BEi4XhEd53L6RWiCziEPozC8w0xx/hpgTU+aT6m
	k=
X-Gm-Gg: ASbGnctEbpq5RELNmNN5ktxYs9uq9SWy/urFwDkiDGTOsWd0W7QRIEIDiT2x2yrXk5M
	mvefpYEJty9TvPfA7kxYoD2gLVVCHXni2/+5XjV/hZVAt7raUTkmnuGKW9LseSyrSKZ5R6cKJ0x
	zsQG1JoXJr9ZjLN40TlBuN9J3ZcpQWi508F9DxYD54C8kA9pTkj3Kpn07+9+JR1PhtoTF19w1xb
	7pDgmdzrOc/Xek3u6YVqX3lm1lpK1jO4Lhs075d7N2hsHlxVVrNilazyS7pnFCmJPFmh5aaqAUn
	Y1h8Wy0n+q8VQhQEfwzXZH8e01xaKzHBqUMRuWkdoqwEqmAm5tcYAHMEzMwnOxP6ZsZP
X-Received: by 2002:a05:6a21:32a4:b0:240:cd0:b18f with SMTP id adf61e73a8af0-243d505ce60mr23025637637.4.1756882329654;
        Tue, 02 Sep 2025 23:52:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFXajHBDkYe23FL7mguuC493CU9o4nYUdXepF1r/U+XRkTqaTve2Jr243ltR83czIWc5OLoOw==
X-Received: by 2002:a05:6a21:32a4:b0:240:cd0:b18f with SMTP id adf61e73a8af0-243d505ce60mr23025569637.4.1756882328812;
        Tue, 02 Sep 2025 23:52:08 -0700 (PDT)
Received: from [10.218.10.142] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b4f8a0a3948sm5981277a12.27.2025.09.02.23.52.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Sep 2025 23:52:08 -0700 (PDT)
Message-ID: <67329e66-2221-426b-88a4-eece06d694ec@oss.qualcomm.com>
Date: Wed, 3 Sep 2025 12:22:03 +0530
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
Content-Language: en-US
From: Prashanth K <prashanth.k@oss.qualcomm.com>
In-Reply-To: <20250902234450.vdair2jjrtpmpdal@synopsys.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: nMe5AuVoP6gNB0XjkAEWLHEKDI5OWpsg
X-Proofpoint-ORIG-GUID: nMe5AuVoP6gNB0XjkAEWLHEKDI5OWpsg
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAyNyBTYWx0ZWRfX2eOcSCbHRt2Q
 CiLOwyyeAiwMfLSHYZyLDvbhZIlCUrJRHQ408q3oi4v3Z2yvOxdMa807ipikMALhWNVZ4wTfEBr
 tuU5/ixay9Cf45w6KBKEYFsqKspMWwYR91mDrFrbc8AEHPc9/voVepObyge5nyKALfXpuRhSmdJ
 A6nUJLKUczbFfpbpmQv7HsGlYBOlMNPYqwSMx3knsX1gWzACnUsK4jPIwB7faNdTAh1GgspFCeg
 TgKS4CH8UwoAykEub6auYLJ6ZqPF6BP0sY9+Mfyh0oHmUs71nWH4/+clIB0dudg8F2zYnAC8cqN
 Ph6z+5muLgFZNWV2+zp9FNrATqS+rVfIh6f/musFzCZsQlT4aU8u+1u9ollE/N3h+wGEaxP0PLZ
 4VoO+XOr
X-Authority-Analysis: v=2.4 cv=NrDRc9dJ c=1 sm=1 tr=0 ts=68b7e59b cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=k2XJ8v2PsYtg0y1r_vcA:9
 a=QEXdDO2ut3YA:10 a=IoOABgeZipijB_acs4fv:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-03_02,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 malwarescore=0 priorityscore=1501 phishscore=0
 impostorscore=0 spamscore=0 bulkscore=0 adultscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508300027



On 9/3/2025 5:14 AM, Thinh Nguyen wrote:
> On Mon, Sep 01, 2025, Prashanth K wrote:
>>
>>
>> On 8/29/2025 4:18 AM, Thinh Nguyen wrote:
>>> Hi,
>>>
>>> On Mon, Aug 25, 2025, Prashanth K wrote:
>>>> When multiple DWC3 controllers are being used, trace events from
>>>> different instances get mixed up making debugging difficult as
>>>> there's no way to distinguish which instance generated the trace.
>>>>
>>>> Append the device name to trace events to clearly identify the
>>>> source instance.
>>>
>>> Can we print the base address instead of the device name? This will be
>>> consistent across different device names, and it will be easier to
>>> create filter.
>>>
>> Did you mean to print the iomem (base address) directly?
>> I think using device name is more readable, in most cases device name
>> would contain the base address also. Let me know if you are pointing to
>> something else.>>
> 
> Yes, I mean the device base address. PCI devices won't have the base
> address as part of the device name.
> 
But the base address (void __iomem *base) wouldn't be helpful.
Using the base address, i guess we would be able to differentiate the
traces when there are multiple instances, but it wouldn't help us
identify which controller instance generated which trace.

And for PCI devices, i agree that it doesn't have  address in device
name, but i think we should be able to identify the correct instance
based on the bus/device numbers, right ?

>>>> Example trace output,
>>>> before ->  dwc3_event: event (00000101): Reset [U0]
>>>> after  ->  dwc3_event: a600000.usb: event (00000101): Reset [U0]
>>>>
>>>> Signed-off-by: Prashanth K <prashanth.k@oss.qualcomm.com>

Regards,
Prashanth K

