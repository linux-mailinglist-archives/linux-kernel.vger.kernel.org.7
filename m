Return-Path: <linux-kernel+bounces-880074-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 03B7DC24CE5
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 12:37:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 277A0467901
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 11:35:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90B253A1CD;
	Fri, 31 Oct 2025 11:35:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dmczZhTo"
Received: from mail-yx1-f41.google.com (mail-yx1-f41.google.com [74.125.224.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A342345CCD
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 11:35:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761910543; cv=none; b=i6NOC8n//jDWQiUeKObF6ordhvRm+Oi6q/ekUJ5owKqXw1bI5OVx5AqGPq3OgNzwBk12ZbjOPJrkw39CAt4Tu1qem/1SA2i3oWpGpp2aqnBBDwJwLr8BW5f85CZkvBTDNWRXdRSvr4shq4si8+xqdcMCAtVmAIb3T0vTlKqnCDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761910543; c=relaxed/simple;
	bh=zGfOY1YKgFGvpQyOBRrxFHQgGi+qTE8E9CATiNKrKcc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tCxAR5QunhPJhvjpd7YGRlrbRxVFu7jK6tw7G2AzM8mSiU8nLgsC/Vo65s3RYRzjhNx3CnGpENtxBR6+boc4yk/zI8X+rcmth92hxyYA2RFaZTs4LhzpWj0MnzXnL4vxvPK5EWwn6E+9rakfZItnlKmpraLCHHD9HXRE/ty7PCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dmczZhTo; arc=none smtp.client-ip=74.125.224.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f41.google.com with SMTP id 956f58d0204a3-63e336b1ac4so3576666d50.1
        for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 04:35:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761910541; x=1762515341; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sbYQROsqbxlCCT18FcNDkFe0rlrcvGndQ8kTMkEAgwk=;
        b=dmczZhTocGyCImgJzd+gMPfbpRCRNsfJ9UXVNKH/CVsAL/s3WuxWysiP44c1xxC3kn
         ps5fkQC0HjvhMKdADrLKUZqrOFIisFoE+fNa9O+8qS8NHkPrHwcumEArGFIzEZtDjMZj
         7ufN9FR7SqYBpZVnZUbwiiqTj3hhEZnxJcXoLJ26BLpIZGBVYcszIMCBdDsEyS+69yzm
         Dil7VXnVT22pZCfapyTkeRxpz2kmuM+KFeZACj1QjDiR0WlYS7Vp6WuftAgBIth1dnTA
         rMYQpGj7okJnGUFWOVqwxiqbvMETQUYLsSJC/zZgY8/Q/HlUcXLfF6F3J9QrUO131zLd
         lT2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761910541; x=1762515341;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sbYQROsqbxlCCT18FcNDkFe0rlrcvGndQ8kTMkEAgwk=;
        b=JJML4E8GYCKvP7P05+QmKzdFnP3BZ8yU/Ipf2KYeha0FjwTwo6FkG1rXZA0KAF8dtG
         qBie5oEjM8MARJRV20z/IOVQMReADHEvlLbLj86Gf2JyfBU0xyBxde+AVSTjvckcNsNs
         W+m9A4BJMFmn+RvoauK1cVWRxfrR/mNrhc/zi8YscxqM3+d17B/njX6lpTqe60LsrV/x
         exUCr+Gc2677pXbe4wjVx941FyZpzs6YNZStXZAT56OVW6ktELlN3EJQXrUUp0wzQoxT
         OfQ0lo01kgFzPjVP9IJ8oRTQqO7Oi27CG/bONM3zZLT2sKv4NFXLLwY/spKsWTJ4A3jD
         eipw==
X-Forwarded-Encrypted: i=1; AJvYcCUMYa3iqZvQ9EAm9sh86o4sZMfjy6QO8ECwhdkqwvjTXO8tAORHrABIqs4yRKdA38h3QvVG80dOSPh6iig=@vger.kernel.org
X-Gm-Message-State: AOJu0YyEIPRI3i1eHY0Lm7bKzPwzW4Dju+GGAdo6BKxwngM+3MKqQlIM
	vN6STMBy6KvJzEwM71BzaxPS0pA/L4xSMjGhpKCAW/3zV5VO8/X9qT4VLCcCXtX+Q4X3KXHGOJu
	o5LIlWiVjpOxGEmzQDAFt8a4I1RxLboQ=
X-Gm-Gg: ASbGncvCestIdW9ArXTiVkJaR9xzOHWZ25K3Gux/EKZ5TvqYMrKS2MxSYQ8XDTWn6IB
	swgwrgZRDgTJR/G7ebCxLm+bMp8gB3QY+xGU4I9cRTVfEa1GpnB+HvD3Rgtt46TccPzeIwBKi9y
	/TDYv3Ed/PkTLBwxgU4ylmEtD9nYK/73jMPfZFucSwCvxbwnrApMHQE7AZR4dkUEnPffXlk1LzB
	Ke+OqgPoIbnfDqd8jGev7a9HPfYETjfv53MSN0a2iXBSu+RY6bVqYs2iT0A6w==
X-Google-Smtp-Source: AGHT+IEu9dWSv5Gv4oIclWkYCdwjipk6IKPGLuplrWhNfsF2BSjzskyBODi71LrFaVQiUOiO05FML1vQlRoaBoKLGH4=
X-Received: by 2002:a05:690e:4311:b0:63f:471b:c949 with SMTP id
 956f58d0204a3-63f828dc3f4mr4262945d50.8.1761910541181; Fri, 31 Oct 2025
 04:35:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251027231727.472628-1-roman.gushchin@linux.dev>
 <20251027231727.472628-3-roman.gushchin@linux.dev> <CAHzjS_sLqPZFqsGXB+wVzRE=Z9sQ-ZFMjy8T__50D4z44yqctg@mail.gmail.com>
 <87zf98xq20.fsf@linux.dev> <CAHzjS_tnmSPy_cqCUHiLGt8Ouf079wQBQkostqJqfyKcJZPXLA@mail.gmail.com>
 <CAMB2axMkYS1j=KeECZQ9rnupP8kw7dn1LnGV4udxMp=f=qoEQA@mail.gmail.com>
 <877bwcus3h.fsf@linux.dev> <CAADnVQJGiH_yF=AoFSRy4zh20uneJgBfqGshubLM6aVq069Fhg@mail.gmail.com>
 <87bjloht28.fsf@linux.dev> <CAHzjS_vRrxTLR0kFJvm4R3kO0s8hyN5Onsr6XfbA3Peyasz+Cg@mail.gmail.com>
In-Reply-To: <CAHzjS_vRrxTLR0kFJvm4R3kO0s8hyN5Onsr6XfbA3Peyasz+Cg@mail.gmail.com>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Fri, 31 Oct 2025 19:35:05 +0800
X-Gm-Features: AWmQ_bnhSoJ6Ut36XhdxJDrXBHOIvRPVygYW6oOyCo1P7xEhTIcG9Z7qxfxs8eM
Message-ID: <CALOAHbAAjx+OAOd=2y-fQUTbPd6gxVeybJd3RoTLYahb_ZO8DA@mail.gmail.com>
Subject: Re: bpf_st_ops and cgroups. Was: [PATCH v2 02/23] bpf: initial
 support for attaching struct ops to cgroups
To: Song Liu <song@kernel.org>
Cc: Roman Gushchin <roman.gushchin@linux.dev>, 
	Alexei Starovoitov <alexei.starovoitov@gmail.com>, Amery Hung <ameryhung@gmail.com>, 
	Andrew Morton <akpm@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@kernel.org>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Johannes Weiner <hannes@cmpxchg.org>, 
	Andrii Nakryiko <andrii@kernel.org>, JP Kobryn <inwardvessel@gmail.com>, 
	linux-mm <linux-mm@kvack.org>, 
	"open list:CONTROL GROUP (CGROUP)" <cgroups@vger.kernel.org>, bpf <bpf@vger.kernel.org>, 
	Martin KaFai Lau <martin.lau@kernel.org>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, Tejun Heo <tj@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 31, 2025 at 2:14=E2=80=AFPM Song Liu <song@kernel.org> wrote:
>
> On Thu, Oct 30, 2025 at 4:24=E2=80=AFPM Roman Gushchin <roman.gushchin@li=
nux.dev> wrote:
> >
> > Alexei Starovoitov <alexei.starovoitov@gmail.com> writes:
> >
> > > On Thu, Oct 30, 2025 at 12:06=E2=80=AFPM Roman Gushchin
> > > <roman.gushchin@linux.dev> wrote:
> > >>
> > >> Ok, let me summarize the options we discussed here:
> > >>
> > >> 1) Make the attachment details (e.g. cgroup_id) the part of struct o=
ps
> > >> itself. The attachment is happening at the reg() time.
> > >>
> > >>   +: It's convenient for complex stateful struct ops'es, because a
> > >>       single entity represents a combination of code and data.
> > >>   -: No way to attach a single struct ops to multiple entities.
> > >>
> > >> This approach is used by Tejun for per-cgroup sched_ext prototype.
> > >
> > > It's wrong. It should adopt bpf_struct_ops_link_create() approach
> > > and use attr->link_create.cgroup.relative_fd to attach.
> >
> > This is basically what I have in v2, but Andrii and Song suggested that
> > I should use attr->link_create.target_fd instead.
> >
> > I have a slight preference towards attr->link_create.cgroup.relative_fd
> > because it makes it clear that fd is a cgroup fd and potentially opens
> > a possibility to e.g. attach struct_ops to individual tasks and
> > cgroups, but I'm fine with both options.
>
> relative_fd and relative_id have specific meaning. When multiple
> programs are attached to the same object (cgroup, socket, etc.),
> relative_fd and relative_id (together with BPF_F_BEFORE and
> BPF_F_AFTER) are used to specify the order of execution.
>
> >
> > Also, as Song pointed out, fd=3D=3D0 is in theory a valid target, so in=
stead of
> > using the "if (fd) {...}" check we might need a new flag. Idk if it
> > really makes sense to complicate the code for it.
> >
> > Can we, please, decide on what's best here?
>
> How about we add a new attach_type BPF_STRUCT_OPS_CGROUP?

I'm concerned that defining a unique BPF_STRUCT_OPS_XXX for each type
might lead to a maintainability challenge. To keep the design clean
and forward-looking, we might want to consider a more generic
abstraction that could easily accommodate other kernel structures
(task_struct, mm_struct, etc.) without duplication.

--=20
Regards
Yafang

