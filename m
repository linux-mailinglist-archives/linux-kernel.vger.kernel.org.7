Return-Path: <linux-kernel+bounces-780011-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A5EFB2FC61
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 16:26:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ABC731C83825
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 14:18:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83F9E22B8BE;
	Thu, 21 Aug 2025 14:17:16 +0000 (UTC)
Received: from smtp.gentoo.org (woodpecker.gentoo.org [140.211.166.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B80A41E8320
	for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 14:17:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755785836; cv=none; b=Y4Tt5L6M+2EDwIhEQyAyK8rYUjSH9lNaCyQo9Gp88cbe6uQOmc44GkeD01P9u1mbtdpZjId1jNWH1Z298zykP+12xio4/tlpC7hNytCEJ9WNXiAb27OfJ12Ufa46HwKlHKxix2jG8eXYo0Trhq22O/K56OtMjvKrF9lUDZobYTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755785836; c=relaxed/simple;
	bh=ipCRsd1VfHlrlpxgjqdTRnACWEk7iAdMxYp3yq+pTvI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YMn68tuyt7TAB7g/ZqlJZkAB+zL4z3hda0ysg5toH7aDIwpGnIPhmdsHJAgiaPeLcDr4iHphtnrChYqhDsYS4Dpuu8e3dNMzlFixu+3vwm43ejyzJIYSeWBd1VydPKlKs1ZixEWE5s0gL6uuUhO4cb+B+C0sB1/SbDNFSNkEl28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org; spf=pass smtp.mailfrom=gentoo.org; arc=none smtp.client-ip=140.211.166.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentoo.org
Received: from bozeman.fios-router.home (pool-96-240-17-61.nwrknj.fios.verizon.net [96.240.17.61])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: mpagano)
	by smtp.gentoo.org (Postfix) with ESMTPSA id D2CF6340A98;
	Thu, 21 Aug 2025 14:17:13 +0000 (UTC)
From: Mike Pagano <mpagano@gentoo.org>
To: linux-kernel@vger.kernel.org
Cc: akshay.gupta@amd.com,
	mpagano@gentoo.org
Subject: [PATCH] misc: amd-sbi: Add missing dependency on REGMAP_I2C
Date: Thu, 21 Aug 2025 10:16:52 -0400
Message-ID: <20250821141711.177014-1-mpagano@gentoo.org>
X-Mailer: git-send-email 2.49.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This driver requires REGMAP_I2C to be selected in order to get
access to devm_regmap_init_i2c.

Add the missing dependency.

Signed-off-by: Mike Pagano <mpagano@gentoo.org>
---
 drivers/misc/amd-sbi/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/misc/amd-sbi/Kconfig b/drivers/misc/amd-sbi/Kconfig
index 4840831c84..4aae0733d0 100644
--- a/drivers/misc/amd-sbi/Kconfig
+++ b/drivers/misc/amd-sbi/Kconfig
@@ -2,6 +2,7 @@
 config AMD_SBRMI_I2C
 	tristate "AMD side band RMI support"
 	depends on I2C
+	select REGMAP_I2C
 	help
 	  Side band RMI over I2C support for AMD out of band management.
 
-- 
2.49.1


