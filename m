Return-Path: <linux-kernel+bounces-879172-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id F09E7C22706
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 22:40:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 75F2034E64D
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 21:40:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B0B83233FA;
	Thu, 30 Oct 2025 21:40:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l9gVow4Z"
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 181C63112DC
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 21:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761860402; cv=none; b=k3zGChReMRtC5PFD02WTKHJRW7qyHTwHgCtmxmPxdkVOzwUi+O5BgN08wK6skeT92geOLHqlcE7vkga66ZUSaJu4nfZElXHJCt1TXREHAvP3zlbQ1WcXOMfxvvPEvWSeiDNximElZmICBKMkxcYw9Lkam4JQtR/9kwbkp0gsNUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761860402; c=relaxed/simple;
	bh=Un7q2VE5bBWMu9+bF1/DDuPDLvT9+CiXheIllChWZYg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TLxCq2RzcHyNImJfmCpHThEwfrEiK0F9dV1Ld3nTzy1Qrwbg74SdM/wbQHueGqQJlne2oVvH+Ju1PVHoWm7Ke7yUIXYBMsMNMe5DgvCq8CjkUul+ruHeWU0nWMVVj3+8lNSi+YlXe6Lo+4izf8sODMafUz8rMfBevg/l2I4r42s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l9gVow4Z; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-63e0abe71a1so3188220a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 14:40:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761860399; x=1762465199; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Un7q2VE5bBWMu9+bF1/DDuPDLvT9+CiXheIllChWZYg=;
        b=l9gVow4ZwNZEUykKmLsbfgJEXkRM/dGHpifWnWjcgcIlKUk4R7kqjjTZ5LF5BTuhzA
         uLKHJDCZpLcVD+AH9Gsj+bZ8OCU+d7W9uEIDFSwjZCv6WpNY/ehv1fArZf+9cVzMubCd
         HqRf2rYRwwaOd63zqUWfakhLSMhi9OuSr0FrzlVahK9KgQlbWmE3pNqBbBvD2lFQpYuK
         M8KLXZbh2gNEeJadSB1QOj+zGMMLd+9rY3HEnMRs8IioxrVkvjsJJBDRknPnH9A/Qdh2
         gyqJQiJ1TH/dQC5HntBX32Ey5+d0U3/Huqf1FZ2BmrrbpT69MUL9srh7t9Iv7N7RLpVv
         ybyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761860399; x=1762465199;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Un7q2VE5bBWMu9+bF1/DDuPDLvT9+CiXheIllChWZYg=;
        b=qdYINbL3iTZngpl5pFcbAJKyB6DDipOlAHOzdccuQNZy55qon5nwD9G/5U7G78OL69
         0Lx7Uvc5L0TYbiqJi/fdNw+QgXd3mfRcene5PeOy/5RddcnhaoB8Rc/YHh6O8rq3nEkk
         z81k7oEzykwZiOpsdlMJkxY/CXRFsdFTZcg+hCqQAXwCjEhcjT6tcd/ble/P7ds08s1I
         PbNpm7FftVyWp6ybUiU1EBv55EoaG9ewNusCtFhH3ewyS8C97d/A3Rs4305cvm8pv5mm
         o/lEPAuokLTZZLIFf+SppN9PvIJm/tABOV+UmMG7dZzzKjqdCPcU08l8WmqxvETs4TIB
         +nfg==
X-Forwarded-Encrypted: i=1; AJvYcCUgxQlSMTVH+fgF3ogUkW9RFLXI1RsaOHUlqisnVSPy9v+OxOdqe9EoXXXoHPxwfU6VfhLBeUKrOj6E5Uk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxmhkG5mCfj6kpYeuExD/18fficIx5qmecaUuJVLwzyt7gor4MI
	B6+Eci8na0t1HpcJhGZEGH31KMgS2PZCoYDqwZwF/MneO+WNeyqyp+3+/07vhDsyDe26D3rqztt
	L4jh+EnTFkO1E04dPWFw6Y5HDnHJiS1sXThoZ
X-Gm-Gg: ASbGncsVKTQ9eMyXgnaNKKx/ar0MvckgbLKYEH5PZvwmJdaWrw7iSw2XD3UMLBZz1yp
	fs6O1+ExhU1EGsPYlhJE3Mv8RaadDEpsEV1I/rmjatAsPvSmx85FmRIbY39CCZ9Gb1Ey2gjTYSS
	irpM6W+drjXzl/rZtoy4r5u1ljhNvtJj7+f0aZmZQq0PTl7a5o0mgndgyRMS4WIxVlmLGLQNOJz
	1ToGpK7YRtbZxr1zkCJRLVMQXUSWygiJiCZ65w/NeJ5rJRSdahTEhBwL8fmPmYVqOqzclxUNbtx
	+XY4gWScmysDs14=
X-Google-Smtp-Source: AGHT+IGivTHuxgPZcQa4cCBLgM5kLxSC+JWSlWSFpHYQlDc5EdqGinLy/IF97I7fOc1TIWJwOMdylWlJmhsiHGzUZNM=
X-Received: by 2002:a05:6402:2711:b0:63c:33f8:f05e with SMTP id
 4fb4d7f45d1cf-64077018349mr791179a12.22.1761860399068; Thu, 30 Oct 2025
 14:39:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251030105242.801528-1-mjguzik@gmail.com> <CAHk-=wj5o+BPgrUNase4tOuzbBMmiqyiYO9apO9Ou-M_M1-tKQ@mail.gmail.com>
 <CAGudoHG_WYnoqAYgN2P5LcjyT6r-vORgeAG2EHbHoH+A-PvDUA@mail.gmail.com> <CAHk-=wgGFUAPb7z5RzUq=jxRh2PO7yApd9ujMnC5OwXa-_e3Qw@mail.gmail.com>
In-Reply-To: <CAHk-=wgGFUAPb7z5RzUq=jxRh2PO7yApd9ujMnC5OwXa-_e3Qw@mail.gmail.com>
From: Mateusz Guzik <mjguzik@gmail.com>
Date: Thu, 30 Oct 2025 22:39:46 +0100
X-Gm-Features: AWmQ_blVgA3zdng1SUEMEnvVT1kzBIJqYiHPFrsa5zFQqVfW0RDEFbr-ecEITls
Message-ID: <CAGudoHH817CKv0ts4dO08j5FOfEAWtvoBeoT06KarjzOh_U6ug@mail.gmail.com>
Subject: Re: [PATCH v4] fs: hide names_cachep behind runtime access machinery
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, brauner@kernel.org, viro@zeniv.linux.org.uk, 
	jack@suse.cz, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	pfalcato@suse.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 30, 2025 at 7:07=E2=80=AFPM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> [ Adding Thomas, because he's been working on our x86 uaccess code,
> and I actually think we get this all wrong for access_ok() etc ]
>
> On Thu, 30 Oct 2025 at 09:35, Mateusz Guzik <mjguzik@gmail.com> wrote:
> >
> > I don't know if you are suggesting to make the entire thing fail to
> > compile if included for a module, or to transparently convert
> > runtime-optimized access into plain access.
> >
> > I presume the former.
>
> I think *including* it should be ok, because we have things like
> <asm/uaccess.h> - or your addition to <linux/fs.h> - that use it for
> core functionality that is then not supported for module use.
>
> Yeah, in a perfect world we'd have those things only in "internal"
> headers and people couldn't include them even by mistake, but that
> ends up being a pain.
>
> So I don't think your
>
> +#ifdef MODULE
> +#error "this functionality is not available for modules"
> +#endif
>
> model works, because I think it might be too painful to fix (but hey,
> maybe I'm wrong).
>

In my proposal the patch which messes with the namei cache address
would have the following in fs.h:
#ifndef MODULE
#include <asm/runtime-const.h>
#endif

As in, unless the kernel itself is being compiled, it would pretend
the runtime machinery does not even exist, which imo is preferable to
failing later at link time.

Then whatever functionality using runtime-const is straight up not
available and code insisting on providing something for modules anyway
is forced to provide an ifdefed implementation.

Ignoring the safety vs modules thing and back to the names_cachep
patch: the reported riscv build failure has proven problematic to fix.
Turns out mm.h includes mm_huge.h, which then includes fs.h(!). Adding
the runtime-const.h include into fs.h then results in compilation
failure on that platform as it depends on vmalloc-related symbols
which are only getting declared *after* fs.h gets included.

I tried to get rid of the fs.h inclusion in mm_huge.h, but that
uncovered a bunch of other build failures where code works only
because fs.h got sneaked in by someone else.

Given the level of bullshit here it may be it is just straight up
infeasible to include runtime-const.h in fs.h without major
rototoiling, which I'm not signing up for.

I wonder if it would make sense to bypass the problem by moving the
pathname handling routines to a different header -- might be useful in
its own right to slim down the kitchen sink that fs.h turned out to
be, but that's another bikeshed-y material.

I may end up just ditching this for the time being.

