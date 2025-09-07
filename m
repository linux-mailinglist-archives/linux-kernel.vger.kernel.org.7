Return-Path: <linux-kernel+bounces-804754-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AA585B47C93
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Sep 2025 19:30:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 710893B6C98
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Sep 2025 17:30:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC10A285042;
	Sun,  7 Sep 2025 17:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="m9KSs/W2"
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE8901DE3DB;
	Sun,  7 Sep 2025 17:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757266233; cv=none; b=Xwb1DaP91ZKgnojxQ/37Sqx3VPiuxnTuA17/Vd2Y9TgSTcAHCUVoqTBneHmjBYljMBMiRSfKAwHIooHFxXwVSVceoS2s2JsmVkdca4Y92LZNC56dCePd8RIPb36ZtXFFUPkbSGoosRox8JFPrYTeBOHib5DvicUO+/fQOw9CGHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757266233; c=relaxed/simple;
	bh=fgLTMyaCQ0OcK8llm4szDxgZbA432B7hXXzTNC9FQ6E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=McQgZp/2FH/GmazE1TXc+TTtEh8oKOFJwZrSEdlu7Ona7lOObXskGLcdR7V0/DPIa6WpNJKTrifvPeOTG6ZcwXNGxmMH0sv5rdish7zPf+GLGCp8+wFYyp1vizCdSFvPZAs8ZW5a40t7tjDuK+iR/aPCnsqK4tvB/YtZK8QcwLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=m9KSs/W2; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Transfer-Encoding:Content-Type:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To;
	bh=VFuG/8nZb4eVJ5UiKdHvsABqzXbNy5nmmF5KkQCHiw0=; b=m9KSs/W2ZV6YVhiXV1ECPX2vKD
	+o2h8UUPBOWVMzKw2GAnPbEBfcduwFTekGW1MigwFNoLfpCVWSYS50tJEDGcD3VyJbEnmSYaPX/vq
	pH4IgmXZ+DvmN/7+iyG/oYOvunyxtxONYXABQ8tBCOO2b3YxI6frJvBkyRn761u3LBUsKCpviyoMb
	L7xoMdCbhOgSOsX4bQFfnIlVPozUaRDxOKXrQs7dGsmWg6HODDw2mQr3TYw9PWPaAbAny4r9+8FrV
	DoRIcZYrp4K7yB7pOwGQCcKDpy0L3X7CYzVZO6MsNszer68gFbp9ja7PEhMNowPPNNHlEtKDq4xkV
	EVyr/V7Q==;
Received: from [61.8.147.163] (helo=localhost.localdomain)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1uvJDa-0004Ii-UM; Sun, 07 Sep 2025 19:30:23 +0200
From: Heiko Stuebner <heiko@sntech.de>
To: Chukun Pan <amadeus@jmu.edu.cn>
Cc: Heiko Stuebner <heiko@sntech.de>,
	Yao Zi <ziyao@disroot.org>,
	Rob Herring <robh@kernel.org>,
	Jonas Karlman <jonas@kwiboo.se>,
	Conor Dooley <conor+dt@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH v3 0/1] arm64: dts: rockchip: rk3528: Add CPU frequency scaling support
Date: Sun,  7 Sep 2025 19:30:09 +0200
Message-ID: <175726620393.195224.5931454450160072348.b4-ty@sntech.de>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250801080025.558935-1-amadeus@jmu.edu.cn>
References: <20250801080025.558935-1-amadeus@jmu.edu.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Fri, 01 Aug 2025 16:00:24 +0800, Chukun Pan wrote:
> By default, the CPUs on RK3528 operates at 1.5GHz. Add CPU frequency and
> voltage mapping to the device tree to enable dynamic scaling via cpufreq.
> 
> The OPP values come from downstream 5.10 kernel, using a voltage close to
> the actual frequency. Frequencies below 1200MHz have been removed as they
> currently use the same voltage.
> 
> [...]

Applied, thanks!

[1/1] arm64: dts: rockchip: rk3528: Add CPU frequency scaling support
      commit: 42bbc32c7e9e974ae4eb830ae1381cb016133e5c

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>

