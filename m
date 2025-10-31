Return-Path: <linux-kernel+bounces-880589-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 95A7AC26183
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 17:24:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 06C341B20DA2
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 16:18:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52CF6313260;
	Fri, 31 Oct 2025 16:13:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D6dQgcF9"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05B83309EE4
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 16:13:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761927217; cv=none; b=SAAeXDtICRpIkwnTIUTvP44EKcfviWw/GXM5kjzUDBLxrBmBjmYJLdVpxYsBayGOcvojJPsq57KOo6fIdeuzaAG2ejlYjRNe6KzWq2ed+uDqnBpNDJOcRmxScRJn50C/ygRSvn1nTcQByESwhteWyCwFl4iSjQSWtFATFjd3XHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761927217; c=relaxed/simple;
	bh=ndOEHZ3nWccRUrwdUMb0NZJPH9B3+tUoq0msaJX3oRU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Gds1rxBJyPXL08nl3qZXePS9++kjvMvF5pPEqayKSOW7YINSSjLNdHxpPZEAEEHMheufjdHOo0tYdqQD9ERCjBVTgXRZLaK9lC4hap/GKsiCeaTX8ywDARO4vMW0LtI2j1GhvG0HpWtmzJYiwDv+dcn0mthot2nswuew6AaypZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D6dQgcF9; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-47728f914a4so12485835e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 09:13:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761927214; x=1762532014; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0sN3X2Xwo6rgocUEV/FIBQzOQxPvDntamogTA2IKqR4=;
        b=D6dQgcF9lny/vFokxaWJdICvY0QTb4NTgCdgveyuLz5ugCUWpa2Ho0+fyFA8w8Q4pJ
         9pUPdx1224oqIqfxmEhAVonZbpasRW+xqdY0OPKE4bEEvLnpo6mdnGdaFuAn4KHDQzdW
         PBxzRwRhwRKa46di9YTZKOu9fawaorTpO3Yr+MnWAUZfJ/YV33TVVrdoS107siSl7Ut0
         xUa1bD7tgRIPrFw4aOy+1ht65SicGSMou3HeBL0BX8ewQroAVETC8Mjxfh8lxuj1X4UF
         wUFrEFhSj1qOkbbP8ZI4Tx+6MvYT9cbsWIlMOtLg1xyhRsh/tEAi0r2qLQj05Pj+S/IN
         rgOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761927214; x=1762532014;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0sN3X2Xwo6rgocUEV/FIBQzOQxPvDntamogTA2IKqR4=;
        b=iz1GnooVXRv4y+aPvYrzSRdD5xvyIAuUnxSPHV8tZGkO8qmVTM3raM6ypi2fZm3X1z
         IECPAo8VUlIqzDZnqWv4wv1g7GSR0xGPMGnRfnTrloUMUTyips7ugVQ/H0uzlCpD8zut
         KMUq2c3l/bV5PNKT7OnoWGYQ41qtQeZMAm1wyruiEWa3O5wcTb1FFGZbGMqm450BtP5W
         z5rSmfBlcxW3CQtKVy+PAS0uGzbp2X+FihU+vWF2leYviXD4sHYLFQsFRg2pS+6wB3rc
         RrnplXHDC+qgf/4HKEsEx9nKIWY6Sw5FFKvThFWfqQ6XvuP4rvMckJ4pdZOd++zjpYKk
         v2CA==
X-Forwarded-Encrypted: i=1; AJvYcCVDivXrFiOkv3Zx6qM4fGRR0IMy7YRJInfkbYboR4iUM8JFrfOzXq/VC4PAl54lS2nvUJWMw6y/OW6QLgg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxe95z4W0YXhIlAgFWcfUjmsAKNOOCwTLYeNTn4JQmjnJ31V8Rz
	7ZFeVn7GXeL/24GAxG5M6vxelhdJxoc4RsHAXziDWYcICJSvTYJjhulE
X-Gm-Gg: ASbGncvxyqFKGDQVkpjgM6eVQMg17izAzhjBenjCyu4IKBKkAYz5u3MVVuN8Sx8DRKt
	be2JU1DL28TPAPnmW4Ef42QTJ5HixvvM3itQIMdWtGf/UojDpln7uoRgGuDV+kaqB/HIxpXuW+G
	n8WYKhe7alxFdP7Z0hjCS/EEsQaIx2w/2fsC8EdbQxHZcl5ETfR3n1tOTPxsZXfsHv+M6iJquag
	sCWLM0tAIZpU73A/o1zs+TZQuVaI4vx7HvBdqPGmfb8XurFbO9isqyT7kbAeHEAKNBpBnwwhLMn
	0aiPmLrK/SEzfWjNSaXxFjc1CAmoiL6WFaUhAIokGS3HHfs1yfin4A2DbjKpKkg7T+8W8lPwRgO
	okBF/yGZVCCtWW1qUwf3oHV4AIbySc4zGP079sBCj+M2xXCgYKEJCnjhtaI6krOE8Grqgyx7fGQ
	YKJYOVuyAqbk1AfszLon5qaKzTcmK5ZK46qbf82l23BzFvFv54XNOC
X-Google-Smtp-Source: AGHT+IHVP72QSGXFkR2pGkrGQk5WvUtITPWOK+QFA8hZ2bNsTY9AyXA5gNFkfS4+KdvMg01Jb8B6bA==
X-Received: by 2002:a05:600c:a0b:b0:476:57b4:72b6 with SMTP id 5b1f17b1804b1-477305a6db5mr44531025e9.8.1761927213600;
        Fri, 31 Oct 2025 09:13:33 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429c13f2b5asm4250397f8f.40.2025.10.31.09.13.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Oct 2025 09:13:33 -0700 (PDT)
Date: Fri, 31 Oct 2025 16:13:31 +0000
From: David Laight <david.laight.linux@gmail.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, Jyoti Bhayana
 <jbhayana@google.com>, Jonathan Cameron <jic23@kernel.org>, David Lechner
 <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>
Subject: Re: [PATCH v1 1/1] iio: common: scmi_sensors: Replace const_ilog2()
 with ilog2()
Message-ID: <20251031161331.0f0ef347@pumpkin>
In-Reply-To: <aQSw7V7tYjBOtJ7k@smile.fi.intel.com>
References: <20251031074500.3958667-1-andriy.shevchenko@linux.intel.com>
	<20251031094336.6f352b4f@pumpkin>
	<aQSHVsWGXzigTEMe@smile.fi.intel.com>
	<20251031124530.3db7805b@pumpkin>
	<aQSw7V7tYjBOtJ7k@smile.fi.intel.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, 31 Oct 2025 14:51:57 +0200
Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

> On Fri, Oct 31, 2025 at 12:45:30PM +0000, David Laight wrote:
> > On Fri, 31 Oct 2025 11:54:30 +0200
> > Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote: =20
> > > On Fri, Oct 31, 2025 at 09:43:36AM +0000, David Laight wrote: =20
> > > > On Fri, 31 Oct 2025 08:45:00 +0100
> > > > Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:   =20
>=20
> ...
>=20
> > > > >  		tstamp_scale =3D sensor->sensor_info->tstamp_scale +
> > > > > -			       const_ilog2(NSEC_PER_SEC) / const_ilog2(10);
> > > > > +			       ilog2(NSEC_PER_SEC) / ilog2(10);   =20
> > > >=20
> > > > Is that just a strange way of writing 9 ?   =20
> > >=20
> > > Why? It's correct way of writing log=C2=B9=E2=81=B0(NSEC_PER_SEC), th=
e problem here is that
> > > "i" people do not think about :-) =20
> >=20
> > Even without the "i" the division could easily give 8.999999.
> > So you'd be relying on rounding to get the required integral value.
> >  =20
> > > But we have intlog10(), I completely forgot about it. =20
> >=20
> > And it isn't the function the code is looking for.
> > (The result is shifted left 24 and it doesn't have an optimisation
> > for constants.) =20
>=20
> Do you have an idea how to improve that?

Not sure I'd want to get cpp to generate a high-precision log.
It if definitely doable, but will be a mind-blowing mess.
(and I'm not sure how many MB the expanded line would be).
An ilog10() would be easier (probably looking like const_ilog2()).

But for this code just use '+ 9' and add a suitable comment :-)

	David



