Return-Path: <linux-kernel+bounces-765291-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A890B22DF6
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 18:43:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 49BF17ACD23
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 16:42:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2CDF2FE57B;
	Tue, 12 Aug 2025 16:41:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T/kTdtEh"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 030492FE571;
	Tue, 12 Aug 2025 16:41:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755016906; cv=none; b=KxIb2ERVvGlqCMklAjimZfMEtUu967fKDdd9VTuh3uYvb3yWVsFtQNJM+ETjnzok1B0B1Y/oZyWfOUgC321WNyTVcCqJm/Aqr430gh6UPTP2PXpBqNR1TxWSor4iWHAWs4jmU8IhoyEB/G9g5C9cnUXu444bqylygCfHFP5hdt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755016906; c=relaxed/simple;
	bh=QGGDJtpzAvDGfqv7vg9yuxITaE/1e8imJeia0T1EH14=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=ojqULRFGoniM7bYHxQtNZsUqb09Rniv/YPtSnOUB2cxr/8lS+FgHiDdpFk6XElRiOHhFwm+2crdiMB1rRQOkNj9QjqPKCyjpf96zIQzLMQOK77uakFRQMGwfirukGhNkmpBd6OQgoHZk2SR1y3UbEH9yybF0yU4ntHoH2Kyf/a8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T/kTdtEh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57B88C4CEF1;
	Tue, 12 Aug 2025 16:41:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755016905;
	bh=QGGDJtpzAvDGfqv7vg9yuxITaE/1e8imJeia0T1EH14=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=T/kTdtEhphOT6xszjdKktCKpnJpfZa5VEwMlu+vUa4rn37Qe7G6XfB5had/tshpCT
	 dKCJtPpwMY5mlN89kaeWEyCs2IesyHvzUj7WMcStNXTkp9KwDGuHpOjRzeUdmUkOQi
	 jeuQd/v6m8VGR9de5HDYzGXpn24NdCDY07RoaMj3IScRqWuVEyqKERtzoao+6pRdSN
	 9DhZycyPdSIwSY3WLvHPYdG/RZ/6YuPsBoB/wRIv9MRS5lrdh1bZVutkQlBME8rj3w
	 nOUm7fqbxZqxqssQ4c6Wr/W2f8t+Jhu5KLpiKcZe2TPSBD4psDFdK4MoJoNFM5Ax/M
	 kRjCYuRti3Bog==
From: Vinod Koul <vkoul@kernel.org>
To: Kishon Vijay Abraham I <kishon@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>, 
 Frank Wang <frank.wang@rock-chips.com>, Andy Yan <andy.yan@rock-chips.com>, 
 Cristian Ciocaltea <cristian.ciocaltea@collabora.com>, 
 Detlev Casanova <detlev.casanova@collabora.com>, 
 Shresth Prasad <shresthprasad7@gmail.com>, Chukun Pan <amadeus@jmu.edu.cn>, 
 Jonas Karlman <jonas@kwiboo.se>, Yao Zi <ziyao@disroot.org>
Cc: linux-phy@lists.infradead.org, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20250728102947.38984-2-ziyao@disroot.org>
References: <20250728102947.38984-2-ziyao@disroot.org>
Subject: Re: (subset) [PATCH v5 0/6] Support RK3528 variant of Rockchip
 naneng-combphy
Message-Id: <175501689991.633310.3061565953624951232.b4-ty@kernel.org>
Date: Tue, 12 Aug 2025 22:11:39 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0


On Mon, 28 Jul 2025 10:29:42 +0000, Yao Zi wrote:
> Rockchip RK3528 ships a naneng-combphy that operates in either PCIe or
> USB 3.0 mode. It has a similar control logic to previous generations of
> naneng-combphy but an apparently different register layout.
> 
> This series prepares phy-rockchip-naneng-combphy.c for variants with a
> different register layout and add RK3528 support.
> 
> [...]

Applied, thanks!

[1/6] dt-bindings: soc: rockchip: Add RK3528 pipe-phy GRF syscon
      commit: d7122636eca216ea2876baae45483d17e40a55f6
[2/6] dt-bindings: phy: rockchip: naneng-combphy: Add power-domains property
      commit: 19bb2bfdfa5dc4a912e7e5e3432290204e998ac9
[3/6] dt-bindings: phy: rockchip: naneng-combphy: Add RK3528 variant
      commit: d9e0fd60d8d44b2cabd41f5e370e9d41edffe6e9
[4/6] phy: rockchip: naneng-combphy: Add SoC prefix to register definitions
      commit: 11f1896e60f61ca1948cb7920585a79ce5254c0c
[5/6] phy: rockchip: naneng-combphy: Add RK3528 support
      commit: aee07ee1b97d9a3825e8db609a1c76157218cc59

Best regards,
-- 
~Vinod



