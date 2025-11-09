Return-Path: <linux-kernel+bounces-892012-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E21AC44152
	for <lists+linux-kernel@lfdr.de>; Sun, 09 Nov 2025 16:10:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 34A184E1774
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Nov 2025 15:10:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 364152FE067;
	Sun,  9 Nov 2025 15:10:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e/HsiaUB"
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1CD41C84DC
	for <linux-kernel@vger.kernel.org>; Sun,  9 Nov 2025 15:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762701015; cv=none; b=pmbi5uBKCRZvpTYkBZ9kjsPhNhG18muLLXPphIZfX46fdBCXMlR8PNdqeBsh1ZWmOOysESefo7E688ovQh3NWu3JXMxNvC7yWlTQdiqPSJpa5uB8+IIGj1dkhrFxaUcTHMasClQAW1VWi0dP3niA7iw4PdGR5ClKVsicH/3DDDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762701015; c=relaxed/simple;
	bh=ic9oXRX/KaRVsd69aqaf21/OW+QO/vHVfurZJL7/ctw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lyAQbgYpl/nS1Gc7ZdNa8HymsXM4XfcmHzijUTbtpOukKKVrycc7aLLbm3z/PYd1nyrl1P/LwTj5wJBRY7Pa4e1L9jbjO6fqeCs6Ev1D013bs8+mSoRnTK0RBaU6l8FeCngu2i53hL8sc7YhRkt7tWVtptstLcP86NQ5H6BdcPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e/HsiaUB; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-786635a8ce4so17799237b3.2
        for <linux-kernel@vger.kernel.org>; Sun, 09 Nov 2025 07:10:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762701013; x=1763305813; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u4I+yONFaRC7fqexg8U+HT2nmVmnkhZMZygoSEaoWNA=;
        b=e/HsiaUBzpQ8ZizN48OcSziBxjMvUwrTqKDI+GmZ+CiU1feRVKDlH0BBr2wRla3yoU
         /9INLAgpujGzES74ToD6nJHAr9qg3rdUOhz36UNN7fv+MdMqrw4GraSTPGw+j641aaeo
         43SY3f3AGI8u/S9AemINxH069oxy/IcpeIslZdAQiQXdn8jzMCg0TDKLtX4W1eoLtJD1
         abfMmQ9ZgXXKCvf6XO4StJOSUU32nX83eT6fXBNiKtuLJ9WB4UCxydbqk1heMireIOr/
         AzTZili9whzLpQfHiLWtoAff1VIYGkvzxCnA6TraEf47h2bvgMjlQlb5V44bzSKXrSSY
         bz4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762701013; x=1763305813;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=u4I+yONFaRC7fqexg8U+HT2nmVmnkhZMZygoSEaoWNA=;
        b=Mg+pZrQHeqm6vcKn6+zreEc9bzNW4R6TssOU3sHXW4dFAFrKCFV7Ujb0KszxhLaYMZ
         HfvpnZ86cvB3MwkSvOouxzby55yTZMPV0xHgy93hYvKYX6xbqIRww8sZAMUYQj9mNa9q
         A1Ws/I+nXWp9Xn9xAkYnWR7Y9ihUZRe74zwpdH+q/+H/c8bhmO2vW7aUcHpVqSOse18h
         M/eQlkdtmQ9szwLLnZPPSdCzARc/Mz9YCkop/0THibdGkrcYfotX1Y+HcBF3ET+adDVD
         b+Pw4LAymV5Bh/JfY1VpPrftYkeq2WM/IJWMdXk0WJVYMkZP5WN28BftPYyNGRwkrX5O
         WvNw==
X-Gm-Message-State: AOJu0YzEOI4zpA7HsfXbYsyRd5MY8rRQWZ4OyzRHRLsE3Ey8teljzQST
	KJ7EOR+chB+Zl6ni7l0/+3jQ3iF4S0ZSasbfxvUT9NfBkqdxsL9N2JdHnlhy0QD7mI3TuIZ/6NQ
	/6o739ch8vDDlaKGASSTi1A2rkvSeNu96kw==
X-Gm-Gg: ASbGnctCdUeoD3cepTS1X+2/zhrIpMck+ffg3P6/TKkSE+iolOHhFhot3sY2bBjTcIO
	Fe3hSG9SFPjzRX8O5Flw8V7TfYJ72S3BZV+jsMe9pF0SBdOokDwewiHwvHQzWW0ZHR0bM6dnS9s
	l104WF2/CiXlJnt3k8lsKCL84JEw7R7DxsjdL8S431bBClCg6QYNIVIuhn8tp/xO+r7uUkGVOww
	ndPK+rLRZQK8jmD2ADDsFSTi8AeaCe1gK44+MMYBjrA4EDcs/q9vbWHVZOb+uhxd6Wv
X-Google-Smtp-Source: AGHT+IFrCC+krStX6Xak3OL09d3qv+5XNBkCTHr/2ekDDohIavTffFiQtNf8VsP8fPJQ78+gajdQ32WsyxAjKR1Hfpc=
X-Received: by 2002:a05:690c:4a13:b0:786:56f9:215c with SMTP id
 00721157ae682-787d53a1b45mr52211077b3.29.1762701012916; Sun, 09 Nov 2025
 07:10:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251108234725.1650246-1-jim.cromie@gmail.com> <cc0edf9cf2ee40bc13eec609eec5686de4f9f77f.camel@perches.com>
In-Reply-To: <cc0edf9cf2ee40bc13eec609eec5686de4f9f77f.camel@perches.com>
From: jim.cromie@gmail.com
Date: Sun, 9 Nov 2025 08:09:47 -0700
X-Gm-Features: AWmQ_bknW3FxvV6C9ro0e5jn6Y9errQ2pAZyn-OOQnuuXVHVbd4yglkjOXtBTkU
Message-ID: <CAJfuBxxfr3EgUB1cPDC_PXB0qVhrtDL330EmtTFeEbF=t8Wv5w@mail.gmail.com>
Subject: Re: [PATCH 1/1] checkpatch: add MA_STATE to declaration_macros
To: Joe Perches <joe@perches.com>
Cc: linux-kernel@vger.kernel.org, akpm@linuxfoundation.org, 
	kernel test robot <lkp@intel.com>, Andy Whitcroft <apw@canonical.com>, 
	Dwaipayan Ray <dwaipayanray1@gmail.com>, Lukas Bulwahn <lukas.bulwahn@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 8, 2025 at 5:52=E2=80=AFPM Joe Perches <joe@perches.com> wrote:
>
> On Sat, 2025-11-08 at 16:47 -0700, Jim Cromie wrote:
> > MA_STATE is used repeatedly as a declaration, add it to the list.
>
> OK but
>
> > I left out the $Storage regex component, since I saw no cases wanting
> > it, via: $> grep -r -B1 '\bMA_STATE' .
> >
> > This change fixes the following, reproduced locally.
>
> No following ?

the oe-kbuild report followed, but the link didnt work right..

>
> And I looked at the MA_STATE macro definition that has
> several NULL or zero unnecessary member initializations
> but doesn't initialize the entire structure as all
> non-named members are NULL or zero by default.
>
> I wonder if the unnecessary NULL/0 initializations there
> could actually increase the object size.
>
> With gcc 15.2.1 allyesconfig & defconfig do not change
> either way but I don't know if all supported versions
> minimize the initialization properly.
>
> > Reported-by: kernel test robot <lkp@intel.com>
> > Closes: https://lore.kernel.org/oe-kbuild-all/202511071306.OJpTf7fK-lkp=
@intel.com/
>
> This Closes: url is not found on lore

That is weird.
when I follow the Closes link, I get something unexpected - a "not
found - look here maybe",
AND a ../oe-kbuild/ link -
clicking that takes me to the report proper.

If you retry, you can edit the "-all" out of the URL and it works.

It sounds like a small bug somewhere in the lkp-robot CI chain.


>
> >
> > Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
> > ---
> >  scripts/checkpatch.pl | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> > index e722dd6fa8ef..4b5e2e64dece 100755
> > --- a/scripts/checkpatch.pl
> > +++ b/scripts/checkpatch.pl
> > @@ -1096,7 +1096,8 @@ our $declaration_macros =3D qr{(?x:
> >       (?:$Storage\s+)?(?:[A-Z_][A-Z0-9]*_){0,2}(?:DEFINE|DECLARE)(?:_[A=
-Z0-9]+){1,6}\s*\(|
> >       (?:$Storage\s+)?[HLP]?LIST_HEAD\s*\(|
> >       (?:SKCIPHER_REQUEST|SHASH_DESC|AHASH_REQUEST)_ON_STACK\s*\(|
> > -     (?:$Storage\s+)?(?:XA_STATE|XA_STATE_ORDER)\s*\(
> > +     (?:$Storage\s+)?(?:XA_STATE|XA_STATE_ORDER)\s*\(|
> > +     (?:MA_STATE)\s*\(
> >  )};
> >
> >  our %allow_repeated_words =3D (

