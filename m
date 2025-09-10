Return-Path: <linux-kernel+bounces-811085-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 63201B5243D
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 00:33:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BBA737AD0CE
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 22:31:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CA522D6E68;
	Wed, 10 Sep 2025 22:33:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="KWRxDXVt"
Received: from out-186.mta0.migadu.com (out-186.mta0.migadu.com [91.218.175.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B55342581
	for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 22:33:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757543600; cv=none; b=D7kwQ7YIMVfYkfc2mq5cSgqjFg+S0kuFrkGNz93eszvGNztZAJB5FAb4szOqCq8EdWnPXD/F7T/pcvTZlyFOSkon6OdzxsJeiUGAV18XQ9KrCaU8If9sUl1LuOPO0MEXWnBK0zzFmT6iTZ8wY8/9XLFGCOhWP7F5f+f+Z+S+ACs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757543600; c=relaxed/simple;
	bh=1D8kYvYnUt9p2Tkspt3iq/LOk01t/zl1ADq5ZH93yO0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Kok81Z6nnJXzmA38FMqBzcTIzR7vqi2JahW72yqNdCinlRv95tBl0FtxfvpktvUJsqOFQPI/kS3txUH3ruXn4FlOsXa3Lkr3UtD9TuCa8sOtOTu5wh1rMvu09taNl0tLveU3yYc+7wPPchX8aPoqs7BsSKs/NLgI06LqzUszR/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=KWRxDXVt; arc=none smtp.client-ip=91.218.175.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Wed, 10 Sep 2025 15:33:04 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1757543594;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3a//xGijpXNAuGudMzhJ5QIbcnpcApxjy+dhMPgQAYk=;
	b=KWRxDXVt7y9s6wE+N5w0wSQ5Ynzy9bk1e3X8QxXkENMXrCSlAwlUuk55Uxkl7/O4MIj/U6
	WOOIegzy9yno5PLguEzQTbqb/YbwxIUIgLlP9lb3pIv+4Hi6+YBzVJ8Vagftl5Oea5XNB3
	z7oywdV/N8xCxnl9VbYwRvcPo0Pr4co=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: "T.J. Mercier" <tjmercier@google.com>
Cc: Suren Baghdasaryan <surenb@google.com>, Lei Liu <liulei.rjpt@vivo.com>, 
	Michal Hocko <mhocko@suse.com>, David Rientjes <rientjes@google.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Kemeng Shi <shikemeng@huaweicloud.com>, 
	Kairui Song <kasong@tencent.com>, Nhat Pham <nphamcs@gmail.com>, Baoquan He <bhe@redhat.com>, 
	Barry Song <baohua@kernel.org>, Chris Li <chrisl@kernel.org>, 
	Johannes Weiner <hannes@cmpxchg.org>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Muchun Song <muchun.song@linux.dev>, David Hildenbrand <david@redhat.com>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>, 
	Brendan Jackman <jackmanb@google.com>, Zi Yan <ziy@nvidia.com>, 
	"Peter Zijlstra (Intel)" <peterz@infradead.org>, Chen Yu <yu.c.chen@intel.com>, Hao Jia <jiahao1@lixiang.com>, 
	"Kirill A. Shutemov" <kas@kernel.org>, Usama Arif <usamaarif642@gmail.com>, 
	Oleg Nesterov <oleg@redhat.com>, Christian Brauner <brauner@kernel.org>, 
	Mateusz Guzik <mjguzik@gmail.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Al Viro <viro@zeniv.linux.org.uk>, 
	Fushuai Wang <wangfushuai@baidu.com>, "open list:MEMORY MANAGEMENT - OOM KILLER" <linux-mm@kvack.org>, 
	open list <linux-kernel@vger.kernel.org>, 
	"open list:CONTROL GROUP - MEMORY RESOURCE CONTROLLER (MEMCG)" <cgroups@vger.kernel.org>
Subject: Re: [PATCH v0 0/2] mm: swap: Gather swap entries and batch async
 release
Message-ID: <lsg5toahtv3odhjslxn5zd6huih7ziaei6vjj3u4wybbesjup4@i6tytlo4uczo>
References: <20250909065349.574894-1-liulei.rjpt@vivo.com>
 <fszpgct7ywqy6qq3qnjflol3theovmgnau2wgdqqdxin4q7ezm@zumgw533hxon>
 <CAJuCfpFaTj8PsXkoYRQKQ0sOu+mKikUAE8Wbcx+YpZXZ4M7cMA@mail.gmail.com>
 <qisfqncqgkgxh2nj5axafunlfjen6oiciobcrmpus6l3xwrbyj@blxv73pbhzez>
 <CAJuCfpF1deAfZfWQZkAdws9FDNsmZp3KMQap-LqcX1NzOoknhA@mail.gmail.com>
 <CABdmKX2386gYbF5BXzbJ3awybF+edGAfGgFguhAbppejYMKGZA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CABdmKX2386gYbF5BXzbJ3awybF+edGAfGgFguhAbppejYMKGZA@mail.gmail.com>
X-Migadu-Flow: FLOW_OUT

On Wed, Sep 10, 2025 at 03:10:29PM -0700, T.J. Mercier wrote:
> On Wed, Sep 10, 2025 at 1:41 PM Suren Baghdasaryan <surenb@google.com> wrote:
> >
> > On Wed, Sep 10, 2025 at 1:10 PM Shakeel Butt <shakeel.butt@linux.dev> wrote:
> > >
> > > On Tue, Sep 09, 2025 at 12:48:02PM -0700, Suren Baghdasaryan wrote:
> > > > On Tue, Sep 9, 2025 at 12:21 PM Shakeel Butt <shakeel.butt@linux.dev> wrote:
> > > > >
> > > > > On Tue, Sep 09, 2025 at 02:53:39PM +0800, Lei Liu wrote:
> > > > > > 1. Problem Scenario
> > > > > > On systems with ZRAM and swap enabled, simultaneous process exits create
> > > > > > contention. The primary bottleneck occurs during swap entry release
> > > > > > operations, causing exiting processes to monopolize CPU resources. This
> > > > > > leads to scheduling delays for high-priority processes.
> > > > > >
> > > > > > 2. Android Use Case
> > > > > > During camera launch, LMKD terminates background processes to free memory.
> > > > >
> > > > > How does LMKD trigger the kills? SIGKILL or cgroup.kill?
> > > >
> > > > SIGKILL
> > > >
> > > > >
> > > > > > Exiting processes compete for CPU cycles, delaying the camera preview
> > > > > > thread and causing visible stuttering - directly impacting user
> > > > > > experience.
> > > > >
> > > > > Since the exit/kill is due to low memory situation, punting the memory
> > > > > freeing to a low priority async mechanism will help in improving user
> > > > > experience. Most probably the application (camera preview here) will get
> > > > > into global reclaim and will compete for CPU with the async memory
> > > > > freeing.
> > > > >
> > > > > What we really need is faster memory freeing and we should explore all
> > > > > possible ways. As others suggested fix/improve the bottleneck in the
> > > > > memory freeing path. In addition I think we should explore parallelizing
> > > > > this as well.
> > > > >
> > > > > On Android, I suppose most of the memory is associated with single or
> > > > > small set of processes and parallelizing memory freeing would be
> > > > > challenging. BTW is LMKD using process_mrelease() to release the killed
> > > > > process memory?
> > > >
> > > > Yes, LMKD has a reaper thread which wakes up and calls
> > > > process_mrelease() after the main LMKD thread issued SIGKILL.
> > > >
> > >
> > > Thanks Suren. I remember Android is planning to use Apps in cgroup. Is
> > > that still the plan? I am actually looking into cgroup.kill, beside
> > > sending SIGKILL, putting the processes of the target cgroup in the oom
> > > reaper list. In addition, making oom reaper able to reap processes in
> > > parallel. I am hoping that functionality to be useful to Android as
> > > well.
> >
> > Yes, cgroups v2 with per-app hierarchy is already enabled on Android
> > as of about a year or so ago. The first usecase was the freezer. TJ
> > (CC'ing him here) also changed how ActivityManager Service (AMS) kills
> > process groups to use cgroup.kill (think when you force-stop an app
> > that's what will happen). LMKD has not been changed to use cgroup.kill
> > but that might be worth doing now. TJ, WDYT?
> 
> Sounds like it's worth trying here [1].
> 
> One potential downside of cgroup.kill is that it requires taking the
> cgroup_mutex, which is one of our most heavily contended locks.

Oh let me look into that and see if we can remove cgroup_mutex from that
interface.

> 
> We already have logic that waits for exits in libprocessgroup's
> KillProcessGroup [2], but I don't think LMKD needs or wants that from
> its main thread. I think we'll still want process_mrelease [3] from
> LMKD's reaper thread.

I imagine once kernel oom reaper can work on killed processes
transparently, it would be much easier to let it do the job instead of
manual process_mrelease() on all the processes in a cgroup.

> 
> [1] https://cs.android.com/android/platform/superproject/main/+/main:system/memory/lmkd/reaper.cpp;drc=88ca1a4963004011669da415bc421b846936071f;l=233
> [2] https://cs.android.com/android/platform/superproject/main/+/main:system/core/libprocessgroup/processgroup.cpp;drc=61197364367c9e404c7da6900658f1b16c42d0da;l=537
> [3] https://cs.android.com/android/platform/superproject/main/+/main:system/memory/lmkd/reaper.cpp;drc=88ca1a4963004011669da415bc421b846936071f;l=123
> 
> Shakeel could we not also invoke the oom reaper's help for regular
> kill(SIGKILL)s?

I don't see why this can not be done. I will take a look.

