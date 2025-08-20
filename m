Return-Path: <linux-kernel+bounces-777860-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7709AB2DEA6
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 16:05:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 934761BC5517
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 14:02:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE116269D18;
	Wed, 20 Aug 2025 14:02:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bBYYpC0F"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39F292690D1
	for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 14:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755698524; cv=none; b=MKBLHsFEQJWtE4Xauxdnv90sGi9HI1QtAD+rgYstqmSXj9O1Cw9tpxfwGg43Wv0VR2pCTXjUqYsc1hc72u9fyeOAcj9xoT4G9DEVGTZ6CBxbWXn1UKoYxGEind/uTxWGyJ6GcPae4Kjq+AIh3uUYSe4O/ANH9MLv8iOMcybtRHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755698524; c=relaxed/simple;
	bh=7M8WQ93AaEVDFJvrP9tpFEBFhyFY0X5kFY5fADadnZw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Cv4qV0fh2yhTbP86z7lJ+IbkXuVVJCfGQGggqBG2L2hbVPJ7ZR+6Q81VnzprNO+lF4o5fD+0jIWQvOB2ROk1I2MGuwjE7BEPWVBySHvr4TWXDWUlt3D91OfWvNnoJUNisEhkI3Gao7wlEgfIHCukAsikmHTY/e2pLTCUC2z/zII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bBYYpC0F; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75FA5C4CEE7;
	Wed, 20 Aug 2025 14:02:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755698523;
	bh=7M8WQ93AaEVDFJvrP9tpFEBFhyFY0X5kFY5fADadnZw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=bBYYpC0FkTO01ZF0XW2EroYm0Mp+L8HTFnWs0O/Gtl+5EybiJq0oCCqVf7EoLxfl3
	 G+P4KPSucuU0/HxyigbeHZS8oBS5WCh9kyU7IREFbHKX2gr0nZLpCwyDYdH6UrJa0n
	 CTEj0QFokXchz2zC8qaElhkmqGYv0ykzezT/q9keH7KnPsOmdV2ZTIffCslowM8FLz
	 c7cYlKwx8Pi2hXlBWh1qH0dPJPp4j5t4WdpNdt4L1jOCsUCXrdcHsXzx5Ydq7Q+xtx
	 yYFVSmKm8KIc05Joecw91dyaZgutWheFaxB74qFPEaC3O6lrs4CVSBVpE9V6OiIA8L
	 6n+4REYkfc3qg==
From: Maxime Ripard <mripard@kernel.org>
Date: Wed, 20 Aug 2025 16:01:41 +0200
Subject: [PATCH v2 01/14] drm/tidss: dispc: Remove unused OVR_REG_GET
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250820-drm-tidss-field-api-v2-1-43cab671c648@kernel.org>
References: <20250820-drm-tidss-field-api-v2-0-43cab671c648@kernel.org>
In-Reply-To: <20250820-drm-tidss-field-api-v2-0-43cab671c648@kernel.org>
To: Jyri Sarha <jyri.sarha@iki.fi>, 
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Maxime Ripard <mripard@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1128; i=mripard@kernel.org;
 h=from:subject:message-id; bh=7M8WQ93AaEVDFJvrP9tpFEBFhyFY0X5kFY5fADadnZw=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDBlLr/r/bH52w+CrpJBp7naZmG97k+MXr/Xc9qr/gPQ0R
 6MVt4rEO6ayMAhzMsiKKbI8kQk7vbx9cZWD/cofMHNYmUCGMHBxCsBEuPgY65QuS20zyz529NNa
 PZuf39Tz19o0tQfIs+xa4+3++/rH9U2Z/PFVSyTPVfy+rz1rxswSBcaGRpHWn26c1q98zdLO/hG
 TqO96ph6d6/TTae8Ex/j3peJOs1bvSLk7ydH5S/jmLVI3Y0oB
X-Developer-Key: i=mripard@kernel.org; a=openpgp;
 fpr=BE5675C37E818C8B5764241C254BCFC56BF6CE8D

The OVR_REG_GET function in the dispc driver is not used anywhere. Let's
drop it.

Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
 drivers/gpu/drm/tidss/tidss_dispc.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/drivers/gpu/drm/tidss/tidss_dispc.c b/drivers/gpu/drm/tidss/tidss_dispc.c
index 975d94547c3f9d5e9ad61aefd4eeb8ada8874cb0..8ec06412cffa71512cead9725bb43440258eb1ec 100644
--- a/drivers/gpu/drm/tidss/tidss_dispc.c
+++ b/drivers/gpu/drm/tidss/tidss_dispc.c
@@ -666,17 +666,10 @@ static void VP_REG_FLD_MOD(struct dispc_device *dispc, u32 vp, u32 idx, u32 val,
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


