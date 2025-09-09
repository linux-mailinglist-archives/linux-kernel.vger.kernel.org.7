Return-Path: <linux-kernel+bounces-808959-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A7FDB506D8
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 22:17:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9688F1BC1A7E
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 20:17:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 370FF362988;
	Tue,  9 Sep 2025 20:15:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex-team.com header.i=@yandex-team.com header.b="ypBkuNKW"
Received: from forwardcorp1a.mail.yandex.net (forwardcorp1a.mail.yandex.net [178.154.239.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87612362087;
	Tue,  9 Sep 2025 20:15:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757448952; cv=none; b=pooqKSzzAWEkn2IKeNDZpXgjJyAlYnKKg3nGcM2BXCUMUwMXSGYT2kt6zwy28397DRvZdBnId3O6aASue3RRWof1vAOi261cIR/m/gI3c3NkP1TxBKXsa01pp7PemgQinaJMtktxtVakt47ak2bC4ZQK/ddDPinuEtb0i1qUWyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757448952; c=relaxed/simple;
	bh=61JY3aGOKt4Zvihy3nw1Me6reibz0TIE5UHSRp7WR/Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=coWUVqlDgX4Bb24mFIz+8t0E5aNymYGFIh/uABAkc8viGqifZExQHyOjgY5LvYP6r65Ji008LbsD+YJiFdLvtkNxGUj3Jf3FVh4Suxb90WxfROvdlY4gR058V76hAxG3OpvXExfAOnXND4nauOQWnkubPC7g9PHbTIcOKac3tgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex-team.com; spf=pass smtp.mailfrom=yandex-team.com; dkim=pass (1024-bit key) header.d=yandex-team.com header.i=@yandex-team.com header.b=ypBkuNKW; arc=none smtp.client-ip=178.154.239.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex-team.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex-team.com
Received: from mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net (mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net [IPv6:2a02:6b8:c1f:3a87:0:640:845c:0])
	by forwardcorp1a.mail.yandex.net (Yandex) with ESMTPS id EE366C01AB;
	Tue, 09 Sep 2025 23:15:48 +0300 (MSK)
Received: from localhost.localdomain (172.31.115.73-vpn.dhcp.yndx.net [172.31.115.73])
	by mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net (smtpcorp/Yandex) with ESMTPSA id IFQqlX5GteA0-QszPafCr;
	Tue, 09 Sep 2025 23:15:48 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.com;
	s=default; t=1757448948;
	bh=m8A5M9SWZ4FduOae9/W265UdgKKBYKII8mDM46+RgEM=;
	h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
	b=ypBkuNKW+ERXO+vB9wi+MesqhXDJci+Z58snBgpV01YxOdZZSgyD0EiGOS1d6ChRM
	 hs4mlstpXx3wA2LGBMtVkU4uQU0M8JpfQTx3pK+DQa36tE3REBAz6GdNN58l44rh9q
	 GyjRrorPLSUoRNijR571xdfTd90C7ZpqX08mC7Vk=
Authentication-Results: mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net; dkim=pass header.i=@yandex-team.com
From: Andrey Ryabinin <arbn@yandex-team.com>
To: linux-kernel@vger.kernel.org
Cc: Alexander Graf <graf@amazon.com>,
	Mike Rapoport <rppt@kernel.org>,
	James Gowans <jgowans@amazon.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-mm@kvack.org,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Baoquan He <bhe@redhat.com>,
	kexec@lists.infradead.org,
	Pratyush Yadav <ptyadav@amazon.de>,
	Jason Gunthorpe <jgg@nvidia.com>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	David Rientjes <rientjes@google.com>,
	Pratyush Yadav <pratyush@kernel.org>,
	Changyuan Lyu <changyuanl@google.com>,
	Jonathan Corbet <corbet@lwn.net>,
	linux-doc@vger.kernel.org,
	Andrey Ryabinin <ryabinin.a.a@gmail.com>,
	Chris Li <chrisl@kernel.org>,
	Ashish.Kalra@amd.com,
	William Tu <witu@nvidia.com>,
	David Matlack <dmatlack@google.com>,
	Andrey Ryabinin <arbn@yandex-team.com>
Subject: [PATCH v3 6/7] mm/memblock: Use KSTATE instead of kho to preserve preserved_mem_table
Date: Tue,  9 Sep 2025 22:14:41 +0200
Message-ID: <20250909201446.13138-7-arbn@yandex-team.com>
X-Mailer: git-send-email 2.49.1
In-Reply-To: <20250909201446.13138-1-arbn@yandex-team.com>
References: <20250909201446.13138-1-arbn@yandex-team.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently preserved_mem_table serialized/deserialized using fdt. Use KSTATE
instead as it makes code simpler and more compact.

Signed-off-by: Andrey Ryabinin <arbn@yandex-team.com>
---
 include/linux/kstate.h |   1 +
 mm/memblock.c          | 158 +++++++++++++----------------------------
 2 files changed, 49 insertions(+), 110 deletions(-)

diff --git a/include/linux/kstate.h b/include/linux/kstate.h
index 0ced0da37c8f..db8ba07e2319 100644
--- a/include/linux/kstate.h
+++ b/include/linux/kstate.h
@@ -97,6 +97,7 @@ enum kstate_ids {
 	KSTATE_KHO_FDT_ID,
 	KSTATE_TEST_ID,
 	KSTATE_TEST_ID_V2,
+	KSTATE_RESERVED_MEM_ID,
 	KSTATE_LAST_ID = -1,
 };
 
diff --git a/mm/memblock.c b/mm/memblock.c
index 6af0b51b1bb7..b9d84d1ffd83 100644
--- a/mm/memblock.c
+++ b/mm/memblock.c
@@ -14,11 +14,13 @@
 #include <linux/pfn.h>
 #include <linux/debugfs.h>
 #include <linux/kmemleak.h>
+#include <linux/kstate.h>
 #include <linux/seq_file.h>
 #include <linux/memblock.h>
 #include <linux/mutex.h>
 
 #ifdef CONFIG_KEXEC_HANDOVER
+#include <linux/crc32.h>
 #include <linux/libfdt.h>
 #include <linux/kexec_handover.h>
 #endif /* CONFIG_KEXEC_HANDOVER */
@@ -2498,140 +2500,76 @@ int reserve_mem_release_by_name(const char *name)
 }
 
 #ifdef CONFIG_KEXEC_HANDOVER
-#define MEMBLOCK_KHO_FDT "memblock"
-#define MEMBLOCK_KHO_NODE_COMPATIBLE "memblock-v1"
-#define RESERVE_MEM_KHO_NODE_COMPATIBLE "reserve-mem-v1"
-
-static int __init prepare_kho_fdt(void)
-{
-	int err = 0, i;
-	struct page *fdt_page;
-	void *fdt;
-
-	fdt_page = alloc_page(GFP_KERNEL);
-	if (!fdt_page)
-		return -ENOMEM;
-
-	fdt = page_to_virt(fdt_page);
-
-	err |= fdt_create(fdt, PAGE_SIZE);
-	err |= fdt_finish_reservemap(fdt);
-
-	err |= fdt_begin_node(fdt, "");
-	err |= fdt_property_string(fdt, "compatible", MEMBLOCK_KHO_NODE_COMPATIBLE);
-	for (i = 0; i < reserved_mem_count; i++) {
-		struct reserve_mem_table *map = &reserved_mem_table[i];
-
-		err |= kho_preserve_phys(map->start, map->size);
-		err |= fdt_begin_node(fdt, map->name);
-		err |= fdt_property_string(fdt, "compatible", RESERVE_MEM_KHO_NODE_COMPATIBLE);
-		err |= fdt_property(fdt, "start", &map->start, sizeof(map->start));
-		err |= fdt_property(fdt, "size", &map->size, sizeof(map->size));
-		err |= fdt_end_node(fdt);
-	}
-	err |= fdt_end_node(fdt);
-	err |= fdt_finish(fdt);
-
-	err |= kho_preserve_folio(page_folio(fdt_page));
-	err |= kho_add_subtree(MEMBLOCK_KHO_FDT, fdt);
-
-	if (err) {
-		pr_err("failed to prepare memblock FDT for KHO: %d\n", err);
-		put_page(fdt_page);
-	}
-
-	return err;
-}
+static int kstate_preserve_phys(struct kstate_stream *stream, void *obj,
+				const struct kstate_field *field)
+{
+	struct reserve_mem_table *map = obj;
+
+	return kho_preserve_phys(map->start, map->size);
+}
+
+struct kstate_description kstate_reserve_mem = {
+	.name = "reserved_mem",
+	.id = KSTATE_RESERVED_MEM_ID,
+	.fields = (const struct kstate_field[]) {
+		KSTATE_BASE_TYPE(name, struct reserve_mem_table,
+				char[RESERVE_MEM_NAME_SIZE]),
+		KSTATE_BASE_TYPE(start, struct reserve_mem_table, phys_addr_t),
+		KSTATE_BASE_TYPE(size, struct reserve_mem_table, phys_addr_t),
+		{
+			.name = "phys_range",
+			.flags = KS_CUSTOM,
+			.save = kstate_preserve_phys,
+		},
+		KSTATE_END_OF_LIST(),
+	},
+};
 
 static int __init reserve_mem_init(void)
 {
 	int err;
+	int i;
 
 	if (!kho_is_enabled() || !reserved_mem_count)
 		return 0;
 
-	err = prepare_kho_fdt();
-	if (err)
-		return err;
-	return err;
-}
-late_initcall(reserve_mem_init);
-
-static void *__init reserve_mem_kho_retrieve_fdt(void)
-{
-	phys_addr_t fdt_phys;
-	static void *fdt;
-	int err;
-
-	if (fdt)
-		return fdt;
-
-	err = kho_retrieve_subtree(MEMBLOCK_KHO_FDT, &fdt_phys);
-	if (err) {
-		if (err != -ENOENT)
-			pr_warn("failed to retrieve FDT '%s' from KHO: %d\n",
-				MEMBLOCK_KHO_FDT, err);
-		return NULL;
-	}
-
-	fdt = phys_to_virt(fdt_phys);
+	for (i = 0; i < reserved_mem_count; i++) {
+		struct reserve_mem_table *map = &reserved_mem_table[i];
 
-	err = fdt_node_check_compatible(fdt, 0, MEMBLOCK_KHO_NODE_COMPATIBLE);
-	if (err) {
-		pr_warn("FDT '%s' is incompatible with '%s': %d\n",
-			MEMBLOCK_KHO_FDT, MEMBLOCK_KHO_NODE_COMPATIBLE, err);
-		fdt = NULL;
+		err = kstate_register(&kstate_reserve_mem,
+				map, crc32(~0, map->name, RESERVE_MEM_NAME_SIZE));
+		if (err)
+			goto out;
 	}
-
-	return fdt;
+out:
+	return err;
 }
+late_initcall(reserve_mem_init);
 
 static bool __init reserve_mem_kho_revive(const char *name, phys_addr_t size,
 					  phys_addr_t align)
 {
-	int err, len_start, len_size, offset;
-	const phys_addr_t *p_start, *p_size;
-	const void *fdt;
+	struct reserve_mem_table *map = &reserved_mem_table[reserved_mem_count];
 
-	fdt = reserve_mem_kho_retrieve_fdt();
-	if (!fdt)
+	if (kstate_restore(&kstate_reserve_mem, map,
+				crc32(~0, name, RESERVE_MEM_NAME_SIZE)))
 		return false;
 
-	offset = fdt_subnode_offset(fdt, 0, name);
-	if (offset < 0) {
-		pr_warn("FDT '%s' has no child '%s': %d\n",
-			MEMBLOCK_KHO_FDT, name, offset);
-		return false;
-	}
-	err = fdt_node_check_compatible(fdt, offset, RESERVE_MEM_KHO_NODE_COMPATIBLE);
-	if (err) {
-		pr_warn("Node '%s' is incompatible with '%s': %d\n",
-			name, RESERVE_MEM_KHO_NODE_COMPATIBLE, err);
+	if (map->start & (align - 1)) {
+		pr_warn("KHO reserve-mem '%s' has wrong alignment (0x%pa, 0x%pa)\n",
+			name, &align, &map->start);
 		return false;
 	}
 
-	p_start = fdt_getprop(fdt, offset, "start", &len_start);
-	p_size = fdt_getprop(fdt, offset, "size", &len_size);
-	if (!p_start || len_start != sizeof(*p_start) || !p_size ||
-	    len_size != sizeof(*p_size)) {
+	if (map->size != size) {
+		pr_warn("KHO reserve-mem '%s' has wrong size (0x%pa != 0x%pa)\n",
+			name, &map->size, &size);
 		return false;
 	}
 
-	if (*p_start & (align - 1)) {
-		pr_warn("KHO reserve-mem '%s' has wrong alignment (0x%lx, 0x%lx)\n",
-			name, (long)align, (long)*p_start);
-		return false;
-	}
-
-	if (*p_size != size) {
-		pr_warn("KHO reserve-mem '%s' has wrong size (0x%lx != 0x%lx)\n",
-			name, (long)*p_size, (long)size);
-		return false;
-	}
-
-	reserved_mem_add(*p_start, size, name);
-	pr_info("Revived memory reservation '%s' from KHO\n", name);
-
+	pr_info("Revived memory reservation '%s' %pa %pa from KHO\n",
+		name, &map->start, &map->size);
+	reserved_mem_count++;
 	return true;
 }
 #else
-- 
2.49.1


