Return-Path: <linux-kernel+bounces-858667-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 90C8FBEB60B
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 21:22:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 46E4F404833
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 19:22:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EAB72DF3FD;
	Fri, 17 Oct 2025 19:22:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Z0iThYoP"
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8506624DCE5
	for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 19:22:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760728927; cv=none; b=Oy6r5/pVGUGpMRp5bQukKt/1vgM6mvJz5liKv2pT0HH4BrUng+rXbED2LM9IzDEt6Mj9gQJ3KERKVW5a8mGK0beSAcLfogyaNjOPAdrRVZV3aPqdLkYHhdzDUkAKl3+ZZOoykf6duLh2PDNqqgXu0O7l2QEAwG7lQy/z1vnFdgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760728927; c=relaxed/simple;
	bh=zSl/sOQ3KBk7i8ADPKh+1Wp21VP6JAJtCm/h3uQYmao=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=qdVHC3IiCSaO4ct2E++E3Tx8IJDvH4wCw3l5/F3UCa7XLqmIEzUhSyRPRPTLKGSuetWCpoEw3l9VvEMPPPrWXXrsgjy5W1XNgVazNoDbuQmhWcYZgVS0FMPFyVr7WOFfSn3mUy2Kim3HDZtya8W9QjFS9f4t/Ax0rRTHHcORUGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Z0iThYoP; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-7833765433cso3092479b3a.0
        for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 12:22:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1760728925; x=1761333725; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4Zj4VXFFqRvnlzu2xKxM1rLyOed+PBAcmGOJAFPxXKA=;
        b=Z0iThYoPGdm/9OalWx+pvZgYMzSdnMKZaVrz6WG1RY3DE2MdlseR2F8fbjOqIFtCz8
         WmGI071eQBtMl097UEQ6SfOQOQgaA9B4g6J93mU86Vzq5B0cfkasic5q2vgxSVPqsK+S
         GTFUPUakUD519hj7Gum2E3nJe+tchOTOlnLU0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760728925; x=1761333725;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4Zj4VXFFqRvnlzu2xKxM1rLyOed+PBAcmGOJAFPxXKA=;
        b=T9BsEF5h8beoM87oeXTB7kJrdUCaWHBjZbqU1eIDpnJFCtlk+VF3zXN+sxSlDKXQo+
         o+EcBnnkggab0nRgYtxClmuwRSjgvQuBbW0YxeBXxWj8RD7qJ5QfSYivZxsc7Ki+9chi
         zYmHl3gxLCYBfpkNwiELmJVZNLw23yPB3/zYX6fp9ey3L8yEhERPqQ8c+I9QN+s02XtD
         2BPzbp7fM1WWACTZdgbeE/hmNWKoOgqhm0iWnSkKvcN6EpgOCkfzFzuK6IahYYmAy552
         x/iwhd0zafa7g6UnvgkdvotVCSSfZOQUH54o85rch/aWl4KTThYd0bPaP3W/ddUtqFNB
         VzNg==
X-Forwarded-Encrypted: i=1; AJvYcCWLcZRqbkboR6pZJaEru9ZALy5z4uT7TXFOJz88bTypWYiygUGXbnil0GSmXsmnL2+LvZNqgUwqniAYzbU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxHH2bjhwgGawA+etkOms1niCRZybTd8WPB9Wlso4SAX7llKsYv
	gxkTaSnj+QRjS69pCx0WOFYNPaW+b+fZ3zencUGgT+hlrYQ/Hs4ommRxandQUCDkew==
X-Gm-Gg: ASbGncvnhJrOxT0NdVEtBdHXDLBB1+O0GdLHwWgI+EFHME/JoH0eXkQu/RMjFI6334j
	K3viwdPzJHmOI2PnlwJkRG0/ISK62dXg0clS6MiPe4/hmC6NC8ZlsfIDDDtRKCXzfWQKTy725n3
	SX039s1eFgfz1lmis41C+Vbhh9NfZCl8WR96SvLis4xE7JT6eq0mp7qCwkFjRBRYZjpgK2zSrTF
	pR9maFndnjh0lxGlDsRKp9vyrRpDAZBPsvtvLJVMBV1f1ZgrpZmD2qK/uE8jmAC7H3hEnVfTHqk
	bea1WScKK3z80BTVN+cRBstKlP4rOOGJnni2PDrGZ/9jEAPJz23owciiYqKF3k6P3k/XrmZ5/Rn
	9ZNv1V4ZDldzAI1Y2aHIO5xodqJRVJKs0ccCY0u/RF3eWkJ4j4FaWbjkZKi39ryCFzvBDj7tDbz
	RI+xWZ+X01o5IVEEytAkhbr9UJXofhwQrIySyLcxrSE7b5EIKS
X-Google-Smtp-Source: AGHT+IFAAbkjfr0le6ea1oHImV4kAyDrBstZFai2T458GK8mhda6jZiJODFckP73bHLy/lAnTldVpg==
X-Received: by 2002:a05:6a20:9144:b0:2cc:692a:3a2b with SMTP id adf61e73a8af0-334a85640d4mr6572099637.16.1760728924873;
        Fri, 17 Oct 2025 12:22:04 -0700 (PDT)
Received: from localhost ([2a00:79e0:2e7c:8:5ca9:a8d0:7547:32c6])
        by smtp.gmail.com with UTF8SMTPSA id 41be03b00d2f7-b6a76b33a27sm511259a12.25.2025.10.17.12.22.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Oct 2025 12:22:04 -0700 (PDT)
From: Brian Norris <briannorris@chromium.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	linux-pm@vger.kernel.org,
	Lukas Wunner <lukas@wunner.de>,
	linux-pci@vger.kernel.org,
	Brian Norris <briannorris@chromium.org>
Subject: [PATCH v2] PCI/PM: Prevent runtime suspend before devices are fully initialized
Date: Fri, 17 Oct 2025 12:21:23 -0700
Message-ID: <20251017122123.v2.1.I60a53c170a8596661883bd2b4ef475155c7aa72b@changeid>
X-Mailer: git-send-email 2.51.0.858.gf9c4a03a3a-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Today, it's possible for a PCI device to be created and
runtime-suspended before it is fully initialized. When that happens, the
device will remain in D0, but the suspend process may save an
intermediate version of that device's state -- for example, without
appropriate BAR configuration. When the device later resumes, we'll
restore invalid PCI state and the device may not function.

Prevent runtime suspend for PCI devices by deferring pm_runtime_enable()
until we've fully initialized the device.

More details on how exactly this may occur:

1. PCI device is created by pci_scan_slot() or similar
2. As part of pci_scan_slot(), pci_pm_init() enables runtime PM; the
   device starts "active" and we initially prevent (pm_runtime_forbid())
   suspend -- but see [*] footnote
3. Underlying 'struct device' is added to the system (device_add());
   runtime PM can now be configured by user space
4. PCI device receives BAR configuration
   (pci_assign_unassigned_bus_resources(), etc.)
5. PCI device is added to the system in pci_bus_add_device()

The device may potentially suspend between #3 and #4.

[*] By default, pm_runtime_forbid() prevents suspending a device; but by
design, this can be overridden by user space policy via

  echo auto > /sys/bus/pci/devices/.../power/control

Thus, the above #3/#4 sequence is racy with user space (udev or
similar).

Notably, many PCI devices are enumerated at subsys_initcall time and so
will not race with user space. However, there are several scenarios
where PCI devices are created later on, such as with hotplug or when
drivers (pwrctrl or controller drivers) are built as modules.

Signed-off-by: Brian Norris <briannorris@chromium.org>
Cc: <stable@vger.kernel.org>
---

Changes in v2:
 * Update CC list
 * Rework problem description
 * Update solution: defer pm_runtime_enable(), instead of trying to
   get()/put()

 drivers/pci/bus.c | 3 +++
 drivers/pci/pci.c | 1 -
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/bus.c b/drivers/pci/bus.c
index f26aec6ff588..fc66b6cb3a54 100644
--- a/drivers/pci/bus.c
+++ b/drivers/pci/bus.c
@@ -14,6 +14,7 @@
 #include <linux/of.h>
 #include <linux/of_platform.h>
 #include <linux/platform_device.h>
+#include <linux/pm_runtime.h>
 #include <linux/proc_fs.h>
 #include <linux/slab.h>
 
@@ -375,6 +376,8 @@ void pci_bus_add_device(struct pci_dev *dev)
 		put_device(&pdev->dev);
 	}
 
+	pm_runtime_enable(&dev->dev);
+
 	if (!dn || of_device_is_available(dn))
 		pci_dev_allow_binding(dev);
 
diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index b14dd064006c..f792164fa297 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -3226,7 +3226,6 @@ void pci_pm_init(struct pci_dev *dev)
 	pci_pm_power_up_and_verify_state(dev);
 	pm_runtime_forbid(&dev->dev);
 	pm_runtime_set_active(&dev->dev);
-	pm_runtime_enable(&dev->dev);
 }
 
 static unsigned long pci_ea_flags(struct pci_dev *dev, u8 prop)
-- 
2.51.0.858.gf9c4a03a3a-goog


