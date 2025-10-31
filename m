Return-Path: <linux-kernel+bounces-880695-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A671AC26599
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 18:29:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DAE011A657AB
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 17:30:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BCA634A3BF;
	Fri, 31 Oct 2025 17:28:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="ax0z1Sus"
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FF4832AAB5
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 17:28:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761931700; cv=none; b=iz6ggpMKnJ4pkm0vpiMAaUCgEdotPzq1ygOHaTF62N/xdn5WzzA6iwesJlPN/qh6afUQMGVCmux+Lh5HmZ3hTIiRlEDZUxtEFQe5nvnfoYr0Xemdeau5ZT99Bf9ScH+Atzy5f/UBMf+BJ0k55Lt6QdKy34r238eN/cYmJ1CS7LA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761931700; c=relaxed/simple;
	bh=IwvLnoMLU4bG0efPYGhK9TqWmO5drDF3tKFRE+kxHg0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DI6MJIXrA1A/o4QHGvIRpnNbgnguILQaX7LPpOf6EqKYISaesC7QjkPc49nHeHjAS+WLMR/TeIwTUhsjSdRIflZ7bpE1IHVSHrZEBZ06myWXGLSsj+tzi3JXEaTbO7fZopNMkpXGQdf3l64CNAlAF0wNb9RsfIXUDAyTV3tfpYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=ax0z1Sus; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 7BB39C0E958;
	Fri, 31 Oct 2025 17:27:56 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 0BEC560704;
	Fri, 31 Oct 2025 17:28:17 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 7BD8F1181800A;
	Fri, 31 Oct 2025 18:28:15 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1761931696; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=q/W5OsQj0CIrKwA3ktIDzuIUiJU0LxRWvddRPMRjja0=;
	b=ax0z1SusDDh0MrZrcgp7sj0nbRFj0hAdv1pbn8SDe9RQAtVGGyU+wpaPFsihD0kt/edBdI
	RS2MsgDMgLyESKYt2qGjvCt7PHlxWC/4P9CixrJi5LbbLCVFQ/b4uZ3aBSd0Xe2DFU6eg0
	o4p5X3pGqKQnKCfUbfdF/gxTjSwHQuEVjPjjv6v1oA01OnFEDTZKOpPi8JeUBwnZSPvUYt
	/rd+fbNp5KMioDzOz+QGrUh1w3ZarjCHh2mwB81avnBwwZk+VnEtl8N08ogN1UumlEsRPU
	GP3LboSkzgGu5XXpaBk3UGL+i70Ah36WDB2DaSZQq+7qpWCXYzoEeTcCpUsf7Q==
From: Miquel Raynal <miquel.raynal@bootlin.com>
Date: Fri, 31 Oct 2025 18:26:49 +0100
Subject: [PATCH 05/28] mtd: spinand: Add missing check
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251031-winbond-v6-17-rc1-oddr-v1-5-be42de23ebf1@bootlin.com>
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

The update cache variant is mandatory, both read and write versions are
being checked, but not this one. All chip drivers seem to implement this
variant, so there should be no breakage.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
The core has been like that since the begining, I do not think this
patch should be backported, hence no Fixes tag. This barely
qualifies as a fix anyway.
---
 drivers/mtd/nand/spi/core.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/mtd/nand/spi/core.c b/drivers/mtd/nand/spi/core.c
index e748fa47ef7bffb7f443b37261d138b35eb4cc7a..9d4e82554dab07b676632155ae94a706cf1177df 100644
--- a/drivers/mtd/nand/spi/core.c
+++ b/drivers/mtd/nand/spi/core.c
@@ -1431,6 +1431,9 @@ int spinand_match_and_init(struct spinand_device *spinand,
 
 		op = spinand_select_op_variant(spinand,
 					       info->op_variants.update_cache);
+		if (!op)
+			return -ENOTSUPP;
+
 		spinand->op_templates.update_cache = op;
 
 		return 0;

-- 
2.51.0


