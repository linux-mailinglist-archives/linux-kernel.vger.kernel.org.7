Return-Path: <linux-kernel+bounces-826012-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 31E8BB8D550
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Sep 2025 07:45:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B3DF03B52EF
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Sep 2025 05:45:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D682126529B;
	Sun, 21 Sep 2025 05:45:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n+GIwKUZ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 384662737F6
	for <linux-kernel@vger.kernel.org>; Sun, 21 Sep 2025 05:45:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758433510; cv=none; b=RH6vtOTr+6BA1fqGFuH4yb7oYHrV4WFMqLoZnri4eONHywI2CsM5DssoscVztauwhIAr5Htj3ip+qDWE23ZzsCPl+l8dQor9K+GUaP4WylVGpKftsR/IU8pMjU9WMNxFNhZYw75IzYjlmhW7rE33hqxVIsqSFWHCYNGvU+39jbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758433510; c=relaxed/simple;
	bh=qKv5CzwLLtDXYj45Vz9NYuIeSEVLwG4QLtqMDnI6e28=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sMRPl0wyc2RL65Jdi9omJyNLezVOwpxSK+9Rt/8TiOXtxgTtoJcd/Nd1watdNtuI3c7aS96QuE5GOmtbPxBj/oE9J+BUNe+dhMi665+3B8ebf3IML8toKfVEoigGS5a0ewxwtxn/je0WysnPHLKTwjfkWw2o+A0NMnYEaUS4xyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n+GIwKUZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92B61C4CEF7;
	Sun, 21 Sep 2025 05:45:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758433509;
	bh=qKv5CzwLLtDXYj45Vz9NYuIeSEVLwG4QLtqMDnI6e28=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=n+GIwKUZiWi4CgoEKu3KIu0wCOseJatAQSLSbZrUrAd9QoU8dee7yMHTGBzMSl3ED
	 ghUNJKQmWMNsRQsovFspvdM74/loQb6s8wVAyzRVLnudXh9mi6Y9XAD4BTFIqTrpxV
	 YpM1FDAM8o9cVrU53BDIL8rEfMKrl3lifCqVMPTyMJMNm6vheOM0whKLPYEpG5SKzJ
	 9WwAHXW99DNpa7Mnab+L4PVv6op2Lmf1qcubLtxBjpv2xAQeajXVNojqll7cN0T3pX
	 Dv7AmV7DMnJJuGJ0nmafCjjorQFg5WhjF1blob4QalpCms1ubzOs2Ozz77S1JYfXRf
	 iGTaBzeol9Tbw==
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
Subject: [PATCH v5 1/4] kho: check if kho is finalized in __kho_preserve_order()
Date: Sun, 21 Sep 2025 08:44:55 +0300
Message-ID: <20250921054458.4043761-2-rppt@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250921054458.4043761-1-rppt@kernel.org>
References: <20250921054458.4043761-1-rppt@kernel.org>
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
Reviewed-by: Pratyush Yadav <pratyush@kernel.org>
---
 kernel/kexec_handover.c | 55 +++++++++++++++++++----------------------
 1 file changed, 26 insertions(+), 29 deletions(-)

diff --git a/kernel/kexec_handover.c b/kernel/kexec_handover.c
index 555488eb1a18..85f1bf38b123 100644
--- a/kernel/kexec_handover.c
+++ b/kernel/kexec_handover.c
@@ -107,6 +107,29 @@ struct kho_serialization {
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
@@ -165,6 +188,9 @@ static int __kho_preserve_order(struct kho_mem_track *track, unsigned long pfn,
 
 	might_sleep();
 
+	if (kho_out.finalized)
+		return -EBUSY;
+
 	physxa = xa_load(&track->orders, order);
 	if (!physxa) {
 		int err;
@@ -667,29 +693,6 @@ int kho_add_subtree(struct kho_serialization *ser, const char *name, void *fdt)
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
@@ -717,9 +720,6 @@ int kho_preserve_folio(struct folio *folio)
 	const unsigned int order = folio_order(folio);
 	struct kho_mem_track *track = &kho_out.ser.track;
 
-	if (kho_out.finalized)
-		return -EBUSY;
-
 	return __kho_preserve_order(track, pfn, order);
 }
 EXPORT_SYMBOL_GPL(kho_preserve_folio);
@@ -743,9 +743,6 @@ int kho_preserve_phys(phys_addr_t phys, size_t size)
 	int err = 0;
 	struct kho_mem_track *track = &kho_out.ser.track;
 
-	if (kho_out.finalized)
-		return -EBUSY;
-
 	if (!PAGE_ALIGNED(phys) || !PAGE_ALIGNED(size))
 		return -EINVAL;
 
-- 
2.50.1


