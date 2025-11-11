Return-Path: <linux-kernel+bounces-895545-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ED9CBC4E409
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 14:56:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3DA773B0226
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 13:54:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D5BF359703;
	Tue, 11 Nov 2025 13:53:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="yMasYjzu"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68B2535A137
	for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 13:53:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762869220; cv=none; b=T1wmVabDbs7v/jwkY05SHhjAY5jtElZzL5vxTxH8zZ026KqTubbxNOtlw+wc44czjtgWGgpiQmbaliK0W6efqPwLVuSWxf0qXM0DoAcmUuWPWWbU3QnrZ4lj2q6OM85Svmn/+TeqmjF9eat+evC1EsoqN5hOBauZNsRRcBAoIRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762869220; c=relaxed/simple;
	bh=jAGTp4DCAtnLFIH+G1gVEgmLeE3alkJjImptY/EIsD4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YQk8JKZR1SoDo2UII1XoIZ2rl2IRswXYu3B+eYiSCQfWkl6jZq1EzXBVUbBlhoK8N5VP70JFX9nDTppFSCSrzvnhLGQBPx9aNHo5hmIOO7a7L223Np/dJeyJeABCWt8jE8ZvtwGN02+E/4nsaJAC7C9rhhzoJ6s+LZoootQlDfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=yMasYjzu; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=/l9Hdn5bqG50yE8Iq7CCW/03Z6STb0lgI5QBSkVDgR4=; b=yMasYjzuWp173oMums2Wv1+XOh
	Rwj6mMgOVRRmUN/7Thitzct40xTKrIrKh9ZaD8JyLn2wH3ZWhJVsGoL/wT0YdjlVTRs6R+pmM/jsZ
	Jf4SEbFf42Q6zY5CdbjlBZwTkrcnJoYnPr9ii/rBw9FNgkVMIPhY4QE2gGsZyCTzB0Oeyk6+l7Dqy
	t7fItH5E1JfwMY/r/qPzdMRxgcpLLEJ2TbdMLnNYHQQAv1Nygat3LM5QAFo9awGLn2hc9Ou49c/iA
	ugxTJWY8Ck0DnIV0sNWJF1CKI8v/SNDQgSLtGAVYOaJgzZMzcedJemVWcqr5WWvKOUyhnOcOqhP9r
	tGmoJfHA==;
Received: from 2a02-8389-2341-5b80-d601-7564-c2e0-491c.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:d601:7564:c2e0:491c] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vIooS-00000007Gda-3Jnd;
	Tue, 11 Nov 2025 13:53:37 +0000
From: Christoph Hellwig <hch@lst.de>
To: Vlastimil Babka <vbabka@suse.cz>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: Christoph Lameter <cl@gentwo.org>,
	David Rientjes <rientjes@google.com>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Harry Yoo <harry.yoo@oracle.com>,
	Eric Biggers <ebiggers@kernel.org>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 6/7] mempool: fix a wakeup race when sleeping for elements
Date: Tue, 11 Nov 2025 14:52:34 +0100
Message-ID: <20251111135300.752962-7-hch@lst.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251111135300.752962-1-hch@lst.de>
References: <20251111135300.752962-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Waiters always need to re-check their condition after adding themselves
to the waitqueue, as otherwise they might miss a wakeup.  Check
for elements in the pool and use them before going to sleep.

The workaround mentioned was probably due to this, but seems genuinely
useful for other reasons, so keep it and update the comment describing
it.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 mm/mempool.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/mm/mempool.c b/mm/mempool.c
index 850362f4ca7a..8cf3b5705b7f 100644
--- a/mm/mempool.c
+++ b/mm/mempool.c
@@ -388,6 +388,7 @@ static void *mempool_alloc_from_pool(struct mempool *pool, gfp_t gfp_mask)
 	spin_lock_irqsave(&pool->lock, flags);
 	if (unlikely(!pool->curr_nr))
 		goto fail;
+alloc:
 	element = remove_element(pool);
 	spin_unlock_irqrestore(&pool->lock, flags);
 
@@ -406,13 +407,17 @@ static void *mempool_alloc_from_pool(struct mempool *pool, gfp_t gfp_mask)
 		DEFINE_WAIT(wait);
 
 		prepare_to_wait(&pool->wait, &wait, TASK_UNINTERRUPTIBLE);
+		if (pool->curr_nr) {
+			finish_wait(&pool->wait, &wait);
+			goto alloc;
+		}
 		spin_unlock_irqrestore(&pool->lock, flags);
 
 		/*
-		 * Wait for someone else to return an element to @pool.
-		 *
-		 * FIXME: this should be io_schedule().  The timeout is there as
-		 * a workaround for some DM problems in 2.6.18.
+		 * Wait for someone else to return an element to @pool, but wake
+		 * up occasionally as memory pressure might have reduced even
+		 * and the normal allocation in alloc_fn could succeed even if
+		 * no element was returned.
 		 */
 		io_schedule_timeout(5 * HZ);
 		finish_wait(&pool->wait, &wait);
-- 
2.47.3


