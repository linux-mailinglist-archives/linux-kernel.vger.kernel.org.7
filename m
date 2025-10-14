Return-Path: <linux-kernel+bounces-853242-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 152FEBDAFF0
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 21:06:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 003224EF1AB
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 19:06:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DB3F2BE62C;
	Tue, 14 Oct 2025 19:06:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="c9mTlzH3"
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2271E25A353
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 19:06:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760468796; cv=none; b=aJKTexHPMjX0nsylGXAKEjyuy7Cme08K4nJAZVecSEY/Z0PBFPuSc6IKjBSeLyXlRJ+sQ5H52MhLhCNRLrFoXjny3CUlSkfyO0c4L2YOAzZBFIQKh0jZZeeGRtkht78XHw3C2oDgvTgi1qa6CwCQfSDpOpW6WLO3pEhakzLNWsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760468796; c=relaxed/simple;
	bh=YHkoBXMGobkLQ8o+PhxXHefddsG1ieCfaB2d71pVtoU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=rjJNuepkyonJ56TPSDwJ/p6VOaCmZMI0TxA8atV3eJ04C0KZBe8q6pLdY/wHIaJJFkOmagYeqZ2/QFiM2UQE7WqPthHNBfsMXcuKK7x9SwuuE54nWaVeXclrs6ipfncaSPG6uKwofhOvLXthSyNVvcMS5JBCzjW32K7nWeor4zY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=c9mTlzH3; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-b5edecdf94eso15587227a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 12:06:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760468794; x=1761073594; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=NJxlV+oNDwXk+z+h9rw/7gmtAEVoUIc/lNQpO7FKflY=;
        b=c9mTlzH33TKdq7MgxgmTSkLCArSuZg7B4e0qDn3gZNHjLLvsabhQeY6mzURYf+WPgU
         U5647dVwI4KzZYLv9uRGibfg6//ulkcGUwpkewXvmBp0ti2ZSUhZZt4Q21c0qwyRqJ82
         xH93ynUJSLEwrYwZJHpUa9kS/B9OpxVbHi6GPzsPwo4FJbawEnCwPPqnNLfFRLM72280
         GuEdjZ+duAelDUVm7l4HTRBCPcKwPwfFyRYHGzO4jfuRnNcAI8H7uugBYKRRe1A3LC0T
         JvPeqkkloEWlAOFkXO1ADiaKT4lsbmdrsQx6ptNtgnT51oOA0TZXe9CTALm9IR5uyo0V
         BMXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760468794; x=1761073594;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NJxlV+oNDwXk+z+h9rw/7gmtAEVoUIc/lNQpO7FKflY=;
        b=dlys238tSzj+M8M9vybi8Hw8iRSJidJvyS1ecscHb25GJ2iVvuf39VWbNK1eP9BphO
         uVxkEg2LqnufAkixYxWBPjmP36loI2YtqbjoUiPAXSoU5tbolddrkGroh/HMsnQLI42u
         QoJTcEeX0fsIMmL4+oQNzCmyEEqPzjA1M5Wa0YFzOu/ZHkGM1QWx+F+HFidsxz42ytxy
         TY9/g6ruqyLvDBjPAZ73erWd6CIWZ+rVhHXOauKczjt0gVT+1wn+8K6FlZMFhiFXu+bj
         OOBwpFitvSw1CGYVbLWzu5qNYtfkXtw4ZVTklQK+ZvSK7VTdWt2JAtBXvDtdFdtUAywl
         nVfw==
X-Gm-Message-State: AOJu0YymzjM4nh59e2KwN1BJdiGVKGeCc0q/npp776iJbP3YcvAwlsVv
	yZS6KqZDv0M16E9GxnKFUXOrERSx9WhsKajF9gbdRQ5kvlAaKQqlIAEXoi/vK7cyOMNNk2Zb+ht
	/ldikQw==
X-Google-Smtp-Source: AGHT+IG9Zd3t+86XRNhfr6MOl3z2x5n36Sr6uReq0nGSm2P7jNviBzkfzWGC0x9bWFlsxNGdGfsNX6JxluA=
X-Received: from pjuj14.prod.google.com ([2002:a17:90a:d00e:b0:32b:95bb:dbc])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:3ec5:b0:327:e018:204a
 with SMTP id 98e67ed59e1d1-33b50f85081mr35201870a91.0.1760468794156; Tue, 14
 Oct 2025 12:06:34 -0700 (PDT)
Date: Tue, 14 Oct 2025 12:06:32 -0700
In-Reply-To: <xhsmhwm4xpwyt.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251010153839.151763-1-vschneid@redhat.com> <20251010153839.151763-20-vschneid@redhat.com>
 <aO2S3oZwOW_UgAci@google.com> <xhsmhwm4xpwyt.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
Message-ID: <aO6fOM-XydknM6NJ@google.com>
Subject: Re: [PATCH v6 19/29] KVM: VMX: Mark vmx_l1d_should flush and
 vmx_l1d_flush_cond keys as allowed in .noinstr
From: Sean Christopherson <seanjc@google.com>
To: Valentin Schneider <vschneid@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, rcu@vger.kernel.org, 
	x86@kernel.org, linux-arm-kernel@lists.infradead.org, 
	loongarch@lists.linux.dev, linux-riscv@lists.infradead.org, 
	linux-arch@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	Josh Poimboeuf <jpoimboe@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, 
	"H. Peter Anvin" <hpa@zytor.com>, Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>, Arnd Bergmann <arnd@arndb.de>, 
	Frederic Weisbecker <frederic@kernel.org>, "Paul E. McKenney" <paulmck@kernel.org>, 
	Jason Baron <jbaron@akamai.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Ard Biesheuvel <ardb@kernel.org>, Sami Tolvanen <samitolvanen@google.com>, 
	"David S. Miller" <davem@davemloft.net>, Neeraj Upadhyay <neeraj.upadhyay@kernel.org>, 
	Joel Fernandes <joelagnelf@nvidia.com>, Josh Triplett <josh@joshtriplett.org>, 
	Boqun Feng <boqun.feng@gmail.com>, Uladzislau Rezki <urezki@gmail.com>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Mel Gorman <mgorman@suse.de>, 
	Andrew Morton <akpm@linux-foundation.org>, Masahiro Yamada <masahiroy@kernel.org>, 
	Han Shen <shenhan@google.com>, Rik van Riel <riel@surriel.com>, Jann Horn <jannh@google.com>, 
	Dan Carpenter <dan.carpenter@linaro.org>, Oleg Nesterov <oleg@redhat.com>, 
	Juri Lelli <juri.lelli@redhat.com>, Clark Williams <williams@redhat.com>, 
	Yair Podemsky <ypodemsk@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>, 
	Daniel Wagner <dwagner@suse.de>, Petr Tesarik <ptesarik@suse.com>
Content-Type: text/plain; charset="us-ascii"

On Tue, Oct 14, 2025, Valentin Schneider wrote:
> On 13/10/25 17:01, Sean Christopherson wrote:
> > On Fri, Oct 10, 2025, Valentin Schneider wrote:
> >> Later commits will cause objtool to warn about static keys being used in
> >> .noinstr sections in order to safely defer instruction patching IPIs
> >> targeted at NOHZ_FULL CPUs.
> >>
> >> These keys are used in .noinstr code, and can be modified at runtime
> >> (/proc/kernel/vmx* write). However it is not expected that they will be
> >> flipped during latency-sensitive operations, and thus shouldn't be a source
> >> of interference wrt the text patching IPI.
> >>
> >> Mark it to let objtool know not to warn about it.
> >
> > Can you elaborate in the changelog on what will happen if the key is toggle?
> > IIUC, smp_text_poke_batch_finish() will force IPIs if noinstr code is being
> > patched.
> 
> Right!
> 
> > Even just a small footnote like this:
> >
> >   Note, smp_text_poke_batch_finish() never defers IPIs if noinstr code is
> >   being patched, i.e. this is purely about silencing objtool warnings.
> >
> > to make it clear that there's no bug/race being introduced.
> 
> Good point. How about:
> 
> """
> Later commits will cause objtool to warn about static keys being used in
> .noinstr sections in order to safely defer instruction patching IPIs
> targeted at NOHZ_FULL CPUs.
> 
> The VMX keys are used in .noinstr code, and can be modified at runtime
> (/proc/kernel/vmx* write). However it is not expected that they will be
> flipped during latency-sensitive operations, and thus shouldn't be a source
> of interference for NOHZ_FULL CPUs wrt the text patching IPI.
> 
> Note, smp_text_poke_batch_finish() never defers IPIs if noinstr code is
> being patched, i.e. this is purely to tell objtool we're okay with updates
> to that key causing IPIs and to silence the associated objtool warning.
> """

LGTM.  With the updated changelog,

Acked-by: Sean Christopherson <seanjc@google.com>

