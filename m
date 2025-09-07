Return-Path: <linux-kernel+bounces-804549-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A7701B47946
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Sep 2025 09:01:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9E41916386A
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Sep 2025 07:01:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B56C1F3BB5;
	Sun,  7 Sep 2025 07:00:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HEZKwHsm"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78818202C2B
	for <linux-kernel@vger.kernel.org>; Sun,  7 Sep 2025 07:00:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757228447; cv=none; b=hCkxlu1LfDqSgkwyCfTRjZsyT4BCgCAtH6DRLP6h1ym6YMwjKq3BgEPquOSesu/Qsf1mBn/qcdPYi8EMGGmnomR1mjTgEm+ndhMFNkzQCBR1NJgDaQpYIdb8nqD3S4hL5sLkVCZ9uUVspLR46KFlI1lom57BQyHT9FGEScmuoL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757228447; c=relaxed/simple;
	bh=S6cq5Fd+Tt7edEdfLD7ze+ZKtAEEGtzWPj0q1zSXPO4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=p7aH7QP+47AOtBi+VdxV+w59DIrWe8yBuv6C2sxBb4DRTsqp8oySU5ZgM/FaffbDgP4x8wHHuabKeSwh7k9xm3F2STeX9GumQYvYBPSWQLeEK2Ilo9dSdtMOIiTy+VldsmstU33DZZeRr2uJkgbJ7sEA1CTmsb1c1VW5QHQHCoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HEZKwHsm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2ADDC4CEFB;
	Sun,  7 Sep 2025 07:00:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757228447;
	bh=S6cq5Fd+Tt7edEdfLD7ze+ZKtAEEGtzWPj0q1zSXPO4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HEZKwHsmg+QtBW5UFiuYs26fucUIr6wGXLeddggrTHC9Qgqatmc8T374QZ/+Eg7eN
	 3Cp2tnZpsbMiwBTqNfFboEAuvBqaFsEi2cwjiokLUKJf+eiR/hyZKhyERzjaRZiqKO
	 qWcUlZigxroFfPXhC2aRs9Liyf/KGq+idNdgxbi4uUL7csesh9HXkeB1uckoUz3h3N
	 oXUjzf1vww1oWvfB9l4KyHTe1abGjyAtQxaTXgFwnA3jM3KpdfipijBM6BFPCW5uo0
	 Asp36UxHGNj9ZisfH32xiFhzIDbj06EjDDQfURoMxacHCdyPXEaApf5f8glSSLDeCf
	 Lsnk/dTM0xRVg==
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
Subject: [PATCH v3 2/2] lib/test_kho: use kho_preserve_vmalloc instead of storing addresses in fdt
Date: Sun,  7 Sep 2025 10:00:22 +0300
Message-ID: <20250907070022.2177974-6-rppt@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250907070022.2177974-1-rppt@kernel.org>
References: <20250907070022.2177974-1-rppt@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>

KHO test stores physical addresses of the preserved folios directly in
fdt.
Use kho_preserve_vmalloc() instead of it and kho_restore_vmalloc() to
retrieve the addresses after kexec.

This makes the test more scalable from one side and adds tests coverage
for kho_preserve_vmalloc() from the other.

Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
---
 lib/test_kho.c | 41 +++++++++++++++++++++++++++++------------
 1 file changed, 29 insertions(+), 12 deletions(-)

diff --git a/lib/test_kho.c b/lib/test_kho.c
index fe8504e3407b..c46f577b6aee 100644
--- a/lib/test_kho.c
+++ b/lib/test_kho.c
@@ -32,6 +32,7 @@ module_param(max_mem, long, 0644);
 struct kho_test_state {
 	unsigned int nr_folios;
 	struct folio **folios;
+	phys_addr_t *folios_info;
 	struct folio *fdt;
 	__wsum csum;
 };
@@ -67,18 +68,15 @@ static struct notifier_block kho_test_nb = {
 
 static int kho_test_save_data(struct kho_test_state *state, void *fdt)
 {
-	phys_addr_t *folios_info;
+	phys_addr_t *folios_info __free(kvfree) = NULL;
+	phys_addr_t folios_info_phys;
 	int err = 0;
 
-	err |= fdt_begin_node(fdt, "data");
-	err |= fdt_property(fdt, "nr_folios", &state->nr_folios,
-			    sizeof(state->nr_folios));
-	err |= fdt_property_placeholder(fdt, "folios_info",
-					state->nr_folios * sizeof(*folios_info),
-					(void **)&folios_info);
-	err |= fdt_property(fdt, "csum", &state->csum, sizeof(state->csum));
-	err |= fdt_end_node(fdt);
+	folios_info = vmalloc_array(state->nr_folios, sizeof(*folios_info));
+	if (!folios_info)
+		return -ENOMEM;
 
+	err = kho_preserve_vmalloc(folios_info, &folios_info_phys);
 	if (err)
 		return err;
 
@@ -93,6 +91,17 @@ static int kho_test_save_data(struct kho_test_state *state, void *fdt)
 			break;
 	}
 
+	err |= fdt_begin_node(fdt, "data");
+	err |= fdt_property(fdt, "nr_folios", &state->nr_folios,
+			    sizeof(state->nr_folios));
+	err |= fdt_property(fdt, "folios_info", &folios_info_phys,
+			    sizeof(folios_info_phys));
+	err |= fdt_property(fdt, "csum", &state->csum, sizeof(state->csum));
+	err |= fdt_end_node(fdt);
+
+	if (!err)
+		state->folios_info = no_free_ptr(folios_info);
+
 	return err;
 }
 
@@ -210,7 +219,8 @@ static int kho_test_save(void)
 static int kho_test_restore_data(const void *fdt, int node)
 {
 	const unsigned int *nr_folios;
-	const phys_addr_t *folios_info;
+	const phys_addr_t *folios_info_phys;
+	phys_addr_t *folios_info;
 	const __wsum *old_csum;
 	__wsum csum = 0;
 	int len;
@@ -225,8 +235,12 @@ static int kho_test_restore_data(const void *fdt, int node)
 	if (!old_csum || len != sizeof(*old_csum))
 		return -EINVAL;
 
-	folios_info = fdt_getprop(fdt, node, "folios_info", &len);
-	if (!folios_info || len != sizeof(*folios_info) * *nr_folios)
+	folios_info_phys = fdt_getprop(fdt, node, "folios_info", &len);
+	if (!folios_info_phys || len != sizeof(*folios_info_phys))
+		return -EINVAL;
+
+	folios_info = kho_restore_vmalloc(*folios_info_phys);
+	if (!folios_info)
 		return -EINVAL;
 
 	for (int i = 0; i < *nr_folios; i++) {
@@ -246,6 +260,8 @@ static int kho_test_restore_data(const void *fdt, int node)
 		folio_put(folio);
 	}
 
+	vfree(folios_info);
+
 	if (csum != *old_csum)
 		return -EINVAL;
 
@@ -304,6 +320,7 @@ static void kho_test_cleanup(void)
 		folio_put(kho_test_state.folios[i]);
 
 	kvfree(kho_test_state.folios);
+	vfree(kho_test_state.folios_info);
 	folio_put(kho_test_state.fdt);
 }
 
-- 
2.50.1


