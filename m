Return-Path: <linux-kernel+bounces-794375-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 35B0DB3E0C4
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 13:00:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 35DFC4E2566
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 11:00:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80823311592;
	Mon,  1 Sep 2025 10:59:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="RpaGy4XL"
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09BF03074B0;
	Mon,  1 Sep 2025 10:59:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756724386; cv=none; b=AYCfJWieIL1LjkZvmhUo7Djj6eSzBSBvbWlEwetWr33RS+3sVwPQHORAEKfbG+Mu0tmP/Ic/x+lJ/9npiFXKeGl3XwZPoQNKmAaLHXK2tjA3wMhPDgf9aM2mNRFxTQNtC719NPyoBoe64nUZ16PKhOdXtdoA3XnRFOh7zswh9ZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756724386; c=relaxed/simple;
	bh=lAx35WFmw7lEUlTWnVH6iTLTCvjL7HeXgxfmiuXIeEY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hirtEzaTFJDvwsqRBes8IUdETuouB2ustgrAnGpAHteB21v0J8kYkZ78eprfyQL2xntAT58ZpQvUrMeyNWKK00OyyJmbQ+987WRite28N56TE1mHd4+qT26x+0tIzToKtgEKMOGvFM3xAqkAVgep3R4mABdmHqJpJP8mIy38mtw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=RpaGy4XL; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Transfer-Encoding:Content-Type:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To;
	bh=b8jTxoxu6fM2YyVPoK/aAvaCJ5ksiaw3bZKSjKUEM/U=; b=RpaGy4XLA2c8YZbgeSDDso6S1v
	Oq+FsFM7XHisXgM9rW4mmHd7SdV6y32fbWlLjPI0RAygFIsPgPoNluuqQZNVroLT/F2auR68tNQ4Y
	tiFfd+Dvh6V+OKoRhvvhyTTOmD3Bv9hdYlxB496hP52VeyuFbv5NTQOkwlXef959spGX2yfhCzNfx
	sb8GcCicl0XC1MJ5GHahwYid1616J5X2RvY35RwumHQsoDxueaks1SRe2oZJc/DtHriO5UQZP0xfz
	DrphtNNohbV6b9/EXMt+SoT1VWC1fy+LCtWlVB60NP6CE/Eez7CjZ0pZWPSgxz+KN5AhY66C73Gux
	zLLCRaVQ==;
Received: from i53875a2d.versanet.de ([83.135.90.45] helo=phil..)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1ut2G3-0001WA-HP; Mon, 01 Sep 2025 12:59:31 +0200
From: Heiko Stuebner <heiko@sntech.de>
To: dmitry.baryshkov@oss.qualcomm.com,
	Andy Yan <andyshrk@163.com>
Cc: Heiko Stuebner <heiko@sntech.de>,
	hjc@rock-chips.com,
	mripard@kernel.org,
	naoki@radxa.com,
	stephen@radxa.com,
	cristian.ciocaltea@collabora.com,
	neil.armstrong@linaro.org,
	Laurent.pinchart@ideasonboard.com,
	yubing.zhang@rock-chips.com,
	krzk+dt@kernel.org,
	devicetree@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	robh@kernel.org,
	sebastian.reichel@collabora.com,
	Andy Yan <andy.yan@rock-chips.com>
Subject: Re: (subset) [PATCH v7 00/10] Add support for RK3588 DisplayPort Controller
Date: Mon,  1 Sep 2025 12:59:27 +0200
Message-ID: <175672432555.3612134.264758265580488174.b4-ty@sntech.de>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250822063959.692098-1-andyshrk@163.com>
References: <20250822063959.692098-1-andyshrk@163.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Fri, 22 Aug 2025 14:39:44 +0800, Andy Yan wrote:
> There are two DW DPTX based DisplayPort Controller on rk3588 which
> are compliant with the DisplayPort Specification Version 1.4 with
> the following features:
> 
> * DisplayPort 1.4a
> * Main Link: 1/2/4 lanes
> * Main Link Support 1.62Gbps, 2.7Gbps, 5.4Gbps and 8.1Gbps
> * AUX channel 1Mbps
> * Single Stream Transport(SST)
> * Multistream Transport (MST)
> * Type-C support (alternate mode)
> * HDCP 2.2, HDCP 1.3
> * Supports up to 8/10 bits per color component
> * Supports RBG, YCbCr4:4:4, YCbCr4:2:2, YCbCr4:2:0
> * Pixel clock up to 594MHz
> * I2S, SPDIF audio interface
> 
> [...]

Applied, thanks!

[07/10] arm64: dts: rockchip: Add DP0 for rk3588
        commit: 8c239f24341ab9ac75992a0a3c32bb8cddf48a20
[08/10] arm64: dts: rockchip: Add DP1 for rk3588
        commit: 445e4ac0d85821904b3f2bee410def4181987c4e
[09/10] arm64: dts: rockchip: Enable DisplayPort for rk3588s Cool Pi 4B
        commit: 1b242cafdfc4bc7d43ed9147cbffe5480632f661
[10/10] arm64: dts: rockchip: Enable DP2HDMI for ROCK 5 ITX
        commit: df02252f271b4fa50c7087a0e6f5a7d7ed2f1dcc

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>

