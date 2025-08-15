Return-Path: <linux-kernel+bounces-771121-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E0D47B2831D
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 17:43:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2EE5D3AB47E
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 15:42:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 564B2307AD8;
	Fri, 15 Aug 2025 15:41:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BcQaeZG/"
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3958D307AC3
	for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 15:41:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755272515; cv=none; b=rIXmZvhK42kINUvGGLKmiXfV3MPQ4UNWVceD2Zhp2sbma3f1RrDBKb0iXpSffySSb+k5cwnD81YlmU4tAikZ/LVM6zCW8Po8Zf0M/U2eoxUIiLANWcozwyjIfGvYBA8hYyxa7Mpmi4WmamAc3B+NjT/sPKb3FqFkLyNrzhKBXLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755272515; c=relaxed/simple;
	bh=V0iQe0wXHiwXgNwjclXLeqc33EIkx7ymZ0WlHmqsCas=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=kjt1cTUISsFeP5Veq60QBgqmxotnCggOwBQqB6d2EVYkDZLdZ4eXq4j9FZTFZVZsrClKvy04B6SsywJMKEDu6QuXiP/sysI8x4ZCxfFnhy4rkwXqNQDH5c+nd/yj4ZUuSjx9bUuxwVmM8DyzvWAkXpfyk7XHnNmSwMLKLOipvxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BcQaeZG/; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-32326e6b1deso2016244a91.3
        for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 08:41:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755272513; x=1755877313; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=mZHHNj6EVbfkylJhuGEQxcUJR48ZbvWbqL/aI2BJPfo=;
        b=BcQaeZG/f9RcD6D65wb23kfnpQB4guGcKuw/KTsOk6gCU8wmZPv3WKbejGKBIKMVJg
         qnMnhQD5eLFsfma/pjecFNbUnIrG1svYeGCmGqI9V+vFD9VFj3wPA3Aau2l2rI+37NA7
         PuDK9PUas4XawIIlyE2SCbJPuhcw7DgD3iB9D3MEoWFELVDnq+474vY/Vqu2Y5zt1u9E
         fmVWw/1HZRif2tIolnjr6/tvQ8QCeCnlrAKcVUWPjQzoS+fjoIXMsNNotp6aCYoekC2S
         airPuZjuYIQoEOd+iiSTJXEKmdzcxjQhH0KEyLt4WFtru0nB/9ggaABps5g4I5XL1qbD
         IA1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755272513; x=1755877313;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mZHHNj6EVbfkylJhuGEQxcUJR48ZbvWbqL/aI2BJPfo=;
        b=HFQc28x9oYFtCCfkOMd1ddw1IDBzzuSPwnZAxBAwvR/Fu3t1dZDkbmcanaM2mf383X
         tLIFIqBB0vDnYjfWJgFSDchdLLHTcTffj+7wDBvLNzoky7jXkDOcJ3cZlMChBj4MMBhT
         C87UM8O+am25yQkahpRGDBa5j64Bzv3RQVjHXGR2hJUJuQWrWlFA69lG/fuJdGBH0Iva
         BxxgUPGKl4090edTq+j0NunyRJWxo6SHtrSFr543emACsx5e1WhgCX2s6n0W/zga+vsv
         7Axnkxs/zyTbNQ3lHTZXezwHnCsiLJ+3wEsxuXlqJymk8lqSVKxK8MuXK+oL7pjcSu2a
         ahfA==
X-Forwarded-Encrypted: i=1; AJvYcCWynmzZhxbTRR5DfGJ2oZPaXxJ4Yxh5L3yBnSKuWtJU7PFzbze6UQWk82zxw0dHxqxkcRvKvwPnZ3wKSBA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4crJQcNZ2lMaEWJA2U/uzP/H0fh7a941rIdrkoeSzE+CvSPpX
	oUFOM2EPvVaIoAoc0uKoIcTk6yCfi0/YmXVpiQHCf+GVgAe4DHEKm9aLSj7GCdGa2kg2lR1vxCr
	z5bYHzg==
X-Google-Smtp-Source: AGHT+IF1xhNBmkTpZib3NykIL4xlxFbGkhXK+/yjF5LGvtuWFmTYgkxBDJw0+uZkCmQyO/RrRqfOrKLRso0=
X-Received: from pjbsd7.prod.google.com ([2002:a17:90b:5147:b0:31e:a094:a39])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:5104:b0:31e:4492:af48
 with SMTP id 98e67ed59e1d1-32342238d44mr3660367a91.28.1755272513579; Fri, 15
 Aug 2025 08:41:53 -0700 (PDT)
Date: Fri, 15 Aug 2025 08:41:52 -0700
In-Reply-To: <20250815113951.GC4067720@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250806195706.1650976-1-seanjc@google.com> <20250806195706.1650976-10-seanjc@google.com>
 <20250815113951.GC4067720@noisy.programming.kicks-ass.net>
Message-ID: <aJ9VQH87ytkWf1dH@google.com>
Subject: Re: [PATCH v5 09/44] perf/x86: Switch LVTPC to/from mediated PMI
 vector on guest load/put context
From: Sean Christopherson <seanjc@google.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Marc Zyngier <maz@kernel.org>, Oliver Upton <oliver.upton@linux.dev>, 
	Tianrui Zhao <zhaotianrui@loongson.cn>, Bibo Mao <maobibo@loongson.cn>, 
	Huacai Chen <chenhuacai@kernel.org>, Anup Patel <anup@brainfault.org>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Xin Li <xin@zytor.com>, "H. Peter Anvin" <hpa@zytor.com>, 
	Andy Lutomirski <luto@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Paolo Bonzini <pbonzini@redhat.com>, linux-arm-kernel@lists.infradead.org, 
	kvmarm@lists.linux.dev, kvm@vger.kernel.org, loongarch@lists.linux.dev, 
	kvm-riscv@lists.infradead.org, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	Kan Liang <kan.liang@linux.intel.com>, Yongwei Ma <yongwei.ma@intel.com>, 
	Mingwei Zhang <mizhang@google.com>, Xiong Zhang <xiong.y.zhang@linux.intel.com>, 
	Sandipan Das <sandipan.das@amd.com>, Dapeng Mi <dapeng1.mi@linux.intel.com>
Content-Type: text/plain; charset="us-ascii"

On Fri, Aug 15, 2025, Peter Zijlstra wrote:
> > diff --git a/kernel/events/core.c b/kernel/events/core.c
> > index e1df3c3bfc0d..ad22b182762e 100644
> > --- a/kernel/events/core.c
> > +++ b/kernel/events/core.c
> > @@ -6408,6 +6408,8 @@ void perf_load_guest_context(unsigned long data)
> >  		task_ctx_sched_out(cpuctx->task_ctx, NULL, EVENT_GUEST);
> >  	}
> >  
> > +	arch_perf_load_guest_context(data);
> 
> So I still don't understand why this ever needs to reach the generic
> code. x86 pmu driver and x86 kvm can surely sort this out inside of x86,
> no?

It's definitely possible to handle this entirely within x86, I just don't love
switching the LVTPC without the protection of perf_ctx_lock and perf_ctx_disable().
It's not a sticking point for me if you strongly prefer something like this: 

diff --git a/arch/x86/kvm/pmu.c b/arch/x86/kvm/pmu.c
index 0e5048ae86fa..86b81c217b97 100644
--- a/arch/x86/kvm/pmu.c
+++ b/arch/x86/kvm/pmu.c
@@ -1319,7 +1319,9 @@ void kvm_mediated_pmu_load(struct kvm_vcpu *vcpu)
 
        lockdep_assert_irqs_disabled();
 
-       perf_load_guest_context(kvm_lapic_get_reg(vcpu->arch.apic, APIC_LVTPC));
+       perf_load_guest_context();
+
+       perf_load_guest_lvtpc(kvm_lapic_get_reg(vcpu->arch.apic, APIC_LVTPC));
 
        /*
         * Disable all counters before loading event selectors and PMCs so that
@@ -1380,5 +1382,7 @@ void kvm_mediated_pmu_put(struct kvm_vcpu *vcpu)
 
        kvm_pmu_put_guest_pmcs(vcpu);
 
+       perf_put_guest_lvtpc();
+
        perf_put_guest_context();
 }


