Return-Path: <linux-kernel+bounces-865084-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8175FBFC372
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 15:40:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4E0895E7E57
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 13:31:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52F0233FE23;
	Wed, 22 Oct 2025 13:31:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2Rivw26z"
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57AA726ED42
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 13:31:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761139869; cv=none; b=imo2p+4Gsl3Hr0UJnOOqGfguLQdt5NAYSGSgclxoA5yiq70TutsXAAHvrveEsPCSqFiPjThaMbdgn5GVUpwvxvw2+VFyu38EKikV/JIHML2lROWlyIcu2IKQQKPH7MP1F5fdczO6U4urfmlJQwoNYY8quyb0yY1Nw2IxzXVcN1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761139869; c=relaxed/simple;
	bh=sel1HJtAS2O29cIWNqiKkkEz1pxvKt1v3uFl2gMTlX8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=lN3IBTw97G8RrvL2wPK8X0VTfxL7suqUti86GmLzC3lbuPoSV5/XgzAToziHUJNhVZ1T+alGSi/DLuejv5sTTRoXuEjEgbqvMqEVCwVvSxQ13EJ9zA5zD2DEUaSyAw8q8kKfXmyQkaoyEIMpjfKYdBa1CX/07zSjdh1LyMVnqDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=2Rivw26z; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-28a5b8b12bbso173796385ad.2
        for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 06:31:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761139867; x=1761744667; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=h3wO07hafJRdUwd+XoJw2gU8nsUOjd7xuiaFKufh6dM=;
        b=2Rivw26zoT07dXFGuU99Fc+QhnBrGwbiLUYizEKB7oQ6PNQ9BMBi4l+vDveb67b+Ev
         COvxyMwcOLlnsbmZtlUJBISItyQwxbSOuLNfM5l4xN/K26VllUAaVDuNYvK/njBc3IJs
         O/1BuIl4e+Rt2hCr3Fsc4zb/8X2rS/RC7HOVnzbIX35BhzFPwWN+xUHbKU2Wy1mkHG/x
         j1fiGh8grMOs6z0SmthoLFCSQkyACfM55QAPtTmCFJXqyt2aPIbCgGMmzuqAk2CeTKHi
         38GMYuOqVMVhlm+yPZaPGESVW+4JEne56d+1WSH58uz7HmtbqGHWcKLXp6K42/PeV1bK
         v/5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761139867; x=1761744667;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=h3wO07hafJRdUwd+XoJw2gU8nsUOjd7xuiaFKufh6dM=;
        b=N2BbAjFhROeYN4C1C46KBNMWeNa3tLwZw4BzKHTfWCn4H2PXS53tB11FkeOmh1vuOS
         pLJtunFdeJcgRq6x/ZuWDc4jGCjMTTAHlKxHhkkZcT0szCifh/Xp5tcbFll+UoCIWoNZ
         JS3Z6WKXyySS6/buIc2vXkDvlmUhACnoqjqNPC1kWZOhn42iceOzFBTT3XeGk3ngHsYZ
         79EYc4+UvUeOLF4vPfDGsMuAZwLzZveAbPmwWyICzFGDktXIxbaazWovuok1CGfOMbQe
         mj7F8ooalE2LN12MYJbtOrjamHo/890kMENXUqaPN+MhUY9UvIQsaWw3nBx4ZEQW9Ozj
         t8og==
X-Gm-Message-State: AOJu0YwtIOGYIM1ADUBnqSuHq8ijlV3v558Xx+xMQfdRH8mc11DBqwwK
	jQgwdFntbAwsA8gbu1xE/ICZleYzdH8LFnb2CtMjzl6UwwumDB6mWNQMWgOD9pF5aBz03V0nF5H
	Hm3cztA==
X-Google-Smtp-Source: AGHT+IGJIc5VeJ0Kn0KHRl1biYqCs1Kr1sT+eUo6DoK17Mdbvu7kTK5JgmVyg0c8Pu9nxDAlhxIns2nxqs0=
X-Received: from pjsi1.prod.google.com ([2002:a17:90a:65c1:b0:33e:2d15:8e39])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:19f0:b0:269:6052:3536
 with SMTP id d9443c01a7336-290cbc3e8b8mr236260295ad.45.1761139867555; Wed, 22
 Oct 2025 06:31:07 -0700 (PDT)
Date: Wed, 22 Oct 2025 06:31:06 -0700
In-Reply-To: <20251022121942.971014155@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251022121836.019469732@linutronix.de> <20251022121942.971014155@linutronix.de>
Message-ID: <aPjcmhnOm1R-9euo@google.com>
Subject: Re: [patch V5 25/31] rseq: Rework the TIF_NOTIFY handler
From: Sean Christopherson <seanjc@google.com>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>, Michael Jeanson <mjeanson@efficios.com>, 
	Jens Axboe <axboe@kernel.dk>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Peter Zijlstra <peterz@infradead.org>, "Paul E. McKenney" <paulmck@kernel.org>, x86@kernel.org, 
	Wei Liu <wei.liu@kernel.org>
Content-Type: text/plain; charset="us-ascii"

On Wed, Oct 22, 2025, Thomas Gleixner wrote:
> ---
>  include/linux/rseq_entry.h |   29 +++++++++++++++++
>  kernel/rseq.c              |   76 +++++++++++++++++++--------------------------
>  2 files changed, 62 insertions(+), 43 deletions(-)
> --- a/include/linux/rseq_entry.h
> +++ b/include/linux/rseq_entry.h
> @@ -368,6 +368,35 @@ bool rseq_set_ids_get_csaddr(struct task
>  	return false;
>  }
>  
> +/*
> + * Update user space with new IDs and conditionally check whether the task
> + * is in a critical section.
> + */
> +static rseq_inline bool rseq_update_usr(struct task_struct *t, struct pt_regs *regs,
> +					struct rseq_ids *ids, u32 node_id)
> +{
> +	u64 csaddr;
> +
> +	if (!rseq_set_ids_get_csaddr(t, ids, node_id, &csaddr))
> +		return false;
> +
> +	/*
> +	 * On architectures which utilize the generic entry code this
> +	 * allows to skip the critical section when the entry was not from
> +	 * a user space interrupt, unless debug mode is enabled.
> +	 */
> +	if (IS_ENABLED(CONFIG_GENERIC_IRQ_ENTRY)) {
> +		if (!static_branch_unlikely(&rseq_debug_enabled)) {
> +			if (likely(!t->rseq.event.user_irq))
> +				return true;
> +		}
> +	}

This can be:

	if (IS_ENABLED(CONFIG_GENERIC_IRQ_ENTRY) &&
	    !static_branch_unlikely(&rseq_debug_enabled) &&
	    likely(!t->rseq.event.user_irq))
		return true;

> +	if (likely(!csaddr))
> +		return true;
> +	/* Sigh, this really needs to do work */
> +	return rseq_update_user_cs(t, regs, csaddr);
> +}
> +
>  static __always_inline void rseq_exit_to_user_mode(void)
>  {
>  	struct rseq_event *ev = &current->rseq.event;

