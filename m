Return-Path: <linux-kernel+bounces-609578-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C5B7AA923F2
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Apr 2025 19:27:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A84E0189B867
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Apr 2025 17:27:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D938B14F90;
	Thu, 17 Apr 2025 17:27:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=posteo.net header.i=@posteo.net header.b="L7AHkC6E"
Received: from mout02.posteo.de (mout02.posteo.de [185.67.36.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2342F1ADC6C
	for <linux-kernel@vger.kernel.org>; Thu, 17 Apr 2025 17:27:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.67.36.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744910827; cv=none; b=A6gugdE7CO2t0o2J4D+NXffIVRKapwnf63woJ5TO+vQvBf0BMu0NDsC5KdJug1LFgxe777iF4njx1BdTZnlta3n8sBlrzqZbst8tf9cs5DdUVoTEjkwLmWUlDBDhSMeghlwLiYoimhzZCD+sNGmNEcEh40UYF58lSegceWClXUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744910827; c=relaxed/simple;
	bh=n5minbvQKRDdzRXAgO5LmYLGqHrSYkxYUYinpIYV8MY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=EhQ0Kofsv46xnU3UiIh7T4x7zJ597xIiMvRfsPBCyxllAdRyuqJfQSsyuIruSVuxZfVSn0QA3CsGv2ssupZBlHrOGmhgVjESqHlq1VxLOk4Hv9SlRhoA+FHzxJ2fnH7XhLQF6cfH14A29hSoXHEY6vhYLfBqQ2vG/28HXrmSvSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.net; spf=pass smtp.mailfrom=posteo.net; dkim=pass (2048-bit key) header.d=posteo.net header.i=@posteo.net header.b=L7AHkC6E; arc=none smtp.client-ip=185.67.36.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=posteo.net
Received: from submission (posteo.de [185.67.36.169]) 
	by mout02.posteo.de (Postfix) with ESMTPS id 33FD5240104
	for <linux-kernel@vger.kernel.org>; Thu, 17 Apr 2025 19:27:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.net; s=2017;
	t=1744910823; bh=n5minbvQKRDdzRXAgO5LmYLGqHrSYkxYUYinpIYV8MY=;
	h=Message-ID:Subject:From:To:Cc:Date:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:From;
	b=L7AHkC6E5RBkL1rT1997zm3B7ie3EDz68H5HIW2eOKb03e9onfATyQxiLiUdEE62v
	 TIu6OmncN/41P0WlXHoSLnCkDyPj0YSVCBTF/Ys7UIjy7nrPvwxFU8CExwVP1Ji+Gc
	 z1z51WJ/uFDi3RjSBq1+ERDOZKW/SiOr8FGyQ0bT4dLqcus1TqqThD4wHVUNF2f8b1
	 RSqtnai/6a7ruIVVw8iLrmQTj2vvpj6g0i8NO/Gj5dW7pEl+gGjCdOneNm/VvpuNIW
	 wk0InwnpldGmQxzx8K1iw9QPj3zeGrE7yMw1BfN+CS4AG0MZ7vUxvFpjHqLSEkDPIA
	 peG6E5VdxzRGw==
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4ZdlFK2NvTz6tvd;
	Thu, 17 Apr 2025 19:27:01 +0200 (CEST)
Message-ID: <8578fcea4ae682e8bb8b60b21df3c27d757b019c.camel@posteo.net>
Subject: Re: [PATCH] iio: frequency:: Remove unused parameter from data
 documentation
From: Charalampos Mitrodimas <charmitro@posteo.net>
To: Gabriel Shahrouzi <gshahrouzi@gmail.com>
Cc: skhan@linuxfoundation.org, linux-kernel-mentees@lists.linux.dev, 
	gregkh@linuxfoundation.org, jic23@kernel.org, lars@metafoo.de, 
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-staging@lists.linux.dev, Michael.Hennerich@analog.com
Date: Thu, 17 Apr 2025 17:26:57 +0000
In-Reply-To: <CAKUZ0zK58DgEN6C9U34dyxrVuoq3PoQFQ1_O0ve4GQYy+bUJOA@mail.gmail.com>
References: <20250417143220.572261-1-gshahrouzi@gmail.com>
	 <56edfb88d3f31939fb343149bfad436f24671f9d.camel@posteo.net>
	 <2cc70f19c1b001ea7f2cf0632618d060f69faef0.camel@posteo.net>
	 <CAKUZ0zK58DgEN6C9U34dyxrVuoq3PoQFQ1_O0ve4GQYy+bUJOA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2025-04-17 at 13:17 -0400, Gabriel Shahrouzi wrote:
> On Thu, Apr 17, 2025 at 11:57=E2=80=AFAM Charalampos Mitrodimas
> <charmitro@posteo.net> wrote:
> >=20
> > On Thu, 2025-04-17 at 15:53 +0000, Charalampos Mitrodimas wrote:
> > > On Thu, 2025-04-17 at 10:32 -0400, Gabriel Shahrouzi wrote:
> > > > The AD9832 driver uses the Common Clock Framework (CCF) to
> > > > obtain
> > > > the
> > > > master clock (MCLK) frequency rather than relying on a
> > > > frequency
> > > > value
> > > > passed from platform data.
> > > >=20
> > > > Signed-off-by: Gabriel Shahrouzi <gshahrouzi@gmail.com>
> > > > ---
> > > > =C2=A0drivers/staging/iio/frequency/ad9832.h | 1 -
> > > > =C2=A01 file changed, 1 deletion(-)
> > > >=20
> > > > diff --git a/drivers/staging/iio/frequency/ad9832.h
> > > > b/drivers/staging/iio/frequency/ad9832.h
> > > > index 98dfbd9289ab8..d0d840edb8d27 100644
> > > > --- a/drivers/staging/iio/frequency/ad9832.h
> > > > +++ b/drivers/staging/iio/frequency/ad9832.h
> > > > @@ -13,7 +13,6 @@
> > > >=20
> > > > =C2=A0/**
> > > > =C2=A0 * struct ad9832_platform_data - platform specific informatio=
n
> > > > - * @mclk:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 master clock in Hz
> > >=20
> > > Hi Gabriel,
> > >=20
> > > This seems to be a leftover from
> > > 566564e80b0ed23ffa4c40f7ad4224bf3327053a ("staging: iio: ad9832:
> > > use
> > > clock framework for clock reference")
> Ah ok. I will include this in the body as a reference. I guess for
> small clean up patches like this, they would have been most likely to
> be included in a larger patch that covered other changes but
> forgotten. In this case, should they be referenced?

Yes, you can just have a reference to it on your v2 (if a v2 is
needed).

> >=20
> > That said, a Fixes: tag might be helpful?
> >=20
> > >=20
> > >=20
> > >=20
> > > > =C2=A0 * @freq0:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 power up freq0 tuning word in Hz
> > > > =C2=A0 * @freq1:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 power up freq1 tuning word in Hz
> > > > =C2=A0 * @phase0:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 power up phase0 value [0..4095]
> > > > correlates
> > > > with 0..2PI
> > >=20
> > >=20
> >=20


