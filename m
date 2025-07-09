Return-Path: <linux-kernel+bounces-724470-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A085AFF34D
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 22:56:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4C27D5A4BF7
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 20:56:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F08E23BCE2;
	Wed,  9 Jul 2025 20:55:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bha1WtoZ"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0150E248F55
	for <linux-kernel@vger.kernel.org>; Wed,  9 Jul 2025 20:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752094542; cv=none; b=CtQsGgqZpeM1X1MRRwtA1Z6kyOXpCTQFAQ3YtfsPDKY/beUmUpz/3wVOuqazyyQgz9/2/+vz02wyWexFTItQ4+8XcdhI721+k0OVhAYpTjaDNGZ0TG/NXAOyk8XKn39p+ZuLW68v4Yx/7unfhwsdCFliyM6tJRn4neGjVCErFIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752094542; c=relaxed/simple;
	bh=ixhuBTYfea3ddE2iz9G1mIy9dwkewDEfDsZY+6NW2nw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y8C1OB7kR0QIZ67KZXfGfHl0W8cvseiGXBZ7rMraDYozAe+yQrMw0kj/C6Uzo1PocUYm7ta0bO9wd7URdeaRYT9OpJT9+L6V62iDW1Am0xYXjIu4GvJaw2jAO5nMBX5n+V84jiGhX7gMXzw1EFDqQCKXQGruyaAZGfw6VG81xY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bha1WtoZ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752094540;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=iyE61h0zJVl0tJYFuJIzKM7tu1ObimreBAr/5qShF90=;
	b=bha1WtoZWxjBIU0xAzrmdZNgXAVmYwaIq8VWSCaBBfquEggxGEYF+TMrNiWwiBycLiCKBC
	LTN7yKx+spylWl/1YkOO1vJ0WJZkDYxHASZBVMwR5zBM9jzNxTLMgBprfp1Vm5QwVoXIBu
	1RuJcfxyVMmm6ttZKfabkH59vb2D+no=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-118-7uLTOtpgNnOOt49OV9tlBg-1; Wed, 09 Jul 2025 16:55:38 -0400
X-MC-Unique: 7uLTOtpgNnOOt49OV9tlBg-1
X-Mimecast-MFC-AGG-ID: 7uLTOtpgNnOOt49OV9tlBg_1752094537
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-3a4e9252ba0so208185f8f.0
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jul 2025 13:55:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752094536; x=1752699336;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iyE61h0zJVl0tJYFuJIzKM7tu1ObimreBAr/5qShF90=;
        b=OCckP++CU7BqbQyW1tjbzcsNLAXa7nQLqkCMm2Bbx9img9ytwIwpL24bF0zu5ZH/Ui
         lE5WKkSedXTUcIq9UnyUl0rkJ9Hu80KCPNshKmYP67zKWEvJbmuX4CDoFPwMgS3xADyO
         YUvFDdPs5KzMOk2SwzT31wPjC86+3PimWTUzU6Fv9IqfI3Od/uKrHLyZ9vjgMv+GNU23
         QQxfCDl1YeAQkqkwBHt1MfPrDTj5CzHpfz/ks/hCiGn7V4fNQD1R/AVIKEB2zMqbjbZl
         Jbaaeyt1glTrY9PlXo1hEtMyZuBPYe6Kii7k84a1bK1Z75nnWKAh44lHk9rVL9EmyuGU
         RlZQ==
X-Gm-Message-State: AOJu0YwUt3bBAbto3zrCqCOY67H9EFfKZjqNsdexJnz4wI5CNrksHwUZ
	9fN095kB2MyxKNpohplqwSMUMTqQNfNSh6Inss7gINkDYk+zaqtLdKOlCW57ruHbiMJkvnMcMVm
	ZD1W1velGJLty1/iIuRHyBjlg+VAmF3PLOlOU/VHz4bQoMk1mnWo5zJSGOVIAaTgGB27HwfO3gC
	P/zGEEg1Mb7qRMhUPi7jY+WTjZFKRwB6Z+kmPFFRgcLtw=
X-Gm-Gg: ASbGncvnny5+WKEq0cs2fWqtVNvqTRgKD1rK06fBiwGVxj4Beax759lS5H5KA/thF5N
	OKJus5MaDBwN+KRp3rphGMW3QyNGOuZnzdtT4WIUnMtENpmS3MRfa3G/zAi5uh6dKCspvep8rD8
	7subGCYVI3ZAQf62O9LjIzGztoL7jfVzV2LutOwse4vO+0qzHF7iQFzzZR/0Zltal3dGKkT7daY
	wo6EA/jTqpapwReGV/SDUi7EQ9Oy0loIIcOynrUVVt905/KrNfKTF63PiKRyFNKapn0Zq332W6T
	UqVCFDkxaIaKnVI=
X-Received: by 2002:a05:6000:40d9:b0:3b2:fe84:a10 with SMTP id ffacd0b85a97d-3b5e7650d66mr1214807f8f.0.1752094536435;
        Wed, 09 Jul 2025 13:55:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGpsMPu7CU6gE5ErnQ6ZCj2ysNbEZlkEPok6bMsjf7y8BkX7URX96NcV6dlU7ULjAJLQlSWtg==
X-Received: by 2002:a05:6000:40d9:b0:3b2:fe84:a10 with SMTP id ffacd0b85a97d-3b5e7650d66mr1214783f8f.0.1752094535966;
        Wed, 09 Jul 2025 13:55:35 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:150d:fc00:de3:4725:47c6:6809])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b47030bd90sm17238302f8f.15.2025.07.09.13.55.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Jul 2025 13:55:35 -0700 (PDT)
Date: Wed, 9 Jul 2025 16:55:33 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: Lukas Wunner <lukas@wunner.de>, Keith Busch <kbusch@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Parav Pandit <parav@nvidia.com>, virtualization@lists.linux.dev,
	stefanha@redhat.com, alok.a.tiwari@oracle.com,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>
Subject: [PATCH RFC v5 4/5] virtio: allow transports to suppress config change
Message-ID: <bd9a6c26e03cafdc41a678c6eb12c0e91b7d0e69.1752094439.git.mst@redhat.com>
References: <cover.1752094439.git.mst@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1752094439.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent

Will be used on surprise removal, so we don't need to
re-check.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 drivers/virtio/virtio.c | 18 +++++++++++++++++-
 include/linux/virtio.h  |  2 ++
 2 files changed, 19 insertions(+), 1 deletion(-)

diff --git a/drivers/virtio/virtio.c b/drivers/virtio/virtio.c
index c441c8cc71ef..1dd5cdf68c1d 100644
--- a/drivers/virtio/virtio.c
+++ b/drivers/virtio/virtio.c
@@ -127,7 +127,8 @@ static void __virtio_config_changed(struct virtio_device *dev)
 {
 	struct virtio_driver *drv = drv_to_virtio(dev->dev.driver);
 
-	if (!dev->config_core_enabled || dev->config_driver_disabled)
+	if (!dev->config_core_enabled || dev->config_driver_disabled ||
+	    dev->config_transport_disabled)
 		dev->config_change_pending = true;
 	else if (drv && drv->config_changed) {
 		drv->config_changed(dev);
@@ -193,6 +194,20 @@ static void virtio_config_core_enable(struct virtio_device *dev)
 	spin_unlock_irq(&dev->config_lock);
 }
 
+/**
+ * virtio_config_transport_disable - disable config change reporting by transport
+ * @dev: the device in question
+ *
+ * This must only be called by transport and enabling is not allowed.
+ */
+void virtio_config_transport_disable(struct virtio_device *dev)
+{
+	spin_lock_irq(&dev->config_lock);
+	dev->config_transport_disabled = true;
+	spin_unlock_irq(&dev->config_lock);
+}
+EXPORT_SYMBOL_GPL(virtio_config_transport_disable);
+
 void virtio_add_status(struct virtio_device *dev, unsigned int status)
 {
 	might_sleep();
@@ -530,6 +545,7 @@ int register_virtio_device(struct virtio_device *dev)
 		goto out_ida_remove;
 
 	spin_lock_init(&dev->config_lock);
+	dev->config_transport_disabled = false;
 	dev->config_driver_disabled = false;
 	dev->config_core_enabled = false;
 	dev->config_change_pending = false;
diff --git a/include/linux/virtio.h b/include/linux/virtio.h
index be0beb16b487..072a25f6622c 100644
--- a/include/linux/virtio.h
+++ b/include/linux/virtio.h
@@ -151,6 +151,7 @@ struct virtio_device {
 	bool failed;
 	u8 config_core_enabled:1;
 	u8 config_driver_disabled:1;
+	u8 config_transport_disabled:1;
 	u8 config_change_pending:1;
 	spinlock_t config_lock;
 	spinlock_t vqs_list_lock;
@@ -185,6 +186,7 @@ void virtio_config_changed(struct virtio_device *dev);
 void virtio_config_driver_disable(struct virtio_device *dev);
 void virtio_config_driver_enable(struct virtio_device *dev);
 
+void virtio_config_transport_disable(struct virtio_device *dev);
 #ifdef CONFIG_PM_SLEEP
 int virtio_device_freeze(struct virtio_device *dev);
 int virtio_device_restore(struct virtio_device *dev);
-- 
MST


