Return-Path: <linux-kernel+bounces-841039-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id CCAE1BB603D
	for <lists+linux-kernel@lfdr.de>; Fri, 03 Oct 2025 08:57:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C50CE4E87F3
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Oct 2025 06:57:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFABF207A32;
	Fri,  3 Oct 2025 06:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IsPtfq3e"
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A90C21CC62
	for <linux-kernel@vger.kernel.org>; Fri,  3 Oct 2025 06:57:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759474665; cv=none; b=lg9iHNgyYkZr5s9IA253eCf/o6v0CAL0askTIHRxDV7plWxRg27Rki+J8QFDtzgZbcpNMMUL5m6+bypR6hcoVmIrc9wa58On3ZsIZRgJlIeh5LNqyKKxXoIaxuJh477FF7RjhvhC7UtRJ39VCpg+5/4ytw6wqyYWsLyN8XhAQuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759474665; c=relaxed/simple;
	bh=yQdQXw7+avsuC5hhfujv1yVVicy+u0sf+WMMAeSOEQE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BiK4AlKYmtmldhJma2hXcvmZ/hNpOtPHIHJ6hI7CMgEE8gIw8bZRl8CQJzsaEsHhh+xHzF4ngIuw2S+x4jYDYoshXUaPQh7aXbR1y7u5pVP8S0lFAfB/PnnNatVrHH4D26dS8R7TvZYBFj11AEZQdHfVqowH5/Km8wJSqn+fcpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IsPtfq3e; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-57dfd0b6cd7so2329734e87.0
        for <linux-kernel@vger.kernel.org>; Thu, 02 Oct 2025 23:57:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759474661; x=1760079461; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=yQdQXw7+avsuC5hhfujv1yVVicy+u0sf+WMMAeSOEQE=;
        b=IsPtfq3ebpj43XCFdaQUXibpvIQv85YovUV6+Sqn8dMrEjlmZEwl6eVwDB//8x06HV
         L0z54rhAdBZUXOwzDBCvV1sDg3wLcG0L7rptp959JjKInrEKGQPsssIfFLSIo13EpjRW
         HsQDXzi6cDxroC8shetr8la69wFhe7vym0otlBOCAXjad17cTYl2D/Rof1deaAgAq0g/
         bmHhjpc14XAmx+eRa/SXSUwLgVftqFkwgGvqd7ZyELy2hb2fEuarGiM/ZOfLQdMbSadG
         EVfiyuDsv5INQXptP0vWxZlvK6jl9y1/pOr9iGhVL3fqFclbg0Ts0L9GKXCCGqt+sW0M
         77YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759474661; x=1760079461;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yQdQXw7+avsuC5hhfujv1yVVicy+u0sf+WMMAeSOEQE=;
        b=IuHEx4Onw4muPpTg9+Gl2IYcM1iUjH9QkjMqoGgBB7Ais7bM/O73srhugyEvu2TRYM
         pcbckRVJ06IaMspR3UFnbn062jvsT86UVI0aJRO+IJPaU5bEIwP0zRLG7d0pzT3UX7H2
         r2XZZKYhODfyv+CzXCxK1qIYNBfJ4oN6PLweWnwZ7YX85doG5L0K0CQyQ/Op/0rb1vic
         4d5ygXY2ObAU/9PM0CCMMDK57zuD0B3os5dlIUNJJ1hHg19doLeo/VoPVUnVeF8Up4VI
         bwB74RjgfNvyGBUHBWcqc89fyzqSnbjNsTiXEbOtU7h8cN9SuRA55wqsdG8Oq8b6nLiL
         6uzA==
X-Forwarded-Encrypted: i=1; AJvYcCXoYsDpyyzl246rwnfLY69BPe9vV/ZF9osXWKuiFhcBbtRSIIonntpcxU0K3KqeqmeQAkiP0aRU3GnK1iw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwIut9haQFjW0J2kqGmIuEXLMnHmO7F2ylMSphB/6jaGlv404p1
	VXWKKJuj+ZKiu665+raNj9aj7scZNcqmWHqlIyb8KQm6IGGUXhH/vuYy
X-Gm-Gg: ASbGncvsxi/py3NnuzrjDGwgFd+vWXVwAqWfNuOkC+0SitPkGOEQN0cAjNJlaLL3M0p
	GvNQ2FFnRrNX8n/kWVHxfA+6YX89quUFHmSYhM8iwyBRvllYM1V9vDAOBoajbZIjdEYoC2/xDJu
	oDOjRJ/+Xhz41eMHBWWZkH/7vKwxwSWgtvdnoNPfdofPtp3TTmuUGbqR38OGKkWGSI3JwlXoHCx
	sJW6ckuPh9D/AmUJ9G3QtQt2vf6dEvEmvITv+tYyuhbXjn02usBFA59kfKX1eIAeFI+ZFbmcDMT
	xnZ+Ovlu+ovSfH9TDZkt5/ScBXryyTPrMzSXXX4oR6o/hGovPQhpCpvy65X22K+OYVKcKX6NXSb
	B/NY0fIRpGJCmlP/+qnqcAnTrVfKiYy6LsQ7OIiOwgYxbhtnlZM34Iktm6vm85Wz1uMwPYB8wtj
	P/nS7HFl8=
X-Google-Smtp-Source: AGHT+IFykhT+qoW3okH4MQ58h/3zC+W0SukcWJAG7Lz3Pob97kZlcMYuRXV/fQcvc293Rdd5UPr+nw==
X-Received: by 2002:a05:6512:2315:b0:579:fb79:45ba with SMTP id 2adb3069b0e04-58cbbbeed8cmr523242e87.48.1759474660918;
        Thu, 02 Oct 2025 23:57:40 -0700 (PDT)
Received: from gmail.com (83-233-6-197.cust.bredband2.com. [83.233.6.197])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-58b011ae145sm1542943e87.123.2025.10.02.23.57.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Oct 2025 23:57:40 -0700 (PDT)
Date: Fri, 3 Oct 2025 08:57:38 +0200
From: Marcus Folkesson <marcus.folkesson@gmail.com>
To: Javier Martinez Canillas <javierm@redhat.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/sitronix/st7571-i2c: reset position before clearing
 display
Message-ID: <aN9z4pdh1aBZZLdz@gmail.com>
References: <20250913-st7571-reset-v1-1-ae5f58acdf8d@gmail.com>
 <87o6r9o25m.fsf@minerva.mail-host-address-is-not-set>
 <aMvIyOJkXE39sp8T@gmail.com>
 <87a52saujd.fsf@minerva.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="bS1gySna/1bzmu0S"
Content-Disposition: inline
In-Reply-To: <87a52saujd.fsf@minerva.mail-host-address-is-not-set>


--bS1gySna/1bzmu0S
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Javier,

On Thu, Sep 18, 2025 at 01:07:18PM +0200, Javier Martinez Canillas wrote:
> Marcus Folkesson <marcus.folkesson@gmail.com> writes:
>=20
> Hello Marcus,
>=20
> > Hello Javier,
> >
> > On Wed, Sep 17, 2025 at 11:32:05AM +0200, Javier Martinez Canillas wrot=
e:
> >> Marcus Folkesson <marcus.folkesson@gmail.com> writes:
> >>=20
> >> > We cannot know where the write pointer is, always reset position to
> >> > (0,0) before clearing display.
> >> >
> >> > Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>
> >> > ---
> >>=20
> >> Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>
> >>=20
> >> Marcus, do you already have commit rights in drm-misc or do you want m=
e to
> >> apply this patch ?
> >
> > I sent a request for commit rights yesterday, once it is approved I will
> > apply this patch myself :-)
> >

It took longer than expected to get commit rights.

Could you please apply this patch so that I could get it of my TODO-list
:-)

>=20
> Sounds good. Thanks!
>=20
> --=20
> Best regards,
>=20
> Javier Martinez Canillas
> Core Platforms
> Red Hat

Thanks,
Marcus Folkesson

--bS1gySna/1bzmu0S
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEBVGi6LZstU1kwSxliIBOb1ldUjIFAmjfc9wACgkQiIBOb1ld
UjJvqw//S8X/vaqyxIZtYmGNPjRVvzWOXLt1Yx8S5L5t5a3SNj9R5eNaeO2rtSKm
bhFtZ07j9AqkC3Xvjf7q7M+uvsFpzcw1tA1Z2mG8JOymXcgu6JkwIPKdA/a9DGwF
viXAgw92/CjiC2ODFVoMZ6ckmyfICviF957vm0SdLu32Ion4UNGmQmm3LYHQwTpc
BrDflx32LvwIzRwcjFFUI17a2iy3yDwjy8ZKsyTSepLTFVaqiJQUG241BIzO8gLQ
1QzoWKqhEVjxZ0lh5teDh+hF/Yar4B3zC3b0kRwUhYYpQaCxGYqab0KrECOc351/
PyS+CP+gx2FUlQRfpgLsSzumipTi6znLkxBS8XI2jZokK+deWmI683V4Adob0y8O
TWPASyG8m1pJUXm9nKR5pk23yL02lDjn6dPBBol3NZWOwlPws0owNIZ1CEBHXypj
flg7yO9wSMVaSEsS/Dlg0N1GXauYy9ENR6V6BSUElfZdLKgFI7lIPFWD1XqcsRxJ
U9REa6XS1P/xKoITX0S+v5/TNImBdVc344+jkAXUFR0Nas0qL1hAyX+NGc2o0aii
A+S/ZhRCXSkRUEvBWqngTY2RnJMUZ7MBt+Vy/tdvpYpK+fDlGMBJjUp5Z9unevp6
vRa4+DpsHAA4YUh+rZ/GGOLnAc4FiG+F4BD1gb7F9bmxRBJb9CQ=
=FoRv
-----END PGP SIGNATURE-----

--bS1gySna/1bzmu0S--

