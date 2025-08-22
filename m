Return-Path: <linux-kernel+bounces-782269-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 56B74B31DEA
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 17:16:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 740036619BE
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 15:07:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 644431A9FA9;
	Fri, 22 Aug 2025 15:07:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="hXO651aH"
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 562BC3F9D2;
	Fri, 22 Aug 2025 15:07:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755875245; cv=none; b=tg5bYo+wLTZC3E3qKZwKbBtAiaypTRMGszZHADkXmcCvvNlcZhOd73l60O2Z2MZ2TnSoKadrSxGfJnxbXQ1w6hqHO4ONXsq9Vnemitfw4vHhC8v9/ZVfxJGgDGyH9a+RAjkNCef2VE/cy25fKroJ5zzfUs1inhH1pja/kabjUF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755875245; c=relaxed/simple;
	bh=fU2ORU4cOlSGX33IXl2CgMrG8x38iM8RTLwSMonKKTw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=p89RzLXVy4joIlGzu3V0uLHs/naAfXlAwGPqKmhfIrKP7FCsTp5Iay2qfxoDiHNRdsvRD3z2JwqSyrTp1W4aC+5M7SEXFzKADvTbwfewR30NgAtC7cZGvk0ueniBS6SQfhEtjNmqzV0Yi6PxwLGkU74nAky6Ask+PFxIBXt2HXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=hXO651aH; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Transfer-Encoding:Content-Type:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To;
	bh=ohAxfRMC3hfwx3bWNwqhsVIp9/GkRkVmDTq9tXa2hWo=; b=hXO651aHiuKcKK9LsfPxhe2tEp
	/8OWWYskvDMRuZTlbG+4fOkc9r7tDDxYQ0QqX/7RRpFesk0ufQbFKGouuGM6nqhVi2yDJBf3rZ/aw
	4FPAtzdypX427e2MTU678VK5lIBfIQmCAKbDrOc6E4MNirID2u/1RTotan2tqz2Ju8dyhS6LthjLL
	43+yXto27VZDs845hMcae/pE0gIiCsLmOYKLC+82oXRzGQ/p5ZM1dHoaT55M122dhefJfWdcvM9fC
	XevwYqlfLWY+mnN0oJzNkcj9ieqI9ZWjM7+7KCrwnpeV80xCvvwgCNA6xNl+wLL/DhNhjjq29AcRC
	orFl6uaA==;
Received: from i53875a83.versanet.de ([83.135.90.131] helo=phil..)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1upTM4-00016y-MI; Fri, 22 Aug 2025 17:07:00 +0200
From: Heiko Stuebner <heiko@sntech.de>
To: Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Frank Wang <frank.wang@rock-chips.com>,
	Andy Yan <andy.yan@rock-chips.com>,
	Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
	Detlev Casanova <detlev.casanova@collabora.com>,
	Shresth Prasad <shresthprasad7@gmail.com>,
	Chukun Pan <amadeus@jmu.edu.cn>,
	Jonas Karlman <jonas@kwiboo.se>,
	Yao Zi <ziyao@disroot.org>
Cc: Heiko Stuebner <heiko@sntech.de>,
	linux-phy@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: (subset) [PATCH v5 0/6] Support RK3528 variant of Rockchip naneng-combphy
Date: Fri, 22 Aug 2025 17:06:56 +0200
Message-ID: <175587519618.3220879.13156903990488376391.b4-ty@sntech.de>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250728102947.38984-2-ziyao@disroot.org>
References: <20250728102947.38984-2-ziyao@disroot.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Mon, 28 Jul 2025 10:29:42 +0000, Yao Zi wrote:
> Rockchip RK3528 ships a naneng-combphy that operates in either PCIe or
> USB 3.0 mode. It has a similar control logic to previous generations of
> naneng-combphy but an apparently different register layout.
> 
> This series prepares phy-rockchip-naneng-combphy.c for variants with a
> different register layout and add RK3528 support.
> 
> [...]

Applied, thanks!

[6/6] arm64: dts: rockchip: Add naneng-combphy for RK3528
      commit: 70bb21cbc8c704c664b5d3ea417f3e35376fc229

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>

