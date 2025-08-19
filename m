Return-Path: <linux-kernel+bounces-775503-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E01FB2BFEC
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 13:12:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1CFF71B6715C
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 11:11:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29D67322777;
	Tue, 19 Aug 2025 11:11:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="SHymUxFo"
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6442C322DB7
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 11:11:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755601866; cv=none; b=GEfMD8aJirslV5L/w9PPEbqthZxYo8CRQfSlU/QsvnqnsSiDcAMX44Xgd4NCvFNHTBNiNwDjOsdQBHqkTW1T7bvFSfNK6xiP3xdaTRM3sG1dZRwF9b/8Rp74NNzI25ocz7RUeRSQTyIor/umJDYNFit2QRopzlxBXyJtV094Q5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755601866; c=relaxed/simple;
	bh=C46cxh37otbWjRDqzJcdqyTBwXuLy7xE3pNBZX+LYbY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VvR7eWG2clbJPfM6ee7+ldmyfWzJVeEcQWZcgOWaSwY0Qlf0O609fTzFlKxEJ2sPgUpUwGdb7lfppyPALLNubekaEhp3MRoAF/T0Zh/LwQ9ZQ9mXDh32hHfCBJb+zGDQnh6AgvdlhA8RlTr1F8U855aAzx4i9DmibZowOpeEnMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=SHymUxFo; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:
	Subject:Cc:To:From:Reply-To:Content-Type:In-Reply-To:References;
	bh=cSeEG+pd+PLbzzq4w2+Bc4gPYVktvWRvTyXPr57+HcE=; b=SHymUxFoyd+h1Ap+7NtNiaY+JD
	LajxIG2Q/Nne0sm7/gcBRvNsYewuqirlGvs/Ie5RkCJaKXtVPf/P7Ayza8InKAfalczX1hnUuE73Y
	ToBe/M8OflwQwk6zaa4vk2/f23oqBafhkYLO909Spnje/wdGDIelBsOdMysBYSylfxN5N/JGUPTg9
	zW16Zb10BO/TjhyU69HK+E25gwkW1pgBpavr7X6GUwItFitV5qVPn9OQTdHuavTjw8j278WLysVwq
	yXlggaEM2H/XNoZTL6md3PRV8jJB70xaj7p4swZl7L+Z6Xvn3jEl3rO7IgaeGzFYSFE2KQU3dXDcJ
	Dwef5PuQ==;
Received: from i53875a31.versanet.de ([83.135.90.49] helo=phil..)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1uoKF1-0000g2-O7; Tue, 19 Aug 2025 13:10:59 +0200
From: Heiko Stuebner <heiko@sntech.de>
To: srini@kernel.org
Cc: linux-kernel@vger.kernel.org,
	heiko@sntech.de,
	kernel test robot <lkp@intel.com>
Subject: [PATCH] nvmem: qnap-mcu-eeprom: swap header order to fix missing type definitions
Date: Tue, 19 Aug 2025 13:10:44 +0200
Message-ID: <20250819111044.2714855-1-heiko@sntech.de>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The main header for the qnap-mcu uses types without (at the moment)
including the necessary types.h header.

While there is patch pending to fix that for every use:
  https://lore.kernel.org/all/20250804130726.3180806-2-heiko@sntech.de/
this does not help the nvmem driver right now.

Swapping the order of module.h and qnap-mcu.h headers does fix the
problem locally until the main change gets merged though.

Fixes: 117c3f3014a9 ("nvmem: add driver for the eeprom in qnap-mcu controllers")
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202508191205.ROvIX7IA-lkp@intel.com/
Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 drivers/nvmem/qnap-mcu-eeprom.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvmem/qnap-mcu-eeprom.c b/drivers/nvmem/qnap-mcu-eeprom.c
index fea1e7b91764..e18e9ff4cfce 100644
--- a/drivers/nvmem/qnap-mcu-eeprom.c
+++ b/drivers/nvmem/qnap-mcu-eeprom.c
@@ -9,8 +9,8 @@
  * Copyright (C) 2008 Wolfram Sang, Pengutronix
  */
 
-#include <linux/mfd/qnap-mcu.h>
 #include <linux/module.h>
+#include <linux/mfd/qnap-mcu.h>
 #include <linux/nvmem-provider.h>
 #include <linux/platform_device.h>
 
-- 
2.47.2


