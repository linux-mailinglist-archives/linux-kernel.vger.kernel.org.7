Return-Path: <linux-kernel+bounces-775002-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F2231B2BA27
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 09:05:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0F82C1BA2086
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 07:06:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 249022773D7;
	Tue, 19 Aug 2025 07:05:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="BBddDjHA";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="ewMRqAnt"
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1476A2512F1
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 07:05:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.104.207.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755587130; cv=none; b=n+zUG64hPmH7pPJwQI8dz3lWg6d1QW4r50nXYzPCEqrwd0u3Fl7ZRbg9QPuDlFKigQXOhvfvq1jDKLvWDhs+8ARIixIl+1nGKturpsv3IQguqyrh/zVZLGjWQV+3EsIQgmw8EA4I5ioLM50H+h1XMeRw3s9LT1S/hCmbroM7hOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755587130; c=relaxed/simple;
	bh=ge9nJXxHGQT2Mw4/9oN/varmGprwiqC6f1IcTogV7qQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GFXmLtxBXMUgRDr7NV2QDzcGzUF10uBdX4lkWmbZd8ddqJUXFpOQwuEFL/moshzlsxb9MTXpd8y/Qt8GCwXh3flVSZKjDT0eZxnR1tnKJ79UmtUEPmCkyYtc39En2yyfBDlrDkFZy6Glv/hDQB9ZNtgjocpPVMyK4iY0iZ8dg78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b=BBddDjHA; dkim=fail (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=ewMRqAnt reason="key not found in DNS"; arc=none smtp.client-ip=93.104.207.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1755587126; x=1787123126;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=c1BxtWxFSzVI01nWbBEkqZ/G2VNra/FxRh8DQNAAobM=;
  b=BBddDjHA6SJpIfHTIB9t3yynvuxugn3FQ3rJZAi1ZmDI5dHsJ4M7PsP3
   SpOVUltH/WmtjtwWTqPXFRajfM3QCw03Vkf1S/klkmVcyT6DlzkNUA8eQ
   QePXSSLvQfZ+Ihb3WwWfDA+o56Mtu+WtQDTno8x+mM5x+Y+u6/J28ZuQ4
   HBRkhai22tHPum5cAW9RuO0ADb5CYlv7bgVlVtQAhEYt62c+GM8im9P28
   kzVw+yLYVrrtk/JqVN6xJ5bzl175GiAz0IOG0bcXQUItdww1TFyd6Wbt7
   F00wsTw5EVj8F2iEsJjnFRqOFXh9gNYB0sCY9cRMjUE69Lc6LM5M83CR3
   A==;
X-CSE-ConnectionGUID: fIwxeDp0R6+2sZww5NY2GQ==
X-CSE-MsgGUID: t4fCMBi3Tzi/l0NmZyvFkA==
X-IronPort-AV: E=Sophos;i="6.17,300,1747692000"; 
   d="scan'208";a="45796382"
Received: from vmailcow01.tq-net.de ([10.150.86.48])
  by mx1.tq-group.com with ESMTP; 19 Aug 2025 09:05:22 +0200
X-CheckPoint: {68A42232-45-299FBAB0-EF52EDE7}
X-MAIL-CPID: 6C09F7E41B71AA5AEA1F17DECCEFAC1D_5
X-Control-Analysis: str=0001.0A00211B.68A421CD.001A,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 7B2211632DA;
	Tue, 19 Aug 2025 09:05:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ew.tq-group.com;
	s=dkim; t=1755587118; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding; bh=c1BxtWxFSzVI01nWbBEkqZ/G2VNra/FxRh8DQNAAobM=;
	b=ewMRqAntA6oODBtgjE7i+UeOXcV8RT4OzCEikUxqiOoxv+/bpnomoQdCUUxUY4KFKJ8M4o
	muMrUY8YljVX8QI2yYLeFGZ+WfFoBfQXomWuZkm8Wrk0BmrIgjq4qkU+ghN/cNiL5YY6yH
	Q3CGnkDkWFiaG1kvds1i0ECODJy6njRjd65s1Id0fhiLsZTplAf093SncXYwFtVtIIwIcB
	gQMLO1QuNibHEw7KbwdA5EQZmY4deRvS8JRjqFzQErlBTeRNHQn+VkYCHtobxK7yV0IlOi
	d93+CBxrUwfRYDzCUYfphrGX0OcGNSp1epe0CQ/B83RWGfk+vwFdgmqNr6aEtw==
From: Alexander Stein <alexander.stein@ew.tq-group.com>
To: Lee Jones <lee@kernel.org>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>
Cc: Alexander Stein <alexander.stein@ew.tq-group.com>,
	linux-kernel@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 1/1] mfd: stmpe: Allow building as module
Date: Tue, 19 Aug 2025 09:04:57 +0200
Message-ID: <20250819070458.1027883-1-alexander.stein@ew.tq-group.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

Export the core probe and remove function to be used by i2c and spi
drivers. Also add necessary module information so the drivers can be built
as modules. This reduces footprint of the driver is enabled but unused.

Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
---
Changes in v2:
* Improved commit message
* Remove superfluous text from module description
* Patch 1/3 and 2/3 already applied in next-20250819

v1: https://lore.kernel.org/all/20250725071153.338912-1-alexander.stein@ew.tq-group.com/

 drivers/mfd/Kconfig | 10 +++++-----
 drivers/mfd/stmpe.c |  6 ++++++
 2 files changed, 11 insertions(+), 5 deletions(-)

diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
index a403a3daedd52..874fee5681658 100644
--- a/drivers/mfd/Kconfig
+++ b/drivers/mfd/Kconfig
@@ -1539,8 +1539,8 @@ config MFD_DB8500_PRCMU
 	  through a register map.
 
 config MFD_STMPE
-	bool "STMicroelectronics STMPE"
-	depends on I2C=y || SPI_MASTER=y
+	tristate "STMicroelectronics STMPE"
+	depends on I2C || SPI_MASTER
 	depends on OF
 	select MFD_CORE
 	help
@@ -1568,14 +1568,14 @@ menu "STMicroelectronics STMPE Interface Drivers"
 depends on MFD_STMPE
 
 config STMPE_I2C
-	bool "STMicroelectronics STMPE I2C Interface"
-	depends on I2C=y
+	tristate "STMicroelectronics STMPE I2C Interface"
+	depends on I2C
 	default y
 	help
 	  This is used to enable I2C interface of STMPE
 
 config STMPE_SPI
-	bool "STMicroelectronics STMPE SPI Interface"
+	tristate "STMicroelectronics STMPE SPI Interface"
 	depends on SPI_MASTER
 	help
 	  This is used to enable SPI interface of STMPE
diff --git a/drivers/mfd/stmpe.c b/drivers/mfd/stmpe.c
index e1165f63aedae..3c5c2f157f529 100644
--- a/drivers/mfd/stmpe.c
+++ b/drivers/mfd/stmpe.c
@@ -1482,6 +1482,7 @@ int stmpe_probe(struct stmpe_client_info *ci, enum stmpe_partnum partnum)
 
 	return ret;
 }
+EXPORT_SYMBOL_GPL(stmpe_probe);
 
 void stmpe_remove(struct stmpe *stmpe)
 {
@@ -1497,6 +1498,7 @@ void stmpe_remove(struct stmpe *stmpe)
 
 	mfd_remove_devices(stmpe->dev);
 }
+EXPORT_SYMBOL_GPL(stmpe_remove);
 
 static int stmpe_suspend(struct device *dev)
 {
@@ -1520,3 +1522,7 @@ static int stmpe_resume(struct device *dev)
 
 EXPORT_GPL_SIMPLE_DEV_PM_OPS(stmpe_dev_pm_ops,
 			     stmpe_suspend, stmpe_resume);
+
+MODULE_DESCRIPTION("STMPE Core driver");
+MODULE_AUTHOR("Rabin Vincent <rabin.vincent@stericsson.com>");
+MODULE_LICENSE("GPL");
-- 
2.43.0


