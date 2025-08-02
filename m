Return-Path: <linux-kernel+bounces-753933-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CE2FB18A20
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Aug 2025 03:46:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 22BB93A9C5D
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Aug 2025 01:45:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C16FE6F53E;
	Sat,  2 Aug 2025 01:45:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ethancedwards.com header.i=@ethancedwards.com header.b="eQRFA9LU"
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EBDD2E36FD;
	Sat,  2 Aug 2025 01:45:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.161
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754099151; cv=none; b=GMFbtHbMn3Tx59arIb9/VGDzOqhhXW+tNu9J5/n6224z9OqzpiZ/TiNZ16+DxQrWNm4c6zwfzUT0AooPsjZYBOcB20VKNRu205Eub/PP/EgZlD6dlqd0Gqs1m2v/kJhsR+XHLZLfQ729uA6D0zpSgl1klzOhr4h56jmfl/RSgzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754099151; c=relaxed/simple;
	bh=wSIMwojZxAeqCqhOtPw3LFtWfkmZDSg728hLzzO3iGg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=dLhcRWIZZ/2Cwz0OaRQbk0YiZFmmBPsNx5yHqhktVR8ZE7iryXXOI5Pzt92o/WBKgjJr72NJ2VMDL81pmP3qWGgnuWT6F5X0+Zi37C8TC0JPsd3vhhq++XifGfMvPP5Wt7RDDUVePFHdvg33brPMY6WwLjkzUy0IetJcxUOfiiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ethancedwards.com; spf=pass smtp.mailfrom=ethancedwards.com; dkim=pass (2048-bit key) header.d=ethancedwards.com header.i=@ethancedwards.com header.b=eQRFA9LU; arc=none smtp.client-ip=80.241.56.161
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ethancedwards.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ethancedwards.com
Received: from smtp1.mailbox.org (smtp1.mailbox.org [IPv6:2001:67c:2050:b231:465::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4bv5Hs6L4Bz9srX;
	Sat,  2 Aug 2025 03:45:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ethancedwards.com;
	s=MBO0001; t=1754099145;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=CpjI4I6Uq8G040F7+g4OD3KACxvNtwDXSXaQIXXONz8=;
	b=eQRFA9LUCoFkzelyoGO+FBD17JtZjzVoqzAjzZtNl/dF32NJql/WJ6XjL5U94pnG0oYiDI
	vDu/pIoQQ2s7N5zDGGdcY6nivksV9GakgFmkd7wES/1i/ZdHkyVgo2hzIx16QmwqojQD3q
	BVhuUxNdqa+rg/150nSip3EwxGLWZs1NiiQOsq8rhVuFF3+UbSS9sIb9UOJqQu5EBskjNB
	OgWPz0XUQOB3qQwDf9Mbt+qUoEkGnA6vVia3/CpjrTGX2o5nmNkL4MjORfEiWErH6VFxlq
	0JaQk1NYt01Ogl5fHHDvfye9CUzXo3YqRf76olZnr3PndUuzCnSyxPV6h+8+xQ==
Authentication-Results: outgoing_mbo_mout;
	dkim=none;
	spf=pass (outgoing_mbo_mout: domain of ethan@ethancedwards.com designates 2001:67c:2050:b231:465::1 as permitted sender) smtp.mailfrom=ethan@ethancedwards.com
From: Ethan Carter Edwards <ethan@ethancedwards.com>
Date: Fri, 01 Aug 2025 21:45:41 -0400
Subject: [PATCH] drm/amdgpu/gfx9: remove redundant repeated null checks
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250801-amdgfxv9-v1-1-0b9670ab5509@ethancedwards.com>
X-B4-Tracking: v=1; b=H4sIAMRtjWgC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDCwND3cTclPS0ijJLXWMDY1NzcxNLc0PzVCWg8oKi1LTMCrBR0bG1tQB
 WQFkTWgAAAA==
X-Change-ID: 20250801-amdgfxv9-30357749717e
To: Alex Deucher <alexander.deucher@amd.com>, 
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org, 
 Ethan Carter Edwards <ethan@ethancedwards.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1779;
 i=ethan@ethancedwards.com; h=from:subject:message-id;
 bh=wSIMwojZxAeqCqhOtPw3LFtWfkmZDSg728hLzzO3iGg=;
 b=LS0tLS1CRUdJTiBQR1AgTUVTU0FHRS0tLS0tCgpvd0o0bkp2QXk4ekFKWGJEOXFoNThlVGp6e
 GhQcXlVeFpQVG1IaE02TnorNktMRWhRRTZWOXdjRDI2bHVlN1dqCko2YUttSmR6bGJTZlZGQVZL
 TzhvWldFUTQyS1FGVk5rK1oram5QWlFjNGJDenI4dVRUQnpXSmxBaGpCd2NRckEKUk56Zk1melB
 uN0JLc2I3b2hGRkZaMkVvbndGSHd4czNxVFY1U1dKdWdRYnhuMWV0djIzR3lOQ1V1ZVQ1dVYrOQ
 oyMi8xL1RYeXVtUmgwWENJNHhrZjkrbEh6NXowWmZ2dTNPTUVBSXF4U2NFPQo9OHROaAotLS0tL
 UVORCBQR1AgTUVTU0FHRS0tLS0tCg==
X-Developer-Key: i=ethan@ethancedwards.com; a=openpgp;
 fpr=2E51F61839D1FA947A7300C234C04305D581DBFE
X-Rspamd-Queue-Id: 4bv5Hs6L4Bz9srX

The repeated checks on grbm_soft_reset are unnecessary. Remove them.

Signed-off-by: Ethan Carter Edwards <ethan@ethancedwards.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c | 24 +++++++++++-------------
 1 file changed, 11 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
index 6a9cf3587cc6f0a0d00ab1c109fd599dd8aa2579..a6ff9a137a83a93cde0b0c9c9e51db66374bcbee 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -4175,19 +4175,17 @@ static int gfx_v9_0_soft_reset(struct amdgpu_ip_block *ip_block)
 		/* Disable MEC parsing/prefetching */
 		gfx_v9_0_cp_compute_enable(adev, false);
 
-		if (grbm_soft_reset) {
-			tmp = RREG32_SOC15(GC, 0, mmGRBM_SOFT_RESET);
-			tmp |= grbm_soft_reset;
-			dev_info(adev->dev, "GRBM_SOFT_RESET=0x%08X\n", tmp);
-			WREG32_SOC15(GC, 0, mmGRBM_SOFT_RESET, tmp);
-			tmp = RREG32_SOC15(GC, 0, mmGRBM_SOFT_RESET);
-
-			udelay(50);
-
-			tmp &= ~grbm_soft_reset;
-			WREG32_SOC15(GC, 0, mmGRBM_SOFT_RESET, tmp);
-			tmp = RREG32_SOC15(GC, 0, mmGRBM_SOFT_RESET);
-		}
+		tmp = RREG32_SOC15(GC, 0, mmGRBM_SOFT_RESET);
+		tmp |= grbm_soft_reset;
+		dev_info(adev->dev, "GRBM_SOFT_RESET=0x%08X\n", tmp);
+		WREG32_SOC15(GC, 0, mmGRBM_SOFT_RESET, tmp);
+		tmp = RREG32_SOC15(GC, 0, mmGRBM_SOFT_RESET);
+
+		udelay(50);
+
+		tmp &= ~grbm_soft_reset;
+		WREG32_SOC15(GC, 0, mmGRBM_SOFT_RESET, tmp);
+		tmp = RREG32_SOC15(GC, 0, mmGRBM_SOFT_RESET);
 
 		/* Wait a little for things to settle down */
 		udelay(50);

---
base-commit: b9ddaa95fd283bce7041550ddbbe7e764c477110
change-id: 20250801-amdgfxv9-30357749717e

Best regards,
-- 
Ethan Carter Edwards <ethan@ethancedwards.com>


