Return-Path: <linux-kernel+bounces-860356-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 662AABEFF04
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 10:28:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 1172C348260
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 08:28:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA2EF2F291B;
	Mon, 20 Oct 2025 08:26:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="UbhZz0bX"
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64D0E2EBB99;
	Mon, 20 Oct 2025 08:25:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760948759; cv=none; b=PAODSLxUgGZHaubH1YWNUQ4h2xYwignYL9HUYG6XX2cAPyGBuO0JrCz7iEIMD0hy/kb5P/XtP6hSq24bN6yQtKVB8jdZJHXGQ/LPDxyMWA6T8Qa+GuEt4xwsIx1ZlWgQpTVD/r1fTFkb9F0VvF+SaUxABJc7sZERCob0SuXmR0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760948759; c=relaxed/simple;
	bh=6rUczfMk0139hnj6WC/mItzsddJzFcXLQO6QjFYakvA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ogOhPHp1cDONULoC/zwkLj5XNDWFh7xFSn9ALsQyzHSAMGQJ14qreShifaGEkvxPORpWzB+0hPZy4M3RvS/QiqldlIdlZQspzGxrA9EpVw1zBrES674Wc2EYyFc59mHBGsDctloIEO4hXfjc5jJe7gpX1GHrBGhW83rbTfxxMgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=UbhZz0bX; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:
	Subject:Cc:To:From:Reply-To:Content-Type:In-Reply-To:References;
	bh=wGVaL8ZXz08MYLs41kERmlA/MzErRlXr5si+49dXDbw=; b=UbhZz0bXI2wfJ4VRYaZGhN0+pe
	PxbtZDraakyULxzeZn++PGmRjHhrq9DFRFuiZjgWGo2m2jhzlavDfE0uWCtmVRHi9zr5m+ASNct1R
	F26pghlil5tKauQeoCKutKVaI1TxOt38HigcDS/DzZfFkEI+dRPJWEus33p8j8IQfwo58XNfuIVaR
	owRLKwvDZ0JVSoFNZv/4ddCzSWNEXVLDrAFqh0c/5EVHiEwP7h4CujSSoDChHQ/TIEvCScXMyP8WC
	yqD2oTPSOqpfRVdof1U7yeJWb5OyW8EXK+a0VZkg+Z2op8/tc7MzgqaW6rcJmpZbOlI+C28E0gQrB
	4AK3P8wQ==;
Received: from [141.76.253.240] (helo=phil.eduroam.local)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1vAlCx-00078O-M9; Mon, 20 Oct 2025 10:25:35 +0200
From: Heiko Stuebner <heiko@sntech.de>
To: heiko@sntech.de
Cc: maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	quentin.schulz@cherry.de,
	andy.yan@rock-chips.com,
	dri-devel@lists.freedesktop.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	cn.liweihao@gmail.com
Subject: [PATCH 0/9] Gernal RK3368 HDMI support and 2 outputs for RK3368-Lion
Date: Mon, 20 Oct 2025 10:24:59 +0200
Message-ID: <20251020082508.3636511-1-heiko@sntech.de>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series adds the necessary bits for HDMI output on RK3368 and enables
this on RK3368-Lion. At the same time, use the recently added DSI support
to enable the generic Video-Demo-adapter as an overlay on Lion as well.


The reason I'm shaving this Yak is that the recently added DSI support
created DTC warnings about a single endpoint with an address.

So it was either removing the @0 from the endpoint, or adding a second
output option :-) .


Heiko Stuebner (9):
  dt-bindings: display: rockchip: dw-hdmi: Add compatible for RK3368
    HDMI
  drm/rockchip: hdmi: add RK3368 controller variant
  soc: rockchip: grf: Add select correct PWM implementation on RK3368
  arm64: dts: rockchip: Add power-domain to RK3368 DSI controller
  arm64: dts: rockchip: Add power-domain to RK3368 VOP controller
  arm64: dts: rockchip: Use phandle for i2c_lvds_blc on rk3368-lion
    haikou
  arm64: dts: rockchip: Add HDMI node to RK3368
  arm64: dts: rockchip: Enable HDMI output on RK3368-Lion-Haikou
  arm64: dts: rockchip: Add the Video-Demo overlay for Lion Haikou

 .../display/rockchip/rockchip,dw-hdmi.yaml    |   1 +
 arch/arm64/boot/dts/rockchip/Makefile         |   5 +
 .../rk3368-lion-haikou-video-demo.dtso        | 174 ++++++++++++++++++
 .../boot/dts/rockchip/rk3368-lion-haikou.dts  |  36 +++-
 arch/arm64/boot/dts/rockchip/rk3368.dtsi      |  45 +++++
 drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c   |  16 ++
 drivers/soc/rockchip/grf.c                    |   1 +
 7 files changed, 268 insertions(+), 10 deletions(-)
 create mode 100644 arch/arm64/boot/dts/rockchip/rk3368-lion-haikou-video-demo.dtso

-- 
2.47.2


