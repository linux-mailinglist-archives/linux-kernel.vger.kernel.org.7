Return-Path: <linux-kernel+bounces-747307-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B458DB13244
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 00:38:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EBD0D1758CC
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Jul 2025 22:38:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70D302512D8;
	Sun, 27 Jul 2025 22:37:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Yhrmd8g9";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="lmRhPJRf"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6616524DD17
	for <linux-kernel@vger.kernel.org>; Sun, 27 Jul 2025 22:37:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753655878; cv=none; b=sJkR35mYK2JvQkf5YppxsaIVWP4bsCoqkn7w+D0HarL77oqSie9GtrkToB/0+j1xMXhn/b3f9FraMKgSi0G6UkWPLmLD+uTIqwZ5M2hnoDC3sJfk0QLVqlWfq0onnDoxuTolm/QWs5AmCafozTgiMiN32u6lRcB71pSQaFlqUIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753655878; c=relaxed/simple;
	bh=cT1W0l84jQPD27j+0q6xGdeFUT3uRxoVdqcyf0lrpaY=;
	h=From:To:Cc:Subject:References:Message-ID:Content-Type:
	 MIME-Version:Date; b=rrrJ0qG4Gjp27IVHqtvCULR2QB5dkEloaGl1p5Ls3RbYxw9mD7eARPNLuc2EO640r38NedM8CFvG13ZvPjRowNeXCKLWpVKc7FfAt55cjB6Chj3P8eNWYxz3y6uRu/hD/mimVfGIofgKGCWSbSj0hEsT/P2aySanMC/tSwI5KnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Yhrmd8g9; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=lmRhPJRf; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1753655875;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:  references:references;
	bh=spdz0KjplqtkV8ic03tZnjXComQOBCllYFaKjb+Y0nc=;
	b=Yhrmd8g9Ms6dcWjlcauh41iNev7cP3wKB6QWOgsYRJzlY5Pxyqr04VyONc3v7XR/fZdnyc
	9Chilvj1bbpdYgqBh7Il2IUH8QOhHxVvRkYPOYOuClNXnHUISiG21lj4Xwij+X0UV7qJsV
	9Kxa0sRFksPaCvyVOOOSXRnquSBhwFc4KLLGQrYpcS5ojhuoxVXEJSV9nentdCjhDx8BH+
	nJUHMdbOpX7eORU+bc8qhxH7o24xZzFJPclgPs/AsZwW7k3BgHOe2XZtD6EsBgiJqAG8hU
	dYjbbUjQqX0Iz+HbIcwZo/WhWYnI1uJt20NtzO89u2uh2wqbL0JbmQ8ZvM5+Xg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1753655875;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:  references:references;
	bh=spdz0KjplqtkV8ic03tZnjXComQOBCllYFaKjb+Y0nc=;
	b=lmRhPJRfNdPCu2eraSPxaJ9AHOEuaIAf+UxfqCAQjLz7ef2nK+LvViEEcBAR03dxMGwVTs
	wGhCiAM8UIIw+eDQ==
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org
Subject: [GIT pull] irq/msi for v6.17-rc1
References: <175365567943.581055.6806236199247802443.tglx@xen13>
Message-ID: <175365568292.581055.1455338411054266072.tglx@xen13>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 28 Jul 2025 00:37:54 +0200 (CEST)

Linus,

please pull the latest irq/msi branch from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git irq-msi-2025-07-=
27

up to:  4a089c0b3f55: PCI/MSI: Remove duplicated to_pci_dev() conversion

A trivial cleanup in the PCI/MSI code to remove a duplicated back and forth
conversion.

Thanks,

	tglx

------------------>
Chris Li (1):
      PCI/MSI: Remove duplicated to_pci_dev() conversion


 drivers/pci/msi/msi.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/msi/msi.c b/drivers/pci/msi/msi.c
index 6ede55a7c5e6..78bed2def9d8 100644
--- a/drivers/pci/msi/msi.c
+++ b/drivers/pci/msi/msi.c
@@ -113,7 +113,8 @@ static int pci_setup_msi_context(struct pci_dev *dev)
=20
 void pci_msi_update_mask(struct msi_desc *desc, u32 clear, u32 set)
 {
-	raw_spinlock_t *lock =3D &to_pci_dev(desc->dev)->msi_lock;
+	struct pci_dev *dev =3D msi_desc_to_pci_dev(desc);
+	raw_spinlock_t *lock =3D &dev->msi_lock;
 	unsigned long flags;
=20
 	if (!desc->pci.msi_attrib.can_mask)
@@ -122,8 +123,7 @@ void pci_msi_update_mask(struct msi_desc *desc, u32 clear=
, u32 set)
 	raw_spin_lock_irqsave(lock, flags);
 	desc->pci.msi_mask &=3D ~clear;
 	desc->pci.msi_mask |=3D set;
-	pci_write_config_dword(msi_desc_to_pci_dev(desc), desc->pci.mask_pos,
-			       desc->pci.msi_mask);
+	pci_write_config_dword(dev, desc->pci.mask_pos, desc->pci.msi_mask);
 	raw_spin_unlock_irqrestore(lock, flags);
 }
=20


