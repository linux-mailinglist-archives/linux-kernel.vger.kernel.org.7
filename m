Return-Path: <linux-kernel+bounces-774289-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D0B8B2B0E2
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 20:53:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0A0A817FF8A
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 18:53:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 904CF272E43;
	Mon, 18 Aug 2025 18:52:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uNm5odB9"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E37361D9663;
	Mon, 18 Aug 2025 18:52:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755543176; cv=none; b=DK4pxTIBLFvpyBAZjLYJAEYV3vTtAN2fQUaOoPcul2fcwQ3qRE2MXuf0EoBygJjUZR1ndWqEOMLwQgRzDLBIHxPSywIPGVs9UTDk/benIAEV8omHJpnoqFEN8LH6rgIwDBi3L04l+YwEu3dKcVHVmA3o28a0QwdIu/MUFCjwqSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755543176; c=relaxed/simple;
	bh=xAl6j6GaAGL32sNV8Opo5jFXlU7s74kxZxZLMQi9Ibc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XogeHUqVUuuzk+38o+uj3mOoUc4NNQOy04NaUjOKp8hYNf1eyolqW1o2+VUbz7ug2FjCi/lFw178ENInnKaUMlxBSWLfJLcmT2hK3POnvOzZ+aL33e8kNJTfrOl4Olo1WFc+3nX86+ZekZ9EWKfGM0mI88vcJH0z4cCtHA/8i2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uNm5odB9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90FAEC4CEEB;
	Mon, 18 Aug 2025 18:52:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755543175;
	bh=xAl6j6GaAGL32sNV8Opo5jFXlU7s74kxZxZLMQi9Ibc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uNm5odB9c601eu4eW8kNtWNarTFoY6NNh025QD2l0ZENuijjXcbZo+gKtavPD4qMr
	 uEhBfKkInkdd4bXnmYHEhedA6iSxQFsQo9ii0yFDL0QAuVtJHoMbR0l10ZuCkYd0Jd
	 uKq3jKfMBpaww06mTp9fos8+mv0FbhqQ/WTZkDnIWX//EMs5w7CRRBrd95aJSrn0Gt
	 FMgKkzR+tQeqlkcQodam8VGFF9W2qQHNOJa24573syPJkxS3ZEVLWL5BcZPSAj9xAR
	 V1etDOvN5fcx/wONFITovTk0OZRURZ8qe4Qk0ku/iM/mhQjYhH437P1yZW/DfBPrFM
	 DH7VToQuTvNkA==
Date: Mon, 18 Aug 2025 19:52:50 +0100
From: Mark Brown <broonie@kernel.org>
To: srinivas.kandagatla@oss.qualcomm.com
Cc: perex@perex.cz, tiwai@suse.com, srini@kernel.org, lgirdwood@gmail.com,
	linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-msm@vger.kernel.org, krzysztof.kozlowski@linaro.org
Subject: Re: [PATCH v3 3/6] ASoC: qcom: audioreach: add support for static
 calibration
Message-ID: <6d137f07-d37a-431b-ab38-5f3087d9b3b7@sirena.org.uk>
References: <20250818125055.1226708-1-srinivas.kandagatla@oss.qualcomm.com>
 <20250818125055.1226708-4-srinivas.kandagatla@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="5IwgppfYZzURBDwA"
Content-Disposition: inline
In-Reply-To: <20250818125055.1226708-4-srinivas.kandagatla@oss.qualcomm.com>
X-Cookie: Be careful!  Is it classified?


--5IwgppfYZzURBDwA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 18, 2025 at 01:50:52PM +0100, srinivas.kandagatla@oss.qualcomm.=
com wrote:
> From: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
>=20
> This change adds support for static calibration data via ASoC topology
> file. This static calibration data could include binary blob of data
> that is required by specific module and is not part of topology tokens.

This breaks an x86 allmodconfig build:

In file included from <built-in>:1:
=2E/usr/include/sound/snd_ar_tokens.h:243:2: error: unknown type name '__le=
32'
  243 |         __le32 size;    /* size in bytes of the array, including al=
l elements */
      |         ^
=2E/usr/include/sound/snd_ar_tokens.h:244:2: error: unknown type name '__le=
32'
  244 |         __le32 type;    /* SND_SOC_AR_TPLG_MODULE_CFG_TYPE */
      |         ^
=2E/usr/include/sound/snd_ar_tokens.h:245:2: error: unknown type name '__le=
32'
  245 |         __le32 priv[2]; /* Private data for future expansion */
      |         ^
=2E/usr/include/sound/snd_ar_tokens.h:246:2: error: unknown type name '__le=
32'
  246 |         __le32 data[0]; /* config data */
      |         ^
4 errors generated.

--5IwgppfYZzURBDwA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmijdoIACgkQJNaLcl1U
h9A68wf9Fq8C+zsAJwozO4UA322ixrFDwbVc4xy7sAUCejeurkRxtsq8tf0F7wga
60lD3z9dUNrzm3mo7hIclevBucdlnrJzOzAGfe921vhpiKQ6DQCL96aR/rGTK/zY
P2JI2yeSUigtuWk/AHLy+i2RC+EkesgrqE1XwRl8gzSAqzHSJZHUyCniMV5us/u+
8gkTmwSbdyzeyLLSy1nPo0ume0lxlTqXJm77hoyHFQFawBH+jmg13OgRd6hX+Q5w
MfPQkyHM6aMww5IOTYSQrifcKwNaFc6zMLp4V4xBR0KiUVxohCVGlFRUKGB4BZQ8
tVU1AvVvQtI+qVsv2haeJ6dHSGFFYQ==
=9BxV
-----END PGP SIGNATURE-----

--5IwgppfYZzURBDwA--

