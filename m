Return-Path: <linux-kernel+bounces-877316-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2864DC1DD17
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 00:53:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5BBCF188FEC0
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 23:54:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D4E9221721;
	Wed, 29 Oct 2025 23:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GdjEmTlF"
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B88E31E11D
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 23:53:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761782003; cv=none; b=nh+mSimZ33HadXnmUwewuI0sU2taVQMAlHdl27nmn0yX1bP6hi4awjz6Ppb0mfdEn3G2Lp5GCCvggPAVANgE0+Bu5pE5opb07WMQECDTh+2ZtFBua/gIj1HDXtI+ntreig15+yp1AntRDMvPGq+pJuvmXSIKwJX4k+GIPayMMSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761782003; c=relaxed/simple;
	bh=D2m0EPDbKpZ3JRo0DT82GnQ89LW7K7rjeczuEkHf41c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DwKaZNkyxwAC0hNJuYw69/+8Q1CKKYqs0tq7Hz4isCKkLipEiR884fuoO8Ja6hiJJietXpclUqO4PnDaVrWDrZFkyLmh7Sr6/Y6nKko9kqGv5tO9uAAKqYb883NOUlL7ygnEJcrrTce4Mc338RMu/UxK+Zi6QnrRWz9tGJUggqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GdjEmTlF; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-3f0ae439bc3so218800f8f.1
        for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 16:53:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761781999; x=1762386799; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tPZgBPK4KYbf0wiRz1OKb0KetLC+LXdJvV1wxFVXEDg=;
        b=GdjEmTlFtXhTuQnUYJW+l0CfSZil3NOWdcMOyTAXh5I70y6DEjmmTxMNcoW7NaLTEa
         SAy6cQec1OySTTXC5MGmJWDdby8z3p9gdF7DzIDggB+3df2Kp3eJbb1Uprx+O1IEMbQP
         MJDc3yUEFAvpfPUuivxzBLmhICzm0/mxjw+xNP3rxBFli80mD6knr3G+DKcIgbZsFucp
         wi9WxIrZCghgbFLFswKp874Hx3Hi69+RVFmrGj8gWqvfLBQBxRB+x1Zf5/1zlLsMRMe3
         +aJuRwE5VSq5PvqyR+Wxb7/2fLXeu/8dWOhl5/yiBjTzeM2oyHQgOyOGO4KjUdoJBVPy
         aIPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761781999; x=1762386799;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tPZgBPK4KYbf0wiRz1OKb0KetLC+LXdJvV1wxFVXEDg=;
        b=GIfuVfZ5XaDx2gN4dXhWlaURObDedrrgHKJd2nCjI3mKPM7cjiCFqpsDKQOXHJMmD7
         KlnIPL0kYkssuz7eXJPzhoMQzFkymYozuKRGIfu2Ai3H4k6UzjBt7P2ZjDAor92gKfEr
         KHKLfJCNadtoJrZBQuHPP6qjqTp5wcVB/GCEZ5O+qvu5JjlDhzi1/fsTLyi963kUOn0l
         HMGrysek2Qo3MG8pMfiEAki1PbR/lYVtcD79Keq4IrgjkBCNeHhsVjQ6uldTMyAH5Zcr
         l7iERows/9OZvhDZR8EALv1hSPxd39RuVmP4+6kBzr2tcSvee+AOOJfWa7K9bcTB+8rF
         bGtA==
X-Forwarded-Encrypted: i=1; AJvYcCVEtP25g2o3iaLDf3MfwLinBP3D6+GxqnKqFxMPtQX11AK76MVlETXnbiX4QLNHXN3OWzsgvFHHTi55Y4s=@vger.kernel.org
X-Gm-Message-State: AOJu0YyROaw3EKZuyS297OBDZpBsdLVIPWVZPr066dshC8thZEIwHXnQ
	V7km31fHLzWw7Um7gmOeKwnPqMWBxDAgA+bPE1oI0BNfgUMsCYqnu9rvfAcIxVnF7syjksS2xgl
	Y8xhzp+EUsgNbMY5PLfk1DAHWws8gE0w=
X-Gm-Gg: ASbGncvvFx1gfY+te2NYYLWbYVoTtgfJWyLwaGLkQYgC0Kvl3sDRT22sGgcxp2u3Bdw
	BvXSHy6EOKOhVGC9PrOBL8V6KeM5d7lS/BINAudC7ACJB4WvowR13nTtA5GAYWhAekGyV+U1KNB
	d8yyvQ2zAw0k1hBueyW7DHmrs3AItzDPmOcCgcevQz1MGnUAjatKtP1JUAsP8Z5UiXe/SULsf+E
	YGYgo0phQeiYyTSgwlCgkjsjkuQPaCs39mQutQGkVrtuIwMfJ/RjJC7BEzBpEgIXXYWEEuDt5PO
	PX3om/BPM5ibZK69+WOk9fmLiisaTeuIW4no7o8=
X-Google-Smtp-Source: AGHT+IGrKp5MfacnbzNbpqAIhTO7ERG2WHtS4t6jru8KJPhlxG//rUzfqdjALv0fSxc61RpV8oyRKHl4WsT9w4GfLtM=
X-Received: by 2002:a05:6000:2005:b0:425:7e38:419f with SMTP id
 ffacd0b85a97d-429aef82fd5mr3552778f8f.16.1761781999226; Wed, 29 Oct 2025
 16:53:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251027231727.472628-1-roman.gushchin@linux.dev>
 <20251027231727.472628-3-roman.gushchin@linux.dev> <aQJZgd8-xXpK-Af8@slm.duckdns.org>
 <87ldkte9pr.fsf@linux.dev> <aQJ61wC0mvzc7qIU@slm.duckdns.org>
 <CAHzjS_vhk6RM6pkfKNrDNeEC=eObofL=f9FZ51tyqrFFz9tn1w@mail.gmail.com>
 <871pmle5ng.fsf@linux.dev> <CAADnVQJ+4a97bp26BOpD5A9LOzfJ+XxyNt4bdG8n7jaO6+nV3Q@mail.gmail.com>
 <aQKa5L345s-vBJR1@slm.duckdns.org>
In-Reply-To: <aQKa5L345s-vBJR1@slm.duckdns.org>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 29 Oct 2025 16:53:07 -0700
X-Gm-Features: AWmQ_bmmWr20Sr7nISe9-dxnu7qiuhrtBr-MHR5CpH7Nay8Y8PduHzn8NSxStmM
Message-ID: <CAADnVQJp9FkPDA7oo-+yZ0SKFbE6w7FzARosLgzLmH74Vv+dow@mail.gmail.com>
Subject: Re: [PATCH v2 02/23] bpf: initial support for attaching struct ops to cgroups
To: Tejun Heo <tj@kernel.org>
Cc: Roman Gushchin <roman.gushchin@linux.dev>, Song Liu <song@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@kernel.org>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Johannes Weiner <hannes@cmpxchg.org>, 
	Andrii Nakryiko <andrii@kernel.org>, JP Kobryn <inwardvessel@gmail.com>, 
	linux-mm <linux-mm@kvack.org>, 
	"open list:CONTROL GROUP (CGROUP)" <cgroups@vger.kernel.org>, bpf <bpf@vger.kernel.org>, 
	Martin KaFai Lau <martin.lau@kernel.org>, Kumar Kartikeya Dwivedi <memxor@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 29, 2025 at 3:53=E2=80=AFPM Tejun Heo <tj@kernel.org> wrote:
>
> Hello,
>
> On Wed, Oct 29, 2025 at 03:43:39PM -0700, Alexei Starovoitov wrote:
> ...
> > I think the general bpf philosophy that load and attach are two
> > separate steps. For struct-ops it's almost there, but not quite.
> > struct-ops shouldn't be an exception.
> > The bpf infra should be able to load a set of progs (aka struct-ops)
> > and attach it with a link to different entities. Like cgroups.
> > I think sched-ext should do that too. Even if there is no use case
> > today for the same sched-ext in two different cgroups.
>
> I'm not sure it's just that there's no use case.

I think there will be a use case for sched-ext as well,
just the current way the scheds are written is too specific.
There is cgroup local storage, so scheds can certainly
store whatever state there.
Potentially we can improve UX further by utilizing __thread on bpf.c
side in some way.

> - How would recursion work with private stacks? Aren't those attached to
>   each BPF program?

yes. private stack is per prog, but why does it matter?
I'm not suggesting that the same prog to be attached at different
levels of the cgroup hierarchy, because such configuration
will indeed trigger recursion prevention logic (with or without private
stack).
But having one logical sched-ext prog set to manage tasks
in container A and in container B makes sense as a use case to me
where A and B are different cgroups.
DSQs can be cgroup scoped too.

> - Wouldn't that also complicate attributing kfunc calls to the handle
>   instance?

you mean the whole prog_assoc stuff ?
That's orthogonal. tracing progs are global so there is
no perfect place to associate them with. struct-ops map
is the best we can do today, but ideally it's run_ctx
that should be per-attachment. Like cookie.

> If there is one struct_ops per cgroup, the oom kill kfunc can
>   look that up and then verify that the struct_ops has authority over the
>   target process. Multiple attachments can work too but that'd require
>   iterating all attachments, right?

Are you talking about bpf_oom_kill_process() kfunc from these patch set?
I don't think it needs any changes. oom context is passed into prog
and passed along to kfunc. Doesn't matter the cgroup origin.

