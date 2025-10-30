Return-Path: <linux-kernel+bounces-879211-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E3571C228A2
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 23:19:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C42534E3DE0
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 22:19:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AFEC33B6C2;
	Thu, 30 Oct 2025 22:19:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OjXjkS1I"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4251127FD72
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 22:19:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761862766; cv=none; b=MwdxjOtrMsqvS1GJVn3DIoH3lfhnv8ZcB8Lix/tNJcVV0q6siNWNU/HfexfOlzZhkTzobgFyvw0rXapaGDy20cj4gmnEjwlH5LLVl8MUi4xM62/hi48v/UNUAu+3ZecQt6NOUraPg5AFL1VLVyVl1Q2GlQss3vN/JY+uBH8/wes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761862766; c=relaxed/simple;
	bh=Q0NLfuAPRCRv2UVmufeZOfqT4b7DmYLGbcb7vMqjN8g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PXv7mu85NjiZJ72rBV+JnRPXoY5xCHvkgR5FNbz0UQKDi0aZS2u8mfrQjwRQxw9JolKV/MUYkbJqwSj6cNbS6y5N7jmFZTCkl3agnkJgCivzBMySeC7yImk2Eg7IqfAmulCHcC/JAw3KvPZAVt6qjeDbkuipsFKdKzYjps8d5IE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OjXjkS1I; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-470ffbf2150so16152835e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 15:19:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761862762; x=1762467562; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wwT0gzXBjfVIjqUHMyMXwgTVGE+oE1n+ZnWlhE9CZ5U=;
        b=OjXjkS1IDRMEsa3JaoykFfeSztq6wJvosHXa64fQAXuZSy9LFVkX7l3vlkq8/9Xd6j
         4f4UP4RhQoGgcVi1IU+M79alMqgX16ZhpM5hC4xzNUKTN4MB25wk/kSCIN5DeJcobX9P
         Sw+xhnHaxvHJKWnr3LlV6KOT2b9BEmn89S9hDxAq1mDT/ypy1YoszhniVjDgQEWLtQ62
         Sx+OBuluhCcDHN3nDx7AqBQO3cKirWQVr+SkC2wh18pMXGw7j5OlnwEqnxO/GcIgccXx
         vgomRqEdiXdL5W5Tg+BZx7JxxaWZX/vSN3Zzmg9ni4GDLOBd9hSTcvixS9Z0HxxxsDV7
         P/Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761862762; x=1762467562;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wwT0gzXBjfVIjqUHMyMXwgTVGE+oE1n+ZnWlhE9CZ5U=;
        b=mJBstq6Dh2SXSfRcGMl2FmN0lWZvswVqVHhABArOKXE8qQXquA0zv1viZXfiT7kXc9
         +bgnexgKbqsJJjHvD4bD+uRi2EEYQ33R0mOaxM4p85oHxXm0ySDTz/5Xu85IwUr86iIL
         O/7M4oEwm/mbNiT9fNx7+L6wy6+N9Z6jHErvEBzQ/1em+5xsNdzOfu+aXrXQpvmwyA1h
         VcSs8OS4viOaNbtFV8pCZIE3jRFQkMPg5kKvOC/wODxKe2xHBw6Rd+WcipIHRHBIHa68
         lNRiSdzcXzMWk2/pXigZfDpoFmOp7HkqBg9fWpahNtrjpwKAzqQarq0yZ+WeHo5lWpLz
         VyAw==
X-Forwarded-Encrypted: i=1; AJvYcCXo3Jlc/UwlYRHInaj4RwezC1jFUcjVYmqNXYNPIj/wQJyjZudk7cQfMs3gG0gyHlI+3UxiYveRwoxA56U=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxp3UUfIUL6DWfothghCc5aAoxxS+r2aAored+YlRgfIk7TbBjB
	Cqkx0IPBphOciczXkViM8w9LWG8M1ENLkRDx9hqBbyMevJyW8imvU1cSl1AEAN0cv4X22hPmmZY
	U4y5kd42v9ufPjgbAWTKCopxuHIywiVE=
X-Gm-Gg: ASbGncv4YRIAsD1ea72s4cK/RtqaPzxI36Jo+pcX6eSy7sjJ6/GZokvQL0yCDLyRYIK
	SznA+dK44rZxbMnCL8rYghrQUEm8ILqefcAbBkjqT4V+1OLX2+UL2u4g9PuJjf+j4QXkXZFnkxX
	czVB0yowJFaDut0R2XJdKEFghrCNx4l6LxIw/Z8m3Okwsl29chH/cBkFyxtflbhOgI7UYL4ZhGT
	RbApOvs/k8ZpcYDL7MxB1bEkiFxlG72mA5s6XuINtf4KM3yySN78GsOKDH4w7pOlW/CaKF0Fea2
	Z3ImJDuo37WDl5xa8HMY4J79Ql2b
X-Google-Smtp-Source: AGHT+IFiyX3dJnURSNNpVr0vY2zqjAiRZhDfNNfk8vGHPMc1PF33QyAD/7tk5XU1FaTuD+gAkKoljP+gHiDD9PWESHk=
X-Received: by 2002:a05:600c:8189:b0:475:de75:84c6 with SMTP id
 5b1f17b1804b1-477262a941emr44348555e9.12.1761862762377; Thu, 30 Oct 2025
 15:19:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251027231727.472628-1-roman.gushchin@linux.dev>
 <20251027231727.472628-3-roman.gushchin@linux.dev> <CAHzjS_sLqPZFqsGXB+wVzRE=Z9sQ-ZFMjy8T__50D4z44yqctg@mail.gmail.com>
 <87zf98xq20.fsf@linux.dev> <CAHzjS_tnmSPy_cqCUHiLGt8Ouf079wQBQkostqJqfyKcJZPXLA@mail.gmail.com>
 <CAMB2axMkYS1j=KeECZQ9rnupP8kw7dn1LnGV4udxMp=f=qoEQA@mail.gmail.com> <877bwcus3h.fsf@linux.dev>
In-Reply-To: <877bwcus3h.fsf@linux.dev>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 30 Oct 2025 15:19:11 -0700
X-Gm-Features: AWmQ_bncjILdks5wFOJTGOLbyWVnc9Lf7_PQRe6yc5ZnQYFFDm9_YYMU7X8G_V0
Message-ID: <CAADnVQJGiH_yF=AoFSRy4zh20uneJgBfqGshubLM6aVq069Fhg@mail.gmail.com>
Subject: bpf_st_ops and cgroups. Was: [PATCH v2 02/23] bpf: initial support
 for attaching struct ops to cgroups
To: Roman Gushchin <roman.gushchin@linux.dev>
Cc: Amery Hung <ameryhung@gmail.com>, Song Liu <song@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@kernel.org>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Johannes Weiner <hannes@cmpxchg.org>, 
	Andrii Nakryiko <andrii@kernel.org>, JP Kobryn <inwardvessel@gmail.com>, 
	linux-mm <linux-mm@kvack.org>, 
	"open list:CONTROL GROUP (CGROUP)" <cgroups@vger.kernel.org>, bpf <bpf@vger.kernel.org>, 
	Martin KaFai Lau <martin.lau@kernel.org>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, Tejun Heo <tj@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 30, 2025 at 12:06=E2=80=AFPM Roman Gushchin
<roman.gushchin@linux.dev> wrote:
>
> Ok, let me summarize the options we discussed here:
>
> 1) Make the attachment details (e.g. cgroup_id) the part of struct ops
> itself. The attachment is happening at the reg() time.
>
>   +: It's convenient for complex stateful struct ops'es, because a
>       single entity represents a combination of code and data.
>   -: No way to attach a single struct ops to multiple entities.
>
> This approach is used by Tejun for per-cgroup sched_ext prototype.

It's wrong. It should adopt bpf_struct_ops_link_create() approach
and use attr->link_create.cgroup.relative_fd to attach.
At that point scx can enforce that it attaches to one cgroup only
if it simplifies things for sched-ext. That's fine.
But api must be link based.
Otherwise cgroup_id inside st_ops all the way from bpf prog
will not be backward compatible if/when people would want
to attach the same sched-ext to multiple cgroups.

> 2) Make the attachment details a part of bpf_link creation. The
> attachment is still happening at the reg() time.
>
>   +: A single struct ops can be attached to multiple entities.
>   -: Implementing stateful struct ops'es is harder and requires passing
>      an additional argument (some sort of "self") to all callbacks.

sched-ext is already suffering from lack of 'this'.
The current workarounds with prog_assoc and aux__prog are not great.
We should learn from that mistake instead of repeating it with bpf-oom.

As far as 'this' I think we should pass
'struct bpf_struct_ops_link *' to all callbacks.
This patch is proposing to have cougrp_id in there.
It can be a pointer to cgroup too. This detail we can change later.

We can brainstorm a way to pass 'link *' in run_ctx,
and have an easy way to access it from ops and from kfuncs
that ops will call.
The existing tracing style bpf_set_run_ctx() should work for bpf-oom,
and 'link *'->cgroup_id->cgrp->memcg will be there for ops
and for kfuncs, but it doesn't quite work for sched-ext as-is
that wants run_ctx to be different for sched-ext-s
attached at different levels of hierarchy.
Maybe additional bpf_set_run_ctx() while traversing
hierarchy will do the trick?
Then we might not even need aux_prog and kf_implicit_args that much.
Though they may be useful on their own though.

> I'm using this approach in the bpf oom proposal.
>
> 3) Move the attachment out of .reg() scope entirely. reg() will register
> the implementation system-wide and then some 3rd-party interface
> (e.g. cgroupfs) should be used to select the implementation.

We went that road with ioctl-s and subsystem specific ways to attach.
All of them sucked. link_create is the only acceptable approach
because it returns FD.

