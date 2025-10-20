Return-Path: <linux-kernel+bounces-860349-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DE218BEFEDB
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 10:27:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B452D1885393
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 08:27:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 766362ECD05;
	Mon, 20 Oct 2025 08:25:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="DtpxN1Pl"
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E27502EBB80;
	Mon, 20 Oct 2025 08:25:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760948757; cv=none; b=sWBmv9N4pD6N9ItmWre18TghfVYCBp5pxzRYyZK6AOaZ/7ztAw4c792An8s2bskkuOGCHPgSHiWrgCLtuiyZ2MqtdUkmgqn+9b2ItHTkLOFivG/uiAcwSdWlF5l4c1OOQkE8oUK666w23nv58FI0uoOK4N/yvp2QxbdTpmvQF/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760948757; c=relaxed/simple;
	bh=8ulyx0+RM3z/QL2q66jui3FXZ/82ad4gLMet0dogxGw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JcakMJFlCJDykhE9JQDx6eaQP++B0SlJveN09r/Qp/0hPziCgjfWd29zreE4ZZZzDq6N8VIO80MmOH5C83uT8NTjrGpMdU/I1cmckahAW27WXiP4ugr0SFDrUB6ch3nSR92mm56VPdoHKSimnFHP3eVTpMWhLITUUJhhurVVRkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=DtpxN1Pl; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Transfer-Encoding:MIME-Version:References:
	In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type;
	bh=pOUvvxU2BJaHxDxHIo4De4OqXEVjTkBaEpIseudvhGs=; b=DtpxN1PlWm09zUHWBVJ/Gg5IPU
	PSGk1BUw4cEaCdaqGuDI8L+X6H1LWC8MhNZcTnLUXKyiRAHisS7294+McAYXLj3+JQjoF7LViXtDk
	BMAwd3d9G9P1RwNIhMFqoFMNE8rNgc2XKoX3VEyhvlFJrG3bqaq6phrvxcZ+FmPHFJXwf9eGQBec+
	vuomOk/nTgNdAV6KYi5UJOvewVTgqnUoVjODjCKgHDEgRxH9mroI0NRSAelfA4KC/pSdubIxi+tAc
	N1FGbLFz6MM7OmJvXfXSeCniDfK7mcrzgXjNNvEBF9aFtnmGL31iEtxJqIOpM2mlxCraK6GO9Wf6G
	TqtmiJew==;
Received: from [141.76.253.240] (helo=phil.eduroam.local)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1vAlCz-00078O-AA; Mon, 20 Oct 2025 10:25:37 +0200
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
Subject: [PATCH 4/9] arm64: dts: rockchip: Add power-domain to RK3368 DSI controller
Date: Mon, 20 Oct 2025 10:25:03 +0200
Message-ID: <20251020082508.3636511-5-heiko@sntech.de>
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

The DSI controller is also part of the VIO power-domain and it
definitly needs to be on when accessing it to no cause SError
faults, so add the power-domain property to it.

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


