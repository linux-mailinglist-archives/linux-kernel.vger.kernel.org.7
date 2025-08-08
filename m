Return-Path: <linux-kernel+bounces-760866-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA90CB1F137
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Aug 2025 01:06:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A365CA05502
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 23:06:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64A822741A3;
	Fri,  8 Aug 2025 23:06:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T/rE7DUK"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7E941D54EE;
	Fri,  8 Aug 2025 23:06:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754694378; cv=none; b=qtAaDjKaaN7qjF64IhkacUp+SdLrOpvPFFFZpTGuFXArv0HceTB4BamLHdiCVp4fQYbm3a/zqbrO4XcQ3If63jQCH2fgYC9ff+/OWGt3vwxkY/eZyyiEzS+NjwJpxoBxCBTV+n9jAdl05vJU+fQ2zXhdjYPPIaWTb4UBopLawNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754694378; c=relaxed/simple;
	bh=wk1Rwnl+DQFlLilqKiajb3cVEadjb3JB09vbEstMqps=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XuzIYIDVxQKQ/2UgS5ihamccUb+uIc6+f33zs/SWxNGOZfS0CvPdW79PLvd4spw/7kfAMuQ4Rq1UdVV3tfwfaBLZpl/MwTmXjO9PV2UHJaXIv6EAQnsIaSkxdjRmxRrRgyR2oj6+uushgyC3moNGCwV0UU1/3M7FJ819613DRBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T/rE7DUK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92F14C4CEED;
	Fri,  8 Aug 2025 23:06:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754694377;
	bh=wk1Rwnl+DQFlLilqKiajb3cVEadjb3JB09vbEstMqps=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=T/rE7DUK+wKkgy8YIR6Z2qIuYHBEdnX5q+0r5r7qhHP77Y2pxFDE10pRpwULrO1Tm
	 HM3K/5TLqnZQ2+tuzlaHsL5Em0fl+/urShabeYR4QOtqK/YIbsP5JsmFOVdLwgPeKH
	 VXECacC4ZqpLtVxrqF2NV8Y365sYVtUMMMApNqmpDiScfwi3MUNcwcgJgBsK/JPTdP
	 wnRs9EbHtzp6zmsOsdxbJFoBdSpIXVwRvPjXa34cbLvZfblMC05M3IpywJjc/YIo4r
	 lmOC9POh0IwYUw7O1FKdscN+0V21unFKmAalb/2ksSzObN4cIuYmuB6h1xVMWXgYb6
	 tytaUXuW54OGA==
Date: Fri, 8 Aug 2025 16:06:15 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: =?UTF-8?B?VGjDqW8=?= Lebrun <theo.lebrun@bootlin.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Nicolas Ferre
 <nicolas.ferre@microchip.com>, Claudiu Beznea <claudiu.beznea@tuxon.dev>,
 Geert Uytterhoeven <geert@linux-m68k.org>, Harini Katakam
 <harini.katakam@xilinx.com>, Richard Cochran <richardcochran@gmail.com>,
 Russell King <linux@armlinux.org.uk>, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Thomas Petazzoni
 <thomas.petazzoni@bootlin.com>, Tawfik Bayouk <tawfik.bayouk@mobileye.com>,
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, Sean Anderson
 <sean.anderson@linux.dev>, Andrew Lunn <andrew@lunn.ch>
Subject: Re: [PATCH net v3 00/16] net: macb: various fixes & cleanup
Message-ID: <20250808160615.695beafe@kernel.org>
In-Reply-To: <20250808-macb-fixes-v3-0-08f1fcb5179f@bootlin.com>
References: <20250808-macb-fixes-v3-0-08f1fcb5179f@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, 08 Aug 2025 18:52:32 +0200 Th=C3=A9o Lebrun wrote:
> This is a split off my previous series on MACB [0]. The main goal is to
> add EyeQ5 support, but there was a lot of independent fixes/cleanup.
>=20
> Overall, it is fixes first so they can be applied swiftly, followed by a
> series of cleanup patches. To clarify, nothing critical. It mostly puts
> the driver in a better shape and prepares it for EyeQ5 patches.

Nothing past patch 7 is a fix, please separate fixes from other changes
(unless there's a hard to avoid dependency). Please wrap the code at 80
chars.
--=20
pw-bot: cr

