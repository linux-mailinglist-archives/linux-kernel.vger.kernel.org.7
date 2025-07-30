Return-Path: <linux-kernel+bounces-750468-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BD64B15BA1
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 11:31:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3AE3E7ABFCE
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 09:29:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 584FC275B0A;
	Wed, 30 Jul 2025 09:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zxvy2Zpq"
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FBB127144C
	for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 09:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753867827; cv=none; b=lJOsALdHOFSpYAgvD2Xs/3a1ONXqaLzt6QshhmFOYKjbegR2l/061fN6bZaLGtPaibXJa/DDzola17nkc9UmnrXq2jWoJD0kGFlOqj8iOs3M3xVgO3QNj3Uoi5x3LandNkPESzs5MRFqwmdpthaIoObGQ8BOT205UyxuUR0MjV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753867827; c=relaxed/simple;
	bh=EZG5GWBuYkwXyo63tWvaS2vVdUxh8TggH36mdHovo0U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qeyUR7rcy++T3diC+ACGe2/bU3/GbaCGNkP4jsAJAmiaxBHB1U5UwdUxs+r7oP0YjmpIC5B43gUkqnU/4OHq2OdqYbTWYYGBRcmnVz3yDNyo02elqsgEcB2cXazWMxwOYEC4tLf+tdUFaIkREFjbrxMNjJncZWZIYejHhqFCbkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=zxvy2Zpq; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-31eb40b050bso3189145a91.0
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 02:30:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1753867825; x=1754472625; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+ztfLizoM6vJzWJQpk/yKuNltuSgkusaceKeZjG9ohE=;
        b=zxvy2ZpqBnucmNMLGSBa6OS5fGglqfJLOYItaLW1FeLRekA3fiVD/bf1HntB3YoufV
         cZL+EMdDvFTZhnLNH9SiF7HwZoibomtziROVLGuvFTFEevVvcWSwIk5xZ1rrAwndzZEj
         aaWDkI9wRtWGWu6uDcc4B+JIwH06s9nySjjnd2jM7FzyA/XxXCwpn1lsD6aDOxuAMzel
         NV+VzUKBfkVqGAx6f8VTsqtKmxofCCUCZqQawpJgiJiO5JfIz4Mbbm6NGG/I/cGo9zT2
         k7VdXJp4pP71d7vk6ahLxzCAwlu7SMyx1PvNzxzT42nPDUQqryDkqmj9uNr7AlbDW9Uh
         NyeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753867825; x=1754472625;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+ztfLizoM6vJzWJQpk/yKuNltuSgkusaceKeZjG9ohE=;
        b=Xek8Z1hJeOzSWkUOpEnPDE8MIuvs5YDrAz91bDxXRe/QaS8F0JqMIjyc44JC9uy3Eb
         nqjSNUIKNY3ex7FZTdM/Xt4/5BrBG70sIdH1Lxn+HZr9NF/KJwCsTlKqODYEbyL7tEKT
         KrtDybjcS8qKIzx8scuZtzC7bHhTaAyDD8tr8n8or4uUmpE6fss51tUOCDZvv+a7f5cu
         5K0L/mzlvySzQ1iQa4malSnrOGZQCCYbsTLfyqz50B7mMERAQDThJVaz4UgPuotQ+RJU
         yGYdXWA4VxZdD7Z4X3oEF/xl5KFXfm6UEzNV0yta/WlvLYIFJaOL2IZK/WtCqX9E4B3Z
         Agjw==
X-Gm-Message-State: AOJu0Yzu3Dpzw688WNLVTb16pjfkkt1a/Z6FOPBd/9k+wqbVpkqWpgDe
	DobLzlVchrsoHD1xrYrzU7koLxe2QUV2Xfi1FqIPPszoUhZpWMlb5idgVR5H7dyUQ/aAyuRXSRg
	n0skS
X-Gm-Gg: ASbGncsip2VznO3K5OQBKQnpabALHpUsstuNUpbIAj+Ny6CrQG77AVQ+1azcN5M2Ryw
	M5sNprSv+cWJyX4vXcwQdzuv4kuE4FKDu0FsaODQstew8bq9HRgA9eMHTHKeE9rwQJS2Dc6YD4J
	DAleIH5Pc6RjKl+TQs/kr7/vOSMn/OOg9uVaYP08+Y5GZv0jRh/AA6voZ8DQXEK2df3py233WTa
	2AvacNHMec7OtAr2R8F52qT6tkCTAk2bM7hCEWe7g2iRKeqaO6KON9mc0KqxhIOZF304eTe5YaD
	mgghwyzuvY/BLECXd620EW8zmDkD92orZd4Q6GwkBeiguS9L2G8Z3Hl62xmDGJ/2so3KA35cKip
	Z8kQFHz57tG8SA0UP44Hm9MA=
X-Google-Smtp-Source: AGHT+IFUrg1QYU7YbPaiKF9yxuBVZ4/0jL0dMyof/YqyAVSp+4ZDAcvrCV6vSNusV2vKF99MbZL+zw==
X-Received: by 2002:a17:90b:3e84:b0:311:e8cc:424c with SMTP id 98e67ed59e1d1-31f5ea4c967mr3628584a91.25.1753867824670;
        Wed, 30 Jul 2025 02:30:24 -0700 (PDT)
Received: from localhost ([122.172.85.40])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31f63dd8c04sm1479090a91.19.2025.07.30.02.30.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Jul 2025 02:30:24 -0700 (PDT)
From: Viresh Kumar <viresh.kumar@linaro.org>
To: linux-kernel@vger.kernel.org,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Viresh Kumar <viresh.kumar@linaro.org>
Cc: Arnd Bergmann <arnd@kernel.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	=?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
	Bill Mills <bill.mills@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Saravana Kannan <saravanak@google.com>,
	devicetree@vger.kernel.org,
	virtualization@lists.linux.dev,
	Sudeep Holla <sudeep.holla@arm.com>,
	Bertrand Marquis <bertrand.marquis@arm.com>,
	"Edgar E . Iglesias" <edgar.iglesias@amd.com>,
	Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Subject: [RFC PATCH  6/6] virtio-msg: Add support for loopback bus
Date: Wed, 30 Jul 2025 14:59:35 +0530
Message-Id: <622460b11118be66d5ec380b3d5771be77fc1e91.1753865268.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.31.1.272.g89b43f80a514
In-Reply-To: <cover.1753865268.git.viresh.kumar@linaro.org>
References: <cover.1753865268.git.viresh.kumar@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a loopback bus implementation for the virtio-msg transport.

This bus simulates a backend that echoes messages to itself, allowing
testing and development of virtio-msg without requiring an actual remote
backend or transport hardware.

The loopback bus requires a reserved memory region for its operation.
All DMA-coherent and streaming DMA allocations are restricted to this
region, enabling safe mapping into user space and helping validate the
memory-sharing model.

The reserved-memory region must be named "vmsglb" in the device tree.
Example:

  reserved-memory {
    #address-cells = <2>;
    #size-cells   = <2>;
    ranges;

    vmsglb@100000000 {
      compatible = "restricted-dma-pool";
      reg = <0x00000001 0x00000000  0x0 0x00400000>; /* 4 MiB */
    };
  };

This bus is primarily intended for functional testing, development, and
validation of the virtio-msg transport and its userspace interface.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/virtio/Kconfig               |   9 +
 drivers/virtio/Makefile              |   1 +
 drivers/virtio/virtio_msg_loopback.c | 323 +++++++++++++++++++++++++++
 include/uapi/linux/virtio_msg_lb.h   |  22 ++
 4 files changed, 355 insertions(+)
 create mode 100644 drivers/virtio/virtio_msg_loopback.c
 create mode 100644 include/uapi/linux/virtio_msg_lb.h

diff --git a/drivers/virtio/Kconfig b/drivers/virtio/Kconfig
index 683152477e3f..934e8ccb3a01 100644
--- a/drivers/virtio/Kconfig
+++ b/drivers/virtio/Kconfig
@@ -196,6 +196,15 @@ config VIRTIO_MSG_FFA
 
 	 If unsure, say N.
 
+config VIRTIO_MSG_LOOPBACK
+	tristate "Loopback bus driver for virtio message transport"
+	select VIRTIO_MSG
+	select VIRTIO_MSG_USER
+	help
+	 This implements the Loopback bus for Virtio msg transport.
+
+	 If unsure, say N.
+
 config VIRTIO_DMA_SHARED_BUFFER
 	tristate
 	depends on DMA_SHARED_BUFFER
diff --git a/drivers/virtio/Makefile b/drivers/virtio/Makefile
index 96ec0a9c4a7a..90a2f1d86937 100644
--- a/drivers/virtio/Makefile
+++ b/drivers/virtio/Makefile
@@ -7,6 +7,7 @@ obj-$(CONFIG_VIRTIO_MMIO) += virtio_mmio.o
 virtio_msg_transport-y := virtio_msg.o
 virtio_msg_transport-$(CONFIG_VIRTIO_MSG_USER) += virtio_msg_user.o
 obj-$(CONFIG_VIRTIO_MSG) += virtio_msg_transport.o
+obj-$(CONFIG_VIRTIO_MSG_LOOPBACK) += virtio_msg_loopback.o
 obj-$(CONFIG_VIRTIO_MSG_FFA) += virtio_msg_ffa.o
 obj-$(CONFIG_VIRTIO_PCI) += virtio_pci.o
 virtio_pci-y := virtio_pci_modern.o virtio_pci_common.o
diff --git a/drivers/virtio/virtio_msg_loopback.c b/drivers/virtio/virtio_msg_loopback.c
new file mode 100644
index 000000000000..d1d454fadc6f
--- /dev/null
+++ b/drivers/virtio/virtio_msg_loopback.c
@@ -0,0 +1,323 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Loopback bus implementation for Virtio message transport.
+ *
+ * Copyright (C) 2025 Google LLC and Linaro.
+ * Viresh Kumar <viresh.kumar@linaro.org>
+ *
+ * This implements the Loopback bus for Virtio msg transport.
+ */
+
+#define pr_fmt(fmt) "virtio-msg-loopback: " fmt
+
+#include <linux/err.h>
+#include <linux/list.h>
+#include <linux/miscdevice.h>
+#include <linux/module.h>
+#include <linux/mutex.h>
+#include <linux/of_reserved_mem.h>
+#include <linux/slab.h>
+#include <linux/types.h>
+#include <linux/virtio.h>
+#include <uapi/linux/virtio_msg.h>
+#include <uapi/linux/virtio_msg_lb.h>
+
+#include "virtio_msg_internal.h"
+
+struct vmlb_device {
+	struct virtio_msg_device vmdev;
+	struct list_head list;
+};
+
+struct virtio_msg_lb {
+	/* Serializes transfers and protects list */
+	struct mutex lock;
+	struct list_head list;
+	struct miscdevice misc;
+	struct virtio_msg_user_device vmudev;
+	struct virtio_msg *response;
+	struct reserved_mem *rmem;
+	struct device *dev;
+};
+
+static struct virtio_msg_lb *vmlb;
+
+#define to_vmlbdev(_vmdev)	((struct vmlb_device *)(_vmdev)->bus_data)
+
+static struct vmlb_device *find_vmlbdev(u16 dev_id)
+{
+	struct vmlb_device *vmlbdev;
+
+	list_for_each_entry(vmlbdev, &vmlb->list, list) {
+		if (vmlbdev->vmdev.dev_id == dev_id)
+			return vmlbdev;
+	}
+
+	return NULL;
+}
+
+static const char *virtio_msg_lb_bus_info(struct virtio_msg_device *vmdev,
+					  u16 *msg_size, u32 *rev)
+{
+	*msg_size = VIRTIO_MSG_MIN_SIZE;
+	*rev = VIRTIO_MSG_REVISION_1;
+
+	return dev_name(vmlb->dev);
+}
+
+static int virtio_msg_lb_transfer(struct virtio_msg_device *vmdev,
+				  struct virtio_msg *request,
+				  struct virtio_msg *response)
+{
+	struct virtio_msg_user_device *vmudev = &vmlb->vmudev;
+	int ret;
+
+	/*
+	 * Allow only one transaction to progress at once.
+	 */
+	guard(mutex)(&vmlb->lock);
+
+	/*
+	 * Set `vmsg` to `request` and finish the completion to wake up the
+	 * `read()` thread.
+	 */
+	vmudev->vmsg = request;
+	vmlb->response = response;
+	complete(&vmudev->r_completion);
+
+	/*
+	 * Wait here for the `write()` thread to finish and not return before
+	 * the operation is finished to avoid any potential races.
+	 */
+	ret = wait_for_completion_interruptible_timeout(&vmudev->w_completion, 1000);
+	if (ret < 0) {
+		dev_err(vmlb->dev, "Interrupted while waiting for response: %d\n", ret);
+	} else if (!ret) {
+		dev_err(vmlb->dev, "Timed out waiting for response\n");
+		ret = -ETIMEDOUT;
+	} else {
+		ret = 0;
+	}
+
+	/* Clear the pointers, just to be safe */
+	vmudev->vmsg = NULL;
+	vmlb->response = NULL;
+
+	return ret;
+}
+
+static struct virtio_msg_ops virtio_msg_lb_ops = {
+	.transfer = virtio_msg_lb_transfer,
+	.bus_info = virtio_msg_lb_bus_info,
+};
+
+static int virtio_msg_lb_user_handle(struct virtio_msg_user_device *vmudev,
+				     struct virtio_msg *vmsg)
+{
+	struct vmlb_device *vmlbdev;
+
+	/* Response message */
+	if (vmsg->type & VIRTIO_MSG_TYPE_RESPONSE) {
+		if (vmlb->response)
+			memcpy(vmlb->response, vmsg, VIRTIO_MSG_MIN_SIZE);
+
+		return 0;
+	}
+
+	/* Only support EVENT_USED virtio request messages */
+	if (vmsg->type & VIRTIO_MSG_TYPE_BUS || vmsg->msg_id != VIRTIO_MSG_EVENT_USED) {
+		dev_err(vmlb->dev, "Unsupported message received\n");
+		return 0;
+	}
+
+	vmlbdev = find_vmlbdev(le16_to_cpu(vmsg->dev_id));
+	if (!vmlbdev)
+		return 0;
+
+	virtio_msg_event(&vmlbdev->vmdev, vmsg);
+	return 0;
+}
+
+static struct virtio_msg_user_ops vmlb_user_ops = {
+	.handle = virtio_msg_lb_user_handle,
+};
+
+static int vmlbdev_add(struct file *file, struct vmsg_lb_dev_info *info)
+{
+	struct vmlb_device *vmlbdev;
+	int ret;
+
+	scoped_guard(mutex, &vmlb->lock) {
+		if (find_vmlbdev(info->dev_id))
+			return -EEXIST;
+
+		vmlbdev = kzalloc(sizeof(*vmlbdev), GFP_KERNEL);
+		if (!vmlbdev)
+			return -ENOMEM;
+
+		vmlbdev->vmdev.dev_id = info->dev_id;
+		vmlbdev->vmdev.ops = &virtio_msg_lb_ops;
+		vmlbdev->vmdev.vdev.dev.parent = vmlb->dev;
+		vmlbdev->vmdev.bus_data = vmlbdev;
+
+		list_add(&vmlbdev->list, &vmlb->list);
+	}
+
+	ret = virtio_msg_register(&vmlbdev->vmdev);
+	if (ret) {
+		dev_err(vmlb->dev, "Failed to register virtio msg lb device (%d)\n", ret);
+		goto out;
+	}
+
+	return 0;
+
+out:
+	scoped_guard(mutex, &vmlb->lock)
+		list_del(&vmlbdev->list);
+
+	kfree(vmlbdev);
+	return ret;
+}
+
+static int vmlbdev_remove(struct file *file, struct vmsg_lb_dev_info *info)
+{
+	struct vmlb_device *vmlbdev;
+
+	scoped_guard(mutex, &vmlb->lock) {
+		vmlbdev = find_vmlbdev(info->dev_id);
+		if (vmlbdev) {
+			list_del(&vmlbdev->list);
+			virtio_msg_unregister(&vmlbdev->vmdev);
+			return 0;
+		}
+	}
+
+	dev_err(vmlb->dev, "Failed to find virtio msg lb device.\n");
+	return -ENODEV;
+}
+
+static void vmlbdev_remove_all(void)
+{
+	struct vmlb_device *vmlbdev, *tvmlbdev;
+
+	guard(mutex)(&vmlb->lock);
+
+	list_for_each_entry_safe(vmlbdev, tvmlbdev, &vmlb->list, list) {
+		virtio_msg_unregister(&vmlbdev->vmdev);
+		list_del(&vmlbdev->list);
+	}
+}
+
+static long vmlb_ioctl(struct file *file, unsigned int cmd, unsigned long data)
+{
+	struct vmsg_lb_dev_info info;
+
+	if (copy_from_user(&info, (void __user *)data, sizeof(info)))
+		return -EFAULT;
+
+	switch (cmd) {
+	case IOCTL_VMSG_LB_ADD:
+		return vmlbdev_add(file, &info);
+
+	case IOCTL_VMSG_LB_REMOVE:
+		return vmlbdev_remove(file, &info);
+
+	default:
+		return -ENOTTY;
+	}
+}
+
+static int vmlb_mmap(struct file *file, struct vm_area_struct *vma)
+{
+	unsigned long size = vma->vm_end - vma->vm_start;
+	unsigned long offset = vma->vm_pgoff << PAGE_SHIFT;
+
+	if (offset > vmlb->rmem->size - size)
+		return -EINVAL;
+
+	return remap_pfn_range(vma, vma->vm_start,
+			(vmlb->rmem->base + offset) >> PAGE_SHIFT,
+			size,
+			vma->vm_page_prot);
+}
+
+static loff_t vmlb_llseek(struct file *file, loff_t offset, int whence)
+{
+	return fixed_size_llseek(file, offset, whence, vmlb->rmem->size);
+}
+
+static const struct file_operations vmlb_miscdev_fops = {
+	.owner = THIS_MODULE,
+	.unlocked_ioctl = vmlb_ioctl,
+	.mmap = vmlb_mmap,
+	.llseek = vmlb_llseek,
+};
+
+static int virtio_msg_lb_init(void)
+{
+	int ret;
+
+	vmlb = kzalloc(sizeof(*vmlb), GFP_KERNEL);
+	if (!vmlb)
+		return -ENOMEM;
+
+	INIT_LIST_HEAD(&vmlb->list);
+	mutex_init(&vmlb->lock);
+	vmlb->vmudev.ops = &vmlb_user_ops;
+
+	vmlb->misc.name = "virtio-msg-lb";
+	vmlb->misc.minor = MISC_DYNAMIC_MINOR;
+	vmlb->misc.fops = &vmlb_miscdev_fops;
+
+	ret = misc_register(&vmlb->misc);
+	if (ret)
+		goto vmlb_free;
+
+	vmlb->dev = vmlb->misc.this_device;
+	vmlb->vmudev.parent = vmlb->dev;
+
+	vmlb->rmem = of_reserved_mem_lookup_by_name("vmsglb");
+	if (IS_ERR(vmlb->rmem)) {
+		ret = PTR_ERR(vmlb->rmem);
+		goto unregister;
+	}
+	ret = reserved_mem_device_init(vmlb->dev, vmlb->rmem);
+	if (ret)
+		goto mem_release;
+
+	/* Register with virtio-msg UAPI */
+	ret = virtio_msg_user_register(&vmlb->vmudev);
+	if (ret) {
+		dev_err(vmlb->dev, "Could not register virtio-msg user API\n");
+		goto mem_release;
+	}
+
+	ret = dma_coerce_mask_and_coherent(vmlb->dev, DMA_BIT_MASK(64));
+	if (ret)
+		dev_warn(vmlb->dev, "Failed to enable 64-bit or 32-bit DMA\n");
+
+	return 0;
+
+mem_release:
+	of_reserved_mem_device_release(vmlb->dev);
+unregister:
+	misc_deregister(&vmlb->misc);
+vmlb_free:
+	kfree(vmlb);
+	return ret;
+}
+module_init(virtio_msg_lb_init);
+
+static void virtio_msg_lb_exit(void)
+{
+	virtio_msg_user_unregister(&vmlb->vmudev);
+	of_reserved_mem_device_release(vmlb->dev);
+	vmlbdev_remove_all();
+	misc_deregister(&vmlb->misc);
+	kfree(vmlb);
+}
+module_exit(virtio_msg_lb_exit);
+
+MODULE_AUTHOR("Viresh Kumar <viresh.kumar@linaro.org>");
+MODULE_DESCRIPTION("Virtio message loopback bus driver");
+MODULE_LICENSE("GPL");
diff --git a/include/uapi/linux/virtio_msg_lb.h b/include/uapi/linux/virtio_msg_lb.h
new file mode 100644
index 000000000000..fe0ce6269a0a
--- /dev/null
+++ b/include/uapi/linux/virtio_msg_lb.h
@@ -0,0 +1,22 @@
+/* SPDX-License-Identifier: ((GPL-2.0 WITH Linux-syscall-note) OR BSD-3-Clause) */
+/*
+ * Virtio message Loopback bus header.
+ *
+ * Copyright (C) 2025 Google LLC and Linaro.
+ * Viresh Kumar <viresh.kumar@linaro.org>
+ */
+
+#ifndef _LINUX_VIRTIO_MSG_LB_H
+#define _LINUX_VIRTIO_MSG_LB_H
+
+struct vmsg_lb_dev_info {
+	unsigned int dev_id;
+};
+
+#define IOCTL_VMSG_LB_ADD					\
+	_IOC(_IOC_NONE, 'P', 0, sizeof(struct vmsg_lb_dev_info))
+
+#define IOCTL_VMSG_LB_REMOVE					\
+	_IOC(_IOC_NONE, 'P', 1, sizeof(struct vmsg_lb_dev_info))
+
+#endif /* _LINUX_VIRTIO_MSG_LB_H */
-- 
2.31.1.272.g89b43f80a514


