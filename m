Return-Path: <linux-kernel+bounces-738639-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 69067B0BB57
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 05:21:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B05E33A1CF9
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 03:21:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7C561F4165;
	Mon, 21 Jul 2025 03:21:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="TPQZjOSE"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90FE317BD3
	for <linux-kernel@vger.kernel.org>; Mon, 21 Jul 2025 03:21:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753068097; cv=none; b=EghEPko5GeGFtDkkUiCr8+wRzKOrnXDzIKJ88zCxi0hbp00V3HO1oICPPooBk4NoKZSicLJ3mpmXOt6aRxywoFddi1GabcPiNnNYjgBtUE4wHrTmFxeh5B1bnT7N27DNtE0yPyGsM3aCFl+utUNARY2zTvbX81fDTb9rzQyYSUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753068097; c=relaxed/simple;
	bh=E9sbhD9ivhdnUuBXXfVTUKiu8i5/lan6U4UksfuVpbM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nsJWeR2vxK8gzaQmM0Oyu4367ICYnOiCqQvXQ+j/ZhmZOZu+2BsM3ZDYReFFhQtBixia/pwQJ4vb8wx+hMifobrKcRC4qWKsVcwTV7Re6dGTzUiY0ZZWMG+eb2Ec7ZlknlaWyrYA2X54gw0e3f50TKFFCLr9sdZwNKKLVJHFfH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=TPQZjOSE; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56L0glZr005326
	for <linux-kernel@vger.kernel.org>; Mon, 21 Jul 2025 03:21:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ED6NTckJoWD046wUBIqrWgZnrV8TWC71vBoOZTpTH0I=; b=TPQZjOSEBrlrwH/7
	dGOQ/NiUF2gbYd/vPTXA+zBbqOXeFb/ewNQriF+TivfQD/jSzb6aM3a1JysGuSAq
	npIPFYwHUHCZwkPNkT6bBSe29IXjKSZs1dgJhyXgp1voK83kFbX61Ova8n5PU9cW
	7GskbuB+YGEcqt/7YbCTh1K7QFXxXhvpG+vmUuJFFJ3PGuWJi6DvgiYuTtDvBtmE
	y/hcvt4mwVSy4tyukZqc9He5ifO4af2Nk6Goor21ZiaoUNjJjKn94uQZ3jKGEc4e
	oLQDnxwFD75cIBQYiqgqQBBsYHke6wT7JXSuJyw7h8zhojX1c42bUAjy/RVrB3/F
	FxdL0A==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48048ru8sc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 21 Jul 2025 03:21:34 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-75ab147e0f7so1419518b3a.2
        for <linux-kernel@vger.kernel.org>; Sun, 20 Jul 2025 20:21:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753068093; x=1753672893;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ED6NTckJoWD046wUBIqrWgZnrV8TWC71vBoOZTpTH0I=;
        b=AbjbIrcmOUv+28Lt8uUQfd9z/X2m3NznShavBrxRgcgMAHrtlV9BO10PNbUxKc/VTb
         tjBAGa3A49gdJHClEDhvShpN5laL2mWYXRkYKUukoccwZhYBXDNb21/il/19MhZcj+l9
         fc4N3iNrfrm0M4eL/r/pL9DIGbRjl4yb99hbgzBWF37ji7aXyvtXG2nTKsHZJqRtCxAa
         BtsiPXNxmyO8fMywS1BCM5ggLLEmPTdhC+dLQRpcKi73Zx6j+yNiWaMWgAYFJP3V8xBT
         +cjvFBP9peStsb9ORVL6G1ckLIrq8gn4L9X0jROia5pzapPzF7qjFVqGG3vzY+u/SGoH
         6FGA==
X-Forwarded-Encrypted: i=1; AJvYcCW/00nkPdA8OE0yy42CMDuadNETMHmn0vjy/aWBHiFJmOkNfjpJoFCbHDPYVNCWjZQ8pWbHghivSSF+NM0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxRcddhQC1tAK8bCQ/XRm/IE+kX+fU5NCIZfxAqJF1VfXsqB0l3
	5yuZc+yTU2kpMoBIFpy5TVdlUsCe7ys/c+m9GMmjeOZAGV/psYymF4lOCWJD0OJx2YQX+S/JqFk
	nRGKyyvNLp8rUfOmVzIQL28HYM+F9EEaoVdgm57mRY3ZKv37jcyjXphnzGuiwVfkqj6Y=
X-Gm-Gg: ASbGncsEmiB4VV9TSsPbKiUtTzaZRUyGsMJfnEIulWda7eknhwOcd5ExZwObsaCxaLs
	aWBsbLLQ1yzeK2mfKm/cLOFh27MtdSk6kqP9gIzo7g0TALX8nLJyrUX8ZLeLaxFA8+wK4t5WW+m
	GKA9dOn9jqt7YVmVSUJjdGUMHecEu3mhmezsRazn51q6BUkyIMomrsH9hrUiFCGhHHpXeYHZLHM
	tfiNj/TOdu9d6MbpVZ7T2YzQ/YmDxPo5HE/QyIfhKBAeCZx6PvndewRCk475mdjuus2T0/OHHES
	YFFpaG8FyQRKeMWQj4tUKKiPOpkWt8jYWuSC11/0BEOSH4umqbOdzbJBzOO0h5ez3WEA4+qa9FI
	ePxOek4acotafwUJei7LvNEQqyZcsPZU=
X-Received: by 2002:a05:6a20:748f:b0:220:9d84:1cf6 with SMTP id adf61e73a8af0-237d7c64606mr33924169637.22.1753068092406;
        Sun, 20 Jul 2025 20:21:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF/bz1uQ4gli7rbtRoTkn4SAOOOJUPD6Q7fOi6r3yt+XIjMhJ6nfqLasT2Yi85dOUQnh8GPdA==
X-Received: by 2002:a05:6a20:748f:b0:220:9d84:1cf6 with SMTP id adf61e73a8af0-237d7c64606mr33924133637.22.1753068091701;
        Sun, 20 Jul 2025 20:21:31 -0700 (PDT)
Received: from [10.133.33.30] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b3f2fe8ec36sm4418383a12.29.2025.07.20.20.21.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 20 Jul 2025 20:21:31 -0700 (PDT)
Message-ID: <8354f613-692e-4f6b-933c-3434a5ae90b2@oss.qualcomm.com>
Date: Mon, 21 Jul 2025 11:21:27 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: qca6174 hw3.2 target 0x05030000 chip_id 0x00340aff: firmware
 crashed!
To: Paul Menzel <pmenzel@molgen.mpg.de>, Jeff Johnson <jjohnson@kernel.org>
Cc: ath10k@lists.infradead.org, LKML <linux-kernel@vger.kernel.org>,
        jamie@stimulussoft.com
References: <5aa2dae4-94ba-45cb-b138-bb40c89a85eb@molgen.mpg.de>
 <486e9f27-3b03-4317-a1fc-1bd92235db1c@molgen.mpg.de>
 <90a764d0-c230-43bb-b7e5-189544839f8d@quicinc.com>
 <e2e58098-4589-4ae4-bc38-6b009823b071@molgen.mpg.de>
 <82b9e966-5e12-4a13-98d4-0ffa88505f97@molgen.mpg.de>
 <d8145c41-1e61-454f-a343-be0a7239e36e@molgen.mpg.de>
Content-Language: en-US
From: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
In-Reply-To: <d8145c41-1e61-454f-a343-be0a7239e36e@molgen.mpg.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzIxMDAyNSBTYWx0ZWRfX1d1iVen3R54G
 2xG2RJZT6ePi12GlCyEO0unjqslURnwaadawM9t4aUuHF032P9/8YswuNK94DvpAnX/7K7ZhyEu
 D/hymAaZ5urQrH7qxDhLBhqhzWJ5Qg+/E6pbWbEHD16c4bX6DlLTqpJwr5Ehdh+sqO1c0Am+BYL
 rgwSp05rMOPHGQ7PCyJFHmbTE31ucZEADLYj2rg/3GcsdBIcWo5cNuWO5RIyTvvIGAyieesjIrG
 ZizLnK1RnsLq+BSMuj+5Ktq7I10XvtIszOBZjjtUeAAMnqdPECaGUct4ZSVld44wXgldeb5AT5Y
 oTu+ANTIpZ0kjTHFn3cHOUQjtljCq+52O4ypWvSUT7ch+lYUdmK2SCPWDKAYWadOPB7SRQCRl/3
 bQ9AJzdu1Xi6gRFJOOlYkQ4B13GoMjJyGwRIdRjo02PCbErbD9yGWgYuPqgNdT3fMbBYqouC
X-Proofpoint-ORIG-GUID: d3_klVpiXhYM0fgWLfq3Ihsk242CzaRW
X-Proofpoint-GUID: d3_klVpiXhYM0fgWLfq3Ihsk242CzaRW
X-Authority-Analysis: v=2.4 cv=OPUn3TaB c=1 sm=1 tr=0 ts=687db23e cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=xNf9USuDAAAA:8 a=VwQbUJbxAAAA:8
 a=XgL6m6CVAAAA:8 a=85N1-lAfAAAA:8 a=besvyySB-tCJMmxioCcA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=zc0IvFSfCIW2DFIPzwfm:22 a=0UletBSDd9R_kuu03CwM:22
 a=cyfSibbquD4hpIoiQNSb:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-21_01,2025-07-17_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1015 mlxlogscore=999 lowpriorityscore=0 suspectscore=0
 spamscore=0 mlxscore=0 bulkscore=0 priorityscore=1501 phishscore=0
 malwarescore=0 impostorscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507210025



On 7/20/2025 4:43 PM, Paul Menzel wrote:
> Dear Baochen, dear Jeff,
> 
> 
> Am 14.05.25 um 10:08 schrieb Paul Menzel:
> 
>> another crash happened yesterday after six weeks of silence.
>>
>> Am 25.03.25 um 08:01 schrieb Paul Menzel:
>>
>>> Am 24.03.25 um 04:29 schrieb Baochen Qiang:
>>>
>>>> On 3/23/2025 7:41 PM, Paul Menzel wrote:
>>>
>>>>> Am 08.12.24 um 23:21 schrieb Paul Menzel:
>>>>>
>>>>>> Today the Wi-Fi connection stopped working, and the logs contained:
>>>>>>
>>>>>>       [44177.000699] ath10k_pci 0000:3a:00.0: firmware crashed! (guid
>>>>>> 1b4a40c5-4495-4c5b-9df9-b7395848239c)
>>>>>>       [44177.000720] ath10k_pci 0000:3a:00.0: qca6174 hw3.2 target 0x05030000
>>>>>> chip_id 0x00340aff sub 1a56:1535
>>>>>>       [44177.000731] ath10k_pci 0000:3a:00.0: kconfig debug 0 debugfs 0 tracing 0
>>>>>> dfs 0 testmode 0
>>>>>>       [44177.002450] ath10k_pci 0000:3a:00.0: firmware ver WLAN.RM.4.4.1-00309- api
>>>>>> 6 features wowlan,ignore-otp,mfp crc32 0793bcf2
>>>>>>       [44177.004168] ath10k_pci 0000:3a:00.0: board_file api 2 bmi_id N/A crc32
>>>>>> d2863f91
>>>>>>       [44177.004176] ath10k_pci 0000:3a:00.0: htt-ver 3.87 wmi-op 4 htt- op 3 cal
>>>>>> otp max-sta 32 raw 0 hwcrypto 1
>>>>>>       [44177.014494] ath10k_pci 0000:3a:00.0: failed to get memcpy hi address for
>>>>>> firmware address 4: -16
>>>>>>       [44177.014498] ath10k_pci 0000:3a:00.0: failed to read firmware dump area: -16
>>>>>>       [44177.014500] ath10k_pci 0000:3a:00.0: Copy Engine register dump:
>>>>>>       [44177.014508] ath10k_pci 0000:3a:00.0: [00]: 0x00034400  12 12  3   3
>>>>>>       [44177.014517] ath10k_pci 0000:3a:00.0: [01]: 0x00034800  19 19 64  65
>>>>>>       [44177.014525] ath10k_pci 0000:3a:00.0: [02]: 0x00034c00  39 37 36  37
>>>>>>       [44177.014532] ath10k_pci 0000:3a:00.0: [03]: 0x00035000  20 20 22  20
>>>>>>       [44177.014540] ath10k_pci 0000:3a:00.0: [04]: 0x00035400 6457 6457 222 158
>>>>>>       [44177.014548] ath10k_pci 0000:3a:00.0: [05]: 0x00035800   0  0 64   0
>>>>>>       [44177.014556] ath10k_pci 0000:3a:00.0: [06]: 0x00035c00  29 29  0   0
>>>>>>       [44177.014563] ath10k_pci 0000:3a:00.0: [07]: 0x00036000   1  0  1   0
>>>>>>       [44177.109219] ieee80211 phy0: Hardware restart was requested
>>>>>>       [44177.429445] ath10k_pci 0000:3a:00.0: device successfully recovered
>>>>>>
>>>>>> Please find the output of `dmesg` with two firmware crashes attached. Looking
>>>>>> through my logs since September 20th with Linux 6.11-rcX, this is not the first
>>>>>> firmware crash. The `guid` value differs pairwaise between each of them.
>>>>>
>>>>> Since my message in December I found two more crashes in the logs:
>>>>>
>>>>>      Jan 20 13:11:11 abreu kernel: ath10k_pci 0000:3a:00.0: firmware crashed! (guid
>>>>> 0290afa9-63d2-4d66-b355-de2e12f96f4b)
>>>>>
>>>>>      Feb 02 20:34:20 abreu kernel: ath10k_pci 0000:3a:00.0: firmware crashed! (guid
>>>>> 4c1fb23a-8d0e-4c03-8dfb-a5fa9ad3d2bc)
>>>>>
>>>>> I am now in a WLAN with Cisco access points, and get a few crashes:
>>>>>
>>>>>      Mär 21 14:01:36 abreu kernel: ath10k_pci 0000:3a:00.0: firmware crashed! (guid
>>>>> bc05fa56-0033-4fca-bfc0-660568f560fd)
>>>>>      Mär 23 11:54:24 abreu kernel: ath10k_pci 0000:3a:00.0: firmware crashed! (guid
>>>>> b6eb8244-0e48-4785-8247-901e833ed59a)
>>>>>
>>>>>      [42307.272046] ath10k_pci 0000:3a:00.0: firmware crashed! (guid
>>>>> bc05fa56-0033-4fca-bfc0-660568f560fd)
>>>>>      [42307.272078] ath10k_pci 0000:3a:00.0: qca6174 hw3.2 target 0x05030000 chip_id
>>>>> 0x00340aff sub 1a56:1535
>>>>>      [42307.272094] ath10k_pci 0000:3a:00.0: kconfig debug 0 debugfs 0 tracing 0 dfs
>>>>> 0 testmode 0
>>>>>      [42307.272452] ath10k_pci 0000:3a:00.0: firmware ver WLAN.RM.4.4.1-00309- api 6
>>>>> features wowlan,ignore-otp,mfp crc32 0793bcf2
>>>>>      [42307.272825] ath10k_pci 0000:3a:00.0: board_file api 2 bmi_id N/A crc32 d2863f91
>>>>>      [42307.272834] ath10k_pci 0000:3a:00.0: htt-ver 3.87 wmi-op 4 htt-op 3 cal otp
>>>>> max-sta 32 raw 0 hwcrypto 1
>>>>>      [42307.283011] ath10k_pci 0000:3a:00.0: failed to get memcpy hi address for
>>>>> firmware address 4: -16
>>>>>      [42307.283024] ath10k_pci 0000:3a:00.0: failed to read firmware dump area: -16
>>>>>      [42307.283034] ath10k_pci 0000:3a:00.0: Copy Engine register dump:
>>>>>      [42307.283050] ath10k_pci 0000:3a:00.0: [00]: 0x00034400  12  12  3   3
>>>>>      [42307.283070] ath10k_pci 0000:3a:00.0: [01]: 0x00034800   5   5 82  83
>>>>>      [42307.283088] ath10k_pci 0000:3a:00.0: [02]: 0x00034c00  53  47 45  46
>>>>>      [42307.283104] ath10k_pci 0000:3a:00.0: [03]: 0x00035000  13  13 14  12
>>>>>      [42307.283120] ath10k_pci 0000:3a:00.0: [04]: 0x00035400  67  67 98  34
>>>>>      [42307.283135] ath10k_pci 0000:3a:00.0: [05]: 0x00035800   0   0 64   0
>>>>>      [42307.283151] ath10k_pci 0000:3a:00.0: [06]: 0x00035c00  22  22 24  24
>>>>>      [42307.283167] ath10k_pci 0000:3a:00.0: [07]: 0x00036000   1   1  1   0
>>>>>      [42307.371777] ieee80211 phy0: Hardware restart was requested
>>>>>      [42309.383940] ath10k_pci 0000:3a:00.0: timed out waiting peer stats info
>>>>>      [42309.690205] ath10k_pci 0000:3a:00.0: device successfully recovered
>>>>>      [43924.050746] wlp58s0: deauthenticating from 48:2f:6b:7a:61:54 by local choice
>>>>> (Reason: 3=DEAUTH_LEAVING)
>>>>>
>>>>> Baochen, do you have an idea? Also how to fix the dump errors?
>>>>
>>>> could you share AP model? and any specific test steps you hit it?
>>>
>>> Sorry, I do not know the AP model. It was at a university network. After sending my
>>> email it also happened with a FRITZ!Box 7590. It all was the same boot cycle and over
>>> 70 ACPI S3 suspend/resume cycles happened.
>>>
>>> ```
>>> […]
>>> Mar 23 21:26:32 abreu kernel: PM: suspend entry (deep)
>>> Mar 23 21:26:32 abreu wpa_supplicant[572998]: wlp58s0: CTRL-EVENT-DSCP-POLICY clear_all
>>> Mar 23 21:26:32 abreu wpa_supplicant[572998]: nl80211: deinit ifname=wlp58s0
>>> disabled_11b_rates=0
>>> […]
>>> Mar 23 21:58:07 abreu wpa_supplicant[572998]: wlp58s0: CTRL-EVENT- CONNECTED -
>>> Connection to dc:15:c8:46:1c:4b completed [id=0 id_str=]
>>> […]
>>> Mar 23 21:58:10 abreu wpa_supplicant[572998]: wlp58s0: CTRL-EVENT-REGDOM-CHANGE
>>> init=BEACON_HINT type=UNKNOWN
>>> Mar 23 21:58:14 abreu wpa_supplicant[572998]: wlp58s0: CTRL-EVENT-REGDOM-CHANGE
>>> init=BEACON_HINT type=UNKNOWN
>>> Mar 23 21:58:17 abreu wpa_supplicant[572998]: wlp58s0: CTRL-EVENT-REGDOM-CHANGE
>>> init=BEACON_HINT type=UNKNOWN
>>> Mar 23 21:58:18 abreu systemd[1]: NetworkManager-dispatcher.service: Deactivated
>>> successfully.
>>> Mar 23 21:58:20 abreu wpa_supplicant[572998]: wlp58s0: CTRL-EVENT- REGDOM-CHANGE
>>> init=BEACON_HINT type=UNKNOWN
>>> Mar 23 21:58:23 abreu rtkit-daemon[932]: Supervising 1 threads of 1 processes of 1 users.
>>> Mar 23 21:58:23 abreu rtkit-daemon[932]: Supervising 1 threads of 1 processes of 1 users.
>>> Mar 23 21:58:24 abreu wpa_supplicant[572998]: wlp58s0: CTRL-EVENT-REGDOM-CHANGE
>>> init=BEACON_HINT type=UNKNOWN
>>> Mar 23 21:58:27 abreu wpa_supplicant[572998]: wlp58s0: CTRL-EVENT-REGDOM-CHANGE
>>> init=BEACON_HINT type=UNKNOWN
>>> Mar 23 21:58:30 abreu wpa_supplicant[572998]: wlp58s0: CTRL-EVENT-REGDOM-CHANGE
>>> init=BEACON_HINT type=UNKNOWN
>>> Mar 23 21:58:34 abreu wpa_supplicant[572998]: wlp58s0: CTRL-EVENT-REGDOM-CHANGE
>>> init=BEACON_HINT type=UNKNOWN
>>> Mar 23 21:58:37 abreu wpa_supplicant[572998]: wlp58s0: CTRL-EVENT-REGDOM-CHANGE
>>> init=BEACON_HINT type=UNKNOWN
>>> Mar 23 21:58:40 abreu wpa_supplicant[572998]: wlp58s0: CTRL-EVENT-REGDOM-CHANGE
>>> init=BEACON_HINT type=UNKNOWN
>>> Mar 23 21:58:44 abreu wpa_supplicant[572998]: wlp58s0: CTRL-EVENT-REGDOM-CHANGE
>>> init=BEACON_HINT type=UNKNOWN
>>> […]
>>> Mar 23 22:01:07 abreu wpa_supplicant[572998]: wlp58s0: WPA: Group rekeying completed
>>> with dc:15:c8:46:1c:4b [GTK=CCMP]
>>> Mar 23 22:03:09 abreu wpa_supplicant[572998]: wlp58s0: CTRL-EVENT-REGDOM-CHANGE
>>> init=BEACON_HINT type=UNKNOWN
>>> Mar 23 22:03:09 abreu wpa_supplicant[572998]: wlp58s0: CTRL-EVENT-REGDOM-CHANGE
>>> init=BEACON_HINT type=UNKNOWN
>>> […]
>>> Mar 23 22:10:31 abreu systemd[1456]: Started app-gnome-ptyxis-1551384.scope -
>>> Application launched by gsd-media-keys.
>>> Mar 23 22:10:32 abreu systemd[1456]: Started ptyxis-spawn-aec65fc6-84bf-4f85-8dad-
>>> c6c4e1e39e99.scope - [systemd-run] /usr/bin/bash.
>>> Mar 23 22:11:07 abreu wpa_supplicant[572998]: wlp58s0: WPA: Group rekeying completed
>>> with dc:15:c8:46:1c:4b [GTK=CCMP]
>>> Mar 23 22:11:35 abreu rtkit-daemon[932]: Supervising 1 threads of 1 processes of 1 users.
>>> […]
>>> Mar 23 22:21:07 abreu wpa_supplicant[572998]: wlp58s0: WPA: Group rekeying completed
>>> with dc:15:c8:46:1c:4b [GTK=CCMP]
>>> […]
>>> Mar 23 22:27:24 abreu gnome-shell[1647]: JS ERROR: TypeError: event is null
>>> addClickAction/<@resource:///org/gnome/shell/ui/dnd.js:151:13 @resource:///org/gnome/
>>> shell/ui/init.js:21:20
>>> Mar 23 22:31:07 abreu wpa_supplicant[572998]: wlp58s0: WPA: Group rekeying completed
>>> with dc:15:c8:46:1c:4b [GTK=CCMP]
>>> Mar 23 22:32:13 abreu systemd-timesyncd[410]: Contacted time server 17.253.14.251:123
>>> (0.debian.pool.ntp.org).
>>> Mar 23 22:35:01 abreu CRON[1553601]: pam_unix(cron:session): sessionopened for user
>>> root(uid=0) by root(uid=0)
>>> Mar 23 22:35:01 abreu CRON[1553603]: (root) CMD (command -v debian-sa1 > /dev/null &&
>>> debian-sa1 1 1)
>>> Mar 23 22:35:01 abreu CRON[1553601]: pam_unix(cron:session): session closed for user root
>>> Mar 23 22:36:09 abreu kernel: i915 0000:00:02.0: [drm] *ERROR* Atomic update failure on
>>> pipe A (start=6 end=7) time 266 us, min 1788, max 1799, scanline start 1781, end 1810
>>> Mar 23 22:37:35 abreu kernel: ath10k_pci 0000:3a:00.0: firmware crashed! (guid
>>> 45f495a9-56a5-48e5-aa94-1d8ff413720e)
>>> Mar 23 22:37:35 abreu kernel: ath10k_pci 0000:3a:00.0: qca6174 hw3.2 target 0x05030000
>>> chip_id 0x00340aff sub 1a56:1535
>>> Mar 23 22:37:35 abreu kernel: ath10k_pci 0000:3a:00.0: kconfig debug 0 debugfs 0
>>> tracing 0 dfs 0 testmode 0
>>> Mar 23 22:37:35 abreu kernel: ath10k_pci 0000:3a:00.0: firmware ver
>>> WLAN.RM.4.4.1-00309- api 6 features wowlan,ignore-otp,mfp crc32 0793bcf2
>>> Mar 23 22:37:35 abreu kernel: ath10k_pci 0000:3a:00.0: board_file api 2 bmi_id N/A
>>> crc32 d2863f91
>>> Mar 23 22:37:35 abreu kernel: ath10k_pci 0000:3a:00.0: htt-ver 3.87 wmi-op 4 htt-op 3
>>> cal otp max-sta 32 raw 0 hwcrypto 1
>>> Mar 23 22:37:35 abreu kernel: ath10k_pci 0000:3a:00.0: failed to get memcpy hi address
>>> for firmware address 4: -16
>>> Mar 23 22:37:35 abreu kernel: ath10k_pci 0000:3a:00.0: failed to readfirmware dump
>>> area: -16
>>> Mar 23 22:37:35 abreu kernel: ath10k_pci 0000:3a:00.0: Copy Engine register dump:
>>> Mar 23 22:37:35 abreu kernel: ath10k_pci 0000:3a:00.0: [00]: 0x00034400   12   12   3   3
>>> Mar 23 22:37:35 abreu kernel: ath10k_pci 0000:3a:00.0: [01]: 0x00034800   23   23  36  37
>>> Mar 23 22:37:35 abreu kernel: ath10k_pci 0000:3a:00.0: [02]: 0x00034c00   31   27  89  90
>>> Mar 23 22:37:35 abreu kernel: ath10k_pci 0000:3a:00.0: [03]: 0x00035000   22   22  24  22
>>> Mar 23 22:37:35 abreu kernel: ath10k_pci 0000:3a:00.0: [04]: 0x00035400 4329 4329 181 117
>>> Mar 23 22:37:35 abreu kernel: ath10k_pci 0000:3a:00.0: [05]: 0x00035800    0    0  64   0
>>> Mar 23 22:37:35 abreu kernel: ath10k_pci 0000:3a:00.0: [06]: 0x00035c00   10   10  16  16
>>> Mar 23 22:37:35 abreu kernel: ath10k_pci 0000:3a:00.0: [07]: 0x00036000    1    1   1   0
>>> Mar 23 22:37:35 abreu kernel: ieee80211 phy0: Hardware restart was requested
>>> Mar 23 22:37:35 abreu kernel: ath10k_pci 0000:3a:00.0: device successfully recovered
>>> Mar 23 22:38:00 abreu gnome-shell[1647]: JS ERROR: TypeError: event is null
>>> addClickAction/<@resource:///org/gnome/shell/ui/dnd.js:151:13 @resource:///org/gnome/
>>> shell/ui/init.js:21:20
>>> […]
>>> ```
>>>
>>> Unfortunately, I do not know how to reproduce it. I was browsing and had some SSH
>>> sessions running. I also did some bandwidth tests by downloading some files, and
>>> sometimes it went up to 30 MB/s.
>>>
>>>      wget -O /dev/null http://deb.debian.org/debian/pool/main/f/flightgear-data/
>>> flightgear-data-base_2020.3.19+dfsg-1_all.deb
>>>
>>> But I do *not* know, when the hang happened, and if it is related at all. The crash
>>> with the FRITZ!Box did also not involve any large downloads during this time.
>>>
>>> So, I unfortunately, do not know how to reproduce it.
>>>
>>> I was hoping the firmware dump could shed more light on it, and ease debugging on your
>>> and my end.
>>>
>>>> regarding the dump error, I think it is due to unresponsive firmware since it crashes.
>>>> We'd better focus on the crash first.
>>>>
>>>>> Jamie (Cc:) also reported this this January 2025 *Ath10k firmware crash* [1].
> 
> [As per Jamie’s reply, it was a voltage setting problem there.]
> 
>> Yesterday it crashed when connected to an Aruba AP-205:
>>
>> ```
>> May 13 09:19:51.379037 abreu kernel: ath10k_pci 0000:3a:00.0: firmware crashed! (guid
>> 6112a2e3-7e6d-4f80-8145-421da9708ee0)
>> May 13 09:19:51.379992 abreu kernel: ath10k_pci 0000:3a:00.0: qca6174 hw3.2 target
>> 0x05030000 chip_id 0x00340aff sub 1a56:1535
>> May 13 09:19:51.380564 abreu kernel: ath10k_pci 0000:3a:00.0: kconfig debug 0 debugfs 0
>> tracing 0 dfs 0 testmode 0
>> May 13 09:19:51.381091 abreu kernel: ath10k_pci 0000:3a:00.0: firmware ver
>> WLAN.RM.4.4.1-00309- api 6 features wowlan,ignore-otp,mfp crc32 0793bcf2
>> May 13 09:19:51.381585 abreu kernel: ath10k_pci 0000:3a:00.0: board_file api 2 bmi_id N/
>> A crc32 d2863f91
>> May 13 09:19:51.382098 abreu kernel: ath10k_pci 0000:3a:00.0: htt-ver 3.87 wmi-op 4 htt-
>> op 3 cal otp max-sta 32 raw 0 hwcrypto 1
>> May 13 09:19:51.391018 abreu kernel: ath10k_pci 0000:3a:00.0: failed to get memcpy hi
>> address for firmware address 4: -16
>> May 13 09:19:51.391856 abreu kernel: ath10k_pci 0000:3a:00.0: failed to read firmware
>> dump area: -16
>> May 13 09:19:51.392469 abreu kernel: ath10k_pci 0000:3a:00.0: Copy Engine register dump:
>> May 13 09:19:51.393029 abreu kernel: ath10k_pci 0000:3a:00.0: [00]: 0x00034400  12  12  
>> 3   3
>> May 13 09:19:51.393542 abreu kernel: ath10k_pci 0000:3a:00.0: [01]: 0x00034800  27  27
>> 264 265
>> May 13 09:19:51.394036 abreu kernel: ath10k_pci 0000:3a:00.0: [02]: 0x00034c00   2  63 
>> 62  63
>> May 13 09:19:51.394574 abreu kernel: ath10k_pci 0000:3a:00.0: [03]: 0x00035000  29  29 
>> 31  29
>> May 13 09:19:51.395137 abreu kernel: ath10k_pci 0000:3a:00.0: [04]: 0x00035400 505 505 
>> 62 254
>> May 13 09:19:51.395633 abreu kernel: ath10k_pci 0000:3a:00.0: [05]: 0x00035800   0   0 
>> 64   0
>> May 13 09:19:51.396126 abreu kernel: ath10k_pci 0000:3a:00.0: [06]: 0x00035c00   0   0 
>> 26  26
>> May 13 09:19:51.396609 abreu kernel: ath10k_pci 0000:3a:00.0: [07]: 0x00036000   1   0  
>> 1   0
>> May 13 09:19:51.475013 abreu kernel: ieee80211 phy0: Hardware restart was requested
>> May 13 09:19:51.783041 abreu kernel: ath10k_pci 0000:3a:00.0: device successfully recovered
>> ```
>>
>> Were you or the firmware team able to pinpoint the problem, and come up with a fix? Is
>> there any logging I can enable to help with debugging?
> 
> It also happens with a Telekom Speedport Smart 3 (Arcadyan Corporation) router. The
> firmware crashed five more times since June. A reliable Wi-Fi connection would be really
> appreciated. Could you send me a debug firmware, so the firmware developers have it easier
> to fix it?

Paul, we are working on getting leagle approval on collecting necessary information, such
as firmwre dump etc, from community. Once done we will share guides to collect them to
debug further.

> 
> 
> Kind regards,
> 
> Paul
> 
> 
>>>>>> PS: Other times:
>>>>>>
>>>>>> -- Boot caea92a03f6d4776926f451f8281ea31 --
>>>>>> Sep 26 12:12:01 abreu kernel: ath10k_pci 0000:3a:00.0: firmware crashed! (guid
>>>>>> 6eb9dc57-1295-4a53-b71d-a8aeba7281a1)
>>>>>> Sep 26 12:32:58 abreu kernel: ath10k_pci 0000:3a:00.0: firmware crashed! (guid
>>>>>> c4a6c6a2-3cf4-445e-b16b-2baa35d547f3)
>>>>>> Sep 26 12:46:02 abreu kernel: ath10k_pci 0000:3a:00.0: firmware crashed! (guid
>>>>>> b8c8a5f0-7ff7-45c3-8ecb-7ba8074ba6f7)
>>>>>>
>>>>>> -- Boot 26e7175e65254625bf58276e9532773e --
>>>>>> Okt 23 12:11:20 abreu kernel: ath10k_pci 0000:3a:00.0: firmware crashed! (guid
>>>>>> 1b3f438c-339c-4ad1-9d82-92a96a07c3c2)
>>>>>>
>>>>>> Earliest crash:
>>>>>>
>>>>>> Sep 26 10:41:36 abreu kernel: Linux version 6.11.0-07273-g1e7530883cd2
>>>>>> (build@bohemianrhapsody.molgen.mpg.de) (gcc (Debian 14.2.0-5) 14.2.0, GNU ld (GNU
>>>>>> Binutils for Debian) 2.43.1) #12 SMP PREEMPT_DYNAMIC Sun Sep 22 09:57:36 CEST 2024
>>>>>> […]
>>>>>> Sep 26 12:12:01 abreu kernel: ath10k_pci 0000:3a:00.0: firmware crashed! (guid
>>>>>> 6eb9dc57-1295-4a53-b71d-a8aeba7281a1)
>>>>>> Sep 26 12:12:01 abreu kernel: ath10k_pci 0000:3a:00.0: qca6174 hw3.2 target
>>>>>> 0x05030000 chip_id 0x00340aff sub 1a56:1535
>>>>>> Sep 26 12:12:01 abreu kernel: ath10k_pci 0000:3a:00.0: kconfig debug 0 debugfs 0
>>>>>> tracing 0 dfs 0 testmode 0
>>>>>> Sep 26 12:12:01 abreu kernel: ath10k_pci 0000:3a:00.0: firmware ver
>>>>>> WLAN.RM.4.4.1-00309- api 6 features wowlan,ignore-otp,mfp crc32 0793bcf2
>>>>>> Sep 26 12:12:01 abreu kernel: ath10k_pci 0000:3a:00.0: board_file api 2 bmi_id N/A
>>>>>> crc32 d2863f91
>>>>>> Sep 26 12:12:01 abreu kernel: ath10k_pci 0000:3a:00.0: htt-ver 3.87 wmi-op 4 htt-op
>>>>>> 3 cal otp max-sta 32 raw 0 hwcrypto 1
>>>>>> Sep 26 12:12:01 abreu kernel: ath10k_pci 0000:3a:00.0: failed to get memcpy hi
>>>>>> address for firmware address 4: -16
>>>>>> Sep 26 12:12:01 abreu kernel: ath10k_pci 0000:3a:00.0: failed to read firmware dump
>>>>>> area: -16
>>>>>> Sep 26 12:12:01 abreu kernel: ath10k_pci 0000:3a:00.0: Copy Engine register dump:
>>>>>> Sep 26 12:12:01 abreu kernel: ath10k_pci 0000:3a:00.0: [00]: 0x00034400 12  12   3   3
>>>>>> Sep 26 12:12:01 abreu kernel: ath10k_pci 0000:3a:00.0: [01]: 0x00034800 28  28 265 266
>>>>>> Sep 26 12:12:01 abreu kernel: ath10k_pci 0000:3a:00.0: [02]: 0x00034c00 29  27  90  91
>>>>>> Sep 26 12:12:01 abreu kernel: ath10k_pci 0000:3a:00.0: [03]: 0x00035000 15  15  17  15
>>>>>> Sep 26 12:12:01 abreu kernel: ath10k_pci 0000:3a:00.0: [04]: 0x00035400 3887 3887
>>>>>> 217 153
>>>>>> Sep 26 12:12:01 abreu kernel: ath10k_pci 0000:3a:00.0: [05]: 0x00035800   0   0  64   0
>>>>>> Sep 26 12:12:01 abreu kernel: ath10k_pci 0000:3a:00.0: [06]: 0x00035c00 20  20  16  16
>>>>>> Sep 26 12:12:01 abreu kernel: ath10k_pci 0000:3a:00.0: [07]: 0x00036000   1   0   1   0
>>>>>
>>>>>
>>>>> [1]: https://lore.kernel.org/all/a5b15899-b214-403b-a1b2-84a948e776ef@stimulussoft.com/


