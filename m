Return-Path: <linux-kernel+bounces-775388-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 56226B2BE9B
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 12:14:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4F35D3A8DD9
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 10:12:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0C1032038D;
	Tue, 19 Aug 2025 10:12:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="N70PXs3T"
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B1F231A05E
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 10:12:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755598324; cv=none; b=Rz82Sf/pscYJBOL0l/ZjNEEf8wGklZ3c8o6PWF5Mt1HQfOgFTlvlZMOyBpAVkPxGQNYolPyIdFef6MkxCLq2JHX5BLaUO4lQaErk8xChTrPT/qmfCunfkr20lnMrBVQ7EY05ac1+cqVS+3lCqJTWko4LJQueIjk9It3vXT4J7Yk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755598324; c=relaxed/simple;
	bh=Z8YihQoUMUnaN9eAL22PA1tfYOLUO3Jii/5tTLrDjf8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=KlFdvphypMY2zheN5ZoQKp1SuI5BUM0qbGY3Eo0E56YIYY5bCnxCym6riAt0oiqxQnRKcYQOYMv0lBloBkUbVSxkXV9dzLFFiv/rjUI47GKpdH3U0w/F+9pCr9X4ZCdUxy2d/3/5j0Q2pkwyrdQPHAfnFyKu9b5WVR8vt78A5iA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=N70PXs3T; arc=none smtp.client-ip=198.47.23.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllvem-sh04.itg.ti.com ([10.64.41.54])
	by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTP id 57JABgZl2931017;
	Tue, 19 Aug 2025 05:11:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1755598302;
	bh=GBseufnTrkiprToC1hEN+V9bNDsJi2enuQf3IdAPE+Q=;
	h=From:To:CC:Subject:Date;
	b=N70PXs3TIPiz+Cb3ic2Ofohfyxe7TrSOO3rI3pMSoGN1HQ59QNMLn7ehsOCgI41Hc
	 oLY3GcDN5soDs8EsZFjywg7du8tlqGmFHaZuFXw2xJG3h/NGBemRyORlMuA13SdjnH
	 rZSWx+6YFndODx4zt3w1+7VGB3ZU/h1i/kdsswzM=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
	by fllvem-sh04.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 57JABfsK1207830
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Tue, 19 Aug 2025 05:11:41 -0500
Received: from DLEE110.ent.ti.com (157.170.170.21) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Tue, 19
 Aug 2025 05:11:41 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Tue, 19 Aug 2025 05:11:41 -0500
Received: from uda0510294.dhcp.ti.com (uda0510294.dhcp.ti.com [172.24.234.212])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 57JABbiw2552213;
	Tue, 19 Aug 2025 05:11:38 -0500
From: Beleswar Padhi <b-padhi@ti.com>
To: <linux@armlinux.org.uk>, <arnd@arndb.de>
CC: <krzk@kernel.org>, <afd@ti.com>, <u-kumar1@ti.com>, <praneeth@ti.com>,
        <b-padhi@ti.com>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v2] arm: multi_v7_defconfig: Enable more OMAP related configs
Date: Tue, 19 Aug 2025 15:41:37 +0530
Message-ID: <20250819101137.2878336-1-b-padhi@ti.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

This allows us to enable various peripherals in the TI OMAP family
platforms like AM571X-IDK, AM572X-IDK, AM574X-IDK, AM57XX-BEAGLE-X15,
AM57XX-EVM using the multi_v7_defconfig, instead of only with the
OMAP specific defconfigs.

DRM_PANEL_OSD_OSD101T2587_53TS:
Enables OSD LCD panel support used in AM57XX evaluation modules.

SPI_TI_QSPI:
Enables TI's QSPI master controller driver for accessing flash devices
on OMAP5 platforms.

Signed-off-by: Beleswar Padhi <b-padhi@ti.com>
---
v2: Changelog:
1. Enabled only OMAP related configs as modules.
Dropped userspace distribution related configs and other generic ones.

Link to v1:
https://lore.kernel.org/all/20250806141808.4013462-1-b-padhi@ti.com/

 arch/arm/configs/multi_v7_defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
index f2822eeefb95..2b226b0ecaa2 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -453,6 +453,7 @@ CONFIG_SPI_GXP=m
 CONFIG_SPI_GPIO=m
 CONFIG_SPI_FSL_DSPI=m
 CONFIG_SPI_OMAP24XX=y
+CONFIG_SPI_TI_QSPI=m
 CONFIG_SPI_ORION=y
 CONFIG_SPI_PL022=y
 CONFIG_SPI_ROCKCHIP=m
@@ -747,6 +748,7 @@ CONFIG_DRM_PANEL_SIMPLE=y
 CONFIG_DRM_PANEL_EDP=y
 CONFIG_DRM_PANEL_SAMSUNG_LD9040=m
 CONFIG_DRM_PANEL_ORISETECH_OTM8009A=m
+CONFIG_DRM_PANEL_OSD_OSD101T2587_53TS=m
 CONFIG_DRM_PANEL_RAYDIUM_RM68200=m
 CONFIG_DRM_PANEL_SAMSUNG_S6E63J0X03=m
 CONFIG_DRM_PANEL_SAMSUNG_S6E8AA0=m
-- 
2.34.1


