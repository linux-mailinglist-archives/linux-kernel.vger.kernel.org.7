Return-Path: <linux-kernel+bounces-859574-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 17A25BEDFDF
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Oct 2025 09:55:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 986293AE54B
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Oct 2025 07:55:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DCA322A7E0;
	Sun, 19 Oct 2025 07:55:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MFWD2+/P"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2531A22128B
	for <linux-kernel@vger.kernel.org>; Sun, 19 Oct 2025 07:55:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760860546; cv=none; b=JQ8Rcgdh2RL1x/ElXUtJdqfsyhquhd+LOFS5OJhGHZgkvcqVSeOUNbjbr2zm6NPEHMhaN95YmkgzAnTNFIdJBPgptr9d0VDDjYNpiJI7zm1udKzrYTehS66CNKXKpLG53/34b89reOjGElye3O3ReYmpNQtpMZ6y5zafudnkOgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760860546; c=relaxed/simple;
	bh=GZ8HyRlR9zTf/bfRs5/LkOfkUPaPv/tTrbDB099Lg2w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lu6ET8ktQacDvA+7kZuMiQDfgTcPxuvnw9CztPGkdK/Vv7GgZMQuoOVGUXgqaZOlZO1SzlPCqZCUrBPzCnrBkVCgn5Cm7n3vYlJYNrvNbvY242p1ch8QAhOb405CJDv3jXPR3EI+6VMo+5cI3dLEdghxsQJhVjUME6im2ePSElg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MFWD2+/P; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760860545; x=1792396545;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=GZ8HyRlR9zTf/bfRs5/LkOfkUPaPv/tTrbDB099Lg2w=;
  b=MFWD2+/PtMQIqqhtjjJ7h0UH4vBvIiKmkCPBEQQn2N264fMibk1i4ccz
   zU2F9kyJcuVGzLbZUSmBaGzFTO0evE4YOuL3Ctk481rI+fZiR/SqZWOBf
   gJY5Gr2DmAiSzVA3Hd/G+FWudC+yNb/KysF44nW/sVnNaQoENIcjOnTRS
   FVTQYI7PhMG3HZieOLAJFT612xbllP1QopBlei5k+TPluxU1aAza+i0rD
   F11I0XbPWXq9gB0iwrfKPgEGASNzq5E1iHjboH0OLf/Wr0ZgdecodW00c
   Wp5HsgviGKjnzd8b2t8Xkf3QyJms7N6Bt8AyKglLiQe728co1AIsv24se
   Q==;
X-CSE-ConnectionGUID: NZHgDfpRSMSBUa5ohl67MQ==
X-CSE-MsgGUID: vq3TLArnT8a0OtYiHB0y7g==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="88484496"
X-IronPort-AV: E=Sophos;i="6.19,240,1754982000"; 
   d="scan'208";a="88484496"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2025 00:55:44 -0700
X-CSE-ConnectionGUID: 9uUyh6S0T02mVAPXRXWRmg==
X-CSE-MsgGUID: UOMLILG8SiyTQElDUz43Zw==
X-ExtLoop1: 1
Received: from sannilnx-dsk.jer.intel.com ([10.12.231.107])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2025 00:55:43 -0700
From: Alexander Usyskin <alexander.usyskin@intel.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Reuven Abliyev <reuven.abliyev@intel.com>,
	Alexander Usyskin <alexander.usyskin@intel.com>,
	linux-kernel@vger.kernel.org
Subject: [char-misc] mei: txe: fix initialization order
Date: Sun, 19 Oct 2025 10:36:59 +0300
Message-ID: <20251019073659.2646791-1-alexander.usyskin@intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The mei_register() should move before the mei_start() for hook
on class device to work.
Same change was implemented in mei-me, missed from mei-txe.

Fixes: 7704e6be4ed2 ("mei: hook mei_device on class device")
Signed-off-by: Alexander Usyskin <alexander.usyskin@intel.com>
---
 drivers/misc/mei/pci-txe.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/misc/mei/pci-txe.c b/drivers/misc/mei/pci-txe.c
index c9eb5c5393e4..06b55a891c6b 100644
--- a/drivers/misc/mei/pci-txe.c
+++ b/drivers/misc/mei/pci-txe.c
@@ -109,19 +109,19 @@ static int mei_txe_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 		goto end;
 	}
 
+	err = mei_register(dev, &pdev->dev);
+	if (err)
+		goto release_irq;
+
 	if (mei_start(dev)) {
 		dev_err(&pdev->dev, "init hw failure.\n");
 		err = -ENODEV;
-		goto release_irq;
+		goto deregister;
 	}
 
 	pm_runtime_set_autosuspend_delay(&pdev->dev, MEI_TXI_RPM_TIMEOUT);
 	pm_runtime_use_autosuspend(&pdev->dev);
 
-	err = mei_register(dev, &pdev->dev);
-	if (err)
-		goto stop;
-
 	pci_set_drvdata(pdev, dev);
 
 	/*
@@ -144,8 +144,8 @@ static int mei_txe_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 
 	return 0;
 
-stop:
-	mei_stop(dev);
+deregister:
+	mei_deregister(dev);
 release_irq:
 	mei_cancel_work(dev);
 	mei_disable_interrupts(dev);
-- 
2.43.0


