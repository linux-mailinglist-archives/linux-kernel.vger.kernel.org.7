Return-Path: <linux-kernel+bounces-848180-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 003BABCCD2E
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 14:03:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 50CC24ED264
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 12:03:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B86F2288C25;
	Fri, 10 Oct 2025 12:03:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="FoDPBAnp";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="oNIdUWY2"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A1D0220698
	for <linux-kernel@vger.kernel.org>; Fri, 10 Oct 2025 12:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760097797; cv=none; b=iz7XKS/MB/SsvNGFf6sb5Bf674oMVNaTP8scYvBnFaNrzBvTNJ58Jv6TCk7kvW96sJYnS5sZNPcrZAMV2jlMxkSkWbcE5h019o3QHhq8nQ9spzozjEJyoraeBB354goOWm2+zV45eUUtsnWNhnYMY/YG/A3MOawHwetXRRS5+Mg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760097797; c=relaxed/simple;
	bh=OeLAYRoODw1GEaOFT/AQr2n8zpeVCbvh6hul0MaeIuI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dHSkOhFebzB63ADaizQ2g/2rnImd38N2+ztludkLG0oRzZxpcIDBmmhn1BaNlUcy2G1ojvkXFhfXuMLYii2VFfztzUBTP6XqyhS2VwlrWDrrzkhkMzyLiuSRtFt/b7+6M0jl9JFgAYKLrLsdURbFKZ6YS1uPH6ZXA9/BxDJZRio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=FoDPBAnp; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=oNIdUWY2; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1760097793;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=1WQ4/s0vJPykpnnYd7mdV+rKmdacgri2InTmJfigiAI=;
	b=FoDPBAnp+dQMTD4mcmpKFr4YwyeaJlOmD6ryPOjT5zu/nZtjOEA9iicgSemlVrbU2bsD7p
	2mWYm/84lLykVQCKHq4++S8uhykCfnpNzb7Owwwxu8X/le7Wk+HhKx6raMC2QqkQAP+U7X
	Q+5R3q/H42ncxgUD3J5NjRFvdoATd6yt9YjFzx8gZfgN6b88aA0sEtrpKW+MKajzemMurq
	iHD3v2vZyibnP0Q8xShkkj45keGAILnKy1Fh5XCVAqf4pETVDf7nAXSAnxZ8VQXlgy1S3p
	WC6SzEU4oSdc/e1KehZl6gF6+X2IZqTnInwZ4uAuRVepjbYb2/gKqDmihTHy0A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1760097793;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=1WQ4/s0vJPykpnnYd7mdV+rKmdacgri2InTmJfigiAI=;
	b=oNIdUWY2nXLLoRleentRIre5rOxeakSX2Rb//70QW0sJKIGAhz+anLVF7pSlBVsfYGQWzC
	j8CE2tzYaUFAgzDg==
To: Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Cc: Nam Cao <namcao@linutronix.de>,
	Venkat Rao Bagalkote <venkat88@linux.ibm.com>
Subject: [PATCH] powerpc/pseries/msi: Fix NULL pointer dereference at irq domain teardown
Date: Fri, 10 Oct 2025 12:03:07 +0000
Message-ID: <20251010120307.3281720-1-namcao@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

pseries_msi_ops_teardown() reads pci_dev* from msi_alloc_info_t. However,
pseries_msi_ops_prepare() does not populate this structure, thus it is all
zeros. Consequently, pseries_msi_ops_teardown() triggers a NULL pointer
dereference crash.

struct pci_dev is available in struct irq_domain. Read it there instead.

Reported-by: Venkat Rao Bagalkote <venkat88@linux.ibm.com>
Closes: https://lore.kernel.org/linuxppc-dev/878d7651-433a-46fe-a28b-1b7e89=
3fcbe0@linux.ibm.com/
Tested-by: Venkat Rao Bagalkote <venkat88@linux.ibm.com>
Signed-off-by: Nam Cao <namcao@linutronix.de>
---
 arch/powerpc/platforms/pseries/msi.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/msi.c b/arch/powerpc/platforms/=
pseries/msi.c
index 825f9432e03d..a82aaa786e9e 100644
--- a/arch/powerpc/platforms/pseries/msi.c
+++ b/arch/powerpc/platforms/pseries/msi.c
@@ -443,8 +443,7 @@ static int pseries_msi_ops_prepare(struct irq_domain *d=
omain, struct device *dev
  */
 static void pseries_msi_ops_teardown(struct irq_domain *domain, msi_alloc_=
info_t *arg)
 {
-	struct msi_desc *desc =3D arg->desc;
-	struct pci_dev *pdev =3D msi_desc_to_pci_dev(desc);
+	struct pci_dev *pdev =3D to_pci_dev(domain->dev);
=20
 	rtas_disable_msi(pdev);
 }
--=20
2.51.0


