Return-Path: <linux-kernel+bounces-811690-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C6F52B52CA0
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 11:06:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 864BD175DBD
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 09:06:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4673B2E7F31;
	Thu, 11 Sep 2025 09:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="WJNoCw2W"
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40B56221F0C;
	Thu, 11 Sep 2025 09:06:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757581561; cv=none; b=abG8SVBU4xdEGOfsKs3tYARRjwnlx99lA7iui9gK7qLTMgOH9+ThU/61fiDo8bPN7euNN9ibjYx9/KpTuanf+jPNejdXRrmhIzIBV+JX4Vbscd3kCqk/Qftj9PkdllnZyF3DMI0CQ45jMGgyJp54N6nzo85VrJvCy6L54GScLHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757581561; c=relaxed/simple;
	bh=K62nCi4Wi1+HiFrPD0CG2FSWyKAtQEmeHOEbvAgPOeQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rUQWocXBoAk6TU4i48FUIkc5hIwTICnokBnZJizKxSyE6mFZtDpEWg7KwIpgcKqbxQjMDDNmg5XYOajdTIVG3FuiK7qnQyu/1sIrJ+fIQYvId/zCNZ8ovbeTLlKnLp4boZR/vRKUB7h4uD1BGupbaV08TRaMcGmnG5SLd8jWnUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=WJNoCw2W; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Transfer-Encoding:Content-Type:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To;
	bh=cej5DMxhg1NtNzRRvje5njCeicTXDAKaR1Lh4aeMCPE=; b=WJNoCw2W6vlFy/tjv+9eVO3xlO
	/cPnJ4wkK5Vc2DbkHJeZkrKRrF8BPry0QLn18fKzktbGuvQeNtXuHl7G3Vmx6hpUAbRp5oSRdXoU0
	Tc6IUTcdtbWFi7XkhGcxrPK2H8dyJ7JXscamDitlNPyVVN4fT6j5woGaB1QnIddpV+Hz3/hePpZYi
	OAtr8lLzJU/A9vHyTeMyG9uEDDyyfbm8gBCAN0Kwz80ThDRvGIw8+dYuVCEseAmecvIqPf9dLz+dk
	cXm2v7bd1K3cxM4u7+tkZMyNqpjZvNvPoONDQtVddk7g5PoS/bcERjuGoPCjNf6PL6xYbLWmIVEmn
	/FVkl2Tw==;
Received: from i53875b0e.versanet.de ([83.135.91.14] helo=localhost.localdomain)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1uwdFb-00005b-JV; Thu, 11 Sep 2025 11:05:55 +0200
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
Subject: Re: [PATCH] arm64: dts: rockchip: Fix network on rk3576 evb1 board
Date: Thu, 11 Sep 2025 11:05:44 +0200
Message-ID: <175758154013.610665.7420825533435349040.b4-ty@sntech.de>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250910-rk3576-evb-network-v1-1-68ed4df272a2@collabora.com>
References: <20250910-rk3576-evb-network-v1-1-68ed4df272a2@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Wed, 10 Sep 2025 15:54:51 +0200, Sebastian Reichel wrote:
> The RK3576 EVB1 has a RTL8211F PHY for each GMAC interface with
> a dedicated reset line and the 25MHz clock provided by the SoC.
> The current description results in non-working Ethernet as the
> clocks are only enabled by the PHY driver, but probing the right
> PHY driver currently requires that the PHY ID register can be read
> for automatic identification.
> 
> [...]

Applied, thanks!

[1/1] arm64: dts: rockchip: Fix network on rk3576 evb1 board
      commit: 843367c7ed196bd0806c8776cba108aaf6923b82

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>

