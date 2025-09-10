Return-Path: <linux-kernel+bounces-811077-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B1246B52415
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 00:10:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A62041C242FD
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 22:11:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 673983112DA;
	Wed, 10 Sep 2025 22:10:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UYzGrvdi"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8971272807
	for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 22:10:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757542245; cv=none; b=LqU1b/Xu964Caknt3Qhc/zDhM20RUwW9Bf7B9pU7xzKi8C18qMC9jcK+oDiV4oq27y2eE0sDTXQKZXzrlpGJeTbp98o4alVrZdyZTFVKENqJ6tFDkHExN4Upfrni+g/xR38hmpq115JorIW7RkxxnyqjRRlkMevlZMNQDr9k26k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757542245; c=relaxed/simple;
	bh=Ud8/LjX5tWIW9/pb4uJHFmXYj1ABUwohGw3Ffq3cLmU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TJwNleWcQNpjWDZcauolopM2a4ZIDUZgJeGWSL7XaIkAB8mv/rkn+R0Wy+FdXdwTCKgtMqKYGEeUAINy9gr7fpyexOkhJmiQGy8wSYpp69cVXe5NlH770X68k/UrMzGo2fq22H71ca7c0od3JQYxG3YlpgE/HTTmn5usdae91ug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UYzGrvdi; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-45dd9d72f61so33235e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 15:10:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757542242; x=1758147042; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ud8/LjX5tWIW9/pb4uJHFmXYj1ABUwohGw3Ffq3cLmU=;
        b=UYzGrvdi2HOGyLVC/EWexoTWzIxrrO0OmAlaMx0C2W6jWJLK7d3kIHPH3/x9pFXA8o
         EoVUqx+WhV4O+OXqcCKWT7BnEDyGCcywYn+LDvpEgImbPdST+5yAXjNHLmk8cnpWg2+R
         uvW4sAl9Lo7Wttd+ncgTLwTwEIdhdfWRGzP4v+HoZ1Edp2kCTHpyxmLj/lT2rFl3OE3I
         W5Tn7jv1YNMoRlQAOuYUELfSkUe7LQKHHSfDvgrqN9MvfSWUscCjF8BwbqGq+FnjXxq1
         8Pt3lpPwMOjt8gtbFMeJIRv4j0LN0tOw00KPdpnnqnSs5Hy09h7A+nPnncV1znvvBdnI
         rcqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757542242; x=1758147042;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ud8/LjX5tWIW9/pb4uJHFmXYj1ABUwohGw3Ffq3cLmU=;
        b=EB0s5UDYnLBi4OrHvoldvnZuL6hoe/j4OJ4BPGSPc1YwEyA82vKwSrX6RP5d9aLYTa
         p6g5PO3RB1nr7XyRdvcmyKu7lfCBwQu1qNn/zhXSUdP26L2xXXoMoTfN200PYQ2SEFJt
         tZmP8LQE/uvLuweCHZ0D+egUc1HmpzZ1I1VO+RVZqO0A2SNd4ZEyuG8OwddZlNrMDafn
         YqDXz9AvR5QMOZfD9GZuBY497Hg/LGAKZ2Zf/hbibIIQq0z4bpKPXyKhVugsQ/fGKIBs
         qnVQ23K+gM3uB0BAyJGND6s18NtZRRpRKMjzCt2hIZ58MVhwpUO7jmHPhyO3tqt9gheL
         JCXw==
X-Forwarded-Encrypted: i=1; AJvYcCViWYBz6/pqgaQfFufyX8zbK9b7CqxIck0Sqt3itVJwP5zdgfDTqOJUUpSI6+Yma6LHPfWkzxdZ3EqgO/k=@vger.kernel.org
X-Gm-Message-State: AOJu0YyShqptEJgPnAUW7sTI0iX1Ub6cYw19pzDbnBbUTtCWQ/5ipkfb
	hxjvMMln99souMvP0FmZe+9NpEge+5JLdu9XZCaJIXIcF2B1IcEScBQE2U8YwWP455rleHbaW/N
	SVriAf9fYtyHs7hyVFAmR+m4nTgA9Xj+PQdWXBCKo
X-Gm-Gg: ASbGncsALXInPJ3CyMArKjWE/DVhjaA6Gu/YYCiWgbA2WwDvXV35QRz2e75Vutv5v1P
	nv+2Qtr7VZrHWVrIrab2szOzcHYMaPykoT5bFyOodfuNJu5e2axMV9x6O21X1PXt4fIa3PucXSN
	HQaUwgafl6vgHhDGrO/uCo6p4xmht3E5dolhnZ9k8kVJ1/ehSNj/zgkGkc0G128qtypTGNqBXOs
	tuoyILHfoy4eSYm2Kv5xJF0UqzeCN35em61jzQwtn25
X-Google-Smtp-Source: AGHT+IE3cor2ZFx47kcBwK+FPBD50LrvoMIv/c7Fwfd1Jpre33Ol/npl+FUbI0aeN+ZCL2YEHcjgddsm1h5zK39jj+4=
X-Received: by 2002:a05:600c:8584:b0:45d:f6a6:a13e with SMTP id
 5b1f17b1804b1-45df81fce12mr2007125e9.1.1757542241661; Wed, 10 Sep 2025
 15:10:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250909065349.574894-1-liulei.rjpt@vivo.com> <fszpgct7ywqy6qq3qnjflol3theovmgnau2wgdqqdxin4q7ezm@zumgw533hxon>
 <CAJuCfpFaTj8PsXkoYRQKQ0sOu+mKikUAE8Wbcx+YpZXZ4M7cMA@mail.gmail.com>
 <qisfqncqgkgxh2nj5axafunlfjen6oiciobcrmpus6l3xwrbyj@blxv73pbhzez> <CAJuCfpF1deAfZfWQZkAdws9FDNsmZp3KMQap-LqcX1NzOoknhA@mail.gmail.com>
In-Reply-To: <CAJuCfpF1deAfZfWQZkAdws9FDNsmZp3KMQap-LqcX1NzOoknhA@mail.gmail.com>
From: "T.J. Mercier" <tjmercier@google.com>
Date: Wed, 10 Sep 2025 15:10:29 -0700
X-Gm-Features: AS18NWDgkOOVxVEJ5m_y8MH1I0nxlUuRqO0CwbrMLM_l8GTe9AE5nrTwvPrjvCI
Message-ID: <CABdmKX2386gYbF5BXzbJ3awybF+edGAfGgFguhAbppejYMKGZA@mail.gmail.com>
Subject: Re: [PATCH v0 0/2] mm: swap: Gather swap entries and batch async release
To: Suren Baghdasaryan <surenb@google.com>
Cc: Shakeel Butt <shakeel.butt@linux.dev>, Lei Liu <liulei.rjpt@vivo.com>, 
	Michal Hocko <mhocko@suse.com>, David Rientjes <rientjes@google.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Kemeng Shi <shikemeng@huaweicloud.com>, 
	Kairui Song <kasong@tencent.com>, Nhat Pham <nphamcs@gmail.com>, Baoquan He <bhe@redhat.com>, 
	Barry Song <baohua@kernel.org>, Chris Li <chrisl@kernel.org>, 
	Johannes Weiner <hannes@cmpxchg.org>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Muchun Song <muchun.song@linux.dev>, David Hildenbrand <david@redhat.com>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>, Brendan Jackman <jackmanb@google.com>, 
	Zi Yan <ziy@nvidia.com>, "Peter Zijlstra (Intel)" <peterz@infradead.org>, Chen Yu <yu.c.chen@intel.com>, 
	Hao Jia <jiahao1@lixiang.com>, "Kirill A. Shutemov" <kas@kernel.org>, 
	Usama Arif <usamaarif642@gmail.com>, Oleg Nesterov <oleg@redhat.com>, 
	Christian Brauner <brauner@kernel.org>, Mateusz Guzik <mjguzik@gmail.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Al Viro <viro@zeniv.linux.org.uk>, Fushuai Wang <wangfushuai@baidu.com>, 
	"open list:MEMORY MANAGEMENT - OOM KILLER" <linux-mm@kvack.org>, open list <linux-kernel@vger.kernel.org>, 
	"open list:CONTROL GROUP - MEMORY RESOURCE CONTROLLER (MEMCG)" <cgroups@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 10, 2025 at 1:41=E2=80=AFPM Suren Baghdasaryan <surenb@google.c=
om> wrote:
>
> On Wed, Sep 10, 2025 at 1:10=E2=80=AFPM Shakeel Butt <shakeel.butt@linux.=
dev> wrote:
> >
> > On Tue, Sep 09, 2025 at 12:48:02PM -0700, Suren Baghdasaryan wrote:
> > > On Tue, Sep 9, 2025 at 12:21=E2=80=AFPM Shakeel Butt <shakeel.butt@li=
nux.dev> wrote:
> > > >
> > > > On Tue, Sep 09, 2025 at 02:53:39PM +0800, Lei Liu wrote:
> > > > > 1. Problem Scenario
> > > > > On systems with ZRAM and swap enabled, simultaneous process exits=
 create
> > > > > contention. The primary bottleneck occurs during swap entry relea=
se
> > > > > operations, causing exiting processes to monopolize CPU resources=
. This
> > > > > leads to scheduling delays for high-priority processes.
> > > > >
> > > > > 2. Android Use Case
> > > > > During camera launch, LMKD terminates background processes to fre=
e memory.
> > > >
> > > > How does LMKD trigger the kills? SIGKILL or cgroup.kill?
> > >
> > > SIGKILL
> > >
> > > >
> > > > > Exiting processes compete for CPU cycles, delaying the camera pre=
view
> > > > > thread and causing visible stuttering - directly impacting user
> > > > > experience.
> > > >
> > > > Since the exit/kill is due to low memory situation, punting the mem=
ory
> > > > freeing to a low priority async mechanism will help in improving us=
er
> > > > experience. Most probably the application (camera preview here) wil=
l get
> > > > into global reclaim and will compete for CPU with the async memory
> > > > freeing.
> > > >
> > > > What we really need is faster memory freeing and we should explore =
all
> > > > possible ways. As others suggested fix/improve the bottleneck in th=
e
> > > > memory freeing path. In addition I think we should explore parallel=
izing
> > > > this as well.
> > > >
> > > > On Android, I suppose most of the memory is associated with single =
or
> > > > small set of processes and parallelizing memory freeing would be
> > > > challenging. BTW is LMKD using process_mrelease() to release the ki=
lled
> > > > process memory?
> > >
> > > Yes, LMKD has a reaper thread which wakes up and calls
> > > process_mrelease() after the main LMKD thread issued SIGKILL.
> > >
> >
> > Thanks Suren. I remember Android is planning to use Apps in cgroup. Is
> > that still the plan? I am actually looking into cgroup.kill, beside
> > sending SIGKILL, putting the processes of the target cgroup in the oom
> > reaper list. In addition, making oom reaper able to reap processes in
> > parallel. I am hoping that functionality to be useful to Android as
> > well.
>
> Yes, cgroups v2 with per-app hierarchy is already enabled on Android
> as of about a year or so ago. The first usecase was the freezer. TJ
> (CC'ing him here) also changed how ActivityManager Service (AMS) kills
> process groups to use cgroup.kill (think when you force-stop an app
> that's what will happen). LMKD has not been changed to use cgroup.kill
> but that might be worth doing now. TJ, WDYT?

Sounds like it's worth trying here [1].

One potential downside of cgroup.kill is that it requires taking the
cgroup_mutex, which is one of our most heavily contended locks.

We already have logic that waits for exits in libprocessgroup's
KillProcessGroup [2], but I don't think LMKD needs or wants that from
its main thread. I think we'll still want process_mrelease [3] from
LMKD's reaper thread.

[1] https://cs.android.com/android/platform/superproject/main/+/main:system=
/memory/lmkd/reaper.cpp;drc=3D88ca1a4963004011669da415bc421b846936071f;l=3D=
233
[2] https://cs.android.com/android/platform/superproject/main/+/main:system=
/core/libprocessgroup/processgroup.cpp;drc=3D61197364367c9e404c7da6900658f1=
b16c42d0da;l=3D537
[3] https://cs.android.com/android/platform/superproject/main/+/main:system=
/memory/lmkd/reaper.cpp;drc=3D88ca1a4963004011669da415bc421b846936071f;l=3D=
123

Shakeel could we not also invoke the oom reaper's help for regular
kill(SIGKILL)s?

