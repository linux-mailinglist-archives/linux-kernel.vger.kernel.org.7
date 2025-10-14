Return-Path: <linux-kernel+bounces-853195-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E6F4EBDAE57
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 20:07:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 330104F4071
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 18:07:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 531BA3074B2;
	Tue, 14 Oct 2025 18:06:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="Z9OoWeec"
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 314062741B3;
	Tue, 14 Oct 2025 18:06:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760465217; cv=none; b=rOsqQpAngK1z+jmELBXUJ7DnYJjr9rQPTy/VmmNJ1G024Po5uYhXKupHlKf0RbhfRKx1ROuY6mGK9ruFHP1nVIhut2PDKTUf94xMbKUSOMXlJswK9o0i/5mQzFOVr1ZrTbdsW2yLBlgNCgWi/Wpm1zpnILw7knQ1yWSje+6NCv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760465217; c=relaxed/simple;
	bh=2Bc4jeTDUOZBAoT875/RgB8dXWQZZhWa6hi9IWA9N1o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ld6ggLlNAKcjQ8Gj/7QL08LdIoiHUiGfBwHrjfhFwXVswITkixxuqvjF+JvYxnR8eQT2vNh9SZ6g5YRnaVSqXyhFvxPm0CWs6Pdr8HEH+5wGEmkDYcP0cSqeZ96+BHy0YrC8qOiCIEyy1JHcIwzhJCRJfgTSc404WhjmoTUSIkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=Z9OoWeec; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Transfer-Encoding:Content-Type:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To;
	bh=TOZSAhMRoAi3ivFm/RUgbGXpjIfGUXs3ICM+R1IZIJE=; b=Z9OoWeecwoNEZkO2ZI1cvN3ctl
	AHOBscQGHPybThXJQ1AGvFyJSuYIRJtkxV9QWlhGNG82J2GsJSf2uidys1gK/9oYsIDpDGu4cQv/p
	N2spY0NZZcZSXEsx9IbkVbuCjZqvxb1mgq6PO91TT5J7KsKCUVNyKWd/cZw5ODK22KaQs8VxOaS75
	Jb8Oez7VGFEadXfI1xn4sTxqYARkJa29vtwhHE1R8a7UZZPsuoFVyvq80nZhyiD8x1YcynwueslpC
	jYjHB15kOW3sDEGkPrf6cfpoH+LQL1s+NoqjvLxHMs9R5Et9yCUSCHYeZbp8Qk+1TKR6eQUoS63rr
	wV2xiR9A==;
Received: from i53875b75.versanet.de ([83.135.91.117] helo=localhost.localdomain)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1v8jQ9-0001Gj-RG; Tue, 14 Oct 2025 20:06:49 +0200
From: Heiko Stuebner <heiko@sntech.de>
To: robh@kernel.org,
	WeiHao Li <cn.liweihao@gmail.com>
Cc: Heiko Stuebner <heiko@sntech.de>,
	hjc@rock-chips.com,
	andy.yan@rock-chips.com,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-clk@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: (subset) [PATCH v2 0/8] drm/rockchip: Add MIPI DSI support for RK3368
Date: Tue, 14 Oct 2025 20:06:33 +0200
Message-ID: <176046473165.1662867.3389597341632636891.b4-ty@sntech.de>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250905025632.222422-1-cn.liweihao@gmail.com>
References: <20250905025632.222422-1-cn.liweihao@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Fri, 05 Sep 2025 10:56:24 +0800, WeiHao Li wrote:
> This series adds MIPI DSI support for the Rockchip RK3368 SoC, enabling
> native display connectivity through the MIPI DSI host controller and
> PHY. The changes span multiple subsystems, including clock control,
> DRM/VOP integration, DSI controller binding.
> 
> Key changes:
>  - Update dw-mipi-dsi-rockchip driver to preperly handle RK3368 dsi
>    initialization.
>  - Add missing lut_size of vop_data for RK3368.
>  - Add missing clock ID SCLK_MIPIDSI_24M to the RK3368 CRU driver,
>    which is required for enabling the 24MHz reference clock.
>  - Add MIPI DSI node to rk3368.dtsi with correct clocks, resets,
>    and register mappings.
>  - Add dt-bindings document.
> 
> [...]

Applied, thanks!

[5/8] arm64: dts: rockchip: Add display subsystem for RK3368
      commit: ef06b5ddee1e1288e51e8d961947d1b16156db0c
[6/8] arm64: dts: rockchip: Add D-PHY for RK3368
      commit: d62e2ad29b815509291b6a07787ed51b52e2b4d5
[7/8] arm64: dts: rockchip: Add DSI for RK3368
      commit: 5023d0cd61831acd6e88496f5f7867a18a217a74

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>

