Return-Path: <linux-kernel+bounces-836483-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EE113BA9D1B
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 17:39:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ACC9A175FF0
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 15:39:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6028730BBB8;
	Mon, 29 Sep 2025 15:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="VWWA0KnM"
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 623DD30649C;
	Mon, 29 Sep 2025 15:39:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759160379; cv=none; b=HrOOZKBi1NlLbHc7osOQyrdIlBreFyV+D8PftNr0URpr3ttaa+oKTFr+IcD0jdDmq4WLdK7gzbVedWTUlxz7nTYQwqndt5h//+Q9Y8yKzH0zXccCcdQiJM0fbxfVQOuU5yQb7+IMcZIqYfxN2rjTTFtYcljKtbvHmT53Glmxj74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759160379; c=relaxed/simple;
	bh=WpiRmRiNktJeHW5C/m0YQuXfG2H8PJzwMojJHmpXVQ4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ao4kNGJpHHkkiXZgj7aAMW3jNeh8bWMoDhI5iO1EnECle9JI/ZR2a2Kyj3k45QUGMNUKoDIJHjBPfebUNqo8K+I9kqwY2yUeVWrcAUymY6WgU27ZHTxDU3ni2Uoa3zwmmpGEVAKRrKrHAmwkLkuSbvVepVi97kI8OUYYzy1BEB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=VWWA0KnM; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Type:Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To;
	bh=IsJOyWxYTnSzM823W7VRWdUdPLOKig+uzT39p4FJXVw=; b=VWWA0KnMv1KRO+v0x0Pgoe4jJL
	Q0z7nv9BmMZQC1tgtRC6yObi66xEw8xnvKEcur2X2k4CCkq5ddT2YHB2bqniNnmHTHb92waqUnD0X
	ZH2S4QACc2L/mpeYv3zV1Tf3GKSwX47He0qRIg2ZNLdjgGvrjOFAtPBmeo+j3OpR14Z92J+QvRO++
	4nRsM2gQk0iicjDOGB62XT63NlY/gpGSsULrPsfGHMPMP38qOQVA6IMzFHtKrDz/BjxyZRBhp3MGV
	aAhCSEFUjMULfwPBTeUiglSdd9BAItwct2FipqTda3/9Bf3VAkeBY6hptTSGRglGPORmfQFFRgC8b
	7+NHyJ1Q==;
Received: from e227-076.eduroam.tuwien.ac.at ([128.130.227.76] helo=phil.localnet)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1v3FyJ-0008A3-Fe; Mon, 29 Sep 2025 17:39:27 +0200
From: Heiko Stuebner <heiko@sntech.de>
To: guptarud@gmail.com, Dragan Simic <dsimic@manjaro.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 linux-kernel@vger.kernel.org, Ondrej Jirman <megi@xff.cz>,
 Martijn Braam <martijn@brixit.nl>,
 Kamil =?UTF-8?B?VHJ6Y2nFhHNraQ==?= <ayufan@ayufan.eu>,
 "Leonardo G. Trombetta" <lgtrombetta@gmx.com>
Subject: Re: [PATCH v4 0/4] Upstreaming Pinephone Pro Patches
Date: Mon, 29 Sep 2025 17:39:26 +0200
Message-ID: <8606261.29KlJPOoH8@phil>
In-Reply-To: <49dafe9afc5962d8fec10e6135c9b84d@manjaro.org>
References:
 <20250929-ppp_light_accel_mag_vol-down-v4-0-6598f22d3451@gmail.com>
 <49dafe9afc5962d8fec10e6135c9b84d@manjaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

Am Montag, 29. September 2025, 10:32:59 Mitteleurop=C3=A4ische Sommerzeit s=
chrieb Dragan Simic:
> Hello Rudraksha,
>=20
> On 2025-09-29 09:35, Rudraksha Gupta via B4 Relay wrote:
> >       arm64: dts: rk3399-pinephone-pro: Add light/proximity sensor=20
> > support
> >       arm64: dts: rk3399-pinephone-pro: Add accelerometer sensor=20
> > support
> >       arm64: dts: rk3399-pinephone-pro: Add magnetometer sensor support
> >       arm64: dts: rk3399-pinephone-pro: Fix voltage threshold for=20
> > volume keys
>=20
> Please note that the patch summaries/subjects are still a bit
> wrong in the v4 of this series, because there should be no
> "rk3399-pinephone-pro:" prefixes in them.
>=20
> You can always check the commit history for the file you're
> editing, to see what's the expected format of the patch summary.
> It differs a bit between the subsystems and architectures, so
> it should always be checked.

for reference for Rockchip dts files, the preferred format is:
arm64: dts: rockchip: Do something on boardname

aka "arm64: dts: rockchip: " and the rest is free form but should
mention the board.

But I'll generally fix those up myself if needed, so right now
there is no need to resend just for that change.


Heiko



