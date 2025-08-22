Return-Path: <linux-kernel+bounces-781729-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EF254B315F8
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 12:57:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A04511D029A7
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 10:57:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 578AF2F90DB;
	Fri, 22 Aug 2025 10:57:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="KrIwDyqY";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="LRKurpbp"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32D682F99AE
	for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 10:57:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755860237; cv=none; b=LXkat513xJxw1xc6uhKoNpOvhfoD1AE7udvkK5xgTYqFRO+qoAEhf5ODwWeD2hrQEKDEhN0MYEi6egQMVrdEz5aw0392MGinDjeHMANaFqQgV2+kKECXsZ1og+hkhw3dbvpMtbqROD5c30I0CgwvSq1E/Vh0UkczYMYEpjO08SQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755860237; c=relaxed/simple;
	bh=wCcj79rEkn6y+hynzsgq/jAmW6XuXgK74yFwQrEelTE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XFnrEITyHi+GLaGkVmdRgsiwhR3ix5B8HdOqWA89Du0aqS/ipkkq/ygu0HgPGC51yaTvNdEb+IbgcsWnkei7AIGfksKnfzjxqtdUp94y6qxXvHWwog6xtW2tWN1IrBtSu+a9yP6vHuEA90evkSmD7S1HZbphkFlPL5Gx5hcrWY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=KrIwDyqY; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=LRKurpbp; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 22 Aug 2025 12:57:12 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1755860234;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gsf4Vx7e1gJ/lk/DxwYIL3SSk24RUYX3bl3t9LVrocc=;
	b=KrIwDyqYS/Z5KCFlP5jzLF+ob8oc66ixyD+Wo+F9x7msNPKm2pUJs6Nmp012ns7grttW+i
	E3igNaGeIGQtt2TUg/Y1wdWUnQjn9/4K3nGt1CY8OMUpZongBqvv/ewhL586SiYiUXhNA4
	iHAhjOFbwISD6YEpGQuQO43z/JXzb+JMKSeOMla5NjdMfzjC78i8B7d50Ibmk7GL+d0ptP
	XXoa01w/TwJUeeO625oq1kA9q0JZajFV57ZQ/0QAiYaXwsiO+gPrnUwkNiXgCvyDj8ud3H
	lZlB12wZc1xYKZIsCV81PjoVVzmUcII0yFnXB2MPWd0pempJ6a04v8E6W4Ss+Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1755860234;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gsf4Vx7e1gJ/lk/DxwYIL3SSk24RUYX3bl3t9LVrocc=;
	b=LRKurpbpirmEw9yvQaEwVxa2vuuSv5xG2G4E9Lkr6Y2Bscfp19banxVLj4Inc1vYMbfpqu
	+wQvqEXTP/WXCvBg==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Borislav Petkov <bp@alien8.de>, Thomas Gleixner <tglx@linutronix.de>,
	Peter Zijlstra <peterz@infradead.org>, x86-ml <x86@kernel.org>,
	lkml <linux-kernel@vger.kernel.org>
Subject: Re: [GIT PULL] locking/urgent for v6.17-rc1
Message-ID: <20250822105712.CRp0on1Y@linutronix.de>
References: <20250809180207.GAaJeNHymvt6gaR5nY@fat_crate.local>
 <CAHk-=wi+X2A6K839AxrRvaCDCakya-2B68NTkYP5YGfi-h5EuQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHk-=wi+X2A6K839AxrRvaCDCakya-2B68NTkYP5YGfi-h5EuQ@mail.gmail.com>

On 2025-08-21 14:19:31 [-0400], Linus Torvalds wrote:
> On Sat, 9 Aug 2025 at 14:02, Borislav Petkov <bp@alien8.de> wrote:
> >
> > please pull a locking/urgent fix for v6.17-rc1.
> 
> Ok, so this clearly wasn't a fix.
> 
> > Thomas Gleixner (1):
> >       futex: Move futex cleanup to __mmdrop()
> 
> So this causes problems, because __mmdrop is not done in thread
> context, and the kvfree() calls then cause issues:
> 
>   https://lore.kernel.org/all/20250821102721.6deae493@kernel.org/
>   https://lore.kernel.org/all/20250818131902.5039-1-hdanton@sina.com/
> 
> Hilf Danton sent out a patch, but honestly, that patch looks like pure
> bandaid, and will make the exit path horribly much slower by moving
> things into workqueues. It might not be visible in profiles exactly
> *because* it's then hidden in workqueues, but it's not great.

vfree() has an in_interrupt() check. Extending it to an irq-check would
check this but not a section where a spin_lock_t is held since we can't
check for disabled preemption. And therefore another band aid.

> I think it's a mistake to allow vmalloc'ing those hashes in the first
> place, and I suggest the local hash be size-limited to the point where
> it's just a kmalloc() and thus works in all contexts.

default auto scaling with 512 CPUs without lockdep maxes out
	64 + (64 * 512 * 4) = 128KiB + 64.

For kmalloc() the slab cache is used up to 8KiB which crosses the limit
with 32 CPUs. Then we have kmalloc()'s max allocation limit which is at
4MiB.

Given that Jakub hits the warning after sometime might indicate that it
was possible to fulfill the requirement initially but over time the
memory became too fragmented. So it allocated virtual memory.

> Or maybe the mistake was the mm-private hashing in the first place.
> Maybe that hash shouldn't be allocated at mm_alloc() ->
> futex_mm_init() at all. Only initialized by the futex code when
> needed, and then dropped in exit_mmap().

mm_alloc() is fine. This does only an alloc_percpu() and its counter part
can be used in atomic context. So the hash pointer should end up in
kfree(NULL).
Let me stare at the initial report leading to the fix. Maybe we can
avoid the leak and the atomic context altogether.

> So the problems seem deeper than just "free'd in the wrong context".
> 
>            Linus

Sebastian

