Return-Path: <linux-kernel+bounces-671762-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B7ACACC5DA
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jun 2025 13:53:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0800C3A308C
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jun 2025 11:53:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72BF922FDEA;
	Tue,  3 Jun 2025 11:53:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nEsKA43h"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1603922F767
	for <linux-kernel@vger.kernel.org>; Tue,  3 Jun 2025 11:53:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748951614; cv=none; b=Zo6jLF08Ct1N8bUCDv/eM4BenmrIFJTPjT2U7YbQkIkBUj1VxhJue/EcB32/G+PFgrQq3g2SFx6xoP2cn94Aklr2RxSDA7Hb+w/R3sfiOCuwAXUzajdk7FJjjdW3cuWN/0/xDZAtfxQ8FnSsfthKed1eE05td11JxoBxWENOpKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748951614; c=relaxed/simple;
	bh=aSgvIdP+ojEHSDG1CUmc1DtuQ/TYaem9leeq4TuxoWw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PeEfPN6szNraBKucj3mIHifKyzTFhWY2KUrnbKCyqrRQqFJsOdGQZ+L+rAHDCywBCsJxkTq0/FDZ/1F72ccwnWlf95Vx2Gp1DwtVcIpgF4ISzYvL7toXCPqqigvFcblAd7ZkzYNQHUBooXKH5KXOtjwqckeCBebLnb6zCpqQm+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nEsKA43h; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1748951613; x=1780487613;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=aSgvIdP+ojEHSDG1CUmc1DtuQ/TYaem9leeq4TuxoWw=;
  b=nEsKA43h9mv4LM/HHN0LMnCunbRrkg8JiW54T9W8mvHeNoSW9dvSL0jW
   M2hz3mt/5YwOyt5fRi7I3Ep3Tz/sEwEYPgFuDxYGxCpouTSM9IPdxNAFJ
   TsHk5ZZmQkNA77dTMOmhfUTv01cL1wYiOlpTmf+YAQ2Z96A2Gnv34K0s+
   Mgo6YX/E04gHiBH+Qm0IFO3XobkBq/KGh+lERbu8Qo/WQTYtmeSL3eK7d
   mMaFV7LGFBuLqONWtKhG1ir3fjn/vWMwbZa4fv/Fw49e53PEcgDTX3MaY
   5WPDQChb0QNdsfRrZClI2MMJqdzhlMJBV5rZyF34da2gydEICrBhk+GdR
   w==;
X-CSE-ConnectionGUID: Oq6WplT6QLuPPo0Omtjlvg==
X-CSE-MsgGUID: +aBcakb2RWSydRFT7TsT1g==
X-IronPort-AV: E=McAfee;i="6700,10204,11451"; a="53616410"
X-IronPort-AV: E=Sophos;i="6.16,206,1744095600"; 
   d="scan'208";a="53616410"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2025 04:53:33 -0700
X-CSE-ConnectionGUID: BBpA8KhjRySFtJDUbHtZCA==
X-CSE-MsgGUID: g+wbcYNtTqGoOnv0jQV6Fw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,206,1744095600"; 
   d="scan'208";a="149993309"
Received: from sannilnx-dsk.jer.intel.com ([10.12.231.107])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2025 04:53:27 -0700
From: Alexander Usyskin <alexander.usyskin@intel.com>
To: Miquel Raynal <miquel.raynal@bootlin.com>,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Lucas De Marchi <lucas.demarchi@intel.com>,
	=?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Jani Nikula <jani.nikula@linux.intel.com>,
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
	Tvrtko Ursulin <tursulin@ursulin.net>,
	Karthik Poosa <karthik.poosa@intel.com>,
	Raag Jadav <raag.jadav@intel.com>
Cc: Reuven Abliyev <reuven.abliyev@intel.com>,
	Oren Weil <oren.jer.weil@intel.com>,
	linux-mtd@lists.infradead.org,
	intel-xe@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	intel-gfx@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Alexander Usyskin <alexander.usyskin@intel.com>,
	Tomas Winkler <tomasw@gmail.com>
Subject: [PATCH v12 01/10] mtd: add driver for intel graphics non-volatile memory device
Date: Tue,  3 Jun 2025 14:39:44 +0300
Message-ID: <20250603113953.3599816-2-alexander.usyskin@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250603113953.3599816-1-alexander.usyskin@intel.com>
References: <20250603113953.3599816-1-alexander.usyskin@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add auxiliary driver for intel discrete graphics
non-volatile memory device.

CC: Lucas De Marchi <lucas.demarchi@intel.com>
Reviewed-by: Raag Jadav <raag.jadav@intel.com>
Reviewed-by: Rodrigo Vivi <rodrigo.vivi@intel.com>
Acked-by: Miquel Raynal <miquel.raynal@bootlin.com>
Co-developed-by: Tomas Winkler <tomasw@gmail.com>
Signed-off-by: Tomas Winkler <tomasw@gmail.com>
Signed-off-by: Alexander Usyskin <alexander.usyskin@intel.com>
---
 MAINTAINERS                        |   7 ++
 drivers/mtd/devices/Kconfig        |  11 +++
 drivers/mtd/devices/Makefile       |   1 +
 drivers/mtd/devices/mtd_intel_dg.c | 134 +++++++++++++++++++++++++++++
 include/linux/intel_dg_nvm_aux.h   |  30 +++++++
 5 files changed, 183 insertions(+)
 create mode 100644 drivers/mtd/devices/mtd_intel_dg.c
 create mode 100644 include/linux/intel_dg_nvm_aux.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 578ac300033a..7f0db98ed365 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -11931,6 +11931,13 @@ L:	linux-kernel@vger.kernel.org
 S:	Supported
 F:	arch/x86/include/asm/intel-family.h
 
+INTEL DISCRETE GRAPHICS NVM MTD DRIVER
+M:	Alexander Usyskin <alexander.usyskin@intel.com>
+L:	linux-mtd@lists.infradead.org
+S:	Supported
+F:	drivers/mtd/devices/mtd_intel_dg.c
+F:	include/linux/intel_dg_nvm_aux.h
+
 INTEL DRM DISPLAY FOR XE AND I915 DRIVERS
 M:	Jani Nikula <jani.nikula@linux.intel.com>
 M:	Rodrigo Vivi <rodrigo.vivi@intel.com>
diff --git a/drivers/mtd/devices/Kconfig b/drivers/mtd/devices/Kconfig
index ff2f9e55ef28..59be6d3f0d32 100644
--- a/drivers/mtd/devices/Kconfig
+++ b/drivers/mtd/devices/Kconfig
@@ -183,6 +183,17 @@ config MTD_POWERNV_FLASH
 	  platforms from Linux. This device abstracts away the
 	  firmware interface for flash access.
 
+config MTD_INTEL_DG
+	tristate "Intel Discrete Graphics non-volatile memory driver"
+	depends on AUXILIARY_BUS
+	depends on MTD
+	help
+	  This provides an MTD device to access Intel Discrete Graphics
+	  non-volatile memory.
+
+	  To compile this driver as a module, choose M here: the module
+	  will be called mtd-intel-dg.
+
 comment "Disk-On-Chip Device Drivers"
 
 config MTD_DOCG3
diff --git a/drivers/mtd/devices/Makefile b/drivers/mtd/devices/Makefile
index d11eb2b8b6f8..9fe4ce9cffde 100644
--- a/drivers/mtd/devices/Makefile
+++ b/drivers/mtd/devices/Makefile
@@ -18,6 +18,7 @@ obj-$(CONFIG_MTD_SST25L)	+= sst25l.o
 obj-$(CONFIG_MTD_BCM47XXSFLASH)	+= bcm47xxsflash.o
 obj-$(CONFIG_MTD_ST_SPI_FSM)    += st_spi_fsm.o
 obj-$(CONFIG_MTD_POWERNV_FLASH)	+= powernv_flash.o
+obj-$(CONFIG_MTD_INTEL_DG)	+= mtd_intel_dg.o
 
 
 CFLAGS_docg3.o			+= -I$(src)
diff --git a/drivers/mtd/devices/mtd_intel_dg.c b/drivers/mtd/devices/mtd_intel_dg.c
new file mode 100644
index 000000000000..c2d0dbfb0378
--- /dev/null
+++ b/drivers/mtd/devices/mtd_intel_dg.c
@@ -0,0 +1,134 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright(c) 2019-2025, Intel Corporation. All rights reserved.
+ */
+
+#include <linux/device.h>
+#include <linux/intel_dg_nvm_aux.h>
+#include <linux/io.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/string.h>
+#include <linux/slab.h>
+#include <linux/types.h>
+
+struct intel_dg_nvm {
+	struct kref refcnt;
+	void __iomem *base;
+	size_t size;
+	unsigned int nregions;
+	struct {
+		const char *name;
+		u8 id;
+		u64 offset;
+		u64 size;
+	} regions[] __counted_by(nregions);
+};
+
+static void intel_dg_nvm_release(struct kref *kref)
+{
+	struct intel_dg_nvm *nvm = container_of(kref, struct intel_dg_nvm, refcnt);
+	int i;
+
+	pr_debug("freeing intel_dg nvm\n");
+	for (i = 0; i < nvm->nregions; i++)
+		kfree(nvm->regions[i].name);
+	kfree(nvm);
+}
+
+static int intel_dg_mtd_probe(struct auxiliary_device *aux_dev,
+			      const struct auxiliary_device_id *aux_dev_id)
+{
+	struct intel_dg_nvm_dev *invm = auxiliary_dev_to_intel_dg_nvm_dev(aux_dev);
+	struct intel_dg_nvm *nvm;
+	struct device *device;
+	unsigned int nregions;
+	unsigned int i, n;
+	int ret;
+
+	device = &aux_dev->dev;
+
+	/* count available regions */
+	for (nregions = 0, i = 0; i < INTEL_DG_NVM_REGIONS; i++) {
+		if (invm->regions[i].name)
+			nregions++;
+	}
+
+	if (!nregions) {
+		dev_err(device, "no regions defined\n");
+		return -ENODEV;
+	}
+
+	nvm = kzalloc(struct_size(nvm, regions, nregions), GFP_KERNEL);
+	if (!nvm)
+		return -ENOMEM;
+
+	kref_init(&nvm->refcnt);
+
+	for (n = 0, i = 0; i < INTEL_DG_NVM_REGIONS; i++) {
+		if (!invm->regions[i].name)
+			continue;
+
+		char *name = kasprintf(GFP_KERNEL, "%s.%s",
+				       dev_name(&aux_dev->dev), invm->regions[i].name);
+		if (!name)
+			continue;
+		nvm->regions[n].name = name;
+		nvm->regions[n].id = i;
+		n++;
+	}
+	nvm->nregions = n; /* in case where kasprintf fail */
+
+	nvm->base = devm_ioremap_resource(device, &invm->bar);
+	if (IS_ERR(nvm->base)) {
+		ret = PTR_ERR(nvm->base);
+		goto err;
+	}
+
+	dev_set_drvdata(&aux_dev->dev, nvm);
+
+	return 0;
+
+err:
+	kref_put(&nvm->refcnt, intel_dg_nvm_release);
+	return ret;
+}
+
+static void intel_dg_mtd_remove(struct auxiliary_device *aux_dev)
+{
+	struct intel_dg_nvm *nvm = dev_get_drvdata(&aux_dev->dev);
+
+	if (!nvm)
+		return;
+
+	dev_set_drvdata(&aux_dev->dev, NULL);
+
+	kref_put(&nvm->refcnt, intel_dg_nvm_release);
+}
+
+static const struct auxiliary_device_id intel_dg_mtd_id_table[] = {
+	{
+		.name = "i915.nvm",
+	},
+	{
+		.name = "xe.nvm",
+	},
+	{
+		/* sentinel */
+	}
+};
+MODULE_DEVICE_TABLE(auxiliary, intel_dg_mtd_id_table);
+
+static struct auxiliary_driver intel_dg_mtd_driver = {
+	.probe  = intel_dg_mtd_probe,
+	.remove = intel_dg_mtd_remove,
+	.driver = {
+		/* auxiliary_driver_register() sets .name to be the modname */
+	},
+	.id_table = intel_dg_mtd_id_table
+};
+module_auxiliary_driver(intel_dg_mtd_driver);
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Intel Corporation");
+MODULE_DESCRIPTION("Intel DGFX MTD driver");
diff --git a/include/linux/intel_dg_nvm_aux.h b/include/linux/intel_dg_nvm_aux.h
new file mode 100644
index 000000000000..00b6c1301bd8
--- /dev/null
+++ b/include/linux/intel_dg_nvm_aux.h
@@ -0,0 +1,30 @@
+/* SPDX-License-Identifier: MIT */
+/*
+ * Copyright(c) 2019-2025, Intel Corporation. All rights reserved.
+ */
+
+#ifndef __INTEL_DG_NVM_AUX_H__
+#define __INTEL_DG_NVM_AUX_H__
+
+#include <linux/auxiliary_bus.h>
+#include <linux/container_of.h>
+#include <linux/ioport.h>
+#include <linux/types.h>
+
+#define INTEL_DG_NVM_REGIONS 13
+
+struct intel_dg_nvm_region {
+	const char *name;
+};
+
+struct intel_dg_nvm_dev {
+	struct auxiliary_device aux_dev;
+	bool writable_override;
+	struct resource bar;
+	const struct intel_dg_nvm_region *regions;
+};
+
+#define auxiliary_dev_to_intel_dg_nvm_dev(auxiliary_dev) \
+	container_of(auxiliary_dev, struct intel_dg_nvm_dev, aux_dev)
+
+#endif /* __INTEL_DG_NVM_AUX_H__ */
-- 
2.43.0


