Return-Path: <linux-kernel+bounces-648755-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EB1DAB7B27
	for <lists+linux-kernel@lfdr.de>; Thu, 15 May 2025 03:50:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E1D7C1BA7133
	for <lists+linux-kernel@lfdr.de>; Thu, 15 May 2025 01:50:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57D0B2853E3;
	Thu, 15 May 2025 01:49:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ZY2twBwc"
Received: from out-181.mta0.migadu.com (out-181.mta0.migadu.com [91.218.175.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDB2F41C71
	for <linux-kernel@vger.kernel.org>; Thu, 15 May 2025 01:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747273796; cv=none; b=SKq6k5+hPUWyAHfu0eRiyYnga/xfIQLqWlH/TYq4jpdB0q86kKD8xLkvBUNtPhEns1rCaPgXPduHnvHTAgpxS1Qla7aRwDh3N4zpQhcXMysH0uTBrIm9rWNmOerVkeEM1dxG8mEp0CWitTvYT/9oVFjycfiV++A7rZFpTBy3NxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747273796; c=relaxed/simple;
	bh=NjYefZJ+G12d8ZbQGjEoN4hKEc0qOfGCUdQw7dcIbHA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rXRQkUud6aNtc6nE50vQvmB+tdoo8P+Fvmguy2JTimjfqHbw89Dr48rQZwC5F5yRqa4ZxhTmRAlJVEYRyuE+FTjbMKoOLFoRv1b1xfdIU5/kAqL10VNnyUz9mkOMShn98CChyOKS/kSbnICwVBIRHoAGgNnabZPBUjLNGHjhOuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ZY2twBwc; arc=none smtp.client-ip=91.218.175.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Wed, 14 May 2025 18:49:47 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1747273792;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FS/yE07A4Cv6zJAjjeYcVdij2I9QfJ/UEHQCtSmp7sw=;
	b=ZY2twBwc4USR7Gw2dEDffmf4FeaE58904GvYVMl8BBdMJ5qN/u0DfcmyYma+K6jrE7PiC0
	oPgNdcW/JD4cXwgyOTJdig85MQLmkbDAzNvKm2gopHzIhI34ha3xipM565sjzzo1GG1FCa
	SBsKU99aiO6NoMDwptx09g8x6aZMbig=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Peter Zijlstra <peterz@infradead.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	Michal Hocko <mhocko@kernel.org>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Muchun Song <muchun.song@linux.dev>, Alexei Starovoitov <ast@kernel.org>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, bpf@vger.kernel.org, linux-mm@kvack.org, cgroups@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Meta kernel team <kernel-team@meta.com>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH 0/4] memcg: nmi-safe kmem charging
Message-ID: <mezzzvbplz2jtt6wjel7dwic25owtydcu3hp2mkqlhp2q3zb7x@js2bm7oheljs>
References: <20250509232859.657525-1-shakeel.butt@linux.dev>
 <2e2f0568-3687-4574-836d-c23d09614bce@suse.cz>
 <mzrsx4x5xluljyxy5h5ha6kijcno3ormac3sobc3k7bkj5wepr@cuz2fluc5m5d>
 <07e4e8d9-2588-41bf-89d4-328ca6afd263@suse.cz>
 <20250513114125.GE25763@noisy.programming.kicks-ass.net>
 <ct2h2eyuepa2g2ltl5fucfegwyuqspvz6d4uugcs4szxwnggdc@6m4ks3hp3tjj>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ct2h2eyuepa2g2ltl5fucfegwyuqspvz6d4uugcs4szxwnggdc@6m4ks3hp3tjj>
X-Migadu-Flow: FLOW_OUT

On Tue, May 13, 2025 at 03:17:00PM -0700, Shakeel Butt wrote:
[...]
> 
> Thanks a lot Vlastimil & Peter for the suggestions. Let me summarize
> what I plan to do and please point out if I am doing something wrong:
> 
> 
> #if defined(CONFIG_ARCH_HAS_NMI_SAFE_THIS_CPU_OPS) || !defined(CONFIG_HAVE_NMI)
> 
> // Do normal this_cpu* ops
> 
> #elif defined(ARCH_HAVE_NMI_SAFE_CMPXCHG)
> 
> // Do 32 bit atomic ops with in_nmi() checks
> 
> #else
> 
> // Build error or ignore nmi stats??
> 
> #endif
> 
> 

Just wanted to circle back on the updated plan:

#if defined(CONFIG_ARCH_HAS_NMI_SAFE_THIS_CPU_OPS) || !defined(CONFIG_HAVE_NMI)

- Allow memcg charging in nmi context
- Use this_cpu_ops for memcg stats even in nmi context

#elif defined(ARCH_HAVE_NMI_SAFE_CMPXCHG)

- Allow memcg charging in nmi context
- Use atomic* ops for selected memcg stats in nmi context

#else

- Do not allow memcg charging in nmi context

#endif

