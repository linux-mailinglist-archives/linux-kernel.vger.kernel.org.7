Return-Path: <linux-kernel+bounces-704062-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C4C7DAE98D7
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jun 2025 10:47:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6498E3AA11E
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jun 2025 08:46:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 332CB2BEFF6;
	Thu, 26 Jun 2025 08:46:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Vv5Jo79g"
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9C612BCF6F
	for <linux-kernel@vger.kernel.org>; Thu, 26 Jun 2025 08:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750927564; cv=none; b=cSzAqzwdRsmwLrmXeTyLHPU33za+pjM/GsZE1BZh1a7CNi2tFzBR9Xosp7jW83iBva1aqac2Ki4xOP+YZkjvhX/pZloBLtMaE4u8mzUKNQej0CqyMbe7QGV+0hx3o1eaX4gHkxj9bdgiYKuTKeCYTlKPFJzYTbu+83kqMVWCijw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750927564; c=relaxed/simple;
	bh=piFh5ILKyHADE2TsGJ2+a2KfUuuTuXy7hRYX8G7eVXM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jz5EPPRPEPUTAuRBhdKl2qcI190SkYwTYkPZq4XHtM682jhyQL2wVCpTwoNARjNUYPYFAQx2kToGpyRu5JktWv0w0dY9EN/LWZEH5FiXSVAiXKHH8f6PCBG+Ahg6aq462RgbZTFjPcwM5TbdwvZYaPreG4YZK7UtcxY21zlj4Tw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=Vv5Jo79g; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-235f9ea8d08so7760545ad.1
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jun 2025 01:46:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1750927562; x=1751532362; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rQrBbtrezw6k0k+Mrx1meF1bPCRTxYJ73q9YtFyyiOk=;
        b=Vv5Jo79gYlMGFbQGwaosNaMepAbhjxzXpg9rLJoYonLWf7tMkSAqJkWG4SOR0VbNXn
         /LcA5RALjsRamBIIEw+P8Cxi1xKknOOMhX1DpPG7KIzNvV1mtkOFfNaT/8N5AKJLSiXF
         qyA+arb5/Cov4gvsDUHzKQaXK+LKgSAkObDrc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750927562; x=1751532362;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rQrBbtrezw6k0k+Mrx1meF1bPCRTxYJ73q9YtFyyiOk=;
        b=hUcONn6J5QGx/FBRwLSgZkrRoyGeaQzMbGSvR1nktAIucKvY6z3aXl1fcnBe2cbF9q
         mEbVg/UkCp1spTeJk4d7CuMQw1f9nG646cPPo6wMhtiPHtJ80t/siMZ9G3y2PEXthNra
         GsxZbmy0iOmpnLZz3fngqxMDUKX6GRddWMJQto4BZEJpAQ7xPTWSuljC/TxudVSEUskV
         ii3MpOshPp4CY/WlXG+A3EM5quw/V5OEChtnBFCNIV+GfDVpHHVJ3lCGm4VWBdW/jV25
         EhatEw/+kF7v/oHVnjTYPMAMmYbRXH6VNEmI9S/HZsgJ6aDGlRLuiJmANahEiJ6fu+AP
         D/hw==
X-Forwarded-Encrypted: i=1; AJvYcCUbc4vBjd2ZcVlSvkmbYJPaTfrJXMH0v1Sa+9WlgtmevTSA1T9CHmyV+/5pyX6DLhYM4ezmQuTl9LwPNMg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzKaG0PiAwJU8hBBl39LGsOhJ5O+tYpkvEfJOUcD4DdhQRigmwi
	1UU10Q3nKFi2+3xeA80SleEkTZIb+id2OXYgoSbExte4oZIFOLwnvw8CBgc7P4Gdxw==
X-Gm-Gg: ASbGnct1SWA2vw51fGWAZ1fxYiNHSydvByXxnhMSjBlymu9T1UZvxKySwtlxNqvU0LV
	4pU93ScGsY2q84EfhNCOIBeVEryO8YGkKndzcgQpTO8whF2zsqxeCgyb/y1HYkwEBdSbSWX+Fko
	3F3Be3shXpJ5TqywAe+oo6lpshgwII/Q/Nx4yTivn+h7GdnDUMhnDPcrchYm8ymgpe7HXVpA5Wk
	xnIN9Bp96pnf9SdcXhWh3lO/ZqcUBr0/k791ifzYMANfZo6mMcJcAek9284Kh4+MyBhbLNi7uQR
	DC/EsV+bqCkHyjgycnZ70/PQiYSwYGRSXuLU/uVHw+S/arIDTmfTRtOXtyui0ZVbPJmN8PJx2o8
	55M+TBBjjol7uRykVXUYuV+r2wbIMmhRXUIfAW/Q=
X-Google-Smtp-Source: AGHT+IFBpBVs/2aXiTLEGtvEzLB5A2xwi3bGMz6cMXTliWf5609qRpqAkz5LYiXHqvwOLw5wMR5mTg==
X-Received: by 2002:a17:903:1ce:b0:235:f4f7:a62b with SMTP id d9443c01a7336-2382405d084mr109892425ad.41.1750927562063;
        Thu, 26 Jun 2025 01:46:02 -0700 (PDT)
Received: from localhost.localdomain ([192.19.203.250])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-237d83fbe94sm152524875ad.86.2025.06.26.01.45.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Jun 2025 01:46:01 -0700 (PDT)
From: Vikas Gupta <vikas.gupta@broadcom.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	michael.chan@broadcom.com,
	pavan.chebbi@broadcom.com,
	vsrama-krishna.nemani@broadcom.com,
	Vikas Gupta <vikas.gupta@broadcom.com>,
	Bhargava Chenna Marreddy <bhargava.marreddy@broadcom.com>,
	Rajashekar Hudumula <rajashekar.hudumula@broadcom.com>
Subject: [net-next, v2 02/10] bng_en: Add devlink interface
Date: Thu, 26 Jun 2025 14:08:11 +0000
Message-ID: <20250626140844.266456-3-vikas.gupta@broadcom.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250626140844.266456-1-vikas.gupta@broadcom.com>
References: <20250626140844.266456-1-vikas.gupta@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Allocate a base device and devlink interface with minimal
devlink ops.
Add dsn and board related information.
Map PCIe BAR (bar0), which helps to communicate with the
firmware.

Signed-off-by: Vikas Gupta <vikas.gupta@broadcom.com>
Reviewed-by: Bhargava Chenna Marreddy <bhargava.marreddy@broadcom.com>
Reviewed-by: Rajashekar Hudumula <rajashekar.hudumula@broadcom.com>
---
 drivers/net/ethernet/broadcom/Kconfig         |   1 +
 drivers/net/ethernet/broadcom/bnge/Makefile   |   3 +-
 drivers/net/ethernet/broadcom/bnge/bnge.h     |  11 ++
 .../net/ethernet/broadcom/bnge/bnge_core.c    |  43 +++++
 .../net/ethernet/broadcom/bnge/bnge_devlink.c | 156 ++++++++++++++++++
 .../net/ethernet/broadcom/bnge/bnge_devlink.h |  18 ++
 6 files changed, 231 insertions(+), 1 deletion(-)
 create mode 100644 drivers/net/ethernet/broadcom/bnge/bnge_devlink.c
 create mode 100644 drivers/net/ethernet/broadcom/bnge/bnge_devlink.h

diff --git a/drivers/net/ethernet/broadcom/Kconfig b/drivers/net/ethernet/broadcom/Kconfig
index e2c1ac91708e..0fc10e6c6902 100644
--- a/drivers/net/ethernet/broadcom/Kconfig
+++ b/drivers/net/ethernet/broadcom/Kconfig
@@ -256,6 +256,7 @@ config BNXT_HWMON
 config BNGE
 	tristate "Broadcom Ethernet device support"
 	depends on PCI
+	select NET_DEVLINK
 	help
 	  This driver supports Broadcom 50/100/200/400/800 gigabit Ethernet cards.
 	  The module will be called bng_en. To compile this driver as a module,
diff --git a/drivers/net/ethernet/broadcom/bnge/Makefile b/drivers/net/ethernet/broadcom/bnge/Makefile
index 0c3d632805d1..e021a14d2fa0 100644
--- a/drivers/net/ethernet/broadcom/bnge/Makefile
+++ b/drivers/net/ethernet/broadcom/bnge/Makefile
@@ -2,4 +2,5 @@
 
 obj-$(CONFIG_BNGE) += bng_en.o
 
-bng_en-y := bnge_core.o
+bng_en-y := bnge_core.o \
+	    bnge_devlink.o
diff --git a/drivers/net/ethernet/broadcom/bnge/bnge.h b/drivers/net/ethernet/broadcom/bnge/bnge.h
index b49c51b44473..19d85aabab4e 100644
--- a/drivers/net/ethernet/broadcom/bnge/bnge.h
+++ b/drivers/net/ethernet/broadcom/bnge/bnge.h
@@ -13,4 +13,15 @@ enum board_idx {
 	BCM57708,
 };
 
+struct bnge_dev {
+	struct device	*dev;
+	struct pci_dev	*pdev;
+	u64	dsn;
+#define BNGE_VPD_FLD_LEN	32
+	char		board_partno[BNGE_VPD_FLD_LEN];
+	char		board_serialno[BNGE_VPD_FLD_LEN];
+
+	void __iomem	*bar0;
+};
+
 #endif /* _BNGE_H_ */
diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_core.c b/drivers/net/ethernet/broadcom/bnge/bnge_core.c
index 514602555cd1..37dbd42af084 100644
--- a/drivers/net/ethernet/broadcom/bnge/bnge_core.c
+++ b/drivers/net/ethernet/broadcom/bnge/bnge_core.c
@@ -7,6 +7,7 @@
 #include <linux/pci.h>
 
 #include "bnge.h"
+#include "bnge_devlink.h"
 
 MODULE_LICENSE("GPL");
 MODULE_DESCRIPTION(DRV_SUMMARY);
@@ -77,8 +78,19 @@ static int bnge_pci_enable(struct pci_dev *pdev)
 	return rc;
 }
 
+static void bnge_unmap_bars(struct pci_dev *pdev)
+{
+	struct bnge_dev *bd = pci_get_drvdata(pdev);
+
+	if (bd->bar0) {
+		pci_iounmap(pdev, bd->bar0);
+		bd->bar0 = NULL;
+	}
+}
+
 static int bnge_probe_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 {
+	struct bnge_dev *bd;
 	int rc;
 
 	if (pci_is_bridge(pdev))
@@ -100,13 +112,44 @@ static int bnge_probe_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 
 	bnge_print_device_info(pdev, ent->driver_data);
 
+	bd = bnge_devlink_alloc(pdev);
+	if (!bd) {
+		dev_err(&pdev->dev, "Devlink allocation failed\n");
+		rc = -ENOMEM;
+		goto err_pci_disable;
+	}
+
+	bnge_devlink_register(bd);
+
+	bd->bar0 = pci_ioremap_bar(pdev, 0);
+	if (!bd->bar0) {
+		dev_err(&pdev->dev, "Failed mapping BAR-0, aborting\n");
+		rc = -ENOMEM;
+		goto err_devl_unreg;
+	}
+
 	pci_save_state(pdev);
 
 	return 0;
+
+err_devl_unreg:
+	bnge_devlink_unregister(bd);
+	bnge_devlink_free(bd);
+
+err_pci_disable:
+	bnge_pci_disable(pdev);
+	return rc;
 }
 
 static void bnge_remove_one(struct pci_dev *pdev)
 {
+	struct bnge_dev *bd = pci_get_drvdata(pdev);
+
+	bnge_unmap_bars(pdev);
+
+	bnge_devlink_unregister(bd);
+	bnge_devlink_free(bd);
+
 	bnge_pci_disable(pdev);
 }
 
diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_devlink.c b/drivers/net/ethernet/broadcom/bnge/bnge_devlink.c
new file mode 100644
index 000000000000..ea7571dfb6bb
--- /dev/null
+++ b/drivers/net/ethernet/broadcom/bnge/bnge_devlink.c
@@ -0,0 +1,156 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (c) 2025 Broadcom.
+
+#include <linux/unaligned.h>
+#include <linux/pci.h>
+#include <linux/types.h>
+#include <net/devlink.h>
+
+#include "bnge.h"
+#include "bnge_devlink.h"
+
+static int bnge_dl_info_put(struct bnge_dev *bd, struct devlink_info_req *req,
+			    enum bnge_dl_version_type type, const char *key,
+			    char *buf)
+{
+	if (!strlen(buf))
+		return 0;
+
+	switch (type) {
+	case BNGE_VERSION_FIXED:
+		return devlink_info_version_fixed_put(req, key, buf);
+	case BNGE_VERSION_RUNNING:
+		return devlink_info_version_running_put(req, key, buf);
+	case BNGE_VERSION_STORED:
+		return devlink_info_version_stored_put(req, key, buf);
+	}
+
+	return 0;
+}
+
+static void bnge_vpd_read_info(struct bnge_dev *bd)
+{
+	struct pci_dev *pdev = bd->pdev;
+	unsigned int vpd_size, kw_len;
+	int pos, size;
+	u8 *vpd_data;
+
+	vpd_data = pci_vpd_alloc(pdev, &vpd_size);
+	if (IS_ERR(vpd_data)) {
+		pci_warn(pdev, "Unable to read VPD\n");
+		return;
+	}
+
+	pos = pci_vpd_find_ro_info_keyword(vpd_data, vpd_size,
+					   PCI_VPD_RO_KEYWORD_PARTNO, &kw_len);
+	if (pos < 0)
+		goto read_sn;
+
+	size = min_t(int, kw_len, BNGE_VPD_FLD_LEN - 1);
+	memcpy(bd->board_partno, &vpd_data[pos], size);
+
+read_sn:
+	pos = pci_vpd_find_ro_info_keyword(vpd_data, vpd_size,
+					   PCI_VPD_RO_KEYWORD_SERIALNO,
+					   &kw_len);
+	if (pos < 0)
+		goto exit;
+
+	size = min_t(int, kw_len, BNGE_VPD_FLD_LEN - 1);
+	memcpy(bd->board_serialno, &vpd_data[pos], size);
+
+exit:
+	kfree(vpd_data);
+}
+
+static int bnge_devlink_info_get(struct devlink *devlink,
+				 struct devlink_info_req *req,
+				 struct netlink_ext_ack *extack)
+{
+	struct bnge_dev *bd = devlink_priv(devlink);
+	int rc;
+
+	if (bd->dsn) {
+		char buf[32];
+		u8 dsn[8];
+		int rc;
+
+		put_unaligned_le64(bd->dsn, dsn);
+		sprintf(buf, "%02X-%02X-%02X-%02X-%02X-%02X-%02X-%02X",
+			dsn[7], dsn[6], dsn[5], dsn[4],
+			dsn[3], dsn[2], dsn[1], dsn[0]);
+		rc = devlink_info_serial_number_put(req, buf);
+		if (rc) {
+			NL_SET_ERR_MSG_MOD(extack, "Failed to set dsn");
+			return rc;
+		}
+	}
+
+	if (strlen(bd->board_serialno)) {
+		rc = devlink_info_board_serial_number_put(req,
+							  bd->board_serialno);
+		if (rc) {
+			NL_SET_ERR_MSG_MOD(extack,
+					   "Failed to set board serial number");
+			return rc;
+		}
+	}
+
+	rc = bnge_dl_info_put(bd, req, BNGE_VERSION_FIXED,
+			      DEVLINK_INFO_VERSION_GENERIC_BOARD_ID,
+			      bd->board_partno);
+	if (rc) {
+		NL_SET_ERR_MSG_MOD(extack, "Failed to set board part number");
+		return rc;
+	}
+
+	return rc;
+}
+
+static const struct devlink_ops bnge_devlink_ops = {
+	.info_get = bnge_devlink_info_get,
+};
+
+void bnge_devlink_free(struct bnge_dev *bd)
+{
+	struct devlink *devlink = priv_to_devlink(bd);
+
+	devlink_free(devlink);
+}
+
+struct bnge_dev *bnge_devlink_alloc(struct pci_dev *pdev)
+{
+	struct devlink *devlink;
+	struct bnge_dev *bd;
+
+	devlink = devlink_alloc(&bnge_devlink_ops, sizeof(*bd), &pdev->dev);
+	if (!devlink)
+		return NULL;
+
+	bd = devlink_priv(devlink);
+	pci_set_drvdata(pdev, bd);
+	bd->dev = &pdev->dev;
+	bd->pdev = pdev;
+
+	bd->dsn = pci_get_dsn(pdev);
+	if (!bd->dsn)
+		pci_warn(pdev, "Failed to get DSN\n");
+
+	bnge_vpd_read_info(bd);
+
+	return bd;
+}
+
+void bnge_devlink_register(struct bnge_dev *bd)
+{
+	struct devlink *devlink = priv_to_devlink(bd);
+
+	devlink_register(devlink);
+}
+
+void bnge_devlink_unregister(struct bnge_dev *bd)
+{
+	struct devlink *devlink = priv_to_devlink(bd);
+
+	devlink_unregister(devlink);
+}
diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_devlink.h b/drivers/net/ethernet/broadcom/bnge/bnge_devlink.h
new file mode 100644
index 000000000000..c6575255e650
--- /dev/null
+++ b/drivers/net/ethernet/broadcom/bnge/bnge_devlink.h
@@ -0,0 +1,18 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright (c) 2025 Broadcom */
+
+#ifndef _BNGE_DEVLINK_H_
+#define _BNGE_DEVLINK_H_
+
+enum bnge_dl_version_type {
+	BNGE_VERSION_FIXED,
+	BNGE_VERSION_RUNNING,
+	BNGE_VERSION_STORED,
+};
+
+void bnge_devlink_free(struct bnge_dev *bd);
+struct bnge_dev *bnge_devlink_alloc(struct pci_dev *pdev);
+void bnge_devlink_register(struct bnge_dev *bd);
+void bnge_devlink_unregister(struct bnge_dev *bd);
+
+#endif /* _BNGE_DEVLINK_H_ */
-- 
2.47.1


