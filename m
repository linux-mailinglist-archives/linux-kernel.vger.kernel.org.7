Return-Path: <linux-kernel+bounces-835956-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B047BA86FE
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 10:45:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C8C643B4F15
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 08:45:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF6632773EC;
	Mon, 29 Sep 2025 08:45:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nF4jrYDH"
Received: from mail-yx1-f65.google.com (mail-yx1-f65.google.com [74.125.224.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C912275B16
	for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 08:45:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759135505; cv=none; b=Ja6VSEcpWdK5EBLh5mkUKtzLoWTEvsxxvTdgbKrEb6C/pLwi0/5/fvLOtOk9DWaHcZuiqwja+vNtCUKAwWO98sZZIIunz3v8E3AtV5iRpltJBwVudHkCD1Y0WAU6mrqc25AZl3vKtOxasYxDzYz0feEAB+Y95Gx0ZT9NrWVi7DI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759135505; c=relaxed/simple;
	bh=X75ObHJZr1Ef5aDV2F1f9MYR+RaTFrZG0VaxFYaJTtA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OvIGzTkeYG7XbM/tnFBjiqL1bq/GUxoiolEJkWWkvebnF4IJH8VXXyMFRKsCXgZUuJPBO6IRnk9dH+m4im66TCESYISLuKJi7eWqitmUCqWVlV9u2O0hmTfjZIdov+Y9YhxKRwygM1DRfTY2zEZYK1+sVQKFUHsREVhtn1cGUbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nF4jrYDH; arc=none smtp.client-ip=74.125.224.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f65.google.com with SMTP id 956f58d0204a3-633be3be1e6so3929709d50.1
        for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 01:45:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759135501; x=1759740301; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JP8IQIErWyVyQbQCHDd0KKmnOzs9hqCQnTWShHnXfyA=;
        b=nF4jrYDHYPpYw5ga/XFlhep4Zp6CCMkdaMOmCupi0ovTPYRVmjtzrrr2laGR0X3L4y
         tDcWr/wzUkXUJxmqkJtNmm+R1cJAVhD3Mk/aHHYMF6D2f4MFztDzDK/2h/C+e/UCNX+U
         8v2X/RYGFcioFRJXXfafqznEunb/qpjZE7HafC8Mfs8BEC5/lEMJMUUBuj6aW/j79r+N
         EhJfwpxYu4Lxzq36pf6jxzXxuPzfusTG1KpRJE4xeOdj9AhVOiAbVEJZuI+svjr/txn8
         ezfM6wUoOz9+4Luta0nnjIhaCgl/thkiVbvNFiCQiwnS8Sp28viDzGjD0Tsj91ITglrt
         bM3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759135501; x=1759740301;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JP8IQIErWyVyQbQCHDd0KKmnOzs9hqCQnTWShHnXfyA=;
        b=PqmvUerN8h17vIHNx81e9VoVYNXgeYeptZ6gjCb51yYpRLyjfiu+UjeXcbHalELXTZ
         +iHhdqxDzeqLaJMIFnTwdoG7+OztrAgKeiNpTqbyz5D3wjnANrF452dRFuIGbYJh9SW2
         vQDbAo1NN4Ho+NDw81uXs8amufnqQfK0EcgFD+/XPEZTTnGYYiX7wlHW+n9V6eFb4mAX
         uT/7vPmOb7zw35torZghPhwfFR0igPjiWpMZiblVHwlfPeusRCUDKPjwso8l7qMxx+4o
         FplIeOpFQN4cn/MdlxqnBmTwOV7QJYH7/msUSfwypoJnCdQZSst84HoJNLP7QXkYn/Ug
         lHCA==
X-Forwarded-Encrypted: i=1; AJvYcCVTS3RCxopGbAiw6/a9DGukNilE8/1zQK6QYtqbBXdfVyzVilIhSHubG6T/ZdLuEekjEuoFNRqDWSbeZek=@vger.kernel.org
X-Gm-Message-State: AOJu0YyjKWdvxtRkcakIIkhve03kjcFaKvwYetfKfqsAiZKcGiToTwYu
	LouWvDB04pvnHoqadO5q0SskCnx4HMhCYgbk1bSYclbEgH8GAYChoSDLhpqCWfX2pw/NU0ltJ6y
	cAg8mJWX0ZAMc/D5Jlxe4QUlkJPynOuB32/YpSwVjvfIj
X-Gm-Gg: ASbGnctmlAd6pB128nYpnD+pCvSSkhY2LlnKL6Rlm56Y4YkbyNCOZIyLpZAtntKlQgt
	rTWG1Sq6icKos1tZTpAtyhWtf2M+oQ37zaBnUCZoB867fvzSHrQfuTVOjKe79sKb0c4LKz9ftgP
	HoiEpoMfpcqUDhJZd/zIiQeUacrFkvPGdasFfRZzJqO9PBcWdYzpGQQQ5a4TrrgYRkW6BbW0cT3
	huDkBlYlwGVzCpI5A==
X-Google-Smtp-Source: AGHT+IFxYtBs5xRDiUYvTaJKzeNeG/IYt0ldkmoGNhRwvsol4gj4zN4L1p96bEyvoXGcb6J+7ZYjL3MG/05LU6Ra36M=
X-Received: by 2002:a53:7e05:0:b0:635:34f5:51a4 with SMTP id
 956f58d0204a3-636dddb3f9cmr6667956d50.13.1759135501484; Mon, 29 Sep 2025
 01:45:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250928061950.34531-1-dongml2@chinatelecom.cn> <175911730161.1696783.8081419303155421417@noble.neil.brown.name>
In-Reply-To: <175911730161.1696783.8081419303155421417@noble.neil.brown.name>
From: Menglong Dong <menglong8.dong@gmail.com>
Date: Mon, 29 Sep 2025 16:44:50 +0800
X-Gm-Features: AS18NWAWEWKS_kXuZX19DMBkYVbBkJRhoGuXBBDUCeDDp3ILgruju3i5YpW8Vlw
Message-ID: <CADxym3bHM3ykp6nSCNT_8fCVAGk04c1qgoFeAQbrCURSHk3NDg@mail.gmail.com>
Subject: Re: [PATCH] rhashtable: use likely/unlikely for rhashtable lookup
To: NeilBrown <neil@brown.name>
Cc: herbert@gondor.apana.org.au, tgraf@suug.ch, linux-crypto@vger.kernel.org, 
	linux-kernel@vger.kernel.org, jiang.biao@linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 29, 2025 at 11:41=E2=80=AFAM NeilBrown <neilb@ownmail.net> wrot=
e:
>
> On Sun, 28 Sep 2025, Menglong Dong wrote:
> > Sometimes, the result of the rhashtable_lookup() is expected to be foun=
d
> > or not found. Therefore, we can use likely() or unlikely() for such cas=
es.
> >
> > Following new functions are introduced, which will use likely or unlike=
ly
> > during the lookup:
> >
> >  rhashtable_lookup_likely
> >  rhashtable_lookup_unlikely
> >  rhltable_lookup_likely
> >  rhltable_lookup_unlikely
> >
> > A micro-benchmark is made for these new functions: lookup a existed ent=
ry
> > repeatedly for 100000000 times, and rhashtable_lookup_likely() gets ~30=
%
> > speedup.
>
> I generally like this patch - it seems well structured and leaves the
> code easy to maintain.
>
> I think you have made a good case for rhashtable_lookup_likely() and it
> seems sensible to optimise that case.
>
> I'm less sure of rhashtable_lookup_unlikely() - you have provided no
> measurements for that.
>
> In general we expect an rhashtable to be between 33% and 75% full.  The
> inevitable hash collisions will mean that the number of used slots in
> the bucket table will be a little less that this.  But let's assume 50%
> of the buckets are in use at any time on average.
>
> If you are using rhashtable_lookup_likely() you expect to find the
> target so you expect the bucket to not be empty, so it is reasonable to
> tell the compiler that it is "likely" that the pointer isn't NULL.
>
> However if you don't expect to find the target, that DOESN'T mean you
> expect the bucket to be empty - it could have another item it in.  All
> you can really say is that the probability of an empty bucket matches
> the degree of utilisation of the table - so about 50% as discussed
> above.
>
> So I don't think it is reasonable to ever tell the compiler that an
> bucket being empty is "likely".  You also use "likely()" for deciding
> whether or not to subtract the key offset from the address before
> returning a pointer.  This is a valid thing to tell the compiler, but we
> would need numbers to confirm whether or not it was worth adding to the
> API.
>
> If, however, you could provide numbers showing that in an rhashtable
> with lots of entries, a lookup for a non-existing key was faster with
> the rhashtable_lookup_unlikely() code, then I would find that
> interesting and worth pursuing.

Ah, you are right, I wasn't aware of this part. I think it makes no sense
to use unlikely() if the possibility of hitting the budget is ~50%. The onl=
y
thing that may matter is the using of unlikely() in rhashtable_lookup()
before returning the pointer.

I'll do a bench testing on that part, and I'll remove the unlikely version
directly in the next version if it doesn't help.

Thanks a lot!
Menglong Dong

>
> In general it would be interesting to know the number for both
> successful lookups and unsuccessful lookups across all three proposed
> lookup versions.  I don't know how helpful it would be, but I would find
> it interesting...
>
> Thanks,
> NeilBrown

