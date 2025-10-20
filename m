Return-Path: <linux-kernel+bounces-860357-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 14EF7BEFF2E
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 10:29:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A17E84018F6
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 08:28:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA2572F12C3;
	Mon, 20 Oct 2025 08:26:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="dUgmxZbi"
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64BF01DF26E;
	Mon, 20 Oct 2025 08:25:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760948760; cv=none; b=sjJl0XTskStGMd+XkLmqRm0LwocS+1k9UqUlLe2jsXdZTky/0W1ONzqwNAMjqa6RD/zfXb0xpfuLeatSSyYLfSF8oCK5Q7J2gQtv3RhgDdO013Q1aopvmNyzCMNdof7t/Tk8a11dlTWts0omz3k9CDHzLH03/7pvJJKBBYacTPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760948760; c=relaxed/simple;
	bh=R70wZXJ8F0/cNojCyOImKR8Y/E8ke+fHcCkZQxYzEjo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=czl7z65eKGwTvDyeh8LCwyXJHJB3RTOTxmqH7EJH2xjNkAdk6GPHXwa1pr1W7lCZ4QsMILV4AEDU4Yk3/DYib0KzkZSTZ5hlKHEnvMRrs7zIxxoe93OcEyWsGqiV3EtdFyj5NFjOjFcOeSx/ZrOYepPn8zQwrZJbyqfxoHkLmhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=dUgmxZbi; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Transfer-Encoding:MIME-Version:References:
	In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type;
	bh=vq+OLT6kQHBvZ3SWUmco3TCZbL/ngmeaaecxDEGXCME=; b=dUgmxZbiqZHYh6tpf3bP0/hewn
	qeEKPW/M+nVRk/aIuwlPJJ/6PLzWNlu52tkPtPMR+Uzdk9raOyXp7k9GdHPfu/TNRRoNFj/AstiDV
	rKFBJc1Y1ie8TBCGMgi6UdRB7ghCr2Qr6l0Ue66Mg1GehcRkFsG8K7KV8HR98U0ARbqEJJNLF23fI
	VXphZOBD0mKl7VHJPA2Tg1EVHnxJCqiwEo2KxU4SFgOlsp123cRSChTGdV1qyW2Q73+fylfd1ccMj
	TZkJLdy/9I45+QCj8ZYSGu6ylz3WkZj829rZI4OV/PBO4Zudr+MIdXUX0i7lE7PwhaNUm3xzq3BWU
	iWfbYNfg==;
Received: from [141.76.253.240] (helo=phil.eduroam.local)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1vAlCz-00078O-MZ; Mon, 20 Oct 2025 10:25:37 +0200
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
Subject: [PATCH 5/9] arm64: dts: rockchip: Add power-domain to RK3368 VOP controller
Date: Mon, 20 Oct 2025 10:25:04 +0200
Message-ID: <20251020082508.3636511-6-heiko@sntech.de>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20251020082508.3636511-1-heiko@sntech.de>
References: <20251020082508.3636511-1-heiko@sntech.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Heiko Stuebner <heiko.stuebner@cherry.de>

The VOP is also part of the VIO power-domain and it definitly needs to
be on when accessing it to no cause SError faults, so add the
power-domain property to it.

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


