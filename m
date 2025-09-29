Return-Path: <linux-kernel+bounces-836545-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D73C2BA9FAF
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 18:14:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8C4853B1900
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 16:14:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 722AA30C0F8;
	Mon, 29 Sep 2025 16:13:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dOFqC+nD"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A8602EB5AF
	for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 16:13:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759162437; cv=none; b=qgiY4VRgmY8F+oWR7Nlua3IlPXtqobX/dBXigySoWfCgDg3p7t140ZqdjhBOsLJKr6iI2V/JlPsrPDbVYfQMXJLRGa2MDgJTNOel7LNRd6berSXtoTW0ZSXI0U/T6JHWMYcu84skvTT1WhUMeYUtB9FGYZCW6P5gF4o725De0tM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759162437; c=relaxed/simple;
	bh=HfPpVOATPK+zR25Vh8mR1pKAlKGnw5t9Y66vFudTmos=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FjGxzANW3541VMC2RiHFTC55Ul5yGJxjaPShImaOQLwXa4sX5Z340yWSoXOAuRtcxv8EsWF6dlTxBEEULApqQ5RMoyqQJ5U9yTzd4AYborva1b0TdnujJLH6H1n++btYnTSbhNXR2Xkv8ATocdkPN9B38U7TvmUpgckQpBIAJ6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dOFqC+nD; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759162435;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=CMjKy42+gbCbyaTX2+DnN1ff8sLEDP8LC/4AUZpgyCM=;
	b=dOFqC+nDYABPzHMXzkV6FgDKYDwLKgQhwXeVwuOP9u8kxir0e6B9OlPQNudMuzqfmL4Tw4
	pOAJhs+67zYkg0RlbT6hnvV8F4k/HqBHFlq4OASM0EAvMUSqEVyDjhgFT13ZIKSclFR5Lp
	K5j12Xx5zWaFFpQW0jZHKz2WJdPhdpc=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-440-l3dGcD46O9GuXQgXA3hjuQ-1; Mon, 29 Sep 2025 12:13:53 -0400
X-MC-Unique: l3dGcD46O9GuXQgXA3hjuQ-1
X-Mimecast-MFC-AGG-ID: l3dGcD46O9GuXQgXA3hjuQ_1759162432
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-46e502a37cdso7946565e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 09:13:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759162432; x=1759767232;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CMjKy42+gbCbyaTX2+DnN1ff8sLEDP8LC/4AUZpgyCM=;
        b=SNUXgnWjQx5gc0WSOi2a9iCi0gOFN8O+sLQ8mbdM31WGWcH9OlsI+8eaej20Nb4ZJv
         gMlVOHXusFSv4OTmPhkfFGqoU4MxiUwysq3DqGDK2g952uC3+nMiA9H/KHTWpnKA1qg8
         V0TvkMbgig/jBBCui025jwCa3eE8BjMRgfgpeuWBGEBfCGiH6fVNzbJbHRyRbS4OT90V
         5waToyUNYnvV7F8VVEmfFMS/SmnDUtSQbSSMlh8CZyo6DjKFslunbiCf0KlB/QnIRg7z
         6Y5kUGEKw4n7ApoPPLlBcpkDmcIx2b6x7JuHB6xzO/rwX6FtNRDuMjal4r23v06agDKq
         pWmg==
X-Forwarded-Encrypted: i=1; AJvYcCVUJ1T+G9VsjVnxIKlbOopyDptDyKgegW+oR9vlr/kxu/dSPSj8S6rvlQ+Zd8HBxl6jJm68skfFgxBr7IE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxhVLDim7vVYJJb9udcg3dgqweNEWJwFIp2YTAZNBYzHHGouNtw
	AGdG/9EpPOCtctAWSsSXjPZdbGsZYNe39McSTjufnBOaoF7ZNU+P3XgJZsAq8xvGo6iC8g86Txy
	olehTSWivBhAbiY7XVaMdi9vbLtGQQH5y8wCckhqQw09xKCg8LEcUHEIIPryVu6aLXA==
X-Gm-Gg: ASbGncv/8/y6Fv7ZbnwJ3zPZWPlfX3ACzCJEVd2kaCaO4irO4iQCmvVRT6J//PslCGq
	8yvqOHZDAh3E4qwErrxpu1RYap20WHC/LyvMUtfNGPf6Zfh3aqxJLnyYSsOhkpncunSEtP0Pp9d
	xG23r3y2pu1jvtKRD6/kKViCayIiYZY1Xu3s4YxfpYn7llZ5MQWib5PbBH1B8qcKduqZDd5vbZ9
	jSBhgRW8ZYBKaY6JHESjKtQlSpxvirAlcw0UDCdSUQW9jCIRnrbmlzzZSwT+BSxd4j3bm5C/r4E
	KR8vJkDxnMIo+0fFyeWTR5w5o+41j28T1odp0mdirm5liuIFXxjkd4qd6u26UB/Ia9drsBm55to
	f7a4=
X-Received: by 2002:a05:600c:4e4a:b0:46e:4b79:551 with SMTP id 5b1f17b1804b1-46e4b7906ecmr83712625e9.31.1759162432341;
        Mon, 29 Sep 2025 09:13:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHoFc8xuMuPIzOs6RnpSitU5twwvIzI1pUCORRMzQfKguRrIHl6sk9Twc5C6wBlCIFOmhcdpQ==
X-Received: by 2002:a05:600c:4e4a:b0:46e:4b79:551 with SMTP id 5b1f17b1804b1-46e4b7906ecmr83710625e9.31.1759162429891;
        Mon, 29 Sep 2025 09:13:49 -0700 (PDT)
Received: from ?IPV6:2a01:599:901:4a65:f2e2:845:f3d2:404d? ([2a01:599:901:4a65:f2e2:845:f3d2:404d])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-40fb72fb2eesm19397965f8f.12.2025.09.29.09.13.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Sep 2025 09:13:49 -0700 (PDT)
Message-ID: <06874ec1-5e92-4988-95ed-e4fdbb041845@redhat.com>
Date: Mon, 29 Sep 2025 18:13:47 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [syzbot] [mm?] WARNING in memory_failure
To: Zi Yan <ziy@nvidia.com>, "Pankaj Raghav (Samsung)"
 <kernel@pankajraghav.com>
Cc: Luis Chamberlain <mcgrof@kernel.org>,
 syzbot <syzbot+e6367ea2fdab6ed46056@syzkaller.appspotmail.com>,
 akpm@linux-foundation.org, linmiaohe@huawei.com,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, nao.horiguchi@gmail.com,
 syzkaller-bugs@googlegroups.com
References: <68d2c943.a70a0220.1b52b.02b3.GAE@google.com>
 <ce93b55c-75a7-4b4d-a68b-9d80baf1578b@redhat.com>
 <DB0E39CD-36A9-4929-BCC6-33F27E387AEA@nvidia.com>
 <70522abd-c03a-43a9-a882-76f59f33404d@redhat.com>
 <B0781266-D168-4DCB-BFCE-3EA01F43F184@nvidia.com>
 <cad74ef8-3543-4fc5-a175-8fc23a88776a@redhat.com>
 <E82638DD-9E5D-4C69-AA0F-7DDC0E3D109B@nvidia.com>
 <fzfcprayhtwbyuauld5geudyzzrslcb3luaneejq4hyq2aqm3l@iwpn2n33gi3m>
 <80D4F8CE-FCFF-44F9-8846-6098FAC76082@nvidia.com>
 <w2kwxcd6br6h4tdn6xigtuf73qklt6jhxvhtcwp7idugycgxlv@vqjx26vrnwu5>
 <CB2E9455-480C-438F-982A-AFCA1051BBDF@nvidia.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <CB2E9455-480C-438F-982A-AFCA1051BBDF@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 29.09.25 17:20, Zi Yan wrote:
> On 29 Sep 2025, at 7:08, Pankaj Raghav (Samsung) wrote:
> 
>>>
>>> I want to change all the split functions in huge_mm.h and provide
>>> mapping_min_folio_order() to try_folio_split() in truncate_inode_partial_folio().
>>>
>>> Something like below:
>>>
>>> 1. no split function will change the given order;
>>> 2. __folio_split() will no longer give VM_WARN_ONCE when provided new_order
>>> is smaller than mapping_min_folio_order().
>>>
>>> In this way, for an LBS folio that cannot be split to order 0, split
>>> functions will return -EINVAL to tell caller that the folio cannot
>>> be split. The caller is supposed to handle the split failure.
>>
>> IIUC, we will remove warn on once but just return -EINVAL in __folio_split()
>> function if new_order < min_order like this:
>> ...
>> 		min_order = mapping_min_folio_order(folio->mapping);
>> 		if (new_order < min_order) {
>> -			VM_WARN_ONCE(1, "Cannot split mapped folio below min-order: %u",
>> -				     min_order);
>> 			ret = -EINVAL;
>> 			goto out;
>> 		}
>> ...
>>>
>>> WDYT?
>>>
>> I think it should be fine as along as we return an error if someone is
>> trying to split < min_order for file-backed folios.
>>
>>> diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
>>> index f327d62fc985..e15c3ca07e33 100644
>>> --- a/include/linux/huge_mm.h
>>> +++ b/include/linux/huge_mm.h
>>> @@ -387,34 +387,16 @@ int folio_split(struct folio *folio, unsigned int new_order, struct page *page,
>>>    * Return: 0: split is successful, otherwise split failed.
>>>    */
>>>   static inline int try_folio_split(struct folio *folio, struct page *page,
>>> -		struct list_head *list)
>>> +		struct list_head *list, unsigned int order)
>>>   {
> 
> OK, I will send a proper patch to fix this. Thanks.

Thanks!

-- 
Cheers

David / dhildenb


