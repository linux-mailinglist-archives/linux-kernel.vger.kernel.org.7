Return-Path: <linux-kernel+bounces-752345-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 933D7B17457
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 17:54:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DCE1F7AF826
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 15:53:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE544231856;
	Thu, 31 Jul 2025 15:53:10 +0000 (UTC)
Received: from srv01.abscue.de (abscue.de [89.58.28.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9566C1DF244;
	Thu, 31 Jul 2025 15:53:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.58.28.240
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753977189; cv=none; b=kZGFI+RI2+QKuxr2cp3MWZBd2gSLHI8kVWjATiA5cULwAjzo2AyzfGOhqWW973pGAHE0ZqCEbTxDwRzg8dHmnP3yYREYjlPSDD1f9NCAMF6LBRS7KK6XWUYWAzd9aNY8xHg5zN4DuYi37+hEfhLe3JUXLHT1ckYljxyLkgA8NEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753977189; c=relaxed/simple;
	bh=Ssv+F/VpR5OCJMVx4G+i145J6Os34SXD/KxA/E4mGJI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JOS8+L6hcpDxFG9C+nsFfE0AfBSUyJprCVH5/4YfEPBVB1NeDMbemvJBmndDw+fYr18EyQqjkQ3dwXCQ2FFTE8+5vaWsm6KejRf0XcpwQEnyoO0YsTU7l8oATKyvkfahEQwjsN3OJgfIozn/k+rm8fOzr67UFC5mdwrQO3AM+Wc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=abscue.de; spf=pass smtp.mailfrom=abscue.de; arc=none smtp.client-ip=89.58.28.240
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=abscue.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=abscue.de
Received: from srv01.abscue.de (localhost [127.0.0.1])
	by spamfilter.srv.local (Postfix) with ESMTP id 64FE21C274F;
	Thu, 31 Jul 2025 17:53:01 +0200 (CEST)
X-Spam-Level: 
Received: from fluffy-mammal.metal.fwg-cag.de (unknown [IPv6:2001:9e8:cdc9:0:1347:874c:9851:58c6])
	by srv01.abscue.de (Postfix) with ESMTPSA id 7E4EC1C2728;
	Thu, 31 Jul 2025 17:52:59 +0200 (CEST)
From: =?utf-8?q?Otto_Pfl=C3=BCger?= <otto.pflueger@abscue.de>
Date: Thu, 31 Jul 2025 17:51:26 +0200
Subject: [PATCH v3 13/16] drm: sprd: always initialize DPU registers
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250731-ums9230-drm-v3-13-06d4f57c4b08@abscue.de>
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

When the Unisoc DRM driver is initialized for the first time to display
an image on the screen, reinitialize the display controller properly
instead of relying on the bootloader to have set up a configuration that
also works with this driver.

Signed-off-by: Otto Pflüger <otto.pflueger@abscue.de>
---
 drivers/gpu/drm/sprd/sprd_dpu.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/gpu/drm/sprd/sprd_dpu.c b/drivers/gpu/drm/sprd/sprd_dpu.c
index 978d4947e1bc5cd5b13b1f25719268fa08b77297..b946d015133db44d2d3d0b18803ed887b2b7ae2e 100644
--- a/drivers/gpu/drm/sprd/sprd_dpu.c
+++ b/drivers/gpu/drm/sprd/sprd_dpu.c
@@ -456,6 +456,14 @@ static void sprd_dpu_init(struct sprd_dpu *dpu)
 	}
 
 	writel(int_mask, ctx->base + REG_DPU_INT_EN);
+
+	/*
+	 * The DPU is usually enabled by the bootloader to show
+	 * a splash screen. Stop it here when the kernel initializes
+	 * the display.
+	 */
+	if (!ctx->stopped)
+		sprd_dpu_stop(dpu);
 }
 
 static void sprd_dpu_fini(struct sprd_dpu *dpu)

-- 
2.50.0

