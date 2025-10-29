Return-Path: <linux-kernel+bounces-877265-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B9C0C1D9B1
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 23:44:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9E9ED3BD6C7
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 22:44:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D614F2DC78F;
	Wed, 29 Oct 2025 22:43:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mVetzJTD"
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FAE82D3737
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 22:43:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761777834; cv=none; b=K2mQCE4VG0Vx3bhp+oKNk7H6PgOgiCcGQjT3le/tP5wkRU2mzHqCDjmR3qFSb439j7ch8wzy+TNhAaHRzrf8KDoH8CXNACCPy8jIqdKpm6Dg0w9teWyetij9qM/JWtJzKy0Yy/oQIdT7Om/C+WkL0xda3UkUR9yRAnYFoXzZO0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761777834; c=relaxed/simple;
	bh=wik67zmjPJSCJArpOPAfO/nO0IlbnlsMUwHITZGrZG0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NJn3ZrRD0lnT7H3PukAuiczE4FHrH8svAf9+wlSxYlvEkIqJkKTfWZFAdbEqKZSEkgS4JdNSRvwDhZg/ADHaMGDVgPu/bC6EATbayqyIeAnvwUi+FP7LXjJjTCnI4KlrEbauB9VsA8H6XGdLXcewwNK0ifSoLIKJJ1cdvn1hswc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mVetzJTD; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-47109187c32so1916775e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 15:43:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761777831; x=1762382631; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wik67zmjPJSCJArpOPAfO/nO0IlbnlsMUwHITZGrZG0=;
        b=mVetzJTDY0XFXAtlvcIJX5FAgxmXcYfXKlq4L9Wk41tl6eZE5gPwzN45+3JMagE4IA
         izbJSFbKJbgFSjnGiW4xy36dC8VNK0AAD2WIKqPcYf1HfpPJ0M5HSZtUh2iqNJWeYdAI
         lf34qx+wGlKR2+ty15cf39qU8F77q12LRh+xLftRL08FTHdALhPZM/bzugjF7arqheFE
         nOHEcE3tWch2X12QFKWmZgRyJieoK4PS5BrbP4xX7U01SmV66sOwULwcLxoKVHN4kOWO
         FjgUNp+LOP+M+IAeiB+EWYIWOy9uaoV+SE9KC3SC77voiSSh73Bh8DrMFUB2vKQuLja7
         hVIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761777831; x=1762382631;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wik67zmjPJSCJArpOPAfO/nO0IlbnlsMUwHITZGrZG0=;
        b=OZaG+0bajmmNGx8p5vGk+OlI7+vqGgQWMuCpHXA1fEBipG5CJxiVYQ1mbSG8tg+3Xj
         5/+B3jjy737xnjtT8MN2lRiB0ZCGhPHWXZhoZXUTm+T8N2T1YYr4wBzoufZsXvzTo8he
         +pC0Irb/dlYBdhVS7z2/yxOfTEJ1Pn1oJxy6ig8yXzWPuaB3WdtSQ1terLPucxcEuBRZ
         1WU4qxor5Kb4k4bDlGEzaZ+dHGh5R7ZqpsO+jrE64p4cItnnUKwknqxYn9jH/BgIO3m4
         N+0WSdoN2b55eb+al80ghFg6aIAlA8GxMHmUpZoKTxLDcnrr2gBUJDzfYchyb1+gDEnQ
         ZC4g==
X-Forwarded-Encrypted: i=1; AJvYcCXYsbAq0nQUYcGjUCD2DpSNM6V6B3V5E4pi88Ii/dgvFDiahWj023ReBmFKLHAGeqwUFxyeQchR+uKlLPc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9T4TBzPFzB4n4W6dE/Tuj5Ho2l4adurIRC2HhctrG/oIivYba
	FNwWQpQj8WuKvxFGLRyutTsJ3eqZP9ER83VvefVGIUh+Q5BrObmFO60yzMUccah3XXMYFD81TK8
	A7nbVMvcRZXcbnhH5cOLvYhlrSMMnFN4=
X-Gm-Gg: ASbGncsDWt22oRyQTAcnbbl6TT5vjiisKf5EOFu0+26L40lGR+1AlkeQblbzY1hzQHI
	H5CrZ+cx5jkGBWmGjkYQoyL9Uwrsd8GfCZtsiIIVc6YgvZYB7m7OvxYKgsrLPcmXr8q4jjBi3BB
	nOPuP7rMCKVoB6xMhrARXjH/65aHiq/NDHP6EYJuiGwkS1JLqKJ98Cnc3UPYFvDlytSH01N0cYX
	JAua9vmjF7UiIgwoS9Mey4pf63DOn74oB/CDOMZCGcKGFVV3jKp7XWH8uP4qxik/XaFQKRAHqbt
	0O4bK/TghJGXEyGWsaruzDEA/+rj
X-Google-Smtp-Source: AGHT+IGgG3j4M2SQf3XFssiae2E5GaU0Oz0HOJLZDxtGjEKIMo/1gRVHcuNdOoC/ksGXyg/SfrIqUSHv9CMrDZOG1Sg=
X-Received: by 2002:a05:600c:3e07:b0:46e:48fd:a1a9 with SMTP id
 5b1f17b1804b1-4771e3fbdcemr39702415e9.33.1761777830545; Wed, 29 Oct 2025
 15:43:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251027231727.472628-1-roman.gushchin@linux.dev>
 <20251027231727.472628-3-roman.gushchin@linux.dev> <aQJZgd8-xXpK-Af8@slm.duckdns.org>
 <87ldkte9pr.fsf@linux.dev> <aQJ61wC0mvzc7qIU@slm.duckdns.org>
 <CAHzjS_vhk6RM6pkfKNrDNeEC=eObofL=f9FZ51tyqrFFz9tn1w@mail.gmail.com> <871pmle5ng.fsf@linux.dev>
In-Reply-To: <871pmle5ng.fsf@linux.dev>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 29 Oct 2025 15:43:39 -0700
X-Gm-Features: AWmQ_bklQRlCeWMvvDMXXjosBJpVWn26QkhuJgrczs1PBday5NsqxYLilK9uBkc
Message-ID: <CAADnVQJ+4a97bp26BOpD5A9LOzfJ+XxyNt4bdG8n7jaO6+nV3Q@mail.gmail.com>
Subject: Re: [PATCH v2 02/23] bpf: initial support for attaching struct ops to cgroups
To: Roman Gushchin <roman.gushchin@linux.dev>
Cc: Song Liu <song@kernel.org>, Tejun Heo <tj@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@kernel.org>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Johannes Weiner <hannes@cmpxchg.org>, 
	Andrii Nakryiko <andrii@kernel.org>, JP Kobryn <inwardvessel@gmail.com>, 
	linux-mm <linux-mm@kvack.org>, 
	"open list:CONTROL GROUP (CGROUP)" <cgroups@vger.kernel.org>, bpf <bpf@vger.kernel.org>, 
	Martin KaFai Lau <martin.lau@kernel.org>, Kumar Kartikeya Dwivedi <memxor@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 29, 2025 at 2:53=E2=80=AFPM Roman Gushchin <roman.gushchin@linu=
x.dev> wrote:
>
> Song Liu <song@kernel.org> writes:
>
> > Hi Tejun,
> >
> > On Wed, Oct 29, 2025 at 1:36=E2=80=AFPM Tejun Heo <tj@kernel.org> wrote=
:
> >>
> >> On Wed, Oct 29, 2025 at 01:25:52PM -0700, Roman Gushchin wrote:
> >> > > BTW, for sched_ext sub-sched support, I'm just adding cgroup_id to
> >> > > struct_ops, which seems to work fine. It'd be nice to align on the=
 same
> >> > > approach. What are the benefits of doing this through fd?
> >> >
> >> > Then you can attach a single struct ops to multiple cgroups (or Idk
> >> > sockets or processes or some other objects in the future).
> >> > And IMO it's just a more generic solution.
> >>
> >> I'm not very convinced that sharing a single struct_ops instance acros=
s
> >> multiple cgroups would be all that useful. If you map this to normal
> >> userspace programs, a given struct_ops instance is package of code and=
 all
> >> the global data (maps). ie. it's not like running the same program mul=
tiple
> >> times against different targets. It's more akin to running a single pr=
ogram
> >> instance which can handle multiple targets.
> >>
> >> Maybe that's useful in some cases, but that program would have to expl=
icitly
> >> distinguish the cgroups that it's attached to. I have a hard time imag=
ining
> >> use cases where a single struct_ops has to service multiple disjoint c=
groups
> >> in the hierarchy and it ends up stepping outside of the usual operatio=
n
> >> model of cgroups - commonality being expressed through the hierarchica=
l
> >> structure.
> >
> > How about we pass a pointer to mem_cgroup (and/or related pointers)
> > to all the callbacks in the struct_ops? AFAICT, in-kernel _ops structur=
es like
> > struct file_operations and struct tcp_congestion_ops use this method. A=
nd
> > we can actually implement struct tcp_congestion_ops in BPF. With the
> > struct tcp_congestion_ops model, the struct_ops map and the struct_ops
> > link are both shared among multiple instances (sockets).
>
> +1 to this.
> I agree it might be debatable when it comes to cgroups, but when it comes=
 to
> sockets or similar objects, having a separate struct ops per object
> isn't really an option.

I think the general bpf philosophy that load and attach are two
separate steps. For struct-ops it's almost there, but not quite.
struct-ops shouldn't be an exception.
The bpf infra should be able to load a set of progs (aka struct-ops)
and attach it with a link to different entities. Like cgroups.
I think sched-ext should do that too. Even if there is no use case
today for the same sched-ext in two different cgroups.
For bpf-oom I can imagine a use case where container management sw
would pre-load struct-ops and then attach it later to different
containers depending on container configs. These container might
be peers in hierarchy, but attaching to their parent won't be
equivalent, since other peers might not need that bpf-oom management.
The "workaround" could be to create another cgroup layer
between parent and container, but that becomes messy, since now
there is a cgroup only for the purpose of attaching bpf-oom to it.

Whether struct-ops link attach is using cgroup_fd or cgroup_id
is debatable. I think FD is cleaner.

