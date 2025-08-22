Return-Path: <linux-kernel+bounces-782721-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 52CF2B3241C
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 23:23:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0C3FCA04F89
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 21:22:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE6623314DF;
	Fri, 22 Aug 2025 21:22:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="MqjXmnGz"
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4393F2EB861;
	Fri, 22 Aug 2025 21:22:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755897755; cv=none; b=DsE6L2kQQaj0XuzgccGbSQbgZbWt0/tfiQoadLAabmxZaIqtfu6CayOuSGm8Nac7pcVMuVQgVC6EiY8PFmQCVWdS9+gAxS2mHMpfEUU3f8Xtazl/o3jT21AQnBCkQ8wJ1j+EyNg+TX3NmC7M4VELO8uXzYNI2t6mIWtwtssBaD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755897755; c=relaxed/simple;
	bh=8zlq2lGcS0m3Z+6f/hS7oqKA/SdpyGyLCfZ0xUdtWUs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZmQDairrv/+elsKAwa4dhOcyl8LfMaDD/HKk+4uIr2XaCxomlVtCtHeljILlRtox+riEANssXohvAcL9tBF2gJcp+3SykviavE75/VkLE28fEOqpL2Dzlr73fOaI9pBqc8iAw2euzv1mxA3VaQBvXFobb8VGyYaiAHcs/J37wME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=MqjXmnGz; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Transfer-Encoding:Content-Type:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To;
	bh=MUyMAIJnbkOdcwtpYR/h4OiFxPawHL+4XS3+iNmUVuU=; b=MqjXmnGzSVAi7K9hMP41rVxp3H
	ZmIMpPrHojZ+uFniw/zrIG8lzmZQLGtvBp0p4cAKVhYj7dBBuCqsOIrVoNjazjh5+PnmT7I3FwM7/
	zIcVNaHivTP9nm4dZgEQVTtBvmEq2o7XvUsdu2PaavVIW1eUQS9GPVVTWpAv+J8PecKuRsbumGx8E
	yyxrGDmMfzwZ6jV2e/cbOYWZOL6eGqg/szMr+AhHkwsfkYl96E+3AsGRYslHk5mPc85CR9XMjgQzR
	7bGVtxiNIW0Uz23MNIxJSm5qmOze3zMqc33KvSgqpqjdw49k/IPwWqZ5DoBDf/UGmNoihdU6ssReP
	fUkCUIKg==;
Received: from i53875a83.versanet.de ([83.135.90.131] helo=phil..)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1upZD7-0004lj-An; Fri, 22 Aug 2025 23:22:09 +0200
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
Date: Fri, 22 Aug 2025 23:22:06 +0200
Message-ID: <175589772390.3317579.11344569273616285700.b4-ty@sntech.de>
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

[07/13] dt-bindings: soc: rockchip: add rk3576 mipi dcphy syscon
        commit: 0e3f3d7c7ae3dec5ff52325915e3efcbce652a82
[10/13] arm64: dts: rockchip: add mipi-dcphy to rk3576
        commit: 21bc1a7fcea4635a49f6b2eff3e4c661e80e8f43
[11/13] arm64: dts: rockchip: add the dsi controller to rk3576
        commit: e51828f80df99a2899e263b750cada6426f14c92
[12/13] arm64: dts: rockchip: add vcc3v3-lcd-s0 regulator to roc-rk3576-pc
        commit: 3d5c0c21d86fed05caeae43549e0c13ddd203c31

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>

