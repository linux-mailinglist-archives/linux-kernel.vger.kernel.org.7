Return-Path: <linux-kernel+bounces-768758-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D59DB26521
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 14:13:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 65E002A64AA
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 12:12:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CB662FD1A0;
	Thu, 14 Aug 2025 12:12:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qRWP95gW"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D70482FCC0E;
	Thu, 14 Aug 2025 12:12:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755173523; cv=none; b=Za0i6IehVY9liVAdDf9EVV1gScrtycbXb12oNVTPWcsEuuJN5mgcfcYpNDE9ehLBb8VxUKIDIwMFHiKW4vVuNehNnIgS+EYpZIbTH7JDTj0flSanKZwkU3mYT8wDV1JB9ghoTISeW+OMhJeUlWHMnoEoRpSoGWXioEulad+kozM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755173523; c=relaxed/simple;
	bh=oKG/z4imADYHqqynLKtUtN4Oij6zZpz6vZ6gDYrFCfw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n5hfDyZpxsxmjWd6VUyi6AeTm80KRyyh9A3g8H4ED+uvclpu89390U2bjS9mDMWO5zAd+qog8wzRxIQvGijRziq/Arssr17VPN4pJtknjxI1btVg28iK81sNnrIR1t7AvOuxbFUgREUzvUnVnY58QSjtuzjHFvLD11/F8QgRBGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qRWP95gW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E177FC4CEED;
	Thu, 14 Aug 2025 12:12:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755173523;
	bh=oKG/z4imADYHqqynLKtUtN4Oij6zZpz6vZ6gDYrFCfw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qRWP95gWPi8uGdMOal1tWKaqi6Fih6c4F2ouyp3iwFFTnq65bqB9nXZ80bQBqhVVL
	 3sOuySCHWSFjSkzaWpMelGWspQGcAErxFbcDac9LoJoHq0Hj1Br3rW+qzz6rv1XJOL
	 uu3nI3imdj/MZhWIU0n8vL/UmXveS7jTq07JAfVc+tEBq+oftsBIJE6yyaFanq3Iwp
	 EmagD21d8bZYFrRgegdFvx3VBpzPT2K0Mi/ZT2cP4oU7/3mpf9Ndu+INHKInvSMgJP
	 +gFmlHP1QAur5Wbl7fX5bCyHPt4J0Op/n50t5Z6xrP2AV1+TKvtrh0MkI98Max3l37
	 sMQaowSLuBbCQ==
Date: Thu, 14 Aug 2025 13:11:59 +0100
From: Mark Brown <broonie@kernel.org>
To: Shimrra Shai <shimrrashai@gmail.com>
Cc: lgirdwood@gmail.com, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-sound@vger.kernel.org,
	perex@perex.cz, tiwai@suse.com
Subject: Re: [PATCH 1/2] ASoC: es8323: enable right-hand DAC-mixer connection
 on ES8323
Message-ID: <b5a64166-c55f-4ca4-af92-52c954847af6@sirena.org.uk>
References: <20250814012652.81424-1-shimrrashai@gmail.com>
 <20250814014731.86651-1-shimrrashai@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="PLXYa5/zsu/y4xid"
Content-Disposition: inline
In-Reply-To: <20250814014731.86651-1-shimrrashai@gmail.com>
X-Cookie: This sentence no verb.


--PLXYa5/zsu/y4xid
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Aug 13, 2025 at 08:47:31PM -0500, Shimrra Shai wrote:
> Enable the right-hand DAC mixer connection in the same manner as the
> left-hand one.

> @@ -633,6 +633,7 @@ static int es8323_probe(struct snd_soc_component *component)
>  	snd_soc_component_write(component, ES8323_CONTROL2, 0x60);
>  	snd_soc_component_write(component, ES8323_CHIPPOWER, 0x00);
>  	snd_soc_component_write(component, ES8323_DACCONTROL17, 0xB8);
> +	snd_soc_component_write(component, ES8323_DACCONTROL20, 0xB8);

Neither of these should be unconditional writes, these should be user
visible controls.  We don't encode specific system's use cases into the
driver.

--PLXYa5/zsu/y4xid
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmid0o4ACgkQJNaLcl1U
h9Cw0Qf/fVy2aA2vdtzxxkMt3NZISirhPQt7ljKImdZ23mMinHypli76WIRu4Vom
EZ67Rf8PhDIh47o4kt1PXRoqs+RY0+kVMV/EXl62aRHEWzZA5Nnu9NAoeallApT9
B/Zee+ERSeLSfiG5VnMgOXyIoxXj8ef3qjT+YnmosASsC8mO6KratoqMTJgv1vA0
MYDl2eKwzYZc2E4ejPJOQj1LY+mWLaZVLAxzYL2SJYafv6IucpT40wuL7d+GfrDO
oOnm2yFtY88AxYlocm4j1SOet5v6acFHJT+eZfSWDNBr2vRn96q/zqK58nIIkVMU
LINhnJwnXBOQqaEvviOTsFg+cCG2DA==
=Cp97
-----END PGP SIGNATURE-----

--PLXYa5/zsu/y4xid--

