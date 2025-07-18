Return-Path: <linux-kernel+bounces-736944-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4688CB0A576
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 15:45:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7E92C3AEFCA
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 13:44:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE932155CB3;
	Fri, 18 Jul 2025 13:43:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="XnPSymwU";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="T//Eds1e"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C969113C9A6
	for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 13:43:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752846237; cv=none; b=egzZUYKvRdk6Go/hYyZk2eCG4mOSEz+qw6Zfa032AlFSpoT4msX0aZoo03K/9WOLuoZD+/sgAwqEm7KrkgBotxGWdsp86aFv+yfHEkxcmj+XEJhE7U8g/b23Jo4GSTG43+iyJRQw/5QiDhFNEBduokDG7miBtZNy3p5GbyTgfGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752846237; c=relaxed/simple;
	bh=q2UjMKOga6JToQy1uIaopMAEf1fITIaxtJHPyKM7SwA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=CGigxFKbMp4Och/Y/gM5gxdHubGPLmu+CRFhQrqUU1ERjgkUKf+WN0iuxesalt245zrPMQkGP3eBx2amgnYEHzcmtl8nRp9vw5w5o5NFNs3Ces49Ow69RlzFHuj7xt5Gb3x8+bKdOw4gCXUKlw6o9F+S9Y+/I583aK96YUosd7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=XnPSymwU; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=T//Eds1e; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1752846234;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=a4gWJwKjGqlCn3SHvIPVpvQm4zN1334M0yU56VgpRRE=;
	b=XnPSymwUhnbipVc7aff+wxyOsOwyCr8tAjQWtH1swGBR8DIQvdfx2p9MBWR3X5zzBO/eTa
	To1vBHdU7VwJQd8iV1pySLCskprvC/67T2VnhOyRixljxrlYlO5RFInAswXFf/3p5KBo2M
	adaXOSTAvWXwgrG84NM0kXnIGexvG28qwBkuYYUVUoQ3zwQ6Uaj2KEHBw0DPYnYpf9ZpZl
	aMt77fm1RZnHymVxl3LU1uaDNKATljxpIcz5Rj/YMUhqzqgQz4OV0HFwMQ6NrxJdPYvGdn
	7J73NXwPZv6EuxNHgTot1vZHi/ywinGLRCSt3eEiyDuoC6Gz4e90gOSdY7y7EQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1752846234;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=a4gWJwKjGqlCn3SHvIPVpvQm4zN1334M0yU56VgpRRE=;
	b=T//Eds1eCehNxOcxKJJbUZXhqzSCd4hnRVBT0nHtubwKZqc/o89xmqW/gVlQmOZnsxThgm
	HhPz34nJwhm04cDw==
Date: Fri, 18 Jul 2025 15:43:49 +0200
Subject: [PATCH] drivers: virt: acrn: Don't use %pK through printk
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250718-restricted-pointers-virt-v1-1-12913fceaf52@linutronix.de>
X-B4-Tracking: v=1; b=H4sIAJRPemgC/x3MQQqFMAxF0a1Ixj9gK2J1K/IHUp+aSZWkiCDu3
 eLwDO69yaACo6G6SXGKyZ4K3K+iuE1pBctcTL72bd25wArLKjFj5mOXlKHGp2hmF8KCyfnY9JF
 KfigWub71+H+eFzqfCH5qAAAA
X-Change-ID: 20250718-restricted-pointers-virt-188fea12c39c
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Fei Li <fei1.li@intel.com>
Cc: linux-kernel@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1752846233; l=3405;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=q2UjMKOga6JToQy1uIaopMAEf1fITIaxtJHPyKM7SwA=;
 b=lXi9lyg7l+RVZWqk+KnWqJ2cW+QQOjV0tSdGVAct4twexKCSbw8aWe/Q/p1B0ckrRRUQoJ1re
 guXH4R+M2swD27A90OGaFWMBslByvvw3RaWlONTT8LQvGDS5rJi97Dl
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

In the past %pK was preferable to %p as it would not leak raw pointer
values into the kernel log.
Since commit ad67b74d2469 ("printk: hash addresses printed with %p")
the regular %p has been improved to avoid this issue.
Furthermore, restricted pointers ("%pK") were never meant to be used
through printk(). They can still unintentionally leak raw pointers or
acquire sleeping locks in atomic contexts.

Switch to the regular pointer formatting which is safer and
easier to reason about.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
 drivers/virt/acrn/ioreq.c | 4 ++--
 drivers/virt/acrn/mm.c    | 8 ++++----
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/virt/acrn/ioreq.c b/drivers/virt/acrn/ioreq.c
index e94358239a4b54013b2d770b3626175c6c312059..55ddfa4840afc4c0bf72a73b9dac1a74ddbddb09 100644
--- a/drivers/virt/acrn/ioreq.c
+++ b/drivers/virt/acrn/ioreq.c
@@ -626,7 +626,7 @@ int acrn_ioreq_init(struct acrn_vm *vm, u64 buf_vma)
 	}
 
 	dev_dbg(acrn_dev.this_device,
-		"Init ioreq buffer %pK!\n", vm->ioreq_buf);
+		"Init ioreq buffer %p!\n", vm->ioreq_buf);
 	ret = 0;
 free_buf:
 	kfree(set_buffer);
@@ -638,7 +638,7 @@ void acrn_ioreq_deinit(struct acrn_vm *vm)
 	struct acrn_ioreq_client *client, *next;
 
 	dev_dbg(acrn_dev.this_device,
-		"Deinit ioreq buffer %pK!\n", vm->ioreq_buf);
+		"Deinit ioreq buffer %p!\n", vm->ioreq_buf);
 	/* Destroy all clients belonging to this VM */
 	list_for_each_entry_safe(client, next, &vm->ioreq_clients, list)
 		acrn_ioreq_client_destroy(client);
diff --git a/drivers/virt/acrn/mm.c b/drivers/virt/acrn/mm.c
index 4c2f28715b703957eb8ef1aef2a719cd704cb1ef..bfb3031885e8d6c288d0d34a01c2509c808249cb 100644
--- a/drivers/virt/acrn/mm.c
+++ b/drivers/virt/acrn/mm.c
@@ -68,7 +68,7 @@ int acrn_mm_region_add(struct acrn_vm *vm, u64 user_gpa, u64 service_gpa,
 	ret = modify_region(vm, region);
 
 	dev_dbg(acrn_dev.this_device,
-		"%s: user-GPA[%pK] service-GPA[%pK] size[0x%llx].\n",
+		"%s: user-GPA[%p] service-GPA[%p] size[0x%llx].\n",
 		__func__, (void *)user_gpa, (void *)service_gpa, size);
 	kfree(region);
 	return ret;
@@ -99,7 +99,7 @@ int acrn_mm_region_del(struct acrn_vm *vm, u64 user_gpa, u64 size)
 
 	ret = modify_region(vm, region);
 
-	dev_dbg(acrn_dev.this_device, "%s: user-GPA[%pK] size[0x%llx].\n",
+	dev_dbg(acrn_dev.this_device, "%s: user-GPA[%p] size[0x%llx].\n",
 		__func__, (void *)user_gpa, size);
 	kfree(region);
 	return ret;
@@ -224,7 +224,7 @@ int acrn_vm_ram_map(struct acrn_vm *vm, struct acrn_vm_memmap *memmap)
 
 		if (ret) {
 			dev_dbg(acrn_dev.this_device,
-				"Failed to lookup PFN at VMA:%pK.\n", (void *)memmap->vma_base);
+				"Failed to lookup PFN at VMA:%p.\n", (void *)memmap->vma_base);
 			return ret;
 		}
 
@@ -326,7 +326,7 @@ int acrn_vm_ram_map(struct acrn_vm *vm, struct acrn_vm_memmap *memmap)
 	kfree(regions_info);
 
 	dev_dbg(acrn_dev.this_device,
-		"%s: VM[%u] service-GVA[%pK] user-GPA[%pK] size[0x%llx]\n",
+		"%s: VM[%u] service-GVA[%p] user-GPA[%p] size[0x%llx]\n",
 		__func__, vm->vmid,
 		remap_vaddr, (void *)memmap->user_vm_pa, memmap->len);
 	return ret;

---
base-commit: d086c886ceb9f59dea6c3a9dae7eb89e780a20c9
change-id: 20250718-restricted-pointers-virt-188fea12c39c

Best regards,
-- 
Thomas Weißschuh <thomas.weissschuh@linutronix.de>


