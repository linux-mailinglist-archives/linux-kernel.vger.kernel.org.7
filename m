Return-Path: <linux-kernel+bounces-721422-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E06DDAFC902
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 12:56:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2F803164C29
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 10:56:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DF8C2D8399;
	Tue,  8 Jul 2025 10:56:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Jt6KXUMW"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF7892BE026
	for <linux-kernel@vger.kernel.org>; Tue,  8 Jul 2025 10:56:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751972170; cv=none; b=WIAWhkPvEXrbmsyIrAgVpeyiIPUipEpI5wHun7MI4ZOTQ8EpTAA+PVfC1x3a0GSwtzJDM1xRgzvWhmZJAwxHjHcha0x2kr2mlF8S8cNQVYEHZX6AZk1VIR/4+IaUYci4uynIfZHWz0Wy5TB8rMLJy5ncEAQdOuC1/ZH4LRLSi70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751972170; c=relaxed/simple;
	bh=GcH5y9I+vwLgEQFHzGMrRHmf1LUNk+VNdMsUyN/XRd0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tsxEpuEfkaPE3oEXgHnGmnAkAuGOBMvU/WEs89GtT6SGbEGCIctcNXiPMRajJoE2pXDxYzaChnVNZGlTD+u1RySduXy50E0x9cvGoveMSn65UG5m/XEM8P7hrM1QZMTWmWHy977F2jXsI0PUeeeIWfyplmteCh9fyg+DQQaqLN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Jt6KXUMW; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751972167;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=bHrF+We+xHosy6K4Q3pHkoPGMQwoIqcnCH+g8ghgZSQ=;
	b=Jt6KXUMWeb7z9+B0p49yQBrRiIBLCb5EPUCTJK7E5L6twDDORJ46YRKBCJPfnYFmNbaML/
	PtXKJwQ5/waxKxeLZtBkjmlZOvrpnBQOn2WpKdIi/rSirFyiX4pBqRLTsjCFW/ZOKaWJLH
	1qOngq/86gyePmJZAN+yGxTkVMomHEs=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-349-4K51PU0BPSGE5dvP52eUYw-1; Tue,
 08 Jul 2025 06:56:04 -0400
X-MC-Unique: 4K51PU0BPSGE5dvP52eUYw-1
X-Mimecast-MFC-AGG-ID: 4K51PU0BPSGE5dvP52eUYw_1751972163
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 61ECB195F170;
	Tue,  8 Jul 2025 10:56:03 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.45.224.100])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 58F5C18002B6;
	Tue,  8 Jul 2025 10:56:02 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
	id AF59918000B2; Tue, 08 Jul 2025 12:55:59 +0200 (CEST)
From: Gerd Hoffmann <kraxel@redhat.com>
To: linux-efi@vger.kernel.org
Cc: Gerd Hoffmann <kraxel@redhat.com>,
	Ard Biesheuvel <ardb@kernel.org>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] efi: add ovmf debug log driver
Date: Tue,  8 Jul 2025 12:55:56 +0200
Message-ID: <20250708105559.603425-1-kraxel@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

Recent OVMF versions (edk2-stable202508 + newer) can write their debug
log to a memory buffer.  This driver exposes the log content via sysfs
(/sys/firmware/efi/ovmf_debug_log).

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 include/linux/efi.h             |   2 +
 drivers/firmware/efi/efi.c      |  11 +++
 drivers/firmware/efi/ovmf-log.c | 136 ++++++++++++++++++++++++++++++++
 drivers/firmware/efi/Kconfig    |   9 +++
 drivers/firmware/efi/Makefile   |   1 +
 5 files changed, 159 insertions(+)
 create mode 100644 drivers/firmware/efi/ovmf-log.c

diff --git a/include/linux/efi.h b/include/linux/efi.h
index 7d63d1d75f22..55479cd8438b 100644
--- a/include/linux/efi.h
+++ b/include/linux/efi.h
@@ -439,6 +439,7 @@ void efi_native_runtime_setup(void);
 
 /* OVMF protocol GUIDs */
 #define OVMF_SEV_MEMORY_ACCEPTANCE_PROTOCOL_GUID	EFI_GUID(0xc5a010fe, 0x38a7, 0x4531,  0x8a, 0x4a, 0x05, 0x00, 0xd2, 0xfd, 0x16, 0x49)
+#define OVMF_MEMORY_LOG_TABLE_GUID			EFI_GUID(0x95305139, 0xb20f, 0x4723, 0x84, 0x25, 0x62, 0x7c, 0x88, 0x8f, 0xf1, 0x21)
 
 typedef struct {
 	efi_guid_t guid;
@@ -642,6 +643,7 @@ extern struct efi {
 	unsigned long			esrt;			/* ESRT table */
 	unsigned long			tpm_log;		/* TPM2 Event Log table */
 	unsigned long			tpm_final_log;		/* TPM2 Final Events Log table */
+	unsigned long                   ovmf_debug_log;
 	unsigned long			mokvar_table;		/* MOK variable config table */
 	unsigned long			coco_secret;		/* Confidential computing secret table */
 	unsigned long			unaccepted;		/* Unaccepted memory table */
diff --git a/drivers/firmware/efi/efi.c b/drivers/firmware/efi/efi.c
index e57bff702b5f..629a42e50b57 100644
--- a/drivers/firmware/efi/efi.c
+++ b/drivers/firmware/efi/efi.c
@@ -45,6 +45,9 @@ struct efi __read_mostly efi = {
 	.esrt			= EFI_INVALID_TABLE_ADDR,
 	.tpm_log		= EFI_INVALID_TABLE_ADDR,
 	.tpm_final_log		= EFI_INVALID_TABLE_ADDR,
+#ifdef CONFIG_OVMF_DEBUG_LOG
+	.ovmf_debug_log         = EFI_INVALID_TABLE_ADDR,
+#endif
 #ifdef CONFIG_LOAD_UEFI_KEYS
 	.mokvar_table		= EFI_INVALID_TABLE_ADDR,
 #endif
@@ -473,6 +476,11 @@ static int __init efisubsys_init(void)
 		platform_device_register_simple("efi_secret", 0, NULL, 0);
 #endif
 
+#ifdef CONFIG_OVMF_DEBUG_LOG
+	if (efi.ovmf_debug_log != EFI_INVALID_TABLE_ADDR)
+		platform_device_register_simple("ovmf_log", 0, NULL, 0);
+#endif
+
 	return 0;
 
 err_remove_group:
@@ -617,6 +625,9 @@ static const efi_config_table_type_t common_tables[] __initconst = {
 	{LINUX_EFI_MEMRESERVE_TABLE_GUID,	&mem_reserve,		"MEMRESERVE"	},
 	{LINUX_EFI_INITRD_MEDIA_GUID,		&initrd,		"INITRD"	},
 	{EFI_RT_PROPERTIES_TABLE_GUID,		&rt_prop,		"RTPROP"	},
+#ifdef CONFIG_OVMF_DEBUG_LOG
+	{OVMF_MEMORY_LOG_TABLE_GUID,		&efi.ovmf_debug_log,	"OVMF-LOG"	},
+#endif
 #ifdef CONFIG_EFI_RCI2_TABLE
 	{DELLEMC_EFI_RCI2_TABLE_GUID,		&rci2_table_phys			},
 #endif
diff --git a/drivers/firmware/efi/ovmf-log.c b/drivers/firmware/efi/ovmf-log.c
new file mode 100644
index 000000000000..4af52adb57cc
--- /dev/null
+++ b/drivers/firmware/efi/ovmf-log.c
@@ -0,0 +1,136 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <linux/efi.h>
+#include <linux/init.h>
+#include <linux/io.h>
+#include <linux/kernel.h>
+#include <linux/kobject.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/sysfs.h>
+
+#define MEM_DEBUG_LOG_MAGIC1  0x3167646d666d766f  // "ovmfmdg1"
+#define MEM_DEBUG_LOG_MAGIC2  0x3267646d666d766f  // "ovmfmdg2"
+
+struct mem_debug_log_header {
+	u64    magic1;
+	u64    magic2;
+	u64    hdr_size;
+	u64    log_size;
+	u64    lock; // edk2 spinlock
+	u64    head_off;
+	u64    tail_off;
+	u64    truncated;
+	u8     fw_version[128];
+};
+
+static struct mem_debug_log_header *hdr;
+static u8 *logbuf;
+static u64 logbufsize;
+
+static ssize_t ovmf_log_read(struct file *filp, struct kobject *kobj,
+			     const struct bin_attribute *attr, char *buf,
+			     loff_t offset, size_t count)
+{
+	u64 start, end;
+
+	start = hdr->head_off + offset;
+	if (hdr->head_off > hdr->tail_off && start >= hdr->log_size)
+		start -= hdr->log_size;
+
+	end = start + count;
+	if (start > hdr->tail_off) {
+		if (end > hdr->log_size)
+			end = hdr->log_size;
+	} else {
+		if (end > hdr->tail_off)
+			end = hdr->tail_off;
+	}
+
+	if (start > logbufsize || end > logbufsize)
+		return 0;
+	if (start >= end)
+		return 0;
+
+	memcpy(buf, logbuf + start, end - start);
+	return end - start;
+}
+
+static struct bin_attribute ovmf_log_bin_attr = {
+	.attr = {
+		.name = "ovmf_debug_log",
+		.mode = 0444,
+	},
+	.read = ovmf_log_read,
+};
+
+static int ovmf_log_probe(struct platform_device *dev)
+{
+	u64 size;
+	int ret = -EINVAL;
+
+	if (efi.ovmf_debug_log == EFI_INVALID_TABLE_ADDR) {
+		dev_err(&dev->dev, "OVMF debug log: not available\n");
+		return -EINVAL;
+	}
+
+	/* map + verify header */
+	hdr = memremap(efi.ovmf_debug_log, sizeof(*hdr), MEMREMAP_WB);
+	if (!hdr) {
+		dev_err(&dev->dev, "OVMF debug log: header map failed\n");
+		return -EINVAL;
+	}
+
+	if (hdr->magic1 != MEM_DEBUG_LOG_MAGIC1 ||
+	    hdr->magic2 != MEM_DEBUG_LOG_MAGIC2) {
+		dev_err(&dev->dev, "OVMF debug log: magic mismatch\n");
+		goto err_unmap;
+	}
+
+	size = hdr->hdr_size + hdr->log_size;
+	dev_info(&dev->dev, "firmware version: \"%s\"\n", hdr->fw_version);
+	dev_info(&dev->dev, "log buffer size: %lldk\n", size / 1024);
+
+	/* map complete log buffer */
+	iounmap(hdr);
+	hdr = memremap(efi.ovmf_debug_log, size, MEMREMAP_WB);
+	if (!hdr) {
+		dev_err(&dev->dev, "OVMF debug log: buffer map failed\n");
+		return -EINVAL;
+	}
+	logbuf = (void*)hdr + hdr->hdr_size;
+	logbufsize = hdr->log_size;
+
+	ovmf_log_bin_attr.size = size;
+	ret = sysfs_create_bin_file(efi_kobj, &ovmf_log_bin_attr);
+	if (ret != 0) {
+		dev_err(&dev->dev, "OVMF debug log: sysfs register failed\n");
+		goto err_unmap;
+	}
+
+	return 0;
+
+err_unmap:
+	iounmap(hdr);
+	return ret;
+}
+
+static void ovmf_log_remove(struct platform_device *dev)
+{
+	iounmap(hdr);
+}
+
+static struct platform_driver ovmf_log_driver = {
+	.probe = ovmf_log_probe,
+	.remove = ovmf_log_remove,
+	.driver = {
+		.name = "ovmf_log",
+	},
+};
+
+module_platform_driver(ovmf_log_driver);
+
+MODULE_DESCRIPTION("OVMF debug log");
+MODULE_AUTHOR("Gerd Hoffmann <kraxel@redhat.com>");
+MODULE_LICENSE("GPL");
+MODULE_ALIAS("platform:ovmf_log");
diff --git a/drivers/firmware/efi/Kconfig b/drivers/firmware/efi/Kconfig
index db8c5c03d3a2..4563d0df170f 100644
--- a/drivers/firmware/efi/Kconfig
+++ b/drivers/firmware/efi/Kconfig
@@ -263,6 +263,15 @@ config EFI_COCO_SECRET
 	  virt/coco/efi_secret module to access the secrets, which in turn
 	  allows userspace programs to access the injected secrets.
 
+config OVMF_DEBUG_LOG
+	tristate "Expose OVMF firmware debug log via sysfs"
+	depends on EFI
+	default y
+	help
+	  Recent OVMF versions (edk2-stable202508 + newer) can write
+	  their debug log to a memory buffer.  This driver exposes the
+	  log content via sysfs (/sys/firmware/efi/ovmf_debug_log).
+
 config UNACCEPTED_MEMORY
 	bool
 	depends on EFI_STUB
diff --git a/drivers/firmware/efi/Makefile b/drivers/firmware/efi/Makefile
index a2d0009560d0..4770c7c4e3c7 100644
--- a/drivers/firmware/efi/Makefile
+++ b/drivers/firmware/efi/Makefile
@@ -29,6 +29,7 @@ obj-$(CONFIG_APPLE_PROPERTIES)		+= apple-properties.o
 obj-$(CONFIG_EFI_RCI2_TABLE)		+= rci2-table.o
 obj-$(CONFIG_EFI_EMBEDDED_FIRMWARE)	+= embedded-firmware.o
 obj-$(CONFIG_LOAD_UEFI_KEYS)		+= mokvar-table.o
+obj-$(CONFIG_OVMF_DEBUG_LOG)		+= ovmf-log.o
 
 obj-$(CONFIG_SYSFB)			+= sysfb_efi.o
 
-- 
2.50.0


