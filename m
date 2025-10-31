Return-Path: <linux-kernel+bounces-880189-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB161C2514F
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 13:47:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6965A423003
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 12:46:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3230734C81B;
	Fri, 31 Oct 2025 12:45:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SKTc/vLY"
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF12B19ABC6
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 12:45:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761914739; cv=none; b=V3/yB7xCli7J2RzPLbtLJ9Y6civ89K2c1gl9cHrVYfG6V61GoOaOHPoWbcQY8ZQ8MOd+fOxus0QLre6aTH3yL8aBD1SBIFr53PqBhEL6dwfMoDwuMdCKqkj78dl61GhbWtBechexONg5cdZ9qTYjNmH352ItviZt8m1ojdsKTas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761914739; c=relaxed/simple;
	bh=YEJFofn4dJHm/7g/MnUrRU8zirCPi/m2VRyPXl529WI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EGFE3UbIFk77acQ+VbU0cmhIc3qahJQ3f9vv3XANAFrNeIf33RnRD4MrNV3CuiDKq2QtWMumDx5kZVoCbt8+nMRyQHvC13Cmd8PLwnJYtqDbTaYS0ENg9NbP/SZRec2atETSYjrmz3Wbutnaa6jeiG8E8IL0NiIepw8HSbpfzQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SKTc/vLY; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-3ece1102998so1570841f8f.2
        for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 05:45:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761914732; x=1762519532; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=htLfTgaGj6SXyo+gY+C4RM9cQYSpr8e9dgfcpC46jhA=;
        b=SKTc/vLYhamnfomqqqDSBQM3XSkYb8cQPUdYv/tzGvjNLc84NDF+N3MfONpqDMbvFN
         ZaYOHDTr7erTHV8vTRzrxxahAwEbV8Z45Dc8d1orsJrA3KbsONJj6K9zLpKoE8rkr24s
         nPTJWGsDAL8heGdasVxisIydjsTISXLLPiFitnXlek0iYHMRwsmAKQIEzKaldVNLKNJ2
         VRW1L2IkndqEGDjDjodM3xgnjaGIJtMGjYwALif4wE5X1NIY+5iMrSWeLrQasL8zmjGG
         bgHMcAr9Ef89TlkeadNGVu7Q050czjfjQEUPEET4tk5+WlEUrOpsHdAvXdJ0sdDKMQVY
         qDMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761914732; x=1762519532;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=htLfTgaGj6SXyo+gY+C4RM9cQYSpr8e9dgfcpC46jhA=;
        b=CtgeB2K+Cx/OnufGHZYcgP2OilMS0b2f6JYdJMNjEatwCddENpvwLsIT5yDmRJ2v01
         1F5R4EXOCXU2fjzeiIy/NK4yYvTkLJnTDPG0ndl7NxIgYH3AkCGC4NLHT+GIaa5Mc87n
         HctiD+toT0s4QCqtCQ7AAxku73s6ceTESrSsGbgs7y187ch60cTF7m6NTzRGBI7tTQEz
         TmFz+mOTWD0UOYU6Bc+yxuCZ4iGIJmiishRDHGN/vLBcXfonFHEU+ZDxuUYOvQt1c5Vs
         YGns5uLpil3SqIYcPFdetfq/WyfWKJ5knI6tt5wYSrATliOHvi9gkr2maoQHyCbAeyAv
         SFPA==
X-Forwarded-Encrypted: i=1; AJvYcCVaqMfOpUBfrMaYFkJgywdyTq1WDZkKpS9HYAcTqyESX5/60oaXawKwe+bsIrzTMgH2Gj4pLzevJdvzPGM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwLxRgK4XxwpW+gJPKvgzTw2k0ZCZqTnznaFskBOdjI3pxidDi3
	MWXfaNX+IG10TrGT6r0l0qys/fz5dRWGlShew5TIm857y5PY9vOWJOdi
X-Gm-Gg: ASbGnct4i0B2DpyvQjzWP4HzTnP7rJksc092ZkyDJ0Q+/vJ5qhCtH0XVuiTYe2dibVB
	HUPNgxsvvg6kHUhMRF7dKQTow/OPEgPh4zE6gQ7iC1TwudPZWUe3q+LeSSi00wZvDNr62DuaKyw
	YA2cSwCisT6eUyVKv58Fn2TTxuc+819MZrh/jy8WC3yPIwHAA+newpz7TNsIqQS5V7V+xx8ZlUs
	FwTo7jNl4ynByUXlI0NUUDaB2EZyIVdtJjPrmjZZ2BTuE7LprPMRFQDmgsopzUlKQlSvnKgpJmJ
	ggYGoQvMXq7E7fSlZXOejc60AXLH1xbXTJjCwNNf00WU+pvn2l+AuFabkDeaRM7Pe+YDNFvI/qO
	CAqaUrIjJPiIWmK4oOVI1hYYq9zdn5Z5qny5hFAmeBPB/RGuNL72FRseFnHN8FXIqNkQPgvcFwV
	qLsKtuuAby4EzsWCzt4BxpqEx28DTBXvIHl/XI4AOK/MCq8ntVttB0
X-Google-Smtp-Source: AGHT+IHSbBaoyJFzeN/27Rgp+5ix/nizQNjZB0dnWxKV1godF2Cu1it5Urb0qAv1OThr89VNsq/Rxg==
X-Received: by 2002:a05:6000:40ca:b0:429:b9bc:e81a with SMTP id ffacd0b85a97d-429bd5ef85bmr2376964f8f.0.1761914731839;
        Fri, 31 Oct 2025 05:45:31 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429c1125ad0sm3503532f8f.13.2025.10.31.05.45.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Oct 2025 05:45:31 -0700 (PDT)
Date: Fri, 31 Oct 2025 12:45:30 +0000
From: David Laight <david.laight.linux@gmail.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, Jyoti Bhayana
 <jbhayana@google.com>, Jonathan Cameron <jic23@kernel.org>, David Lechner
 <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>
Subject: Re: [PATCH v1 1/1] iio: common: scmi_sensors: Replace const_ilog2()
 with ilog2()
Message-ID: <20251031124530.3db7805b@pumpkin>
In-Reply-To: <aQSHVsWGXzigTEMe@smile.fi.intel.com>
References: <20251031074500.3958667-1-andriy.shevchenko@linux.intel.com>
	<20251031094336.6f352b4f@pumpkin>
	<aQSHVsWGXzigTEMe@smile.fi.intel.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, 31 Oct 2025 11:54:30 +0200
Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

> On Fri, Oct 31, 2025 at 09:43:36AM +0000, David Laight wrote:
> > On Fri, 31 Oct 2025 08:45:00 +0100
> > Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote: =20
>=20
> ...
>=20
> > >  		tstamp_scale =3D sensor->sensor_info->tstamp_scale +
> > > -			       const_ilog2(NSEC_PER_SEC) / const_ilog2(10);
> > > +			       ilog2(NSEC_PER_SEC) / ilog2(10); =20
> >=20
> > Is that just a strange way of writing 9 ? =20
>=20
> Why? It's correct way of writing log=C2=B9=E2=81=B0(NSEC_PER_SEC), the pr=
oblem here is that
> "i" people do not think about :-)

Even without the "i" the division could easily give 8.999999.
So you'd be relying on rounding to get the required integral value.

> But we have intlog10(), I completely forgot about it.

And it isn't the function the code is looking for.
(The result is shifted left 24 and it doesn't have an optimisation
for constants.)

>=20
> > Mathematically log2(x)/log2(10) is log10(x) - which would be 9.
> > The code does seem to be 'in luck' though.
> > NSEC_PER_SEC is 10^9 or 0x3b9aca00, so ilog2(NSEC_PER_SEC) is 29.
> > ilog2(10) is 3, and 29/3 is 9.
> >=20
> > Do the same for 10^10 and you get 11. =20
>=20
> That code looks like working by luck entirely, TBH. I just took the scope=
 of
> the patch to start dropping const_ilog2() usages.

Something always crawls out of the woodwork...

	David



