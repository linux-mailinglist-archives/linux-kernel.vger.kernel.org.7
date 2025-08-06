Return-Path: <linux-kernel+bounces-757246-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F1CEB1BFC1
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 07:05:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2D80E17B7B9
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 05:05:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C0FB1F03C7;
	Wed,  6 Aug 2025 05:05:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="N7+wXG3F"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26EED78F43
	for <linux-kernel@vger.kernel.org>; Wed,  6 Aug 2025 05:05:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754456718; cv=none; b=svP2BorKm+9kQ1WBeDnWxp/2VpvRHxsr91Jsx7jWPbfsa3canY9/ht29huqRm9uu99/UIh0ZKhZEVgOegTULUQmRvGWzbzZWljlTSVf5WWL7DzUJdvxGs3V2izxMJe4B+YtzTnQFXwOemzH8RLwpLwCboddavmAv7mZiXlTY/qM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754456718; c=relaxed/simple;
	bh=PVqQ6wtrl5nEpndbCzGcHw0CEmGNEvKloJtWxKXQeEo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IRvZp4jjHST1mM6S5RN2PUofUZpjcAt2Zkd6D3r8SgsPbqvWFTXntNLZ7sFjZWEl9zXmNxrtybkqJudHuqHn0xBKiu612PA/ksNaQbqFBe2fcT/Y1ApB+avnRnFJi3pnsvS3Tvcr8mW0BQtio7svFJtPhlDdhmwB1sKCovcAyBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=N7+wXG3F; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5761ens7000746
	for <linux-kernel@vger.kernel.org>; Wed, 6 Aug 2025 05:05:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	eJpmhwp2+qNhNACvd0DwKsKdUDtzWWHlSvICRJ6COMI=; b=N7+wXG3FLdjCgtOB
	Byi1fwQzkP2HjqFlMEH5ywgV1+OqEV5l3I8SHADlDzR2Ec9CM/4pKz2/v1bKunAH
	f9oMwDYCxJSgC4NnBJOB4qkr/V4w8dXEtkOtH2VRr4h5GWMXB/z/4eJK6neoTqjF
	e+rxdHZCEaOtHHWTh+XFLRZDIS6PIBK+WyaFPsbCWQX+MNo9avpZEDsi5/wAeDR2
	bM+VrI4gmP4oLy+elg4ope3+fjlJf2uoafDT13mqD27na3+BD2gwba9Wr9NpwPRM
	FpiF7WAbOCjH2OZ6ZSf7G2sEnLWxaHGswHqcGWfd/ehLLr+K3m3cb+7pxry3Wpb5
	5bTQNw==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48bpy6sgcf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 06 Aug 2025 05:05:16 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-b4227d86246so4404794a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 05 Aug 2025 22:05:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754456715; x=1755061515;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eJpmhwp2+qNhNACvd0DwKsKdUDtzWWHlSvICRJ6COMI=;
        b=l8CMXFWfDb4Msq5vTJIy/250neYGG19Ud5l0b2I6Jvni3vh/DiquIIJXUZMulfeofa
         YxA0h2dETW1gcci7f+2Ja6PvuuHTqkvf0++0dXjCcvgAXHWnrpIs26LhrLzy+rc3hdIJ
         zxw1/iwDYfiZc9jPUsCLMPrWgSOHV1t054/02baNCLLOYi3N+4m3ewtjPTnoCU5Ebn0j
         2FTlFVZCNLlLf9L5XKOXlZfhCVSyxV3ZOFhVO9Axs0I4MOgsID3mNyubObwJWhlqwDs1
         v7qbvPfRuzROWdCnRTfcDhhfnDsYdMkuvTWd++mX0kLks4v6pAqW8y7vHpx33CfAcsio
         4ADQ==
X-Forwarded-Encrypted: i=1; AJvYcCU2RHHvpm5vEuvBR3bBl5MNmQ+vfwHQZX+Ir0opJm1uTBpTBrvRvysk8WyAz+4e0cx6uMN5svXfrRZsPTk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6PDQSQo6V8UKQSqUcaMFHYCP6lLv6vQcf8oTv7UMBVkcxo0L4
	AJsiXpvNnx+HsObKAePh8tSxtqTJ3zN6p9I+/5oF5wRaPuB8ceND1G7qr1U0A4AaML6s9BkHZ8B
	wZqplBru9Ixin1e8cuVm4hq5UHgAK8BZNauMOdJ7z/kctRl8wtzR8xvaY0A3KeEt6w8M=
X-Gm-Gg: ASbGncv/AgFpxAbIUdX5rnpZZFKyCvHymO9DcFqv7VI/K5NUkgHMYN70xqoFRi4MsgT
	89g/GvbgQFAYCDUcaATGJlZz7gxRAZHwoZp63b9rIO0BATtUajuCYzNSmDmn17bKLI3nNLQG8V7
	561atQ9+ngPUT0F4rb/74B5ZHrOufnEGWDCBM94i0AEm+BmGzL/k8LwzyU+QjWzofwzVHCYk8AG
	/ThH5B14ddH8rAQFhtaQQwHNY+i8q8DR/c7TCaE8RtVCJ7XvL0x+zcuxEpSTH2CuooON9UjfgL2
	RJLzqgWIWaVcUb9M3W0QlRXSpobZAXP17ihrUeYBtqZxnp60zDecCKS7D+I1cw7z8TpfX6fbWA=
	=
X-Received: by 2002:a17:902:e742:b0:242:3855:c77a with SMTP id d9443c01a7336-2429f42cd9fmr25385485ad.34.1754456715107;
        Tue, 05 Aug 2025 22:05:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGO4P/gghaw5vcTbD4LFu6tD+0oWLmkEJgxeJd+4qKXvJVceZgq/qMoTJ7ZbXwzENC0yZlQ1g==
X-Received: by 2002:a17:902:e742:b0:242:3855:c77a with SMTP id d9443c01a7336-2429f42cd9fmr25384945ad.34.1754456714518;
        Tue, 05 Aug 2025 22:05:14 -0700 (PDT)
Received: from [10.218.42.132] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-241e8aaa829sm146510685ad.149.2025.08.05.22.05.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Aug 2025 22:05:13 -0700 (PDT)
Message-ID: <6035a961-7c5a-4fde-b4ea-e9ea9d88e6c1@oss.qualcomm.com>
Date: Wed, 6 Aug 2025 10:35:05 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] opp: Add bw_factor support to adjust bandwidth
 dynamically
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org
References: <20250717-opp_pcie-v1-0-dde6f452571b@oss.qualcomm.com>
 <0dfe9025-de00-4ec2-b6ca-5ef8d9414301@oss.qualcomm.com>
 <20250801072845.ppxka4ry4dtn6j3m@vireshk-i7>
 <7bac637b-9483-4341-91c0-e31d5c2f0ea3@oss.qualcomm.com>
 <20250801085628.7gdqycsggnqxdr67@vireshk-i7>
 <7f1393ab-5ae2-428a-92f8-3c8a5df02058@oss.qualcomm.com>
 <20250804111340.t62d4y2zg77rr3rp@vireshk-i7>
Content-Language: en-US
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
In-Reply-To: <20250804111340.t62d4y2zg77rr3rp@vireshk-i7>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: T0NJgkaia9l2P54ttmsBQmKmfitOI9xy
X-Proofpoint-GUID: T0NJgkaia9l2P54ttmsBQmKmfitOI9xy
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA2MDAwOSBTYWx0ZWRfX4e3uRN47pl8u
 AAX52njCrSn5xim30ELiVgVvfwkebX+sCP2NpolYqJcf3gjatl/dVeiSGeSSa5AO+94Mb1YWNdn
 f9KBVMCODUOmpNnMg07yx6BPl5cTCys05J926ITy5kIXucpmYxX7zt5rLjCoHD1gsoIvbHtonVQ
 Fqw4I0kxgaX3y259kd68iTolvKbuGhz1UPGTdjjx6uQQ2m0Pd/n7RyVn65/s4zzhUExeYMlgwVD
 k6RqqORlBKA7vg8gxV+bbndUHoOcVysF1GuoXu48K946IiHN/dtX6kt5OYCk5kjVXAerVcr97Xy
 4ZaIVUBrIuvOmID4mijnOflVS+Ra8ch3jGjg/CdfQWcBqashz3UjITYmlAy2mYSZzEk6WKCe+Dx
 AFMyNQx+
X-Authority-Analysis: v=2.4 cv=LNVmQIW9 c=1 sm=1 tr=0 ts=6892e28c cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=GvZj0uSKTECx7ubp4XUA:9
 a=QEXdDO2ut3YA:10 a=3WC7DwWrALyhR5TkjVHa:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-05_05,2025-08-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 clxscore=1015 malwarescore=0 adultscore=0
 phishscore=0 priorityscore=1501 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508060009



On 8/4/2025 4:43 PM, Viresh Kumar wrote:
> On 01-08-25, 15:05, Krishna Chaitanya Chundru wrote:
>> Currently we are fetching the OPP based on the frequency and setting
>> that OPP using dev_pm_opp_set_opp().
>>
>> As you are suggesting to use dev_pm_opp_set_prop_name() here.
>> This what I understood
>>
>> First set prop name using dev_pm_opp_set_prop_name then
>> set opp dev_pm_opp_set_opp()
>>
>> if you want to change above one we need to first clear using
>> dev_pm_opp_put_prop_name() then again call dev_pm_opp_set_prop_name
>> & dev_pm_opp_set_opp()
> 
> dev_pm_opp_set_prop_name() should be called only once at boot time and not
> again later on. It is there to configure one of the named properties before the
> OPP table initializes for a device. Basically it is there to select one of the
> available properties for an OPP, like selecting a voltage applicable for an OPP
> for a device.
Then we can't use this dev_pm_opp_set_prop_name(), there is possibility
link width x1, x2, x4 etc can also change at runtime.

- Krishna Chaitanya.
> 

