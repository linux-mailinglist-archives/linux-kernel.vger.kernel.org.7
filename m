Return-Path: <linux-kernel+bounces-780110-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E32EB2FDB9
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 17:06:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B8F161D013D0
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 14:59:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACBA12F6193;
	Thu, 21 Aug 2025 14:59:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="dsIK0u11"
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8639D2F4A12
	for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 14:58:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755788341; cv=none; b=HGgxLsVuv4WASZKQ10U9X22pTy5xEbwY3XRKX8Ue3UhgS5TZce86mECKINZiVpU11IldC+RbYLR1WpyjyND0j4VDK6GIAgHd9n4E4KQF3gEPSNOnh7TH5dfiq89KAkUKGMx3Hex3mvYzYPdzHqgBr9BDWQd2RNvE+NRssahfDx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755788341; c=relaxed/simple;
	bh=Tz/VZwFoOgQ0Y4zvdRFkegcxdyj0tPL1i1gvMWA7+7Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=N1J/utW/F7JPnEupfFGusnWIqOdnMWGGac1s4Jgb4077pKh7lE95fiVhaASf5/0RKKDcNHaLhcxvW7WoGSXiW3a0PgrjHaNkGzNrB/AYkwBAkQ0XG6Py5rT8M7GcbGrV/02wsNbviq9F5lTJJt9DCpU2Z7q/tB+IbhX3WLs94+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=dsIK0u11; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2445827be70so12281475ad.3
        for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 07:58:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1755788339; x=1756393139; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=aaLinSTBsg2Heqd5n/Y8HcIpri3LMWuuwE5FV81Iuv8=;
        b=dsIK0u11Uj2shhL/rM82sHsgOs/rTJuf7U4i6Kw/NZ8/E4cl4wQD1yLrHaQ9XGISGH
         OEn9H+qpR5Y9JniVagCZSBGmOoOO6LIoVMd/7lGT8VLhnzWXmxrRTVmhO02hFuMqn75o
         bIfH5DLdHzk6EegT9kMohlQENMXNSInMHb2sI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755788339; x=1756393139;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aaLinSTBsg2Heqd5n/Y8HcIpri3LMWuuwE5FV81Iuv8=;
        b=f7qFX9yp3lRFKW+WCY4aVHPKSuVlm2ti4GYMBHmOb3sb4YIYBnvIIHKsnm91IvpU8P
         p9y+fjKx1e4/MTR0ClrRovkFvfAZ7QXMOJ3QcuB9W8kGi2cyPcOBpqSWsfLQRPPCOsyO
         tfWj/kRd1m5trWVc61YYkAIaULyQCE4JUYxV9f/S435N+KElZCUpSrYbVCZ3WZRmSKaC
         O9vpGSsQJ++56ffMoC7Wr2aNMYoDVxlzPVgRhv26syxGB1y9UlQtl5WJ4T143BOjjn+w
         cp5p/9vGu43Y+lD+Tg/fxzxujpFGcyok/t4u+jYbBd7owPGzcHgmGFFoS1LorJ6nVydZ
         x/CA==
X-Gm-Message-State: AOJu0YzKLkbprg8x/FaB8HadxI6ZXSglnQptns3ryCL8DjtZe5YwuqZ4
	7ARGhwPtcZ0goPuheTJs91KcnVLq5Kc/PYoCTjSoQNNhOWsfic3RgzbLjx0vANQrEA==
X-Gm-Gg: ASbGnctDZxeXZvkXqoRZnC7ph7a/AjQeIA51DW56D39xM6DTSdSaX6jXUn2t6rNR+yb
	8FZo+I/Bu9um14E+vqhQ5ozCIRt7l9oKuRalM6XCTorS2aJZAd4iBUhnIGuiph/LNOPrOWZcTr/
	cxewzXmTEmlw5+prQc1dW1i6TBAUH1WxxJXVpoeYws7O4abqiXfvdDRe9VwYDIa2g8EcNZUJzd9
	P8acxkg+bbT8hAZg8+f70Fms1ekCV5MDasUs6D41QJxC5Kc7kx96wAYI5v3awmWTVs27/LzQdjJ
	tZ3ajVzywAFZGAxx6Ag6xnF4HGMXBBp+UTgJHEBeRvsLt3wveGVKCSItS9NNeyWbkns7xcGJLPl
	SvGpkSRMpQxbiXH58mCMrVTkyn3ZJLIkd3NQwW76s95HJbvUO663jf2KglzctQTykugRt0fE=
X-Google-Smtp-Source: AGHT+IF5jd207eAHYlWkozFvV4W7rHhk80wb+yRJAbAhw3XVWRLn8xbVDIiu2vgUdgY7fOZrtSdwdQ==
X-Received: by 2002:a17:902:d4cd:b0:246:571:4b21 with SMTP id d9443c01a7336-24605714c9dmr35347695ad.58.1755788338577;
        Thu, 21 Aug 2025 07:58:58 -0700 (PDT)
Received: from localhost ([2a00:79e0:2e14:7:2283:604f:d403:4841])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-245ed33aa3esm58509915ad.24.2025.08.21.07.58.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Aug 2025 07:58:58 -0700 (PDT)
From: Brian Norris <briannorris@chromium.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	Brian Norris <briannorris@google.com>,
	stable@vger.kernel.org,
	Brian Norris <briannorris@chromium.org>
Subject: [PATCH] PCI/PM: Ensure power-up succeeded before restoring MMIO state
Date: Thu, 21 Aug 2025 07:58:12 -0700
Message-ID: <20250821075812.1.I2dbf483156c328bc4a89085816b453e436c06eb5@changeid>
X-Mailer: git-send-email 2.51.0.rc1.193.gad69d77794-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Brian Norris <briannorris@google.com>

As the comments in pci_pm_thaw_noirq() suggest, pci_restore_state() may
need to restore MSI-X state in MMIO space. This is only possible if we
reach D0; if we failed to power up, this might produce a fatal error
when touching memory space.

Check for errors (as the "verify" in "pci_pm_power_up_and_verify_state"
implies), and skip restoring if it fails.

This mitigates errors seen during resume_noirq, for example, when the
platform did not resume the link properly.

Cc: stable@vger.kernel.org
Signed-off-by: Brian Norris <briannorris@google.com>
Signed-off-by: Brian Norris <briannorris@chromium.org>
---

 drivers/pci/pci-driver.c | 12 +++++++++---
 drivers/pci/pci.c        | 13 +++++++++++--
 drivers/pci/pci.h        |  2 +-
 3 files changed, 21 insertions(+), 6 deletions(-)

diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
index 302d61783f6c..d66d95bd0ca2 100644
--- a/drivers/pci/pci-driver.c
+++ b/drivers/pci/pci-driver.c
@@ -557,7 +557,13 @@ static void pci_pm_default_resume(struct pci_dev *pci_dev)
 
 static void pci_pm_default_resume_early(struct pci_dev *pci_dev)
 {
-	pci_pm_power_up_and_verify_state(pci_dev);
+	/*
+	 * If we failed to reach D0, we'd better not touch MSI-X state in MMIO
+	 * space.
+	 */
+	if (pci_pm_power_up_and_verify_state(pci_dev))
+		return;
+
 	pci_restore_state(pci_dev);
 	pci_pme_restore(pci_dev);
 }
@@ -1101,8 +1107,8 @@ static int pci_pm_thaw_noirq(struct device *dev)
 	 * in case the driver's "freeze" callbacks put it into a low-power
 	 * state.
 	 */
-	pci_pm_power_up_and_verify_state(pci_dev);
-	pci_restore_state(pci_dev);
+	if (!pci_pm_power_up_and_verify_state(pci_dev))
+		pci_restore_state(pci_dev);
 
 	if (pci_has_legacy_pm_support(pci_dev))
 		return 0;
diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index e698278229f2..c75fec3b094f 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -3144,10 +3144,19 @@ void pci_d3cold_disable(struct pci_dev *dev)
 }
 EXPORT_SYMBOL_GPL(pci_d3cold_disable);
 
-void pci_pm_power_up_and_verify_state(struct pci_dev *pci_dev)
+int pci_pm_power_up_and_verify_state(struct pci_dev *pci_dev)
 {
-	pci_power_up(pci_dev);
+	int ret;
+
+	ret = pci_power_up(pci_dev);
 	pci_update_current_state(pci_dev, PCI_D0);
+
+	if (ret < 0 && pci_dev->current_state == PCI_D3cold) {
+		dev_err(&pci_dev->dev, "Failed to power up device: %d\n", ret);
+		return ret;
+	}
+
+	return 0;
 }
 
 /**
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 1c48bc447f58..87ad201417d5 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -233,7 +233,7 @@ void pci_dev_adjust_pme(struct pci_dev *dev);
 void pci_dev_complete_resume(struct pci_dev *pci_dev);
 void pci_config_pm_runtime_get(struct pci_dev *dev);
 void pci_config_pm_runtime_put(struct pci_dev *dev);
-void pci_pm_power_up_and_verify_state(struct pci_dev *pci_dev);
+int pci_pm_power_up_and_verify_state(struct pci_dev *pci_dev);
 void pci_pm_init(struct pci_dev *dev);
 void pci_ea_init(struct pci_dev *dev);
 void pci_msi_init(struct pci_dev *dev);
-- 
2.51.0.rc1.193.gad69d77794-goog


