Return-Path: <linux-kernel+bounces-736013-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2019EB096A1
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 23:59:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 358A94E84DE
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 21:58:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8524B241690;
	Thu, 17 Jul 2025 21:58:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="S2AwcGSc"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43C6123F271;
	Thu, 17 Jul 2025 21:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752789503; cv=none; b=MazOfdwAb+3KY8yd3hMrNrHk9uXYvo2tEwVufQO8fUDRE1zJtGUP5ky9IVFmZPNJm6IFdqwp3n+6xKhUaOPnJVMnOfDEQOGwbZEonVOA2Glk4V265as5Sd99Dz0+QsX6X3aQE9RkAnzZeIEzI6n3PeZqIuItQNhC/ae8RfG/+eU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752789503; c=relaxed/simple;
	bh=UlmKtimZv0mcncJupvIcvhzZK8a2K3i6JEcDqY2dLcI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qSUDx1U4NW39d1m+d4YjN6lXavkDCH/2chZZDjozQFWLEbj/ujkw6nIopEUnFp6YBAHHTW2thw11TpFfgX75EgxuD+XTz4K4FtrdPxP98qhsxWspheHkaUYzp1Tph4RQf190VdiRDu8TO5IZnzz11441qrE514kwqbXYqTNUJ60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=S2AwcGSc; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1752789497;
	bh=UlmKtimZv0mcncJupvIcvhzZK8a2K3i6JEcDqY2dLcI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=S2AwcGSch9VmhIqBfQr+dxXo8YLlc7vsvClliBhOved3g8jBVDPsCtC4ecPqfbwjX
	 1Zc1FiPhfmG1rTfckPRxmFIyzDHdHmgh2k38kKm2CfYFxYGLSRTuhAWyKmKoXYgwp+
	 /YM1vVyb1DnB9L49OdVQL+RsIfpuyhcdFxUk+eZM0ug+kQFTuIzw7dMqpfeePPyZXi
	 3yie/F7qElt+pAba4BACU00rzRKpUnJk5mRwiVMhdJPsLdkE6WEdB/UAWSJsSPBrwP
	 Lq12L2+kyy2UufpXDEiDa7uakQLuNkBcMTRqLDGdXFc4P0Bf17rHDF+B2mFLPc3/jv
	 jsHp4i1EElFMw==
Received: from trenzalore.hitronhub.home (unknown [23.233.251.139])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: detlev)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 706DA17E1562;
	Thu, 17 Jul 2025 23:58:14 +0200 (CEST)
From: Detlev Casanova <detlev.casanova@collabora.com>
To: linux-kernel@vger.kernel.org
Cc: Andrzej Hajda <andrzej.hajda@intel.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Robert Foss <rfoss@kernel.org>,
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
	Jonas Karlman <jonas@kwiboo.se>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
	Detlev Casanova <detlev.casanova@collabora.com>,
	Douglas Anderson <dianders@chromium.org>,
	Heiko Stuebner <heiko@sntech.de>,
	Sugar Zhang <sugar.zhang@rock-chips.com>,
	Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
	Charles Keepax <ckeepax@opensource.cirrus.com>,
	Raag Jadav <raag.jadav@intel.com>,
	dri-devel@lists.freedesktop.org,
	linux-sound@vger.kernel.org,
	kernel@collabora.com
Subject: [PATCH 3/3] drm/bridge: synopsys: Do not warn about audio params computation
Date: Thu, 17 Jul 2025 17:56:20 -0400
Message-ID: <20250717215620.288651-4-detlev.casanova@collabora.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250717215620.288651-1-detlev.casanova@collabora.com>
References: <20250717215620.288651-1-detlev.casanova@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There is no need to warn about non pre-computed values, just change it to
dbg.

Signed-off-by: Detlev Casanova <detlev.casanova@collabora.com>
---
 drivers/gpu/drm/bridge/synopsys/dw-hdmi-qp.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/bridge/synopsys/dw-hdmi-qp.c b/drivers/gpu/drm/bridge/synopsys/dw-hdmi-qp.c
index 7d3d7b5084c8d..0571d604d8aa3 100644
--- a/drivers/gpu/drm/bridge/synopsys/dw-hdmi-qp.c
+++ b/drivers/gpu/drm/bridge/synopsys/dw-hdmi-qp.c
@@ -276,8 +276,7 @@ static unsigned int dw_hdmi_qp_find_n(struct dw_hdmi_qp *hdmi, unsigned long pix
 	if (n > 0)
 		return n;
 
-	dev_warn(hdmi->dev, "Rate %lu missing; compute N dynamically\n",
-		 pixel_clk);
+	dev_dbg(hdmi->dev, "Rate %lu missing; compute N dynamically\n", pixel_clk);
 
 	return dw_hdmi_qp_compute_n(hdmi, pixel_clk, sample_rate);
 }
-- 
2.50.1


