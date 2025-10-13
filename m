Return-Path: <linux-kernel+bounces-851522-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E0F69BD6A60
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 00:40:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 6804335012F
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 22:40:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40ADF309DC0;
	Mon, 13 Oct 2025 22:37:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dnlunlRK"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80323308F0A
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 22:37:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760395055; cv=none; b=Nv8n/8s/qNft/L8pwiRNPyKRU6i6apy7fxLHDt820ARLpQQrf6z88wFLlNk/GFX6F3e+Q+cuYYr4t9t8cgnYgBdIZqdZU0NdtPm9YEUIqp4LmbX2FvqpcAGb8xuZkPMXLEdplPYWq4/F4IF8+scxXzNvWLmEkQm7uf5aGYpDPJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760395055; c=relaxed/simple;
	bh=4zPbmz/GYQ9Xc4qksgNbJt7SIAPFTibdbVLdYd1h/gE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Cwgxej6jNRTziwSadjWU8CP/7DRlBAHyTk4HVc1xdflGLc0kme9/b5hio7S2V0pZWXN1xkQOdGKTV3lLtc7V05ygxecqNUGyQgjrTueFMovrpIuJF5YAG55lTytLmtFdA5RKuK9sTyo/E8tmR+L2yakj26l+KehFJAPQNMRznkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dnlunlRK; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-46e3cdc1a6aso34760555e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 15:37:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760395052; x=1760999852; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=24Ftr7hy8LaAtQlSQs7NMC+zhhMlyRCsiGOHiR7triQ=;
        b=dnlunlRK644J2QsmWvcBtfyWvA82YIqPFf+VOvLYpFv7Gztn22N6DqtI30tJqdkYF0
         rU18qW5JSrU1ddKQon+W4nCG9bDiwRlaHDgoVgBw1MkurHlGlKMitcLHxXLmFbmsC89r
         0ToxW6PG+8v5yWrykkurjBuG+0q9ffTmlxps9Q5DkMrlVx3SvnZJkebztuQgmwq2ZWJh
         NaI2jb2N7y08lIjM8aZPQ8u6KCVJBbamEp1fmqrC386ZL3+c8bd8TxA7/ha6/Jy0h9P0
         6E+CdaTisV9z6yK9CsZloeCSoKpo7x4TUfrQWgbbgvIerYj4bel6Uq1SsffgP8MGekKk
         HFtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760395052; x=1760999852;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=24Ftr7hy8LaAtQlSQs7NMC+zhhMlyRCsiGOHiR7triQ=;
        b=nxkWV1MRArZpdifKcUYhtsHabjm5DIrWHOr6RK3GUihZ/QbRRS4vOECBcjHEcw6ms0
         +Q1yeHpxCuExAJbnOCZm7i999jPeBtaMYIJcR9A2ZQ5l9sX0t6PyM/AxEJsgBWj2+ZhW
         +7tQ9QEUdUT//fxL/URDOxVGQQG6ewE+TDVfoO0QNWpRUzYqToYywoktH2TTQHsEJ6K1
         dvvlgV4WMh5Ho/rGN+Isk4UiZejWnc7v+D0tqyVMkHYR+VZ9QfkkxtrTj4spaP5rmTzD
         b1hB60cE/JKfyQGeZPFQ//7jtvok0etREBo00UZNcKNc0g1kIPYnApTnUGE6ZDCKreQU
         Y66w==
X-Forwarded-Encrypted: i=1; AJvYcCW7PWSxSeBCawXh3wHAYKn6uzPrGOWZJPGf8BHd8Emf032lqlIpYDWqEy9rlDByWXen1zY9qEWmQcJSuVY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwcSSg+FR8b63fW99rEAMd8PNYadnCw/gCq/K0+j3foS4XQx3hJ
	BFIGf00lOm3vvjFyut1+AwMUOWYprpGB2oJ28If4/gz7FRu4YVT4GiFP
X-Gm-Gg: ASbGncvDcZ7WOhGSy1ZvEtbVfjY3y9gPQIeGcjoqSRCz11uiUO5LL4X8oCm8JbYFhTu
	O+Qq72gqEAxEGdmeePmXaKpF5d6Uf8jwIUircfcBC7LuA6nFcW5wWXUfFRp5UFIlmMujDMTmyuT
	CsRS06QGlQwagNs1cEHA1yDcYa3OSFXChM9VQIeynL9xF2ReBR+xgSh+9Pp6Dv+MHt7wtytt5zL
	ev5frS6+Q98Z0RKKyKPRNSuf0KXy6Myde12R9lsnqBYgFnHDTRJLOiGUK7edi4uq/Q5qN+VuL55
	FY4kdFYlX/4EEsVt21p4o7ZjWCMqoDV90tyDENUshyevoSQdT87eNBRlPWUGs8W3l9MsoZB0SpX
	c2SRf+8k1i4WncwgnUgYs7U3wHaklmysBZ4HDoXLzhBiLsdqGRc2ZSoTM2Vrdp9re7nrFUwb374
	LDnuVoDJ+8
X-Google-Smtp-Source: AGHT+IEamLZvij5RfRNleTzFAVlezTx1ysHtzuQYGAsX+iOPJIp3KIAoTV4KFic1Q1UmEwJsLYhfCg==
X-Received: by 2002:a7b:cc06:0:b0:46e:7dbf:6cc2 with SMTP id 5b1f17b1804b1-46fa296e763mr131783135e9.8.1760395051548;
        Mon, 13 Oct 2025 15:37:31 -0700 (PDT)
Received: from Ansuel-XPS24 (93-34-92-177.ip49.fastwebnet.it. [93.34.92.177])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-46fb49d0307sm204948955e9.18.2025.10.13.15.37.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Oct 2025 15:37:31 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Christian Marangi <ansuelsmth@gmail.com>,
	stable@vger.kernel.org,
	=?UTF-8?q?Krzysztof=20Ha=C5=82asa?= <khalasa@piap.pl>
Subject: [PATCH] PCI/sysfs: enforce single creation of sysfs entry for pdev
Date: Tue, 14 Oct 2025 00:37:16 +0200
Message-ID: <20251013223720.8157-1-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

In some specific scenario it's possible that the
pci_create_resource_files() gets called multiple times and the created
entry actually gets wrongly deleted with extreme case of having a NULL
pointer dereference when the PCI is removed.

This mainly happen due to bad timing where the PCI bus is adding PCI
devices and at the same time the sysfs code is adding the entry causing
double execution of the pci_create_resource_files function and kernel
WARNING.

To be more precise there is a race between the late_initcall of
pci-sysfs with pci_sysfs_init and PCI bus.c pci_bus_add_device that also
call pci_create_sysfs_dev_files.

With correct amount of ""luck"" (or better say bad luck)
pci_create_sysfs_dev_files in bus.c might be called with pci_sysfs_init
is executing the loop.

This has been reported multiple times and on multiple system, like imx6
system, ipq806x systems...

To address this, imlement multiple improvement to the implementation:
1. Add a bool to pci_dev to flag when sysfs entry are created
   (sysfs_init)
2. Implement a simple completion to wait pci_sysfs_init execution.
3. Permit additional call of pci_create_sysfs_dev_files only after
   pci_sysfs_init has finished.

With such logic in place, we address al kind of timing problem with
minimal change to any driver.

A notice worth to mention is that the remove function are not affected
by this as the pci_remove_resource_files have enough check in place to
always work and it's always called by pci_stop_dev.

Cc: stable@vger.kernel.org
Reported-by: Krzysztof Hałasa <khalasa@piap.pl>
Closes: https://bugzilla.kernel.org/show_bug.cgi?id=215515
Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 drivers/pci/pci-sysfs.c | 34 +++++++++++++++++++++++++++++-----
 include/linux/pci.h     |  1 +
 2 files changed, 30 insertions(+), 5 deletions(-)

diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
index 71a36f57ef57..cab3aa27f947 100644
--- a/drivers/pci/pci-sysfs.c
+++ b/drivers/pci/pci-sysfs.c
@@ -14,6 +14,7 @@
  */
 
 #include <linux/bitfield.h>
+#include <linux/completion.h>
 #include <linux/kernel.h>
 #include <linux/sched.h>
 #include <linux/pci.h>
@@ -37,6 +38,7 @@
 #endif
 
 static int sysfs_initialized;	/* = 0 */
+static DECLARE_COMPLETION(sysfs_init_completion);
 
 /* show configuration fields */
 #define pci_config_attr(field, format_string)				\
@@ -1652,12 +1654,32 @@ static const struct attribute_group pci_dev_resource_resize_group = {
 	.is_visible = resource_resize_is_visible,
 };
 
+static int __pci_create_sysfs_dev_files(struct pci_dev *pdev)
+{
+	int ret;
+
+	ret = pci_create_resource_files(pdev);
+	if (ret)
+		return ret;
+
+	/* on success set sysfs correctly created */
+	pdev->sysfs_init = true;
+	return 0;
+}
+
 int __must_check pci_create_sysfs_dev_files(struct pci_dev *pdev)
 {
 	if (!sysfs_initialized)
 		return -EACCES;
 
-	return pci_create_resource_files(pdev);
+	/* sysfs entry already created */
+	if (pdev->sysfs_init)
+		return 0;
+
+	/* wait for pci_sysfs_init */
+	wait_for_completion(&sysfs_init_completion);
+
+	return __pci_create_sysfs_dev_files(pdev);
 }
 
 /**
@@ -1678,21 +1700,23 @@ static int __init pci_sysfs_init(void)
 {
 	struct pci_dev *pdev = NULL;
 	struct pci_bus *pbus = NULL;
-	int retval;
+	int retval = 0;
 
 	sysfs_initialized = 1;
 	for_each_pci_dev(pdev) {
-		retval = pci_create_sysfs_dev_files(pdev);
+		retval = __pci_create_sysfs_dev_files(pdev);
 		if (retval) {
 			pci_dev_put(pdev);
-			return retval;
+			goto exit;
 		}
 	}
 
 	while ((pbus = pci_find_next_bus(pbus)))
 		pci_create_legacy_files(pbus);
 
-	return 0;
+exit:
+	complete_all(&sysfs_init_completion);
+	return retval;
 }
 late_initcall(pci_sysfs_init);
 
diff --git a/include/linux/pci.h b/include/linux/pci.h
index f3f6d6dee3ae..f417a0528f01 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -480,6 +480,7 @@ struct pci_dev {
 	unsigned int	non_mappable_bars:1;	/* BARs can't be mapped to user-space  */
 	pci_dev_flags_t dev_flags;
 	atomic_t	enable_cnt;	/* pci_enable_device has been called */
+	bool		sysfs_init;	/* sysfs entry has been created */
 
 	spinlock_t	pcie_cap_lock;		/* Protects RMW ops in capability accessors */
 	u32		saved_config_space[16]; /* Config space saved at suspend time */
-- 
2.51.0


