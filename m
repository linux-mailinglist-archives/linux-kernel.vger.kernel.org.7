Return-Path: <linux-kernel+bounces-825767-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DB62B8CC7F
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Sep 2025 18:01:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D43AC3BF05A
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Sep 2025 16:00:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D77828DB3;
	Sat, 20 Sep 2025 16:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZS3g0djW"
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8D14223707
	for <linux-kernel@vger.kernel.org>; Sat, 20 Sep 2025 16:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758384044; cv=none; b=l5HT6miQtZW1WjRESJ/AcODdGuKYa9VbzUO0Wm6NC/ywdolF/K/x196eWRet6R291Tb6+SuDAst/VeXuAId7VyZroyssUS57GFyoh3SXfithPygZwilOPPmVVLBLG3UBclNb7CosA5okkkPxwsknTldI+VNOadtumO9IqGdNFP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758384044; c=relaxed/simple;
	bh=0FXSiX8LV1vGBvynLmEYz4qPHdBcTqMHOixN5CzoCzA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FQ3FT0V8MmtTLQZEmT+ZNpcrVnmhQdKdtrH99C7ft3FnYhX3zOcN+6Dt4+8D5n+WJujKkcg/AOj2PZY021LjT9b6r21E58PomhuWw+oG6T4Ke/6HSh4/OE1mdfiVCEvUi6+wxtX2iAAqbUHW1wGKBp59KFUukyNgNQiTDmqR5RI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ZS3g0djW; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-62fbd0a9031so2835541a12.0
        for <linux-kernel@vger.kernel.org>; Sat, 20 Sep 2025 09:00:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1758384039; x=1758988839; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=6bGBwhqJX9F0xOuCnvuuNe/MoHdsR7Bf1qZLNoNX5Qk=;
        b=ZS3g0djW0jR7JfMIJpNFpMiCo2l9HKrn2Zi8SbeP2K1Ltvv6LAm8VQ5EGwXsgJVaT5
         K84LjxLJb9obJ90J1gpQtpK2BY58Tqlz4JA5F4xcKGFSakm9mp+m95WHYRmG0WJSdQMX
         N6/xVrC46qLXWRoyqCRTxOp/SZuacMW1QKQDG6x7Zp6/cHETwhz9Q6kgRFT+xVwBn1CJ
         k2Q/vlWINIFkbSBoibgqMkHwSv3KN0cHm6yLggeb0xpwpv8Hebed8zJd8FKtQNkB1JrX
         XZyC5KTIFEFlRcydTic6AagLqi4KiefJwzg1ircy8uYD+G4rgs9KGGZLr5vFTwM85Opm
         FfOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758384039; x=1758988839;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6bGBwhqJX9F0xOuCnvuuNe/MoHdsR7Bf1qZLNoNX5Qk=;
        b=Ese5ca1m57tISBknWd0tvifXm1FIDVxtrrZ0mXqfnuu8GqwYQdI0QyLTj0q2yNG28f
         evA0kXMjZjVD7GbFkkgnHIAHX6wFUvDEs8IraKYR1mJcAW9Omt9BReAxseVRD8O6I20x
         X3TM2GEzXCiFwNLYkmxmTfnDNHHv2ECRBk8DPPMPHfiuk81O1VvwGNAYZ1tU0Lw1Aq+v
         hfmsJCQJOuQFRudHUnG0rTLHHmcCo1b2IhJ+Tgv1kqxw4E6lhanqPHzBn81Br6gAyrJ1
         7jBDVJP3U6Gc8njDzTjTaboQcNi+PYU7rE94sdtTW8ZxzllJ7UGNwGjt/CIOjcQlCwxp
         idpA==
X-Gm-Message-State: AOJu0Yy586trgY4cDcOh6/L1EpCZm7Wwqx2UUgCiq5IntPDhbJz4SXWn
	BgRD/7uyl8y6XDn6QOYnc7I+t/oSGcko44H2zDPy8tKHU6Id6nanDWHYnWIiBXxXfzJX9l5gSz4
	jCHA5nnwJQuBUwpmu0N7BBSm+xUcxKjx1yWROkCtZmEax5EziYU+uT/g=
X-Gm-Gg: ASbGncu1rRJ9X0tiHYUmjB2qWHpe67Om9wiK+NxN4Vdwvl8we7jvSRtTzPFMKxNETy0
	db7xQg1jhJ62V6nxIYwskG0umBpUsP1MkqTfqah7T1n7m0pVUzRMs0Wl5xi2gkzdI3hVQaBzg6Y
	jx6rvmWdTiuOY1dUasPjpVp6OI8cLWe7+oLjtIQP7lcuCeC8amwe4aSEcsfWmwb9ii+3Hs1T/bd
	auLPPAzjVpPJw1SQK2cs9bn2J8NWgEYL/Gw
X-Google-Smtp-Source: AGHT+IGhUL+kILCgvIy42z2qBJz3nD98fFtf16ENDJwDcWGqNqZPLpWOf/WplU4dCmobMVHp3dmQfvBSGbyb8aaZ16k=
X-Received: by 2002:a05:6402:208a:b0:62f:31f6:6aac with SMTP id
 4fb4d7f45d1cf-62fc0a7b1e0mr6728772a12.23.1758384038519; Sat, 20 Sep 2025
 09:00:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAKfTPtBp85jaM8sdOXqB1Fq7XcfgGP-T2A=fd4Qbhe48CUNUGA@mail.gmail.com>
In-Reply-To: <CAKfTPtBp85jaM8sdOXqB1Fq7XcfgGP-T2A=fd4Qbhe48CUNUGA@mail.gmail.com>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Sat, 20 Sep 2025 18:00:26 +0200
X-Gm-Features: AS18NWCZwxYmt0CLn-uDv8qhYWdHHmD_8uweCDgoyxFrcUPIiuRHE3oZNODkeAQ
Message-ID: <CAKfTPtBKB41LyyfSDm7RK=gbDt3JjY_k8SJAALxQzxGACEp+ig@mail.gmail.com>
Subject: Re: Call for Speakers: Join us at the Scheduler and Real-Time
 Microconference at LPC2025!
To: linux-kernel <linux-kernel@vger.kernel.org>, linux-rt-devel@lists.linux.dev
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
	Juri Lelli <juri.lelli@redhat.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, 
	Valentin Schneider <vschneid@redhat.com>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
	Clark Williams <williams@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, 
	John Stultz <jstultz@google.com>, K Prateek Nayak <kprateek.nayak@amd.com>, 
	Phil Auld <pauld@redhat.com>, dhaval@gianis.ca, Aaron Lu <ziqianlu@bytedance.com>
Content-Type: text/plain; charset="UTF-8"

Hi everyone,

Just a friendly reminder that the Call for Proposals for the Scheduler
and Real-Time Microconference at Linux Plumbers 2025 closes on Sept
30th, 2025.

We're looking forward to receiving your proposals!

Best regards,
The Scheduler and Real-Time Microconference Team
- Dhaval Giani <dhaval.giani@gmail.com>
- Juri Lelli <juri.lelli@redhat.com>
- Phil Auld <pauld@redhat.com>
- Steven Rostedt <rostedt@goodmis.org>
- Vincent Guittot <vincent.guittot@linaro.org>

On Mon, 18 Aug 2025 at 20:31, Vincent Guittot
<vincent.guittot@linaro.org> wrote:
>
> Hello everyone,
>
> We're pleased to announce that the Call for Topics for the upcoming
> Scheduler and Real-Time Microconference at Linux Plumbers 2025, is
> open!
>
>     https://lpc.events/event/19/sessions/218/
>
> This event is designed to gather kernel developers and engineers to
> share knowledge on scheduler and/or real time issues in Linux and
> connect with peers. This year, we are joining the tightly linked
> Real-Time and scheduler topics in one same microconference.
>
> We're particularly interested in talks that:
>
>     - Spark Discussion: The goal is to discuss open problems,
> preferably with patch sets already on the mailing list.
>
>     - Are Concise: Presentations are meant to be limited to 2 or 3
> slides intended to seed a discussion and debate.
>
> Some possible topics for discussions:
>
>     - Improve responsiveness of fair tasks
>     - Improve PREEMPT_RT
>     - Improve Locking and priority inversion
>     - Impact of new topology, including hybrid or heterogeneous system
>     - Improvements on SCHED_DEADLINE and DL server
>     - Tooling for debugging low latency analysis
>
> It is also perfectly fine if you have a new topic that is not on the
> list above. People are encouraged to submit any topic related to
> real-time and/or scheduling.
>
> Ready to submit? Please fill out the submission form by
>
>     Sept 30th 2025
>
> at this link:
>
>     https://lpc.events/event/19/abstracts/
>
> and select
>
>     "Scheduler and Real-Time MC" as the track.
>
> We can't wait to see your proposal and build a fantastic lineup together.
>
> If you have any questions, don't hesitate to reach out.
>
> Best regards,
>
> The Scheduler and Real-Time Microconference Team
> - Dhaval Giani <dhaval.giani@gmail.com>
> - Juri Lelli <juri.lelli@redhat.com>
> - Phil Auld <pauld@redhat.com>
> - Steven Rostedt <rostedt@goodmis.org>
> - Vincent Guittot <vincent.guittot@linaro.org>

