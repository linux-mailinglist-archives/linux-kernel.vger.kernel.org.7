Return-Path: <linux-kernel+bounces-875827-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 8ADB0C19E65
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 11:57:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9936E4F351F
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 10:55:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F40CD31A56D;
	Wed, 29 Oct 2025 10:55:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fEWV12AF"
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD3DE23D7D4
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 10:55:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761735314; cv=none; b=d3kAUaOW5rCcKIUCCLaSESoXTVlQNwWhTHaWrlqGhW3e4bu6sM89G2jortE4Ed1hCWaJHQP/urcIkTopnUic+tIFhiRhw9UoIKwRNxULKSAhE8f+7mccUShYiCBGEOD6i76nvu0deplydpCcPiJX5f9gnMxKubotfCQ7JA6INv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761735314; c=relaxed/simple;
	bh=Rr4PrRD0uTnD5X7DfLkNakDbPave9MXutYtNwHgJApo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bHsRISVsXZzfDqf0dkcPp+7zSgxaqIRWjokP1wzH/fxKoiDOoCGpYjKgBkSbwnjNohNTQwAAAhRFzaL8vFZViOymFvT4QKs8ZzrIWkmjo7wQ+DNsEZYaXOVEl+jJTeyICaTcJYIgdrqoc8Ki6pd4zu+YdUSGnfJCQFTzxf6SD9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fEWV12AF; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-781010ff051so4849653b3a.0
        for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 03:55:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761735311; x=1762340111; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=M3M8yuoV+WVkfqwV5hF9tFBbA7TseCo339hiIVKayGg=;
        b=fEWV12AFwGmq7BY4YU2ti/Qo/HDVAWnGnrAB5hoHacrheh6b+0h73CuWQ4n/CZ7jMd
         MherlildxzUoKObxEPpcAJfmgbwZDkV3sRL0XMmrHJ0XdwBuW5fHB36MjsjkJtXooupD
         +HvyuQbQU0j4JAH3QxkMBETZ3QY8ZdRtwQv6bzS8MTivsuZ9BnEFcfbDHO81gj8KIbKC
         R5CSYOfe0xdYt9W9Y1Jy6XP4lUDQCTaZDgVi6NUgci6Vdh/K8W9HK7AQngsEgX0dNF7w
         HNbIoT3+7fE5mRCu0cpmnMLMEBBdtnZjCwagpvGOegZj1VxpSPpTD6ca4z5r3Q3rcOdd
         ygzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761735311; x=1762340111;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M3M8yuoV+WVkfqwV5hF9tFBbA7TseCo339hiIVKayGg=;
        b=EnzHK2bK0g2X4O8Dm2xlHlvoTmHXNkTz4GBJ41N7IMLy9ivihOZ6oMonkx1/7vyqEM
         ptdjlh7EkSFJ2ZDSQMTNoqLrdA55OJ/eBomQUN/IX4sozRPM3qqjbT3IYmd+AG50aejI
         OFXRHXWeEBDTsaa6ovlaKoA/X9lceWSM+pAC9ygcXT7alIXDdC9W3Bu3IouEeNn1TULj
         TulMjMpFCrX+eK7CwFNz7hr1QB0gUwuGwSMN4tlqEtj2JdQ7Uz5SKmSV5WlcLw8DO8tt
         bZTwmy8gyE9LrtZPFzMRHCI17Y4H93YcIRN3PfHNmYfap2ofqe2VyyhMCtpW+Gk2hBd8
         NNkQ==
X-Forwarded-Encrypted: i=1; AJvYcCViM5r+ZEsRd9PSOafWHiAsMfDfxDDhRhAF2wcGfDPkdL6jQA8GcioClCvkEglytwB+s16x5M5gSMrIvgY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8b4xSqxMq8BwXPMhWm4hKBcMb9g8wfXFgXqKlJDXKBWDtnWIH
	CccNNCkn/dJ0bpMQCaiZPcQ+CN0zh4pgvrryw0xE4dN3GdcFI1QWm1VV
X-Gm-Gg: ASbGncvTBfmqQAkJO8Kt6ePjIKcZzDg1IUZWc9xYi5KUmn6TOJMdwX2Q5iqWbCVXjbP
	EBfGHCmDc69yasV9xexEG3XJmTDHu6xZvz9K9q+rLEE1iYVATIE5Aj1p/o0BdE40c/mNERot8WJ
	TNicnUhy9BHje3lDZ5cJk8/F0qLG8Hnp8OcSvFEh2x8/dPM2cSlYIUTFn9loDQP9ouuglRgwZMx
	G0LMefVpKJMVDoOCS+vKHqX1DkeSH+ylTWVAuZGi3rSWD6k4Ft5bfGGGGDjQCwBCC+VGNlfm3md
	O9GBc+smdlGnjb7YGQVvHrSoMGObRnIEZtgl/dKuRyypZiibO6YUIGkNzflOb/wDzYm0k8eM1sq
	Omo34DTiC4BBQW7JoWOmKfWhspYGrj961ONsLr2J70e5ctxXgt0/+ZeDzBWpXU9MQLMHGAFhrBs
	kuflaZ6+7A//Y=
X-Google-Smtp-Source: AGHT+IGeYe2sO0IYtMLVzcKmcV/3doDaMD9jpsIXsLgc9sjqcKG5guNXcDoYITmYFQ+eGr5BHDzw3Q==
X-Received: by 2002:a05:6a20:734d:b0:342:9fc7:55bf with SMTP id adf61e73a8af0-34651553e7cmr3644520637.3.1761735310650;
        Wed, 29 Oct 2025 03:55:10 -0700 (PDT)
Received: from archie.me ([210.87.74.117])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a414049315sm14689077b3a.32.2025.10.29.03.55.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Oct 2025 03:55:09 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id 20D214206925; Wed, 29 Oct 2025 17:55:01 +0700 (WIB)
Date: Wed, 29 Oct 2025 17:55:01 +0700
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Swaraj Gaikwad <swarajgaikwad1925@gmail.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Jonathan Corbet <corbet@lwn.net>,
	"open list:CPU FREQUENCY SCALING FRAMEWORK" <linux-pm@vger.kernel.org>,
	"open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>
Cc: skhan@linuxfoundation.org, david.hunter.linux@gmail.com
Subject: Re: [PATCH] Documentation: pm: fix duplicate hyperlink target errors
Message-ID: <aQHyhU78m-9RPQ8q@archie.me>
References: <20251029134737.42229-1-swarajgaikwad1925@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="1RMd1Zox1MRAM54T"
Content-Disposition: inline
In-Reply-To: <20251029134737.42229-1-swarajgaikwad1925@gmail.com>


--1RMd1Zox1MRAM54T
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 29, 2025 at 01:47:37PM +0000, Swaraj Gaikwad wrote:
> Fix reST warnings in
> Documentation/admin-guide/pm/intel_pstate.rst caused by missing explicit
> hyperlink labels for section titles.
>=20
> Before this change, the following errors were printed during
> `make htmldocs`:
>=20
>   Documentation/admin-guide/pm/intel_pstate.rst:401:
>     ERROR: Indirect hyperlink target (id=3D"id6") refers to target
>     "passive mode", which is a duplicate, and cannot be used as a
>     unique reference.
>   Documentation/admin-guide/pm/intel_pstate.rst:517:
>     ERROR: Indirect hyperlink target (id=3D"id9") refers to target
>     "active mode", which is a duplicate, and cannot be used as a
>     unique reference.
>   Documentation/admin-guide/pm/intel_pstate.rst:611:
>     ERROR: Indirect hyperlink target (id=3D"id15") refers to target
>     "global attributes", which is a duplicate, and cannot be used as
>     a unique reference.
>   ERROR: Duplicate target name, cannot be used as a unique reference:
>   "passive mode", "active mode", "global attributes".

Hmm... I don't see these warnings when I build htmldocs by:

  $ make SPHINXOPTS=3D'-j 1' htmldocs

My environment uses docutils 0.21.2 and Sphinx 8.2.3, though. What are your=
s?

> diff --git a/Documentation/admin-guide/pm/intel_pstate.rst b/Documentatio=
n/admin-guide/pm/intel_pstate.rst
> index 26e702c7016e..9cdd9dad6516 100644
> --- a/Documentation/admin-guide/pm/intel_pstate.rst
> +++ b/Documentation/admin-guide/pm/intel_pstate.rst
> @@ -62,6 +62,8 @@ a certain performance scaling algorithm.  Which of them=
 will be in effect
>  depends on what kernel command line options are used and on the capabili=
ties of
>  the processor.
>=20
> +.. _Active Mode:
> +
>  Active Mode
>  -----------
>=20
> @@ -94,6 +96,8 @@ Which of the P-state selection algorithms is used by de=
fault depends on the
>  Namely, if that option is set, the ``performance`` algorithm will be use=
d by
>  default, and the other one will be used by default if it is not set.
>=20
> +.. _Active Mode With HWP:
> +
>  Active Mode With HWP
>  ~~~~~~~~~~~~~~~~~~~~
>=20
> @@ -192,6 +196,8 @@ This is the default P-state selection algorithm if the
>  :c:macro:`CONFIG_CPU_FREQ_DEFAULT_GOV_PERFORMANCE` kernel configuration =
option
>  is not set.
>=20
> +.. _Passive Mode:
> +
>  Passive Mode
>  ------------
>=20
> @@ -432,6 +438,8 @@ the ``energy_model`` directory in ``debugfs`` (typlic=
ally mounted on
>  User Space Interface in ``sysfs``
>  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D
>=20
> +.. _Global Attributes:
> +
>  Global Attributes
>  -----------------
>=20
>=20

The diff LGTM, nevertheless.

Reviewed-by: Bagas Sanjaya <bagasdotme@gmail.com>

Thanks.

--=20
An old man doll... just what I always wanted! - Clara

--1RMd1Zox1MRAM54T
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCaQHyggAKCRD2uYlJVVFO
o4FQAPwI9ysO/Xy3C7EUOrpBOObCsr/d9LYGqaw7KWjOQSptjgEAvEbkgaRLMIuZ
S8J3is3X+lOzodAVxz1yz2WwK4/iFgA=
=JGAF
-----END PGP SIGNATURE-----

--1RMd1Zox1MRAM54T--

