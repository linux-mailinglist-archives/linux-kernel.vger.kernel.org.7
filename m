Return-Path: <linux-kernel+bounces-886243-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 04D1FC35127
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 11:18:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7C05A4F0FE8
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 10:18:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90CC43002D0;
	Wed,  5 Nov 2025 10:18:19 +0000 (UTC)
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49E762FFFB4
	for <linux-kernel@vger.kernel.org>; Wed,  5 Nov 2025 10:18:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762337899; cv=none; b=bbytHu8tBdb8KR2td+QETkFiS/i0yTtX7Z1/eGqkPlXNstAuSaWvJGP5YkCcxvKmr5tUjPOZuHp9duMbjtlQMIluPFuaaEksjfPhdBFOomslAlsOQKoEA7P2a3LH0AvBebGYpQpS/oLik7lvuASps7fHxX6iPReHy0isHx1W4Ak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762337899; c=relaxed/simple;
	bh=w4Q3tSFMoR02WDdtF03wIIwXMyl+pJLqWG4iANl0i4A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WALComAt9a02S8gFlC2+Xb6DfhTO4uLzYTnA/Lq9LWKlERejIzdtUVcAUfnJQrbYbRJN6F0ZUxcH3GCITZTjzMseRFgYtRFK22ArWtgaL84eDx6lYIH/5NDMO8kC8fSQ+x4/N9adj/HG62cFHMoKJSwpi/I/UgJQddNX79kPnlo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-640f0f82da9so2613223a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 05 Nov 2025 02:18:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762337896; x=1762942696;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O+nitTwb5WJ+EUmnDTJjRK0YITVPRlucFpEPdRpx4NY=;
        b=LrW/g2Tk1KZsazwOWWfwG/tppDwI8cA7TsgKPMIC/nKqcetdn0JJP1npLrg0zTuv6T
         6RW8LPpUjpg/PatIwysR7RjB8QH7FLDtq5NwLQZTLbBQjSxpN9eeYlZ6Oqs66Zs6b6gB
         ozgzNCA1jxxSnFqQwUtQ1armb0S+hr9GLj9kTFePCgrH6Q2VcxnlLqZQlFqDQBb/lc6x
         q78g92d1XMy6lViJwzl9jAZBHPdDmxO46m0ruzUg6BX0ZY6I0vUrCPUAxEhDZ195vFMw
         rapxKg3cehPKeg0ujXYP/1Xr2P5EkmOcGB7D357M47AlbD3mosocGq3Sl1lhI1uQmXTo
         476w==
X-Forwarded-Encrypted: i=1; AJvYcCX4kTsebmZa73gP2ZBQuNea3lJXYxLboXF4FzksW7uO0Hum3WdoTm0ePOWOkPE/GgZkRDUZLITxfxjXCjA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyUd3rN5ohOUwCaX0+PBG36slN9GsMG2jyVAyZ0ke2z0rYVe5GQ
	zV5NS48tFcM61Iu+g3+VtdIg3YMFX5DHhrHHzQPMfCH0+8tJeKZoYXiB
X-Gm-Gg: ASbGncsP+t/VeJd0OIanuVroc83AqRLI+xqUzJcFl8k9rLOekBnhtKpYol62Z7Zeseo
	QaoNn65AsDG+U4ihAPBR6YDnjf7fWLkOha87Mde+00ayf0sJODJds3Foi+Qb9QxqIKO7zw8KbZC
	EW9LOFaYRLEIo+xkJd4tv3zfqwP5aRW8CJWaPhMoGKYtXSjd2gF0D9dMn/+unvitIgxWKYYSGHs
	33wdtMMRdjEMKfZzmM/zTQHOJGX7TeDJYpzEq6aANebwtciItzr615k5ysCh6xhc1XX6ScIOx0K
	OgVH1EspDpPfHlb9rSF4+W2Js91AKcT5g+rnw/0/IJQTSGnGA472hrB+m7H0cYXPapon9fek5wg
	XnGCqQ8reUv8Yo3hxwAFNEqHz/AtMwnqw1juTPZKDunmdePusxFuFn08Ls9rdbNCELjY=
X-Google-Smtp-Source: AGHT+IGMOyHdTrU7e4XzICZCye2rZuaFGN3pfPJ6kDUtI82R9LpfHeUzLCsG0FSLtDRWmVaLyRXkdA==
X-Received: by 2002:a05:6402:5351:20b0:63e:6d38:865 with SMTP id 4fb4d7f45d1cf-64105b7a684mr1701971a12.36.1762337895297;
        Wed, 05 Nov 2025 02:18:15 -0800 (PST)
Received: from gmail.com ([2a03:2880:30ff:74::])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-640ebbdc7cesm3763441a12.35.2025.11.05.02.18.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Nov 2025 02:18:14 -0800 (PST)
Date: Wed, 5 Nov 2025 02:18:11 -0800
From: Breno Leitao <leitao@debian.org>
To: Pratyush Yadav <pratyush@kernel.org>
Cc: Changyuan Lyu <changyuanl@google.com>, rppt@kernel.org, 
	akpm@linux-foundation.org, linux-kernel@vger.kernel.org, anthony.yznaga@oracle.com, 
	arnd@arndb.de, ashish.kalra@amd.com, benh@kernel.crashing.org, bp@alien8.de, 
	catalin.marinas@arm.com, corbet@lwn.net, dave.hansen@linux.intel.com, 
	devicetree@vger.kernel.org, dwmw2@infradead.org, ebiederm@xmission.com, graf@amazon.com, 
	hpa@zytor.com, jgowans@amazon.com, kexec@lists.infradead.org, krzk@kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org, linux-mm@kvack.org, luto@kernel.org, 
	mark.rutland@arm.com, mingo@redhat.com, pasha.tatashin@soleen.com, pbonzini@redhat.com, 
	peterz@infradead.org, robh@kernel.org, rostedt@goodmis.org, saravanak@google.com, 
	skinsburskii@linux.microsoft.com, tglx@linutronix.de, thomas.lendacky@amd.com, will@kernel.org, 
	x86@kernel.org
Subject: Re: [PATCH v8 01/17] memblock: add MEMBLOCK_RSRV_KERN flag
Message-ID: <c2nrxby4atq75o5yhwdpoikyso42tzimwn2bnl7fk54wuwdqax@i6kdssez3kfj>
References: <20250509074635.3187114-1-changyuanl@google.com>
 <20250509074635.3187114-2-changyuanl@google.com>
 <ef6wfr72set5wa5el3wbbu4yd5tnc4p2rhtjpb5kpmncv3xs5d@i3c5v3ciioi3>
 <mafs0wm4yluej.fsf@kernel.org>
 <mafs0h5w2lpqu.fsf@kernel.org>
 <2ege2jfbevtunhxsnutbzde7cqwgu5qbj4bbuw2umw7ke7ogcn@5wtskk4exzsi>
 <mafs0cy6pljci.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <mafs0cy6pljci.fsf@kernel.org>

Hello Pratyush,

On Tue, Oct 14, 2025 at 03:10:37PM +0200, Pratyush Yadav wrote:
> On Tue, Oct 14 2025, Breno Leitao wrote:
> > On Mon, Oct 13, 2025 at 06:40:09PM +0200, Pratyush Yadav wrote:
> >> On Mon, Oct 13 2025, Pratyush Yadav wrote:
> >> >
> >> > I suppose this would be useful. I think enabling memblock debug prints
> >> > would also be helpful (using the "memblock=debug" commandline parameter)
> >> > if it doesn't impact your production environment too much.
> >> 
> >> Actually, I think "memblock=debug" is going to be the more useful thing
> >> since it would also show what function allocated the overlapping range
> >> and the flags it was allocated with.
> >> 
> >> On my qemu VM with KVM, this results in around 70 prints from memblock.
> >> So it adds a bit of extra prints but nothing that should be too
> >> disrupting I think. Plus, only at boot so the worst thing you get is
> >> slightly slower boot times.
> >
> > Unfortunately this issue is happening on production systems, and I don't
> > have an easy way to reproduce it _yet_.
> >
> > At the same time, "memblock=debug" has two problems:
> >
> >  1) It slows the boot time as you suggested. Boot time at large
> >     environments is SUPER critical and time sensitive. It is a bit
> >     weird, but it is common for machines in production to kexec
> >     _thousands_ of times, and kexecing is considered downtime.
> 
> I don't know if it would make a real enough difference on boot times,
> only that it should theoretically affect it, mainly if you are using
> serial for dmesg logs. Anyway, that's your production environment so you
> know best.
> 
> >
> >     This would be useful if I find some hosts getting this issue, and
> >     then I can easily enable the extra information to collect what
> >     I need, but, this didn't pan out because the hosts I got
> >     `memblock=debug` didn't collaborate.
> >
> >  2) "memblock=debug" is verbose for all cases, which also not necessary
> >     the desired behaviour. I am more interested in only being verbose
> >     when there is a known problem.

I am still interested in this problem, and I finally found a host that
constantly reproduce the issue and I was able to get `memblock=debug`
cmdline. I am running 6.18-rc4 with some debug options enabled.

	DMA-API: exceeded 7 overlapping mappings of cacheline 0x0000000006d6e400
	WARNING: CPU: 58 PID: 828 at kernel/dma/debug.c:463 add_dma_entry+0x2e4/0x330
	pc : add_dma_entry+0x2e4/0x330
	lr : add_dma_entry+0x2e4/0x330
	sp : ffff8000b036f7f0
	x29: ffff8000b036f800 x28: 0000000000000001 x27: 0000000000000008
	x26: ffff8000835f7fb8 x25: ffff8000835f7000 x24: ffff8000835f7ee0
	x23: 0000000000000000 x22: 0000000006d6e400 x21: 0000000000000000
	x20: 0000000006d6e400 x19: ffff0003f70c1100 x18: 00000000ffffffff
	x17: ffff80008019a2d8 x16: ffff80008019a08c x15: 0000000000000000
	x14: 0000000000000000 x13: 0000000000000820 x12: ffff00011faeaf00
	x11: 0000000000000000 x10: ffff8000834633d8 x9 : ffff8000801979d4
	x8 : 00000000fffeffff x7 : ffff8000834633d8 x6 : 0000000000000000
	x5 : 00000000000bfff4 x4 : 0000000000000000 x3 : ffff0001075eb7c0
	x2 : 0000000000000000 x1 : 0000000000000000 x0 : ffff0001075eb7c0
	Call trace:
	add_dma_entry+0x2e4/0x330 (P)
	debug_dma_map_phys+0xc4/0xf0
	dma_map_phys (/home/leit/Devel/upstream/./include/linux/dma-direct.h:138 /home/leit/Devel/upstream/kernel/dma/direct.h:102 /home/leit/Devel/upstream/kernel/dma/mapping.c:169)
	dma_map_page_attrs (/home/leit/Devel/upstream/kernel/dma/mapping.c:387)
	blk_dma_map_direct.isra.0 (/home/leit/Devel/upstream/block/blk-mq-dma.c:102)
	blk_dma_map_iter_start (/home/leit/Devel/upstream/block/blk-mq-dma.c:123 /home/leit/Devel/upstream/block/blk-mq-dma.c:196)
	blk_rq_dma_map_iter_start (/home/leit/Devel/upstream/block/blk-mq-dma.c:228)
	nvme_prep_rq+0xb8/0x9b8
	nvme_queue_rq+0x44/0x1b0
	blk_mq_dispatch_rq_list (/home/leit/Devel/upstream/block/blk-mq.c:2129)
	__blk_mq_sched_dispatch_requests (/home/leit/Devel/upstream/block/blk-mq-sched.c:314)
	blk_mq_sched_dispatch_requests (/home/leit/Devel/upstream/block/blk-mq-sched.c:329)
	blk_mq_run_work_fn (/home/leit/Devel/upstream/block/blk-mq.c:219 /home/leit/Devel/upstream/block/blk-mq.c:231)
	process_one_work (/home/leit/Devel/upstream/kernel/workqueue.c:991 /home/leit/Devel/upstream/kernel/workqueue.c:3213)
	worker_thread (/home/leit/Devel/upstream/./include/linux/list.h:163 /home/leit/Devel/upstream/./include/linux/list.h:191 /home/leit/Devel/upstream/./include/linux/list.h:319 /home/leit/Devel/upstream/kernel/workqueue.c:1153 /home/leit/Devel/upstream/kernel/workqueue.c:1205 /home/leit/Devel/upstream/kernel/workqueue.c:3426)
	kthread (/home/leit/Devel/upstream/kernel/kthread.c:386 /home/leit/Devel/upstream/kernel/kthread.c:457)
	ret_from_fork (/home/leit/Devel/upstream/entry.S:861)


Looking at memblock debug logs, I haven't seen anything related to
0x0000000006d6e400.

I got the output of `dmesg | grep memblock` in, in case you are curious:

	https://github.com/leitao/debug/blob/main/pastebin/memblock/dmesg_grep_memblock.txt

Thanks
--breno

