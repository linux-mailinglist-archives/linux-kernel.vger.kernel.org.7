Return-Path: <linux-kernel+bounces-723164-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 765BDAFE3DF
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 11:18:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 64507166268
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 09:18:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 813C0265292;
	Wed,  9 Jul 2025 09:18:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="kjG96jQr"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9406735897
	for <linux-kernel@vger.kernel.org>; Wed,  9 Jul 2025 09:17:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752052679; cv=none; b=jnBc+8Gg1j1GjlYRAKUjrXNRruPLEnB7BN3tghDu/BIKimyeGZNMo6OfJrrAA6eFGUKYCcujrKUdrFnaJMjzYp6EZaa9BCGsq/q5bmpZZgqmw/nsiLp/QEZU6I6QjQg4/UmKVqMz8hIUr8ipD0egvzSnC2VIrz0ojr4c4ETjpnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752052679; c=relaxed/simple;
	bh=6NLJOD4mUSJZOJBrGweRXFb4jvQpuTuvqn99WvuAma0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FR+/G+lY2Vv76kSxI3g/6T+a0d69Rrzcs75wPpFaAuADGbfNWuIkMBVaStnSedAZphaI8gnnyocjaXqxcjavJ9ft3y6UTlbNHdLKxJOSVSS4Ndsr4ROoImecg/l/c+WT+VTuSQ0g+dgzWqimkQruu586CscM6Z2nH7ka8qVuTf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=kjG96jQr; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=hu+SDxzRoyWfWTYHxn/gl+38SKrFmF6sGQthxNefc7g=; b=kjG96jQr8GyqfcM0QJ/FVh2q2i
	1C8WDcsf/jE514W9O8s38D0ORKUsxwsKzGr/SDsWCn3WzSj3HLCcqcwZZHEU4ehk62ccJCnjz2gvu
	lvxf3VjLtTwqjWCqmgT7t5DyFjf9AuS5ket1fcACzA5mtA8Qc7BWheONqmD7ycYf/BAWvTk7u1fQY
	XkaXLU+h4izmbiJaDQ0t4Om02iblznmJhP+Ga3WHUCKl3Nf6hTQkvRmPmDbThry2xG6LHFJ9VxA0F
	7pi9lCPu5WJa/xa53MlspNI2qNL1566WzlBhMpaODoGJuNpOgFRiQRQfUmL1Fokwnaa0esgcXxo67
	1A7bi1Qg==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uZQvu-00000008qRs-3bm3;
	Wed, 09 Jul 2025 09:17:43 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 4404530029B; Wed, 09 Jul 2025 11:17:41 +0200 (CEST)
Date: Wed, 9 Jul 2025 11:17:41 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Vincent Guittot <vincent.guittot@linaro.org>
Cc: mingo@redhat.com, juri.lelli@redhat.com, dietmar.eggemann@arm.com,
	rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
	vschneid@redhat.com, dhaval@gianis.ca, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/6] sched/fair: Fix NO_RUN_TO_PARITY case
Message-ID: <20250709091741.GH1613200@noisy.programming.kicks-ass.net>
References: <20250708165630.1948751-1-vincent.guittot@linaro.org>
 <20250708165630.1948751-3-vincent.guittot@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250708165630.1948751-3-vincent.guittot@linaro.org>

On Tue, Jul 08, 2025 at 06:56:26PM +0200, Vincent Guittot wrote:

>  static inline void set_protect_slice(struct sched_entity *se)
>  {
> -	se->vlag = se->deadline;
> +	u64 quantum = se->slice;
> +
> +	if (!sched_feat(RUN_TO_PARITY))
> +		quantum = min(quantum, normalized_sysctl_sched_base_slice);
> +
> +	if (quantum != se->slice)
> +		se->vprot = min_vruntime(se->deadline, se->vruntime + calc_delta_fair(quantum, se));
> +	else
> +		se->vprot = se->deadline;
>  }

I've done s/quantum/slice/ on the whole series. In the end this thing:

> +static inline bool resched_next_quantum(struct cfs_rq *cfs_rq, struct sched_entity *curr)

is gone, and *_protect_slice() has slice in the name, and its mostly
assigned from slice named variables.

Final form ends up looking like so:

static inline void set_protect_slice(struct cfs_rq *cfs_rq, struct sched_entity *se)
{
	u64 slice = normalized_sysctl_sched_base_slice;
	u64 vprot = se->deadline;

	if (sched_feat(RUN_TO_PARITY))
		slice = cfs_rq_min_slice(cfs_rq);

	slice = min(slice, se->slice);
	if (slice != se->slice)
		vprot = min_vruntime(vprot, se->vruntime + calc_delta_fair(slice, se));

	se->vprot = vprot;
}

I'll run a few compiles and then push out to queue/sched/core (and stick
the ttwu bits in queue/sched/ttwu -- as I should've done earlier).

