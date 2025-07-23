Return-Path: <linux-kernel+bounces-742264-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 58E83B0EF54
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 12:08:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1B2197B9860
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 10:05:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66F5428F53F;
	Wed, 23 Jul 2025 10:05:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="OTQZQRe+"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D77028D844
	for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 10:05:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753265146; cv=none; b=lcDEVzPDi6AloO/NcFBwfoXxPui9qioumPSTdB/Pp+ITFf2nzWbEV/ksBinkywf186EDF4v+7ROVGlGMbHdfcGCrqHXAP8gBUGLHMYscB/agAKXjcMVyW+rzjcTzxslyGAoFzrxJCoCLSShckENs+guIEJp9/86k99BLR2y8FW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753265146; c=relaxed/simple;
	bh=9P0ZS+LOE91FSs5KuTmn6c1+z0gltGmsa74PXoQ3bjk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TKI7hg7frB/HG8z2+Sqy9m7Npn2fjITcwTFmaBLlDYLv63PVOclV1SWJelwd8tsFRwxKNbxDf1i3Z6IqtmeJFd/Cb5i21H+jbHVsmTJyyvaocX/mpl4uQVJXoc6FNZUXK5LZ16W/PBhw+I0tJeXSym8yogeRLafwnygLiXIRSaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=OTQZQRe+; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from [127.0.1.1] (91-158-153-178.elisa-laajakaista.fi [91.158.153.178])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 4733D105D;
	Wed, 23 Jul 2025 12:05:02 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1753265103;
	bh=9P0ZS+LOE91FSs5KuTmn6c1+z0gltGmsa74PXoQ3bjk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=OTQZQRe+Xe+jKkNDpMRy5sxjKXIQUHoNoaI2hJLCzfHO/1lNHytQ2jQqt/LCiHrko
	 Jo06mc2PyCukPcM1NnxGND//qfmozq+Eda6Xvdtj75/1gFa6/3k5VnU8aBg0OGHUID
	 N+SYcWAe4VIEF/X0Ej5IxvIYjglTWLwANlIRkOUA=
From: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Date: Wed, 23 Jul 2025 13:05:10 +0300
Subject: [PATCH v5 04/15] drm/bridge: cdns-dsi: Remove extra line at the
 end of the file
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250723-cdns-dsi-impro-v5-4-e61cc06074c2@ideasonboard.com>
References: <20250723-cdns-dsi-impro-v5-0-e61cc06074c2@ideasonboard.com>
In-Reply-To: <20250723-cdns-dsi-impro-v5-0-e61cc06074c2@ideasonboard.com>
To: Jyri Sarha <jyri.sarha@iki.fi>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Vinod Koul <vkoul@kernel.org>, Kishon Vijay Abraham I <kishon@kernel.org>, 
 Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Jayesh Choudhary <j-choudhary@ti.com>, Dmitry Baryshkov <lumag@kernel.org>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 linux-phy@lists.infradead.org, Francesco Dolcini <francesco@dolcini.it>, 
 Aradhya Bhatia <aradhya.bhatia@linux.dev>, 
 Devarsh Thakkar <devarsht@ti.com>, 
 Parth Pancholi <parth.pancholi@toradex.com>, 
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
X-Mailer: b4 0.15-dev-c25d1
X-Developer-Signature: v=1; a=openpgp-sha256; l=884;
 i=tomi.valkeinen@ideasonboard.com; h=from:subject:message-id;
 bh=9P0ZS+LOE91FSs5KuTmn6c1+z0gltGmsa74PXoQ3bjk=;
 b=owEBbQKS/ZANAwAIAfo9qoy8lh71AcsmYgBogLPqIKG6ZTR7VyLLHdtlX7FYBGXGqO//0OqRU
 YmIjx1q5OyJAjMEAAEIAB0WIQTEOAw+ll79gQef86f6PaqMvJYe9QUCaICz6gAKCRD6PaqMvJYe
 9V1nD/430OXS6nFDACJLmouxzWxEu6HLEJDi80lXm2GNRdJ3R9XfGF8M300rc7mcXYViMspfHiG
 YvLpYOvxgI30bZnMgHbIUvCChv7/H7ZZ55OEAcY6aWEUwZBt2dVND/d4QRLFxnEVg/ejh2RqvbP
 2nybPvZ5F8cUx8Sg599WzRP4HxCcHUKC68EceID2J022c5yT7n/MplOdmBq135QJypDe+chUqLI
 3bw8i2Iywk3oIf5PeYx3S5bYAUTEINS3KuiilkUTnZssuvRyew8Bv7TCV3vJ32OncS1QJTnw91B
 J+SaGbruWiUDU3SnKm05JY07Poyt64ibY4IIlpth0Z7sIrDuzRxFuBgCSVVROZKFsx7Dtm7tHGo
 KfSh2yIimdqqVL+fw1u3yvpLocx31IWzWm08qPNn2YYmSEE4BNMFt5jgkMtftIh/TPXJ5Bi+N64
 OLgKF4Z1bxnR1+0rurDlEqCnJl40YNAVwatpqZTMwZtdedkhXbY6IaMTI4BNXdwth/dbtCpF/It
 AVGOGei0OsG3SWHiomcm5ufcckeCroNsycVWkegiwQtSvk7oRJGJn0piJl24BVpHgD0Qo8rvHsk
 a2bx/aQeydTcHBT2/Ysvbp1WKI9+U2QcYizKtOqM8BHNynHZoFUbJZtxTR/yGVroYC73SZZ7diE
 /rn4w7kd8eaUMhg==
X-Developer-Key: i=tomi.valkeinen@ideasonboard.com; a=openpgp;
 fpr=C4380C3E965EFD81079FF3A7FA3DAA8CBC961EF5

Remove extra line at the end of the file.

Reviewed-by: Aradhya Bhatia <aradhya.bhatia@linux.dev>
Tested-by: Parth Pancholi <parth.pancholi@toradex.com>
Tested-by: Jayesh Choudhary <j-choudhary@ti.com>
Reviewed-by: Devarsh Thakkar <devarsht@ti.com>
Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
---
 drivers/gpu/drm/bridge/cadence/cdns-dsi-core.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpu/drm/bridge/cadence/cdns-dsi-core.c b/drivers/gpu/drm/bridge/cadence/cdns-dsi-core.c
index 695b6246b280..0c7ad05b6e53 100644
--- a/drivers/gpu/drm/bridge/cadence/cdns-dsi-core.c
+++ b/drivers/gpu/drm/bridge/cadence/cdns-dsi-core.c
@@ -1442,4 +1442,3 @@ MODULE_AUTHOR("Boris Brezillon <boris.brezillon@bootlin.com>");
 MODULE_DESCRIPTION("Cadence DSI driver");
 MODULE_LICENSE("GPL");
 MODULE_ALIAS("platform:cdns-dsi");
-

-- 
2.43.0


