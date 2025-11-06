Return-Path: <linux-kernel+bounces-889469-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D64F5C3DB5B
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 23:58:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7B6EA188D2AA
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 22:59:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4FB234EF1B;
	Thu,  6 Nov 2025 22:58:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="ZPFSJYhh"
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A70463081DD;
	Thu,  6 Nov 2025 22:58:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762469924; cv=none; b=E9+dnQ3MWalATal6EBjXREGfFBccO6tEz/3WqPvNFwuUpasG9VFxdGNRJ6j+dPcBjx1Mcleg16DwIBFm/4xjqCZnGVeE89NLqh7LZX0yvnxKU4vdqyzfxb7+thyWeXtU8jebbW+m1CiTnCgwucd5STqWz1Cja5MIS9Y/wDt8VYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762469924; c=relaxed/simple;
	bh=AFICj84jWxdNccawZTa69XmaXce1yyvcQ/AX4LopSrc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SNuSwJVWAC3c8e4z/zde3XYPB2c+U0j1A+PLYqnJ/kwvuT8944u9VE/xQE4cWNnGoL/hZkhffpY2OqQlAPNkA3R4AlVO6gkcUoYBuqDx2ypZaZ6/l7x9bGUVcR+i9DuuwZ5JRn2F8BBdNmM6rIMiioAyh7gfzL8Gc5sjr4hEvOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=ZPFSJYhh; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Transfer-Encoding:Content-Type:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To;
	bh=66drUzeJX6dC+QazFCafnL4iFqkKi3oQMXaB9Tb7WcM=; b=ZPFSJYhhgvdGSqHJsmjYioP6XU
	iWy7sNTs8wyyXn/U0r6s4afa/omTIMnDQ1l/4dIoq+HU0dAyN57wwHJtYzIhpG2L3GRFwRCWdC/oQ
	hJhQcAMao/ikKUkV+4owK26FjNGnyorWIC2sGROe60yKXDtNZJvhXTxAFrIoB2vPHXLYkxj5OtVl+
	5M0l+4mbeFV3627ToS+wW7dl1FtXIkHwVbyADhtZdf6OheU9tzFoRDs2ycwh/yVR5B3HDoL71a4Ru
	UeDhvPFKrFlogEBgv6Ag37glzywbvRKvvpIxVP0yPnBG3wXUAYi8BQE5IBSCkH7/yF7auo01E0uVu
	IvOtQLVQ==;
Received: from i53875bac.versanet.de ([83.135.91.172] helo=phil.fritz.box)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1vH8wA-0001pr-7L; Thu, 06 Nov 2025 23:58:38 +0100
From: Heiko Stuebner <heiko@sntech.de>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Dragan Simic <dsimic@manjaro.org>,
	Jonas Karlman <jonas@kwiboo.se>,
	Coia Prant <coiaprant@gmail.com>
Cc: Heiko Stuebner <heiko@sntech.de>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 0/3] Add devicetree for the 9Tripod X3568 v4
Date: Thu,  6 Nov 2025 23:58:32 +0100
Message-ID: <176246989738.210200.5023344118308147970.b4-ty@sntech.de>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20251103171702.1518730-1-coiaprant@gmail.com>
References: <20251103171702.1518730-1-coiaprant@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Tue, 04 Nov 2025 01:16:59 +0800, Coia Prant wrote:
> Change in v2:
> - Add vendor 'ninetripod' to board filename
>   > 'x3568_v4' => 'ninetripod_x3568_v4'
> 
> Change in v3:
> - Fix Makefile
> 
> [...]

Applied, thanks!

[1/3] dt-bindings: vendor-prefixes: Add 9Tripod
      commit: 25802f8d16374bcfc1e32d26fdee0d89ec82f865
[2/3] dt-bindings: arm: rockchip: Add 9Tripod X3568 series
      commit: a12838aab0cea1e4427d8d620906ce6a1a83a344
[3/3] arm64: dts: rockchip: Add devicetree for the 9Tripod X3568 v4
      commit: 156a530ed5ed012f35e8319c2ee5223dfc7195d3

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>

