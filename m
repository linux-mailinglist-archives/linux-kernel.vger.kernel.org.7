Return-Path: <linux-kernel+bounces-818210-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 51C54B58E40
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 08:10:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AEE343BE039
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 06:10:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A254F28468E;
	Tue, 16 Sep 2025 06:10:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Mn1vmNJ2";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="W9BYIc0b"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61C3D2BAF9
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 06:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758003041; cv=none; b=rc3m+pSyATfiWqJ+mgJ+AyRICW4MTKRioZfBwJUOIyPDrvq9bO3W87zqCJycPSYD07VrRnSRbBL09qHNNlfEj4j7vaCs3HThbdxhfk0z/Ze6XzeSelkxqvH/E66hZfXS8YTUas8u5RtGbuyJT3yGHRCqAKxo9ko9ksvV1hmn4aQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758003041; c=relaxed/simple;
	bh=GItwQiY643xHT4/eirxI8WZx2rqzWpLNfGMISdMtfHA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=K9I6/BpMzcx3gUU8cuSTp5FjJwUxPW+0PLGlBT5ba/8o7q7wYdDWTHj36kG4fy9o1WmwgosnwkMgrFHAPHkl6uoicDmZrm5hOQu66kabnNA5TZjSV7Yon9tv4+Mh5rmzp0uLvzPE11EzFaEyF7ebEiccVEnx/HdU3tyaN69JW9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Mn1vmNJ2; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=W9BYIc0b; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1758003038;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=gaWb8FaXTaOm9pYwQoptQTg8O5QNaVOVs+VrR+4evqs=;
	b=Mn1vmNJ29B3nn2f7ZDKYq6uh1x3lGn1KS1bymhPbhHUHYIXuwLU21nc9AVlkaXmEcyDruW
	m0x0ZHulo1bYfC0f0XqkJTk97e/cIHdH8jqCrXwJuHTtr1wHrCVhWAjMeUHYv6n/a/W6nl
	3eBw8r+z2oOataqwL5WfhRY6iSjdumIiPFv0Rm99jLQQTz/rif7/XGh7lwwlbg1nIdpb/o
	Vq5/Ub3PVL5Sm5tp9xYCKFwb7obq6afxX3jzvyUOdGYAd0a02gt5hl7vC8ENqUPGgDwjkI
	o9+OMgt4ISJlB5nNrMdIvstdVhBRGH/PXKFwrkSKExsa5yroBAKW9JWhCvd9hg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1758003038;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=gaWb8FaXTaOm9pYwQoptQTg8O5QNaVOVs+VrR+4evqs=;
	b=W9BYIc0bgetn+IO7V5IHipUl1Twp9sGJ6AA5upoFAXbKJILDMsiGARygGt0Egev4YNZGcZ
	Phd9o9TLtDhiMICA==
To: Thomas Gleixner <tglx@linutronix.de>,
	Marc Zyngier <maz@kernel.org>,
	linux-kernel@vger.kernel.org,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	linuxppc-dev@lists.ozlabs.org
Cc: Nam Cao <namcao@linutronix.de>
Subject: [PATCH] genirq/msi: Remove msi_post_free()
Date: Tue, 16 Sep 2025 08:10:07 +0200
Message-Id: <20250916061007.964005-1-namcao@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The only user of msi_post_free() - powerpc/pseries - has been changed to
use msi_teardown().

Remove this unused callback.

Signed-off-by: Nam Cao <namcao@linutronix.de>
---
This patch depends on the powerpc/series conversion patch, which is
currently in powerpc tree:
https://lore.kernel.org/lkml/c7a6d8f27fd217021dea4daad777e81a525ae460.17549=
03590.git.namcao@linutronix.de/

I think it is most convenient to apply this patch to powerpc tree, if
everyone is okay with that?
---
 include/linux/msi.h | 4 ----
 kernel/irq/msi.c    | 3 ---
 2 files changed, 7 deletions(-)

diff --git a/include/linux/msi.h b/include/linux/msi.h
index e5e86a8529fb..faac634ac230 100644
--- a/include/linux/msi.h
+++ b/include/linux/msi.h
@@ -431,8 +431,6 @@ struct msi_domain_info;
  *			function.
  * @domain_free_irqs:	Optional function to override the default free
  *			function.
- * @msi_post_free:	Optional function which is invoked after freeing
- *			all interrupts.
  * @msi_translate:	Optional translate callback to support the odd wire to
  *			MSI bridges, e.g. MBIGEN
  *
@@ -473,8 +471,6 @@ struct msi_domain_ops {
 					     struct device *dev, int nvec);
 	void		(*domain_free_irqs)(struct irq_domain *domain,
 					    struct device *dev);
-	void		(*msi_post_free)(struct irq_domain *domain,
-					 struct device *dev);
 	int		(*msi_translate)(struct irq_domain *domain, struct irq_fwspec *fwspe=
c,
 					 irq_hw_number_t *hwirq, unsigned int *type);
 };
diff --git a/kernel/irq/msi.c b/kernel/irq/msi.c
index 9b09ad3f9914..e7ad99254841 100644
--- a/kernel/irq/msi.c
+++ b/kernel/irq/msi.c
@@ -1644,9 +1644,6 @@ static void msi_domain_free_locked(struct device *dev=
, struct msi_ctrl *ctrl)
 	else
 		__msi_domain_free_irqs(dev, domain, ctrl);
=20
-	if (ops->msi_post_free)
-		ops->msi_post_free(domain, dev);
-
 	if (info->flags & MSI_FLAG_FREE_MSI_DESCS)
 		msi_domain_free_descs(dev, ctrl);
 }
--=20
2.39.5


