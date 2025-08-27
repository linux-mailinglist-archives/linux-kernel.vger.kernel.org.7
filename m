Return-Path: <linux-kernel+bounces-788528-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D826B385E4
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 17:13:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 75B955E6DE7
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 15:12:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA051275AF4;
	Wed, 27 Aug 2025 15:12:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SMbVdFR/"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51970275105
	for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 15:12:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756307568; cv=none; b=ru4irycREHmYmQ1J9kW7drbSWtxx8ZdQUPX2ND2IKsdrJeTF9Fhod25lxoQ2Azsp/xjcccNdc6HVS3iOPZ2ic6mQ96Vm3dLMFZMU+mYYb7ySKa9DtPksapJQDRQSaTIwzj6w5MLR6y92ldgdJBuMxPjlBNE0x5fEZJhAOjKc798=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756307568; c=relaxed/simple;
	bh=TOyEj6XtI89c72jvHNqBo0jjmqIBf/MzWhGVwim4FCA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YKaEHTTEaCqs4t3XyoWoJwfKZaam4w9iX28WLMm5hjE+i4X1Vh5S1NdtZ6J8cXzFJbkGCQt1mmiK9EsSILjro7K9nNeskJ6x7ZddOJAFe7DLLjaEvHTka4FgCKNE+ctjnSd1pkyTgW5V284AJ5mZYL+LZhaZSzorSOYieqWa6C4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SMbVdFR/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84361C4CEF0;
	Wed, 27 Aug 2025 15:12:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756307566;
	bh=TOyEj6XtI89c72jvHNqBo0jjmqIBf/MzWhGVwim4FCA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=SMbVdFR/6HYBUUiHSEEqS/ABonhocWVWP3tF4zIhH8zlV4KKPRkhcMgU793wICR0n
	 gRA6s2/7p3bPgszUEchZWoyxS69jbSwBiTBCmaijbbKcMKF2PHtqYeNBEGYhlvkYfC
	 tT43iHO2JCnTZJy+82eUxeIQFPxuK+oV9j4EvDH66GBcnePXYr0354oLdcNmODYHym
	 Wlos7ZGrukh1K9qW39iXWnz9bmBjLx+ECZV1WcJ1dF8dPsR0116beDk6KTxWGl7gK6
	 gwi00NbMh/qb8NdNPU5g9Z/ZY+7GueiJYIbrnNwpthEPf6fSoGg2zDZsHaD/E2cHyc
	 s8Z2O8IPSQ7Cg==
From: Maxime Ripard <mripard@kernel.org>
Date: Wed, 27 Aug 2025 17:12:32 +0200
Subject: [PATCH v3 01/14] drm/tidss: dispc: Remove unused OVR_REG_GET
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250827-drm-tidss-field-api-v3-1-7689b664cc63@kernel.org>
References: <20250827-drm-tidss-field-api-v3-0-7689b664cc63@kernel.org>
In-Reply-To: <20250827-drm-tidss-field-api-v3-0-7689b664cc63@kernel.org>
To: Jyri Sarha <jyri.sarha@iki.fi>, 
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Maxime Ripard <mripard@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1128; i=mripard@kernel.org;
 h=from:subject:message-id; bh=TOyEj6XtI89c72jvHNqBo0jjmqIBf/MzWhGVwim4FCA=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDBnrFZLn7fRdlB5lHbnM2f8IQ617x7xkV+O7TMufXNk9I
 3Guze+pHVNZGIQ5GWTFFFmeyISdXt6+uMrBfuUPmDmsTCBDGLg4BWAifMGMDfu0bsmVec8VV0p7
 ISvNYxNrdCmw8drCzXycRvdUxBZceFEhPHXLcrWcKYzPZ7TZareeYWx4m6699vSJC4o5G+Se2KR
 KuOrZTta9yrDDdqdV6vyGD2L5uU+3NmwPj4mySSyruRDeawAA
X-Developer-Key: i=mripard@kernel.org; a=openpgp;
 fpr=BE5675C37E818C8B5764241C254BCFC56BF6CE8D

The OVR_REG_GET function in the dispc driver is not used anywhere. Let's
drop it.

Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
 drivers/gpu/drm/tidss/tidss_dispc.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/drivers/gpu/drm/tidss/tidss_dispc.c b/drivers/gpu/drm/tidss/tidss_dispc.c
index 3f6cff2ab1b29b43638eb62d4ead36f7fe07486f..71031c3ad60e5a2c99a9a0981c85d246a1a42dc6 100644
--- a/drivers/gpu/drm/tidss/tidss_dispc.c
+++ b/drivers/gpu/drm/tidss/tidss_dispc.c
@@ -651,17 +651,10 @@ static void VP_REG_FLD_MOD(struct dispc_device *dispc, u32 vp, u32 idx, u32 val,
 {
 	dispc_vp_write(dispc, vp, idx, FLD_MOD(dispc_vp_read(dispc, vp, idx),
 					       val, start, end));
 }
 
-__maybe_unused
-static u32 OVR_REG_GET(struct dispc_device *dispc, u32 ovr, u32 idx,
-		       u32 start, u32 end)
-{
-	return FLD_GET(dispc_ovr_read(dispc, ovr, idx), start, end);
-}
-
 static void OVR_REG_FLD_MOD(struct dispc_device *dispc, u32 ovr, u32 idx,
 			    u32 val, u32 start, u32 end)
 {
 	dispc_ovr_write(dispc, ovr, idx,
 			FLD_MOD(dispc_ovr_read(dispc, ovr, idx),

-- 
2.50.1


