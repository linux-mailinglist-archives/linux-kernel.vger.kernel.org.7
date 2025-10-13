Return-Path: <linux-kernel+bounces-851173-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id B8E46BD5B00
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 20:20:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D49FA4F09A1
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 18:20:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 199A62D3731;
	Mon, 13 Oct 2025 18:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="Be9U0+IE"
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B76B02D24AB
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 18:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760379600; cv=none; b=Or6D/CrYcbYNWYbtkcN3mKw/S7sbG1u3VXBuNLT5rLSobkHlahQsgegx9wMsoeccj8AAzRYJcuw3h53e9Rvnr3H9/TZQqK6TlXZcTSlLjhHuaCtcDEpoxI/BKkPHCoPvuu7HfAhvdzy77w/OEQoLlbLffmks4EGkLKlGZa6gMyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760379600; c=relaxed/simple;
	bh=W4qMuSbsChk18yYhdcQSWgTQQXNPzIkCryRUuq5LDB8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=btJwXj0DUUdarC96U3Rs+ryV6KIyqqHD6GQMLRXYfH85rApvIe1JPen+fOaV439zDhFvvJ/La1LkkVeGsH/yyXiDhfoxxBrBf/WQfCN8WPizUca4FE/g66UAHdodfN6+HqFc/c6wcu8ctliBpMk+JKb356KzxkIPO53iEifI6wg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=Be9U0+IE; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-27eed7bdfeeso49681185ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 11:19:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1760379598; x=1760984398; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qgS28ji+B97qItp4AzHMdPygisOKxR0wELKF1U991to=;
        b=Be9U0+IEmY2bixjR6EMvpxfgG1dEWgepTjO9gCC4qvjRpzjZq4x7MJn7ZroUB1EWov
         xC455odP1XGOD5t9G7tHJUjzUpkM1/9cIjJa0s9UAmarZkTiYBcI9PpWVQX4tWMWmzg5
         WH4KEA8svKHg7HBynIZ19R9K0Cqpv1jbtR3WOr2z64XtsKKYmByLPIhgffeHm4fjg5WA
         3z0RmqRWJg5wPVqivku2dDFkkIWgieihmi+j8RVLPCGIrR2eqKkRxVtkECCRLmnwTZBG
         CKEHulhcFzh/OSjfXqeQeUIuleqPFGi2nOICG/gen9vuOoZDMIeTekunpeuzuomaHxZq
         gvoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760379598; x=1760984398;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qgS28ji+B97qItp4AzHMdPygisOKxR0wELKF1U991to=;
        b=vY5lwOozLa9OOMzU01rk3c86s06KaighQKElL2Rr5gMEAG7DG6pC4onx8Ff+X4MOMN
         yk+d1b4WpfPbL3eJ9VNLVVTkFJVfksp3IP8ad6aTy2IdEVWJSbxjdtE/uopOpY1mhYXa
         YK4iUz7bhOF0mZV3AHFoaezbrJDzUMSh6BPG+kHWapANZnckGXgmbVG11OHQRyxmbSV4
         nPaEp6qlWwlE8xpEY5ZthTUZCVhLMQmsGCbX3asVQr7wcB4AYTDdOZhPuGfSs8dCBi4L
         4PFrXqEN6hoQEaZPGFbAZbxUJBUtdl7EsYv7fUCiloagEJgYrxJWuUISa5i689Gag6Io
         avoQ==
X-Forwarded-Encrypted: i=1; AJvYcCWmQRNU8MAceTNzOmWpFbFbN+JuJQXQhXLJXRx3hAFqCgakx36EtvE6+qow1uPnVpP98HBMJcVBNNwmxxk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwpHjI3lweiw0U7phDmYcHs/fGYoFbXnqOMFAm+BW0qGoP72UrX
	yYASVjyRbS4aWvaS/5nK+KuZQLj5hA9IzsjZEDSRpRM3WNDqnl8bT4er7yqvXyu34CM=
X-Gm-Gg: ASbGncsx+v8rJBTJL7j27wV8bZG5d7KplWCXSB5Awud35K76cz08e4o/srxjimkr6CD
	xjaSsRcS8W4Q3aActVJGhzXnsRfHwMfZbNNrP0V40K11geO68tb+K3N7UVaexL+knBBpvBo0IHC
	+jAePq0gl3/6puslr4O+SaB9WaFj7CsKt52oKiUT6uoqJ+M11SCnTJQAqaAzAVhB+Ehzh1DuOLl
	lejInIPxKxD/lnHG6mbP6YIJNPCSN0SrKigwKCuc9tnnYtzcCfCkrYH0xPb2eyuQYBXGRYKoWjI
	loAJ8iSIENTwJ7mcPqSoSyEfpNMJt6TIn031XjvSucG9WtzNNmMkuSFTmSpE522fQRqJMjPXfVT
	M8dT01TfWrf7VzndYa+0BrJy2urfV7BH5fKVHFpVwYy3+AhGKTPJWbowySPZgcD6mT7Q=
X-Google-Smtp-Source: AGHT+IFpFqK+ccAxZeSzlfsUYTQajx+NLQOJnyFNLwylalWZUDxsky2kTMEhpS6+sgdWpJGowGzqpQ==
X-Received: by 2002:a17:902:c410:b0:249:71f5:4e5a with SMTP id d9443c01a7336-29027f3e32emr309779485ad.26.1760379598009;
        Mon, 13 Oct 2025 11:19:58 -0700 (PDT)
Received: from sunil-pc.tail07344b.ts.net ([106.51.198.226])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29034f36738sm140048525ad.87.2025.10.13.11.19.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Oct 2025 11:19:57 -0700 (PDT)
From: Sunil V L <sunilvl@ventanamicro.com>
To: linux-acpi@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: "Rafael J . Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>,
	Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Joerg Roedel <joerg.roedel@amd.com>,
	Anup Patel <anup@brainfault.org>,
	Sunil V L <sunilvl@ventanamicro.com>,
	kernel test robot <lkp@intel.com>
Subject: [PATCH] ACPI: RIMT: Fix unused function warnings when CONFIG_IOMMU_API is disabled
Date: Mon, 13 Oct 2025 23:49:47 +0530
Message-ID: <20251013181947.261759-1-sunilvl@ventanamicro.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When CONFIG_IOMMU_API is disabled, some functions defined outside its
conditional scope become unused, triggering compiler warnings reported
by the kernel test robot.

Move these function definitions inside the #ifdef CONFIG_IOMMU_API block
to prevent unused function warnings when the configuration is disabled.

Fixes: 8f7729552582 ("ACPI: RISC-V: Add support for RIMT")
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202509280031.8Sjkr4bh-lkp@intel.com/
Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
---
 drivers/acpi/riscv/rimt.c | 122 +++++++++++++++++++-------------------
 1 file changed, 61 insertions(+), 61 deletions(-)

diff --git a/drivers/acpi/riscv/rimt.c b/drivers/acpi/riscv/rimt.c
index 683fcfe35c31..7f423405e5ef 100644
--- a/drivers/acpi/riscv/rimt.c
+++ b/drivers/acpi/riscv/rimt.c
@@ -61,30 +61,6 @@ static int rimt_set_fwnode(struct acpi_rimt_node *rimt_node,
 	return 0;
 }
 
-/**
- * rimt_get_fwnode() - Retrieve fwnode associated with an RIMT node
- *
- * @node: RIMT table node to be looked-up
- *
- * Returns: fwnode_handle pointer on success, NULL on failure
- */
-static struct fwnode_handle *rimt_get_fwnode(struct acpi_rimt_node *node)
-{
-	struct fwnode_handle *fwnode = NULL;
-	struct rimt_fwnode *curr;
-
-	spin_lock(&rimt_fwnode_lock);
-	list_for_each_entry(curr, &rimt_fwnode_list, list) {
-		if (curr->rimt_node == node) {
-			fwnode = curr->fwnode;
-			break;
-		}
-	}
-	spin_unlock(&rimt_fwnode_lock);
-
-	return fwnode;
-}
-
 static acpi_status rimt_match_node_callback(struct acpi_rimt_node *node,
 					    void *context)
 {
@@ -202,6 +178,67 @@ static struct acpi_rimt_node *rimt_scan_node(enum acpi_rimt_node_type type,
 	return NULL;
 }
 
+/*
+ * RISC-V supports IOMMU as a PCI device or a platform device.
+ * When it is a platform device, there should be a namespace device as
+ * well along with RIMT. To create the link between RIMT information and
+ * the platform device, the IOMMU driver should register itself with the
+ * RIMT module. This is true for PCI based IOMMU as well.
+ */
+int rimt_iommu_register(struct device *dev)
+{
+	struct fwnode_handle *rimt_fwnode;
+	struct acpi_rimt_node *node;
+
+	node = rimt_scan_node(ACPI_RIMT_NODE_TYPE_IOMMU, dev);
+	if (!node) {
+		pr_err("Could not find IOMMU node in RIMT\n");
+		return -ENODEV;
+	}
+
+	if (dev_is_pci(dev)) {
+		rimt_fwnode = acpi_alloc_fwnode_static();
+		if (!rimt_fwnode)
+			return -ENOMEM;
+
+		rimt_fwnode->dev = dev;
+		if (!dev->fwnode)
+			dev->fwnode = rimt_fwnode;
+
+		rimt_set_fwnode(node, rimt_fwnode);
+	} else {
+		rimt_set_fwnode(node, dev->fwnode);
+	}
+
+	return 0;
+}
+
+#ifdef CONFIG_IOMMU_API
+
+/**
+ * rimt_get_fwnode() - Retrieve fwnode associated with an RIMT node
+ *
+ * @node: RIMT table node to be looked-up
+ *
+ * Returns: fwnode_handle pointer on success, NULL on failure
+ */
+static struct fwnode_handle *rimt_get_fwnode(struct acpi_rimt_node *node)
+{
+	struct fwnode_handle *fwnode = NULL;
+	struct rimt_fwnode *curr;
+
+	spin_lock(&rimt_fwnode_lock);
+	list_for_each_entry(curr, &rimt_fwnode_list, list) {
+		if (curr->rimt_node == node) {
+			fwnode = curr->fwnode;
+			break;
+		}
+	}
+	spin_unlock(&rimt_fwnode_lock);
+
+	return fwnode;
+}
+
 static bool rimt_pcie_rc_supports_ats(struct acpi_rimt_node *node)
 {
 	struct acpi_rimt_pcie_rc *pci_rc;
@@ -290,43 +327,6 @@ static struct acpi_rimt_node *rimt_node_get_id(struct acpi_rimt_node *node,
 	return NULL;
 }
 
-/*
- * RISC-V supports IOMMU as a PCI device or a platform device.
- * When it is a platform device, there should be a namespace device as
- * well along with RIMT. To create the link between RIMT information and
- * the platform device, the IOMMU driver should register itself with the
- * RIMT module. This is true for PCI based IOMMU as well.
- */
-int rimt_iommu_register(struct device *dev)
-{
-	struct fwnode_handle *rimt_fwnode;
-	struct acpi_rimt_node *node;
-
-	node = rimt_scan_node(ACPI_RIMT_NODE_TYPE_IOMMU, dev);
-	if (!node) {
-		pr_err("Could not find IOMMU node in RIMT\n");
-		return -ENODEV;
-	}
-
-	if (dev_is_pci(dev)) {
-		rimt_fwnode = acpi_alloc_fwnode_static();
-		if (!rimt_fwnode)
-			return -ENOMEM;
-
-		rimt_fwnode->dev = dev;
-		if (!dev->fwnode)
-			dev->fwnode = rimt_fwnode;
-
-		rimt_set_fwnode(node, rimt_fwnode);
-	} else {
-		rimt_set_fwnode(node, dev->fwnode);
-	}
-
-	return 0;
-}
-
-#ifdef CONFIG_IOMMU_API
-
 static struct acpi_rimt_node *rimt_node_map_id(struct acpi_rimt_node *node,
 					       u32 id_in, u32 *id_out,
 					       u8 type_mask)
-- 
2.43.0


