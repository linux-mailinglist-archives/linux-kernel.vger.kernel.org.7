Return-Path: <linux-kernel+bounces-753930-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 475A2B18A18
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Aug 2025 03:38:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D06B91C842A4
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Aug 2025 01:39:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EA4C6F53E;
	Sat,  2 Aug 2025 01:38:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ethancedwards.com header.i=@ethancedwards.com header.b="2BUzz0mP"
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17DFC139D;
	Sat,  2 Aug 2025 01:38:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754098713; cv=none; b=PLqxQhnxMao0ihdk1DYsnMsA7O1BOVI1bcecXR/N6+6+QynI0LKH6BGunt9CVOIPxLQrkP6L3A5/hUnEpCeUp4mIiQcLY+EN8OonBX6K8D7dBUKIKc+oCZvkE71OJjER65YsdYx1NOmL87WoVvmS1PJbCWUZGHSZseoZ+qo9grw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754098713; c=relaxed/simple;
	bh=xDkwf/R7sAObhLKaY0pjx6MvG2RHtOr1vU7eBDGzsac=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=EHwG8y1bwpTBS+VhTWknkQiXNbISqoJE9NZSGVgaSVaCQJq7txF2gu7g9H8HsCDkOEYjE2PZ1z2K/UwDpDKhVgZKr4SNyHF9sUSZzkbOmErbWtJlFoExrONxthVbbkiZKFa6jvpVLOS8XC3f9RLWWasQTvH29JzpC4uowvtvyeA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ethancedwards.com; spf=pass smtp.mailfrom=ethancedwards.com; dkim=pass (2048-bit key) header.d=ethancedwards.com header.i=@ethancedwards.com header.b=2BUzz0mP; arc=none smtp.client-ip=80.241.56.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ethancedwards.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ethancedwards.com
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4bv57K4DLnz9sjY;
	Sat,  2 Aug 2025 03:38:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ethancedwards.com;
	s=MBO0001; t=1754098701;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=rfkrPveYvBWrUoTk+3x/Gm8/fAfhVxdSxnNmYta/3AU=;
	b=2BUzz0mPfFRiv93fjREkLONE/LzphDg6i7cdTQJ1TfqY5dBgTlidYiCn0RUwkI9PKiJXSi
	0yLtcy/IiblkuDSV3H8HiAcbQQGYv5eaiBkTdTQ/Ha+351EuUs0xgMzYJMunWAlSaCRr8O
	sRMzt7yGtAaBOIfcbu0JEBcLoNNtyE2BV+h0kmCLdUmyXzBYAIr6Ym8BwyRFOUfcEk86Gv
	EYh7HVmKUyBfNpc+kwV4wVf6gT3cYZeLetcQpX81EBS9toAOzSOAqrcH/f03+rdyqlWhjh
	OlH/WWf+djA0dkZpY6gvk4o6W0oIbMjap8sRtc1j9ROrc8ULXue9TfAn6KE1lg==
From: Ethan Carter Edwards <ethan@ethancedwards.com>
Date: Fri, 01 Aug 2025 21:38:16 -0400
Subject: [PATCH] drm/amdgpu/gfx9.4.3: remove redundant repeated null checks
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250801-uartlite-redundant-v1-1-6141b97a3c7f@ethancedwards.com>
X-B4-Tracking: v=1; b=H4sIAAdsjWgC/x3MTQqAIBBA4avErBMsyqSrRAt/xhoIi9EiiO6et
 PwW7z2QkAkTjNUDjBcl2mNBU1fgVhMXFOSLoZVtL7VsxGk4b5RRMPozehOzcJ2zKujBWqWhhAd
 joPufTvP7fpSTyuRkAAAA
X-Change-ID: 20250801-uartlite-redundant-c4cb6f87bb68
To: Alex Deucher <alexander.deucher@amd.com>, 
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org, 
 Ethan Carter Edwards <ethan@ethancedwards.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1960;
 i=ethan@ethancedwards.com; h=from:subject:message-id;
 bh=xDkwf/R7sAObhLKaY0pjx6MvG2RHtOr1vU7eBDGzsac=;
 b=LS0tLS1CRUdJTiBQR1AgTUVTU0FHRS0tLS0tCgpvd0o0bkp2QXk4ekFKWGJEOXFoNThlVGp6e
 GhQcXlVeFpQVG1jQmpWU2Mydlh2ajdoaFpIbTRVZTc4Nm02d2ZtClhxMTg4RnRsM3pSbW9kUHRY
 dVVkcFN3TVlsd01zbUtLTFA5emxOTWVhczVRMlBuWHBRbG1EaXNUeUJBR0xrNEIKbU1pL013ei9
 2VUl1bUI1Y0ZtWEx3N2EyemtIajR2TFpsL2VWNXoxZy91ZitnaXM3K09kZkpVYUdiU3lOemFvYw
 pCb3JiZ3hPRDUvTHNNZm44UXJBdjIreFIwTVBzYTg4WUhzcHhBd0R3cmt0QQo9VTJpcAotLS0tL
 UVORCBQR1AgTUVTU0FHRS0tLS0tCg==
X-Developer-Key: i=ethan@ethancedwards.com; a=openpgp;
 fpr=2E51F61839D1FA947A7300C234C04305D581DBFE

The repeated checks on grbm_soft_reset are unnecessary. Remove them.

Signed-off-by: Ethan Carter Edwards <ethan@ethancedwards.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c | 24 +++++++++++-------------
 1 file changed, 11 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
index 51babf5c78c86c20ef806e31e9d0a4185ffda5b8..8ba66d4dfe86e96073f63e259177ca0ca2416a6d 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
@@ -2461,19 +2461,17 @@ static int gfx_v9_4_3_soft_reset(struct amdgpu_ip_block *ip_block)
 		/* Disable MEC parsing/prefetching */
 		gfx_v9_4_3_xcc_cp_compute_enable(adev, false, 0);
 
-		if (grbm_soft_reset) {
-			tmp = RREG32_SOC15(GC, GET_INST(GC, 0), regGRBM_SOFT_RESET);
-			tmp |= grbm_soft_reset;
-			dev_info(adev->dev, "GRBM_SOFT_RESET=0x%08X\n", tmp);
-			WREG32_SOC15(GC, GET_INST(GC, 0), regGRBM_SOFT_RESET, tmp);
-			tmp = RREG32_SOC15(GC, GET_INST(GC, 0), regGRBM_SOFT_RESET);
-
-			udelay(50);
-
-			tmp &= ~grbm_soft_reset;
-			WREG32_SOC15(GC, GET_INST(GC, 0), regGRBM_SOFT_RESET, tmp);
-			tmp = RREG32_SOC15(GC, GET_INST(GC, 0), regGRBM_SOFT_RESET);
-		}
+		tmp = RREG32_SOC15(GC, GET_INST(GC, 0), regGRBM_SOFT_RESET);
+		tmp |= grbm_soft_reset;
+		dev_info(adev->dev, "GRBM_SOFT_RESET=0x%08X\n", tmp);
+		WREG32_SOC15(GC, GET_INST(GC, 0), regGRBM_SOFT_RESET, tmp);
+		tmp = RREG32_SOC15(GC, GET_INST(GC, 0), regGRBM_SOFT_RESET);
+
+		udelay(50);
+
+		tmp &= ~grbm_soft_reset;
+		WREG32_SOC15(GC, GET_INST(GC, 0), regGRBM_SOFT_RESET, tmp);
+		tmp = RREG32_SOC15(GC, GET_INST(GC, 0), regGRBM_SOFT_RESET);
 
 		/* Wait a little for things to settle down */
 		udelay(50);

---
base-commit: b9ddaa95fd283bce7041550ddbbe7e764c477110
change-id: 20250801-uartlite-redundant-c4cb6f87bb68

Best regards,
-- 
Ethan Carter Edwards <ethan@ethancedwards.com>


