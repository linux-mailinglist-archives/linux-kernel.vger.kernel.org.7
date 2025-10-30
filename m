Return-Path: <linux-kernel+bounces-878907-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B4E5C21BAA
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 19:20:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1B32B3B5E3D
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 18:20:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA11C32ABD1;
	Thu, 30 Oct 2025 18:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TTPtHy8C"
Received: from mail-yx1-f52.google.com (mail-yx1-f52.google.com [74.125.224.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 877301548C
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 18:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761848409; cv=none; b=rrBfPtiN12Z/ly1pNUedUU3PIUr1u/zyO43JNn0hQEUJnZdJj8GOZN/5nNdb/YKPoqmJK2ERFQDOa+Dww8nDNU3jqsHcyrLVog6gjOKMuQrekRHg8EvtDreYtJPbtGfUid4tNQoiQnL8glTTAsv3rVEV0zV/JBPI0qWXsaV7Uuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761848409; c=relaxed/simple;
	bh=jt/qBYJIOeOFwtHbOH5zYk4RkZfESLzUExJtxgVMyw8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OPRcqnPXDEyh+mO26ThattVwq5R7fLuboLOLlD7+o0R+bBKdv9GQ5kYoUSIXoKQfsA/1L6gdf+lzfoa5CoGV1FVtfj6t3UlnENaEpOPWa707I14V8jqlUs9BtQEXcI0j/mCCLVyGUFQWKG6q5hnJKJLTigipnKOfRiPoxLbG4BU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TTPtHy8C; arc=none smtp.client-ip=74.125.224.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f52.google.com with SMTP id 956f58d0204a3-63e0dd765a0so1497037d50.3
        for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 11:20:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761848406; x=1762453206; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=109chwgkwyzi06JaRr4D3LMqLJ/YTAxWxAAZVd/ElR0=;
        b=TTPtHy8CRWleL/ekF9vQeaqx4euOFaNNWn5LKiDli5ffDOBhhDQ+EAcIW+kavLS1TQ
         PxLUVtLfDuG/LCgZWvC0xH60fleLrnYWwTRR43lteN0fa3NMF3uOFST73FbMHxIC2/jA
         v/TkansXVum2ly1nO4vsoqBaLvZHQE8eFRXz8LeGCuO8txA3e+JKU0dA2wCjzUXdlB7L
         XBHs4ZcTbFrh+xLCW21cPuV4lhdh9gElayGgMQ8m/3pIguW+augMAdRWguexh5km9h6a
         /gFata82jtBWrherZGkXJwpRkwPN4JnSJjLnCzkAh4D+ovL3qSMHELWrjVzv3VUtvZ+2
         mzdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761848406; x=1762453206;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=109chwgkwyzi06JaRr4D3LMqLJ/YTAxWxAAZVd/ElR0=;
        b=FD3dCdcKEBcfz79rwzo7aoJ18pIfMz+DdRThlQNUFDgb40kUgExfssLEXmS/UY473I
         hVKaF/fB95r3FkLq9VvTVy2vw8X/8QoILtkV1P61XQ9g30JmQxo4fdiDIWVEzckE+qJC
         qcP10Co+X3IvY0TpXnBifYvzSPz+wHdPCkaCwoqDXP9AxFGODtDNFCDqz0DN1nQgtz6O
         lXTbUrjvaEfP6f13s63/0hYSXfJreQrbjI7EGpVRasX95eFdEEaYhOKHgNWSxPUvjfKV
         XqdpYw4YBca+api7gavrMNX79wVa2BqxAakNaZ1FNWVhkgDJoqtts7B/uID1M5QkUJv9
         5vVw==
X-Forwarded-Encrypted: i=1; AJvYcCWTMDTGpfYC8n6vutTxEVAlrApckr6Do4d98vomeWgymarDvZUZ8qL/niLYPtRL0fEaBv4uNH+J2UoEfpQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxLUqeC+TG3xX0TQEpKg+okj5OKQtKwRrtxT2BPkbkEnyJukeAq
	ROGn8o3YBn3EzYZ5lfUv54qquMcCUlkvGeG+/Wc0qXo/UBzNNdX33V0lc/85utbVrIkz4o4Y39M
	rPQ9CBKIaum97eZgcSdTvDhXlTNpmHyc=
X-Gm-Gg: ASbGnct+Dbhs8W9GESCNMVb8t4NsgEJZF9yR5mRaCnu0oBce+cxdNcfFSzG46767oug
	B7EH5v0vzUkLbkI08yKf2hdt/2CZqq25NqeO0LZkwL482Klqpb6e5XJSJQ6P7sx/HZQPQKPMOtY
	I42oWWbS/Ba+aAQYXOXMDQRTE6AvbmnDCCxKhsqtGGUn3/hGnxunaecqrYLS+Q0/wib4wo3iUZY
	IvNStHeJk/we1CHmezItKHH201s6NHgMWFTy6XGQRcNlkizJxjkqGqCbXF0iQyrng39Azrzu4cH
	UtcTMhSXY7I=
X-Google-Smtp-Source: AGHT+IHKbL8ofjlCsmGkHmIIbYHwwwbI3UCw8KC2XPnz0NNn+Py3t0X37OVPJ2XMR6wmDS50IynVTGupm5236DxxcP8=
X-Received: by 2002:a05:690c:6103:b0:785:c086:aa51 with SMTP id
 00721157ae682-78648435fc3mr8623737b3.25.1761848406521; Thu, 30 Oct 2025
 11:20:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251027231727.472628-1-roman.gushchin@linux.dev>
 <20251027231727.472628-3-roman.gushchin@linux.dev> <CAHzjS_sLqPZFqsGXB+wVzRE=Z9sQ-ZFMjy8T__50D4z44yqctg@mail.gmail.com>
 <87zf98xq20.fsf@linux.dev> <CAHzjS_tnmSPy_cqCUHiLGt8Ouf079wQBQkostqJqfyKcJZPXLA@mail.gmail.com>
In-Reply-To: <CAHzjS_tnmSPy_cqCUHiLGt8Ouf079wQBQkostqJqfyKcJZPXLA@mail.gmail.com>
From: Amery Hung <ameryhung@gmail.com>
Date: Thu, 30 Oct 2025 11:19:52 -0700
X-Gm-Features: AWmQ_bkLArZ_9Xo7aHFRx3Y_Fcg5RHa9nGJniHAp-qT8VVY1Zm9_Hwf5WmIwP68
Message-ID: <CAMB2axMkYS1j=KeECZQ9rnupP8kw7dn1LnGV4udxMp=f=qoEQA@mail.gmail.com>
Subject: Re: [PATCH v2 02/23] bpf: initial support for attaching struct ops to cgroups
To: Song Liu <song@kernel.org>
Cc: Roman Gushchin <roman.gushchin@linux.dev>, Andrew Morton <akpm@linux-foundation.org>, 
	linux-kernel@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@kernel.org>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Johannes Weiner <hannes@cmpxchg.org>, 
	Andrii Nakryiko <andrii@kernel.org>, JP Kobryn <inwardvessel@gmail.com>, linux-mm@kvack.org, 
	cgroups@vger.kernel.org, bpf@vger.kernel.org, 
	Martin KaFai Lau <martin.lau@kernel.org>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, Tejun Heo <tj@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 30, 2025 at 11:09=E2=80=AFAM Song Liu <song@kernel.org> wrote:
>
> On Thu, Oct 30, 2025 at 10:22=E2=80=AFAM Roman Gushchin
> <roman.gushchin@linux.dev> wrote:
> >
> > Song Liu <song@kernel.org> writes:
> >
> > > On Mon, Oct 27, 2025 at 4:17=E2=80=AFPM Roman Gushchin <roman.gushchi=
n@linux.dev> wrote:
> > > [...]
> > >>  struct bpf_struct_ops_value {
> > >>         struct bpf_struct_ops_common_value common;
> > >> @@ -1359,6 +1360,18 @@ int bpf_struct_ops_link_create(union bpf_attr=
 *attr)
> > >>         }
> > >>         bpf_link_init(&link->link, BPF_LINK_TYPE_STRUCT_OPS, &bpf_st=
ruct_ops_map_lops, NULL,
> > >>                       attr->link_create.attach_type);
> > >> +#ifdef CONFIG_CGROUPS
> > >> +       if (attr->link_create.cgroup.relative_fd) {
> > >> +               struct cgroup *cgrp;
> > >> +
> > >> +               cgrp =3D cgroup_get_from_fd(attr->link_create.cgroup=
.relative_fd);
> > >
> > > We should use "target_fd" here, not relative_fd.
> > >
> > > Also, 0 is a valid fd, so we cannot use target_fd =3D=3D 0 to attach =
to
> > > global memcg.
> >
> > Yep, but then we need somehow signal there is a cgroup fd passed,
> > so that struct ops'es which are not attached to cgroups keep working
> > as previously. And we can't use link_create.attach_type.
> >
> > Should I use link_create.flags? E.g. something like add new flag
> >
> > @@ -1224,6 +1224,7 @@ enum bpf_perf_event_type {
> >  #define BPF_F_AFTER            (1U << 4)
> >  #define BPF_F_ID               (1U << 5)
> >  #define BPF_F_PREORDER         (1U << 6)
> > +#define BPF_F_CGROUP           (1U << 7)
> >  #define BPF_F_LINK             BPF_F_LINK /* 1 << 13 */
> >
> >  /* If BPF_F_STRICT_ALIGNMENT is used in BPF_PROG_LOAD command, the
> >
> > and then do something like this:
> >
> > int bpf_struct_ops_link_create(union bpf_attr *attr)
> > {
> >         <...>
> >         if (attr->link_create.flags & BPF_F_CGROUP) {
> >                 struct cgroup *cgrp;
> >
> >                 cgrp =3D cgroup_get_from_fd(attr->link_create.target_fd=
);
> >                 if (IS_ERR(cgrp)) {
> >                         err =3D PTR_ERR(cgrp);
> >                         goto err_out;
> >                 }
> >
> >                 link->cgroup_id =3D cgroup_id(cgrp);
> >                 cgroup_put(cgrp);
> >         }
> >
> > Does it sound right?
>
> I believe adding a flag (BPF_F_CGROUP or some other name), is the
> right solution for this.
>
> OTOH, I am not sure whether we want to add cgroup fd/id to the
> bpf link. I personally prefer the model used by TCP congestion
> control: the link attaches the struct_ops to a global list, then each
> user picks a struct_ops from the list. But I do agree this might be
> an overkill for cgroup use cases.

+1.

In TCP congestion control and BPF qdisc's model:

During link_create, both adds the struct_ops to a list, and the
struct_ops can be indexed by name. The struct_ops are not "active" by
this time.
Then, each has their own interface to 'apply' the struct_ops to a
socket or queue: setsockopt() or netlink.

But maybe cgroup-related struct_ops are different.

-Amery

>
> Thanks,
> Song
>

