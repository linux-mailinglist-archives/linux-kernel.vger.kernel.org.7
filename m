Return-Path: <linux-kernel+bounces-823894-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 76A4DB87AC4
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 04:03:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D76311C86CFF
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 02:03:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D67372475C8;
	Fri, 19 Sep 2025 02:01:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NVTHnMdd"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F20719E7F7
	for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 02:01:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758247313; cv=none; b=i9+6DHWnYD2DqExuYY1O9YavSAjzbBWyZABPODxZzZp/yDoW09A229FMLc+/I4pjYUIKDGfya9DrFuGE5L+5UiYHDTnM9RRCtnJt/9ypAzVrwv0WR0n1iFIwB4WlykAtYvV/lOfPoMA7LKRNxN4BQy/4pfLIeCLkL6cw6oHPmF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758247313; c=relaxed/simple;
	bh=GFt8pFuik9xBCtcF6v21dOZpA6lIwmUZgdZDpPfX3Ag=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ufq+uia7zCKQaDFxTaMjGCO+56m0PJSk6CaZf9ne6818VtAbf3cD0BXEGw7JK87fNlVC6E9OXAOSNwtp6rFos/XczTIoxpGf3W8A47YbIwISXCb3UiGNbSgD+R5MEUHA7FOAIBIcsHaRecXcTiT8XolmeskKEh6v88dCy00yi94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NVTHnMdd; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-45df7dc1b98so9396045e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 19:01:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758247310; x=1758852110; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l5WUqAepWLoNLD7FRaeKdFUWeAJ0W7lZ+MsRWC9QyZ0=;
        b=NVTHnMddvk9fHECdZ/gx23JK+0qTWni77btsPMqs22zXWpMkbvwu46x6aVgSA9Wo+L
         aMTsXy6Rgsoyiig34Q3pfybCk1/GitHnqVZKOXOSO3/q5zwNqF4gmn/IciczNqPzIX0w
         Bkx6FTGVZJuAQtNaTju8K42cNJXVDvA0YhFJpS4MHTMD7WURfvC+Rc8crq665Uf86yVM
         0l1majrcIkuegjwH5JC7zogSyp5VdtyujYG98dLnVj6egleIz4JUiv8Ob0120oCLDRBW
         0EbxBNUC7k50hJHso68BpLY/n4OpAdmAFzOYQp64yfzWd5EPK44HdEvH+jmCY8WCt1XS
         61Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758247310; x=1758852110;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=l5WUqAepWLoNLD7FRaeKdFUWeAJ0W7lZ+MsRWC9QyZ0=;
        b=QNX1L4EN9cGcr9h4ncMukENTB4Id/NE3H3sb6xKFYIvMgI/PAZ8R/128xhWlru/FL1
         6ElFd4UB/ZYIOm/j3L9Hz1Lc2VSLHoFQrN49bQYFfztadvoTVIpFycTQPKc9Qxtrk5uL
         tGnMr6wfnoS2Jh+mokNxrvRpuu/r9E/ruC0JS2bwSfsplA8ZhewZ23giAiZ2ChGsuD7z
         v8Vt9HBjuR0FQvYWag7fY7VLs55FqmSuzIHrJ3LrDTQAO7vWEZ2UlCyf3o4aaugn5Uz/
         12sfdOwl3ZM4tI2P/ufGrf1j3VfxjGmiZPUzCxotS4TiT35quBgX5c9VGjojEoQGcw/3
         2y3w==
X-Forwarded-Encrypted: i=1; AJvYcCVr3o/ZNlg1U0vpyql7vVyYtz1L0ngYpub7uRGMWdeLOpzxXrRZ9p8egWZ6HkzV0SuHrSSt12yhhKpVx7M=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzw0dEMC62V1tF3+PplEF65l+hXVCaLqT2nLDOd5f/lALisd84c
	Z/POC56yHojJqWaYhZ8hMkYwQsdmk3ksTVzIPgVEaYAx1UC/WoKx0C/KHG77Q0h1HHtgS59mqa7
	YwlBAe2Z+wN0Qf+tVmzOuWciNEN9wowM=
X-Gm-Gg: ASbGnctlliLUi2oH4VXgIN2S4jcdy9nyzU5q4GlXRaKnOdhrgV3+nB9qJqpK/rLqqF0
	cLILWh9VRXgLySFDE6EGLQnerlAVFYSRLUTwBiszasmep/QKe+XwIOogNhEHN3ERC2XMtOkFW3E
	SQpecUgiFBjm2nWzcov0uQxWoYWg2SiSTYwqRXTt6guNVzeTUoCT08B38bNzfGhWaX1odMkvc4V
	W2fP+AKaO68Tx8khOwrIS3Kc7tzgzzJcAt+bQmPEiISSJg=
X-Google-Smtp-Source: AGHT+IGqrAFmcKNFldXwl+7lGTYe5vLdPKGJ3FDX6GFFmDnR/ksftzRaTmDcFLsw0OzFBwVfJXvS93pGqqn07g8Sud0=
X-Received: by 2002:a05:600c:3b26:b0:43c:ec4c:25b4 with SMTP id
 5b1f17b1804b1-467e7f7d558mr10524025e9.10.1758247309372; Thu, 18 Sep 2025
 19:01:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250909163223.864120-1-chen.dylane@linux.dev>
 <CAEf4BzZ2Fg+AmFA-K3YODE27br+e0-rLJwn0M5XEwfEHqpPKgQ@mail.gmail.com>
 <CAADnVQ+s8B7-fvR1TNO-bniSyKv57cH_ihRszmZV7pQDyV=VDQ@mail.gmail.com> <457b805f-ea5c-460e-b93f-b7b63f3358af@linux.dev>
In-Reply-To: <457b805f-ea5c-460e-b93f-b7b63f3358af@linux.dev>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 18 Sep 2025 19:01:37 -0700
X-Gm-Features: AS18NWAUCzCGY0hlax5izykpElRA9BP19wAxU45go4krfvf0sGMlA8XbTCJNj8w
Message-ID: <CAADnVQLwV=fUkgLF3uTmevA97WX2FH4vG-7=97Px0H_WJOJieQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 1/2] bpf: Add lookup_and_delete_elem for BPF_MAP_STACK_TRACE
To: Tao Chen <chen.dylane@linux.dev>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, John Fastabend <john.fastabend@gmail.com>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, Eduard <eddyz87@gmail.com>, 
	Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	bpf <bpf@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 18, 2025 at 6:35=E2=80=AFAM Tao Chen <chen.dylane@linux.dev> wr=
ote:
>
> =E5=9C=A8 2025/9/18 09:35, Alexei Starovoitov =E5=86=99=E9=81=93:
> > On Wed, Sep 17, 2025 at 3:16=E2=80=AFPM Andrii Nakryiko
> > <andrii.nakryiko@gmail.com> wrote:
> >>
> >>
> >> P.S. It seems like a good idea to switch STACKMAP to open addressing
> >> instead of the current kind-of-bucket-chain-but-not-really
> >> implementation. It's fixed size and pre-allocated already, so open
> >> addressing seems like a great approach here, IMO.
> >
> > That makes sense. It won't have backward compat issues.
> > Just more reliable stack_id.
> >
> > Fixed value_size is another footgun there.
> > Especially for collecting user stack traces.
> > We can switch the whole stackmap to bpf_mem_alloc()
> > or wait for kmalloc_nolock().
> > But it's probably a diminishing return.
> >
> > bpf_get_stack() also isn't great with a copy into
> > perf_callchain_entry, then 2nd copy into on stack/percpu buf/ringbuf,
> > and 3rd copy of correct size into ringbuf (optional).
> >
> > Also, I just realized we have another nasty race there.
> > In the past bpf progs were run in preempt disabled context,
> > but we forgot to adjust bpf_get_stack[id]() helpers when everything
> > switched to migrate disable.
> >
> > The return value from get_perf_callchain() may be reused
> > if another task preempts and requests the stack.
> > We have partially incorrect comment in __bpf_get_stack() too:
> >          if (may_fault)
> >                  rcu_read_lock(); /* need RCU for perf's callchain belo=
w */
> >
> > rcu can be preemptable. so rcu_read_lock() makes
> > trace =3D get_perf_callchain(...)
> > accessible, but that per-cpu trace buffer can be overwritten.
> > It's not an issue for CONFIG_PREEMPT_NONE=3Dy, but that doesn't
> > give much comfort.
>
> Hi Alexei,
>
> Can we fix it like this?
>
> -       if (may_fault)
> -               rcu_read_lock(); /* need RCU for perf's callchain below *=
/
> +       preempt_diable();
>
>          if (trace_in)
>                  trace =3D trace_in;
> @@ -455,8 +454,7 @@ static long __bpf_get_stack(struct pt_regs *regs,
> struct task_struct *task,
>                                             crosstask, false);
>
>          if (unlikely(!trace) || trace->nr < skip) {
> -               if (may_fault)
> -                       rcu_read_unlock();
> +               preempt_enable();
>                  goto err_fault;
>          }
>
> @@ -475,9 +473,7 @@ static long __bpf_get_stack(struct pt_regs *regs,
> struct task_struct *task,
>                  memcpy(buf, ips, copy_len);
>          }
>
> -       /* trace/ips should not be dereferenced after this point */
> -       if (may_fault)
> -               rcu_read_unlock();
> +       preempt_enable();

That should do it. Don't see an issue at first glance.

