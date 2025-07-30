Return-Path: <linux-kernel+bounces-750410-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CCD7B15B0F
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 10:58:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 86C9418C08E7
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 08:58:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 296B0293457;
	Wed, 30 Jul 2025 08:57:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IeRfxubk"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84913293C76
	for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 08:57:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753865844; cv=none; b=ST0yRvKRnkC/F+GimwKlnXDld5PMB/CNwDMkS2CFZig+BqeLjsh+39KEm7Z8EuXsfUpNg1HTyme7fbfmaQLaDuFcPDCKRY5bahOZlvVtxUD1WSgPcg6VMUhx494BbrKtqUEvoWChtQp6GjzIX48Ku5EuIbwZGR0rK64hBxqitmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753865844; c=relaxed/simple;
	bh=w27UoqUceMQEYOVXBT40nQLYhN3aneD/BafQ1QuXRhE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=eiomYnw5104iCcajIM8BV80lTMxKiFPfEjr0xb7+sZ6lamtB9W4+OB2TEL1sc7sscGLXwznGj8fBmjdSMic38J5h3EgJeV7sW9WGyAMoxaE99bxE14vPK+1Jl+rsWlRka7Ik9EPRABjV9RmDhCCA0v7LKgQD7wdXJAPikXV2UhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IeRfxubk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00987C4CEF8;
	Wed, 30 Jul 2025 08:57:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753865844;
	bh=w27UoqUceMQEYOVXBT40nQLYhN3aneD/BafQ1QuXRhE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=IeRfxubkqu4oxCBCwwetWWfBurhzTe+I5K5H3PULR5TpgEs5pDN14Q1Lw78amLSLM
	 Acs3AaTQ35tLjmqjlytUAy46ev+xvO9IvcTg6Wy7E95kY3chcsyvn3v+FWHSR2ACME
	 dOUr+B9p8ktpODQ8A9FZU8i9W9Jc1p29a2u+698VEUY+QP5/Us6elinR+TAxpGWBGj
	 H/9B0OabvgjLUs0XZN/GcH5URkvUMBM8GcTWso/qQGlN0UjhE6zZKWllC+OcwpB05u
	 rwpZdZMUGJekcy4meX86BaaP6csaeWqdLA7GkEcrKw5LAO51fbGk2kjqcuBPmEwe4n
	 wgl09sTdmsS3g==
From: Maxime Ripard <mripard@kernel.org>
Date: Wed, 30 Jul 2025 10:57:04 +0200
Subject: [PATCH 04/14] drm/tidss: dispc: Get rid of FLD_GET
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250730-drm-tidss-field-api-v1-4-a71ae8dd2782@kernel.org>
References: <20250730-drm-tidss-field-api-v1-0-a71ae8dd2782@kernel.org>
In-Reply-To: <20250730-drm-tidss-field-api-v1-0-a71ae8dd2782@kernel.org>
To: Jyri Sarha <jyri.sarha@iki.fi>, 
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Maxime Ripard <mripard@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2296; i=mripard@kernel.org;
 h=from:subject:message-id; bh=w27UoqUceMQEYOVXBT40nQLYhN3aneD/BafQ1QuXRhE=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDBmd9xK/JR/mvPhui2Zes3Dkaad/7F9FimVXJJVd5lHfp
 Rl6qPdIx1QWBmFOBlkxRZYnMmGnl7cvrnKwX/kDZg4rE8gQBi5OAZjIxK2MDX8O9y8oVFbyYvu0
 9iPLw/c+uZLBNubvXmSEpNk/YO9Ie8rzaev5n++5Wz79zgw7Y8M/l7E+NM31hFGTgVPFudIeq1c
 90w8ETTa+/fOr60WRvRplz4WZNT3nftFewfOmVeHn21/3pP4DAA==
X-Developer-Key: i=mripard@kernel.org; a=openpgp;
 fpr=BE5675C37E818C8B5764241C254BCFC56BF6CE8D

The FLD_GET function is an equivalent to what FIELD_GET + GENMASK
provide, so let's drop it and switch to the latter.

Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
 drivers/gpu/drm/tidss/tidss_dispc.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/tidss/tidss_dispc.c b/drivers/gpu/drm/tidss/tidss_dispc.c
index 7e36f5af666342dc4f5fa9159d829d88362de18c..974387313632cc85fb6c4d559b4d35656b1119da 100644
--- a/drivers/gpu/drm/tidss/tidss_dispc.c
+++ b/drivers/gpu/drm/tidss/tidss_dispc.c
@@ -612,23 +612,18 @@ void tidss_disable_oldi(struct tidss_device *tidss, u32 hw_videoport)
 static u32 FLD_VAL(u32 val, u32 start, u32 end)
 {
 	return FIELD_PREP(GENMASK(start, end), val);
 }
 
-static u32 FLD_GET(u32 val, u32 start, u32 end)
-{
-	return (val & GENMASK(start, end)) >> end;
-}
-
 static u32 FLD_MOD(u32 orig, u32 val, u32 start, u32 end)
 {
 	return (orig & ~GENMASK(start, end)) | FLD_VAL(val, start, end);
 }
 
 static u32 REG_GET(struct dispc_device *dispc, u32 idx, u32 start, u32 end)
 {
-	return FLD_GET(dispc_read(dispc, idx), start, end);
+	return FIELD_GET(GENMASK(start, end), dispc_read(dispc, idx));
 }
 
 static void REG_FLD_MOD(struct dispc_device *dispc, u32 idx, u32 val,
 			u32 start, u32 end)
 {
@@ -637,11 +632,12 @@ static void REG_FLD_MOD(struct dispc_device *dispc, u32 idx, u32 val,
 }
 
 static u32 VID_REG_GET(struct dispc_device *dispc, u32 hw_plane, u32 idx,
 		       u32 start, u32 end)
 {
-	return FLD_GET(dispc_vid_read(dispc, hw_plane, idx), start, end);
+	return FIELD_GET(GENMASK(start, end),
+			 dispc_vid_read(dispc, hw_plane, idx));
 }
 
 static void VID_REG_FLD_MOD(struct dispc_device *dispc, u32 hw_plane, u32 idx,
 			    u32 val, u32 start, u32 end)
 {
@@ -651,11 +647,11 @@ static void VID_REG_FLD_MOD(struct dispc_device *dispc, u32 hw_plane, u32 idx,
 }
 
 static u32 VP_REG_GET(struct dispc_device *dispc, u32 vp, u32 idx,
 		      u32 start, u32 end)
 {
-	return FLD_GET(dispc_vp_read(dispc, vp, idx), start, end);
+	return FIELD_GET(GENMASK(start, end), dispc_vp_read(dispc, vp, idx));
 }
 
 static void VP_REG_FLD_MOD(struct dispc_device *dispc, u32 vp, u32 idx, u32 val,
 			   u32 start, u32 end)
 {

-- 
2.50.1


