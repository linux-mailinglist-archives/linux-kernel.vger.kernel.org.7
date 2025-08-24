Return-Path: <linux-kernel+bounces-783465-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E35AB32DEA
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Aug 2025 09:09:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7A0E9200E38
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Aug 2025 07:08:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76C8D254873;
	Sun, 24 Aug 2025 07:08:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="UeIRc+bm"
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E27824EAAB;
	Sun, 24 Aug 2025 07:08:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756019288; cv=none; b=noE4fW1FSfR6UEvc9oD7/1ooOVlFd9OQtbWy21SpJoiBC2qgKZB4+pnkW1Y6yhtqHnbjaDGc/wkNaEQqinE31FTayL4734Jf7tgu5z2yuhaGBmxyc2AVitz0dQ6bt0Y5Ob9T0ugp5og8LLlXxaX5XvgmJKflEOxFsp2r1cfyqbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756019288; c=relaxed/simple;
	bh=CB5n4KWWYVda8TRUy78jTo49jEkJBsq+iJ2yD5lYtO8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Yslz4hOBj4mDZkoXPqBK9+x/jFDIDLCdY/4Hc45+jEm10DOd8dygzdNDiAO56Vkh5kQnH3+p3wS7fcaT7eWic0wUOfdnCEzmcca7V9ApVgZyEHDK4PLNvkORSFBrIE/j88FmMNLDoYFiYYIDlWe2DDXwHT18tPfk6cQqEDDp6pI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=UeIRc+bm; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Transfer-Encoding:Content-Type:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To;
	bh=AbIEA6FrWytQiEVgDAOyKyyO3ZlP3FJYDn4qrDVk2b0=; b=UeIRc+bm0k10Jgu0XpAHqhUtot
	guyc76rCEkuIX5VLJ7GQMsLejUFCNsgJadOY/eK4Gx6uKmMg358e/RxtmIM7slW1+GWwZwFVpFs8w
	RpnXOEOk4s6JNp5Wo80noau1en2M18gElJno3aF1CBhSnjihz6npAJMnnQPpivP049UxUYeyzCT0L
	xQ1urYIYWpTwT6xCELhfTFIVcyM+eJ7nAPQn9WYevatPEpHbXh+G4NUnfLNtCmVDE9nqWTIbRARK0
	NaG/0HUAKMenLECsbaY7pUhzoMVFhiRN56uTDTZbFxbw6wiwW0xE0ALANiuUTroM/MLG5UOSkFdMn
	50R6OmZw==;
Received: from [212.111.254.164] (helo=phil.aerolan.de)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1uq4pb-0002Oo-OB; Sun, 24 Aug 2025 09:07:59 +0200
From: Heiko Stuebner <heiko@sntech.de>
To: Chen-Yu Tsai <wens@kernel.org>
Cc: Heiko Stuebner <heiko@sntech.de>,
	Chen-Yu Tsai <wens@csie.org>,
	linux-rockchip@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: rockchip: rk3588-orangepi-5: Add supplies for eMMC
Date: Sun, 24 Aug 2025 09:07:54 +0200
Message-ID: <175601920180.3425909.3489493735708204537.b4-ty@sntech.de>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250821052939.1869171-1-wens@kernel.org>
References: <20250821052939.1869171-1-wens@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Thu, 21 Aug 2025 13:29:39 +0800, Chen-Yu Tsai wrote:
> The eMMC description is missing both vmmc and vqmmc supplies.
> 
> Add them to complete the description.
> 
> 

Applied, thanks!

[1/1] arm64: dts: rockchip: rk3588-orangepi-5: Add supplies for eMMC
      commit: 2dea24df234940b27d378f786933dc10f33de6b8

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>

