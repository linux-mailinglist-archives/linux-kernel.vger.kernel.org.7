Return-Path: <linux-kernel+bounces-818053-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 93DE8B58C25
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 05:08:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0D0161BC456F
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 03:08:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24EF9238C33;
	Tue, 16 Sep 2025 03:08:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="N8A+NpMj"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D55538DDB
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 03:08:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757992098; cv=none; b=XZleqWeS7CAEkvib1EerQZscfYUm4YXVovhsj3C8+Pxj7ZkOdcslOt+rMu8aIBALdijA+y9qQpIxPlQdL0iNbTyNiioECf1k/HMv2A2rWe4EF/jQjqPX08QSsgfvYdRb+HExZKNeuWXkU7iKh/aoN7zBmzfYZBZ+uQjCeQT43K8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757992098; c=relaxed/simple;
	bh=SzU9zd6gKPgO0BdktrwqDgUBQcmLllVJGEvbli/LrUs=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=oFsHpRTrDaeC4/OqprENiTroTWfMDEvsS4SE4Z0qgaVoBOobenbIO0xX4GPe10maGp6Ydb2NPAm3SHUOgcL7nIb28Vzru1eHBW9a55P3iLWPmcOhrnlJFP0adVjFrvEEWqu2qzjuJnwKzDaSe1TwiKHrplNfdxdoMV+V9AoC54Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=N8A+NpMj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90EC9C4CEF1;
	Tue, 16 Sep 2025 03:08:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1757992096;
	bh=SzU9zd6gKPgO0BdktrwqDgUBQcmLllVJGEvbli/LrUs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=N8A+NpMjB+OO2qFkCikHUYaXyurnUzhTBVaKoQWOUESt4QplPSf6y5gNUrLZdTnzH
	 NJHtWZhaZ92UXB7/08B/2cODdTaYBEELsRs1Okg4QdAKEJQVeQ3prjctU0f7uZBUuA
	 xZZ6jGQOsShojE+eX88M6C+jgKtO7J0y2OQceE3o=
Date: Mon, 15 Sep 2025 20:08:15 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Jane Chu <jane.chu@oracle.com>
Cc: david@redhat.com, harry.yoo@oracle.com, osalvador@suse.de,
 liushixin2@huawei.com, muchun.song@linux.dev, jannh@google.com,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] mm/hugetlb: fix copy_hugetlb_page_range() to use
 ->pt_share_count
Message-Id: <20250915200815.e2b844e0a3291fa994d333b4@linux-foundation.org>
In-Reply-To: <20250916004520.1604530-1-jane.chu@oracle.com>
References: <20250916004520.1604530-1-jane.chu@oracle.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 15 Sep 2025 18:45:20 -0600 Jane Chu <jane.chu@oracle.com> wrote:

> commit 59d9094df3d79 ("mm: hugetlb: independent PMD page table shared count")
> introduced ->pt_share_count dedicated to hugetlb PMD share count tracking,
> but omitted fixing copy_hugetlb_page_range(), leaving the function relying on
> page_count() for tracking that no longer works.
> 
> When lazy page table copy for hugetlb is disabled, that is, revert
> commit bcd51a3c679d ("hugetlb: lazy page table copies in fork()")
> fork()'ing with hugetlb PMD sharing quickly lockup -
> 
> [  239.446559] watchdog: BUG: soft lockup - CPU#75 stuck for 27s!
> [  239.446611] RIP: 0010:native_queued_spin_lock_slowpath+0x7e/0x2e0
> [  239.446631] Call Trace:
> [  239.446633]  <TASK>
> [  239.446636]  _raw_spin_lock+0x3f/0x60
> [  239.446639]  copy_hugetlb_page_range+0x258/0xb50
> [  239.446645]  copy_page_range+0x22b/0x2c0
> [  239.446651]  dup_mmap+0x3e2/0x770
> [  239.446654]  dup_mm.constprop.0+0x5e/0x230
> [  239.446657]  copy_process+0xd17/0x1760
> [  239.446660]  kernel_clone+0xc0/0x3e0
> [  239.446661]  __do_sys_clone+0x65/0xa0
> [  239.446664]  do_syscall_64+0x82/0x930
> [  239.446668]  ? count_memcg_events+0xd2/0x190
> [  239.446671]  ? syscall_trace_enter+0x14e/0x1f0
> [  239.446676]  ? syscall_exit_work+0x118/0x150
> [  239.446677]  ? arch_exit_to_user_mode_prepare.constprop.0+0x9/0xb0
> [  239.446681]  ? clear_bhb_loop+0x30/0x80
> [  239.446684]  ? clear_bhb_loop+0x30/0x80
> [  239.446686]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
> 
> There are two options to resolve the potential latent issue:
>   1. warn against PMD sharing in copy_hugetlb_page_range(),
>   2. fix it.
> This patch opts for the second option.
> While at it, simplify the comment, the details are not actually relevant
> anymore.

Thanks.  I dropped the v2 patch from mm-hotfixes-stable and added this.

> Fixes: 59d9094df3d79 ("mm: hugetlb: independent PMD page table shared count")
> Signed-off-by: Jane Chu <jane.chu@oracle.com>
> Reviewed-by: Harry Yoo <harry.yoo@oracle.com>
> ---
>  include/linux/mm_types.h |  5 +++++
>  mm/hugetlb.c             | 15 +++++----------
>  2 files changed, 10 insertions(+), 10 deletions(-)
> 

It's conventional (and useful) to explain (beneath the "---") what
changed since the previous version.

Here's the v2->v3 diff, which appears to be based on David's review
comments:

--- a/include/linux/mm_types.h~mm-hugetlb-fix-copy_hugetlb_page_range-to-use-pt_share_count
+++ a/include/linux/mm_types.h
@@ -631,6 +631,11 @@ static inline int ptdesc_pmd_pts_count(s
 {
 	return atomic_read(&ptdesc->pt_share_count);
 }
+
+static inline bool ptdesc_pmd_is_shared(struct ptdesc *ptdesc)
+{
+	return !!ptdesc_pmd_pts_count(ptdesc);
+}
 #else
 static inline void ptdesc_pmd_pts_init(struct ptdesc *ptdesc)
 {
--- a/mm/hugetlb.c~mm-hugetlb-fix-copy_hugetlb_page_range-to-use-pt_share_count
+++ a/mm/hugetlb.c
@@ -5595,8 +5595,8 @@ int copy_hugetlb_page_range(struct mm_st
 		}
 
 #ifdef CONFIG_HUGETLB_PMD_PAGE_TABLE_SHARING
-		/* If the pagetables are shared don't copy or take references. */
-		if (ptdesc_pmd_pts_count(virt_to_ptdesc(dst_pte)) > 0) {
+		/* If the pagetables are shared, there is nothing to do */
+		if (ptdesc_pmd_is_shared(virt_to_ptdesc(dst_pte))) {
 			addr |= last_addr_mask;
 			continue;
 		}
@@ -7597,7 +7597,7 @@ int huge_pmd_unshare(struct mm_struct *m
 	hugetlb_vma_assert_locked(vma);
 	if (sz != PMD_SIZE)
 		return 0;
-	if (!ptdesc_pmd_pts_count(virt_to_ptdesc(ptep)))
+	if (!ptdesc_pmd_is_shared(virt_to_ptdesc(ptep)))
 		return 0;
 
 	pud_clear(pud);
_


