Return-Path: <linux-kernel+bounces-831178-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 22FF0B9BC8F
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 21:56:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D72EE3B79D0
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 19:56:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C95EE270EBF;
	Wed, 24 Sep 2025 19:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="VoZryYF9"
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFD3D26CE11
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 19:56:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758743787; cv=none; b=jxYDZHoNW1xxdF4Y6UV1pCIdqxyDiJVUv1ty2u6+e2HexZdYk3qa2es4AqURKkhs4kzZHod6FPu8agSNuxvYECOU0yOwImmZYNBUFk/kqvWFCpZPY2JZj3PeDXuubjdurogu09WvugNgGoNpaVkX6pNnnYl/noKC1KKGE9dYnMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758743787; c=relaxed/simple;
	bh=I3+6vqYsG2MOCMGnfr911GjPWcuVd7Zi2yHvh2TaGvw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=i1eg15TwDRJ/LALFAVxeap5BJay3p0n3XOlO4fJtFRMxVzx/Iogu9Hwz1kKkIqnAfmrceBaXPudXJnN/Z4jBnWwB7aCXSKsSzUwBMYMELdLZ5gOcwG0mGrJD15qMaB7PbxdRuNOViIm8Bkmv/xRDnrG572bD5GjvwFEqM8VfH1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=VoZryYF9; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 01A11C011C6
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 19:55:56 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 1DE5760634;
	Wed, 24 Sep 2025 19:56:14 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 07437102F1875;
	Wed, 24 Sep 2025 21:56:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1758743773; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding; bh=qgbwk8TYbiHBOGbfoCQ5QpKJ1sVltwaWlsA72FQdWzc=;
	b=VoZryYF9K8OJR23YwWFgiqvn/EgvJ5SIk9daxNqgxC6Z3VuCYbIobfhGL2ldDeFxKJSQ9D
	FMAcFi+LXvkUnWEdkML9ewr18NqZ9H/J3kak84VCrmccCYFsBwUBARigZdRnhHagMmFE7f
	yyx4xpoGXkdJEHCNWnGVxkhAIB6wPmnt97cRHZAslIIZ2wPYEkhS28d+CV/WSk/HD/+UkE
	mKeYCWm9Z56zB2LsP591PZ9oLbhdxvp2OIG8PKXXfFOvXxkcpDB17Hk4JGLhCW5b7mP8IJ
	V2HHnQR88AlCn5RFGsZjB9WUi9a4Xbq48jEuYM9Dkqw/d6jhUi2ytoPPiuwhbg==
From: alexandre.belloni@bootlin.com
To: Jorge Marques <jorge.marques@analog.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Frank Li <Frank.Li@nxp.com>
Cc: kernel test robot <lkp@intel.com>,
	linux-i3c@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] i3c: master: adi: fix number of bytes written to fifo
Date: Wed, 24 Sep 2025 21:56:00 +0200
Message-ID: <20250924195600.122142-1-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

From: Alexandre Belloni <alexandre.belloni@bootlin.com>

adi_i3c_master_wr_to_tx_fifo computes the maximum number of bytes that can be
sent to the fifo but never makes use of it, actually limit the number of bytes
sent.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202509190505.fKGvEJRa-lkp@intel.com/
Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 drivers/i3c/master/adi-i3c-master.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/i3c/master/adi-i3c-master.c b/drivers/i3c/master/adi-i3c-master.c
index 18597ba1f1c3..82ac0b3d057a 100644
--- a/drivers/i3c/master/adi-i3c-master.c
+++ b/drivers/i3c/master/adi-i3c-master.c
@@ -135,7 +135,7 @@ static void adi_i3c_master_wr_to_tx_fifo(struct adi_i3c_master *master,
 
 	n = readl(master->regs + REG_SDO_FIFO_ROOM);
 	m = min(n, nbytes);
-	i3c_writel_fifo(master->regs + REG_SDO_FIFO, buf, nbytes);
+	i3c_writel_fifo(master->regs + REG_SDO_FIFO, buf, m);
 }
 
 static void adi_i3c_master_rd_from_rx_fifo(struct adi_i3c_master *master,
-- 
2.51.0


