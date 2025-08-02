Return-Path: <linux-kernel+bounces-753931-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 17238B18A1A
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Aug 2025 03:42:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9E25B1C27297
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Aug 2025 01:42:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CC8F78F51;
	Sat,  2 Aug 2025 01:41:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ethancedwards.com header.i=@ethancedwards.com header.b="SGNbONkT"
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 252732AD11;
	Sat,  2 Aug 2025 01:41:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.161
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754098912; cv=none; b=JcqyzEGZJO6Fb6nTUqGrn/XGDzPYSTNKkjUFJjU618JfTaodPJC0RIgpSGAhP+dlay0R9P606vvO6jnF9I8pyf4gQRxNWuyEO8ZhUN3KCcpLv/MKfW8q9tWmP7iO3dibrJ4nx6Xhb3LcOfNhkWbWu2TSejNB9gsWRXmP2vQc4OM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754098912; c=relaxed/simple;
	bh=tzPbGNY/HtNHNCn/spEV2iQKJagDaRpg4U+Fv4M44/o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=px2Y8r/nP4+mLLQXHrH3mNLYwd4USVdjSCe3u5fC9nly7c7riCHhj7pYHz0g/x8B7CA58PSRi8fUkiuAXToMXpxq8fL9Qb0nHoszvvWgEifGvmSGwFi2PS0nL8I/Waa8TwYtTUChn1t0la48sDb9NRlalpwN2/81hLZa/uP76bY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ethancedwards.com; spf=pass smtp.mailfrom=ethancedwards.com; dkim=pass (2048-bit key) header.d=ethancedwards.com header.i=@ethancedwards.com header.b=SGNbONkT; arc=none smtp.client-ip=80.241.56.161
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ethancedwards.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ethancedwards.com
Received: from smtp102.mailbox.org (smtp102.mailbox.org [IPv6:2001:67c:2050:b231:465::102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4bv5CG2YH0z9sNZ;
	Sat,  2 Aug 2025 03:41:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ethancedwards.com;
	s=MBO0001; t=1754098906;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=hC33MpvR7EnAum2rPEi+BrxfSU2s+0/kfdHWysXARnw=;
	b=SGNbONkTIJ3xq0bJkKblq7p6wXInscD86UVia9dEBidHpbsISkPqYLmgQ43YWKOHswxW2r
	2NIY+0WCd8Ufk0J62tYyd4kIROw9a7N1C0jdFx4GOPmYx+I2KXWViXY/QtxrpCug6DbG6n
	XIJyb65POgKRytjYriWfak3aHbkgXHJS/eV09Bnh5MEZeDp/Tbbm9iprGrCBBxt8T4ZTJl
	WSDpcRdC5oOzY/1Faa8vGAoyn64GxYT0PkXTb7ZSzMvEr7MASFTMJKvm9MLuDBOckMihRN
	GXM6HbrQeX/bMoOiITD8dCzMDizRN6xqhFklTcCuPZg6z60+/KgQFgcElKsRAA==
Authentication-Results: outgoing_mbo_mout;
	dkim=none;
	spf=pass (outgoing_mbo_mout: domain of ethan@ethancedwards.com designates 2001:67c:2050:b231:465::102 as permitted sender) smtp.mailfrom=ethan@ethancedwards.com
From: Ethan Carter Edwards <ethan@ethancedwards.com>
Date: Fri, 01 Aug 2025 21:41:42 -0400
Subject: [PATCH] drm/amdgpu/gfx10: remove redundant repeated null checks
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250801-amdgfx10-v1-1-e1dcbe18d84e@ethancedwards.com>
X-B4-Tracking: v=1; b=H4sIANVsjWgC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDCwND3cTclPS0CkMD3TRLs2QT4+Qkg2RTSyWg8oKi1LTMCrBR0bG1tQA
 mRLYJWgAAAA==
X-Change-ID: 20250801-amdgfx10-f96c43cb0c59
To: Alex Deucher <alexander.deucher@amd.com>, 
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org, 
 Ethan Carter Edwards <ethan@ethancedwards.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1786;
 i=ethan@ethancedwards.com; h=from:subject:message-id;
 bh=tzPbGNY/HtNHNCn/spEV2iQKJagDaRpg4U+Fv4M44/o=;
 b=LS0tLS1CRUdJTiBQR1AgTUVTU0FHRS0tLS0tCgpvd0o0bkp2QXk4ekFKWGJEOXFoNThlVGp6e
 GhQcXlVeFpQVG1YTi8xbXVjcjA3SW0wM2VUL2orcWVkQWtxTDZnCko5bEZZT2sySjY1dXFjT0Zz
 VE02U2xrWXhMZ1laTVVVV2Y3bktLYzkxSnloc1BPdlN4UE1IRllta0NFTVhKd0MKTUpHZ1N3ei9
 5OE1mZnJHTGRYMXkxaTVLYzZYdXlROEJPaHZ1cDcvVWZyNHYzY1ExYk9kZFQ0Yi9vVnRLR2VSdQ
 ptMDh2OHVDUkNwMjhlb1AvbTZSNHNZOU5pNjd2Wm4zR0k5UFBEQUFaUDA0bQo9bHgySQotLS0tL
 UVORCBQR1AgTUVTU0FHRS0tLS0tCg==
X-Developer-Key: i=ethan@ethancedwards.com; a=openpgp;
 fpr=2E51F61839D1FA947A7300C234C04305D581DBFE
X-Rspamd-Queue-Id: 4bv5CG2YH0z9sNZ

The repeated checks on grbm_soft_reset are unnecessary. Remove them.

Signed-off-by: Ethan Carter Edwards <ethan@ethancedwards.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 24 +++++++++++-------------
 1 file changed, 11 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
index 7bd506f06eb155de7f2edb2c1c9d5ed7232b16fc..264183ab24ec299425e6a6d0539339ee69f60c24 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -7668,19 +7668,17 @@ static int gfx_v10_0_soft_reset(struct amdgpu_ip_block *ip_block)
 		/* Disable MEC parsing/prefetching */
 		gfx_v10_0_cp_compute_enable(adev, false);
 
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
change-id: 20250801-amdgfx10-f96c43cb0c59

Best regards,
-- 
Ethan Carter Edwards <ethan@ethancedwards.com>


