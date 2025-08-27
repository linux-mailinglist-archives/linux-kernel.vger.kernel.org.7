Return-Path: <linux-kernel+bounces-788192-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BD88B3810E
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 13:29:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7BC5D1B64773
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 11:29:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EEEA34DCF5;
	Wed, 27 Aug 2025 11:28:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EDZKiO1W"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E6652773E0
	for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 11:28:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756294133; cv=none; b=pA3j8hNVZw/YMDdtRb0olDdSF3HfRG0ZobBU390Ffz2cAgVEOC7xXvENIy8W5CMtZ5nu36+5o7h0GzJOlOtn/zdj9v92PQieMNxKZ89QUS3QD67SvrSQTYODITE+xSP1x1qbEonjSywdCahvn0Exf78BtWShug4di1syRN6sbRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756294133; c=relaxed/simple;
	bh=y0jEC4ysJYws01/bNcxA/efdzV9Bb+FCxDwvAOZSy9A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oFmtGcqk6xScn9KAIBY7YspoJpW/07FRqJgjdsZecnilc/HHgZaRZfHkixQp3HFFXNTOp5uTH51iuzpFw+teyYFO2ouk0/cu0hFDmNzZOQ6mzBxq/ZIhEBXwGW3KL7/miP4K+2Xk9aBgCfBwUhlG4uehcK0QKcnMGGTU5OkfOBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EDZKiO1W; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756294131;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=2oQ4yyn+fuHtT1ZM0Ps0RKh7qw9mFPkcHlRbmx1CZxA=;
	b=EDZKiO1W7g7U8VHwI8IWCP3Gobo9VuKgfNnblmdlvvPxgnGwHYztX2dG4iyVfinCStqZoC
	fOzVMekNt+32WrNTqCCcrcijP8/t+3X5GcmA1ReBdLedNFXWuN7TdNOTtK2dGgzBq75G3h
	gjh3L8VRp8SOAa+HYK1wZivVS8n2ok0=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-12-OMy0GWhvOfWbg3E9mSOP-A-1; Wed, 27 Aug 2025 07:28:49 -0400
X-MC-Unique: OMy0GWhvOfWbg3E9mSOP-A-1
X-Mimecast-MFC-AGG-ID: OMy0GWhvOfWbg3E9mSOP-A_1756294129
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-7e870315c98so2310528585a.0
        for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 04:28:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756294129; x=1756898929;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2oQ4yyn+fuHtT1ZM0Ps0RKh7qw9mFPkcHlRbmx1CZxA=;
        b=cKJYqDY4scilslwVn97q5kjjvDARouPI9RnAioC8MRwKRywZKySZqvFs8F+qzb41bv
         nnW6QHjwODYXlk7/zJVeL3UaG6Ko745WcSTDIcnfw+kfrlirMuiJDRPdzknFhZhGBo28
         dCu1K/1+U5sWXQ2EmK/PfnU1mn5/DtjXgH06ZNzbUKVbRurnlurMGbvWqXagq2Ox8lp8
         P4wMnz0DEMWTInCcXY5MNWil78f5Um+kBd4Y69xoQhut7HqsMQmwcVk1yswEzhekcVTW
         ExRHtJBDjIWe8NVlGL6Zen0OEApVzVmRtWGS6YcS4UueNSCt1clGm1fFi960YLD+891f
         YdHw==
X-Forwarded-Encrypted: i=1; AJvYcCX/6EH4XWIHhlQKByu294ZOMKoeiYNl+9+IYc2Ah4ftP/h1qnmJlCv8+/QDkYBfy/xsVrDldnQYpvFkJ3I=@vger.kernel.org
X-Gm-Message-State: AOJu0YwKLghedNApo71FYcbDkoUX+qm6OO5EnN8wWQVFkyHsGNLaqngX
	R/I+s0rQJ+F3yGEcQFoTUlX8UcABETt96ccpL4Pk1C+kZWZ1gfOGcoYv2+VjYlwWzY66KXbXutY
	G7+aHZqDvvPFb9LP8OcloALQwoGmNTzJVheGvz2ER+cwq+l7krN0NZuhBhkd+WVK6hg==
X-Gm-Gg: ASbGncsoSL/I2BG/eCqq0Zps+CeZ1JbyZK2IxyIOulBuvbx9JyXqJ8e9rqidoAGMxvD
	TMgziNYDQ6XiX4VdnvOs5yqsLT6lvGvW6+htL7l2bbL2macI1ihccTp4dDOaMNPp7/2X+1RhTLN
	oF+gqLGk9N1XkOix8C0e+MrCpqtAiioeUvt6b4JaB4SldAQThwtFBBKozk3YsnQJ7ZyGGFXEHWe
	Gg2zURkCpx3u31CMzZTikUTExs7U+8uY0vXgebU3Ei1sIi3Gtht1mEDQPBFIry4pA0L05Kv7NUp
	EZw1+IPun0dMZyNlEtpnR4SfOmhLdogm+vBj2ic6pvf5JUyNrX7EU+SaHgzaRQ==
X-Received: by 2002:a05:620a:2894:b0:7e6:856d:bcb with SMTP id af79cd13be357-7ea10f94df7mr2661736085a.6.1756294128452;
        Wed, 27 Aug 2025 04:28:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGW8ZUPI6UYniG83VeXzqqz790E5oUSfgsxv/Czm9VchZxyn+4OUiu73ck2Pw5OQnBy/KIY8Q==
X-Received: by 2002:a05:620a:2894:b0:7e6:856d:bcb with SMTP id af79cd13be357-7ea10f94df7mr2661730185a.6.1756294127842;
        Wed, 27 Aug 2025 04:28:47 -0700 (PDT)
Received: from [10.32.64.156] (nat-pool-muc-t.redhat.com. [149.14.88.26])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7ebecb18cb4sm867878585a.2.2025.08.27.04.28.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Aug 2025 04:28:47 -0700 (PDT)
Message-ID: <7cdc05d8-899b-495a-8298-ad5f27fcf8ad@redhat.com>
Date: Wed, 27 Aug 2025 13:28:42 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [v3 02/11] mm/thp: zone_device awareness in THP handling code
To: Balbir Singh <balbirs@nvidia.com>, dri-devel@lists.freedesktop.org,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@linux-foundation.org>, Zi Yan <ziy@nvidia.com>,
 Joshua Hahn <joshua.hahnjy@gmail.com>, Rakie Kim <rakie.kim@sk.com>,
 Byungchul Park <byungchul@sk.com>, Gregory Price <gourry@gourry.net>,
 Ying Huang <ying.huang@linux.alibaba.com>,
 Alistair Popple <apopple@nvidia.com>, Oscar Salvador <osalvador@suse.de>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, Nico Pache <npache@redhat.com>,
 Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>,
 Barry Song <baohua@kernel.org>, Lyude Paul <lyude@redhat.com>,
 Danilo Krummrich <dakr@kernel.org>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Ralph Campbell <rcampbell@nvidia.com>,
 =?UTF-8?Q?Mika_Penttil=C3=A4?= <mpenttil@redhat.com>,
 Matthew Brost <matthew.brost@intel.com>,
 Francois Dugast <francois.dugast@intel.com>
References: <20250812024036.690064-1-balbirs@nvidia.com>
 <20250812024036.690064-3-balbirs@nvidia.com>
 <763e1fca-e4c4-467e-a1d0-ea911cad4714@redhat.com>
 <85ef9a34-f511-4306-ac28-bf90f614709a@nvidia.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <85ef9a34-f511-4306-ac28-bf90f614709a@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

>> Like teaching zap, mprotect, rmap walks .... code separately.
>>
>> I'm, sure you'll find a way to break this down so I don't walk out of a
>> review with an headake ;)
>>
> 
> :) I had smaller chunks earlier, but then ran into don't add the change unless you
> use the change problem
> 

It's perfectly reasonable to have something like

mm/huge_memory: teach copy_huge_pmd() about huge device-private entries
mm/huge_memory: support splitting device-private folios

...

etc :)

[...]

>> Careful: There is is_readable_exclusive_migration_entry(). So don't
>> change the !is_readable_migration_entry(entry) to is_writable_migration_entry(entry)(),
>> because it's wrong.
>>
> 
> Ack, I assume you are referring to potential prot_none entries?

readable_exclusive are used to maintain the PageAnonExclusive bit right
now for migration entries. So it's not realted to prot_none.

[...]

>>> -            WARN_ONCE(1, "Non present huge pmd without pmd migration enabled!");
>>> +
>>> +            if (!thp_migration_supported())
>>> +                WARN_ONCE(1, "Non present huge pmd without pmd migration enabled!");
>>> +
>>> +            if (is_pmd_device_private_entry(orig_pmd)) {
>>> +                folio_remove_rmap_pmd(folio, &folio->page, vma);
>>> +                WARN_ON_ONCE(folio_mapcount(folio) < 0);
>>
>> Can we jsut move that into the folio_is_device_private() check below.
> 
> The check you mean?

The whole thing like

if (...) {
	folio_remove_rmap_pmd(folio, &folio->page, vma);
	WARN_ON_ONCE(folio_mapcount(folio) < 0);
	folio_put(folio)
}


[...]

> 
>> Why do we have to flush? pmd_clear() might be sufficient? In the PTE case we use pte_clear().
> 
> Without the flush, other entities will not see the cleared pmd and isn't the pte_clear() only
> when should_defer_flush() is true?

It's a non-present page entry, so there should be no TLB entry to flush.

> 
>>
>> [...]
>>
>>>            pmde = pmd_mksoft_dirty(pmde);
>>>        if (is_writable_migration_entry(entry))
>>> diff --git a/mm/migrate_device.c b/mm/migrate_device.c
>>> index e05e14d6eacd..0ed337f94fcd 100644
>>> --- a/mm/migrate_device.c
>>> +++ b/mm/migrate_device.c
>>> @@ -136,6 +136,8 @@ static int migrate_vma_collect_pmd(pmd_t *pmdp,
>>>                 * page table entry. Other special swap entries are not
>>>                 * migratable, and we ignore regular swapped page.
>>>                 */
>>> +            struct folio *folio;
>>> +
>>>                entry = pte_to_swp_entry(pte);
>>>                if (!is_device_private_entry(entry))
>>>                    goto next;
>>> @@ -147,6 +149,51 @@ static int migrate_vma_collect_pmd(pmd_t *pmdp,
>>>                    pgmap->owner != migrate->pgmap_owner)
>>>                    goto next;
>>>    +            folio = page_folio(page);
>>> +            if (folio_test_large(folio)) {
>>> +                struct folio *new_folio;
>>> +                struct folio *new_fault_folio = NULL;
>>> +
>>> +                /*
>>> +                 * The reason for finding pmd present with a
>>> +                 * device private pte and a large folio for the
>>> +                 * pte is partial unmaps. Split the folio now
>>> +                 * for the migration to be handled correctly
>>> +                 */
>>
>> There are also other cases, like any VMA splits. Not sure if that makes a difference,
>> the folio is PTE mapped.
>>
> 
> Ack, I can clarify that the folio is just pte mapped or remove the comment

Sounds good.


-- 
Cheers

David / dhildenb


