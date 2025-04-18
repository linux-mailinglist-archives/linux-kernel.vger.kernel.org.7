Return-Path: <linux-kernel+bounces-610547-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 472DCA93621
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Apr 2025 12:42:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 89CC63B0C24
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Apr 2025 10:42:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C0B7270ECF;
	Fri, 18 Apr 2025 10:42:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="I1FYO3WP"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93228254AEF
	for <linux-kernel@vger.kernel.org>; Fri, 18 Apr 2025 10:42:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744972971; cv=none; b=qew8VcyqVTMZwnsjBmGo0AMXZoCg3akt3BWq75yhOLPZaHPrNPZk5i8vo30spVpI0Mw4K9hLeo4OstqGi+JMz4aXG3tqd9E3SKnPe7l0UQ+WAjFkKjOI1RLzLi4Y4cwYFyRvBs+SlPBlNg5inaMuUxU8aB8DGv6Q2dHxg/SDm/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744972971; c=relaxed/simple;
	bh=usis88t2+NZaqnNWK+iRf0eft0+CuD7L0Tt2N3CnfkQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nOspwDpemqP/zjc4lqzcO4JRW8MlFXsJU0DvnDGwHtjXl44fg2YCWiAAk7MhwS5z+av+ma3fZ93DyqK1729UXbwe/Cotqh8j/UO4vVVxgCRZsIG5wDDupWnyVv4IcNYnvpltr/WtkHnLpsd5XfE9xiC0SizrVZGmthWjPpxW82k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=I1FYO3WP; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744972967;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=F2UKf/nIUC40itgdl7oxZaELksq74njXfCuz7PqJZ5s=;
	b=I1FYO3WPePi3HRR6srmu0KTmwS683DLxAkjnk64tqrfRFYJ9PCodoKUX7qi90xfL6CPYxR
	rj81du/DlXMnh6ziwSWpjFkDpyPxT6/lCZKhmKXXSuh9t9OBUpeRrguLBIwJ+9V0Zsv8vN
	r7/37ynLIqxttvafgI5S7CEgmBgqB8U=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-433-eZVzIlFAOWKCZxffbDMJVg-1; Fri, 18 Apr 2025 06:42:46 -0400
X-MC-Unique: eZVzIlFAOWKCZxffbDMJVg-1
X-Mimecast-MFC-AGG-ID: eZVzIlFAOWKCZxffbDMJVg_1744972965
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-43ceb011ea5so9279925e9.2
        for <linux-kernel@vger.kernel.org>; Fri, 18 Apr 2025 03:42:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744972965; x=1745577765;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=F2UKf/nIUC40itgdl7oxZaELksq74njXfCuz7PqJZ5s=;
        b=KxLwh+P4JLMddTswwosPI3sfCAvEWwvOs4Ul9s1LtKPwIZTkgZW00CFkKa9ZYxzGJm
         snAQjag+Nip1DtnZQNdNYcjtmoiLIbYZNqP+hL+hn4qMlNZPaijVGbvJWwCcXASmFF1j
         w++FHjClTI62oaYUmksBbQ3xHmQZ3Zrps5RKHq8+oa/KJEXjad1e5M1ahCOi3I6GXxbq
         o2Zo52I0gqhgpEQQKNRI7lxhnQx+iewqr77m0G3WMviQNmtIZfJkLZlJnUx3L3NwD8MH
         yMz6e49dZeK2fHTNEYx3iCNXqqe5nNeGzyKdoBxLQRAeYjTWyFf89phemFMA34y0p5h0
         /8uA==
X-Forwarded-Encrypted: i=1; AJvYcCVr8dPZCHeciGzTz47iYM8B2MMfZjYZI2/oIz6rzT0GH0XPT6kwuxErbuCzBBEr30fB+P0xqvWRQ3TjTKM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyr6e4rQdGwbgyl4Brz4dY2MWai5SNTc3CIfcVCJk0v7WXb1Xa/
	hnRpi53tznVXohuNLgBOkhhHmO6SimJMcUgHphbFjk2p6IUSOOqZGxY0bGS8tBgiwLTvyahEzYO
	u114wpPAv5iOOTrH5sDnm5uS3OXAJ75IKiGMUMS5TZAtarNPdDp30jVsNsSwiuA==
X-Gm-Gg: ASbGncu7oEADTz1zYEHMfEGxObwug0L8F76c+B2iWqkam91jFa/CTRqsTyWN83JXMxT
	Ncep3jRWEXq8qQgUVBPExRFs/sJjzu8/3/ZhvQSlyNiHNGjjwXnZqg/ns7rGwA1GHbvYIREqQ+G
	gYDzXubL4Z9Ya/+j4UIgZ2apW0hNeoDHDMAv5hrxE9rQ6Sk8hT+suMY9NyIkVgDZ5Z5rn04DPzQ
	sbIRP0ZouWJtDIMPNYL+jrBTmUvnxvw9fYxnM5/Lg/kxy2RQmBozrDzcsqQpVpr4eU1P30hqdFx
	ibvmOeqBZD6Rjtli/kxulKUcY5RSsQnM5PB5fXJXcLpLzrfye/Kswn8nujif2wOlJQ7ahMP95yF
	z7OIRvDxaxhwxepP+5r8SLn6wCh0AjjhhMmbxzdI=
X-Received: by 2002:a05:6000:420e:b0:39c:2692:4259 with SMTP id ffacd0b85a97d-39efba52932mr1769744f8f.21.1744972964919;
        Fri, 18 Apr 2025 03:42:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEjknDenypVlGG3mISM9N1mpp29IQkVNRz9TU81Ddl+BsSWLmo/5hiUTuRzvh4t9/3gAE5Eig==
X-Received: by 2002:a05:6000:420e:b0:39c:2692:4259 with SMTP id ffacd0b85a97d-39efba52932mr1769717f8f.21.1744972964480;
        Fri, 18 Apr 2025 03:42:44 -0700 (PDT)
Received: from ?IPV6:2003:cb:c70e:6700:cada:5396:a4f8:1434? (p200300cbc70e6700cada5396a4f81434.dip0.t-ipconnect.de. [2003:cb:c70e:6700:cada:5396:a4f8:1434])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39efa420740sm2413742f8f.16.2025.04.18.03.42.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Apr 2025 03:42:43 -0700 (PDT)
Message-ID: <b1312600-1855-406c-9249-c7426f3a7324@redhat.com>
Date: Fri, 18 Apr 2025 12:42:42 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] mm/huge_memory: fix dereferencing invalid pmd
 migration entry
To: Gavin Guo <gavinguo@igalia.com>, linux-mm@kvack.org,
 akpm@linux-foundation.org
Cc: willy@infradead.org, ziy@nvidia.com, linmiaohe@huawei.com,
 hughd@google.com, revest@google.com, kernel-dev@igalia.com,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20250418085802.2973519-1-gavinguo@igalia.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20250418085802.2973519-1-gavinguo@igalia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 18.04.25 10:58, Gavin Guo wrote:
> When migrating a THP, concurrent access to the PMD migration entry
> during a deferred split scan can lead to a invalid address access, as
> illustrated below. To prevent this page fault, it is necessary to check
> the PMD migration entry and return early. In this context, there is no
> need to use pmd_to_swp_entry and pfn_swap_entry_to_page to verify the
> equality of the target folio. Since the PMD migration entry is locked,
> it cannot be served as the target.
> 
> Mailing list discussion and explanation from Hugh Dickins:
> "An anon_vma lookup points to a location which may contain the folio of
> interest, but might instead contain another folio: and weeding out those
> other folios is precisely what the "folio != pmd_folio((*pmd)" check
> (and the "risk of replacing the wrong folio" comment a few lines above
> it) is for."
> 
> BUG: unable to handle page fault for address: ffffea60001db008
> CPU: 0 UID: 0 PID: 2199114 Comm: tee Not tainted 6.14.0+ #4 NONE
> Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
> RIP: 0010:split_huge_pmd_locked+0x3b5/0x2b60
> Call Trace:
> <TASK>
> try_to_migrate_one+0x28c/0x3730
> rmap_walk_anon+0x4f6/0x770
> unmap_folio+0x196/0x1f0
> split_huge_page_to_list_to_order+0x9f6/0x1560
> deferred_split_scan+0xac5/0x12a0
> shrinker_debugfs_scan_write+0x376/0x470
> full_proxy_write+0x15c/0x220
> vfs_write+0x2fc/0xcb0
> ksys_write+0x146/0x250
> do_syscall_64+0x6a/0x120
> entry_SYSCALL_64_after_hwframe+0x76/0x7e
> 
> The bug is found by syzkaller on an internal kernel, then confirmed on
> upstream.
> 
> Fixes: 84c3fc4e9c56 ("mm: thp: check pmd migration entry in common path")
> Cc: stable@vger.kernel.org
> Signed-off-by: Gavin Guo <gavinguo@igalia.com>
> Acked-by: David Hildenbrand <david@redhat.com>
> Acked-by: Hugh Dickins <hughd@google.com>
> Acked-by: Zi Yan <ziy@nvidia.com>
> Link: https://lore.kernel.org/all/20250414072737.1698513-1-gavinguo@igalia.com/
> ---
> V1 -> V2: Add explanation from Hugh and correct the wording from page
> fault to invalid address access.
> 
>   mm/huge_memory.c | 18 ++++++++++++++----
>   1 file changed, 14 insertions(+), 4 deletions(-)
> 
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index 2a47682d1ab7..0cb9547dcff2 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -3075,6 +3075,8 @@ static void __split_huge_pmd_locked(struct vm_area_struct *vma, pmd_t *pmd,
>   void split_huge_pmd_locked(struct vm_area_struct *vma, unsigned long address,
>   			   pmd_t *pmd, bool freeze, struct folio *folio)
>   {
> +	bool pmd_migration = is_pmd_migration_entry(*pmd);
> +
>   	VM_WARN_ON_ONCE(folio && !folio_test_pmd_mappable(folio));
>   	VM_WARN_ON_ONCE(!IS_ALIGNED(address, HPAGE_PMD_SIZE));
>   	VM_WARN_ON_ONCE(folio && !folio_test_locked(folio));
> @@ -3085,10 +3087,18 @@ void split_huge_pmd_locked(struct vm_area_struct *vma, unsigned long address,
>   	 * require a folio to check the PMD against. Otherwise, there
>   	 * is a risk of replacing the wrong folio.
>   	 */
> -	if (pmd_trans_huge(*pmd) || pmd_devmap(*pmd) ||
> -	    is_pmd_migration_entry(*pmd)) {
> -		if (folio && folio != pmd_folio(*pmd))
> -			return;
> +	if (pmd_trans_huge(*pmd) || pmd_devmap(*pmd) || pmd_migration) {
> +		if (folio) {
> +			/*
> +			 * Do not apply pmd_folio() to a migration entry; and
> +			 * folio lock guarantees that it must be of the wrong
> +			 * folio anyway.
> +			 */
> +			if (pmd_migration)
> +				return;
> +			if (folio != pmd_folio(*pmd))
> +				return;

Nit: just re-reading, I would have simply done

if (pmd_migration || folio != pmd_folio(*pmd)
	return;

Anyway, this will hopefully get cleaned up soon either way, so I don't 
particularly mind. :)

-- 
Cheers,

David / dhildenb


