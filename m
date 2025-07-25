Return-Path: <linux-kernel+bounces-745706-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 38845B11D51
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 13:12:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1CF131898D01
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 11:12:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6841F2E54D1;
	Fri, 25 Jul 2025 11:12:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gptuJOu6"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71B242E5412
	for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 11:12:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753441936; cv=none; b=S/Zb7oe1OGbWj+uLmrGpL4KMKlvH+LdiukmBLTpziRFoD4PAyu7npqv93vprzc/ijbyadT8aWkesrrWudo0Q1HbwZbkHylMoyIl89tVW97YWapu+u+M/6V5NZKHDqxKLrBgB8O0X0X2nQDVKbKZXzvKb0ruqf7umB1oUYzxGkqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753441936; c=relaxed/simple;
	bh=UwT1k1m5FssI6iW/uwenCUjap2v2l3xC5g0HLZrzrg4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Z2i9dVrymyZeIajSgaPMs49SyrQOCG6Q4CEccawVYl8vGU9Vtjfi9BnJ+WZk3YdDzQm7OKsDveuaPSKAZaxGJT7fsz9vOeDhHgOiQ8VXgOn7qgO474vHMtVtGZn9nqS4GcIPDs6sb7t1qBGkNuSrnOz9PeMRxkQMA5yPDRZ2YZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gptuJOu6; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1753441933;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=vvAMKNHyDr+p7xUsxnSZ3nM5HAGq789tGrRLQqOtJTA=;
	b=gptuJOu652YDpQPrpPqGLaTNxkcVFwHNW0qvsgdQDUEUe0RF7MTCwMQKAJoXXLyTEfrTox
	mWf4/83nnibt6SUZo4CFJ5m0x91wrfhntZ4RwFahH/8PizWz+9yxX+cJu+JrFEvIpmcsQv
	rIz8wSVAhAh6VcyJOy9+nTBB+yPI8Fg=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-523-PgoiBx43Oh-EDLLTlUUrJA-1; Fri, 25 Jul 2025 07:12:12 -0400
X-MC-Unique: PgoiBx43Oh-EDLLTlUUrJA-1
X-Mimecast-MFC-AGG-ID: PgoiBx43Oh-EDLLTlUUrJA_1753441931
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-3a4fabcafecso863820f8f.0
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 04:12:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753441931; x=1754046731;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=vvAMKNHyDr+p7xUsxnSZ3nM5HAGq789tGrRLQqOtJTA=;
        b=L/08eCcm0+jQQZOFU+RHi7AVNurcv5n8b9K5kdBIrNpfo5OFOmD7Ffc6eLWGbT4UOJ
         3soj+i2PbbuWNQEz5pIY0sQGGgAESb7F5RaIEuUlKWHRpDP3D3sDNy4Z2vE+vsQ+IUiN
         PVxrxd26QeXZN5rAs7OROj+cDukAfAnWkEUHOVb0CAJk7TdCO+tLI+qJbLC13IyR/1VL
         6TxYUwP+1BXMHi9GiVOwENBO6XFatbNKruymmf84aSXQ9+nUV5EiU1NoWif4N0cUQXji
         G5jj2Kp0nZsskLO9Pdy9oen7NVXnaYFeFxm/23N/gBUOiQYFehwAvLzVITbfgrZdWQF0
         MOwg==
X-Forwarded-Encrypted: i=1; AJvYcCX1LWwv8MyXdbsyNZg3RA1P71LwVFDovIQ4yr6k+27HGUseTNfZ5yS19O/ieXc+9iY2TaEJ6ScxXHxmaDU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwdwSWiqZdIvXN0N14UYrX7aBa2wPD69iT8kjWfF1UtYYjtSET6
	02kp0gV2A2P7cRthDVxKuhVdKZJy8bHatUyToElbuCl6sF7isKuyZGGwOTOOEB7PvgjzdAHTMdI
	A0qrzYcogPjYSQyq5rS/b+dXYPVx5wiERhVK8ZrerhuSQkoPcvmCjEsvatotqi1noRA==
X-Gm-Gg: ASbGncunaxhoaQ6wvEZWQTENZ2i75NgqvLnM9jy4ZoJgqLAJqyB2wOwlYhI51NAxwzb
	+Lo1aDn6GeoY+uxkdFuwqp1mTKC2qrJrgKQVifE32TxVTfuklYxpJSfvHVy+iOgcxHMolpmrFop
	lIcwVHudVY8Zu0PFf5qXXH8jw8kVKFua6L0kkEzVdbYG5JMwbFGYkHl6abKC4SS+mdS4frAQ8hj
	u6TEi8boTVDVjLlKO6u+fF4pegdTbg676uPXugi5SjpPhkLbZvjvdm0Av/4K76MRFSmFLCjNq3i
	kYR1fPhAPm75MEFuX20I9DA9+fuNk2oD7oYdrWx3HHJGSXhH+4gzK9vAVzPbdoFqZlP71F5yrFi
	Pljg0EAIFoVbGl6XL0ELD2jjzI/U5FLRSehc1ScsuV6IgW+0jiuQZIRI9H2TmgDAliro=
X-Received: by 2002:a05:6000:250c:b0:3a8:30b8:cb93 with SMTP id ffacd0b85a97d-3b77675bd64mr1398716f8f.32.1753441930860;
        Fri, 25 Jul 2025 04:12:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGpbeHKS+nspooiwMzx9I2rs2V3dCEOZZIv81NqfkgXnD8tjiuNdNZyFUr4giMpWLWQvDLecQ==
X-Received: by 2002:a05:6000:250c:b0:3a8:30b8:cb93 with SMTP id ffacd0b85a97d-3b77675bd64mr1398690f8f.32.1753441930369;
        Fri, 25 Jul 2025 04:12:10 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f1a:f400:5a9f:b1bf:4bb3:99b1? (p200300d82f1af4005a9fb1bf4bb399b1.dip0.t-ipconnect.de. [2003:d8:2f1a:f400:5a9f:b1bf:4bb3:99b1])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-458705c4f40sm50046715e9.27.2025.07.25.04.12.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Jul 2025 04:12:09 -0700 (PDT)
Message-ID: <bf29d398-5f7b-449c-b142-cf9873a5b183@redhat.com>
Date: Fri, 25 Jul 2025 13:12:08 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm/rmap: Add anon_vma lifetime debug check
To: Jann Horn <jannh@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Rik van Riel
 <riel@surriel.com>, "Liam R. Howlett" <Liam.Howlett@oracle.com>,
 Vlastimil Babka <vbabka@suse.cz>, Harry Yoo <harry.yoo@oracle.com>,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20250724-anonvma-uaf-debug-v1-1-29989ddc4e2a@google.com>
 <85c4a092-14df-4478-811c-f3789610e4b8@redhat.com>
 <CAG48ez1O+7ciCNDVnh9MPh_1_1TLWd-=H9L6p90J_9AEbav27w@mail.gmail.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 g3eXuA==
Organization: Red Hat
In-Reply-To: <CAG48ez1O+7ciCNDVnh9MPh_1_1TLWd-=H9L6p90J_9AEbav27w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 25.07.25 13:08, Jann Horn wrote:
> On Thu, Jul 24, 2025 at 11:56 PM David Hildenbrand <david@redhat.com> wrote:
>> On 24.07.25 21:13, Jann Horn wrote:
>>> If an anon page is mapped into userspace, its anon_vma must be alive,
>>> otherwise rmap walks can hit UAF.
>>>
>>> There have been syzkaller reports a few months ago[1][2] of UAF in rmap
>>> walks that seems to indicate that there can be pages with elevated mapcount
>>> whose anon_vma has already been freed, but I think we never figured out
>>> what the cause is; and syzkaller only hit these UAFs when memory pressure
>>> randomly caused reclaim to rmap-walk the affected pages, so it of course
>>> didn't manage to create a reproducer.
>>>
>>> Add a VM_WARN_ON_FOLIO() when we add/remove mappings of anonymous pages to
>>> hopefully catch such issues more reliably.
>>>
>>> Implementation note: I'm checking IS_ENABLED(CONFIG_DEBUG_VM) because,
>>> unlike the checks above, this one would otherwise be hard to write such
>>> that it completely compiles away in non-debug builds by itself, without
>>> looking extremely ugly.
>>>
>>> [1] https://lore.kernel.org/r/67abaeaf.050a0220.110943.0041.GAE@google.com
>>> [2] https://lore.kernel.org/r/67a76f33.050a0220.3d72c.0028.GAE@google.com
>>>
>>> Signed-off-by: Jann Horn <jannh@google.com>
>>> ---
>>>    include/linux/rmap.h | 13 +++++++++++++
>>>    1 file changed, 13 insertions(+)
>>>
>>> diff --git a/include/linux/rmap.h b/include/linux/rmap.h
>>> index c4f4903b1088..ba694c436f59 100644
>>> --- a/include/linux/rmap.h
>>> +++ b/include/linux/rmap.h
>>> @@ -449,6 +449,19 @@ static inline void __folio_rmap_sanity_checks(const struct folio *folio,
>>>        default:
>>>                VM_WARN_ON_ONCE(true);
>>>        }
>>> +
>>> +     /*
>>> +      * Anon folios must have an associated live anon_vma as long as they're
>>> +      * mapped into userspace.
>>> +      * Part of the purpose of the atomic_read() is to make KASAN check that
>>> +      * the anon_vma is still alive.
>>> +      */
>>> +     if (IS_ENABLED(CONFIG_DEBUG_VM) && PageAnonNotKsm(page)) {
>>
>> 1) You probably don't need the CONFIG_DEBUG_VM check: the
>> VM_WARN_ON_FOLIO should make everything get optimized out ... right?
> 
> The PageAnonNotKsm() check is outside the VM_WARN_ON_FOLIO(), and it
> uses page_folio(), which uses _compound_head(), which does
> READ_ONCE(page->compound_head); and READ_ONCE() unfortunately doesn't
> just mean "I want a read without tearing", it also (intentionally)
> prevents the compiler from removing the read when it sees that it's
> not being used for anything.

That makes sense, the volatile read will not get optimized out.

> 
>> 2) We have a folio here, so ... better
>>
>> if (folio_test_anon(folio) && !folio_test_ksm(folio)) {
>>          ...
>> }
> 
> Hrm, okay. It kind of irks me to write it as two checks when really I
> want to ask "is it this one specific type", but yeah, will change it.

Well, ksm is a subtype of anon.

folio_test_anon_not_ksm()

let's rather ... not :)

-- 
Cheers,

David / dhildenb


