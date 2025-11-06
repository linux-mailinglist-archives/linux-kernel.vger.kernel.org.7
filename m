Return-Path: <linux-kernel+bounces-888010-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 97DBCC3990F
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 09:24:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B464E4EBC1B
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 08:24:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A191A301460;
	Thu,  6 Nov 2025 08:24:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MQfFohEU"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA308280332;
	Thu,  6 Nov 2025 08:24:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762417481; cv=none; b=XqAftwhGqXlgHFXEeMGR1s7kc3Da1I9P6AkYwpVeqFqxVee7c7T1z5cp+F5fLcu3GoliRFfXyf4lVKvTk8wwtxlByapyB7K+QfdvX/b8vXtJwkwDDzdOOtUnRDv2/q267cxI7jyFXgJnb9lWtvC7Rv8uyAZs/EdxWjWmcIGRevg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762417481; c=relaxed/simple;
	bh=tnT+oLc/kBo4dvSKn58H5wJqyeTpfH6PqdkJR5lwiCI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V1VnQDvPVbRvLabMr6AY4LV5JUrNziHCgnB6jMXLq56cp1TywEPEyUWD0xfzyP/gJRwuTigVh2BK/RDkWTCjSpRYC5ublEG1fFb1P9lnq2VjCpJ7L18UUOaaF9vP2gvi+27o1+s9kzJIV9zXBiOKhikc61nkVOl4PvtdG3BWGgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MQfFohEU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3145C4CEFB;
	Thu,  6 Nov 2025 08:24:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762417480;
	bh=tnT+oLc/kBo4dvSKn58H5wJqyeTpfH6PqdkJR5lwiCI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MQfFohEUn+hXz5i9qgPu11Y8k2A6IGar+vdTxNhbAo5kq96oZC66SvEwCEwZLngMa
	 nZqgVO6+lGr5SbnAscnFEGlOYth+V4uFEvuRy8xVQMnvVEiHxMmse/uc5VnagiJNt8
	 7+LUyj+hqpudRx/65qxTU8MdcRF9WWbQQgyoIMJ5FYNqvVvXm0EJe3tzNLVe4x9hWN
	 OwMtBjGFSqk12yNZ+IiQNnuFCH6ChjQrOxCXNG3qNwMylFktFN1x1Sr2exkVzhcv2W
	 GcbUH/H4EasrjeEnAZuC2B/VAI67qBmhIzlMObyBFLthPShiCWyultl0kZZGY0ZbBJ
	 1YtPynLoEba2g==
Date: Thu, 6 Nov 2025 10:24:24 +0200
From: Mike Rapoport <rppt@kernel.org>
To: Breno Leitao <leitao@debian.org>
Cc: Pratyush Yadav <pratyush@kernel.org>,
	Changyuan Lyu <changyuanl@google.com>, akpm@linux-foundation.org,
	linux-kernel@vger.kernel.org, anthony.yznaga@oracle.com,
	arnd@arndb.de, ashish.kalra@amd.com, benh@kernel.crashing.org,
	bp@alien8.de, catalin.marinas@arm.com, corbet@lwn.net,
	dave.hansen@linux.intel.com, devicetree@vger.kernel.org,
	dwmw2@infradead.org, ebiederm@xmission.com, graf@amazon.com,
	hpa@zytor.com, jgowans@amazon.com, kexec@lists.infradead.org,
	krzk@kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-doc@vger.kernel.org, linux-mm@kvack.org, luto@kernel.org,
	mark.rutland@arm.com, mingo@redhat.com, pasha.tatashin@soleen.com,
	pbonzini@redhat.com, peterz@infradead.org, robh@kernel.org,
	rostedt@goodmis.org, saravanak@google.com,
	skinsburskii@linux.microsoft.com, tglx@linutronix.de,
	thomas.lendacky@amd.com, will@kernel.org, x86@kernel.org
Subject: Re: [PATCH v8 01/17] memblock: add MEMBLOCK_RSRV_KERN flag
Message-ID: <aQxbOG65t-Vu6TVe@kernel.org>
References: <20250509074635.3187114-1-changyuanl@google.com>
 <20250509074635.3187114-2-changyuanl@google.com>
 <ef6wfr72set5wa5el3wbbu4yd5tnc4p2rhtjpb5kpmncv3xs5d@i3c5v3ciioi3>
 <mafs0wm4yluej.fsf@kernel.org>
 <mafs0h5w2lpqu.fsf@kernel.org>
 <2ege2jfbevtunhxsnutbzde7cqwgu5qbj4bbuw2umw7ke7ogcn@5wtskk4exzsi>
 <mafs0cy6pljci.fsf@kernel.org>
 <c2nrxby4atq75o5yhwdpoikyso42tzimwn2bnl7fk54wuwdqax@i6kdssez3kfj>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c2nrxby4atq75o5yhwdpoikyso42tzimwn2bnl7fk54wuwdqax@i6kdssez3kfj>

Hello Breno,

On Wed, Nov 05, 2025 at 02:18:11AM -0800, Breno Leitao wrote:
> Hello Pratyush,
> 
> On Tue, Oct 14, 2025 at 03:10:37PM +0200, Pratyush Yadav wrote:
> > On Tue, Oct 14 2025, Breno Leitao wrote:
> > > On Mon, Oct 13, 2025 at 06:40:09PM +0200, Pratyush Yadav wrote:
> > >> On Mon, Oct 13 2025, Pratyush Yadav wrote:
> > >> >
> > >> > I suppose this would be useful. I think enabling memblock debug prints
> > >> > would also be helpful (using the "memblock=debug" commandline parameter)
> > >> > if it doesn't impact your production environment too much.
> > >> 
> > >> Actually, I think "memblock=debug" is going to be the more useful thing
> > >> since it would also show what function allocated the overlapping range
> > >> and the flags it was allocated with.
> > >> 
> > >> On my qemu VM with KVM, this results in around 70 prints from memblock.
> > >> So it adds a bit of extra prints but nothing that should be too
> > >> disrupting I think. Plus, only at boot so the worst thing you get is
> > >> slightly slower boot times.
> > >
> > > Unfortunately this issue is happening on production systems, and I don't
> > > have an easy way to reproduce it _yet_.
> > >
> > > At the same time, "memblock=debug" has two problems:
> > >
> > >  1) It slows the boot time as you suggested. Boot time at large
> > >     environments is SUPER critical and time sensitive. It is a bit
> > >     weird, but it is common for machines in production to kexec
> > >     _thousands_ of times, and kexecing is considered downtime.
> > 
> > I don't know if it would make a real enough difference on boot times,
> > only that it should theoretically affect it, mainly if you are using
> > serial for dmesg logs. Anyway, that's your production environment so you
> > know best.
> > 
> > >
> > >     This would be useful if I find some hosts getting this issue, and
> > >     then I can easily enable the extra information to collect what
> > >     I need, but, this didn't pan out because the hosts I got
> > >     `memblock=debug` didn't collaborate.
> > >
> > >  2) "memblock=debug" is verbose for all cases, which also not necessary
> > >     the desired behaviour. I am more interested in only being verbose
> > >     when there is a known problem.
> 
> I am still interested in this problem, and I finally found a host that
> constantly reproduce the issue and I was able to get `memblock=debug`
> cmdline. I am running 6.18-rc4 with some debug options enabled.
> 
> 	DMA-API: exceeded 7 overlapping mappings of cacheline 0x0000000006d6e400
> 	WARNING: CPU: 58 PID: 828 at kernel/dma/debug.c:463 add_dma_entry+0x2e4/0x330
> 	pc : add_dma_entry+0x2e4/0x330
> 	lr : add_dma_entry+0x2e4/0x330
> 	sp : ffff8000b036f7f0
> 	x29: ffff8000b036f800 x28: 0000000000000001 x27: 0000000000000008
> 	x26: ffff8000835f7fb8 x25: ffff8000835f7000 x24: ffff8000835f7ee0
> 	x23: 0000000000000000 x22: 0000000006d6e400 x21: 0000000000000000
> 	x20: 0000000006d6e400 x19: ffff0003f70c1100 x18: 00000000ffffffff
> 	x17: ffff80008019a2d8 x16: ffff80008019a08c x15: 0000000000000000
> 	x14: 0000000000000000 x13: 0000000000000820 x12: ffff00011faeaf00
> 	x11: 0000000000000000 x10: ffff8000834633d8 x9 : ffff8000801979d4
> 	x8 : 00000000fffeffff x7 : ffff8000834633d8 x6 : 0000000000000000
> 	x5 : 00000000000bfff4 x4 : 0000000000000000 x3 : ffff0001075eb7c0
> 	x2 : 0000000000000000 x1 : 0000000000000000 x0 : ffff0001075eb7c0
> 	Call trace:
> 	add_dma_entry+0x2e4/0x330 (P)
> 	debug_dma_map_phys+0xc4/0xf0
> 	dma_map_phys (/home/leit/Devel/upstream/./include/linux/dma-direct.h:138 /home/leit/Devel/upstream/kernel/dma/direct.h:102 /home/leit/Devel/upstream/kernel/dma/mapping.c:169)
> 	dma_map_page_attrs (/home/leit/Devel/upstream/kernel/dma/mapping.c:387)
> 	blk_dma_map_direct.isra.0 (/home/leit/Devel/upstream/block/blk-mq-dma.c:102)
> 	blk_dma_map_iter_start (/home/leit/Devel/upstream/block/blk-mq-dma.c:123 /home/leit/Devel/upstream/block/blk-mq-dma.c:196)
> 	blk_rq_dma_map_iter_start (/home/leit/Devel/upstream/block/blk-mq-dma.c:228)
> 	nvme_prep_rq+0xb8/0x9b8
> 	nvme_queue_rq+0x44/0x1b0
> 	blk_mq_dispatch_rq_list (/home/leit/Devel/upstream/block/blk-mq.c:2129)
> 	__blk_mq_sched_dispatch_requests (/home/leit/Devel/upstream/block/blk-mq-sched.c:314)
> 	blk_mq_sched_dispatch_requests (/home/leit/Devel/upstream/block/blk-mq-sched.c:329)
> 	blk_mq_run_work_fn (/home/leit/Devel/upstream/block/blk-mq.c:219 /home/leit/Devel/upstream/block/blk-mq.c:231)
> 	process_one_work (/home/leit/Devel/upstream/kernel/workqueue.c:991 /home/leit/Devel/upstream/kernel/workqueue.c:3213)
> 	worker_thread (/home/leit/Devel/upstream/./include/linux/list.h:163 /home/leit/Devel/upstream/./include/linux/list.h:191 /home/leit/Devel/upstream/./include/linux/list.h:319 /home/leit/Devel/upstream/kernel/workqueue.c:1153 /home/leit/Devel/upstream/kernel/workqueue.c:1205 /home/leit/Devel/upstream/kernel/workqueue.c:3426)
> 	kthread (/home/leit/Devel/upstream/kernel/kthread.c:386 /home/leit/Devel/upstream/kernel/kthread.c:457)
> 	ret_from_fork (/home/leit/Devel/upstream/entry.S:861)
> 
> 
> Looking at memblock debug logs, I haven't seen anything related to
> 0x0000000006d6e400.

It looks like the crash happens way after memblock passed all the memory to
buddy. Why do you think this is related to memblock?
 
> I got the output of `dmesg | grep memblock` in, in case you are curious:
> 
> 	https://github.com/leitao/debug/blob/main/pastebin/memblock/dmesg_grep_memblock.txt
> 
> Thanks
> --breno
> 

-- 
Sincerely yours,
Mike.

