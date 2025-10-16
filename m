Return-Path: <linux-kernel+bounces-856163-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id F1C52BE3480
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 14:13:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E6571506547
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 12:12:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51B8E32A3FD;
	Thu, 16 Oct 2025 12:12:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=thundersoft.com header.i=@thundersoft.com header.b="H6z9Sgmv"
Received: from mail-m49229.qiye.163.com (mail-m49229.qiye.163.com [45.254.49.229])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99758327797;
	Thu, 16 Oct 2025 12:12:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.229
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760616728; cv=none; b=qGJLgSS1DU+/SlHO8WLAJy0mCpMOh0O9lZqTjohntBu+gCHJhqlEGIIWNJpVBSxM3uLetdckx946qhVI3d1qqlELnFe9A7hBuGUIuGG3ow8+iCSW9ABnoih73qcEKsdjGj+1A/R9O2HQo4ShX9ZICFRxe+T80BED3vjWexIhdig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760616728; c=relaxed/simple;
	bh=olkBCbQnXe3lHI85ko2cYkbDktrNik8z0qgQeQfqMpg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jpA65boJFJj6ejhY/S8s2bkFVMaijRDsHo6hjw5AiCY+EAIBQTSjgWnwxmL05wtJm5mIouEki0YHs6rdA4q8euAzWGuwgiR1KgQrz/JLUmrojPV71KW/aPXTdODtMEnpqxDT3mhLDZUI3Ao+NgawwKEb5Z/QoVQPWvV0HsipL7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=thundersoft.com; spf=pass smtp.mailfrom=thundersoft.com; dkim=pass (1024-bit key) header.d=thundersoft.com header.i=@thundersoft.com header.b=H6z9Sgmv; arc=none smtp.client-ip=45.254.49.229
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=thundersoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=thundersoft.com
Received: from albert-OptiPlex-7080.. (unknown [117.184.129.134])
	by smtp.qiye.163.com (Hmail) with ESMTP id 262659589;
	Thu, 16 Oct 2025 20:06:48 +0800 (GMT+08:00)
From: Albert Yang <yangzh0906@thundersoft.com>
To: krzysztof.kozlowski@linaro.org
Cc: krzk+dt@kernel.org,
	catalin.marinas@arm.com,
	will@kernel.org,
	arnd@arndb.de,
	robh@kernel.org,
	conor+dt@kernel.org,
	gordon.ge@bst.ai,
	bst-upstream@bstai.top,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	ulf.hansson@linaro.org,
	Albert Yang <yangzh0906@thundersoft.com>
Subject: [PATCH v5 5/6] arm64: defconfig: enable BST platform support
Date: Thu, 16 Oct 2025 20:05:57 +0800
Message-ID: <20251016120558.2390960-6-yangzh0906@thundersoft.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251016120558.2390960-1-yangzh0906@thundersoft.com>
References: <20251016120558.2390960-1-yangzh0906@thundersoft.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a99ecea670309cckunm98a0ee061288a
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVkaSE1LVkJOTE0eSh1KTR9KS1YVFAkWGhdVEwETFh
	oSFyQUDg9ZV1kYEgtZQVlKSkxVSkNPVUpJQlVKSE9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0hVSk
	tLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=H6z9Sgmvu2C1R0oPR62LMripRSOW2lVjysP5SKiq8YQn7c8BE3zTzgdVB1nsM/YOm5Y23y6JKrPYpOhLQCfVQAbASHrCJvZ8OR/BquULYWDqiFbNcgHahxx1SUEyS2nwdfoFu/c6je8N6Cr/pDCZh9zv/B0s5/I/a04bD+TidEM=; s=default; c=relaxed/relaxed; d=thundersoft.com; v=1;
	bh=2wYL+QTnahYA8W6BIWbc0y8myOYV1kLbZlxm0xBma04=;
	h=date:mime-version:subject:message-id:from;

Enable support for Black Sesame Technologies (BST) platform
in the ARM64 defconfig:
- CONFIG_ARCH_BST: Enable BST SoC platform support

Signed-off-by: Albert Yang <yangzh0906@thundersoft.com>
---
Changes for v5:
- Remove CONFIG_MMC_SDHCI_BST (MMC patches will be submitted separately)

Changes for v4:
- move CONFIG_MMC_SDHCI_BST before CONFIG_MMC_SDHCI_F_SDH30
- Remove Signed-off-by line for Ge Gordon
- Simplify commit message (remove detailed description about eMMC/SD functionality)

Changes for v3:
- Also enable CONFIG_ARCH_BST in arm64 defconfig (in addition to CONFIG_MMC_SDHCI_BST)

Changes for v2:
- No changes
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index e3a2d37bd104..972cae9bee88 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -47,6 +47,7 @@ CONFIG_ARCH_BCMBCA=y
 CONFIG_ARCH_BRCMSTB=y
 CONFIG_ARCH_BERLIN=y
 CONFIG_ARCH_BLAIZE=y
+CONFIG_ARCH_BST=y
 CONFIG_ARCH_CIX=y
 CONFIG_ARCH_EXYNOS=y
 CONFIG_ARCH_SPARX5=y
-- 
2.43.0


