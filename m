Return-Path: <linux-kernel+bounces-864353-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A3961BFA99C
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 09:36:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 90DCA4FFF5E
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 07:36:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05CEE2FB09E;
	Wed, 22 Oct 2025 07:36:36 +0000 (UTC)
Received: from relmlie5.idc.renesas.com (relmlor1.renesas.com [210.160.252.171])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 081D72F99A8
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 07:36:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.160.252.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761118595; cv=none; b=SZh32oAxdAGLH8ymSs9EKMKaIpi3HxhpBVKl7jaLMVpPibLVfL2kQrrmPCTuFOle1pU97iwkkCFu3OIz56R08MCDY9eixvpPtY496v1i3h2ktThcFgKzvJHriM1kEKlPhr0g8wolk/47h2/KwuXL5ErhbvPH5zM9CSJoDj+5fs4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761118595; c=relaxed/simple;
	bh=913M1ncD54sEXqwTfbFPqZShHN5/wvM2dF1qjrakCu4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PFFOC3cC6NVTlRkHNHUMbsUfYCA1vnD15noxmom62wWREO+kalfDYYFkttpDlNPGfzpOZB13bIIlNk8Tw83106Clh1XurCWy+6IcQvy0aIZILDrI9T5tLTRGRgcxr5E5NbmChmVfdF/PddN+inDtkGwMFI/xZspk8H4h5Fn5Ab4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; arc=none smtp.client-ip=210.160.252.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
X-CSE-ConnectionGUID: 0dbJzd9TQZqzcAWtfYWUCA==
X-CSE-MsgGUID: kLELqGYCTYe8IV3wXScWMQ==
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 22 Oct 2025 16:36:31 +0900
Received: from demon-pc.localdomain (unknown [10.226.93.88])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 809F241562AB;
	Wed, 22 Oct 2025 16:36:29 +0900 (JST)
From: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
To: 
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	linux-kernel@vger.kernel.org,
	Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
Subject: [PATCH] irqchip/renesas-rzg2l: remove braces around single statement if block
Date: Wed, 22 Oct 2025 10:35:57 +0300
Message-ID: <20251022073558.1992384-1-cosmin-gabriel.tanislav.xa@renesas.com>
X-Mailer: git-send-email 2.51.1.dirty
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Braces around single statement if blocks are unnecessary, remove them.

Signed-off-by: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
---
 drivers/irqchip/irq-renesas-rzg2l.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/irqchip/irq-renesas-rzg2l.c b/drivers/irqchip/irq-renesas-rzg2l.c
index 1bf19deb02c4..6e215649bf29 100644
--- a/drivers/irqchip/irq-renesas-rzg2l.c
+++ b/drivers/irqchip/irq-renesas-rzg2l.c
@@ -555,10 +555,9 @@ static int rzg2l_irqc_common_probe(struct platform_device *pdev, struct device_n
 		return dev_err_probe(dev, ret, "cannot parse interrupts: %d\n", ret);
 
 	resetn = devm_reset_control_get_exclusive_deasserted(dev, NULL);
-	if (IS_ERR(resetn)) {
+	if (IS_ERR(resetn))
 		return dev_err_probe(dev, PTR_ERR(resetn),
 				     "failed to acquire deasserted reset: %d\n", ret);
-	}
 
 	ret = devm_pm_runtime_enable(dev);
 	if (ret)
-- 
2.51.1.dirty


