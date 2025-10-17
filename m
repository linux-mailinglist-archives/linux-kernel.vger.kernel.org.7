Return-Path: <linux-kernel+bounces-857604-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 40268BE73E5
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 10:44:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CFCF25831D7
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 08:44:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87F1F29E0FD;
	Fri, 17 Oct 2025 08:44:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="rEsXJxeo";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="w2sMkOcO"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C7FE296BCB;
	Fri, 17 Oct 2025 08:44:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760690681; cv=none; b=mvB8bmuK/wdsfj4yEwcnLgnovx4JkiUxLimX6ga60lJK+pt8Oq/t4WbUp43GooUfgO7ewW2zGBxrwWFEgZqYLsTYyxX1KT27HNKADetdkT6JZ9zO3Pz4ojrgTNECcJRhb3MahLP6HMqH6rqiAKpb34+tFVpHjiZY7tH/Ldm9iB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760690681; c=relaxed/simple;
	bh=qgDPBAQBZGrfdUAUp9hOLmJDvBaLqtxByWYhlThGNhw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=i6Cc2gX5QAIbw3EIZBMe4FuqALKNjFdidAXGrClC7PYQzXP4FxGqjFXtrk98kf3q6rtMRxCCZCawGZxETZdAGqKYdjMFZSIeAhjopvLa1oZ2Dz9JH0Vzt6uhFHZEA7rIaZPlIyLHLEYjdIX/qUy29StKyFn6cab1qVWhDiec7DA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=rEsXJxeo; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=w2sMkOcO; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1760690677;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8l98EgvkPcRXAFtf3Mvaaqt6iRB7ATL73UNXw0Nrql0=;
	b=rEsXJxeoful2dBoqN0sCZLBmCEYFUySJsXMrqk/i/FXYQ6RbPGwnxw9/Gy7kYremFABHtl
	n9+GnsckKysMFkQvVKlBI/b2ZmDExPhsrP6u20y0oDKcGcHg9vh9MCiKivaW5OCUQSPt6o
	dZWTL4xEdvqu2xGRLFSU3m/3hVo2Qbn7ihuupIqxByryiQBd9TUr/VZeT23XSiUOXAoBTI
	KOLszVt2Dyfb5mkWzroJh7baRsEV7w/F71nPO1OnUq83N29KJbEzX0BAg7szgwp4V4BKcY
	MjeWV0N6FkpGFGEcxKkWTAohte/hai3Mvz/o6/91Vg/zcIZNDZNWF2Q5tLoC2w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1760690677;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8l98EgvkPcRXAFtf3Mvaaqt6iRB7ATL73UNXw0Nrql0=;
	b=w2sMkOcOzBN5V2hNMw0VQfIe7Iw+KoJlbhkmXyVafyljEUM/VjgLDLizctD8ow3jFCxRg+
	T+pUsQw03SFaeACw==
To: Gabriele Monaco <gmonaco@redhat.com>, linux-kernel@vger.kernel.org,
 Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, linux-trace-kernel@vger.kernel.org
Cc: Gabriele Monaco <gmonaco@redhat.com>, Tomas Glozar <tglozar@redhat.com>,
 Juri Lelli <jlelli@redhat.com>, Clark Williams <williams@redhat.com>, John
 Kacur <jkacur@redhat.com>
Subject: Re: [PATCH v2 10/20] rv: Add Hybrid Automata monitor type
In-Reply-To: <20250919140954.104920-11-gmonaco@redhat.com>
References: <20250919140954.104920-1-gmonaco@redhat.com>
 <20250919140954.104920-11-gmonaco@redhat.com>
Date: Fri, 17 Oct 2025 10:44:36 +0200
Message-ID: <87ldl9x6h7.fsf@yellow.woof>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Gabriele Monaco <gmonaco@redhat.com> writes:
> diff --git a/include/rv/ha_monitor.h b/include/rv/ha_monitor.h
> new file mode 100644
> index 000000000000..fb885709b727
> --- /dev/null
> +++ b/include/rv/ha_monitor.h
> @@ -0,0 +1,469 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Copyright (C) 2025-2028 Red Hat, Inc. Gabriele Monaco <gmonaco@redhat.com>
> + *
> + * Hybrid automata (HA) monitor functions, to be used together
> + * with automata models in C generated by the dot2k tool.
> + *
> + * This type of monitors extends the Deterministic automata (DA) class by
> + * adding a set of environment variables (e.g. clocks) that can be used to
> + * constraint the valid transitions.
> + *
> + * The dot2k tool is available at tools/verification/dot2k/
                                     ^^^^^^^^^^^^^^^^^^^^^^^^^
                                     non-existent
> +/*
> + * ktime_get_ns is expensive, since we usually don't require precise accounting
> + * of changes within the same event, cache the current time at the beginning of
> + * the constraint handler and use the cache for subsequent calls.
> + * Monitors without ns clocks automatically skip this.
> + */
> +#ifdef HA_CLK_NS
> +#define ha_update_ns_cache() ktime_get_ns()
> +#else
> +#define ha_update_ns_cache() 0
> +#endif /* HA_CLK_NS */

ha_update_ns_cache() itself does not cache, its caller does. So I think
it is misleading to name this "cache".

Why is "update" in the name? Isn't something like ha_get_ns() betters
describe this macro?

> +/*
> + * The clock variables have 2 different representations in the env_store:
> + * - The guard representation is the timestamp of the last reset
> + * - The invariant representation is the timestamp when the invariant expires

Why does guard representation store the last reset?

For example, what if I specifiy the guard as "clk > 500ns". Shouldn't
the guard representation be "500ns"?

> +static inline u64 ha_get_passed_ns(struct ha_monitor *ha_mon, enum envs env,
> +				   u64 expire, u64 time_ns)
> +{
> +	u64 passed = 0;
> +
> +	if (env < 0 || env >= ENV_MAX_STORED)
> +		return 0;
> +	if (ha_monitor_env_invalid(ha_mon, env))
> +		return 0;
> +	passed = ha_get_env(ha_mon, env, time_ns);
> +	ha_set_invariant_ns(ha_mon, env, expire - passed, time_ns);

The function is named *get*() which indicates that it only reads. But it
also writes.

> +/*
> + * Retrieve the last reset time (guard representation) from the invariant
> + * representation (expiration).
> + * It the caller's responsibility to make sure the storage was actually in the
> + * invariant representation (e.g. the current state has an invariant).
> + * The provided value must be the same used when starting the invariant.
> + *
> + * This function's access to the storage is NOT atomic, due to the rarity when
> + * this is used. If a monitor allows writes concurrent to this, likely
> + * other things are broken and need rethinking the model or additional locking.

Does atomic_sub() solves your "NOT atomic" problem?

> +static inline void ha_start_timer_jiffy(struct ha_monitor *ha_mon, enum envs env,
> +					u64 expire, u64 time_ns)
> +{
> +	u64 passed = ha_get_passed_jiffy(ha_mon, env, expire, time_ns);
> +
> +	mod_timer(&ha_mon->timer, get_jiffies_64() + expire - passed);
> +}

I don't understand this "passed" thing. I see this function being called
in ha_setup_invariants() of stall monitor. Stall monitor is validating
that the task does not stay in "enqueued" state for more than
"threshold_jiffies". If so, what is the purpose of "passed"? From my
understanding, it should be just 

static inline void ha_start_timer_jiffy(struct ha_monitor *ha_mon, enum envs env,
					u64 expire, u64 time_ns)
{
	mod_timer(&ha_mon->timer, get_jiffies_64() + expire);
}

what do I miss?

Nam

