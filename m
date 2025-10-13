Return-Path: <linux-kernel+bounces-849935-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E479BD161D
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 06:36:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5904B4E3547
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 04:36:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF61D2BE7DB;
	Mon, 13 Oct 2025 04:36:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="H0vKBEvu"
Received: from fllvem-ot04.ext.ti.com (fllvem-ot04.ext.ti.com [198.47.19.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 001F6232785
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 04:36:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760330199; cv=none; b=KKaCmuupcoIc9x6eI9L2srID06e3awpp6AG+iBx1YneHk/tfgFtYNM86V4diLwjek13KZ4QpbE6IP15ksoSi0LeDDxFPAD/Lxc1GPnDoBlZB1hfxyZ09vUOGljiz0MWDDbZC9ohinHXDCbJHk62hfSGVOpnoFAlGtYla1v/jVt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760330199; c=relaxed/simple;
	bh=7KA+d1gJCWsD4GhWE0t1thjF0Uz/53nXOVwpE+B05sY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=nTwDLQFnlE3/e1mhaK6fEH8pVB4z4m7WTDtyB0wy6ju5/BIViOD1AKpfWC/3GVbVZs1rdjEOzCyzbYSybrTDnM229Isp1E9V5SIPZ/29Wxe23vPkP6oFVCwL8UkpqEt+V6bCY1B0EsoZla4h26u/fmnV56vHQ6g5UC/Hrvw1HQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=H0vKBEvu; arc=none smtp.client-ip=198.47.19.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllvem-sh04.itg.ti.com ([10.64.41.54])
	by fllvem-ot04.ext.ti.com (8.15.2/8.15.2) with ESMTP id 59D4a3sA1177000;
	Sun, 12 Oct 2025 23:36:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1760330163;
	bh=MR5ug0YxD7IGZ4Inwcalzi0VvEB2St2aBI6pB9aDRXg=;
	h=From:To:CC:Subject:Date;
	b=H0vKBEvuohPctSuZpezBFmfqQWJJcd8xr9Vg7c5rXnTAtuSpO4e5xwB872U5Fa+14
	 ll+aA2VCrTfA224kSnFf3gfFX+j3KkjW2wRPHu45WqkaqluIKbK2mSIIYRdVe7gsFs
	 sAEtkRxXdRZAqU7Ia7Ggv8pnVXdH8ueuHEQooLso=
Received: from DFLE212.ent.ti.com (dfle212.ent.ti.com [10.64.6.70])
	by fllvem-sh04.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 59D4a3ab2692860
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Sun, 12 Oct 2025 23:36:03 -0500
Received: from DFLE211.ent.ti.com (10.64.6.69) by DFLE212.ent.ti.com
 (10.64.6.70) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 12 Oct
 2025 23:36:03 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE211.ent.ti.com
 (10.64.6.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Sun, 12 Oct 2025 23:36:03 -0500
Received: from LT5CG31242FY.dhcp.ti.com (lt5cg31242fy.dhcp.ti.com [10.85.14.169])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 59D4Zxxx1215459;
	Sun, 12 Oct 2025 23:36:00 -0500
From: Shenghao Ding <shenghao-ding@ti.com>
To: <tiwai@suse.de>
CC: <broonie@kernel.org>, <andriy.shevchenko@linux.intel.com>,
        <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        <baojun.xu@ti.com>, <Baojun.Xu@fpt.com>, <13564923607@139.com>,
        <13916275206@139.com>, Shenghao Ding <shenghao-ding@ti.com>
Subject: [PATCH v1] ALSA: hda/tas2781: Set tas2781_hda::tasdevice_priv::chip_id as TAS5825 in case of tas5825
Date: Mon, 13 Oct 2025 12:35:55 +0800
Message-ID: <20251013043555.1871-1-shenghao-ding@ti.com>
X-Mailer: git-send-email 2.33.0.windows.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

The software reset for TAS5825 is different form other chips, as it will
set as 0x11 instead of 0x1 during reset in the tasdevice_reset(). So set
tas2781_hda::tasdevice_priv::chip_id as TAS5825, tasdevice_reset() can
work correctly.

Fixes: 7ceb69ca82b1 ("ASoC: tas2781: Add tas2118, tas2x20, tas5825 support")
Signed-off-by: Shenghao Ding <shenghao-ding@ti.com>
---
 sound/hda/codecs/side-codecs/tas2781_hda_i2c.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/hda/codecs/side-codecs/tas2781_hda_i2c.c b/sound/hda/codecs/side-codecs/tas2781_hda_i2c.c
index a126f04c3ed7..0357401a6023 100644
--- a/sound/hda/codecs/side-codecs/tas2781_hda_i2c.c
+++ b/sound/hda/codecs/side-codecs/tas2781_hda_i2c.c
@@ -669,6 +669,7 @@ static int tas2781_hda_i2c_probe(struct i2c_client *clt)
 		 */
 		device_name = "TXNW5825";
 		hda_priv->hda_chip_id = HDA_TAS5825;
+		tas_hda->priv->chip_id = TAS5825;
 	} else {
 		return -ENODEV;
 	}
-- 
2.43.0


