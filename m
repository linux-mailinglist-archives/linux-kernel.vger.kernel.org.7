Return-Path: <linux-kernel+bounces-812606-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C57BB53A3E
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 19:19:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 88F82189DCEA
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 17:19:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5C663191BF;
	Thu, 11 Sep 2025 17:19:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gzus+dHV"
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7394522AE45
	for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 17:19:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757611163; cv=none; b=H3k6WvBnuj+/dC47n9+pw+4g6CwKOJotJDNXmguDpBtFKRko22aXE1ErnOETWAKSIYk5XtpycW62TjaPxZDY8vsrWrQWM3NLNOejLMcK9oStxUKB7MLRhH4E9HuVFJzAmI7DMk9vhV/rFv7uIC6uv09OJ74vS3XV6Q+ey4yDa0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757611163; c=relaxed/simple;
	bh=z2gtPUXB7/LXbkSd38vOHruaxUvSZAbiHNqziAkJ0rE=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=To7GxLJN1tJgFfmpelNpIp5vpsKEYj/CXzayHjCjqYaircnAaIQtSEohOTbPPU2tuIHEZunPgnR6Df1tbdNMzfG8lpHE710Hh95y1f4EmU+wl/aat8bQXVaECTBAkwzG4jow74FcgrxxymApJ5YSsqF2FNedifmaiCpc5E4y8Os=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Gzus+dHV; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-45b9853e630so9184025e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 10:19:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757611160; x=1758215960; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=rx9Yhlqw+0SU2LxMIy3CyY83e0mubLsvcInhwmm1OUM=;
        b=Gzus+dHVUZ7CzdhhAqu332T7B440P0w5tVqzNV+YQ0/gIXowkEbiNfx45u43DEHPgs
         Tt/efgXiuVW2oUlr0aAucdsQWBsHxb5747+QnVBLhkWPsd2Uu7LuZVMK9svAdQxjk+8m
         e7YROrq03VTYa5//NQNVVlNx7jayjkF3LOxZjRU+1WcKTh+njA76ttpeRwesxerzqSba
         ng9Y+1K29gWIZkazV4SICVqVjMjlQhIdOh2TCIdJiVdTv2wOGjDw4bxyeyefWahSJKXC
         AeXQgHlQC8du4aMnBjHZc7ejKPC2wzh411oUw8zK7b3AOdycohdOEwgr4kwWxjjr7v7l
         FRVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757611160; x=1758215960;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rx9Yhlqw+0SU2LxMIy3CyY83e0mubLsvcInhwmm1OUM=;
        b=PhzRJX17YdUGocSY6+BnCTkQMKo2U58W5ndCtPJM3iFmQX0E+bOL7pQmPjk+p0QC8h
         MhwgF+qEdPpHdbkUX04UQvTskE6A3qEUeIqBw6bytXygVf0hE8eHVOHDqmzbU0n41w6x
         EdmzfkquWMfnDsj0dmPsqIdhuWsVAnkBnmTBvtNyQjE6bCycRCLT9mCBXr5Q8b5Lpm5z
         x3hdXREQOjgfMT6p+113vHeQRNWPRYyDgV7Tl3kCOV9seHyV5c/UIEov8p+Mi1wKrqDd
         kBJIeCgBQz9Swyje1mgA5fnx8jATBbGT8UxFSmlfObeMp7sY0nbFTT3+yt6gGI5cUdQn
         8rqw==
X-Forwarded-Encrypted: i=1; AJvYcCUgVAdoKFmuLXA4va8tRqQjjb/4mbd8H5wFh1jGa6NkKCORrhq69VNzx15gOi3zaaQvbh9cGZue3xww58k=@vger.kernel.org
X-Gm-Message-State: AOJu0YzSMoBjCHStMOV+d2KvB9Fnc4wHzn/LceMGuPCMzB7T1JrgVuWo
	iEKpndiazTG2dHLT3WXZ7lSOLG2rlOxM7pGLgZwiqdrPssCrysvflp8H
X-Gm-Gg: ASbGncuCpH/+O1jTJgvIg2Dc84BYmwNGtyiI6T/HpEeE/KS4aa830ReSyTsNdjFhYmK
	cIsGlGGESRHQcNoLSk6J7ZZjUdPg/DMK/ZL4ArxaVhncQMzjbehrvjSQkBZTghTzLy++SIeXy0J
	XDWb88D9qaCOjfSXx+/Ndjxa4G7+u91SzWCEtMJEZ2D/O+/kg6hIukX6iatcGUoviNAR0WvYjXF
	wkgfLECLFOA2pzR/PX3b2Xt3APCXgOrw+Ryf1Q1J9VKLDCD/pBbA7IR1g+M6QUJu1zEZ4nwsaw6
	P1XUsZ8yCBdeoP0Mk4xi2JslkN3dswNrXtV5zWfmQu6hMoRZSZkHCgklAIEAfxpcOY39VYY+uWe
	xHURO7XRuIyqhWJmWxOvTH7W94wrP3rrQ0b0wX/Z+BYsF+RoAghiqXRxrWbVHiOIQDKF1kPnOWh
	czQJsLyRDAjjDE6kLraUk=
X-Google-Smtp-Source: AGHT+IEf2gXfdcNvdRzd70DEbnbwTZwMjmAbAlOFv57WQK8ZacZzewIz4tro1Hmj+L+IBaWx2B7KfQ==
X-Received: by 2002:a05:6000:4211:b0:3e3:921b:65a2 with SMTP id ffacd0b85a97d-3e765a49430mr86583f8f.50.1757611159699;
        Thu, 11 Sep 2025 10:19:19 -0700 (PDT)
Received: from orome (p200300e41f1c4d00f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f1c:4d00:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3e760786cddsm3307395f8f.14.2025.09.11.10.19.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Sep 2025 10:19:18 -0700 (PDT)
Date: Thu, 11 Sep 2025 19:19:16 +0200
From: Thierry Reding <thierry.reding@gmail.com>
To: Peter De Schrijver <pdeschrijver@nvidia.com>, 
	Prashant Gaikwad <pgaikwad@nvidia.com>, Michael Turquette <mturquette@baylibre.com>, 
	Stephen Boyd <sboyd@kernel.org>, Jonathan Hunter <jonathanh@nvidia.com>, 
	linux-clk@vger.kernel.org, linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Liao Yuanhong <liaoyuanhong@vivo.com>
Subject: Re: [PATCH] clk: tegra: Remove redundant semicolons
Message-ID: <axjur75ks4ib6273l2xfcu3prrjnmxwro26ocrct2dgobw42wo@nan7vw4egkow>
References: <20250813094003.552308-1-liaoyuanhong@vivo.com>
 <175761090509.3229177.9207716245913935287.b4-ty@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="hrth5zdfdtzr3exd"
Content-Disposition: inline
In-Reply-To: <175761090509.3229177.9207716245913935287.b4-ty@nvidia.com>


--hrth5zdfdtzr3exd
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] clk: tegra: Remove redundant semicolons
MIME-Version: 1.0

On Thu, Sep 11, 2025 at 07:15:32PM +0200, Thierry Reding wrote:
> From: Thierry Reding <treding@nvidia.com>
>=20
>=20
> On Wed, 13 Aug 2025 17:40:03 +0800, Liao Yuanhong wrote:
> > Remove unnecessary semicolons.
> >=20
> >=20
>=20
> Applied, thanks!
>=20
> [1/1] clk: tegra: Remove redundant semicolons
>       commit: 8ec061e72f15da80df10d4cf29777556992074e1

Scratch that. Stephen already applied this.

Thierry

--hrth5zdfdtzr3exd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmjDBJQACgkQ3SOs138+
s6Fnhw//aAmXHrNo8uDwH1S2CoJOmfSWtDC41SjGjRBp3u9JOSy+WFP6LFwj6G4S
aVy8AnD9COKvtTc9q/Tjg7YkhnyPc7mVrmgp5dCj12rvLNHt6WXYJBplj/lEvwYy
RnIjYvx4bnI72/nmjBrGrDV5xwX3cbYH1FpahksGXzwG/hd9C4CtbnTGgrkpqhB0
PzBQO3/O1Cm0HkSHAvvtQfWUDQ1cBbRsSdXLsNrBH6dz8+s4VIhxyBt/AcIs/q95
Sadv/LGYOcXGbjX163JwGtsCo4OcCcwunBLeoOU9ZuLoV1qfnUMyKiA8H2gsoKDA
OOPeqHwfGTuVv6TOIQBFmUxpiUVlqibPC/gfKynhc+QpPeB8iqJi6+zIlkUgfk8u
xNFQRKL7AejFz8fx+wn1u72O8WkAhlY3jNKzKcksj0pA9o8I6ujYVrl0lzXbRZI6
WAvYHeTurejO4yYNKvHKG8XfF9SGGOiYjI21fXvAICWPhZv3yz3lHWq+qvtJnXqD
qyyJau2ylyHS5xdijMZl9IC2dheTdd+nC+pQd55gezy1F+P8Cbubwak1XXN8lVbS
xQjSpNlVpLS8BNXw6RhwoTdllK6OcRGnpeROzaTJ3p7RJwABCt5oOak25K/ssylc
VP8wFE7EthPFDYORCcKOCwy/iBS8gtCKK3PU4/4ekNRiguvbq2A=
=YMuX
-----END PGP SIGNATURE-----

--hrth5zdfdtzr3exd--

