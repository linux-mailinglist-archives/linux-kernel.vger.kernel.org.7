Return-Path: <linux-kernel+bounces-886918-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 11E38C36CA1
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 17:49:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 341184FAA4F
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 16:26:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B712B3195E5;
	Wed,  5 Nov 2025 16:26:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pOwS0edG"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CFE12248BE
	for <linux-kernel@vger.kernel.org>; Wed,  5 Nov 2025 16:26:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762359977; cv=none; b=rkyeLyj8qlBho5K0SgmCaEAibX0/SPz/Nw787P8VEfkHl2vt/tgwDRhy9RwvR5dWytBJgdW2EyZ1JNWxACbPUw1F/AZi9OgaVXcJsZ5AbJaNlxY2q80lJK+AcFPt85MrnTT0ev8L8/a57PxoyyBxVQpZ7Y6NCc8IJIy+eGIN1JE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762359977; c=relaxed/simple;
	bh=EfG74v4V1kQCUmquknG5JlX59da5IXwfDOC9fFb+6XU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mwfzI3hg6LxfiSfN7mwQS9V4hHi8lN3cg9ZR13vR+uoQfxeUu2ljsd1xORoO4EOzR8sHJHnyTIdU/ACfGkn6LQ1/iVqGMbWcQbMEpT6Lw6uSbIoI/gqv7EnNNOKjnN/vp60F8nb19x+iXpPuaIvu4lnWgX0tAlZTyoS4IQr6bFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pOwS0edG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41E7EC4CEF5;
	Wed,  5 Nov 2025 16:26:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762359976;
	bh=EfG74v4V1kQCUmquknG5JlX59da5IXwfDOC9fFb+6XU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pOwS0edGmUiaWhUGquCLEFiJVJyIQ+DtgJUg85g2l3fyxt5ujQW8HPCnDsPbsGLjb
	 AVu7JbvxvhIoqGvSZeeFAtU5TXTK83rSFiMIAfqgZbQ66M+XGpivModJHPNR2DPqnW
	 leV8oPN7NuXBqp7VRd8BF75oV0e9m8Rt5kUnqV35j8i0ziPkhET2llsLo+vM4K4mQI
	 zOQhHzVmH0KkYyv58m6Cq5oZb1ru4qu0E9HEgpeiUd7aRJPEL66a+7URHFql24HrTA
	 UXyStWcdO1fNaHnLZEovDuTfu4DygPjMuuZ6v32pPyH+dki+k7VjzgtwYVbOrP7VTF
	 Os+py4mcQVp8Q==
Date: Wed, 5 Nov 2025 16:26:14 +0000
From: Mark Brown <broonie@kernel.org>
To: Marco Crivellari <marco.crivellari@suse.com>
Cc: linux-kernel@vger.kernel.org, Tejun Heo <tj@kernel.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Michal Hocko <mhocko@suse.com>, Liam Girdwood <lgirdwood@gmail.com>
Subject: Re: [PATCH] regulator: qcomm-labibb: replace use of system_wq with
 system_percpu_wq
Message-ID: <aQt6pofw-Ub-lEbZ@finisterre.sirena.org.uk>
References: <20251105162024.314040-1-marco.crivellari@suse.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="+YTPwd3WhqaHjLSV"
Content-Disposition: inline
In-Reply-To: <20251105162024.314040-1-marco.crivellari@suse.com>
X-Cookie: If in doubt, mumble.


--+YTPwd3WhqaHjLSV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Nov 05, 2025 at 05:20:24PM +0100, Marco Crivellari wrote:

> Replace system_wq with system_percpu_wq, keeping the old behavior.
> The old wq (system_wq) will be kept for a few release cycles.

As with the ASoC stuff I'm really not convinced that this driver cares
about this being per CPU so we'd be better off just using the unbound
workqueue.  The fact that the existing API was per CPU by default feels
like a bit of a landmine and baking it in explicitly makes the driver
code more confusing.

--+YTPwd3WhqaHjLSV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmkLeqIACgkQJNaLcl1U
h9DHjgf/e6PwT5TB5+64DDV9ftj+5apBWH4mg0Hleb+rjZdierVSxq2kYTmzLnW2
woQqUI1IQh735ZxwFkgOq3IoTWQWzx9J7AEVwv/8bmV0UXDvvn+8dPTOdqQpDxqj
Kj86dp8dKylVWxMyEDAoZbzEhlA901N7Y8RssMYQi+rtacuUKUKkp+WVAajHi8m7
VGKxLb94CHxqEW9JYxkQk7NlUZZmiAkbe+AeVnOIh2yjrobEF9NHUlXjHGvLNJH0
ND7ouSf+IGN+/20bYODE6NmnciU5JurcYZLFOEqAUIFuU6cuwExVDRYsQ2OJZ8sw
vXO1dZHZ9vil2IZpx6fTelhgPFsI1Q==
=tJe1
-----END PGP SIGNATURE-----

--+YTPwd3WhqaHjLSV--

