Return-Path: <linux-kernel+bounces-782074-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E9438B31AA7
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 16:05:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2A54FA06376
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 14:00:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8FD6304BC1;
	Fri, 22 Aug 2025 13:57:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="c7Cjx71j";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="coZaT6+1"
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2306D3074BE
	for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 13:57:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.104.207.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755871053; cv=none; b=sSW2PyabE2MOzDSXlFtqP3nqpe2rPPznt4Ra+V+NhBm7+zhe2sMlchrF78Jmm+IVbFhyCWLR/Q0XFbNs6bmkbH2ze8Sbd9YAJ1GDpMV24Ie6w5wOOWdlU810OJnY/zrqHks9rlbzzLmGLD4RUnVrTqBRZtjLn6Q864YRRTOazYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755871053; c=relaxed/simple;
	bh=zCCSy0o35JvAI7QafSxpydH2hzoK0y79MPd+2j4OwW0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nwN8kN/StVifslsqXgJ7+KzGCdhnFyWp/1Yo4XsvPLkGivddZl+kITmiZXMHWe+2oRq9/fOP/dMBNYrUgFyMcW0ooSZf2P3iVcsgrIQGNxsSv9KqxyIEwWJXyo6EU6fqCtu74DKkj9Ihl2/IcLbcJARbwCdo53m81VwmZkLjvUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b=c7Cjx71j; dkim=fail (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=coZaT6+1 reason="key not found in DNS"; arc=none smtp.client-ip=93.104.207.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1755871051; x=1787407051;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=9n/naAKcBCNNY+t9a5vJJ7PI9f1fYi7nwTRgic5hZFg=;
  b=c7Cjx71jAcmaqDyqxP25MEIcXnW4EKKxSsO07Ax+IDH5J2bm58n25ztx
   eTlegmZ96jlUTSAPQ93z5bG4eRt6+RJFvttI/jDCrRR1/i+b2IURNpBDL
   C8SZFI+4OuRoRQwxJCn+ei5JhA+rQdFjHh/M76yp8oqhBHiaXSxqmA8eq
   uILa2I2KCvitIlBRpdMSRSIPaMEh0Uw3IXU9bDfpbj0/SfylkBVGTIp3m
   ix5fV40HiN3z31cy4CL9nZLrikHPXpYAXx0Q/tQYzTb/s9Ew3bj75WjPC
   S7aejuonxc7wNJpOPi5PjeonZMKZ5NQ6IESp9Hql69oxz/F1UYYYfqISh
   w==;
X-CSE-ConnectionGUID: JKVv52hjTCGPr31HoOYi9A==
X-CSE-MsgGUID: 0Ixf0lb7QBKCT3RAt1aU2Q==
X-IronPort-AV: E=Sophos;i="6.17,309,1747692000"; 
   d="scan'208";a="45868445"
Received: from vmailcow01.tq-net.de ([10.150.86.48])
  by mx1.tq-group.com with ESMTP; 22 Aug 2025 15:57:27 +0200
X-CheckPoint: {68A87747-0-820F521C-C7779E56}
X-MAIL-CPID: E1AE969BEAE425E55620FADF3E35DF18_4
X-Control-Analysis: str=0001.0A00210E.68A8769F.000E,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 79A8416462D;
	Fri, 22 Aug 2025 15:57:22 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ew.tq-group.com;
	s=dkim; t=1755871042; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding; bh=9n/naAKcBCNNY+t9a5vJJ7PI9f1fYi7nwTRgic5hZFg=;
	b=coZaT6+1llALA9Baw1AWaB0ssP8Dg1+xnD1pjqaOsGmdomdMEnc2PJGDmx8osO3fjR8/YQ
	e30NfqHz4kkrY1azSk9x0khEctHIFZT4K378dzK9HtVrFPROdqqAFyMh/8CIvBlQQQf46e
	uXD5WPawv1HMDHvUpE1aoMNIsInSaa/+cq++fk3G0nl9GKAc9kW9v14NpnGfD2Cv+HVw5V
	z2f6AJbb8OzsXa8v1D0ZslArziwum4jUmL/hznldevKy5TvEH4RU4uD/ymyGx4uAx0sNxl
	dDgrrny5Y6UPsxFXtk/jUxVaWyuA2vGlxMsItyOnycFLxp9IgrIYSZvIqzxs2g==
From: Alexander Stein <alexander.stein@ew.tq-group.com>
To: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Fabio Estevam <festevam@gmail.com>,
	Sascha Hauer <s.hauer@pengutronix.de>
Cc: Alexander Stein <alexander.stein@ew.tq-group.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev,
	Pengutronix Kernel Team <kernel@pengutronix.de>
Subject: [PATCH v3 1/1] arm64: defconfig: Enable Marvell WiFi-Ex USB driver
Date: Fri, 22 Aug 2025 15:57:14 +0200
Message-ID: <20250822135715.3335023-1-alexander.stein@ew.tq-group.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

MBa91xxCA (imx93-tqma9352-mba91xxca.dts) features a USB attached WiFi
module. lsusb says:
 ID 1286:204e Marvell Semiconductor, Inc. Bluetooth and Wireless LAN Composite Device
Enable the corresponding driver.

To: Shawn Guo <shawnguo@kernel.org>
To: Fabio Estevam <festevam@gmail.com>
To: Sascha Hauer <s.hauer@pengutronix.de>
Cc: imx@lists.linux.dev
Cc: Pengutronix Kernel Team <kernel@pengutronix.de>
Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
---
Changes in v3:
* Improved commit message

 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 603c9528c778d..4535a3e5a7560 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -441,6 +441,7 @@ CONFIG_IWLMVM=m
 CONFIG_MWIFIEX=m
 CONFIG_MWIFIEX_SDIO=m
 CONFIG_MWIFIEX_PCIE=m
+CONFIG_MWIFIEX_USB=m
 CONFIG_MT7921E=m
 CONFIG_RSI_91X=m
 CONFIG_WL18XX=m
-- 
2.43.0


