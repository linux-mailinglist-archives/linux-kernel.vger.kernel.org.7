Return-Path: <linux-kernel+bounces-852698-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C0FBFBD9AEB
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 15:23:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EA18019A6804
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 13:18:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97C533168FC;
	Tue, 14 Oct 2025 13:11:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y7a2RlIw"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7B903101DC;
	Tue, 14 Oct 2025 13:11:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760447513; cv=none; b=A6PXVS0dLffa0Cck55fg78ayodnA7/Cs/1gPwkdFnOtcQOuKmIM36CWj8gm4pU5bpdvRv4S5BJNJK13C6v4DgUlTzdCQXK9uzz2ch/ODlWOqQ3m6Q3hywiIfildSJ+iPVZIe13m6kMV32mjctCF7zKaxMAhvOYHEF/i61kRc29E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760447513; c=relaxed/simple;
	bh=WWge5QE7ccS0BE12tLmkqcCYs9UtsCrKVaewIgo/7yU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fw2+fBNiagUl9p8Ij/5sTN1iR8h+8aoJLj9+dZ2VM0ygy90ymUUVigcQqfsI0hxil3Z8swGCB02aB9aY7hy3tTaxiEgRBeumX17JvDhkNp6km15a/pYJt4Dv2IbMBlFvngL4tq4/7eW6tttSRD+RAlNCobmeZzb3qByvd6mJS2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y7a2RlIw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 967D6C4CEE7;
	Tue, 14 Oct 2025 13:11:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760447512;
	bh=WWge5QE7ccS0BE12tLmkqcCYs9UtsCrKVaewIgo/7yU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Y7a2RlIwG+uclBVyxfFoAmq5L+WVQ+T93yE4x0y2sc96TgfibGQFYktXTqIQNO+Om
	 NIqTIzEFo8yLWL8/qmogLEvEkSKqV//zWpZWFAetDL8ZaNC/RLp6Xbgl+TwaEKEivJ
	 DOqaujPGMQaxHhFJzve603WuvJpmJLb7Wr48gxqckfUtzLVo2BZzPNUip9djagijrU
	 rq93rWYCDmSjZybOQkuoiJDXvbk5ZrwnjQmFjz0Jeo7wg36uODDRqBV11GtCTgVAX/
	 Vr7im8kqP3oEn1Tyh61/7Xxk4n3uAww/C8ddyfmjvGeBDGiFNxjwfOgyYv+AbL2vv6
	 R0a2kNX5/3rvg==
Date: Tue, 14 Oct 2025 14:11:47 +0100
From: Mark Brown <broonie@kernel.org>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Joan-Na-adi <joan.na.devcode@gmail.com>,
	Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, Joan Na <joan.na@analog.com>
Subject: Re: [PATCH v3 3/3] dt-bindings: regulator: Add MAX77675 regulator
 binding
Message-ID: <08b4c0a0-cc59-4640-94ff-2d243c558a67@sirena.org.uk>
References: <20251014053142.15835-1-joan.na@analog.com>
 <20251014053142.15835-4-joan.na@analog.com>
 <512ffe3d-5ab3-4e87-afd2-46f0005a8d17@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="LaFKth9VJQMz7YfU"
Content-Disposition: inline
In-Reply-To: <512ffe3d-5ab3-4e87-afd2-46f0005a8d17@kernel.org>
X-Cookie: Go 'way!  You're bothering me!


--LaFKth9VJQMz7YfU
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 14, 2025 at 10:14:15AM +0200, Krzysztof Kozlowski wrote:
> On 14/10/2025 07:31, Joan-Na-adi wrote:

> > +  maxim,en-mode:
> > +    description: |
> > +      Enable mode configuration.
> > +      "push-button"  - Push button
> > +      "slide-switch" - Slide switch
> > +      "logic" - Logic mode

> You just repeat the name in the description. Say something useful.

Do you have concrete suggestions there?  I can see dropping the
descriptions entirely but otherwise I'm not sure there's much to
usefully add.

> > +  maxim,latency-mode:
> > +    description: |
> > +      Latency mode for voltage transition:
> > +      "high" - High latency (100=CE=BCs)
> > +      "low"  - Low latency (10=CE=BCs)

> So use values 100 or 10, and proper type (-us)

Without knowing the device specifics at all I rather suspect those
numbers are more ballparks than specifics.

> > +  maxim,dvs-slew-rate-mv-per-us:

> ... like here.

> > +    description: |
> > +      Dynamic rising slew rate for output voltage transitions, in mV/=
=CE=BCs.

> Except you said mv/us, not us. Confusing.

That's what I'd expect for a slew rate?  It's the speed with which the
device ramps between voltages during voltage transitions, mV/us is a
perfectly normal unit for that.

--LaFKth9VJQMz7YfU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmjuTBIACgkQJNaLcl1U
h9BeEQf/c+ATautvWAPuyL53Im3Y2OM+ZsLDKKeM5EwuL1lGWkvTcHXgoyTOxFPi
EXq8a1AZAND96Ac1+ENo2SQRQ+Vd38ra2fcLLDXdFdxZ7leyIc4APSsq/uvCRdGH
HWmbKFpqtNDpyrtb7tQtrnBaSPDYKWSosuVIEv9GlTlziIb5/uTos5hUjsPKiTDb
3ElwO6MBUrAeGRMMtFONT+uqGeCA8Dods3y8LJdcL3JTMTitJrgEL9q/xDf5VyyQ
eT879ZMRLO8QF0L0BCPDYn/DLy9ZUlwk9DvJIQN6crKth6M16lz/djmqyrtRud68
3njZFR5Gq9ohrYW679cCo9CgTzKJBQ==
=qJK/
-----END PGP SIGNATURE-----

--LaFKth9VJQMz7YfU--

