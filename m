Return-Path: <linux-kernel+bounces-757590-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DAEA9B1C3F8
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 12:00:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D52211872C9
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 10:00:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B59B321CC4E;
	Wed,  6 Aug 2025 09:59:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="I08+PJ8t"
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD0022882CB
	for <linux-kernel@vger.kernel.org>; Wed,  6 Aug 2025 09:59:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754474390; cv=none; b=WSfGP6/25HtVTZgZ62rzhnJWToZulomojVrr9GawhfaXVfU4+7YDPtzbKqIseDfOH/LXE/LWlY7+A20PLYaqqV4f7y7IxMiFQiV8mBkKnW4Mpa+qA7FbNo7xthorelZPQ7hALeqnv6gU2YbUo8TJg3SPebh0577GSMBEDCGo3QY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754474390; c=relaxed/simple;
	bh=YQgVMOo/sF5mWuCGJ5jBS5ET2/ABTB4szgnwvzWQk0k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bBq6yDqzq15NGhnfzLXxT9enmYZWwDQBSd/av8tihVyvED20KLi5W65qAu5A5hE0qfMPQX4vAG6ZR0z4FkRmYf91bf5BXPKzydA7BFW+E/xk1gZFf0NvUbZ/JRdm9Up9XE6nq9+TJ5MQC99MS1brJSXIHqRSyhiRanBYtvJICuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=I08+PJ8t; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-33253a73769so32709131fa.3
        for <linux-kernel@vger.kernel.org>; Wed, 06 Aug 2025 02:59:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1754474387; x=1755079187; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sAOW6ml3mToRpwXvdxnqACJOhESSTx6u7j8K1+IsIcI=;
        b=I08+PJ8tmQqx9BjRVZ593GmCHZUb5jyhdQoBigCf2CGMPJD0NEgH5qaWhMXSiMJkiH
         T2/eyXqz4nogqEV56IHMoIEh2L2GXHCc06KaJJ3BsSqm0geoPLFnFyz8Aq6mobgQGgHW
         Qt0K4mqNDE9vRQmOxhQ7W6OtWKfHpgbQOmr+cfgES+wnsYPpubUCRpcxn/3zfJ5iYdDe
         p9Zz4uIG1uOKFw+qx4w9FaT26yL1szHT+YWCyVBrunPWg6F/GHvOVHyIgU3b6oxfGZ/7
         aEYW0s6v3ZvolU/EPMBTRk450NQ+fwNSC4+sjrk2q6SiWa+EONr/kjcWyC27QXyOGGt/
         WHnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754474387; x=1755079187;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sAOW6ml3mToRpwXvdxnqACJOhESSTx6u7j8K1+IsIcI=;
        b=oiJx4VXkHKlPhIvEdDfk+Ks0SyG/pyOBaJwDl8yKEP5fU0JducT/sgp/nTmvsTOrem
         GWBkZZdox/O3er0MO9aXdeYMQ3c0b4Orr35wjFT2cj8fDDxWzEoKl+rZUmj9FYam8itX
         Oc4Mvp31mdSnWitSzOIqdJzzSzLcn9pZWoTVTTguzifdXj/AkD6Lkm+JxrHY1eMuUHIA
         C9P5j7BfdlYS9xA5DS9C3OQfnrposbplW8Ha26lsRtpHJqm86Qx7MUjr009VbbbL3e6u
         NzTUae4e/D+VaqERHqZqD5RNFlrZ2KWYB2kxalLLl8yvY0QLAJoU9VUl+3aCaExrSH2W
         cTEQ==
X-Forwarded-Encrypted: i=1; AJvYcCVQoFP3JmfXE4M7QhS0rKEcr1gl+OnhwsapUo4Lca1Jn9dihq74K1Le+NguZc5mgE6VaeqTdp2w+wkF6EA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzDd/yMpKlhxDaUCcw8OY0jHa9pRy5c6bIUYBzUbf4/HoZbRkkC
	6TA9c3tP0XN90s+/nsaPOwmi60fFHGlbtcak3FAcfGgjJsH+XISU6cYVWWLEuoKByOgLHfpB0Ij
	Tw+QItwyA9TPBsOnkpVlIFPDnzl9E0EQMID48mLIV
X-Gm-Gg: ASbGncsI0LCv6K2NgFmoDCwJPA5NvEVzOOsenptWCgfXIR52KN7m3pklLX/zTZR1rJH
	mUz3nB9P8EnrvvtLf9b7f0XF4WJxpuZ33mtYHL7KBbe7chor3NOiXrJz7rnYeNukJsw9aaI/Ccb
	leSHeIDFCT2Kggp6Cj3Nrh4mAWqXJ0nVEUxWPuoehZfHPfwmZXp6N4Y+e/ambY/mgcJ5jd0Ylxt
	zW2VR9vBbSS9n1DydpLhXw5rJD5j8HS5NcsdBBU
X-Google-Smtp-Source: AGHT+IHAcgY7QkdhxjryMr5c1QCeMolGErRgl5fK3qdVGu5nIq774XnQ8ITw9HWQMkdB7xGV5AuzInRQYglhNJVzyP4=
X-Received: by 2002:a05:651c:555:b0:332:6304:3076 with SMTP id
 38308e7fff4ca-3338120ce2amr6683961fa.1.1754474386475; Wed, 06 Aug 2025
 02:59:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250728152548.3969143-1-glider@google.com> <20250728152548.3969143-9-glider@google.com>
 <CACT4Y+aEwxFAuKK4WSU8wuAvG01n3+Ch6qBiMSdGjPqNgwscag@mail.gmail.com> <CAG_fn=XYS43pefo1EEO6jTTkPHKhB0+hpbh9KGQ5kodAJm3Ncg@mail.gmail.com>
In-Reply-To: <CAG_fn=XYS43pefo1EEO6jTTkPHKhB0+hpbh9KGQ5kodAJm3Ncg@mail.gmail.com>
From: Dmitry Vyukov <dvyukov@google.com>
Date: Wed, 6 Aug 2025 11:59:35 +0200
X-Gm-Features: Ac12FXyI3YUGwZ39tZWMZ9Wsw2WfrqCosnn9hPEGLahbYFj0RRIAWr5mkPiiOgo
Message-ID: <CACT4Y+bmmYuCbV6g9yk8aFZdzhGhct3K78ii6voHR4KAa6oE0g@mail.gmail.com>
Subject: Re: [PATCH v3 08/10] kcov: add ioctl(KCOV_RESET_TRACE)
To: Alexander Potapenko <glider@google.com>
Cc: quic_jiangenj@quicinc.com, linux-kernel@vger.kernel.org, 
	kasan-dev@googlegroups.com, Aleksandr Nogikh <nogikh@google.com>, 
	Andrey Konovalov <andreyknvl@gmail.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, Ingo Molnar <mingo@redhat.com>, 
	Josh Poimboeuf <jpoimboe@kernel.org>, Marco Elver <elver@google.com>, 
	Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 6 Aug 2025 at 11:47, Alexander Potapenko <glider@google.com> wrote:
>
> On Tue, Jul 29, 2025 at 1:17=E2=80=AFPM Dmitry Vyukov <dvyukov@google.com=
> wrote:
> >
> > On Mon, 28 Jul 2025 at 17:26, Alexander Potapenko <glider@google.com> w=
rote:
> > >
> > > Provide a mechanism to reset the coverage for the current task
> > > without writing directly to the coverage buffer.
> > > This is slower, but allows the fuzzers to map the coverage buffer
> > > as read-only, making it harder to corrupt.
> > >
> > > Signed-off-by: Alexander Potapenko <glider@google.com>
> >
> > Reviewed-by: Dmitry Vyukov <dvyukov@google.com>
> >
> >
> > >
> > > ---
> > > v2:
> > >  - Update code to match the new description of struct kcov_state
> > >
> > > Change-Id: I8f9e6c179d93ccbfe0296b14764e88fa837cfffe
> > > ---
> > >  Documentation/dev-tools/kcov.rst | 26 ++++++++++++++++++++++++++
> > >  include/uapi/linux/kcov.h        |  1 +
> > >  kernel/kcov.c                    | 15 +++++++++++++++
> > >  3 files changed, 42 insertions(+)
> > >
> > > diff --git a/Documentation/dev-tools/kcov.rst b/Documentation/dev-too=
ls/kcov.rst
> > > index 6446887cd1c92..e215c0651e16d 100644
> > > --- a/Documentation/dev-tools/kcov.rst
> > > +++ b/Documentation/dev-tools/kcov.rst
> > > @@ -470,3 +470,29 @@ local tasks spawned by the process and the globa=
l task that handles USB bus #1:
> > >                 perror("close"), exit(1);
> > >         return 0;
> > >      }
> > > +
> > > +
> > > +Resetting coverage with an KCOV_RESET_TRACE
> > > +-------------------------------------------
> > > +
> > > +The ``KCOV_RESET_TRACE`` ioctl provides a mechanism to clear collect=
ed coverage
> > > +data for the current task. It resets the program counter (PC) trace =
and, if
> > > +``KCOV_UNIQUE_ENABLE`` mode is active, also zeroes the associated bi=
tmap.
> > > +
> > > +The primary use case for this ioctl is to enhance safety during fuzz=
ing.
> > > +Normally, a user could map the kcov buffer with ``PROT_READ | PROT_W=
RITE`` and
> > > +reset the trace from the user-space program. However, when fuzzing s=
ystem calls,
> > > +the kernel itself might inadvertently write to this shared buffer, c=
orrupting
> > > +the coverage data.
> > > +
> > > +To prevent this, a fuzzer can map the buffer with ``PROT_READ`` and =
use
> > > +``ioctl(fd, KCOV_RESET_TRACE, 0)`` to safely clear the buffer from t=
he kernel
> > > +side before each fuzzing iteration.
> > > +
> > > +Note that:
> > > +
> > > +* This ioctl is safer but slower than directly writing to the shared=
 memory
> > > +  buffer due to the overhead of a system call.
> > > +* ``KCOV_RESET_TRACE`` is itself a system call, and its execution wi=
ll be traced
> > > +  by kcov. Consequently, immediately after the ioctl returns, cover[=
0] will be
> > > +  greater than 0.
> > > diff --git a/include/uapi/linux/kcov.h b/include/uapi/linux/kcov.h
> > > index e743ee011eeca..8ab77cc3afa76 100644
> > > --- a/include/uapi/linux/kcov.h
> > > +++ b/include/uapi/linux/kcov.h
> > > @@ -23,6 +23,7 @@ struct kcov_remote_arg {
> > >  #define KCOV_DISABLE                   _IO('c', 101)
> > >  #define KCOV_REMOTE_ENABLE             _IOW('c', 102, struct kcov_re=
mote_arg)
> > >  #define KCOV_UNIQUE_ENABLE             _IOW('c', 103, unsigned long)
> > > +#define KCOV_RESET_TRACE               _IO('c', 104)
> > >
> > >  enum {
> > >         /*
> > > diff --git a/kernel/kcov.c b/kernel/kcov.c
> > > index a92c848d17bce..82ed4c6150c54 100644
> > > --- a/kernel/kcov.c
> > > +++ b/kernel/kcov.c
> > > @@ -740,6 +740,21 @@ static int kcov_ioctl_locked(struct kcov *kcov, =
unsigned int cmd,
> > >                 return 0;
> > >         case KCOV_UNIQUE_ENABLE:
> > >                 return kcov_handle_unique_enable(kcov, arg);
> > > +       case KCOV_RESET_TRACE:
> > > +               unused =3D arg;
> > > +               if (unused !=3D 0 || current->kcov !=3D kcov)
>
> I think this is too strict, in certain cases it should be possible to
> reset the trace not belonging to the current thread, WDYT?
> E.g. syzkaller does that for the extra coverage:
> https://github.com/google/syzkaller/blob/ffe1dd46b97d508a7b65c279b8108eea=
ade66cb1/executor/executor.cc#L920

Yes, remote should be allowed here. There is some mutex that protects
remote trace buffer.

