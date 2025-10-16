Return-Path: <linux-kernel+bounces-856264-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F5EABE3AC3
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 15:22:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id EFEB0502E68
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 13:22:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9676630506E;
	Thu, 16 Oct 2025 13:22:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=thundersoft.com header.i=@thundersoft.com header.b="PeRvnqFx"
Received: from mail-m49239.qiye.163.com (mail-m49239.qiye.163.com [45.254.49.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A2FC1E5B73;
	Thu, 16 Oct 2025 13:22:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760620948; cv=none; b=Wm1cNVvE20rXWnjDSuu+zFdFtIWRbGkbbpDbcENAWb6owmy7BIWkzlEDgzziXFg4nM4erZX84iC+Nmqr1t2IX6JhgiLElgwgc49WJyVwjjAIYQTdD3IWHv8TQePdjNXWesg0aZ0cEP2j+3CCNZiMhlTo+6QI41cx8QK2j0FHLXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760620948; c=relaxed/simple;
	bh=rxEd+0JBkFw8qMczxjE0SyJrkwGZaBCVs+xPIpp4iB0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=th0CAH0Z4jQdsBDwfJTBOxBjJkKLLy8JYGZQCLkgme1OgavOOeHINXPIItqzAht5ntfSZTz5qIkCottoqFEfiQ6ursCcHiAKTdPbqb3hVkAd1f/XGMhkWKMkz1UAG88N3HUcSi74Vu0FHVVhF2jakwrAYNi0QAeC1A92YB3/Rio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=thundersoft.com; spf=pass smtp.mailfrom=thundersoft.com; dkim=pass (1024-bit key) header.d=thundersoft.com header.i=@thundersoft.com header.b=PeRvnqFx; arc=none smtp.client-ip=45.254.49.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=thundersoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=thundersoft.com
Received: from albert-OptiPlex-7080.. (unknown [117.184.129.134])
	by smtp.qiye.163.com (Hmail) with ESMTP id 26265957a;
	Thu, 16 Oct 2025 20:06:42 +0800 (GMT+08:00)
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
Subject: [PATCH v5 3/6] arm64: Kconfig: add ARCH_BST for Black Sesame Technologies SoCs
Date: Thu, 16 Oct 2025 20:05:55 +0800
Message-ID: <20251016120558.2390960-4-yangzh0906@thundersoft.com>
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
X-HM-Tid: 0a99ecea4cb109cckunm98a0ee061283a
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVkZSx9IVkpDHxhCTh1LGkwaHVYVFAkWGhdVEwETFh
	oSFyQUDg9ZV1kYEgtZQVlKSkxVSkNPVUpJQlVKSE9ZV1kWGg8SFR0UWUFZT0tIVUpLSEpOTE5VSk
	tLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=PeRvnqFxOosBECcstfsShRbjQR2lQV0eRGa/35ZIsIhLUw6SMIj2KL4gg+HQ0vtbAPj0LtJFoZrpLrPISDGVxAGZ9hUZWffZqJPcij2RVTFZo0/IAX1pozDf7kb/92tQRVgmdEQGmKNb/G76qr1EooiWCVbw52OLv0XMIQeg+Dc=; s=default; c=relaxed/relaxed; d=thundersoft.com; v=1;
	bh=NTiFMa0um5MCx7YKz9M9UL5FTlU26BokizDRovnOdsQ=;
	h=date:mime-version:subject:message-id:from;

Add ARCH_BST configuration option to enable support for Black Sesame
Technologies SoC family. BST produces automotive-grade system-on-chips
for intelligent driving, focusing on computer vision and AI capabilities.
The BST C1200 family includes SoCs for ADAS and autonomous driving
applications.

Signed-off-by: Albert Yang <yangzh0906@thundersoft.com>
---
Changes for v4:
- remove Signed-off-by: Ge Gordon

Changes for v3:
- Reword subject from "for bst silicons" to "for Black Sesame Technologies
SoCs"
- drop unrelated whitespace hunk

Changes for v2:
- Placed the configuration entry in correct alphabetical order
- Used generic family name (ARCH_BST) instead of SoC-specific naming
- Followed upstream kernel naming and description conventions
---
 arch/arm64/Kconfig.platforms | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm64/Kconfig.platforms b/arch/arm64/Kconfig.platforms
index 13173795c43d..0ef07343cc3d 100644
--- a/arch/arm64/Kconfig.platforms
+++ b/arch/arm64/Kconfig.platforms
@@ -119,6 +119,14 @@ config ARCH_BLAIZE
 	help
 	  This enables support for the Blaize SoC family
 
+config ARCH_BST
+	bool "Black Sesame Technologies SoC Family"
+	help
+	  This enables support for Black Sesame Technologies (BST) SoC family.
+	  BST produces automotive-grade system-on-chips for intelligent driving,
+	  focusing on computer vision and AI capabilities. The BST C1200 family
+	  includes SoCs for ADAS and autonomous driving applications.
+
 config ARCH_CIX
 	bool "Cixtech SoC family"
 	help
-- 
2.43.0


