Return-Path: <linux-kernel+bounces-819660-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 870DAB5A444
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 23:52:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0169F1899A26
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 21:52:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 801F7307ACC;
	Tue, 16 Sep 2025 21:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T5EvIdYK"
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F4BB2F9D89
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 21:52:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758059539; cv=none; b=jTX3xmlNzWuimxGro4J48aUWp5VVhb7pNtd6U7BvByZzw5KCzy4zqSWHaxCOFOQlYo/QISB65X3WagQEwYo1iHJ7TfaiZPhUivRsdFvGWcPo4ija2dv+fnO5pkjs5aXPbD7nuAZR0QiPC4aPcUzF4qB6L5FOTcV1mG8sXJcXzIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758059539; c=relaxed/simple;
	bh=I7vgzpb4iQRotjVoiX/pLxoru+xY5k4ZR4ZCWGtLhqk=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QFDIU+E50or0vJKfYKYWk/M+tgL7bc3Jo/Kor7PlYGYKsVUHjkHnBJ/fhgJOJeK0+ckxRcrMJ/FhPYazQw18sazZA43qA/kfKGWmoqPf/bgTERHQWXdGWE8ZE9z01WUxzgjTIqHeJxSKSvXPmoP39sbsHD/OPNMH2zvDGOoreKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T5EvIdYK; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-afcb78ead12so859914866b.1
        for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 14:52:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758059535; x=1758664335; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=HmHjJhcmqy1sBBEmVO7MB7cGRMGtnkst9/nnRmc5EGM=;
        b=T5EvIdYKM7xdM80hgROGpZCjWUgiJyj6DNTUADzcCLD4yLYcqmtXVTmvW3+7fpwF49
         /1RkICJtwQU2llZPTyAbZVkHRQ8uBP9DR6mL1qO10ss66D6YTTDTN7wGITa2Rhtvk2r7
         RK4hPqbl5KImlcQaDGEzLjpKVuhnM8ds/63Bbl0leLu8GWKGf/JQStWel3qZvP/RXvEk
         MGjP21F4XJiTJNFGacNlozYeVZqnyj5Hmn2FWTvfY/BiIPG/rcoMu7LtNXq4jQH9k0rs
         wclDdfnjRr9VItIOY3f1gv66UroRHmbwr4G+V6FYmuq02IftQEapEmpaVQ3GbMFYtYAg
         tqKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758059535; x=1758664335;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HmHjJhcmqy1sBBEmVO7MB7cGRMGtnkst9/nnRmc5EGM=;
        b=tS0Euk9NMLsdB7z9PtLTDkEbRvVH+WVF+YYIUEtWgti4dAQyCY51pgFveg7+ja2Saj
         6vaIUXKMqQ23T6abXYkvOWzbY9MK9IezfTpJuL4bGe0G3GMITBKQMEDzJHqH4PRNeQBA
         Z20ZuRZ22JtfPvi7GH7k2ttJsctmU+rtoVzRSrx8PM4WBk+F77vBSRpKorifs+G8YBaF
         qEY0LnCzHvCV6BZWIKx7bTSlLjty+tTDjUe9NRkm7SBEBDlqRKBAyDcr0bq6uAIjk5s+
         aQ32iUPqyL5I5ZFd2XqfiPEAzqOogJxI3QLoW3kQ65KwyKOl3qasRXCGHA9fRNRYJufW
         2qtA==
X-Forwarded-Encrypted: i=1; AJvYcCWgrOKdnhxCifDvEh7BkaKc6h8Xo0im7YUDrdj5ZDInGDjGlz14qvSM7BPMZMXdJtLBovMGbIN/e/BJvvU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyX11AKkjOApqPMsj7Ni5ZqXs+XXXVNm8KaQjVHlPaQbV0whB66
	w/xJEqoxMO8Ij1NgM61qjDkht4BqP0Zxl8FJ7NuR+FmExa/ImdjzskUd
X-Gm-Gg: ASbGncv2BcnOv3jEdt1aGCSJxSQagzto9WekXtlI/YQ8zbFRhG8R07U4usaOFaJImWJ
	F/8ZxcteOHDcisFOOjyYVWdHGRDRPZ1oN5qldxoHmvXk6G7kYXJ8oe5oDi2iTxXAUy6FORhvBS4
	pWnJxVV7iuDBc2guaqr2mBbmyaAXIGY1yq/1qVDk3JHckSF1S8pBbirhzv0pdmoklkeX0G5B3YO
	0Zxg0m5MWlWPqLDIsGmG8h+J0BHDq3e/uuOr+0iOf92fjQBzi12du1qakHD9OFh3MfT/3XTz52d
	Mz234U2u/UWIpYdC71l4D7SVeXPPG7jA8uvrYq+1GDt95hChggc+dM1Q6YhFpO1fhnUcTWXdfqu
	vA+J81u8gwoYHsXn4HmcB6KkJuiUhrYA2u9LXQgs=
X-Google-Smtp-Source: AGHT+IEEPGcRJK3rkvIfHaTSzEc1f2K/e0Z2Jggqlv4rhtrevVG/kWh6oUJyYLTrD+W1XABPwN8FRQ==
X-Received: by 2002:a17:906:dc89:b0:b12:3f5f:603b with SMTP id a640c23a62f3a-b1bb08685eamr3355066b.3.1758059535004;
        Tue, 16 Sep 2025 14:52:15 -0700 (PDT)
Received: from krava (89-40-234-69.wdsl.neomedia.it. [89.40.234.69])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b07c6110c27sm1027530466b.66.2025.09.16.14.52.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Sep 2025 14:52:14 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Tue, 16 Sep 2025 23:52:11 +0200
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Oleg Nesterov <oleg@redhat.com>, Masami Hiramatsu <mhiramat@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	x86@kernel.org, Song Liu <songliubraving@fb.com>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	Hao Luo <haoluo@google.com>, Steven Rostedt <rostedt@goodmis.org>,
	Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCHv3 perf/core 1/6] bpf: Allow uprobe program to change
 context registers
Message-ID: <aMncCwre1QwJTNcL@krava>
References: <20250909123857.315599-1-jolsa@kernel.org>
 <20250909123857.315599-2-jolsa@kernel.org>
 <CAEf4Bzbw0uvfNgUHQM9iG2YRtnVbgdh_GgFGy4Q7eQiPPJ==dA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEf4Bzbw0uvfNgUHQM9iG2YRtnVbgdh_GgFGy4Q7eQiPPJ==dA@mail.gmail.com>

On Tue, Sep 09, 2025 at 12:41:36PM -0400, Andrii Nakryiko wrote:
> On Tue, Sep 9, 2025 at 8:39 AM Jiri Olsa <jolsa@kernel.org> wrote:
> >
> > Currently uprobe (BPF_PROG_TYPE_KPROBE) program can't write to the
> > context registers data. While this makes sense for kprobe attachments,
> > for uprobe attachment it might make sense to be able to change user
> > space registers to alter application execution.
> >
> > Since uprobe and kprobe programs share the same type (BPF_PROG_TYPE_KPROBE),
> > we can't deny write access to context during the program load. We need
> > to check on it during program attachment to see if it's going to be
> > kprobe or uprobe.
> >
> > Storing the program's write attempt to context and checking on it
> > during the attachment.
> >
> > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> > ---
> >  include/linux/bpf.h      | 1 +
> >  kernel/events/core.c     | 4 ++++
> >  kernel/trace/bpf_trace.c | 7 +++++--
> >  3 files changed, 10 insertions(+), 2 deletions(-)
> >
> > diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> > index cc700925b802..404a30cde84e 100644
> > --- a/include/linux/bpf.h
> > +++ b/include/linux/bpf.h
> > @@ -1619,6 +1619,7 @@ struct bpf_prog_aux {
> >         bool priv_stack_requested;
> >         bool changes_pkt_data;
> >         bool might_sleep;
> > +       bool kprobe_write_ctx;
> >         u64 prog_array_member_cnt; /* counts how many times as member of prog_array */
> >         struct mutex ext_mutex; /* mutex for is_extended and prog_array_member_cnt */
> >         struct bpf_arena *arena;
> > diff --git a/kernel/events/core.c b/kernel/events/core.c
> > index 28de3baff792..c3f37b266fc4 100644
> > --- a/kernel/events/core.c
> > +++ b/kernel/events/core.c
> > @@ -11238,6 +11238,10 @@ static int __perf_event_set_bpf_prog(struct perf_event *event,
> >         if (prog->kprobe_override && !is_kprobe)
> >                 return -EINVAL;
> >
> > +       /* Writing to context allowed only for uprobes. */
> > +       if (prog->aux->kprobe_write_ctx && !is_uprobe)
> > +               return -EINVAL;
> > +
> >         if (is_tracepoint || is_syscall_tp) {
> >                 int off = trace_event_get_offsets(event->tp_event);
> >
> > diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
> > index 3ae52978cae6..dfb19e773afa 100644
> > --- a/kernel/trace/bpf_trace.c
> > +++ b/kernel/trace/bpf_trace.c
> > @@ -1521,8 +1521,6 @@ static bool kprobe_prog_is_valid_access(int off, int size, enum bpf_access_type
> >  {
> >         if (off < 0 || off >= sizeof(struct pt_regs))
> >                 return false;
> > -       if (type != BPF_READ)
> > -               return false;
> >         if (off % size != 0)
> >                 return false;
> >         /*
> > @@ -1532,6 +1530,7 @@ static bool kprobe_prog_is_valid_access(int off, int size, enum bpf_access_type
> >         if (off + size > sizeof(struct pt_regs))
> >                 return false;
> >
> > +       prog->aux->kprobe_write_ctx |= type == BPF_WRITE;
> 
> nit: minor preference for
> 
> if (type == BPF_WRITE)
>     prog->aux->kprobe_write_ctx = true;

ok, will change

jirka

> 
> 
> >         return true;
> >  }
> >
> > @@ -2913,6 +2912,10 @@ int bpf_kprobe_multi_link_attach(const union bpf_attr *attr, struct bpf_prog *pr
> >         if (!is_kprobe_multi(prog))
> >                 return -EINVAL;
> >
> > +       /* Writing to context is not allowed for kprobes. */
> > +       if (prog->aux->kprobe_write_ctx)
> > +               return -EINVAL;
> > +
> >         flags = attr->link_create.kprobe_multi.flags;
> >         if (flags & ~BPF_F_KPROBE_MULTI_RETURN)
> >                 return -EINVAL;
> > --
> > 2.51.0
> >

