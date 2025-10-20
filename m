Return-Path: <linux-kernel+bounces-861136-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 55EE0BF1DF8
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 16:33:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4789A4F40ED
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 14:33:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1CE719C553;
	Mon, 20 Oct 2025 14:33:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="3Sp5tegT"
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E096136351
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 14:32:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760970780; cv=none; b=ABDOrKC3JkdIXdrYNBvMGb1edcpcYfDH+qIRt+h1Ija3WfMjj9MuhPrx/Fxwnb4tYQIvMkBJDtCECgIuDLDoOBzu6DItiTwYE3zMCNVqh9zBkkzj0VmtwoD1PfEE1oSr3FduEVSf1cj+nuTpyD71VCSDkXSkuUM7G+e+l6YsG2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760970780; c=relaxed/simple;
	bh=Efs56rk0rh6KgCp6OjzpKIx03q5a6HbqOI6l92/mJFk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=DDxyOEWvKP1VDh6U3YP6WzNZayvcdtEodTsoIlTM05q9xryIZqWGRrtWERB7GrnqLVcCsCRztVyA1hh9Ye0V3326GAQWn8tpsyBzWJzJdzjGUbu9e16nS1z088gh7/U+i7EL0MgyYHNYPc81wWaNTHyqiym8Pvrh84zDvgchglY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=3Sp5tegT; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-b609c0f6522so8320645a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 07:32:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760970778; x=1761575578; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=rxtYEYVGg1xee+FU6QJob1EIzCq4b+DS/H4drZtXgbA=;
        b=3Sp5tegT4S/I93DPczEipbN11Ouh29RTRAb7h8oJBjPAwzt/h78/LHVl/ruRcaL+R7
         SGlC4dz26aG9AvTMKQd+KB2AYW0Q73kVt9vpSi/94QocmaH1SYteEBl8H5ZaJs33ttRy
         Qcs3LhQ/bs0kKVALhxTb3dxEvPHUwLWzbqwAGP/wJm+A1O1wbNvmcrsF1qEfmeSgpH7R
         6mrfCkB9+dEa16rkxF73g7WDmoIO1uukdX9g1I1HJt9F2/F/X9VA4IlbX/EJLcfk5k61
         9F5Gw4xIkLUxQ2eIO1s5KCgj+nhMNaKGJ2MJP6obsPqn9UpLUlSzAoUmWh1wB4EsN8tR
         np+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760970778; x=1761575578;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rxtYEYVGg1xee+FU6QJob1EIzCq4b+DS/H4drZtXgbA=;
        b=deav0wX+QsbkSeUJExGQNT2jsKwAhPOt9T6EpRkyqVO6Ey1NjFJZ1+UNiyHH554yT7
         RgpoEjHD7UwvO/WO5Xnej6pl1cR/NK8ov3+5oOIq9zEoFERU3EvCBGM4Bh8DRJwlJREj
         2i9kmgZvazwB75fHeEAapr8qlyNsuzr0jYyY8eWjAa3YJd4yOXeSrhz1RVzp16OiHnvM
         SPOm4r1JFXMeIf6S06T3fGc4k3d6bgM6NWnAT9TEoZKTOzboDUatPYQ2pOMxPUcuR2Mg
         G0ucyuajY1ZazVWUuhsUIHdlR3GC22rbMILFoHU1nrZUfbppzTZfSbMDi6nIIscGXJm6
         6puA==
X-Forwarded-Encrypted: i=1; AJvYcCWk3iJvRQKQAS5gKlPgVxwFyBKTLlkcXxIGU6lpYAVltPLCQHq/bt2Q5gTwbR9ZoxfroKadORgDGuT2JM4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzihVEHPp8PSw357+I7xqiJ94gWRyPJ6YSlZ0X25gbNuLmMMLW6
	H3ezDGlpAQe1JoyUG/FaPNzUWsODMHwioWId4A6zfYQ0BM8BpaLBdLPbV1QzUjB7IaVu4OMee56
	g9+JNzQ==
X-Google-Smtp-Source: AGHT+IHYN3gPwuTbUwp+qLhiw1dSLKSY08s8KoatdQfaWUcMz0x8Il84U6uQREjYTVBx6/2IDE5exBcT4Xo=
X-Received: from plcr12.prod.google.com ([2002:a17:903:14c:b0:290:4eeb:bc7a])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:1746:b0:28d:190a:1913
 with SMTP id d9443c01a7336-290caf8509bmr147845565ad.38.1760970777614; Mon, 20
 Oct 2025 07:32:57 -0700 (PDT)
Date: Mon, 20 Oct 2025 07:32:56 -0700
In-Reply-To: <20250910174210.1969750-1-sshegde@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250910174210.1969750-1-sshegde@linux.ibm.com>
Message-ID: <aPZIGCFk-Rnlc1yT@google.com>
Subject: Re: [RFC PATCH v3 00/10] paravirt CPUs and push task for less vCPU preemption
From: Sean Christopherson <seanjc@google.com>
To: Shrikanth Hegde <sshegde@linux.ibm.com>
Cc: mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com, 
	vincent.guittot@linaro.org, tglx@linutronix.de, yury.norov@gmail.com, 
	maddy@linux.ibm.com, linux-kernel@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, gregkh@linuxfoundation.org, 
	vschneid@redhat.com, iii@linux.ibm.com, huschle@linux.ibm.com, 
	rostedt@goodmis.org, dietmar.eggemann@arm.com, vineeth@bitbyteword.org, 
	jgross@suse.com, pbonzini@redhat.com
Content-Type: text/plain; charset="us-ascii"

On Wed, Sep 10, 2025, Shrikanth Hegde wrote:
> tl;dr
> 
> This is follow up of [1] with few fixes and addressing review comments.
> Upgraded it to RFC PATCH from RFC. 
> Please review. 
> 
> [1]: v2 - https://lore.kernel.org/all/20250625191108.1646208-1-sshegde@linux.ibm.com/
> 
> v2 -> v3:
> - Renamed to paravirt CPUs

There are myriad uses of "paravirt" throughout Linux and related environments,
and none of them mean "oversubscribed" or "contended".  I assume Hillf's comments
triggered the rename from "avoid CPUs", but IMO "avoid" is at least somewhat
accurate; "paravirt" is wildly misleading.

> - Folded the changes under CONFIG_PARAVIRT.
> - Fixed the crash due work_buf corruption while using
>   stop_one_cpu_nowait. 
> - Added sysfs documentation.
> - Copy most of __balance_push_cpu_stop to new one, this helps it move 
>   the code out of CONFIG_HOTPLUG_CPU. 
> - Some of the code movement suggested. 
> 
> -----------------
> ::Detailed info:: 
> -----------------
> Problem statement 
> 
> vCPU - Virtual CPUs - CPU in VM world.
> pCPU - Physical CPUs - CPU in baremetal world.
> 
> A hypervisor does scheduling of vCPUs on a pCPUs. It has to give each
> vCPU some cycles and be fair. When there are more vCPU requests than
> the pCPUs, hypervsior has to preempt some vCPUs in order to run others.
> This is called as vCPU preemption.
> 
> If we take two VM's, When hypervisor preempts vCPU from VM1 to run vCPU from 
> VM2, it has to do save/restore VM context.Instead if VM's can co-ordinate among
> each other and request for limited  vCPUs, it avoids the above overhead and 
> there is context switching within vCPU(less expensive). Even if hypervisor
> is preempting one vCPU to run another within the same VM, it is still more 
> expensive than the task preemption within the vCPU. So basic aim to avoid 
> vCPU preemption.
> 
> So to achieve this, introduce "Paravirt CPU" concept, where it is better if
> workload avoids these vCPUs at this moment. (vCPUs stays online, don't want
> the overhead of sched domain rebuild and hotplug takes a lot of time too).
> 
> When there is contention, don't use paravirt CPUs.
> When there is no contention, use all vCPUs. 

...

> ------------
> Open issues: 
> 
> - Derivation of hint from steal time is still a challenge. Some work is
>   underway to address it. 
> 
> - Consider kvm and other hypervsiors and how they could derive the hint.
>   Need inputs from community. 

Bluntly, this series is never going to land, at least not in a form that's remotely
close to what is proposed here.  This is an incredibly simplistic way of handling
overcommit, and AFAICT there's no line of sight to supporting more complex scenarios.

I.e. I don't see a path to resolving all these "todos" in the changelog from the
last patch:

 : Ideal would be get the hint from hypervisor. It would be more accurate
 : since it has knowledge of all SPLPARs deployed in the system.
 : 
 : Till the hint from underlying hypervisor arrives, another idea is to
 : approximate the hint from steal time. There are some works ongoing, but
 : not there yet due to challenges revolving around limits and
 : convergence.
 : 
 : Till that happens, there is a need for debugfs file which could be used to
 : set/unset the hint. The interface currently is number starting from which
 : CPUs will marked as paravirt. It could be changed to one the takes a
 : cpumask(list of CPUs) in future.

I see Vineeth and Steven are on the Cc.  Argh, and you even commented on their
first RFC[1], where it was made quite clear that sprinkling one-off "hints"
throughoug the kernel wasn't a viable approach.

I don't know the current status of the ChromeOS work, but there was agreement in
principle that the bulk of paravirt scheduling should not need to touch the kernel
(host or guest)[2].

[1] https://lore.kernel.org/all/20231214024727.3503870-1-vineeth@bitbyteword.org
[2] https://lore.kernel.org/all/ZjJf27yn-vkdB32X@google.com

