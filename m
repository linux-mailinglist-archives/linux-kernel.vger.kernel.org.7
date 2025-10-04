Return-Path: <linux-kernel+bounces-841977-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C0D4BB8B3E
	for <lists+linux-kernel@lfdr.de>; Sat, 04 Oct 2025 10:34:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 240FD4A05E0
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Oct 2025 08:34:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5263924DFF4;
	Sat,  4 Oct 2025 08:34:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SksNSPVp"
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DBB8322A
	for <linux-kernel@vger.kernel.org>; Sat,  4 Oct 2025 08:34:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759566854; cv=none; b=quYhc3+IU/2BnQ3kK70HU5KgltekrfbdLmnZgqJc8Tff6bYVuIf9zEqckx7Sp25Y3T+XgPQCttefdwrtEWzx7RQtToYuuKIl2v3tEbm2J92seGdN+UHXS//JlvqMbVWiJ7WmBTfrw0nVqggTdwQDP+Numyde13qEkFJsCi/j5sM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759566854; c=relaxed/simple;
	bh=ewAScujQh6IO+nNyoKcQ1124xJn4eyXuYWjb3HxVNyI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=U7WnaBI1Ekls+E/XGTiaU8H8T95GV6D/cixn2rogD3Yqr+w+S8Ojcfn4FiSPVVqdHL1yPxtjusPML68oSwHGO93NWDf3RZRcwy150wHGPtirNNzpkjl3MzErv+W4H6966wDPuuiJ3MaolNIvRPoBtpQ98DDpf96zMaFVVk942PE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ynaffit.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SksNSPVp; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ynaffit.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-b55118e2d01so2109918a12.1
        for <linux-kernel@vger.kernel.org>; Sat, 04 Oct 2025 01:34:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1759566852; x=1760171652; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:user-agent:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to;
        bh=DNUXIAMIgyuQcbpSIlbWyb8Yr08Un31/NnbXWZYjsP0=;
        b=SksNSPVp+5WQEnJ2UWC2Z0FOsEBGoOsImDoNqw+EFu0Gj5iRUnqnbjVuBYelmS2c0f
         H23xqUExrHXDzJQn0sA/A1bhW4jpeTmpdKGeOyE6KtPwjcy2H3/2RB8mw6skA2e1zyzc
         teU5EZ25mwovFgYjakFTRtswIpummiJR/Jdb/wT7YvOgJqMWuMgErdPe/sISlP54OEe9
         VneXjiWpVkF0/GBByrm+NtgVM18cihpavTIkjVGYICYtYkQq6uSr9HXxi5H15beZvPHE
         3IYs2DzAaECsSk6O97K39gQkBzxq9WpYLQ8QuWcGt+RDuCGV7IeKy8wTf/EGLC3Hxxtd
         8dyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759566852; x=1760171652;
        h=cc:to:from:subject:message-id:user-agent:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DNUXIAMIgyuQcbpSIlbWyb8Yr08Un31/NnbXWZYjsP0=;
        b=ao2blQvXAl7Lo9nCY501IhH3N7GyIchrxkU83/wSbNYKcysCBsWvvCoE854XjraQ1e
         1xuTWCTl8sD9E0UlL/gpn4peORTyIKx8hzEymwRB8q00AGgeBzYlKcWiiEC+WdAt5Tdn
         9+snMGIb83cvL3AZJEqpMse1Ix271a0iEq0VxDkAK4KlcyeBgjZN+csSU2cjysbrcuKH
         oXN2I2HUIHBgyI/wO2tMZceD5xwbhME0+304uvNEztqEz0DSaY8OVYfAMKMqWZI6diJv
         +738e677pcx2UiaPHOIm+OqcFGW1HZmp0X+02mOZJHbmF64DLTA7xx4dpMm1s9id0aXN
         zrMg==
X-Forwarded-Encrypted: i=1; AJvYcCXBWa2teslTCwdk0L1gPU8CN2d3Es5l9+RUi7iUY20+wzdQiARJwIiWE2zkIgXkc2GxfJ0DRZUGWaEq5J4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxAudaipmkqWThDfdbeVdbEPnmVZ0xoljTDnaixk3o9cqZrny1r
	KOz5JZrCeEHjl2Vy0/+hjiDoM3Y1nmIiLhBxUrxOcsqNvM1nhW/8evlVBMkfoW0K4Fflr0Lfpah
	3eDw59KdLeQ==
X-Google-Smtp-Source: AGHT+IG8WMGHaurimhri+gW5zRlp6uwHUCV2xHoW/prUeoq2RpfxaFVx0IibIcEVP1lg9S9cRSoC1Wbb2vOb
X-Received: from pjzh5.prod.google.com ([2002:a17:90a:ea85:b0:32d:e264:a78e])
 (user=ynaffit job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:3ec6:b0:330:3fb8:3885
 with SMTP id 98e67ed59e1d1-339c276e814mr6792475a91.18.1759566852200; Sat, 04
 Oct 2025 01:34:12 -0700 (PDT)
Date: Sat, 04 Oct 2025 01:34:10 -0700
In-Reply-To: <20251003114555.413804-1-nirbhay.lkd@gmail.com> (Nirbhay Sharma's
 message of "Fri, 3 Oct 2025 17:15:55 +0530")
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251003114555.413804-1-nirbhay.lkd@gmail.com>
User-Agent: mu4e 1.12.9; emacs 30.1
Message-ID: <dbx87bxbvzel.fsf@ynaffit-andsys.c.googlers.com>
Subject: Re: [PATCH] cgroup: Fix seqcount lockdep assertion in cgroup freezer
From: Tiffany Yang <ynaffit@google.com>
To: Nirbhay Sharma <nirbhay.lkd@gmail.com>
Cc: Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	"Michal =?utf-8?Q?Koutn=C3=BD?=" <mkoutny@suse.com>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
	Clark Williams <clrkwllms@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, cgroups@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev, 
	syzbot+27a2519eb4dad86d0156@syzkaller.appspotmail.com, 
	skhan@linuxfoundation.org, david.hunter.linux@gmail.com, 
	linux-kernel-mentees@lists.linuxfoundation.org
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes

Nirbhay Sharma <nirbhay.lkd@gmail.com> writes:

> The commit afa3701c0e45 ("cgroup: cgroup.stat.local time accounting")
> introduced a seqcount to track freeze timing but initialized it as a
> plain seqcount_t using seqcount_init().

> However, the write-side critical section in cgroup_do_freeze() holds
> the css_set_lock spinlock while calling write_seqcount_begin(). On
> PREEMPT_RT kernels, spinlocks do not disable preemption, causing the
> lockdep assertion for a plain seqcount_t, which checks for preemption
> being disabled, to fail.

> This triggers the following warning:
>    WARNING: CPU: 0 PID: 9692 at include/linux/seqlock.h:221

> Fix this by changing the type to seqcount_spinlock_t and initializing
> it with seqcount_spinlock_init() to associate css_set_lock with the
> seqcount. This allows lockdep to correctly validate that the spinlock
> is held during write operations, resolving the assertion failure on all
> kernel configurations.

> Reported-by: syzbot+27a2519eb4dad86d0156@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=27a2519eb4dad86d0156
> Fixes: afa3701c0e45 ("cgroup: cgroup.stat.local time accounting")
> Signed-off-by: Nirbhay Sharma <nirbhay.lkd@gmail.com>
> ---
>   include/linux/cgroup-defs.h | 2 +-
>   kernel/cgroup/cgroup.c      | 2 +-
>   2 files changed, 2 insertions(+), 2 deletions(-)

> diff --git a/include/linux/cgroup-defs.h b/include/linux/cgroup-defs.h
> index 539c64eeef38..933c4487a846 100644
> --- a/include/linux/cgroup-defs.h
> +++ b/include/linux/cgroup-defs.h
> @@ -435,7 +435,7 @@ struct cgroup_freezer_state {
>   	int nr_frozen_tasks;

>   	/* Freeze time data consistency protection */
> -	seqcount_t freeze_seq;
> +	seqcount_spinlock_t freeze_seq;

>   	/*
>   	 * Most recent time the cgroup was requested to freeze.
> diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
> index ab096b884bbc..fe175326b155 100644
> --- a/kernel/cgroup/cgroup.c
> +++ b/kernel/cgroup/cgroup.c
> @@ -5789,7 +5789,7 @@ static struct cgroup *cgroup_create(struct cgroup  
> *parent, const char *name,
>   	 * if the parent has to be frozen, the child has too.
>   	 */
>   	cgrp->freezer.e_freeze = parent->freezer.e_freeze;
> -	seqcount_init(&cgrp->freezer.freeze_seq);
> +	seqcount_spinlock_init(&cgrp->freezer.freeze_seq, &css_set_lock);
>   	if (cgrp->freezer.e_freeze) {
>   		/*
>   		 * Set the CGRP_FREEZE flag, so when a process will be

Thanks for this fix, Nirbhay!

-- 
Tiffany Y. Yang

