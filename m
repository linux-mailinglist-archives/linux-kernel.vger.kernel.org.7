Return-Path: <linux-kernel+bounces-723876-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E932FAFEBBE
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 16:23:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9142A7A1671
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 14:22:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CC9917A586;
	Wed,  9 Jul 2025 14:23:42 +0000 (UTC)
Received: from relay.hostedemail.com (smtprelay0012.hostedemail.com [216.40.44.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F364F2E0930
	for <linux-kernel@vger.kernel.org>; Wed,  9 Jul 2025 14:23:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752071022; cv=none; b=U8ij/O5oz94WFGrDS+IZrHbdUC+F++NRXxx4fFZvzPluLXZyds+MCUj652Zmckf38VAF/3hPei4Qq3dL1GX13ADyNAaK+VbDXkBeuMMnQLmoslsSVhHhQF25EHyngtm7agooZ9gRvkJty8sGrBv1qFwVO1E/1tC51+fCQU42d34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752071022; c=relaxed/simple;
	bh=sWl+IZYkVopB/RqvPQgbtjQC52n5C/xriMlbBb4g2W8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZkRyGhy9K8SuyWrh7D1xrMAVauBYuYeDzHjeHQSaA0A+y97zfdsdSiUQpxPOUyrcurFfi2vdx/JaEvbBaG21xJjydcFjxEmWrRz3BKpN5c5/W14dWED4xFMkw6+S4H4YQzSPR8M0WtIDLWkYtzMJeg++Q9D7wAIc+KQkbrgJClM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf14.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay10.hostedemail.com (Postfix) with ESMTP id 8B795C0250;
	Wed,  9 Jul 2025 14:23:31 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf14.hostedemail.com (Postfix) with ESMTPA id EB7A930;
	Wed,  9 Jul 2025 14:23:29 +0000 (UTC)
Date: Wed, 9 Jul 2025 10:23:29 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Aditya Chillara <quic_achillar@quicinc.com>
Cc: Ingo Molnar <mingo@redhat.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] tracing/perf: Prevent double unregister of perf
 probes
Message-ID: <20250709102329.7a5430fd@batman.local.home>
In-Reply-To: <20250709-fix-double-perf-probe-unregister-v1-1-2b588b3c0140@quicinc.com>
References: <20250709-fix-double-perf-probe-unregister-v1-0-2b588b3c0140@quicinc.com>
	<20250709-fix-double-perf-probe-unregister-v1-1-2b588b3c0140@quicinc.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: EB7A930
X-Stat-Signature: 8gdf5dbzu4gqbbu8a5stekf3kq1ruzqi
X-Rspamd-Server: rspamout06
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX18/ZMa5SLApCnYIBS39ZOWsQAE+WNF/dhI=
X-HE-Tag: 1752071009-268585
X-HE-Meta: U2FsdGVkX181aKLlrmoxpk3ILopkNoL6E3THn3wNQxhzgg1BKY7aQu5VkfjjUHxo1hblizKHburntqfIlVpLOfUtiTsJtFyvBKKeEmHIrIAqtjosHshTl51NMIbn8Q+ZsFW93S4tW02iBcRKMyrGyWc2hfwRjQadmM3H1QWF48FRwiHGfqKS4vN5h92I7c7KJDoiuPc8sibqr0aEK032dvMNyKP391i80iNxRZMzoX1qa4+kJedcpUwZo1cWrhy5JJ2T7JFrv+k5wfXqazPumnuTwJq8IBKeZoqeGo0pz0K9iiofsD1DCTzG34ts8OuazwPoBnsZOLZ46xsalMw35Ni7COg3YJuobW02DuDSMHSi20by1rOmphlI9jSeX4F0

On Wed, 9 Jul 2025 11:11:09 +0530
Aditya Chillara <quic_achillar@quicinc.com> wrote:

> Double perf_trace_event_unreg is allowed causing perf_refcount to go
> negative. total_ref_count also goes negative because the return value
> of tracepoint_probe_unregister is ignored.
> 
> Once total_ref_count is negative, the next call to perf_trace_event_reg
> will register perf_probe but will not allocate perf_trace_buf and sets
> it to NULL instead.
> 
> The subsequent trace_##call() will mem abort in perf_trace_buf_alloc
> because memset will be called on the NULL perf_trace_buf.
> 
> Gracefully handle the error in perf_trace_event_unreg to prevent
> double unregister.
> 
> Signed-off-by: Aditya Chillara <quic_achillar@quicinc.com>
> ---
>  kernel/trace/trace_event_perf.c | 8 ++++++--
>  kernel/trace/trace_events.c     | 3 +--
>  2 files changed, 7 insertions(+), 4 deletions(-)
> 
> diff --git a/kernel/trace/trace_event_perf.c b/kernel/trace/trace_event_perf.c
> index 61e3a2620fa3c9417ac23cf5a18aeb86e7393dcc..247db88accd88eb0acf3692ea593d576519ce8b1 100644
> --- a/kernel/trace/trace_event_perf.c
> +++ b/kernel/trace/trace_event_perf.c
> @@ -154,12 +154,16 @@ static int perf_trace_event_reg(struct trace_event_call *tp_event,
>  static void perf_trace_event_unreg(struct perf_event *p_event)
>  {
>  	struct trace_event_call *tp_event = p_event->tp_event;
> -	int i;
> +	int i, ret;
>  
>  	if (--tp_event->perf_refcount > 0)
>  		return;
>  
> -	tp_event->class->reg(tp_event, TRACE_REG_PERF_UNREGISTER, NULL);
> +	ret = tp_event->class->reg(tp_event, TRACE_REG_PERF_UNREGISTER, NULL);

The only time unreg() fails is when it doesn't find a tracepoint to
unregister.

There should be no reason to check the return value of unregister if
you have your accounting correct. Thus I think you are fixing a symptom
of a bug elsewhere.

-- Steve


> +	if (ret) {
> +		++tp_event->perf_refcount;
> +		return;
> +	}
>  

