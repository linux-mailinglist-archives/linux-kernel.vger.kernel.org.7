Return-Path: <linux-kernel+bounces-817202-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AD1CFB57F35
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 16:37:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 588B51891C10
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 14:37:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C4D532F743;
	Mon, 15 Sep 2025 14:37:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WVs88B5y"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6317F320A17;
	Mon, 15 Sep 2025 14:37:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757947020; cv=none; b=BPAf1y73SjP4uecD8rUAsfaia2oeQ7okqG4htATU7fCBX9Saa7+uT4wKjwf6pSG1JXMbSPmqysm3ND5REQ9POqUuup3lIECWrt4IQjJu+EjVI/51zJWjPLtyBdm0VTbqdiERHTvUxUBGz9Nsl+AQABfBh81vgTMG/AxImgXIoIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757947020; c=relaxed/simple;
	bh=LaVVBqstrujneGbAzHLz7nrkIsdxKDKzrualI52ZIIs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=sXHhUwn/gwu6sYThoHezrBVwjXEvbXq8gn0zpekXzyE1cFIFK8lRe7lxpbWUuEIQVPPm/PyE/aB/kU1+/8iExT6EpxRDOfgblEBL++1bTgio8BadFNGOyma9fSWcqxXOoE79vqrMLUVcxvdPFcLg2UjlPd65f6/8goX4p/I/ucI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WVs88B5y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 625ACC4CEF1;
	Mon, 15 Sep 2025 14:36:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757947020;
	bh=LaVVBqstrujneGbAzHLz7nrkIsdxKDKzrualI52ZIIs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WVs88B5yPRlclUwE4sdDfug96OsJwa/zEnVNdGpbhF5zYb68Ql2WhaTZABRcwSHKv
	 Zk9BU8nb9qRPHabu3/j47DThmakS/S1dxGaGrU+z/vwUqtlC506/ScQu9O75IblX4Y
	 7+QwCb3VH72OdO5JpBd2MiIcBLSTsYUVJRekL7Qd6HKC0I8nXzaV+To1d3giw6uJDt
	 dwTyz8u2kCoCaTSd3wQW79C42tsz1//NRN0ldFgfHqYDDHbHZM4Oa4IsVcwaBYVSGB
	 i0OSM9QX0sOFzq0Dlv8gaocWM8Sb7DYeMyINVOjTFakLd3sEEv/9LPSixot9k2QaMp
	 RwvKVaVQ2Sffw==
From: Michael Walle <mwalle@kernel.org>
To: Frank Binns <frank.binns@imgtec.com>,
	Matt Coster <matt.coster@imgtec.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Nishanth Menon <nm@ti.com>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Tero Kristo <kristo@kernel.org>,
	Santosh Shilimkar <ssantosh@kernel.org>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>
Cc: Andrew Davis <afd@ti.com>,
	dri-devel@lists.freedesktop.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-clk@vger.kernel.org,
	Michael Walle <mwalle@kernel.org>
Subject: [PATCH 3/3] arm64: dts: ti: add GPU node
Date: Mon, 15 Sep 2025 16:34:40 +0200
Message-Id: <20250915143440.2362812-4-mwalle@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250915143440.2362812-1-mwalle@kernel.org>
References: <20250915143440.2362812-1-mwalle@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The J722S features a BXS-4 GPU. Add the node for it.

Signed-off-by: Michael Walle <mwalle@kernel.org>
---
 .../arm64/boot/dts/ti/k3-am62p-j722s-common-main.dtsi | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-am62p-j722s-common-main.dtsi b/arch/arm64/boot/dts/ti/k3-am62p-j722s-common-main.dtsi
index d0cfd6821b18..d02f7fba327b 100644
--- a/arch/arm64/boot/dts/ti/k3-am62p-j722s-common-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am62p-j722s-common-main.dtsi
@@ -1232,6 +1232,17 @@ dsi0: dsi@30500000 {
 		status = "disabled";
 	};
 
+	gpu: gpu@fd80000 {
+		compatible = "ti,am62p-gpu", "img,img-bxs-4-64", "img,img-rogue";
+		reg = <0x00 0x0fd80000 0x00 0x80000>;
+		clocks = <&k3_clks 237 3>;
+		clock-names = "core";
+		interrupts = <GIC_SPI 241 IRQ_TYPE_LEVEL_HIGH>;
+		power-domains = <&k3_pds 237 TI_SCI_PD_EXCLUSIVE>,
+				<&k3_pds 242 TI_SCI_PD_EXCLUSIVE>;
+		power-domain-names = "a", "b";
+	};
+
 	vpu: video-codec@30210000 {
 		compatible = "ti,j721s2-wave521c", "cnm,wave521c";
 		reg = <0x00 0x30210000 0x00 0x10000>;
-- 
2.39.5


