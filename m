Return-Path: <linux-kernel+bounces-802929-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C62E6B45882
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 15:13:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6FC0F1C26816
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 13:14:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C26C02EC543;
	Fri,  5 Sep 2025 13:13:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FGNTu275"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EFB02343BE
	for <linux-kernel@vger.kernel.org>; Fri,  5 Sep 2025 13:13:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757077997; cv=none; b=Z4KXJxl8rYQJSha+voxktWvg4C83qw5RlO2FSeOhAD6Z8qklKAaD8iegHSlbyeB4bAzDxSor38r4l7SxKEuIryR+Rqos+zTCgAiI8DLcJoMlBASMhNHePxzBBhG9JSsx0qi/n7/hIHrwDaYelTzHy7O620IG2mhG68rTT2WXN68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757077997; c=relaxed/simple;
	bh=C3NlxNYz6bfCABhEIee3Vq9GbnEKAONZKNFONpPiN3c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ip7KXUByEjZjV7OlE6koHG4uX79Ye6tj0fEbDxQneXjMRwrY49g6XlwuQFWbnJ/7u6wBXir26sB5NjbipkpywcnbqPSfNZg7hTWNPC0vNe+InpRHJcL/410JyA0E+5oaDW4mBlUPgknwTYOhAanDIHjJiPAyp4rTNJHq4FHPMDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FGNTu275; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9438FC4CEF5;
	Fri,  5 Sep 2025 13:13:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757077996;
	bh=C3NlxNYz6bfCABhEIee3Vq9GbnEKAONZKNFONpPiN3c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FGNTu275tZdPUVoHbM/gsRDrY9R4cZS7yNP3f5xFXFJckXDeUDoGcHBVQPqzUEybo
	 p01bpMPmeOFwRV3EFf/vTUyWrR5NT+FphaDifK39Z+ICtA8qx9tjBE7C+8B2gSNAa6
	 /jK445o7hQMS3xvSr+1Kb7Kq+ic17FFSXiHpOcFILLy29BXGrV0VT+UneZgLb+VcaX
	 SmggdGs5SQqC9fO/duwxz6wP9726EJzbjmG4KYyIf+8ew9eKQGYn48RN0M4vjudfxa
	 JTt3Xo97JetPuAa9Ztc+z8clkMInxubohu0XAU4VbSXZ53NrepwMbHL5EuhUD0Xn8y
	 b5bj4d7GC/5qw==
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
Subject: [PATCH v2 2/2] lib/test_kho: use kho_preserve_vmalloc instead of storing addresses in fdt
Date: Fri,  5 Sep 2025 16:13:02 +0300
Message-ID: <20250905131302.3595582-3-rppt@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250905131302.3595582-1-rppt@kernel.org>
References: <20250905131302.3595582-1-rppt@kernel.org>
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
 lib/test_kho.c | 30 +++++++++++++++++++++++-------
 1 file changed, 23 insertions(+), 7 deletions(-)

diff --git a/lib/test_kho.c b/lib/test_kho.c
index c2eb899c3b45..10045f5979a0 100644
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
@@ -68,13 +69,17 @@ static struct notifier_block kho_test_nb = {
 static int kho_test_save_data(struct kho_test_state *state, void *fdt)
 {
 	phys_addr_t *folios_info __free(kvfree) = NULL;
+	phys_addr_t folios_info_phys;
 	int err = 0;
 
-	folios_info = kvmalloc_array(state->nr_folios, sizeof(*folios_info),
-				     GFP_KERNEL);
+	folios_info = vmalloc_array(state->nr_folios, sizeof(*folios_info));
 	if (!folios_info)
 		return -ENOMEM;
 
+	err = kho_preserve_vmalloc(folios_info, &folios_info_phys);
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
+	err |= fdt_property(fdt, "folios_info", &folios_info_phys,
+			    sizeof(folios_info_phys));
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
+	const phys_addr_t *folios_info_phys;
+	phys_addr_t *folios_info;
 	const __wsum *old_csum;
 	__wsum csum = 0;
 	int len;
@@ -212,8 +221,12 @@ static int kho_test_restore_data(const void *fdt, int node)
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
2.50.1


