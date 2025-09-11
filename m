Return-Path: <linux-kernel+bounces-811691-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ADF96B52CA2
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 11:06:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 545DB1BC608F
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 09:06:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABBE22E7BA5;
	Thu, 11 Sep 2025 09:06:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="f/dE23N6"
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A2392E7647;
	Thu, 11 Sep 2025 09:06:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757581567; cv=none; b=nEd/m1nePJ4WUh50o0w4Awh8V+6RDVaZYlgC6ZqhsC2JuwRUexH5YVrsCyKvsJO7CFNa1C4GzQZv55P/CYqGPzS7z6fwyzgye0hISqzkCAlVROfMonzlVHlJmk2E77FoIL2alq4TT3sJL9yxlDqvzE+YdG7seGffwj9VcQYrMtQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757581567; c=relaxed/simple;
	bh=DdlfvT3eCR6NUQqyc1yLTs/CeeSPGuVhHipcnexsBwY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oYX8Y9H42jKk2Didi1QFJIamKTejKcD+WalOaV2lHmebezJR4SNozt9c1SD8v4HQ5tdRagiREqWExQyyRaP35NGzO/GdMxVDraaj6wKmQraMKixm19t/VkY1JX1uHhMe9t+0R8wsloXd88vCuVb937N63JZXf189oiM3nnTXEb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=f/dE23N6; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Transfer-Encoding:Content-Type:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To;
	bh=K0km93K0aEijBUWbpPd5UCCfJKPcIzvJxr0PWIyYCV8=; b=f/dE23N60ADgK8SxUUU7fYKFfa
	+wXbwRQoRv2MyKN8CRUydcne/ZBrP+PRhWcxTEakiAYBmAGXvmkU7qXh2a28144dfoCRn+sE2gtVi
	lZdSStcL1CQLukgoqKmW75+1dbZvkmM0gd0I3B9h7FhOnHfPv2ckhq53XDyD54FvhziozSw7TzcqU
	LVqSXEtXSsh7M8bm+BOnYWfVnSk21daLQqQVSLEaROzo07X2x96itgUaRf6PU8umqL5KTTwwxRo7o
	orI35NSlmXti4xLyE8jxPvfFk8g+fUKpmZzgTS9Guwcm/2TS/vCWzO8ZiST8bM6cmRoe62Tql+K7e
	Csj34lEg==;
Received: from i53875b0e.versanet.de ([83.135.91.14] helo=localhost.localdomain)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1uwdFb-00005b-5A; Thu, 11 Sep 2025 11:05:55 +0200
From: Heiko Stuebner <heiko@sntech.de>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Kever Yang <kever.yang@rock-chips.com>,
	Jagan Teki <jagan@amarulasolutions.com>,
	Sebastian Reichel <sebastian.reichel@collabora.com>,
	Diederik de Haas <didi.debian@cknow.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Collabora Kernel Team <kernel@collabora.com>,
	Michael Riesch <michael.riesch@collabora.com>
Cc: Heiko Stuebner <heiko@sntech.de>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-phy@lists.infradead.org,
	stable@kernel.org,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: (subset) [PATCH v4 0/7] phy: rockchip: phy-rockchip-inno-csidphy: add support for rk3588 variant
Date: Thu, 11 Sep 2025 11:05:43 +0200
Message-ID: <175758154013.610665.15945900188702007855.b4-ty@sntech.de>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250616-rk3588-csi-dphy-v4-0-a4f340a7f0cf@collabora.com>
References: <20250616-rk3588-csi-dphy-v4-0-a4f340a7f0cf@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Wed, 03 Sep 2025 19:04:48 +0200, Michael Riesch wrote:
> Habidere,
> 
> The Rockchip RK3588 features two MIPI CSI-2 DPHYs (not to be confused with
> the two combo MIPI DSI/CSI CPHY/DPHY blocks). The CSI-2 DPHYs can be
> supported using the existing phy-rockchip-inno-csidphy driver, the notable
> differences being
>  - the control bits in the GRF
>  - the additional reset line
> This patch series adds support for this variant.
> 
> [...]

Applied, thanks!

[1/7] dt-bindings: soc: rockchip: add rk3588 csidphy grf syscon
      commit: 92f96706947e902fd9156cdcdd61c9a44b4b186c
[7/7] arm64: dts: rockchip: add mipi csi-2 dphy nodes to rk3588
      commit: 871b0391ccf3feb831e233ba3e972663c057b946

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>

