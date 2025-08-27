Return-Path: <linux-kernel+bounces-788844-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE6CEB38AEF
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 22:28:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D4B2D686833
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 20:27:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB7F92F067E;
	Wed, 27 Aug 2025 20:26:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eqBbZXhu"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9002A2EF678
	for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 20:26:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756326377; cv=none; b=V5tgHWyLvogOk320vkCFdk4sp3gAzmY50TA3rP61Rk8Awz6yRWicKhsq5TGUjlY+7zxc7VvfXqso9zbBVKa0ddLgxpCIHsao9wPl4/PmXZDSnIo6HjcHLCMcAn6t13XKebUvK2SyIHDv1MOM9ZveTNoSvXF5YMinBcFV3ZoIq3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756326377; c=relaxed/simple;
	bh=c9MI22F6zJXO9t7ul6zlheSb+XucPYJ5G9gVpeODLrs=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=fOz1Tte3AUKiGKj23eHt4u3NvTmlA/wPFwy/lvGiMc9XrU4B4ZLBHO1zylIZeyJ6Ixx2tf2bB7+m0HhkkDzd/dQb7R5ye3Jrw+w8aQFGuF9lwadSy9BRM/s/eWR6onBKxHWm/rYtqwsNTknJhJ7KI3wdS9I82etoXeXyqlJpkbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eqBbZXhu; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756326374;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=AOs3uJzXX/k9jmtMpMd9nBSE+OF57uMz5ApCLqXUPO0=;
	b=eqBbZXhulsP+kFC9+mgnY0oFvGhqU/uai0HGm3Ib4sfc56BWpuklD2G05Z6f8DCK1xPcoX
	P5r4tp9pLeoVf1dzb4i9QkSq/HkXLPSdRjP/9W3SEpfU60SBmOkBMECxzsK2k7fZnbhAbf
	brkJ0jeySNi8//qGPsIZ79VGvVO1NAU=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-159-AB3spdwgOtiyNMWgGu2LnA-1; Wed, 27 Aug 2025 16:26:12 -0400
X-MC-Unique: AB3spdwgOtiyNMWgGu2LnA-1
X-Mimecast-MFC-AGG-ID: AB3spdwgOtiyNMWgGu2LnA_1756326371
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-45b71eef08eso900595e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 13:26:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756326371; x=1756931171;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AOs3uJzXX/k9jmtMpMd9nBSE+OF57uMz5ApCLqXUPO0=;
        b=tLXz5YeCm+lIKyf0NLMwwQhakvJHijvx9e8hj2AAzzA/A8vvviwOGMJQValL6w4KZV
         1EYPfEzY0cgdXD5TNoY/xXPVliRpM9MZpUlTyRvf9YOgn2n8XoHTiEzlXTBwaLfFk9KS
         sLtmvqVXkm8m216RgQ7IB8VrEIccMUWziDZ8gn0ixvrZ2v4sNwFk+19h2ziuTdGZ0x3c
         iEL3orrhukfliLOcCN0YQ/7vsaKAmKgjCsrVJMVszfIlD1jOSDcdNXzJXG3veIYFwrvA
         nQn3B4j6sFzusVZ81JL8nHS8jyXCHGHyfk03LzZpYc/VyVCQXWD4rTHLyuy1m3obgAjd
         Uhfw==
X-Forwarded-Encrypted: i=1; AJvYcCWdfqKR467+oqyMmIs2B3Bx5hLwBEdSqZsWX7Ty+Q/vm5ZGltA1a0FiP8/eRY4gmeo2Njp963uqsnU0gZM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4EW3cwa9l87IO96hq7EzDkLiWad2WWoFimXFGXCs420g8EVLL
	L2cMJW4dT3T0v4uKph7f8zFEaQD6+EP2Mu2Pttrn2y72Rb4k/shZ0Dr5XpIMmZebh11XQ+TEetP
	o30J3MvprPQtdsO4oAX3tfjs5BW8TWs+KWMnl692/jAiuTyVre/108hNlEqfjFFvjWQ==
X-Gm-Gg: ASbGncsMRfW+s74wpAXBXHl4tZmP/0hS3zYkGhON4H+nSDDpPPAws0BzDuZWW85sIZS
	hvJgkwVov3fix0wb2Goq3+J0FReXKzooxXBADI8v7ZZ24DtCU9z3JIq6IGKO8Q2ZzbOBZoM6rzf
	3dyhNRRWaGkNswFUd216enB84rDFxluJtkSL0DGwkPmORw3f1jXAJmDFQ7zxLFOnuuFqS9fiwMk
	ob9hd1o7d6UDdDsqa1uO7TVBMhf4kA6rORMYSvPsFb1IMOXEzj3SlI5WEEK+gPQ17Iv67kXO2Be
	HMlGiXp9I2HDIfVomKtTV6L0aEOOvR5qQqmuWu9trOJL0vXrIrOjGHEV1E0AbgX5WJxBmuNYoFk
	SbBBTOZND1Qku2eR5QnfOVQECLScgp9rx27t7QrwAhzceYflpgj453F9AIn5ixSJ6W8A=
X-Received: by 2002:a05:600c:3ba2:b0:45b:47e1:ef70 with SMTP id 5b1f17b1804b1-45b74421339mr17480145e9.35.1756326371204;
        Wed, 27 Aug 2025 13:26:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEwWSfdQZlagbLP65+8+IBTZq+moTWEKls9nquyTJI8BJWVHR6V2mwVXtGXYC9Qu2jC34+VqQ==
X-Received: by 2002:a05:600c:3ba2:b0:45b:47e1:ef70 with SMTP id 5b1f17b1804b1-45b74421339mr17480015e9.35.1756326370811;
        Wed, 27 Aug 2025 13:26:10 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f1f:d000:d4e1:a22e:7d95:bb63? (p200300d82f1fd000d4e1a22e7d95bb63.dip0.t-ipconnect.de. [2003:d8:2f1f:d000:d4e1:a22e:7d95:bb63])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b66c383b1sm42788865e9.3.2025.08.27.13.26.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Aug 2025 13:26:10 -0700 (PDT)
Message-ID: <4927ed52-a250-4ae8-b596-6f81020eb31a@redhat.com>
Date: Wed, 27 Aug 2025 22:26:09 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] huge_mm.h: disallow is_huge_zero_folio(NULL)
From: David Hildenbrand <david@redhat.com>
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
 <0de24b30-70ad-498f-9eac-01596c8713df@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <0de24b30-70ad-498f-9eac-01596c8713df@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 27.08.25 22:01, David Hildenbrand wrote:
> 
>> This seems not so great.
>>
>> I really think the VM_WARN_ON_ONCE() should be in folios_put_refs() based
>> on what you've said.
> 
> No.
> 
> Everything in folio_put_refs() will dereference the folio and properly
> crash the machine when doing something stupid.
> 
> This function, however, will silently swallow a "NULL" pointer.
> 
>>
>>>
>>> Signed-off-by: Max Kellermann <max.kellermann@ionos.com>
>>> ---
>>>    include/linux/huge_mm.h | 3 +++
>>>    1 file changed, 3 insertions(+)
>>>
>>> diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
>>> index 7748489fde1b..bc9ca7798f2e 100644
>>> --- a/include/linux/huge_mm.h
>>> +++ b/include/linux/huge_mm.h
>>> @@ -2,6 +2,7 @@
>>>    #ifndef _LINUX_HUGE_MM_H
>>>    #define _LINUX_HUGE_MM_H
>>>
>>> +#include <linux/mmdebug.h> // for VM_WARN_ON_ONCE()
>>
>> Please don't do //.
>>
>> This include is suspect though, huge_mm.h is included from mm.h and thus
>> this very easily might break some arch that is weird about this stuff,
>> because a ton of stuff includes mm.h including things that might absolutely
>> baulk at mmdebug.
> 
> Jup. Very likely this is not required.

Took another look and including mmdebug.h should likely be fine, because 
all it includes is really

(1) include/linux/bug.h
(2) include/linux/stringify.h

But originally, I wonder if we even need mmdebug.h or if it is already 
implicitly included.

huge_mm.h includes mm_types.h (where we already do use VM_WARN...).

I assume there we get it implicitly through percpu.h, mmap_lock.h or 
percpu.h

So the include should just get dropped.

-- 
Cheers

David / dhildenb


