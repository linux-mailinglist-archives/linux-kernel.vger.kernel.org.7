Return-Path: <linux-kernel+bounces-782857-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 37989B3261B
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Aug 2025 03:07:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1515A1BA818A
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Aug 2025 01:07:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB7E0155757;
	Sat, 23 Aug 2025 01:07:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="aXtznABH"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ECB213B7AE
	for <linux-kernel@vger.kernel.org>; Sat, 23 Aug 2025 01:07:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755911231; cv=none; b=KQqhjrUe7bmsznjgREv9/aeFgCgxy1y9F33wPxjHsXXfubZXN/zrqsl3anaLbmoXTGHQhGmRYEWcMbzlwkmFdwuIWiIFNTMjbdKZPW5zS4eZAIkXhxuYQtHar/BJgT/yJZcnuyaSFwBbd5lTa/AO8mKqI508VsXMnh7xKHleyhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755911231; c=relaxed/simple;
	bh=zPA848lcj2PEuJ1vl87BuBrFFkm/q/v1YtYEAu70EyM=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=EPutiyOw/fuV6m47wJFoDSHpHqLKmBWrHNaytYp3u1Rt5L+07bTSh8W/opkpoBfmFwQtVKgJnS4g+okR3EtO4EUdmEaql7d7OLLd54bVEJLw5dQDJJye5RmuyZIfyR8TFWbpYi2QljaoCFRdq5kTN8KaoAfnJBqVFpPmA8QqIec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=aXtznABH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E748C4CEED;
	Sat, 23 Aug 2025 01:07:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1755911229;
	bh=zPA848lcj2PEuJ1vl87BuBrFFkm/q/v1YtYEAu70EyM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=aXtznABHufngIYSDtYdd01SpLEVfLER3WrVjAondkKqurHFL/zI/WCeIWW6NSri5Z
	 H1a1ejxqy6k+D1ez67uV9a2ksETHTzdUaomcq7TPd+QKL477M0+e+EFQrVCQOFgRay
	 m/PaoBsedbdvh92ZeQGsXNMn1WlQoqocJ+xh31wY=
Date: Fri, 22 Aug 2025 18:07:08 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Jeongjun Park <aha310510@gmail.com>
Cc: muchun.song@linux.dev, osalvador@suse.de, david@redhat.com,
 leitao@debian.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 syzbot+417aeb05fd190f3a6da9@syzkaller.appspotmail.com
Subject: Re: [PATCH] mm/hugetlb: add missing hugetlb_lock in
 __unmap_hugepage_range()
Message-Id: <20250822180708.86e79941d7e47e3bb759b193@linux-foundation.org>
In-Reply-To: <20250822055857.1142454-1-aha310510@gmail.com>
References: <20250822055857.1142454-1-aha310510@gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 22 Aug 2025 14:58:57 +0900 Jeongjun Park <aha310510@gmail.com> wrote:

> When restoring a reservation for an anonymous page, we need to check to
> freeing a surplus. However, __unmap_hugepage_range() causes data race
> because it reads h->surplus_huge_pages without the protection of
> hugetlb_lock.
> 
> Therefore, we need to add missing hugetlb_lock.
> 
> ...
>
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -5951,6 +5951,8 @@ void __unmap_hugepage_range(struct mmu_gather *tlb, struct vm_area_struct *vma,
>  		 * If there we are freeing a surplus, do not set the restore
>  		 * reservation bit.
>  		 */
> +		spin_lock_irq(&hugetlb_lock);
> +
>  		if (!h->surplus_huge_pages && __vma_private_lock(vma) &&
>  		    folio_test_anon(folio)) {
>  			folio_set_hugetlb_restore_reserve(folio);
> @@ -5958,6 +5960,7 @@ void __unmap_hugepage_range(struct mmu_gather *tlb, struct vm_area_struct *vma,
>  			adjust_reservation = true;
>  		}
>  
> +		spin_unlock_irq(&hugetlb_lock);
>  		spin_unlock(ptl);
>  

Does hugetlb_lock nest inside page_table_lock?

It's a bit sad to be taking a global lock just to defend against some
alleged data race which probably never happens.  Doing it once per
hugepage probably won't matter but still, is there something more
proportionate that we can do here?

