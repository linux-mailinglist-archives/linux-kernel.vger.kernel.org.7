Return-Path: <linux-kernel+bounces-863971-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C7DCBF9A05
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 03:41:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 47B0919C79EE
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 01:41:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F17E1F3B9E;
	Wed, 22 Oct 2025 01:41:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d6R32oOq"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86902288D2
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 01:41:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761097261; cv=none; b=aeBBoiby74f1TOLFjVJnUd2cPAUYwstvR7bEiL7FXhQBaHSJvDhlWot3ZPIhKEkHEiaKKWzJzuckg+aBA7NlkJ0kB48N9/hQ3jECRLOTUWI7PIt6HR1W+QMQgNwixYm3SJiiW6nYjr0tGafWuJE6ToQ7/f2XkjgJgYnE/3osASw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761097261; c=relaxed/simple;
	bh=pFBBzB2arJXkNPRvMZSCJ6eRnA/xFysNEdKKlZiu1IA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NIX2qy3cAXwUdT2HK+7V548qpJZv6Wx1Dtn6B+7i1IeEHCMgYAKU53wXpL2VN8vOLydcvhRPvWKZAPIZr/R7uVCfunhEFo0Dold1XKtptiyREiy2iJg4zCrdr3mAj/L9kBTHvy2glyILkGA8rxz4p0qHr2U0f1S0jv2ahNdguPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d6R32oOq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D019C4CEF1;
	Wed, 22 Oct 2025 01:40:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761097261;
	bh=pFBBzB2arJXkNPRvMZSCJ6eRnA/xFysNEdKKlZiu1IA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=d6R32oOqgjh3e7Ejgb67KUf7y3yistL/0VVbArQ3XlTq2vuLG4aSIamn8YoqIw2rX
	 qpnrTOSv1Q3UIRJbNgplZQPp9QZsZwbdN2E5um551ARVWFkRRCWEX0bCfB5ZSNu1kg
	 CRrAqr14Q3cBcUy5YDnahW48ltXD0duwPo38jkBa8EhIvT54aE0ao3PzEJt33kpNdz
	 G5ki0cy+bkMYyLrWurXwzb4TH3djBQpEzot7JKTWqeZJlblufIHXbAOUwFjMkiKxBm
	 tFUPOT5JjDySmsY7sG/TRFZr6RiRaM+kRRVLQCiBleiFMfpK77ua+Zp/tVHSEuQ0sQ
	 lOlFa9KXZ/uGA==
From: SeongJae Park <sj@kernel.org>
To: Gregory Price <gourry@gourry.net>
Cc: SeongJae Park <sj@kernel.org>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	akpm@linux-foundation.org,
	vbabka@suse.cz,
	surenb@google.com,
	mhocko@suse.com,
	jackmanb@google.com,
	hannes@cmpxchg.org,
	ziy@nvidia.com,
	David Hildenbrand <david@redhat.com>
Subject: Re: [RFC PATCH v2] page_alloc: allow migration of smaller hugepages during contig_alloc.
Date: Tue, 21 Oct 2025 18:40:57 -0700
Message-ID: <20251022014057.128900-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251020210816.1089910-1-gourry@gourry.net>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, 20 Oct 2025 17:08:16 -0400 Gregory Price <gourry@gourry.net> wrote:

> We presently skip regions with hugepages entirely when trying to do
> contiguous page allocation.  Instead, if hugepage migration is enabled,
> consider regions with hugepages smaller than the requested allocation.
> 
> Compaction `isolate_migrate_pages_block()` already expects requests
> with hugepages to originate from alloc_contig, and hugetlb code also
> does a migratable check when isolating in `folio_isolate_hugetlb()`.
> 
> Suggested-by: David Hildenbrand <david@redhat.com>
> Signed-off-by: Gregory Price <gourry@gourry.net>
> ---
>  mm/page_alloc.c | 15 +++++++++++++--
>  1 file changed, 13 insertions(+), 2 deletions(-)
> 
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 600d9e981c23..da2e65bf63e3 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -7048,8 +7048,19 @@ static bool pfn_range_valid_contig(struct zone *z, unsigned long start_pfn,
>  		if (PageReserved(page))
>  			return false;
>  
> -		if (PageHuge(page))
> -			return false;
> +		if (PageHuge(page)) {
> +			unsigned int order;
> +
> +			if (!IS_ENABLED(CONFIG_ARCH_ENABLE_HUGEPAGE_MIGRATION))
> +				return false;
> +
> +			/* Don't consider moving same size/larger pages */
> +			page = compound_head(page);
> +			order = compound_order(page);
> +			if ((order >= MAX_PAGE_ORDER) ||
> +			    (nr_pages < (1 << order)))
> +				return false;

Shouldn't the comparison of 'nr_pages' against '1 << order' use '<=' instead of
'<', to match the commit description?

> +		}
>  	}
>  	return true;
>  }
> -- 
> 2.51.0


Thanks,
SJ

