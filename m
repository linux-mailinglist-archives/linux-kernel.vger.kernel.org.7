Return-Path: <linux-kernel+bounces-742324-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EFD98B0EFF4
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 12:37:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 105DC3AF931
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 10:36:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C677287246;
	Wed, 23 Jul 2025 10:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IvHzO6I0"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C2BE286887
	for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 10:36:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753267018; cv=none; b=buSvmOVJQllFVmq9C2ekTwZ0VOpVUDCT/EnPi2F1t2Xl1ymrLvnRMSC0AZ8Vq1AfvinpXnmPR+tZWo6YeFMv3h0N0lYdGz0BBGLO0YsPlB9rFo8ShYGTdRsw7r3nPTEwh4kQw4UBIbGt562RcSAM33+9X1pWB5bnn37j6wGojug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753267018; c=relaxed/simple;
	bh=fXF7zEtoV3pkDHHk/2jCv9vm7zea7eal1YY9i1TcUJc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RKKMRD8baOpj5b8UGDOrg99YjUG1Wp5KuGKnslN5SRxQaQtbQ/Z7qL3Dv4pP+nD8SAWQZ7rxbFGwYEHKs/hOtIMzPLy5+z1cz1e0hEGU89ExdT5/TDieLLculS1/3Sa/JIpn2YRtbggMFlg7UHDwF0D7oWaNCNfgzVHAxCVYxiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IvHzO6I0; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1753267015;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=GC/2LupUE5wLX6ukUG4xRAWyfgxjbwSSK+8wvyo+VGw=;
	b=IvHzO6I0ryBth2DgumleJ5Tv9eUaqurxz7WpzquxhakfkHlfDkY8incdSoBOPwAZmz2a1Q
	3RiOtuV3R5uPP0T5VbJ41SGk8fBu8FuohFS5SRw1pr15ayf2LpOLElF/PHCx/wbXVuFqu6
	u9tQ4s6KR3HQN3VtnQ1bFtGHzv5eDjU=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-324-aiUQbumtMZupI4JsRsmvfw-1; Wed, 23 Jul 2025 06:36:54 -0400
X-MC-Unique: aiUQbumtMZupI4JsRsmvfw-1
X-Mimecast-MFC-AGG-ID: aiUQbumtMZupI4JsRsmvfw_1753267013
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-3a4f7f1b932so4335496f8f.2
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 03:36:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753267013; x=1753871813;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=GC/2LupUE5wLX6ukUG4xRAWyfgxjbwSSK+8wvyo+VGw=;
        b=lpOP39LupTqnuUPfbVF4VPpeQkW/Q7aR3cPMdDvB9oQDmHYlA+5fi/3SUCT7OmHpRr
         RM5K/QvwQ9Y0SKjXHuDcvRXtzyWpjsF8M3/ZaTu2HleIVEwvnAHpyaWv6XDZyCpGsKZf
         viCvavfFnA390PRqxUAgDOEVY7PVdLHsAUPGYAMO7CcllXrhilenGeX2gka4o/BruU/N
         k9JeCISC2fCYmcen4xBA140IDfUOaMR8c4iIK5QyoXGHhZ8tGiNRQbDhgBgaWbu3s/HR
         syleMdxvR/aC+G1HOGb83BDuWCrjAjfN4AjduNrNKdjsYx2fXTQPs+OI+Q0Xkui5AA9C
         2CSA==
X-Forwarded-Encrypted: i=1; AJvYcCUBYs94VQJ4p7TRm4gUO0bu49VMhDcrxF5wv5vkI9XqVAxke1ef1HFcHK9MsmKgqE33AEb9coO6JuDyt9k=@vger.kernel.org
X-Gm-Message-State: AOJu0YwyetBhX7sdVUzVtLsKOai066Dklq/5V/pgbRy1xflNr60R5WAI
	h4NfcRsh9Tf2JtH1+vcy/VsYWjrUe8Ntp53ueNdgF50NVutDfM/tw66w+h1g7fFOrv/kGVbogVB
	uPNhcVGkEs8bg3laRiXWcz0vW8+axGEun0Mb6yGY7dczxaMXhB6PpCRWMDFgfablRAA==
X-Gm-Gg: ASbGncuOPrOeoDcj1bIQFby1vuklfwAyARTrGftc4SZxfeBAOLgGMnMY0PnbkYTh5Tb
	bMw6pt5CF5Hvh+lioqaZ7ZZdHE/ODimqNUjzaUYffCuQ4hUeRrDEHRKoXj8X9rquuqLABI/PSl7
	jX31nB3LbG2HNmNu4ljcwaEzPuF5Ak7pSFXKf1TyKRMQGHZP9VQJZCltotmM4H5yIJxWof3tLTT
	l/pHjU5GVYGW5f51UJrzlBtqWD+0MZT8ZXXn6ttryE7EYrrpwzluRz6OfaNiNEThWG9nKQ79ZQv
	tOA1KRnH4OgF+w/sUqk9xuXbIIMkN4/j1TaznOXdkux3slHTnZvyqt5Wq6uZZCSwhCNt7A5qSvx
	dFAx3elJcDxUT9NgOq+JioSRPZUQ6jOffkCZpqJ8PxuUUDZvDb5Mh7PHunar8WgoQXAs=
X-Received: by 2002:a05:6000:1886:b0:3a5:27ba:479c with SMTP id ffacd0b85a97d-3b768effafdmr2019227f8f.43.1753267012714;
        Wed, 23 Jul 2025 03:36:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFqUvpYeVB0LjNVAtGw7wtGt9ho7Oby82qyjHiMQGf36IgI7a2x1v0eqNwKNc2oJ1e6grFOEA==
X-Received: by 2002:a05:6000:1886:b0:3a5:27ba:479c with SMTP id ffacd0b85a97d-3b768effafdmr2019195f8f.43.1753267012191;
        Wed, 23 Jul 2025 03:36:52 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f00:4000:a438:1541:1da1:723a? (p200300d82f004000a43815411da1723a.dip0.t-ipconnect.de. [2003:d8:2f00:4000:a438:1541:1da1:723a])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b61ca4d581sm15775545f8f.64.2025.07.23.03.36.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Jul 2025 03:36:50 -0700 (PDT)
Message-ID: <cbf19dfd-f1a2-4fec-bee4-137df33098d6@redhat.com>
Date: Wed, 23 Jul 2025 12:36:49 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] MAINTAINERS: add MM MISC section, add missing files to
 MISC and CORE
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 "Liam R . Howlett" <Liam.Howlett@oracle.com>,
 Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
 Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>
References: <20250723095823.21940-1-lorenzo.stoakes@oracle.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 g3eXuA==
Organization: Red Hat
In-Reply-To: <20250723095823.21940-1-lorenzo.stoakes@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 23.07.25 11:58, Lorenzo Stoakes wrote:
> Add a MEMORY MANAGEMENT - MISC section to contain files that are not described
> by other sections, moving all but the catch-all mm/ and tools/mm/ from MEMORY
> MANAGEMENT to MEMORY MANAGEMENT - CORE and MEMORY MANAGEMENT - MISC as
> appropriate.

Curious: do we need the catch-all because of untracked files, or because 
of future files?

> 
> In both sections add remaining missing files. At this point, with the other
> recent MAINTAINERS changes, this should now mean that every memory
> management-related file has a section and assigned maintainers/reviewers.
> 
> Finally, we copy across the maintainers/reviewers from MEMORY MANAGEMENT -
> CORE to MEMORY MANAGEMENT - MISC, as it seems the two are sufficiently
> related for this to be sensible.
> 
> Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> Acked-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
> ---
> 
> v2:
> * Propagate ack (thanks Mike!)
> * Retain MEMORY MANAGEMENT section to contain the global mm/ and tools/mm/
>    directories and remove from MEMORY MANAGEMENT - MISC section, I misunderstood
>    how these catch-alls would work. As reported by Vlastimil.
> * Update cover letter and subject to reflect the above.
> 
> v1:
> https://lore.kernel.org/all/20250722192704.164758-1-lorenzo.stoakes@oracle.com/
> 
> 
>   MAINTAINERS | 68 ++++++++++++++++++++++++++++++++++++++++++-----------
>   1 file changed, 54 insertions(+), 14 deletions(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 507a999f1955..5a9d4c57add4 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -15741,22 +15741,8 @@ S:	Maintained
>   W:	http://www.linux-mm.org
>   T:	git git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm
>   T:	quilt git://git.kernel.org/pub/scm/linux/kernel/git/akpm/25-new
> -F:	Documentation/admin-guide/mm/
> -F:	Documentation/mm/
> -F:	include/linux/gfp.h
> -F:	include/linux/gfp_types.h
> -F:	include/linux/memory_hotplug.h
> -F:	include/linux/memory-tiers.h
> -F:	include/linux/mempolicy.h
> -F:	include/linux/mempool.h
> -F:	include/linux/mmzone.h
> -F:	include/linux/mmu_notifier.h
> -F:	include/linux/pagewalk.h
> -F:	include/trace/events/ksm.h
>   F:	mm/
>   F:	tools/mm/
> -F:	tools/testing/selftests/mm/
> -N:	include/linux/page[-_]*
> 
>   MEMORY MANAGEMENT - CORE
>   M:	Andrew Morton <akpm@linux-foundation.org>
> @@ -15771,18 +15757,32 @@ L:	linux-mm@kvack.org
>   S:	Maintained
>   W:	http://www.linux-mm.org
>   T:	git git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm
> +F:	include/linux/gfp.h
> +F:	include/linux/gfp_types.h
>   F:	include/linux/memory.h
>   F:	include/linux/mm.h
>   F:	include/linux/mm_*.h
> +F:	include/linux/mmzone.h
>   F:	include/linux/mmdebug.h
>   F:	include/linux/pagewalk.h
>   F:	kernel/fork.c
>   F:	mm/Kconfig
>   F:	mm/debug.c
> +F:	mm/folio-compat.c
> +F:	mm/highmem.c
>   F:	mm/init-mm.c
> +F:	mm/internal.h
> +F:	mm/maccess.c
>   F:	mm/memory.c
> +F:	mm/mmzone.c
>   F:	mm/pagewalk.c
> +F:	mm/pgtable-generic.c
> +F:	mm/sparse-vmemmap.c
> +F:	mm/sparse.c
>   F:	mm/util.c
> +F:	mm/vmpressure.c
> +F:	mm/vmstat.c
> +N:	include/linux/page[-_]*
> 
>   MEMORY MANAGEMENT - EXECMEM
>   M:	Andrew Morton <akpm@linux-foundation.org>
> @@ -15844,6 +15844,46 @@ F:	mm/mempolicy.c
>   F:	mm/migrate.c
>   F:	mm/migrate_device.c
> 
> +MEMORY MANAGEMENT - MISC
> +M:	Andrew Morton <akpm@linux-foundation.org>
> +M:	David Hildenbrand <david@redhat.com>
> +R:	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> +R:	Liam R. Howlett <Liam.Howlett@oracle.com>
> +R:	Vlastimil Babka <vbabka@suse.cz>
> +R:	Mike Rapoport <rppt@kernel.org>
> +R:	Suren Baghdasaryan <surenb@google.com>
> +R:	Michal Hocko <mhocko@suse.com>
> +L:	linux-mm@kvack.org
> +S:	Maintained
> +W:	http://www.linux-mm.org
> +T:	git git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm
> +F:	Documentation/admin-guide/mm/
> +F:	Documentation/mm/
> +F:	include/linux/memory-tiers.h
> +F:	include/linux/mempolicy.h

That is already under "MEMORY MANAGEMENT - MEMORY POLICY AND MIGRATION"

> +F:	include/linux/mempool.h
> +F:	include/linux/memremap.h

That will be MEMORY_HOTPLUG, right?

> +F:	include/linux/mmu_notifier.h
> +F:	include/trace/events/ksm.h

This is already in the KSM section.

> +F:	mm/backing-dev.c
> +F:	mm/cma.c
> +F:	mm/cma_debug.c
> +F:	mm/cma_sysfs.c
> +F:	mm/dmapool.c
> +F:	mm/dmapool_test.c
> +F:	mm/early_ioremap.c
> +F:	mm/fadvise.c
> +F:	mm/io-mapping.c
> +F:	mm/ioremap.c
> +F:	mm/mapping_dirty_helpers.c
> +F:	mm/memory-tiers.c
> +F:	mm/mmu_notifier.c
> +F:	mm/page_idle.c
> +F:	mm/pgalloc-track.h
> +F:	mm/process_vm_access.c
> +F:	mm/ptdump.c
> +F:	tools/testing/selftests/mm/

Kind-of a catch-all as well.


-- 
Cheers,

David / dhildenb


