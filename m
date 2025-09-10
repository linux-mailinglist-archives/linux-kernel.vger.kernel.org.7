Return-Path: <linux-kernel+bounces-810708-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D2368B51E2D
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 18:48:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DA8235E72BE
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 16:48:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 703AC28641F;
	Wed, 10 Sep 2025 16:47:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s0zO5tM1"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C4B8285417;
	Wed, 10 Sep 2025 16:47:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757522859; cv=none; b=TFMF80Cl3nkhfMhy/roYyKJnSfbtClN1qzT4hGJ9IIpqP8/3fRwFo6aIZoTKDupyBz8xZQVLHHLM2H0dWHxZzUebLV8qBgrbgEbZ612nJwgDtXU8yRATpOnxRB97QphyGWhNxC3xxvdHRXvN9PpwcrAbGzIh9QoLGu/Q6k4UpM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757522859; c=relaxed/simple;
	bh=5LVOay0CBSTzKX6JQb+omIyOhnTXbtPDOJBt3OJI80U=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=HaQlR0cYb0dfIJpWNFDN/dVkFZKHYdg5kNVp82c3qLS7TeCq7KRf/yaof6YIOLeHKDjdQuxJTkqtBQR6HNv79vpZ1WtbpFMxKAzyu09qcWyNWTVPzHtlf2XWQHo9CJaWDmTxbRkS1D92oLF9AK6wDF3Rm+hpi6CYQPeC8ZXM+WQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s0zO5tM1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80388C4CEF9;
	Wed, 10 Sep 2025 16:47:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757522858;
	bh=5LVOay0CBSTzKX6JQb+omIyOhnTXbtPDOJBt3OJI80U=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=s0zO5tM1IFmM+YDTx3+eUjNq80Vk0WVQ5hpj3j1jEG1rmZUYEX1OZDKOH2XNRAS95
	 X1wL4schmp48KEFQjOmi6xash8eHMiP54yqP4d77D2PbfYJ1pCy4iriDnSECOUB8J/
	 b6q37uHO0fW/DgcgJgOmX/PUc1vxSP4xdQVyDPOJXwREgy8HpPhVEtsCAoo/OxOA3c
	 MVk68IchiwQ+qzWpwB9yGeuEDVtYocvjMvzOyxpDk+ww0bu38FiseL95MY2C3JPXYN
	 aPR4zTs9SJlWAM3bG2XXeprrgLvP8fm13dkSdhtrHem84BgZz4IyrWhCg+D+Z524yM
	 wm2qvXkYyiG2w==
From: Vinod Koul <vkoul@kernel.org>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, 
 Philipp Zabel <p.zabel@pengutronix.de>, 
 Kever Yang <kever.yang@rock-chips.com>, 
 Jagan Teki <jagan@amarulasolutions.com>, 
 Sebastian Reichel <sebastian.reichel@collabora.com>, 
 Diederik de Haas <didi.debian@cknow.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Heiko Stuebner <heiko@sntech.de>, 
 Collabora Kernel Team <kernel@collabora.com>, 
 Michael Riesch <michael.riesch@collabora.com>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-phy@lists.infradead.org, stable@kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20250616-rk3588-csi-dphy-v4-0-a4f340a7f0cf@collabora.com>
References: <20250616-rk3588-csi-dphy-v4-0-a4f340a7f0cf@collabora.com>
Subject: Re: (subset) [PATCH v4 0/7] phy: rockchip:
 phy-rockchip-inno-csidphy: add support for rk3588 variant
Message-Id: <175752285211.484319.18097786132863236205.b4-ty@kernel.org>
Date: Wed, 10 Sep 2025 22:17:32 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0


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

[2/7] dt-bindings: phy: rockchip-inno-csi-dphy: make power-domains non-required
      commit: c254815b02673cc77a84103c4c0d6197bd90c0ef
[3/7] dt-bindings: phy: rockchip-inno-csi-dphy: add rk3588 variant
      commit: 5072b8e98eef4685a5a9a8bae56072cb65a2ef69
[4/7] phy: rockchip: phy-rockchip-inno-csidphy: allow writes to grf register 0
      commit: 8c7c19466c854fa86b82d2148eaa9bf0e6531423
[5/7] phy: rockchip: phy-rockchip-inno-csidphy: allow for different reset lines
      commit: 260435153c90c8e90553e456ec43578834a14a71

Best regards,
-- 
~Vinod



