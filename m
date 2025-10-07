Return-Path: <linux-kernel+bounces-844284-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FC69BC1739
	for <lists+linux-kernel@lfdr.de>; Tue, 07 Oct 2025 15:15:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 56AF24F20A1
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Oct 2025 13:15:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46EDE2E0928;
	Tue,  7 Oct 2025 13:15:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YTSYY3Uy"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D03C2E0B69;
	Tue,  7 Oct 2025 13:15:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759842920; cv=none; b=HFVxGcdrpqHjxEsHTfdH4f6+O/6wP3cLXM6H52b4NVF6gJ16KwparjZ6ea5sby83ZLquXU8mzzjP4MSSoHsOiVU82ugZ1lWKAP+zbo2edXiqb0Jsp+WP5Fad/guwhvqRFPNAFnn7m0iYM/BCVMa5k42hkRXqn+AKc1sTOSnvUs8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759842920; c=relaxed/simple;
	bh=7Ds6za995kRmFU9u7IDO1WDKFYmSApctqb2MqozwvXc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i1DSVdoszr4bSLfa2kNhY7c7lwbyELixKiAYmCNq4TLleINT1RHl9V27J9rkIsaZo+VFzILWLORxDoHUPys8mLo14+fYZxOECMHg+cUqocBJN0yh7b+QRbIDI/Y50vZKOlEmYxCiHv3oKV/EC4a1p+wrnVpIKQPxHaKvOWSKnqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YTSYY3Uy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DA91C4CEF1;
	Tue,  7 Oct 2025 13:15:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759842920;
	bh=7Ds6za995kRmFU9u7IDO1WDKFYmSApctqb2MqozwvXc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YTSYY3UyAV488/ZsJMZFRNksri1whF7PZf1llrD3523tFRu+5GAXQ1BTJNXtfgsUv
	 jQMRKtKB/ALEtLxMrAs+3tvxmEtKq3OZ9PAXiE7MUNIR/P95TxPtr5V2nVoSwH4Qio
	 kGrE3zGpBcFXiQVyh0Jhzj6xiey1+sk7xhRhmKIfb4rY3DfBx27m9vDp+WjPKzsmfU
	 xVGQQ+J3uaobcc4xj94LZaY0L3oVlB/LCwejPdHqT19+WuTK10uGwHbh2BtDb1AwCj
	 9B8udYk8TeS0BswSjDiWIg8+rGOn1XuJZ3IwmJtOnd6pIAzCd5RQdAVgetXLE8I8i6
	 UakZdkrQTLmbQ==
Date: Tue, 7 Oct 2025 14:15:15 +0100
From: Mark Brown <broonie@kernel.org>
To: Sune Brian <briansune@gmail.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>,
	Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
	linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org,
	Charles Keepax <ckeepax@opensource.cirrus.com>
Subject: Re: [PATCH v2] ASoC: wm8978: add missing BCLK divider setup
Message-ID: <200e3d65-ffa5-40d1-86a9-974fbaae24d5@sirena.org.uk>
References: <20251003091304.3686-1-briansune@gmail.com>
 <20251007113305.1337-1-briansune@gmail.com>
 <5a71fdac-f6cf-4557-9bc8-d416a033263e@sirena.org.uk>
 <CAN7C2SCHirxurUA0n2VZKEEiYCt-NUKgspGFfZLNurHhACZkBQ@mail.gmail.com>
 <3266559a-8403-4a26-bbd9-c54e27fc59f8@sirena.org.uk>
 <CAN7C2SC96jZYYGP=DFrSKgtEfxy+MYpM7=-iW8YKhDG81ufw+Q@mail.gmail.com>
 <6963ab04-d0d2-42ee-9fc3-19f9c298849b@sirena.org.uk>
 <CAN7C2SBAPMG1-0huf+3NcUAULZmHTM4idcytShNDs-iiseZm5g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="nFqaftzm+Xafojgk"
Content-Disposition: inline
In-Reply-To: <CAN7C2SBAPMG1-0huf+3NcUAULZmHTM4idcytShNDs-iiseZm5g@mail.gmail.com>
X-Cookie: Teachers have class.


--nFqaftzm+Xafojgk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Oct 07, 2025 at 09:03:37PM +0800, Sune Brian wrote:
> Understood, so in this situation.
> What is the proper way to fix it?
> Leave it as such or create a new thread?

It's fine, just don't do this for any future versions you post.

Please don't top post, reply in line with needed context.  This allows
readers to readily follow the flow of conversation and understand what
you are talking about and also helps ensure that everything in the
discussion is being addressed.

--nFqaftzm+Xafojgk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmjlEmIACgkQJNaLcl1U
h9C4Tgf/fgiqPzg6v8DUBQx8Ekf42gOf+I/9pKK1rgcA2FBajMbc6DSlVTfD9lLq
1ECETmt2cOsurbqKV5pbdrQ1FiA4BGku7rv9U1Sak5LMUt8L8ItoL4iB9XbDQ71O
lqI/zJRI422w5uxbnIHEN+BA+s2MS5XFzmq5qB0DBEizcDnmnHjC92Z6iWScSib8
3+tMtrvouH+e9Q/xx/Uo1tjAOM/M9U0PcqVezIfgtDUpXVJOKsV9k4cc92ze+6nX
dBP/Qc+mut/ydCfyMT6laK309vSYsaWy1tb4Af7ZOdT7oC6JAubv12/2LioFZYbE
yjyL/cUIMAxNSTOzy+/5XY9cmItdYA==
=pVAy
-----END PGP SIGNATURE-----

--nFqaftzm+Xafojgk--

