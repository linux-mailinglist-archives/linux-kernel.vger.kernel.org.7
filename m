Return-Path: <linux-kernel+bounces-819291-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EC9DB59E19
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 18:47:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C6A9F7B27DE
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 16:45:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A0002FFFA9;
	Tue, 16 Sep 2025 16:46:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=heusel.eu header.i=christian@heusel.eu header.b="XH3XAUBv"
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 324302FFF82;
	Tue, 16 Sep 2025 16:46:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758041192; cv=none; b=tsoBAyFX4SgZAraSaRr+q5BOMM6nJX0/KbzsXkqdwaHoMOyubk0XzEB23izoBviIOYn9p6WZtnH/o/fA5ljzs3LFW3iPrrIWZrQDGYAv+72oecioFj7ov89Pd26QvQGSD0lcqNtG+pshxYqf0d0Z8lnsQpkSl2jxRuUcx8a1xdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758041192; c=relaxed/simple;
	bh=8AESY8DFg+P8p5pZuaMkvp80UwJ/QTg4ZdEEHu0ICgM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=afYyWofjo4wfur2ku2pwtP51K5GdrvcqlYLlyfvlkhoEQdRMQBbGoU6wGzYjfkEGnUPxGhr8XHQh4S/4Mc18l1Wg7NGqsSy232vUzx/1JPo1p8AU/gHikzLMK00G2he2YirbT7tyiRJ+KFtKW6RuLpzmhXHy2qDg9Jrds2fLGig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=heusel.eu; spf=pass smtp.mailfrom=heusel.eu; dkim=pass (2048-bit key) header.d=heusel.eu header.i=christian@heusel.eu header.b=XH3XAUBv; arc=none smtp.client-ip=212.227.17.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=heusel.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=heusel.eu
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=heusel.eu;
	s=s1-ionos; t=1758041168; x=1758645968; i=christian@heusel.eu;
	bh=D5WjKsYzC/8TQ4xzES5ykkMKYMccrsD0qleFS2sZfIY=;
	h=X-UI-Sender-Class:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:In-Reply-To:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=XH3XAUBvlVuoIRcY7m680tuNZ03tgyN+4N0tBMtCv76BTXKk9+VqfLuC4Gs62kMG
	 1lZ5CkctZd6kNOJ6c/dawjVwJ5lSgZuAxqSpBEQe5CArt8Bz4BW6z31Yz7p4YOXxz
	 k6Mi/T8v+wtyS2AoaZPVUc4Qwx7oTQWOvzXKcmbNc8ImiA36QyNxlue1N0eeiXmqU
	 TAlmZHeXEB8GFp7R7baD+6AckHiyd3hs+X60U6tS4tgXPxwKSuSL3bmeED+EB8VtK
	 mprG27iM4NTgOeSqFJ9G3LSDadzCTHtUwKin8fP9aF0PlJO+C/SGinprMPAWbDOVG
	 TuKtPasnj+kN8Se0YQ==
X-UI-Sender-Class: 55c96926-9e95-11ee-ae09-1f7a4046a0f6
Received: from localhost ([94.31.75.247]) by mrelayeu.kundenserver.de
 (mreue108 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1N1Ok1-1uEcGy2Dmd-00re1b; Tue, 16 Sep 2025 18:46:07 +0200
Date: Tue, 16 Sep 2025 18:46:06 +0200
From: Christian Heusel <christian@heusel.eu>
To: Naresh Kamboju <naresh.kamboju@linaro.org>
Cc: rust-for-linux@vger.kernel.org, 
	open list <linux-kernel@vger.kernel.org>, Linux Regressions <regressions@lists.linux.dev>, 
	lkft-triage@lists.linaro.org, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Peter Zijlstra <peterz@infradead.org>, Alice Ryhl <aliceryhl@google.com>, 
	Benno Lossin <lossin@kernel.org>, Elle Rhumsaa <elle@weathered-steel.dev>, 
	Dan Carpenter <dan.carpenter@linaro.org>, Arnd Bergmann <arnd@arndb.de>, 
	Anders Roxell <anders.roxell@linaro.org>, Ben Copeland <benjamin.copeland@linaro.org>
Subject: Re: next-20250915: error[E0425]: cannot find function
 `atomic_read_acquire` in crate `bindings`
Message-ID: <27366f94-67d4-4b73-b420-cacdbe9d603f@heusel.eu>
References: <CA+G9fYtT7HNBM2XBbePeZ-Fw+ig7SJ+JE_NpQ1VuHR_TvAjX2w@mail.gmail.com>
 <CA+G9fYs4JB0ngq+aryXHVQSq-f05cb4agCfyM9zN0SgprQf0_A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="tl3l7oscxlsmmgsi"
Content-Disposition: inline
In-Reply-To: <CA+G9fYs4JB0ngq+aryXHVQSq-f05cb4agCfyM9zN0SgprQf0_A@mail.gmail.com>
X-Provags-ID: V03:K1:UpdFU2uAahLiZS0wyFOe047oO8Z6N4yaaZevfwl69BxlOKmVI5k
 Cgj6pSGwHNT9Wyn0Vx7mDgtGhn3Zk/4a25sJlxqf/hKiHXDUdW/euurFTZAdFV0m48DQslK
 2i/ZJgNlkv93YdGp4SVmccBF7Km0ridR+I4uvcBKIlxOnwqFOXw/4GFSE+yilEJWUlF+UvP
 Ctyoo8hItlmcuaYFRZpWg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:EdEoQslSM8U=;5/+m8JTvQKztS6MwM8VFz0OO90Z
 3333JO4PbuKbyzEKOas9k6j1fbDlwnP+dFMGaibtEjynmB6ljSXayoGvv/FGb761uAp8taUZz
 wk359JQ0WcWcdMqg62r0898FBWZnQTzvjFpLEUYfoP5rw7Yl8PstsJoYWme4wMMF6QBXdXZ5Q
 NudX0eVeznO+TOUv6y2CVGIeCGvXPQ+H4GRlyswcmbIjp8rpANzZFuynaQWKH6bkmTQU0wCjF
 bBsr0IHrk6Pwl8jeP3Dw+JjrWzvTWd9wf3WSBFKKgJyfpKdMnce28xsuNjX5R5q9zyMUbh9kC
 KnUZtMIjWzBWQnfD8O+M1fXYV074hJv5Y9Alci72g+28BfK+/BzZPDv6T0G9ZK0A2qjR+It/d
 /jvovKQ5l8JRZaj88DPTjpE3b2ZFU6dh4baCz8D9/yHXleweual5kmALpZ+dUmXcdIGc9aX9X
 61ZRpTjyKLs2qOU+hx/R7U9bS7MQjN+zFIr+jej2BYHEf7wFjIZl07n0wHqYnYzSYfQ7wirlx
 aN8gw1plpX2zXTnGD3mlo25tehrnLnQeTHeTDYBZQQSQk58YQmXbIAtGs4NarrKvnUpBJFJg4
 d1XjijcHDzbyExmf+qS6I4LkrjSnRGfYSz3IazJGajj4eaWrtmXAcPO9oSIwM2AvbTRIqypRi
 Mkz68n7Qd9vyWeDdB6cdByRB1TMQTm74az9GrB1GKDl03pv+ErxGDzip3GuagLyzBUYjZ4ETM
 UYqlPFqEnB8M+x7htteNaS+hsxf6lZ0ZDD2p8R6Ht1zlDKKEHZ5zBhIaUl1FI7Yhc2q+0pYJ2
 y0zWYR0wHyIcC27Oo3kCaloABjZ3Kn/ozM7lq5GdVEH3PFbYu5iAZWDrqGoPYpsweLZgi58CM
 04As2FAtzIGFED8w+EeJxCZYsT9/qIeFZQQGpl4VC9pXwOLfOT3foT2vc38IqXyZCXsrY01eg
 lVOJ9fbhxV7XcYLOL77L1mwTRPTAzv4oECPJXX2EJAibqV4f78nU+XblDMFh/FlR6uNLQpJe6
 J2HK8ti0IQffmOwKQ/zjY9z58g2jvtPWoomPazJngj/raiNd0YGDsK6zwoGxzkmb4spwxMiyl
 wEBbdB92fPDixr79tur3Bj2hCvt77C+YURtjky2nyaPFx86hnX6plp5mZMcNNdv0q8z9G0KQD
 NYVLFxzCgW9/X3JYr1VOE59GlE8XQajvmMtk8Rw09jBHOPBJNDGEsfrwvhrZNhvbXc6DIbGh7
 UnlVClsy07mp3eq4uZMTCwus6JkGKAboqGS6wv+RO37gdxdCssPpwMLJj1i3BNEzrYMYI0W0F
 HkyorK2W6dErra/k3z1jQRUk7NzlkAX2t6PUAmVDVjaPis4vmB6aN0HUtod/VteWSLnNE8jvz
 Zqz2O09RGsG/I6VaBqxbrrLkux1bfs4eEh7GVuM3odTp9aFpUw/hUTQ0DXCV8bNY82AuE0ViD
 XvNY4GZylKlfT8e69Nr1JS33vUWYA//367tI3NX6/+eE6B7o26YkUDmkttLMnb+E7YPX/Bzhc
 vFnjN7RAz77Ac91uztjqhCXiFII2I3ffh8YFoLU65Li/pGSU1+Mxt9roF/dxR/1IE/bCEJroI
 jTkq203T6h/6hFDwqwueJhofkEK/SnoRVCp8okhjtUHTRm0vv+yz7eolnBZVtnZ66fVuoE/QK
 OBCFS7mA7mKqNIT5saW4HH1mOpPhmFa2u5w6RKZQlPoKBstr/WKzEkqSZI5BJ/3jwsAUhQhb4
 eeSU4XtKnEfczoitKcy572af5bloh0eONImFMB2RdZA+LSFbA9HGV3qU=


--tl3l7oscxlsmmgsi
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: next-20250915: error[E0425]: cannot find function
 `atomic_read_acquire` in crate `bindings`
MIME-Version: 1.0

On 25/09/16 09:56PM, Naresh Kamboju wrote:
> On Tue, 16 Sept 2025 at 11:17, Naresh Kamboju <naresh.kamboju@linaro.org>=
 wrote:
> >
> > The following build warnings / errors noticed on the arm arm64 and x86_=
64
> > with rust config build on the Linux next-20250915 tag.
> >
> > First seen on next-20250915
> > Good: next-20250912
> > Bad: next-20250915
> >
> > Regression Analysis:
> > - New regression? yes
> > - Reproducibility? yes
> >
> > * arm, build
> >   - rustclang-lkftconfig-kselftest
> >   - rustgcc-lkftconfig-kselftest
> >
> > * arm64, build
> >   - rustclang-lkftconfig-kselftest
> >   - rustgcc-lkftconfig-kselftest
> >
> > * x86_64, build
> >   - rustgcc-lkftconfig-kselftest
> >   - rustclang-nightly-lkftconfig-kselftest
> >
> > Build regression: next-20250915: error[E0425]: cannot find function
> > `atomic_read_acquire` in crate `bindings`
>=20
> Anders bisected this build regressions and found,
>=20
> # first bad commit:
>  [eb57133305f61b612252382d0c1478bba7f57b67]
>  rust: sync: Add basic atomic operation mapping framework

Is this still an issue on next-20250916? As far as I can tell this has
been fixed, but now there is another rust build issue, see
https://lore.kernel.org/regressions/0fee48bb-7411-4414-b4e7-395a8c3d0f6c@he=
usel.eu/
for more information.

Cheers,
Chris

>=20
> >
> > Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
> >
> > ## Build log
> > error[E0425]: cannot find function `atomic_read_acquire` in crate `bind=
ings`
> >    --> rust/kernel/sync/atomic/internal.rs:124:37
> >     |
> > 124 |                   $unsafe { bindings::[< $ctype _ $func >]($($c_a=
rg,)*) }
> >     |                                       ^^^^^^^^^^^^^^^^^^^^ not
> > found in `bindings`
> > ...
> > 201 | / declare_and_impl_atomic_methods!(
> > 202 | |     /// Basic atomic operations
> > 203 | |     pub trait AtomicBasicOps {
> > 204 | |         /// Atomic read (load).
> > ...   |
> > 216 | | );
> >     | |_- in this macro invocation
> >     |
> >     =3D note: this error originates in the macro `impl_atomic_method`
> > which comes from the expansion of the macro
> > `declare_and_impl_atomic_methods` (in Nightly builds, run with -Z
> > macro-backtrace for more info)
> > error: aborting due to 34 previous errors
> >
> > For more information about this error, try `rustc --explain E0425`.
> > make[3]: *** [rust/Makefile:553: rust/kernel.o] Error 1
> >
> >
> > ## Source
> > * Kernel version: 6.17.0-rc6
> > * Git tree: https://kernel.googlesource.com/pub/scm/linux/kernel/git/ne=
xt/linux-next.git
> > * Git describe: 6.17.0-rc6-next-20250915
> > * Git commit: c3067c2c38316c3ef013636c93daa285ee6aaa2e
> > * Architectures: arm, arm64 and x86_64
> > * Toolchains: gcc (Debian 15.2.0-3) 15.2.0
> > * Kconfigs: rust config
> >
> > ## Build
> > * Build log: https://qa-reports.linaro.org/api/testruns/29894207/log_fi=
le/
> > * Build details:
> > https://regressions.linaro.org/lkft/linux-next-master/next-20250915/bui=
ld/rustgcc-lkftconfig-kselftest/
> > * Build plan: https://tuxapi.tuxsuite.com/v1/groups/linaro/projects/lkf=
t/builds/32l4UDzp0FMtS73JeG3kWpcoQrm
> > * Build link: https://storage.tuxsuite.com/public/linaro/lkft/builds/32=
l4UDzp0FMtS73JeG3kWpcoQrm/
> > * Kernel config:
> > https://storage.tuxsuite.com/public/linaro/lkft/builds/32l4UDzp0FMtS73J=
eG3kWpcoQrm/config
> >
> > --
> > Linaro LKFT
>=20
> - Naresh
>=20

--tl3l7oscxlsmmgsi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEb3ea3iR6a4oPcswTwEfU8yi1JYUFAmjJlEoACgkQwEfU8yi1
JYUh2hAAyo0MneTix6hFjD8ruKiMvRwwgbkfjDjj29QW0/pOaq/WyxT8FBGvJWSv
JUZSBSS3HsoM+KPqhlRwbv9TheDGNnNCYqM5w4P83XgmzYWC4zjl/ITX8H3UH28s
14/vPbYTC8are1EdkDGzrBw/wRg7ekqQE75BOVxPqTMOJ4IQlcTKkVaMZWwH6L7Y
XdECQomFGuD24WQ0ezkhHPkkEmg+VDqYYH5s+Q8hRn4w+uYDGWGegrjSfXUYzoj6
/vl6dkxmx9kQj99lFDebsvw6piNyAfSeS37EuYDE+uz0qf+dU1yWO7RMDsbcZY0K
Jdkpv0GRJt/p3WaOhO2P6iT0BGgz8dYG0B6I65UdqZUPT0Z/YMjmH6gsG5ShSyrm
RH+K8JV90VTgXa1USh2wjG7mGas9gEfGeLSogZNCjWjgiPa5sFXS3xx/e4KX6stF
KTFaW6GxdMsmeqy1F9cr4/CzyI1Tek9e985VOrsuHmnGqEK3rQb7eeXueYM5VIXR
yoJL3DcuSyOAVlt+/jhmOUZQeN3sok2K+ke8ApNzQBU6XyeY5ErlWndKjIfNtY/4
hsw/Q6VVQfiyIdXqinb+tIdL753aViGusuOFh4fU5/9tEjkXdg9oFqU7INj62x8A
b34zElsjs/uGjkVbAR/0RujA6kedS7k3SMFKqX6z/1MfmcfYqZ8=
=+ihB
-----END PGP SIGNATURE-----

--tl3l7oscxlsmmgsi--

