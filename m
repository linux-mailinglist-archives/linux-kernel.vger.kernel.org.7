Return-Path: <linux-kernel+bounces-780423-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BDEC7B301BA
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 20:09:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9D0B3AC3382
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 18:08:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C8B63431FC;
	Thu, 21 Aug 2025 18:07:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SoZuMqbt"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D281B3115B8;
	Thu, 21 Aug 2025 18:07:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755799674; cv=none; b=gMJ8vF1lWb7iZFt2ocinucDWZcRb6TB7/vTx1HPhLrsJeH9cThBuN9nwHfaKr40C8rwq1tJVDu0beepLTutV8VNoTyaseoxjwnuBNlmrjpUgwZVmpail69WoUaloBHOZVKcfgHPjq+Db+AYlN+IAO6aA1gx7zzS//FrVrMh9qDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755799674; c=relaxed/simple;
	bh=cqV32R8BauF0D9RcGuPTvw5bHyckwkMGjqU7llEphYg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SlWEnRKwMnjJfUcVWxE1B3+fmh+nEDp2Erm8bHp6HMYQjA3E9gejInv1spGnvUgWZqphARocBVNXPuFFTR+i5b8rQmNkDEBGFFv2iv1OQgm2v89hdLHbXMZ1zSGpb25gfAQDn378Q+mVmbz6MLAnHrflvUl8rN4iRsWlLT1VPYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SoZuMqbt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55C22C4CEEB;
	Thu, 21 Aug 2025 18:07:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755799674;
	bh=cqV32R8BauF0D9RcGuPTvw5bHyckwkMGjqU7llEphYg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SoZuMqbtNodZBdlB7WdbDgWySAkmHnvNA4/90X/Eojf8vkCVPMu46gsuc/pSMYzqc
	 O3Muhgm5HPqVV+9TW0jNkSlqdfyk86ROBJOUHV/MeKY5hlvyo++ylCpXZmha89oo9C
	 TR0hSVJSRTupBpsI6qgdt4DewUjOof+bPu5Y0/jr+KSYYmvud64kznOaF5F0yBXNbZ
	 hJfB2AQJ9X0VG+3N7u3AZHC1WwqD5GGaXMpxjalBbFccke4uRA0vx3+iueKGR8BmLs
	 HjF2a8p8GpQsPlZS0qk4mF8+E6B9F52WjhNLJ5gTaZ+r6syy3RFsFVUEDWlyrLojb/
	 8l/twFM5g1ppw==
Date: Thu, 21 Aug 2025 19:07:48 +0100
From: Conor Dooley <conor@kernel.org>
To: Hsun Lai <i@chainsx.cn>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	heiko@sntech.de, andrew@lunn.ch, inindev@gmail.com,
	quentin.schulz@cherry.de, jonas@kwiboo.se, sfr@canb.auug.org.au,
	nicolas.frattaroli@collabora.com, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	krzysztof.kozlowski@linaro.org, linux-rockchip@lists.infradead.org
Subject: Re: [PATCH v1 1/2] dt-bindings: arm: rockchip: Add 100ASK DShanPi A1
Message-ID: <20250821-java-tapping-a828a2775e29@spud>
References: <20250821110942.172150-1-i@chainsx.cn>
 <20250821110942.172150-2-i@chainsx.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="BT4qYPKxiViwhuZI"
Content-Disposition: inline
In-Reply-To: <20250821110942.172150-2-i@chainsx.cn>


--BT4qYPKxiViwhuZI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 21, 2025 at 07:09:41PM +0800, Hsun Lai wrote:
> This documents 100ASK DShanPi A1 which is a SBC based on RK3576 SoC.
>=20
> Link: https://wiki.dshanpi.org/en/docs/DshanPi-A1/intro/
>=20
> Signed-off-by: Hsun Lai <i@chainsx.cn>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

--BT4qYPKxiViwhuZI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaKdgdAAKCRB4tDGHoIJi
0qd9AQCqoS6NzL53hBCjSPNRb1IEtMcHrfzfvhXri8oJ6S4m7gEAtCM6t9wk+Rjr
r9QVywY0EGRtNRxOMkSUulbpp+KCSgk=
=qr+H
-----END PGP SIGNATURE-----

--BT4qYPKxiViwhuZI--

