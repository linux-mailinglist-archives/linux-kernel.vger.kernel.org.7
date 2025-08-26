Return-Path: <linux-kernel+bounces-786398-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DDE3AB35939
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 11:41:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A71FE17F9AB
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 09:41:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 685C53002CA;
	Tue, 26 Aug 2025 09:41:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="FjIxHJfe"
Received: from fllvem-ot04.ext.ti.com (fllvem-ot04.ext.ti.com [198.47.19.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6300120296A
	for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 09:41:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756201301; cv=none; b=Ixg37ydOGIV8u98zeNKtrR7k2pJRYl7G8zFldTimO9eEPwJLXnW4kr488nAq+US71V6ZRBJKzJlsKF5p+fij8eTyAYP5QQvkA/VNpcBi4nxVof+WYR1dk0H8qaA3+mZk7LRoROfqJmsL63GY1gVYWPRlG7j7tOdlecbSJcZrS9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756201301; c=relaxed/simple;
	bh=vLjLwr94q3rSj4G25/68U6jKI9ri/x/KD4FRifqWx14=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=gW74izGJSgFsL7bpb4xqWCSCCKGPdGdAnINjU62RDO0+QoaODNyHsv93KO9ktWCJP+Y0ERrfxE6gsrtjVreRcdP1woot1J1sjwbvHbtkm20dwO+xStsmIPdBZ0d5Y+2VO8L78QPf0IdOwg5X545A7MYc/iim+y/CJaczoPomW9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=FjIxHJfe; arc=none smtp.client-ip=198.47.19.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllvem-sh03.itg.ti.com ([10.64.41.86])
	by fllvem-ot04.ext.ti.com (8.15.2/8.15.2) with ESMTP id 57Q9fGFk1488907;
	Tue, 26 Aug 2025 04:41:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1756201276;
	bh=JZgmDGp+9Nh8DudvfY3ViWKUhhZhmNY8uji+3z7DO0g=;
	h=From:To:CC:Subject:Date;
	b=FjIxHJfeOSg3YJGpeoA2kTi6hESe3cd8Ywwn0718HaCqYf9Ls3bLqJi/bVw/CHtij
	 HOhkm3RF2dNCEG26ZT8TsDxcdgNuEMRhKrSSjtL0wZqExBJ1VgKQ2ESjyZT9BOjH7z
	 V3qnXBfkFSlzZjNYJD8fBJ7t9JNLyTCsLrw+tuVY=
Received: from DLEE102.ent.ti.com (dlee102.ent.ti.com [157.170.170.32])
	by fllvem-sh03.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 57Q9fFaa1590905
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Tue, 26 Aug 2025 04:41:15 -0500
Received: from DLEE104.ent.ti.com (157.170.170.34) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Tue, 26
 Aug 2025 04:41:14 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Tue, 26 Aug 2025 04:41:14 -0500
Received: from LT5CG31242FY.dhcp.ti.com ([10.250.161.79])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 57Q9fAo91229666;
	Tue, 26 Aug 2025 04:41:11 -0500
From: Shenghao Ding <shenghao-ding@ti.com>
To: <tiwai@suse.de>
CC: <broonie@kernel.org>, <andriy.shevchenko@linux.intel.com>,
        <13564923607@139.com>, <13916275206@139.com>,
        <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        <baojun.xu@ti.com>, <Baojun.Xu@fpt.com>, <jesse-ji@ti.com>,
        Shenghao Ding <shenghao-ding@ti.com>
Subject: [PATCH v2] ALSA: hda/tas2781: Fix EFI name for calibration beginning with 1 instead of 0
Date: Tue, 26 Aug 2025 17:41:05 +0800
Message-ID: <20250826094105.1325-1-shenghao-ding@ti.com>
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

A bug reported by one of my customers that EFI name beginning with 0
instead of 1.

Fixes: 4fe238513407 ("ALSA: hda/tas2781: Move and unified the calibrated-data getting function for SPI and I2C into the tas2781_hda lib")
Signed-off-by: Shenghao Ding <shenghao-ding@ti.com>

---
v2:
 - remove unrelated change
v1:
 - Fix EFI name beginning with 1 instead of 0
 - Add extra comments on EFI name for calibration
 - Remove an extra space
---
 sound/hda/codecs/side-codecs/tas2781_hda_i2c.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/sound/hda/codecs/side-codecs/tas2781_hda_i2c.c b/sound/hda/codecs/side-codecs/tas2781_hda_i2c.c
index ed7771ab9475..635cbd8820ac 100644
--- a/sound/hda/codecs/side-codecs/tas2781_hda_i2c.c
+++ b/sound/hda/codecs/side-codecs/tas2781_hda_i2c.c
@@ -340,7 +340,8 @@ static int tas2563_save_calibration(struct tas2781_hda *h)
 		data[offset] = i;
 		offset++;
 		for (j = 0; j < TASDEV_CALIB_N; ++j) {
-			ret = snprintf(var8, sizeof(var8), vars[j], i);
+			/* EFI name for calibration started with 1, not 0 */
+			ret = snprintf(var8, sizeof(var8), vars[j], i + 1);
 
 			if (ret < 0 || ret >= sizeof(var8) - 1) {
 				dev_err(p->dev, "%s: Read %s failed\n",
@@ -349,7 +350,7 @@ static int tas2563_save_calibration(struct tas2781_hda *h)
 			}
 			/*
 			 * Our variable names are ASCII by construction, but
-			 * EFI names are wide chars.  Convert and zero-pad.
+			 * EFI names are wide chars. Convert and zero-pad.
 			 */
 			memset(efi_name, 0, sizeof(efi_name));
 			for (k = 0; k < sizeof(var8) && var8[k]; k++)
-- 
2.43.0


