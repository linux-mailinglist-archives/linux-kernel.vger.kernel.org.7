Return-Path: <linux-kernel+bounces-858881-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E216BEC1D8
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Oct 2025 02:10:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 536941AE172F
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Oct 2025 00:10:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 189C2218845;
	Sat, 18 Oct 2025 00:07:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rjYNxdbg"
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2E411F94A
	for <linux-kernel@vger.kernel.org>; Sat, 18 Oct 2025 00:07:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760746065; cv=none; b=ATIWirsJcGbqDHs8NrPUdvT6LaeNFvRUSODqAfQAugfpimQz1+id+CZTBT8EMonkOJ5TonRGFunUEF5NZ1L/mCoxGvMF7Flpcf1hMn94SdMuXGolnWHQV+fIhwpuu5Vuh9QYRxBCo4+Fam86eM7eorfXU/UJfoZWEyv880Idtss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760746065; c=relaxed/simple;
	bh=Zxz213bnVu4PytMrWtldNoB5RbSMv3rpGoHLoxMbz8o=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=K/O5XVV3STqXqRvS/A4qv+U/t4pdLzK/wreC1vX0hk8zeSiqvqZWGxoagkKx9Jm+8/Ixt+nUXXtfRu0o1NmcNJaOwgVk5rAoHyC/UgErENsDU0SkgeaPQsdXRPfe/xSRZ7wjhRgdIrxrGuZQgEI/jnuBYzaJ5S0qjvMmS/iXMdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--vipinsh.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rjYNxdbg; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vipinsh.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-33bb3b235ebso4160443a91.1
        for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 17:07:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760746062; x=1761350862; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=xxD/Cw9jyxG7ivQQV697wV0O8b/3dIW50+ry6yUBLsE=;
        b=rjYNxdbgkeA9Ic725M8o7FLT88khjBrEUJuwj09S5ZV7oDtUnH5X8zg/oJ42cSULtA
         3C8rp0yyxLUem98Qm2I5yQG5wArE2cx5xiA/RkvsyMERttwiBQGynOgeuYihuomORrl9
         sw9AYXrFIg9nFpJvKkFjQhU64sfYSGPvwLBBng8HPEVUUFcSXolYOJPpyDd9lt20lr1v
         iSkpnVjWWcW1FUJ4TVXjN74wkNLW9s2RXegGjc9rxlr/jgRNfxLd/KR10W+reMqSqQUf
         oYJxPobaEglhhJ3ev6zkd293Ifb2tF6+MW8XFPHTEcc7LjYOxkkR1ocS6578YtsTUx9y
         Qhpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760746062; x=1761350862;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xxD/Cw9jyxG7ivQQV697wV0O8b/3dIW50+ry6yUBLsE=;
        b=cuyTq5wTZ+WfYyNoX5Txd9USbavPiYxhdyHkbHEHYRyzTu3Aw/1NCtJC2QEgykgbd5
         3JIJwX4KfLbx3rmWxOq1aYX6uttR6SOlq4DX2vyOijlOCRkD3gUwoyw1Z+O8tSZn46JS
         8RQBCGT63k8piiAns9+KeC3gYZVkNsEweDBC4X+puiX9TEeEtaFixIa8w7SmPu8ZaZG/
         ZQVeghedFWcwnpSzwxVXrCPfCU73Zv1L6VLQSqsH+Q7syLQpY8piuTz321nK9FnJcN4Z
         oBBP875R1sSpPMkjWH4unLbj5mey7jMpy4VwAXQCc3/iu1Y5YUF/xAN3a2X2igBoQUyW
         VXrg==
X-Forwarded-Encrypted: i=1; AJvYcCVxvCLEzoeY7jDKfM65lILo/x6wi64YF/q0DMng1dggnYDKUiQAh6jZnCVeFPgsaAGjlwz9+ozO7fSxpCg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzGsm71QObSMRhMTxfrcJ6kAFxskZnNahbA29FZ/Yw9Wuy3787y
	U98qnsNYKoFC63Vs1Pm04pqqECZu3VGW0D7f6e/5waX7Y9Lzc3tuOuBsxfYOM6oZ6jvRVjMIobO
	wCcb96D4B1g==
X-Google-Smtp-Source: AGHT+IGvT4gSxZumpaRuwK33oT1VTteqUw6nohwluWluZWlr9C8TOLWOTIAP6j/iKx3fcI6xg3+HQZq1UcLw
X-Received: from pjre17.prod.google.com ([2002:a17:90a:b391:b0:33b:51fe:1a89])
 (user=vipinsh job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:180e:b0:32e:73fd:81a3
 with SMTP id 98e67ed59e1d1-33bcf93dfbdmr7878362a91.33.1760746062232; Fri, 17
 Oct 2025 17:07:42 -0700 (PDT)
Date: Fri, 17 Oct 2025 17:07:03 -0700
In-Reply-To: <20251018000713.677779-1-vipinsh@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251018000713.677779-1-vipinsh@google.com>
X-Mailer: git-send-email 2.51.0.858.gf9c4a03a3a-goog
Message-ID: <20251018000713.677779-12-vipinsh@google.com>
Subject: [RFC PATCH 11/21] vfio/pci: Skip clearing bus master on live update
 device during kexec
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

Set skip_kexec_clear_master on live update prepare() so that the device
participating in live update can continue to perform DMA during kexec
phase.

Signed-off-by: Vipin Sharma <vipinsh@google.com>
---
 drivers/vfio/pci/vfio_pci_liveupdate.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/vfio/pci/vfio_pci_liveupdate.c b/drivers/vfio/pci/vfio_pci_liveupdate.c
index 8e0ee01127b3..789b52665e35 100644
--- a/drivers/vfio/pci/vfio_pci_liveupdate.c
+++ b/drivers/vfio/pci/vfio_pci_liveupdate.c
@@ -54,6 +54,7 @@ static int vfio_pci_liveupdate_prepare(struct liveupdate_file_handler *handler,
 		goto err_free_folio;
 
 	*data = virt_to_phys(ser);
+	vdev->pdev->skip_kexec_clear_master = true;
 
 	return 0;
 
@@ -67,7 +68,12 @@ static void vfio_pci_liveupdate_cancel(struct liveupdate_file_handler *handler,
 {
 	struct vfio_pci_core_device_ser *ser = phys_to_virt(data);
 	struct folio *folio = virt_to_folio(ser);
+	struct vfio_pci_core_device *vdev;
+	struct vfio_device *device;
 
+	device = vfio_device_from_file(file);
+	vdev = container_of(device, struct vfio_pci_core_device, vdev);
+	vdev->pdev->skip_kexec_clear_master = false;
 	WARN_ON_ONCE(kho_unpreserve_folio(folio));
 	folio_put(folio);
 }
-- 
2.51.0.858.gf9c4a03a3a-goog


