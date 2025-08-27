Return-Path: <linux-kernel+bounces-788812-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B1C9BB38A99
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 22:02:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9B7DD7B2A1C
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 20:00:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49FAF2C15AF;
	Wed, 27 Aug 2025 20:01:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dvKctROz"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6996E19924D
	for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 20:01:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756324913; cv=none; b=S+FXKOTpqKw2M/D58UTx7vsBo0khH10u0AgKzrz1I+NkOshcTTMSau1Af+M2C6Y+VfJKeeN9K9CxTXfd70pmDUnruPUyuFgsByaQ8xNUg0aadtZg5SbumVai2qB2NjFEZIkwDGMTRbdTKVeTySfREhMet6RNrr+0XSxTQS7TZcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756324913; c=relaxed/simple;
	bh=zKjZLWM/DjPxOkS9yhtqV3Vw4czNRuRqlPyAjJZx7jA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Tb6N+AMWFgcme+YKpM/tBCAALeCdXElvRLFZTpelUbflSZ+b0P5O+BQY/4d5yaClq/0eLDeIh2vtPW4ObEq4o5XRzlyn/nzwZ5Z4mgIsK0YiOnmCazp5a8avCzUGSTCsAknKkBfIJwNCTgfESz54UKabhgOxVAEQcbngLNG1nT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dvKctROz; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756324910;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=UYqkjtN1JFfwlUAqfFsvOnMI5dplQR5YXMojjDPr8tU=;
	b=dvKctROzpLbokiIJf92OAAX3ADe9c9xMpvWq+Inz3He/aVSdAUiOjynxFDODtgRP3Vcflz
	YACY061gnvVGCoAfWapVaPmwTkZuQd3IEg750ehq6ptxSxzzAUShtWwWXGggfqgVpvYst3
	3GVnytNtEHcR3OHpopaNtYqp6DXBpAo=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-465-b2I0fld8MjuNKtguUDx9vA-1; Wed, 27 Aug 2025 16:01:48 -0400
X-MC-Unique: b2I0fld8MjuNKtguUDx9vA-1
X-Mimecast-MFC-AGG-ID: b2I0fld8MjuNKtguUDx9vA_1756324907
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-45a1b0c5366so898125e9.3
        for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 13:01:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756324907; x=1756929707;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UYqkjtN1JFfwlUAqfFsvOnMI5dplQR5YXMojjDPr8tU=;
        b=mLTwurxu7ayo3PcHkAwtvKGrwQ7HG+OLpZxAIxHaKL51A7n8MyS/XoBXGheJkEdFo+
         NxiQCKm8o02a1sN4/ieTb/ZnHYZ9y/cG+Ob46JWuJJfGpUSNVq8SLseoMwxD4bTWU1JJ
         5L8u+NpCvGYnTi2h4cxsF8qZd2VELLBY7cWm+Pi88LKiOWHI/44oqCv/yAPZ6TL/gjCj
         HU1WLn4nfgBuwNy8je49f8vJu4HLTwZKFtdCh2X4XWMfBjCGjwU3s72rMMGMrlJpXll6
         RgE6UEYCAnQzOtnnKqkoagIX+mGjtdflq0rMYJIVUBC8dk3VyQ9iFnxm305JmG6m0iN+
         gu7g==
X-Forwarded-Encrypted: i=1; AJvYcCU7kCUkvlxnc1VLj4wgJvLKs9ZbsO7h8yC33lF3Kj70opo47/x9h2LnRln3KiTBaT91RIKoJ0G4CLagfTU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZ8pmj5pbTICT3eXKZZlaLMJMpJwLEb58gDuJ5ojN1DMbJrgFM
	hQkNa5iA44kPgvto3k8Zna6F/bhNufjK/kAFne3xcy8F8uR+SA5virBU4a32ebyrd9qQfr8MILV
	y17+yUxZLXxpPvozggK5qBpPQA/m61q2YuKeC0tQzcw+ImAPLjppqgk+6ssgVb8uwHg==
X-Gm-Gg: ASbGncu608ovvYB/QOYASiq1JboJ7RBb0/JDY6VcdlVwdTUmFX4RI4jtGwIZehzjrCP
	sQIBTkEcLZJ0wTQqmcPP9fTrNupdo5VUDWUMP42uNMrJKOuldt7NmHSpAUDCBCpoUKb/+JzssR+
	ZnuKe+IAuUmN6jYpM4OvUHAQpyyWXTNx2IY0TneZKKujDqq3ER4l1W8ypVarKlMVEfEGQ4V4yHb
	GRYPA5dpZQJOOSBeUUffc6FbxPppJe8MRGIkjD4XYCHjtuk/gTTA4GLt1wCjzZ5fElFN7c5ril/
	mYwO2MN0rma2fWgubpGEvKNx2pM26AnqPqu41ubpI6pnQam1B6f9JCjAhUDEqS05udfBCdo=
X-Received: by 2002:a05:600c:1552:b0:459:d3d0:6507 with SMTP id 5b1f17b1804b1-45b517d9eecmr158174855e9.32.1756324907481;
        Wed, 27 Aug 2025 13:01:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEh+BGCBEwRzTA4du6R/9CuTee1WNYaJBMwU4SV32gJ/BEUsY+1Pqx5bTC12AkbEN54umRLQQ==
X-Received: by 2002:a05:600c:1552:b0:459:d3d0:6507 with SMTP id 5b1f17b1804b1-45b517d9eecmr158174675e9.32.1756324907074;
        Wed, 27 Aug 2025 13:01:47 -0700 (PDT)
Received: from [192.168.3.141] (p4ff1fc83.dip0.t-ipconnect.de. [79.241.252.131])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3cbf1f5fc1bsm6731329f8f.54.2025.08.27.13.01.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Aug 2025 13:01:46 -0700 (PDT)
Message-ID: <0de24b30-70ad-498f-9eac-01596c8713df@redhat.com>
Date: Wed, 27 Aug 2025 22:01:45 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] huge_mm.h: disallow is_huge_zero_folio(NULL)
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Max Kellermann <max.kellermann@ionos.com>
Cc: akpm@linux-foundation.org, ziy@nvidia.com, baolin.wang@linux.alibaba.com,
 Liam.Howlett@oracle.com, npache@redhat.com, ryan.roberts@arm.com,
 dev.jain@arm.com, baohua@kernel.org, shikemeng@huaweicloud.com,
 kasong@tencent.com, nphamcs@gmail.com, bhe@redhat.com, chrisl@kernel.org,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <2aa3f478-9c87-4102-b83e-bf235372d834@redhat.com>
 <20250827150330.280399-1-max.kellermann@ionos.com>
 <30f52bf5-ff37-4e22-ac57-7be0b03b1f51@lucifer.local>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <30f52bf5-ff37-4e22-ac57-7be0b03b1f51@lucifer.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


> This seems not so great.
> 
> I really think the VM_WARN_ON_ONCE() should be in folios_put_refs() based
> on what you've said.

No.

Everything in folio_put_refs() will dereference the folio and properly 
crash the machine when doing something stupid.

This function, however, will silently swallow a "NULL" pointer.

> 
>>
>> Signed-off-by: Max Kellermann <max.kellermann@ionos.com>
>> ---
>>   include/linux/huge_mm.h | 3 +++
>>   1 file changed, 3 insertions(+)
>>
>> diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
>> index 7748489fde1b..bc9ca7798f2e 100644
>> --- a/include/linux/huge_mm.h
>> +++ b/include/linux/huge_mm.h
>> @@ -2,6 +2,7 @@
>>   #ifndef _LINUX_HUGE_MM_H
>>   #define _LINUX_HUGE_MM_H
>>
>> +#include <linux/mmdebug.h> // for VM_WARN_ON_ONCE()
> 
> Please don't do //.
> 
> This include is suspect though, huge_mm.h is included from mm.h and thus
> this very easily might break some arch that is weird about this stuff,
> because a ton of stuff includes mm.h including things that might absolutely
> baulk at mmdebug.

Jup. Very likely this is not required.

> 
> I've had this kind of thing happen several times before.
> 
>>   #include <linux/mm_types.h>
>>
>>   #include <linux/fs.h> /* only for vma_is_dax() */
>> @@ -479,6 +480,8 @@ extern unsigned long huge_zero_pfn;
>>
>>   static inline bool is_huge_zero_folio(const struct folio *folio)
>>   {
>> +	VM_WARN_ON_ONCE(folio == NULL);
>> +
> 
> Convention is VM_WARN_ON_ONCE(!folio);

Wanted to comment the same thing.

-- 
Cheers

David / dhildenb


