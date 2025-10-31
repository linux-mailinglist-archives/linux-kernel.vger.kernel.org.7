Return-Path: <linux-kernel+bounces-879466-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id D6A08C23305
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 04:37:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id AE9624ECE0E
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 03:37:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9079D27F010;
	Fri, 31 Oct 2025 03:36:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W6oinO+d"
Received: from mail-yw1-f196.google.com (mail-yw1-f196.google.com [209.85.128.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 600881F03D7
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 03:36:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761881811; cv=none; b=fC8Pn91jgQo2Y1GrQ9BmvsQGuysDAjuMw7o+UGC9HeewXFxpQPEzirnVPq6sw+ii/bS85hrxjSWUqv1aitNghViZM0O+CBYSIRiXLyIUujgjeJWqQ7bw4R9qJUN22IpwJUWuA5n4vSkVfIM4ruhkrIn7GFgN4xE+VqPwc8eJoLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761881811; c=relaxed/simple;
	bh=l3mm+lBFPHAks+LwRIC7KHR/F6NM7jW/PvnGW725S5Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LPf/NcwBCr+1e+hnP9bkn4WIQ5I1CWWNTYqo0bExoRvaey6EkfH/A8nPm4SgG2f4htDtzcH/1PBxqxSjTIpcAhtuS3vk/jSrqHQ8RaMWIOYoivSGftg1DRPP8DwsHvpTrHqrruS+cfoDsLKvD+l6aY4ISv3qQgrEKUljDOF8v80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W6oinO+d; arc=none smtp.client-ip=209.85.128.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f196.google.com with SMTP id 00721157ae682-784826b75a4so23364837b3.0
        for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 20:36:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761881809; x=1762486609; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I+gv0KDSDdRFFvN+HUcCWv1GSnQA5FAvdjB0Eum3nw4=;
        b=W6oinO+dev/uST9GryQXsNDZkQLWI+P1zPNa6uPlW/4Vro55I7i65zLbLnOcci4GNR
         ECTTBqmct0snFh5q2aFKWrmSybVASZuLJzdb+vXuz/PVpMeqrw1YVSzQikIOgcWLLWSu
         5Bik3dxYMaUiFYALKvG+CbuhYSftjGt2BRz9wYypB/FjZXau9v55ut+ZUcIDp7VILH7c
         1h5CLdS/Uy3TOQzUGeIaxvvCPwyZ9mhfaqr/otNE/ejcO20zknCXRxTnyxD419qHfSaV
         RGueWlhNjm5x5HwgBxNZDSPeo7VITJTNwxK57a1Uy8nEqQykNYq+Vy68wY1LUWfDWUzM
         AICQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761881809; x=1762486609;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=I+gv0KDSDdRFFvN+HUcCWv1GSnQA5FAvdjB0Eum3nw4=;
        b=IgGgJ1sJqRQva82qEZA9u16VToC+SFNJ1C7Yfn5+jlpnasNQ8QmPw8YNxLaP6AdBBE
         pdStCfMOco6FGllzeOMQg8r6vWQPSpEzmSqhIPHQwxBq6844s6qs7xgnxERMtgqJwdzZ
         cycwVWl19gpxj7fH7LOEoaydZtwor9DsK0MVTgM7cKbQ1VXRkfkCB89hrrBrO+ZHTjki
         dCEXqzYnhIzOxJdq8TDU0xqsrj8NcW9XxMCWHRYv74ZD5lmBnzmeVAK8TExg/DeKv5bR
         QrHHlP4xp++z8JvXnP6l6HAnTpgrUQUwy6+eu/5lRPHdIeeFBOaoWTi0iSqMXDZLIdPE
         iMew==
X-Forwarded-Encrypted: i=1; AJvYcCX7iZn67wDnuuwJYJRSCXKEd16e9+y5pyFufamAfVOve9iTfOkaakwAEAqaXDdN8+vijZz5s0aUjJ9H8UY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyRK9POeA7fkofhXYITeqhJKmwILROsXXWrueIZq+15eWy6U2/x
	VrMNGLLtfiJ1sDIpsRtnpFttK2NNRaIUslU+z4H081DBgzO/twE6+Ail9TBDKprmdIg4iPUuQjY
	VTrBih2Xrtit3MJMDhlcqK0fXuf6sQxo=
X-Gm-Gg: ASbGnctNGMLdeWKSzugRy7ZUA74XPOEojk82qalJ6GvDwat7Imf0YJUdognIaY5ayHi
	vvbYMw5+ErigCtGQqgM4oOQYamLKmUhULIfgxHhYXRgKEkELWXY+rQ4RNtyk0HHpYILxf4V9qq6
	vRYOXUJsc7qIzeGXUaL/xDTzlViupvB3EBXTLDOz2eAaWIFQ4nYfm+QAlHrteOHIFo4pv2iwGBn
	l5a0hqkXn4fEYI779O/2ZzXa13KrOIkXC2UvJZrpO/E/CIpoVeISVPbhERwxXCH
X-Google-Smtp-Source: AGHT+IHBmFr/f7KUXhuoC5VAA8WBA2v3pQ2OxS/qFztuZcGPw4PY9FleCBb81VjY5kGRmzystYJN7lAr1Uhl6zn6/9s=
X-Received: by 2002:a05:690c:6011:b0:785:cbf4:7534 with SMTP id
 00721157ae682-786484164f5mr18054737b3.29.1761881809184; Thu, 30 Oct 2025
 20:36:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251026030143.23807-1-dongml2@chinatelecom.cn>
 <20251026030143.23807-5-dongml2@chinatelecom.cn> <CAADnVQLfxjOUqbbexFvvVJ4JTUQ2TKL0wvUn3iHv6vXvGfitoQ@mail.gmail.com>
In-Reply-To: <CAADnVQLfxjOUqbbexFvvVJ4JTUQ2TKL0wvUn3iHv6vXvGfitoQ@mail.gmail.com>
From: Menglong Dong <menglong8.dong@gmail.com>
Date: Fri, 31 Oct 2025 11:36:37 +0800
X-Gm-Features: AWmQ_bmKglPpjYeN8wPTAXBHJxvfdd8Q3ML6kp5pKVrlzSQxwPJihOrL8DGnJA4
Message-ID: <CADxym3Y4nc2Qaq00Pp7XwmCXJHn0SsEoOejK8ZxhydepcbB8kQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 4/7] bpf,x86: add tracing session supporting
 for x86_64
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, John Fastabend <john.fastabend@gmail.com>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, Eduard <eddyz87@gmail.com>, 
	Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Matt Bobrowski <mattbobrowski@google.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Leon Hwang <leon.hwang@linux.dev>, jiang.biao@linux.dev, 
	bpf <bpf@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	linux-trace-kernel <linux-trace-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 31, 2025 at 9:42=E2=80=AFAM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Sat, Oct 25, 2025 at 8:02=E2=80=AFPM Menglong Dong <menglong8.dong@gma=
il.com> wrote:
> >
> > Add BPF_TRACE_SESSION supporting to x86_64. invoke_bpf_session_entry an=
d
> > invoke_bpf_session_exit is introduced for this purpose.
> >
> > In invoke_bpf_session_entry(), we will check if the return value of the
> > fentry is 0, and set the corresponding session flag if not. And in
> > invoke_bpf_session_exit(), we will check if the corresponding flag is
> > set. If set, the fexit will be skipped.
> >
> > As designed, the session flags and session cookie address is stored aft=
er
> > the return value, and the stack look like this:
> >
> >   cookie ptr    -> 8 bytes
> >   session flags -> 8 bytes
> >   return value  -> 8 bytes
> >   argN          -> 8 bytes
> >   ...
> >   arg1          -> 8 bytes
> >   nr_args       -> 8 bytes
> >   ...
> >   cookieN       -> 8 bytes
> >   cookie1       -> 8 bytes
> >
> > In the entry of the session, we will clear the return value, so the fen=
try
> > will always get 0 with ctx[nr_args] or bpf_get_func_ret().
> >
> > Before the execution of the BPF prog, the "cookie ptr" will be filled w=
ith
> > the corresponding cookie address, which is done in
> > invoke_bpf_session_entry() and invoke_bpf_session_exit().
>
> ...
>
> > +       if (session->nr_links) {
> > +               for (i =3D 0; i < session->nr_links; i++) {
> > +                       if (session->links[i]->link.prog->call_session_=
cookie)
> > +                               stack_size +=3D 8;
> > +               }
> > +       }
> > +       cookies_off =3D stack_size;
>
> This is not great. It's all root and such,
> but if somebody attaches 64 progs that use session cookies
> then the trampoline will consume 64*8 of stack space just for
> these cookies. Plus more for args, cookie, ptr, session_flag, etc.

The session cookie stuff does take a lot of stack memory.
For fprobe, it will store the cookie into its shadow stack, which
can free the stack.

How about we remove the session cookie stuff? Therefore,
only 8-bytes(session flags) are used on the stack. And if we reuse
the nr_regs slot, no stack will be consumed. However, it will make
thing complex, which I don't think we should do.

> Sigh.
> I understand that cookie from one session shouldn't interfere
> with another, but it's all getting quite complex
> especially when everything is in assembly.
> And this is just x86 JIT. Other JITs would need to copy
> this complex logic :(

Without the session cookie, it will be much easier to implement
in another arch. And with the hepler of AI(such as cursor), it can
be done easily ;)

> At this point I'm not sure that "symmetry with kprobe_multi_session"
> is justified as a reason to add all that.
> We don't have a kprobe_session for individual kprobes after all.

As for my case, the tracing session can make my code much
simpler, as I always use the fentry+fexit to hook a function. And
the fexit skipping according to the return value of fentry can also
achieve better performance.

AFAIT, the mast usage of session cookie in kprobe is passing the
function arguments to the exit. For tracing, we can get the args
in the fexit. So the session cookie in tracing is not as important as
in kprobe.

What do you think?

Thanks!
Menglong Dong

> I think we better spend the energy designing a mechanism to
> connect existing fentry prog with fexit prog without hacking
> it through a stack in the bpf trampoline.
>
> Sorry.
>
> pw-bot: cr

