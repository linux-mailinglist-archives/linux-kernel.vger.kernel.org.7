Return-Path: <linux-kernel+bounces-779173-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 300BBB2F005
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 09:46:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5AA3B3BC0E2
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 07:45:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB00E2D3218;
	Thu, 21 Aug 2025 07:44:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="i9tek8q5"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CD6F2E88B3
	for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 07:44:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755762288; cv=none; b=ajRGDwZ0v7Mz9QzavPKDeeRNM1B3dupYmUAB3kpKJ6W/VGyBzvnHp5AK4x2rkY9KKaHtpFWlYztV34TGA3qSNGNzjIx6R42QUbwMo56Wjm2vKKZt5q5ZNh4OC68dX8MofCfa9eMbqVJPAxWoK1WKcvJNgeUXU/ai55/R1dO+C/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755762288; c=relaxed/simple;
	bh=xa3DIOO7y1glNzGRuazUnZc48zCXNjkfWK2VUj9m5lY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Vw4RhWdZJbWnAXyMzvPOBBmfLGTRkRnfBln6SDGGfj06Pi0SGYRrJOcz0D9aX8VTY30j0OjwKq3n/2aiG1BsLjRs6jPXq92W5kTpO/jNr91GgbizVCr+YJa3n1RESSI6EfbkJlRc/ZFNUuTUVyWxolHEiKk3YSGtkqhCfe3rHvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=i9tek8q5; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57KJJ1j6002009
	for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 07:44:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	2G0jmrcoufd+8ZCF18bJzb+Xt0es+kwirLRdoPQfQUk=; b=i9tek8q5zP7VBerF
	OFJZaZU7TOs8DKlGS4fsHG7Ekm1g+/rqLfpQpRq8HWo+ReDcxCztYHPVZ21fkg3f
	r9rf0X/EpOHLUomn1DeyQZqunbcj5TSupViTh3DAsbYwXcQy746ag07UJ/PKsYzS
	YUKgWso3WMcIRTAjtCMPJFaJeIskwFoW0dyqlduAYI2O+sj3o4zWgxh2K1SI1++F
	cXg7nrVH1Au6n+Js7jWhf3Egb6wtPnZYs8ma+js9P7GTyt6sNqJKRNiwM7HCynPh
	m5BUW6LpG0Ejg0A06sqPTb+j6TDadfS4LjD4H6z9QivXsydAFGp/1f0N/aqTDOfI
	I4xAHw==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48n528vcv1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 07:44:45 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-b4750376ca8so489624a12.2
        for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 00:44:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755762284; x=1756367084;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2G0jmrcoufd+8ZCF18bJzb+Xt0es+kwirLRdoPQfQUk=;
        b=htKnAY/ebdZtr3O+a7Cs4LqN6A4eeZ38iUVXv0IVPgiAWT2NUlxF4nIw6tMGxy+dQL
         q9AXcuNCrz058XvYyAbf3P4M4gBgbp+zgeus2cYpQBzEezigx5r2nTK3xa/uVBNDjg9r
         4jgu/B63mD8XzEXBWwUqCSBMyWK+wFCJtMpwtWT/C1Nrg+tuQu8OkHfIAg3J/ftUYlQs
         8YiFaA06hRZq8XK3sjF+5doEY3Wt2l33ARneIaI8RKW2ZRRskG/XQla5P4AzsiA9Y+Ld
         BheLbLZW6DM+c4T0wcDs40jEC7Y0WKHZWbp/n5/BVXKq/kB3ozQkt62lS9bTaMYew86U
         F9bg==
X-Forwarded-Encrypted: i=1; AJvYcCVnWfvy9E57i1sES6u7P5a57mNX8tj97/E1auqjZK2IZ70iRl+xzhhptkUWeHUxlQxHwOYwOBSPJ9SwUKU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/vDp7XRkoYDeMXDfQ15vAZROBjIMpJO+0S4hfw1p2cdEP3aGz
	WJm83Xo05ZbbRcOHMmNdZKzySc5a5smdH+qdgjVEbXeHrqJqjErHFvFAqbicHiHyDEknTHY3yKt
	L4R9sfReLCMQKMaFAcM80j2H/WPKNjwf3W83SmjfgLnJK4Nz4rFgNdGbbNWpeX9G5Ga8=
X-Gm-Gg: ASbGncs1dbGJ2o5xhMvDiVaEuTb4W9b4m9YMWWT2tEEQpzFCTYASRzzbmVqLgt6kAtO
	ibDlGAaHHvXsejJJaTAKcq1Ys335er77rDwZwxxp4vzzCiQDBa/K3Aal0cbEp0wXrmA24zV2ZJG
	CBqYeg5CDl3jr/lz/t3tJtgJD4Tg8FxAnsJOeRgMt2ke3YoWeYkTiPfsMXAUJN2Ap20LHtztaZL
	sftxEUKWYCZjXkgv5FeYqlg35Hqyba+QbOJhM89V7RPW0awhimOx/fJOd6jxn6/UAN218IoVX9H
	j503XyRBlRkDH0G96ANgEND1zLJwIFryLRYVpYoSfspuT30tzNcpi2JJtcJbylocZ9pzjV/dCSG
	ysk8v7RcPQOk=
X-Received: by 2002:a05:6a20:158a:b0:240:1f14:f6c5 with SMTP id adf61e73a8af0-24330ac3fd6mr1959896637.32.1755762284551;
        Thu, 21 Aug 2025 00:44:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGCYXhKxcZWmfeFwKM6Wq6qQQK5DHE77TncdGGZ0vJrDqJkBWEHm7E/yR2GbbuMTQR8tAX6DA==
X-Received: by 2002:a05:6a20:158a:b0:240:1f14:f6c5 with SMTP id adf61e73a8af0-24330ac3fd6mr1959866637.32.1755762284068;
        Thu, 21 Aug 2025 00:44:44 -0700 (PDT)
Received: from [192.168.225.142] ([157.49.248.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76e7d0d1a44sm7470773b3a.1.2025.08.21.00.44.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Aug 2025 00:44:43 -0700 (PDT)
Message-ID: <b711072b-11fa-ea33-3a47-d16ad5a9cc62@oss.qualcomm.com>
Date: Thu, 21 Aug 2025 13:14:39 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH ath-next] wifi: ath11k: switch to of_get_mac_address
Content-Language: en-US
To: Rosen Penev <rosenp@gmail.com>
Cc: linux-wireless@vger.kernel.org, Jeff Johnson <jjohnson@kernel.org>,
        "open list:QUALCOMM ATHEROS ATH11K WIRELESS DRIVER"
 <ath11k@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20250821032755.636661-1-rosenp@gmail.com>
 <86ddae9a-4931-b160-51a2-f89d45d4038d@oss.qualcomm.com>
 <CAKxU2N-0Q2uxw=-v-XP8g=Y=yBb2ufv+T0yk7dmaszwUy8Z6tg@mail.gmail.com>
From: Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>
In-Reply-To: <CAKxU2N-0Q2uxw=-v-XP8g=Y=yBb2ufv+T0yk7dmaszwUy8Z6tg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=fpOFpF4f c=1 sm=1 tr=0 ts=68a6ce6d cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=pagehsHO18wfKU6DcLw+7w==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=EUspDBNiAAAA:8 a=pGLkceISAAAA:8
 a=CpWlhAl6zUZw53vu2Z0A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=x9snwWr2DeNwDh03kgHS:22
X-Proofpoint-GUID: CsbfXgOK--NyyfZUAraYg8mnnUpBiFTM
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIwMDAxMyBTYWx0ZWRfXxfhUFFAqVV48
 JYhMXByr9/KVfNP2HGIIF+BeLod/lIL34raE5i+9jhxcnfSXsE6AQSdlhwGB4LDe0aE3aCaBZNX
 x059GcZ/QYIf4HsYCA3HzVVZ8BLhU2VThEeOYYbLR9uFl7TrMi6h37hFNTVp3wNWEteEPCLbDwD
 I7TRuGaXe9znarl2xVDHy6nusaKPcjAtMJ9zWsBg27s4ecRl0K9g3djv7Uq0IJ7gxR+nLQJ6/xy
 hDQdJsZZTt2mzJRLNMxC1FaDVWJH9UL9/Ee1YNFoaye+qVDIdkl0flyKCZ3y/Kpa6IF/gBXN/Xy
 INN58+CUxHteEJyG9jI8u7yOR7wPzTPIA/7I6dthC2HlhzXnoK/sV0SaquHPaXu0ZFqCBWT1E/7
 m70M8a7q3hQOIzgULqehIDMs6hkFAg==
X-Proofpoint-ORIG-GUID: CsbfXgOK--NyyfZUAraYg8mnnUpBiFTM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-21_01,2025-08-20_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 priorityscore=1501 spamscore=0 clxscore=1015 adultscore=0
 suspectscore=0 bulkscore=0 phishscore=0 impostorscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2508110000 definitions=main-2508200013



On 8/21/2025 12:21 PM, Rosen Penev wrote:
> On Wed, Aug 20, 2025 at 10:55 PM Vasanthakumar Thiagarajan
> <vasanthakumar.thiagarajan@oss.qualcomm.com> wrote:
>>
>>
>>
>> On 8/21/2025 8:57 AM, Rosen Penev wrote:
>>> This is needed to support nvmem defined MAC addresses in DTS.
>>>
>>> In addition, check if the probe should be deferred as nvmem can load
>>> after ath11k.
>>>
>>> For brevity, ACPI is not a factor here. ath11k is too new for that.
>>
>> This may not be accurate, pcie devices are widely used on x86 where
>> ACPI is not certainly new.
> No way ACPI is used to define MAC addresses.
>>
>>>
>>> Signed-off-by: Rosen Penev <rosenp@gmail.com>
>>> ---
>>>    drivers/net/wireless/ath/ath11k/mac.c | 5 ++++-
>>>    1 file changed, 4 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/net/wireless/ath/ath11k/mac.c b/drivers/net/wireless/ath/ath11k/mac.c
>>> index 1fadf5faafb8..801db15ca78b 100644
>>> --- a/drivers/net/wireless/ath/ath11k/mac.c
>>> +++ b/drivers/net/wireless/ath/ath11k/mac.c
>>> @@ -9,6 +9,7 @@
>>>    #include <linux/etherdevice.h>
>>>    #include <linux/bitfield.h>
>>>    #include <linux/inetdevice.h>
>>> +#include <linux/of_net.h>
>>>    #include <net/if_inet6.h>
>>>    #include <net/ipv6.h>
>>>
>>> @@ -10434,7 +10435,9 @@ int ath11k_mac_register(struct ath11k_base *ab)
>>>        if (ret)
>>>                return ret;
>>>
>>> -     device_get_mac_address(ab->dev, mac_addr);
>>> +     ret = of_get_mac_address(ab->dev->of_node, mac_addr);
>>
>> I still think it is better to keep the generic API and add the the one specific
>> to nvmem when the generic one fails.
> I don't. ath10k and ath11k are the only modern drivers using
> device_get_mac_address
>>
>>> +     if (ret == -EPROBE_DEFER)
>>> +             return ret;
>>
>> Please note that this error does not impact the device probe as this is
>> being done in the event path after probe returns withis complete.
>> Also, this will result in device registration failure even when
>> the device is not really looking for mac_addr from nvmem (or it is not
>> there) as firmware can also provide the mac_addr from the hardware.
> 
> Does probe not handle EPROBE_DEFER?

right

