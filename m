Return-Path: <linux-kernel+bounces-895732-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id BE647C4ECA6
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 16:33:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 56B1C4ED278
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 15:29:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 391E4364EB9;
	Tue, 11 Nov 2025 15:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bYAD6/Ee"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7536D344024
	for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 15:29:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762874949; cv=none; b=mfp6GOYp55/9tvBz8ZF6QE49agfMY8AOyBIrMIOP7stF7UkbpzeTsDsNP+IkpVwdFtzDB/4+wjw3xlaSB0H/Z0BZKewmWYroa6a/c22fMPVtaAZUigKuswmG5T4XoGGblWeqktq27poHWV478oLuFOOYrLOyCd4a1c1LOYarulo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762874949; c=relaxed/simple;
	bh=sHV4YCriJE6MHGsGQWPgrOX/gNbP+xPxtR6RU0E9fDY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=usLL2hzB/vcSwgHLG0n5l56syK/Fc6uKSU1v2ANFFpQkMGitkjfyQvKfr4DWMdK2YQA1zhbCULAYu15vC1laQD0FxqR9UiYwqYmO+of6zAyyMIsPY65KOHWitAAhjqaJzsubyLqgYwvU4lKV648v7p+UIDTl94XuTY2c3itxuyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bYAD6/Ee; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762874948; x=1794410948;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=sHV4YCriJE6MHGsGQWPgrOX/gNbP+xPxtR6RU0E9fDY=;
  b=bYAD6/EeX0xb1TQJjUoPgN0GTKDjEUin9fBfgFK2MREjybaMaAsMv3+J
   Quhs4W73bN20C2MoVwwv2TqlvRUFoWsB4IBiddYndFwoWjkR0Pt7X46gd
   Vd6fTdERyGF3gMqhCnULYjmmlMSG9BToYswGI4bF5J3W1KtN63LrTERvv
   ywwdCmO67iDir+uwrYlc+xSUV1xLGIBh6R6MLL/XNkhdwCwNbhPXM/7Qi
   YlMPeYGxNvhD0Y5/D1i2hbCGD/1CBudP16KV9PDM6dIazbg3MV1AayNIN
   RgCan6hBmxq7IU4NSY9+kIvAMlIT092FJXvc2QMZwaWn2e4Vmtj1XTE6K
   A==;
X-CSE-ConnectionGUID: Nhc1reT5TxWze0tMZkK8mw==
X-CSE-MsgGUID: r7G727cOTc22+F4V5f+Ntw==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="64854870"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="64854870"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2025 07:29:07 -0800
X-CSE-ConnectionGUID: f7ybnT3wTeaeyy5BxAvp3A==
X-CSE-MsgGUID: tQ2osJ4ERGCYOccNK9PqSQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,296,1754982000"; 
   d="scan'208";a="212383820"
Received: from lucas-s2600cw.jf.intel.com ([10.54.55.69])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2025 07:29:07 -0800
From: Lucas De Marchi <lucas.demarchi@intel.com>
To: intel-xe@lists.freedesktop.org,
	linux-mtd@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: Lucas De Marchi <lucas.demarchi@intel.com>,
	Alexander Usyskin <alexander.usyskin@intel.com>,
	Jani Partanen <jiipee@sotapeli.fi>
Subject: [PATCH] mtd: intel-dg: Fix accessing regions before setting nregions
Date: Tue, 11 Nov 2025 07:28:25 -0800
Message-ID: <20251111-mtd-nregions-v1-1-61db61e78c63@intel.com>
X-Mailer: git-send-email 2.51.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Change-ID: 20251110-mtd-nregions-e9c66d5fcfae
X-Mailer: b4 0.15-dev-50d74
Content-Transfer-Encoding: 8bit

The regions array is counted by nregions, but it's set only after
accessing it:

	[] UBSAN: array-index-out-of-bounds in drivers/mtd/devices/mtd_intel_dg.c:750:15
	[] index 0 is out of range for type '<unknown> [*]'

Fix it by also fixing an undesired behavior: the loop silently ignores
ENOMEM and continues setting the other entries.

Cc: Alexander Usyskin <alexander.usyskin@intel.com>
Reported-by: Jani Partanen <jiipee@sotapeli.fi>
Closes: https://lore.kernel.org/all/caca6c67-4f1d-49f1-948f-e63b6b937b29@sotapeli.fi
Fixes: ceb5ab3cb646 ("mtd: add driver for intel graphics non-volatile memory device")
Signed-off-by: Lucas De Marchi <lucas.demarchi@intel.com>
---
 drivers/mtd/devices/mtd_intel_dg.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/mtd/devices/mtd_intel_dg.c b/drivers/mtd/devices/mtd_intel_dg.c
index b438ee5aacc34..114e69135b8d9 100644
--- a/drivers/mtd/devices/mtd_intel_dg.c
+++ b/drivers/mtd/devices/mtd_intel_dg.c
@@ -738,6 +738,7 @@ static int intel_dg_mtd_probe(struct auxiliary_device *aux_dev,
 
 	kref_init(&nvm->refcnt);
 	mutex_init(&nvm->lock);
+	nvm->nregions = nregions;
 
 	for (n = 0, i = 0; i < INTEL_DG_NVM_REGIONS; i++) {
 		if (!invm->regions[i].name)
@@ -745,13 +746,15 @@ static int intel_dg_mtd_probe(struct auxiliary_device *aux_dev,
 
 		char *name = kasprintf(GFP_KERNEL, "%s.%s",
 				       dev_name(&aux_dev->dev), invm->regions[i].name);
-		if (!name)
-			continue;
+		if (!name) {
+			ret = -ENOMEM;
+			goto err;
+		}
+
 		nvm->regions[n].name = name;
 		nvm->regions[n].id = i;
 		n++;
 	}
-	nvm->nregions = n; /* in case where kasprintf fail */
 
 	nvm->base = devm_ioremap_resource(device, &invm->bar);
 	if (IS_ERR(nvm->base)) {




