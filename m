Return-Path: <linux-kernel+bounces-863943-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FF0DBF98FB
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 03:05:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id AE4714F18DD
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 01:05:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27CA91C4A24;
	Wed, 22 Oct 2025 01:05:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HDCIcUu9"
Received: from mail-yx1-f65.google.com (mail-yx1-f65.google.com [74.125.224.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BB535C96
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 01:05:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761095123; cv=none; b=rK6PGByAaQOhluC9qPZfvD8vfzRY7xFJlEcnsvn0MgIDxoEqkpWGtiw3xlXvxKrDtzLCPidXR7QO0i+c9K0/+CFAlczMYGrRNGNuFMUu4cUJJlOmf380pR+nbaAlCd+31BWLujr8DfKsIPDQyDlUtA4ffiRYcu8MRPoArl1C8To=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761095123; c=relaxed/simple;
	bh=4rmLUQu1le5r8D+swi25K4jEmqaVPWc7lJ6PHq6tcyQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oOS+7fyV6uJl3UTUNdU+46zT/BJQsYDHRYp12dlSWtz35MIVvxvP6QzlZB6mT4IWZ3ALGupKU0SdCyFSXt/i9OvGhR1ErQaQ6at19ywSxyQFzHyeBhTJVW96IFoKokXbU3ic2GddzLF4+B4xzVLrJd9Sw99ln2EYZ0z3zl1NcuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HDCIcUu9; arc=none smtp.client-ip=74.125.224.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f65.google.com with SMTP id 956f58d0204a3-63e0dd765a0so5620404d50.3
        for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 18:05:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761095119; x=1761699919; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EpBWUMQUyNYztr0Z+6+lgRKFyM4PGQRNG3RtejXI1dQ=;
        b=HDCIcUu9l4Uhbwu7zyX3X3VuVKCyI+HKGSp+LI2xNLz2NFyfdscIQyW79bnFihm5DG
         z1suO+SaaItuy4Hq2UCxlO7iyTb/+ayXNTFxxvuLWpI0j6DOx1QxjufvksL7ImfSD2Z8
         96S2x+n9F7eUFdKsVsaO9Zv59SiqrmJbXaoSSzRmYoCWuR//TW8kRR2oQeHyP/cINZ+B
         He3v3uo6tWAnxRwUwX9IME4SQqMIvZKpUwxvsfzIx3UlY0Hrdf2qfgkFPXn6RMeKLPsS
         bEztIWcL7Ctf9ulY2Zgbs7SpXq52QX8ysVLQ4QAHdayRVZasehc2+Smw3CWM3iFayeoY
         m5lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761095119; x=1761699919;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EpBWUMQUyNYztr0Z+6+lgRKFyM4PGQRNG3RtejXI1dQ=;
        b=AL/h6o6DqNGk6Wi+iYaeLbhVOIP8ZiWMR2cnNPc0wW+jlV7qPslD2liBEN2AQijHBD
         rRcPMww8jPVZy3aLi0/0h8zRYCDYkjGclkgelfr293nOm+gH58HarbCtsBJbKIQmeZWu
         zpFIy3wtdOYtz+qGwQCjyaWPa8kgpkGLT4pqUOgjPA5x1353HTgBoVyN+1P4nF+Y1FDh
         MfkjHX+H6nSgPijs71/NbpZGuXpPPlDJFYWC/ZbP0sj/i3vaHDmRKer+pJiC+p2DZOOU
         r+p5qMauEbwyU5ZhvWB9lZuH1lj2+zoQeskf3nAkaSlYGKSnQlFW/tmg/XD6oQC6fXxo
         y3kw==
X-Forwarded-Encrypted: i=1; AJvYcCUf+08L4dkSryswZH4QLh0cAOW3ttpx9aHLv/kR8zuQtG8cd3Da3YZ4p3S8wvuU1ECEsnqA9zxM+140B6M=@vger.kernel.org
X-Gm-Message-State: AOJu0YwndsORFny2MjaPIZkTKxD66iLbythyJdf3bS+ULjBBqDHLPx2B
	LWg8fAI8uSRW2XfivUZWjaGg0bUDESh9+CUycSdeNAzLMAjPFudXBmxW1hobqCG3NJx8jrqmvvc
	/+ssZtKjXoHrSGYN4cbC37UfKAz1eXRc=
X-Gm-Gg: ASbGncsg84VrYpBYY3oXvK7QKKBNvZSK8pb7wyWtAlGyIMgIphRotvMp+9VUy8nqg2N
	U27bSPVfphsrhj4K4oMgzJ02vVCtM4KFf68I9GMt7oQs/zrSvGCk7XpZ005hQ+4NVFOk1zYNN9s
	C2a/srduA9VjXxpV4FGXppfwMP81FqIMudW9lvl0ktogoNFvDupj3hhjX+6pl9Hme6OcT4ueFqW
	0NHPi8c6q/76I2kCHuAmrGncC7CzXQz9DkmS826Yys4jf10D+dj+hy6ptCC7qGDbKORhhw=
X-Google-Smtp-Source: AGHT+IF3FvmioM9BLiSXPvFefJ9mFTLeZP3TQOzmbGHlmIBl0/JtWtAgQ/j9lUo1B1DPYzFjyNFxiVtADeI/nOfgO0Y=
X-Received: by 2002:a05:690c:6204:b0:722:7a7f:537a with SMTP id
 00721157ae682-783b02e8f85mr264235697b3.38.1761095119351; Tue, 21 Oct 2025
 18:05:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251018142124.783206-1-dongml2@chinatelecom.cn>
 <20251018142124.783206-4-dongml2@chinatelecom.cn> <CAADnVQLN96WZd0eWWb=__62g49y_wPfjTPKXaB_=o5jdVE7uKQ@mail.gmail.com>
In-Reply-To: <CAADnVQLN96WZd0eWWb=__62g49y_wPfjTPKXaB_=o5jdVE7uKQ@mail.gmail.com>
From: Menglong Dong <menglong8.dong@gmail.com>
Date: Wed, 22 Oct 2025 09:05:08 +0800
X-Gm-Features: AS18NWBvheWbnEYFkDqoW2scTpYlV2lsYeAzkOkH1tIPcoLNZoG6fvzq48EGweo
Message-ID: <CADxym3ad72C+0D2AMDp799-zmLO-f2TG1+Xtbu-72Jv6LSzwSg@mail.gmail.com>
Subject: Re: [PATCH RFC bpf-next 3/5] bpf,x86: add tracing session supporting
 for x86_64
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, John Fastabend <john.fastabend@gmail.com>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, Eduard <eddyz87@gmail.com>, 
	Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Matt Bobrowski <mattbobrowski@google.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Leon Hwang <leon.hwang@linux.dev>, bpf <bpf@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, 
	linux-trace-kernel <linux-trace-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 22, 2025 at 2:17=E2=80=AFAM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Sat, Oct 18, 2025 at 7:21=E2=80=AFAM Menglong Dong <menglong8.dong@gma=
il.com> wrote:
> >  /* mov rax, qword ptr [rbp - rounded_stack_depth - 8] */
> >  #define LOAD_TRAMP_TAIL_CALL_CNT_PTR(stack)    \
> >         __LOAD_TCC_PTR(-round_up(stack, 8) - 8)
> > @@ -3179,8 +3270,10 @@ static int __arch_prepare_bpf_trampoline(struct =
bpf_tramp_image *im, void *rw_im
> >                                          void *func_addr)
> >  {
> >         int i, ret, nr_regs =3D m->nr_args, stack_size =3D 0;
> > -       int regs_off, nregs_off, ip_off, run_ctx_off, arg_stack_off, rb=
x_off;
> > +       int regs_off, nregs_off, session_off, ip_off, run_ctx_off,
> > +           arg_stack_off, rbx_off;
> >         struct bpf_tramp_links *fentry =3D &tlinks[BPF_TRAMP_FENTRY];
> > +       struct bpf_tramp_links *session =3D &tlinks[BPF_TRAMP_SESSION];
> >         struct bpf_tramp_links *fexit =3D &tlinks[BPF_TRAMP_FEXIT];
> >         struct bpf_tramp_links *fmod_ret =3D &tlinks[BPF_TRAMP_MODIFY_R=
ETURN];
> >         void *orig_call =3D func_addr;
> > @@ -3222,6 +3315,8 @@ static int __arch_prepare_bpf_trampoline(struct b=
pf_tramp_image *im, void *rw_im
> >          *
> >          * RBP - nregs_off [ regs count      ]  always
> >          *
> > +        * RBP - session_off [ session flags ] tracing session
> > +        *
> >          * RBP - ip_off    [ traced function ]  BPF_TRAMP_F_IP_ARG flag
> >          *
> >          * RBP - rbx_off   [ rbx value       ]  always
> > @@ -3246,6 +3341,8 @@ static int __arch_prepare_bpf_trampoline(struct b=
pf_tramp_image *im, void *rw_im
> >         /* regs count  */
> >         stack_size +=3D 8;
> >         nregs_off =3D stack_size;
> > +       stack_size +=3D 8;
> > +       session_off =3D stack_size;
>
> Unconditional stack increase? :(

Ah, it should be conditional increase and I made a mistake here,
which will be fixed in the V2.

In fact, we can't add the session stuff here. Once we make it
conditional increase, we can't tell the location of "ip" in
bpf_get_func_ip() anymore, as we can't tell if session stuff exist
in bpf_get_func_ip().

Several solution that I come up:

1. reuse the nregs_off. It's 8-bytes, but 1-byte is enough for it.
Therefore, we can store some metadata flags to the high 7-bytes
of it, such as "SESSION_EXIST" or "IP_OFFSET". And then,
we can get the offset of the ip in bpf_get_func_ip().
It works, but it will make the code more confusing.

2. Introduce a bpf_tramp_session_run_ctx:
struct bpf_tramp_session_run_ctx {
  struct bpf_tramp_run_ctx;
  __u64 session_flags;
  __u64 session_cookie;
}
If the session exist, use the bpf_tramp_session_run_ctx in the
trampoline.
It work and simple.

3. Add the session stuff to the tail of the context, which means
after the "return value". And the stack will become this:
session cookie -> 8-bytes if session
session flags   -> 8-bytes if session
return value     -> 8-bytes
argN
.....
arg1

Both method 2 and method 3 work and simple, and I decide use
the method 3 in the V2.

Thanks!
Menglong Dong

