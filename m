Return-Path: <linux-kernel+bounces-858877-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E547DBEC1AB
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Oct 2025 02:09:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 466881AA8357
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Oct 2025 00:09:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B59C31CAA7D;
	Sat, 18 Oct 2025 00:07:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="4hHZszIy"
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D924319C566
	for <linux-kernel@vger.kernel.org>; Sat, 18 Oct 2025 00:07:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760746057; cv=none; b=JUuVbd+r6Cd+6HFWEDfDPcfzALMv7JFhEhUT6aAcuJPhKIYylWNuznYwot558fp9+x6rTz2hKZoZNn5uaXsjx4kfNn940A5W2PSLLMcRekJryy7OHFl1MyLFlappnTOP/WYWihYCF7gCvOjN46AJ3e7M2uJC95oT9KaqwLK/opI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760746057; c=relaxed/simple;
	bh=9kz7IeKfS4YgzfgKMPszd7/uCUEYDB0UKs2xeqOId+E=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ezlXHwalf+Mrck+Ja35TxScZOUMnZYuvP31HPvKtsd5+MpkFyWVOCTnG+EDkwge+b2u7yEdU17AvbAw4fjCnEgj14dsg1RlwezzKodM91yPdvF2eeUy3+VH8jHkDpm5M6vPtiDus8Td/3lGUoJmQhDiHdRVwpm7xNmQtHR/GVt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--vipinsh.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=4hHZszIy; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vipinsh.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-33428befc49so3923140a91.0
        for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 17:07:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760746055; x=1761350855; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=FsS9kFTR9UD975XBprEHxRtCq2p91h3XBSwxLrbiSS8=;
        b=4hHZszIyICDX684inLL4qqhvefcGlVk81E1+bYgkII9xXJlx6fhPBFAoLa6RUzSi7c
         Ab0GOmYq84zm/RF74ssl/qJDKT8khHszASsgn964lqaFdlvy3gMv3Gi6CsTQGbEOHW3O
         IT1AbJ5bq5yyZTOK+1fkGbo5OVHqnKMFhLsHtsmBebIt++z6l+b0QwZPLl/8zWj88LP3
         EIAfqoLHzv5GXxSnyxkYQXJ6olw2VmeU4oK34kuzHwY4IStATJThFlbxo98wMiudSJGG
         FupCI+JjwG7kghVmKWndEn2lbGaEFhyeMOwo10Rh4k+pVuhU5afh0M6oyQgzy2IHvzSi
         0hrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760746055; x=1761350855;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FsS9kFTR9UD975XBprEHxRtCq2p91h3XBSwxLrbiSS8=;
        b=BLC5B3Gh012UTu3+L4jKBLus9VAA4owaw2TvXCh3zFJDaIHkkT0bsIm7qckwo4ar/0
         n6VenCWjtZYUuHK3hFY182mURJbLuUqsknbrx4edQZRDrNm0WhjS9LWJIDpJQ0XDUAm4
         kMxp2hIdbrOgD6sE/5D2dk5poLp3GsjBcAu38zTywHS2qc+vkCG9/OUa3aWrw4fhA0jk
         iCsIp5j+uMwIybCfdaR6ONBZHsK5+IVWZqS+yA6vmioTfOpIf+BydthXYR5iYK8xAsld
         l0FWtHfuXBtxvdBBi4jD7YfYnpq5AvWdk2KkTgwkDV1rkWwI/eZCSKOvd7GalGWEO8C1
         t/6A==
X-Forwarded-Encrypted: i=1; AJvYcCXYnjN3YDFbdX7SOEtzJtq834LmbuFlT04DtOp69U0vglm3uxJTCOr4M5EB2dMoKCJX4drtuvuYw43g15E=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1K27yRRfo75dQNfQK2HuG8YdoG4rYJVrN56Epp0Sqik0ZFhqO
	JPjRkRi4pDdMco7ZECNFbEGqjURBlujPaZfZxMB+6OqTKEfI+eODArc5XLQIELO/oTWlRQMc3Iw
	O6MZSu00AQw==
X-Google-Smtp-Source: AGHT+IGRIAXsRYc0Ud2iJi9huekvodTNwMahs7Yf+RSITKDZqjl7U0MJ3wXRjz337obRdzxOo9SfX8Vmvxkg
X-Received: from pjbml19.prod.google.com ([2002:a17:90b:3613:b0:33b:ba58:40a6])
 (user=vipinsh job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90a:d406:b0:32d:e027:9b26
 with SMTP id 98e67ed59e1d1-33bc9d1a8e6mr7604436a91.13.1760746055286; Fri, 17
 Oct 2025 17:07:35 -0700 (PDT)
Date: Fri, 17 Oct 2025 17:06:59 -0700
In-Reply-To: <20251018000713.677779-1-vipinsh@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251018000713.677779-1-vipinsh@google.com>
X-Mailer: git-send-email 2.51.0.858.gf9c4a03a3a-goog
Message-ID: <20251018000713.677779-8-vipinsh@google.com>
Subject: [RFC PATCH 07/21] vfio/pci: Store VFIO PCI device preservation data
 in KHO for live update
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

Create a struct to serialize VFIO PCI data and preserve it using KHO.
Provide physical address of the folio to Live Update Orchestrator (LUO)
in prepare() callback so that LUO can give it back after kexec.
Unpreserve and free the folio in cancel() callback.

Store PCI BDF value in the serialized data. BDF value is unique for each
device on a host and remains same unless hardware or firmware is
changed.

Preserving BDF value allows VFIO to find the PCI device which LUO wants
to restore in retrieve() callback after kexec. In future patches, more
meaningful data will be serialized to actually preserve working of the
device.

Signed-off-by: Vipin Sharma <vipinsh@google.com>
---
 drivers/vfio/pci/vfio_pci_liveupdate.c | 54 +++++++++++++++++++++++++-
 1 file changed, 53 insertions(+), 1 deletion(-)

diff --git a/drivers/vfio/pci/vfio_pci_liveupdate.c b/drivers/vfio/pci/vfio_pci_liveupdate.c
index 2ce2c11cb51c..3eb4895ce475 100644
--- a/drivers/vfio/pci/vfio_pci_liveupdate.c
+++ b/drivers/vfio/pci/vfio_pci_liveupdate.c
@@ -10,13 +10,64 @@
 #include <linux/liveupdate.h>
 #include <linux/vfio.h>
 #include <linux/errno.h>
+#include <linux/kexec_handover.h>
 
 #include "vfio_pci_priv.h"
 
+struct vfio_pci_core_device_ser {
+	u16 bdf;
+} __packed;
+
+static int vfio_pci_lu_serialize(struct vfio_pci_core_device *vdev,
+				 struct vfio_pci_core_device_ser *ser)
+{
+	ser->bdf = pci_dev_id(vdev->pdev);
+	return 0;
+}
+
 static int vfio_pci_liveupdate_prepare(struct liveupdate_file_handler *handler,
 				       struct file *file, u64 *data)
 {
-	return -EOPNOTSUPP;
+	struct vfio_pci_core_device_ser *ser;
+	struct vfio_pci_core_device *vdev;
+	struct vfio_device *device;
+	struct folio *folio;
+	int err;
+
+	device = vfio_device_from_file(file);
+	vdev = container_of(device, struct vfio_pci_core_device, vdev);
+
+	folio = folio_alloc(GFP_KERNEL | __GFP_ZERO, get_order(sizeof(*ser)));
+	if (!folio)
+		return -ENOMEM;
+
+	ser = folio_address(folio);
+
+	err = vfio_pci_lu_serialize(vdev, ser);
+	if (err)
+		goto err_free_folio;
+
+	err = kho_preserve_folio(folio);
+	if (err)
+		goto err_free_folio;
+
+	*data = virt_to_phys(ser);
+
+	return 0;
+
+err_free_folio:
+	folio_put(folio);
+	return err;
+}
+
+static void vfio_pci_liveupdate_cancel(struct liveupdate_file_handler *handler,
+				       struct file *file, u64 data)
+{
+	struct vfio_pci_core_device_ser *ser = phys_to_virt(data);
+	struct folio *folio = virt_to_folio(ser);
+
+	WARN_ON_ONCE(kho_unpreserve_folio(folio));
+	folio_put(folio);
 }
 
 static int vfio_pci_liveupdate_retrieve(struct liveupdate_file_handler *handler,
@@ -39,6 +90,7 @@ static bool vfio_pci_liveupdate_can_preserve(struct liveupdate_file_handler *han
 
 static const struct liveupdate_file_ops vfio_pci_luo_fops = {
 	.prepare = vfio_pci_liveupdate_prepare,
+	.cancel = vfio_pci_liveupdate_cancel,
 	.retrieve = vfio_pci_liveupdate_retrieve,
 	.can_preserve = vfio_pci_liveupdate_can_preserve,
 	.owner = THIS_MODULE,
-- 
2.51.0.858.gf9c4a03a3a-goog


