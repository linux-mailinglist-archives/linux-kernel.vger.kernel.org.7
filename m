Return-Path: <linux-kernel+bounces-877256-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D6445C1D94E
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 23:23:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C2AB04057B4
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 22:23:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7128131A059;
	Wed, 29 Oct 2025 22:23:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="d/Y8YxX1"
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBDD618FDBD
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 22:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761776606; cv=none; b=uzh6/3v0eAeH47HA3AR1LB2ipb1I6icrixsSJTdJjFO3ZcoJaXGglJ0cV4jWIQOL1A/RvPFIJPAqK4eWsIVu06X12eAUhpLXD0nxEilvrRt0YxsL7zSPWfC8uw+jGVcRJxcUrqBvrEH2AgQzJ+q9+7UMr2B3T4wPV+1P1Xjn32Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761776606; c=relaxed/simple;
	bh=0Y78CioIXcFYqCT7J2U6NFL9zXeL/myq9J1+6AArRCY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XlVpbfkKzDcqmhSyOcA882ohoN0GGt370+WUdDPQVZh3+LFrfVrKHWn5jCKpLwfT6eaah5bAQqcgA51KWyPi+eGBvxW9YABLp3wJcGkBJroTs01XoKiRygDqenO0BbcmVSmayCSdbpi70TBntQ9vlrbDL+3/I0KIFGmlI5cxrlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b=d/Y8YxX1; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-b6d3effe106so73636366b.2
        for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 15:23:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1761776603; x=1762381403; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gpv6Bu1gRrUbx52oNEm6LTdZ6YidJrARd+ghcU8tGMU=;
        b=d/Y8YxX1VAiOmpiGt3Ue0chFji5sf3GJonQNt5/XOkqwB20wHfYB6mEKMYe5tI792u
         6wDsIf2IuH6Hk7J0mF98aRquNvwi3u7OyO1kGnjg5tSa1ghm5RB/0gAAPJB+dT2efM7n
         mvqDhL8WUKoJNuCtE11MqByHdzA4wivQsgb8PvL0u0snM95mDS67G8zT1ct5YuCZ2634
         JuQnZB64xoi0nuz+1XNqOV2h5Zjve8VPtPcS3Cg7//evwQufRApn8q2AqCRbVFowO1JZ
         JRfs6iy2UWyYFgec/V/wPXw4S+f6EXZ2eDlQZAq2LiBjUa2khZhT7UCm6p+BIiZ2oWia
         EWMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761776603; x=1762381403;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gpv6Bu1gRrUbx52oNEm6LTdZ6YidJrARd+ghcU8tGMU=;
        b=QTvqDsqy+PxdZtEs2llN8SYUxSMzE+xepCl7quRlo00QI2+rVwimJAkZ4VhUq+PMVr
         4dacnJ/to31YAg4UvE1AY8aWfcnqAdZX9RffX2x5Z81DiadPHJKgUtyFCXrQz0BSv23C
         NMRbaBPb48+kb83O4285hzQKFQLTBErMsWtNwcJEw/o7YeQGBP4iLgxHWhNbtj6IsDpE
         zIjjD75CCTEVD3NWVxdhYN+yL/v6UUA2QEhcC+HjRRknHot+giS2x7WKVjNE93nMkEJH
         Xc4ImiuJOFgsRW0McXLQSQmGJ68Lpc2oQKq7eXamzLmamodAvejojPTunoJkIkZO72q/
         53AA==
X-Forwarded-Encrypted: i=1; AJvYcCXJrhTRNXgDaxb3+IhWzLpz4+aIbHxOF6JrsrFarv6bm1leMykp0asweUBb8dAcvh7jqNK2EmXcW+cA4iE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzLqB0wQIwgYz+EMxMfKrqcg/j47AhFJ+zOXQUDMiThygGAxLFT
	fYeK/ACcmkZIGJ98D58ZzhNoNE22H9py1piS2T/0fJn9/qJkNBnAggTBlsnWSV4qJMzfjviNFjN
	t7Ks6moDES7FfX70LWpDcrr+KkNdoUgSqalercAIivg==
X-Gm-Gg: ASbGncuTon1E7Il06WALYZhZqvcWIPe13qYkKQGq7i1Vurxj88hlEip3s/1QDtQPECI
	Ok+I/wuMcK0VIIyUQsUt6FnLM9dl4LW9lhmDC1qYl8rPc44ocn28XebmaYKNMmEj02KhC+2+DdO
	IdjyIDcJ4fWuu2EvMWmdQrqI5jXXN1ksN7Bbdvov2KWR9k1R45RhGS40QhvPOjFJkX3C8KoOQJF
	u0Wt3H/Hl9WWKVCmjEGcqamCzTcVuO4AmWZFSo5sxq69fdGkeW0ElTmF8Wcn5V2Kvug
X-Google-Smtp-Source: AGHT+IEGXWbi1zL2MYQq1jWo5fkcmj13mveE6SjemKqwCk4bOIMfIzJadEzaXl9lawQXtRHdx+HKvLwQpuN1CFTNwBw=
X-Received: by 2002:a17:907:7292:b0:b33:a2ef:c7 with SMTP id
 a640c23a62f3a-b703d5cb7efmr522068666b.55.1761776603191; Wed, 29 Oct 2025
 15:23:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251021000852.2924827-1-pasha.tatashin@soleen.com>
 <20251021000852.2924827-2-pasha.tatashin@soleen.com> <aQHUyyFtiNZhx8jo@kernel.org>
In-Reply-To: <aQHUyyFtiNZhx8jo@kernel.org>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Wed, 29 Oct 2025 18:22:46 -0400
X-Gm-Features: AWmQ_bmdWz_K-6x0FqPYXVy37hUITH8KVofabeFsr0NG2wwGh65pPSXncqtE7HQ
Message-ID: <CA+CK2bB=k6ZxeEuLC9Xwtzmgm5MZdpH2sRgk84WQVm4uoeHsVw@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] liveupdate: kho: warn and fail on metadata or
 preserved memory in scratch area
To: Mike Rapoport <rppt@kernel.org>
Cc: akpm@linux-foundation.org, brauner@kernel.org, corbet@lwn.net, 
	graf@amazon.com, jgg@ziepe.ca, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-mm@kvack.org, masahiroy@kernel.org, 
	ojeda@kernel.org, pratyush@kernel.org, rdunlap@infradead.org, tj@kernel.org, 
	jasonmiu@google.com, dmatlack@google.com, skhawaja@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

Would you like me to resend the series with the "+       depends on
KEXEC_HANDOVER" fix from Mike, or would you apply it into your tree
directly?

Thank you,
Pasha

On Wed, Oct 29, 2025 at 4:48=E2=80=AFAM Mike Rapoport <rppt@kernel.org> wro=
te:
>
> Hi Pasha,
>
> On Mon, Oct 20, 2025 at 08:08:50PM -0400, Pasha Tatashin wrote:
> > It is invalid for KHO metadata or preserved memory regions to be locate=
d
> > within the KHO scratch area, as this area is overwritten when the next
> > kernel is loaded, and used early in boot by the next kernel. This can
> > lead to memory corruption.
> >
> > Adds checks to kho_preserve_* and KHO's internal metadata allocators
> > (xa_load_or_alloc, new_chunk) to verify that the physical address of th=
e
> > memory does not overlap with any defined scratch region. If an overlap
> > is detected, the operation will fail and a WARN_ON is triggered. To
> > avoid performance overhead in production kernels, these checks are
> > enabled only when CONFIG_KEXEC_HANDOVER_DEBUG is selected.
> >
> > Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
> > ---
> >  kernel/Kconfig.kexec             |  9 ++++++
> >  kernel/Makefile                  |  1 +
> >  kernel/kexec_handover.c          | 53 ++++++++++++++++++++++----------
> >  kernel/kexec_handover_debug.c    | 25 +++++++++++++++
> >  kernel/kexec_handover_internal.h | 16 ++++++++++
> >  5 files changed, 87 insertions(+), 17 deletions(-)
> >  create mode 100644 kernel/kexec_handover_debug.c
> >  create mode 100644 kernel/kexec_handover_internal.h
> >
> > diff --git a/kernel/Kconfig.kexec b/kernel/Kconfig.kexec
> > index 422270d64820..c94d36b5fcd9 100644
> > --- a/kernel/Kconfig.kexec
> > +++ b/kernel/Kconfig.kexec
> > @@ -109,6 +109,15 @@ config KEXEC_HANDOVER
> >         to keep data or state alive across the kexec. For this to work,
> >         both source and target kernels need to have this option enabled=
.
> >
> > +config KEXEC_HANDOVER_DEBUG
> > +     bool "Enable Kexec Handover debug checks"
> > +     depends on KEXEC_HANDOVER_DEBUGFS
>
> I missed that in the earlier review, should be "depends on KEXEC_HANDOVER=
"
>
> @Andrew, can you please fold this into what's now commit 0e0faeffd144
> ("kho: warn and fail on metadata or preserved memory in scratch area")
>
> diff --git a/kernel/Kconfig.kexec b/kernel/Kconfig.kexec
> index c94d36b5fcd9..54e581072617 100644
> --- a/kernel/Kconfig.kexec
> +++ b/kernel/Kconfig.kexec
> @@ -111,7 +111,7 @@ config KEXEC_HANDOVER
>
>  config KEXEC_HANDOVER_DEBUG
>         bool "Enable Kexec Handover debug checks"
> -       depends on KEXEC_HANDOVER_DEBUGFS
> +       depends on KEXEC_HANDOVER
>         help
>           This option enables extra sanity checks for the Kexec Handover
>           subsystem. Since, KHO performance is crucial in live update
>
> > +     help
> > +       This option enables extra sanity checks for the Kexec Handover
> > +       subsystem. Since, KHO performance is crucial in live update
> > +       scenarios and the extra code might be adding overhead it is
> > +       only optionally enabled.
> > +
> >  config CRASH_DUMP
> >       bool "kernel crash dumps"
> >       default ARCH_DEFAULT_CRASH_DUMP
>
> --
> Sincerely yours,
> Mike.

