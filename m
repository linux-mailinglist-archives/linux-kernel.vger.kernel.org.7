Return-Path: <linux-kernel+bounces-827968-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 58DF6B938C0
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 01:10:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 946B57AF4FB
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 23:08:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4648821D3E6;
	Mon, 22 Sep 2025 23:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="lJwABXWv"
Received: from relay.smtp-ext.broadcom.com (relay.smtp-ext.broadcom.com [192.19.144.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C7952F49E3;
	Mon, 22 Sep 2025 23:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.19.144.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758582618; cv=none; b=CLrB1ntK0jxnMNCYFsGgpIsIWAWWo7nXfmmxKLNj3UUWLEpmIxFkSIl2maJ57DIZEiJ0C1lmNfjQnRSWlpwZ9RuymFR5/ZoUNaCDn9lvcc0OwR8Vu54rVmUW3uuuBLfHwkHnKpWRR8Co4dkRCBGC6C58qJpEy8Van5TK/AgSx88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758582618; c=relaxed/simple;
	bh=rUoj4tYcG/6wEz/Vqkhc/ccNirLpMOCICMtWHCPHTqg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Ap1BrMOu1Qxg25jCcKgIEaR0JJpr6V/3b01b+fmRaTlgQOicM6Lm1nUuBWYJbgVNcxHm1MuESS5LjuriKITzMYzdJ975Eu7/J3lUel8wQvnkbsTjI0+RLTolHpquEShE0Xjc32xai1JTso0iUBwqWD+KmzCh+2rKptlk11p2jDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=lJwABXWv; arc=none smtp.client-ip=192.19.144.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: from mail-lvn-it-01.broadcom.com (mail-lvn-it-01.lvn.broadcom.net [10.36.132.253])
	by relay.smtp-ext.broadcom.com (Postfix) with ESMTP id 67120C0005E6;
	Mon, 22 Sep 2025 16:00:15 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 relay.smtp-ext.broadcom.com 67120C0005E6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=broadcom.com;
	s=dkimrelay; t=1758582015;
	bh=rUoj4tYcG/6wEz/Vqkhc/ccNirLpMOCICMtWHCPHTqg=;
	h=From:To:Cc:Subject:Date:From;
	b=lJwABXWv2xWER7S5TxKSXrT+QQmAKt63jFB50zTfrwpYhrhFQiHuycpyYTkGynmI2
	 bRhe5LAO4S6nPYqK87Sy02+EnZDDSMEptHJ20hHSoV2WYpYLofp0EQzPOhlm7xTPdg
	 UtqqS312sqhy/sgUUNyz2O7eukIGucIxOky0tapI=
Received: from stbirv-lnx-1.igp.broadcom.net (stbirv-lnx-1.igp.broadcom.net [10.67.48.32])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail-lvn-it-01.broadcom.com (Postfix) with ESMTPSA id 0E0FD18000530;
	Mon, 22 Sep 2025 16:00:15 -0700 (PDT)
From: Florian Fainelli <florian.fainelli@broadcom.com>
To: stable@vger.kernel.org
Cc: gregkh@linuxfoundation.org,
	sashal@kernel.org,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Ray Jui <rjui@broadcom.com>,
	Scott Branden <sbranden@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Russell King <linux@armlinux.org.uk>,
	linux-arm-kernel@lists.infradead.org (moderated list:ARM SUB-ARCHITECTURES),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH stable 6.6] ARM: bcm: Select ARM_GIC_V3 for ARCH_BRCMSTB
Date: Mon, 22 Sep 2025 16:00:12 -0700
Message-Id: <20250922230012.1373936-1-florian.fainelli@broadcom.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

commit 2b28fe75c7dbe7ec322e706eed4622964409e21d upstream

A number of recent Broadcom STB SoCs utilize a GIC-600 interrupt
controller thus requiring the use of the GICv3 driver.

Link: https://lore.kernel.org/r/20240726233414.2305526-1-florian.fainelli@broadcom.com
Signed-off-by: Florian Fainelli <florian.fainelli@broadcom.com>
---
While technically not a bug fix, this allows me to properly build test
6.6 on additional platforms within our test rack. Thanks!

 arch/arm/mach-bcm/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-bcm/Kconfig b/arch/arm/mach-bcm/Kconfig
index 8789d93a7c04..c705bec1410c 100644
--- a/arch/arm/mach-bcm/Kconfig
+++ b/arch/arm/mach-bcm/Kconfig
@@ -186,6 +186,7 @@ config ARCH_BRCMSTB
 	select ARCH_HAS_RESET_CONTROLLER
 	select ARM_AMBA
 	select ARM_GIC
+	select ARM_GIC_V3
 	select ARM_ERRATA_798181 if SMP
 	select HAVE_ARM_ARCH_TIMER
 	select ZONE_DMA if ARM_LPAE
-- 
2.34.1


