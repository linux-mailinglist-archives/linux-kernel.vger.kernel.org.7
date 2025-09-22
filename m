Return-Path: <linux-kernel+bounces-826969-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C09C2B8FC15
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 11:29:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 68C7217F806
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 09:29:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59C97286D70;
	Mon, 22 Sep 2025 09:29:45 +0000 (UTC)
Received: from mail-ua1-f42.google.com (mail-ua1-f42.google.com [209.85.222.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55C5C283FDB
	for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 09:29:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758533384; cv=none; b=MeaP3XwAAn/sXONPpCRcFrv+PYxBRd5FF07PCfGx2NXcwduE2ZjT6YMZUd4aYt/gcMnv92Lzs0udZL3RHfDSKBheg5199YZA9v++f7836VTE9CEU+hXMnSQzeHmR0DGQc06k5qz6PxCk05v8ICcYWvtZfi19jhtrRMDIJRs+5K0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758533384; c=relaxed/simple;
	bh=gxid6d73FASpgj+Dbo6qkKXdo6ItVd1h5REmlU4F6PE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tiXoBu72ZkjV5XVZBf8bgksmBfhPhQT8BKgNlNA3zRiVxWmW73OCls0LCecTOasEEatzPWIC3tCM4ztpXgZQKxXbph3fj4l5Pl67y4/BC9esrTkgKaBUQcyhd7aTDDYhpXwjmTaMreCFLQwxzEj0ibaNFm9KxcorX4bgrtanOzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f42.google.com with SMTP id a1e0cc1a2514c-8fea25727a9so112322241.1
        for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 02:29:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758533382; x=1759138182;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ebw4sp1U8DsoLtMGrD53MUAXHrZ/k+nhfitncmC356Q=;
        b=UyLgSoRnCXEB+HDtG0gAGERodVonS3aYoIq03g5nUkd3yxdJGTEtOHUWbY5iMQ+UYz
         l8cd1xWlGq4E9UYttrdXbdbQCtlkPO2ZstGYb+O0mC4EdRji4+VUCeDEnBJpu32/CDfo
         +EgyIF9zqliRz5136Srj1eVkRXfhjdjvpds5uYZ7EH8tYmoTXq7tXNkehSECnqXVDBjN
         3U3Xc8hrD5/A/S2k0HgKOZHN4QUR1qIlXkYzw+CVXNSOEpTBsFpw6OEDDkJgmndXRHGb
         UkhPz9JvXYhtJN4lMiaLAiXWTNRyLT4tbhQN1JCtdlVGHQ0HdCnBuDUSorSByb1wZ1O1
         AMvA==
X-Forwarded-Encrypted: i=1; AJvYcCXwV9LD9UzhRysD4sBTYgujj8DbYsgJQiO9WMs6qCEXTrvxh+tXI+y5f03RCEWYkk/R802GmamV6KQAavY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyAeWcZTf1iv7GPWsV4201R6KcykykoE9HxUUdnzq3M3IB3AtDw
	MRQ4rS9PEkDMOG7xUrLrLoe4rDvUb4245wpaey/B1NiugIy6c90ANuHDeYzRpSAQ
X-Gm-Gg: ASbGncvBhKOh9iag4CfYL8gA8vIJBiL0N3yrTPeSZUQRwDu9egl9tXD+lPG2usuGieh
	pOwCzcW0iarEUSABXGsIpQvvEuyRsM19fQ5mRDVj5a8oVUDhjta5UG5xYhIhb/Xt9s4nDMbbd1x
	blQ41K99nhcy6HK21KOhdJ5BwRXpoy7kuWZaJbpEip7btzjPFIqux5dPcmDHSLuKj9y+RWdE0ni
	iKbwfiU7TxCuXXJVy1ir+WempWgPk2Z3Vv3rTYgUR1559RqdANDPhiDViXWD81MG+QkH2FtskF1
	TbNdFHAt99ROJ3YzEuZPnm07dJB1GIdiD1TjFFf6bQ8h1R8S6Ly1Rv9OUl5dZKWxaX+thj4l0tH
	efhKhSqRSJC9pYGw7uUIXbvGXk53k7zBPSJU8Sh2bAd9iDjIEO4tSq9LMblPH
X-Google-Smtp-Source: AGHT+IG8zW5SlZ61zL0ZoePs+NySyvPOtigg9DJqPnD4vByITN6d9uiFkbPz8+jkJDy/2bbLJIFONw==
X-Received: by 2002:a05:6102:3e1b:b0:4ec:c4f8:c4d3 with SMTP id ada2fe7eead31-588d388e0f5mr2648909137.5.1758533381978;
        Mon, 22 Sep 2025 02:29:41 -0700 (PDT)
Received: from mail-vs1-f42.google.com (mail-vs1-f42.google.com. [209.85.217.42])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-8fba10c5a57sm622565241.0.2025.09.22.02.29.41
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Sep 2025 02:29:41 -0700 (PDT)
Received: by mail-vs1-f42.google.com with SMTP id ada2fe7eead31-5838680e242so1213630137.0
        for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 02:29:41 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCX/fsCoMkzVTYUWlTUByyetEV7mM7BEK8Gf7kNyhtTUUYPU+kt8WT6twz/qSlflnqEOIwlZV6j1jo9SJpM=@vger.kernel.org
X-Received: by 2002:a05:6102:c08:b0:522:255d:4d19 with SMTP id
 ada2fe7eead31-588eb292bb9mr3073422137.23.1758533380886; Mon, 22 Sep 2025
 02:29:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1757810729.git.fthain@linux-m68k.org> <abf2bf114abfc171294895b63cd00af475350dba.1757810729.git.fthain@linux-m68k.org>
 <CAMuHMdUgkVYyUvc85_P9TyTM5f-=mC=+X=vtCWN45EMPqF7iMg@mail.gmail.com> <6c295a4e-4d18-a004-5db8-db2e57afc957@linux-m68k.org>
In-Reply-To: <6c295a4e-4d18-a004-5db8-db2e57afc957@linux-m68k.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 22 Sep 2025 11:29:29 +0200
X-Gmail-Original-Message-ID: <CAMuHMdW-AG-NeGZKuVy1e=TGKN895F2eHEzkjJeaGvAADv-vOQ@mail.gmail.com>
X-Gm-Features: AS18NWDKBc4eQCJYFdlrfn6McdPM_5-5yG-PRssau5_dGdaYxg2W9cfnnLuZ5PU
Message-ID: <CAMuHMdW-AG-NeGZKuVy1e=TGKN895F2eHEzkjJeaGvAADv-vOQ@mail.gmail.com>
Subject: Re: [RFC v2 2/3] atomic: Specify alignment for atomic_t and atomic64_t
To: Finn Thain <fthain@linux-m68k.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Will Deacon <will@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Boqun Feng <boqun.feng@gmail.com>, 
	Jonathan Corbet <corbet@lwn.net>, Mark Rutland <mark.rutland@arm.com>, Arnd Bergmann <arnd@arndb.de>, 
	linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, 
	linux-m68k@vger.kernel.org, Lance Yang <lance.yang@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Finn,

On Mon, 22 Sept 2025 at 10:16, Finn Thain <fthain@linux-m68k.org> wrote:
> On Mon, 22 Sep 2025, Geert Uytterhoeven wrote:
> > This triggers a failure in kernel/bpf/rqspinlock.c:
> >
> > kernel/bpf/rqspinlock.c: In function =E2=80=98bpf_res_spin_lock=E2=80=
=99:
> > include/linux/compiler_types.h:572:45: error: call to
> > =E2=80=98__compiletime_assert_397=E2=80=99 declared with attribute erro=
r: BUILD_BUG_ON
> > failed: __alignof__(rqspinlock_t) !=3D __alignof__(struct
> > bpf_res_spin_lock)
> >   572 |         _compiletime_assert(condition, msg,
> > __compiletime_assert_, __COUNTER__)
> >       |                                             ^
> > include/linux/compiler_types.h:553:25: note: in definition of macro
> > =E2=80=98__compiletime_assert=E2=80=99
> >   553 |                         prefix ## suffix();
> >          \
> >       |                         ^~~~~~
> > include/linux/compiler_types.h:572:9: note: in expansion of macro
> > =E2=80=98_compiletime_assert=E2=80=99
> >   572 |         _compiletime_assert(condition, msg,
> > __compiletime_assert_, __COUNTER__)
> >       |         ^~~~~~~~~~~~~~~~~~~
> > include/linux/build_bug.h:39:37: note: in expansion of macro
> > =E2=80=98compiletime_assert=E2=80=99
> >    39 | #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond),=
 msg)
> >       |                                     ^~~~~~~~~~~~~~~~~~
> > include/linux/build_bug.h:50:9: note: in expansion of macro =E2=80=98BU=
ILD_BUG_ON_MSG=E2=80=99
> >    50 |         BUILD_BUG_ON_MSG(condition, "BUILD_BUG_ON failed: " #co=
ndition)
> >       |         ^~~~~~~~~~~~~~~~
> > kernel/bpf/rqspinlock.c:695:9: note: in expansion of macro =E2=80=98BUI=
LD_BUG_ON=E2=80=99
> >   695 |         BUILD_BUG_ON(__alignof__(rqspinlock_t) !=3D
> > __alignof__(struct bpf_res_spin_lock));
> >       |         ^~~~~~~~~~~~
> >
> > I haven't investigated it yet.
>
> Yes, I noticed that also, after I started building with defconfigs.
> I pushed a new patch to my github repo.
>
> https://github.com/fthain/linux/tree/atomic_t

Thanks, the updated version fixes the issue.

Gr{oetje,eeting}s,

                        Geert

--=20
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
.org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds

