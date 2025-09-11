Return-Path: <linux-kernel+bounces-812521-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F195B5392A
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 18:26:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2C31FA06C58
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 16:25:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C164369988;
	Thu, 11 Sep 2025 16:23:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mMEp+KuT"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1EF63629B5
	for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 16:23:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757607815; cv=none; b=sIQMtPxXzRmt2pd9rMlILx2tQbrxZx8cJsnxg+/K0UL/+dLo3QCZSWDfj31xSHFboKIdwgPXq2tMGCOmnnWLiyozXRqqPCSb1a1ZuaTsa0q+QQNYXlSOGOmX0vtt8Bc0Xf+qGXJaD1pLXkoz09btyT0fo8EyhCu60jpDx2a6C1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757607815; c=relaxed/simple;
	bh=9QxraYm5GUXl7u0Oai/gva02p1eqz1FDVLfEUwZUjL4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mQf24vCFF2zXC+5uu/3O8U1yWQd8ZsUNUNF9cz7aI2CGWQMMI5Erk7aQElOiSk0xf1e5UwcCexu9/DjVR37C5jV0m2edNnWZKNIL3RXb+2jk6j+XUvFb3M7OxCntxxQuETjngZujrbV8SheXn9I/wV+gfWKmf/I8iLOt9ud+oiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mMEp+KuT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2208C4CEF0;
	Thu, 11 Sep 2025 16:23:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757607815;
	bh=9QxraYm5GUXl7u0Oai/gva02p1eqz1FDVLfEUwZUjL4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mMEp+KuToFa34pqvXC293dC/bMZBCA2jf39qtrvLFLtDv/jTjek/wWdEUC2zGsdFq
	 0fUFc2eTzSZ/aLutBhS7V4XjRgFqzVDCTyXFbPpfbjFch/3tIMTu6KCUVzM0dLeKiT
	 eLlJGLRWQSG3vnaYejiczvXdACq6Wfh1BrMPuK3lETFnL4PPXHgpkwxL0t204tBo2F
	 nDhZc90oobiuGCV34Vd/yNGKHeJfBnQewGHLrx9iUTFofDOMjZU5/cFqU1SMk+cp2L
	 Q9A0c6e9zs2ca6E9GsAWjvNOBQQJEb7u4XhU5yXM+QtSu3mMe65Ii8V5hwB9/acC1C
	 3ppwPVU7AcoIQ==
Date: Thu, 11 Sep 2025 17:23:30 +0100
From: Conor Dooley <conor@kernel.org>
To: Drew Fustini <fustini@kernel.org>
Cc: Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	Kornel =?utf-8?Q?Dul=C4=99ba?= <mindal@semihalf.com>,
	Adrien Ricciardi <aricciardi@baylibre.com>,
	James Morse <james.morse@arm.com>,
	Atish Kumar Patra <atishp@rivosinc.com>,
	Atish Patra <atish.patra@linux.dev>,
	Vasudevan Srinivasan <vasu@rivosinc.com>, guo.wenjia23@zte.com.cn,
	liu.qingtao2@zte.com.cn, linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] RISC-V: Detect Ssqosid extension and handle srmcfg
 CSR
Message-ID: <20250911-chaste-rare-fbc3b48a341a@spud>
References: <20250910-ssqosid-v6-17-rc5-v1-0-72cb8f144615@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="66oBAo5TwOQvaR8d"
Content-Disposition: inline
In-Reply-To: <20250910-ssqosid-v6-17-rc5-v1-0-72cb8f144615@kernel.org>


--66oBAo5TwOQvaR8d
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 10, 2025 at 11:15:28PM -0700, Drew Fustini wrote:
> This series adds support for the RISC-V Quality-of-Service Identifiers
> (Ssqosid) extension [1] which adds the srmcfg register. This CSR=20
> configures a hart with two identifiers: a Resource Control ID (RCID)
> and a Monitoring Counter ID (MCID). These identifiers accompany each
> request issued by the hart to shared resource controllers.
>=20
> Background on RISC-V QoS:
>=20
> The Ssqosid extension is used by the RISC-V Capacity and Bandwidth
> Controller QoS Register Interface (CBQRI) specification [2]. QoS in
> this context is concerned with shared resources on an SoC such as cache
> capacity and memory bandwidth. Intel and AMD already have QoS features
> on x86 and ARM has MPAM. There is an existing user interface in Linux:
> the resctrl virtual filesystem [3].
>=20
> The srmcfg CSR provides a mechanism by which a software workload (e.g.
> a process or a set of processes) can be associated with an RCID and an
> MCID. CBQRI defines operations to configure resource usage limits, in
> the form of capacity or bandwidth. CBQRI also defines operations to
> configure counters to track the resource utilization.
>=20
> Goal for this series:
>=20
> These two patches are taken from the implementation of resctrl support
> for RISC-V CBQRI. Please refer to the proof-of-concept RFC [4] for
> details on the resctrl implementation. More recently, I have rebased
> the CBQRI support on mainline [5]. Big thanks to James Morse for the
> tireless work to extract resctrl from arch/x86 and make it available
> to all archs.
>=20
> I think it makes sense to first focus on the detection of Ssqosid and
> handling of srmcfg when switching tasks. It has been tested against a
> QEMU branch that implements Ssqosid and CBQRI [6]. A test driver [7]
> was used to set srmcfg for the current process. This allows switch_to
> to be tested without resctrl.
>=20
> Changes from RFC v2:
>  - Rename all instances of the sqoscfg CSR to srmcfg to match the
>    ratified Ssqosid spec
>  - RFC v2: https://lore.kernel.org/linux-riscv/20230430-riscv-cbqri-rfc-v=
2-v2-0-8e3725c4a473@baylibre.com/
>=20
> Changes from RFC v1:
>  - change DEFINE_PER_CPU to DECLARE_PER_CPU for cpu_sqoscfg in qos.h to
>    prevent linking error about multiple definition. Move DEFINE_PER_CPU
>    for cpu_sqoscfg into qos.c
>  - renamed qos prefix in function names to sqoscfg to be less generic
>  - handle sqoscfg the same way has_vector and has_fpu are handled in the
>    vector patch series
>  - RFC v1: https://lore.kernel.org/linux-riscv/20230410043646.3138446-1-d=
fustini@baylibre.com/
>=20
> [1] https://github.com/riscv/riscv-ssqosid/releases/tag/v1.0
> [2] https://github.com/riscv-non-isa/riscv-cbqri/releases/tag/v1.0
> [3] https://docs.kernel.org/filesystems/resctrl.html
> [4] https://lore.kernel.org/linux-riscv/20230419111111.477118-1-dfustini@=
baylibre.com/
> [5] https://github.com/tt-fustini/linux/tree/b4/cbqri-v6-17-rc5
> [6] https://github.com/tt-fustini/qemu/tree/riscv-cbqri-rqsc-pptt
> [7] https://github.com/tt-fustini/linux/tree/ssqosid-v6-17-rc5-debug
>=20
> Signed-off-by: Drew Fustini <fustini@kernel.org>
> ---
> Drew Fustini (2):
>       RISC-V: Detect the Ssqosid extension
>       RISC-V: Add support for srmcfg CSR from Ssqosid ext
>=20
>  MAINTAINERS                        |  6 ++++++
>  arch/riscv/Kconfig                 | 17 ++++++++++++++++
>  arch/riscv/include/asm/csr.h       |  8 ++++++++
>  arch/riscv/include/asm/hwcap.h     |  1 +
>  arch/riscv/include/asm/processor.h |  3 +++
>  arch/riscv/include/asm/qos.h       | 41 ++++++++++++++++++++++++++++++++=
++++++
>  arch/riscv/include/asm/switch_to.h |  3 +++
>  arch/riscv/kernel/cpufeature.c     |  1 +

Why is there no binding change here? Is it not possible to use the
extension on DT systems, or is this an oversight?

--66oBAo5TwOQvaR8d
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaML3ggAKCRB4tDGHoIJi
0sDhAP0Y7MCc4EvQQ+4eO1Eg3H3Ujeucf8hI6xyXcdaIGBykMAD9E/9sPo9X2ojz
/FZEoMDL+uhV7qYu4lfS54vhGJOVcAI=
=u1qT
-----END PGP SIGNATURE-----

--66oBAo5TwOQvaR8d--

