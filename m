Return-Path: <linux-kernel+bounces-882624-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AF326C2AEDF
	for <lists+linux-kernel@lfdr.de>; Mon, 03 Nov 2025 11:10:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AD0433B8976
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 10:09:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E28A72FC870;
	Mon,  3 Nov 2025 10:08:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DMNO6Hbf"
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 486D82FBE08
	for <linux-kernel@vger.kernel.org>; Mon,  3 Nov 2025 10:08:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762164529; cv=none; b=ZVbiwEA7AgKNx13x8OtHpD58R2vVJDQ6amFtgeXw5wSVqRjhPKyjNMlZBZG3TeogGCakuHljjfE0H7dcnpaPVFujOaEFnRKDOmJ8woK+0v2ZiELNTmK59L24eaESfDCn6qIlke0S6M5aAY3h/37jHCA4vhT3ogLSLiELioGA7qE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762164529; c=relaxed/simple;
	bh=YsTF68mjR39B/r/G6EPCUdpxSXCB8HJ4vZ+J81ZFViU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:MIME-Version:
	 Content-Type; b=qxGWT/GurrHuICV1zwtTDZIauIblt0qNJ3279IQAJrXAWg17dNh2YFUOeXy5G9YYcaLpbpQMuhzGJZrNPzXKA7e92TY/eN5OPR3oJh+M8zh8IWe6IdxsH25954/gRmubGaPhXXKmYs63cim4WiKivR2GvF4n8yGA4Tx2Ue+lnqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DMNO6Hbf; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-b6dbb4a209aso753946666b.1
        for <linux-kernel@vger.kernel.org>; Mon, 03 Nov 2025 02:08:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762164526; x=1762769326; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:in-reply-to:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=tLS6qgKRGlV1tkSNCOlSCrCisKumvAST+7mt3QUKFME=;
        b=DMNO6HbfY7/ZVxGwmvwUUzErGvh8CWY+wb/crRNs3uS/5/PkUFPWJhyGKWEt1IgKv2
         WbsPLhnvK8r/Kq6gNTAcTnmAExm6HgmdDaasRENjtlVfvbEPhVRJ+S5Kg+2ullVMdpSm
         cSIZRXF0SbA+q8HzSaKcJgfZ2dtT6dQwRU5R0mj8/Plx9PeCp10G4BgUXS0C7CA8h7R5
         6z6WFB21x+xXrSyRbJQXQbTUtrCBTptX9FvVX7d2DUCO3KydSkvRjYGD+WDXisVosTGB
         8ITCH6tNmhaXOGLiJeIww35gaRvT6n7WsDYKZDt9YmB4vfPmU9aBTOg5A7BIy3C5B9I+
         1dvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762164526; x=1762769326;
        h=content-transfer-encoding:mime-version:in-reply-to:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tLS6qgKRGlV1tkSNCOlSCrCisKumvAST+7mt3QUKFME=;
        b=j0djxytAy4zOt67dVVWsE/q0adImmTYK+0Q+xqMs8OaqqNReJAXtNZ0rp6HmLhkk9V
         7qu0Y5WqnfyyLUrcakqD8lH9/IvkE84Xn2PTPvnAxiyfXruKMvjJhIIhWj0QcGe4cRGl
         8+Wb3CzCB66KdXYkwfveU4fYRbW4xRf6/uZj0RvimU0GqVcxD5g8NXnCz//jALiWiQr3
         DruUPodjNWt56SBch0GgDO+xow6Re1Aqdv3Llcx+WS7FGcpQcWmL47nLyLWa2pw/5TnA
         QvSYbKpHmK9TAVf96SmjXP807JYwxSU3xAU5s8cLRIZvq6J5ZQWsqVxYPKYNiFp70wCD
         r6hg==
X-Forwarded-Encrypted: i=1; AJvYcCX557c+gaS17dx0wRiSFVKsfFepKXTitRLy4RGW1oKn1MoL3FTGPxxQ8Yrjzv+EIOKwcXdK2x9azmxMIxE=@vger.kernel.org
X-Gm-Message-State: AOJu0YweYa8f+HvyQC6WLDgk0vwVEGXD1GFsPaMa2PzBqVkvYogUxESd
	695pUbHmvRtmmoPXkEHAU6Iou3PJLDWXlV4lFb+siOJQ0sIHUsRbIi6g
X-Gm-Gg: ASbGncvpyE1sUaKxErKEyPRanLEOJjIMt9PFnI1b9ZpcgVt4slr+83vReccmuSyBc9C
	RxPNuf2feamPtbNwo6ubuuGc2e87/7A1oyZegyfvJWm9nsCgDWs7dxMyLICqhA1oIDqAHUcZvMn
	SKf3tQzryAjdzsfN7m09hv5w9yB0PVxDBlNY+GinFxZI3YH7MKuM2thh1a7OqJYLQs4sSM4O5rh
	KiPna8kobgcGuFSkXWSY/ZnW2DV1lUzkyOd7nNRbWtglKB9bXSNtKEWnuYHcqzpUdCvdianu6KZ
	5OxL8ahJFPuMHv/lTfR66KpLazzWCawp2gl9KiCmysbt1Xj2uNBCPSULK+BIgbqyHKh8Pf/4iUN
	94pDTWPdBrsywiL4s+beOGre5fVMUPVEIHkmWmC/jDLHtZXHgUq8yVToVcqbOCX10ll1+nWS2/9
	TyRfSYPGRJgdVG
X-Google-Smtp-Source: AGHT+IEv5yXN9Rq+z/PHyS8obHrzjUW6HYGA45FU+WSNF/Zev/u9SGVmMPbE9+9XkPkG1FxuYOM0eQ==
X-Received: by 2002:a17:907:3d4f:b0:b70:6d3a:a08b with SMTP id a640c23a62f3a-b70700ad4dfmr1388461366b.10.1762164525413;
        Mon, 03 Nov 2025 02:08:45 -0800 (PST)
Received: from foxbook (bgu110.neoplus.adsl.tpnet.pl. [83.28.84.110])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b718a2dd982sm74711866b.49.2025.11.03.02.08.43
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 03 Nov 2025 02:08:45 -0800 (PST)
Date: Mon, 3 Nov 2025 11:08:35 +0100
From: Michal Pecio <michal.pecio@gmail.com>
To: bigeasy@linutronix.de
Cc: bp@alien8.de, da.gomez@samsung.com, dave.hansen@linux.intel.com,
 hpa@zytor.com, jpoimboe@kernel.org, linux-kernel@vger.kernel.org,
 linux-modules@vger.kernel.org, mcgrof@kernel.org, mingo@redhat.com,
 paulmck@kernel.org, peterz@infradead.org, petr.pavlu@suse.com,
 samitolvanen@google.com, tglx@linutronix.de, x86@kernel.org
Subject: Re: [PATCH v3 22/28] x86: Use RCU in all users of
 __module_address().
Message-ID: <20251103110835.1dca378c.michal.pecio@gmail.com>
In-Reply-To: <20250108090457.512198-23-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

> x86: Use RCU in all users of __module_address().
>
> __module_address() can be invoked within a RCU section, there is no
> requirement to have preemption disabled.
> 
> Replace the preempt_disable() section around __module_address() with
> RCU.
> 
> Cc: H. Peter Anvin <hpa@zytor.com>
> Cc: Borislav Petkov <bp@alien8.de>
> Cc: Dave Hansen <dave.hansen@linux.intel.com>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Josh Poimboeuf <jpoimboe@kernel.org>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: x86@kernel.org
> Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> ---
>  arch/x86/kernel/callthunks.c | 3 +--
>  arch/x86/kernel/unwind_orc.c | 4 +---
>  2 files changed, 2 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/x86/kernel/callthunks.c b/arch/x86/kernel/callthunks.c
> index f17d166078823..276b5368ff6b0 100644
> --- a/arch/x86/kernel/callthunks.c
> +++ b/arch/x86/kernel/callthunks.c
> @@ -98,11 +98,10 @@ static inline bool within_module_coretext(void *addr)
>  #ifdef CONFIG_MODULES
>  	struct module *mod;
>  
> -	preempt_disable();
> +	guard(rcu)();
>  	mod = __module_address((unsigned long)addr);
>  	if (mod && within_module_core((unsigned long)addr, mod))
>  		ret = true;
> -	preempt_enable();
>  #endif
>  	return ret;
>  }
> diff --git a/arch/x86/kernel/unwind_orc.c b/arch/x86/kernel/unwind_orc.c
> index d4705a348a804..977ee75e047c8 100644
> --- a/arch/x86/kernel/unwind_orc.c
> +++ b/arch/x86/kernel/unwind_orc.c
> @@ -476,7 +476,7 @@ bool unwind_next_frame(struct unwind_state *state)
>  		return false;
>  
>  	/* Don't let modules unload while we're reading their ORC data. */
> -	preempt_disable();
> +	guard(rcu)();
>  
>  	/* End-of-stack check for user tasks: */
>  	if (state->regs && user_mode(state->regs))
> @@ -669,14 +669,12 @@ bool unwind_next_frame(struct unwind_state *state)
>  		goto err;
>  	}
>  
> -	preempt_enable();
>  	return true;

Hi,

There is a regression report on a distribution forum which involves
an out of tree module on a patched kernel (yes, I know) calling
stack_trace_save() in task context, which arrives here and apparently
calls the various deref_stack_xxx() functions with preemption enabled,
which in turn call stack_access_ok() leading to a BUG:

Nov 02 21:44:30 ArchBasement kernel: BUG: using smp_processor_id() in preemptible [00000000] code: Xorg/1183
Nov 02 21:44:30 ArchBasement kernel: caller is in_entry_stack+0x11/0x60
Nov 02 21:44:30 ArchBasement kernel: CPU: 0 UID: 1000 PID: 1183 Comm: Xorg Tainted: P           OE       6.16.12-hardened1-1-hardened #1 PREEMPT(full)  6edb90a7a07fab33bbee72d6d5ef53ba6eec3b9c
Nov 02 21:44:30 ArchBasement kernel: Tainted: [P]=PROPRIETARY_MODULE, [O]=OOT_MODULE, [E]=UNSIGNED_MODULE
Nov 02 21:44:30 ArchBasement kernel: Hardware name: ASUS All Series/Z97-E, BIOS 0803 02/23/2016
Nov 02 21:44:30 ArchBasement kernel: Call Trace:
Nov 02 21:44:30 ArchBasement kernel:  <TASK>
Nov 02 21:44:30 ArchBasement kernel:  dump_stack_lvl+0x5d/0x80
Nov 02 21:44:30 ArchBasement kernel:  check_preemption_disabled+0xe5/0xf0
Nov 02 21:44:30 ArchBasement kernel:  in_entry_stack+0x11/0x60
Nov 02 21:44:30 ArchBasement kernel:  get_stack_info+0x2c/0x80
Nov 02 21:44:30 ArchBasement kernel:  stack_access_ok+0x51/0xa0
Nov 02 21:44:30 ArchBasement kernel:  unwind_next_frame+0x1cb/0x7b0
Nov 02 21:44:30 ArchBasement kernel:  ? _nv003168kms+0x42/0x50 [nvidia_modeset 90775ea8a26c5e58b97ef4b3f46eb45efa040eb2]
Nov 02 21:44:30 ArchBasement kernel:  ? __pfx_stack_trace_consume_entry+0x10/0x10
Nov 02 21:44:30 ArchBasement kernel:  arch_stack_walk+0xa6/0x110
Nov 02 21:44:30 ArchBasement kernel:  ? _nv003168kms+0x42/0x50 [nvidia_modeset 90775ea8a26c5e58b97ef4b3f46eb45efa040eb2]
Nov 02 21:44:30 ArchBasement kernel:  stack_trace_save+0x4d/0x70

Is this nvidia doing something wrong, or a problem with this commit?

The removed code suggests that preemption is allowed here, and as far
as I see, this call trace is still possible on vanilla 6.18. Perhaps
preempt_disable() needs to be restored around this code?

Regards,
Michal

