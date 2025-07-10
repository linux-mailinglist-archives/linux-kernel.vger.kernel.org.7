Return-Path: <linux-kernel+bounces-725366-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1ED0DAFFE18
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 11:28:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 04D834E7D3A
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 09:28:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 354552D0C73;
	Thu, 10 Jul 2025 09:27:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="eHA+B6I8"
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E71082BF009;
	Thu, 10 Jul 2025 09:27:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752139653; cv=none; b=qD9vYgl4ZyCXCrpiMjnTZwaebcmyco94S+QRmi9mBlK7WLGbtJnm5SJlI+j1aWMPUor+LnCCvNFGGbVp3KB1DjAKP/tf+4gHv+sQ5iI0PielCi7iuBMnaI7HUkMo4gf1Xfs1Mn43djOnCYdvbHmH2bA/PcwnOvyqqEx9bzWmc+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752139653; c=relaxed/simple;
	bh=rKsmPUu0Q9yzbfSDSSF+OKz0cn7VGlB6m5EoPWaNS/U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Bbfrqy2MUoTEEk4zkzJiMwUGm4JpqAVaQdp6s7oPyVoWfhjugyHXZijupDSCJlHgjNcIuiDMwooxMCNPtvmkHyvB5h2MnbQx0CXPpSehwaXpRavHseRXogDzoBK51GaS0qZ/4hJT0gemVWvj90C2OGMDWt+zmXNAnX470yDsczE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=eHA+B6I8; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Transfer-Encoding:Content-Type:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To;
	bh=MroTOxMmgxwRAhtMlsJpCRSnugYklaOaOLCLE5+XIJ0=; b=eHA+B6I8H4ThyYpE9AGVQ0VVyS
	oBNaC/b7eWo69WNjLwIoWi3o83F9XieyNQb6GLcAC3RX9OXghV9TWUZrZCKn8Hpgv5hnatx4lHfZU
	K2jBfvGckT5Yf3JGZQDQBmStl8Mju2N5OFV6C8nF28v5qsX8QGiZRq2L3yxkh+DT9Gr3yj0/dlGtz
	voPJyo5eWhrgOsA8Zpx2+d7Rsyz8lvihXeKrlEAhfMMK1WtmoXhQifzqiFvgx0gPNMR/Aldp8SaeX
	Vgw8BRh6QYCAGcA9T7ZVaecx0Aexak9VDKw8OcEyKfOtslTjAp1Kr15ofXOxtxad8+CycyY2pAg8S
	GNcUv38w==;
Received: from [194.95.143.137] (helo=phil.dip.tu-dresden.de)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1uZnYn-0003fo-Rd; Thu, 10 Jul 2025 11:27:21 +0200
From: Heiko Stuebner <heiko@sntech.de>
To: Lee Jones <lee@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Sebastian Reichel <sebastian.reichel@collabora.com>,
	Quentin Schulz <foss+kernel@0leil.net>
Cc: Heiko Stuebner <heiko@sntech.de>,
	Lukasz Czechowski <lukasz.czechowski@thaumatec.com>,
	Daniel Semkowicz <dse@thaumatec.com>,
	Nicolas Frattaroli <nicolas.frattaroli@collabora.com>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Quentin Schulz <quentin.schulz@cherry.de>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: (subset) [PATCH v4 0/5] rockchip: rk8xx: allow to customize PMIC reset mode on RK806
Date: Thu, 10 Jul 2025 11:27:14 +0200
Message-ID: <175213962005.1887379.11523516137151032329.b4-ty@sntech.de>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250627-rk8xx-rst-fun-v4-0-ce05d041b45f@cherry.de>
References: <20250627-rk8xx-rst-fun-v4-0-ce05d041b45f@cherry.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Fri, 27 Jun 2025 12:53:52 +0200, Quentin Schulz wrote:
> This allows to customize the PMIC reset method (also called RST_FUN) on
> RK806 PMIC from Rockchip, mainly found on RK3588 devices but also on
> RK3576.
> 
> Finally, this is required on the two RK3588 devices from Theobroma as
> U-Boot changes the silicon-default (which is suitable for us) to
> something that breaks our companion microcontroller's reboot detection
> which breaks a bunch of assumptions in the MCU FW code.
> 
> [...]

Applied, thanks!

[3/5] arm64: dts: rockchip: add header for RK8XX PMIC constants
      commit: 92056b3afde6599f0e125a89c9483bad6930ea85
[4/5] arm64: dts: rockchip: force PMIC reset behavior to restart PMU on RK3588 Jaguar
      commit: 03b77bbb428250d8359bc76ff5032534d33f8499
[5/5] arm64: dts: rockchip: force PMIC reset behavior to restart PMU on RK3588 Tiger
      commit: b5c69adb3e27a5d31b733fbfbc32e5f036e21bed

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>

