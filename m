Return-Path: <linux-kernel+bounces-751263-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 04554B16709
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 21:45:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EBCE03B311B
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 19:44:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0BD7204C3B;
	Wed, 30 Jul 2025 19:45:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="TTee3jR4";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="6/Gz0aKb"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCFF61FAC54
	for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 19:44:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753904700; cv=none; b=a4Bx69qjKdQv3gyBGMxZo9UGjjmlMD7lb7eYbttKg4uPt2e5UMoA94JLmlNUKc3RZHmmA19cS9GVWPZGVkfyK6vicpY+EIFYhQB6VAir9pXiim5wV4/XbMQSsvcYIWOpaxyx8Yeo+q16pbr0JPbVuSgD6ZvL5noIeKBmU/87VV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753904700; c=relaxed/simple;
	bh=Ke9lyDaaMDdndi2lxCQE1wADg998E4SFP0E2I6SEiUY=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:MIME-Version:
	 Content-Type; b=Ivn96WppYrylAwTnHeo488k7L13veN8gYarypcv7VW/MAb8yBvsCTXryqJa6WN14j2uPmdw3U9VNSvT0krYjs6s96G6ubvaO30SKjl4SwA6yzC6SY0Y1ayTdyhTJNyM0SyUgG+MrPNWi65zsjBEb1EsaNpGdX4gitg1QqiKSVsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=TTee3jR4; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=6/Gz0aKb; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1753904696;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:  in-reply-to:in-reply-to;
	bh=cgIR3LlEqm5Yn4FbgFmfo81Tc4TUNuPGbcZVD8SuLzs=;
	b=TTee3jR4JgLVEmuOlv5TLzXRmHqeQhruQHEhwnOfbjfW/3/AF71PJM5ag9KGfK3f1PfXah
	44cuO6UyKwwmXB4RDgwrrGbOdQgxQEmRaBhvDJB+Yw2b1/XOfK5BCJXFg9eDiTLcYjtKu5
	xk2VTq3M+zcpqavajvn79gMJzE9VIMgZTfJT0rfe+w+4u0Ntd5/vpex4LDamvmJY7eVXin
	X2iZLaRJZWqwMMLMCbXLlt+9zQEeC7sJBs9BWxvssHklMB2QrLAv5j94UhEAGCCU4gYBOM
	ao4CGkjFc/G6NzEW6lQUA4DOFhKAe1KN2KCWCHYKBBvmm5H0tnOG8EKKqcYeHg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1753904696;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:  in-reply-to:in-reply-to;
	bh=cgIR3LlEqm5Yn4FbgFmfo81Tc4TUNuPGbcZVD8SuLzs=;
	b=6/Gz0aKbOJRDitx+CqwintG72qHhWn2ENuaJEAHGtoXwk2w+2JlJXrSLoqBK75YWS2j+bV
	01onNiQW+J6VLuAg==
To: =?utf-8?Q?Andr=C3=A9?= Draszik <andre.draszik@linaro.org>, Sebastian
 Andrzej Siewior <bigeasy@linutronix.de>, linux-kernel@vger.kernel.org
Cc: =?utf-8?Q?Andr=C3=A9?= Almeida <andrealmeid@igalia.com>, Darren Hart
 <dvhart@infradead.org>, Davidlohr Bueso <dave@stgolabs.net>, Ingo Molnar
 <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>, Peter Zijlstra
 <peterz@infradead.org>, Valentin
 Schneider <vschneid@redhat.com>, Waiman Long <longman@redhat.com>, Andrew
 Morton <akpm@linux-foundation.org>, David Hildenbrand <david@redhat.com>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, Lorenzo Stoakes
 <lorenzo.stoakes@oracle.com>, Michal Hocko <mhocko@suse.com>, Mike
 Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>,
 Vlastimil Babka <vbabka@suse.cz>, linux-mm@kvack.org
Subject: Re: [PATCH v2 2/6] futex: Use RCU-based per-CPU reference counting
 instead of rcuref_t
In-Reply-To: <0c8cc83bb73abf080faf584f319008b67d0931db.camel@linaro.org>
Date: Wed, 30 Jul 2025 21:44:55 +0200
Message-ID: <87ldo5ihu0.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 30 2025 at 13:20, Andr=C3=A9 Draszik wrote:
> kmemleak complains about a new memleak with this commit:
>
> [  680.179004][  T101] kmemleak: 1 new suspected memory leaks (see /sys/k=
ernel/debug/kmemleak)
>
> $ cat /sys/kernel/debug/kmemleak
> unreferenced object (percpu) 0xc22ec0eface8 (size 4):
>   comm "swapper/0", pid 1, jiffies 4294893115
>   hex dump (first 4 bytes on cpu 7):
>     01 00 00 00                                      ....
>   backtrace (crc b8bc6765):
>     kmemleak_alloc_percpu+0x48/0xb8
>     pcpu_alloc_noprof+0x6ac/0xb68
>     futex_mm_init+0x60/0xe0
>     mm_init+0x1e8/0x3c0
>     mm_alloc+0x5c/0x78
>     init_args+0x74/0x4b0
>     debug_vm_pgtable+0x60/0x2d8
>
> Reverting this commit (and patches 3 and 4 in this series due to context),
> makes kmemleak happy again.

Unsurprisingly ...

debug_vm_pgtable() allocates it via mm_alloc() -> mm->init() and then
after the selftest it invokes mmdrop(), which does not free it, as it is
only freed in __mmput().

The patch below should fix it.

Thanks,

        tglx
---
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -686,6 +686,7 @@ void __mmdrop(struct mm_struct *mm)
 	mm_pasid_drop(mm);
 	mm_destroy_cid(mm);
 	percpu_counter_destroy_many(mm->rss_stat, NR_MM_COUNTERS);
+	futex_hash_free(mm);
=20
 	free_mm(mm);
 }
@@ -1133,7 +1134,6 @@ static inline void __mmput(struct mm_str
 	if (mm->binfmt)
 		module_put(mm->binfmt->module);
 	lru_gen_del_mm(mm);
-	futex_hash_free(mm);
 	mmdrop(mm);
 }
=20

