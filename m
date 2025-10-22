Return-Path: <linux-kernel+bounces-865915-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 74A99BFE536
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 23:36:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 129C94EA14A
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 21:36:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 666C22F4A19;
	Wed, 22 Oct 2025 21:36:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="YD/zEhKO"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54ED312CDA5
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 21:36:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761168966; cv=none; b=qtQukMQJa76UJZsDdCdJIwMu2g2XsXpTUsI09f9W6Aj6RLzZBX6ojtcM1wn57wxLGX3yXp3LdsxZ083XBe3WG+mDf+t1h7vSffoHEmm3D4Y/868G7wA2XHcMqK165RF9fe479fQ5ObDuFnH6YGtMunmzrvWxv3P259DZy+LUAOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761168966; c=relaxed/simple;
	bh=xzJFHS05vq/gzblbNJCK/TcArYaZ4JncDoxITCAkLaY=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=m0abrCtl/ojR2Imi8o2THXRJKv2RiDDiKFHJDKzxhc8TIXV9ZwXPyf9cSehlzh3NXXKhz1MWMGAQ2lmKd+i8lkrhYcBNxixDME5Ij9+N3yuCoUsUJIF7s3gaYjwC10987ycQpHUMbDLtT1rlHbihpOqR0AdCz+xf+iN+t17DaV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=YD/zEhKO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81401C4CEE7;
	Wed, 22 Oct 2025 21:36:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1761168965;
	bh=xzJFHS05vq/gzblbNJCK/TcArYaZ4JncDoxITCAkLaY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=YD/zEhKOHgEYpglKaPhtMClD31p30giEdTFT17IwmiXfer+aiI+vhBszRJP0giJZJ
	 eG2wyFYkb0Ca9YMP19vLrq8LvCIie8zJLDpkh81fViVa+wJVVggvnJmvqxkvU2mAoL
	 KpvHzFeQSLVqxbnRE+K1StBZGaU930yoNKcxhxQ4=
Date: Wed, 22 Oct 2025 14:36:04 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Eric Biggers <ebiggers@kernel.org>
Cc: Aleksei Nikiforov <aleksei.nikiforov@linux.ibm.com>, Alexander Potapenko
 <glider@google.com>, Marco Elver <elver@google.com>, Dmitry Vyukov
 <dvyukov@google.com>, kasan-dev@googlegroups.com, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, Ilya Leoshkevich <iii@linux.ibm.com>, Alexei
 Starovoitov <ast@kernel.org>
Subject: Re: [PATCH] mm/kmsan: Fix kmsan kmalloc hook when no stack depots
 are allocated yet
Message-Id: <20251022143604.1ac1fcb18bfaf730097081ab@linux-foundation.org>
In-Reply-To: <20251022030213.GA35717@sol>
References: <20250930115600.709776-2-aleksei.nikiforov@linux.ibm.com>
	<20251008203111.e6ce309e9f937652856d9aa5@linux-foundation.org>
	<335827e0-0a4c-43c3-a79b-6448307573fd@linux.ibm.com>
	<20251022030213.GA35717@sol>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 21 Oct 2025 20:02:13 -0700 Eric Biggers <ebiggers@kernel.org> wrote:

> On Fri, Oct 10, 2025 at 10:07:04AM +0200, Aleksei Nikiforov wrote:
> > On 10/9/25 05:31, Andrew Morton wrote:
> > > On Tue, 30 Sep 2025 13:56:01 +0200 Aleksei Nikiforov <aleksei.nikiforov@linux.ibm.com> wrote:
> > > 
> > > > If no stack depot is allocated yet,
> > > > due to masking out __GFP_RECLAIM flags
> > > > kmsan called from kmalloc cannot allocate stack depot.
> > > > kmsan fails to record origin and report issues.
> > > > 
> > > > Reusing flags from kmalloc without modifying them should be safe for kmsan.
> > > > For example, such chain of calls is possible:
> > > > test_uninit_kmalloc -> kmalloc -> __kmalloc_cache_noprof ->
> > > > slab_alloc_node -> slab_post_alloc_hook ->
> > > > kmsan_slab_alloc -> kmsan_internal_poison_memory.
> > > > 
> > > > Only when it is called in a context without flags present
> > > > should __GFP_RECLAIM flags be masked.
> > > > 
> > > > With this change all kmsan tests start working reliably.
> > > 
> > > I'm not seeing reports of "hey, kmsan is broken", so I assume this
> > > failure only occurs under special circumstances?
> > 
> > Hi,
> > 
> > kmsan might report less issues than it detects due to not allocating stack
> > depots and not reporting issues without stack depots. Lack of reports may go
> > unnoticed, that's why you don't get reports of kmsan being broken.
> 
> Yes, KMSAN seems to be at least partially broken currently.  Besides the
> fact that the kmsan KUnit test is currently failing (which I reported at
> https://lore.kernel.org/r/20250911175145.GA1376@sol), I've confirmed
> that the poly1305 KUnit test causes a KMSAN warning with Aleksei's patch
> applied but does not cause a warning without it.  The warning did get
> reached via syzbot somehow
> (https://lore.kernel.org/r/751b3d80293a6f599bb07770afcef24f623c7da0.1761026343.git.xiaopei01@kylinos.cn/),
> so KMSAN must still work in some cases.  But it didn't work for me.

OK, thanks, I pasted the above para into the changelog to help people
understand the impact of this.

> (That particular warning in the architecture-optimized Poly1305 code is
> actually a false positive due to memory being initialized by assembly
> code.  But that's besides the point.  The point is that I should have
> seen the warning earlier, but I didn't.  And Aleksei's patch seems to
> fix KMSAN to work reliably.  It also fixes the kmsan KUnit test.)
> 
> I don't really know this code, but I can at least give:
> 
> Tested-by: Eric Biggers <ebiggers@kernel.org>
> 
> If you want to add a Fixes commit I think it is either 97769a53f117e2 or
> 8c57b687e8331.  Earlier I had confirmed that reverting those commits
> fixed the kmsan test too
> (https://lore.kernel.org/r/20250911192953.GG1376@sol).

Both commits affect the same kernel version so either should be good
for a Fixes target.

I'll add a cc:stable to this and shall stage it for 6.18-rcX.

The current state is below - if people want to suggest alterations,
please go for it.



From: Aleksei Nikiforov <aleksei.nikiforov@linux.ibm.com>
Subject: mm/kmsan: fix kmsan kmalloc hook when no stack depots are allocated yet
Date: Tue, 30 Sep 2025 13:56:01 +0200

If no stack depot is allocated yet, due to masking out __GFP_RECLAIM
flags kmsan called from kmalloc cannot allocate stack depot.  kmsan
fails to record origin and report issues.  This may result in KMSAN
failing to report issues.

Reusing flags from kmalloc without modifying them should be safe for kmsan.
For example, such chain of calls is possible:
test_uninit_kmalloc -> kmalloc -> __kmalloc_cache_noprof ->
slab_alloc_node -> slab_post_alloc_hook ->
kmsan_slab_alloc -> kmsan_internal_poison_memory.

Only when it is called in a context without flags present should
__GFP_RECLAIM flags be masked.

With this change all kmsan tests start working reliably.

Eric reported:

: Yes, KMSAN seems to be at least partially broken currently.  Besides the
:_fact that the kmsan KUnit test is currently failing (which I reported at
:_https://lore.kernel.org/r/20250911175145.GA1376@sol), I've confirmed that
:_the poly1305 KUnit test causes a KMSAN warning with Aleksei's patch
:_applied but does not cause a warning without it.  The warning did get
:_reached via syzbot somehow
:_(https://lore.kernel.org/r/751b3d80293a6f599bb07770afcef24f623c7da0.1761026343.git.xiaopei01@kylinos.cn/),
:_so KMSAN must still work in some cases.  But it didn't work for me.

Link: https://lkml.kernel.org/r/20250930115600.709776-2-aleksei.nikiforov@linux.ibm.com
Link: https://lkml.kernel.org/r/20251022030213.GA35717@sol
Fixes: 97769a53f117 ("mm, bpf: Introduce try_alloc_pages() for opportunistic page allocation")
Signed-off-by: Aleksei Nikiforov <aleksei.nikiforov@linux.ibm.com>
Reviewed-by: Alexander Potapenko <glider@google.com>
Tested-by: Eric Biggers <ebiggers@kernel.org>
Cc: Dmitriy Vyukov <dvyukov@google.com>
Cc: Ilya Leoshkevich <iii@linux.ibm.com>
Cc: Marco Elver <elver@google.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 mm/kmsan/core.c   |    3 ---
 mm/kmsan/hooks.c  |    6 ++++--
 mm/kmsan/shadow.c |    2 +-
 3 files changed, 5 insertions(+), 6 deletions(-)

--- a/mm/kmsan/core.c~mm-kmsan-fix-kmsan-kmalloc-hook-when-no-stack-depots-are-allocated-yet
+++ a/mm/kmsan/core.c
@@ -72,9 +72,6 @@ depot_stack_handle_t kmsan_save_stack_wi
 
 	nr_entries = stack_trace_save(entries, KMSAN_STACK_DEPTH, 0);
 
-	/* Don't sleep. */
-	flags &= ~(__GFP_DIRECT_RECLAIM | __GFP_KSWAPD_RECLAIM);
-
 	handle = stack_depot_save(entries, nr_entries, flags);
 	return stack_depot_set_extra_bits(handle, extra);
 }
--- a/mm/kmsan/hooks.c~mm-kmsan-fix-kmsan-kmalloc-hook-when-no-stack-depots-are-allocated-yet
+++ a/mm/kmsan/hooks.c
@@ -84,7 +84,8 @@ void kmsan_slab_free(struct kmem_cache *
 	if (s->ctor)
 		return;
 	kmsan_enter_runtime();
-	kmsan_internal_poison_memory(object, s->object_size, GFP_KERNEL,
+	kmsan_internal_poison_memory(object, s->object_size,
+				     GFP_KERNEL & ~(__GFP_RECLAIM),
 				     KMSAN_POISON_CHECK | KMSAN_POISON_FREE);
 	kmsan_leave_runtime();
 }
@@ -114,7 +115,8 @@ void kmsan_kfree_large(const void *ptr)
 	kmsan_enter_runtime();
 	page = virt_to_head_page((void *)ptr);
 	KMSAN_WARN_ON(ptr != page_address(page));
-	kmsan_internal_poison_memory((void *)ptr, page_size(page), GFP_KERNEL,
+	kmsan_internal_poison_memory((void *)ptr, page_size(page),
+				     GFP_KERNEL & ~(__GFP_RECLAIM),
 				     KMSAN_POISON_CHECK | KMSAN_POISON_FREE);
 	kmsan_leave_runtime();
 }
--- a/mm/kmsan/shadow.c~mm-kmsan-fix-kmsan-kmalloc-hook-when-no-stack-depots-are-allocated-yet
+++ a/mm/kmsan/shadow.c
@@ -208,7 +208,7 @@ void kmsan_free_page(struct page *page,
 		return;
 	kmsan_enter_runtime();
 	kmsan_internal_poison_memory(page_address(page), page_size(page),
-				     GFP_KERNEL,
+				     GFP_KERNEL & ~(__GFP_RECLAIM),
 				     KMSAN_POISON_CHECK | KMSAN_POISON_FREE);
 	kmsan_leave_runtime();
 }
_


