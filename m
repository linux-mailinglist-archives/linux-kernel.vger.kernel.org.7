Return-Path: <linux-kernel+bounces-884762-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id A97EEC310AA
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 13:45:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C2E6D4E9868
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 12:45:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EC35212542;
	Tue,  4 Nov 2025 12:45:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kDXsodId"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5C215789D;
	Tue,  4 Nov 2025 12:45:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762260335; cv=none; b=PRjdfvARjRGbfgavrobj5iog1F/zB9xIXlTdlAHfuky5XUVumso6JxZsl2ARmESQba+ethnjsWc5pT9hUujDCQ7K/mS95KI/K43WyzOBec0FzJjEnEljkb9wnWR649Q65T/Q1nG4aRQ6Xw4bXES82HbiB0QxnSVvLDK82Z3PKsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762260335; c=relaxed/simple;
	bh=weQp7YKscYs55DPdc8KYB4FS7Y2EgyNmky01+EGG6e8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=U0vrDeTUBh9eDI/pWnq4darTbm2N5VDU9Sn5t9yuGnAbzMQQjAiNTUTqYYXMlCpVXnqLC80CVT4vBmmiHAkTmtiSAkFLljvxVGaL8iLiizfA+SCR2200xtodYlmrEWi4/YqzRkKCpQepEZAyaQYcXn0oTfW40NKP7eADwKDN15c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kDXsodId; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2758C116C6;
	Tue,  4 Nov 2025 12:45:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762260335;
	bh=weQp7YKscYs55DPdc8KYB4FS7Y2EgyNmky01+EGG6e8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=kDXsodIdVRsdEPRidfCu4meBFHuWVJB963Qpg7kdaOaSj8Xf3hAGgWZP4fYnbJ8Am
	 G1Ccxljaitngi/zvAIWlQgf5KlvbWiz6eVUSFRJ8YrtuOqDddmlH2vhwHdsDyvjq73
	 Nl+eAvVMMhzQlbVlUQJYq4IKpbuwE0HdHrqkYEZzRMxRtrQve4lAsW3LCbuO/7agsj
	 LYpiUYfaNUBcLtZUfgk4QJ3nC7Z8p0/vlq4tVr8rwfDUsDT2DAYPTQTHtWbrbS2/jq
	 wiL4FogITtIb76ocYSMVC+Hn1UTAaBAozJu9mKS7Gj7c//ZoHh8DFLWAoQdAjEAyNP
	 q/Fpt+1gteHrg==
From: Andreas Hindborg <a.hindborg@kernel.org>
To: Lyude Paul <lyude@redhat.com>, rust-for-linux@vger.kernel.org, Thomas
 Gleixner <tglx@linutronix.de>, Boqun Feng <boqun.feng@gmail.com>,
 linux-kernel@vger.kernel.org, Daniel Almeida
 <daniel.almeida@collabora.com>
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 Juri Lelli <juri.lelli@redhat.com>, Vincent Guittot
 <vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, Mel
 Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>, Will
 Deacon <will@kernel.org>, Waiman Long <longman@redhat.com>, Miguel Ojeda
 <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Gary Guo
 <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn?= Roy Baron
 <bjorn3_gh@protonmail.com>, Benno
 Lossin <lossin@kernel.org>, Alice Ryhl <aliceryhl@google.com>, Trevor
 Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, David
 Woodhouse <dwmw@amazon.co.uk>, Sebastian Andrzej Siewior
 <bigeasy@linutronix.de>, Joel Fernandes <joelagnelf@nvidia.com>, Ryo
 Takakura <ryotkkr98@gmail.com>, K Prateek Nayak <kprateek.nayak@amd.com>
Subject: Re: [PATCH v13 05/17] irq & spin_lock: Add counted interrupt
 disabling/enabling
In-Reply-To: <20251013155205.2004838-6-lyude@redhat.com>
References: <20251013155205.2004838-1-lyude@redhat.com>
 <20251013155205.2004838-6-lyude@redhat.com>
Date: Tue, 04 Nov 2025 13:45:20 +0100
Message-ID: <878qgm7yqn.fsf@t14s.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Hi Lyude,

Lyude Paul <lyude@redhat.com> writes:

> From: Boqun Feng <boqun.feng@gmail.com>

<cut>

> diff --git a/include/linux/irqflags_types.h b/include/linux/irqflags_types.h
> index c13f0d915097a..277433f7f53eb 100644
> --- a/include/linux/irqflags_types.h
> +++ b/include/linux/irqflags_types.h
> @@ -19,4 +19,10 @@ struct irqtrace_events {
>  
>  #endif
>  
> +/* Per-cpu interrupt disabling state for local_interrupt_{disable,enable}() */
> +struct interrupt_disable_state {
> +	unsigned long flags;
> +	long count;

Is this `count` field dead?

> +};
> +


Best regards,
Andreas Hindborg



