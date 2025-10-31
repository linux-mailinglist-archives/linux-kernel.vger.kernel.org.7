Return-Path: <linux-kernel+bounces-880738-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E9AB9C26755
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 18:46:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B05D03B87D8
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 17:38:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1749F2638BC;
	Fri, 31 Oct 2025 17:37:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lEjxjv9o"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5A59155757
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 17:37:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761932256; cv=none; b=nUeYFOQEr24F0Y3HarxCE1SQojGOQ9sL4ZopnGXv35wInS30diMsT65p3ROhFc1i8CU2VFwgMHxdcVUXVGhH+mA2WJXcW0HTbZ/Fv/TxVJpMWzYBl0OJv+cutm0Ooe3n3a3GUgfYB7vMRRArmp7UjROmE6/O3Maf6ohhr9M6QwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761932256; c=relaxed/simple;
	bh=zsbaoA/F5NOlNgn/Q7m0Emzmj/vRyRI3wur6J/zRy/Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=m9vHz8eN4uiu17fHj3rc8B1IKp2QA6eb63J3IcWtFYaqb7e62WB7+GEBIE5yCeEFFXA3opXo1ncaCAzSUYFFjvSh8B9UlQGgaMrWerq5z9Nm13sqOE3sx/WZIBvOC13oOwH1r8eHUDxOP4DzU6h68cSL9jjL7DCxVtnKrVf0mCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lEjxjv9o; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-47710acf715so12954455e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 10:37:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761932252; x=1762537052; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C5mV2w6my4c1PMfXawO9gB6t8vYeJrvxem9h0oKA3+w=;
        b=lEjxjv9oFZlzMn5hsNQUVb6a+oQWFxj/lq53sbuJRiKJxH4DJmrPjp8IF8nY/8qNI4
         F4hrk3oAy8n5a2lNRUGK0fGFkRuAnULtm7BRdt0FWrI80Rc/malY1dyQjq/6+/uT0dS3
         WXYfqx4yB3mO2nyqfV/oS/N3bh5c9KFnkEYOmsJ3mZGBDAh0uNo4lnJab4qJt6zSwgon
         jGZGigAGe7GwDnAo9T8FoItHodMdZ15RnUciHb9W8rIIOEZPEiamKbAbfrzdz7R6yeoU
         uM+A8IIJtQjlXnuqwoYPz3kHcLFx61mjD3idEGwdeXtdHdeAYtjGxL31i9YwXy0jcjPN
         Qg6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761932252; x=1762537052;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C5mV2w6my4c1PMfXawO9gB6t8vYeJrvxem9h0oKA3+w=;
        b=d8IBukuLOlSgXltIWTnG3YFcC5v7GKg1hH/aRH3dQFoJBp5Fz+HrpHL1wcjg3cMgeG
         fh9nODdwKkBZn/bIkwQyHTmm9IWxohMgShNFwIWKb2S/SvJ/F8zmbCJ6pzFW7D/WMPgO
         FhwGw29mlOc5GOiSEKOP0SDvePhT/7oDlcnFshmpmKSE1Z0Wz0PZY248Wq70p1KDqkGN
         wO8xCQHMk2Zrobv8AsDO4/86h5OHBmw9EqJwpYhd9VDbYwwgso+q5H+hoNyfYKefYBsX
         YVuyhZdgB3WvU7fBgp+5byED7LOWaqwEtXG8zRZctxzTAVt9TRlUgSlVCRiUgnjRL2sz
         lQrg==
X-Forwarded-Encrypted: i=1; AJvYcCXLvTOtc/8uPpdCgMuQmXNJdwW4nhmvwi0r0AHGllKkqrAxwmWvSH7CvMt251gJ3+SN4aBin8eJqY5+IW0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6OyacO1ATTpjWGJGRj0yAL594uEwid8g2jRLmNdUEUsLnF6ds
	7OcEXTft5+TUysd6i4rCIrVMV4HyoFzoid014KUh5wU+kpz166weogFvzeLsGp9TSeZPjUJ7+fd
	2sdUUzAcn2PSdt8L1czo8oPCdbhtga5U=
X-Gm-Gg: ASbGnctxTSlJ7Fekb0CQGF8r3iOl6oPVSb5GDtr4KJgEXdxEB+gzJkv7abtTXeeXGnF
	phurGu6ZB4NLFdI3j3YwuWZfeUboo7MbaAvmmiSAxbQbCQVf445ddaeBNLMwjmBumjuaFhL1fhy
	3Edx9es7K/LmiiUb8I1Vw7LEQ8xSJIkAtcFyhwGrhVTK5T4jdYpoWHuYwsochZUmMY3N4w0kudb
	OB9jbgCih+clLcz2pujShsMeSAwUhDg7ayUzvgWs+aolYNdIyuStDfghH2ODG92Aoa0fsqaD6Cr
	m4tkfpUonQswCSIN2A==
X-Google-Smtp-Source: AGHT+IHPMUcDW3YwpEvtBrlqSkWgH3dOQo9Kw9291NP88P35J7TeeNcT/Tu9V9VlCr57x5pMjLGDLOmypXe3JvzCues=
X-Received: by 2002:a05:6000:2585:b0:428:3f7c:bcfe with SMTP id
 ffacd0b85a97d-429bd6c1ef3mr3470559f8f.57.1761932251229; Fri, 31 Oct 2025
 10:37:31 -0700 (PDT)
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
 <87bjloht28.fsf@linux.dev>
In-Reply-To: <87bjloht28.fsf@linux.dev>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 31 Oct 2025 10:37:19 -0700
X-Gm-Features: AWmQ_bk3MBgTJKB4MZUJUE5RMJOP5ctpuIVST3txj8WpDOUYgUkSaXNEbEZ7Ahg
Message-ID: <CAADnVQLHT7DrqwNb_N_==vxCdtX3QvTyZKxZa4STw4cD-WKswQ@mail.gmail.com>
Subject: Re: bpf_st_ops and cgroups. Was: [PATCH v2 02/23] bpf: initial
 support for attaching struct ops to cgroups
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

On Thu, Oct 30, 2025 at 4:24=E2=80=AFPM Roman Gushchin <roman.gushchin@linu=
x.dev> wrote:
>
> Alexei Starovoitov <alexei.starovoitov@gmail.com> writes:
>
> > On Thu, Oct 30, 2025 at 12:06=E2=80=AFPM Roman Gushchin
> > <roman.gushchin@linux.dev> wrote:
> >>
> >> Ok, let me summarize the options we discussed here:
> >>
> >> 1) Make the attachment details (e.g. cgroup_id) the part of struct ops
> >> itself. The attachment is happening at the reg() time.
> >>
> >>   +: It's convenient for complex stateful struct ops'es, because a
> >>       single entity represents a combination of code and data.
> >>   -: No way to attach a single struct ops to multiple entities.
> >>
> >> This approach is used by Tejun for per-cgroup sched_ext prototype.
> >
> > It's wrong. It should adopt bpf_struct_ops_link_create() approach
> > and use attr->link_create.cgroup.relative_fd to attach.
>
> This is basically what I have in v2, but Andrii and Song suggested that
> I should use attr->link_create.target_fd instead.

Yes. Of course.
link_create.cgroup.relative_fd actually points to a program.
We will need it if/when we add support for mprog style attach.

> I have a slight preference towards attr->link_create.cgroup.relative_fd
> because it makes it clear that fd is a cgroup fd and potentially opens
> a possibility to e.g. attach struct_ops to individual tasks and
> cgroups, but I'm fine with both options.

yeah. The name is confusing. It's not a cgroup fd.

> Also, as Song pointed out, fd=3D=3D0 is in theory a valid target, so inst=
ead of
> using the "if (fd) {...}" check we might need a new flag. Idk if it
> really makes sense to complicate the code for it.

One option is to cgroup_get_from_fd(attr->link_create.target_fd)
and if it's not a cgroup, just ignore it in bpf_struct_ops_link_create()
But a new flag like BPF_F_CGROUP_FD maybe cleaner ?
If we ever attach st_ops to tasks there will be another BPF_F_PID_FD flag ?
Or we may try different supported kinds like bpf_fd_probe_obj() does
and don't bother with flags.

New attach_type-s are not necessary. The type of st_ops itself
reflects the purpose and hook location.

