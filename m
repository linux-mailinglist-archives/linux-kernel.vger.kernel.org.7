Return-Path: <linux-kernel+bounces-784454-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E24DAB33C23
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 12:06:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E5F0518908A8
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 10:07:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11E9F2D97BD;
	Mon, 25 Aug 2025 10:06:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="K0BB1y3A";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Pkeg4IQY"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2613C2D3A69;
	Mon, 25 Aug 2025 10:06:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756116397; cv=none; b=ZkUYRC5T6ZXb+3zSoAZbI/NkIEoZfVH8l0dQH1IInNsyeOkF9l1uAz4vzh3r+YxPeMbZlmrre9xajXkOo3IDlbHMislI93iCOrqk154NrGsP7kHtV5VbYCCzKULF6eBBb9jeIaMY8nq+YxJhoNHKterzkmnWapZZqk82KrEZQA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756116397; c=relaxed/simple;
	bh=ovBPuF4X5ABp0nuv52TJYGVcRNTqkSGYkjl/JQsyAlg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pH5zdEuZmOVbnqPljU1zegy4+3atJhsEQZivT815CrgR2JlwMhOduoR3rmmwM0UCZROJlkRgOFrg9zhI679QEf0XJpF81yPeC3N80XTeFsHaRWOlvKYkhGO8yEOPSSzkbapD8NObFGsqhezhJGcFMrRrwPasNi8+APMf7mdiJ0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=K0BB1y3A; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Pkeg4IQY; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 25 Aug 2025 12:06:31 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1756116392;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hBX/CMBtB58CvR7/q9l30OpA0bAkfhgvc3RLehTnQPY=;
	b=K0BB1y3AHrqrj1/KLL6SZsDN0GoEKWnyEpBQfmXhhgw3dshM3SwNaWAysTRuNQge6x4C1L
	n2OM8aehvgtLbiaEOqOQqpKQyz1p/hXcb+w9KqWISMzQx86/Almf5TR/AoJhX45E1j/NNd
	LAW8mlVgwCBPUsMh4Z+VE+K6fDeeXt849IlYO11jUTjHK26FwHMafuJvKa9CH++QquJJm7
	WuS0CnGgfxyxWwdGKyzhE2lHa946s8knDXYWKJCFcWxKHrfiKDUgBE8iWKXiVjlrCt6HwR
	6POqGuAd0KBmkhwNxAIMkMQiBB30jBN7RGIwb8RcPratMcEqcz3dAS+vI6081w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1756116392;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hBX/CMBtB58CvR7/q9l30OpA0bAkfhgvc3RLehTnQPY=;
	b=Pkeg4IQYxwdsiYDYCA8KNWfu5+TnWGKBJfkIj2APdMg+CPI4/bRnBx/32Kx7jZwzySuSQV
	Ozd4oUTJ2ubQZ9BA==
From: Nam Cao <namcao@linutronix.de>
To: Gabriele Monaco <gmonaco@redhat.com>
Cc: linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
	linux-trace-kernel@vger.kernel.org,
	Tomas Glozar <tglozar@redhat.com>, Juri Lelli <jlelli@redhat.com>,
	Clark Williams <williams@redhat.com>,
	John Kacur <jkacur@redhat.com>
Subject: Re: [RFC PATCH 10/17] verification/rvgen: Add support for Hybrid
 Automata
Message-ID: <20250825100631.uTAyvLwP@linutronix.de>
References: <20250814150809.140739-1-gmonaco@redhat.com>
 <20250814150809.140739-11-gmonaco@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250814150809.140739-11-gmonaco@redhat.com>

On Thu, Aug 14, 2025 at 05:08:02PM +0200, Gabriele Monaco wrote:
> +    def fill_constr_func(self) -> list[str]:
> +        buff = []
> +        if self.constraints:
> +            buff.append(
> +"""/*
> + * This function is used to validate state transitions.
> + *
> + * It is generated by parsing the model, there is usually no need to change it,
> + * unless conditions were incorrectly specified

If the conditions were incorrectly specified, then they should be fixed in
the automaton, not fixed in this generated C code.

> or too complex for the parser.

Do you have examples of these "too complex" cases? Is there a plan to
handle them?

> + * If the monitor requires a timer, this function is responsible to arm it when
> + * the next state has a constraint and cancel it in any other case. Transitions
> + * to the same state never affect timers.
> + */
> +static bool ha_verify_constraint(struct ha_monitor *ha_mon,
> +\t\t\t\t enum %s curr_state, enum %s event,
> +\t\t\t\t enum %s next_state)
> +{
> +\tbool res = true;
> +""" % (self.enum_states_def, self.enum_events_def, self.enum_states_def))
> +            buff += self.__get_constr_condition()
> +            buff += self.__get_state_constr_condition()
> +            buff.append("""\treturn res;
> +}\n""")
> +        return buff

Nam

