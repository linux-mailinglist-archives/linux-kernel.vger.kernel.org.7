Return-Path: <linux-kernel+bounces-844623-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 59E87BC25C5
	for <lists+linux-kernel@lfdr.de>; Tue, 07 Oct 2025 20:19:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 798604F0F33
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Oct 2025 18:19:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51B752D5408;
	Tue,  7 Oct 2025 18:19:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AOfahSZX"
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9586621D3E2
	for <linux-kernel@vger.kernel.org>; Tue,  7 Oct 2025 18:19:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759861190; cv=none; b=n1/mjIsVYFLbVvbRLG8AApY5w4Y61NxCsuLp4BuqJ9K3UPhblx7IiqxlSQrFP62e7CNFfIR/CLOzBQEPD9v5hQBUw8eG//cyM+2cIu3UdXkzB5K5md1sQJyGMG7bBpgT/vZm2OYGLWkll6QnzdGfh3eU4disdf3hDhSKCwVzypg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759861190; c=relaxed/simple;
	bh=IVqEvsVTUvX2jwOw2TI5EYYaO5oPHB99rIwU+g37kOU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mBWNaMFYhcZWmkyxjHVaSSnlHjuKkimXJmf/PMV3BEbjVSG7uIbOHkPNyGAE7jKyeI9/EghwQGETvwxG6B0EC1/NgtKsBHqvrqLWIMtBy6CXZ9s+o76OC+z7WXZwuKPlzstLFPtdmRFTOH4QU6HQktsCNNtdHiCMjpHCyYVcgOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=AOfahSZX; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-71d6014810fso72547037b3.0
        for <linux-kernel@vger.kernel.org>; Tue, 07 Oct 2025 11:19:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1759861186; x=1760465986; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QpRN8feqqsElTzLcm8W2XosrV9uz7ywy4cSoDnu6iQU=;
        b=AOfahSZX/OVO/qiBtcbWKTd23P7v6SJ+YQcWyRIcgwOERZuZerVpFkTo44CGuGBCoI
         He7yWgbx3v9VtvSA1jlvpeGHsRtyaU3NIn4u8vmKbj3JhnWpykTOR9FE26T83kvq97Ur
         m5p6D8gss2UcEI6I0DtKkkVsLwHTJF/mHyUWp7WaUmtpkLmVxNmkXzOjvwGUN1ntPAos
         /OKPrt0PqidGP7PSaoV62EZxvop9Ro1r1BpUC0So+yfpC/iPyNpaCU3f7+z0sAI1UPRi
         5o3SbK/rJ1FwFEEBQjc3Mr1CkHfVt2H8tzmYT5G4qCkggaT+Fw7xyEPViOymvTFk2tF3
         +3Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759861186; x=1760465986;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QpRN8feqqsElTzLcm8W2XosrV9uz7ywy4cSoDnu6iQU=;
        b=ULC5e08dX/oIiKZjVfDdP7nzyJMrW2IgxUwOEHaHnQvB0YfxkEKVVTDAFgVvqwd5VP
         dH1JXUD64OVyoeVR1+iDVkd4UQG6dKpJmMsz1XcUvxKcNGL0Skvh/sVKbyHRyZQiaH4U
         IiV6eH6JHvJy5Y0Ri4TwYAh5nOf6+K4H5mrj9Yss5P6W6zTn7OVVAcjJKwHDWSMEVz++
         277WN6WUZ+gZ/Fh+fQhsfXSFeeJjSfadnr4bJ6w/4TJJgkILivjQtuNwAIEPytFQ1rEv
         1Ux6/hp8EQJGJZ72EMxguBg+uND5Q4yAf35rY3apgGn0I+QX8Kv/X7x0m3cNh1mL7zd3
         wLRg==
X-Forwarded-Encrypted: i=1; AJvYcCWzs4Ej14AY4Winni+mSZgTceLq7oKbZSmo7ora0/4JyTJJxgatyP7903NxXlAuEJtzpu0Lv4DIwaaXe3k=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7t/GhkXrHl4hJAnyYQ9Wo/6OUnFZH58Alqgon10WFiqCcYdP3
	9oKAAquTVXiYXOT6rDwkvKzD4Y30xwLHRfKJFC4M9Abvt4o5luBWAUn9gtYxUOnKDkxAMFYLaXd
	8/fwHbKFP2rnxosKDlosS2xH4TlYD/RkMPBR7fn5T
X-Gm-Gg: ASbGncuwJdRP2moDOOspAwIF4R4RND3CqSbc0lp/ut9VoFa/YgUOoP071jIyFWOKIOD
	N1ziMkwgoROtSxMLv6YiS3jNe6hnzWJZzJPD/oFsAnwlg09v2aUoMy1rut6tj3oPmu/32JiS1kc
	ngbXgT90M8b52jnGH7bljT8b1z0v7g4KjtaSaA1JCEOoiaYlBf/3hLj6hAd2a6/dNq1CH8KZt+7
	G7Tv+J8ws0n7WkfhQYyLYP5e4XYDqMRG6CK1d00yYQoSRGVlIdKEl52FItCMMsXiflV3nBI09iZ
	HbIJVj9XK2TK9Q==
X-Google-Smtp-Source: AGHT+IHmnWRPd1ss0ygaevLRNtl5Gxq2B+MPydv3Ris/6UTKaORAxfSjZgrqGsCx7T5ydjyxJGnOiVeVkgDs6SCCIy8=
X-Received: by 2002:a53:bd52:0:b0:636:5bf:2e30 with SMTP id
 956f58d0204a3-63ccb8dba95mr426506d50.38.1759861186047; Tue, 07 Oct 2025
 11:19:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251007003417.3470979-2-runpinglai@google.com> <20251006221043.07cdb0fd@gandalf.local.home>
In-Reply-To: <20251006221043.07cdb0fd@gandalf.local.home>
From: Runping Lai <runpinglai@google.com>
Date: Tue, 7 Oct 2025 11:19:34 -0700
X-Gm-Features: AS18NWCYZSrDjScKnxfB6EhPqKQ5Q-Y1_UuIogq3KVwEYQ9HtyLxCPJJqTTf_vU
Message-ID: <CABgk4RQwGsn4CdP0K+_7A0j7RVOiHNfoF1ESk17wEuzCea16pA@mail.gmail.com>
Subject: Re: [PATCH v1] Revert "tracing: Fix tracing_marker may trigger page
 fault during preempt_disable"
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Wattson CI <wattson-external@google.com>, kernel-team@android.com, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	Luo Gengkun <luogengkun@huaweicloud.com>, Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 6, 2025 at 7:08=E2=80=AFPM Steven Rostedt <rostedt@goodmis.org>=
 wrote:
>
> On Tue,  7 Oct 2025 00:34:17 +0000
> Runping Lai <runpinglai@google.com> wrote:
>
> > This reverts commit 3d62ab32df065e4a7797204a918f6489ddb8a237.
> >
> > It's observed on Pixel 6 that this commit causes a severe functional
> > regression: all user-space writes to trace_marker now fail. The write
> > does not goes through at all. The error is observed in the shell as
> > 'printf: write: Bad address'. This breaks a primary ftrace interface
> > for user-space debugging and profiling. In kernel trace file, it's
> > logged as 'tracing_mark_write: <faulted>'. After reverting this commit,
> > functionality is restored.
>
> This is very interesting. The copy is being done in an atomic context. If
> the fault had to do anything other than update a page table, it is likely
> not to do anything and return a fault.
>
> What preemption model is Pixel 6 running in? CONFIG_PREEMPT_NONE?

Hey Steve,

On Pixel6, CONFIG_PREEMPT is set. And CONFIG_PREEMPT_NONE
is not set. I'll paste the full PREEMPT configs:

~/aosp_kernel > common/scripts/extract-ikconfig
out/slider/dist/vmlinux | less | grep PREEMPT
CONFIG_PREEMPT_BUILD=3Dy
CONFIG_ARCH_HAS_PREEMPT_LAZY=3Dy
# CONFIG_PREEMPT_NONE is not set
# CONFIG_PREEMPT_VOLUNTARY is not set
CONFIG_PREEMPT=3Dy
# CONFIG_PREEMPT_LAZY is not set
# CONFIG_PREEMPT_RT is not set
CONFIG_PREEMPT_COUNT=3Dy
CONFIG_PREEMPTION=3Dy
# CONFIG_PREEMPT_DYNAMIC is not set
CONFIG_PREEMPT_RCU=3Dy
CONFIG_HAVE_PREEMPT_DYNAMIC=3Dy
CONFIG_HAVE_PREEMPT_DYNAMIC_KEY=3Dy
CONFIG_PREEMPT_NOTIFIERS=3Dy
# CONFIG_DEBUG_PREEMPT is not set
CONFIG_PREEMPTIRQ_TRACEPOINTS=3Dy
# CONFIG_PREEMPT_TRACER is not set
# CONFIG_PREEMPTIRQ_DELAY_TEST is not set

>
> The original code is buggy, but if this is causing a regression, then we
> likely need to do something else, like copy in a pre-allocated buffer?

Sounds like a good plan. Before the long term fix, can we please
revert this commit?

Best,
Runping

>
> -- Steve
>
>
> >
> > Signed-off-by: Runping Lai <runpinglai@google.com>
> > Reported-by: Wattson CI <wattson-external@google.com>
> > ---
> >  kernel/trace/trace.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
> > index 156e7e0bf559..bb9a6284a629 100644
> > --- a/kernel/trace/trace.c
> > +++ b/kernel/trace/trace.c
> > @@ -7213,7 +7213,7 @@ static ssize_t write_marker_to_buffer(struct trac=
e_array *tr, const char __user
> >       entry =3D ring_buffer_event_data(event);
> >       entry->ip =3D ip;
> >
> > -     len =3D copy_from_user_nofault(&entry->buf, ubuf, cnt);
> > +     len =3D __copy_from_user_inatomic(&entry->buf, ubuf, cnt);
> >       if (len) {
> >               memcpy(&entry->buf, FAULTED_STR, FAULTED_SIZE);
> >               cnt =3D FAULTED_SIZE;
> > @@ -7310,7 +7310,7 @@ static ssize_t write_raw_marker_to_buffer(struct =
trace_array *tr,
> >
> >       entry =3D ring_buffer_event_data(event);
> >
> > -     len =3D copy_from_user_nofault(&entry->id, ubuf, cnt);
> > +     len =3D __copy_from_user_inatomic(&entry->id, ubuf, cnt);
> >       if (len) {
> >               entry->id =3D -1;
> >               memcpy(&entry->buf, FAULTED_STR, FAULTED_SIZE);
>

