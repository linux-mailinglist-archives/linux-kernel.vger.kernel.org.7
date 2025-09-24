Return-Path: <linux-kernel+bounces-831176-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E3F56B9BC89
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 21:55:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B530B19C2432
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 19:55:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9F4F2701BB;
	Wed, 24 Sep 2025 19:55:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nFVc7KK7"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 333C019AD5C;
	Wed, 24 Sep 2025 19:55:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758743728; cv=none; b=RQFJt8C6eIIImKZzg9fAeJ9y8oN7seQ+n7eCAvtfs2m4VAl8B0PiSDR9m+nnyFNQZPpXqIbXCeaZsROUAHxqCSdPoygB+v3SrTYrg3g5PYiHGElPTQKn6AWxwRAJ4WLhaeMKca0Zdk4gW8ILs6OhiQAJlDMvz8A5L5l8wZtsT3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758743728; c=relaxed/simple;
	bh=b7tMSRatNPiuUi1gczrNM41fbVsirIkhBCPf9ks04OQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LP9WLXBn6ULdE16mx3+NO0i2q6djjkd337yRne5tpJnheE8424CTF9gtgVRrrBzqp8JfaJA9kcQYzoOvE/pBa0n2pmkGYCmjX945psN/KmlYwTluGx/eTwysanYvkftZCPzsDKmSVeVSZToPXSlSlo18K5SnlL9Gl5bLUkfZbSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nFVc7KK7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21653C4CEE7;
	Wed, 24 Sep 2025 19:55:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758743726;
	bh=b7tMSRatNPiuUi1gczrNM41fbVsirIkhBCPf9ks04OQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nFVc7KK7Q1ZufpyE0VhGLu+kdBFhx6oSfNOFquaomDFqg5zUCjeUE66sKmpvo07lX
	 b90Xhu9oppxERU0mViZrIUi+a+jsJhxylvEAuytriwCjqJRDWP2MJ5+pyF8x6LdIlC
	 PWYTTnCQhJsp2Ic1HZdBosvXh/EPT0mmuzi8snzVZPVSjLrZbV+0jFq/1ddRQ+bau7
	 2LBwoMz5Zt/lu+iDcn1HRIG9hzQ5MFVvB8cKtg5a/ug3I1KT7PSZBXiQIqOEmHW3fK
	 DyrkEwPkLxKKky6zfb1iAY5m8BHbphvZDMPauE8rI/9k2lgCmArFl4tDOFZ3U0XAis
	 ZOOJAxrNpRekw==
Date: Wed, 24 Sep 2025 20:55:22 +0100
From: Conor Dooley <conor@kernel.org>
To: Hang Cao <caohang@eswincomputing.com>
Cc: gregkh@linuxfoundation.org, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, Thinh.Nguyen@synopsys.com,
	p.zabel@pengutronix.de, linux-kernel@vger.kernel.org,
	linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
	ningyu@eswincomputing.com, linmin@eswincomputing.com,
	pinkesh.vaghela@einfochips.com,
	Senchuan Zhang <zhangsenchuan@eswincomputing.com>
Subject: Re: Re: [PATCH v3 1/2] dt-bindings: usb: Add ESWIN EIC7700 USB
 controller
Message-ID: <20250924-shimmer-sphinx-1a12caeab401@spud>
References: <20250915085329.2058-1-caohang@eswincomputing.com>
 <20250915091024.2128-1-caohang@eswincomputing.com>
 <20250915-affair-halves-4f881f6c7cdb@spud>
 <17731a13.1cce.19974dfc64d.Coremail.caohang@eswincomputing.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="NTUzUaWJZNr9XbDj"
Content-Disposition: inline
In-Reply-To: <17731a13.1cce.19974dfc64d.Coremail.caohang@eswincomputing.com>


--NTUzUaWJZNr9XbDj
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 23, 2025 at 12:40:46PM +0800, Hang Cao wrote:
> > > From: Hang Cao <caohang@eswincomputing.com>
> > > +  eswin,hsp-sp-csr:
> > > +    description:
> > > +      HSP CSR is to control and get status of different high-speed p=
eripherals
> > > +      (such as Ethernet, USB, SATA, etc.) via register, which can cl=
ose
> > > +      module's clock,reset module independently and tune board-level=
's
> > > +      parameters of PHY, etc.
> > > +    $ref: /schemas/types.yaml#/definitions/phandle-array
> > > +    items:
> > > +      - items:
> > > +          - description: phandle to HSP Register Controller hsp_sp_c=
sr node.
> > > +          - description: usb bus register offset.
> > > +          - description: axi low power register offset.
> > > +          - description: vbus frequency register offset.
> > > +          - description: mpll register offset.
> >=20
> > As I mentioned on the shdci binding patch, I'm not happy with the
> > justification for this phandle. What exactly is the clock that this
> > controls and why does it not have a dedicated clock-controller driver
> > and reset-controller driver?
> >=20
> In the current design framework, the clock can be divided into two parts:=
=A0
> 1. The top-clock, which is used to manage and control the clocks of vario=
us subsystems (such as HSP, GPU, NPU, etc.);=A0
> 2. The subsystem clocks managed independently by each subsystem.
> The top-clock is a standard clock design(featuring gate, divider, and mux=
 functions) that has been registered in the=A0
> common clock framework,with a dedicated clock controller driver.
>=20
> The subsystem clocks managed by subsystems are controlled and configured =
through the CSR (Control and Status Register)=A0
> of each respective subsystem. For example, the HSP subsystem uses the esw=
in,hsp-sp-csr. Additionally, this CSR is
> =A0responsible for managing startup functions, performing independent res=
et of specific modules, and adjusting=A0
> PHY parameters to achieve board-level tuning (for USB/SATA interfaces, et=
c.).

Unlike the use of the HSP in the sdhci driver, where it appears to be
setting bits that indicate stability (according to your colleague) what
you say here (and what is done in the driver on the reset side in
particular) seems like something that should be handled by a dedicated
driver. "independent reset of specific modules" is the domain of
reset-controller drivers. What are the other modules for which the HSP
has resets? Does it have clocks for other modules too?

> The top-clock manages the global clocks of subsystems. Taking the HSP sub=
system as an example, the top-clock
> =A0configures the hsp_aclk_ctrl and hsp_cfg_ctrl of HSP subsystem only.

> In contrast, the subsystem clocks are managed via their own CSRs. For ins=
tance, the USB ref clock used in the USB module of=A0
> the HSP subsystem can only be configured through the hsp-csr, and cannot =
be set via the top-clock controller driver.
> As for the reset function, it is not integrated into a dedicated controll=
er driver either, for reasons similar to those of the=A0
> clock management mentioned above.

That just sounds to me like the hsp-csr needs to become both a
reset-controller and a clock-controller! It's not unusual to have more
than one clock-controller in an device, the top-clock being a
clock-controller does not mean that the HSP also cannot be one.


--NTUzUaWJZNr9XbDj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaNRMqQAKCRB4tDGHoIJi
0tWjAP9rnj6LBBt2RvkZZpyWdjjtrL57PNlebKO2HzRQiCciMQEAobZWD6QhY9Us
t+BXD1QAI79Mrf2XA3QZOFR2AjJ0Cgk=
=cO52
-----END PGP SIGNATURE-----

--NTUzUaWJZNr9XbDj--

