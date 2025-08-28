Return-Path: <linux-kernel+bounces-790406-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 54D83B3A6A9
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 18:42:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A85AC18879FB
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 16:41:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AFD3248F72;
	Thu, 28 Aug 2025 16:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="baOz2Z00"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52BF41EEA49
	for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 16:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756399158; cv=none; b=Zx+wyHAMlFhHhHOjCeLx6flmoVXN4pcsRLxU9mfU+LW0YzYiKXqBLstPCz6SAi/7JDQsbDoLWm9CzlOEc5+YlY9Qyc+0Zne3rQCC830OLPgFc4xTdhv9iuOyQ0m44phX3o7jcwEODNJbVma2VqbTm5z+ntdefYBPg78dk0bhSWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756399158; c=relaxed/simple;
	bh=0bIrfHHvdndRjxfSe82hZYDrXd8C517S0JeqnePV9n4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JYaaiIPqEWkZhMsqIz+Tr2vR4hJtHAVUvsoH+acJEptaZDBg4yLJKfvK3h5vfXO+nktjcH+RUDdibv7lgaEJl4j+2nLVqep5kQO4Qa8vQrbr4vn6XL9YAXF1teimVkLwp7spsnsX3dCWz1Ob6cu69ulDUDNTC9Jf1BRtR17kOMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=baOz2Z00; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6481C4CEEB;
	Thu, 28 Aug 2025 16:39:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756399155;
	bh=0bIrfHHvdndRjxfSe82hZYDrXd8C517S0JeqnePV9n4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=baOz2Z00VcExfEIm8pFmHSW/W54UqYkfu7WwDgA8MZJ7mHYql6x8p/aw875eZ6a3z
	 HSZiDfm8Y4qWlsTVji6/oYcVodVlnmusXpzJAzYCvkrhZrjEpQYlrw1hQUI8sLSQB1
	 e+IYpCouV432ekjDknSZmqjWmYBMXVtvENipdi1iGFgXBgg4FoAXzjxuET6a+iKJiA
	 yB5ZFFDC5/bsxHPGD18DPidUfJX+AEHo5iXOi1x8MMypZ2a7mC+pMtIVyOd6wsUIeI
	 UD5+U6b0L4WGkJnAfui35HVyUSbapyhCLeFuoJL3/4N6OjMFXHvoSALUZeKy+zo6vR
	 E4ODLC18G/JEQ==
From: SeongJae Park <sj@kernel.org>
To: Chris Li <chrisl@kernel.org>
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Chengming Zhou <chengming.zhou@linux.dev>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Nhat Pham <nphamcs@gmail.com>,
	Yosry Ahmed <yosry.ahmed@linux.dev>,
	kernel-team@meta.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	Takero Funaki <flintglass@gmail.com>,
	David Hildenbrand <david@redhat.com>,
	Baoquan He <bhe@redhat.com>,
	Barry Song <baohua@kernel.org>,
	Kairui Song <kasong@tencent.com>
Subject: Re: [PATCH v5] mm/zswap: store <PAGE_SIZE compression failed page as-is
Date: Thu, 28 Aug 2025 09:39:13 -0700
Message-Id: <20250828163913.57957-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <CACePvbXnaWZh61aH=BHoGDqbKvBSE52Me+PpE-WMXcGpRy0FFw@mail.gmail.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Wed, 27 Aug 2025 14:16:37 -0700 Chris Li <chrisl@kernel.org> wrote:

> On Wed, Aug 27, 2025 at 10:45 AM SeongJae Park <sj@kernel.org> wrote:
[...]
> Anyway, I just opened the editor to check again. Yes, if we goto the
> read_done, the if condition using dlen can introduce a new incoming
> edge that has len uninitialized value to be used. Yes, need to
> initialize dlen = PAGE_SIZE or you initialize it at the memcpy of
> page.

Thank you for confirming.

> 
> > I will post the fixup by tomorrow morning (Pacific time) unless I
> > hear other opinions or find my mistakes on the above plan by tonight.
> 
> You are too humble, that is the normal reviewing process. You can take
> your time.

No worry, I just wanted to give you an expectation of the time line :)

Andrew, could you please pick the below attached cleanup patch as a fixup of
the original patch?  Please feel free to let me know if you prefer posting a
new version of the patch instead or any other approach.


Thanks,
SJ

[...]

==== Attachment 0 (0001-mm-zswap-cleanup-incompressible-pages-handling-code.patch) ====
From 867c3789fa80ac163427f1d7804bf2c8667684ca Mon Sep 17 00:00:00 2001
From: SeongJae Park <sj@kernel.org>
Date: Wed, 27 Aug 2025 13:18:38 -0700
Subject: [PATCH] mm/zswap: cleanup incompressible pages handling code

Following Chris Li's suggestions[1], make the code easier to read and
manage.

[1] https://lore.kernel.org/CACePvbWGPApYr7G29FzbmWzRw-BJE39WH7kUHSaHs+Lnw8=-qQ@mail.gmail.com

Signed-off-by: SeongJae Park <sj@kernel.org>
Acked-by: Chris Li <chrisl@kernel.org>
---
 mm/zswap.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/mm/zswap.c b/mm/zswap.c
index f865a930dc88..e5e1f5687f5e 100644
--- a/mm/zswap.c
+++ b/mm/zswap.c
@@ -952,6 +952,7 @@ static bool zswap_compress(struct page *page, struct zswap_entry *entry,
 	struct zpool *zpool;
 	gfp_t gfp;
 	u8 *dst;
+	bool mapped = false;
 
 	acomp_ctx = acomp_ctx_get_cpu_lock(pool);
 	dst = acomp_ctx->buffer;
@@ -983,9 +984,8 @@ static bool zswap_compress(struct page *page, struct zswap_entry *entry,
 	 * only adds metadata overhead.  swap_writeout() will put the page back
 	 * to the active LRU list in the case.
 	 */
-	if (comp_ret || !dlen)
+	if (comp_ret || !dlen || dlen >= PAGE_SIZE) {
 		dlen = PAGE_SIZE;
-	if (dlen >= PAGE_SIZE) {
 		if (!mem_cgroup_zswap_writeback_enabled(
 					folio_memcg(page_folio(page)))) {
 			comp_ret = comp_ret ? comp_ret : -EINVAL;
@@ -994,6 +994,7 @@ static bool zswap_compress(struct page *page, struct zswap_entry *entry,
 		comp_ret = 0;
 		dlen = PAGE_SIZE;
 		dst = kmap_local_page(page);
+		mapped = true;
 	}
 
 	zpool = pool->zpool;
@@ -1007,7 +1008,7 @@ static bool zswap_compress(struct page *page, struct zswap_entry *entry,
 	entry->length = dlen;
 
 unlock:
-	if (dst != acomp_ctx->buffer)
+	if (mapped)
 		kunmap_local(dst);
 	if (comp_ret == -ENOSPC || alloc_ret == -ENOSPC)
 		zswap_reject_compress_poor++;
@@ -1025,7 +1026,7 @@ static bool zswap_decompress(struct zswap_entry *entry, struct folio *folio)
 	struct zpool *zpool = entry->pool->zpool;
 	struct scatterlist input, output;
 	struct crypto_acomp_ctx *acomp_ctx;
-	int decomp_ret, dlen;
+	int decomp_ret = 0, dlen = PAGE_SIZE;
 	u8 *src, *obj;
 
 	acomp_ctx = acomp_ctx_get_cpu_lock(entry->pool);
@@ -1034,9 +1035,7 @@ static bool zswap_decompress(struct zswap_entry *entry, struct folio *folio)
 	/* zswap entries of length PAGE_SIZE are not compressed. */
 	if (entry->length == PAGE_SIZE) {
 		memcpy_to_folio(folio, 0, obj, entry->length);
-		zpool_obj_read_end(zpool, entry->handle, obj);
-		acomp_ctx_put_unlock(acomp_ctx);
-		return true;
+		goto read_done;
 	}
 
 	/*
@@ -1059,6 +1058,7 @@ static bool zswap_decompress(struct zswap_entry *entry, struct folio *folio)
 	decomp_ret = crypto_wait_req(crypto_acomp_decompress(acomp_ctx->req), &acomp_ctx->wait);
 	dlen = acomp_ctx->req->dlen;
 
+read_done:
 	zpool_obj_read_end(zpool, entry->handle, obj);
 	acomp_ctx_put_unlock(acomp_ctx);
 
-- 
2.39.5


