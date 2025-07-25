Return-Path: <linux-kernel+bounces-745360-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D107CB118E1
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 09:08:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AC3531626F3
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 07:08:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 719C7292B25;
	Fri, 25 Jul 2025 07:08:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="KryMtTUn";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="piZvWWy3"
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C26F26B2D2
	for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 07:08:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.104.207.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753427290; cv=none; b=VHa2UD9ev4pDbPZqYBu8V07UOVp6rg2pP0o6ewfvTtdYh6VmPVLXMiJ3QZ/QsZ+/qrKs+0/aA2h63k8dAhx+kemHQojwPkv1Bb17FidAgmtfrY2uWdEE+0WT8AnyL5wBxFcmyITntD8/RMtePCEhLiR1u3aYsIZMNo+vSzGfIC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753427290; c=relaxed/simple;
	bh=8Gw7owxlUWZtMpootgVc588v6Rf4ho7abQxTKGOb8w4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ClCkSAHU1CJl5JxY1TlNurq6sYTfuev5bnGSPW8IEH9W7abuD37SUCHS7mBuxwYBpjfcaXm4McBCTenL7RPMADitZEKcnOxKTudSC8X+Y7UyhnvG8t0cUYDp4yn7LECSMov37kug1Ir7wv5NPde1k9M/hTln/8FvUfGOhAsaXDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b=KryMtTUn; dkim=fail (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=piZvWWy3 reason="key not found in DNS"; arc=none smtp.client-ip=93.104.207.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1753427288; x=1784963288;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=XwSC+xmVIES6nj+1a81sSHqaAHSEmrsC+d7iOGrRylo=;
  b=KryMtTUnp2NMBrSo04mlO03RXegknW8VLFBgl8gn4x8729gGIORvYa6s
   mng2mXqAWLQ+M0DHE3PhsJkU4tkVnzFk1kLOZB1Hm/cRZCZpYRPDMyB33
   giL7mrN19CJLt0Jge4SnnDtWVT0TeHhAx+A8n5nMiwWMsdOGt/1+F7/KB
   sGbd+eweKpfnv/gwfjx3li3lRQnGD/NyrXHh+a9cMhJm/gzmRb0E3y5SQ
   o8Rpq98ZsFTi5ItKwAsWXKYMc6vpN0qmtipa4CuRyA7K7419nhyUCcPmU
   FLoL8kfqJ1CG+RL41slDv6WN1Y2aFOHkGe9XGUd1/N0UyedpAziVNfSeW
   Q==;
X-CSE-ConnectionGUID: h+qPiIYfQ4qbBN9e7JX0tQ==
X-CSE-MsgGUID: AghS5NPgSGChX8c9uv8wDQ==
X-IronPort-AV: E=Sophos;i="6.16,338,1744063200"; 
   d="scan'208";a="45414668"
Received: from vmailcow01.tq-net.de ([10.150.86.48])
  by mx1.tq-group.com with ESMTP; 25 Jul 2025 09:08:05 +0200
X-CheckPoint: {68832D55-19-943DFC15-D71A48EE}
X-MAIL-CPID: 6648D9629072FCC338F99289EBC1854B_5
X-Control-Analysis: str=0001.0A002103.68832D75.0025,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id C3D4517365F;
	Fri, 25 Jul 2025 09:08:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ew.tq-group.com;
	s=dkim; t=1753427280;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XwSC+xmVIES6nj+1a81sSHqaAHSEmrsC+d7iOGrRylo=;
	b=piZvWWy30WlbT9jMg31fqOmt4K1lc1f4DnhLnAmBKKqLgTKbSgCUKpJfDAkHS5BHjPSch6
	JxjYBqLjTDntiju9znT/pM1UpyBG+zFD2QmoIwBVlNdwZMmTs/v/NrffSguWnE5mS0iPsB
	2HsuUUGvD3fXWBPoiZTZJGyKXTQVek6FdpHGFMlur9EwNyUAvX23uhzozXvk8Ty3boXdGr
	tDQY7ho7ajsQwPK7H7esFaOwXz6mEOPOF1DPQAFIujtyKZeU5/4tgAjiwCGlJzj0UieTNY
	yx1y/LKmli0pSqMLNzgnNm9As6H73k/4S5QP5bxEaRmoZJSIPYhkciIQ5WlMAQ==
From: Alexander Stein <alexander.stein@ew.tq-group.com>
To: Lee Jones <lee@kernel.org>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>
Cc: Alexander Stein <alexander.stein@ew.tq-group.com>,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] mfd: stmpe-spi: Use module_spi_driver to remove boilerplate
Date: Fri, 25 Jul 2025 09:07:49 +0200
Message-ID: <20250725070752.338376-2-alexander.stein@ew.tq-group.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250725070752.338376-1-alexander.stein@ew.tq-group.com>
References: <20250725070752.338376-1-alexander.stein@ew.tq-group.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

Driver implements feature of module_spi_driver() manually. Replace it by
that macro instead.

Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
---
 drivers/mfd/stmpe-spi.c | 13 +------------
 1 file changed, 1 insertion(+), 12 deletions(-)

diff --git a/drivers/mfd/stmpe-spi.c b/drivers/mfd/stmpe-spi.c
index b9cc85ea2c401..7fee64102cae7 100644
--- a/drivers/mfd/stmpe-spi.c
+++ b/drivers/mfd/stmpe-spi.c
@@ -141,18 +141,7 @@ static struct spi_driver stmpe_spi_driver = {
 	.remove		= stmpe_spi_remove,
 	.id_table	= stmpe_spi_id,
 };
-
-static int __init stmpe_init(void)
-{
-	return spi_register_driver(&stmpe_spi_driver);
-}
-subsys_initcall(stmpe_init);
-
-static void __exit stmpe_exit(void)
-{
-	spi_unregister_driver(&stmpe_spi_driver);
-}
-module_exit(stmpe_exit);
+module_spi_driver(stmpe_spi_driver);
 
 MODULE_DESCRIPTION("STMPE MFD SPI Interface Driver");
 MODULE_AUTHOR("Viresh Kumar <vireshk@kernel.org>");
-- 
2.43.0


