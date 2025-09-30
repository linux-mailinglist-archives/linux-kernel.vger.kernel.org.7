Return-Path: <linux-kernel+bounces-837423-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B7041BAC490
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 11:37:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ED8AE7A6887
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 09:35:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B9ED2F5301;
	Tue, 30 Sep 2025 09:37:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MgU4npTV"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CB4E4D8CE
	for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 09:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759225024; cv=none; b=MVwvJQfvkav5NIuUJbj9etc4n3qe86MgCVlsRlTi++5XlErgnIphx7rSXM/C6udEcPgTKeLMlw7U8fHgrF5m0vO62fdfKXoWGB7uxl/Q3k3hqhlrQDuRuePPLib65WODy0dRmZjYGKcaG7ZB2MJiYWtJ8H8dX0t+xf3PLTfCtZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759225024; c=relaxed/simple;
	bh=nD/bQPOCQrRccfwBiCpHSUMqBrcO9uIg2y/JUpCEMmk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QkUUhwJ9l/KBdSwvuMzP/Pps8RUw1QEivwhygEb/kWycJxjIHwnrWH1/Npt+Pw3whT0EWO1W6jlXUOrZQUSYeLAuzBDJrx2A1FTaN8bjZ4fW2ZrxTzzmyHCzZl5RRZbifIHuILoHZbDzghZQFbArhAMf2RMp+y6yum4Pbp4H4vU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MgU4npTV; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759225021;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=sriyjezazUL36Fd5zaQH3Go6JHJr+H5glZUzh05N9l8=;
	b=MgU4npTVNXkg23dOPxSTC3HaNscnZrOAQVgki1sU4vBpqz/0zNA89sdnIxBfIvYxP5wWPo
	FCfl5XAmXdeMYVwIKkVU/ZuoQ+2VyFQrVPKdERiY9vWuyCw6fRpoxisWOiZvfKHJFhGpcI
	nqAgisAxthfSNHpK28a+DeuFOxuJ84Q=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-219-08cydzrPO9OhBhGgIkFz2w-1; Tue, 30 Sep 2025 05:36:59 -0400
X-MC-Unique: 08cydzrPO9OhBhGgIkFz2w-1
X-Mimecast-MFC-AGG-ID: 08cydzrPO9OhBhGgIkFz2w_1759225019
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-46e3ef2dd66so24039155e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 02:36:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759225018; x=1759829818;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sriyjezazUL36Fd5zaQH3Go6JHJr+H5glZUzh05N9l8=;
        b=PbkNjYO+X1xF8N0gEb9ird393iz+pWUwlNjBHol7y3IR6x9gMB6Ew+JxoMVCOKMMf4
         oDwsCf45QHUXUFfDBA8p6gKE2BfBnqHX3l0urlxqYgPpFgknP/dSLDNQ/9YC8K8wWcZ4
         DaxwmQWL5c8l82wbSsYbsMFI3kCMjK7nuIbxXmHFGAlxxVhII6xsIFzoe0cWSWNDKozj
         ao2zkC2dObm62W6jti5gsAa/+3rw9OXu1+N9BSqcMufnvjOuLz6SnGmEfd1ykzcMpdPE
         xsc20urXS2M0GAO+iqIS0Gcptu8m8TyNah4XctPDND1a+DgC+H1Olw2NGr6pdXl1+rrU
         NHVw==
X-Forwarded-Encrypted: i=1; AJvYcCUyYMUsaF5FFjIrsUKJ0uzKDnbHweX3SWxj84lDrxb1BCUbOWPJ+iwTAncI6vwAkmR6WCtgFwtqZR80wA4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzHbdIEl1eY2ZdX/EWgiR1V9AKbo2DUVcRyvLkYt9SnYXkRBBWH
	df4S90xRc35JHnHGaiHNxhrHdHgj1130ZRXAQnobNRwbvJ6NxyPXdmJqGV+3z6pBWpxmO7sgyYH
	No7I0FEt+G7wvaKg6/pPxqAIwYnxvjZJn51NZNWSEhGkAH8KHhsBC/VogpDKSV+m5dA==
X-Gm-Gg: ASbGncuGQgQQtNBoLwk1pZcmuI2PqM+Fi0E+22W95fCwGJnY3G15uGu0mZMViFG5lBz
	ufas+r/ICmeHsUZC0XxunQ0tbRUdMIbXJnyjdnFE6FhnK1zAxhkoqsIWYi7ve5ZHn9vi2hcHb8J
	wzOzW0GEyd6WrrpwKHNhgdYd1HxajWgmwr6S/S6bBhOZ8ABzFXbeBqnsIyTTMqFe2cbMqLcX+Pj
	/VlzHuCGczGS7/lo+VKGBT1I+JFWKUCB+p9lfuB526JaoPuc/I+ZQN+e4T7oILuEZYQglSNhrh7
	iZ4CEZJ2QTwCpQm/7bQKJ6wtkd1KwapNCwByGxLvPe7sHcJlpaq9d5+8grY6B4qYMvSpZ29Bvms
	/EFIdcQqU
X-Received: by 2002:a05:600c:4510:b0:46d:1a9b:6d35 with SMTP id 5b1f17b1804b1-46e58ac9c36mr37612505e9.14.1759225018321;
        Tue, 30 Sep 2025 02:36:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGsPJzHmF8DkpwxtlmdmhxGs2aUnDwUWraLDaT6N40+ieEDyQubMcJS5ZryUo4Ugs9z5ZSCKg==
X-Received: by 2002:a05:600c:4510:b0:46d:1a9b:6d35 with SMTP id 5b1f17b1804b1-46e58ac9c36mr37612135e9.14.1759225017777;
        Tue, 30 Sep 2025 02:36:57 -0700 (PDT)
Received: from [192.168.3.141] (tmo-080-144.customers.d1-online.com. [80.187.80.144])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46e4ab0bf62sm109304255e9.9.2025.09.30.02.36.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Sep 2025 02:36:57 -0700 (PDT)
Message-ID: <f1da3505-f17f-4829-80c1-696b1d99057d@redhat.com>
Date: Tue, 30 Sep 2025 11:36:53 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/4] mm: Introduce vm_uffd_ops API
To: Peter Xu <peterx@redhat.com>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
Cc: Axel Rasmussen <axelrasmussen@google.com>,
 Vlastimil Babka <vbabka@suse.cz>, James Houghton <jthoughton@google.com>,
 Nikita Kalyazin <kalyazin@amazon.com>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Ujwal Kundur <ujwal.kundur@gmail.com>, Mike Rapoport <rppt@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Andrea Arcangeli <aarcange@redhat.com>,
 "Liam R . Howlett" <Liam.Howlett@oracle.com>, Michal Hocko
 <mhocko@suse.com>, Muchun Song <muchun.song@linux.dev>,
 Oscar Salvador <osalvador@suse.de>, Hugh Dickins <hughd@google.com>,
 Suren Baghdasaryan <surenb@google.com>
References: <20250926211650.525109-1-peterx@redhat.com>
 <20250926211650.525109-2-peterx@redhat.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <20250926211650.525109-2-peterx@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 26.09.25 23:16, Peter Xu wrote:
> Currently, most of the userfaultfd features are implemented directly in the
> core mm.  It will invoke VMA specific functions whenever necessary.  So far
> it is fine because it almost only interacts with shmem and hugetlbfs.
> 
> Introduce a generic userfaultfd API extension for vm_operations_struct,
> so that any code that implements vm_operations_struct (including kernel
> modules that can be compiled separately from the kernel core) can support
> userfaults without modifying the core files.
> 
> With this API applied, if a module wants to support userfaultfd, the
> module should only need to properly define vm_uffd_ops and hook it to
> vm_operations_struct, instead of changing anything in core mm.
> 
> This API will not work for anonymous memory. Handling of userfault
> operations for anonymous memory remains unchanged in core mm.
> 
> Due to a security concern while reviewing older versions of this series
> [1], uffd_copy() will be temprorarily removed.  IOW, so far MISSING-capable
> memory types can only be hard-coded and implemented in mm/.  It would also
> affect UFFDIO_COPY and UFFDIO_ZEROPAGE.  Other functions should still be
> able to be provided from vm_uffd_ops.
> 
> Introduces the API only so that existing userfaultfd users can be moved
> over without breaking them.
> 
> [1] https://lore.kernel.org/all/20250627154655.2085903-1-peterx@redhat.com/
> 

Looks much better with the uffdio_copy stuff removed for now.

> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>   include/linux/mm.h            |  9 +++++++++
>   include/linux/userfaultfd_k.h | 37 +++++++++++++++++++++++++++++++++++
>   2 files changed, 46 insertions(+)
> 
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index 6b6c6980f46c2..8afb93387e2c6 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -620,6 +620,8 @@ struct vm_fault {
>   					 */
>   };
>   
> +struct vm_uffd_ops;
> +
>   /*
>    * These are the virtual MM functions - opening of an area, closing and
>    * unmapping it (needed to keep files on disk up-to-date etc), pointer
> @@ -705,6 +707,13 @@ struct vm_operations_struct {
>   	struct page *(*find_normal_page)(struct vm_area_struct *vma,
>   					 unsigned long addr);
>   #endif /* CONFIG_FIND_NORMAL_PAGE */
> +#ifdef CONFIG_USERFAULTFD
> +	/*
> +	 * Userfaultfd related ops.  Modules need to define this to support
> +	 * userfaultfd.
> +	 */
> +	const struct vm_uffd_ops *userfaultfd_ops;
> +#endif
>   };
>   
>   #ifdef CONFIG_NUMA_BALANCING
> diff --git a/include/linux/userfaultfd_k.h b/include/linux/userfaultfd_k.h
> index c0e716aec26aa..b1949d8611238 100644
> --- a/include/linux/userfaultfd_k.h
> +++ b/include/linux/userfaultfd_k.h
> @@ -92,6 +92,43 @@ enum mfill_atomic_mode {
>   	NR_MFILL_ATOMIC_MODES,
>   };
>   
> +/* VMA userfaultfd operations */
> +struct vm_uffd_ops {
> +	/**
> +	 * @uffd_features: features supported in bitmask.
> +	 *
> +	 * When the ops is defined, the driver must set non-zero features
> +	 * to be a subset (or all) of: VM_UFFD_MISSING|WP|MINOR.
> +	 *
> +	 * NOTE: VM_UFFD_MISSING is still only supported under mm/ so far.
> +	 */
> +	unsigned long uffd_features;

This variable name is a bit confusing , because it's all about vma 
flags, not uffd features. Just reading the variable, I would rather 
connect it to things like UFFD_FEATURE_WP_UNPOPULATED.

As currently used for VM flags, maybe you should call this

	unsigned long uffd_vm_flags;

or sth like that.

I briefly wondered whether we could use actual UFFD_FEATURE_* here, but 
they are rather unsuited for this case here (e.g., different feature 
flags for hugetlb support/shmem support etc).

But reading "uffd_ioctls" below, can't we derive the suitable vma flags 
from the supported ioctls?

_UFFDIO_COPY | _UFDIO_ZEROPAGE -> VM_UFFD_MISSING
_UFFDIO_WRITEPROTECT -> VM_UFFD_WP
_UFFDIO_CONTINUE -> VM_UFFD_MINOR

> +	/**
> +	 * @uffd_ioctls: ioctls supported in bitmask.
> +	 *
> +	 * Userfaultfd ioctls supported by the module.  Below will always
> +	 * be supported by default whenever a module provides vm_uffd_ops:
> +	 *
> +	 *   _UFFDIO_API, _UFFDIO_REGISTER, _UFFDIO_UNREGISTER, _UFFDIO_WAKE
> +	 *
> +	 * The module needs to provide all the rest optionally supported
> +	 * ioctls.  For example, when VM_UFFD_MINOR is supported,
> +	 * _UFFDIO_CONTINUE must be supported as an ioctl.
> +	 */
> +	unsigned long uffd_ioctls;
> +	/**
> +	 * uffd_get_folio: Handler to resolve UFFDIO_CONTINUE request.

Just wondering if we could incorporate the "continue" / "minor" aspect 
into the callback name.

uffd_minor_get_folio / uffd_continue_get_folio

Or do you see use of that callback in the context of other uffd features?

-- 
Cheers

David / dhildenb


