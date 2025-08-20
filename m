Return-Path: <linux-kernel+bounces-778115-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A2DAAB2E186
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 17:54:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 15C861C4466B
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 15:49:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28CE5322552;
	Wed, 20 Aug 2025 15:49:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Juo0qmgF"
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1019322544
	for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 15:48:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755704940; cv=none; b=iXc+84qb29d+LOrkeq2vcYHsoLE/6hVzXPrYqkYCZq7SiYR0jUFLa3CNZoFZ8rIsDJDJv2EQtJ2ZYgbZbfD3PdKtQ1cYR8SmgLHRV5Hn6/LM7ccSh14bwFWVtewgdqLrpFP1Qbd8zWlaqJo3W0rMNald8aij2bciQZivIk5FWtQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755704940; c=relaxed/simple;
	bh=Hz2c0QipImHNIT9RINImWk+xubu9D/S0+Gn4csaJFqI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OP+LYTjmOhnEwDdGs+FTrM4GWK4xrFqS7P41T2yWf4lEhZD03cbqpr3Kdix38DT5fEOwKXkKSiBDwm7lISBqYCIW2AGH6S1rv3XvZulO1Pp6TM67Ovf7A8Js50UGrTOL6e570xBfUbWeobjT2AqXpFVOaB8iknuM++cDwC04S58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Juo0qmgF; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-71d60504db9so55010107b3.2
        for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 08:48:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755704937; x=1756309737; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YapFlZLhDO6WeQ4sTaP804rPtqfECGySrXHAqDQV/uc=;
        b=Juo0qmgFbNy0IxE299iwXDyY1p1poydmdLLiQtQF9P4jY09AyOot0sbjLfZcaGMM0A
         A4X+/4shG3xQiI1ZLZ5iNLXmyQmha2N5kVIpXlULdn8bmSRs2ZkbSU3D7AiGa2Vd8faV
         5P8a9Ml3F8L0+kVm4t/MAvDpfIwVf1wXn2sa8goxJfimeHJhE2QuBhWJaUBMImpjLClW
         tHbaCSllMLtzJqph/ustxrm3KFGAlV4WuuuITulvSSF8DUv35iWYbL70b9ajHtAXeA9g
         AqAK14xxdCL4OCjVKOgaT+MXY41l0A/irOAjj50MuplASYWV+n3GJhMI1cMYHx5yMiiS
         kt0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755704937; x=1756309737;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YapFlZLhDO6WeQ4sTaP804rPtqfECGySrXHAqDQV/uc=;
        b=n0vGSH5vBt+495gcaEbs057Sav4XortfgSav0g4WwgjrNpIIJVYCLp+j+7oZL0IkdI
         AQjIb1fPHcqxy0qdcqRKemDZyb+PnwGhE+r00Q/wjNxLNO80VmCiJB81vExEMzOBqaz0
         kadE0H4gjEH/RyIEDatbPVkqiQGo2GTlp0v2HVb+/RkJxTDNL5FUQRwBP/+EMIN1EvFq
         PC8oY4kwqQ2lA+EEn0h0PXJKPjTTiwg/xDira+7dl+u8dN25aK4khsDIhvGejWMtgO+p
         yuvB9V9DKROYz2i19+a+35Coqaz4t9b+leH76dOsfX/PoDc4Nc0dWeHXf8WFBCU4GeZr
         VmvA==
X-Forwarded-Encrypted: i=1; AJvYcCVaShEvjr09l1uYExPmC1B0G6qM2Q7P5s127Orolq/tn8T5j9rK+ZPKdUyNFblzZnuw+zi3EfN0EyyoZR0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwXtzKV3Qio6NNlFB+Co/tQE2fIXG78Qik111IMvmFBwtU78uqj
	X/zKRsc0W31270aVr5tHxXwLz5P5zGC+UdeJ8WwxT7FE3D30FD3K0fnb
X-Gm-Gg: ASbGnctqNxj26KH5TfRQuzKmX8dY342S+3wG8hZDo3q6BFJ9CQ/c49dKhGtNb8xfuQx
	YujelWZ+lbPTUjA7TBTMeSC+7UsUPQmgY9wOOEWE410Wma/L4pQ9yTpGMeDW0AUk9fxJyAnB22i
	ti5A6Tb7wZQVK7nhdX75a0YfvTp3ga5Cb3PEDujetRWDPHVBHup9O+qGhqzsd4e4mTY0eC49AsH
	e29FpiLPKxQJdQVQzeiQfBRHng2xySPYQcQsm6qy1qvrykaU/3DROLrVmHw+HjUUfYKbvGJP77Y
	gFKVVHqHxC9jpPqbNKPgdCYHrywYNLJFvqNNWopMf2lpOZnMiGHltJ34ysfRcB+5g7dXvSEpRlb
	5QKbyuymQw9dWaRJG21UqRA==
X-Google-Smtp-Source: AGHT+IFnBectO9j5CKIBEIOyjSzsK1xF+OQVRcvut6PzymCeGy0chKH+uklouHbhduerRNsx19yK+g==
X-Received: by 2002:a05:690c:6e13:b0:71f:9a36:d33a with SMTP id 00721157ae682-71fb322d649mr33501547b3.44.1755704937493;
        Wed, 20 Aug 2025 08:48:57 -0700 (PDT)
Received: from localhost ([2a03:2880:25ff:4d::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-71e6e068f64sm37561437b3.40.2025.08.20.08.48.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Aug 2025 08:48:57 -0700 (PDT)
From: Joshua Hahn <joshua.hahnjy@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>,
	Chris Mason <clm@fb.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Brendan Jackman <jackmanb@google.com>,
	Zi Yan <ziy@nvidia.com>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	kernel-team@meta.com
Subject: Re: [PATCH] mm/page_alloc: Occasionally relinquish zone lock in batch freeing
Date: Wed, 20 Aug 2025 08:48:54 -0700
Message-ID: <20250820154855.2002698-1-joshua.hahnjy@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250819224111.e710eab683b7c7f941c7d1a7@linux-foundation.org>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, 19 Aug 2025 22:41:11 -0700 Andrew Morton <akpm@linux-foundation.org> wrote:

Hello Andrew, thank you again for your input : -)

> On Mon, 18 Aug 2025 11:58:03 -0700 Joshua Hahn <joshua.hahnjy@gmail.com> wrote:
> 
> > While testing workloads with high sustained memory pressure on large machines
> > (1TB memory, 316 CPUs), we saw an unexpectedly high number of softlockups.
> > Further investigation showed that the lock in free_pcppages_bulk was being held
> > for a long time, even being held while 2k+ pages were being freed.
> 
> It would be interesting to share some of those softlockup traces.

Unfortunately it has been a long time since these softlockups have been detected
on our fleet, so the records of them have disappeared : -(

What I do have is an example trace of a rcu stall warning:

[ 4512.591979] rcu: INFO: rcu_sched self-detected stall on CPU
[ 4512.604370] rcu: 	20-....: (9312 ticks this GP) idle=a654/1/0x4000000000000000 softirq=309340/309344 fqs=5426
[ 4512.626401] rcu: 	         hardirqs   softirqs   csw/system
[ 4512.638793] rcu: 	 number:        0        145            0
[ 4512.651177] rcu: 	cputime:       30      10410          174   ==> 10558(ms)
[ 4512.666657] rcu: 	(t=21077 jiffies g=783665 q=1242213 ncpus=316)

And here is the trace that accompanies it:

[ 4512.666815] RIP: 0010:free_unref_folios+0x47d/0xd80
[ 4512.666818] Code: 00 00 31 ff 40 80 ce 01 41 88 76 18 e9 a8 fe ff ff 40 84 ff 0f 84 d6 00 00 00 39 f0 0f 4c f0 4c 89 ff 4c 89 f2 e8 13 f2 fe ff <49> f7 87 88 05 00 00 04 00 00 00 0f 84 00 ff ff ff 49 8b 47 20 49
[ 4512.666820] RSP: 0018:ffffc900a62f3878 EFLAGS: 00000206
[ 4512.666822] RAX: 000000000005ae80 RBX: 000000000000087a RCX: 0000000000000001
[ 4512.666824] RDX: 000000000000007d RSI: 0000000000000282 RDI: ffff89404c8ba310
[ 4512.666825] RBP: 0000000000000001 R08: ffff89404c8b9d80 R09: 0000000000000001
[ 4512.666826] R10: 0000000000000010 R11: 00000000000130de R12: ffff89404c8b9d80
[ 4512.666827] R13: ffffea01cf3c0000 R14: ffff893d3ac5aec0 R15: ffff89404c8b9d80
[ 4512.666833]  ? free_unref_folios+0x47d/0xd80
[ 4512.666836]  free_pages_and_swap_cache+0xcd/0x1a0
[ 4512.666847]  tlb_finish_mmu+0x11c/0x350
[ 4512.666850]  vms_clear_ptes+0xf9/0x120
[ 4512.666855]  __mmap_region+0x29a/0xc00
[ 4512.666867]  do_mmap+0x34e/0x910
[ 4512.666873]  vm_mmap_pgoff+0xbb/0x200
[ 4512.666877]  ? hrtimer_interrupt+0x337/0x5c0
[ 4512.666879]  ? sched_clock+0x5/0x10
[ 4512.666882]  ? sched_clock_cpu+0xc/0x170
[ 4512.666885]  ? irqtime_account_irq+0x2b/0xa0
[ 4512.666888]  do_syscall_64+0x68/0x130
[ 4512.666892]  entry_SYSCALL_64_after_hwframe+0x4b/0x53
[ 4512.666896] RIP: 0033:0x7f1afe9257e2

> We have this CONFIG_PCP_BATCH_SCALE_MAX which appears to exist to
> address precisely this issue.  But only about half of the
> free_pcppages_bulk() callers actually honor it.

I see. I think this makes sense, and I also agree that there should probably be
some guardrails from the callers of this function, especially since free
pcppages bulk is unaware of how the pcp lock is acquired / freed.

Functions like drain_zone_pages, which explicitly enforce this by setting
"to_drain" to be min(pcp->batch, pcp->count) seem like a smart way to do this.

> So perhaps the fix is to fix the callers which forgot to implement this?
> 
> - decay_pcp_high() tried to implement CONFIG_PCP_BATCH_SCALE_MAX, but
>   that code hurts my brain.

To be honest, I don't fully understand decay_pcp_high() as well : -)
From what I can tell, it seems like CONFIG_PCP_BATCH_SCALE_MAX doesn't directly
pass in a value that limits how many pages are freed at once for the bulk
freer, but rather tunes the parameters pcp->high. (Except for drain_pages_zone,
which you have pointed out below).

> - drain_pages_zone() implements it but, regrettably, doesn't use it
>   to periodically release pcp->lock.  Room for improvement there.

From what I can see, it seems like drain_pages_zone() does release pcp->lock
every pcp->batch << CONFIG_PCP_BATCH_SCALE_MAX (simplified pseudocode below)

do {
	spin_lock(&pcp->lock);
	to_drain = min(count, pcp->batch << CONFIG_PCP_BATCH_SCALE_MAX);
	free_pcppages_bulk(zone, to_drain, ...);
	spin_unlock(&pcp->lock);
} while (count);

Although, the concern you raised earlier of whether another thread can
reasonably grab pcp->lock during the short check between the unlock and lock
is still valid here (which means the concern is also relieved if the machine is
x86, arm64, or any other arch that defaults spin locks to be queued).

With all of this said, I think adding the periodic unlocking / locking of the
zone lock within free_pcppages_bulk still makes sense; if the caller enforces
count to be <= pcp->batch, then the check is essentially a no-op; otherwise, we
create some locking safety, whihc would protect it in case there are any new
callers in the future, which forget to add the check as well.

Thank you for your thoughtful review, Andrew. I hope you have a great day!
Joshua

Sent using hkml (https://github.com/sjp38/hackermail)

