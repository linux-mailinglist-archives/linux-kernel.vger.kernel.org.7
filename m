Return-Path: <linux-kernel+bounces-862333-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 8479ABF5067
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 09:43:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id AD9894F2D08
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 07:43:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4669285C9F;
	Tue, 21 Oct 2025 07:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="jlUVEXvA"
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EA75263C69;
	Tue, 21 Oct 2025 07:43:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761032612; cv=none; b=HCzqMlpzDe+YLODGbuXz6DTSa5RqtGc2Z4yVXCjjQhe3I6o+H03Z3/xare1hCjldwjhCZ98/1jl2p1OmaWfwWQFipuQdsVohkK/x2YK/Ccr8KUbChrxFI4599cG0V9GGULB1atxXEkGVRSW4G0JEg2WI6Wbi0dNNWFQgEaeXydo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761032612; c=relaxed/simple;
	bh=NYtGpFUqxfCvceJbUCP/XQAGwrV3WJO9yfm1U9sVb+A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ac1+bA03p2oXT7Ln2wSe/DbCxRvO6hrFaMb66xMBNypxKaOW9SIp98oqAa3eoCP/TFFP36O/GX1yuWNm+uZHYZgfrYKBFQOKWjYPKMbrzENPPgfXlmN3gYJtXI1ZuHqBkPfG11HCD6a/tmXFf2DlA4MjaOcOKHKFqC2hQsLrstk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=jlUVEXvA; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Transfer-Encoding:MIME-Version:References:
	In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type;
	bh=mmlHMPWedKZa3b5lspADk1yGjz374S0SlNnfit98E9I=; b=jlUVEXvAHh3IXoI8CaQJLnkll7
	5haUWO+poWoQMwL+eZ9FT43Z/c7uyRa4kqt4q24UWF52y0cu+tyeIuuC2ATYVEc1184y5zq4w3Bmt
	lcagqGU3K2VaYMpbxfNVsdyldDdFxjx64j8xlC+KQk2Ar6ThZUxzgOfQRpKKQEq10hb0yjROERpxH
	WSLuYet96m6Mb0btNwUpuEg4UA29Z20lLnoTR9jHmPyNVJxUAsuEZ9xuqU8Hq8g7mXhEK6/7/yuDK
	YVOEwpVjjKkcd2o1NprP4CQl1Oiu+KRJK6ycUlI66jikfW5avzwZHQbVUdU81fRTKcgt64QfqLuGO
	i2ao6vpA==;
Received: from [212.111.240.218] (helo=phil.guestnet.ukdd.de)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1vB71O-0000uy-Hl; Tue, 21 Oct 2025 09:43:06 +0200
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
	cn.liweihao@gmail.com,
	Heiko Stuebner <heiko.stuebner@cherry.de>
Subject: [PATCH v2 5/9] arm64: dts: rockchip: Add power-domain to RK3368 VOP controller
Date: Tue, 21 Oct 2025 09:42:50 +0200
Message-ID: <20251021074254.87065-6-heiko@sntech.de>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20251021074254.87065-1-heiko@sntech.de>
References: <20251021074254.87065-1-heiko@sntech.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Heiko Stuebner <heiko.stuebner@cherry.de>

The VOP is also part of the VIO power-domain and it definitely needs to
be on when accessing it to not cause SError faults, so add the
power-domains property to it.

Fixes: ef06b5ddee1e ("arm64: dts: rockchip: Add display subsystem for RK3368")
Signed-off-by: Heiko Stuebner <heiko.stuebner@cherry.de>
---
 arch/arm64/boot/dts/rockchip/rk3368.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3368.dtsi b/arch/arm64/boot/dts/rockchip/rk3368.dtsi
index 5b2cbb3003b6..ce4b112b082b 100644
--- a/arch/arm64/boot/dts/rockchip/rk3368.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3368.dtsi
@@ -862,6 +862,7 @@ vop: vop@ff930000 {
 		clocks = <&cru ACLK_VOP>, <&cru DCLK_VOP>, <&cru HCLK_VOP>;
 		clock-names = "aclk_vop", "dclk_vop", "hclk_vop";
 		iommus = <&vop_mmu>;
+		power-domains = <&power RK3368_PD_VIO>;
 		resets = <&cru SRST_LCDC0_AXI>, <&cru SRST_LCDC0_AHB>, <&cru SRST_LCDC0_DCLK>;
 		reset-names = "axi", "ahb", "dclk";
 		status = "disabled";
-- 
2.47.2


