Return-Path: <linux-kernel+bounces-857060-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 136C3BE5CA9
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 01:28:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C60F04E3869
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 23:28:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 997FB2E6137;
	Thu, 16 Oct 2025 23:28:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="nlcTtEqO"
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C2C72E1F08
	for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 23:28:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760657297; cv=none; b=AQSWtT58cNhAmLzTwBL3F9/4J5wPe8oXGbw1u6x6+Wl7m6LEDBciW6mSdhe5s2w2H41/5ozKv3h+o0EG6BoLPuf/JrDuPOth2x0NXdB5Y/QTy5x8sjqHJkEOom7RLRzPpwwyvn9AyYyDSedBSLgOV24m4Z+aLf28l6B426swHu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760657297; c=relaxed/simple;
	bh=XJoRXhF6cct+u5hqeBr/GjrKmq9CEKau2+FBHdOwe7Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bwI0EG1mVdxbml+u3BQ8gDcpNpaMPjFx4w2uMxQXH6Zxv609VqZ6HCLPUO9qvDknWetrb28x8ASldT1iK0Benga1hO/u53d23wbi1fLxDn+qZTNYbKJMCqfonBcR9f+rusOigpgTwe+FbvMLwhMClxahF1KeMCkjH8zpINN7I9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=nlcTtEqO; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-76e2ea933b7so1265189b3a.1
        for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 16:28:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1760657294; x=1761262094; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=VDHKL7YrbYj0WMr/qaC61DmFE96g6L5ksIAhfdoxQrQ=;
        b=nlcTtEqOnd54qW/ICO8glTxNOt8FmeJe9owrl9qhvsPQpg/B2Mp2KNJrvMtdul+Qc0
         5ZrKRVGXHR9+Sciv6jft3dF9eSOcsgAtHbQadNAfu0F+YCXY0RCAJj29LAAA/rB3arHR
         zik0LCswwZQ/Ug93I4EKLk4SwByaxOXB4G2HA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760657294; x=1761262094;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VDHKL7YrbYj0WMr/qaC61DmFE96g6L5ksIAhfdoxQrQ=;
        b=pNakvCl0gYKr4zhDZ+a0jbMCRFe0wCtBUPEbqWprX9zJzqKFR3Vudyp7IPPUDKD9fL
         mlvEoCESZKtjOmUFsCJKokawzevDq1ekzrlOuCC7xIAIgZQqmxi2XOQy+my0dprqLbDi
         KubEtnACGb5mkfcGEzR41KDkr6rPP/RwJqnTXQwpXopImSFjBrtE36pt5IH7FNIeN9p3
         jkAoM4mHBfF3rv9tR2nK9HlQOcNN8JRFZicLUvbpJWTuR2zn3fPnVia8FiaCAWURTZsv
         NK5s6PXPAAv69/BisoKLF5yrlVSTw2Jo5rsCsW6BYZwI9Hfz5sYpqK7Z25ElaDgPQ2hv
         3/Zg==
X-Gm-Message-State: AOJu0YzOAj4OYbAt4MX8CH0FshAKNgyvumTqabcUQ+QfKlncagHjyf5u
	8PnB3PBguHh0OQvspuSYG9aL+G8/peU6QKzg+mrS7DYwVhClBS/sZapJafP0/Qkpbw==
X-Gm-Gg: ASbGncvXtNikjd70a1dXqJ3CnJu/9FfJM1gyqsXXHWdUz5bBxjACmPj9R81mPeIR2gt
	8d6wwyCCnfvBPiCu5MlVyTc6kdQXVX89gtlBu4pmZsbQqdD0ddNFnOQkPJ0UOZFG0kFoRCZDsL8
	Obng6lgsmZudp8zTKar1JabEYggWz7pMafB42X+3+XtyReGTaNCzyK0XZeGs25dFMOmpMsKs/aH
	yzGKLdQo7mGImCvxUor1S7FbWMZhsG/Ff27sXIToHul/ktttQPZoA3ApR5rg6TB6GkGxfiSIdhV
	dpDufOVkwIiftdxQ/17huFdNeIGBbpnL1+9xnZtn5uk0MDpR87IBM5wNlXCSHMrp8+87QstkuDL
	ruWUngqpvxTGTJRm0vq5Walhkw9kmZ1wh4dei2bOJU+LFqM7tUH1Hhrj+nWUCbvYYSSbnfZ2prB
	SWw5Xx1TmguPdMeMOZCqaby9FVyIQJmZK4VppCSw==
X-Google-Smtp-Source: AGHT+IHptz2Viou3aQb7JTKgXj8lqBa3xVm9ubMw1J3oe5c1h0nSfI0VxDkbrkw3mL1kDx6q4igwAQ==
X-Received: by 2002:a05:6a20:6a28:b0:32d:b925:22ab with SMTP id adf61e73a8af0-334a78fbd98mr2663524637.17.1760657294603;
        Thu, 16 Oct 2025 16:28:14 -0700 (PDT)
Received: from localhost ([2a00:79e0:2e7c:8:98f9:84ca:9891:3fd2])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-7992b060b59sm24127004b3a.2.2025.10.16.16.28.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Oct 2025 16:28:13 -0700 (PDT)
From: Brian Norris <briannorris@chromium.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Lukas Wunner <lukas@wunner.de>,
	linux-pci@vger.kernel.org,
	Brian Norris <briannorris@chromium.org>,
	stable@vger.kernel.org
Subject: [PATCH] PCI/PM: Prevent runtime suspend before devices are fully initialized
Date: Thu, 16 Oct 2025 15:53:35 -0700
Message-ID: <20251016155335.1.I60a53c170a8596661883bd2b4ef475155c7aa72b@changeid>
X-Mailer: git-send-email 2.51.0.858.gf9c4a03a3a-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

PCI devices are created via pci_scan_slot() and similar, and are
promptly configured for runtime PM (pci_pm_init()). They are initially
prevented from suspending by way of pm_runtime_forbid(); however, it's
expected that user space may override this via sysfs [1].

Now, sometime after initial scan, a PCI device receives its BAR
configuration (pci_assign_unassigned_bus_resources(), etc.).

If a PCI device is allowed to suspend between pci_scan_slot() and
pci_assign_unassigned_bus_resources(), then pci-driver.c will
save/restore incorrect BAR configuration for the device, and the device
may cease to function.

This behavior races with user space, since user space may enable runtime
PM [1] as soon as it sees the device, which may be before BAR
configuration.

Prevent suspending in this intermediate state by holding a runtime PM
reference until the device is fully initialized and ready for probe().

[1] echo auto > /sys/bus/pci/devices/.../power/control

Cc: <stable@vger.kernel.org>
Signed-off-by: Brian Norris <briannorris@chromium.org>
---

 drivers/pci/bus.c | 7 +++++++
 drivers/pci/pci.c | 6 ++++++
 2 files changed, 13 insertions(+)

diff --git a/drivers/pci/bus.c b/drivers/pci/bus.c
index f26aec6ff588..227a8898acac 100644
--- a/drivers/pci/bus.c
+++ b/drivers/pci/bus.c
@@ -14,6 +14,7 @@
 #include <linux/of.h>
 #include <linux/of_platform.h>
 #include <linux/platform_device.h>
+#include <linux/pm_runtime.h>
 #include <linux/proc_fs.h>
 #include <linux/slab.h>
 
@@ -375,6 +376,12 @@ void pci_bus_add_device(struct pci_dev *dev)
 		put_device(&pdev->dev);
 	}
 
+	/*
+	 * Now that resources are assigned, drop the reference we grabbed in
+	 * pci_pm_init().
+	 */
+	pm_runtime_put_noidle(&dev->dev);
+
 	if (!dn || of_device_is_available(dn))
 		pci_dev_allow_binding(dev);
 
diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index b14dd064006c..06a901214f2c 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -3226,6 +3226,12 @@ void pci_pm_init(struct pci_dev *dev)
 	pci_pm_power_up_and_verify_state(dev);
 	pm_runtime_forbid(&dev->dev);
 	pm_runtime_set_active(&dev->dev);
+	/*
+	 * We cannot allow a device to suspend before its resources are
+	 * configured. Otherwise, we may allow saving/restoring unexpected BAR
+	 * configuration.
+	 */
+	pm_runtime_get_noresume(&dev->dev);
 	pm_runtime_enable(&dev->dev);
 }
 
-- 
2.51.0.858.gf9c4a03a3a-goog


