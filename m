Return-Path: <linux-kernel+bounces-724115-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BB41AFEECD
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 18:21:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ED8EE4E5713
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 16:21:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48F3020AF9C;
	Wed,  9 Jul 2025 16:21:31 +0000 (UTC)
Received: from relay.hostedemail.com (smtprelay0014.hostedemail.com [216.40.44.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CECE4146D45;
	Wed,  9 Jul 2025 16:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752078090; cv=none; b=CxcdRuylkLwk3tH5zLhjDcz5V2ZUem+z8u2bY/h5uiipkOdfkA1+bBHkIDrJXsg34fdAmzdC/dSp0X/SQMHnOAIbE49Hcu1a8fpYUOPOVnrIxFVHZRSfopxHZ5TTwKHUgE4wP8/HwPhQKmeypiSZ/5nUBk0aLbDr1t6bsw6YkCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752078090; c=relaxed/simple;
	bh=vNFKpWvUgiRSxy59r6jbFTJESnlfgfLQit6HrriuWvY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ECV6Mqv055woE/vatgh+KYmEBE3yWyg5z48u8fa8wDJc1IhU4VPTu6Tc3Uu3kqNpuibuYuESCRvm096WQsnQsefjLu0REUoZHnAlYflfUGZ0GuDz/C9L5EM89MtlP+Ei0DA7TAJhHpBtkWP+QhXlJSmim9NDuH4L67z4Fxza/s4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf11.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay05.hostedemail.com (Postfix) with ESMTP id 04B2858876;
	Wed,  9 Jul 2025 16:21:26 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf11.hostedemail.com (Postfix) with ESMTPA id D78A020029;
	Wed,  9 Jul 2025 16:21:24 +0000 (UTC)
Date: Wed, 9 Jul 2025 12:21:23 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: SeongJae Park <sj@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 damon@lists.linux.dev, kernel-team@meta.com, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] mm/damon: add trace event for effective size quota
Message-ID: <20250709122123.779c874f@batman.local.home>
In-Reply-To: <20250704221408.38510-3-sj@kernel.org>
References: <20250704221408.38510-1-sj@kernel.org>
	<20250704221408.38510-3-sj@kernel.org>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: D78A020029
X-Rspamd-Server: rspamout02
X-Stat-Signature: fkg984hkoqjmczbxduzqcafqtg6cfuhe
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1+J83NPMP8Sb/jo8DzLq42jn+04tnd7tQs=
X-HE-Tag: 1752078084-665881
X-HE-Meta: U2FsdGVkX19yh07IWGJTt82fNF/ks4rwm7Vd04a3pMjNbEa9Iu2kCulF+w3I8TKkzOcC4LrKMfExorhkuneJ5aivcdQPGfaB6Gv4+YvVKYa2/plhI4vNpcQzOpfwvfwhDrczQIa6wsJd4+jOewKhbRkkpXCfLfONXlESW3UW1+31AQReitUvox9NrhHOAuaUTOQvYIIqS59/hfasvc0RbYsmz/pUa8MbHpoO4PXVx+Cjbbh2yrudjrxhbM532YhV5U8srTsOI8YRlh2VE6kzlDbTskCtxjbP0bl16FzcfvePsjdD6eMLnNMxZ4OHxl1BfdJMcHDeqkN0iaWxWdXTOI1aLdkYiVdr

On Fri,  4 Jul 2025 15:14:08 -0700
SeongJae Park <sj@kernel.org> wrote:

> Aim-oriented DAMOS quota auto-tuning is an important and recommended
> feature for DAMOS users.  Add a trace event for the observability of the
> tuned quota and tuning itself.
> 
> Signed-off-by: SeongJae Park <sj@kernel.org>
> ---
>  include/trace/events/damon.h | 26 ++++++++++++++++++++++++++
>  mm/damon/core.c              | 20 +++++++++++++++++++-
>  2 files changed, 45 insertions(+), 1 deletion(-)
> 
> diff --git a/include/trace/events/damon.h b/include/trace/events/damon.h
> index 32c611076023..36b2cdf47dce 100644
> --- a/include/trace/events/damon.h
> +++ b/include/trace/events/damon.h
> @@ -9,6 +9,32 @@
>  #include <linux/types.h>
>  #include <linux/tracepoint.h>
>  
> +TRACE_EVENT_CONDITION(damos_esz,
> +
> +	TP_PROTO(unsigned int context_idx, unsigned int scheme_idx,
> +		unsigned long esz, bool do_trace),
> +
> +	TP_ARGS(context_idx, scheme_idx, esz, do_trace),
> +
> +	TP_CONDITION(do_trace),

Please explain to me why you are using a conditional here?

> +
> +	TP_STRUCT__entry(
> +		__field(unsigned int, context_idx)
> +		__field(unsigned int, scheme_idx)
> +		__field(unsigned long, esz)
> +	),
> +
> +	TP_fast_assign(
> +		__entry->context_idx = context_idx;
> +		__entry->scheme_idx = scheme_idx;
> +		__entry->esz = esz;
> +	),
> +
> +	TP_printk("ctx_idx=%u scheme_idx=%u esz=%lu",
> +			__entry->context_idx, __entry->scheme_idx,
> +			__entry->esz)
> +);
> +
>  TRACE_EVENT_CONDITION(damos_before_apply,
>  
>  	TP_PROTO(unsigned int context_idx, unsigned int scheme_idx,
> diff --git a/mm/damon/core.c b/mm/damon/core.c
> index 57a1ace4d10d..6019b8ec4bba 100644
> --- a/mm/damon/core.c
> +++ b/mm/damon/core.c
> @@ -2011,12 +2011,26 @@ static void damos_set_effective_quota(struct damos_quota *quota)
>  	quota->esz = esz;
>  }
>  
> +static void damos_trace_esz(struct damon_ctx *c, struct damos *s,
> +		struct damos_quota *quota)
> +{
> +	unsigned int cidx = 0, sidx;
> +	struct damos *siter;
> +
> +	damon_for_each_scheme(siter, c) {
> +		if (siter == s)
> +			break;
> +		sidx++;
> +	}
> +	trace_damos_esz(cidx, sidx, quota->esz, true);

It's set to true, so it's not even a conditional anymore. The compiler
will likely optimize it out!

-- Steve


> +}
> +
>  static void damos_adjust_quota(struct damon_ctx *c, struct damos *s)
>  {
>  	struct damos_quota *quota = &s->quota;
>  	struct damon_target *t;
>  	struct damon_region *r;
> -	unsigned long cumulated_sz;
> +	unsigned long cumulated_sz, cached_esz;
>  	unsigned int score, max_score = 0;
>  
>  	if (!quota->ms && !quota->sz && list_empty(&quota->goals))
> @@ -2030,7 +2044,11 @@ static void damos_adjust_quota(struct damon_ctx *c, struct damos *s)
>  		quota->total_charged_sz += quota->charged_sz;
>  		quota->charged_from = jiffies;
>  		quota->charged_sz = 0;
> +		if (trace_damos_esz_enabled())
> +			cached_esz = quota->esz;
>  		damos_set_effective_quota(quota);
> +		if (trace_damos_esz_enabled() && quota->esz != cached_esz)
> +			damos_trace_esz(c, s, quota);
>  	}
>  
>  	if (!c->ops.get_scheme_score)


