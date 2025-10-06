Return-Path: <linux-kernel+bounces-843543-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A651BBBFB22
	for <lists+linux-kernel@lfdr.de>; Tue, 07 Oct 2025 00:34:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 662353BEE31
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Oct 2025 22:34:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CD4E1F1505;
	Mon,  6 Oct 2025 22:34:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="qRWz16nj"
Received: from out-171.mta0.migadu.com (out-171.mta0.migadu.com [91.218.175.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8387419E7F9
	for <linux-kernel@vger.kernel.org>; Mon,  6 Oct 2025 22:34:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759790073; cv=none; b=FgyicJjdO1pZ3EIPmZfbaKHPzk1QGgb9FTQQeAM67LeP/v+y4cwUHwTQauMaStxhUtlwbYbGopXihBMTJQnX9wVbqF9iGOHuL3yL+eVnlNtyIR9nC9XJ7e1KhHhyB536VyfycpTIdtFHMN1gqeTGYO99isKz6lElUJzOD7XNwPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759790073; c=relaxed/simple;
	bh=iXTicpzOs7ChOVyBxMHdtQyArPMa+H1oltk6rtwRIto=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Is/Sk/KUy1U8gcIO+nLqXmqgBXLNS9c89moc0WkODHkrR8m4vJfjV9vttQbFNAm5dKza4W9Sce0ax3gQBZQPOj9IKBDrWQiyujyiV/EjUkTES0Ih22GXznqIelUokuJ0fOCvabyi6C+STFAgcRsmDwNGvPVyM9r2E6WtLpeeQeg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=qRWz16nj; arc=none smtp.client-ip=91.218.175.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1759790064;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=vbof03f6Ib9YXQ4zrPTewbQTGhlgNiHtdjRceVw2hVQ=;
	b=qRWz16nj7iH2hsriDj3R0GccK7SV/iGasKinv1qnndYNugEjOCp0y/to4zW4qx0O5b5Hv2
	2E9gXIBF2x4U0X0hlRC9U/0oa8SfwxSmt+kXMUM+Bsbjman97LBjuG0veIZUoUbZTiiyYy
	yzSKIhyHCfdtyqhtqrLNAq777QT/U3k=
From: Sean Anderson <sean.anderson@linux.dev>
To: Tudor Ambarus <tudor.ambarus@linaro.org>,
	Pratyush Yadav <pratyush@kernel.org>,
	Michael Walle <mwalle@kernel.org>,
	linux-mtd@lists.infradead.org
Cc: Richard Weinberger <richard@nod.at>,
	linux-kernel@vger.kernel.org,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Sean Anderson <sean.anderson@linux.dev>
Subject: [PATCH] mtd: spi-nor: Enable locking for n25q00a
Date: Mon,  6 Oct 2025 18:34:09 -0400
Message-Id: <20251006223409.3475001-1-sean.anderson@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

The datasheet for n25q00a shows that the status register has the same
layout as for n25q00, so use the same flags to enable locking support.
These flags should have been added back in commit 150ccc181588 ("mtd:
spi-nor: Enable locking for n25q128a11"), but they were removed by the
maintainer...

Signed-off-by: Sean Anderson <sean.anderson@linux.dev>
---
Tested with a mt25qu01gbbb, which shares the same flash ID.

 drivers/mtd/spi-nor/micron-st.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/mtd/spi-nor/micron-st.c b/drivers/mtd/spi-nor/micron-st.c
index 187239ccd549..17c7d6322508 100644
--- a/drivers/mtd/spi-nor/micron-st.c
+++ b/drivers/mtd/spi-nor/micron-st.c
@@ -486,6 +486,8 @@ static const struct flash_info st_nor_parts[] = {
 		.id = SNOR_ID(0x20, 0xbb, 0x21),
 		.name = "n25q00a",
 		.size = SZ_128M,
+		.flags = SPI_NOR_HAS_LOCK | SPI_NOR_HAS_TB | SPI_NOR_4BIT_BP |
+			 SPI_NOR_BP3_SR_BIT6,
 		.no_sfdp_flags = SECT_4K | SPI_NOR_QUAD_READ,
 		.mfr_flags = USE_FSR,
 		.fixups = &n25q00_fixups,
-- 
2.35.1.1320.gc452695387.dirty


