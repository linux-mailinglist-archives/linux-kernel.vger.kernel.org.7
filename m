Return-Path: <linux-kernel+bounces-752221-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C5B09B172AB
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 16:01:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E886F170956
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 14:01:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE18A1714C6;
	Thu, 31 Jul 2025 14:01:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XprNaRik"
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D7A242A87
	for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 14:00:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753970460; cv=none; b=q6QGDV2Bp4kjudFK8xJSuDplOueP4rDEONj7Y1FrILF7RV73+Z5AnDcKd23YfLOiY/EzIhcR1vCGRIRgi0q94F6UeM8LI4qycGJl7LMp9be5lTSTYEOYDbXGzYATycF7NUZY6/wImIac8wEZyFTtqZ3Xi5qEeh9IYKGvVTVYK/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753970460; c=relaxed/simple;
	bh=p4VeZrFlCqtVa7XoU54rtdRXo3wij4Swtu56Sdv5maI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oKGSdg02oiwX4JpFyyL229xfq9qb82Pmj9sRTUjddJruWcbK4Om89uNKxIxN17x30HDQ12WFbdxoz5/sdXKVqXc1vpCimIa82giiUCC2myapHQh7QpziYQKfXCtua8Q9ywWbNHlUrf765pLLN81rkaK/zH6+DNkkOlpCF3Q7OfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XprNaRik; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-31ec291f442so140807a91.1
        for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 07:00:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753970458; x=1754575258; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8157ZS3tYeHtH6rijRBK7OcIVWChQfvpSllS+EZouUI=;
        b=XprNaRik6W3tBLrqRa/8G7soIqS9lbuLF/Caaz6esN83jc85FX8tJ4ZcAGrhyoW/ut
         Inm45ScYkozFG3c6XH1SS4nDXGTCzZ8WMFWu4VV1c691pmyo7mOLRC2XRjof/n6fpJ3W
         iabF5PZYNcfwy4+dpXYL47W5PFsR4rXnekmzW1tEfdzlO8PoviOXAhsBaw4ZDmpNi6nC
         SycsgcyhFI2RAqLMCy+a9cIyx3SGuHtVIsA47D+/9ddGBRwUHAcPh326GtsRjKUPPjSf
         DUSqbZnv8LlTlIOQO8HtCZF8D6NwFcnUyOScaGOUYRscS+IUpK+pIosvwEs9BFy9mvmD
         AHfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753970458; x=1754575258;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8157ZS3tYeHtH6rijRBK7OcIVWChQfvpSllS+EZouUI=;
        b=n8Q1UkKcQxQGdMFDxM943rDMXNIz3gUJxIeo5pDBr033tIkWkoXjAPRWQ2q9I+JzNp
         ehRL0le8vDzq/YA1hIuXtnQFTQguv1uhRJabAgDeZcoAheuO0LqgmI11fYDDz22HPS5t
         +eC/C/rvVvWtUDc0qjKJaknIniliI+I57jI/WmNNRjGGNy/jtOiT3X5rvIAS7yiMVKUy
         sW5sEFmiQBXMwDeuGLu34BQ0XBLLCBhzKLeYHYzg3mTprcP5MHPfQAeAvnnMKLgUyvHo
         ZVH3vGJRb+akfFyiuPLWnti+fV4XlFU7rxW/Pq9MYfShbF5CbgJYNrDKaxGBUikSm9Na
         GW7A==
X-Forwarded-Encrypted: i=1; AJvYcCVuInKeEw6AeB5DVB7pLtqRN0djdT8C3KwTe17+qeKJptF1dz5rPsmKSxbGeV2KqOBwhZMA+M3yyxb8qoc=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywxw5DE98AQRcQt4hvlEA8UQCvupy+VlU+XrNdIcQqmpJH6KjE9
	ddaQtKEWe+QcZLiQaHTxeqIY3W5/IoPA8hmEse9hcqrb8drYpPhTzgRgl99kYvghRn6T4OY3kFW
	9KubDnK9WlbeNb4N1lUkg2RhmSSGJmyE=
X-Gm-Gg: ASbGnct++1awE/fG+2zzJZ131NJgqF/JhrEFtyFtx+QBwbNErEIEjsf2hcR6iyowB6u
	FGja+upOVnoaNQplMrAKcMiegCtVmXTPtGUo4P3CAMZ7v5gQr5/r2JS96t40368cRekWsXeXnvH
	gdHVTzSmYyv2wkjSx5cmM6ETeRsbnF+Jsq94xfqkLeMfsuOSliXAdev6AcDw9rHsQi76tBglDJK
	zkDddvx
X-Google-Smtp-Source: AGHT+IHmeHWZpcZnnZ3kXgdMZ5YyCy7CsMUcHBLKicsRETzXtCN9pdf52HCE2POOb92QpUFR8CCNPcVZOGClLpCOnww=
X-Received: by 2002:a17:90b:1d88:b0:312:e9d:4001 with SMTP id
 98e67ed59e1d1-31f5de88251mr1992896a91.8.1753970458039; Thu, 31 Jul 2025
 07:00:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAPM=9tzVm80-v6_5nt6kko3nR+aQLZ7R98i419FV8f4-ayQWUw@mail.gmail.com>
 <CAHk-=wirxHy+KU6jmtO2dzmGQ1BwaOdd5Mjtrc40fGvZVULQQg@mail.gmail.com>
 <CAHk-=wjn5Pg2Gp=o2NVv-nRKqE=E75AxUypWCCpQ7MDXuHx+YA@mail.gmail.com>
 <CAHk-=whnuRuQEky2GsCDRQSf1dZbpoqnK+puw=qdR-D7aap9SQ@mail.gmail.com>
 <CAPM=9tygJqtbmYzB5gktxp-7fBfv_9gNq9p9+SdZ6wiYE2-6PQ@mail.gmail.com>
 <CAHk-=whB1X1c6rWbY34wZVGcnaY=yfPGLOtjd5h3mMDGV9Lbkg@mail.gmail.com>
 <CAPM=9tyb1mELymOJv62KJom4mGF0UBifbVqLJUFdS1C7Eeu3jg@mail.gmail.com>
 <CAPM=9tzDWmYBKQGB0ybDzhYHkg0p98_6PJA8OuPahRep8+QPvQ@mail.gmail.com>
 <CAHk-=whOb_ebQQbnXeqb8uXf32WA32nrL3=HQ2y8hBm9hFgVOw@mail.gmail.com>
 <CAHk-=wh+79KkMXsNqyPxeU+c5U2h-n13ko6J_QzwtjyYCKhrSw@mail.gmail.com>
 <CAHk-=wgEGn0azq0n5BfWg4ZStrZYanLCX1a+quug7HKmjimhpw@mail.gmail.com> <CADnq5_NBM1Kso==+N=1xCjF+xiS7Vy4g47uvUN7sSWs8bontZQ@mail.gmail.com>
In-Reply-To: <CADnq5_NBM1Kso==+N=1xCjF+xiS7Vy4g47uvUN7sSWs8bontZQ@mail.gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 31 Jul 2025 10:00:45 -0400
X-Gm-Features: Ac12FXxuuoZ1YWI8UmgU_FrhbQ3mMkgX2KF3Bcm21SS1tJ08teC8t0_OYzwfXfM
Message-ID: <CADnq5_MWxd7WHi6=aY2ckHNOvRvT1e_rDPU_0xEma1cbaGa2Yg@mail.gmail.com>
Subject: Re: [git pull] drm for 6.17-rc1
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Dave Airlie <airlied@gmail.com>, Dillon Varone <dillon.varone@amd.com>, 
	Ivan Lipski <ivan.lipski@amd.com>, Daniel Wheeler <daniel.wheeler@amd.com>, 
	Alex Deucher <alexander.deucher@amd.com>, Wenjing Liu <wenjing.liu@amd.com>, 
	Simona Vetter <simona@ffwll.ch>, dri-devel <dri-devel@lists.freedesktop.org>, 
	LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 31, 2025 at 9:09=E2=80=AFAM Alex Deucher <alexdeucher@gmail.com=
> wrote:
>
> On Thu, Jul 31, 2025 at 3:03=E2=80=AFAM Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> >
> > On Wed, 30 Jul 2025 at 21:58, Linus Torvalds
> > <torvalds@linux-foundation.org> wrote:
> > >
> > > d7b618bc41ee3d44c070212dff93949702ede997 is the first bad commit
> > >     drm/amd/display: Refactor DSC cap calculations
> > >
> > > Let me go see how painful it is to just revert it from top-of-tree.
> >
> > So with that reverted (didn't require a lot of fixing, only minor
> > unrelated context added nearby later), current top-of-tree works for
> > me again.
> >
> > The revert I used for testing attached just so people can see exactly
> > what I did.
> >
> > It's late here, I wasn't getting any more work done today anyway, so
> > I'll leave it like this for now.
> >
> > I can continue to do the merge window with this revert purely local
> > for a while, so if somebody comes up with a proper fix, I can test
> > that out.
>
> I think it may be fixed here:
> https://patchwork.freedesktop.org/patch/663973/

That patch is in my fixes branch that I was just about to send to Dave
and Simona.

Alex

>
> Alex
>
> >
> >             Linus

