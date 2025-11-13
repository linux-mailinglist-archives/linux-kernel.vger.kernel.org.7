Return-Path: <linux-kernel+bounces-900053-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 636A5C597C2
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 19:35:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C1B9F3B7F86
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 18:32:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5726F30F934;
	Thu, 13 Nov 2025 18:32:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="buoZPyVo"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C469B30EF71
	for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 18:32:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763058766; cv=none; b=k7kAJ3oRFy7z0/M3mOXvFPXT3XvR93auFgSrxzuVGFvNPwDmW3h0e8sUFuWmLl3nUguf4w+N7lcez+s1R3+fQKnMaPBS+Dom9G7sj5oYa9WlSa9giscJL8gLeB7lyHYhvgl3HN5iUxqiTzsJFmb/PYgsEFp/ZjUn5iaSA3FXzOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763058766; c=relaxed/simple;
	bh=lVK6LGrRGW3eaG+V9l1z4aQDY2CjycAA5y0HtlS4sFw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FAOTZrY99zATu5g9+shSjY2Apeu7zItK2Q7AhvNm2afxC12oy1y5j13A5kR1lar2XJX10cFmb96nUNbUqSJU0O07z/EgXojZqcofp5ewOE8zvbupnIfvBQL7PIBZjUN9rPRLwfCu0HxXYL/ncAp7xV1gHwB1AeEhT12bUIuQDj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=buoZPyVo; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-47112edf9f7so6043365e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 10:32:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763058763; x=1763663563; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=v9yZQXqBch1JSJzcaQQctkjx9YKy3u8FyEyL/vNPgfc=;
        b=buoZPyVo7ZpxO7iHnKxBGL+Mddg0YRXQE95VObAX4idoXofJHPS7wtTeN1dfitRF2v
         C3P8AadegOHoPG9KGBUkncQnmKw2oI00zot1SGTXuEWVzyAyhfuQDD7rvTmhd/ujDliq
         DvQ4sbzWj8b/4JIfb1fflA2qsG7llFGKk4YPRD6KMgAqMjjH6kwEIuHNm7VWM3k8rmYq
         Hru2Fqz92YWIqvxeavvM2p2gCflCx49M4wSrUTqo9bRb/854VOA17uXmUELQ8juuWUyD
         K145cLRHUNwMMnduWR7cHY6SgPAs2gqSPaD1lbO3U8iSatx7FJcokQvOSl+qZe10R4ki
         2/RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763058763; x=1763663563;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=v9yZQXqBch1JSJzcaQQctkjx9YKy3u8FyEyL/vNPgfc=;
        b=Xa9gbUB/UCO0PjFg8tyZ1xCWED6rElZwiwXRUVwZW3KqS8aYYp4xH8BpLAJoSZLkxo
         xm/YpxLQYuAY8HNE6a+p7Hffg6XHLT50cDYjvS0ewczjhA2QMhit2lykVJf/H3XTo6jl
         bd18Ymml/Inlvo5KWGSDKxLrYFLygejq/pi9Za97baUtDtPOFbvF2XPlRElMVs88QCJF
         M7eYPNWIkOKKd0GFJE8c4ElSUDEM7JNBz7HQXP1BEyEPm/iprvp50eFEi7sFBOxVC8zI
         carxOULiX4wD7lq5+GjOZgFMSKq6JdG6Z/yhevZsrNMpz2T2tEnk2lUyGwSt6PsDKDVN
         hvwg==
X-Forwarded-Encrypted: i=1; AJvYcCVPeKKLgxmEv5UemZH2ASUwOOc7Jaxw50IO9xxM7nyEiw8mVqKAPIAqHIKaZ3Kdkd3rx2Lu84tygeS5rAo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/5/jtPKTuSnFHx/kkdN+T3YPOht9IQKj2VtGeaWZqdXJxgF7X
	TRT+jTlqvQt0BZjCTKJbmQP2UjupYKOXka5f0AQwb/qndlsJyNU+/uxW+G9IwA==
X-Gm-Gg: ASbGncsjnuZ/DcXTTWoPP2MVH7OrQ6N7D+AJBIzKIkk+CQOxLBOeJ6VNvPxoyp3mnjt
	d6PN3mjfoRgQpH3IdJEDxoPsuM0xSM0+Cg/MURSk7HsaAe2nlXi0+RUyx/E8a93BuL7lALCjrcU
	jauFz4PT1DzOZPoM37MHIaZxSRZYZ9frV4PH2eJ/lz/aooIhP9SL162QM+CiBuaz+HsFruRIFkc
	YnY0v1x9+pZOnLiQeRk+7tiUqjdtTKiJc5Y+CydJ6orJBbtUeJDjx/4u4AWdMh+ozaw04xBTSMg
	0roPAq+eIBeC0pyv7Q6UkS04S1N4tEfOghgceNPMTXZbrDJbCd0Fjyg2xIhsNzAb8pUAvgSAakd
	nBTTUR0qvCXphcrbFqcvBKoIBetLFBsDzKtznLMdI9M4HnB95gGSXtTKuarXQfq25vK9qt57i40
	MS8lg0qw7h31gul6tMZvbnwGidCl13GxJ8964zb8LOtEKOd36H1pDFNGdIgRUb3fVJ/yQjRZ05q
	A==
X-Google-Smtp-Source: AGHT+IEUOfl9Mj/MhDnCs6vXeSUiBJWe5OA5hhf/B85epyvDSKEXz8FsTxq8lGXRcYwvA52KNvjEqA==
X-Received: by 2002:a05:600c:3b12:b0:477:67ca:cdbb with SMTP id 5b1f17b1804b1-4778febd327mr4653575e9.36.1763058762895;
        Thu, 13 Nov 2025 10:32:42 -0800 (PST)
Received: from orome (p200300e41f274600f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f27:4600:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4778c88bee1sm63595835e9.11.2025.11.13.10.32.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Nov 2025 10:32:40 -0800 (PST)
Date: Thu, 13 Nov 2025 19:32:38 +0100
From: Thierry Reding <thierry.reding@gmail.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: x86@kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-riscv@lists.infradead.org, linux-mips@vger.kernel.org, loongarch@lists.linux.dev, 
	linuxppc-dev@lists.ozlabs.org, linux-sh@vger.kernel.org, linux-pci@vger.kernel.org, 
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/7] syscore: Pass context data to callbacks
Message-ID: <2tx3o5es77oa37zqvikcoo6n2ryxvepa54ezsaawcjdbf3g3wp@o2dbcbskjksk>
References: <20251029163336.2785270-1-thierry.reding@gmail.com>
 <20251029163336.2785270-2-thierry.reding@gmail.com>
 <CAJZ5v0igMJ12KoYCmrWauvOfdxaNP5-XVKoSxUroaKFN7S-rTQ@mail.gmail.com>
 <3dzha4qyqdrbutxby3n5nkvihnxrhniqr6w726eumhzgln2w5l@fbu72mzmjz4m>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="7axrx4sqgqvkj2b7"
Content-Disposition: inline
In-Reply-To: <3dzha4qyqdrbutxby3n5nkvihnxrhniqr6w726eumhzgln2w5l@fbu72mzmjz4m>


--7axrx4sqgqvkj2b7
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v3 1/7] syscore: Pass context data to callbacks
MIME-Version: 1.0

On Wed, Nov 05, 2025 at 05:52:01PM +0100, Thierry Reding wrote:
> On Mon, Nov 03, 2025 at 05:18:08PM +0100, Rafael J. Wysocki wrote:
> > On Wed, Oct 29, 2025 at 5:33=E2=80=AFPM Thierry Reding <thierry.reding@=
gmail.com> wrote:
> > >
> > > From: Thierry Reding <treding@nvidia.com>
> > >
> > > Several drivers can benefit from registering per-instance data along
> > > with the syscore operations. To achieve this, move the modifiable fie=
lds
> > > out of the syscore_ops structure and into a separate struct syscore t=
hat
> > > can be registered with the framework. Add a void * driver data field =
for
> > > drivers to store contextual data that will be passed to the syscore o=
ps.
> > >
> > > Signed-off-by: Thierry Reding <treding@nvidia.com>
> >=20
> > This change is fine with me, so I can apply it unless somebody has any
> > specific heartburn related to it (Greg?), but in case you want to
> > route it differently
> >=20
> > Acked-by: Rafael J. Wysocki (Intel) <rafael@kernel.org>
>=20
> I have a few follow-up patches for the Tegra PMC driver that depend on
> this. 6.19 is what I was targetting, so if we could put this into a
> stable branch that'd be the best solution. I can set that up via the
> Tegra tree if you and Greg are okay with it.
>=20
> If that's all too complicated, I can probably wait until the next cycle
> to merge the PMC changes.

I've added this single patch to a branch based off of v6.18-rc1 that I
plan to feed into linux-next so it can get some broader exposure.

I can keep that branch stable so it can go through multiple trees if
needed. If anyone's interested, the branch is here:

	https://git.kernel.org/pub/scm/linux/kernel/git/tegra/linux.git/log/?h=3Df=
or-6.19/syscore

Thierry

--7axrx4sqgqvkj2b7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmkWJEYACgkQ3SOs138+
s6GbLQ/+LcY0n50MLCzG6P3cLlbnizYWB4fd77qBH6YbB2iRPf1TPkFtC1s24QiA
KgZqLzCkJ5rw0Xtvmtzci4gr3GeqsMf/4DM0k3X5WdN/DMat0RTe1rhVuxq0MmGV
7kmy+iB9FW6MgVt4kjeYdEL94ohEKXEUKTS6HTGfPFsonbJjnZdIsv4GVThClyxW
Y3vE0mnoAvxjqtVu57jc/Ihryv5Zz6pYiX9AWhT1ryTG7tmgKuFWW0YgqkFy/Y9O
rneSUrPJCeOBzjgL5oY6mPqTCl5f0VdGMb9S18RK+DKXSCLW7b0nGt4CCN7sEuOo
7Dy1UuUjok1XLs8NYPQ7oDD29Q536WmrUmQMjMm0R3HuqmmD+PDO0/I9QA2cuOvw
V1zUm+XqIlAyZs4lZkJXotqlCEBkPNCv0iIqEraETrCS1RYi/k0eqPF3Yu3oQc5p
58cnaEW28DaJ9+Cy7T4NCu7lsDzDyyL+5n4HQyWGaFkVYU+Wkfh0H1ezo8bP9txU
/Yan3s21OGdjzLMcCT0abiDrFOdN9N6HGOI2/UHnz87jxubwy7HjZ52Fkz3iGATD
uz1HyHzrIav2FWTN0PkENUQpiTQIHTs0znDBKPpTvDkeVbTF5nQuP2S0+bUGxvLR
BBevVnm7dT2dD5WqJbGfhem+DFPn66JVA5SFq9+/bvG0KsOpwpA=
=Jfb5
-----END PGP SIGNATURE-----

--7axrx4sqgqvkj2b7--

