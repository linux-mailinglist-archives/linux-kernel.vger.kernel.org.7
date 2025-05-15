Return-Path: <linux-kernel+bounces-650337-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2302BAB8FF5
	for <lists+linux-kernel@lfdr.de>; Thu, 15 May 2025 21:25:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C559D1BC56C2
	for <lists+linux-kernel@lfdr.de>; Thu, 15 May 2025 19:26:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E26D525D1E1;
	Thu, 15 May 2025 19:25:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Y2Ez2VWQ"
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D034625C6FA
	for <linux-kernel@vger.kernel.org>; Thu, 15 May 2025 19:25:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747337146; cv=none; b=ng/r5aHnz8kh92LKlm5tPrrj+YFYVXbwKcciiBVZMfZNDdUZRQeFppHvJihccA95uXKpra1+FI8W5Pv1dBGiWePYqaAul/vBB/L76ObQX9F3xQX0F15nF3jDFZ5WAcsCWjn5KdD/g+b3CszqsnuklEFgUZcNQW0BzUw9Y6LxJlA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747337146; c=relaxed/simple;
	bh=zZ5aWmM8OMpv9EBcLKQSdDKlyFMLUjP1YzCEI1CApF8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=KqiT2PiXNnhuxc25LW91ctYlBunJvmK8n3VBDmm6AEO9aN8PrxRCCdVmnnwh50FdtEgNAq4Gqu59wrMxjuaAFO+tdKMjc22qBInFpcQcFH/qjX8qkcmQ5ePwe28SZ77hlLfA5YxjJHNd/QahxUmLjfw0aXjbqb9Sfn0XguhwajE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Y2Ez2VWQ; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-30e7c25aedaso213059a91.2
        for <linux-kernel@vger.kernel.org>; Thu, 15 May 2025 12:25:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1747337144; x=1747941944; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=PJSWz1qQY0bOXhQozVAxmE44I1S4t/sjttyPXQeJ8IA=;
        b=Y2Ez2VWQKD8ykMesyPGe5Sk9lwA99kOHZBc/CpOJo0njXtSajYe6PGwH8Rp2Tv3vi7
         wZa3Jk4nphL3OUz/VlDFoh+d1DaYbwYLIJ/wco9ribNUbTFjtAjryb4q91lamAmd4SOX
         Ys5ammPTuJQWFCCcDZJbPQ/2gLv2uPv8WZnDmYrx4PjRnG+6QBYCPBFwdG3P3MMw6rDj
         iYmPn1yARz890pOwaqG/3jZXsDtCO8JWa3cs2DsQsp0fbD+rCubMCriSzsecGJsRda57
         +SF1VYF2YPoy5VR0NEqa9yXdNoM44nLAhzd701xgiqOt3VnDgv+Fo/SndKTc/VWIDayf
         +sIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747337144; x=1747941944;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PJSWz1qQY0bOXhQozVAxmE44I1S4t/sjttyPXQeJ8IA=;
        b=UAP1pSNclXwMYzP+lsKetV3qMo4IBNyvyXSr0qorCVi2/iI/YtoQPTo3tXtcYVHw4h
         HXW7VEXR49fdFyVWoOPdnQbCdmXBXOmvcinfUazpnA4wZ3HAMa4dNzdRM3Pt98m6ySzZ
         yvaZ1bFjuC2P5uur00YgVQSb9UiU0QTkztWzEiVpVoRa5RW+fZ6cCA1W7CM6lhwE0woC
         PL8c8uNV0Qgi3Nxqg7jChR+IUkLN2bJ2mVJtxriYOQxqsAd0vKhL64gCxv1hNHWYfztn
         NiKks5BXQK/uwS1z0Lv5TrcLXmgtr7oGVHD+QblOXazhH/bR9dNTq7UoRCgOKRJbh2Cm
         b6cg==
X-Forwarded-Encrypted: i=1; AJvYcCV6AFs9XIHt88tmhA38cM2+8+wIv+iKT3PTBrREk3nLMjdW/7eEIQdPgtIVVaGqgXjnXFcey0l8E7kdRYE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxaZswt+XYBSy7rOm2dJiV0qZbaKFNX10PF/ZVpTjOgYrPmpmFi
	7ZglKc9LPgYz/aUzlUhBCRJc2yzJXIYwg+cTM6pAFXYALZlyk3/FFcTqW21woTOxZX4Mh2F5zo1
	1slomew==
X-Google-Smtp-Source: AGHT+IGnnpSy0LS4moSG7jQw0vd/6SN3ne1/zkd5xblJsV96qiTU23vCFfxne9MCIwYbbn2km+mxYmv5Vhc=
X-Received: from pji8.prod.google.com ([2002:a17:90b:3fc8:b0:2ea:5084:5297])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:6d0:b0:2ea:3f34:f18f
 with SMTP id 98e67ed59e1d1-30e7d55c397mr714765a91.19.1747337143852; Thu, 15
 May 2025 12:25:43 -0700 (PDT)
Date: Thu, 15 May 2025 12:25:42 -0700
In-Reply-To: <4aaf67ab-aa5c-41e6-bced-3cb000172c52@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250324173121.1275209-1-mizhang@google.com> <20250324173121.1275209-6-mizhang@google.com>
 <20250425111352.GF1166@noisy.programming.kicks-ass.net> <aCUlCApeDM9Uy4a0@google.com>
 <4aaf67ab-aa5c-41e6-bced-3cb000172c52@linux.intel.com>
Message-ID: <aCY_tkjzxknAbEgq@google.com>
Subject: Re: [PATCH v4 05/38] perf: Add generic exclude_guest support
From: Sean Christopherson <seanjc@google.com>
To: Kan Liang <kan.liang@linux.intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Mingwei Zhang <mizhang@google.com>, 
	Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Paolo Bonzini <pbonzini@redhat.com>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, Liang@google.com, 
	"H. Peter Anvin" <hpa@zytor.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, Yongwei Ma <yongwei.ma@intel.com>, 
	Xiong Zhang <xiong.y.zhang@linux.intel.com>, Dapeng Mi <dapeng1.mi@linux.intel.com>, 
	Jim Mattson <jmattson@google.com>, Sandipan Das <sandipan.das@amd.com>, 
	Zide Chen <zide.chen@intel.com>, Eranian Stephane <eranian@google.com>, 
	Shukla Manali <Manali.Shukla@amd.com>, Nikunj Dadhania <nikunj.dadhania@amd.com>
Content-Type: text/plain; charset="us-ascii"

On Thu, May 15, 2025, Kan Liang wrote:
> On 2025-05-14 7:19 p.m., Sean Christopherson wrote:
> >> This naming is confusing on purpose? Pick either guest/host and stick
> >> with it.
> > 
> > +1.  I also think the inner perf_host_{enter,exit}() helpers are superflous.
> > These flows
> > 
> > After a bit of hacking, and with a few spoilers, this is what I ended up with
> > (not anywhere near fully tested).  I like following KVM's kvm_xxx_{load,put}()
> > nomenclature to tie everything together, so I went with "guest" instead of "host"
> > even though the majority of work being down is to shedule out/in host context.
> > 
> > /* When loading a guest's mediated PMU, schedule out all exclude_guest events. */
> > void perf_load_guest_context(unsigned long data)
> > {
> > 	struct perf_cpu_context *cpuctx = this_cpu_ptr(&perf_cpu_context);
> > 
> > 	lockdep_assert_irqs_disabled();
> > 
> > 	perf_ctx_lock(cpuctx, cpuctx->task_ctx);
> > 
> > 	if (WARN_ON_ONCE(__this_cpu_read(guest_ctx_loaded)))
> > 		goto unlock;
> > 
> > 	perf_ctx_disable(&cpuctx->ctx, EVENT_GUEST);
> > 	ctx_sched_out(&cpuctx->ctx, NULL, EVENT_GUEST);
> > 	perf_ctx_enable(&cpuctx->ctx, EVENT_GUEST);
> > 	if (cpuctx->task_ctx) {
> > 		perf_ctx_disable(cpuctx->task_ctx, EVENT_GUEST);
> > 		task_ctx_sched_out(cpuctx->task_ctx, NULL, EVENT_GUEST);
> > 		perf_ctx_enable(cpuctx->task_ctx, EVENT_GUEST);
> > 	}
> > 
> > 	arch_perf_load_guest_context(data);
> > 
> > 	__this_cpu_write(guest_ctx_loaded, true);
> > 
> > unlock:
> > 	perf_ctx_unlock(cpuctx, cpuctx->task_ctx);
> > }
> > EXPORT_SYMBOL_GPL(perf_load_guest_context);
> > 
> > void perf_put_guest_context(void)
> > {
> > 	struct perf_cpu_context *cpuctx = this_cpu_ptr(&perf_cpu_context);
> > 
> > 	lockdep_assert_irqs_disabled();
> > 
> > 	perf_ctx_lock(cpuctx, cpuctx->task_ctx);
> > 
> > 	if (WARN_ON_ONCE(!__this_cpu_read(guest_ctx_loaded)))
> > 		goto unlock;
> > 
> > 	arch_perf_put_guest_context();
> 
> It will set the guest_ctx_loaded to false.
> The update_context_time() invoked in the perf_event_sched_in() will not
> get a chance to update the guest time.

The guest_ctx_loaded in arch/x86/events/core.c is a different variable, it just
happens to have the same name.

It's completely gross, but exposing guest_ctx_loaded outside of kernel/events/core.c
didn't seem like a great alternative.  If we wanted to use a single variable,
then the writes in arch_perf_{load,put}_guest_context() can simply go away.

