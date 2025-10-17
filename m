Return-Path: <linux-kernel+bounces-857363-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 38E37BE6A46
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 08:24:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0DF86741FAE
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 06:18:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 521C3311C0C;
	Fri, 17 Oct 2025 06:14:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sinic.eu header.i=@sinic.eu header.b="Hw3uwCPs"
Received: from mail.sinic.eu (mail.sinic.eu [168.119.168.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FAAE311950
	for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 06:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.168.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760681649; cv=none; b=MuSK4PquhkBpGNmQ+dmZVSCme6T2rODObdIdwneyLZSfPoeGstb8ziJpfOMTFsVoZopJavY1g/RnwVpSe6OH/zI6j+80Hphe5J8ldqP+7rZ/iSqTDm5RwhySKO1RNKwXa22vCNwfjx/d59zaxFvaq5GdcmDigsnUAMIBUhbvNzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760681649; c=relaxed/simple;
	bh=1GJ8oU1PYbUbEXQkSe0PbBqDg1vD0KcuKamnBAhE7gg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=X5n18SGA/Jd3zdL69HLy2Qrl0FN1NB40GV9KSN70+znTkG/2t7uwYdmuI7PhAVLrj/oRl0CrgErCq9Bj4qBPqlOs5ZEJ6m2R8PJkXT0Mv30Y2636moWPIV92od1K72xOBEgAKusKzPnOdMmluK71/eW5eEen7raOs46Ta62Tbgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sinic.eu; spf=pass smtp.mailfrom=sinic.eu; dkim=pass (2048-bit key) header.d=sinic.eu header.i=@sinic.eu header.b=Hw3uwCPs; arc=none smtp.client-ip=168.119.168.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sinic.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sinic.eu
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id A9DE33F16A;
	Fri, 17 Oct 2025 08:05:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sinic.eu; s=dkim;
	t=1760681145; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding; bh=EocX1a7XiC78SMAYfzWXkhpGeubPEEt2A4XDo0VaZcA=;
	b=Hw3uwCPs1UQdiaNMQhs1zky1zGH48CNcvQN0aGRsmpFukdSlNUX9Chfw2F1215QZmmVtkR
	EJILPv0rZPGdui26N3lEF/xJ3Pga+Pp9m3bGBVqPwQqXPXRbKnsmH3oxaoFeflzAGJ484q
	+HIUtz1coJTBXF6nX2+k3qoL/MJSTRJqLF6rPxm6+8aVhzWTi1eJ8r3JfaK34ZXBIe7eFT
	v/54CbUf8SyI+SZ7rJF3DRTbDbSr3vOcOJJlU6c4lheo52kCQCZJxqBCGtm8Zyiyh1oHMy
	33My9i3B5tnzl4UfPxCpS59vp6FpXtyhn+gyjpQkC+NOUtBjXLCnsuw+YpaubQ==
From: Simon Richter <simon@sinic.eu>
To: Tudor Ambarus <tudor.ambarus@linaro.org>,
	Pratyush Yadav <pratyush@kernel.org>,
	Michael Walle <mwalle@kernel.org>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	linux-mtd@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: Marcus Folkesson <marcus.folkesson@gmail.com>,
	Simon Richter <simon@sinic.eu>
Subject: [PATCH] mtd: spi-nor: atmel: add at25dn011
Date: Fri, 17 Oct 2025 08:05:29 +0200
Message-ID: <20251017060529.21169-1-simon@sinic.eu>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

Add AT25DN011 with 1Mbit.
Used on multiple custom boards and tested with this patch.

Link: https://www.renesas.com/en/document/dst/at25dn011-datasheet?r=1608506
Signed-off-by: Simon Richter <simon@sinic.eu>
---
 drivers/mtd/spi-nor/atmel.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/mtd/spi-nor/atmel.c b/drivers/mtd/spi-nor/atmel.c
index 82c592f0a1e1..0c2908bce0bc 100644
--- a/drivers/mtd/spi-nor/atmel.c
+++ b/drivers/mtd/spi-nor/atmel.c
@@ -171,6 +171,11 @@ static const struct flash_info atmel_nor_parts[] = {
 		.name = "at45db081d",
 		.size = SZ_1M,
 		.no_sfdp_flags = SECT_4K,
+	}, {
+		.id = SNOR_ID(0x1f, 0x42, 0x00),
+		.name = "at25dn011",
+		.size = SZ_128K,
+		.no_sfdp_flags = SECT_4K | SPI_NOR_DUAL_READ
 	}, {
 		.id = SNOR_ID(0x1f, 0x42, 0x16),
 		.name = "at25sl321",
-- 
2.51.0


