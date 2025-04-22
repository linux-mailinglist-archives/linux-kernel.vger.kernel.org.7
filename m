Return-Path: <linux-kernel+bounces-614586-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 38489A96E44
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Apr 2025 16:23:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7068F3A6217
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Apr 2025 14:22:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF60E2820C6;
	Tue, 22 Apr 2025 14:22:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="BkaCXPe3"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7817428150D
	for <linux-kernel@vger.kernel.org>; Tue, 22 Apr 2025 14:22:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745331773; cv=none; b=ANPtgd8mh816OWoVDDQIJBQvyHkZZfIH+256uuEZ1WfrTNI7xqfy8inN+dNpQc68digSMK6Lwp68xZ3xbF4HeW0YmqgIDD/zj0jVNzyAA1j/Fg5NHCWsIUOtH+zGzJxkpoBm/9cWKp8YJUGO1nLFwxCnGbUrjUhb3MShqPGR7Gc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745331773; c=relaxed/simple;
	bh=EzYK2Vv5I+NwzoYvDIFVIzPsytRC007d9duriSbWGas=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=N/eDkpBh2IIKx5GMJ4kKZMK8aLzv+5xhIZ2kGlDDT2ed15clZt2B8epxM/xvDtu9wUL7HEhCsbxC9fhCWG2P6ou0RDSRlk0zNAwvkPBBLhItU1DzE3j1mMtOmu1qVS07ydIqEnUZg5LuFHHyVLyQELEjsyWMRVhP2BxBbzCmGf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=BkaCXPe3; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53MD1oCc021574
	for <linux-kernel@vger.kernel.org>; Tue, 22 Apr 2025 14:22:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	VDUMhJwzGuaWJ9KiJYGjIED1/r5S129iPKRbB3m5fPA=; b=BkaCXPe3cYsIwZIN
	s38EPhP6qBwkc3qcba6iEdUj1VjtR3uGjDIoETiJyHwRNjRh+WsN8WT/k9gzYjgH
	C0CgaII10tHy84ybg+bxqcR1syBiZ0mL0z+vWI3m7DGyAFsDPa18kNSAa8hIEplB
	XAcAZdHT+AQek8drzZLsFRKaSqQmuz4Fr6E56pQORetkAzuhkPqicYlZM0bfRUQb
	ioMV7XC6CjNVsHMiYEKz7es3w8D1BIEIweS4f2QvMUvO/jcreHKmXGuu1TDDEbRp
	apQbaxcDYf3Imoi2gkRlp4b+BrJJj15DS+iTTI8nvtxAcLp1o4KD0x2+CJjtn3CA
	w8lSGA==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4642svfu3y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 22 Apr 2025 14:22:51 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-af2f03fcc95so5586104a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 22 Apr 2025 07:22:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745331770; x=1745936570;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VDUMhJwzGuaWJ9KiJYGjIED1/r5S129iPKRbB3m5fPA=;
        b=KQx8yvuU+HFZP8px0lz85XmQbkgVVOsNIXvRDcCVDPf3hKKlx6UkXNuBR6X/LemJEe
         wHCvvPfVAXc5vJ5f1KFBNQ4FgNv445XzwA7xffgNBFUlDY1mquJCt2XUHx7R0IEJzbo5
         W+HT+kAszLmxEz+RON328vH9GVKYWt6puqirpGPpH24oI5NokkodmfFVaGu+Xi2d9Kv3
         KXjbI4uvZumZuacpwAVaW2wLaEeCP0HPPPTxxqF5omt7nDqwjDHygKB7UXx1x6jgAKAG
         wIka+i7lN6q6zbljN308Tce6RQPkVi8zE97hA8abqSqktBtuDqne3C9T4IqpxLHYOuW4
         hpoQ==
X-Forwarded-Encrypted: i=1; AJvYcCXaQ24O0ZLCzoF0AFX9uVHvHV7GWPPoZjTv3wTIQkc8vG0HGhAb7Px6GmHbSmc0LZZLYjy4f+VzKrxJoRM=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywjk0QdAGOaNHvf5fVMvysibZ4zLuVRkvGDF0+y9bgZMdHUf5aE
	sHKIx97R5dB8cYHHoR1HQ9suF+VUkRJni7GjPqomGA2Ou3L4nMIdm+G+sG8L0qIsKV5KiA/p4zs
	yPPEmeMH8mz5PHktTZXPOs2Zp2OAkznmQRWq81sB0lxVQgXMkqRBy1s+4AY4XGF0=
X-Gm-Gg: ASbGncueHizCI8x1biVqNjv1pOTt29LOQEKHmKL8VoppQuK0LP4/EiH4BREN2IzvTjN
	ypitHklVMEbIW2+7lyxG+MXUhe8Yx3tG9lG3PeU5l73VR9Waxo0rGdSHWKR2VzXWcGxEEKaJr4y
	OqNPM3P6c2idx0DP7eDL8d1+eqLlZjD4wfoBzdoEISOwEA1cYl/4eaceErZcAaUu79Ph36oFiE1
	+GGsAa7r4VR7tv6V2nhklHqoNIlW427vdrUKYd2viyJUEXN7HGNAJ5pAWB122sxLCy7yFn0o6nN
	gynIu6/myxduRKOB4FXFntLfkUvwBb1RIGDIu6j3MueN79QZFVMzoc8hXEvWCw==
X-Received: by 2002:a17:903:191:b0:224:194c:6942 with SMTP id d9443c01a7336-22c53607ff7mr243147055ad.34.1745331770427;
        Tue, 22 Apr 2025 07:22:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFcL0j1OxOa0IGTbFKXINvvIo5ANKYI+5b/cjiegYk7qV3IMC4ckUaP/KOJ1rfgkWh4KCpk1w==
X-Received: by 2002:a17:903:191:b0:224:194c:6942 with SMTP id d9443c01a7336-22c53607ff7mr243146475ad.34.1745331769887;
        Tue, 22 Apr 2025 07:22:49 -0700 (PDT)
Received: from [10.226.59.182] (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22d78db8b04sm62553865ad.238.2025.04.22.07.22.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Apr 2025 07:22:49 -0700 (PDT)
Message-ID: <c1fdbd16-4197-4a2e-a33d-6b29cc285f0a@oss.qualcomm.com>
Date: Tue, 22 Apr 2025 08:22:47 -0600
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
 <822543a0-d7e1-4aec-ae1b-018b32985d1f@oss.qualcomm.com>
 <1bf328cd-d301-4d1f-a8f5-7020d9e25ea5@collabora.com>
Content-Language: en-US
From: Jeff Hugo <jeff.hugo@oss.qualcomm.com>
In-Reply-To: <1bf328cd-d301-4d1f-a8f5-7020d9e25ea5@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: IsGYbk5qbEd_xjCE_Nz-fQskTwGzevZ_
X-Proofpoint-ORIG-GUID: IsGYbk5qbEd_xjCE_Nz-fQskTwGzevZ_
X-Authority-Analysis: v=2.4 cv=QLJoRhLL c=1 sm=1 tr=0 ts=6807a63b cx=c_pps a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=xyljDXbKnjJUPSj0334A:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=x9snwWr2DeNwDh03kgHS:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-22_07,2025-04-22_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0
 lowpriorityscore=0 mlxscore=0 spamscore=0 mlxlogscore=999 malwarescore=0
 adultscore=0 phishscore=0 suspectscore=0 impostorscore=0
 priorityscore=1501 clxscore=1015 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502280000 definitions=main-2504220109

On 4/22/2025 1:23 AM, Muhammad Usama Anjum wrote:
> On 4/18/25 7:08 PM, Jeff Hugo wrote:
>> On 4/18/2025 2:10 AM, Muhammad Usama Anjum wrote:
>>> On 4/14/25 7:14 PM, Jeff Hugo wrote:
>>>> On 4/14/2025 1:32 AM, Muhammad Usama Anjum wrote:
>>>>> On 4/12/25 6:22 AM, Krishna Chaitanya Chundru wrote:
>>>>>>
>>>>>> On 4/12/2025 12:02 AM, Muhammad Usama Anjum wrote:
>>>>>>> On 4/11/25 1:39 PM, Krishna Chaitanya Chundru wrote:
>>>>>>>>
>>>>>>>>
>>>>>>>> On 4/11/2025 12:32 PM, Muhammad Usama Anjum wrote:
>>>>>>>>> On 4/11/25 8:37 AM, Krishna Chaitanya Chundru wrote:
>>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>> On 4/10/2025 8:26 PM, Muhammad Usama Anjum wrote:
>>>>>>>>>>> Fix dma_direct_alloc() failure at resume time during bhie_table
>>>>>>>>>>> allocation. There is a crash report where at resume time, the
>>>>>>>>>>> memory
>>>>>>>>>>> from the dma doesn't get allocated and MHI fails to re-
>>>>>>>>>>> initialize.
>>>>>>>>>>> There may be fragmentation of some kind which fails the
>>>>>>>>>>> allocation
>>>>>>>>>>> call.
>>>>>>>>>>>
>>>>>>>>>>> To fix it, don't free the memory at power down during suspend /
>>>>>>>>>>> hibernation. Instead, use the same allocated memory again after
>>>>>>>>>>> every
>>>>>>>>>>> resume / hibernation. This patch has been tested with resume and
>>>>>>>>>>> hibernation both.
>>>>>>>>>>>
>>>>>>>>>>> The rddm is of constant size for a given hardware. While the
>>>>>>>>>>> fbc_image
>>>>>>>>>>> size depends on the firmware. If the firmware changes, we'll
>>>>>>>>>>> free and
>>>>>>>>>> If firmware image will change between suspend and resume ?
>>>>>>>>> Yes, correct.
>>>>>>>>>
>>>>>>>> why the firmware image size will change between suspend & resume?
>>>>>>>> who will update the firmware image after bootup?
>>>>>>>> It is not expected behaviour.
>>>>>>> I was trying to research if the firmware can change or not. I've not
>>>>>>> found any documentation on it.
>>>>>>>
>>>>>>> If the firmare is updated in filesystem before suspend/hibernate,
>>>>>>> would
>>>>>>> the new firwmare be loaded the next time kernel resumes as the older
>>>>>>> firmware is no where to be found?
>>>>>>>
>>>>>>> What do you think about this?
>>>>>>>
>>>>>> I don't think firmware can be updated before suspend/hibernate. I
>>>>>> don't
>>>>>> see any reason why it can be updated. If you think it can be updated
>>>>>> please quote relevant doc.
>>>>> I've not found any documentation on it. Let's wait for others to review
>>>>> and it it cannot be updated, I'll remove this part.
>>>>>
>>>>
>>>> Wouldn't this be trivial to test?  Boot the device, go modify the
>>>> firmware on the filesystem, then go through a suspend cycle.
>>> I just tested this. I've used an old firmware from last year vs the
>>> latest one.
>>>
>>> Firmware A: old firmware size: 5349376
>>> Firmware B: new firmware size: 5165056
>>>
>>> A here has bigger size.
>>>
>>> 1. I loaded A at boot and then replaced the firmwares in filesystem with
>>> B before syspend. At resume time, B was loaded fine by freeing the
>>> bigger memory area and allocating the smaller one.
>>>
>>> 2. I loaded B and then replaced A in its place before suspend. At resume
>>> time, memory was freed and larger memory was allocated. But driver
>>> wasn't able to initialize correctly:
>>>
>>> [  184.051902] ath11k_pci 0000:03:00.0: timeout while waiting for
>>> restart complete
>>> [  184.051916] ath11k_pci 0000:03:00.0: failed to resume core: -110
>>> [  184.051923] ath11k_pci 0000:03:00.0: PM: dpm_run_callback():
>>> pci_pm_resume returns -110
>>> [  184.051945] ath11k_pci 0000:03:00.0: PM: failed to resume async:
>>> error -110
>>> [  187.251911] ath11k_pci 0000:03:00.0: wmi command 16387 timeout
>>> [  187.251924] ath11k_pci 0000:03:00.0: failed to send
>>> WMI_PDEV_SET_PARAM cmd
>>> [  187.251933] ath11k_pci 0000:03:00.0: failed to enable dynamic bw: -11
>>>
>>> So should we generalize above that changing firmware at
>>> suspend/hibernation time isn't supported. If firmware package is
>>> updated, does user restarts every time?
>>
>> You may want to review how other devices handle this.  I can think of
>> these threads as potential reference
>>
>> https://lore.kernel.org/all/
>> CAPM=9twyvq3EWkwUeoTdMMj76u_sRPmUDHWrzbzEZFQ8eL++BQ@mail.gmail.com/
>> https://lore.kernel.org/all/20250207012531.621369-1-airlied@gmail.com/
> They are talking about firmware cache which is not being used in the
> wireless drivers. In my kernel config, firwmare cache is enabeld. But
> everytime kernel needs to read the firwamre, it reads from the filesystem.
> 
> What can be the way forward for this patch? Assuming my previous
> experiment with changed firmwares across suspend/resume failed, I should
> remove reuse logic and send again?

Perhaps you need to refactor the wireless drivers?

I'm not convinced your patch is valid.  If FW needs to be reloaded due 
to suspend/resume, it seems like the proper thing is to load the same FW 
that was loaded at device boot.  Per your testing, loading changed FW 
can cause a failure.  Even if it doesn't fail, will the changed firmware 
cause a "breakage" from the user perspective by modifying the device 
behavior?

This does not seem to be a problem that is relevant to all MHI devices, 
so whatever the end solution ends up being, I think that it should not 
be blanket applied to all of MHI.

-Jeff

