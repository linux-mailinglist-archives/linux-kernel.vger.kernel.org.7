Return-Path: <linux-kernel+bounces-885736-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id E6D53C33CC6
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 03:45:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 749F24FAAD0
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 02:43:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 026AB242D9D;
	Wed,  5 Nov 2025 02:43:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FPC64YiB"
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF1471F2BA4
	for <linux-kernel@vger.kernel.org>; Wed,  5 Nov 2025 02:43:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762310618; cv=none; b=Io+tA50ljOBYX/aoKYxUV3f5/hIICh7YTrgbWHV7aChr/ygSTVfWJnV+buTWkqfuj8JSpOTZEBcHJlACdAFXgGV0bQvccDby1I4vK5rgtoa5gsr8PmrfJSJTJoEy1KsFLqtZohT7XDh9QoUbfuESoyyKYI1p5VueczOgH4G9F+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762310618; c=relaxed/simple;
	bh=SgBFrNhogvdoa8VGxahe1W9m0v06c9gjW1nigepRweQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=C9pQ4c3cCK6/CcSPY/lQaGd4+Puq9PseqWPxAjDlMQOgxHPdYRgOE+syWX7O0l4WlFStw5hS3kBHJ0BwFeWIdrLwUlsGzChygyaGQHKVUZwbPRFrGizRHdurW4BvF0cmiWVuLkkatN8LM+yEra3fRHaoE8RnnH83dGCUr2Qz/9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FPC64YiB; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-42557c5cedcso3694222f8f.0
        for <linux-kernel@vger.kernel.org>; Tue, 04 Nov 2025 18:43:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762310615; x=1762915415; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/Bf7PBghSo52U1Mjeh5akTeQxAJNH9o/Gf88oU5D228=;
        b=FPC64YiBp/jQ78UsoRSEvvO1pAnRjK86H8ayhbYIqYVW1y6MRdfRqa9vtxgWDMm/Xj
         duejNmxVGW17d0BvynrHgM6w7RK31AiDDcZCKezZmZJzDW2xt68Hxr/j4Rp8gjT+WL4Z
         vcFq6kLtsKCo5sz13vFO+uMGVRGUEobIUwBRLBdbJIOh/+ymFUprUqLgiSfi+GwS1rVN
         F0DSstkoPSwk+Ku7zEJzajI+5sBw4feqbYTxt5HpSFOgTOmV2CJ0vhA2rLNk4DxfdyBq
         Hx1FQky28c4VZ7qXiLJjPo06bDNBCR5+cDx0XZ6NbcfBO/6L36TPBuFGI2HW33F4DbIW
         DONw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762310615; x=1762915415;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/Bf7PBghSo52U1Mjeh5akTeQxAJNH9o/Gf88oU5D228=;
        b=qcmdTWoS83jBaBZ8W1684JkyVddlsX56gAnr62RhIdrRAGQ2FJ2Uo4IJzo29NSkK9Y
         ji7DE7EKYFPVctltXPCUkLDdSDa8zdazpmjqQ/+zClX2TV7jV1k3yGAxs5p+7kqM2O5G
         mhf8czC9TzDQEqe8RWGnBsU8VgJIRXX+LsrGBoUcgIWIcUsynCyKA2+EvQ6Q4uEGWTRQ
         rDOS6GhIc0pEqOCmvjMZ2p3H1dE0hCmNQTb+m++umVinhZakMvUzf+mM/spxSwlhrKSj
         pzkPehU9lS+NdwyuS/s89GacRBwDBGYof+lHTeqNw0qZskg12pB8IwsvTHL1xgdxUHI6
         92fw==
X-Forwarded-Encrypted: i=1; AJvYcCU0WaxdU+aWvJnFFK3SyFt0W5rlIlzoOjCHq2K7VmbpJ5neyVZPlix49CrRZV+K3lk9fqVzLyxa4YEuVkc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxKHaqTqgfL8u+l4MXFkvv8v+mc76TexjW4/8Qq4lxPZqLX5kvn
	XRXwoj3lsx0V8aTFcjrPKoRIZb5ZD/YYtlEaVk96r8J+ucBBJfNizhuvvufveTNNWhdepZkfIj0
	+9wQ1D4h1TWBPZ+OyrJU7yv8wC6T0ABA=
X-Gm-Gg: ASbGncv/MH3WfRMvkW5xO0tMZ3BwcmDrctaIHMH2J3nrnelKN/KpcqOuLbxBzQMePfy
	pNw33Xio6vYUG/kngbMKhruvfVGUVaKceZ8VXwjV4ws898MfIijoZ4C+rnfo+QGuB3K/iwQoAqc
	eFrXYMaqEQqc6Q6kQLn9lSlqcSDaByn9DShrzAzuF0yBDcq4T8cbNRNBKvBvWgEjg7jdZEy8dpJ
	7d+XxVHCNyopmGwBvyYHQl39RXATydsvHmjpd787js2h3KpMZiNgMDq6tOqj5F+bfS07XSBCnG+
	+ICwWZpBrKvQz0xFLQ==
X-Google-Smtp-Source: AGHT+IElw2WYyuP+JJ6JyFhdeXjrplIdVA3eJDD2wPNCnK/SS5SPqimXkO+nmYB4XUQk94VGTnNZ/SssoFvBygPSMhg=
X-Received: by 2002:a05:6000:1788:b0:429:d6fa:da32 with SMTP id
 ffacd0b85a97d-429e3333edbmr990646f8f.59.1762310614957; Tue, 04 Nov 2025
 18:43:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251026030143.23807-1-dongml2@chinatelecom.cn>
 <CADxym3Y4nc2Qaq00Pp7XwmCXJHn0SsEoOejK8ZxhydepcbB8kQ@mail.gmail.com>
 <CAADnVQKDza_ueBFRkZS8rmUVJriynWi_0FqsZE8=VbTzQYuM4w@mail.gmail.com>
 <3577705.QJadu78ljV@7950hx> <CAEf4Bzas7Or4yPzqdHqEcgVpTDx2j26dR5oRnSg7bepr-uDqHw@mail.gmail.com>
In-Reply-To: <CAEf4Bzas7Or4yPzqdHqEcgVpTDx2j26dR5oRnSg7bepr-uDqHw@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 4 Nov 2025 18:43:23 -0800
X-Gm-Features: AWmQ_bnCqHk08l-4KYCNW-OmyHCZdl1u1xf5DR7CCUqC-jjbESzGUXgAHgyys20
Message-ID: <CAADnVQKV_a7NxvWwXDgRab_gakwJ=VadZ0=eC5sHwutVyM0rmg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 4/7] bpf,x86: add tracing session supporting
 for x86_64
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Menglong Dong <menglong.dong@linux.dev>, Menglong Dong <menglong8.dong@gmail.com>, 
	Alexei Starovoitov <ast@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
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

On Tue, Nov 4, 2025 at 4:40=E2=80=AFPM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Mon, Nov 3, 2025 at 3:29=E2=80=AFAM Menglong Dong <menglong.dong@linux=
.dev> wrote:
> >
> > On 2025/11/1 01:57, Alexei Starovoitov wrote:
> > > On Thu, Oct 30, 2025 at 8:36=E2=80=AFPM Menglong Dong <menglong8.dong=
@gmail.com> wrote:
> > > >
> > > > On Fri, Oct 31, 2025 at 9:42=E2=80=AFAM Alexei Starovoitov
> > > > <alexei.starovoitov@gmail.com> wrote:
> > > > >
> > > > > On Sat, Oct 25, 2025 at 8:02=E2=80=AFPM Menglong Dong <menglong8.=
dong@gmail.com> wrote:
> > > > > >
> > > > > > Add BPF_TRACE_SESSION supporting to x86_64. invoke_bpf_session_=
entry and
> > > > > > invoke_bpf_session_exit is introduced for this purpose.
> > > > > >
> > > > > > In invoke_bpf_session_entry(), we will check if the return valu=
e of the
> > > > > > fentry is 0, and set the corresponding session flag if not. And=
 in
> > > > > > invoke_bpf_session_exit(), we will check if the corresponding f=
lag is
> > > > > > set. If set, the fexit will be skipped.
> > > > > >
> > > > > > As designed, the session flags and session cookie address is st=
ored after
> > > > > > the return value, and the stack look like this:
> > > > > >
> > > > > >   cookie ptr    -> 8 bytes
> > > > > >   session flags -> 8 bytes
> > > > > >   return value  -> 8 bytes
> > > > > >   argN          -> 8 bytes
> > > > > >   ...
> > > > > >   arg1          -> 8 bytes
> > > > > >   nr_args       -> 8 bytes
>
> Let's look at "cookie ptr", "session flags", and "nr_args". We can
> combine all of them into a single 8 byte slot: assign each session
> program index 0, 1, ..., Nsession. 1 bit for entry/exit flag, few bits
> for session prog index, and few more bits for nr_args, and we still
> will have tons of space for some other additions in the future. From
> that session program index you can calculate cookieN address to return
> to user.
>
> And we should look whether moving nr_args into bpf_run_ctx would
> actually minimize amount of trampoline assembly code, as we can
> implement a bunch of stuff in pure C. (well, BPF verifier inlining is
> a separate thing, but it can be mostly arch-independent, right?)

Instead of all that I have a different suggestion...

how about we introduce this "session" attach type,
but won't mess with trampoline and whole new session->nr_links.
Instead the same prog can be added to 'fentry' list
and 'fexit' list.
We lose the ability to skip fexit, but I'm still not convinced
it's necessary.
The biggest benefit is that it will work for existing JITs and trampolines.
No new complex asm will be necessary.
As far as writable session_cookie ...
let's add another 8 byte space to bpf_tramp_run_ctx
and only allow single 'fsession' prog for a given kernel function.
Again to avoid changing all trampolines.
This way the feature can be implemented purely in C and no arch
specific changes.
It's more limited, but doesn't sound that the use case for multiple
fsession-s exist. All this is on/off tracing. Not something
that will be attached 24/7.

