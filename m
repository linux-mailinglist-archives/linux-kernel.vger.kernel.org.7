Return-Path: <linux-kernel+bounces-860548-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id A0D9FBF05F3
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 12:03:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 2547934ABEC
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 10:03:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0603D2E2DD4;
	Mon, 20 Oct 2025 10:03:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Hik/L0Ym"
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82DC52F60C1
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 10:03:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760954596; cv=none; b=JGADXQy0rUVkX0ndm7WJnD40hNra+mAUKHonP6MX68nVfpxov25K9dTk28P4CPhTFQjsdce5XTxGcy3PCZytQa069ro/nniRbWf1gRruu0juv0HpU4sbnr+Q/3D+fhpFs7j8dGwGSV9R8OXQB3jkSnLcArBr6REWQ738KpWDulY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760954596; c=relaxed/simple;
	bh=nSkiL/f4TnAu0mDQVzVP/nlBjsjA0HpOQEjUL4Xrfcw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=pdgfbqqIU7QDzoQ7CSisZ260OlPYb+BbacnH9kf48cyeD2YvuVa7jFSh1xNDELPZQxkUPoVRCSo5QCbl/SJLOYxK81s4zXGEONKj7pwjW0fCHhX84q9jV199l3KXt7JnJA9lO8vKWfLv7o+NwLMoNXRblc9mgOxlXMvhORb3n0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jasonmiu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Hik/L0Ym; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jasonmiu.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2697410e7f9so111258785ad.2
        for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 03:03:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760954594; x=1761559394; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lWYMfKzAMwpC3rMo+EO7RJrq8DN+4fyyYi/w0NuGFhk=;
        b=Hik/L0YmzBz66RGb9Bn3vxB5aEW+Lfq7Srm3CsFcrdOGnvp3Vt77LO0bGSfCb3SbHw
         9ws4cR8TlUF5/UMyrklIVzcD6vpyjmF80NlucG5OJp6hgfELat1wmgaikSrkQGfz7mpo
         Bwk72rQUp93qdqf0m8LD9ARTMvYibQVCLICzYHhX7lTaQOxxqxGLClL+jKeBnCpmRwJk
         B/xaL5JNH/kooqiaNwSc4aSZLsl89HomJxyIoIbh+i1W+6u8RvwtA3UdAUG1oB02bSiD
         rprPITjZe4BzntEm9ropMybph7TaUvLHHNBVcGJ3JgyENqYOnznZQYkAXBL2qe2/9emm
         iQNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760954594; x=1761559394;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lWYMfKzAMwpC3rMo+EO7RJrq8DN+4fyyYi/w0NuGFhk=;
        b=EaWudesLtYDkG6fAj+9ZwbybI5BSOMltpU9czQHlw+oTWRSQuyYzvM29NwJNophLhX
         btLcuqaPFKg9jgwEjT6Nb3O9O62i7QOiFejAq7l82gaDKet6GYaJZFJAu5ZkuMuBcwNd
         9ypWEN24wvzHF8xi4bfgtnanO6Gh1YCzrDZZ3rtt+R3phdF2c1XsNRAP6ohe1lB7zcQD
         hQ3+q6oYfxZZQEIDmWpZ5u3kFm8Fc+q+I2jazrh5cVvydvjVeylcDOqQ/OZ5tgsCbHsH
         boc9DA0t1RRZ0zT89mn/1AgHXJMH+YyS8BpPnTR+8Wzg//7IJ9VRyGR86zF1pcy5dJMy
         gSYg==
X-Forwarded-Encrypted: i=1; AJvYcCVU+155RUrSKFWvvqOqie29L6Xgx63ORKbuqs84HGWLuogFZnMNBNb0PGnq68GFmMYkg+lo56KdzkXsF1o=@vger.kernel.org
X-Gm-Message-State: AOJu0YyKb7lUsiLxhX0f9lXjNDhfezVxvZfJzeqSmdbp4dIVG+WzFCAP
	c7lkgwbP//yFi9BZGDhuu03sDaNBEmtTGHFXzCgQ9xOepqz9HgelURjy+YntVfO8j4eNATTLerW
	1YnaY5TeQVSIk4g==
X-Google-Smtp-Source: AGHT+IEYcb3O7V1ky5jKWFnqxa+/2YZV8/a9EZaxLZJsoQaIasplHaDB8TXWgZyuKJmpJffHcKoX/v4QSLaLJg==
X-Received: from plll4.prod.google.com ([2002:a17:902:d044:b0:290:b0eb:f853])
 (user=jasonmiu job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:902:d586:b0:268:db2:b78e with SMTP id d9443c01a7336-290cba42358mr144766195ad.60.1760954593812;
 Mon, 20 Oct 2025 03:03:13 -0700 (PDT)
Date: Mon, 20 Oct 2025 03:03:05 -0700
In-Reply-To: <20251020100306.2709352-1-jasonmiu@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251020100306.2709352-1-jasonmiu@google.com>
X-Mailer: git-send-email 2.51.0.858.gf9c4a03a3a-goog
Message-ID: <20251020100306.2709352-3-jasonmiu@google.com>
Subject: [PATCH v2 2/3] memblock: kho: Remove KHO notifier usage
From: Jason Miu <jasonmiu@google.com>
To: Alexander Graf <graf@amazon.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Baoquan He <bhe@redhat.com>, Changyuan Lyu <changyuanl@google.com>, 
	David Matlack <dmatlack@google.com>, David Rientjes <rientjes@google.com>, 
	Jason Gunthorpe <jgg@nvidia.com>, Jason Miu <jasonmiu@google.com>, Mike Rapoport <rppt@kernel.org>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, Pratyush Yadav <pratyush@kernel.org>, 
	kexec@lists.infradead.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"

Remove the KHO notifier registration and callbacks from the memblock
subsystem. These notifiers were tied to the former KHO finalize and
abort events, which are no longer used.

Memblock now preserves its `reserve_mem` regions and registers its
metadata by calling kho_preserve_phys(), kho_preserve_folio(), and
kho_add_subtree() directly within its initialization function.

KHO selftest is also updated with this deprecation of notifier.

Signed-off-by: Jason Miu <jasonmiu@google.com>
---
 include/linux/kexec_handover.h     |  5 ++--
 kernel/kexec_handover.c            |  3 +-
 lib/test_kho.c                     | 28 ++++---------------
 mm/memblock.c                      | 45 +++++++-----------------------
 tools/testing/selftests/kho/init.c | 19 -------------
 5 files changed, 18 insertions(+), 82 deletions(-)

diff --git a/include/linux/kexec_handover.h b/include/linux/kexec_handover.h
index bc2f9e060a79..1f2ca09519a1 100644
--- a/include/linux/kexec_handover.h
+++ b/include/linux/kexec_handover.h
@@ -27,7 +27,7 @@ bool kho_is_enabled(void);
 int kho_preserve_folio(struct folio *folio);
 int kho_preserve_phys(phys_addr_t phys, size_t size);
 struct folio *kho_restore_folio(phys_addr_t phys);
-int kho_add_subtree(struct kho_serialization *ser, const char *name, void *fdt);
+int kho_add_subtree(const char *name, void *fdt);
 int kho_remove_subtree(const char *name);
 int kho_retrieve_subtree(const char *name, phys_addr_t *phys);
 
@@ -59,8 +59,7 @@ static inline struct folio *kho_restore_folio(phys_addr_t phys)
 	return NULL;
 }
 
-static inline int kho_add_subtree(struct kho_serialization *ser,
-				  const char *name, void *fdt)
+static inline int kho_add_subtree(const char *name, void *fdt)
 {
 	return -EOPNOTSUPP;
 }
diff --git a/kernel/kexec_handover.c b/kernel/kexec_handover.c
index 2fc5975690a7..1138b16fa546 100644
--- a/kernel/kexec_handover.c
+++ b/kernel/kexec_handover.c
@@ -688,7 +688,6 @@ static struct kho_out kho_out = {
 
 /**
  * kho_add_subtree - record the physical address of a sub FDT in KHO root tree.
- * @ser: serialization control object passed by KHO notifiers.
  * @name: name of the sub tree.
  * @fdt: the sub tree blob.
  *
@@ -701,7 +700,7 @@ static struct kho_out kho_out = {
  *
  * Return: 0 on success, error code on failure
  */
-int kho_add_subtree(struct kho_serialization *ser, const char *name, void *fdt)
+int kho_add_subtree(const char *name, void *fdt)
 {
 	void *root_fdt = page_to_virt(kho_out.ser.fdt);
 	u64 phys = (u64)virt_to_phys(fdt);
diff --git a/lib/test_kho.c b/lib/test_kho.c
index c2eb899c3b45..e4307587a713 100644
--- a/lib/test_kho.c
+++ b/lib/test_kho.c
@@ -38,33 +38,16 @@ struct kho_test_state {
 
 static struct kho_test_state kho_test_state;
 
-static int kho_test_notifier(struct notifier_block *self, unsigned long cmd,
-			     void *v)
+static int kho_test_preserve(void)
 {
-	struct kho_test_state *state = &kho_test_state;
-	struct kho_serialization *ser = v;
 	int err = 0;
 
-	switch (cmd) {
-	case KEXEC_KHO_ABORT:
-		return NOTIFY_DONE;
-	case KEXEC_KHO_FINALIZE:
-		/* Handled below */
-		break;
-	default:
-		return NOTIFY_BAD;
-	}
-
-	err |= kho_preserve_folio(state->fdt);
-	err |= kho_add_subtree(ser, KHO_TEST_FDT, folio_address(state->fdt));
+	err |= kho_preserve_folio(kho_test_state.fdt);
+	err |= kho_add_subtree(KHO_TEST_FDT, folio_address(kho_test_state.fdt));
 
-	return err ? NOTIFY_BAD : NOTIFY_DONE;
+	return err;
 }
 
-static struct notifier_block kho_test_nb = {
-	.notifier_call = kho_test_notifier,
-};
-
 static int kho_test_save_data(struct kho_test_state *state, void *fdt)
 {
 	phys_addr_t *folios_info __free(kvfree) = NULL;
@@ -191,7 +174,7 @@ static int kho_test_save(void)
 	if (err)
 		return err;
 
-	return register_kho_notifier(&kho_test_nb);
+	return kho_test_preserve();
 }
 
 static int kho_test_restore_data(const void *fdt, int node)
@@ -295,7 +278,6 @@ static void kho_test_cleanup(void)
 
 static void __exit kho_test_exit(void)
 {
-	unregister_kho_notifier(&kho_test_nb);
 	kho_test_cleanup();
 }
 module_exit(kho_test_exit);
diff --git a/mm/memblock.c b/mm/memblock.c
index 117d963e677c..602a16cb467a 100644
--- a/mm/memblock.c
+++ b/mm/memblock.c
@@ -2510,39 +2510,6 @@ int reserve_mem_release_by_name(const char *name)
 #define RESERVE_MEM_KHO_NODE_COMPATIBLE "reserve-mem-v1"
 static struct page *kho_fdt;
 
-static int reserve_mem_kho_finalize(struct kho_serialization *ser)
-{
-	int err = 0, i;
-
-	for (i = 0; i < reserved_mem_count; i++) {
-		struct reserve_mem_table *map = &reserved_mem_table[i];
-
-		err |= kho_preserve_phys(map->start, map->size);
-	}
-
-	err |= kho_preserve_folio(page_folio(kho_fdt));
-	err |= kho_add_subtree(ser, MEMBLOCK_KHO_FDT, page_to_virt(kho_fdt));
-
-	return notifier_from_errno(err);
-}
-
-static int reserve_mem_kho_notifier(struct notifier_block *self,
-				    unsigned long cmd, void *v)
-{
-	switch (cmd) {
-	case KEXEC_KHO_FINALIZE:
-		return reserve_mem_kho_finalize((struct kho_serialization *)v);
-	case KEXEC_KHO_ABORT:
-		return NOTIFY_DONE;
-	default:
-		return NOTIFY_BAD;
-	}
-}
-
-static struct notifier_block reserve_mem_kho_nb = {
-	.notifier_call = reserve_mem_kho_notifier,
-};
-
 static int __init prepare_kho_fdt(void)
 {
 	int err = 0, i;
@@ -2583,7 +2550,7 @@ static int __init prepare_kho_fdt(void)
 
 static int __init reserve_mem_init(void)
 {
-	int err;
+	int err, i;
 
 	if (!kho_is_enabled() || !reserved_mem_count)
 		return 0;
@@ -2592,7 +2559,15 @@ static int __init reserve_mem_init(void)
 	if (err)
 		return err;
 
-	err = register_kho_notifier(&reserve_mem_kho_nb);
+	for (i = 0; i < reserved_mem_count; i++) {
+		struct reserve_mem_table *map = &reserved_mem_table[i];
+
+		err |= kho_preserve_phys(map->start, map->size);
+	}
+
+	err |= kho_preserve_folio(page_folio(kho_fdt));
+	err |= kho_add_subtree(MEMBLOCK_KHO_FDT, page_to_virt(kho_fdt));
+
 	if (err) {
 		put_page(kho_fdt);
 		kho_fdt = NULL;
diff --git a/tools/testing/selftests/kho/init.c b/tools/testing/selftests/kho/init.c
index 8034e24c6bf6..211d6bda8961 100644
--- a/tools/testing/selftests/kho/init.c
+++ b/tools/testing/selftests/kho/init.c
@@ -27,22 +27,6 @@ static int mount_filesystems(void)
 	return mount("proc", "/proc", "proc", 0, NULL);
 }
 
-static int kho_enable(void)
-{
-	const char enable[] = "1";
-	int fd;
-
-	fd = open(KHO_FINILIZE, O_RDWR);
-	if (fd < 0)
-		return -1;
-
-	if (write(fd, enable, sizeof(enable)) != sizeof(enable))
-		return 1;
-
-	close(fd);
-	return 0;
-}
-
 static long kexec_file_load(int kernel_fd, int initrd_fd,
 			    unsigned long cmdline_len, const char *cmdline,
 			    unsigned long flags)
@@ -83,9 +67,6 @@ int main(int argc, char *argv[])
 	if (mount_filesystems())
 		goto err_reboot;
 
-	if (kho_enable())
-		goto err_reboot;
-
 	if (kexec_load())
 		goto err_reboot;
 
-- 
2.51.0.858.gf9c4a03a3a-goog


