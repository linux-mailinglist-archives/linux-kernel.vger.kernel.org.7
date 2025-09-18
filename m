Return-Path: <linux-kernel+bounces-767130-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 79924B24FD1
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 18:32:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 33E955E149B
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 16:20:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBB1729E0F5;
	Wed, 13 Aug 2025 16:16:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="SK45sVxt"
Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26F6C29ACC0
	for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 16:16:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755101800; cv=none; b=mOmSTEKrW8dsdpnz5jqL1eXccSpscKUcIdXpmf2z5kpe6rC3lgEW16QevVVJgbtr1VfmJ6TvBzxhA3pVXaKEBOkXM8bw1QpBJq6qF02KP7+djoyT+T/b9ewKfX2s/BEvT1AhgY5fnF72NDpe1D39sQyJDXVdd7zECVDIU4Gus8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755101800; c=relaxed/simple;
	bh=p8MWpyF+PHQFJ6hSzygfVCYmm1+i2ZjBlY5werjyLWY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BdsPhuYMlwLd+JCB2zgevNL8Hm9ESllUPtOhJNH94IK4IhEhsYmWtV5QiuhqzHobiEDswIrX3S4N7QrI4T01UW3dNy8xEL0YJu+xkqvkexulHaGmmst+zDjKF2BOHq8uqyGyAF1Ls8HNV9mu8wm0hFy/Kvk89Pqe9DYxGg8JPk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=SK45sVxt; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=from:to:cc:subject:date:message-id
	:in-reply-to:references:mime-version:content-transfer-encoding;
	 s=k1; bh=dm4NvC8GSXuhdaV/btFqQyJwzxLFYpkxbFGHw5QCyZU=; b=SK45sV
	xt7nlwH5wnSIOQ1QOEGOrI1D60TB7eUuKp1UDyCRiOiM2jV824rcwUUqq2bd1svg
	Epg8HB+PWDa2CCFII1ikbTOKeD/rJobi1UIHpk1IaBOjTI4FqM2g8o92xeDOS57A
	JlXyKvmMUwZFrEqIwRQtvsj9WH2y2pL8lq/NrOSjEskTxH+afZzhaDTX5aU0iUMR
	JMB4wFP0IDbU09xZM/lomdAcGS6zUZr0+pPNl4qsWRnkN4Ord7mPIXNmBR3Q0CHI
	pdQHonNWtXP4LixJmmrjltHRKjydQR2PAn/kGTT4VgrIxsfipavRCv3gXqjcgwd5
	bgLwm4g8TORkviuw==
Received: (qmail 695769 invoked from network); 13 Aug 2025 18:16:31 +0200
Received: by mail.zeus03.de with UTF8SMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 13 Aug 2025 18:16:31 +0200
X-UD-Smtp-Session: l3s3148p1@JEDDekE8EL1tKLKq
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: linux-kernel@vger.kernel.org
Cc: Mark Brown <broonie@kernel.org>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	linux-spi@vger.kernel.org
Subject: [PATCH 19/21] spi: remove unneeded 'fast_io' parameter in regmap_config
Date: Wed, 13 Aug 2025 18:15:05 +0200
Message-ID: <20250813161517.4746-20-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250813161517.4746-1-wsa+renesas@sang-engineering.com>
References: <20250813161517.4746-1-wsa+renesas@sang-engineering.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When using MMIO with regmap, fast_io is implied. No need to set it
again.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
No dependencies, can be applied directly to the subsystem tree. Buildbot is
happy, too.

 drivers/spi/spi-altera-platform.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/spi/spi-altera-platform.c b/drivers/spi/spi-altera-platform.c
index 585393802e9f..e163774fd65b 100644
--- a/drivers/spi/spi-altera-platform.c
+++ b/drivers/spi/spi-altera-platform.c
@@ -30,7 +30,6 @@ static const struct regmap_config spi_altera_config = {
 	.reg_bits = 32,
 	.reg_stride = 4,
 	.val_bits = 32,
-	.fast_io = true,
 };
 
 static int altera_spi_probe(struct platform_device *pdev)
-- 
2.47.2


