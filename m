Return-Path: <linux-kernel+bounces-833421-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 89389BA1EA1
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 01:03:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 917376237AC
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 23:03:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DEC12EC565;
	Thu, 25 Sep 2025 23:03:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZxEie5Yx"
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6749D24A049
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 23:03:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758841420; cv=none; b=b4EUbg5Ldum1LDXRsNfek2flSQrtCW84hndByvsqMbl3ZPICWn0c2ge6nAGcyYJjP7a6VtjBwayS+9TE7BTaDahz1hE+UFWm6qkRtRims+XeSJZwnTI3ZHzJAxyKdeBFN4ZxLM3M5bAJDcOiGh11PCeU2WeAC/3CGg6u5HxjW5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758841420; c=relaxed/simple;
	bh=nbRxRgK3MnmggxW+Ebz0E61TveOH+wQ+UCwJ8FnXk1s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RaZDRGyXLt8r0chC1QVb60IAEtKRuYNXSq7hPfL9PLTAMFdRtS4JFRMahu5hAjc2uua4CdMf+k5J74kOyzRrFzdUnbKFLqUC2+L0Da8xICdAZ6rwnWrM/LSLGH3kb0onZAH5LfTKhSFtgvcGclo7rGQpqOy0sSKR4j4C6YxT5xI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZxEie5Yx; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-33292adb180so1490415a91.3
        for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 16:03:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758841419; x=1759446219; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bWCh6bHuJ83aEJauG6K7Go4MbRibOQjjxAHEedB0ZuA=;
        b=ZxEie5YxYAzYGQq7gyt9/aGVcOf6r+OuyMa45Oss0/3xcEgZBOx73sMoqd9QioRTm3
         xp2rZ551UjWav3zueoH9kCtBSWAfd2X7LNKtjR0kSLo/oaLn4n4AzVr3htubRgwZzv+a
         crVUXISft7y0S83LOv2veYBr8wgXMYb+Ivx7H+ztPTr9FghQV9mrRb1FQdHtkMu2/eE2
         Hy8UQwm2UqQb7uQJ1mZstdyWg8c3AOrzk8OGO1R7Pc1uvDFeiysqiA+IKwQ/S7trnxFa
         8QlamQBHJqKC0vSMu0RNcazGAedOJScFUaZoqUaDaomdSNWSQ2c7gjhvSbImXkIOtAr7
         dETA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758841419; x=1759446219;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bWCh6bHuJ83aEJauG6K7Go4MbRibOQjjxAHEedB0ZuA=;
        b=a8aNGb2lQHK6l9R8ylUi9unX57zuVUXXHdtxqCvYdkKtLR0Q/09wQYm3uQVwsCwy5j
         EQT0avk5XF7yHW+79u/HGIEk60FYW8NDYezV7rLK+/FdjxTViiuqr8gjUl0JU+R8Rajr
         TVo1DukAy2xjz9K05fWaA03vS5OpXQrkk0Jj0HBUqCKVzk7FyCXXFvSWMN9CubEsxdaY
         27I098/7xwz89MP55EHBysOggP9Z1WDgHpjajGcIvuwVT5gTywglJKFwclMbG5adYYm8
         zSSClfwmlrsTS2yhZntkLX2V07Qxu7IYVS8+Yd5V3hD+FZ6N9JqQsHk9vbLeyTm4ZoHh
         Vo+g==
X-Forwarded-Encrypted: i=1; AJvYcCX4ldy1ii+Ha821Hy+ajkz3RxYqFBcIObZW9cB9FKUu75pN3/uUXbbElvYjMnTN+HnF8c2dPkXoRqGAitE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxk11QJr4D/RexyLHqMhmJium6kybbaw/LwUhKwWiGu0gUmcVqE
	AXYTg5KmEMbT1kHu/gUWu4pfLnj/EX4bnrxPhaaDgBCxCgGhAyxGkQPv062cSv4QS5Fcon/E2bm
	11hpXPJiVK/DrKtDtZ/L9tCKPRmtB3Zk=
X-Gm-Gg: ASbGncuh3dhu274oBBAK3nNjBLYNQh7cQGqGorQ/wLLdoQYyhAY7DyrsDoAIhZgyx0e
	14eVXpy1OIfmfzpTySySsr2QuFptRV41HNZi9e9KESyxNIjaDI3bPXahSPWkaAHhwj4jAtcs1UH
	mnpHjpioL5W67eqqLFybZekzMl4cAvBm4r0wpj9dXHfatWgglTeAu1zj+EFR+CoktjcY4KuBqUJ
	lVoCeHnfCjK/4sgDo0mVgI=
X-Google-Smtp-Source: AGHT+IFVMZr4QbmqcqxCgLtuTgFhRVYmfx2s+Lxtuz+jkt4cak2J7MG2Tktss3VzbUSEwI3Y7f8XzvgSq8XSb44Nuro=
X-Received: by 2002:a17:90b:380f:b0:32e:32e4:9789 with SMTP id
 98e67ed59e1d1-3342a257486mr5730580a91.3.1758841418424; Thu, 25 Sep 2025
 16:03:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250922075333.1452803-1-chen.dylane@linux.dev>
 <CAADnVQKtOCXdv-LJ-T6K_meAS26C_i4Yc0hOpYS46umsPmuQAQ@mail.gmail.com> <310091f8-ee17-4dfc-bbb4-1bb262cbfd98@linux.dev>
In-Reply-To: <310091f8-ee17-4dfc-bbb4-1bb262cbfd98@linux.dev>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 25 Sep 2025 16:03:24 -0700
X-Gm-Features: AS18NWCZqe86-2jnAA3oW2HxIVMTqCEDZ148AGumKP2KAEVMGbEn6_GmoZZgGN0
Message-ID: <CAEf4BzYL8NSRRZBj0=7aih01LZHAM67cDCAX5FwMW7WcQ_-f0g@mail.gmail.com>
Subject: Re: [PATCH bpf-next] bpf: Add preempt_disable to protect get_perf_callchain
To: Tao Chen <chen.dylane@linux.dev>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>, Song Liu <song@kernel.org>, 
	Jiri Olsa <jolsa@kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard <eddyz87@gmail.com>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	bpf <bpf@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 25, 2025 at 10:45=E2=80=AFAM Tao Chen <chen.dylane@linux.dev> w=
rote:
>
> =E5=9C=A8 2025/9/23 10:53, Alexei Starovoitov =E5=86=99=E9=81=93:
> > On Mon, Sep 22, 2025 at 12:54=E2=80=AFAM Tao Chen <chen.dylane@linux.de=
v> wrote:
> >>
> >> As Alexei suggested, the return value from get_perf_callchain() may be
> >> reused if another task preempts and requests the stack after BPF progr=
am
> >> switched to migrate disable.
> >>
> >> Reported-by: Alexei Starovoitov <ast@kernel.org>
> >> Signed-off-by: Tao Chen <chen.dylane@linux.dev>
> >> ---
> >>   kernel/bpf/stackmap.c | 14 +++++---------
> >>   1 file changed, 5 insertions(+), 9 deletions(-)
> >>
> >> diff --git a/kernel/bpf/stackmap.c b/kernel/bpf/stackmap.c
> >> index 2e182a3ac4c..07892320906 100644
> >> --- a/kernel/bpf/stackmap.c
> >> +++ b/kernel/bpf/stackmap.c
> >> @@ -314,8 +314,10 @@ BPF_CALL_3(bpf_get_stackid, struct pt_regs *, reg=
s, struct bpf_map *, map,
> >>          if (max_depth > sysctl_perf_event_max_stack)
> >>                  max_depth =3D sysctl_perf_event_max_stack;
> >>
> >> +       preempt_disable();
> >>          trace =3D get_perf_callchain(regs, 0, kernel, user, max_depth=
,
> >>                                     false, false);
> >> +       preempt_enable();
> >
> > This is obviously wrong.
> > As soon as preemption is enabled, trace can be overwritten.
> > guard(preempt)();
> > can fix it, but the length of the preempt disabled section
> > will be quite big.
> > The way get_perf_callchain() api is written I don't see
> > another option though. Unless we refactor it similar
> > to bpf_try_get_buffers().
> >
> > pw-bot: cr
>
> Hi Alexei,
>
> I tried to understand what you meant and looked at the implementation of
> get_perf_callchain.
>
> Only one perf_callchain_entry on every cpu right now.
>
> callchain_cpus_entries(rcu global avariable)
>      =E2=86=93
> struct callchain_cpus_entries {
>         struct perf_callchain_entry     *cpu_entries[];
>                         |
> }                       =EF=BD=9C-> perf_callchain_entry0    cpu0
>                              perf_callchain_entry1     cpu1
>                               =E2=80=A6
>                               perf_callchain_entryn     cpun
>
>
> If we want to realise it like bpf_try_get_buffers, we should
> alloc a perf_callchain_entry array on every cpu right?
>
> callchain_cpus_entries(rcu global avariable)
>      =E2=86=93
> struct callchain_cpus_entries {
>         struct perf_callchain_entry     *cpu_entries[];
>                         |
> }                       =EF=BD=9C-> perf_callchain_entry0[N]    cpu0
>                              perf_callchain_entry1[N]     cpu1
>                               =E2=80=A6
>                               perf_callchain_entryn[N]     cpun

Either allow a few entries per CPU (bpf_try_get_buffers allows up to 3
buffers per CPU), or extend get_perf_callchain() to accept
perf_callchain_entry from outside, and then we can do that in a
BPF-specific way.

>
> --
> Best Regards
> Tao Chen

