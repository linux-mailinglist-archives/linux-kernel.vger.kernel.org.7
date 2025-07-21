Return-Path: <linux-kernel+bounces-739698-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B5B7B0C9D8
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 19:39:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6B699167356
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 17:39:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D3372E175E;
	Mon, 21 Jul 2025 17:39:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="CRtEapz+"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46362285075
	for <linux-kernel@vger.kernel.org>; Mon, 21 Jul 2025 17:39:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753119560; cv=none; b=I52Q/fu49duga0IEvYmH55E21AHQbxMvRwitxYkPiHLParHZuBOUjpvp+BI74EW0U0aAoAyHhnHxgplfhsz28OnxJGMjjKgHlf4TI0dOYdHUBz3e3SGmuCcTu7yc5LoYZQaqZHIh2K+wUAhjKNavkfx3lqzT6pIQuahPeppFVjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753119560; c=relaxed/simple;
	bh=FL2EBBa+wSm77LeCRuxbxYL7cW7Y0BEpaYSJV7FVF5A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VV/RxtFOwVEWeGrASPVmUkA8JWXarW25q1bkY5KELXra6poph8tELoDlHK5RxAhRKyH7gBLIh8Rewu8MCC8hMtq7OejXR9Xc8ArgKkAoMdJMTYgk3IrHUSC0ocVVUqnJJGi8LlzlwUcjPlHPvk3hT1RWKxYrbXI1raicw7clBsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=CRtEapz+; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1753119556;
	bh=FL2EBBa+wSm77LeCRuxbxYL7cW7Y0BEpaYSJV7FVF5A=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=CRtEapz+FWAhM5zcEGnvhUmfHhzRnTaKs8ZI48vJaeYGrWyo4Dg9shRY/fW6oGs1w
	 Y+rhdoZG/7ZpqPOzRDNnHGU+6FS1ifZUq/MSTrFIQ1hqcHrHheje9cSSDLXxO2GwGi
	 pkFE6Zlh3uI+xcLhz1qsg4SBEo37GcUIFDh4ZdE9/bvaAmQojVKejrb6XPqvbqxnA3
	 Ufkd06epzR0rq4/xxfDGFaELibMIby99JPKovs2b9RSRJsbJsYijGqLiIZAo6WYSlb
	 slrauUWrPL6p52umvpAnvfI2qlNXlpmY05i9IaIEOjnQXceKSFQGW+T3JM1DvZfTpa
	 x8unM6QfhX8vA==
Received: from localhost (unknown [82.79.138.60])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: cristicc)
	by bali.collaboradmins.com (Postfix) with UTF8SMTPSA id 4460F17E0FC2;
	Mon, 21 Jul 2025 19:39:16 +0200 (CEST)
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Date: Mon, 21 Jul 2025 20:39:04 +0300
Subject: [PATCH 1/5] drm/rockchip: vop2: Add high color depth support
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250721-rk3588-10bpc-v1-1-e95a4abcf482@collabora.com>
References: <20250721-rk3588-10bpc-v1-0-e95a4abcf482@collabora.com>
In-Reply-To: <20250721-rk3588-10bpc-v1-0-e95a4abcf482@collabora.com>
To: Sandy Huang <hjc@rock-chips.com>, 
 =?utf-8?q?Heiko_St=C3=BCbner?= <heiko@sntech.de>, 
 Andy Yan <andy.yan@rock-chips.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>
Cc: kernel@collabora.com, dri-devel@lists.freedesktop.org, 
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, 
 linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.2

Take the bits per color channel into consideration when computing DCLK
rate.

Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
---
 drivers/gpu/drm/rockchip/rockchip_drm_vop2.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c b/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c
index 186f6452a7d359f079662bc580850929632ea8fe..a714bcbb02de16267e7febbaeb1eb270c70aaef2 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c
@@ -1731,6 +1731,9 @@ static void vop2_crtc_atomic_enable(struct drm_crtc *crtc,
 		clock *= 2;
 	}
 
+	if (vcstate->output_bpc > 8)
+		clock = DIV_ROUND_CLOSEST(clock * vcstate->output_bpc, 8);
+
 	vop2_vp_write(vp, RK3568_VP_MIPI_CTRL, 0);
 
 	/*

-- 
2.50.0


