Return-Path: <linux-kernel+bounces-783565-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C00B0B32F16
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Aug 2025 12:55:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7AFC04817D3
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Aug 2025 10:55:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF3892750E6;
	Sun, 24 Aug 2025 10:54:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="XJqZwGcy"
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E788184E;
	Sun, 24 Aug 2025 10:54:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756032895; cv=none; b=hw57O0Tf2jZsRHDz1p7BSOW33OEfp5QtLd4hZ+BwuH3bXpJyZ1msjh3DbRFxhdU4oo/06UTaUZTaYg5UlPwDEEv07/GR/lZXyERjrtl+dit0LRVPIBfruh7eNUUIJoFLHIJeXNBxaMTbpmEqh0gMmRCTuMjulAthlNON12WTHdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756032895; c=relaxed/simple;
	bh=UMwIhqyr78xgHudAFifY01mG3hBLVFcI7OupJOpmqec=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tEzWpEHHbGRM5uuh5/YorFT1M9vsbBIItUa37s04rCB/9a2l6HGxExgDMHsEm3n/KRes64wtPSYglhResyd8KJcIIP4l3x0UEGDf3Yorhsbas4HdDzBKF84FtzEKpB9+upwCT1wpk5+HoZAUiLjSytFQMiTboPU7N5v7FT2GmVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=XJqZwGcy; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Transfer-Encoding:Content-Type:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To;
	bh=vwyg9Z8kltpkwujmCcdDWk9z8Lamok2C0jIS+V5RVVg=; b=XJqZwGcy8Wl52H3OUT/jHm9gek
	41oZpndzhW1AS+dy8YwJH6Rjpomov/3xLy2wTPusBHm77v2OTqSbK1EitQYvd87DBqCgL9a7TnWnj
	hEvsUiS1e5rW4+s6n9XPmy4wYpJDO2XUWBCV1WMEf86EURYB63CveMl8Or+vwLfkPUZfbp65LG6n6
	MPIMVwRxNebMWF8ctbG/X1d47c8MNEwM7ZRoRng2H8tCkKa9dribwulr7QDXToqoqOYqp5tWZjZpq
	SI87eCS3ceCR9A/9hSsXMvu9ZTMIeR2nOQj2Jn6vbFsTdmabsfJscesPKD5CJ8rDAURiBrHB0Xsan
	VJ8Ny/uw==;
Received: from [62.245.128.201] (helo=phil.wifi.munich-airport.de)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1uq8N7-0005H4-84; Sun, 24 Aug 2025 12:54:49 +0200
From: Heiko Stuebner <heiko@sntech.de>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Sebastian Reichel <sebastian.reichel@collabora.com>
Cc: Heiko Stuebner <heiko@sntech.de>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	kernel@collabora.com
Subject: Re: [PATCH] arm64: dts: rockchip: correct network description on Sige5
Date: Sun, 24 Aug 2025 12:54:44 +0200
Message-ID: <175603280226.3445205.17256679636461186320.b4-ty@sntech.de>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250818-sige5-network-phy-clock-v1-1-87a9122d41c2@kernel.org>
References: <20250818-sige5-network-phy-clock-v1-1-87a9122d41c2@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Mon, 18 Aug 2025 19:12:23 +0200, Sebastian Reichel wrote:
> Both network PHYs have dedicated crystals for the 25 MHz clock
> and do not source it from the RK3576.
> 
> 

Applied, thanks!

[1/1] arm64: dts: rockchip: correct network description on Sige5
      commit: 09cce878427962a5c2a3a37d6cc52485a0134ac1

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>

