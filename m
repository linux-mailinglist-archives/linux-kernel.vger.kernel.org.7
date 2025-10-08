Return-Path: <linux-kernel+bounces-845801-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E813CBC6209
	for <lists+linux-kernel@lfdr.de>; Wed, 08 Oct 2025 19:14:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 359C7403CCD
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Oct 2025 17:14:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1ABEF1ADC7E;
	Wed,  8 Oct 2025 17:13:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HRvFGnI7"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 707D4246782;
	Wed,  8 Oct 2025 17:13:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759943638; cv=none; b=fsVQ5eG/EuJOsiiAoh9qeWFkM3yZefQMADOwvjxnUmVqHOJGAfvQDnjNOqwUQ7BFbTSRHi/ROGCSRbugLMAC+ECPJCU8a4QGQ8h8NngmD3ywkc2VsPnuRpfTPB4jrv5Ew/IQkwwXPOJ6dRytHAb2QGzBPXLopBBb0PLihnSkz00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759943638; c=relaxed/simple;
	bh=pR8gw/Sf64jBixaUFle3bi0P18UWb7unM0I3EIel13U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t7XbsW9NgkW7AHQjj1wDGyyLJl7GSm8HfT2V+EX7yJyJ7bXZdjOE+JPypRUx72GvbMg2vq6CLmOBSNbelX0g6RkuFKkBO3YypeTs3l9obH49SlKYsQOsvIf+69ifAnALAcZXXPBjXn6zcWpicQbr72vrnp0qdMvd/j4X1ZgeHzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HRvFGnI7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96BE9C4CEE7;
	Wed,  8 Oct 2025 17:13:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759943637;
	bh=pR8gw/Sf64jBixaUFle3bi0P18UWb7unM0I3EIel13U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HRvFGnI7X8Y5HS96PJsZuedkkPI+pX76JSqb1C0YYW2PrrBwSjZ21g3Rpsym+8KX+
	 Rdy3D+Z8bTKgNc8qzTTzlf9OYI9InzzxhJTahMTOiMWA/UxYinSKaKVklToPeYXzyr
	 ywp/Zcq2ThMlEEbxe9ojAv8P9rA10SmMlE+66jh3iVvI74uhaD/HT5sOEdia3fTnT5
	 tpwPKbOU9gnwwrk+dPlQZBVckcrn3KpiwTLALmvrVonkUrSGBCXkSKz0ijdNlNLv/E
	 z9hICWUiODJzxtZOR1JY+vxzldzxoUtq4iNoouMldE+zyTYcQoEr5m8FOX/D+qFj1Y
	 aCPWFFMiX9gZA==
Date: Wed, 8 Oct 2025 18:13:53 +0100
From: Mark Brown <broonie@kernel.org>
To: Sune Brian <briansune@gmail.com>
Cc: Charles Keepax <ckeepax@opensource.cirrus.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
	linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] ASoC: wm8978: add missing BCLK divider setup
Message-ID: <e5e86330-8bc6-4742-82c7-045d7b435926@sirena.org.uk>
References: <20251007145028.1845-1-briansune@gmail.com>
 <aOUv69rMkyYFiHae@opensource.cirrus.com>
 <CAN7C2SDUiuMfPs_X5r0RDC56313aJsfhfx0-juhZRKGTb1OKuA@mail.gmail.com>
 <e78c9cc0-4a1f-4a22-9cba-a8213a7b9301@sirena.org.uk>
 <CAN7C2SDMB8_b-m0ZMzuSmhHxWpA10mcxxxDMKWuNe6wfiEXo-g@mail.gmail.com>
 <58756837-9be7-4027-b951-401ceeb69e4c@sirena.org.uk>
 <CAN7C2SBG2EZ4CJKR_vWKBGsKpZTF_9VJXj7ysLx38nJW3dFxeQ@mail.gmail.com>
 <f15af8e0-3bf5-4dd5-85e6-07d00f8b020c@sirena.org.uk>
 <CAN7C2SATEDK4C-C7NOOvSKsQnfDBMStogkR8vFBAS+tejLbtNw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Yp8d6fuUpkrC6Btv"
Content-Disposition: inline
In-Reply-To: <CAN7C2SATEDK4C-C7NOOvSKsQnfDBMStogkR8vFBAS+tejLbtNw@mail.gmail.com>
X-Cookie: f u cn rd ths, itn tyg h myxbl cd.


--Yp8d6fuUpkrC6Btv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Oct 08, 2025 at 10:37:03PM +0800, Sune Brian wrote:

> If this concept holds.
> Are you telling me a operatable case audio can output just quicker or
> slower on such w/o issue?

Yeah, it depends a lot on the application - if you're playing music your
quality requirements are probably going to be a lot higher than if for
example you are playing warning tones.  The warning tones probably just
need to be consistent, accuracy is more of a nice to have.

> Are you telling me the left/right channel bits  are able to load
> correctly on fixed lrclk while bclk is overclock?

Yes, for a lot of devices - the most common case where extra clocks are
an issue is when a device is faking I2S support and only paying
attention to the leading edge of the LRCLK (ie, DSP mode).  In that case
extra dead BCLK cycles between the left and right channels will break.

> If so why this patch required from first place?

Aside from the interoperability issues there's also likely to be some
very marginal power gain, and slower buses tend to be more electically
robust.

> Running bclk quick and just feed in the left/right channel data on
> 1bit delay on both channel should works on IIS.
> Just make bclk /2 or /4 from mclk always works while LRCLK just fixed
> to 44.1k 48k or any audio SR?
> Datasheet WM8978: Figure 38 I2 S Audio Interface (assuming n-bit word length)

The most common case where it might matter is the above one with fake
I2S implementations (usually switching to DSP mode works around it fine,
but some devices don't do DSP mode).

> Do LRCLK is fixed but BCLK is far faster still runs properly?

Usually, yes, so long as the BCLK isn't run so fast that it's exceeding
limits the device has or otherwise causing electrical issues.

--Yp8d6fuUpkrC6Btv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmjmm9EACgkQJNaLcl1U
h9CaLgf/VvBTVRviD+ovCTBmoo0ekhWLcJrGLCErJPVbXrxPaY1ELBO9TqWTc8RM
h38MSP8D/08Y0wCC6gH89oG1Vf7RokS+CkzcDVhxKi/+ksy9+S3KdaM8dvpA9EUk
638VLzRtx/piJoeZPmehoGY55gUHPKb6oeRlBltap9rOHM2ybU3qgklAMvDEyL5G
2n4nR8Co2q6g6KHXWffkvaeb95gDm+vzjw8/AXcGVPcX85h2/p4vsZTGU+V3d4Qi
k2OCSabHTp/lqC0qV2/MY68M5NxEb8yzmnkksAiuyg+p/ihIfLRKl6sY41LAZP6T
XBzOow6WKt+51ClfsqIwjcEGOOwnmg==
=4/ex
-----END PGP SIGNATURE-----

--Yp8d6fuUpkrC6Btv--

