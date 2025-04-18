Return-Path: <linux-kernel+bounces-610726-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E2610A93841
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Apr 2025 16:08:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7297619E2216
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Apr 2025 14:08:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 576F1153836;
	Fri, 18 Apr 2025 14:08:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Htc+xI3a"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 073C514B08A
	for <linux-kernel@vger.kernel.org>; Fri, 18 Apr 2025 14:08:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744985298; cv=none; b=PaPqztt+4LMhZBtqV/OPlq3LIjPNLs07SMa1Ae1+FzmHTN0xznxGShdALM9luS/PG70Bek5Dc9THGlSE0Vutk9HUMEjWSfmtwORYM+gSCgFEOa3hbTglqePCE80ES3HWplnmU5kpUiWg6wt3ScfcwMwoJU1kt/CcVaHuWqP3IkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744985298; c=relaxed/simple;
	bh=IayX/lC6Ac5LLou9XvA+24J24Cy5CiIa+lsRgxv//FU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mFYbigWRTklPjwxHCXNCZWoMGJuBd69oN8H6iRkhOJvPDpqLnfoHZV2kYEE7i47XKynmHp02AZaSsx2zxlD6zZ3Z2jQGaPOix7hLkykz8QaBuH0zbGXYrYStGItfftBEMcVTYZjN1w+xOZlU9iJ5B3cFwvT3EdgH4ZtyWU2sApU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Htc+xI3a; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53I1q6HF013325
	for <linux-kernel@vger.kernel.org>; Fri, 18 Apr 2025 14:08:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Q/vH+9Sfq6E3MaBIjp72hTZbUkDV0ZuaPmRDacgJ8I8=; b=Htc+xI3a+RIMOw+G
	YTWHnb9WGYHf2kPEy+MOCEFV5bGRzhlEHFpazQdHh8RNMnvqcqa+ckgCdpKniKB7
	usphUSb2Q2HoHtDJzTluHliuoLXrwzTPcyk4BSCDFvsl4v0qyjtUWHHGquproMRZ
	DFMqNVmsowLqaZjAY2jfPKD/Yk87/0aUL7qaZ21x9GffpQgqx6l+g3BxutboGJlD
	Ugf32k1HLWGBN8McrszsqW6e9+LAwvdxRbLH0124Ballsn7NFoYVJqM5g3Y8XRCH
	jkw8c2unol3h+TSzx5HX5oyOgC2iyeF+MAa6ERJjQXBLln4v84/NH1GF1y30+6m+
	BUQYOg==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4628rvfemr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 18 Apr 2025 14:08:16 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-2ff798e8c90so1792654a91.1
        for <linux-kernel@vger.kernel.org>; Fri, 18 Apr 2025 07:08:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744985295; x=1745590095;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Q/vH+9Sfq6E3MaBIjp72hTZbUkDV0ZuaPmRDacgJ8I8=;
        b=lEOZdDR1Lt63Hll/2g1C6SCKTTsCTObDZtl5pa2Kqg5FeYqtSZ6HOfxOa+Z9VnFeco
         pchytY4hs+b6iCovVEObFIVugtBYkQF5kJi8iB9p17EgqXUGetKzzK2dI5Vw65EBzQgF
         eSu5wFCeEu2hKzeTOiZot375le3L94apU1tKnLk+LqJrd4IOzrKN/qaEQMuFH6mgvFSm
         u2hdShcS1TXQ56bHHNtkhvVy0qEY9TmDztjefC/e3naToUbkUu0v3zaUmLSxVtAm8+n0
         LranoyHk0bFknHoElTbAhqQvsyJv5M/NVTXG68+KyN8RE4ZZ8IlZ5FFmx9WBn8AN90eY
         h7Tw==
X-Forwarded-Encrypted: i=1; AJvYcCV88Udu0JNmXOUq0lWnDhZIDoeA/4ttFYAGdD6daCE6U8XKUgDsL5gMBdS8bRu/vQw0iMjmIZrvzD75ZCU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxV40XR2LXbU7zUFz97i6m2uO3yHjSxO1Tur/gXVGdJsqeq360i
	tVXOztHZuxJtac7hE0FnpOjM2TU9YA6mks2NTY1+HFzNyDvzir8nZqj3iQaxm1sQ8WaImt3+xKm
	prlQhCCGYMgkMhNMJFbxg7RvzPU18CkR3PvhjHAQoNrOoZSlnesJeR7hp/jx0+FM=
X-Gm-Gg: ASbGncsvO2eBiAMQY7+VINXjozxLuLAIMfEVxPZ0JQKyHlc1dqnNw8dMVv9w67c+wir
	CeUVBNa90vHA+uykXPI7qPTW/0aL9+YRJEBCzs8nxSjF6k7l3f+YNfCHoQ0ADf5NirAnp0gPykd
	1sEKfds4kjd3LCenNg9ueLUg/O+Ykjl931TgZC7tTn6gV1hITr540ytkCVabDGH4LchkLL8WQGL
	fiFbNv53qqGuESwOUcj8hHVuusYalthc+KyOtCzWz1yf1XCLybOygvinN3hT8hakrEyXinowXns
	dhKLgog9xB6dE79LYUEfL2tx1Kv36bSPF3aiMFDLNMU1queRt3izai8JOPNnmQ==
X-Received: by 2002:a17:90a:d007:b0:2fa:1e3e:9be5 with SMTP id 98e67ed59e1d1-3087ba5c5d9mr5839807a91.0.1744985294974;
        Fri, 18 Apr 2025 07:08:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF14QcScPUI1D6ZK2Za7KoGAsaU+ngiPt4WNGXk32CEHr4LdIhzYP9MJqRQIGZbWAhQyDWpGQ==
X-Received: by 2002:a17:90a:d007:b0:2fa:1e3e:9be5 with SMTP id 98e67ed59e1d1-3087ba5c5d9mr5839750a91.0.1744985294581;
        Fri, 18 Apr 2025 07:08:14 -0700 (PDT)
Received: from [10.226.59.182] (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3087e05db51sm1256470a91.43.2025.04.18.07.08.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Apr 2025 07:08:14 -0700 (PDT)
Message-ID: <822543a0-d7e1-4aec-ae1b-018b32985d1f@oss.qualcomm.com>
Date: Fri, 18 Apr 2025 08:08:11 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] bus: mhi: host: don't free bhie tables during
 suspend/hibernation
To: Muhammad Usama Anjum <usama.anjum@collabora.com>,
        Krishna Chaitanya Chundru <quic_krichai@quicinc.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Johannes Berg <johannes@sipsolutions.net>,
        Jeff Johnson
 <jjohnson@kernel.org>,
        Jeffrey Hugo <quic_jhugo@quicinc.com>, Yan Zhen <yanzhen@vivo.com>,
        Youssef Samir <quic_yabdulra@quicinc.com>,
        Qiang Yu <quic_qianyu@quicinc.com>, Alex Elder <elder@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kunwu Chan <chentao@kylinos.cn>
Cc: kernel@collabora.com, mhi@lists.linux.dev, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org,
        ath11k@lists.infradead.org
References: <20250410145704.207969-1-usama.anjum@collabora.com>
 <ba09ae0c-fe8d-8f4e-a1b8-9c7e5913c84e@quicinc.com>
 <fc9ca0da-9f6a-42b5-aa79-abcd43c97043@collabora.com>
 <e0159cb8-fe21-7f71-1ebe-744ed26bd698@quicinc.com>
 <85580a01-289a-461b-b0f1-38fa1b96717c@collabora.com>
 <1c0b2217-49d9-360c-ed60-db517eaf2ccc@quicinc.com>
 <7d6b074c-8499-4984-b235-d1285b006ab3@collabora.com>
 <ad5e99e8-3ff1-4727-aed6-528ac747f409@oss.qualcomm.com>
 <5dcf3ddf-6b0a-4b4c-b4a3-6e015a7e2f53@collabora.com>
Content-Language: en-US
From: Jeff Hugo <jeff.hugo@oss.qualcomm.com>
In-Reply-To: <5dcf3ddf-6b0a-4b4c-b4a3-6e015a7e2f53@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: O_xujq9m6VI5M-SGyj6d2-6uehyN78xk
X-Authority-Analysis: v=2.4 cv=RbSQC0tv c=1 sm=1 tr=0 ts=68025cd0 cx=c_pps a=vVfyC5vLCtgYJKYeQD43oA==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=UAfhXhcpWJM5KsTPzmsA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-GUID: O_xujq9m6VI5M-SGyj6d2-6uehyN78xk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-18_05,2025-04-17_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 suspectscore=0 adultscore=0 impostorscore=0 clxscore=1015 bulkscore=0
 phishscore=0 priorityscore=1501 spamscore=0 mlxscore=0 lowpriorityscore=0
 malwarescore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504180104

On 4/18/2025 2:10 AM, Muhammad Usama Anjum wrote:
> On 4/14/25 7:14 PM, Jeff Hugo wrote:
>> On 4/14/2025 1:32 AM, Muhammad Usama Anjum wrote:
>>> On 4/12/25 6:22 AM, Krishna Chaitanya Chundru wrote:
>>>>
>>>> On 4/12/2025 12:02 AM, Muhammad Usama Anjum wrote:
>>>>> On 4/11/25 1:39 PM, Krishna Chaitanya Chundru wrote:
>>>>>>
>>>>>>
>>>>>> On 4/11/2025 12:32 PM, Muhammad Usama Anjum wrote:
>>>>>>> On 4/11/25 8:37 AM, Krishna Chaitanya Chundru wrote:
>>>>>>>>
>>>>>>>>
>>>>>>>> On 4/10/2025 8:26 PM, Muhammad Usama Anjum wrote:
>>>>>>>>> Fix dma_direct_alloc() failure at resume time during bhie_table
>>>>>>>>> allocation. There is a crash report where at resume time, the
>>>>>>>>> memory
>>>>>>>>> from the dma doesn't get allocated and MHI fails to re-initialize.
>>>>>>>>> There may be fragmentation of some kind which fails the allocation
>>>>>>>>> call.
>>>>>>>>>
>>>>>>>>> To fix it, don't free the memory at power down during suspend /
>>>>>>>>> hibernation. Instead, use the same allocated memory again after
>>>>>>>>> every
>>>>>>>>> resume / hibernation. This patch has been tested with resume and
>>>>>>>>> hibernation both.
>>>>>>>>>
>>>>>>>>> The rddm is of constant size for a given hardware. While the
>>>>>>>>> fbc_image
>>>>>>>>> size depends on the firmware. If the firmware changes, we'll
>>>>>>>>> free and
>>>>>>>> If firmware image will change between suspend and resume ?
>>>>>>> Yes, correct.
>>>>>>>
>>>>>> why the firmware image size will change between suspend & resume?
>>>>>> who will update the firmware image after bootup?
>>>>>> It is not expected behaviour.
>>>>> I was trying to research if the firmware can change or not. I've not
>>>>> found any documentation on it.
>>>>>
>>>>> If the firmare is updated in filesystem before suspend/hibernate, would
>>>>> the new firwmare be loaded the next time kernel resumes as the older
>>>>> firmware is no where to be found?
>>>>>
>>>>> What do you think about this?
>>>>>
>>>> I don't think firmware can be updated before suspend/hibernate. I don't
>>>> see any reason why it can be updated. If you think it can be updated
>>>> please quote relevant doc.
>>> I've not found any documentation on it. Let's wait for others to review
>>> and it it cannot be updated, I'll remove this part.
>>>
>>
>> Wouldn't this be trivial to test?  Boot the device, go modify the
>> firmware on the filesystem, then go through a suspend cycle.
> I just tested this. I've used an old firmware from last year vs the
> latest one.
> 
> Firmware A: old firmware size: 5349376
> Firmware B: new firmware size: 5165056
> 
> A here has bigger size.
> 
> 1. I loaded A at boot and then replaced the firmwares in filesystem with
> B before syspend. At resume time, B was loaded fine by freeing the
> bigger memory area and allocating the smaller one.
> 
> 2. I loaded B and then replaced A in its place before suspend. At resume
> time, memory was freed and larger memory was allocated. But driver
> wasn't able to initialize correctly:
> 
> [  184.051902] ath11k_pci 0000:03:00.0: timeout while waiting for
> restart complete
> [  184.051916] ath11k_pci 0000:03:00.0: failed to resume core: -110
> [  184.051923] ath11k_pci 0000:03:00.0: PM: dpm_run_callback():
> pci_pm_resume returns -110
> [  184.051945] ath11k_pci 0000:03:00.0: PM: failed to resume async:
> error -110
> [  187.251911] ath11k_pci 0000:03:00.0: wmi command 16387 timeout
> [  187.251924] ath11k_pci 0000:03:00.0: failed to send
> WMI_PDEV_SET_PARAM cmd
> [  187.251933] ath11k_pci 0000:03:00.0: failed to enable dynamic bw: -11
> 
> So should we generalize above that changing firmware at
> suspend/hibernation time isn't supported. If firmware package is
> updated, does user restarts every time?

You may want to review how other devices handle this.  I can think of 
these threads as potential reference

https://lore.kernel.org/all/CAPM=9twyvq3EWkwUeoTdMMj76u_sRPmUDHWrzbzEZFQ8eL++BQ@mail.gmail.com/
https://lore.kernel.org/all/20250207012531.621369-1-airlied@gmail.com/

-Jeff

