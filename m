Return-Path: <linux-kernel+bounces-879500-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 238A3C2340E
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 05:35:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 40FF81A2538D
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 04:36:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF18C279DA2;
	Fri, 31 Oct 2025 04:35:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="MUP9Idyh";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="EJ4pkpDY"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67FAD2475C7
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 04:35:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761885329; cv=none; b=V1Nmuda/AuGy7E5S3KeoouKLlvI/wHBMSmUfksIFRJWDpprw1pGm5OsGBKWGBXCd4veyXgIv1v+wc8i1YSBEsJclGGpuCWwa0HhAGCkyPGDhfNFlhjhWtdX5iH6Eigp3WhMmZgUvjm5hIXRZ1fEAxREXRw7DUFi00WkjGwsuxmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761885329; c=relaxed/simple;
	bh=2RkTq0rhVoKsR1VNjNAG0HX3RDYk3Nzrb7saSouIbPA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fYqk8d10fUO8iWNduHbO8UeZO2HQcAfiv07GpGpkL7NMXzJKjNIbYz4YU8ZMEeRxJTeuGjEqFglC1+WNhmwnpc9kWeiujXHlId3/3fGmETdXvvbNbs3M2nBQf+Y4sCcGZKGAeqtNpPWSyh4Mv+o+F2ReoiGVEUNZAJLxEgz+8D8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=MUP9Idyh; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=EJ4pkpDY; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59V2B6wM102654
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 04:35:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	EuOLaPuNvhPnBElt9P239rj2PXCSR2QMFESyHvBzQjc=; b=MUP9Idyhbq28KkTN
	rFTRQCV1mThNKIqNaWanu9fukb6ci8CIoFKgHXdVZQY4yCBHGNaEguWlXyJOtRpS
	v6ZwIryZ3ksVJh60nMhWkoemTIXk7jK9EZcK1uExcsY+NfiOQ4yjaL/ee5xlTrTJ
	5YFEO+xe4tdgq382D+R2s32SXePU5FbFkSCr0ocYuXw+2EPgDN2upc2qcdi8kdGM
	TcYHgROfOhdhLvdX2Cuch2rwCqSYwZoR0pUQvFziy4dhGn4n/lb5QoAH+UG4VQfu
	EuzWEecOa1PoxV3cxHFG3tES0LV/W5IcNl8rMF/X04PwC0zRDpv2gXBm+dGBMTyX
	XXePaQ==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a4ahdhvmu-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 04:35:26 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-294ecd3fdd4so18272465ad.3
        for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 21:35:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1761885326; x=1762490126; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EuOLaPuNvhPnBElt9P239rj2PXCSR2QMFESyHvBzQjc=;
        b=EJ4pkpDYNQoUOImMUiSj7KVwuRYz+qEKJA8sNzW7v431psCWV0AGgOwrfzIlS5AyDk
         V7yxuDuX+36QjNbZb3G8cRg/V3DSqPEQTFa3P82rePd3y0UT7lfU8YhrxoVOMv0eG2wv
         Mne5SyApapY7deDeTzP0TmmKn85+RxctKbR84+9F7VjPPNStQJmIa08H9DylDWS0E1m6
         tJoNN5dUKqekNawMO4obzaTuwBQDlsIAVAJMmoToXIIN0FzOivmfMZcPj3zvu2wJx0CJ
         U5PbWANy0nUbYwqZgkXfLgZVyRaF0QGehgCt06eDmJKITZu7V3X1BN2BtKiXKVfAQOTu
         2fCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761885326; x=1762490126;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EuOLaPuNvhPnBElt9P239rj2PXCSR2QMFESyHvBzQjc=;
        b=LBcEY59/P6UxEDbHTc587+0N3TAjZBtCnPWvUd5QdYzmTbAK4zPAZFbgzSujHC+TKR
         qM+KK2W7FCiLW8r89G4/JqdlWSC2b4wMM0sT3J4d16oSvcqUXr/q+vExbnHLuCOBokVY
         ChtnsvFuGzcvR8f/DK3BgqeJHs0UUs0GlqhOTvnkNZby/swJXBYSXzFqMP5LoZHBI+15
         6fTV/9q1NpMDODJcHovjoYT9/7szN7ZZswUGB0K/uY9dXZY2+YQz84lNVYSjajfwFXOA
         pgtvlh54LJiQ8zlzattGSvD+HLVg8paAD1a5TzyPjn6WCrbAcKts502Ufa7ksLd+2UDV
         RRAQ==
X-Forwarded-Encrypted: i=1; AJvYcCUJ3gEdqyl+I7Ihif1BTDuC6tKo77i8e6oMzjEGsoCzpwb9nWBjF1Ggs1DXn8cXBl2xVVqaruTsQq7oIec=@vger.kernel.org
X-Gm-Message-State: AOJu0YwPZ1PGk/UmMhIYuNBwMKM9+Hg4UYkQf7BfntmpEfxyiv4+ZKCO
	9NQgyOY/ZPB+uK2GBTgGGOo5ZkhBdYXnLOPrCaYfcXqOQSZ+DzDVtQ2ChOmevLoLLWFbOS9SwKG
	SFeclssdRIdp0/RKpudiBYrrpf+RjUr0dpyOgfFFEPMSeTaCY6nzH5NHQjkeGHIi2OkA=
X-Gm-Gg: ASbGnct9ioDluemvKs6Ghw65blU0WSCoLfjCRDLJ0S+/Y1y0OjaSdc5RqZg9H/B1SqF
	L5AdG07ZLe8KcCQHveV7MAwuwGDdc7v6aYQWJ34DWYrTQBc6yhcRD6Mhvj92hM47UHAGBAt/U0S
	zxd7vwjYqm7ZFwEi62MggVniYAW37ETa1eqbezENWkXAXp3SKmomtZpZJnZ+HGzvTnk88lhWZUd
	pLizlVm9ypn7HWDm2vzgTj9IXhelouPEWchP6pk7v+se84DUlKpq7GQXR1aOPx2zMfxh7VxHKjz
	9Im4RfUTX7l2/ouOaShnLZuzJK8IU3uS2qXOiuvVmLVxJs/gsNxxdM0xKCaVvnBai+zvfuSOKP4
	3CcZslyykaRHIOw0TLDEguXoPcsKx7CjHS7gkhnSHVEA=
X-Received: by 2002:a17:902:ecd0:b0:27d:339c:4b0 with SMTP id d9443c01a7336-2951a442a63mr31771485ad.35.1761885325517;
        Thu, 30 Oct 2025 21:35:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFYwp4gUP3Vqxs6YlD5SUkE5WEyM8hNdIE8OE4YwxUbkR5V/o2G6bSftOCOg8QaxCCk4ML4GA==
X-Received: by 2002:a17:902:ecd0:b0:27d:339c:4b0 with SMTP id d9443c01a7336-2951a442a63mr31771125ad.35.1761885324915;
        Thu, 30 Oct 2025 21:35:24 -0700 (PDT)
Received: from [10.151.37.217] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b93be4f8d1esm572662a12.26.2025.10.30.21.35.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Oct 2025 21:35:23 -0700 (PDT)
Message-ID: <7788e25c-4622-4c7d-86b8-0827aac917af@oss.qualcomm.com>
Date: Fri, 31 Oct 2025 10:05:19 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] soc: qcom: smem: introduce qcom_smem_validate_item
 API
To: Christopher Lew <christopher.lew@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>
Cc: Chris Lew <chris.lew@oss.qualcomm.com>,
        Konrad Dybcio <konradybcio@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20251030-image-crm-part2-v1-0-676305a652c6@oss.qualcomm.com>
 <20251030-image-crm-part2-v1-1-676305a652c6@oss.qualcomm.com>
 <b46wt76zmlms5h6zkner2rr22hwmsz422jy44qziqe6a2c4qrt@i5x7j6vgrzqo>
 <CAOdFzcjzzymRxqoeF+FDidDo1aa-fNzV-3kERoV7HRW7RpQ1kA@mail.gmail.com>
Content-Language: en-US
From: Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>
In-Reply-To: <CAOdFzcjzzymRxqoeF+FDidDo1aa-fNzV-3kERoV7HRW7RpQ1kA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDMxMDAzOSBTYWx0ZWRfX8IO5ZxmBsYXb
 o8n9RrO5KDCg4RVYr47AttGD4qqqWVN6aGu72j8uZ2/T/Xc2fx645hRESBlqsgnobyupMW3Y2Ag
 l+P1FDUk0mEY2Qjcj6Wi8EhvnHc8FZXmyr/DuligKM76WRySEAzhR76B4csulaaoN8zZne8S2Rn
 txVDVhjH3b1PcD9woKzNw8Lo1g7/eWBj4HuP/VtOhdNClIW3pK8Ojn5cYF7AnQTtvy/sJF9mEr5
 k2Ih4JVzEGN+U6aWn6pQnqI2jfmrkI8i/jlG0X7uHqVGw1SDtzaSECN0PkqochjBpcfkjqt3v0b
 g3NsTczJSFvxeIi/5Uratp9p7h8C4zZwSVsTlMkVXY2NxHQZLMjxHuDnhqx70E3zUUcIEDzHDkR
 24ocuN5oKaG82T0cnYyMlgkJNQ9pFQ==
X-Proofpoint-GUID: B_AZR4eATb2TgTATVYwnGT8jhT1fsR3d
X-Authority-Analysis: v=2.4 cv=TsnrRTXh c=1 sm=1 tr=0 ts=69043c8e cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=I4BHqWkteyIiaMOeR1wA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-ORIG-GUID: B_AZR4eATb2TgTATVYwnGT8jhT1fsR3d
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-10-30_08,2025-10-29_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 priorityscore=1501 impostorscore=0 lowpriorityscore=0
 spamscore=0 bulkscore=0 phishscore=0 suspectscore=0 adultscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2510240001
 definitions=main-2510310039


On 10/31/2025 6:10 AM, Christopher Lew wrote:
> On Thu, Oct 30, 2025 at 9:48 AM Bjorn Andersson <andersson@kernel.org> wrote:
>> On Thu, Oct 30, 2025 at 03:07:48PM +0530, Kathiravan Thirumoorthy wrote:
>>> When a SMEM item is allocated or retrieved, sanity check on the SMEM item
>>> is performed and backtrace is printed if the SMEM item is invalid.
>>>
>> That sounds overly defensive...
>>
> Discussed with Bjorn a bit offline and we couldn't come up with a
> really good reason to keep the WARN_ON() check.
> Dropping WARN_ON() and returning an error back from qcom_smem_get()
> that clients can act on should suffice.


Thanks Bjorn and Chris for the comments and the suggestions. Based on 
the below feedback from Chris, I understand that we can just drop the 
WARN_ON() on both places. I will submit the V2 with that address.


>
>>> Image version table in SMEM contains version details for the first 32
>>> images. Beyond that, another SMEM item 667 is being used, which may not
>>> be defined in all the platforms. So directly retrieving the SMEM item 667,
>>> throws the warning as invalid item number.
>>>
>>> To handle such cases, introduce a new API to validate the SMEM item before
>>> processing it. While at it, make use of this API in the SMEM driver where
>>> possible.
>>>
>>> Signed-off-by: Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>
>>> ---
>>>   drivers/soc/qcom/smem.c       | 16 ++++++++++++++--
>>>   include/linux/soc/qcom/smem.h |  1 +
>>>   2 files changed, 15 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/drivers/soc/qcom/smem.c b/drivers/soc/qcom/smem.c
>>> index c4c45f15dca4fb14f97df4ad494c1189e4f098bd..8a0a832f1e9915b2177a0fe08298ffe8a779e516 100644
>>> --- a/drivers/soc/qcom/smem.c
>>> +++ b/drivers/soc/qcom/smem.c
>>> @@ -396,6 +396,18 @@ bool qcom_smem_is_available(void)
>>>   }
>>>   EXPORT_SYMBOL_GPL(qcom_smem_is_available);
>>>
>>> +/**
>>> + * qcom_smem_validate_item() - Check if SMEM item is within the limit
>> If nothing else, this contradicts the comment by SMEM_ITEM_COUNT.
>>
>>> + * @item:    SMEM item to validate
>>> + *
>>> + * Return: true if SMEM item is valid, false otherwise.
>>> + */
>>> +bool qcom_smem_validate_item(unsigned item)
>>> +{
>>> +     return item < __smem->item_count;
>>> +}
>>> +EXPORT_SYMBOL_GPL(qcom_smem_validate_item);
>>> +
>>>   static int qcom_smem_alloc_private(struct qcom_smem *smem,
>>>                                   struct smem_partition *part,
>>>                                   unsigned item,
>>> @@ -517,7 +529,7 @@ int qcom_smem_alloc(unsigned host, unsigned item, size_t size)
>>>                return -EINVAL;
>>>        }
>>>
>>> -     if (WARN_ON(item >= __smem->item_count))
>>> +     if (WARN_ON(!qcom_smem_validate_item(item)))
>> When we're using a version 11 (global heap, with toc indexed by the item
>> number) the SMEM_ITEM_COUNT actually matters, but when we use version 12
>> the items are stored in linked lists, so the only limit I can see is
>> that the item needs to be max 16 bit.
>>
>> I think we should push this check down to qcom_smem_alloc_global().
>>
>> And have a sanity check for item in qcom_smem_alloc_private() and
>> qcom_smem_get_private() to avoid truncation errors.
>>
> For alloc, I think we should adhere to the platform defined max
> item_count. I'm not sure if the remote hosts validate the entries
> against item_count while they are iterating through the items during
> their implementation of qcom_smem_get().
>
>>>                return -EINVAL;
>>>
>>>        ret = hwspin_lock_timeout_irqsave(__smem->hwlock,
>>> @@ -690,7 +702,7 @@ void *qcom_smem_get(unsigned host, unsigned item, size_t *size)
>>>        if (!__smem)
>>>                return ptr;
>>>
>>> -     if (WARN_ON(item >= __smem->item_count))
>>> +     if (WARN_ON(!qcom_smem_validate_item(item)))
>> I think we should push this check down to qcom_smem_get_global()
>>
>> I guess we'd still hit your problem on version 11 platforms if we keep
>> the WARN_ON(), but I don't know why that's reason for throwing a splat
>> in the log. Let's drop the WARN_ON() as well.
>>
> I think it's worth keeping the item_count check here because it acts
> as a quick short circuit out of the search loop for absurd values in
> qcom_smem_get_private().
>
> Thanks,
> Chris
>
>>>                return ERR_PTR(-EINVAL);
>>>
>>>        if (host < SMEM_HOST_COUNT && __smem->partitions[host].virt_base) {
>>> diff --git a/include/linux/soc/qcom/smem.h b/include/linux/soc/qcom/smem.h
>>> index f946e3beca215548ac56dbf779138d05479712f5..05891532d530a25747afb8dc96ad4ba668598197 100644
>>> --- a/include/linux/soc/qcom/smem.h
>>> +++ b/include/linux/soc/qcom/smem.h
>>> @@ -5,6 +5,7 @@
>>>   #define QCOM_SMEM_HOST_ANY -1
>>>
>>>   bool qcom_smem_is_available(void);
>>> +bool qcom_smem_validate_item(unsigned item);
>> This makes the API clunky for no real reason, let's avoid that.
>>
>>
>> Adding Chris, in case I'm overlooking something here.
>>
>> Regards,
>> Bjorn
>>
>>>   int qcom_smem_alloc(unsigned host, unsigned item, size_t size);
>>>   void *qcom_smem_get(unsigned host, unsigned item, size_t *size);
>>>
>>>
>>> --
>>> 2.34.1
>>>

