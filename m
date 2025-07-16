Return-Path: <linux-kernel+bounces-734060-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AA781B07CA0
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 20:18:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BF4B7163AC9
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 18:18:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01E3F28F933;
	Wed, 16 Jul 2025 18:18:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dn/v4+z+"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1C4F13D53B
	for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 18:18:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752689888; cv=none; b=CKCpAaq+e7LD7JrDJmmdeXATD9OvDGoqESySqnmEhH1naI8lQw/cXOZqyBwLoc39xgAq/F3UKssZvkVqEkF9h8w77pDEZX82t71b/iytIBNTVOsQEvXodi6bCc0T/eLsZw55UXPn/2hk1a0LlKKfcugzg2TII5Fk+jzjoStQB5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752689888; c=relaxed/simple;
	bh=dmreAGJ6vDaTQp5rnah2bDk0T16axkiKMlzcIQulN8Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=attF+qrZ1ZOmk0oDjn63go1XUUspDjiYZlH4g/MY5nIsKWOL2BgvQGlCvOrIuqvmVRIaxGB1TOkc+FbVVd5HRMvGhimc8wD+78sB4v3hlJLlKsr2OTqtekuuGuCEL9uSxhC8wShTnoCH0kivLIhL8d2jzbwlvvGTafG7fDSCNZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dn/v4+z+; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752689885;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=KoaD2dI4jsgxjvFdQ3bse6bIyKN+Bp/X5u648JOU8EA=;
	b=dn/v4+z+08wfNcxnnG5wABLgWAewuCdo0sqooHE2oL8/ikdHmSV/fX+S56CrebkwRFcWYz
	noG7IfFosyw1w3baYZrL1tn88LEmuLAToEnB/8+okJrD5v/Kw/GSDJdl2/G0eLaXzTZ7++
	FH3S+Z7FxQACnqLgvQzmmh6Ar6zoaPU=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-189-CE_Y4ZwtOs6IjDb6DvAI2Q-1; Wed, 16 Jul 2025 14:18:04 -0400
X-MC-Unique: CE_Y4ZwtOs6IjDb6DvAI2Q-1
X-Mimecast-MFC-AGG-ID: CE_Y4ZwtOs6IjDb6DvAI2Q_1752689883
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-451d7de4ae3so613685e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 11:18:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752689883; x=1753294683;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=KoaD2dI4jsgxjvFdQ3bse6bIyKN+Bp/X5u648JOU8EA=;
        b=PfnKrp4Ls4BzwNf/zODhFLdBROP+hCOLiLm6sJgSHPy4JsqDpGyLQJp9ghkH9ctl6n
         drN9TJehjmHsfp0hxt9bBR6V+emLFbgghdmqlwmANeAuEvDeDWUgC91Rt+EC9i5AMPaF
         nhHQ4deuYSjXM+u1Io3C0gGcgqYq8jDiuH5L6+6Y+mUMKNP1DLbHjbjhjK/DgFndaUWC
         lXwdABoJpKu6oGl35C9eZUDgtmscPf27h9W9LfjYj+PWeHQ2wV32SUodzlM913HdoBOv
         OdrbyPdkVwUDr3y0WuDslOXroOyt11oEp0JoJVuTywYtme3QNwk9Mk/trZtuK5ulIQvw
         7beg==
X-Gm-Message-State: AOJu0Yy8pLjHkiu7x2Y9JyvxcfEb/qBCx4iYmYpCrkqm6RW7aMauy5iX
	SM6iwvS38oBhgDe07ZoQ0r8+/ApJrHCmTUnvUp4hpiBXditjA0k2P/IyZCr1PcDKeCSuMtaod+C
	xZJiOAp3tn1CYbJ5PNVAG2aBwGCyWQjG5Kx30BFkcYOpns1Ynb48s86yMGcPO2sbDmQ==
X-Gm-Gg: ASbGnct0+Se074uvCvNJXTnokDB4mD/jO+2SFwsEnupaSAr0+Qrow58Mm/RI6n+UxBV
	hilD9GIrXyNTQt02oDpSU6KRNw2f0DdQGv5fdwAWrUlKqqdncqA6a4/nBm6jVVwKEesVriZ76se
	2R6MXToqR1qXMuraz17KmYKzMAg/ezahfLJ5Dvn6/Gr0LkpgF7svYaKALJ9IR/5J05UHFXWbdwy
	uuTeVRpxDwzC4NUCkRPXxjjgM6ywydV6AQ6+17aC3E7s1Xv3NDMKt4DJ2NYeikiFrNQXk0iKwo2
	mIY6HT+VhnGWKGP6y5fa/VK0KXdqthu7qTGYKZoZMTBU+H/dAzv/owmrshNxMAW/XexVXM+GRc3
	brRF8nE1AUxrJSCshuaA6gIlVzH1gJ84jiJOcbdrrwYJaxekKCyUxvTjWaENPXBF+I/w=
X-Received: by 2002:a05:600c:674a:b0:450:d4a6:799e with SMTP id 5b1f17b1804b1-4562e275dedmr35862105e9.20.1752689882721;
        Wed, 16 Jul 2025 11:18:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGDtCtTt6AdmmHAkeWIdTpPG0P/rIzq4lzVryUKHl2R7KTsR+2uSQiEcESSjyANyUz/j+rLMw==
X-Received: by 2002:a05:600c:674a:b0:450:d4a6:799e with SMTP id 5b1f17b1804b1-4562e275dedmr35861915e9.20.1752689882273;
        Wed, 16 Jul 2025 11:18:02 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f1d:ed00:1769:dd7c:7208:eb33? (p200300d82f1ded001769dd7c7208eb33.dip0.t-ipconnect.de. [2003:d8:2f1d:ed00:1769:dd7c:7208:eb33])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b5e8e14e82sm18680454f8f.71.2025.07.16.11.18.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Jul 2025 11:18:01 -0700 (PDT)
Message-ID: <492025a7-4132-4944-b55b-90c6d6e40bba@redhat.com>
Date: Wed, 16 Jul 2025 20:18:00 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/4] mm/util: introduce snapshot_page()
To: Luiz Capitulino <luizcap@redhat.com>, willy@infradead.org,
 akpm@linux-foundation.org
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, shivankg@amd.com,
 sj@kernel.org, harry.yoo@oracle.com
References: <cover.1752499009.git.luizcap@redhat.com>
 <637a03a05cb2e3df88f84ff9e9f9642374ef813a.1752499009.git.luizcap@redhat.com>
 <ca72882f-257f-4f41-bea2-0b5324c820d7@redhat.com>
 <900252c7-b16c-49b9-8c01-60e6a7a48683@redhat.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 g3eXuA==
Organization: Red Hat
In-Reply-To: <900252c7-b16c-49b9-8c01-60e6a7a48683@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 16.07.25 19:36, Luiz Capitulino wrote:
> On 2025-07-16 06:16, David Hildenbrand wrote:
>> [...]
>>
>>> -dump:
>>> -    __dump_folio(foliop, &precise, pfn, idx);
>>> +    __dump_folio(&ps.folio_snapshot, &ps.page_snapshot, ps.pfn, ps.idx);
>>
>> Nit that can be cleaned up later on top:
>>
>> We should probably call this
>>
>> __dump_page_snapshot() and then just pass ... the page_snapshot.
>>
>>>    }
>>>    void dump_page(const struct page *page, const char *reason)
>>> diff --git a/mm/util.c b/mm/util.c
>>> index 0b270c43d7d1..f270bf42465b 100644
>>> --- a/mm/util.c
>>> +++ b/mm/util.c
>>> @@ -25,6 +25,7 @@
>>>    #include <linux/sizes.h>
>>>    #include <linux/compat.h>
>>>    #include <linux/fsnotify.h>
>>> +#include <linux/page_idle.h>
>>>    #include <linux/uaccess.h>
>>> @@ -1171,3 +1172,81 @@ int compat_vma_mmap_prepare(struct file *file, struct vm_area_struct *vma)
>>>        return 0;
>>>    }
>>>    EXPORT_SYMBOL(compat_vma_mmap_prepare);
>>> +
>>> +static void set_ps_flags(struct page_snapshot *ps, const struct folio *folio,
>>> +             const struct page *page)
>>> +{
>>> +    /*
>>> +     * Only the first page of a high-order buddy page has PageBuddy() set.
>>> +     * So we have to check manually whether this page is part of a high-
>>> +     * order buddy page.
>>> +     */
>>> +    if (PageBuddy(page))
>>> +        ps->flags |= PAGE_SNAPSHOT_PG_BUDDY;
>>> +    else if (page_count(page) == 0 && is_free_buddy_page(page))
>>> +        ps->flags |= PAGE_SNAPSHOT_PG_BUDDY;
>>> +
>>> +    if (folio_test_idle(folio))
>>> +        ps->flags |= PAGE_SNAPSHOT_PG_IDLE;
>>> +}
>>> +
>>> +/**
>>> + * snapshot_page() - Create a snapshot of a struct page
>>> + * @ps: Pointer to a struct page_snapshot to store the page snapshot
>>> + * @page: The page to snapshot
>>> + *
>>> + * Create a snapshot of the page and store both its struct page and struct
>>> + * folio representations in @ps.
>>> + *
>>> + * Note that creating a faithful snapshot may fail if the compound
>>
>> Maybe highlight that this is not really expected to happen, ever.
>>
>>> + * state of the page keeps changing (e.g., due to a folio split). In
>>> + * this case, ps->faithful is set to false, and the snapshot assumes
>>
>> There is no ps->faithful.
> 
> Yes, good catch. This was from an earlier version.
> 
> Is it fine if I fix only this with a follow up patch for Andrew in this
> thread or would you prefer that I post v4 with all the other changes as
> well?

I think the series was part of mm-new, but now I only spot it in 
mm-everything, weird. Maybe because of a conflict with the other 
stable_page_flags() change?

So whatever Andrew prefers, really :)

-- 
Cheers,

David / dhildenb


