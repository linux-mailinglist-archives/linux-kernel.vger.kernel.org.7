Return-Path: <linux-kernel+bounces-732374-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 33C90B065E3
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 20:20:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7CA361AA571E
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 18:21:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5AB12BE057;
	Tue, 15 Jul 2025 18:20:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="hkoabe7t"
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4C5B8633F;
	Tue, 15 Jul 2025 18:20:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752603644; cv=none; b=WZvFBs+n/kQLvrT1Bv3j3ZCOoB62p5DY/GTkebbfAOHXerP8/IIuJ2+YMNKXj8xGJ/SlJ8TydUNKeIcNMafvStyGGrB4xQqP7xDT2itUZ3g/ylqONbMYKHqVGKILGMBKLgGcW7fjjLstYApdyn7D5CnCLMaCSxSNbdmm9kKySGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752603644; c=relaxed/simple;
	bh=m6z91b94D/zfbjWQ6vChPubCxrPay/me2kTyOx+oaVw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GASplgKTEZENtweRNLDu/k+mlFcuVklkMzR66+IDVtgYqWEb2e8LO9qhWZIWi8lCSybrCP2lHZSGzEIeBQG4WN0HTA6d8cG/aJZGV4TB/M3oyWvfWaH1EouWPOxaqHJJB01vXOvPmG8CdSafCGfdk1R1JVrCwHI/zMIC3VP2/oM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=hkoabe7t; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Transfer-Encoding:Content-Type:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To;
	bh=lkhFOYwdRSyGscGrBbX7jloahWVxL8wW1ddI4bWJmds=; b=hkoabe7t+nW2G2kXb3q34Tsv9z
	D7A6olUIkKsWjxYBFrZ5zUBmCITfYVuNdzFgE/gVxSXtwi0Y1F3UFVwbFupLCZkdNGOGFQf1krUx9
	albAA7yBIqtlQow2FnS+oi1M2ZK3RJF690e+LyEiMDvzvD3U91C3RU6/6AtwQFnTmm+TuT4BVaekm
	AGS2dOFGEkTqvr6LXLrQg521ji2ya5dCl6EVXR1Z5+C4OW7zmGZkAS/Rp3TjyQMuzh5ZXFHg/GprT
	jdjo/zqarZs0ydEbJZGOd7zFEbaEGR302jTqxyE+DI27yVZIjatKjUuA0idAjpVaJ2FNZkT0MRYMX
	bbofTJQw==;
Received: from i53875a5c.versanet.de ([83.135.90.92] helo=localhost.localdomain)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1ubkGX-0003l0-56; Tue, 15 Jul 2025 20:20:33 +0200
From: Heiko Stuebner <heiko@sntech.de>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Diederik de Haas <didi.debian@cknow.org>
Cc: Heiko Stuebner <heiko@sntech.de>,
	Dragan Simic <dsimic@manjaro.org>,
	Quentin Schulz <quentin.schulz@cherry.de>,
	Johan Jonker <jbx6244@gmail.com>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: (subset) [PATCH v4 00/10] rockchip: Fix several DTB validation issues
Date: Tue, 15 Jul 2025 20:20:23 +0200
Message-ID: <175260361882.2550944.901009051285494437.b4-ty@sntech.de>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250709132323.128757-1-didi.debian@cknow.org>
References: <20250709132323.128757-1-didi.debian@cknow.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Wed, 09 Jul 2025 15:15:13 +0200, Diederik de Haas wrote:
> This patch set fixes several DTB validation issues and consists of 2
> parts:
> 1) dsi refactoring
> 2) various low-hanging fruit
> 
> ad 1) The display/rockchip/rockchip,dw-mipi-dsi.yaml binding had:
> - #address-cells
> - #size-cells
> 
> [...]

Applied, thanks!

[04/10] arm64: dts: rockchip: Simplify VOP port definition on rk3328
        commit: 776d8e75d4a3a422a680648e30c5bfe607a99805
[05/10] arm64: dts: rockchip: Simplify edp endpoints on several rk3399 boards
        commit: 25937eb02f0a5a7e30fe97333ecc94ec5582ecb3
[06/10] arm64: dts: rockchip: Simplify mipi_out endpoint on rk3399 RP64 dtso
        commit: dfb549bbca62fe4b2c06bf203a3a9c1f86fcfae2
[07/10] arm64: dts: rockchip: Move mipi_out node on rk3399 haikou demo dtso
        commit: 4ac334d40e7022f091c65480cb7a01bc89135989
[08/10] arm64: dts: rockchip: Fix LCD panel port on rk3566-pinetab2
        commit: 8c17c938dd94f70fd37db476f8b965dd2775b874
[09/10] arm64: dts: rockchip: Drop unneeded address+size-cells on px30
        commit: 2fe00f4611637db677be51d7812dc177e4019b6a
[10/10] arm64: dts: rockchip: Drop regulator-compatible property on rk3399
        commit: b2501f327b8a136dbdd1fe7bad5d113eeda2827a

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>

