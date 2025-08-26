Return-Path: <linux-kernel+bounces-786539-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B3784B35B8F
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 13:25:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EBB9A160DA0
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 11:21:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 753DA31813A;
	Tue, 26 Aug 2025 11:19:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="D5rZ24ux"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7698338F36
	for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 11:19:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756207165; cv=none; b=dgSIPkGTdYIaKc1S4qcjIP0TTmXmuYVB/n7m08iV21/QNWWGZq42iKKZlxwnW1fzBfb7YPXkUF/e26JJLXTTCGzk9+vIEBDOMo823u7Dk6xt1Hbv15Rhm2h0Sj38i1hxA89QS7diWuFvU+/ao2KAHpHtLf3FYtrJNdn9W82VLeU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756207165; c=relaxed/simple;
	bh=D65QWKSM9pN9e8AMIUB748gQGVONPpAN1lsBSYePY+M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NvR5869fBMc9kPbEnMNFSMrjbE0U/cy27WhTuAZjACqbk+8RVPqMLxdJjUihDnk5UBGw4YMs1/fTWapmAXG75exRr9DtLKxjtByLKAEd8JBKV6/Fnbc43sLC2zDsUE8BBYdkk4EhIlvuxO41IetTdpZF2+TB2cB7uNecaP4CoGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=D5rZ24ux; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756207162;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pNRKdff2Ys8RanQTtN4VeDxIO5xowx3e0A00ZcmqvdY=;
	b=D5rZ24uxZD329Y9Tf48CWAw2oOe2pVf/QUVZwx213h7w1eBFAArO2fkGoF3MaT+uBaEgha
	sUViZ5eeLKTe8WGMFtqKxAEEKLE2zXLOVNtKuenwpOAXp2ITe9lyQ4f8UYqtC+oSbjt1Rl
	z18088vEvOjW9sQOiahKW4UNa74ZhGg=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-610-bzO-x2C7NUCV4URLtojfSw-1; Tue, 26 Aug 2025 07:19:18 -0400
X-MC-Unique: bzO-x2C7NUCV4URLtojfSw-1
X-Mimecast-MFC-AGG-ID: bzO-x2C7NUCV4URLtojfSw_1756207158
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-afe89c157e9so131665966b.3
        for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 04:19:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756207158; x=1756811958;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pNRKdff2Ys8RanQTtN4VeDxIO5xowx3e0A00ZcmqvdY=;
        b=WKJAlVkLWxPnxPajEUAPeaLh2tYuRIjBqvSE/Skq804+3hzr4c5cvKrCfdMuUUfZWN
         wCIf9HXG5Kr+VhgIbtx+qJO141Z+kwjP58x5KwJcdA8K8ZKVnaFCTM9n2o6eSPzReBkn
         hDTrHtBN6RLmJJg2s6himnqGzjmtdBvR3NZLqe68L0PimCmhEqms+6Xsaf8aecmMOSpj
         JN8BNNIloceYt5mwojPhNX0twZhPMb8AtbCSH3c8mjkQOz0hHq3bsmRPWHhkm+xJlgf4
         Mvx0J5zM4mwo87bANdctHOZoAn50f+XcBsa+6moTTgRmT8ly6Vg8/svDPq6NF7TwBpqg
         V4xA==
X-Forwarded-Encrypted: i=1; AJvYcCUOkczmS5MyuNClbe05Yx+5UQaFVbF/OV+PbcvqvDc5DNBIenPBxx+aMpJ9tKpr3kKK/W6UHOpAPmdIdgw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyq4E4KOYCbXbd66HmX6ufRqM1M8Bm56cTW1NwXFXArFsLpNcwk
	SwzGAoN5qD3pb+VDMv0nTCAKS+hEUW7Eb2Zrq/j7lkn0aofRuhMgqeTYUtwrPaXpWnOt2N88pWF
	vrlJyej/8WeB6E6fD2tKnm6yxLHAHKvk60Xi8wIccYHkScEbinOejR02XGvOSfvkVzPYDJEgbkH
	D6ERVfxVIQotef13iiKsyDBxQBp4qP0Z9aROiJtN2j
X-Gm-Gg: ASbGncuVT4NtikP0Eg0k/3xbJCwQ+2gUQ0BeDy6KOG9KJTUm1ar7ODuwh6Qoizd3Swz
	kaOPBF8W48ilMxIN4OposKJTPE6JMtWMA8tVZGoNSesFBUQzJ3AGJ5SLAN3iodZvt2LFsMk6oba
	WXE/lEpuTdqZzu8Q8n4HY=
X-Received: by 2002:a17:907:3e1c:b0:ae7:cb7:9005 with SMTP id a640c23a62f3a-afe296e6cc8mr1268932066b.35.1756207157560;
        Tue, 26 Aug 2025 04:19:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFao4TulVQAY9LGiYxoOXfzex73euZlH6UjPDCDFtMrMw28PLaLq1IaRySZ5HlunfHtZekdhWXhTBZ9OHwc3pk=
X-Received: by 2002:a17:907:3e1c:b0:ae7:cb7:9005 with SMTP id
 a640c23a62f3a-afe296e6cc8mr1268929066b.35.1756207157017; Tue, 26 Aug 2025
 04:19:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250816031657.906569-1-ysk@kzalloc.com>
In-Reply-To: <20250816031657.906569-1-ysk@kzalloc.com>
From: Tomas Glozar <tglozar@redhat.com>
Date: Tue, 26 Aug 2025 13:19:05 +0200
X-Gm-Features: Ac12FXzR8e-ZObNfxgNqsGRfcHjsPOiF_earOdPtLBTE-8cWeQFnZ8N63-z04hs
Message-ID: <CAP4=nvTOE9W+6UtVZ5-5gAoYeEQE8g4cgG602FJDPesNko-Bgw@mail.gmail.com>
Subject: Re: [WIP] coccinelle: rt: Add coccicheck on sleep in atomic context
 on PREEMPT_RT
To: Yunseong Kim <ysk@kzalloc.com>
Cc: Julia Lawall <Julia.Lawall@inria.fr>, Nicolas Palix <nicolas.palix@imag.fr>, 
	Easwar Hariharan <eahariha@linux.microsoft.com>, Gal Pressman <gal@nvidia.com>, 
	Hongbo Li <lihongbo22@huawei.com>, Kees Cook <kees@kernel.org>, cocci@inria.fr, 
	linux-rt-devel@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Yunseong,

so 16. 8. 2025 v 6:56 odes=C3=ADlatel Yunseong Kim <ysk@kzalloc.com> napsal=
:
>
> I'm working on a new Coccinelle script to detect sleep-in-atomic bugs in
> PREEMPT_RT kernels. This script identifies calls to sleeping functions
> (e.g., mutex_lock, msleep, kmalloc with GFP_KERNEL, spin_lock which may
> sleep in PREEMPT_RT) within atomic contexts (e.g., raw_spin_lock,
> preempt_disable, bit_spin_lock).
>
> It supports both direct calls and indirect call chains through
> inter-procedural analysis using function call graphs. Memory allocations
> are handled including GFP_ATOMIC/NOWAIT. This is a WIP patch for early
> feedback. I've tested it with make coccicheck on various subsystems, but
> there are still issues with position variables sometimes being tuples,
> leading to "Invalid position info" warnings and incomplete data collectio=
n.

I can share some of my own experience. I wrote a similar tool for the
same problem two years ago, called rtlockscope [1], which uses ctags
to get a list of all functions, CScope to get a function call graph,
and assigning a summary to each function based on its callees. The
results could use some improvement, since it reduces control flow to
an ordering of callees, and assumes that all symbols are global (e.g.
an ARM-only function is seen as called from x86-only code).

[1] Repo: https://gitlab.com/tglozar/rtlockscope, LPC talk slides:
https://lpc.events/event/18/contributions/1735/attachments/1428/3051/lpc202=
4talk.pdf;
currently I'm focusing on getting more reliable results using automata
abstractions.

>
> The script includes defensive checks, but indirect bugs are not always
> detected. I'd appreciate any suggestions on improving the Python handling
> of position variables or the SmPL rules for better matching in complex co=
de
> (e.g., macros, inlines). The script is added to scripts/coccinelle/rt/.
>

My tool captures macros, but it reports a lot of false positives via
various KASAN and printing routines. For example:

Sleeping lock called at:
__cache_free at mm/slab.c:3617
___cache_free at mm/slab.c:3378
do_slab_free at mm/slub.c:3816
__slab_free at mm/slub.c:3796
put_cpu_partial at mm/slub.c:3679
local_lock_irqsave at mm/slub.c:2703
__local_lock_irqsave at include/linux/local_lock.h:31
__local_lock at include/linux/local_lock_internal.h:128
spin_lock at include/linux/local_lock_internal.h:119

preemption disabled at:
__cache_free at mm/slab.c:3617
kasan_slab_free at mm/slab.c:3370
__kasan_slab_free at include/linux/kasan.h:164
____kasan_slab_free at mm/kasan/common.c:244
kasan_quarantine_put at mm/kasan/common.c:238
raw_spin_lock at mm/kasan/quarantine.c:224
_raw_spin_lock at include/linux/spinlock.h:217
__raw_spin_lock at kernel/locking/spinlock.c:154
preempt_disable at include/linux/spinlock_api_smp.h:132

But that might be just because I'm also tracking indirect
preempt_disable though (see below). I'm not familiar with Coccinelle
unfortunately, I considered it for a while, but opted for a different
approach.

> Detects sleep-in-atomic bugs in PREEMPT_RT kernels by identifying imprope=
r
> calls to functions that may sleep, such as mutex locks, explicit sleep
> functions (e.g., msleep), memory allocations and sleepable spinlocks,
> within atomic contexts created by preempt_disable, raw_spin_lock,
> irq_disable (e.g. bit_spin_lock).
>
> 1. Detection of direct calls to sleeping functions in atomic scopes.
> 2. Analysis of inter-procedural call chains to uncover indirect calls to
>    sleeping functions via function call graphs.
> 3. Handling of memory allocation functions that may sleep.
>    (including GFP_ATOMIC).
>

If I understand your code properly, you only match on a specific case
of sleeping in atomic context, where the offending call is directly in
between "preempt disable" and "preempt enable".

That means that your script only takes indirection into account for
sleeping functions, not for disabling preemption/atomic context. There
are some occurrences where custom "lock" functions call
preempt_disable in the kernel, so this is needed in order not to miss
those. But it might be better to skip them to prevent flooding the
output with a lot of false positives, since one unmatched
preempt_disable will pollute the rest of the function (and every
function that calls it).

> This cocci script should identify direct and indirect sleep-in-atomic
> violations, improving PREEMPT_RT compatibility across kernel code.
> For example:
> Link: https://lore.kernel.org/linux-rt-devel/7a68c944-0199-468e-a0f2-ae2a=
9f21225b@kzalloc.com/t/#u
>

There are likely still tens of these bugs across different subsystems,
I remember fixing one in nvdimm and one in BPF.

There is also a 2018 paper, Effective Detection of
Sleep-in-Atomic-Context Bugs in the Linux Kernel [2], which covers
this problem without taking PREEMPT_RT into account. They identify
three challenges: accurately processing control flow, handling
function pointers, and handling different code paths. Notably, they
also use summaries, and handle sleeping in atomic context in interrupt
handlers. Overall, it looks like it uses the same general approach as
rtlockscope and your Coccinelle script, just more polished, so you
might want to have a look at it (if you have not seen it yet). Of
course, on PREEMPT_RT, there is an additional challenge in
distinguishing between RT and non-RT paths (like code that sleeps only
on RT and disables preemption only on non-RT).

[2] https://hal.science/hal-03032244



Tomas


