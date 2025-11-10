Return-Path: <linux-kernel+bounces-893408-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C038C474BF
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 15:44:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DB552188F9A3
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 14:44:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9D91314A9E;
	Mon, 10 Nov 2025 14:43:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="lfh4Z9gI"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72A74313E25
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 14:43:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762785837; cv=none; b=BvZUAsaRm5+vQLk2sB3k/HlzvwHkw5AWQ38Kl2Bh+Sl0TEYGlWZBTLcg2ZT7GMkWugbUbrLsjPrdC0kTiclP8YKLF0R81XgMkSGG6S0OSb3cINxaosEPVvASLDSrs3Nk5LQxF+OonY4K4o/0mSXuhmuwxfSsalg/VN9aoObDdJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762785837; c=relaxed/simple;
	bh=lfiqMlE05HIqJSJ5GitMNg6uvw07EQ2vR98Wo+GNhrg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dJ18et6reE8OhoNRA3viELxAgFNGFJZ5k5/wfGUQY6CY6PCscF0Sxhc4Hi/R57CWcKCmb20gLbsq9NbYkBBnapbR5ECZbwcIOsc1h24Wp3t+vqq512ibpxV40tcfsSHhd+PCV6HI8YCJ0uMr2rPhaMioeHlOJibv8GFXRBMitCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=lfh4Z9gI; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1762785833;
	bh=lfiqMlE05HIqJSJ5GitMNg6uvw07EQ2vR98Wo+GNhrg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lfh4Z9gIeIk6MUJlQ0H6aJo39DWueYdXDOKNSnGEwOMtlia1o4jOEhkM6u3PZp72S
	 RaXCa65XJljS9wWYoBUF+Qtmp8w0HXGjJSN0yRZzsoxJviVAlzcBpwQu5zYlRrq8Oa
	 skaSVCyDFkZIp6w8jQsSp10PzSUCkVGEUjCrW0wfBh02uACOIsiz8QGQZqLAn8PycZ
	 QIVn5cEoh8vsquHuQuoiI9fpC8jRvf9msw1b42nCvoY7bHSdK6yA4A55SFfja137Xk
	 gbXDLKp+nbJZjggsmTUIzli3CX+gHCAojNht4l8CO/bb+rTKYFPTawRKSNtV9l/si0
	 3b5DC15Rwewfg==
Received: from localhost.localdomain (unknown [92.206.121.173])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: gerddie)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 7547D17E130A;
	Mon, 10 Nov 2025 15:43:53 +0100 (CET)
From: gert.wollny@collabora.com
To: Christian Gmeiner <christian.gmeiner@gmail.com>
Cc: Lucas Stach <l.stach@pengutronix.de>,
	Russell King <linux+etnaviv@armlinux.org.uk>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	etnaviv@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Gert Wollny <gert.wollny@collabora.com>
Subject: [PATCH v4 3/5] drm/etnaviv: Add a new function to emit a series of states to cmd stream
Date: Mon, 10 Nov 2025 15:37:49 +0100
Message-ID: <20251110144625.18653-4-gert.wollny@collabora.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251110144625.18653-1-gert.wollny@collabora.com>
References: <20250630202703.13844-1-gert.wollny@collabora.com>
 <20251110144625.18653-1-gert.wollny@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Gert Wollny <gert.wollny@collabora.com>

v2: fix formatting and remove superfluous masking (Lucas)

Signed-off-by: Gert Wollny <gert.wollny@collabora.com>
---
 drivers/gpu/drm/etnaviv/etnaviv_buffer.h | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/gpu/drm/etnaviv/etnaviv_buffer.h b/drivers/gpu/drm/etnaviv/etnaviv_buffer.h
index ae1ba1db6c8a..9388a686edcf 100644
--- a/drivers/gpu/drm/etnaviv/etnaviv_buffer.h
+++ b/drivers/gpu/drm/etnaviv/etnaviv_buffer.h
@@ -43,6 +43,19 @@ static inline void CMD_LOAD_STATE(struct etnaviv_cmdbuf *buffer, u32 reg,
 	OUT(buffer, value);
 }
 
+static inline void CMD_LOAD_STATES_START(struct etnaviv_cmdbuf *buffer, u32 reg,
+					 u32 nvalues)
+{
+	u32 index = reg >> VIV_FE_LOAD_STATE_HEADER_OFFSET__SHR;
+
+	buffer->user_size = ALIGN(buffer->user_size, 8);
+
+	/* write a register via cmd stream */
+	OUT(buffer, VIV_FE_LOAD_STATE_HEADER_OP_LOAD_STATE |
+			    VIV_FE_LOAD_STATE_HEADER_OFFSET(index) |
+			    VIV_FE_LOAD_STATE_HEADER_COUNT(nvalues));
+}
+
 static inline void CMD_END(struct etnaviv_cmdbuf *buffer)
 {
 	buffer->user_size = ALIGN(buffer->user_size, 8);
-- 
2.51.0


