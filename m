Return-Path: <linux-kernel+bounces-800835-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 02522B43CC7
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 15:14:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9DDA5A0174A
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 13:14:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF43530101B;
	Thu,  4 Sep 2025 13:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="ZgJfqEot"
Received: from fllvem-ot04.ext.ti.com (fllvem-ot04.ext.ti.com [198.47.19.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 683DB3002B2
	for <linux-kernel@vger.kernel.org>; Thu,  4 Sep 2025 13:14:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756991642; cv=none; b=Tv+Htkn4dQbUZPhYASRlMHZAiHjagQ3RCptZyscb5joq8eZqVG1N9sDca+51+udawiCJ/wVe1DTHsXpzKi/qKJ1/fbc3yKRaY5JPDpOgIsNE6leLebzC89gE4UKDfF+2nowbJoPbZo+Oy64u0Aw0zHMlI9d4vLhRuiDz0IPtij0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756991642; c=relaxed/simple;
	bh=iLXAfEcSPDX17+JwzkymYZGHswXbUjkyEcB4Hzku/aQ=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=pyWk79iK3BwAWKErHnnem9Hk2pLwydGo/PJHkT+Kbzv76T8UTbyuVrdVamoVCDnY8b8z+SeokyapoRKhVXWsaGQGaw+LLCKP8eQUnORhqpPBAslSZYVwL8bWilGaIwEL4hQvRoZQU+O3b0amyJzThZTacwht7jvfwBGzGhAjz0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=ZgJfqEot; arc=none smtp.client-ip=198.47.19.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllvem-sh03.itg.ti.com ([10.64.41.86])
	by fllvem-ot04.ext.ti.com (8.15.2/8.15.2) with ESMTP id 584DDZn83474169;
	Thu, 4 Sep 2025 08:13:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1756991615;
	bh=T7yYk1ncConBQMSTgtkkCJVLyAVKphf2yMRWEtKMbI8=;
	h=From:To:CC:Subject:Date;
	b=ZgJfqEotqMhOCUGZnh245FWCzBhaMPiCFfLx6G4S1ZIkMg/nZgghAv4My3rkWA4sU
	 MyroBeVPJTsH5IBGSuTd4J5uBqTkEzANlWxURVAvSnWDWW/Z1Xx8nIhXUzYkG/pmK2
	 HnLqYiV/AXLNb4kqecQUng4/hgCbvfBlTmmBgZvE=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
	by fllvem-sh03.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 584DDZ8G139254
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Thu, 4 Sep 2025 08:13:35 -0500
Received: from DLEE115.ent.ti.com (157.170.170.26) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Thu, 4
 Sep 2025 08:13:34 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Thu, 4 Sep 2025 08:13:34 -0500
Received: from santhoshkumark.dhcp.ti.com (santhoshkumark.dhcp.ti.com [172.24.233.254])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 584DDUXn3304007;
	Thu, 4 Sep 2025 08:13:31 -0500
From: Santhosh Kumar K <s-k6@ti.com>
To: <miquel.raynal@bootlin.com>, <richard@nod.at>, <vigneshr@ti.com>,
        <tudor.ambarus@linaro.org>, <pratyush@kernel.org>, <mwalle@kernel.org>
CC: <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <s-k6@ti.com>, <praneeth@ti.com>, <p-mantena@ti.com>, <a-dutta@ti.com>,
        <u-kumar1@ti.com>
Subject: [PATCH] mtd: spi-nor: spansion: Modify addr_mode_nbytes for DTR mode
Date: Thu, 4 Sep 2025 18:43:09 +0530
Message-ID: <20250904131309.3095165-1-s-k6@ti.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

The nor->params->addr_mode_nbytes parameter defines the address byte
count for the current addressing mode. When transitioning between SDR
and DDR modes, this parameter must be properly updated to maintain the
correct addressing behavior. So, implement the necessary updates to
nor->params->addr_mode_nbytes during both DDR mode enablement and
disablement operations to ensure address byte counts remain consistent
with the active transfer mode.

Signed-off-by: Santhosh Kumar K <s-k6@ti.com>
---

Tested on TI's AM62x SK
Logs: https://gist.github.com/santhosh21/8d69756bd54605d79086b00850e1083a

---
 drivers/mtd/spi-nor/spansion.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/mtd/spi-nor/spansion.c b/drivers/mtd/spi-nor/spansion.c
index a0296c871634..678f7f4052c9 100644
--- a/drivers/mtd/spi-nor/spansion.c
+++ b/drivers/mtd/spi-nor/spansion.c
@@ -230,6 +230,8 @@ static int cypress_nor_octal_dtr_en(struct spi_nor *nor)
 			return ret;
 	}
 
+	nor->params->addr_mode_nbytes = 4;
+
 	/* Read flash ID to make sure the switch was successful. */
 	ret = spi_nor_read_id(nor, nor->addr_nbytes, 3, buf,
 			      SNOR_PROTO_8_8_8_DTR);
@@ -275,6 +277,8 @@ static int cypress_nor_octal_dtr_dis(struct spi_nor *nor)
 			return ret;
 	}
 
+	nor->params->addr_mode_nbytes = 3;
+
 	/* Read flash ID to make sure the switch was successful. */
 	ret = spi_nor_read_id(nor, 0, 0, buf, SNOR_PROTO_1_1_1);
 	if (ret) {
-- 
2.34.1


