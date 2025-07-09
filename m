Return-Path: <linux-kernel+bounces-722820-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CCAB3AFDF60
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 07:44:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AB05F3A5811
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 05:43:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A590126A1D9;
	Wed,  9 Jul 2025 05:44:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="VwNSRG6f"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48CEF1F0E55
	for <linux-kernel@vger.kernel.org>; Wed,  9 Jul 2025 05:43:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752039839; cv=none; b=RijACkBr8COqaDnysroCZMmT0OKv7TZmuU6bnefwmX1M+rgu5EspYj2dDmWg4kHwsqT+VPz+Zxdn0kvmXGkgYUmVyDkpX7qcNGBZQiHY6bGiXEtH6MVw+AywADhG/+OcjLgB4+j9mMpi4NW6UtsmRRBd8fAo/5JqZAn69/9gENk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752039839; c=relaxed/simple;
	bh=PgSVKhhZOx9fn9xuG9eyWNT5OlxugNfXlcfTAtWc4Dg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OOE4QbM4aj6PXiphH934erAHkXWM7/JjG3kt5Ojd82d8WaGXl5EDKy4UghJEGugCys6kCLbtp+tnh7e6PddIa79yIyJfuzhKPyJdJFODVn0fuvnEz6zd5fNKUARuLfJ8Ge2n4vuTzrrEG6uKljjuI8HVLYa1OrwWh1wr7TBsvD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=VwNSRG6f; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 568JqOHw031808
	for <linux-kernel@vger.kernel.org>; Wed, 9 Jul 2025 05:43:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	PgSVKhhZOx9fn9xuG9eyWNT5OlxugNfXlcfTAtWc4Dg=; b=VwNSRG6fmyap3vxP
	f5gG+s3GjY2MQbK1O1h7KcdQHh1BvLYnr/d41O78J/EFeneycqz+dSN6IRe7z8is
	Oojhgp4pvxlaTFePZP3RSERhSln5Zy9eT6yz2yZM53I+xz12/xnGl6tbZN06+4G/
	VtOfZez4yJxNGcEf2pXjsiHRgQQkM5aEagSV/GnMJpjKeEmrjW14lkrDHE+47v1G
	6Qa2uz32n7ssusnh1p6NKP2uiVu/KlgSPO0L58F9HylRlz0FwtozUskXoHPPcSBm
	4LWyMKckZkvVUKvL1xQjaoyO81XBRlZB7gXX11aqEoo3k47FBxzoXkh6VMVxSWrV
	taJG3Q==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47pw7qtcd2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 09 Jul 2025 05:43:56 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-74b4d2f67d5so4057005b3a.3
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jul 2025 22:43:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752039835; x=1752644635;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PgSVKhhZOx9fn9xuG9eyWNT5OlxugNfXlcfTAtWc4Dg=;
        b=V8Zk5zhY3YZcHGn1ZjuRA00vyVcLSv94FMSTa9tG9S9T4EmTd9E9eQApANkDW6nk/Z
         jEbcuMsTLr+pYKu4VjtsUA37+t2MPmNeCDgdHUg+CXYur3+RCHuLNFbriGRASrGdeXti
         joObF2t4OwXxfW9U/tpSYmb8Xs3gUe2WT9EQlt+xbkob3dAijFCg7TuKCRxnbZP4ji9A
         pqqbrFBcYRII6Il03/MMQI+tebQlGvtM/QL4lk3/0qZxR3V0QE0gIzB4fNUnEcCCJNA6
         qLVd9Ih/kyG00KpuzVTzuHbGaRFX10VJZFT/QRTTc4KSLg/gjUEi2byIOLG7e86k5dAX
         uTLA==
X-Forwarded-Encrypted: i=1; AJvYcCXqHYwbFqgHT6H/2LdRz7eKHhkYG8kAoa3Frbz7t3QO//KLUBkOQlAxy16Y3owfkY2hZIp1WLpUGDd8/f8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyzpDhiXCs6tUR4pJtUSEV4HNqcpcunD0DEUGRtCQ1dMeFFPr8k
	3UnmbvnT6P9u7MhfDddM/AAG3EN59Z6bvG4nh74Y9vcTq57h6GJqzV2iCt8G/xGRFdYhTne3glk
	c7OW8NC/poFQf9LmC/ya02g6JrKgubeAsjTE2XztnVQga+1yx5mqLZ45+dr8DoJ4uDaYMl9Viuk
	Q=
X-Gm-Gg: ASbGncvkAL72Nuy6ZWnDRv9HLdMrwAvDtNOZ2e0KDLp+LLVOm26228IEfIx6DgN29yV
	ng9WyuawQ3MNxh8E80fI3f++8KZhih8DMlj1T/UrqFRxdudBjlcw6GuzwNQjjChYUNUGZMQnPv5
	JBpMNv26J8KhMjJJEbUW261AXASF9NDagHolkQOy/1cm9KH8aasaOrVFd+dCEJdoVzwA4EGqUW3
	Y7vEhbxHIm77lBj0Db9CukQTEa43vgArxHzabxuvsQPiwt2mDKx/wXVUNgGLoujZrTLyNVjLXhh
	3OlgTjz2JbURLvFtoaotx7l4ixOyts/erO9FAMOLo/qjZiMJ
X-Received: by 2002:a05:6a21:1fc8:b0:21a:df04:3285 with SMTP id adf61e73a8af0-22cd7487eabmr1845823637.22.1752039834889;
        Tue, 08 Jul 2025 22:43:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEYl76ZnEWcsba95ueqkMuH7zTvwhyN2CeXbn/Yj4+3XI4AUN1nTonvDbA0E2YPPM2a34+eFw==
X-Received: by 2002:a05:6a21:1fc8:b0:21a:df04:3285 with SMTP id adf61e73a8af0-22cd7487eabmr1845798637.22.1752039834447;
        Tue, 08 Jul 2025 22:43:54 -0700 (PDT)
Received: from [10.204.65.175] ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b38ee62dd5fsm13371115a12.55.2025.07.08.22.43.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Jul 2025 22:43:54 -0700 (PDT)
Message-ID: <8b877eeb-941a-47c5-a67d-450dfb772d6e@oss.qualcomm.com>
Date: Wed, 9 Jul 2025 11:13:49 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 5/5] misc: fastrpc: Add missing unmapping
 user-requested remote heap
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: srinivas.kandagatla@oss.qualcomm.com, linux-arm-msm@vger.kernel.org,
        gregkh@linuxfoundation.org, quic_bkumar@quicinc.com,
        linux-kernel@vger.kernel.org, quic_chennak@quicinc.com,
        dri-devel@lists.freedesktop.org, arnd@arndb.de, stable@kernel.org
References: <20250513042825.2147985-1-ekansh.gupta@oss.qualcomm.com>
 <20250513042825.2147985-6-ekansh.gupta@oss.qualcomm.com>
 <22uccyp5m2szry7bpitqcav5nlvwch5eqh4mdacfedidgrnyhx@vsjobngwdkmb>
 <dc67df54-2a19-4318-acd4-b96b8549b64d@oss.qualcomm.com>
 <7ogkoxsowpd2x5qmjog4qx5eu4eiinvtnyjz5hfufgna2hz7na@oxzmowlnelxb>
 <61dd2c3f-20ac-484e-8a45-f42fd5f42b86@oss.qualcomm.com>
 <CAO9ioeX1uE3ty5oSezYOLJKqf8G5dLYAS5nRiNvryWTk0RPdEQ@mail.gmail.com>
 <f3d376cc-6e2d-4ac3-88f6-3104eec67acf@oss.qualcomm.com>
 <qw64xqfnyy76f6oawtaecvraejcwyml5k7oxdy67adj2rh46lq@nupxbuy3vwu4>
 <7505f0e8-222d-4052-8614-c12109d14bce@oss.qualcomm.com>
 <cq3qfx32dallivdcwjwqgq7kggiwucpcyhwqqlbrf6n4efkmuc@htjwnigojag2>
Content-Language: en-US
From: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
In-Reply-To: <cq3qfx32dallivdcwjwqgq7kggiwucpcyhwqqlbrf6n4efkmuc@htjwnigojag2>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzA5MDA0OSBTYWx0ZWRfX4eE/td38iNa0
 KMYZhiwtBesiVx6fjEPmYVFIMRS4GPO3oLBTM+noConfcu7fO5iN4SDm60sbcvJeL673AWAKgRB
 o3KDyvGunFmnxjC/qwMbnpdiuurM5CWLTvtfJKcUyFyb+uxL68+KaBaNNy603x/SWyNVpAST049
 UUUsRQExMVEgR/nm1W59mNagcYkXhxHWm4w8NA5zA9I9fz09UIK+Abaaf+7cgAGQkGUctVpIj2E
 Ro8FlYENM8CgNs/dyLmHOre8++yQ4j4rsE6DWbEprFqaS1sKn90iKhTXb8UE3j71g2FDdWIT7Vd
 pm0JgnL9De1knNajwAgXGk1S/KTRGvbmLn5MT5mjCACXuNhZ7YHkpZHvsPA7NwaBii83PM2eL8O
 q+jswCaV/775Z++1IOaYpkEFpTt5l0XP5+w8Kt6IWjRWR/98dqhkQl/KVv7SlLpAaK5yz5nF
X-Proofpoint-GUID: qMLpiSRH9yLKAqpreCccNSlMcYh-6NV0
X-Proofpoint-ORIG-GUID: qMLpiSRH9yLKAqpreCccNSlMcYh-6NV0
X-Authority-Analysis: v=2.4 cv=SOBCVPvH c=1 sm=1 tr=0 ts=686e019c cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=NEAV23lmAAAA:8 a=EUspDBNiAAAA:8
 a=8S-o2TYjEKDqIBSC5TwA:9 a=pl74wFF6UHmSd9ON:21 a=QEXdDO2ut3YA:10
 a=2VI0MkxyNR6bbpdq8BZq:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-09_01,2025-07-08_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 lowpriorityscore=0 bulkscore=0
 impostorscore=0 mlxlogscore=999 mlxscore=0 phishscore=0 malwarescore=0
 adultscore=0 suspectscore=0 spamscore=0 classifier=spam authscore=0
 authtc=n/a authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507090049



On 6/12/2025 3:54 PM, Dmitry Baryshkov wrote:
> On Thu, Jun 12, 2025 at 03:02:52PM +0530, Ekansh Gupta wrote:
>>
>> On 6/12/2025 1:35 PM, Dmitry Baryshkov wrote:
>>> On Thu, Jun 12, 2025 at 10:50:10AM +0530, Ekansh Gupta wrote:
>>>> On 5/22/2025 5:43 PM, Dmitry Baryshkov wrote:
>>>>> On Thu, 22 May 2025 at 08:01, Ekansh Gupta
>>>>> <ekansh.gupta@oss.qualcomm.com> wrote:
>>>>>> On 5/19/2025 7:04 PM, Dmitry Baryshkov wrote:
>>>>>>> On Mon, May 19, 2025 at 04:28:34PM +0530, Ekansh Gupta wrote:
>>>>>>>> On 5/19/2025 4:22 PM, Dmitry Baryshkov wrote:
>>>>>>>>> On Tue, May 13, 2025 at 09:58:25AM +0530, Ekansh Gupta wrote:
>>>>>>>>>> User request for remote heap allocation is supported using ioctl
>>>>>>>>>> interface but support for unmap is missing. This could result in
>>>>>>>>>> memory leak issues. Add unmap user request support for remote heap.
>>>>>>>>> Can this memory be in use by the remote proc?
>>>>>>>> Remote heap allocation request is only intended for audioPD. Other PDs
>>>>>>>> running on DSP are not intended to use this request.
>>>>>>> 'Intended'. That's fine. I asked a different question: _can_ it be in
>>>>>>> use? What happens if userspace by mistake tries to unmap memory too
>>>>>>> early? Or if it happens intentionally, at some specific time during
>>>>>>> work.
>>>>>> If the unmap is restricted to audio daemon, then the unmap will only
>>>>>> happen if the remoteproc is no longer using this memory.
>>>>>>
>>>>>> But without this restriction, yes it possible that some userspace process
>>>>>> calls unmap which tries to move the ownership back to HLOS which the
>>>>>> remoteproc is still using the memory. This might lead to memory access
>>>>>> problems.
>>>>> This needs to be fixed in the driver. We need to track which memory is
>>>>> being used by the remoteproc and unmap it once remoteproc stops using
>>>>> it, without additional userspace intervention.
>>>> If it's the audio daemon which is requesting for unmap then it basically means that
>>>> the remoteproc is no longer using the memory. Audio PD can request for both grow
>>>> and shrink operations for it's dedicated heap. The case of grow is already supported
>>>> from fastrpc_req_mmap but the case of shrink(when remoteproc is no longer using the
>>>> memory) is not yet available. This memory is more specific to audio PD rather than
>>>> complete remoteproc.
>>>>
>>>> If we have to control this completely from driver then I see a problem in freeing/unmapping
>>>> the memory when the PD is no longer using the memory.
>>> What happens if userspace requests to free the memory that is still in
>>> use by the PD
>> I understand your point, for this I was thinking to limit the unmap functionality to the process
>> that is already attached to audio PD on DSP, no other process will be able to map/unmap this
>> memory from userspace.
> Ugh... and what if the adsprpcd misbehaves?
>
>>> How does PD signal the memory is no longer in use?
>> PD makes a reverse fastrpc request[1] to unmap the memory when it is no longer used.
> I don't see how this can be made robust. I fear that the only way would
> be to unmap the memory only on audio PD restart / shutdown. Such
> requests should never leave the kernel.
>
> Moreover, the payload should not be trusted, however you don't validate
> the length that you've got from the remote side.
I was thinking of giving the entire reserved memory to audio PD when
init_create_static_process is called. This way, we can avoid any need to
support grow/free request from user process and the audio PD pool on
DSP will have sufficient memory support the use cases.

This way the free can be moved to fastrpc_rpmsg_remove(When DSP
is shutting down) or during Audio PD restart(Static PD restart is not
yet supported, but clean-up can be done when PDR framework is
implemented in the future).

Do you see any drawbacks with this design?

>
>> [1] https://github.com/quic/fastrpc/blob/development/src/apps_mem_imp.c#L231


