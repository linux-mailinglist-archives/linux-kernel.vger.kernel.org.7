Return-Path: <linux-kernel+bounces-742178-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EE15B0EE55
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 11:24:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A09F9171E3D
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 09:24:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A753928640F;
	Wed, 23 Jul 2025 09:24:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="GCY8O4jQ"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8929211A15
	for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 09:24:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753262657; cv=none; b=NNywrpM5VuzPMrTjTnWf6fJZLqgKslZ1xPxrtM7egtio0OexMcdqCdSTlY0RI6Y9QltVbgS2ECYIfXr+/hHJe33IfhwL2IDm7iY8R3qEmTo0DBemdd6oRlNZMfv7y/M+tea7JVdv6GkM2uz0J6VSdX08pM4xnK+/I2WybS8AaQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753262657; c=relaxed/simple;
	bh=4+wq30tYrS+hasxmkNFAkgFt+v2Bn03QvpeOwwRgrrc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=C6KmOeT0SJFyj/Sob1zSDvmrO/5zd92fHcspDd1rlIXNrEPlH9l3Hg/D4EFGiExe1tvbyYf/4FDu+VERGCKZOM8nhuS4RhjKG9ghvXgsJ6loH/cEJ/TN90PjVBK2guv7a4T9Ypz6JNCApPR9aPoue1tNwLZ800Zzc7YdIzYqQlk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=GCY8O4jQ; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56MMOYgx030815
	for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 09:24:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	4+wq30tYrS+hasxmkNFAkgFt+v2Bn03QvpeOwwRgrrc=; b=GCY8O4jQ5lKWecVN
	j7nkCPQ6+HK9KWWJ7KVC4kGOZcCj44hO+hKh5nTLB/RUtqqlxH8QIbS9+Rpj44v2
	NLdBg/zr4jHrbihqcreqR2Vqwk3zxnIfswDUS+pQcNeK4pKerSXKGjtRhFZ32zCq
	5jUlj26OAIQYCrYv+qs1afF9jKJH3X1JJyH9KLk0xjyX5kqbCJ4zF6kB/KFUU8kt
	ni/zRJNaAGHOOtL6u/T/7bqDynoFu6Y5Cfo00Ewp87l4Eygory76eMwHudp1TVdy
	WmnZA/OqDqgEdqOh7D0BhuvDN7KT4YzQaPZOOPoF7Nimma5nfGcuYR1+QQi1o1J4
	yVIB3w==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48048s4m9b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 09:24:14 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-74943a7cd9aso9897282b3a.3
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 02:24:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753262653; x=1753867453;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4+wq30tYrS+hasxmkNFAkgFt+v2Bn03QvpeOwwRgrrc=;
        b=F/BFvIIXLTGdK1Vgy6uB2F0hCZjN5Z98+Cw3ApFCpTiu7dYBhUH4z9OjssTydFdOKF
         bRsTi99D/1H6ecSKHL75sDIO54t1oPau8MSVGbn8NFZ2NnkMV0eI0Swukt8w3WZquzR9
         ZW/gpP58LBDvbsS8GtkReERIeoCZ2juJ47/9Fu07fAHuiRteZa7rqxjjyezIRqpHUfLs
         DLFNl2/jHNtwFfH+BsrtWwNDGXcrUO6TAeqbn0Bs3VEIcMSGwvCHDtdrEt1bCyMSGXWB
         FdSgaqIjY7VSZu35DHxqV1yBkznQZtXbWmbtXmpOcL8jvxCakRwhnL76zLG+bUV3L+va
         OjVg==
X-Forwarded-Encrypted: i=1; AJvYcCWYm7rBS+3SD8j1OAQxnYgNRXbICSZBjqU0NltQyzqTFmxrYl3ObP+E8A9ksQnY4w0FOQqzy4WRgWA0KOE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz//hq+uC3lQGczuF/ttEf2t2ikfrhnYsPLG6FPfx0OeK9+XHi2
	LdmiIpGGMU0dZfa/yRXyrBMA9jZATajsATTW7VD4LGWuBS3CHcszo5TKoj43QoXK8zPMCpd0Ndy
	Pkq7VkEAJc+7vkhYdfBjf2qXzhKRgcq8lrkmmjMY+cGyYOqI6Q6hsZ6+Uc+z38/UEU/Y=
X-Gm-Gg: ASbGnctc/xT8UsRkMcAubmvqPdghHtnkXpeAdrDryt7qLFhiN5ef+r0Z/hAl95Ke7Uq
	0pORx6Z+RGxW/IkrkyXvmjuIxYr5Ip5AzN7S0NVgYUPcN+5TxLo+IhZteWl2bakX6uHqfeFhcl5
	PoL9ZONoSvN6R1dgMOnOqlXWSYOdpNaX+gIENF3ySfmVguGevIZ7UAel+rmrKACjIn2Cxa8vnF7
	/mB/h1emBHxawOeEi8g5Rhv11cvlGnkWJmomtJI5MoGvzI9QpDmjyGtEFsyacjX2HQv1AEOfc6U
	aHQBaH1v6rekm45yddgKVMNoQ9cYI7QzxAMbAG/kgPs5LSsQtTOQCxkQ9eO5SlJSbS/Ii1s=
X-Received: by 2002:a05:6a20:9147:b0:220:1af3:d98f with SMTP id adf61e73a8af0-23d491221d4mr3493436637.26.1753262653286;
        Wed, 23 Jul 2025 02:24:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFLdbjhjnYdkfyrjU5ffjGqKzviUX7fhzbfayZMX0Fs1jRE595puZVjT4iJO4hden7j7BS+zw==
X-Received: by 2002:a05:6a20:9147:b0:220:1af3:d98f with SMTP id adf61e73a8af0-23d491221d4mr3493411637.26.1753262652840;
        Wed, 23 Jul 2025 02:24:12 -0700 (PDT)
Received: from [10.206.107.125] ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b3f2feabe7bsm8441323a12.32.2025.07.23.02.24.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Jul 2025 02:24:12 -0700 (PDT)
Message-ID: <5af0c2ad-de58-4858-b94d-f7dfc6359e22@oss.qualcomm.com>
Date: Wed, 23 Jul 2025 14:54:08 +0530
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
References: <22uccyp5m2szry7bpitqcav5nlvwch5eqh4mdacfedidgrnyhx@vsjobngwdkmb>
 <dc67df54-2a19-4318-acd4-b96b8549b64d@oss.qualcomm.com>
 <7ogkoxsowpd2x5qmjog4qx5eu4eiinvtnyjz5hfufgna2hz7na@oxzmowlnelxb>
 <61dd2c3f-20ac-484e-8a45-f42fd5f42b86@oss.qualcomm.com>
 <CAO9ioeX1uE3ty5oSezYOLJKqf8G5dLYAS5nRiNvryWTk0RPdEQ@mail.gmail.com>
 <f3d376cc-6e2d-4ac3-88f6-3104eec67acf@oss.qualcomm.com>
 <qw64xqfnyy76f6oawtaecvraejcwyml5k7oxdy67adj2rh46lq@nupxbuy3vwu4>
 <7505f0e8-222d-4052-8614-c12109d14bce@oss.qualcomm.com>
 <cq3qfx32dallivdcwjwqgq7kggiwucpcyhwqqlbrf6n4efkmuc@htjwnigojag2>
 <8b877eeb-941a-47c5-a67d-450dfb772d6e@oss.qualcomm.com>
 <lmytte3p2eq7fsjsbogzrqjyimlw42v2x2zystx32nuvnm62yb@wzqrmhqcrzl3>
Content-Language: en-US
From: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
In-Reply-To: <lmytte3p2eq7fsjsbogzrqjyimlw42v2x2zystx32nuvnm62yb@wzqrmhqcrzl3>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzIzMDA3OSBTYWx0ZWRfXztLOlz+WbYTV
 +y2G0hlwP0X1h+Xj2Ixl+xWUMnD4Go4ZPiumkid6Xq5NzPhr0SjINdMfmwORFIm62JnuPDcWV7B
 BxKTVHJB/Uw1liynAK3Kid0/nLPTTTVOJHXdm47v61BM3RFAcCQUMlasMu9ubHOpSJ5GMsX5ho6
 WJFF10EUd+48YizTEBKLHHV0dQtUfpY9EIWZBmibnh6FU91n5iuf1qqmLbRBZiTsrGkvJ6K8Lqx
 0GUhKTbj4rI8rnasJ42abJpYhEe7kzRilpOHJrFqOXKPiu4OdPut879tOYixrZ3FTwqr19pkp5B
 JmMqbSqil8kLxRiW0xtEa7j96heLghkGDyjoioRlT/25MlEQ4c6NSm/gaDSoxCVbK7PJWvXbSah
 ibkXV9fKvbco5vGY7z60IjeX+ZbzjqF2lGMxuelo1wNbGpSnd3RiVtZovuWoeJrkRwzrhjnN
X-Proofpoint-ORIG-GUID: JOqSOozN4hhNnVtIMNhe41ZqqZHiOPWa
X-Proofpoint-GUID: JOqSOozN4hhNnVtIMNhe41ZqqZHiOPWa
X-Authority-Analysis: v=2.4 cv=OPUn3TaB c=1 sm=1 tr=0 ts=6880aa3e cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=NEAV23lmAAAA:8 a=EUspDBNiAAAA:8
 a=kN03k85zHqnGvZpLErYA:9 a=Zd2r3LNXiuh2AZG0:21 a=QEXdDO2ut3YA:10
 a=2VI0MkxyNR6bbpdq8BZq:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-23_01,2025-07-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1015 mlxlogscore=999 lowpriorityscore=0 suspectscore=0
 spamscore=0 mlxscore=0 bulkscore=0 priorityscore=1501 phishscore=0
 malwarescore=0 impostorscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507230079



On 7/19/2025 3:14 PM, Dmitry Baryshkov wrote:
> On Wed, Jul 09, 2025 at 11:13:49AM +0530, Ekansh Gupta wrote:
>>
>> On 6/12/2025 3:54 PM, Dmitry Baryshkov wrote:
>>> On Thu, Jun 12, 2025 at 03:02:52PM +0530, Ekansh Gupta wrote:
>>>> On 6/12/2025 1:35 PM, Dmitry Baryshkov wrote:
>>>>> On Thu, Jun 12, 2025 at 10:50:10AM +0530, Ekansh Gupta wrote:
>>>>>> On 5/22/2025 5:43 PM, Dmitry Baryshkov wrote:
>>>>>>> On Thu, 22 May 2025 at 08:01, Ekansh Gupta
>>>>>>> <ekansh.gupta@oss.qualcomm.com> wrote:
>>>>>>>> On 5/19/2025 7:04 PM, Dmitry Baryshkov wrote:
>>>>>>>>> On Mon, May 19, 2025 at 04:28:34PM +0530, Ekansh Gupta wrote:
>>>>>>>>>> On 5/19/2025 4:22 PM, Dmitry Baryshkov wrote:
>>>>>>>>>>> On Tue, May 13, 2025 at 09:58:25AM +0530, Ekansh Gupta wrote:
>>>>>>>>>>>> User request for remote heap allocation is supported using ioctl
>>>>>>>>>>>> interface but support for unmap is missing. This could result in
>>>>>>>>>>>> memory leak issues. Add unmap user request support for remote heap.
>>>>>>>>>>> Can this memory be in use by the remote proc?
>>>>>>>>>> Remote heap allocation request is only intended for audioPD. Other PDs
>>>>>>>>>> running on DSP are not intended to use this request.
>>>>>>>>> 'Intended'. That's fine. I asked a different question: _can_ it be in
>>>>>>>>> use? What happens if userspace by mistake tries to unmap memory too
>>>>>>>>> early? Or if it happens intentionally, at some specific time during
>>>>>>>>> work.
>>>>>>>> If the unmap is restricted to audio daemon, then the unmap will only
>>>>>>>> happen if the remoteproc is no longer using this memory.
>>>>>>>>
>>>>>>>> But without this restriction, yes it possible that some userspace process
>>>>>>>> calls unmap which tries to move the ownership back to HLOS which the
>>>>>>>> remoteproc is still using the memory. This might lead to memory access
>>>>>>>> problems.
>>>>>>> This needs to be fixed in the driver. We need to track which memory is
>>>>>>> being used by the remoteproc and unmap it once remoteproc stops using
>>>>>>> it, without additional userspace intervention.
>>>>>> If it's the audio daemon which is requesting for unmap then it basically means that
>>>>>> the remoteproc is no longer using the memory. Audio PD can request for both grow
>>>>>> and shrink operations for it's dedicated heap. The case of grow is already supported
>>>>>> from fastrpc_req_mmap but the case of shrink(when remoteproc is no longer using the
>>>>>> memory) is not yet available. This memory is more specific to audio PD rather than
>>>>>> complete remoteproc.
>>>>>>
>>>>>> If we have to control this completely from driver then I see a problem in freeing/unmapping
>>>>>> the memory when the PD is no longer using the memory.
>>>>> What happens if userspace requests to free the memory that is still in
>>>>> use by the PD
>>>> I understand your point, for this I was thinking to limit the unmap functionality to the process
>>>> that is already attached to audio PD on DSP, no other process will be able to map/unmap this
>>>> memory from userspace.
>>> Ugh... and what if the adsprpcd misbehaves?
>>>
>>>>> How does PD signal the memory is no longer in use?
>>>> PD makes a reverse fastrpc request[1] to unmap the memory when it is no longer used.
>>> I don't see how this can be made robust. I fear that the only way would
>>> be to unmap the memory only on audio PD restart / shutdown. Such
>>> requests should never leave the kernel.
>>>
>>> Moreover, the payload should not be trusted, however you don't validate
>>> the length that you've got from the remote side.
>> I was thinking of giving the entire reserved memory to audio PD when
>> init_create_static_process is called. This way, we can avoid any need to
>> support grow/free request from user process and the audio PD pool on
>> DSP will have sufficient memory support the use cases.
>>
>> This way the free can be moved to fastrpc_rpmsg_remove(When DSP
>> is shutting down) or during Audio PD restart(Static PD restart is not
>> yet supported, but clean-up can be done when PDR framework is
>> implemented in the future).
>>
>> Do you see any drawbacks with this design?
> I'm sorry for the delay in responding to your email.
>
> I think this is a perfect idea. Can we be sure that there will be no
> extra requests from the DSP?
Thanks for the review!

With the existing design, maximum available memory from reserved_memory section
can be allocated and after that it the requests are expected to fail.

With the proposed design, as the entire memory is sent to audio PD, usually grow
request is not expected, but even if there is any grow request, it is expected to fail.

I'll send out a patch with this new design for more clear understanding.

//Ekansh
>
>>>> [1] https://github.com/quic/fastrpc/blob/development/src/apps_mem_imp.c#L231


