Return-Path: <linux-kernel+bounces-839229-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A147BBB119C
	for <lists+linux-kernel@lfdr.de>; Wed, 01 Oct 2025 17:37:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 65F5A2A3950
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Oct 2025 15:37:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42DEC27E7EB;
	Wed,  1 Oct 2025 15:37:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K1V5KcQw"
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0F4E27A904
	for <linux-kernel@vger.kernel.org>; Wed,  1 Oct 2025 15:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759333042; cv=none; b=fdIlToSOWx2Oa4aBCRhaL0tPdwDs5Bz8/dLaGEVTT9vgUplQYdQd0IViY1SQbujbn0svAyqC6A5kCL3nm5wAE8cNqRjBCnnBbyGWu7ldcPk4mTPTQlqqUaCrfHiBvT7DBZOfXDyVZSdvDfTSKMnYS7UShX1KJnKsGFQ+KolDzL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759333042; c=relaxed/simple;
	bh=Bd57e7Pasl7oEVTRvG+Bgi6e9AMkomFmquoRgrSWSs4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ezo/8uFpr+R0u1rPog0iZeqIOoYfhaxpRL8U96zmEa7l5D28zqbrMIAM7UjoCot2hozfpSox4r4v4PxI6LLuGp0ZOoptrZIUYMBnEHKrjEN/TAovSfcLSju3REykYUmj9MdXIOluCVNToxgGAzgMu+oBKHnQ1p6SV1OexYMVsR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K1V5KcQw; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-71d60157747so331357b3.0
        for <linux-kernel@vger.kernel.org>; Wed, 01 Oct 2025 08:37:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759333040; x=1759937840; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HOhlFtoBnWaiM64nftJX9Q0scL17iSbfh4QHyZLgLlk=;
        b=K1V5KcQwExc3mB0SkZ2Oip381SdJ5GHPWx9U/vqHgcA9YNgQ3nl/EgsHYSVAqqww1J
         gr81t8hubx3sjPBqZnmnYExjyDfIXFvEHrRRBt/lkft62FZRWRJU4HLlgiALLWx2LVYN
         NyVxpamdFTeCfWZTr1i/sgKzzakJSAQ+d0NfCgnKRfzrHZ1dO/J6PJTWRy+0Q3oQk5hu
         /HVU+SO3TLFruOGEeaV0uJd0t7ljuaT7IZe5XiARJE8CgZ8j8aOF/NdmoLurk0mgcJzo
         XnfjJe8CWK9rmKUzer0DD7hEoVjJsIaw2oLGiFf5tgcUrQrwp+Vx+KR0vmnuNmm/a9nr
         eP7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759333040; x=1759937840;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HOhlFtoBnWaiM64nftJX9Q0scL17iSbfh4QHyZLgLlk=;
        b=hv/MBqSHK8IKHkfTeCNGdUrTB0VPe3o+jg7W6WDfhCenAbuNi6TojObDM9BN5R9434
         NcIghm+E2cEV3McnS7uHiRz0Xx65D6zF6N9qNkdVvE2yPqMB6I+17BADaGrMhIvj57+f
         pLk9EyObsJFzK2I7EmuRQfLHepK8J6Lf2KcRtvFOFj4bvH+fdFb77JWccNdicyV8DJcy
         l7IKTOfHwUW9Dj960NLjgn3MZRJDt3KrcSYAkS4fFJ9/umanAsbIXq06aPNfJyOvZ2t3
         eIO7joQ5EC94YwP9TgRCM58YGwB40+oQefmet2Gd1p+6U80WtkpGaNVdt3fGzBNfk+QS
         HDlA==
X-Forwarded-Encrypted: i=1; AJvYcCWfdyPqcNI9umWvXAMviy6zoIWhc+SUrWHPP0Lo2jMwhtaO1elQgRoiO/4XWPwkXtZkMloghX3yh0sYbGc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8cuN8YzeTfLqp01x3nK90bQgNIy6T1fkb6JrL2ytFZi7T1j6w
	GRMKBFkis/LCYTC9GAieFcWxOxOPQs2cem+ezryfRNClNq1tx8hQOrF1RAigyw==
X-Gm-Gg: ASbGncv4m1jxYUU/OKGOEZAhXgz28RiV2jJcf2hmN1Xo2qgOtVWaB8IDb/AI2wKCkMS
	c9a0AEdrZbdtmOUZqs6cX0RO6D72LFMN0NWLZXjgmYK9pWV4gMe/GViY55yR1LL8dJu+ae1SvHm
	d8d72sXUjqp7b3dDOmKZGfm4Q0DZdOXI79li3SNEGls754zzfiiJVN+3e6ANWXaL0msf1m+ZgYP
	eqH1cHYjNyP/3CP9QAf9LQ6Beoa1lDNnKe7vVI/TVZlHdl7T2awoWtzu1CongMVG9b+NiajJqZb
	AnCmFD92jPAM3F5gPuJHKjj1BVxnTXB6dAEb9JUlv4RNAurtnHCpvfvVfCRdj093lm0CZw9vZs5
	FpOxgZC/lNu/ssuLWEOYjWuATstC3w6bG8eg7ESlaltaXXp7GSZM9EUSCKkNJc+D0oIEijwWwmB
	pAb0JxrJ3b9OY=
X-Google-Smtp-Source: AGHT+IHKVJROpyMqw1QoZWrF7csKcCEketgdJMlIcKVy36nzcnmwP5FDc0ogNg5Bq4RBgd59dy6v4Q==
X-Received: by 2002:a05:690c:39a:b0:76b:cd91:e7c8 with SMTP id 00721157ae682-77f6f317c86mr59080407b3.25.1759333039546;
        Wed, 01 Oct 2025 08:37:19 -0700 (PDT)
Received: from localhost ([2a03:2880:25ff:8::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-77f67cb2a92sm12615607b3.46.2025.10.01.08.37.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Oct 2025 08:37:19 -0700 (PDT)
From: Joshua Hahn <joshua.hahnjy@gmail.com>
To: Hillf Danton <hdanton@sina.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	kernel-team@meta.com
Subject: Re: [PATCH v2 2/4] mm/page_alloc: Perform appropriate batching in drain_pages_zone
Date: Wed,  1 Oct 2025 08:37:16 -0700
Message-ID: <20251001153717.2379348-1-joshua.hahnjy@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250930221441.7748-1-hdanton@sina.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello Hillf, thanks for your continued interest in this series!

> > Hello Hillf,
> > 
> > Thank you for your feedback!
> > 
> > > Feel free to make it clear, which lock is contended, pcp->lock or
> > > zone->lock, or both, to help understand the starvation.
> > 
> > Sorry for the late reply. I took some time to run some more tests and
> > gather numbers so that I could give an accurate representation of what
> > I was seeing in these systems.
> > 
> > So running perf lock con -abl on my system and compiling the kernel,
> > I see that the biggest lock contentions come from free_pcppages_bulk
> > and __rmqueue_pcplist on the upstream kernel (ignoring lock contentions
> > on lruvec, which is actually the biggest offender on these systems.
> > This will hopefully be addressed some time in the future as well).
> > 
> > Looking deeper into where they are waiting on the lock, I found that they
> > are both waiting for the zone->lock (not the pcp lock, even for
> 
> One of the hottest locks again plays its role.

Indeed...

> > __rmqueue_pcplist). I'll add this detail into v3, so that it is more
> > clear for the user. I'll also emphasize why we still need to break the
> > pcp lock, since this was something that wasn't immediately obvious to me.
> > 
> > > If the zone lock is hot, why did numa node fail to mitigate the contension,
> > > given workloads tested with high sustained memory pressure on large machines
> > > in the Meta fleet (1Tb memory, 316 CPUs)?
> > 
> > This is a good question. On this system, I've configured the machine to only
> > use 1 node/zone, so there is no ability to migrate the contention. Perhaps
> 
> Thanks, we know why the zone lock is hot - 300+ CPUs potentially contended a lock.
> The single node/zone config may explain why no similar reports of large
> systems (1Tb memory, 316 CPUs) emerged a couple of years back, given
> NUMA machine is not anything new on the market.
> 
> > another approach to this problem would be to encourage the user to
> > configure the system such that each NUMA node does not exceed N GB of memory?
> > 
> > But if so -- how many GB/node is too much? It seems like there would be
> > some sweet spot where the overhead required to maintain many nodes
> > cancels out with the benefits one would get from splitting the system into
> > multiple nodes. What do you think? Personally, I think that this patchset
> > (not this patch, since it will be dropped in v3) still provides value in
> > the form of preventing lock monopolies in the zone lock even in a system
> > where memory is spread out across more nodes.
> > 
> > > Can the contension be observed with tight memory pressure but not highly tight? 
> > > If not, it is due to misconfigure in the user space, no?
> > 
> > I'm not sure I entirely follow what you mean here, but are you asking
> > whether this is a userspace issue for running a workload that isn't
> > properly sized for the system? Perhaps that could be the case, but I think
> 
> This is not complicated. Take another look at the system from another
> POV - what is your comment if running the same workload on the same
> system but with RAM cut down to 1Gb? If roughly it is fully loaded for a
> dentist to serve two patients well a day, getting the professional over
> loaded makes no sense I think.
> 
> In short, given the zone lock is hot in nature, soft lockup with reproducer
> hints misconfig.

While I definitely agree that spreading out 1TB across multiple NUMA nodes
is an option that should be considered, I am unsure if it makes sense to
dismiss this issue as simply a misconfiguration problem.

The reality is that these machines do exist, and we see zone lock contention
on these machines. You can also see that I ran performance evaluation tests
on relatively smaller machines (250G) and saw some performance gains.

The other point that I wanted to mention is that simply adding more NUMA
nodes is not always strictly beneficial; it changes how the scheduler
has to work, workloads would require more numa-aware tuning, etc.

Thanks for your feedback, Hillf. I hope you have a great day!
Joshua

