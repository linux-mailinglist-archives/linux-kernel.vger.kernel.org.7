Return-Path: <linux-kernel+bounces-872902-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E975DC12910
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 02:38:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id CBCB44FC39D
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 01:38:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E0E7246786;
	Tue, 28 Oct 2025 01:37:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ZgYyQ3em"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47B0B2248A3
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 01:37:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761615475; cv=none; b=K9qS8Fo/qzmCQNKtw8e2NxuByTPt9kPuVRa87A9yd1nMleoq8TBDmH3z3dgMh3lghU53ek1fIxt11Y+jm/MygKQSD2Mk3IzjZWGhdz8anuBjDs8LYmHAIYiRRkU9fw7Lz1urXchmoHznHV5izWZmoZtZbI6KLmVHgJruITMfTSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761615475; c=relaxed/simple;
	bh=MNLfgHpaAp0OMGTgkqm1aB7JHtYhmZpXjyWsKKd0Jb4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TbFHxsgOWa+XZQpAsQyKMQRw5+w9GWXNKIUTD8E0k/hQSp1sZTIyLg3eSK9ZIJ2O5BYB3lFrbixh3OisuOXRGO1SE+MR/Jv67ta/pBvZqL3eq5Iy5BOey1Ba4bupmgcyAWdSz8wJl6fNTf0irAz0YfAm2kPgkEBYA8wcfFpvrYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ZgYyQ3em; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59RKeTUF2546700
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 01:37:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	kkcYFdv239XurAuQWK16RSzXc9uSR2TrVqUONTo1E+Y=; b=ZgYyQ3emINn21srt
	ThBSNBeMcclusKHpHoexPMb3eoPXaSZhxRDEqDWcYnf3DhUIq1rXjsMJ9suNWOMH
	0PHqcjpBIhqiW/l6Ro3hNncHRri08RPdUiDaUZwnS7V2LC67DrTK5hEfnc9s8/CI
	bmqniLxvHFLPgYz1cJOVYEjs7tPvQJ4YO431QUhBXI/B1UaYq91nVqIj/LkEgpiN
	Ay28MRp3ANH0W8okaEWT5LKKmQ6uSikf0A8FHmLpqeSWuIHg5A43UjZoxjWhotXL
	oj062JncBf3u/kRrTV5tQvZ8WwSKjA/Cw3KmKwZ5aTPVMRw2eFj30nmZARRJe5zD
	fLIOTw==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a27s2j9tt-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 01:37:52 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-798920399a6so5404066b3a.0
        for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 18:37:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761615472; x=1762220272;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kkcYFdv239XurAuQWK16RSzXc9uSR2TrVqUONTo1E+Y=;
        b=v8UQYkui8WN3/ZcvwdUNj7rhGyFRW2lq0GegLB4m7dB1iOn1CTo3cVSw1wfbgyewpF
         NmaKlX72W0XdeNiBJfT8l3o8SpeJ6kXuHk5NXycue3MeDwnNPYOKtI7kpoOU5yDg1hBa
         jKELBFsUVbJjgzj68wvYN2DfUcGFcC6Ec0s3xeoCHPUxzC6m9SF+nBQ7nz+eHShBFlsj
         CltpfGKobAMT0oGNwp3h12nhg5yRcnVGEFUaPZmXJKC3wIZRSPQHcXhD7Qza78o+W50t
         gRqBQuQkIADQGBe4wF14UDpyuLjml96jyAaEa21mHOJwDqUzAmZLw5j+xYHK2AVzWln0
         0zzg==
X-Forwarded-Encrypted: i=1; AJvYcCWIk3yD96BwuvWHiHQDf9j0WHpQYIoq3BTC+nA/aFwdyD5x3Q2o+yGCv7BtUgxucUOO2azqzQFMH5I+X2M=@vger.kernel.org
X-Gm-Message-State: AOJu0YwpF+EZBITMRoh9ercjQIb8VeUyJsayqO0S+UERup2N0AdSawFm
	n3N9uO5hZevr71C6UZWrbfhpngQcdXTq6X7vFp+L7T9+5X8E8y7MbDW1E0jW0x3QY/TSoYdAs/I
	n4AVhiH5u+z2R6qAi+4WmlEn5pAumZ9h0S/o7PEvKOHnKBR/CS01XhjsK7v+vk7QeJGw=
X-Gm-Gg: ASbGncupTr4syRrYKTIaDTFbe3gPI5sJIJZED1MgAo+qaRCMk0zfJPZU5HlkvWBwZWR
	TB8SA63rQuh8tYKknuPpuQFfLaw4+19VMC7DTbJJhIKN8jpI/wEEVB0QTOIi3mIIUzoZPcBjOQD
	kGI8CSK1oz/fkDjoDIIavIMq/uz1EvFDk61vUnvzqLtP6+G6h36AeFdvQLP/CQEhVxeMztRsmDO
	JsXNEDlMVViDADLo29xG0xb/MbuFvbfapChHgJiGqH1BMVkG1P9N1nHaJu1JzyJZIOsBzG3HZ3o
	P7gT4A7xlTA/ugB6AsBq+EQp5Yyu2Sxr79YcFv2A0g77j/H9lbHi661O5F8YPsQIYoJ4scriPZF
	/81MmelN42vaxKQa+xHq1yuuCMSIIqUH6+lzdYQLzbNv0p3R6s6lW
X-Received: by 2002:a05:6a00:1ad4:b0:7a2:7c48:e34a with SMTP id d2e1a72fcca58-7a442ea3e89mr1495019b3a.13.1761615471546;
        Mon, 27 Oct 2025 18:37:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEwXWqh7EbCSdKjDTIqMe6IMuQKXRMeAHV3HeqrZw04+sbIralUpoGvEob8jqGjOgpdwAFzGw==
X-Received: by 2002:a05:6a00:1ad4:b0:7a2:7c48:e34a with SMTP id d2e1a72fcca58-7a442ea3e89mr1495000b3a.13.1761615471088;
        Mon, 27 Oct 2025 18:37:51 -0700 (PDT)
Received: from [10.133.33.212] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a41408c4dfsm9638069b3a.65.2025.10.27.18.37.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Oct 2025 18:37:50 -0700 (PDT)
Message-ID: <42c0477b-87de-4b7d-930c-67ce6c9e4557@oss.qualcomm.com>
Date: Tue, 28 Oct 2025 09:37:46 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/3] add sysfs nodes to configure TPDA's registers
To: Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        James Clark <james.clark@linaro.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Tingwei Zhang <tingwei.zhang@oss.qualcomm.com>
Cc: coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
References: <20250827105545.7140-1-jie.gan@oss.qualcomm.com>
 <b5762a05-8b63-4354-925e-fa3c8296e19f@oss.qualcomm.com>
 <d71e09ff-c063-46d9-8d02-f69c18b6efe5@arm.com>
Content-Language: en-US
From: Jie Gan <jie.gan@oss.qualcomm.com>
In-Reply-To: <d71e09ff-c063-46d9-8d02-f69c18b6efe5@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: ALWecvC957kzMj3HOkMFkFZIuLG2EeA0
X-Proofpoint-GUID: ALWecvC957kzMj3HOkMFkFZIuLG2EeA0
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDI4MDAxMiBTYWx0ZWRfXzoqgUlKHiGqI
 EfpzYkhQOqIACB3niQ6CUOWf2LhzgYdFKA6HWXXsSQ/QrekKmzu+2lq/ugsXEApkkSFIx5OLJeX
 WrcMrTJONCWiD8ME1/Nao5NIhDkXDcCsZyKouRAGuYbK64aRYQl1MxP5HPUSVfoizPldTAwgqXj
 ob28KBkNxLAx6mVhpvM2y2qIfn+yQPk6p1kuQuQYiRrhs83j4/JHdQqDz9bnGaDQFW8yx+CRPAm
 JOMIVfU8t/OrIOiCTn71CbLSXmBFgOVjnnINKYyRCBPZLSOzLyUeTlHjMjwSBDr6Ni5IpGfC+C1
 +2rpCBiGaUhneDcniRs8QKN24+k9QUkj8W+6s/W+zT7mBKPtJCSzTafXX3alHzuWmlg2JAjT7M3
 z+K3HXSV+sDYa06s9qb9/HVnZCiYHA==
X-Authority-Analysis: v=2.4 cv=R60O2NRX c=1 sm=1 tr=0 ts=69001e70 cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=otdSkCFsg5a9Z_Vg604A:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=zc0IvFSfCIW2DFIPzwfm:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-28_01,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 phishscore=0 bulkscore=0
 impostorscore=0 clxscore=1015 spamscore=0 adultscore=0 malwarescore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2510020000
 definitions=main-2510280012



On 10/27/2025 5:29 PM, Suzuki K Poulose wrote:
> On 27/10/2025 01:14, Jie Gan wrote:
>>
>>
>> On 8/27/2025 6:55 PM, Jie Gan wrote:
>>> Patchset 1 introduces configuration of the cross-trigger registers with
>>> appropriate values to enable proper generation of cross-trigger packets.
>>>
>>> Patchset 2 introduces a logic to configure the TPDA_SYNCR register,
>>> which determines the frequency of ASYNC packet generation. These packets
>>> assist userspace tools in accurately identifying each valid packet.
>>>
>>> Patchset 3 introduces a sysfs node to initiate a flush request for the
>>> specific port, forcing the data to synchronize and be transmitted to the
>>> sink device.
>>>
>>
>> Gentle reminder.
> 
> Please could you fix the dates and version to v6.19 ?

Sure, will send a new version with fix.

Thanks,
Jie

> 
> Suzuki
> 
>>
>> Thanks,
>> Jie
>>
>>> Changes in V3:
>>> 1. Optimizing codes according to James's comment.
>>> Link to V2 - https://lore.kernel.org/all/20250827042042.6786-1- 
>>> jie.gan@oss.qualcomm.com/
>>>
>>> Changes in V2:
>>> 1. Refactoring the code based on James's comment for optimization.
>>> Link to V1 - https://lore.kernel.org/all/20250826070150.5603-1- 
>>> jie.gan@oss.qualcomm.com/
>>>
>>> Tao Zhang (3):
>>>    coresight: tpda: add sysfs nodes for tpda cross-trigger configuration
>>>    coresight: tpda: add logic to configure TPDA_SYNCR register
>>>    coresight: tpda: add sysfs node to flush specific port
>>>
>>>   .../testing/sysfs-bus-coresight-devices-tpda  |  50 ++++
>>>   drivers/hwtracing/coresight/coresight-tpda.c  | 278 ++++++++++++++++++
>>>   drivers/hwtracing/coresight/coresight-tpda.h  |  33 ++-
>>>   3 files changed, 360 insertions(+), 1 deletion(-)
>>>   create mode 100644 Documentation/ABI/testing/sysfs-bus-coresight- 
>>> devices-tpda
>>>
>>
> 


