Return-Path: <linux-kernel+bounces-757568-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 845AAB1C3B1
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 11:48:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E246A186F7B
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 09:48:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0151211A28;
	Wed,  6 Aug 2025 09:47:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nUXnqwhs"
Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 910682904
	for <linux-kernel@vger.kernel.org>; Wed,  6 Aug 2025 09:47:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754473676; cv=none; b=TVyATuOrajaXBGWwdHo+5AtOK6vOG73apjdAGUgdVmYku7g8H2v0qUiDKrcNvO4DFR6LN1KmHo9ons/MSjrg+6IrXNXOjORUllw8ALJPsakwXW9zJ7wqISzqLONkbEPDxAy/Z0c21jfW6BGM139OyfSTSztam+arKC3pULm7KDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754473676; c=relaxed/simple;
	bh=qsqMGZbDD7+j46xo5iv6uX/RH6l9xsV3ZNa9rRLQBqA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VgqDGkNg8LpwHDfZYHsYcNX8a7jvW3XI6tFrpYcgUDjC4daSkDfcHxncz1otO7WP9sxmtGZlnUWNoHn3eJf+Ji5DTI7rxMqxw+0qap4CaYwLMHxchpx9bcFoL3xr6qYoZSCDC4JaPe3bq4OFDlr/cgMMhwYwunNTt7IWr2BITOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nUXnqwhs; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-70736b2ea12so27265656d6.1
        for <linux-kernel@vger.kernel.org>; Wed, 06 Aug 2025 02:47:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1754473673; x=1755078473; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PrFRV6Sffa931ZKYbAVq2fB7yUmApGnWVEH6wPxtcxQ=;
        b=nUXnqwhs0GmyNCXQb0Gq8U88SEFJpf7pF/IwCuZOYOpkaLtS9q9GKRr33Vm5MsEL6f
         tSMuzMMwCsfg6tOtsrZ1UUsMf03IFnNog9kSA3HNyExgRUAv70mdUo4FN9x3tkgnmtNN
         jYuE0xZwPFveG8pMB3o7l0o/o5Z2hV406gKAGue/P270FocIUSXW9cLJIe3DDWcODXh8
         QT3yuvA8tuo87KsJEoGuPJ7UvQgpaqSIuSQ2gCbG/nPzuQf2UZyZYUulWxsKa2F9WYOr
         Iezq5WwNtD+gJMrzL/OeHN+5QWjrGXSQk89hflyf+k6MH0IB0K6NOLxAmfFAltQdJatS
         8anA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754473673; x=1755078473;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PrFRV6Sffa931ZKYbAVq2fB7yUmApGnWVEH6wPxtcxQ=;
        b=Jzr0QZN8pwi8ei3KZkbmi7cMm3xrSq7EQvp4gMYMlbakDyc4vnvlxJACP9xqeC8Pyk
         BwUNQatzW1gsTUCLflymXC/951ixhBbwTysB7P8bjxiWsUltzO7RPOLvMBYGYa9GmNEA
         XASs8UoXgsARdILhPx301GZEYVOqwcMeah4VAKRDv9bbXCJBOuFd+8woyJnYDOSXi2ab
         4ZbL3upX0n6A98ktHGTrXArVM1o7UpKhMeOcJwEkT4Rfl+pylvLYygKWQAhR7xMpShvf
         M95Qhl32+G2lANfYDWq43aaOXzebJDVeqtTWuU1XpRt61wJR1RTO5KKQ/Mxj4vdj8Mnh
         btRQ==
X-Forwarded-Encrypted: i=1; AJvYcCVd3PTvMSfcLzw301qFjtETKwHtcFxsbseK0F7hsq6g3s8ozf1S7KsOJR83TBUspx69LVdSlDcNvkp9YLM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyXAW5GcLu1bpEFwyX4khr2X1eHZffUFezocx42Q9hmwYaJtIAD
	QgBdsopQmzeLenVbhVaDBH00IQ6Ch5i7/wwXsYbVtdULcgCdtphGyQwHhxRN/j3IrwzQqhcuXaO
	9hV5/cr60R58cabl5AUj/xKJ16qdZFRBXsFUfP4T5
X-Gm-Gg: ASbGncs6CM1x7Sm7Qk2LEWpC1mafwVBaMk5uLKbFf90mYAimV7YWoXObFpNVfSD3Lyk
	v/bB7FritZr3O+BXyUVFNWeVE2xSIwRS2kelsQ+5nLVIZTqu1E6UDqWhC5qnjTWe64hXapeTxJd
	u9X+g75JRp1wudly3CHjAy6h8aFflvIAyVk6CjXfqauKmuZmu/VqIlVBuJ30qMPVGQwJpxwIbVD
	Uvi4RxcIJreZ+eKtxvK7YP4trlO8tW5nIfrXQ==
X-Google-Smtp-Source: AGHT+IGFIpEjBwKDsYe0qk2b8Ipiup4K/Mu74Zo1acNbIBp/bZon/61k+sa+iLxLOqpOguMi6rCfFapRasj9HMEz+Rw=
X-Received: by 2002:a05:6214:1d24:b0:707:ce0:d1b5 with SMTP id
 6a1803df08f44-7097af5272fmr18873576d6.34.1754473673048; Wed, 06 Aug 2025
 02:47:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250728152548.3969143-1-glider@google.com> <20250728152548.3969143-9-glider@google.com>
 <CACT4Y+aEwxFAuKK4WSU8wuAvG01n3+Ch6qBiMSdGjPqNgwscag@mail.gmail.com>
In-Reply-To: <CACT4Y+aEwxFAuKK4WSU8wuAvG01n3+Ch6qBiMSdGjPqNgwscag@mail.gmail.com>
From: Alexander Potapenko <glider@google.com>
Date: Wed, 6 Aug 2025 11:47:16 +0200
X-Gm-Features: Ac12FXyvMPPkAYf2aXAAJO3vWviF9023u78zwU7TwAkbbhnCYNLNaIfIom9VqF4
Message-ID: <CAG_fn=XYS43pefo1EEO6jTTkPHKhB0+hpbh9KGQ5kodAJm3Ncg@mail.gmail.com>
Subject: Re: [PATCH v3 08/10] kcov: add ioctl(KCOV_RESET_TRACE)
To: Dmitry Vyukov <dvyukov@google.com>
Cc: quic_jiangenj@quicinc.com, linux-kernel@vger.kernel.org, 
	kasan-dev@googlegroups.com, Aleksandr Nogikh <nogikh@google.com>, 
	Andrey Konovalov <andreyknvl@gmail.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, Ingo Molnar <mingo@redhat.com>, 
	Josh Poimboeuf <jpoimboe@kernel.org>, Marco Elver <elver@google.com>, 
	Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 29, 2025 at 1:17=E2=80=AFPM Dmitry Vyukov <dvyukov@google.com> =
wrote:
>
> On Mon, 28 Jul 2025 at 17:26, Alexander Potapenko <glider@google.com> wro=
te:
> >
> > Provide a mechanism to reset the coverage for the current task
> > without writing directly to the coverage buffer.
> > This is slower, but allows the fuzzers to map the coverage buffer
> > as read-only, making it harder to corrupt.
> >
> > Signed-off-by: Alexander Potapenko <glider@google.com>
>
> Reviewed-by: Dmitry Vyukov <dvyukov@google.com>
>
>
> >
> > ---
> > v2:
> >  - Update code to match the new description of struct kcov_state
> >
> > Change-Id: I8f9e6c179d93ccbfe0296b14764e88fa837cfffe
> > ---
> >  Documentation/dev-tools/kcov.rst | 26 ++++++++++++++++++++++++++
> >  include/uapi/linux/kcov.h        |  1 +
> >  kernel/kcov.c                    | 15 +++++++++++++++
> >  3 files changed, 42 insertions(+)
> >
> > diff --git a/Documentation/dev-tools/kcov.rst b/Documentation/dev-tools=
/kcov.rst
> > index 6446887cd1c92..e215c0651e16d 100644
> > --- a/Documentation/dev-tools/kcov.rst
> > +++ b/Documentation/dev-tools/kcov.rst
> > @@ -470,3 +470,29 @@ local tasks spawned by the process and the global =
task that handles USB bus #1:
> >                 perror("close"), exit(1);
> >         return 0;
> >      }
> > +
> > +
> > +Resetting coverage with an KCOV_RESET_TRACE
> > +-------------------------------------------
> > +
> > +The ``KCOV_RESET_TRACE`` ioctl provides a mechanism to clear collected=
 coverage
> > +data for the current task. It resets the program counter (PC) trace an=
d, if
> > +``KCOV_UNIQUE_ENABLE`` mode is active, also zeroes the associated bitm=
ap.
> > +
> > +The primary use case for this ioctl is to enhance safety during fuzzin=
g.
> > +Normally, a user could map the kcov buffer with ``PROT_READ | PROT_WRI=
TE`` and
> > +reset the trace from the user-space program. However, when fuzzing sys=
tem calls,
> > +the kernel itself might inadvertently write to this shared buffer, cor=
rupting
> > +the coverage data.
> > +
> > +To prevent this, a fuzzer can map the buffer with ``PROT_READ`` and us=
e
> > +``ioctl(fd, KCOV_RESET_TRACE, 0)`` to safely clear the buffer from the=
 kernel
> > +side before each fuzzing iteration.
> > +
> > +Note that:
> > +
> > +* This ioctl is safer but slower than directly writing to the shared m=
emory
> > +  buffer due to the overhead of a system call.
> > +* ``KCOV_RESET_TRACE`` is itself a system call, and its execution will=
 be traced
> > +  by kcov. Consequently, immediately after the ioctl returns, cover[0]=
 will be
> > +  greater than 0.
> > diff --git a/include/uapi/linux/kcov.h b/include/uapi/linux/kcov.h
> > index e743ee011eeca..8ab77cc3afa76 100644
> > --- a/include/uapi/linux/kcov.h
> > +++ b/include/uapi/linux/kcov.h
> > @@ -23,6 +23,7 @@ struct kcov_remote_arg {
> >  #define KCOV_DISABLE                   _IO('c', 101)
> >  #define KCOV_REMOTE_ENABLE             _IOW('c', 102, struct kcov_remo=
te_arg)
> >  #define KCOV_UNIQUE_ENABLE             _IOW('c', 103, unsigned long)
> > +#define KCOV_RESET_TRACE               _IO('c', 104)
> >
> >  enum {
> >         /*
> > diff --git a/kernel/kcov.c b/kernel/kcov.c
> > index a92c848d17bce..82ed4c6150c54 100644
> > --- a/kernel/kcov.c
> > +++ b/kernel/kcov.c
> > @@ -740,6 +740,21 @@ static int kcov_ioctl_locked(struct kcov *kcov, un=
signed int cmd,
> >                 return 0;
> >         case KCOV_UNIQUE_ENABLE:
> >                 return kcov_handle_unique_enable(kcov, arg);
> > +       case KCOV_RESET_TRACE:
> > +               unused =3D arg;
> > +               if (unused !=3D 0 || current->kcov !=3D kcov)

I think this is too strict, in certain cases it should be possible to
reset the trace not belonging to the current thread, WDYT?
E.g. syzkaller does that for the extra coverage:
https://github.com/google/syzkaller/blob/ffe1dd46b97d508a7b65c279b8108eeaad=
e66cb1/executor/executor.cc#L920

