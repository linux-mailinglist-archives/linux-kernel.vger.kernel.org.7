Return-Path: <linux-kernel+bounces-752339-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C989B1744E
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 17:53:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8AA8E1C2682E
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 15:53:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7EDF206F27;
	Thu, 31 Jul 2025 15:53:08 +0000 (UTC)
Received: from srv01.abscue.de (abscue.de [89.58.28.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AEE21E32BE;
	Thu, 31 Jul 2025 15:53:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.58.28.240
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753977188; cv=none; b=CKehzR1jKjUnPXBQGAKBUdiDHDw88U1AKkoVbiaCNYdL4x2NOdzkI/mo1OrcjNLWgiPstgWpHFJvOg+q8OtzHjq1Rb+aLWBAfQe8GkY1h48Ggl0e6Sw+sgQKpeFdF25qDdF+g7abz7R/6CzIMkVujuPraT7e7kMCdDn/yZP0LOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753977188; c=relaxed/simple;
	bh=Ev82jqwZV2jAuZD42PHmuYbopywGwmUQ530yBjB+MkY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Hq9UsnXCdGohy1ixqkXiXy3lxy1HmZx24nTTPxFD7fdjYh+5R3x6PySxVVmPdjLxG+Ygsfx5OJGsb6m51bxnII/XyXvpnxh6H9/jvjavlFiYgvbydn8tHiWpgEm6H7PlqZ4iejLfbqJVJ/Fz64/uDFHsZ/kYJwT328yh5rdarjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=abscue.de; spf=pass smtp.mailfrom=abscue.de; arc=none smtp.client-ip=89.58.28.240
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=abscue.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=abscue.de
Received: from srv01.abscue.de (localhost [127.0.0.1])
	by spamfilter.srv.local (Postfix) with ESMTP id 652401C2750;
	Thu, 31 Jul 2025 17:53:01 +0200 (CEST)
X-Spam-Level: 
Received: from fluffy-mammal.metal.fwg-cag.de (unknown [IPv6:2001:9e8:cdc9:0:1347:874c:9851:58c6])
	by srv01.abscue.de (Postfix) with ESMTPSA id 388081C2715;
	Thu, 31 Jul 2025 17:53:00 +0200 (CEST)
From: =?utf-8?q?Otto_Pfl=C3=BCger?= <otto.pflueger@abscue.de>
Date: Thu, 31 Jul 2025 17:51:27 +0200
Subject: [PATCH v3 14/16] drm: sprd: do not access IOMMU registers
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250731-ums9230-drm-v3-14-06d4f57c4b08@abscue.de>
References: <20250731-ums9230-drm-v3-0-06d4f57c4b08@abscue.de>
In-Reply-To: <20250731-ums9230-drm-v3-0-06d4f57c4b08@abscue.de>
To: David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Orson Zhai <orsonzhai@gmail.com>, 
 Baolin Wang <baolin.wang@linux.alibaba.com>, 
 Chunyan Zhang <zhang.lyra@gmail.com>, Kevin Tang <kevin.tang@unisoc.com>, 
 Liviu Dudau <Liviu.Dudau@arm.com>, 
 Russell King <rmk+kernel@arm.linux.org.uk>, Eric Anholt <eric@anholt.net>, 
 Kevin Tang <kevin3.tang@gmail.com>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 =?utf-8?q?Otto_Pfl=C3=BCger?= <otto.pflueger@abscue.de>
X-Mailer: b4 0.14.2

Changing the IOMMU registers results in conflicts with the sprd_iommu
driver. Remove all references to IOMMU registers in the graphics driver.

Signed-off-by: Otto Pflüger <otto.pflueger@abscue.de>
---
 drivers/gpu/drm/sprd/sprd_dpu.c | 14 --------------
 1 file changed, 14 deletions(-)

diff --git a/drivers/gpu/drm/sprd/sprd_dpu.c b/drivers/gpu/drm/sprd/sprd_dpu.c
index b946d015133db44d2d3d0b18803ed887b2b7ae2e..acf28de3fd08edaad03f01104f3e6cc7c243123c 100644
--- a/drivers/gpu/drm/sprd/sprd_dpu.c
+++ b/drivers/gpu/drm/sprd/sprd_dpu.c
@@ -55,14 +55,6 @@
 #define REG_DPI_H_TIMING	0x1F4
 #define REG_DPI_V_TIMING	0x1F8
 
-/* MMU control registers */
-#define REG_MMU_EN			0x800
-#define REG_MMU_VPN_RANGE		0x80C
-#define REG_MMU_PPN1			0x83C
-#define REG_MMU_RANGE1			0x840
-#define REG_MMU_PPN2			0x844
-#define REG_MMU_RANGE2			0x848
-
 /* Global control bits */
 #define BIT_DPU_RUN			BIT(0)
 #define BIT_DPU_STOP			BIT(1)
@@ -410,12 +402,6 @@ static void sprd_dpu_init(struct sprd_dpu *dpu)
 	u32 dpu_version = readl(ctx->base + REG_DPU_VERSION);
 
 	writel(0x00, ctx->base + REG_BG_COLOR);
-	writel(0x00, ctx->base + REG_MMU_EN);
-	writel(0x00, ctx->base + REG_MMU_PPN1);
-	writel(0xffff, ctx->base + REG_MMU_RANGE1);
-	writel(0x00, ctx->base + REG_MMU_PPN2);
-	writel(0xffff, ctx->base + REG_MMU_RANGE2);
-	writel(0x1ffff, ctx->base + REG_MMU_VPN_RANGE);
 
 	if (ctx->if_type == SPRD_DPU_IF_DPI) {
 		/* use dpi as interface */

-- 
2.50.0

