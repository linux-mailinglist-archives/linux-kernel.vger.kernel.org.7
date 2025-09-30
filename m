Return-Path: <linux-kernel+bounces-838215-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C4C1BAEB43
	for <lists+linux-kernel@lfdr.de>; Wed, 01 Oct 2025 00:24:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E07613C7C89
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 22:24:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D58532C3774;
	Tue, 30 Sep 2025 22:24:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b="pXvlLcyQ"
Received: from r3-23.sinamail.sina.com.cn (r3-23.sinamail.sina.com.cn [202.108.3.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B05571EE02F
	for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 22:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.108.3.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759271077; cv=none; b=uFlNDjUtVjTlnhPmbl23DOL3lRzHvbsZFh+/Qc0x0ZjLAvQYYsYbGmW9Gv6H9T/E+O1NpDkVyaeJaDhwNpqpSzlnvxsfJnlpm5S/m+sZguUAvBnImqKPk48XpHEXZeDJ1oN+HTFHmBECbwx/jXHx21SWlxz8SJyXQVKlE4IwOTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759271077; c=relaxed/simple;
	bh=g48O09spZcT2TwbZnPHI3M6D6cC63UQ8dwj/95Lf0nU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=D1xkI/MBOnAHhPd05vtHaVb5FrGJ8Ajg68fxwwe6uMqv7iIwRGVXfm630bmHpl203BZ5LzD3jsjAWwu8G6dByGJPNEnopr+DVFQWq/eC6QUmd91QH3yM66nKgu+936w/aBRnuPxXlRAoJa7dyU6Za2Z3J47yHACrAT5PmP+rUjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b=pXvlLcyQ; arc=none smtp.client-ip=202.108.3.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sina.com; s=201208; t=1759271072;
	bh=PeSt4auwglYPFnJc8427LVoppmueE7xaZPihXjESuXM=;
	h=From:Subject:Date:Message-ID;
	b=pXvlLcyQRzoLtn3GB2rD6kItwqPMHJl3CgHdGruaxSq0YwvWyFjuj6LjwxIf0LtrI
	 2zNXimXImxCnE3vIDd/qd381OIP6LnPUBvw0cLk0NQBPNCZP7/fbzBzcqfK0DoZjmS
	 ODH12MfTj6oMJfT8FvA5IvvmEYojQoo3tEWokeno=
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([114.249.58.236])
	by sina.com (10.54.253.31) with ESMTP
	id 68DC565B00001D3D; Tue, 1 Oct 2025 06:14:54 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 2332286816301
X-SMAIL-UIID: C55BE4FAE527454F8983310896AB42A9-20251001-061454-1
From: Hillf Danton <hdanton@sina.com>
To: Joshua Hahn <joshua.hahnjy@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	kernel-team@meta.com
Subject: Re: [PATCH v2 2/4] mm/page_alloc: Perform appropriate batching in drain_pages_zone
Date: Wed,  1 Oct 2025 06:14:40 +0800
Message-ID: <20250930221441.7748-1-hdanton@sina.com>
In-Reply-To: <20250930144240.2326093-1-joshua.hahnjy@gmail.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, 30 Sep 2025 07:42:40 -0700 Joshua Hahn wrote:
> On Sat, 27 Sep 2025 08:46:15 +0800 Hillf Danton <hdanton@sina.com> wrote:
> > On Wed, 24 Sep 2025 13:44:06 -0700 Joshua Hahn wrote:
> > > drain_pages_zone completely drains a zone of its pcp free pages by
> > > repeatedly calling free_pcppages_bulk until pcp->count reaches 0.
> > > In this loop, it already performs batched calls to ensure that
> > > free_pcppages_bulk isn't called to free too many pages at once, and
> > > relinquishes & reacquires the lock between each call to prevent
> > > lock starvation from other processes.
> > > 
> > > However, the current batching does not prevent lock starvation. The
> > > current implementation creates batches of
> > > pcp->batch << CONFIG_PCP_BATCH_SCALE_MAX, which has been seen in
> > > Meta workloads to be up to 64 << 5 == 2048 pages.
> > > 
> > > While it is true that CONFIG_PCP_BATCH_SCALE_MAX is a config and
> > > indeed can be adjusted by the system admin to be any number from
> > > 0 to 6, it's default value of 5 is still too high to be reasonable for
> > > any system.
> > > 
> > > Instead, let's create batches of pcp->batch pages, which gives a more
> > > reasonable 64 pages per call to free_pcppages_bulk. This gives other
> > > processes a chance to grab the lock and prevents starvation. Each
> 
> Hello Hillf,
> 
> Thank you for your feedback!
> 
> > Feel free to make it clear, which lock is contended, pcp->lock or
> > zone->lock, or both, to help understand the starvation.
> 
> Sorry for the late reply. I took some time to run some more tests and
> gather numbers so that I could give an accurate representation of what
> I was seeing in these systems.
> 
> So running perf lock con -abl on my system and compiling the kernel,
> I see that the biggest lock contentions come from free_pcppages_bulk
> and __rmqueue_pcplist on the upstream kernel (ignoring lock contentions
> on lruvec, which is actually the biggest offender on these systems.
> This will hopefully be addressed some time in the future as well).
> 
> Looking deeper into where they are waiting on the lock, I found that they
> are both waiting for the zone->lock (not the pcp lock, even for

One of the hottest locks again plays its role.

> __rmqueue_pcplist). I'll add this detail into v3, so that it is more
> clear for the user. I'll also emphasize why we still need to break the
> pcp lock, since this was something that wasn't immediately obvious to me.
> 
> > If the zone lock is hot, why did numa node fail to mitigate the contension,
> > given workloads tested with high sustained memory pressure on large machines
> > in the Meta fleet (1Tb memory, 316 CPUs)?
> 
> This is a good question. On this system, I've configured the machine to only
> use 1 node/zone, so there is no ability to migrate the contention. Perhaps

Thanks, we know why the zone lock is hot - 300+ CPUs potentially contended a lock.
The single node/zone config may explain why no similar reports of large
systems (1Tb memory, 316 CPUs) emerged a couple of years back, given
NUMA machine is not anything new on the market.

> another approach to this problem would be to encourage the user to
> configure the system such that each NUMA node does not exceed N GB of memory?
> 
> But if so -- how many GB/node is too much? It seems like there would be
> some sweet spot where the overhead required to maintain many nodes
> cancels out with the benefits one would get from splitting the system into
> multiple nodes. What do you think? Personally, I think that this patchset
> (not this patch, since it will be dropped in v3) still provides value in
> the form of preventing lock monopolies in the zone lock even in a system
> where memory is spread out across more nodes.
> 
> > Can the contension be observed with tight memory pressure but not highly tight? 
> > If not, it is due to misconfigure in the user space, no?
> 
> I'm not sure I entirely follow what you mean here, but are you asking
> whether this is a userspace issue for running a workload that isn't
> properly sized for the system? Perhaps that could be the case, but I think

This is not complicated. Take another look at the system from another
POV - what is your comment if running the same workload on the same
system but with RAM cut down to 1Gb? If roughly it is fully loaded for a
dentist to serve two patients well a day, getting the professional over
loaded makes no sense I think.

In short, given the zone lock is hot in nature, soft lockup with reproducer
hints misconfig.

> that it would not be bad for the system to protect against these workloads
> which can cause the system to stall, especially since the numbers show
> that there is neutral to positive gains from this patch. But of course
> I am very biased in this opinion : -) so happy to take other opinions on
> this matter.
> 
> Thanks for your questions. I hope you have a great day!
> Joshua

