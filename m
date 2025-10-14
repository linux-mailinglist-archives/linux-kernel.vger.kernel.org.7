Return-Path: <linux-kernel+bounces-853104-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 999B0BDAA68
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 18:39:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AD4EE3B5306
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 16:39:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6343302CA0;
	Tue, 14 Oct 2025 16:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="xnFLv0Jj"
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48F2730170F
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 16:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760459949; cv=none; b=fegXG4YPLcIle3Fs+fM3bUdV8nWC9DZDwjplWvzT+8g4eJwLIQqp/DF2c9e6h+N2lPXsOoXwOS0rrFxY3QtpTObH4A8tl8otsF/eP85ddvvTIr/3BpLGMWjRSy+sh7gaBzWR1WYntskv53RPeOWiPyoiGsc92YuoNr3KI6k9AU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760459949; c=relaxed/simple;
	bh=KIdcjicU1xkhUuZ7lS5rBFgv0PumoAcegzgFThh+RDU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fq4YQNCOl/710d4uAjHzrI8co/grO1E+a6gsdnaxVv3LiqicASEbBFRnaFs1+UxivYX1EfvzdXz5w7bZRqXvifRRx/DOeyMUHfMZZVHs46k3o53bv77O0M7QnieC5P9j43FyzgycesZ1tTowWyh/NwbtHnfxjjocvrh/jTaQOl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=xnFLv0Jj; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-b3c2db014easo219246966b.0
        for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 09:39:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760459945; x=1761064745; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3m2YZNN0UigJ9JbMENObnZrolpEs9nwRN25izP8uaiU=;
        b=xnFLv0Jjwr0Msthulxk/3VfLVJoJ3QzY5l6+Uvt0xLIyciw7qa5d5MOrlXBEN7LS/J
         vqTIOj2kES0c38/FgaglYCXIaXtmx0V+kN9KDJ7Rm7zI9Pr7FJ8OYwN0PPmxTsvuLOJv
         wdLiLvM+NFMBSFqJEPk02ngy5oIIfGvHAS2R81sGy2upROqTnJR+uUGjNWkUtS+u4Ws/
         IF/18/4B6yZjTi4Zt5vfzTbwSdTmqFGmuO/IAjtL6xCNvNxUh+RWWg6MnMkPRimJfZ6x
         SfPRDLzy6CedsczUDKvdJWE6a45alB9Hl2s3ZBYmKRhl75mU9851oBe5jkdNY0DkBWjo
         tT0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760459945; x=1761064745;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3m2YZNN0UigJ9JbMENObnZrolpEs9nwRN25izP8uaiU=;
        b=OzdhK+S2ADm6rjvfuURC40eov/+1BVadCm4700CNtOXsi6CvpoHjCuZ4138Y107pHs
         3ACgGWdtj0EiUmEOJUIrlq8X1HJJ4MWSNoEi7R6OKeo7GtDuHd6pLDnMAObs1we5COgo
         D479QAdhmxB/XPLgeMa8P4VV042VrWLQcOkNzr5WdsZt24+1F0M9xlY4PuEBG3Y/yrtO
         LMB1vbaO089fVxgEdkLEHGzJ1GtV2FEMW7Fo2yDii6tOjpS27KM6eJapO2Z2+TZnKEYz
         RfaE+v6Ef7YUqNgUi/tEr89KaMtFZny3Q42EctSQANPhtFYKjZBL3OTaI6mepYo7JAiI
         DCCA==
X-Forwarded-Encrypted: i=1; AJvYcCUr/SWDa4qmkQA1KcNjcLgoA93PvF2M6udOXwC4Jw4CAIjh3bKrglJZWb+ItPucWFEHHw3mS1NjafRxWto=@vger.kernel.org
X-Gm-Message-State: AOJu0YxS5KWaB6XyvS29fdHh4G11oz+VKDYrdcYPqt5XccQrWLzCReIo
	6ns3OrH8fKbVLgTpWQfUAcSezCsHuSx5v7C6g6rsU/OaKx07j1uCl3xL7pWK0AJ1zA/cLRZfuIa
	GkCzY02btvuKnKyah9g886F5Bwq7TvDti5JrvyCE=
X-Gm-Gg: ASbGnctnGT1TPwMlJkwv/YPNG4p3qG/mxKh1RgX3c8GwLHGsyh4sGaVodpw6g4IDiAT
	aV6J0UNQu3VJC/pGXRdFarfceakR3aL8oiBi8EDbpTwRIFoxD0/l/4nbBYGhVYNj6mm/XY9ykoS
	y7dI6XChQShrl22AinvJCjXKKhY+nwNwsX7vlwrcSJtqPkthCOGN/6msIIp3jg5FllH9t8LL2DZ
	FuFr/v3ukAjKUofRpUhiyk+v26xKA==
X-Google-Smtp-Source: AGHT+IF5iAWr07Jq9Ca0FW/cfj1AC3c/D4Vx4woo9Rt7MaT1D0cjoFs6PinKWLKqi6oFaEipagDkNxatkgT/Lv7pwD4=
X-Received: by 2002:a17:906:f584:b0:b43:b7ec:b8a1 with SMTP id
 a640c23a62f3a-b50aa38724bmr2732549066b.24.1760459945266; Tue, 14 Oct 2025
 09:39:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241028141955.639633-1-arnd@kernel.org> <Zx-ndBo7wpYSHWPK@casper.infradead.org>
 <ef98d985-6153-416d-9d5e-9a8a8595461a@app.fastmail.com> <20241029043328.GB3213@mit.edu>
 <CANDhNCpsoPcotnrjH6y0yEBf43652DRasSsEnAyEbrKN=tjEfQ@mail.gmail.com> <20251014143916.GA569133@mit.edu>
In-Reply-To: <20251014143916.GA569133@mit.edu>
From: John Stultz <jstultz@google.com>
Date: Tue, 14 Oct 2025 09:38:52 -0700
X-Gm-Features: AS18NWBEWkQuvz6RJmkj-jqOBSb01FLnoGovGoVGZcfxO-4ryZ13MTK-KtFB3l8
Message-ID: <CANDhNCp=06eNkOqNX2dFrnYhpZX0xsEd06U1xCwORk1mwt=MCw@mail.gmail.com>
Subject: Re: ecryptfs is unmaintained and untested
To: "Theodore Ts'o" <tytso@mit.edu>
Cc: Arnd Bergmann <arnd@arndb.de>, Matthew Wilcox <willy@infradead.org>, Arnd Bergmann <arnd@kernel.org>, 
	Tyler Hicks <code@tyhicks.com>, Damien Le Moal <damien.lemoal@opensource.wdc.com>, 
	ecryptfs@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 14, 2025 at 7:39=E2=80=AFAM Theodore Ts'o <tytso@mit.edu> wrote=
:
> On Mon, Oct 13, 2025 at 11:07:56PM -0700, John Stultz wrote:
> >
> > Yeah. Sadly I'm one, as I needed something to migrate off of when
> > encfs was deprecated.
> >
> > Is there another soon-to-be-deprecated filesystem to encrypt
> > directories I should move to? :)
>
> Well, the closest way of encrypting directories is fscrypt.  The good
> news is that it works on top of btrfs, ext4, f2fs, and ubifs, and it's
> not likely to be deprecated given that it is used by chromeos and
> android.  The bad news is that the integration with traditional Linux
> desktop setups (e.g., login, etc.) was never completed.

Yeah, though to my understanding fscrypt complicates backing up the
data in its encrypted form.
Having the fuse/overlay encryption approaches is nice because you can
just backup the underlying filesystem layer and ignore the overlay
mount.

> This is probably because for many desktop and server configurations,
> using dm-crypt is actually better suited and more secure.  It
> certainly doesn't solve the "just encrypt a directory hierarchy in a
> file system" and the "support multiple users' who might have different
> encryption keys and which are mutually suspicious" use cases.  But
> this appears to not be sufficiently interesting for distributions to
> do that integration work.

Mostly I avoid dm-crypt for personal files as I want the majority of
things (family pictures, etc) to be as simply recoverable as possible.
It's only for a small amount of things like email archives and
tax/financial documents that I'd like to have it be non-trivial to
access if my backup drive or desktop was stolen.

I've wondered if maybe something as simple as fuse mounting a password
protected zip file would do, but I'm guessing something a little more
modern like a fuse + age approach would be better. Unfortunately I'm
not finding anything so far.

thanks
-john

