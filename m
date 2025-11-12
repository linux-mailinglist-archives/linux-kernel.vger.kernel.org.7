Return-Path: <linux-kernel+bounces-896876-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F150FC51650
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 10:40:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 69C88188F596
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 09:39:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFD7D2FD7D8;
	Wed, 12 Nov 2025 09:38:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iCk9qBeY"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5140926CE04
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 09:38:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762940321; cv=none; b=nDS7XD9RE3ZKk9aq/1P3ibd6rFIWwTnkt+eJ59mFha/V78Zqh4t9+d3TBREkcf8jYC2nkqNKecHli6KV88FHm2gdE7BNV5Wh8MbCAWLimNqqX8BM7TWpBP+ILRvVpwQALPiQ2IdShUrEj8PYwrkaTaRZpyM0C8hLHuEP9sp6LSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762940321; c=relaxed/simple;
	bh=n+Gy/q1ZghdzRPER0WHQj+R4RyDqTABKPYlxa+KTZpE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XsQJ9MD3ysKbhuHRfrmebvHQeYMzBx8sy16i0/b0DLkbgYRbuaCwRhHlP7sJwvculm38/DGJn9xxFzZmBBSKMgJeMyudceqaU8Y+u5Hhnvgkn7StZHxtVJoivFnpIur+gubd2psnD1TYs0TqjAbAEFlwUIXwgssfRd94wswhj8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iCk9qBeY; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762940318;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Cepd6WU4kopEaHk/zWZiU+KNb4Y7n9nNigJMeAdOfi4=;
	b=iCk9qBeYW1lxbHL03qVm1Lu0g5gnffzQDwalKp4txSkX/CAGyFBvC3CiUWJVqpHdqHngim
	NsASmpV8dVss0aDLlrrc0sAPl8wEoChUCTJI24nEGHpd+V3dgq0ZKyj0UjZhK/KBq3ejjY
	0ruUe19aUU8Gpk/LTPd5ULzi9jXE2+E=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-112-R7ByYcyAMdWGvtfupXNz7g-1; Wed,
 12 Nov 2025 04:38:36 -0500
X-MC-Unique: R7ByYcyAMdWGvtfupXNz7g-1
X-Mimecast-MFC-AGG-ID: R7ByYcyAMdWGvtfupXNz7g_1762940315
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 198C018002CA;
	Wed, 12 Nov 2025 09:38:35 +0000 (UTC)
Received: from localhost (unknown [10.72.116.179])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id CDDC630044E0;
	Wed, 12 Nov 2025 09:38:32 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Caleb Sander Mateos <csander@purestorage.com>,
	Uday Shankar <ushankar@purestorage.com>,
	Ming Lei <ming.lei@redhat.com>,
	Stefani Seibold <stefani@seibold.net>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH V3 01/27] kfifo: add kfifo_alloc_node() helper for NUMA awareness
Date: Wed, 12 Nov 2025 17:37:39 +0800
Message-ID: <20251112093808.2134129-2-ming.lei@redhat.com>
In-Reply-To: <20251112093808.2134129-1-ming.lei@redhat.com>
References: <20251112093808.2134129-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

Add __kfifo_alloc_node() by refactoring and reusing __kfifo_alloc(),
and define kfifo_alloc_node() macro to support NUMA-aware memory
allocation.

The new __kfifo_alloc_node() function accepts a NUMA node parameter
and uses kmalloc_array_node() instead of kmalloc_array() for
node-specific allocation. The existing __kfifo_alloc() now calls
__kfifo_alloc_node() with NUMA_NO_NODE to maintain backward
compatibility.

This enables users to allocate kfifo buffers on specific NUMA nodes,
which is important for performance in NUMA systems where the kfifo
will be primarily accessed by threads running on specific nodes.

Cc: Stefani Seibold <stefani@seibold.net>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 include/linux/kfifo.h | 27 +++++++++++++++++++++++++++
 lib/kfifo.c           | 13 ++++++++++---
 2 files changed, 37 insertions(+), 3 deletions(-)

diff --git a/include/linux/kfifo.h b/include/linux/kfifo.h
index fd743d4c4b4b..61d1fe014a6c 100644
--- a/include/linux/kfifo.h
+++ b/include/linux/kfifo.h
@@ -369,6 +369,30 @@ __kfifo_int_must_check_helper( \
 }) \
 )
 
+/**
+ * kfifo_alloc_node - dynamically allocates a new fifo buffer on a NUMA node
+ * @fifo: pointer to the fifo
+ * @size: the number of elements in the fifo, this must be a power of 2
+ * @gfp_mask: get_free_pages mask, passed to kmalloc()
+ * @node: NUMA node to allocate memory on
+ *
+ * This macro dynamically allocates a new fifo buffer with NUMA node awareness.
+ *
+ * The number of elements will be rounded-up to a power of 2.
+ * The fifo will be release with kfifo_free().
+ * Return 0 if no error, otherwise an error code.
+ */
+#define kfifo_alloc_node(fifo, size, gfp_mask, node) \
+__kfifo_int_must_check_helper( \
+({ \
+	typeof((fifo) + 1) __tmp = (fifo); \
+	struct __kfifo *__kfifo = &__tmp->kfifo; \
+	__is_kfifo_ptr(__tmp) ? \
+	__kfifo_alloc_node(__kfifo, size, sizeof(*__tmp->type), gfp_mask, node) : \
+	-EINVAL; \
+}) \
+)
+
 /**
  * kfifo_free - frees the fifo
  * @fifo: the fifo to be freed
@@ -902,6 +926,9 @@ __kfifo_uint_must_check_helper( \
 extern int __kfifo_alloc(struct __kfifo *fifo, unsigned int size,
 	size_t esize, gfp_t gfp_mask);
 
+extern int __kfifo_alloc_node(struct __kfifo *fifo, unsigned int size,
+	size_t esize, gfp_t gfp_mask, int node);
+
 extern void __kfifo_free(struct __kfifo *fifo);
 
 extern int __kfifo_init(struct __kfifo *fifo, void *buffer,
diff --git a/lib/kfifo.c b/lib/kfifo.c
index a8b2eed90599..195cf0feecc2 100644
--- a/lib/kfifo.c
+++ b/lib/kfifo.c
@@ -22,8 +22,8 @@ static inline unsigned int kfifo_unused(struct __kfifo *fifo)
 	return (fifo->mask + 1) - (fifo->in - fifo->out);
 }
 
-int __kfifo_alloc(struct __kfifo *fifo, unsigned int size,
-		size_t esize, gfp_t gfp_mask)
+int __kfifo_alloc_node(struct __kfifo *fifo, unsigned int size,
+		size_t esize, gfp_t gfp_mask, int node)
 {
 	/*
 	 * round up to the next power of 2, since our 'let the indices
@@ -41,7 +41,7 @@ int __kfifo_alloc(struct __kfifo *fifo, unsigned int size,
 		return -EINVAL;
 	}
 
-	fifo->data = kmalloc_array(esize, size, gfp_mask);
+	fifo->data = kmalloc_array_node(esize, size, gfp_mask, node);
 
 	if (!fifo->data) {
 		fifo->mask = 0;
@@ -51,6 +51,13 @@ int __kfifo_alloc(struct __kfifo *fifo, unsigned int size,
 
 	return 0;
 }
+EXPORT_SYMBOL(__kfifo_alloc_node);
+
+int __kfifo_alloc(struct __kfifo *fifo, unsigned int size,
+		size_t esize, gfp_t gfp_mask)
+{
+	return __kfifo_alloc_node(fifo, size, esize, gfp_mask, NUMA_NO_NODE);
+}
 EXPORT_SYMBOL(__kfifo_alloc);
 
 void __kfifo_free(struct __kfifo *fifo)
-- 
2.47.0


