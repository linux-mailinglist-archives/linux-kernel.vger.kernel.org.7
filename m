Return-Path: <linux-kernel+bounces-836682-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 54A78BAA4B6
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 20:30:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 514983A3550
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 18:30:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D843223C4ED;
	Mon, 29 Sep 2025 18:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="Szw6tfwC"
Received: from smtp.smtpout.orange.fr (smtp-69.smtpout.orange.fr [80.12.242.69])
	(using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1B0C146A66;
	Mon, 29 Sep 2025 18:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759170610; cv=none; b=c77chT5HyHjOFqQZpmQPHK7L0EKCPr46tC4FjXfj3kOlXSJmcHx1dnnCBVTdWEWDsGSt8K/9Qvwg5Rg45PrAHboYoTFC7yamZw+OvpGc1uiU/uUCtHNruNGB9DuZjOpt/o+ciUPaiFfHHYnfNClZsga03d4dOkr7+39xXDpL8w0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759170610; c=relaxed/simple;
	bh=kM5RjQnF0yMkdlchTapqnhShU6eRYNtHofiGbN3Dl9o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=e3lAAn5O8OA/EhVLA2ijb7Vpj9V7hV4Q8TXOFwNl48JWFDIK0pPVvaaHy1YVPTbYqbw4bsnUpMgLbuuxif3UY7eqcknvax9U3R4YDWezdMw9z8XrJ9oZRZ1sQDevHjG+gtQF8vjj4l9OyrU2Eei7T/doDqzcr6nwGFxCuerRwUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=Szw6tfwC; arc=none smtp.client-ip=80.12.242.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from fedora ([IPv6:2a01:cb10:785:b00:8347:f260:7456:7662])
	by smtp.orange.fr with ESMTPA
	id 3IcIveJbg57iH3IcIvCDtz; Mon, 29 Sep 2025 20:28:55 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1759170535;
	bh=cb2mBdVPaJ9JhXZz0HUS5QIadLlHUVA4Z4MuMhzZfaE=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=Szw6tfwCSLfEnASyenGdiA/HvyMI01WGDzc7cXmjWNc3pIDCiQIfZ2cWD814T6hpK
	 DQQCnCHIBZasYvo+MmWLKmvxam6OQw/sqmui3Tc//F0wfUyXm3bYxZEcUpM/Yo+a+4
	 IeLKHBImBxrubsxBPHcYcPJrDqHEf020uclYjXdBd6PqmRQMEytOq/+/eMheGz+RBw
	 E/7ocmKYuXdRnynTyWH8WkcJ5pvuDd58wHNzUFmGtCJd8kNbvSUJeGVR0m6se7TYDx
	 SoTusgo69yeoSHL+WBdw/tjZe0nMmOAyRA4dJy+qhFDTDuBOSNgMMnlKIxUJeRVs71
	 x1u4akdeBZiRg==
X-ME-Helo: fedora
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Mon, 29 Sep 2025 20:28:55 +0200
X-ME-IP: 2a01:cb10:785:b00:8347:f260:7456:7662
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To: Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Ze Huang <huang.ze@linux.dev>
Cc: linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	linux-usb@vger.kernel.org
Subject: [PATCH] usb: dwc3: Don't call clk_bulk_disable_unprepare() twice
Date: Mon, 29 Sep 2025 20:28:50 +0200
Message-ID: <371860315a5c1ef6e800fa825e4c23ce335a55e2.1759170517.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

devm_clk_bulk_get_all_enabled() is used in the probe, so
clk_bulk_disable_unprepare() should not be called explicitly in the remove
function.

Fixes: e0b6dc00c701 ("usb: dwc3: add generic driver to support flattened")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/usb/dwc3/dwc3-generic-plat.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/usb/dwc3/dwc3-generic-plat.c b/drivers/usb/dwc3/dwc3-generic-plat.c
index d96b20570002..f8ad79c08c4e 100644
--- a/drivers/usb/dwc3/dwc3-generic-plat.c
+++ b/drivers/usb/dwc3/dwc3-generic-plat.c
@@ -85,11 +85,8 @@ static int dwc3_generic_probe(struct platform_device *pdev)
 static void dwc3_generic_remove(struct platform_device *pdev)
 {
 	struct dwc3 *dwc = platform_get_drvdata(pdev);
-	struct dwc3_generic *dwc3g = to_dwc3_generic(dwc);
 
 	dwc3_core_remove(dwc);
-
-	clk_bulk_disable_unprepare(dwc3g->num_clocks, dwc3g->clks);
 }
 
 static int dwc3_generic_suspend(struct device *dev)
-- 
2.51.0


