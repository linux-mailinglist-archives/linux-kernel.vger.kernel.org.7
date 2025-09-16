Return-Path: <linux-kernel+bounces-818485-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E459B5925D
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 11:37:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F1CAC52137F
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 09:36:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C72629AB15;
	Tue, 16 Sep 2025 09:36:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="cIj+cADX"
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21FF9296BB6
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 09:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758015391; cv=none; b=WGuT1+Wxl02RTEM20febCIbSnM9rhekFq7nrf717hpytQLKjA4P1rq+UnJfv5hAg1FSnd4a3FoskGLd26dlpJ5aUi7XBUwibQ41ytbK99liRqh+H+IelRvt2FBfvxsy5y+3ZTfF5WShyaKHrebkLRXIzYkjSMkVn3nLf4AwGPrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758015391; c=relaxed/simple;
	bh=fZI+p/HjCJtJq0JzOCCKrajA0dwNrvxjKZSrCzW8MW4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n0VAL1DcmX1SZvxsseg1Yj6RmVXGbnG0+4+4ruSahxzZqpeGfOIZ23nGOuudmu+L24bzKkHn+wDooaUhegX9RzJBFOL4I75m11RHspEsRtlL/Ob5xi3v7KfSAP7RdI2E/8RIQF2Hpzr0k+7LJxFfzGugXUuOTPFfbIik1BBQzNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=cIj+cADX; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-3eb08d8d9e7so1329673f8f.0
        for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 02:36:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1758015387; x=1758620187; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=fZI+p/HjCJtJq0JzOCCKrajA0dwNrvxjKZSrCzW8MW4=;
        b=cIj+cADX/NjESMnorOrVw+k2YBRP1o+flOgm/4NNauJudqFev453CIlIrqc/eTYxcA
         zE4Z0BwSxoPxRW4n5uMZw8MDN1bITITJzJ3z5/fmwbcn3CAuxuhxxirEKticFCcl7gq7
         9+TDbIf7BRURx2dT05Q/o6rO4/56nACBQ+e3U8a8LMGdR8MxGKbTlU40n/sJ4aryAbWk
         SALNFzYxNnOhWbU86F04nOnFLMf6xu+4QChEgEzW+hyfuoFJB6h1ka39L5l7mDASOWbu
         mubDontYYop5C47EvI3d491Ur7cpkf9sxLM1wC7n58KexT2A9FXf5hqMw/N1pWcSmhD0
         5Qyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758015387; x=1758620187;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fZI+p/HjCJtJq0JzOCCKrajA0dwNrvxjKZSrCzW8MW4=;
        b=GrCEQqOuNWUTiqP4XJaSTkCYsXeWyiubemBnuiKVvaNwr8ieSmenzhaNpR60SOdtJD
         DkL+UkLe86wj1RNiXjqxY7EoJdDaU1VDZqJgIPrW4y2cTgt3DyO5di4/7/j/zVAqOHHy
         bqQgEHzrVOceXW3iCu4hg7V+zniSY93vZ+CJY1f3X7CfFLdO3TngqYlgeKm38Ikn3Acm
         /aeCdWAPpDKIkK0rfTJEAKtwlxGKQ9EBMPpKV6heLw37SDFiG7lQoP4kKx9aLF0MX/Sp
         dTXKgxoTcGBpSvAT1z5RXNV83JMUjPtRbeRB70uThaaQB5qXK/O5hpgitotRup/XMMTY
         4W5g==
X-Gm-Message-State: AOJu0YxuU7n2faBpT3pgHlB2OtrjJsk2Sr522l3kXYXt6qWlfhzjcLjU
	hp0eR9D8RMuVu25WaDpRTzribZ9vs4lXdtqCgKVFDaGVUaMlJ2Kb7BsdV+9k3iF0TbGm+gj6f5e
	ig5wN
X-Gm-Gg: ASbGncuk5innzBPGfTNia59hTp3RCovv2NdF9ThhlekxHgHfk/Kvcb8TttLtOdRP8ef
	WyvN0uNpSn7z49wSv7rUMKqoVa2+mpROkfUXFqOxcG2O1P6lXPfmT8elWbX1L4jgbQmErIE8uP2
	zUajW2jgULVmkCimRxhwu5fYpkNk4jp+TlKwOLiJg0Al8Bc4Xa/+nh8Ubve7ZEMZk/uu4s8foD1
	auDibOdFX03P1sNiYH5fcuRtpR/nCGOWDrXl0a299TEspMnJYuj3PZ3goeTyv0SpTmKFVgvg2Ht
	hBjI9SuGYAxm+DoSD/eD5jWZKIC8BUoH3IEQT2NBtEjWwBqCQjnv+A/TeqbJwkdm8buX19eAK9O
	PdZDgGHHOj9Xy9yD+c6CeBzZBoGqDXXd2OUnD41/umpE=
X-Google-Smtp-Source: AGHT+IEKU1Rm4HZ+0ksdNHYojrzjut6lvIe9tNcd3eQTCHaEmO/AaBdarAUSFEFHY8YENNUIK/ZOKQ==
X-Received: by 2002:a05:6000:438a:b0:3ec:4a0d:a09f with SMTP id ffacd0b85a97d-3ec9dcd3a43mr1279882f8f.1.1758015387278;
        Tue, 16 Sep 2025 02:36:27 -0700 (PDT)
Received: from blackdock.suse.cz (nat2.prg.suse.com. [195.250.132.146])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3eb9a95d225sm6057510f8f.54.2025.09.16.02.36.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Sep 2025 02:36:26 -0700 (PDT)
Date: Tue, 16 Sep 2025 11:36:25 +0200
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: Bagas Sanjaya <bagasdotme@gmail.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, 
	Linux Documentation <linux-doc@vger.kernel.org>, Linux cgroups <cgroups@vger.kernel.org>, 
	Jonathan Corbet <corbet@lwn.net>, Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	Andrea Righi <arighi@nvidia.com>, Johannes Bechberger <me@mostlynerdless.de>, 
	Changwoo Min <changwoo@igalia.com>, Shashank Balaji <shashank.mahadasyam@sony.com>, 
	Ingo Molnar <mingo@kernel.org>, Jake Rice <jake@jakerice.dev>, Cengiz Can <cengiz@kernel.wtf>, 
	Mauro Carvalho Chehab <mchehab@kernel.org>
Subject: Re: [PATCH v2 2/4] Documentation: cgroup-v2: Add section numbers
Message-ID: <pmsodjam5jjih3v3fogokfyshn44izvouhihkijvfxazmmbqoo@hi7b3klfk7nv>
References: <20250915081942.25077-1-bagasdotme@gmail.com>
 <20250915081942.25077-3-bagasdotme@gmail.com>
 <duppgeomaflt6fbymdk5443glmw7d3bgli2yu7gx6awb7q2dhn@syjq5mmia6pb>
 <aMgJPWETGVt_AE9i@archie.me>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ncpdxclrgscw6h4s"
Content-Disposition: inline
In-Reply-To: <aMgJPWETGVt_AE9i@archie.me>


--ncpdxclrgscw6h4s
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v2 2/4] Documentation: cgroup-v2: Add section numbers
MIME-Version: 1.0

On Mon, Sep 15, 2025 at 07:40:29PM +0700, Bagas Sanjaya <bagasdotme@gmail.c=
om> wrote:
> > Erm, so in addition to keeping manual ToC in sync, we'd also need to
> > maintain the section numbers manually?
>=20
> Right.

I mean -- that's not right. Either generate all automatically (original
approach) or simplify maintenance of the manual ToC (as liked by Tejun)
by stripping (meaningless?) manual numbers.

> > What about dropping the numbers from manual ToC and sections? (If manual
> > ToC is to be preserved.)
>=20
> Nope. To be fair, we also want section numbers for htmldocs readers, thou=
gh.

That'd be better automatic too
https://docutils.sourceforge.io/docs/ref/rst/directives.html#automatic-sect=
ion-numbering

Thanks that you look into this!
Michal

--ncpdxclrgscw6h4s
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJEEABYKADkWIQRCE24Fn/AcRjnLivR+PQLnlNv4CAUCaMkvlxsUgAAAAAAEAA5t
YW51MiwyLjUrMS4xMSwyLDIACgkQfj0C55Tb+AjgdgEAnUOZWh1sOndo34Yf+kdQ
nJWfCzO40QmFo4d9a9aif8oA/A3mZT4zM3qn1jWrba7Cj5rstgqg0P8UeO0B5BKp
xv0N
=7YfS
-----END PGP SIGNATURE-----

--ncpdxclrgscw6h4s--

