Return-Path: <linux-kernel+bounces-825010-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17AF4B8AB39
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 19:08:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 322387AB394
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 17:06:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98D0C321441;
	Fri, 19 Sep 2025 17:07:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Pkqlk/jV"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 495BE25C804
	for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 17:07:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758301668; cv=none; b=J+drda6WJrI77IzwbxozQ7WcmNUkSXH46PGa+RmQmgYQaQpA1PTXdKIfPq4NN3/vPe1wjBRRNfctZaCuMSyusc/Zo/nRyROs8Ypng67x43pt5MlsotjRFDZ7krEPywMvUm3JXWf2Qlse89soYVoSXgLgoXQjQqOP6He+wfrphjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758301668; c=relaxed/simple;
	bh=3qp6q9LRUoe6q3bo7J359SoUE/ClQLHaiAfa3bIxl3w=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=I1BcnCImglawq1HIsDVW7u4ZDCDkjdXJoTGMGSVompCWV6SVVFfxlYqSb8HXHujNeTe721dGY6xqP/TleX/9rdpsHpzc+ALwzbcaTInOIGvvonGJqjIeQlPEzwdhPAd+HXaTbtrNqJaQ+JffmltL0NkquyU0X2Ft/ogpKjf2xdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Pkqlk/jV; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758301665;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3qp6q9LRUoe6q3bo7J359SoUE/ClQLHaiAfa3bIxl3w=;
	b=Pkqlk/jVDqX6gVxD0Ax/qKSyHMqOMX3W4Nq2ZiYM3oZgCP9WqkrABDUPZ8j7rEZETBbP3e
	OrXoaVaghe0bP529Ad8DW1tPwULRwgHSKQSR1q+mII3r9lLFguhVfwLfX07Mln1qm5OU6y
	uI0DP+1XsWW6trPsXWpfJiWws7CaJ9s=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-417-47JwMH1aOEOOcSlRKpig9g-1; Fri, 19 Sep 2025 13:07:43 -0400
X-MC-Unique: 47JwMH1aOEOOcSlRKpig9g-1
X-Mimecast-MFC-AGG-ID: 47JwMH1aOEOOcSlRKpig9g_1758301662
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-3ed9557f976so2191633f8f.3
        for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 10:07:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758301662; x=1758906462;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=3qp6q9LRUoe6q3bo7J359SoUE/ClQLHaiAfa3bIxl3w=;
        b=CRlL+g7+b6gj8hP0keSUzMi3B1sFd6x48vf9fx8BVeefof0djszYlBoklbN4H5jBFy
         fFste2JLkqG2aJobPJy2QOsFCLMuCGoT2Tc3ymK24yT8T5E9Iu+hSzfiPiaJAiamg2OS
         GVbFX2HhEJXzAIJintmYcAAYHF5Nc9biatd8E4IVYzxvX7sKLqSGzlIHUztCNa3tyPMb
         Kqnuevd8eNgK4aUL5jlWJs35Q3yr8QAi8pzNJCUDw9hx9fkYnmweifR8vYACETMDky0A
         Su7enPhqfYfQ1vCMTPn8ZSqTOkWyu0VsTjR0uQE6vtXiEwVd38GtZ66M5mj+H56AeHsk
         5FuA==
X-Gm-Message-State: AOJu0YyF8yup8uU643+Z9vMaJlUgtxhqpOmof5NppsJYegBT2vx4l3q2
	c1ckYtLPyBBmyeeVundaG5jzdNWR68Dutu+gjbi+/PjtQDmqDAaH0EfOt/Yr3enFjXoS1zpnhCB
	jojx3aRfYTITgGSTksD/4A9ZQmC76CbzjxbmUZ34VFe/kY1G4PO4RwC0SIrt2ztLDBg==
X-Gm-Gg: ASbGnctFZ/eWdXaPV7UektS7DetYT5PPeLxw864NYgopPrPcJXh8g496fiqth57+Lfb
	6gHzno8lkcEpgDfhFZxxWpE9DSgNw6MijjY/gbayVlC+kLfYShTlleo98alJ2bS7OtzhP1u9sl/
	OYif3jtmK9fL12E/D+o7oVDQAa7B1MYEmkh37D9GXOuHm6TZyuJFf7ibPSp8sdrO7nvS5gwfPVO
	kqX9C6J9eDAXWt4NFxT8LF2OzNLeqkvcYHTBkOwPkOPdfL1lMi4flsfWETKdTqFFPsYE1gvlBdP
	miGpX4Wt6rcocYL8Kz2475AJCXKwnaShCvI9
X-Received: by 2002:a5d:64e5:0:b0:3ea:ac25:b6b9 with SMTP id ffacd0b85a97d-3ee7da56ff7mr2979534f8f.11.1758301662176;
        Fri, 19 Sep 2025 10:07:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFgsMyuWn2Qvd0H7mVqIwWFUhFqllortDrLxiWpPoSxTPoDr2zxCfkYtR+1fTUa0yG7RVSidw==
X-Received: by 2002:a5d:64e5:0:b0:3ea:ac25:b6b9 with SMTP id ffacd0b85a97d-3ee7da56ff7mr2979510f8f.11.1758301661712;
        Fri, 19 Sep 2025 10:07:41 -0700 (PDT)
Received: from [127.0.0.1] ([195.174.132.10])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3ee073f4669sm8270429f8f.4.2025.09.19.10.07.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Sep 2025 10:07:41 -0700 (PDT)
Date: Fri, 19 Sep 2025 17:07:14 +0000 (UTC)
From: Gabriele Monaco <gmonaco@redhat.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Nam Cao <namcao@linutronix.de>, Tomas Glozar <tglozar@redhat.com>,
	Juri Lelli <jlelli@redhat.com>, Clark Williams <williams@redhat.com>,
	John Kacur <jkacur@redhat.com>, linux-trace-kernel@vger.kernel.org
Message-ID: <7a446e09-4333-409f-bba1-246a27d91db8@redhat.com>
In-Reply-To: <20250919113749.7ee1f249@gandalf.local.home>
References: <20250919140954.104920-1-gmonaco@redhat.com> <20250919140954.104920-17-gmonaco@redhat.com> <20250919113749.7ee1f249@gandalf.local.home>
Subject: Re: [PATCH v2 16/20] sched: Export hidden tracepoints to modules
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Correlation-ID: <7a446e09-4333-409f-bba1-246a27d91db8@redhat.com>

2025-09-19T15:36:50Z Steven Rostedt <rostedt@goodmis.org>:

> On Fri, 19 Sep 2025 16:09:50 +0200
> Gabriele Monaco <gmonaco@redhat.com> wrote:
>
>> The tracepoints sched_entry, sched_exit and sched_set_need_resched
>> are not exported to tracefs as trace events, this allows only kernel
>> code to access them. Helper modules like [1] can be used to still have
>> the tracepoints available to ftrace for debugging purposes, but they do
>> rely on the tracepoints being exported.
>>
>> Export the 3 not exported tracepoints.
>> Note that sched_set_state is already exported as the macro is called
>> from modules.
>>
>> [1] - https://github.com/qais-yousef/sched_tp.git
>>
>> Signed-off-by: Gabriele Monaco <gmonaco@redhat.com>
>
> Note, for all the scheduler changes, we need an acked-by from the schedul=
er
> maintainers.
>

Alright got it.

> After you have acks and are satisfied with the code (hopefully someone el=
se
> can review them), you can send me a pull request to be added into linux-n=
ext.

Usually Nam does a very good job reviewing them.

> I'll still run them through my own tests.
>
> Which BTW, there should be a bunch of tests in:
>
> =C2=A0 tools/testing/selftests/verification/
>
> (which doesn't yet exist).

Yeah that's the next thing in my imaginary list, or perhaps something inspi=
red on what's done in rtla.

Thanks,
Gabriele

>
> -- Steve
>
>
>> ---
>> kernel/sched/core.c | 3 +++
>> 1 file changed, 3 insertions(+)
>>
>> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
>> index ccba6fc3c3fe..334ff5b214d7 100644
>> --- a/kernel/sched/core.c
>> +++ b/kernel/sched/core.c
>> @@ -117,6 +117,9 @@ EXPORT_TRACEPOINT_SYMBOL_GPL(sched_util_est_cfs_tp);
>> EXPORT_TRACEPOINT_SYMBOL_GPL(sched_util_est_se_tp);
>> EXPORT_TRACEPOINT_SYMBOL_GPL(sched_update_nr_running_tp);
>> EXPORT_TRACEPOINT_SYMBOL_GPL(sched_compute_energy_tp);
>> +EXPORT_TRACEPOINT_SYMBOL_GPL(sched_entry_tp);
>> +EXPORT_TRACEPOINT_SYMBOL_GPL(sched_exit_tp);
>> +EXPORT_TRACEPOINT_SYMBOL_GPL(sched_set_need_resched_tp);
>>
>> DEFINE_PER_CPU_SHARED_ALIGNED(struct rq, runqueues);
>>


