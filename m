Return-Path: <linux-kernel+bounces-821421-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 96834B81361
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 19:40:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6B85662512B
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 17:40:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 786A52FF661;
	Wed, 17 Sep 2025 17:40:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="imKc2B/G"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3DC827E040
	for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 17:40:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758130844; cv=none; b=WICbIulVYK+EuqPfMq3MfMGUE43Xfz6fyisQunZd+3Kfy72fbQQybZaiNjFYi1DZ3di2kbtLwwZfHDTKjoOgLywgwtOeJabPKMlMSyk/VJ6khXJILSYTNv0QUuXbbGIFHd/LqB5Wei8OI+/CRGkEvohTPJAcmywRrm69qm8zIq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758130844; c=relaxed/simple;
	bh=8S8e7n6CmQnQKabzKFlVH8Uaq/Xv4oQU9mDtf6delh4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=e+EPDHBzdoMCxr8ULkpMZMAGgP6iHuhu+kJLtr9K8epDnUosap5dkChKlBA3teSJ3SUKQchsO9fi+EcbmQA1plTdBgnMH2WrzqkdysyDLWu6Tbn23rCVSN/GTVwzHPzR/cGKik6uKM7TZ2mfnUpW+L/28pE/vb5mmx/IZ5CNttw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=imKc2B/G; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56019C4CEE7;
	Wed, 17 Sep 2025 17:40:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758130844;
	bh=8S8e7n6CmQnQKabzKFlVH8Uaq/Xv4oQU9mDtf6delh4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=imKc2B/Go7tqGnVzKJxq26RWe2jdsBf9Ed5PIKotck8RwFHLfGS0BBPjt8DjrQzwQ
	 PoZq1MNENH7vxNPLowth8cqCBY6VFfgrh/wMPvNHtXoc1QdyvzGZ8KBajL+RtHpAKH
	 BIqzDAu8/OgWWkBn++4a8QixTRL1Z/m4JEbIaMfM7i121nzr00gzHlLgQwfikkq8ZO
	 /7V0AUJnUyLyc32HBkNk+A9WDN+0OI8eYdqYYVDkT5cugq5KiRquwEcou1kuW/iU7K
	 1NOiI35NaZo02txKyCoqSbdnRtMfhvXTf4yEpXQS4PPwgGf9N6kV+jGCJhpSJ0ABX5
	 huHkkfAT7XbvA==
From: Mike Rapoport <rppt@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Alexander Graf <graf@amazon.com>,
	Baoquan He <bhe@redhat.com>,
	Changyuan Lyu <changyuanl@google.com>,
	Chris Li <chrisl@kernel.org>,
	Jason Gunthorpe <jgg@nvidia.com>,
	Mike Rapoport <rppt@kernel.org>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Pratyush Yadav <pratyush@kernel.org>,
	kexec@lists.infradead.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 1/4] kho: check if kho is finalized in __kho_preserve_order()
Date: Wed, 17 Sep 2025 20:40:30 +0300
Message-ID: <20250917174033.3810435-2-rppt@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250917174033.3810435-1-rppt@kernel.org>
References: <20250917174033.3810435-1-rppt@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>

Instead of checking if kho is finalized in each caller of
__kho_preserve_order(), do it in the core function itself.

Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
---
 kernel/kexec_handover.c | 55 +++++++++++++++++++----------------------
 1 file changed, 26 insertions(+), 29 deletions(-)

diff --git a/kernel/kexec_handover.c b/kernel/kexec_handover.c
index 8079fc4b9189..f421acc58c1f 100644
--- a/kernel/kexec_handover.c
+++ b/kernel/kexec_handover.c
@@ -91,6 +91,29 @@ struct kho_serialization {
 	struct khoser_mem_chunk *preserved_mem_map;
 };
 
+struct kho_out {
+	struct blocking_notifier_head chain_head;
+
+	struct dentry *dir;
+
+	struct mutex lock; /* protects KHO FDT finalization */
+
+	struct kho_serialization ser;
+	bool finalized;
+};
+
+static struct kho_out kho_out = {
+	.chain_head = BLOCKING_NOTIFIER_INIT(kho_out.chain_head),
+	.lock = __MUTEX_INITIALIZER(kho_out.lock),
+	.ser = {
+		.fdt_list = LIST_HEAD_INIT(kho_out.ser.fdt_list),
+		.track = {
+			.orders = XARRAY_INIT(kho_out.ser.track.orders, 0),
+		},
+	},
+	.finalized = false,
+};
+
 static void *xa_load_or_alloc(struct xarray *xa, unsigned long index, size_t sz)
 {
 	void *elm, *res;
@@ -149,6 +172,9 @@ static int __kho_preserve_order(struct kho_mem_track *track, unsigned long pfn,
 
 	might_sleep();
 
+	if (kho_out.finalized)
+		return -EBUSY;
+
 	physxa = xa_load(&track->orders, order);
 	if (!physxa) {
 		int err;
@@ -640,29 +666,6 @@ int kho_add_subtree(struct kho_serialization *ser, const char *name, void *fdt)
 }
 EXPORT_SYMBOL_GPL(kho_add_subtree);
 
-struct kho_out {
-	struct blocking_notifier_head chain_head;
-
-	struct dentry *dir;
-
-	struct mutex lock; /* protects KHO FDT finalization */
-
-	struct kho_serialization ser;
-	bool finalized;
-};
-
-static struct kho_out kho_out = {
-	.chain_head = BLOCKING_NOTIFIER_INIT(kho_out.chain_head),
-	.lock = __MUTEX_INITIALIZER(kho_out.lock),
-	.ser = {
-		.fdt_list = LIST_HEAD_INIT(kho_out.ser.fdt_list),
-		.track = {
-			.orders = XARRAY_INIT(kho_out.ser.track.orders, 0),
-		},
-	},
-	.finalized = false,
-};
-
 int register_kho_notifier(struct notifier_block *nb)
 {
 	return blocking_notifier_chain_register(&kho_out.chain_head, nb);
@@ -690,9 +693,6 @@ int kho_preserve_folio(struct folio *folio)
 	const unsigned int order = folio_order(folio);
 	struct kho_mem_track *track = &kho_out.ser.track;
 
-	if (kho_out.finalized)
-		return -EBUSY;
-
 	return __kho_preserve_order(track, pfn, order);
 }
 EXPORT_SYMBOL_GPL(kho_preserve_folio);
@@ -716,9 +716,6 @@ int kho_preserve_phys(phys_addr_t phys, size_t size)
 	int err = 0;
 	struct kho_mem_track *track = &kho_out.ser.track;
 
-	if (kho_out.finalized)
-		return -EBUSY;
-
 	if (!PAGE_ALIGNED(phys) || !PAGE_ALIGNED(size))
 		return -EINVAL;
 
-- 
2.50.1


