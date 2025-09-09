Return-Path: <linux-kernel+bounces-808448-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 515C4B4FFD3
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 16:45:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 635014E2D59
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 14:45:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F053E350826;
	Tue,  9 Sep 2025 14:44:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t5MFgw81"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52FF3352FE5
	for <linux-kernel@vger.kernel.org>; Tue,  9 Sep 2025 14:44:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757429087; cv=none; b=M5fGCV/sBdfhh4+LT8HPRaCkwyr/19hHRoKW0cOnGkrwVKwV3eWpfGaQHpOeEoT2bBENTyQ9hWQJK/TZJfnqnYWhM2yyAGwXiZhgh5mqtscVG9g3+nuAJ34rekrEzYAOy18W5OslkycuqdO3nubGewuCoBbYfnjsKMcASbjU9w4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757429087; c=relaxed/simple;
	bh=5rpwGu8/al+jSPVVDiN+aC7cVtsur+Qn+e55fU0YUFo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sekr6nLwOTRaBnDSkj8zw/CnwaMHrXSq9VE+ofs3CccWtz0EFCtqURn3TySjZXFXHWJIuUpSlZ134Ki2jyWn923YzKLni1paOZwvyzfu335LeNfKnjnkhKwtxy78suC12qyvEheOqm8wpoXKYbBlT5hqLRG467v3unouq06bmOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t5MFgw81; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB53FC4CEF7;
	Tue,  9 Sep 2025 14:44:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757429086;
	bh=5rpwGu8/al+jSPVVDiN+aC7cVtsur+Qn+e55fU0YUFo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=t5MFgw81ctwGvYwePgn0tk5D0dAPf1flnsty/cI4NL15pvNkly5f8OUHdx9B9NQgf
	 WZkofDjZ9wOKpW0h5ohIT89geDptp4SKbq7w9YRCuPU8NxKrYxIsLAtFxDzgdC+RIe
	 AnSgoxvyjnsn2jVvpvy2Tn/DXkjKYhcFjRaRC60S9rdwSO7H/cbFpzkOVyZanvL4QQ
	 fQV8/JgmbtLt6mz2D39P+y2IM65bbjWQ4kn7wwKDq6Q/OA42Za2LuhQyHmjSieIUr6
	 vbJ1HMhsZeme3QsIhuwq2edA+jBSUjkQq4fJ9GZF0FojJgMBKRoGqZjcAAFTUcmAa7
	 /MNRrfJy5mnrw==
From: Pratyush Yadav <pratyush@kernel.org>
To: Alexander Graf <graf@amazon.com>,
	Mike Rapoport <rppt@kernel.org>,
	Changyuan Lyu <changyuanl@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Baoquan He <bhe@redhat.com>,
	Pratyush Yadav <pratyush@kernel.org>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Jason Gunthorpe <jgg@nvidia.com>,
	=?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>,
	Chris Li <chrisl@kernel.org>,
	Jason Miu <jasonmiu@google.com>,
	David Matlack <dmatlack@google.com>,
	David Rientjes <rientjes@google.com>
Cc: linux-kernel@vger.kernel.org,
	kexec@lists.infradead.org,
	linux-mm@kvack.org
Subject: [RFC PATCH 4/4] lib/test_kho: use kho_preserve_vmalloc instead of storing addresses in fdt
Date: Tue,  9 Sep 2025 16:44:24 +0200
Message-ID: <20250909144426.33274-5-pratyush@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250909144426.33274-1-pratyush@kernel.org>
References: <20250909144426.33274-1-pratyush@kernel.org>
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
[pratyush@kernel.org: use the KHO-array version of kho_restore_vmalloc()]
Signed-off-by: Pratyush Yadav <pratyush@kernel.org>
---
 lib/test_kho.c | 30 +++++++++++++++++++++++-------
 1 file changed, 23 insertions(+), 7 deletions(-)

diff --git a/lib/test_kho.c b/lib/test_kho.c
index c2eb899c3b456..3f4cb39cd917e 100644
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
@@ -67,14 +68,18 @@ static struct notifier_block kho_test_nb = {
 
 static int kho_test_save_data(struct kho_test_state *state, void *fdt)
 {
+	struct kho_vmalloc folios_info_preservation = {};
 	phys_addr_t *folios_info __free(kvfree) = NULL;
 	int err = 0;
 
-	folios_info = kvmalloc_array(state->nr_folios, sizeof(*folios_info),
-				     GFP_KERNEL);
+	folios_info = vmalloc_array(state->nr_folios, sizeof(*folios_info));
 	if (!folios_info)
 		return -ENOMEM;
 
+	err = kho_preserve_vmalloc(folios_info, &folios_info_preservation);
+	if (err)
+		return err;
+
 	for (int i = 0; i < state->nr_folios; i++) {
 		struct folio *folio = state->folios[i];
 		unsigned int order = folio_order(folio);
@@ -89,11 +94,14 @@ static int kho_test_save_data(struct kho_test_state *state, void *fdt)
 	err |= fdt_begin_node(fdt, "data");
 	err |= fdt_property(fdt, "nr_folios", &state->nr_folios,
 			    sizeof(state->nr_folios));
-	err |= fdt_property(fdt, "folios_info", folios_info,
-			    state->nr_folios * sizeof(*folios_info));
+	err |= fdt_property(fdt, "folios_info", &folios_info_preservation,
+			    sizeof(folios_info_preservation));
 	err |= fdt_property(fdt, "csum", &state->csum, sizeof(state->csum));
 	err |= fdt_end_node(fdt);
 
+	if (!err)
+		state->folios_info = no_free_ptr(folios_info);
+
 	return err;
 }
 
@@ -197,7 +205,8 @@ static int kho_test_save(void)
 static int kho_test_restore_data(const void *fdt, int node)
 {
 	const unsigned int *nr_folios;
-	const phys_addr_t *folios_info;
+	const struct kho_vmalloc *folios_info_preservation;
+	phys_addr_t *folios_info;
 	const __wsum *old_csum;
 	__wsum csum = 0;
 	int len;
@@ -212,8 +221,12 @@ static int kho_test_restore_data(const void *fdt, int node)
 	if (!old_csum || len != sizeof(*old_csum))
 		return -EINVAL;
 
-	folios_info = fdt_getprop(fdt, node, "folios_info", &len);
-	if (!folios_info || len != sizeof(*folios_info) * *nr_folios)
+	folios_info_preservation = fdt_getprop(fdt, node, "folios_info", &len);
+	if (!folios_info_preservation || len != sizeof(*folios_info_preservation))
+		return -EINVAL;
+
+	folios_info = kho_restore_vmalloc((struct kho_vmalloc *)folios_info_preservation);
+	if (!folios_info)
 		return -EINVAL;
 
 	for (int i = 0; i < *nr_folios; i++) {
@@ -233,6 +246,8 @@ static int kho_test_restore_data(const void *fdt, int node)
 		folio_put(folio);
 	}
 
+	vfree(folios_info);
+
 	if (csum != *old_csum)
 		return -EINVAL;
 
@@ -291,6 +306,7 @@ static void kho_test_cleanup(void)
 		folio_put(kho_test_state.folios[i]);
 
 	kvfree(kho_test_state.folios);
+	vfree(kho_test_state.folios_info);
 }
 
 static void __exit kho_test_exit(void)
-- 
2.47.3


