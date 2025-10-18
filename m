Return-Path: <linux-kernel+bounces-858879-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C20F5BEC1C6
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Oct 2025 02:09:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id AA69A4E3B42
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Oct 2025 00:09:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE5E5208D0;
	Sat, 18 Oct 2025 00:07:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="G4MJr3Te"
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 498221DDC1B
	for <linux-kernel@vger.kernel.org>; Sat, 18 Oct 2025 00:07:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760746061; cv=none; b=n6WNnLxLOe24LhjT/uIhPwcglDCfNAf9gyEEC8bJ5Y1WsUQAT9E49HInjwRwHrAsCHeR3xZMGuH5ZhYIIYPFJv+jvLBGAShIivm3jcukUPekFfU/QYXR9tYVOnMxoN874EZqbMqNUrzKQtdzGwTCfD8a8Z5/K5U7PRk5fh8dR/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760746061; c=relaxed/simple;
	bh=V76LbfI6Ajfy7OIRb8JcXF9vRsTvCVLWBlvUz+UEmyg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=a8PQLWS9hkCynBLd8j+yh33x5w3Twh+moEbBy/8Ixn1j61JSKYGrEQIGC7i/sOVnl8jfJeViEzRfbMEdEfzei8tZOjqwy3tRTNL5WOVmY47Lv392zSnPW8aHxdZHEN5rB7z8t7k9Etgk18QTw2WTUs8Up6F0saVbxtdePel2l58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--vipinsh.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=G4MJr3Te; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vipinsh.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2697410e7f9so62953645ad.2
        for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 17:07:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760746059; x=1761350859; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=GaQ2mjvzcYnMnP1cm0axc8iEarDnxUhNwXsWFDf7Cg4=;
        b=G4MJr3Tef5Amf3FG17p+7c4g/NBzHmwxyZsXr+P8rDwbgd0ogtRFXOHzZ3y8jdLMP2
         bQpIMmnBeUwnrmag100OIhfyB/K37VIMvuC9vEF1OKQAAmGYCuZS31CvbmJDgzJta+yx
         Aqtox1IkRo8Ce4A8ILiyYR6euo/OQ30eY8PHUcqw0pOSNS9sh0gBlDdndjBKNoSR2SIT
         mQunujn5/z+zngMmSwaKCL+MyCQ+mxCxEPTcjjhqj4b9tGsYy8Of+qRolMVw49L2elNy
         kHt/LcNFB9Q7lpdqIPEZBQuoPeRTcqT3VGlnKXd12DiIsVTdbxXoSpdSKsbS3lZNkQiT
         DP0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760746059; x=1761350859;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GaQ2mjvzcYnMnP1cm0axc8iEarDnxUhNwXsWFDf7Cg4=;
        b=PFxY4iw4pdplRM+OQUWApE+chPkKyR3I7UJHcgJGkVJfODdchhV/NKv1GC8NNGrDeE
         yyoNOTa1fbkczdAZAqz8SbJwXjSUlAP9J3rJoSoxfR65dpqmuPJ8u2mRajhGGiVXgkTk
         64Ngyh0CYTryp9U/8IE6MMI15TIY0RfMaUJTK1Zq77Jtj6NS2NYEoA6CY8BnAi8s34kz
         7xHdid4ayEQU64fwFrzKs4eGaSK6nDIDyKOptQZH10FXbD2lus1ogkz2wa651pVaEtTp
         2ZhyZnofNJV8rQ8HDgTfClqdW/K1Ja9W+N0X0UvqQ9KoRvl+ulOalwN8uRrZ51CJdahD
         y1Aw==
X-Forwarded-Encrypted: i=1; AJvYcCWwoQeKNVwEziMgR1Ejle/vAA/fy4s6tym7GCPdM2HQevwDtosOjgh4s/ZGsFZwYDnjSVpw8DM8XJUckcw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJ2SrOtf8mTkUsmp31P1dKYysF6g8POuG5HIP5B5yLawTR+DqH
	2NRD8t4ggeQ0MQy0cvcsI2DnTBXMk5vClJwiwM5wVIWBxF1mnZ5IIQZB6A+5Co0JQO5howsbDlz
	CajRR9UXirw==
X-Google-Smtp-Source: AGHT+IF9dj9Clef1an1TtVMDSsqxw8xp26H//zMhQIxwHrxbjHJhb8hDM1WzMLrsR8CmCfH4zUTMov9736X/
X-Received: from plri16.prod.google.com ([2002:a17:903:32d0:b0:268:11e:8271])
 (user=vipinsh job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:cf0b:b0:24c:cb60:f6f0
 with SMTP id d9443c01a7336-290cb66025amr69035715ad.58.1760746058804; Fri, 17
 Oct 2025 17:07:38 -0700 (PDT)
Date: Fri, 17 Oct 2025 17:07:01 -0700
In-Reply-To: <20251018000713.677779-1-vipinsh@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251018000713.677779-1-vipinsh@google.com>
X-Mailer: git-send-email 2.51.0.858.gf9c4a03a3a-goog
Message-ID: <20251018000713.677779-10-vipinsh@google.com>
Subject: [RFC PATCH 09/21] vfio/pci: Add Live Update finish callback implementation
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

Add finish() callback implentation in LUO file handler to free restored
folio. Reset the VFIO device if it is not reclaimed by userspace.

Signed-off-by: Vipin Sharma <vipinsh@google.com>
---
 drivers/vfio/pci/vfio_pci_liveupdate.c | 33 ++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/drivers/vfio/pci/vfio_pci_liveupdate.c b/drivers/vfio/pci/vfio_pci_liveupdate.c
index cb3ff097afbf..8e0ee01127b3 100644
--- a/drivers/vfio/pci/vfio_pci_liveupdate.c
+++ b/drivers/vfio/pci/vfio_pci_liveupdate.c
@@ -82,6 +82,38 @@ static int match_bdf(struct device *device, const void *bdf)
 	return *(u16 *)bdf == pci_dev_id(vdev->pdev);
 }
 
+static void vfio_pci_liveupdate_finish(struct liveupdate_file_handler *handler,
+				       struct file *file, u64 data, bool reclaimed)
+{
+	struct vfio_pci_core_device_ser *ser;
+	struct vfio_pci_core_device *vdev;
+	struct vfio_device *device;
+	struct folio *folio;
+
+	if (reclaimed) {
+		folio = virt_to_folio(phys_to_virt(data));
+		goto out_folio_put;
+	} else {
+		folio = kho_restore_folio(data);
+	}
+
+	if (!folio)
+		return;
+
+	ser = folio_address(folio);
+
+	device = vfio_find_device_in_cdev_class(&ser->bdf, match_bdf);
+	if (!device)
+		goto out_folio_put;
+
+	vdev = container_of(device, struct vfio_pci_core_device, vdev);
+	pci_try_reset_function(vdev->pdev);
+	put_device(&device->device);
+
+out_folio_put:
+	folio_put(folio);
+}
+
 static int vfio_pci_liveupdate_retrieve(struct liveupdate_file_handler *handler,
 					u64 data, struct file **file)
 {
@@ -156,6 +188,7 @@ static bool vfio_pci_liveupdate_can_preserve(struct liveupdate_file_handler *han
 static const struct liveupdate_file_ops vfio_pci_luo_fops = {
 	.prepare = vfio_pci_liveupdate_prepare,
 	.cancel = vfio_pci_liveupdate_cancel,
+	.finish = vfio_pci_liveupdate_finish,
 	.retrieve = vfio_pci_liveupdate_retrieve,
 	.can_preserve = vfio_pci_liveupdate_can_preserve,
 	.owner = THIS_MODULE,
-- 
2.51.0.858.gf9c4a03a3a-goog


