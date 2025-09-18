Return-Path: <linux-kernel+bounces-823006-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EACAB8543C
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 16:34:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 026DEB610B7
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 14:32:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE7F230BB85;
	Thu, 18 Sep 2025 14:34:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b="g0SBWDS3"
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4892930B531
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 14:34:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758206050; cv=none; b=QZhG/yH7sWk448hrAMrpmc4uT2vxBzfH+qkGFxLQn898Vi8aaZDXzxJYVspw1O6mCOpvPVX3k35+VP5PQ3TobD6DGaRTtLT4RilhThX8+bnIhKgU7H7DzU/d+VFvWkc1qkTOqsAVew9nETNlD3GvWIjt/8n+9ivsIST0K5sS3Qw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758206050; c=relaxed/simple;
	bh=MBfiJfn6GCPk8lGYQ1D2ow124fRDtcVPcMxVyyku0+E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jkceFp6KgE4nRh3X26dtIWfzoY2q5MABunTTRVyzlNJW9cm1AFHwNLYbhVy+LwftcE9LuSFN7RP2K99YMGZRSR0ZZj67SqCLXwcTsZDdNWXqFjGPBRuOU1aggxeSrupTqaHtCHcXBrzmLGn0NsQoBRt//MmApkslwQ7c5X7VdpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b=g0SBWDS3; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-72e565bf2f0so9383907b3.3
        for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 07:34:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20230601.gappssmtp.com; s=20230601; t=1758206047; x=1758810847; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GsFstqf0aPKFXQULvb/QA1W20AW77hE7rNx0BoX95nc=;
        b=g0SBWDS3KNE3knQzwDADEy3vy1KeVHCheOOeHyRfNx9LEKnhLmqBR079sM8IKiWu8X
         xsMcRxsaI2RIp25zYHvy3Xk3oKADObmG5M9cGbv3lEp9qJWT8f9joOxcJGX8AzUK7YxZ
         /1n5z58JuaUscSSn4YPSwtAJPCRP8SAvtEdfaj1bNt+Vm9r0k9wfj8DV9xZvR0rU4Gjp
         JPHBvuqDYzI9VbRgX/UfOdX6wNpmz6vYCuVzrCD0gRgTPptFYsAztc8q12A6rwtokY+W
         sROHRmSqmQmMtMMuK6RKx1HxElOhQV7U2X5mUWomefRlStzD78BzVSxTalJA1mhFs1qO
         mSTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758206047; x=1758810847;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GsFstqf0aPKFXQULvb/QA1W20AW77hE7rNx0BoX95nc=;
        b=C1WGvzDylbpmJrJC1kJHU/yhBoFu2Pt+8Qg6c1VWOLmrTTGXdfZqWgIcC4a/BJSk24
         Jt+qpocEw9cV9kvm7EiC7DK8q1OKPyKrvvT0uhLr4ilv37I/AXfXn3keunoRQM0Fz4iC
         NGMCzYVO8UQn5Qfngjy9FAPmzmqK+oA7iCqf0wxW/s5phdhHQ1N+xbxdaELfSMC9eS+S
         L0Mej5OigealWN5qJoeLe3+Xp1Oa7c0p4gHYjIhzM9NzJx9kg6M278pqk/fFFCDVxpMN
         DDo2ep5ZLydA/tiIo6lBwP11exMEgKYUm/Lg/KNUyASHcoJU5WE/HDnUaUbksYs65V+M
         VRiA==
X-Forwarded-Encrypted: i=1; AJvYcCUQffTyDJyDqAKtqmoeEwnJKw/mthN877EdXjpCQboyGHRGbt9WftNawJ+8kmD6RfgnCt0dHDOM1PRU6kI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzAwamAb6ByEx7a9jkyAzUKL9ONgpLjA+ry3uBuZRKfky4rOKh2
	os9RnCSquJZgtghoIB+8i7YgInmL76uq85dUpFMWjar5D+S46SoIlSTQOSl5dnG38XT//0sRhdT
	dYCPofzJLHqi7ucbmW7NzTAw6P7H0qYQDU0CtTTEM2Q==
X-Gm-Gg: ASbGncu9AhytLV6p0wTGgPBImzYTH3Nc3gh99bB80kUiDDuw9y12fhaG1qYnmA5U1g7
	L6V+UnGbYmPcPUbX0mHJ+8J1LmPsLR1f/AJ2QC46DJ8rzKrFwr3jhmDXlSRwz1fOBHeCMtDL8pJ
	8PR5EFZ86OIGAAoT9y6qxvFdPSCZDlTIRbjfqFP4JHj2maG5GzEHiKLEjwcX2/SIcrWCD18NxhH
	yJuQkF+9VCCaL2NTfo4nHtmbLi/zaw2r/HY5HuOS1/a8dd6edmQmOYUOQ==
X-Google-Smtp-Source: AGHT+IGGhIn8dGYcj5LaqtXCIoUBSX4wr/dd3ZmyZUAtSU0U2kK8GOGIRyt8aZK/8AqwjvXVn4MdC5tlBbzTORZV76A=
X-Received: by 2002:a05:690c:9:b0:721:64ec:bc65 with SMTP id
 00721157ae682-73892852d3bmr54486027b3.44.1758206047207; Thu, 18 Sep 2025
 07:34:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CA+G9fYsPcMfW-e_0_TRqu4cnwqOqYF3aJOeKUYk6Z4qRStdFvg@mail.gmail.com>
 <a07b0ebf-25e7-48ba-a1da-2c04fc0e027f@app.fastmail.com> <20250903165931.GA3288670@ax162>
 <CAH1PCMYWWkThMosDMW=wZZWZ8d_c4_zQWhJOJPKe354LPiV1bA@mail.gmail.com> <20250917182512.GA98086@ax162>
In-Reply-To: <20250917182512.GA98086@ax162>
From: Guodong Xu <guodong@riscstar.com>
Date: Thu, 18 Sep 2025 22:33:54 +0800
X-Gm-Features: AS18NWCkRCx-c09DhKbRjdrZJ83GwTW6_TUdgmfU5HjKCCFZgVCqB9ZOIxiAf5U
Message-ID: <CAH1PCMYoo_AqCXOH7--omBbmOyo6DSNgbF3DY-oPJHaYO4GaNQ@mail.gmail.com>
Subject: Re: next-20250903 x86_64 clang-20 allyesconfig mmp_pdma.c:1188:14:
 error: shift count >= width of type [-Werror,-Wshift-count-overflow]
To: Nathan Chancellor <nathan@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Naresh Kamboju <naresh.kamboju@linaro.org>, 
	clang-built-linux <llvm@lists.linux.dev>, open list <linux-kernel@vger.kernel.org>, 
	dmaengine@vger.kernel.org, lkft-triage@lists.linaro.org, 
	Linux Regressions <regressions@lists.linux.dev>, Vinod Koul <vkoul@kernel.org>, 
	Anders Roxell <anders.roxell@linaro.org>, Dan Carpenter <dan.carpenter@linaro.org>, 
	Benjamin Copeland <benjamin.copeland@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 18, 2025 at 2:25=E2=80=AFAM Nathan Chancellor <nathan@kernel.or=
g> wrote:
>
> Hi Guodong,
>
> On Thu, Sep 04, 2025 at 03:38:21PM +0800, Guodong Xu wrote:
> > On Thu, Sep 4, 2025 at 12:59=E2=80=AFAM Nathan Chancellor <nathan@kerne=
l.org> wrote:
> > >
> > > On Wed, Sep 03, 2025 at 02:04:10PM +0200, Arnd Bergmann wrote:
> > > > On Wed, Sep 3, 2025, at 12:08, Naresh Kamboju wrote:
> > > >
> > > > > Build error:
> > > > > drivers/dma/mmp_pdma.c:1188:14: error: shift count >=3D width of =
type
> > > > > [-Werror,-Wshift-count-overflow]
> > > > >  1188 |         .dma_mask =3D DMA_BIT_MASK(64),   /* force 64-bit=
 DMA
> > > > > addr capability */
> > > > >       |                     ^~~~~~~~~~~~~~~~
> > > > > include/linux/dma-mapping.h:73:54: note: expanded from macro 'DMA=
_BIT_MASK'
> > > > >    73 | #define DMA_BIT_MASK(n) (((n) =3D=3D 64) ? ~0ULL : ((1ULL=
<<(n))-1))
> > > > >       |                                                      ^ ~~=
~
> ...
> > Thanks, Arnd. I'll send a patch to clean up and simplify the logic.
>
> This error continues to break our -next builds. Have you submitted this
> patch yet? I searched lore.kernel.org and I did not find anything but I
> wanted to make sure I had not missed anything.
>
> Cheers,
> Nathan

Hi, Nathan

Yes, I just sent it out. Here is the link to the submission:
https://lore.kernel.org/all/20250918-mmp-pdma-simplify-dma-addressing-v1-1-=
5c2be2b85696@riscstar.com/

BR,
Guodong

