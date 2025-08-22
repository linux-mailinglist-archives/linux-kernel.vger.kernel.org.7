Return-Path: <linux-kernel+bounces-782050-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 39B4DB31A56
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 15:56:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6C033AE69F0
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 13:51:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 158FD28643B;
	Fri, 22 Aug 2025 13:51:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="otWE+VW1"
Received: from fllvem-ot04.ext.ti.com (fllvem-ot04.ext.ti.com [198.47.19.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6625A3043D6
	for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 13:51:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755870681; cv=none; b=YLKfHAPPukG7KPFzHRb/qdgOC9KkkcS/zJx3VodmvRKWOMPRzuovnDHCV3WZPBxugQ31f+XVCsnadnmw1oJykqagrFAcPXAZiucJ+RvZ0z3Ix0U0YoBAvQuaXnhAJZdi2avyrsZaRHsVAeHkd8trohxiFxtrRSFmZB2Gvh4We98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755870681; c=relaxed/simple;
	bh=PoKu8cetijpbo+YzllTWuCf4Q4G3t0TM8w0o7LKcXZE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=i4hA6D64FRHAt/5e+8ulfMc+g1SNmtJMHc8+nqmc8HGiyKLaNf3PmXerJjIlrTVI1RYJ1q1jnxYMN3c1GT+qb7y+pYcZuNb0toblrZSjHb4arJCZujO2PwsBfRP5CC/W3odPMkiFF+o+WoK3Q9G0peucfPWT8Tgr/ZAXoAw/Dcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=otWE+VW1; arc=none smtp.client-ip=198.47.19.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelvem-sh02.itg.ti.com ([10.180.78.226])
	by fllvem-ot04.ext.ti.com (8.15.2/8.15.2) with ESMTP id 57MDoq52730853;
	Fri, 22 Aug 2025 08:50:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1755870652;
	bh=vQpJb33UAMvr55isOHCAnuBgcUtJ7lvapZEPEFi8rGA=;
	h=From:To:CC:Subject:Date;
	b=otWE+VW1+KmfubKRMmslDNvfL171KXOwAEaqG+dzUKYW7iKnd+ZhdkhH0Mmj9EjjF
	 OYUStcTy1oWcag1JomHw4HzZAeDAw+UWc8Uf2rkdLFS2IFZJI66SVC5OTq1Bh12ziW
	 pjtfUl7TYFQUd9q3hkTnzjDl1DBrXlZRVkOpv6HY=
Received: from DFLE106.ent.ti.com (dfle106.ent.ti.com [10.64.6.27])
	by lelvem-sh02.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 57MDop833317935
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Fri, 22 Aug 2025 08:50:51 -0500
Received: from DFLE102.ent.ti.com (10.64.6.23) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Fri, 22
 Aug 2025 08:50:51 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Fri, 22 Aug 2025 08:50:51 -0500
Received: from LT5CG31242FY.dhcp.ti.com ([10.250.161.79])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 57MDolZ13918264;
	Fri, 22 Aug 2025 08:50:47 -0500
From: Shenghao Ding <shenghao-ding@ti.com>
To: <tiwai@suse.de>
CC: <broonie@kernel.org>, <andriy.shevchenko@linux.intel.com>,
        <13564923607@139.com>, <13916275206@139.com>,
        <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        <baojun.xu@ti.com>, <Baojun.Xu@fpt.com>, <jesse-ji@ti.com>,
        Shenghao Ding <shenghao-ding@ti.com>
Subject: [PATCH v1] ALSA: hda/tas2781: Fix EFI name for calibration beginning with 1 instead of 0
Date: Fri, 22 Aug 2025 21:50:42 +0800
Message-ID: <20250822135043.517-1-shenghao-ding@ti.com>
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
instead of 1, and code clean for the string checking.

Fixes: 4fe238513407 ("ALSA: hda/tas2781: Move and unified the calibrated-data getting function for SPI and I2C into the tas2781_hda lib")
Signed-off-by: Shenghao Ding <shenghao-ding@ti.com>

---
v1:
 - Fix EFI name beginning with 1 instead of 0
 - Code clean for the string checking
 - Add extra comments on EFI name for calibration
 - Remove an extra space
---
 sound/hda/codecs/side-codecs/tas2781_hda_i2c.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/sound/hda/codecs/side-codecs/tas2781_hda_i2c.c b/sound/hda/codecs/side-codecs/tas2781_hda_i2c.c
index ed7771ab9475..fecd5eac739b 100644
--- a/sound/hda/codecs/side-codecs/tas2781_hda_i2c.c
+++ b/sound/hda/codecs/side-codecs/tas2781_hda_i2c.c
@@ -340,16 +340,17 @@ static int tas2563_save_calibration(struct tas2781_hda *h)
 		data[offset] = i;
 		offset++;
 		for (j = 0; j < TASDEV_CALIB_N; ++j) {
-			ret = snprintf(var8, sizeof(var8), vars[j], i);
+			/* EFI name for calibration started with 1, not 0 */
+			ret = snprintf(var8, sizeof(var8), vars[j], i + 1);
 
-			if (ret < 0 || ret >= sizeof(var8) - 1) {
+			if (ret != strlen(var8)) {
 				dev_err(p->dev, "%s: Read %s failed\n",
 					__func__, var8);
 				return -EINVAL;
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


