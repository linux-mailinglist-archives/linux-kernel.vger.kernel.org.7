Return-Path: <linux-kernel+bounces-886430-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id CFE39C358FF
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 13:09:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 913D24E1751
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 12:09:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E80530DEB1;
	Wed,  5 Nov 2025 12:09:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="yfHRBPbB"
Received: from canpmsgout12.his.huawei.com (canpmsgout12.his.huawei.com [113.46.200.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CACC08BEC
	for <linux-kernel@vger.kernel.org>; Wed,  5 Nov 2025 12:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762344578; cv=none; b=Hmi61zusPbKQ+Y5Osrd78ndgkEdWP/8LfY8MXMwNMxPHBhpN2Zp3ku0IFjNeB2vR+VwMCH+a/8+vZDRS+qND6LdcCq6b2Gbw7k9nt6Wd3hZDVib9gHT4zErgzHxMv0RL4NNGbkhz4aavJkudk0KuIHZMtFyvv/Zz7QWZPe33J8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762344578; c=relaxed/simple;
	bh=93Znf8v6ce7Wb8dRd3sn0kg/3RzBCMuuhWjJGMlacns=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=mXSSaZy1iKlmc5LfSl1RSu4YnfW7JHymFqcGwLo+Rg/BionGmDnfVcUAwsEdkyLYLG3vqv03Si/wRUrHpOFirN/0WVKGzXwkppw7Ai2SS3dIJ7FP+VSrLr3zWnvPnkLz1sOwsXhrYOCbe8xBnvBbDsiJS05S5sN0rr87i4Bl8pI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=yfHRBPbB; arc=none smtp.client-ip=113.46.200.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=OnyXn+BYYRghXsRACaPAHPyU5ekwK5Cd1WBoa4zVbFM=;
	b=yfHRBPbBRKCa9F5Rxp+zNgniuz+83q76aq6hdavGiY4nxp/0FqCfhalJP4Sqbq0cZU5mdAwDX
	PJJUxYKRC6SVBC7NcrqrjFVotVgxUdv+fLgPil8lGd5Of3g4xsVjFAHWRtRjsw3vEbdwiUsvSmP
	3jqhtYk3UWD1mu7/tsdYVS0=
Received: from mail.maildlp.com (unknown [172.19.163.44])
	by canpmsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4d1kbn1SpZznTVg;
	Wed,  5 Nov 2025 20:07:49 +0800 (CST)
Received: from dggemv712-chm.china.huawei.com (unknown [10.1.198.32])
	by mail.maildlp.com (Postfix) with ESMTPS id 8FE15140156;
	Wed,  5 Nov 2025 20:09:24 +0800 (CST)
Received: from kwepemq100008.china.huawei.com (7.202.195.91) by
 dggemv712-chm.china.huawei.com (10.1.198.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 5 Nov 2025 20:09:24 +0800
Received: from DESKTOP-DKE2JV6.huawei.com (10.67.110.146) by
 kwepemq100008.china.huawei.com (7.202.195.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 5 Nov 2025 20:09:23 +0800
From: Liyuan Pang <pangliyuan1@huawei.com>
To: <richard@nod.at>, <chengzhihao1@huawei.com>, <miquel.raynal@bootlin.com>,
	<vigneshr@ti.com>, <mcoquelin.stm32@gmail.com>,
	<alexandre.torgue@foss.st.com>
CC: <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<linux-stm32@st-md-mailman.stormreply.com>,
	<linux-arm-kernel@lists.infradead.org>, <wanqian10@huawei.com>,
	<young.liuyang@huawei.com>, Liyuan Pang <pangliyuan1@huawei.com>
Subject: [PATCH] ubi: fastmap: fix ubi->fm memory leak
Date: Wed, 5 Nov 2025 20:07:04 +0800
Message-ID: <20251105120704.511192-1-pangliyuan1@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems200002.china.huawei.com (7.221.188.68) To
 kwepemq100008.china.huawei.com (7.202.195.91)

The problem is that scan_fast() allocate memory for ubi->fm
and ubi->fm->e[x], but if the following attach process fails
in ubi_wl_init or ubi_read_volume_table, the whole attach
process will fail without executing ubi_wl_close to free the
memory under ubi->fm.

Fix this by add a new ubi_free_fastmap function in fastmap.c
to free the memory allocated for fm.

If SLUB_DEBUG and KUNIT are enabled, the following warning messages
will show:
ubi0: detaching mtd0
ubi0: mtd0 is detached
ubi0: default fastmap pool size: 200
ubi0: default fastmap WL pool size: 100
ubi0: attaching mtd0
ubi0: attached by fastmap
ubi0: fastmap pool size: 200
ubi0: fastmap WL pool size: 100
ubi0 error: ubi_wl_init [ubi]: no enough physical eraseblocks (4, need 203)
ubi0 error: ubi_attach_mtd_dev [ubi]: failed to attach mtd0, error -28
UBI error: cannot attach mtd0
=================================================================
BUG ubi_wl_entry_slab (Tainted: G    B      O L   ): Objects remaining in ubi_wl_entry_slab on __kmem_cache_shutdown()
-----------------------------------------------------------------------------

Slab 0xffff2fd23a40cd00 objects=22 used=1 fp=0xffff2fd1d0334fd8 flags=0x883fffc010200(slab|head|section=34|node=0|zone=1|lastcpupid=0x7fff)
CPU: 0 PID: 5884 Comm: insmod Tainted: G    B      O L    5.10.0 #1
Hardware name: LS1043A RDB Board (DT)
Call trace:
 dump_backtrace+0x0/0x198
 show_stack+0x18/0x28
 dump_stack+0xe8/0x15c
 slab_err+0x94/0xc0
 __kmem_cache_shutdown+0x1fc/0x39c
 kmem_cache_destroy+0x48/0x138
 ubi_init+0x1d4/0xf34 [ubi]
 do_one_initcall+0xb4/0x24c
 do_init_module+0x4c/0x1dc
 load_module+0x212c/0x2260
 __se_sys_finit_module+0xb4/0xd8
 __arm64_sys_finit_module+0x18/0x28
 el0_svc_common.constprop.0+0x78/0x1a0
 do_el0_svc+0x78/0x90
 el0_svc+0x20/0x38
 el0_sync_handler+0xf0/0x140
 normal+0x3d8/0x400
Object 0xffff2fd1d0334e68 @offset=3688
Allocated in ubi_scan_fastmap+0xf04/0xf40 [ubi] age=80 cpu=0 pid=5884
	__slab_alloc.isra.21+0x6c/0xb4
	kmem_cache_alloc+0x1e4/0x80c
	ubi_scan_fastmap+0xf04/0xf40 [ubi]
	ubi_attach+0x1f0/0x3a8 [ubi]
	ubi_attach_mtd_dev+0x810/0xbc8 [ubi]
	ubi_init+0x238/0xf34 [ubi]
	do_one_initcall+0xb4/0x24c
	do_init_module+0x4c/0x1dc
	load_module+0x212c/0x2260
	__se_sys_finit_module+0xb4/0xd8
	__arm64_sys_finit_module+0x18/0x28
	el0_svc_common.constprop.0+0x78/0x1a0
	do_el0_svc+0x78/0x90
	el0_svc+0x20/0x38
	el0_sync_handler+0xf0/0x140
	normal+0x3d8/0x400

Link: https://bugzilla.kernel.org/show_bug.cgi?id=220744

Signed-off-by: Liyuan Pang <pangliyuan1@huawei.com>
Reviewed-by: Zhihao Cheng <chengzhihao1@huawei.com>
---
 drivers/mtd/ubi/attach.c     |  4 +++-
 drivers/mtd/ubi/fastmap-wl.c |  8 +-------
 drivers/mtd/ubi/fastmap.c    | 12 ++++++++++++
 drivers/mtd/ubi/ubi.h        |  2 ++
 4 files changed, 18 insertions(+), 8 deletions(-)

diff --git a/drivers/mtd/ubi/attach.c b/drivers/mtd/ubi/attach.c
index adc47b87b38a..884171871d0e 100644
--- a/drivers/mtd/ubi/attach.c
+++ b/drivers/mtd/ubi/attach.c
@@ -1600,7 +1600,7 @@ int ubi_attach(struct ubi_device *ubi, int force_scan)
 
 	err = ubi_read_volume_table(ubi, ai);
 	if (err)
-		goto out_ai;
+		goto out_fm;
 
 	err = ubi_wl_init(ubi, ai);
 	if (err)
@@ -1642,6 +1642,8 @@ int ubi_attach(struct ubi_device *ubi, int force_scan)
 out_vtbl:
 	ubi_free_all_volumes(ubi);
 	vfree(ubi->vtbl);
+out_fm:
+	ubi_free_fastmap(ubi);
 out_ai:
 	destroy_ai(ai);
 	return err;
diff --git a/drivers/mtd/ubi/fastmap-wl.c b/drivers/mtd/ubi/fastmap-wl.c
index 9bdb6525f128..e2bc1122bfd3 100644
--- a/drivers/mtd/ubi/fastmap-wl.c
+++ b/drivers/mtd/ubi/fastmap-wl.c
@@ -530,8 +530,6 @@ int ubi_is_erase_work(struct ubi_work *wrk)
 
 static void ubi_fastmap_close(struct ubi_device *ubi)
 {
-	int i;
-
 	return_unused_pool_pebs(ubi, &ubi->fm_pool);
 	return_unused_pool_pebs(ubi, &ubi->fm_wl_pool);
 
@@ -540,11 +538,7 @@ static void ubi_fastmap_close(struct ubi_device *ubi)
 		ubi->fm_anchor = NULL;
 	}
 
-	if (ubi->fm) {
-		for (i = 0; i < ubi->fm->used_blocks; i++)
-			kfree(ubi->fm->e[i]);
-	}
-	kfree(ubi->fm);
+	ubi_free_fastmap(ubi);
 }
 
 /**
diff --git a/drivers/mtd/ubi/fastmap.c b/drivers/mtd/ubi/fastmap.c
index 9a4940874be5..262de30b7b0a 100644
--- a/drivers/mtd/ubi/fastmap.c
+++ b/drivers/mtd/ubi/fastmap.c
@@ -1644,3 +1644,15 @@ int ubi_update_fastmap(struct ubi_device *ubi)
 	kfree(new_fm);
 	goto out_unlock;
 }
+
+void ubi_free_fastmap(struct ubi_device *ubi)
+{
+	int i;
+
+	if (ubi->fm) {
+		for (i = 0; i < ubi->fm->used_blocks; i++)
+			kmem_cache_free(ubi_wl_entry_slab, ubi->fm->e[i]);
+		kfree(ubi->fm);
+		ubi->fm = NULL;
+	}
+}
diff --git a/drivers/mtd/ubi/ubi.h b/drivers/mtd/ubi/ubi.h
index c792b9bcab9b..031a83af3c5c 100644
--- a/drivers/mtd/ubi/ubi.h
+++ b/drivers/mtd/ubi/ubi.h
@@ -969,10 +969,12 @@ int ubi_scan_fastmap(struct ubi_device *ubi, struct ubi_attach_info *ai,
 		     struct ubi_attach_info *scan_ai);
 int ubi_fastmap_init_checkmap(struct ubi_volume *vol, int leb_count);
 void ubi_fastmap_destroy_checkmap(struct ubi_volume *vol);
+void ubi_free_fastmap(struct ubi_device *ubi);
 #else
 static inline int ubi_update_fastmap(struct ubi_device *ubi) { return 0; }
 static inline int ubi_fastmap_init_checkmap(struct ubi_volume *vol, int leb_count) { return 0; }
 static inline void ubi_fastmap_destroy_checkmap(struct ubi_volume *vol) {}
+static inline void ubi_free_fastmap(struct ubi_device *ubi) { }
 #endif
 
 /* block.c */
-- 
2.34.1


