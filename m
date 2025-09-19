Return-Path: <linux-kernel+bounces-823852-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA36BB8793B
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 03:13:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6AF49582128
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 01:13:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9263A22069A;
	Fri, 19 Sep 2025 01:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PjY9hrsJ"
Received: from mail-yb1-f194.google.com (mail-yb1-f194.google.com [209.85.219.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64E4B273F9
	for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 01:13:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758244408; cv=none; b=sNht0pAI+Do4XheYAy2HzNw7+Vwk5iVfeAOsMQvTmkkWVd1oV6nIGlmYZLQ4+8vbODo+fR9GBgDOJHPfns++AEyARD+D5rRcHM0JXjYV/uB535gOYCgRxYa1G7ZQfZMeOK6vPJvw+4FSS2G3Tz/czdqoicRvu3f6FpaXwwvbKkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758244408; c=relaxed/simple;
	bh=NVCINHnu5XyfIfTH/bt86LXIAcWVL7rBMtyraEGrHC4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=J7hR6DJswxvYjNyNjA4ZSOr40TIcS7NKSlgjM6Am4u98YU7duCyGYTlgkW7mUFaXz/f08g9ltbQ6+Ygxhc+uXVEAb8EUfRHzR47BuhidU6IqlxO5rJhg+DbgNEjpFO6Oz832qenVPyJXhZZvw0dVwgmJT1bQMbUm4GXLmq+INaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PjY9hrsJ; arc=none smtp.client-ip=209.85.219.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f194.google.com with SMTP id 3f1490d57ef6-ea5cbca279aso1194936276.0
        for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 18:13:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758244406; x=1758849206; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EaDUMudIdIoXqVSWD7aQteCIRPR13lkKvGy+vWqzuRs=;
        b=PjY9hrsJpWRZjxUKvfRPzJ0MAMN9MBU9Xx/35oozjr7wXcKJmWZzKgDNVNECOaJ3S4
         yPstgd2eTT1np2B7TzMwTU1aPdTiBPdGoA28Fb80BMXXTKgaswPWS0zzIepfUTfee88h
         qs5jw/5yHVlPoNjArPh9RMrgUiCE2FvuARw7/sK8wOuK5Sl7wn2BdKExDIvVTHnEqZPe
         jj69BjUBjGDWQK+tXFrDRmcwdBjak1SSQTTVkcOH2uImgMXlaspS+pY4TicYPj6VUs6v
         w1nhVAyRmDVw0iSfQ/gohVPSP1yviZZgn+TBagrxGwgWgIJKtQHa07cgSGk7TN6XKkQW
         IYOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758244406; x=1758849206;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EaDUMudIdIoXqVSWD7aQteCIRPR13lkKvGy+vWqzuRs=;
        b=wvp3gu0UmyXQQTpCFKex+KO80xK6gkHpfbqDC/GhHDFup+aNj4jelB8eSzhYpjZVOV
         Oml+kQuRg7SmeMYN+AYfg/ueszPs+owYxmMn0JnLlUceLjAAePuLEJ44oCwK3166MUlF
         wQ6XQWHfq2q/AXUgpYYARhjQNUmQw1dlF9gAq+3qdXDSWnvR16ENxpHNs8klaNzR87tm
         z+CtsvrfKMkgntHph0591yTm5vnHES4putQHyyOBqjugIqjhupa9UYczn8QbMEHTZMRk
         w3WKRTmvXYfjAZFGLDTtaFe+DFpKHUgAu7C1krEL/UIhBLbNIsT1YULF5c1FlU1c8s9l
         QrcQ==
X-Forwarded-Encrypted: i=1; AJvYcCVWaOeobFCGE72v9LNBguWTthSGm2fzc8/ZXx2CtvJClXD7t5LzLT833ZcWZAnwlMnpvxQL6w7GpY3sUuo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwDxh6mTAaL8NkPYEvwzXIQOnNKtUgrYKYqXD0WrjPpmSs9hOlb
	fGxPOkEUp8fIqm7eZism916zBmrd/aiygP+fL097oPSy+EvmB561yvSpEM7/a0nM/ISzeat1CnG
	rORR6MacOTwe+bo4uUZB+KovAD6RkJiM=
X-Gm-Gg: ASbGnctm6AYDooSwIuXK65hHurTsQ3SY111FLlV3rp/37rrRTGCQLbubW2mwJ1yuFM6
	+eSVeLRcpaR7W8GLHRo4b6Ty0FoE1FydGbyhgC0LmU8Ps8S1MP6fU7N4tDeAwv1X4yh3NUsgYOw
	TalPh97IFQGcbx32gx/i7qWVo/qgzmCEhjMdjNeKzO1YPzEH49p5eO1euyElDfHrsAO9Y+AOyaN
	AeH3t789TXez9VYC1iO7uSR7A==
X-Google-Smtp-Source: AGHT+IEumflFqxMIDelqzF9utD7SHQtq+byoVXjwm9PjmcKO8ElbCCJANIQDmAQLixQbUCfi+eavIP+X7gcIDmKJF5k=
X-Received: by 2002:a05:690c:39c:b0:732:39a:8218 with SMTP id
 00721157ae682-73d32a37511mr14712097b3.20.1758244406202; Thu, 18 Sep 2025
 18:13:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250918120939.1706585-1-dongml2@chinatelecom.cn>
 <20250918130543.GM3245006@noisy.programming.kicks-ass.net>
 <CADxym3ae8NGRt70rVO8ZyHa3BvWhczUkRs=dVn=rTRMVzrU9tA@mail.gmail.com>
 <CAADnVQ+hOdOpCR6s_GyO_7xxehCPBHSttidia38P5xFie6yjnw@mail.gmail.com>
 <20250918165935.GB3409427@noisy.programming.kicks-ass.net> <CAADnVQLP6-s_dtGpEcnFaVJfDW12rTOS2qk5k0Fyvn=4Gn7gBw@mail.gmail.com>
In-Reply-To: <CAADnVQLP6-s_dtGpEcnFaVJfDW12rTOS2qk5k0Fyvn=4Gn7gBw@mail.gmail.com>
From: Menglong Dong <menglong8.dong@gmail.com>
Date: Fri, 19 Sep 2025 09:13:15 +0800
X-Gm-Features: AS18NWAZ9aDs6021Mx5sft0htLC24LyiQ02L56VQS2hwJXPhGzNa1P40F0wX_NM
Message-ID: <CADxym3Z6Ed5xjDMvh4ChRvrw_aLidkGrkgbK+076Exfmp=m3SA@mail.gmail.com>
Subject: Re: [PATCH] x86/ibt: make is_endbr() notrace
To: Peter Zijlstra <peterz@infradead.org>, Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, X86 ML <x86@kernel.org>, 
	"H. Peter Anvin" <hpa@zytor.com>, Kees Cook <kees@kernel.org>, Sami Tolvanen <samitolvanen@google.com>, 
	Mike Rapoport <rppt@kernel.org>, Andy Lutomirski <luto@kernel.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 19, 2025 at 1:54=E2=80=AFAM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Thu, Sep 18, 2025 at 9:59=E2=80=AFAM Peter Zijlstra <peterz@infradead.=
org> wrote:
> >
> > On Thu, Sep 18, 2025 at 09:02:31AM -0700, Alexei Starovoitov wrote:
> > > On Thu, Sep 18, 2025 at 6:32???AM Menglong Dong <menglong8.dong@gmail=
.com> wrote:
> > > >
> > > > On Thu, Sep 18, 2025 at 9:05???PM Peter Zijlstra <peterz@infradead.=
org> wrote:
> > > > >
> > > > > On Thu, Sep 18, 2025 at 08:09:39PM +0800, Menglong Dong wrote:
> > > > > > is_endbr() is called in __ftrace_return_to_handler -> fprobe_re=
turn ->
> > > > > > kprobe_multi_link_exit_handler -> is_endbr.
> > > > > >
> > > > > > It is not protected by the "bpf_prog_active", so it can't be tr=
aced by
> > > > > > kprobe-multi, which can cause recurring and panic the kernel. F=
ix it by
> > > > > > make it notrace.
> > > > >
> > > > > This is very much a riddle wrapped in an enigma. Notably
> > > > > kprobe_multi_link_exit_handler() does not call is_endbr(). Nor is=
 that
> > > > > cryptic next line sufficient to explain why its a problem.
> > > > >
> > > > > I suspect the is_endbr() you did mean is the one in
> > > > > arch_ftrace_get_symaddr(), but who knows.
> > > >
> > > > Yeah, I mean
> > > > kprobe_multi_link_exit_handler -> ftrace_get_entry_ip ->
> > > > arch_ftrace_get_symaddr -> is_endbr
> > > > actually. And CONFIG_X86_KERNEL_IBT is enabled of course.
> > >
> > > All this makes sense to me.
> >
> > As written down, I'm still clueless.

Ok, let me describe the problem in deetail.

First of all, it has nothing to do with kprobe. The bpf program of type
kprobe-multi based on fprobe, and fprobe base on fgraph. So it's all
about the ftrace, which means __fentry__.

Second, let me explain the recur detection of the kprobe-multi. Let's
take the is_endbr() for example. When it is hooked by the bpf program
of type kretprobe-multi, following calling chain will happen:

  is_endbr -> __ftrace_return_to_handler -> fprobe_return ->
  kprobe_multi_link_exit_handler -> ftrace_get_entry_ip ->
  arch_ftrace_get_symaddr -> is_endbr

Look, is_endbr() is called again during the ftrace handler, so it will
trigger the ftrace handler(__ftrace_return_to_handler) again, which
causes recurrence.

Such recurrence can be detected. In kprobe_multi_link_prog_run(),
the percpu various "bpf_prog_active" will be increased by 1 before we
run the bpf progs, and decrease by 1 after the bpf progs finish. If the
kprobe_multi_link_prog_run() is triggered again during bpf progs run,
it will check if bpf_prog_active is zero, and return directly if it is not.
Therefore, recurrence can't happen within the "bpf_prog_active" protection.

However, the calling to is_endbr() is not within that scope, which makes
the recurrence happen.

Hope I described it clearly =F0=9F=98=89

Thanks!
Menglong Dong

> >
> > > __noendbr bool is_endbr(u32 *val) needs "notrace",
> > > since it's in alternative.c and won't get inlined (unless LTO+luck).
> >
> > notrace don't help with kprobes in general, only with __fentry__ sites.
>
> Are you sure ? Last time I checked "notrace" prevents kprobing
> anywhere in that function.

