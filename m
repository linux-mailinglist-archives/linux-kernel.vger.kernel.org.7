Return-Path: <linux-kernel+bounces-823401-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7714FB8653C
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 19:54:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0F265545C4D
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 17:54:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCA772848BE;
	Thu, 18 Sep 2025 17:54:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MDheYGbp"
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58DB82820DA
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 17:54:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758218048; cv=none; b=A5V9jJvLCHKKj6kwgcbqI8po5532TJndXE8REBwWfpjlbyBwZ8PHFg/YJps2q4P++SOqoZJZeO7FQzMxw6dp/1JpozPTOk8tFvOS3ogOpHSi5fCjeIqASFfp4OnVkjJdxiTs7jxyrJ9tjL6KSvVZw45jb+kkoKEmgy+aud0/0wc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758218048; c=relaxed/simple;
	bh=zBmeDJokNLQXp8RYGcPbjJ9WEW7sezS1c2BqhSqfsKU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sRMYWtVjmTQAyhTDw/8gFsw1myh8um6hH88h2mw7FknGCjxo7t6+Cx3hUs0kD5onTNtQ5o0gLuB4FqDXR3IlkRzpbDOFZSFw/BBK0GFD0vlV1wwonMxIu4hpFrdsJi8eyesAsVWHbr2af/lSr+aBPlnu7rWQ136VgdtxjFF1+BE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MDheYGbp; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-3e98c5adbbeso837805f8f.0
        for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 10:54:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758218045; x=1758822845; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zBmeDJokNLQXp8RYGcPbjJ9WEW7sezS1c2BqhSqfsKU=;
        b=MDheYGbphmnmQlC/31zqeNUO85hnoDnGvPbmIwfVHTqlc9sJR0CpY8bSCc4Lo8Ezy8
         2RBaQKViwsyHt4HTfVrClDiy4XVJO+H/X2mQ2c3oLl5ch/TLFJwSdeXB8Q56QKUSgyCH
         vIWlRrNTXKmIyGjoEdEw2tgvl0pQE7008vwPka4zPU+6yaEERvqWl0Oh4fDPTA72ocTe
         7coG0QzqEs2Fr4xRYl/DuDrOj7sopTOg8fm5DFZdWjPTgw0Gl7C+kpfxINSfgLvXHZ1Y
         tOeNybBK2eB1z3d94VeRnaDKV2RjpmQmDaKjy/3M6Utq/f5Pdqf3pduvSGD+cGj3G1NH
         QXow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758218045; x=1758822845;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zBmeDJokNLQXp8RYGcPbjJ9WEW7sezS1c2BqhSqfsKU=;
        b=u9ms/nhKvB1k/JrZ+6s8uiDdL+IamIqQ79Gu5dnmmjRSBBSjQqBgkW0Ul1OYrFSg2z
         0I4b+mZ5wK8MZEt4Gjs7kzFvcnsbdDN58oEHrZHdT0QrdxWxDidPsYX546o0vNRDnhGT
         B99fpAp9GkY2UqabfdOOqImHBs5L1PoIr55wHPErFrtkUqea+h1SdHs3jzSzRMJGGqqY
         f66c3mnEdhHNzLR7jpROSGMOdSTJj9a1fVlMfXwXkzxegLlxXg1KR38zuBV4UO2nIt7y
         Id/fgNI8vtO6gigQ61gNN1jzQWeW64hejA99qXAX0Htr8lbuWfpgeBpBP0vwRhsWI0Ia
         vnjg==
X-Forwarded-Encrypted: i=1; AJvYcCWum9IHjtlsJ4kYcsY7PETyMYjbIp0zmE5RIC62/BXZTA3GdrPLybBNqtDB7TvVcIvZeXy7DXNw+l19bM8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyi8pYb2HjBUAoz5B8oI0L0eO976UUKZePpozqs6YycsKSJYj3z
	IQ1Qi8YR6ZrYfudgFEr9PBHuv3yOCAYQo85PkF8StBDvazm8ee4m/4djer77x8PVxzEjNTXKbK2
	zKIeHIoAWoqeGDY0DpYQkyiS4zZLF7eI=
X-Gm-Gg: ASbGnctn+Z6REWBAcICa0SIATGw9e1sihGOQ5DUTn4DHtOgm/TZvK1FoKxuCdYA8B+B
	HRanL2rqW8LSVxhAPXvN5qbIhafmr8rysg77rjw3bnWXouw6ZU+564dNXlJR4SQ/EuP9GS/s0KV
	+/4uWfPgtTpHpMwbG0r4OCF+QE2PD/IyZd+oGzGOX6BqPg3eFU36cJy0H/SDo+S3aZUe/RXUegy
	Y5V4iIv/APJyaQKNf0mcArefC8aWv0zGROkeLHh8g==
X-Google-Smtp-Source: AGHT+IH3g1hib5RZjruPeL0g+q1AnwX7TjOn6ttwoWWeo1TMSgAIRtPgT543+gE79wYZjWrKyfpzEcQx1jXvR5GSC1A=
X-Received: by 2002:a05:6000:1789:b0:3ee:154e:4f9 with SMTP id
 ffacd0b85a97d-3ee7d0c8af1mr191670f8f.20.1758218044443; Thu, 18 Sep 2025
 10:54:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250918120939.1706585-1-dongml2@chinatelecom.cn>
 <20250918130543.GM3245006@noisy.programming.kicks-ass.net>
 <CADxym3ae8NGRt70rVO8ZyHa3BvWhczUkRs=dVn=rTRMVzrU9tA@mail.gmail.com>
 <CAADnVQ+hOdOpCR6s_GyO_7xxehCPBHSttidia38P5xFie6yjnw@mail.gmail.com> <20250918165935.GB3409427@noisy.programming.kicks-ass.net>
In-Reply-To: <20250918165935.GB3409427@noisy.programming.kicks-ass.net>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 18 Sep 2025 10:53:51 -0700
X-Gm-Features: AS18NWDkaHp-pjH2K4r_CAiTEfd3U6JL0GsQiWcLpfpyDR9kUwo2oqVemfqnrKA
Message-ID: <CAADnVQLP6-s_dtGpEcnFaVJfDW12rTOS2qk5k0Fyvn=4Gn7gBw@mail.gmail.com>
Subject: Re: [PATCH] x86/ibt: make is_endbr() notrace
To: Peter Zijlstra <peterz@infradead.org>
Cc: Menglong Dong <menglong8.dong@gmail.com>, Jiri Olsa <jolsa@kernel.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, X86 ML <x86@kernel.org>, 
	"H. Peter Anvin" <hpa@zytor.com>, Kees Cook <kees@kernel.org>, Sami Tolvanen <samitolvanen@google.com>, 
	Mike Rapoport <rppt@kernel.org>, Andy Lutomirski <luto@kernel.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 18, 2025 at 9:59=E2=80=AFAM Peter Zijlstra <peterz@infradead.or=
g> wrote:
>
> On Thu, Sep 18, 2025 at 09:02:31AM -0700, Alexei Starovoitov wrote:
> > On Thu, Sep 18, 2025 at 6:32???AM Menglong Dong <menglong8.dong@gmail.c=
om> wrote:
> > >
> > > On Thu, Sep 18, 2025 at 9:05???PM Peter Zijlstra <peterz@infradead.or=
g> wrote:
> > > >
> > > > On Thu, Sep 18, 2025 at 08:09:39PM +0800, Menglong Dong wrote:
> > > > > is_endbr() is called in __ftrace_return_to_handler -> fprobe_retu=
rn ->
> > > > > kprobe_multi_link_exit_handler -> is_endbr.
> > > > >
> > > > > It is not protected by the "bpf_prog_active", so it can't be trac=
ed by
> > > > > kprobe-multi, which can cause recurring and panic the kernel. Fix=
 it by
> > > > > make it notrace.
> > > >
> > > > This is very much a riddle wrapped in an enigma. Notably
> > > > kprobe_multi_link_exit_handler() does not call is_endbr(). Nor is t=
hat
> > > > cryptic next line sufficient to explain why its a problem.
> > > >
> > > > I suspect the is_endbr() you did mean is the one in
> > > > arch_ftrace_get_symaddr(), but who knows.
> > >
> > > Yeah, I mean
> > > kprobe_multi_link_exit_handler -> ftrace_get_entry_ip ->
> > > arch_ftrace_get_symaddr -> is_endbr
> > > actually. And CONFIG_X86_KERNEL_IBT is enabled of course.
> >
> > All this makes sense to me.
>
> As written down, I'm still clueless.
>
> > __noendbr bool is_endbr(u32 *val) needs "notrace",
> > since it's in alternative.c and won't get inlined (unless LTO+luck).
>
> notrace don't help with kprobes in general, only with __fentry__ sites.

Are you sure ? Last time I checked "notrace" prevents kprobing
anywhere in that function.

