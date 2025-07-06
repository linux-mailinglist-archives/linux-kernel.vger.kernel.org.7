Return-Path: <linux-kernel+bounces-712638-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A92A2AF0C6E
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Jul 2025 09:21:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 929831C2152E
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Jul 2025 07:21:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4921422D7A7;
	Wed,  2 Jul 2025 07:20:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LNq4hjC+"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E65221E47AE
	for <linux-kernel@vger.kernel.org>; Wed,  2 Jul 2025 07:20:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751440858; cv=none; b=rbeQ6bVleUXiQRTwkMR0fbkBfT4jWaMrrfl6fY2K2XMJgU3owhBjh1jxppLty9LCTaj6lnd9oc5ZKq+7KiXubfCVkOCW+2We7Ef15Qiybi1KVcccL6NfJzT4iyaQ7JGZ1lkopNcGcjmSThY700KQbYw7gPdUfC/AYw8SjmRtITA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751440858; c=relaxed/simple;
	bh=rDdbRQ2GykeER2SnX1xkF1pAGy/+zzWxsZ+2SzCxzYg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=USco6JaPDmfajVGEfuz4YaXx+TVk4uQ97IQlJkJCf2EaAY/yBlcdp7uHcOI5gYmukKDTMHMEiGy/uyhYwCOK/xw+AO2v/qKMpla+NUmapOX4hXsnVVG4gEstew02yn/ReqfBIxGtBCgqos3RSn2vE635eqxNG8WT6DxXINTBJ7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LNq4hjC+; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751440855;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=3UQYnC1Uj+FP/5u+XpjAfPehyEkGumzn9sTZOVjMEoY=;
	b=LNq4hjC+LHDCyykwPPzFH7pTTRIuaqM3qaZqMqmzhPngxkkKGherOVZTrUHhqE22eEPbvt
	1ed74vyFdBT9muCW876LrcjyHtAhE34LqZF0gXUlK/AiETn/GfZVdOwquTElnYcWEXhOEw
	wSEsQ+Sy6jhc9tKZhtIr3gyx3ed299A=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-153-9b2eoFVgOp2kU7u0UoqdIg-1; Wed, 02 Jul 2025 03:20:54 -0400
X-MC-Unique: 9b2eoFVgOp2kU7u0UoqdIg-1
X-Mimecast-MFC-AGG-ID: 9b2eoFVgOp2kU7u0UoqdIg_1751440853
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-453a190819bso21198505e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 02 Jul 2025 00:20:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751440853; x=1752045653;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3UQYnC1Uj+FP/5u+XpjAfPehyEkGumzn9sTZOVjMEoY=;
        b=Va46+t4AGWCppoc9WUYB4KNb0DJ9wVHcYRrNOzyAFGv9Oqskaeki20bH/MkAGhW9uc
         lNf9uocNduzXkRZDPHo736NPZRZGsYZ2AYx9Qy2Y3N9v5gk0QUDJKh/AL3YKQ4Jkdtdh
         OjaYF+pB34W4u8Zez2+Pz7NA4qVEp0PFfwXfmOjAIFrnsgCnJlxCESqpfmGaeVVPPHGc
         pFK6PKbTOOvwsn6OYETgMyNmIcrJD3+zc/S4vlJjL8j9Yr0SgsYT3a3ntdsnlSWuo2yE
         Vjt15QuKRkoyFYUTA3PzHWXnzEmAdFp52sdzsoWZARyF+MjRyZ2kBGASE/+OE5sh8SgH
         I+8w==
X-Gm-Message-State: AOJu0YzAvtaMaphKoJxcItvuxFupeFyrrFCesVwfWqE2ncJZC/Eh6CUj
	d+H+cCj4G7RX9iMSSFDpHRikmiTDALfmtY9N8jyWy50MTtTZy6j3OJZiIsYg67vKO4ymAFgSuem
	PEeEZt/y3cvFhe9wAux5+NuLQjN0cPsrvBRPDZYleSBIsaXv2Ne0F5ird/K3qdF/dP40hK004TQ
	G0V4KZAE7FLoJLxduyX55JQxGLMjj6JZEpFlVtwa6LGUQ=
X-Gm-Gg: ASbGncsadMnDGgHPzpMLEWMH8UO82X5YUDsIeOYUCBNCieQHEa/8jwl0E+tqOyvQJBn
	Q+C1CpvWwThiPmXFWI2cTnBkTZ8FPUZmvv8m8hdRknu5EIww9LmwQc9+w/mWXngdel8bo/BwKmJ
	fRJIXCzFvNQM3XB5OAZzCuGljPkv+HWSSjM/zFDGjH6zsiMOHM1RGE+aZ6m4gxMmFhhOBh7mo7U
	iS9S1aA3lQbY5yME7XQCSeOAj2viH0QTo8Tv8WfgtXJICShE7ccV05hn2Skxh5sO5e2ilbSoW9z
	RSyQ6FrUZfv108CY
X-Received: by 2002:a05:600c:4686:b0:43d:fa59:af97 with SMTP id 5b1f17b1804b1-454a373566emr14889325e9.32.1751440852843;
        Wed, 02 Jul 2025 00:20:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFU12Z8ggQ0R6Z0B/hxd+EmZh3IQvavd5AT/0Ts/FptyhpCk8URLdlTDVsIsvjAtWLz35dAzQ==
X-Received: by 2002:a05:600c:4686:b0:43d:fa59:af97 with SMTP id 5b1f17b1804b1-454a373566emr14889055e9.32.1751440852301;
        Wed, 02 Jul 2025 00:20:52 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:152e:1400:856d:9957:3ec3:1ddc])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-453823ad01csm220359205e9.22.2025.07.02.00.20.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jul 2025 00:20:51 -0700 (PDT)
Date: Wed, 2 Jul 2025 03:20:50 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Subject: [PATCH RFC v3] pci: report surprise removal event
Message-ID: <1eac13450ade12cc98b15c5864e5bcd57f9e9882.1751440755.git.mst@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent

At the moment, in case of a surprise removal, the regular remove
callback is invoked, exclusively.  This works well, because mostly, the
cleanup would be the same.

However, there's a race: imagine device removal was initiated by a user
action, such as driver unbind, and it in turn initiated some cleanup and
is now waiting for an interrupt from the device. If the device is now
surprise-removed, that never arrives and the remove callback hangs
forever.

For example, this was reported for virtio-blk:

	1. the graceful removal is ongoing in the remove() callback, where disk
	   deletion del_gendisk() is ongoing, which waits for the requests +to
	   complete,

	2. Now few requests are yet to complete, and surprise removal started.

	At this point, virtio block driver will not get notified by the driver
	core layer, because it is likely serializing remove() happening by
	+user/driver unload and PCI hotplug driver-initiated device removal.  So
	vblk driver doesn't know that device is removed, block layer is waiting
	for requests completions to arrive which it never gets.  So
	del_gendisk() gets stuck.

Drivers can artificially add timeouts to handle that, but it can be
flaky.

Instead, let's add a way for the driver to be notified about the
disconnect. It can then do any necessary cleanup, knowing that the
device is inactive.

Since cleanups can take a long time, this takes an approach
of a work struct that the driver initiates and enables
on probe, and tears down on remove.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---


Compile tested only.

Note: this minimizes core code. I considered a more elaborate API
that would be easier to use, but decided to be conservative until
there are multiple users.

changes from v2
	v2 was corrupted, fat fingers :(

changes from v1:
        switched to a WQ, with APIs to enable/disable
        added motivation


 drivers/pci/pci.h   |  6 ++++++
 include/linux/pci.h | 27 +++++++++++++++++++++++++++
 2 files changed, 33 insertions(+)

diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index b81e99cd4b62..208b4cab534b 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -549,6 +549,12 @@ static inline int pci_dev_set_disconnected(struct pci_dev *dev, void *unused)
 	pci_dev_set_io_state(dev, pci_channel_io_perm_failure);
 	pci_doe_disconnected(dev);
 
+	if (READ_ONCE(dev->disconnect_work_enable)) {
+		/* Make sure work is up to date. */
+		smp_rmb();
+		schedule_work(&dev->disconnect_work);
+	}
+
 	return 0;
 }
 
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 51e2bd6405cd..b2168c5d0679 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -550,6 +550,10 @@ struct pci_dev {
 	/* These methods index pci_reset_fn_methods[] */
 	u8 reset_methods[PCI_NUM_RESET_METHODS]; /* In priority order */
 
+	/* Report disconnect events */
+	u8 disconnect_work_enable;
+	struct work_struct disconnect_work;
+
 #ifdef CONFIG_PCIE_TPH
 	u16		tph_cap;	/* TPH capability offset */
 	u8		tph_mode;	/* TPH mode */
@@ -2657,6 +2661,29 @@ static inline bool pci_is_dev_assigned(struct pci_dev *pdev)
 	return (pdev->dev_flags & PCI_DEV_FLAGS_ASSIGNED) == PCI_DEV_FLAGS_ASSIGNED;
 }
 
+/*
+ * Caller must initialize @pdev->disconnect_work before invoking this.
+ * Caller also must check pci_device_is_present afterwards, since
+ * if device is already gone when this is called, work will not run.
+ */
+static inline void pci_set_disconnect_work(struct pci_dev *pdev)
+{
+	/* Make sure WQ has been initialized already */
+	smp_wmb();
+
+	WRITE_ONCE(pdev->disconnect_work_enable, 0x1);
+}
+
+static inline void pci_clear_disconnect_work(struct pci_dev *pdev)
+{
+	WRITE_ONCE(pdev->disconnect_work_enable, 0x0);
+
+	/* Make sure to stop using work from now on. */
+	smp_wmb();
+
+	cancel_work_sync(&pdev->disconnect_work);
+}
+
 /**
  * pci_ari_enabled - query ARI forwarding status
  * @bus: the PCI bus
-- 
MST


