Return-Path: <linux-kernel+bounces-731541-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D95EB055FF
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 11:13:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 54AE14E3579
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 09:12:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25218277CB0;
	Tue, 15 Jul 2025 09:13:10 +0000 (UTC)
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D424D275B03
	for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 09:13:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752570789; cv=none; b=kJRj9nGpgGkZvI8bc/yE0J35rdUm4SheLaM6/sKNny6Qo4f5WQIHs3NneEfFX1tzDViYCeA6C3TSG2m2C2bV2B+Is0JJFCkCXy6E0g4mBQJRaFd4ghWr+o0sO+1tA00rzPNEz5ENC1NRkuGjEr6ZheAorAEKAyrPWAXEn+vYlOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752570789; c=relaxed/simple;
	bh=V39JM+uk+ECxCf/UMd+SmqjRKIKJcI9Z1lKGxS1bZIg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B2PZ8jgrX/5AlV/PxESCHdQ2Ja4hZA25z0LH+glWq2wjXYr+L+2dyq6ygM7vcYPR2p4KwHLFLqdc8uOQx0+csFHJvzA+AeSx1YvU4khgmcLI0hI7r0Tq2A3Zwl9IgSv+pwBBjrQuigyF+0RqisxVctWW7YK1mp84RddlsKMaEic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-60707b740a6so8010597a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 02:13:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752570786; x=1753175586;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nXQcCNz3TP4jrhI/k/hWj1KDOWUbsbzMWtf58eSozP4=;
        b=vrnDuVsT/7KbZPgqLiMJRRb1k/8aIuVEg25khWm6UJg8Lceh+iiFGPOyZ87OmqBNRR
         aUz0mI/12Px75KOYlvVpAqkBZDGmRaForZlcT1VhVn4+S13FqWbUGFG5rIb865Fukj71
         zk46ptLBMEfNJrh0bEBIINa1SQ2MfgSkQbNOqX/uNvhq9v50KpnzBTAw+pbsYXByy/3r
         JWRtU2wAgcvfrWyI6KW2MV0dcUZUwnjz12wKhXc1SKh7PV0yDzimCYxHl4kfzwgO9ojk
         aYgHgQY7+4PO3SDbHbUliCGePHeL5QJBZEJufQs5EeoqUsqhuOH9Y0yVBZmOiHVxcgdd
         XEag==
X-Forwarded-Encrypted: i=1; AJvYcCWPYK0DbB34YWVDuJG0qoZOrLeFOZ3USK4Q9VXWh/v0c43PfwqL1z9mbYdzBfjlpugZ6jqOzaXyCKWKrh0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzOruMIymZtKjgijoNRbAPZHnBe0beU+4hOx+iEwBJS/XmvgqJU
	VxVSWJdv0aq/j9ykXKbxLbkGlwZZbAw7I7cXfQH5P6mRch4f6/xp+DTk1P4jig==
X-Gm-Gg: ASbGnctpf5yRjrZfKafmmx8dV4GAkqAgCReAsxPNiNjEodDwQbE/UdSxfCNgOffdH4Y
	SdS6p7LrqnPjE/dJbL30pQajXhbeaoSx9Q43mfWEMrhVVRHX0SpkcrpWRBqk8xoTHQolL2fij8+
	CzV0Chm+N0LSKJPluc3/jo8u+ylGMqw0oX9unNYGF1+Bi3ArWSO7fC2natK0zj3LwNBwo1vffqT
	GjfKrLGOUQTQLHajNwaGUq8RvMJ3L/hnjunxtVlv0A9U/eDvjhg8iLKYCaZwQ/HzX2C1PcTqOfs
	IQeAm5gHT+5/vf2YLLTsT/AEdkK2hP6vBzGHLahdMTO0/V/VF0aOXlVjkBB/uNNrSN6Q/wu+D1N
	49Lgpk4//R2MrmQ==
X-Google-Smtp-Source: AGHT+IGs+HozET+EPTC5/WJYEH+hNTHAJ5ALiGRwmQBeY7pp/UHhzNouVD8APobVJrqUOt/h4+MKKg==
X-Received: by 2002:a17:907:84a:b0:ae3:a240:7ad2 with SMTP id a640c23a62f3a-ae6fc6aa6dcmr1750612266b.2.1752570785592;
        Tue, 15 Jul 2025 02:13:05 -0700 (PDT)
Received: from gmail.com ([2a03:2880:30ff:74::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae6e82e8ff3sm976685266b.176.2025.07.15.02.13.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Jul 2025 02:13:05 -0700 (PDT)
Date: Tue, 15 Jul 2025 02:13:03 -0700
From: Breno Leitao <leitao@debian.org>
To: Andrea Righi <arighi@nvidia.com>
Cc: Tejun Heo <tj@kernel.org>, David Vernet <void@manifault.com>, 
	Changwoo Min <changwoo@igalia.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] sched_ext: Track currently locked rq
Message-ID: <xy47uzzirvauag3otkqhhhzwyhlpnnmeh3s77i2snmtoub3jhl@ywoeaxl3iq3x>
References: <20250422082907.110167-1-arighi@nvidia.com>
 <20250422082907.110167-2-arighi@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250422082907.110167-2-arighi@nvidia.com>

Hello Andrea,

On Tue, Apr 22, 2025 at 10:26:32AM +0200, Andrea Righi wrote:
> Some kfuncs provided by sched_ext may need to operate on a struct rq,
> but they can be invoked from various contexts, specifically, different
> scx callbacks.
> 
> While some of these callbacks are invoked with a particular rq already
> locked, others are not. This makes it impossible for a kfunc to reliably
> determine whether it's safe to access a given rq, triggering potential
> bugs or unsafe behaviors, see for example [1].
> 
> To address this, track the currently locked rq whenever a sched_ext
> callback is invoked via SCX_CALL_OP*().
> 
> This allows kfuncs that need to operate on an arbitrary rq to retrieve
> the currently locked one and apply the appropriate action as needed.
> 
> [1] https://lore.kernel.org/lkml/20250325140021.73570-1-arighi@nvidia.com/
> 
> Suggested-by: Tejun Heo <tj@kernel.org>
> Signed-off-by: Andrea Righi <arighi@nvidia.com>
> ---
>  kernel/sched/ext.c      | 152 +++++++++++++++++++++++++---------------
>  kernel/sched/ext_idle.c |   2 +-
>  2 files changed, 95 insertions(+), 59 deletions(-)
> 
> diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
> index bb0873411d798..3365b447cbdb8 100644
> --- a/kernel/sched/ext.c
> +++ b/kernel/sched/ext.c
> @@ -1116,8 +1116,38 @@ static void scx_kf_disallow(u32 mask)
>  	current->scx.kf_mask &= ~mask;
>  }
>  
> -#define SCX_CALL_OP(mask, op, args...)						\
> +/*
> + * Track the rq currently locked.
> + *
> + * This allows kfuncs to safely operate on rq from any scx ops callback,
> + * knowing which rq is already locked.
> + */
> +static DEFINE_PER_CPU(struct rq *, locked_rq);
> +
> +static inline void update_locked_rq(struct rq *rq)
> +{
> +	/*
> +	 * Check whether @rq is actually locked. This can help expose bugs
> +	 * or incorrect assumptions about the context in which a kfunc or
> +	 * callback is executed.
> +	 */
> +	if (rq)
	
Why do you only need to lock when rq is not NULL?

> +		lockdep_assert_rq_held(rq);
> +	__this_cpu_write(locked_rq, rq);

This is hitting the following BUG() on some of my debug kernels:

	BUG: using __this_cpu_write() in preemptible [00000000] code: scx_layered_6-9/68770

I have lockdep enabled, and I don't see the assert above. I am wondering
if rq is locked but preemption continues to be enabled (!?)

Also, I am wondering if the following patch would be useful.

	diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
	index b498d867ba210..c458dd7928e92 100644
	--- a/kernel/sched/ext.c
	+++ b/kernel/sched/ext.c
	@@ -1256,8 +1256,10 @@ static inline void update_locked_rq(struct rq *rq)
		* or incorrect assumptions about the context in which a kfunc or
		* callback is executed.
		*/
	-       if (rq)
	+       if (rq) {
			lockdep_assert_rq_held(rq);
	+       }
	+       WARN_ON_ONCE(preemptible());
		__this_cpu_write(locked_rq, rq);
	}

This is the full stack for the BUG: above:

	BUG: using __this_cpu_write() in preemptible [00000000] code: scx_layered_6-9/68770
	caller is bpf_scx_reg (kernel/sched/ext.c:1261 kernel/sched/ext.c:5558 kernel/sched/ext.c:5879)
	Tainted: [S]=CPU_OUT_OF_SPEC, [E]=UNSIGNED_MODULE, [N]=TEST
	Hardware name: Wiwynn Twin Lakes MP/Twin Lakes Passive MP, BIOS YMM20 02/01/2023
	Sched_ext: layered (enabling)
	Call Trace:
	<TASK>
	dump_stack_lvl (lib/dump_stack.c:122)
	check_preemption_disabled (lib/smp_processor_id.c:?)
	bpf_scx_reg (kernel/sched/ext.c:1261 kernel/sched/ext.c:5558 kernel/sched/ext.c:5879)
	? bpf_struct_ops_link_create (kernel/bpf/bpf_struct_ops.c:?)
	? rcu_is_watching (./include/linux/context_tracking.h:128 kernel/rcu/tree.c:745)
	? trace_contention_end (./include/trace/events/lock.h:122)
	? __mutex_lock (./arch/x86/include/asm/preempt.h:104 kernel/locking/mutex.c:612 kernel/locking/mutex.c:747)
	? __raw_spin_lock_init (./include/linux/lockdep.h:135 ./include/linux/lockdep.h:142 kernel/locking/spinlock_debug.c:25)
	bpf_struct_ops_link_create (kernel/bpf/bpf_struct_ops.c:1367)
	__sys_bpf (kernel/bpf/syscall.c:5907)
	? entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:130)
	__x64_sys_bpf (kernel/bpf/syscall.c:5943 kernel/bpf/syscall.c:5941 kernel/bpf/syscall.c:5941)
	do_syscall_64 (arch/x86/entry/syscall_64.c:?)
	? exc_page_fault (arch/x86/mm/fault.c:1536)
	entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:130)

