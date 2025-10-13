Return-Path: <linux-kernel+bounces-850272-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B822DBD260A
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 11:52:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1722D3AABF8
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 09:51:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56A412FE56C;
	Mon, 13 Oct 2025 09:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uyLwdb/A"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B584F2FE079
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 09:50:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760349043; cv=none; b=W0y8NPlFOqn60qFv7Ga29XE7lRxIOjmiDbe/6Rur2M5eYvPDWdFrh31ftSmPVrl7HV+kx4aoqS7hw0gpPrwJjomTfwf3Eg71ccLoIX1wLPwglkTYXKCxJv3A2DCjec2dVXSvNUyKXlUzRIILeJnwd1BfBYwhFPaWWEylCl9b/rM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760349043; c=relaxed/simple;
	bh=G09IVMkLTF1+TAKBasMUWHjWKO0zZGCAuiOPC+jFM8g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=T9i9gxogYYQ8VUiMbrE74yO7kBi71fHhV2ncz+N+dDoGG4riwSoGKSmasRO56rI97wqIySm46WXeQZMW52H6ey2dElY54BAswvzG2J2rpKyb9wh78ZeXSmyaR7GGGawcBVXqv4qaQqiUqD4Lv0b8Yr09c0UEODN3gpp/7r4TiiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uyLwdb/A; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DEE0C4CEE7;
	Mon, 13 Oct 2025 09:50:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760349043;
	bh=G09IVMkLTF1+TAKBasMUWHjWKO0zZGCAuiOPC+jFM8g=;
	h=From:To:Cc:Subject:Date:From;
	b=uyLwdb/An3Z0oz+CUZDX+/+A32g9OpcnlSahAAbcMU7U7QZRtUOfT+JHHAfaxOcYk
	 fQqb8ajhqhleOxELcM/AxtezoZi7nPEtJEW2ztHkv6NQjCM9E8uCFhvjHoc/5hjuw+
	 Q6bfoyUsdRlFIUkV+/QIScjzc2KPZG1HM6iX+zKlklGT7V2Wd0xSHcuwVRz/80X2i6
	 e+kIwA3CXpM/5KAMmhbKvIOhBvTRerxu2ioOcxXz7pCtRRADtk9Wp5JwXE3ioe9/X4
	 tIGJM/DFlFZGEknBFiMNXNDKvzgVlT1IKVPcQbSeATbWjhtRgUOWbzw289CUkHAFxW
	 H/V3GvR0Sr+7A==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1v8FCT-0000000039Z-1eO1;
	Mon, 13 Oct 2025 11:50:41 +0200
From: Johan Hovold <johan@kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Florian Fainelli <florian.fainelli@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	linux-kernel@vger.kernel.org,
	Johan Hovold <johan@kernel.org>
Subject: [PATCH] irqchip: Enable compile testing of Broadcom drivers
Date: Mon, 13 Oct 2025 11:50:27 +0200
Message-ID: <20251013095027.12102-1-johan@kernel.org>
X-Mailer: git-send-email 2.49.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There seems to be nothing preventing the Broadcom drivers from being
compile tested so enable that for wider build coverage.

Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/irqchip/Kconfig | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
index a61c6dc63c29..9b7153777688 100644
--- a/drivers/irqchip/Kconfig
+++ b/drivers/irqchip/Kconfig
@@ -151,7 +151,7 @@ config BCM6345_L1_IRQ
 
 config BCM7038_L1_IRQ
 	tristate "Broadcom STB 7038-style L1/L2 interrupt controller driver"
-	depends on ARCH_BRCMSTB || BMIPS_GENERIC
+	depends on ARCH_BRCMSTB || BMIPS_GENERIC || COMPILE_TEST
 	default ARCH_BRCMSTB || BMIPS_GENERIC
 	select GENERIC_IRQ_CHIP
 	select IRQ_DOMAIN
@@ -159,14 +159,14 @@ config BCM7038_L1_IRQ
 
 config BCM7120_L2_IRQ
 	tristate "Broadcom STB 7120-style L2 interrupt controller driver"
-	depends on ARCH_BRCMSTB || BMIPS_GENERIC
+	depends on ARCH_BRCMSTB || BMIPS_GENERIC || COMPILE_TEST
 	default ARCH_BRCMSTB || BMIPS_GENERIC
 	select GENERIC_IRQ_CHIP
 	select IRQ_DOMAIN
 
 config BRCMSTB_L2_IRQ
 	tristate "Broadcom STB generic L2 interrupt controller driver"
-	depends on ARCH_BCM2835 || ARCH_BRCMSTB || BMIPS_GENERIC
+	depends on ARCH_BCM2835 || ARCH_BRCMSTB || BMIPS_GENERIC || COMPILE_TEST
 	default ARCH_BCM2835 || ARCH_BRCMSTB || BMIPS_GENERIC
 	select GENERIC_IRQ_CHIP
 	select IRQ_DOMAIN
-- 
2.49.1


