Return-Path: <linux-kernel+bounces-827563-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 48757B9217B
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 17:57:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D94E51721BD
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 15:57:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BDB3304BCD;
	Mon, 22 Sep 2025 15:57:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zanders.be header.i=@zanders.be header.b="ScG05gWH"
Received: from smtp15.bhosted.nl (smtp15.bhosted.nl [94.124.121.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF75613D2B2
	for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 15:56:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=94.124.121.26
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758556620; cv=none; b=FNQAHMc2biQfcFs79siv5jgL865rBIDE5b3DW338iSAqt9h6evaRSIkRIhZMaBYyRlM/GWidhDAHhODHnHtS1DbfatjKx4+s6rjC2vs+mWeOG7xer7ybZxkoA70Yo4nWl2oMQMy4dW5F3dQE59YKZyUSCCzEYbD3EV+cBbS7Al0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758556620; c=relaxed/simple;
	bh=NLLTxWIlCnKOYbIWXEU6zKqQ9jkb0my0AkOsUrIwIKo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XBppy6FQ//LDorx6qa/KAjbgXxvpO+pQgwRPX2pRsUAhWickZcj3/7nkPv8J2i9cF3wg91vgx64O3dIkXNjKCLvqXGVaSy999gvklLQWTLbmehD0yz/dcTz3t1I4nb74AJwG8fjH7lh6Q4+xZ9xFFcugTB+/D+neY1uvIqZ4QHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zanders.be; spf=pass smtp.mailfrom=zanders.be; dkim=pass (2048-bit key) header.d=zanders.be header.i=@zanders.be header.b=ScG05gWH; arc=none smtp.client-ip=94.124.121.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zanders.be
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zanders.be
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=zanders.be; s=202002;
	h=content-transfer-encoding:mime-version:message-id:date:subject:cc:to:from:
	 from;
	bh=YTFtlHIfyxHbQdTRh7R7E9Uy1pABIFNYuUrtx6MizW0=;
	b=ScG05gWHzw04epzTp4OPDyhXbuQKMFOXQYADzYCtBjFrQyxdSaBuvfx8jJL1NnoNzJ1SolNzmAGOc
	 T1HkwQWynJo96BLGhYpPGSon4+YZ0RiTkQk3fhHwp0TV7kYWNPc5vNzeBmrGoDkS7VUGsr4bgdAbrZ
	 /cIEnA8P+/K5NgPALlLCo9AEZC49+hNioF7bHWNlvHz7cwue7tIlADNu9bARiaM2Tu2oB3cenCHC2s
	 LDOvxQud5CedUlRohxXC3V4sdc6Kez1ZPKbOqJSGxX7Y6DF0MKbkA+kg3VLfEBK93fkx8G9JtGT0t3
	 ccuCaX7krDf6yUTVJvQEpNk/+LoTAYQ==
X-MSG-ID: c01285bf-97cc-11f0-9d69-00505681446f
From: Maarten Zanders <maarten@zanders.be>
To: Tudor Ambarus <tudor.ambarus@linaro.org>,
	Pratyush Yadav <pratyush@kernel.org>,
	Michael Walle <mwalle@kernel.org>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Boris Brezillon <bbrezillon@kernel.org>
Cc: Maarten Zanders <maarten@zanders.be>,
	linux-mtd@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] handle RDCR opcode for Macronix
Date: Mon, 22 Sep 2025 17:56:31 +0200
Message-ID: <20250922155635.749975-1-maarten@zanders.be>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series introduces a configurable RDCR (Read Configuration Register)
opcode for spi-nor flashes and applies a fix for Macronix devices.

Patch 1 adds a new flash parameter to hold the RDCR opcode, defaulting
to 0x35 (JEDEC standard).

Patch 2 applies a Macronix-specific fixup, setting the RDCR opcode to
0x15.

Signed-off-by: Maarten Zanders <maarten@zanders.be>

Maarten Zanders (2):
  mtd: spi-nor: add configurable RDCR opcode
  mtd: spi-nor: macronix: use RDCR opcode 0x15

 drivers/mtd/spi-nor/core.c     | 12 +++++++++---
 drivers/mtd/spi-nor/core.h     |  6 ++++--
 drivers/mtd/spi-nor/macronix.c |  1 +
 include/linux/mtd/spi-nor.h    |  3 +++
 4 files changed, 17 insertions(+), 5 deletions(-)


base-commit: 4550d33e18112a11a740424c4eec063cd58e918c
-- 
2.51.0


