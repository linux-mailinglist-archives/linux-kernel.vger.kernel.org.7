Return-Path: <linux-kernel+bounces-714935-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F2048AF6E9E
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Jul 2025 11:27:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 371EF1C80119
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Jul 2025 09:28:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C27482D7806;
	Thu,  3 Jul 2025 09:26:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Al7k0xG3"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57CF22D94AF
	for <linux-kernel@vger.kernel.org>; Thu,  3 Jul 2025 09:26:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751534808; cv=none; b=BKd7zRC8NhXx/AbXIoCToJDBRIEKlc8iZc7d5iufKobAuj2Df1J4H8eTeAUfDOdc6dz07Qy1i5WtfkcWjwAGt0C+fpEl0qhIqxbr+B7z9xRjbvZ4k9Li0JcOPuCYtFxoEkbR64mhOw0QFMbPul+FYjkXOMCNruwnHEpejxfFQUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751534808; c=relaxed/simple;
	bh=tkgblbTFuQnMgah+b3qVfqQkZaZdA6aVb5an/8MM4jU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CNHnxHpScpJa8RXmfH1vJwWLlsQsHyWwcS3oDE/VKBuFt6LSApLI+WmL2HarZpzTUS9wQBod+KfQ9oDZDrSBBq0ZASGMqHneoYcjD4fDTJxqI39H+SEX3vAGvpYHQcdV2jiYaWWL0EHW0nd9vCrErCSt/F3tbrb3CVnCIWAopQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Al7k0xG3; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751534805;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6MdKqwpmU7OaPUd1S1vImlbly2qp2E4LikNix66Cy2A=;
	b=Al7k0xG3P24AvTG7db/SySDOXO3lj8Dnx6KRIysEOhErH35LtGX1HoqDehEctpNpwDLmLX
	7BBWlVbVGb8DO0gm9q3BCQszQtPZE1Pu5vovorSPpJyNE8cS6LMwb6yxrrvsUsWwSxTSII
	jXzqiOF/jzibGysiL4z+21YLi8RG0bs=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-283-f-U-mx1INRyUNsBKAbsLzg-1; Thu, 03 Jul 2025 05:26:42 -0400
X-MC-Unique: f-U-mx1INRyUNsBKAbsLzg-1
X-Mimecast-MFC-AGG-ID: f-U-mx1INRyUNsBKAbsLzg_1751534801
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-3a4f858bc5eso3832290f8f.0
        for <linux-kernel@vger.kernel.org>; Thu, 03 Jul 2025 02:26:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751534801; x=1752139601;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6MdKqwpmU7OaPUd1S1vImlbly2qp2E4LikNix66Cy2A=;
        b=S9TnCfOrA541XyVOKUR3mHPwS6NQogOFrAuRMFseyxhHEHuwEYGECFY/y1WJVvpBbM
         L6nTBbyPIaGoHrwLtIPeg/yyFsAwR4Q0B+Y8uPcYKYOg8xbqJizxaVPKoEp4T1NtdP1d
         evG6/fAmbM+OIx+fWNMtriM7tInSO/6DwytFc4oR3gcervJSMcqgERuKAxSiXiYjhlA8
         /upAn1oEuiRj7nz3U2V7USbXkPS4pZB9pH8I1hwRfMep5MRwos7WCTPyY55MPIX7vw0D
         eEW+XgsCY0WxOi90SMbXdVr7aBKRCkXeFaBMId4qEQ0R6A98PRvT18aqrSplBNDLQsjY
         dgCQ==
X-Gm-Message-State: AOJu0YyQO9RicOmn4rnWbIw7b6dPFH6MivKvKkIvYMbZXuJIhMPunhpU
	vsuiGhVJn1mR7hZPhXbs8gJioiV3YRkiUmcea/36SJMLo22NvvPRyTKmeOnTBG5c/WmitGHjriY
	qb7CL8/L/z/qA9GaisDUrrwDrXVQ23BCWmrwq8Izew/7Nuy/Gqb1999ZXOqtvwbO62xzbrJ0na6
	585lEKstoPtkSL+YVW4rOmo5wItpolvBR6kJtpf+TbpLY=
X-Gm-Gg: ASbGncsROSoqBKjI7MtUrC/c9Gvj6i5QSchIJdlSn2UroyEM/GormC3u5Da9GQcugUV
	BoahfbVmKIQc4+vQWrZukXg++lSfht3+mdYZMarLHi6kunvRcSi+x9wJJ2KkCiP0e02sYJdYro6
	Z7jeOuud6dTq3ABoylirPznh+lfjxoUGn0aNc9eH8jEftvveL5ndueJnOUbqeRE3sFPHvYWXRbK
	12BGKw2fu1/XQfe6PANYoVYOc/2RUhkegd5O1tmmu975W8r0gDhQdDHnezUiaqmo4GdDXC1Zoo2
	YYpxrYdid606m2K0
X-Received: by 2002:a05:6000:2c01:b0:3b3:a6e1:135c with SMTP id ffacd0b85a97d-3b3a6e113afmr893722f8f.42.1751534800716;
        Thu, 03 Jul 2025 02:26:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFkQtx6dTZNMo9PhkqNuSJxJCajqjzjsNPok7wcdjiw76P3Vf7cyfZYrozQCIx+rHWOI+RfQg==
X-Received: by 2002:a05:6000:2c01:b0:3b3:a6e1:135c with SMTP id ffacd0b85a97d-3b3a6e113afmr893677f8f.42.1751534800113;
        Thu, 03 Jul 2025 02:26:40 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:152e:1400:856d:9957:3ec3:1ddc])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a88c7fab6esm18489438f8f.31.2025.07.03.02.26.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Jul 2025 02:26:39 -0700 (PDT)
Date: Thu, 3 Jul 2025 05:26:37 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: Lukas Wunner <lukas@wunner.de>, Keith Busch <kbusch@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Parav Pandit <parav@nvidia.com>, virtualization@lists.linux.dev,
	stefanha@redhat.com, alok.a.tiwari@oracle.com,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>
Subject: [PATCH RFC v4 5/5] virtio: support device disconnect
Message-ID: <1854be16aefc3c0f033472099c909c442d3bc555.1751534711.git.mst@redhat.com>
References: <cover.1751534711.git.mst@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1751534711.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent

This adds support for device disconnect:
upon device surprise removal, virtio core makes sure
to no callbacks are running, and then notifies the driver.

At the moment, virtio pci is the only transport with this
functionality enabled, it does nothing for other transports.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 drivers/virtio/virtio_pci_common.c | 45 ++++++++++++++++++++++++++++++
 drivers/virtio/virtio_pci_common.h |  3 ++
 drivers/virtio/virtio_pci_legacy.c |  2 ++
 drivers/virtio/virtio_pci_modern.c |  2 ++
 include/linux/virtio.h             |  3 ++
 include/linux/virtio_config.h      | 32 +++++++++++++++++++++
 6 files changed, 87 insertions(+)

diff --git a/drivers/virtio/virtio_pci_common.c b/drivers/virtio/virtio_pci_common.c
index d6d79af44569..a475f47052eb 100644
--- a/drivers/virtio/virtio_pci_common.c
+++ b/drivers/virtio/virtio_pci_common.c
@@ -594,6 +594,51 @@ const struct cpumask *vp_get_vq_affinity(struct virtio_device *vdev, int index)
 				    vp_dev->vqs[index]->msix_vector);
 }
 
+/* Report disconnect to the driver. */
+static void virtio_pci_disconnect_work(struct work_struct *work)
+{
+	struct pci_dev *pci_dev = container_of(work, struct pci_dev,
+					       disconnect_work);
+	struct virtio_pci_device *vp_dev = pci_get_drvdata(pci_dev);
+	struct virtio_device *vdev = &vp_dev->vdev;
+	struct virtio_driver *drv = drv_to_virtio(vdev->dev.driver);
+
+	if (!pci_test_and_clear_disconnect_enable(pci_dev))
+		return;
+
+        virtio_config_transport_disable(vdev);
+	virtio_break_device(vdev);
+
+	vp_synchronize_vectors(vdev);
+
+	drv->disconnect(&vp_dev->vdev);
+}
+
+void virtio_pci_enable_disconnect(struct virtio_device *vdev)
+{
+	struct virtio_pci_device *vp_dev = to_vp_device(vdev);
+	struct pci_dev *pci_dev = vp_dev->pci_dev;
+	struct virtio_driver *drv = drv_to_virtio(vdev->dev.driver);
+
+	if (!drv->disconnect)
+		return;
+
+	INIT_WORK(&pci_dev->disconnect_work, virtio_pci_disconnect_work);
+	pci_set_disconnect_work(pci_dev);
+}
+
+void virtio_pci_disable_disconnect(struct virtio_device *vdev)
+{
+	struct virtio_pci_device *vp_dev = to_vp_device(vdev);
+	struct pci_dev *pci_dev = vp_dev->pci_dev;
+	struct virtio_driver *drv = drv_to_virtio(vdev->dev.driver);
+
+	if (!drv->disconnect)
+		return;
+
+	pci_clear_disconnect_work(pci_dev);
+}
+
 #ifdef CONFIG_PM_SLEEP
 static int virtio_pci_freeze(struct device *dev)
 {
diff --git a/drivers/virtio/virtio_pci_common.h b/drivers/virtio/virtio_pci_common.h
index 8cd01de27baf..982c4c8aabc8 100644
--- a/drivers/virtio/virtio_pci_common.h
+++ b/drivers/virtio/virtio_pci_common.h
@@ -161,6 +161,9 @@ static inline void virtio_pci_legacy_remove(struct virtio_pci_device *vp_dev)
 int virtio_pci_modern_probe(struct virtio_pci_device *);
 void virtio_pci_modern_remove(struct virtio_pci_device *);
 
+void virtio_pci_enable_disconnect(struct virtio_device *);
+void virtio_pci_disable_disconnect(struct virtio_device *);
+
 struct virtio_device *virtio_pci_vf_get_pf_dev(struct pci_dev *pdev);
 
 #define VIRTIO_LEGACY_ADMIN_CMD_BITMAP \
diff --git a/drivers/virtio/virtio_pci_legacy.c b/drivers/virtio/virtio_pci_legacy.c
index d9cbb02b35a1..cd424f619b47 100644
--- a/drivers/virtio/virtio_pci_legacy.c
+++ b/drivers/virtio/virtio_pci_legacy.c
@@ -191,6 +191,8 @@ static const struct virtio_config_ops virtio_pci_config_ops = {
 	.set		= vp_set,
 	.get_status	= vp_get_status,
 	.set_status	= vp_set_status,
+	.enable_disconnect = virtio_pci_enable_disconnect,
+	.disable_disconnect = virtio_pci_disable_disconnect,
 	.reset		= vp_reset,
 	.find_vqs	= vp_find_vqs,
 	.del_vqs	= vp_del_vqs,
diff --git a/drivers/virtio/virtio_pci_modern.c b/drivers/virtio/virtio_pci_modern.c
index 7182f43ed055..b3dfb403913f 100644
--- a/drivers/virtio/virtio_pci_modern.c
+++ b/drivers/virtio/virtio_pci_modern.c
@@ -1230,6 +1230,8 @@ static const struct virtio_config_ops virtio_pci_config_nodev_ops = {
 	.generation	= vp_generation,
 	.get_status	= vp_get_status,
 	.set_status	= vp_set_status,
+	.enable_disconnect = virtio_pci_enable_disconnect,
+	.disable_disconnect = virtio_pci_disable_disconnect,
 	.reset		= vp_reset,
 	.find_vqs	= vp_modern_find_vqs,
 	.del_vqs	= vp_del_vqs,
diff --git a/include/linux/virtio.h b/include/linux/virtio.h
index 072a25f6622c..a091651e3144 100644
--- a/include/linux/virtio.h
+++ b/include/linux/virtio.h
@@ -214,6 +214,8 @@ size_t virtio_max_dma_size(const struct virtio_device *vdev);
  * @scan: optional function to call after successful probe; intended
  *    for virtio-scsi to invoke a scan.
  * @remove: the function to call when a device is removed.
+ * @disconnect: the function to call on disconnect (surprise removal),
+ *    before remove.
  * @config_changed: optional function to call when the device configuration
  *    changes; may be called in interrupt context.
  * @freeze: optional function to call during suspend/hibernation.
@@ -235,6 +237,7 @@ struct virtio_driver {
 	int (*validate)(struct virtio_device *dev);
 	int (*probe)(struct virtio_device *dev);
 	void (*scan)(struct virtio_device *dev);
+	void (*disconnect)(struct virtio_device *dev);
 	void (*remove)(struct virtio_device *dev);
 	void (*config_changed)(struct virtio_device *dev);
 	int (*freeze)(struct virtio_device *dev);
diff --git a/include/linux/virtio_config.h b/include/linux/virtio_config.h
index b3e1d30c765b..861198a74be2 100644
--- a/include/linux/virtio_config.h
+++ b/include/linux/virtio_config.h
@@ -58,6 +58,10 @@ struct virtqueue_info {
  * @set_status: write the status byte
  *	vdev: the virtio_device
  *	status: the new status byte
+ * @enable_disconnect: driver will get disconnect callbacks
+ *	vdev: the virtio_device
+ * @disable_disconnect: driver will not get disconnect callbacks
+ *	vdev: the virtio_device
  * @reset: reset the device
  *	vdev: the virtio device
  *	After this, status and feature negotiation must be done again
@@ -113,6 +117,8 @@ struct virtio_config_ops {
 	u32 (*generation)(struct virtio_device *vdev);
 	u8 (*get_status)(struct virtio_device *vdev);
 	void (*set_status)(struct virtio_device *vdev, u8 status);
+	void (*enable_disconnect)(struct virtio_device *vdev);
+	void (*disable_disconnect)(struct virtio_device *vdev);
 	void (*reset)(struct virtio_device *vdev);
 	int (*find_vqs)(struct virtio_device *vdev, unsigned int nvqs,
 			struct virtqueue *vqs[],
@@ -299,6 +305,32 @@ void virtio_device_ready(struct virtio_device *dev)
 	dev->config->set_status(dev, status | VIRTIO_CONFIG_S_DRIVER_OK);
 }
 
+/**
+ * virtio_device_enable_disconnect - enable disconnect callback
+ * @dev: the virtio device
+ *
+ * Driver must call this in the probe function.
+ */
+static inline
+void virtio_device_enable_disconnect(struct virtio_device *dev)
+{
+	if (dev->config->enable_disconnect)
+		dev->config->enable_disconnect(dev);
+}
+
+/**
+ * virtio_device_disable_disconnect - enable disconnect callback
+ * @dev: the virtio device
+ *
+ * Driver must call this in the remove function.
+ */
+static inline
+void virtio_device_disable_disconnect(struct virtio_device *dev)
+{
+	if (dev->config->disable_disconnect)
+		dev->config->disable_disconnect(dev);
+}
+
 static inline
 const char *virtio_bus_name(struct virtio_device *vdev)
 {
-- 
MST


