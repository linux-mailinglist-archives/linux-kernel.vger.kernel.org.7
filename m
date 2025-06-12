Return-Path: <linux-kernel+bounces-684254-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 192F5AD782E
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jun 2025 18:28:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 91DBF3A5C5E
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jun 2025 16:24:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74C0F299AB1;
	Thu, 12 Jun 2025 16:24:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cGu7+eYv"
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC20A26FD91
	for <linux-kernel@vger.kernel.org>; Thu, 12 Jun 2025 16:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749745460; cv=none; b=gKC8k9n9/RAL6AYK8iD7HuNLiBfviEsUb+ZgTkgfC8n8mPHClW6pIix9BP7d0MCejazsLQJiroFpt64vafKw1f3NFMRHv63xxm34y2lPW0kOUWONhsKPMcPg85PZtf0R3EoPSG+yxLnfJVMZnF4+cKecq3ZHZmU3eB8Q0v78Rj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749745460; c=relaxed/simple;
	bh=Be+I5tmdlC2zkdh5UFDc365I6yz+JrdL9QpxdY9MCSM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IlvgAHxLJctuzumqxLUPEQjWarZelPnRFXdZzmC2A4X2pfOT8E/yJdjB9z0i00XyjIWr3kQdUyivVrvWIjXu2mYRuVDQlWtC4OO9fz861hxBRv1jsnPetTQ8gALd/HGHE6PoZm5bpAbLkaBq+1MFeJtZ+1RYfMChOUgPM0TVzKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=cGu7+eYv; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-4a58ba6c945so22935681cf.2
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jun 2025 09:24:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1749745457; x=1750350257; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ubpwtkgx55qA2WdWpUmBhEo0OXMBytST0Gd49bZRuCQ=;
        b=cGu7+eYv4XF5ZrOsHEVbwj5yUZtHayOAGB9kjmIgXrwsnJRldfpgNtaszeVGTJDhRt
         gWNqQ6A6jgS5neZe2vqg87eKRR/3Gbae4v4BBMTousPcRYQ6UHjNgTYhM0NESVAPuwcJ
         ubCh5yBox4OeVoWXFtTTEq6NnfEsiUfpUqk+9plKsEA9i/sErBJCOLDlslK9Mov5NysS
         fOSFzPwljX9v1xp3r9H7sMu5ZJ/765HY4iXZbx7gi2YEg3w3+U3mY/gzC+vAYIAImcM5
         E26wq3SRdjlyldQf3G+6uPwGzVtU5x4cIymJZ3IeGVkI37ZGgHPfZP++JcxuAbjF/tO8
         9DuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749745457; x=1750350257;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ubpwtkgx55qA2WdWpUmBhEo0OXMBytST0Gd49bZRuCQ=;
        b=bsc9LQi7DocGA02Ax5p7C52BP91IDkei8TQEiFX8WlzkDZvi+NLaW0CBUW9vcQOZ10
         ss6GvQiv4g3vyaYQuNNkW8NqNbsaOJbuCLR/WJ2J0HnV2JxMcVR2kFJIuCeHfFX3AI7R
         tz6eIx4kcPuVeQhGOx8diuozK7aJM+ty2Q03gmEapviMUgL8/x13hQ13tfNwpK3lgzGc
         xDVmYxVt4trzg74NrTk71hnitorXCHziI0lvs8fxJyQK5gSJFw+YYjbOEXlHM/TwjXE8
         H2ixmVGprZrpnhkSa9T0EuthtG/AjCTuvd6bybH0ozDSxjbrHLvRxzZE3/yN3cFLLtmH
         pjwA==
X-Forwarded-Encrypted: i=1; AJvYcCXBwrQ8keowNX/iN7qAYMZQKua43HMxYyT4ms+H72EWBpqy9uN+7iMF87DNhLBQ/uwj/rg3vDEDmMBLeJA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwGC29s9B5yiyLkidzEQBs1R8BfjuwyjirrU9uUiLJIA/MLIMPN
	3p63xpp09MjO09KrJgW5nO64JOmb0wI8cLerXZx08YElCX/3weUq10jGyfbca9Rb5QrVPiWp3ND
	/IFvjjTMcvL/N8bZcZsWqQey7M2XXb9w501OAQyvyxA==
X-Gm-Gg: ASbGncuiWuRUPUgohiJJQIoD/JoyhnLTpTdVL54mvRDDtO4waxdPLogPA3oTUS2g8yp
	SATt4ho7O12ewxTZRS1ZTy5/29o2dSxajCkJ9KXYLzOhnpLkAQBKDAPTVDq7lifbcznNqSaT6WG
	XIhECRaftbhthED0V7Eku92qvxukKOp2K8VJmUV+uglYjGOJAKQrkptEcfibYTwo8rkO640IyMW
	Mmp
X-Google-Smtp-Source: AGHT+IH5VlckLY7oPmrOLAf7S12aXor6dxrtFBu851Xisht0fLTv7wD60rAOBD4hQbJLQ1v8NQWu/UVsaM/TmBbBsuw=
X-Received: by 2002:a05:620a:4808:b0:7c5:544e:2ccf with SMTP id
 af79cd13be357-7d3b2a8dd09mr647746085a.57.1749745456840; Thu, 12 Jun 2025
 09:24:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250610234307.c675969e83ce53bb856e94d7@kernel.org>
 <174956686826.1494782.11512582667456262594.stgit@mhiramat.tok.corp.google.com>
 <20250611113001.GC2273038@noisy.programming.kicks-ass.net> <20250612091754.b56ed1faf47cdcc1b90aafcd@kernel.org>
In-Reply-To: <20250612091754.b56ed1faf47cdcc1b90aafcd@kernel.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Thu, 12 Jun 2025 21:54:05 +0530
X-Gm-Features: AX0GCFt_ZAJRmm-hY3w_ZWYFRcEx6mKnHy_6UevUofpVrJ7c2ZmBQd-o7EHHwYw
Message-ID: <CA+G9fYt=zY4Xt1ZrkKqENdrJ41=iT5JcKnYn004=paANbG6UPA@mail.gmail.com>
Subject: Re: [RFC PATCH 2/2] x86: alternative: Invalidate the cache for
 updated instructions
To: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, Steven Rostedt <rostedt@goodmis.org>, x86@kernel.org, 
	open list <linux-kernel@vger.kernel.org>, 
	Linux trace kernel <linux-trace-kernel@vger.kernel.org>, lkft-triage@lists.linaro.org, 
	Stephen Rothwell <sfr@canb.auug.org.au>, Arnd Bergmann <arnd@arndb.de>, 
	Dan Carpenter <dan.carpenter@linaro.org>, Anders Roxell <anders.roxell@linaro.org>
Content-Type: text/plain; charset="UTF-8"

On Thu, 12 Jun 2025 at 05:47, Masami Hiramatsu <mhiramat@kernel.org> wrote:
>
> On Wed, 11 Jun 2025 13:30:01 +0200
> Peter Zijlstra <peterz@infradead.org> wrote:
>
> > On Tue, Jun 10, 2025 at 11:47:48PM +0900, Masami Hiramatsu (Google) wrote:
> > > From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> > >
> > > Invalidate the cache after replacing INT3 with the new instruction.
> > > This will prevent the other CPUs seeing the removed INT3 in their
> > > cache after serializing the pipeline.
> > >
> > > LKFT reported an oops by INT3 but there is no INT3 shown in the
> > > dumped code. This means the INT3 is removed after the CPU hits
> > > INT3.
> > >
> > >  ## Test log
> > >  ftrace-stress-test: <12>[   21.971153] /usr/local/bin/kirk[277]:
> > >  starting test ftrace-stress-test (ftrace_stress_test.sh 90)
> > >  <4>[   58.997439] Oops: int3: 0000 [#1] SMP PTI
> > >  <4>[   58.998089] CPU: 0 UID: 0 PID: 323 Comm: sh Not tainted
> > >  6.15.0-next-20250605 #1 PREEMPT(voluntary)
> > >  <4>[   58.998152] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009),
> > >  BIOS 1.16.3-debian-1.16.3-2 04/01/2014
> > >  <4>[   58.998260] RIP: 0010:_raw_spin_lock+0x5/0x50
> > >  <4>[   58.998563] Code: 5d e9 ff 12 00 00 66 66 2e 0f 1f 84 00 00 00
> > >  00 00 0f 1f 40 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 f3
> > >  0f 1e fa 0f <1f> 44 00 00 55 48 89 e5 53 48 89 fb bf 01 00 00 00 e8 15
> > >  12 e4 fe
> > >
> > > Maybe one possible scenario is to hit the int3 after the third step
> > > somehow (on I-cache).
> > >
> > > ------
> > > <CPU0>                                      <CPU1>
> > >                                     Start smp_text_poke_batch_finish().
> > >                                     Start the third step. (remove INT3)
> > >                                     on_each_cpu(do_sync_core)
> > > do_sync_core(do SERIALIZE)
> > >                                     Finish the third step.
> > > Hit INT3 (from I-cache)
> > >                                     Clear text_poke_array_refs[cpu0]
> > > Start smp_text_poke_int3_handler()
> > > Failed to get text_poke_array_refs[cpu0]
> > > Oops: int3
> > > ------
> > >
> > > SERIALIZE instruction flashes pipeline, thus the processor needs
> > > to reload the instruction. But it is not ensured to reload it from
> > > memory because SERIALIZE does not invalidate the cache.
> > >
> > > To prevent reloading replaced INT3, we need to invalidate the cache
> > > (flush TLB) in the third step, before the do_sync_core().
> >
> > This sounds all sorts of wrong. x86 is supposed to be cache-coherent. A
> > store should cause the invalidation per MESI and all that. This means
> > the only place where the old instruction can stick around is in the
> > uarch micro-ops cache and all that, and SERIALIZE will very much flush
> > those.
>
> OK, thanks for pointing it out!
>
> >
> > Also, TLB flush != I$ flush. There is clflush_cache_range() for this.
> > But still, this really should not be needed.
> >
> > Also, this is all qemu, and qemu is known to have gotten this terribly
> > wrong in the past.
>
> What about KVM? We need to ask Naresh how it is running on the machine.
> Naresh, can you tell us how the VM is running? Does that use KVM?
> And if so, how the kvm is configured(it may depend on the real hardware)?

We do not use KVM and are running the Qemu version (10.0.0).

>
> >
> > If you all cannot reproduce on real hardware, I'm considering this a
> > qemu bug.

It is reproducible intermittently on x86_64 device and qemu-x86 device
with and without compat mode.

This link is showing how intermittent it is on Linux next tree.

 - https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20250606/testrun/28685600/suite/log-parser-test/test/oops-oops-int3-smp-pti/history/?page=2

- Naresh

>
> OK, if it is a qemu's bug, dropping [2/2], but I think we still need
> [1/2] to avoid kernel crash (with a warning message without dump).
>
> Thank you,
>
> >
> >
>
>
> --
> Masami Hiramatsu (Google) <mhiramat@kernel.org>

