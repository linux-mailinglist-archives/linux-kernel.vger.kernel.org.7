Return-Path: <linux-kernel+bounces-880709-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 479A5C265F6
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 18:33:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5D31C404D09
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 17:32:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7025350A1D;
	Fri, 31 Oct 2025 17:28:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="LDNV5w1l"
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 824D935029D
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 17:28:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761931716; cv=none; b=k8yPXku66EV4ONb/MjVV52Q2AABZOULymenL3GVsycrHu6jWGD483PCuT8CeHyJ3towynLZP90CFI2bIclDxgl3nledmrWddFafz2bB9xaox3WxFnxPxF6wPNH7N0NT1l/iyP3CXU7i/KnSW5fcc28jqFHLIe0b8TdtuoZuQqM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761931716; c=relaxed/simple;
	bh=RMbMUEEhl1btP11IBkzunbMSOg/RAvy6gpude6+GCuI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=do19bI3iP+MwYf/25yVhlaQ0ehiuGpsdyOINLCX4ySlwUV7hzRjbjejXSU2/D5ppAJnvC14TsoWT6ZQjHCqdzxLhMR5cgkCXkITtzvwLg+NrQhfbutjDYs+dpc5+zDaUWIYNgT98TyQ/q2kDEe5EjRYH+t5zdHnEmeaU9AduyY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=LDNV5w1l; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 2E9CF1A17C5;
	Fri, 31 Oct 2025 17:28:33 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 0524760704;
	Fri, 31 Oct 2025 17:28:33 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 5076E1181800B;
	Fri, 31 Oct 2025 18:28:31 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1761931712; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=o9wIzIvZiwRUNi0x5RrTd6dDilzMRTH2lHz86yrV8Lw=;
	b=LDNV5w1lANS5nYtNjr1I5p7kB/z3pWHD38yKtMCCHsO2u4uEbsKvdnLSsEfDOeq/9WQH21
	w+FIA7SLXadznmJiif0B3U2MqTmZpzZUuZVGc2LusMHMyYpsXK8k2LSNV9XaW4HItAX+7y
	y9m6hTwQMXA1v6ict7ZW+nhKcW+ixNLaOlgtyRnVaBFapQ2PmdfAj8hixvoDcfNoXc18RQ
	VAgCDZpG4mAryhbsOD8WOsSiF8ZOBfl6xIuSlg0odP7vVBvU3p+chIf3y4Y9iC13n7ZCVu
	VaDdFdSp0xeXP5gskJBhAIa5OlC0c8OwCZ+VNA+M8o0JlrtOEjje9dUF65MylQ==
From: Miquel Raynal <miquel.raynal@bootlin.com>
Date: Fri, 31 Oct 2025 18:27:01 +0100
Subject: [PATCH 17/28] mtd: spinand: winbond: Register W25N vendor specific
 operation
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251031-winbond-v6-17-rc1-oddr-v1-17-be42de23ebf1@bootlin.com>
References: <20251031-winbond-v6-17-rc1-oddr-v1-0-be42de23ebf1@bootlin.com>
In-Reply-To: <20251031-winbond-v6-17-rc1-oddr-v1-0-be42de23ebf1@bootlin.com>
To: Mark Brown <broonie@kernel.org>, Richard Weinberger <richard@nod.at>, 
 Vignesh Raghavendra <vigneshr@ti.com>
Cc: Tudor Ambarus <tudor.ambarus@linaro.org>, 
 Pratyush Yadav <pratyush@kernel.org>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Steam Lin <STLin2@winbond.com>, Santhosh Kumar K <s-k6@ti.com>, 
 linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-mtd@lists.infradead.org, Miquel Raynal <miquel.raynal@bootlin.com>
X-Mailer: b4 0.14.2
X-Last-TLS-Session-Version: TLSv1.3

Provide the Winbond W25N specific "select target" operation to let the
core verify it is supported by the controller before using it.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 drivers/mtd/nand/spi/winbond.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/mtd/nand/spi/winbond.c b/drivers/mtd/nand/spi/winbond.c
index 3003ad7e83ee8f553ec82a0326422916c0ed794c..36053f35ee5e84eb355343443a28d274cf7ea5c3 100644
--- a/drivers/mtd/nand/spi/winbond.c
+++ b/drivers/mtd/nand/spi/winbond.c
@@ -105,6 +105,9 @@ spinand_fill_winbond_write_vcr_op(struct spinand_device *spinand, u8 reg, void *
 		   SPI_MEM_OP_NO_DUMMY,					\
 		   SPI_MEM_OP_DATA_OUT(1, buf, 1))
 
+static SPINAND_OP_VARIANTS(winbond_w25_ops,
+		SPINAND_WINBOND_SELECT_TARGET_1S_0_1S(NULL));
+
 static struct spi_mem_op
 spinand_fill_winbond_select_target_op(struct spinand_device *spinand, void *valptr)
 {
@@ -497,6 +500,7 @@ static const struct spinand_info winbond_spinand_table[] = {
 					      &write_cache_variants,
 					      &update_cache_variants),
 		     0,
+		     SPINAND_INFO_VENDOR_OPS(&winbond_w25_ops),
 		     SPINAND_ECCINFO(&w25m02gv_ooblayout, NULL),
 		     SPINAND_SELECT_TARGET(w25m02gv_select_target)),
 	SPINAND_INFO("W25N02JW", /* high-speed 1.8V */

-- 
2.51.0


