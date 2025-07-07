Return-Path: <linux-kernel+bounces-720245-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC4A9AFB90E
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jul 2025 18:51:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 641987A250F
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jul 2025 16:49:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B44E23B617;
	Mon,  7 Jul 2025 16:49:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="txXEzBC7"
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E24F235358;
	Mon,  7 Jul 2025 16:49:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751906992; cv=none; b=r+hkZI8WLGLyYZdebMvXdwFaPj004wGzEPfF02vJP4iyHbINbWqS1FoMewoIJNk2PD3OIcsYNqtNI2cGEfJam3OKZ0qjtCxHL/kkLW4PHCdKml1s6mO7UbRkl93gHYPF6GuM56QXq6Votr7pftRVQCpRjrs09miwBWkFcL+BITU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751906992; c=relaxed/simple;
	bh=c4KSMQg7c1s2ikmZMvn4EPjkLoQe0EitSQX9Kk9KasA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UDq8tEAOzJvFvcp/EsYOLdcVlZudZJ0hsu0RP8Rj0QB9m1oNZdEZY9X23PEDkImO5WneaGQXEg+eZQtzqA6CJNCDbRTIFun3DlmvCtrqVPeBG+lIKSjEJwOjbc/ZXvwnp0RaR1chIEqa12o4xx6+X3MwprnHaqUkFsrXCDp2HDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=txXEzBC7; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:
	Subject:Cc:To:From:Reply-To:Content-Type:In-Reply-To:References;
	bh=95qtSTC/qWsTSLa9j9zg9DGEk7v1YtKph8l3ru7WuWw=; b=txXEzBC79RXkkWjmf9rB61w86m
	ebHNPB/2+iYG3yJd4uB84pjPf2+cuyBKBPdQj1+dgULhRtnOxwSvHr5Z/HwNurXhqi45rTBq7QOim
	C9ftmPi2bPIZrH77L9Bke67wO8cUh5VqCRLb9mxdoDbtVW4GfP3agGdSCXtUnfkEAmZmhgMi4ZZOH
	4eGG0Pv7Tj5nG8d5fvOE+q2+QGEXzGS87fFcJiPg3pmU2B6Nlsrj3YFy0Qrhj5yBKyBscQ/rbE2Q8
	/Al6Mz4lHbM5bQ0ebDvAq5tL7sizhnKjU8YO56T+momMV3C8cy8Vd0IU3Tih3nnhIPb0oahDE/pgn
	ivYB38OA==;
Received: from i53875bf5.versanet.de ([83.135.91.245] helo=localhost.localdomain)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1uYp1o-0004yl-T3; Mon, 07 Jul 2025 18:49:16 +0200
From: Heiko Stuebner <heiko@sntech.de>
To: heiko@sntech.de
Cc: neil.armstrong@linaro.org,
	quic_jesszhan@quicinc.com,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	hjc@rock-chips.com,
	andy.yan@rock-chips.com,
	andyshrk@163.com,
	nicolas.frattaroli@collabora.com,
	dri-devel@lists.freedesktop.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org
Subject: [PATCH 00/13] Support DSI output on rk3576 and roc-rk3576-pc board
Date: Mon,  7 Jul 2025 18:48:53 +0200
Message-ID: <20250707164906.1445288-1-heiko@sntech.de>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This enables all the necesary bits and bindings to get display output
on the dm-m10r800-v3s addon module for the Firefly roc-rk3576-pc board.

A bit of cleanup of the ili9881c, because the driver was still trying
to send dcs commands when the underlying DSI driver might have already
switched to video-mode, which caused me quite a bit of headache until
I realized this being the culprit for my garbled display output :-) .

Only the last patch has a dependency on Nicolas' pwm series [0]
everything else, is directly usable.


[0] https://lore.kernel.org/lkml/20250602-rk3576-pwm-v2-0-a6434b0ce60c@collabora.com/

Guochun Huang (1):
  drm/rockchip: dsi2: add support rk3576

Heiko Stuebner (12):
  drm/panel: ilitek-ili9881c: turn off power-supply when init fails
  drm/panel: ilitek-ili9881c: move display_on/_off dcs calls to
    (un-)prepare
  drm/panel: ilitek-ili9881c: convert (un-)prepare to
    mipi_dsi_multi_context
  dt-bindings: vendor-prefixes: Add prefix for Shenzhen Bestar
    Electronic
  dt-bindings: display: ili9881c: Add Bestar BSD1218-A101KL68 LCD panel
  drm/panel: ilitek-ili9881c: Add Bestar BSD1218-A101KL68 support
  dt-bindings: soc: rockchip: add rk3576 mipi dcphy syscon
  dt-bindings: display: rockchip: Add rk3576 to RK3588 DW DSI2
    controller schema
  arm64: dts: rockchip: add mipi-dcphy to rk3576
  arm64: dts: rockchip: add the dsi controller to rk3576
  arm64: dts: rockchip: add vcc3v3-lcd-s0 regulator to roc-rk3576-pc
  arm64: dts: rockchip: add dm-m10r800-v3s overlay for roc-rk3576-pc

 .../display/panel/ilitek,ili9881c.yaml        |   1 +
 .../rockchip/rockchip,rk3588-mipi-dsi2.yaml   |   1 +
 .../devicetree/bindings/soc/rockchip/grf.yaml |   1 +
 .../devicetree/bindings/vendor-prefixes.yaml  |   2 +
 arch/arm64/boot/dts/rockchip/Makefile         |   5 +
 .../rk3576-roc-pc-dm-m10r800-v3s.dtso         | 134 ++++++++
 .../arm64/boot/dts/rockchip/rk3576-roc-pc.dts |  16 +
 arch/arm64/boot/dts/rockchip/rk3576.dtsi      |  50 +++
 drivers/gpu/drm/panel/panel-ilitek-ili9881c.c | 301 ++++++++++++++----
 .../gpu/drm/rockchip/dw-mipi-dsi2-rockchip.c  |  21 ++
 10 files changed, 475 insertions(+), 57 deletions(-)
 create mode 100644 arch/arm64/boot/dts/rockchip/rk3576-roc-pc-dm-m10r800-v3s.dtso

-- 
2.47.2


