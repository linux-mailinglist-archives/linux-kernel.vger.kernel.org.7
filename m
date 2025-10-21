Return-Path: <linux-kernel+bounces-862332-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AD3E9BF505B
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 09:43:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 01E1618C4327
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 07:44:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51B4628505A;
	Tue, 21 Oct 2025 07:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="hGigLLHz"
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3377C24729A;
	Tue, 21 Oct 2025 07:43:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761032611; cv=none; b=QaA0iT3JpU9OrVN9gW8vgRu70DwWNR8bgtaYSfNV6GhFEHBFjU7F3jJWFkuESscY/EI/u2FTKmnrr1D5f0Acheasse1uncp9F7AzP19UpT830HBw0zqL1Pe6NyfXZ+5TZt33cO7mdlXXhmqf8LOfFQ5KKDFFz3VB4eo9VW6UPbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761032611; c=relaxed/simple;
	bh=rHbR+j8S8tXqpeLLjUh47e1ekryf3X4jzfjFx7zr+t0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gq5s5jlJRU66zq9XHT+Mkg9yZwcA9Vq3vUmPmeH+slbaleME0M49sBOUFz2BCSrDXXrSVgQLq4sk7X6XeKHNtFjCiforXlEmJKfDoBK2W3MeSDfQlYBKRW7yDt0hOaauE+DNboumFUolTnh2txyu0THXT/rpVakzno+MHwEm7OM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=hGigLLHz; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Transfer-Encoding:MIME-Version:References:
	In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type;
	bh=DQiFTA1Zb0f+PltH60opSgxEGjud3fhNqO/a6P7cdMQ=; b=hGigLLHzRgtp20dwA8JjHs7izb
	OSAtKM6CvnKyn2qGGhTEgzXKtVgwieG5XeDqSRKz3Lpiwc6jXQXVm18YL/QiHwSTg2NRY1QBCYrgp
	Vv0adkWzqEuMnuqGSSc4xWt0s60GpXcxRETJNaYSDdwOiInDYVa6WERFcBjFzNV3HAA9ee6PGWHJS
	vpd7v9TOwOAPuSlhN2i9xWkK1YeMrBh8mcikpksA+enGOlEGDUXXVptYF+kjCkMiJtcYuKerS9xfN
	om6qupUiMEL5YZIviWcgozizaR4b9od+LoObXwACthEjFOECfWTNzPLdtUALJro6iWKBWKf33/nBw
	m+AvKbqg==;
Received: from [212.111.240.218] (helo=phil.guestnet.ukdd.de)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1vB71O-0000uy-4v; Tue, 21 Oct 2025 09:43:06 +0200
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
Subject: [PATCH v2 4/9] arm64: dts: rockchip: Add power-domain to RK3368 DSI controller
Date: Tue, 21 Oct 2025 09:42:49 +0200
Message-ID: <20251021074254.87065-5-heiko@sntech.de>
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

The DSI controller is also part of the VIO power-domain and it
definitely needs to be on when accessing it to not cause SError
faults, so add the power-domains property to it.

Fixes: 5023d0cd6183 ("arm64: dts: rockchip: Add DSI for RK3368")
Signed-off-by: Heiko Stuebner <heiko.stuebner@cherry.de>
---
 arch/arm64/boot/dts/rockchip/rk3368.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3368.dtsi b/arch/arm64/boot/dts/rockchip/rk3368.dtsi
index 8f0216203241..5b2cbb3003b6 100644
--- a/arch/arm64/boot/dts/rockchip/rk3368.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3368.dtsi
@@ -896,6 +896,7 @@ mipi_dsi: dsi@ff960000 {
 		clock-names = "pclk";
 		phys = <&dphy>;
 		phy-names = "dphy";
+		power-domains = <&power RK3368_PD_VIO>;
 		resets = <&cru SRST_MIPIDSI0>;
 		reset-names = "apb";
 		rockchip,grf = <&grf>;
-- 
2.47.2


