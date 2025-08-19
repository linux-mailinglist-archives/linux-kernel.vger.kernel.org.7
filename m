Return-Path: <linux-kernel+bounces-775278-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C741CB2BD73
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 11:34:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0A859188DB2C
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 09:29:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6634C31B102;
	Tue, 19 Aug 2025 09:27:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IKzGln0n"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABC3231A06A;
	Tue, 19 Aug 2025 09:27:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755595669; cv=none; b=WQNI4PHZjZJyhW6Tf67OuPxAxnxWju4/WfsbmlC/D8qr/EwxJpxWsktZpMWnBHih3/jmIxrzBt03PvxoeXHIjZRiVPDna8bzHP390rn6nGZZeyNcdoIBdapru/LsP3F0rW3oi69xMoq79G0MQkBDK4z2kz5tYoUlhFaLj3mbctI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755595669; c=relaxed/simple;
	bh=mlRwEb7SX4oAgBhpmfaZnnPryE/EzdfZteXaY9t1JnY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FBjQGkruQEtbeM3me7+L4maWsTZ9HflpHsd5Xul0hm8L4XcYgKdPnU+KqM1QwPhJgiHpVO8L6eWlvv3XfzncJq+m9gOzrOQYrtgyrdqyMFITr9L0tHM3HHroCRuD2X+bBe1cibRyoh7i/NjNXzgWMhfkR1Ii9nq/BOF2iaw7/xk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IKzGln0n; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D208BC4CEF1;
	Tue, 19 Aug 2025 09:27:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755595669;
	bh=mlRwEb7SX4oAgBhpmfaZnnPryE/EzdfZteXaY9t1JnY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IKzGln0nO4/46/KG061bA2HjsGcUHqr5QTHjf/nSkvPMELf7hAbBi+d1ZCpNUMZIp
	 5itY7VQUqiDgwHY2UYjGShwo+kuq11WHmHWlO/qU5ZTnOLyf8BTzNbOGjmk1K8BBUY
	 HQoTfLLQq9SdWP/GDtQ8hlH4Np3Qlb1dhbnA0EgC57bPjJTIVDLj7vbP29B5JxzFj1
	 oBEoGPlX07WcXrYfk0/R0xAv8CWfy2OehL5KTN3Xh7n1goSgwZTBTKyZt532V+UlGV
	 T70yIp9dUybrfu2d0oCMZaKKy6w0t+SP8qmfO2kObGGIykaB3RLWRcryQWS3FD2uvP
	 tXWZvfb7muADg==
Date: Tue, 19 Aug 2025 11:27:45 +0200
From: Maxime Ripard <mripard@kernel.org>
To: Brian Masney <bmasney@redhat.com>
Cc: Michael Turquette <mturquette@baylibre.com>, 
	Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/9] clk: add kernel docs for struct clk_core
Message-ID: <b3kfxuvkz5elhkquj7iqajcoibozsysskwvbfw7rlhvo5sebhq@5uhoib7h5dtl>
References: <20250812-clk-tests-docs-v3-0-054aed58dcd3@redhat.com>
 <20250812-clk-tests-docs-v3-1-054aed58dcd3@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha384;
	protocol="application/pgp-signature"; boundary="mjii5jltq4fisuad"
Content-Disposition: inline
In-Reply-To: <20250812-clk-tests-docs-v3-1-054aed58dcd3@redhat.com>


--mjii5jltq4fisuad
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v3 1/9] clk: add kernel docs for struct clk_core
MIME-Version: 1.0

Hi,

On Tue, Aug 12, 2025 at 10:40:31AM -0400, Brian Masney wrote:
> Document all of the members of struct clk_core.
>=20
> Signed-off-by: Brian Masney <bmasney@redhat.com>
> ---
>  drivers/clk/clk.c | 55 +++++++++++++++++++++++++++++++++++++++++++++++++=
++++++
>  1 file changed, 55 insertions(+)
>=20
> diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
> index b821b2cdb155331c85fafbd2fac8ab3703a08e4d..41690448ce9ada8eaa3022195=
0da4a3b1c4552d2 100644
> --- a/drivers/clk/clk.c
> +++ b/drivers/clk/clk.c
> @@ -57,6 +57,61 @@ struct clk_parent_map {
>  	int			index;
>  };
> =20
> +/**
> + * struct clk_core - This structure represents the internal state of a c=
lk
> + * within the kernel's clock tree. Drivers do not interact with this str=
ucture
> + * directly. The clk_core is manipulated by the framework to manage clock
> + * operations, parent/child relationships, rate, and other properties.
> + *
> + * @name:              Unique name of the clk for identification.
> + * @ops:               Pointer to hardware-specific operations for this =
clk.
> + * @hw:                Pointer for traversing from a struct clk to its
> + *                     corresponding hardware-specific structure.
> + * @owner:             Kernel module owning this clk (for reference coun=
ting).
> + * @dev:               Device associated with this clk (optional)
> + * @rpm_node:          Node for runtime power management list management.
> + * @of_node:           Device tree node associated with this clk (if app=
licable)
> + * @parent:            Pointer to the current parent in the clock tree.
> + * @parents:           Array of possible parents (for muxes/selectable p=
arents).
> + * @num_parents:       Number of possible parents
> + * @new_parent_index:  Index of the new parent during parent change.
> + * @rate:              Current clock rate (Hz). This is effectively a ca=
ched
> + *                     value of what the hardware has been programmed wi=
th. It's
> + *                     initialized by reading the value at boot time, an=
d will
> + *                     be updated every time an operation affects the ra=
te.
> + *                     Clocks with the CLK_GET_RATE_NOCACHE flag should =
not use
> + *                     this value, as its rate is expected to change beh=
ind the
> + *                     kernel's back (because the firmware might change =
it, for
> + *                     example). Also, if the clock is orphan, it's set =
to 0
> + *                     and updated when (and if) its parent is later loa=
ded, so
> + *                     its content is only ever valid if clk_core->orpha=
n is
> + *                     false.
> + * @req_rate:          The last rate requested by a call to clk_set_rate=
=2E It's
> + *                     initialized to clk_core->rate. It's also updated =
to
> + *                     clk_core->rate every time the clock is reparented=
, and
> + *                     when we're doing the orphan -> !orphan transition.
> + * @new_rate:          New rate to be set during a rate change operation.
> + * @new_parent:        Pointer to new parent during parent change.
> + * @new_child:         Pointer to new child during reparenting.

I think both can also be used during a rate change that affects the
parenting, right?

> + * @flags:             Clock property and capability flags.
> + * @orphan:            True if this clk is currently orphaned.
> + * @rpm_enabled:       True if runtime power management is enabled for t=
his clk.
> + * @enable_count:      Reference count of enables.
> + * @prepare_count:     Reference count of prepares.
> + * @protect_count:     Protection reference count against disable.
> + * @min_rate:          Minimum supported clock rate (Hz).
> + * @max_rate:          Maximum supported clock rate (Hz).
> + * @accuracy:          Accuracy of the clock rate (parts per billion).
> + * @phase:             Current phase (degrees).
> + * @duty:              Current duty cycle configuration.

We should probably mention the unit here too. I assume it's in percent?

Looks good otherwise. Once fixed,
Reviewed-by: Maxime Ripard <mripard@kernel.org>

Maxime

--mjii5jltq4fisuad
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJUEABMJAB0WIQTkHFbLp4ejekA/qfgnX84Zoj2+dgUCaKRDkQAKCRAnX84Zoj2+
dswRAX4wgR60klAwrWDL/lT/4T47QpCTjFlOgT/Pe9nulGeVn9SLRjrPrszRRlqW
eaI0OJgBfipVIYXvl3dAgMv/ws1tqsQ9XKhWmdUeyFhLuza7e5hUzvo8skend1wB
Y8kU01QYxg==
=bhAh
-----END PGP SIGNATURE-----

--mjii5jltq4fisuad--

