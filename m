Return-Path: <linux-kernel+bounces-853167-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C582BDAD60
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 19:47:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 83DCA4EB835
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 17:47:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C5B028FA91;
	Tue, 14 Oct 2025 17:47:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KASKeYjV"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03D0635948
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 17:47:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760464051; cv=none; b=Gp0+1dMuiQiEU3UuQeqwSh8hILqVxaxDlO+3i+bsItGmwJtkfIVE8v1AsYm9D6fkjh1ZHaCCuK9YOgXyPdE/oTA7nrtZGmeiqczWmPMcD2f1oMrP8tB4Hz3tWi11GTTi5Yd6lzbjeyNw7PgfOA8DY7NGJ7ONv7TxddO8RjGwQiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760464051; c=relaxed/simple;
	bh=OC84EuBFP9yfoy7CzUJOQryfa1blEGQPmqdzo1E57lI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ha4A8MHiIPJrOYgEkY+7SONHr7Iukv+eUbWaGWah52IKL0AQ61KUKceu+Vzgm5ob4P1jTVwEhRw+wrin7PfTOBbqGVcUgJ6ES9wZD+twKJ8Q5f44TinzK4OQgoMQOORgk6QQA8nCo4rHYb/irg6D7oYklfM/0dcP1me9mBrCCiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KASKeYjV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6666FC4CEE7;
	Tue, 14 Oct 2025 17:47:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760464050;
	bh=OC84EuBFP9yfoy7CzUJOQryfa1blEGQPmqdzo1E57lI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KASKeYjVUTH3PqDcchUO7bZMufvM0SIz0SRz6YfNNx3+DP67690bNiCO70/AdPkoS
	 RYDN9GDYn9/g/fAtEPGeitem5XDOAEGfW/2NoP2fbrP5Oo74eQOPZq47E1+/YqdiOs
	 lZb4dqnG87/WhJM4y6/k35RpA200Dtq7z9c0rH0WHrgBQlP8kfLd3M6FfFLA3iln17
	 RQxmvOPgAWayoDtCYuTYw6sTrcehXuLLF2yxXVnmt9UmH4mLRymFlmNizDTPEUmCU5
	 IGqMYrZhj+kag9011XEm5zKgxk8Bspm8jyTROMIVUi8CuEUDq+0r7QKiWp8lVXPRi8
	 5DRTSWwpgKgqg==
Date: Tue, 14 Oct 2025 18:47:26 +0100
From: Conor Dooley <conor@kernel.org>
To: Vivian Wang <wangruikang@iscas.ac.cn>
Cc: Lucas Zampieri <lzampier@redhat.com>, linux-kernel@vger.kernel.org,
	Charles Mirabile <cmirabil@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Samuel Holland <samuel.holland@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	Vivian Wang <dramforever@live.com>, linux-riscv@lists.infradead.org,
	Zhang Xincheng <zhangxincheng@ultrarisc.com>
Subject: Re: [PATCH v2 3/3] irqchip/plic: add support for UltraRISC DP1000
 PLIC
Message-ID: <20251014-coma-zeppelin-56256bf7e3e6@spud>
References: <20251013111539.2206477-1-lzampier@redhat.com>
 <20251013111539.2206477-4-lzampier@redhat.com>
 <20251013-trimness-stainless-48343053f204@spud>
 <6b7c3c90-d3bd-4d75-9cc0-74d3945fbdfd@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Eck5RHWSnCUGqPAQ"
Content-Disposition: inline
In-Reply-To: <6b7c3c90-d3bd-4d75-9cc0-74d3945fbdfd@iscas.ac.cn>


--Eck5RHWSnCUGqPAQ
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 14, 2025 at 05:14:17PM +0800, Vivian Wang wrote:
> Hi Conor,
>=20
> On 10/14/25 02:30, Conor Dooley wrote:
> > On Mon, Oct 13, 2025 at 12:15:38PM +0100, Lucas Zampieri wrote:
> >> From: Charles Mirabile <cmirabil@redhat.com>
> >>
> >> Add a new compatible for the plic found in UltraRISC DP1000 with a qui=
rk to
> >> work around a known hardware bug with IRQ claiming.
> >>
> >> When claiming an interrupt on the DP1000 PLIC all other interrupts mus=
t be
> >> disabled before the claim register is accessed to prevent incorrect
> >> handling of the interrupt.
> >>
> >> When the PLIC_QUIRK_CLAIM_REGISTER is present, during plic_handle_irq
> >> the enable state of all interrupts is saved and then all interrupts
> >> except for the first pending one are disabled before reading the claim
> >> register. The interrupts are then restored before further processing of
> >> the claimed interrupt continues.
> >>
> >> The driver matches on "ultrarisc,cp100-plic" to apply the quirk to all
> >> SoCs using UR-CP100 cores, regardless of the specific SoC implementati=
on.
> > Why is that? I expect that you're doing that intentionally given the
> > ultrarisc employee listed as a co-developer, but with only one SoC using
> > this IP core it seems possible that this bug in the hardware could be
> > fixed for other SoCs that are built using this IP core.
> > Is there a plan to, for example, change the core version to UR-CP101
> > when the bug is fixed?
>=20
> I originally proposed to match on ultrarisc,cp100-plic under the
> assumption that it would be the case.
>=20
> Furthermore, it is my understanding that if the bug is fixed in, say,
> UR-DP1001, then the PLIC node can simply be
>=20
> =A0 =A0 compatible =3D "ultrarisc,dp1001-plic", "sifive,plic-1.0.0";
>=20
> I meant my reply that I had assumed this bug was associated with the
> UR-CP100 core, but I should have stated so more clearly.=A0

Ah ye, very true, could be done that way if there's a changed version
that's compliant.

--Eck5RHWSnCUGqPAQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaO6MrQAKCRB4tDGHoIJi
0lASAQDunHKDUhoLhTyJvT7pkWAOan78lbIL/4qDP7M47VuIvgD/U4EAlAQLiNV8
FsdMjrvL/8CLKBVSBkHa1eYJxzoq4AY=
=LWPz
-----END PGP SIGNATURE-----

--Eck5RHWSnCUGqPAQ--

