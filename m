Return-Path: <linux-kernel+bounces-751284-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 73865B1673A
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 21:57:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A8D373A8E53
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 19:56:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA24E21480B;
	Wed, 30 Jul 2025 19:57:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="Z3w+Ybc6"
Received: from smtp.smtpout.orange.fr (smtp-28.smtpout.orange.fr [80.12.242.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8C6FBE6C;
	Wed, 30 Jul 2025 19:57:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753905424; cv=none; b=teKYEhLUU8V8z8pZpH65oGL9KKnDar8liaxJ5QX8gqgjhNd23uW1UyEIaSjcdYu3iBhJzvj4fcF8nBUcIdNwOunwP9mLO9j/gFuLJT5U02IHzCQ8ll9wjxYzaMeHVq1n6gk+gAWcLc6uqQVc9hECl8BoPZeSoPgsxvuCq0DduhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753905424; c=relaxed/simple;
	bh=mtj173+yUDes7pXfAXyjiiGJt2by8+zz+jBtD6gBylk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Heo1+RL7L1VoVFlB9rL0g10hy7YaqjOb9/siRSi0Rac1KJlUMzRlw76oOY/Ik+Imn5edgbDzE/A4OHCHaGRqS5dWi9+9f6dIwpq8pj2pjJzXnLPSBz4bazOP/lAUOGP6SxZfAukI8TJzTLKNFNM4eT5OX66/Pp0b43cr4zPb/dA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=Z3w+Ybc6; arc=none smtp.client-ip=80.12.242.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from fedora.home ([IPv6:2a01:cb10:785:b00:8347:f260:7456:7662])
	by smtp.orange.fr with ESMTPA
	id hCmHu9fPBsl3lhCmHuCkHa; Wed, 30 Jul 2025 21:47:57 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1753904877;
	bh=S8vcU+qlyvgic/IsK7WROuRtOUR18FvRKrLARPKltNk=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=Z3w+Ybc635EoBM2qQeo4lmiMQozrgmQluSGV5HEJ/q+765q/Y1h38zD8gQRTtEtDi
	 zqb3VwIyVYSphJ9dXMbYpWR5znReF3TxgBjPYr1aXILW77pkGN8UK+AByzjTgWVKp1
	 2DVBxamqAH0yg/Ur5zomCRCsqbtM7n7vNks8q9oi3sGokNo0bFW67NoaK0GGp7d0Qz
	 ixAvy5sX86OfxxEPYGkwlSFrKLko2KDe013lctPsfTXYgxggSf3EfyU6YncChAoz83
	 a3cnyqw0ovRdSSEO611YoyamSFQyytFwV5IHm1fxMLt3mMrDg2UW28FMqKeuNxu89+
	 Jlp9SB3XfZtlA==
X-ME-Helo: fedora.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Wed, 30 Jul 2025 21:47:57 +0200
X-ME-IP: 2a01:cb10:785:b00:8347:f260:7456:7662
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To: Miquel Raynal <miquel.raynal@bootlin.com>,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Jacky Huang <ychuang3@nuvoton.com>,
	Shan-Chun Hung <schung@nuvoton.com>,
	Hui-Ping Chen <hpchen0nvt@gmail.com>
Cc: linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	linux-mtd@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH] mtd: rawnand: nuvoton: Fix an error handling path in ma35_nand_chips_init()
Date: Wed, 30 Jul 2025 21:47:46 +0200
Message-ID: <a2a4ca2010ac4aa2aee0bec151d2e57e812510a0.1753904852.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If a ma35_nand_chip_init() call fails, then a reference to 'nand_np' still
needs to be released.

Use for_each_child_of_node_scoped() to fix the issue.

Fixes: 5abb5d414d55 ("mtd: rawnand: nuvoton: add new driver for the Nuvoton MA35 SoC")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
Compile tested only
---
 drivers/mtd/nand/raw/nuvoton-ma35d1-nand-controller.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mtd/nand/raw/nuvoton-ma35d1-nand-controller.c b/drivers/mtd/nand/raw/nuvoton-ma35d1-nand-controller.c
index c23b537948d5..1a285cd8fad6 100644
--- a/drivers/mtd/nand/raw/nuvoton-ma35d1-nand-controller.c
+++ b/drivers/mtd/nand/raw/nuvoton-ma35d1-nand-controller.c
@@ -935,10 +935,10 @@ static void ma35_chips_cleanup(struct ma35_nand_info *nand)
 
 static int ma35_nand_chips_init(struct device *dev, struct ma35_nand_info *nand)
 {
-	struct device_node *np = dev->of_node, *nand_np;
+	struct device_node *np = dev->of_node;
 	int ret;
 
-	for_each_child_of_node(np, nand_np) {
+	for_each_child_of_node_scoped(np, nand_np) {
 		ret = ma35_nand_chip_init(dev, nand, nand_np);
 		if (ret) {
 			ma35_chips_cleanup(nand);
-- 
2.50.1


