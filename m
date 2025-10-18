Return-Path: <linux-kernel+bounces-858882-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 642C3BEC21A
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Oct 2025 02:12:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D33CF6E078D
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Oct 2025 00:10:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A93C212554;
	Sat, 18 Oct 2025 00:07:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CKsGIxbd"
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9817F1F3BA2
	for <linux-kernel@vger.kernel.org>; Sat, 18 Oct 2025 00:07:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760746066; cv=none; b=BrDjcJskH+izfdg/HbjwYLUgH/NFSlhsAIuayEJQgNd77CNXo9s22CbWhqyAgcnC12Ibq6OfJ4YfT3rx7vTK6pbfAtrVvuh43GpTL//PpXdLcYFetE5rj+5XIL4qfD1yg3nnY5S8M9iDVALpDriFJuZq63cDLIAD8jVocxoszok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760746066; c=relaxed/simple;
	bh=/Zwi58c0tnVXnIkT6QEOTDduqWPDxbPVbNm/jJa1Zmk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=CTgmY0LPrrfJcLCWU0ApwmOiptrJ5sCKJta/orA66I1zdT2T61eD1HgntPVuz4q8MK/fdnSPB88AIZ29QHfsCRPigT2+JemH9cZ+i7GEqh8XyIr6Nrj0DTppNeyErdg5kaf+TC386jv384DYxgGRibxu/exE/sN+c3dm+pF6A+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--vipinsh.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CKsGIxbd; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vipinsh.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2904e9e0ef9so45624505ad.3
        for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 17:07:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760746064; x=1761350864; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=pb+yM/GSLfD7F9NEd5q0iCevSvrZqDGm2r7fPtuoE4o=;
        b=CKsGIxbdeErOW/fHGYaTjsdg6IV0+LUHB8zpauXFiqZZa+2Ge4t1eHsT8gCrwnMp54
         r8M7ZM/bwC5LRtHQ41HLTUZ0wudq3/DyKkne2F80T++y/4IMjqIawb9hpeAWVQ/4Qa7I
         NEzp5BGPurbCMiqENI/CoF4Bhv2vdQXmla5uS337Td2lKFIS3BIDwZ+5BNvvfLIfpUIy
         Km3Zyd/6opfWLQmTZwuliQR1W1IoTK360I9EfvlI2nD9yNJz7QRd3oGvhI/E/9Xulka/
         o1T+ZOLf38BLVRke04ag2AvME2+qByVhsGqXge53V9ZVZbGG1oCbcqQYcQN4p41MRBc7
         EBxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760746064; x=1761350864;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pb+yM/GSLfD7F9NEd5q0iCevSvrZqDGm2r7fPtuoE4o=;
        b=LCoWitEO9ovWRsZd6LbSOC99og8YiSN+98hg2C0z+bTpAqskcvEjfMvgLWGShwfGFm
         uZ5KMnUR05rjqrgy0Jq3DyGdFdbnxh1vm3w8dfuOewLbRS5OOEffPTn9m07PihW1/DEc
         4vbYRyqmTxk172IC1WLfI+MI7vBWcu0VUYOQ4akJyTbegGnmoI27tQPtm5Ydm8g4HZnm
         eC6V1SIx6SO0TsL9+LYYob8Pbht2WDUueEo7mRsMZkNNIBmIwpuQhkQDHY5x9ejrrdN3
         0XUdvIMaqVQjqPyHvrzqvZfwm871cQmY3lENrhH3qbgb096hGUlYUBnjeV4dWot3u4rE
         9rxg==
X-Forwarded-Encrypted: i=1; AJvYcCVvCChmgBZNYrwo99w3/pQ1efMAm24v8cfv1+8w7aDRMcEdBHGBu3SJF7CwbiFiydNaRUndAaFLiONFdk4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzuShvxRsFQmYlCWiXpC3RQGb7Ve3X30MAVkdSU84h1cM0C+6q3
	FAGx0RSqRTneAD97Nn+77j4bL+TCH72ONPz8HNCx4ugYKl5yvbcNg7AuzgxaWDh6aHBJRdpHkAL
	PJ9ZXg2TyKw==
X-Google-Smtp-Source: AGHT+IFm8I2WbT23xHEc9aRTbzh15nGTE4Afs2ZbYTvSrJoFR5A/1hUgI6fsM2AyRelH/yPNccAGYfnt5l6E
X-Received: from plww18.prod.google.com ([2002:a17:902:d112:b0:290:28e2:ce49])
 (user=vipinsh job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:fc4f:b0:25c:982e:2b1d
 with SMTP id d9443c01a7336-290cbb474f7mr68357455ad.59.1760746063874; Fri, 17
 Oct 2025 17:07:43 -0700 (PDT)
Date: Fri, 17 Oct 2025 17:07:04 -0700
In-Reply-To: <20251018000713.677779-1-vipinsh@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251018000713.677779-1-vipinsh@google.com>
X-Mailer: git-send-email 2.51.0.858.gf9c4a03a3a-goog
Message-ID: <20251018000713.677779-13-vipinsh@google.com>
Subject: [RFC PATCH 12/21] vfio/pci: Skip clearing bus master on live update
 restored device
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

Store the restored serialized data in struct vfio_pci_core_device{}.
Skip clearing the bus master bit on the restored VFIO devices when
opened for the first time after live update reboot.

In the live update finish, clean up the pointer to the restored KHO
data. Warn if the device open count is 0, which indicates that userspace
might not have opened and restored the device.

Signed-off-by: Vipin Sharma <vipinsh@google.com>
---
 drivers/vfio/pci/vfio_pci_core.c       |  8 ++++++--
 drivers/vfio/pci/vfio_pci_liveupdate.c | 19 ++++++++++++++-----
 include/linux/vfio_pci_core.h          |  1 +
 3 files changed, 21 insertions(+), 7 deletions(-)

diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pci_core.c
index 0894673a9262..29236b015242 100644
--- a/drivers/vfio/pci/vfio_pci_core.c
+++ b/drivers/vfio/pci/vfio_pci_core.c
@@ -475,8 +475,12 @@ int vfio_pci_core_enable(struct vfio_pci_core_device *vdev)
 			return ret;
 	}
 
-	/* Don't allow our initial saved state to include busmaster */
-	pci_clear_master(pdev);
+	/*
+	 * Don't allow our initial saved state to include busmaster. However, if
+	 * device is participating in liveupdate then don't change this bit.
+	 */
+	if (!vdev->liveupdate_restore)
+		pci_clear_master(pdev);
 
 	ret = pci_enable_device(pdev);
 	if (ret)
diff --git a/drivers/vfio/pci/vfio_pci_liveupdate.c b/drivers/vfio/pci/vfio_pci_liveupdate.c
index 789b52665e35..6cc94d9a0386 100644
--- a/drivers/vfio/pci/vfio_pci_liveupdate.c
+++ b/drivers/vfio/pci/vfio_pci_liveupdate.c
@@ -96,12 +96,10 @@ static void vfio_pci_liveupdate_finish(struct liveupdate_file_handler *handler,
 	struct vfio_device *device;
 	struct folio *folio;
 
-	if (reclaimed) {
+	if (reclaimed)
 		folio = virt_to_folio(phys_to_virt(data));
-		goto out_folio_put;
-	} else {
+	else
 		folio = kho_restore_folio(data);
-	}
 
 	if (!folio)
 		return;
@@ -113,7 +111,14 @@ static void vfio_pci_liveupdate_finish(struct liveupdate_file_handler *handler,
 		goto out_folio_put;
 
 	vdev = container_of(device, struct vfio_pci_core_device, vdev);
-	pci_try_reset_function(vdev->pdev);
+	if (reclaimed) {
+		guard(mutex)(&device->dev_set->lock);
+		if (!vfio_device_cdev_opened(device))
+			pci_err(vdev->pdev, "Open count is 0, userspace might not have restored the device.\n");
+		vdev->liveupdate_restore = NULL;
+	} else {
+		pci_try_reset_function(vdev->pdev);
+	}
 	put_device(&device->device);
 
 out_folio_put:
@@ -124,6 +129,7 @@ static int vfio_pci_liveupdate_retrieve(struct liveupdate_file_handler *handler,
 					u64 data, struct file **file)
 {
 	struct vfio_pci_core_device_ser *ser;
+	struct vfio_pci_core_device *vdev;
 	struct vfio_device_file *df;
 	struct vfio_device *device;
 	struct folio *folio;
@@ -167,6 +173,9 @@ static int vfio_pci_liveupdate_retrieve(struct liveupdate_file_handler *handler,
 	 */
 	filep->f_mapping = device->inode->i_mapping;
 	*file = filep;
+	vdev = container_of(device, struct vfio_pci_core_device, vdev);
+	guard(mutex)(&device->dev_set->lock);
+	vdev->liveupdate_restore = ser;
 
 	return 0;
 
diff --git a/include/linux/vfio_pci_core.h b/include/linux/vfio_pci_core.h
index f541044e42a2..8c3fe2db7eb3 100644
--- a/include/linux/vfio_pci_core.h
+++ b/include/linux/vfio_pci_core.h
@@ -94,6 +94,7 @@ struct vfio_pci_core_device {
 	struct vfio_pci_core_device	*sriov_pf_core_dev;
 	struct notifier_block	nb;
 	struct rw_semaphore	memory_lock;
+	void			*liveupdate_restore;
 };
 
 /* Will be exported for vfio pci drivers usage */
-- 
2.51.0.858.gf9c4a03a3a-goog


