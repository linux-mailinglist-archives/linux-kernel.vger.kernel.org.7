Return-Path: <linux-kernel+bounces-862994-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F7EABF6C02
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 15:25:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E921F5431D2
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 13:24:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0928633769C;
	Tue, 21 Oct 2025 13:23:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="FUQkomKk"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF8CA33711B
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 13:23:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761053025; cv=none; b=Qdl5IbXAwuEnEU/fVgSPlNjEmSnbz7tolV9xZwj8PeXwZzyYtOZmndHh5AzclfitvLszhI7i7379hWPzwQsuBf7R21Ym1eRz6jhjURemOF4eWuwN6U+IY3QEP2y7/aWF4iCSLFmmOYPINTuybYopJCVFVy+I2CghelqE28kb1oI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761053025; c=relaxed/simple;
	bh=XaG+d9fyiObtuju/o63OkE/MbTOIX8VL9vbdw30zwBg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=B1l77AE90hzaGY13uHg/kNy++JXh1RhrRev/ijkZv8bDxB0XuUW0e0Lprx7nPKzjoxTxqfXkVHJDe1ezkirm0BZaMKSjiTGMn2+TbSWhn5UFOp1ak/MdMAkaklAgyZ4FBDgRwuBnkgOlH+TkWA05daIga0lVoC9ldraEum8ZvVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=FUQkomKk; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from [127.0.1.1] (91-158-153-178.elisa-laajakaista.fi [91.158.153.178])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id C1E31134C;
	Tue, 21 Oct 2025 15:21:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1761052911;
	bh=XaG+d9fyiObtuju/o63OkE/MbTOIX8VL9vbdw30zwBg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=FUQkomKkkzInbOxkR6auwFwdH3RDJjEGfkKgDTbh2CgAhJZVXgvfgBb5RFo4NAp+v
	 zqRgxzXFQlgMhfvlm4kb44rE3LFc72vwTn2i74EBB5l0Dv023/kitvXxOap/TDqNMM
	 FSKjoUI68dIN5bLnkWN1GRR8XeL0DNNGTgoVpfqI=
From: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Date: Tue, 21 Oct 2025 16:23:01 +0300
Subject: [PATCH 5/7] drm/bridge: tc358768: Add LP mode command support
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251021-tc358768-v1-5-d590dc6a1a0c@ideasonboard.com>
References: <20251021-tc358768-v1-0-d590dc6a1a0c@ideasonboard.com>
In-Reply-To: <20251021-tc358768-v1-0-d590dc6a1a0c@ideasonboard.com>
To: Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Parth Pancholi <parth.pancholi@toradex.com>, 
 Francesco Dolcini <francesco.dolcini@toradex.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
X-Mailer: b4 0.15-dev-c25d1
X-Developer-Signature: v=1; a=openpgp-sha256; l=1403;
 i=tomi.valkeinen@ideasonboard.com; h=from:subject:message-id;
 bh=XaG+d9fyiObtuju/o63OkE/MbTOIX8VL9vbdw30zwBg=;
 b=owEBbQKS/ZANAwAIAfo9qoy8lh71AcsmYgBo94lPpZjx7puBa7b/dTW+Lp6esax/BZQXma3ol
 dKK2bsJAnKJAjMEAAEIAB0WIQTEOAw+ll79gQef86f6PaqMvJYe9QUCaPeJTwAKCRD6PaqMvJYe
 9V5vD/4ugHbVnRj7DUD1toPiJp2291oLERPBL55aAUV+Vb9TG2lFog+92wvQdscY2CBTOM+j0lr
 5usGlAkhjvja3HxcVa3FKh1knl2WEi1t8TvoNjPzAqVvcYuT+Hpqpewr6dOqO5VcgdQHUXB0rDB
 Mo0X8bGeGpLcSE412cw3resvs1pusq/TkJ9LxRTuO2bAcP3rcgXQNZLDbGprblAwazNu7j/Nshd
 dtHHfEU6m5YoIXZWEeW+0M49ZgRj9mwIfkVqeseHGtntp2ksoHsFlQsalBqyXkKSYDDFc+n7KY7
 XlfJzCHl5uLApEyat48ajlNfZYXNKZV1jWU8nUbSby+NtrBaTV/gpA8wdKRzj8Re9bx3W3bgfE8
 s+vVMBMzmqM91n5/KLBnPE866vTCaMzFoyRUAd76ccFie0JFZfUXbxwFpSZra7mOoWTYuGXCmnB
 /lscnrMmbwD1sAZJoLR2YXiQ8NKheD/Gdaq+Mx8pQWGp3T3LrjO2uNcJY5f8UfYdqO/J9KGlrWf
 uFxzBZO6MNqCauvF3BeeXjbrcxb2R8/PljtGG8iEusnWxpU/uMMf+xw40ONlCZq/mIBXxWxvr6O
 Uddkr1Sm2NFJXTF/WNCtSkJVVVzXi4FjKpAqGqcnRvskDcfKckrRrz5aPQKzxqd0+pgIUbidiKX
 fPbmARBuGR0W8Pw==
X-Developer-Key: i=tomi.valkeinen@ideasonboard.com; a=openpgp;
 fpr=C4380C3E965EFD81079FF3A7FA3DAA8CBC961EF5

Currently the driver ignores MIPI_DSI_MODE_LPM and always uses HS mode.
Add code to enable HS mode in pre_enable() only if MIPI_DSI_MODE_LPM is
not set, and always enable HS mode in enable() for video transmission.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
---
 drivers/gpu/drm/bridge/tc358768.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/bridge/tc358768.c b/drivers/gpu/drm/bridge/tc358768.c
index a276fbc75dde..a7a14c125ac4 100644
--- a/drivers/gpu/drm/bridge/tc358768.c
+++ b/drivers/gpu/drm/bridge/tc358768.c
@@ -1091,7 +1091,8 @@ static void tc358768_bridge_atomic_pre_enable(struct drm_bridge *bridge,
 	/* Configure DSI_Control register */
 	val = (dsi_dev->lanes - 1) << 1;
 
-	val |= TC358768_DSI_CONTROL_TXMD;
+	if (!(dsi_dev->mode_flags & MIPI_DSI_MODE_LPM))
+		val |= TC358768_DSI_CONTROL_TXMD;
 
 	if (!(dsi_dev->mode_flags & MIPI_DSI_CLOCK_NON_CONTINUOUS))
 		val |= TC358768_DSI_CONTROL_HSCKMD;
@@ -1123,6 +1124,11 @@ static void tc358768_bridge_atomic_enable(struct drm_bridge *bridge,
 		return;
 	}
 
+	/* Enable HS mode for video TX */
+	tc358768_confw_update_bits(priv, TC358768_DSI_CONTROL,
+				   TC358768_DSI_CONTROL_TXMD,
+				   TC358768_DSI_CONTROL_TXMD);
+
 	/* clear FrmStop and RstPtr */
 	tc358768_update_bits(priv, TC358768_PP_MISC, 0x3 << 14, 0);
 

-- 
2.43.0


