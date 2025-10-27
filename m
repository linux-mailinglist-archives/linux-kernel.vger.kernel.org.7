Return-Path: <linux-kernel+bounces-871306-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FC5DC0CDDD
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 11:06:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B518D189F20E
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 10:03:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86B932F363F;
	Mon, 27 Oct 2025 10:02:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YBOijz7i"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E064B1E1DFC;
	Mon, 27 Oct 2025 10:02:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761559363; cv=none; b=NW9E7cFxUgCLzbPg6GnrPYO0xe2nE37/p86v3I/0X3c09wBcN7+nNV/tMGns/ptEE2RrA7tXZ8kieZnWGg7er5Y9QFhiEcu4Ub2vy97iZVK/A9oRY1ns9Hn31SirJs1Q7UVFnurIVR9JxMjLzkixhCMdzgFxdHNSKxGel4sKZC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761559363; c=relaxed/simple;
	bh=/QDE1NTmcHLj6cZxvtKX7IpmEEs54NofkZK/CdHREmw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LmUNlmydk7R53Z7FmhI67p/wpHCSV+1JIVd2/eiY3ZzOL7MNr7wHa3MDcxZQUG1HV0+9fzXi5A7uag2gOYGsChUUQnHfNlxuBIUvW9xEHys/QiTmBTJDvWoeyF8znLYGU1xQnLBqn16rP3OARkQYy9ZyfJdbYM9yLXv8sByHlT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YBOijz7i; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10F4DC4CEF1;
	Mon, 27 Oct 2025 10:02:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761559362;
	bh=/QDE1NTmcHLj6cZxvtKX7IpmEEs54NofkZK/CdHREmw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YBOijz7i/eboYrZF9npI4++3SIru42ibnsld27Q2SLYGrjJ0ahlzzT7qDdSsi4v7c
	 kWykepWypLzxWkBuKr8hkfZML6g8KYlGBCOxOGTWvneVGQJP7rHg1k6+2OpIgQFlKp
	 QAKPkHqfyjiw4rWPAT1t3Npg8nOHb2uoDn7vvVBNIa9Jmey5FDIsLME/YSlcvsk5ao
	 tkNfyBD8aNBozybSMSAgPlOjZ2QqM5ZFtENj10okC3XvDhreSd4kKYzVd7aW15BAix
	 M/Dc4zgN6qRaCQMC7/EYgZUri+ywkRp96kpRciaLKYCAUYZa7aIjtIaDERzLYOFn2G
	 xYVv+E9X4VuhQ==
Date: Mon, 27 Oct 2025 11:02:39 +0100
From: Maxime Ripard <mripard@kernel.org>
To: Rob Herring <robh@kernel.org>
Cc: Saravana Kannan <saravanak@google.com>, 
	Eric Chanudet <echanude@redhat.com>, Radu Rendec <rrendec@redhat.com>, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] of: Make the number of reserved memory regions
 configurable
Message-ID: <6moxms5mnvjgvfxie4zoewdvq4bbmg56hmtpohdxwujdqydxqg@r2x2rvrpjh6g>
References: <20251023-of-max-reserved-mem-v1-1-cfecc7a2150f@kernel.org>
 <CAL_JsqKtGMk8JQJR37i73CMnqtdoZddNpnoVhmyE4w1qUXnRhg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha384;
	protocol="application/pgp-signature"; boundary="r74ooysyp7nd2b2m"
Content-Disposition: inline
In-Reply-To: <CAL_JsqKtGMk8JQJR37i73CMnqtdoZddNpnoVhmyE4w1qUXnRhg@mail.gmail.com>


--r74ooysyp7nd2b2m
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] of: Make the number of reserved memory regions
 configurable
MIME-Version: 1.0

Hi Rob,

Thanks for your answer!

On Fri, Oct 24, 2025 at 07:57:06AM -0500, Rob Herring wrote:
> On Thu, Oct 23, 2025 at 10:35=E2=80=AFAM Maxime Ripard <mripard@kernel.or=
g> wrote:
> >
> > Some platforms register more reserved memory regions than the current
> > hardcoded limit of 64.
>=20
> I've already NAKed a kconfig option for this before.
>=20
> The limit is now 64 dynamic regions, not total. The static regions are
> unlimited. What platform needs so many regions and to abuse
> /reserved-memory like this?

I'm sorry, I totally missed both that you nacked it and that it got
fixed recently. We're still seeing the issue with 6.12, but it looks like

https://lore.kernel.org/all/20241008220624.551309-1-quic_obabatun@quicinc.c=
om/

Is the series you were talking about?

Thanks,
Maxime

--r74ooysyp7nd2b2m
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJUEABMJAB0WIQTkHFbLp4ejekA/qfgnX84Zoj2+dgUCaP9DOwAKCRAnX84Zoj2+
dmq6AX9EAICgL6Tvg573I6LgeVgvdB+Bz2UXpZ3phks1ridThlZ+L9k7vvokZayV
Gq/Xj8cBgJ11n4nhHFKavZdVQFT/rpgpQMPu1VC4qpLdefy8e82LBfro/Tcisg3f
/mglG+U3Kg==
=HuAT
-----END PGP SIGNATURE-----

--r74ooysyp7nd2b2m--

