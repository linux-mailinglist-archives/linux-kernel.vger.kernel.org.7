Return-Path: <linux-kernel+bounces-782709-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 682D1B323F2
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 23:09:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E1E08568900
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 21:09:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63BBA2ED159;
	Fri, 22 Aug 2025 21:09:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="m50fFHfF"
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF4E6235355;
	Fri, 22 Aug 2025 21:08:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755896941; cv=none; b=I+NG5Lya00B2n3y0lHxNPwyQta8tIDCxkBJo9eZFl/2ad/C/J2g4Ws4iWmZkqmA9Pt2UZ/HligliHVofgk4x9ZiPrwbaugDUz49DyonMZKgobMSPW1L4Y7PlBbuTcUllFbk0TfQRHZ6S87Becqj3gRYafoqBaR8R9hzR8vw9Xbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755896941; c=relaxed/simple;
	bh=cfTElvMytB+f8/t/+lVoyM9KAY4OTHDEn0AZz76FBZU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=islPaCdtVqo1W1ZjRZD7mvlo2q3Cz0vRPt07nloh+MfHMdWEd2SG7mmlL4T/K2Iq/2rqw/IrFqQekS1UwZTKzatKaJR72stE6mL6j+06Qiky1ARgrbPeF6RM7IQudveuzGP1TfIEPBaJxe7X/2ssV/RLwiZk54NEHJRjXxtZyw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=m50fFHfF; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Transfer-Encoding:Content-Type:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To;
	bh=cypEHEpRR2kJqbcPVa7GjXp1ID7KVO6yBwZP58hpPu8=; b=m50fFHfFtMqgCcu9VSJ5v/1T6H
	rXZjeTd4nbm4TotaElmywFPoV8XWbvuSL8GfaN6a0xWhFP1p1hlUN8ukE7DdXvkYtnaWjfoG4D0je
	JC2lnZk/8KsCYsbU7QoRjO0hQVndHLLDaOe1i3U2ep9K0lAY7RWGhPeiEDWtCxbc+9se5lg8uEIxD
	LMATyPUYvXPGh7wsS4XepSWRK68sUL0SfF70hBPSFw85dmzzccZSp629CltlOpyppucRM1bRNIUJq
	DtYXKHHGXdselR2BtScg+0iTxTl/8apdFsRowbsNS1kCHLh2PbDTLr5VOOgZj+nmkxAlVGRVI3Yh3
	ObWwOPog==;
Received: from i53875a83.versanet.de ([83.135.90.131] helo=phil..)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1upYzr-000415-Uo; Fri, 22 Aug 2025 23:08:28 +0200
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
Date: Fri, 22 Aug 2025 23:08:25 +0200
Message-ID: <175589689704.3303128.5679950731528883388.b4-ty@sntech.de>
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

[01/13] drm/panel: ilitek-ili9881c: turn off power-supply when init fails
        commit: 6c66eba502709a78281333187c1add7b71f7201f
[02/13] drm/panel: ilitek-ili9881c: move display_on/_off dcs calls to (un-)prepare
        commit: 5efa82492066fcb32308210fb3f0b752af74334f
[03/13] drm/panel: ilitek-ili9881c: convert (un-)prepare to mipi_dsi_multi_context
        commit: 9002f55ee4480f23bd2ce91fb5fca536ce31717e
[04/13] dt-bindings: vendor-prefixes: Add prefix for Shenzhen Bestar Electronic
        commit: 8e484ff181b177ea2e86e537fd7a5c8f9d7532ad
[05/13] dt-bindings: display: ili9881c: Add Bestar BSD1218-A101KL68 LCD panel
        commit: 157ba8c6742931a617a34555c27dd10b36385cf3
[06/13] drm/panel: ilitek-ili9881c: Add Bestar BSD1218-A101KL68 support
        commit: 38dbbbb41c515d72b0a82fde3cec450d068f5e94

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>

