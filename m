Return-Path: <linux-kernel+bounces-735810-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9686FB09420
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 20:41:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 139C25A3EDE
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 18:41:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D513C2135CE;
	Thu, 17 Jul 2025 18:41:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="msRlLmCi"
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C5D6211460;
	Thu, 17 Jul 2025 18:41:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752777673; cv=none; b=i0xlXJI9HLSfTZI+VU8sccH1h1zAZWPZiSeLkVLFUqyJIM7FgUWAuUwouiFEAvYyxLUTey3zFU7RZYw38nCwjnkFSg1c5P0IGius5uVIj8bkypPaUiypNDffNwD3iwepLsKSzFaavRYFiPb6e3aZwQFWowdSmc16c9+uWJ8x5fM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752777673; c=relaxed/simple;
	bh=fDpd4nDOjJXxUCktGXz7ZpXlIKGg14EE+50T3iOPaSk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lEVVFuXg4E6nLnDur8X99S2wRHeWulxOueS8hdgkrJntBm7bvqiU/gkxAwlL8pv9du1scw1YKztbmzPwlflMKBCWofRrDk5A7MkMUNz98rfjeqg3KIUXOdQBk+Uqnma187B2LTMNFJi8ho/PsZY0EThhTEb88fHA0SZLF8IMWeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=msRlLmCi; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Type:Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To;
	bh=z8+rI+enL4BSqLq2MJbBJbkJP0/8ld0NpkqpPbeKKVc=; b=msRlLmCiHmUcDmop9bQYx2XvJT
	0aucsQ8fV2s9REhSuLOn1834b3FxtUmsBDVtsgREcF2UKJsxMqDiiSJ9wPhkIRIdd99HeUoyyAhHc
	iFFVB/uZM6InObn2gGsXFDwwN1PBDUZC2swKuq2ooJYQ05LYkAJz+WvV3GG/9ZDXTYB44cFhIW/vz
	qjMxkon24v6lOrlp0xOM2kB0mxsRdT1SksUV4bGJlIy2hgpSWpxY66eGz7ugirPW5kmncyY2Oz54h
	TA3bXG/er6NFMZriVtHfoUqhsZELemb3ctbcmK3wbwX5xFOoynoueu2grFS/dtI1KE2XOy+beRYgN
	MatY/ONg==;
Received: from cst-prg-35-241.cust.vodafone.cz ([46.135.35.241] helo=phil.localnet)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1ucTXR-0005fE-9W; Thu, 17 Jul 2025 20:41:01 +0200
From: Heiko Stuebner <heiko@sntech.de>
To: Quentin Schulz <quentin.schulz@cherry.de>
Cc: robh@kernel.org, krzk+dt@kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 linux-kernel@vger.kernel.org, damon.ding@rock-chips.com,
 Heiko Stuebner <heiko.stuebner@cherry.de>
Subject:
 Re: [PATCH 2/2] arm64: dts: rockchip: add RK3588 DP carrier from Theobroma
 Systems
Date: Thu, 17 Jul 2025 20:40:59 +0200
Message-ID: <11143499.CDJkKcVGEf@phil>
In-Reply-To: <470dc543-9619-419c-9ea3-6671f4d52326@cherry.de>
References:
 <20250716185027.2762175-1-heiko@sntech.de>
 <20250716185027.2762175-3-heiko@sntech.de>
 <470dc543-9619-419c-9ea3-6671f4d52326@cherry.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

Hi Quentin,

Am Donnerstag, 17. Juli 2025, 14:21:22 Mitteleurop=C3=A4ische Sommerzeit sc=
hrieb Quentin Schulz:
> On 7/16/25 8:50 PM, Heiko Stuebner wrote:
> > From: Heiko Stuebner <heiko.stuebner@cherry.de>
> >=20
> > The DisplayPort carrier is a very simple baseboard only providing seria=
l,
> > ethernet and a displayport output.
> >=20
> > But its main functionality is that it routes the Analogix eDP controller
> > to this DisplayPort output, which allows to test that controller simply
> > by hooking it up to a suitable monitor.
> >=20
> > The Analogix-DP controller supports eDP 1.3 and DP 1.2, so can drive
> > both eDP displays as well as full DP monitors. It does not support DP+
> > so passive DP-to-HDMI adapters won't work.
> >=20
> > Signed-off-by: Heiko Stuebner <heiko.stuebner@cherry.de>
> > ---

> > +&edp0 {
> > +	/*
> > +	 * Note that this board doesn't respect Q7 standard as Q7 has
> > +	 * lane 2 of HDMI on the same pin as lane 0 of DP and lane 0 of HDMI
> > +	 * on lane 2 of DP but this board uses HDMI lane numbering instead of
> > +	 * DP lane numbering for its DP lanes.
> > +	 *
> > +	 * It should be possible to match Q7 standard if required by requesti=
ng
> > +	 * the eDPTX controller to swap lanes with:
> > +	 *
> > +	 * data-lanes =3D <2 1 0 3>;
>=20
> I don't think that's true currently?
>=20
> The driver only seems to be supporting swapping the lanes, c.f.=20
> analogix_dp_lane_swap() which routes it to either 0 1 2 3 or 3 2 1 0 but=
=20
> no mix like the one we would need. Also, this function is never called=20
> with anything but "do not swap" argument. So we would need to fix the=20
> driver to support that.
>=20
> Also, this is the kind of information we should have in Tiger DTSI and=20
> not some "random" baseboard DTS which will actually not make use of it.=20
> We should have data-lanes =3D <2 1 0 3>; in Tiger DTSI actually but=20
> considering 1) the driver doesn't support that, 2) we don't have HW to=20
> validate it works; I guess we'll just leave it at that.
>=20
> > +	 */
> > +
>=20
> Aren't we missing the data-lanes property here? I don't see a default=20
> and I would assume we should be providing one?

The analogix-dp controller binding does not specify data-lanes at all
and the current driver also does not read it, or use anything
regarding it.


> Documentation/devicetree/bindings/media/video-interfaces.yaml specifies=20
> it either starts at 0 or 1, depending if there's a clock lane or not. As=
=20
> far as I could tell, DP has 4 data lanes and the AUX lane as well, but=20
> nothing clock-specific so I assume starting at 0 would be correct?

Looks like it. I looked at the vendor-kernel which does allow data-lane
settings and specifies the default as <0 1 2 3> .

So for now, I'll just drop the comment.


> On a side note, is the audio output on eDP TX controller already=20
> supported like on HDMI? If so, we should add the edp0-sound node like in=
=20
> our downstream fork. But looking at the driver, I don't think we=20
> implement any dp_audio_* callbacks from drm_bridge_funcs which I assume=20
> would be the way to implement that.

Heiko



