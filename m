Return-Path: <linux-kernel+bounces-722716-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 96484AFDE1C
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 05:31:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7E4F01BC6EEE
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 03:31:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 898371FAC37;
	Wed,  9 Jul 2025 03:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="hTJfT3i4"
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 093181F4C8D;
	Wed,  9 Jul 2025 03:31:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752031881; cv=none; b=iv1NpuRbLTe7vK3epSMD5fMDS9B2aII0ZOBNk83ysUYp1RTvOr1psK0kPe8/DQDZ8q4JQERnkuZJhMJMAwIzw2w2IhBJSlh7hv0YHR1JD/H6ivPHFrWZqxv+8z0ST5VoOh1tYV7MO3jYqR2NRQOvMYVtDnTVW2rsi/znnE/MeoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752031881; c=relaxed/simple;
	bh=VhdAlvUZfUyiLoHfSnGHdv+8Iktvv187Kvax6HkpuBo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gsnCGDVx7SEdozYHq5dxJMyKXAyZ0DT/887cRe2RP1fsJYtjVX4yIC7NOMTwwiEb//NfF2A4/lVb9+LXFiO69NiXpQguvFB3PcCZ8slK6B1cc0asEZJjDXoC+BSfrzROh+qYLdeP83P3qVCWqoX7vSCJURi67bRGgYOshj61z0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=hTJfT3i4; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Received: from mail01.disroot.lan (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id B93BC25D89;
	Wed,  9 Jul 2025 05:31:09 +0200 (CEST)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 3EKmnVBUklPl; Wed,  9 Jul 2025 05:31:09 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1752031868; bh=VhdAlvUZfUyiLoHfSnGHdv+8Iktvv187Kvax6HkpuBo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=hTJfT3i4lsyWwGvUqATGqCTf+VVuVvxScnJOqFtiKQIHJPiAQ0JIqb8BIAAlJrDZ/
	 vJ/iWyKzRyoMVyu6GmAPAVnO+BD6ZOeAwPwm1ZjL8JkRC4n0yMRmZ5yPiGtY219/OS
	 hGXSILKAhFrq98LQKfW9mQUpU90uBlFZAZLw6dnJPG8bsYwonXvd+vkEXoO/TeNIIh
	 PmUGJbeS/B24SYhFTI/cpIFruE6FbEqwjDCOlvKeIWNGMJx5WIKLLWR4KSeGQT47h8
	 yCBHRz/TTXbtxueQBRUcqiFojjukdaDQFiah5Jm3CHlOCHPEJfGS/qtsqTbKLtDJh1
	 KZEOFY/yiOtxw==
Date: Wed, 9 Jul 2025 03:30:57 +0000
From: Yao Zi <ziyao@disroot.org>
To: Jonas Karlman <jonas@kwiboo.se>, Heiko Stuebner <heiko@sntech.de>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: Chukun Pan <amadeus@jmu.edu.cn>, linux-rockchip@lists.infradead.org,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6/6] arm64: dts: rockchip: Add FriendlyElec NanoPi Zero2
Message-ID: <aG3iceT_JbERhA4O@pie.lan>
References: <20250708224921.2254116-1-jonas@kwiboo.se>
 <20250708224921.2254116-7-jonas@kwiboo.se>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250708224921.2254116-7-jonas@kwiboo.se>

On Tue, Jul 08, 2025 at 10:48:56PM +0000, Jonas Karlman wrote:
> The NanoPi Zero2 is a small single board computer developed by
> FriendlyElec, based on the Rockchip RK3528A SoC.
> 
> Add initial device tree for the FriendlyElec NanoPi Zero2 board.

Tested on my NanoPi Zero 2 board, RTC could be read out, and Ethernet
and SDMMC reaches a reasonable speed.

Tested-by: Yao Zi <ziyao@disroot.org>

> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
> ---
> Schematics: https://wiki.friendlyelec.com/wiki/images/3/37/NanoPi_Zero2_2407_SCH.pdf
> ---
>  arch/arm64/boot/dts/rockchip/Makefile         |   1 +
>  .../boot/dts/rockchip/rk3528-nanopi-zero2.dts | 341 ++++++++++++++++++
>  2 files changed, 342 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/rockchip/rk3528-nanopi-zero2.dts

