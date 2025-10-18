Return-Path: <linux-kernel+bounces-858875-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D0D0BEC196
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Oct 2025 02:08:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 54DEA4F2596
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Oct 2025 00:08:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 230DE19DF4D;
	Sat, 18 Oct 2025 00:07:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="N8k8baR5"
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A1CA156661
	for <linux-kernel@vger.kernel.org>; Sat, 18 Oct 2025 00:07:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760746055; cv=none; b=lpMP1abt3BfP7DG2G2aITy8/6AkOZB0vqSEdIPTMcesr5W3z7F1g75nygavWXbWQRTBCci1MPMmrxmjxX/nHCIdJdfOeR2ZlienDY+PgyMoGEecrpo4UQ9gnfFv88HKqrNUh7/rNJIxVosTBaUpxziTcK7MBnKoW6lO2pZIyZW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760746055; c=relaxed/simple;
	bh=WqoyuRvOF/KaAj4Kamg+Ll5XCZ1wJiFiYb83JG8QyCI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=QO5+efWw3QKViiSitUy7owzr6KXpFscizJ+lHABxn5793w7PHihS2nQML4nEuVYXmPkQReH9IfaGLJJpU6E5+M+9VlVky23kOlhmQZxSwQnPIJrQUYYc2vMksR1r02JfQbQY+1lJz71bpf/fMAsvRLE+v7mR1LFWdOXqtFnisAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--vipinsh.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=N8k8baR5; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vipinsh.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-26983c4d708so20777135ad.3
        for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 17:07:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760746052; x=1761350852; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=TGD7bzX0Kq7IaGb+QpC13kgMXesYLGgf6obE0wlZYvA=;
        b=N8k8baR5x0TMJ5BpjROOTS4lWz+jivd7/GSXln/iBlHs7y5VsQe6XV5Qcov0dWGyQi
         WAcNV/BTmJ2qRf13/D0/winfvFWIavnaBJgxkVQ1bTBJ1AOdUMVw6+DUIbN3JYKX9FxT
         wJ9/6fIf/C2N6OTOQpTNZ+O/ho16oFWzegOtuKo+jQYaNdNeLMJ2TUVpUeULqaa9AJ7O
         QjqUOsyuNvwZNIDbu/wyZ3mDYSQ0ZlME9xX+mCcPxy4r73Q0ypJYg1OlHB1yQIzam9VG
         1XTBe1qVPCLl2FSperYKbyeVjdR8W5mzuxw+f1lcfyVdKvTELbY52gcDSk7dQyYwmoYe
         ngNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760746052; x=1761350852;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TGD7bzX0Kq7IaGb+QpC13kgMXesYLGgf6obE0wlZYvA=;
        b=Bey7UldKwVHVmNXPgNmiLKYP3as/hQHw41eOocfZU10MQRueXkGRvSo9FMBg2DbqiV
         3GvClN2Q0+FpC6yWlo1W9XpWQzplAYxfSUFruJJTz7ivpJ6pckmOEfIuC5nfR5bwMiQZ
         HNsSVDcyGZWfoDBuFJdZ9Pu19Gie/h+095ptZgPLVS6s8zWb9hn6/G9mXYu18hEN4rij
         E4TulKPVyg17Si89uZ1U9ZINITfYk2nXQLJN2kajbw4s7khjMzxAdokxJODyC/xkFc/K
         vXgH9MSul6MhA0+Ie9PH6epU9Qtxi7kOVmyqdiUn+2VRFTA9HvcCj0fDrU7dg9LsG1mK
         vxpg==
X-Forwarded-Encrypted: i=1; AJvYcCV9wBarS5kgnCjI5BjdV7vH3l4kqe5fhZSEPiiXdei/KpmRMhEoCdCHNnrsXbYALwJwep6gFpbd1sC4bEU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZB9Dj17jJ6TitpGH+1PKylf69MxPXe5Me+YzgsdkYCmnvWVFQ
	WiVup1m9d2Z0MIMJcapIPH2wxqJpvGtLMKn7NsxCHvlpMt3/+GTu89RYC7dXGpQBCXunM4OgiE5
	V3+oAjjbSiQ==
X-Google-Smtp-Source: AGHT+IHJ850JrI8smUyVofUcQEbNFuf48VMG6+VFF6lU6eFbmxUPuJB2Z6EpOhYs4AAVGwT4qh1u+uj/tQ7N
X-Received: from pjg7.prod.google.com ([2002:a17:90b:3f47:b0:330:7dd8:2dc2])
 (user=vipinsh job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:fc4b:b0:290:8d7b:4047
 with SMTP id d9443c01a7336-290c9cbc4c9mr66393955ad.21.1760746051767; Fri, 17
 Oct 2025 17:07:31 -0700 (PDT)
Date: Fri, 17 Oct 2025 17:06:57 -0700
In-Reply-To: <20251018000713.677779-1-vipinsh@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251018000713.677779-1-vipinsh@google.com>
X-Mailer: git-send-email 2.51.0.858.gf9c4a03a3a-goog
Message-ID: <20251018000713.677779-6-vipinsh@google.com>
Subject: [RFC PATCH 05/21] vfio/pci: Register VFIO live update file handler to
 Live Update Orchestrator
From: Vipin Sharma <vipinsh@google.com>
To: bhelgaas@google.com, alex.williamson@redhat.com, pasha.tatashin@soleen.com, 
	dmatlack@google.com, jgg@ziepe.ca, graf@amazon.com
Cc: pratyush@kernel.org, gregkh@linuxfoundation.org, chrisl@kernel.org, 
	rppt@kernel.org, skhawaja@google.com, parav@nvidia.com, saeedm@nvidia.com, 
	kevin.tian@intel.com, jrhilke@google.com, david@redhat.com, 
	jgowans@amazon.com, dwmw2@infradead.org, epetron@amazon.de, 
	junaids@google.com, linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, 
	kvm@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	Vipin Sharma <vipinsh@google.com>
Content-Type: text/plain; charset="UTF-8"

Register VFIO live update file handler to Live Update Orchestrator.
Provide stub implementation of the handler callbacks.

Adding live update support in VFIO will enable a VFIO PCI device to work
uninterrupted while the host kernel is being updated through a kexec
reboot.

Signed-off-by: Vipin Sharma <vipinsh@google.com>
---
 drivers/vfio/pci/Makefile              |  1 +
 drivers/vfio/pci/vfio_pci_core.c       |  1 +
 drivers/vfio/pci/vfio_pci_liveupdate.c | 44 ++++++++++++++++++++++++++
 drivers/vfio/pci/vfio_pci_priv.h       |  6 ++++
 4 files changed, 52 insertions(+)
 create mode 100644 drivers/vfio/pci/vfio_pci_liveupdate.c

diff --git a/drivers/vfio/pci/Makefile b/drivers/vfio/pci/Makefile
index cf00c0a7e55c..929df22c079b 100644
--- a/drivers/vfio/pci/Makefile
+++ b/drivers/vfio/pci/Makefile
@@ -2,6 +2,7 @@
 
 vfio-pci-core-y := vfio_pci_core.o vfio_pci_intrs.o vfio_pci_rdwr.o vfio_pci_config.o
 vfio-pci-core-$(CONFIG_VFIO_PCI_ZDEV_KVM) += vfio_pci_zdev.o
+vfio-pci-core-$(CONFIG_LIVEUPDATE) += vfio_pci_liveupdate.o
 obj-$(CONFIG_VFIO_PCI_CORE) += vfio-pci-core.o
 
 vfio-pci-y := vfio_pci.o
diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pci_core.c
index 7dcf5439dedc..0894673a9262 100644
--- a/drivers/vfio/pci/vfio_pci_core.c
+++ b/drivers/vfio/pci/vfio_pci_core.c
@@ -2568,6 +2568,7 @@ static void vfio_pci_core_cleanup(void)
 static int __init vfio_pci_core_init(void)
 {
 	/* Allocate shared config space permission data used by all devices */
+	vfio_pci_liveupdate_init();
 	return vfio_pci_init_perm_bits();
 }
 
diff --git a/drivers/vfio/pci/vfio_pci_liveupdate.c b/drivers/vfio/pci/vfio_pci_liveupdate.c
new file mode 100644
index 000000000000..088f7698a72c
--- /dev/null
+++ b/drivers/vfio/pci/vfio_pci_liveupdate.c
@@ -0,0 +1,44 @@
+// SPDX-License-Identifier: GPL-2.0
+
+/*
+ * Liveupdate support for VFIO devices.
+ *
+ * Copyright (c) 2025, Google LLC.
+ * Vipin Sharma <vipinsh@google.com>
+ */
+
+#include <linux/liveupdate.h>
+#include <linux/errno.h>
+
+#include "vfio_pci_priv.h"
+
+static int vfio_pci_liveupdate_retrieve(struct liveupdate_file_handler *handler,
+					u64 data, struct file **file)
+{
+	return -EOPNOTSUPP;
+}
+
+static bool vfio_pci_liveupdate_can_preserve(struct liveupdate_file_handler *handler,
+					     struct file *file)
+{
+	return -EOPNOTSUPP;
+}
+
+static const struct liveupdate_file_ops vfio_pci_luo_fops = {
+	.retrieve = vfio_pci_liveupdate_retrieve,
+	.can_preserve = vfio_pci_liveupdate_can_preserve,
+	.owner = THIS_MODULE,
+};
+
+static struct liveupdate_file_handler vfio_pci_luo_handler = {
+	.ops = &vfio_pci_luo_fops,
+	.compatible = "vfio-v1",
+};
+
+void __init vfio_pci_liveupdate_init(void)
+{
+	int err = liveupdate_register_file_handler(&vfio_pci_luo_handler);
+
+	if (err)
+		pr_err("VFIO PCI liveupdate file handler register failed, error %d.\n", err);
+}
diff --git a/drivers/vfio/pci/vfio_pci_priv.h b/drivers/vfio/pci/vfio_pci_priv.h
index a9972eacb293..7779fd744ff5 100644
--- a/drivers/vfio/pci/vfio_pci_priv.h
+++ b/drivers/vfio/pci/vfio_pci_priv.h
@@ -107,4 +107,10 @@ static inline bool vfio_pci_is_vga(struct pci_dev *pdev)
 	return (pdev->class >> 8) == PCI_CLASS_DISPLAY_VGA;
 }
 
+#ifdef CONFIG_LIVEUPDATE
+void vfio_pci_liveupdate_init(void);
+#else
+static inline void vfio_pci_liveupdate_init(void) { }
+#endif /* CONFIG_LIVEUPDATE */
+
 #endif
-- 
2.51.0.858.gf9c4a03a3a-goog


