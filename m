Return-Path: <linux-kernel+bounces-798670-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E8104B42140
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 15:23:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1798C169B1D
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 13:21:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E406E3019A5;
	Wed,  3 Sep 2025 13:19:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QFWQ4QR8"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BDF3246BA4;
	Wed,  3 Sep 2025 13:19:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756905569; cv=none; b=REtl4h0oY9rneLiPWqwUaTBC/Tv+8+hBzvAqSOdhIZt1BUPkpVR8kuC1a+9TzuCn8huvMBQ7qkjwYpv4N639Tdvo3M3FHTCCkSQgwjbHr64rXQwZageYXchOf8ZAXGCDE5APJ9K2/RME9TC7ajEfCxAzOAeTL+BCu9GfCazk+kA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756905569; c=relaxed/simple;
	bh=60cH5L24WXT63BCrBq1FYkghtOxWAn0dwvQF6mJ9L04=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=qlECSjs/x4S0UwLWaepO/CQQ/egSBIGWR5Xqs1EKctiCQiUAjaL8kYlyjfyiQ3do8aN07OpDwTNFcyIu3u/bXeBhuG/I5zYEz5Gc8uWWsnBtTmPs+r0dg7oAsWdGdXZi2u9hdu3VOLheIkl8X9s/KxX0PHNVpR/hqEOkM0soqI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QFWQ4QR8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 638EBC4CEF0;
	Wed,  3 Sep 2025 13:19:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756905568;
	bh=60cH5L24WXT63BCrBq1FYkghtOxWAn0dwvQF6mJ9L04=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=QFWQ4QR87fyUb0GlwBGXv1isC5Lqo70GFiPrDRiVUy6BsAl3Muj0w5Qqh6tWXzcQt
	 mR6ZWszlS/WqC1qg7UJMA4gqWgNnW7DqrPIUpKfPSfK5aNDvXHDJxVsZLe3yvjMB3p
	 PbxQSpOS7anLB561F55d+3Rg5YSITbv8D2PC92PwSEkhJyGTxiKgwc0YSZ8zM8TNka
	 j34bvWzkteY2MBDIvenNlsVjoFocRu21anJ4eT8OgEZcYcqEJviTZftdFoLQ02s4Ye
	 JIdrVjc+pKA5CbrS9hLw/eoO6pC0yuNaK/yQEGzltQoFfIBVXMXPuL6Gqmu77tkVVw
	 KrSIG8On6zR9Q==
From: Lee Jones <lee@kernel.org>
To: sboyd@kernel.org, Conor Dooley <conor@kernel.org>
Cc: Conor Dooley <conor.dooley@microchip.com>, 
 Daire McNamara <daire.mcnamara@microchip.com>, 
 pierre-henry.moussay@microchip.com, valentina.fernandezalanis@microchip.com, 
 Michael Turquette <mturquette@baylibre.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Jassi Brar <jassisinghbrar@gmail.com>, Lee Jones <lee@kernel.org>, 
 Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Philipp Zabel <p.zabel@pengutronix.de>, 
 linux-riscv@lists.infradead.org, linux-clk@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Gabriel FERNANDEZ <gabriel.fernandez@foss.st.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20250901-shorten-yahoo-223aeaecd290@spud>
References: <20250901-shorten-yahoo-223aeaecd290@spud>
Subject: Re: (subset) [PATCH v4 1/9] dt-bindings: mfd: syscon document the
 control-scb syscon on PolarFire SoC
Message-Id: <175690556514.2759012.354928606494922577.b4-ty@kernel.org>
Date: Wed, 03 Sep 2025 14:19:25 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.15-dev-c81fc

On Mon, 01 Sep 2025 12:04:13 +0100, Conor Dooley wrote:
> The "control-scb" region, contains the "tvs" temperature and voltage
> sensors and the control/status registers for the system controller's
> mailbox. The mailbox has a dedicated node, so there's no need for a
> child node describing it, looking the syscon up by compatible is
> sufficient.
> 
> 
> [...]

Applied, thanks!

[1/9] dt-bindings: mfd: syscon document the control-scb syscon on PolarFire SoC
      commit: 61e08b3e5b2d21efd0459643f1003ad41497507d

--
Lee Jones [李琼斯]


