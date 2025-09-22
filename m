Return-Path: <linux-kernel+bounces-826661-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 69461B8F104
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 08:02:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1D884178C9D
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 06:02:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7697E18DB1F;
	Mon, 22 Sep 2025 06:02:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="d3RqjPwj"
Received: from out-187.mta1.migadu.com (out-187.mta1.migadu.com [95.215.58.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94DBB26AEC
	for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 06:02:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758520964; cv=none; b=golCcKrq/PCeTy6NslC5DE5w8xliSFPZkWmd3s5lGJxrcBsaL/D3igEoaobRcMLFVkLjDVWjRK8uQqfhZ1Y35a+qLPEZeIF+cdIJEoHDI0w5gYzYbREC1weTF2mTrF2G3RL8jt73Rn1kURuSOkxGCFLo+kDjSCOmD0f591qwcCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758520964; c=relaxed/simple;
	bh=A9SJVOgTvKuEK9eoF02ve19YOGDPDcRZuXtozFIjPzo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NYl+zWiPQ45VLEArR/tq6HWyhbgrxCWWyYy/gFvPgRAQrCGBfJ+O+Fk+Ubs8pN3A3cGXvsJJhcww4G447z9YaR0q9QDiix40JT79z2Bh43kD3A0jS/ZKhJP6tl4d7Q+3kRTbG4E+bss5AIssPLVBrTpQiaZSPlrOZla2pMfB0qI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=d3RqjPwj; arc=none smtp.client-ip=95.215.58.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Mon, 22 Sep 2025 08:02:36 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1758520959;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=x5SGPhE0JOeMCnrFddhxhMz/QTAvX5WL+uZeNk00z9M=;
	b=d3RqjPwjddNvse0JKJql519VUVIGUCxiBSM+I2rhDTEZFnFPRLNru240JZushSupVCjyht
	4daRi+t8Oi6y/qMZgSagmO7WO2y9re8TIWOeBdbTwL/3Ew2FKjfpcNV+YsMa+3HA1scQZ0
	YOouVUScBZ6Z4yucnKmZyeaurkuYMoQ=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Nicolas Schier <nicolas.schier@linux.dev>
To: Onur =?iso-8859-1?Q?=D6zkan?= <work@onurozkan.dev>
Cc: rust-for-linux@vger.kernel.org, ojeda@kernel.org, nathan@kernel.org,
	nicolas.schier@linux.dev, masahiroy@kernel.org,
	aliceryhl@google.com, thomas.weissschuh@linutronix.de,
	tamird@gmail.com, linux-kbuild@vger.kernel.org,
	linux-kernel@vger.kernel.org, alex.gaynor@gmail.com,
	boqun.feng@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com,
	lossin@kernel.org, a.hindborg@kernel.org, tmgross@umich.edu,
	dakr@kernel.org
Subject: Re: [PATCH v2 1/1] rust: add `rustcheck` make target for check-only
 builds
Message-ID: <20250922-demonic-raccoon-of-will-1adb52@bergen>
Mail-Followup-To: Onur =?iso-8859-1?Q?=D6zkan?= <work@onurozkan.dev>,
	rust-for-linux@vger.kernel.org, ojeda@kernel.org, nathan@kernel.org,
	nicolas.schier@linux.dev, masahiroy@kernel.org,
	aliceryhl@google.com, thomas.weissschuh@linutronix.de,
	tamird@gmail.com, linux-kbuild@vger.kernel.org,
	linux-kernel@vger.kernel.org, alex.gaynor@gmail.com,
	boqun.feng@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com,
	lossin@kernel.org, a.hindborg@kernel.org, tmgross@umich.edu,
	dakr@kernel.org
References: <20250915115311.3025-1-work@onurozkan.dev>
 <20250915115311.3025-2-work@onurozkan.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="bBIxi82jCm1Nqn97"
Content-Disposition: inline
In-Reply-To: <20250915115311.3025-2-work@onurozkan.dev>
X-Migadu-Flow: FLOW_OUT


--bBIxi82jCm1Nqn97
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 15, 2025 at 02:53:11PM +0300, Onur =D6zkan wrote:
> Adds a new `rustcheck` make target to run a check-only build
> similar to `cargo check`. This allows us to verify that the Rust
> sources can build without building/linking final artifacts,
> which speeds up the iteration (a lot) during development.
>=20
> The target also supports the CLIPPY flag (e.g., `make LLVM=3D1
> rustcheck CLIPPY=3D1) to run Clippy in a faster way.
>=20
> Also, unlike `make LLVM=3D1`, it doesn't compile large amounts of C
> code (on a fresh checkout) when the goal is only to check that
> Rust builds are not broken after some changes.
>=20
> Suggested-by: Benno Losin <lossin@kernel.org>
> Link: https://rust-for-linux.zulipchat.com/#narrow/channel/288089/topic/x=
/near/539103602
> Signed-off-by: Onur =D6zkan <work@onurozkan.dev>
> ---
>  Makefile      |  7 +++++
>  rust/Makefile | 73 +++++++++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 80 insertions(+)
>=20
> diff --git a/Makefile b/Makefile
> index cf37b9407821..7812cdc72938 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -1716,6 +1716,8 @@ help:
>  	@echo  '		    is formatted, printing a diff otherwise.'
>  	@echo  '  rustdoc	  - Generate Rust documentation'
>  	@echo  '		    (requires kernel .config)'
> +	@echo  '  rustcheck       - Check that the Rust code builds'
> +	@echo  '                    (requires kernel .config)'
>  	@echo  '  rusttest        - Runs the Rust tests'
>  	@echo  '                    (requires kernel .config; downloads externa=
l repos)'
>  	@echo  '  rust-analyzer	  - Generate rust-project.json rust-analyzer su=
pport file'
> @@ -1821,6 +1823,11 @@ PHONY +=3D rustdoc
>  rustdoc: prepare
>  	$(Q)$(MAKE) $(build)=3Drust $@
> =20
> +# Checking Rust sources.
> +PHONY +=3D rustcheck
> +rustcheck: prepare0

Why do you let rustcheck depend on prepare0 instead of prepare?

> +	$(Q)$(MAKE) $(build)=3Drust $@
> +
>  # Testing target
>  PHONY +=3D rusttest
>  rusttest: prepare
> diff --git a/rust/Makefile b/rust/Makefile
> index bfa915b0e588..b45878870207 100644
> --- a/rust/Makefile
> +++ b/rust/Makefile
> @@ -265,6 +265,79 @@ rusttest-kernel: $(src)/kernel/lib.rs rusttestlib-ff=
i rusttestlib-kernel \
>      rusttestlib-uapi rusttestlib-pin_init FORCE
>  	+$(call if_changed,rustc_test)
> =20
> +## Check-only compilation (similar to `cargo check`)
> +quiet_cmd_rustc_check_library =3D $(RUSTC_OR_CLIPPY_QUIET) CHECK $<
> +      cmd_rustc_check_library =3D \
> +        OBJTREE=3D$(abspath $(objtree)) \

Have you tried this?

        OBJTREE=3D$(CURDIR) \

or

        OBJTREE=3D$(abs_output) \

I'd favor using one of these instead.

Kind regards,
Nicolas

--bBIxi82jCm1Nqn97
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEh0E3p4c3JKeBvsLGB1IKcBYmEmkFAmjQ5nsACgkQB1IKcBYm
EmmbjhAAwVgCYyXQ3IY3eY+gsLi8kKvpvUxK05aLvkWDErcqeiDVS+WAlKxoGRbK
GE1yDdNRZBmvtH6z0B1IP0sK1Bu6Wa0Kb8UdwoT6M080SHDGLlq5QQ7d2y/McZIj
2xikteMbIbaxxPGYw60CbZR8cCWio3AUrp6+IBj/sXcMO8BK86jQ+IdO2gE/zeLD
5fZenzYuO4D9e78IdyMRTHR8224qzSGBYx1P9xNbU2bho1eoHf5Efnby8kAeTkfu
4y7yvozCvLeIpwSFfLfOzbMalGkZ92bwTNpWJi+qRVj3gmq+xSUJ6zp/LPkSYQe0
0PBEvpi5ndMLmGNgix0igvhpP1/Z0/v0CAzKQXkAUwSxjtknTPpMNc3na7U+RHyZ
u4ADnJw8PWagiYTJWijgA+dsyvAhAjLSBRBVY94Z/DZR+pNeWtRlsM6V3G45ZFJk
MMCzvVoTgE2LxgwLEgkFxK45WfpQjSeSLSKdX49Cmu5h6RJEsHyLbiRbgMvuRKmr
vEMYF+37XBJsC29AeuLdvHyrJ2AM/h9aT7hfrHWG0W5BQexl3ztLnrjfrKBjDJqc
Aj1r1biGCw63bJdOtmsQleacap0cosMagKaSdOEV18t6uJIylH3MhKK6ej+LgyFd
nxfgqadowfsepkgfVXSPTHOK5zuvYiDTp2HrYqKyO5tEZZs0bjo=
=iuAC
-----END PGP SIGNATURE-----

--bBIxi82jCm1Nqn97--

