Return-Path: <linux-kernel+bounces-723994-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B843AFED95
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 17:21:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9D1C47BC768
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 15:12:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC9D92E7160;
	Wed,  9 Jul 2025 15:11:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="ivXLvStV"
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C93A22E613A;
	Wed,  9 Jul 2025 15:11:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752073905; cv=none; b=p/B0nvTNsD4FifQLDvu0TO5q2IOqG5jjHDa8Xx4pvCn5jL7gzTvaDyjS5e9TH3+e1Ekm6rk4Rb5D6qhIN3Dlul6K9mLys/AM3bKge9U8B/s6Bzpct2b2FlJD379W2ninlK9XnbtTSJAco3cq6NifxuMaQgobMF6FS4jtsEymWZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752073905; c=relaxed/simple;
	bh=5AAFLigk0Q9JyNtTRRLY+tzPOZ4Uw/mOx77rl361huQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iGOBRX9mo35V0A3wonPN6z0FLZVeCZDJ0M22CsY+Iv9pp4/dNlFWCuwX32kztqNehGBpsSipEBZOh32r+jeVoSK7IsVmy6hN38Q6RpjOnTf4tViWKlT8FJ99vRXTLg+3/jZNgN9QieO2vmm/gsMae4jVynaNHLgJT50PM72nSjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=ivXLvStV; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Type:Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To;
	bh=hSvqoLf0LP5lzWLW+28LdzLoZ3lXqAKVepinrDPL/NU=; b=ivXLvStVMsA2ZVrqLyZJY7hMse
	yCNz2LW2NI8wqvB45/u+ezwSkR0PCxZnV3CgyQPEW43N924bNvJI5PoMRd4e3lDjj4acP7DhN1fJR
	9q0PMiSldEnVbeshyHPuwsiOmlsldPQVR7SJXj4yCXDSE6sHAc5QCgnV+F3/VnghCDaUwS+9O3f7y
	RaXWUspJQHBmZk3BgiNeFsp/Ygw9R5ay9gY747RFIaP8UswuF0yIoYFfsm+BEooABjXnojhZPmtNv
	6IcwCgse+kV94xYkRz6VG9nU1Rh6aa6CBeAetFZSbP6JpSKhtd0mKj0BYw8f3kaoQ4CImlctKmOiW
	H2cE3Kfg==;
Received: from i53875a79.versanet.de ([83.135.90.121] helo=diego.localnet)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1uZWSF-0004jl-6x; Wed, 09 Jul 2025 17:11:27 +0200
From: Heiko =?UTF-8?B?U3TDvGJuZXI=?= <heiko@sntech.de>
To: Diederik de Haas <didi.debian@cknow.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 Krzysztof Kozlowski <krzk@kernel.org>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: rockchip: Add reset button to NanoPi R5S
Date: Wed, 09 Jul 2025 17:11:26 +0200
Message-ID: <5360173.ktpJ11cQ8Q@diego>
In-Reply-To: <ea6f2815-5882-4fab-8372-1c252a87e09a@kernel.org>
References:
 <20250709105715.119771-1-didi.debian@cknow.org>
 <DB7HDOPFOQAE.3NG4SP67ES80J@cknow.org>
 <ea6f2815-5882-4fab-8372-1c252a87e09a@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

Am Mittwoch, 9. Juli 2025, 16:18:17 Mitteleurop=C3=A4ische Sommerzeit schri=
eb Krzysztof Kozlowski:
> On 09/07/2025 13:17, Diederik de Haas wrote:
> >>>  		compatible =3D "gpio-leds";
> >>>  		pinctrl-names =3D "default";
> >>> @@ -127,6 +140,12 @@ eth_phy0_reset_pin: eth-phy0-reset-pin {
> >>>  		};
> >>>  	};
> >>> =20
> >>> +	gpio-keys {
> >>> +		gpio4_a0_k1: gpio4-a0-k1 {
> >>
> >> Are you sure that this passes checks?
> >=20
> > I did the following:
> >=20
> > ```sh
> > export PATH=3D~/dev/kernel.org/dt-schema-venv/bin/:$PATH CROSS_COMPILE=
=3Daarch64-linux-gnu- ARCH=3Darm64
> > make distclean
> > make debarm64_defconfig
> > make CHECK_DTBS=3Dy W=3D1 rockchip/rk3568-nanopi-r5s.dtb
>=20
> This looks fine.
>=20
> > ```
> >=20
> > And it did not report any issues.
> > Then booted up my NanoPi R5S and verified that with the updated dtb the
> > reset button worked.
> >=20
> > If it's about the 'weird' name/label, it is what is used in the
> > schematic document I have and I asked Heiko (on IRC) if using
> > ``reset_button_pin: gpio4-a0-k1`` would not be better. That would make
> > it more descriptive while also having the schematic traceability in it.
> > The answer was no, use the form I used in this patch.
> >=20
> > Am I missing checks I should've done as well?
> I meant that usually nodes, including pin controller mux/config nodes,
> have specific prefixes or suffixes. Other cases have here as well. Your
> does not.

I guess this might have more to do with how deep people submitting DTs
dive into the schematics.

The "aim" has always been to just use the schematics/TRM names, which is
true for the core soc pinctrl entries, and many if not most boards do this.

I would assume the "lan1-led-pin" below the newly added one stems from
a more "shallow dive" ;-) . I would assume that "lan1-led-pin" most
likely has a different name in the schematics, and using that would've
been better.





