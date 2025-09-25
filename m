Return-Path: <linux-kernel+bounces-832429-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CB3CB9F4B6
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 14:39:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 74CD01B27523
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 12:39:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EC5228152D;
	Thu, 25 Sep 2025 12:38:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G1UgG+40"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 932E027FB35
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 12:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758803882; cv=none; b=o3lkO0dKSXkkz/7jyhqw/dVnfq02lkfNgX74eWrh5xl3W2RbsFwKBvf7h+bL6GZv6FgKVaeORUiKYZTSNZKzhTLIcaryeH1diM+LNUUR3A6FLZVzK0UJ5shtzGDFxoVCDZAm0Ww5oFhcA2Z/RqKcDml1H9oK9jrNNCEpfH31wVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758803882; c=relaxed/simple;
	bh=8WHSnL4BT2wiykQ4IYUSxuEooxYTRYdEQO5KCzBE84E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=GcwN+EdPQlX5wAK8Dw/TKa9r7FB2jE1OHE3dPqL8tho2idtzqXz0WVM1Aq6X+LD5cNL7hAHtg2UyQ8xNYr0/UAQAVYMprOzq2JJXIjpLr0eQ3ypmt+eMygBWLLCusPL25fqZM/tcYu73q13AFK3YobDMmg32oO6G+6r84YQFX3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G1UgG+40; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0488C4CEF7;
	Thu, 25 Sep 2025 12:38:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758803882;
	bh=8WHSnL4BT2wiykQ4IYUSxuEooxYTRYdEQO5KCzBE84E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=G1UgG+40AKXpcD6FRJ/1mcUVkTz5uDVnl8ONHDb1dYzKmEKhkBqukKwAgdq18jh7i
	 snn7tcfn8bFIywn3ooYKfVTDEJ2fSQLZxqoZumf0/hs2BE34oR5zeQp+5M4PpIVaqP
	 xrOmZIkEk04yhY7/9no8wUsQQyGUix0dEO/ynvoLAcQSQM7vP/ufo3rO4BhH74uxfQ
	 DgkLkdXBGDx7kDY4v9+a46r97IlQ4WTRZcUckvpu72eMOtRLItVtOZq47W1kWqFBdO
	 rPBdeJaH07koW1hxFVpzAECrS0DjyA20eN392WBd2m7yYVjXt+9HQz0Vn0/3jQ11qu
	 tx6R1hMXpBgYg==
From: SeongJae Park <sj@kernel.org>
To: Alexander Potapenko <glider@google.com>
Cc: SeongJae Park <sj@kernel.org>,
	akpm@linux-foundation.org,
	david@redhat.com,
	vbabka@suse.cz,
	rppt@kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	elver@google.com,
	dvyukov@google.com,
	kasan-dev@googlegroups.com,
	Aleksandr Nogikh <nogikh@google.com>
Subject: Re: [PATCH v2] mm/memblock: Correct totalram_pages accounting with KMSAN
Date: Thu, 25 Sep 2025 05:37:59 -0700
Message-Id: <20250925123759.59479-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250924100301.1558645-1-glider@google.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello,

On Wed, 24 Sep 2025 12:03:01 +0200 Alexander Potapenko <glider@google.com> wrote:

> When KMSAN is enabled, `kmsan_memblock_free_pages()` can hold back pages
> for metadata instead of returning them to the early allocator. The callers,
> however, would unconditionally increment `totalram_pages`, assuming the
> pages were always freed. This resulted in an incorrect calculation of the
> total available RAM, causing the kernel to believe it had more memory than
> it actually did.
> 
> This patch refactors `memblock_free_pages()` to return the number of pages
> it successfully frees. If KMSAN stashes the pages, the function now
> returns 0; otherwise, it returns the number of pages in the block.
> 
> The callers in `memblock.c` have been updated to use this return value,
> ensuring that `totalram_pages` is incremented only by the number of pages
> actually returned to the allocator. This corrects the total RAM accounting
> when KMSAN is active.
> 
> Cc: Aleksandr Nogikh <nogikh@google.com>
> Fixes: 3c2065098260 ("init: kmsan: call KMSAN initialization routines")
> Signed-off-by: Alexander Potapenko <glider@google.com>
> Reviewed-by: David Hildenbrand <david@redhat.com>
[...]
> --- a/mm/mm_init.c
> +++ b/mm/mm_init.c
> @@ -2548,24 +2548,25 @@ void *__init alloc_large_system_hash(const char *tablename,
>  	return table;
>  }
>  
> -void __init memblock_free_pages(struct page *page, unsigned long pfn,
> -							unsigned int order)
> +unsigned long __init memblock_free_pages(struct page *page, unsigned long pfn,
> +					 unsigned int order)
>  {
>  	if (IS_ENABLED(CONFIG_DEFERRED_STRUCT_PAGE_INIT)) {
>  		int nid = early_pfn_to_nid(pfn);
>  
>  		if (!early_page_initialised(pfn, nid))
> -			return;
> +			return 0;
>  	}

I found this patch on mm-new tree is making my test machine (QEMU) reports much
less MemTotal even though KMSAN is disabled.  And modifying the above part to
be considered as free success (returning '1UL << order') fixed my issue.
Because the commit message says the purpose of this change is only for
KMSAN-stashed memory, maybe the above behavior change is not really intended?

I'm not familiar with this code so I'm unsure if the workaround is the right
fix.  But since I have no time to look this in deep for now, reporting first.

>  
>  	if (!kmsan_memblock_free_pages(page, order)) {
>  		/* KMSAN will take care of these pages. */
> -		return;
> +		return 0;
>  	}

I understand this part is the intended change, of course.


Thanks,
SJ

[...]

