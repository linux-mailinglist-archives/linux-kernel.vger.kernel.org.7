Return-Path: <linux-kernel+bounces-750059-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FE05B156C9
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 02:52:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B0F9E5A2139
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 00:52:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD10586338;
	Wed, 30 Jul 2025 00:52:49 +0000 (UTC)
Received: from 6.mo576.mail-out.ovh.net (6.mo576.mail-out.ovh.net [46.105.50.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC40776034
	for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 00:52:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.105.50.107
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753836769; cv=none; b=lwGF1IUG1LkNS/qZGVSLZPJGkXZWacmbmVJLGPNW5e+AXXLy2bUG8+0nLQYZVjnPZpiGGd4vSI/eoFIAqQq4TkhPDyTVr03IYGMgs+HID5VGvLv5OZTa2Wi33+RV0MkMK2rWgdoj/cC2nIbNbztwJFrU+295YrLcGw0FZT9KG+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753836769; c=relaxed/simple;
	bh=YwBtlYTxnMtJEGmsPuBlTha4pUjJngIEzanoIRqVm9I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=c+l6Os/nZm+39zYn77gWsPt9nYKZ/sJuufoqLPbOXVhL40ML5hAATs/qirfzPexLjwD3sydyjQMF6b2BaZ6WkaYK+R7w/eJhg3vtEA1TZ0j1Jt1C40scnG1QTIi1TmeWgu87E8mU7p0hk+cUL2u23vZ6mJlOLI28hyV+ha9iF+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=etezian.org; arc=none smtp.client-ip=46.105.50.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etezian.org
Received: from director5.ghost.mail-out.ovh.net (unknown [10.110.54.182])
	by mo576.mail-out.ovh.net (Postfix) with ESMTP id 4bs7SQ5rHhz5vYK
	for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 21:16:22 +0000 (UTC)
Received: from ghost-submission-5b5ff79f4f-dk6bn (unknown [10.110.118.160])
	by director5.ghost.mail-out.ovh.net (Postfix) with ESMTPS id 12B7E10020F;
	Tue, 29 Jul 2025 21:16:21 +0000 (UTC)
Received: from etezian.org ([37.59.142.96])
	by ghost-submission-5b5ff79f4f-dk6bn with ESMTPSA
	id wT9bLyU6iWg28BwAvp9orQ
	(envelope-from <andi@etezian.org>); Tue, 29 Jul 2025 21:16:21 +0000
Authentication-Results:garm.ovh; auth=pass (GARM-96R00117a49f93-4c2e-440c-a929-1211d3ccec1a,
                    B1BE67AB95BB9E663CBBC29BBB60E52A198E8D2C) smtp.auth=andi@etezian.org
X-OVh-ClientIp:178.39.90.92
From: Andi Shyti <andi.shyti@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Andi Shyti <andi.shyti@kernel.org>
Subject: [PATCH] misc: rmi-i2c: Select regmap in Kconfig
Date: Tue, 29 Jul 2025 23:14:41 +0200
Message-ID: <20250729211441.1908223-1-andi.shyti@kernel.org>
X-Mailer: git-send-email 2.50.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Ovh-Tracer-Id: 4190036504485169735
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdeliedutdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufffkffoggfgsedtkeertdertddtnecuhfhrohhmpeetnhguihcuufhhhihtihcuoegrnhguihdrshhhhihtiheskhgvrhhnvghlrdhorhhgqeenucggtffrrghtthgvrhhnpedtveeuieehfeetudejhfehleeijedvveetleefhfehuedtleektdevjedujefgvdenucfkphepuddvjedrtddrtddruddpudejkedrfeelrdeltddrledvpdefjedrheelrddugedvrdelieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeduvdejrddtrddtrddupdhmrghilhhfrhhomheprghnughisegvthgviihirghnrdhorhhgpdhnsggprhgtphhtthhopedupdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdfovfetjfhoshhtpehmohehjeeimgdpmhhouggvpehsmhhtphhouhht

The driver depends on REGMAP but does not explicitly select it.
Without CONFIG_REGMAP enabled, the build fails. Fix this by
selecting REGMAP in Kconfig.

Signed-off-by: Andi Shyti <andi.shyti@kernel.org>
---
 drivers/misc/amd-sbi/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/misc/amd-sbi/Kconfig b/drivers/misc/amd-sbi/Kconfig
index 4840831c84ca..2074f5f38da2 100644
--- a/drivers/misc/amd-sbi/Kconfig
+++ b/drivers/misc/amd-sbi/Kconfig
@@ -2,6 +2,7 @@
 config AMD_SBRMI_I2C
 	tristate "AMD side band RMI support"
 	depends on I2C
+	select REGMAP
 	help
 	  Side band RMI over I2C support for AMD out of band management.
 
-- 
2.50.0


