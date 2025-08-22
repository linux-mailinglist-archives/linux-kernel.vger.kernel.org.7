Return-Path: <linux-kernel+bounces-782714-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B0FC5B32409
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 23:18:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2EA5216AEE3
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 21:16:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A927D334364;
	Fri, 22 Aug 2025 21:16:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="fynZ0aC+"
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 989F82EB861;
	Fri, 22 Aug 2025 21:16:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755897369; cv=none; b=Kym1Cbp2BCLc2un1MQa1ter3wSP5P3kt/ZNLVAUcj+1QuBWvHmuBOAJVuOngiJkH4vA973Zeg6dowb27s8jEqil5GiaNUmNsVd57I/HcX0PIVjiggE2OHH7siHA41EG0IB9jlMA7ec+pbAkAVAb6e321NgNfT1jVO65U8z7/qBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755897369; c=relaxed/simple;
	bh=ZB+oCURk+FKq3Yr7Udo2n/2oBoAQiUJpcsqJiCSCiuE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=amSYdhJ0oA1YuQK1Q1np8f8WtiV0zRXCLuifj/q6S5ogQZnleXzPkcV0lzPa6oCezITmL/VxDyhlQSPDOGvEWQqdQOpqyE+T/v3lAFYVONvsJj4gZxHGYuAYsbJu4IDh/t5utQkddLFGWsr1zQSeiTcUxRGvlx8yasZFsrBnB+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=fynZ0aC+; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Transfer-Encoding:Content-Type:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To;
	bh=il8hQMyYfXw8Tzc5sMl2lQfGh5RbcWxWYW3ucD/cb6A=; b=fynZ0aC+YlzyqDD4FY9zewVQIF
	56ZPhZCK4JrmqwCsIFYyjHXl4Gn5RzbWhahxobiC0G3VrpBzWVMLX84iQvYgLICQoi/N1nxs57xV6
	Cs5buzQUXm/qj9j26+HWra+6mZL6k3nLJptNO+yZFZgXk4I8osr9fFBI8sufkxIB8dsE73RwJQiXs
	dOzEnM6jM308RctZLplYa7BBArafztWwqvyxLGyXm4WgLykBfh5rvZqhCwXRntKD98+oECQT7aI9f
	I64phKLZX8Y0ALyhm6/gB7/wYxp+5DAMiqMsQRkq1mOWXHBcu8oLjYOM7nnDx3ibZ+Wvilg/kanQc
	LiaCQm9g==;
Received: from i53875a83.versanet.de ([83.135.90.131] helo=phil..)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1upZ6x-0004T7-IZ; Fri, 22 Aug 2025 23:15:47 +0200
From: Heiko Stuebner <heiko@sntech.de>
To: Heiko Stuebner <heiko@sntech.de>
Cc: neil.armstrong@linaro.org,
	quic_jesszhan@quicinc.com,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	hjc@rock-chips.com,
	andy.yan@rock-chips.com,
	andyshrk@163.com,
	nicolas.frattaroli@collabora.com,
	dri-devel@lists.freedesktop.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org
Subject: Re: (subset) [PATCH 00/13] Support DSI output on rk3576 and roc-rk3576-pc board
Date: Fri, 22 Aug 2025 23:15:44 +0200
Message-ID: <175589734234.3314397.11816121357365151257.b4-ty@sntech.de>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250707164906.1445288-1-heiko@sntech.de>
References: <20250707164906.1445288-1-heiko@sntech.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Mon, 07 Jul 2025 18:48:53 +0200, Heiko Stuebner wrote:
> This enables all the necesary bits and bindings to get display output
> on the dm-m10r800-v3s addon module for the Firefly roc-rk3576-pc board.
> 
> A bit of cleanup of the ili9881c, because the driver was still trying
> to send dcs commands when the underlying DSI driver might have already
> switched to video-mode, which caused me quite a bit of headache until
> I realized this being the culprit for my garbled display output :-) .
> 
> [...]

Applied, thanks!

[08/13] dt-bindings: display: rockchip: Add rk3576 to RK3588 DW DSI2 controller schema
        commit: f05530bdaf42aa0e6bb4cde76ba6a081cf473d44
[09/13] drm/rockchip: dsi2: add support rk3576
        commit: b6f11f114759a088acf44e86b5cd72f24de85d44

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>

