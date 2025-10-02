Return-Path: <linux-kernel+bounces-839736-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC201BB2484
	for <lists+linux-kernel@lfdr.de>; Thu, 02 Oct 2025 03:37:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 989861C64E2
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Oct 2025 01:37:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 125CD135A53;
	Thu,  2 Oct 2025 01:37:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VuBLd/tD"
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B13F5A59
	for <linux-kernel@vger.kernel.org>; Thu,  2 Oct 2025 01:37:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759369068; cv=none; b=kg2Sbss8I9wgQWy5s7VvkAopDRlBhBGCNRUKwqLBzyE2vLUdpmK6SPJXbizSpCndovsyg5J4OswDllux7P0AIRndPX2jpd4avqDpWQWGpifF9HBhUXP9yDnRdOKCbzh/vI5LlEQ73SI5qMVr+LSoqAsAn3e70zrhTxeXIukmP28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759369068; c=relaxed/simple;
	bh=LMkdtzViwyUWMomnf2k71aZvoLTDVva+cK4Gpdmjgsc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WrIa7ZwbmpFXpI1cRoFpJAs+kOEhJfYpfzW6/46Y1CqFp6H7fL+OVLPJKwm+1NYuMYlWg4cDTFxClu7T5eSEX6GFYMp6LdrllJ5vRoaqV0huLqQYOUNb5dADtt1sazpwQesmgR9HnR23KbEXFA1We08Qn2aL0TDz/+imoSaPLyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VuBLd/tD; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-3ee64bc6b85so365728f8f.3
        for <linux-kernel@vger.kernel.org>; Wed, 01 Oct 2025 18:37:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759369065; x=1759973865; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rUsweFKMStD+GhCJN1r57gPem6qJDj51RqfNuzsKQug=;
        b=VuBLd/tDYORyI7Bt8BAx0cGUYieMhOqDJ4Ao7sdwMxlb5dgiqRplbDtIP/9YogEYuA
         569tfsf0vrnU3sDLFgk/8HPcWqhqqaeNLadfhy0Q7KWaJrOGQcdRuGCs6cQMdqe+hUGO
         e3WdCY0hVk9xrPi6L+ukrg9oIN376fWjIaHmf3mrQ/cxZN/iEKkhlIuwOYJPE+S6OC8t
         2J5XMQ5HFb0+pfwiM9rDjClSMHN58m6edChYSPOfo9NjFpSqXIKi2KmOOiHLTAluqBBt
         eWaWibRmOggOLHEXoYZBpu8hqidinmJIEIQM+cXQSm4s8zAQXHy9Pr6X2mbgjWxfMilD
         pPPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759369065; x=1759973865;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rUsweFKMStD+GhCJN1r57gPem6qJDj51RqfNuzsKQug=;
        b=WpPm5Jg+FHdUGAVvNEWZAmuSYgW9TxfNNWpFi/+hiG25dlVvI7f0roHmC2tby+TGuS
         so7R7RCMbYrXaLyMtHcH2DZT4R6yO8cA2mKua9qJH9ZQENLN7vvjNrnF/kMVmTamhQD4
         kefR4iDlQ+BDYdH1eaq+E+upveLWLQZ9Ui4Sb3pptN+8qiGPUjhPTVUEfV7JOsMPNxAo
         xIyskGe+5w+zPWQaJXGZjrGDjEt1VHkAWnuLefrtwXOrGZMjQAgKVsJEvcoZAQBqloG6
         bqJEszSk4Y5fNoh/0YPtH+ezzfrkxNDzgb5XrfrHyyQkrIHCzpfyT9yWEWfzP/QyHnIx
         Qvfw==
X-Forwarded-Encrypted: i=1; AJvYcCWY3XcSjRVHd0MAOYfMTY8ZB4Jd5QPHPmACM+qp/FlW8obU9CJ2xmUdtTqWM4Rku0B5GH5hAs1iZAuV+og=@vger.kernel.org
X-Gm-Message-State: AOJu0YwAeZJt2GCcYMfvqNVbqTIEXVcL3yvveiQxq2klWFZAcWxbIp/V
	PY7+vY8//EJP0lMudqJt1mNclSEFPNhTQkPHggr0ub0EQHH0Mwa9V4IQjxni+jHNQNSht38NE4a
	CTGhVRiYuPy75uo6t0Wk5UDges/Bx9p8=
X-Gm-Gg: ASbGnct6Fiv16p0PB5VT+cpYwjH5lfbbmYpHmmVq7RCZba41wK5fjJQvqGspCx5JUk4
	QXH8gVD6ehjcxoek1cVC1mWh9VmD7SpWZLwlvqsJRwqrGB/1P/XwNUL4oFFJpvGvD3qTxOCTMeL
	4z+IsQbM2NhDdZK8nUCGMpmnCUQCltk1JrPgWDtbIn6tYO+PVok8kHpUQ/lY6YiTsDzJ33Nlrz2
	5qg3AX7FkbnTrcaGJ/rcfG2g4ESjdOkhmetkO0iyboUsE7sjguCqjBohCnC
X-Google-Smtp-Source: AGHT+IG/dN6zvZqsW0OdR7QDCo1V90vHvvKNaxbAtuxb51eq9XzcaiuivECud599UAl62Cb3osddY+RXONgelTJz0k4=
X-Received: by 2002:a05:6000:401f:b0:3ea:fb3d:c4cb with SMTP id
 ffacd0b85a97d-4255781ec0cmr4273967f8f.56.1759369064909; Wed, 01 Oct 2025
 18:37:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <7fa58961-2dce-4e08-8174-1d1cc592210f@paulmck-laptop> <20251001144832.631770-8-paulmck@kernel.org>
In-Reply-To: <20251001144832.631770-8-paulmck@kernel.org>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 1 Oct 2025 18:37:33 -0700
X-Gm-Features: AS18NWBgVlCvZ9l0ZgunWqeXdx6ozQ63phiSdeymw8QQUjFb87BpmWz9Dq8KGY4
Message-ID: <CAADnVQLozKuSPMe4qUDxCV6pCSQ=rQNKy524K7R=uM5yTpLV0Q@mail.gmail.com>
Subject: Re: [PATCH v2 08/21] rcu: Add noinstr-fast rcu_read_{,un}lock_tasks_trace()
 APIs
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: rcu@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, 
	Kernel Team <kernel-team@meta.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 1, 2025 at 7:48=E2=80=AFAM Paul E. McKenney <paulmck@kernel.org=
> wrote:
>
> +static inline struct srcu_ctr __percpu *rcu_read_lock_tasks_trace(void)
> +{
> +       struct srcu_ctr __percpu *ret =3D __srcu_read_lock_fast(&rcu_task=
s_trace_srcu_struct);
> +
> +       rcu_try_lock_acquire(&rcu_tasks_trace_srcu_struct.dep_map);
> +       if (!IS_ENABLED(CONFIG_TASKS_TRACE_RCU_NO_MB))
> +               smp_mb(); // Provide ordering on noinstr-incomplete archi=
tectures.
> +       return ret;
> +}

...

> @@ -50,14 +97,15 @@ static inline void rcu_read_lock_trace(void)
>  {
>         struct task_struct *t =3D current;
>
> +       rcu_try_lock_acquire(&rcu_tasks_trace_srcu_struct.dep_map);
>         if (t->trc_reader_nesting++) {
>                 // In case we interrupted a Tasks Trace RCU reader.
> -               rcu_try_lock_acquire(&rcu_tasks_trace_srcu_struct.dep_map=
);
>                 return;
>         }
>         barrier();  // nesting before scp to protect against interrupt ha=
ndler.
> -       t->trc_reader_scp =3D srcu_read_lock_fast(&rcu_tasks_trace_srcu_s=
truct);
> -       smp_mb(); // Placeholder for more selective ordering
> +       t->trc_reader_scp =3D __srcu_read_lock_fast(&rcu_tasks_trace_srcu=
_struct);
> +       if (!IS_ENABLED(CONFIG_TASKS_TRACE_RCU_NO_MB))
> +               smp_mb(); // Placeholder for more selective ordering
>  }

Since srcu_fast() __percpu pointers must be incremented/decremented
within the same task, should we expose "raw" rcu_read_lock_tasks_trace()
at all?
rcu_read_lock_trace() stashes that pointer within a task,
so implementation guarantees that unlock will happen within the same task,
while _tasks_trace() requires the user not to do stupid things.

I guess it's fine to have both versions and the amount of copy paste
seems justified, but I keep wondering.
Especially since _tasks_trace() needs more work on bpf trampoline
side to pass this pointer around from lock to unlock.
We can add extra 8 bytes to struct bpf_tramp_run_ctx and save it there,
but set/reset run_ctx operates on current anyway, so it's not clear
which version will be faster. I suspect _trace() will be good enough.
Especially since trc_reader_nesting is kinda an optimization.

