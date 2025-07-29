Return-Path: <linux-kernel+bounces-749314-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CF6CB14CCA
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 13:12:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C40315466CE
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 11:12:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1520628C2C1;
	Tue, 29 Jul 2025 11:12:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sZwjETJm"
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6472428B7EA
	for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 11:12:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753787534; cv=none; b=rfuOMkXK5XC3Q88Aj1d3+592/tHgLBV4QNU2VuaQUvzNiQHkH4eY11mLD1ASMf1/B+EH3MqMwcDFTrHpcqQOH5sJGmgXVVU7yOXDbN54LMy3JHC8kMi1+edgr+RqMajpPVyHZi6lPcDnbO5k5stCcReYrQMV2Z3uiFu764N4rbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753787534; c=relaxed/simple;
	bh=BVEnoilCFCG1f6yMCo064vRBjQwVBfWkMyhEmTCA+/8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HCu0bw7abG7tQMFiIJItWnhPkLR+oufgxPUNQgk83i29Vkj0V+zmuCcqAdmj4ptbPFrh6ZwRxA+oReM7xVk1iAGcDMKisSZEYvinoY3+gST2PSYN53CP2oV3E7BsJ7geaqV/ONP2HK3I7n9xXMl2AUW7r2f4ktu4SOF8nRZQmGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=sZwjETJm; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-32e14cf205cso53835321fa.1
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 04:12:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753787530; x=1754392330; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=/5LXLgdNoFY7nm3djrI3De1oD1rZPUM1dBdXIbzK2TE=;
        b=sZwjETJmd2U1oIby0H6jGLzHVTMPmCiHrUlzb54DB5Caid9TmChd/WSRRcCwtlAcLn
         nYwxXe4lwD1lVUqYTR+h5U2Jnr5tdSWoZIKv6Q1ljK+mc9t2sZQMGMgwLdk4BI68u58G
         7leHRV4AtyKbWSdrL08YmJx/Oo57tr0o18mAq+05wwWAF7KKf2CXYD12x0vcra00WoOM
         02I3qzjwTphaw+L76vMClqsQu4KH+MKLfp0VZ86+m1B9CpTkVZFw79f0pqGogRqN8OW5
         XViqpREbfdk8MUpOH6IakDmIpvy9IBDek1/hz9ZINOnukLdoOs1fwAiV4nlokJG/IP85
         2Mpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753787530; x=1754392330;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/5LXLgdNoFY7nm3djrI3De1oD1rZPUM1dBdXIbzK2TE=;
        b=N9ft8NYPFpF4sFPVtu0P4612p2yt/TP5+Rcer7KYVUrpEeYxbP5qIVviOZuyZwnkQa
         CkdvoXqRTZ7FY4Jrg2fM5OSprKmsNcV0BYCbAu50kIoT9sLyE+BjGd0AOfDWHNVJQHQJ
         rsGsS3NpWVAHCFKgwQB6+tIEzH0d3ygDworO8PJtyX4I8raP/shuB4L6+7aH76Oz1jlI
         E3zjIyLLeMXpbQLCCRa0TqutE2U5DmxnU45oDMgavPhDiR0yiHx/Jm4Uq8vc267xBQig
         2+x30VyqbK0xInoWTKLjozD8VqTy71YOrhq05NNPfbd2Cs9Ybb7a7we7fQKiturAHx88
         z+3w==
X-Forwarded-Encrypted: i=1; AJvYcCX1FGYxm6z49uobNagPQV56m5dJ0Nnh4qQnm8sel7XQA3aR4e8d0K6y6bqRgJrMZbo3G5xSwBcMjpAFgEo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyETN/qg9/dI1MpDR+imMsdUYy5SOivV05w7W6I0FB+izzR0ovH
	8YomZfe/YMbUfLJjOvpBGlv9S16iyHzVGwD5U+///XmiyNL/1XAGgum1DFTwblNmLZO+vWs8K9g
	R66gis1GKRZNysjpdYN0cLsaJh79plQJfPv0O1B4d
X-Gm-Gg: ASbGncvUZEvliYQ1jrq4XCh4PgRK5Dp+K/mLWqW+4TsquRJCqV3peWCsV92gpLIfSfl
	i5MtkTs89ssw3lcIPMX2ame2rTAj/Ntv+N4BdH2iGIufJxsLhVVO1utAXknJzmm5qolMW4Vhdwi
	S22L6CS22PKyAkpHRCCNEoeCoSMzr6A603hE7zxjFmFlo0rkV55JBWyQrNqvUb+ecbHbPSI3RfQ
	bxkZ96gt76TZ1uMDU5DhuwweNOFKN3dMiC/Xg==
X-Google-Smtp-Source: AGHT+IFp8j2hP56kQeHT0eONPfgXOmvNM+NIK9dYb+CST/EeQjHd0br5xtEoYO6t0zCdfUOUElG2RUzckBvMCeI44nQ=
X-Received: by 2002:a05:651c:1107:20b0:32c:a006:29d3 with SMTP id
 38308e7fff4ca-331ee66d357mr27919651fa.10.1753787530153; Tue, 29 Jul 2025
 04:12:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250728152548.3969143-1-glider@google.com> <20250728152548.3969143-7-glider@google.com>
In-Reply-To: <20250728152548.3969143-7-glider@google.com>
From: Dmitry Vyukov <dvyukov@google.com>
Date: Tue, 29 Jul 2025 13:11:58 +0200
X-Gm-Features: Ac12FXywcPyU53mFZ7Bl6gOazcF0D4j2xnZWgO3CWGRVf7fcxWsyg-cMguQJbC4
Message-ID: <CACT4Y+Ymd=7zQ-AYhEx93DpBZ89jVbdUM0pbN+2vPaiwKg-sdA@mail.gmail.com>
Subject: Re: [PATCH v3 06/10] kcov: add trace and trace_size to struct kcov_state
To: Alexander Potapenko <glider@google.com>
Cc: quic_jiangenj@quicinc.com, linux-kernel@vger.kernel.org, 
	kasan-dev@googlegroups.com, Aleksandr Nogikh <nogikh@google.com>, 
	Andrey Konovalov <andreyknvl@gmail.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, Ingo Molnar <mingo@redhat.com>, 
	Josh Poimboeuf <jpoimboe@kernel.org>, Marco Elver <elver@google.com>, 
	Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"

On Mon, 28 Jul 2025 at 17:26, Alexander Potapenko <glider@google.com> wrote:
>
> Keep kcov_state.area as the pointer to the memory buffer used by
> kcov and shared with the userspace. Store the pointer to the trace
> (part of the buffer holding sequential events) separately, as we will
> be splitting that buffer in multiple parts.
> No functional changes so far.
>
> Signed-off-by: Alexander Potapenko <glider@google.com>

Reviewed-by: Dmitry Vyukov <dvyukov@google.com>

> ---
> v3:
>  - Fix a warning detected by the kernel test robot <lkp@intel.com>
>  - Address comments by Dmitry Vyukov:
>    - s/kcov/KCOV/
>    - fix struct initialization style
>
> v2:
>  - Address comments by Dmitry Vyukov:
>    - tweak commit description
>  - Address comments by Marco Elver:
>    - rename sanitizer_cov_write_subsequent() to kcov_append_to_buffer()
>  - Update code to match the new description of struct kcov_state
>
> Change-Id: I50b5589ef0e0b6726aa0579334093c648f76790a
> ---
>  include/linux/kcov_types.h |  9 ++++++-
>  kernel/kcov.c              | 48 +++++++++++++++++++++-----------------
>  2 files changed, 35 insertions(+), 22 deletions(-)
>
> diff --git a/include/linux/kcov_types.h b/include/linux/kcov_types.h
> index 53b25b6f0addd..9d38a2020b099 100644
> --- a/include/linux/kcov_types.h
> +++ b/include/linux/kcov_types.h
> @@ -7,9 +7,16 @@
>  struct kcov_state {
>         /* Size of the area (in long's). */
>         unsigned int size;
> +       /*
> +        * Pointer to user-provided memory used by KCOV. This memory may
> +        * contain multiple buffers.
> +        */
> +       void *area;
>
> +       /* Size of the trace (in long's). */
> +       unsigned int trace_size;
>         /* Buffer for coverage collection, shared with the userspace. */
> -       void *area;
> +       unsigned long *trace;
>
>         /*
>          * KCOV sequence number: incremented each time kcov is reenabled, used
> diff --git a/kernel/kcov.c b/kernel/kcov.c
> index 8154ac1c1622e..2005fc7f578ee 100644
> --- a/kernel/kcov.c
> +++ b/kernel/kcov.c
> @@ -194,11 +194,11 @@ static notrace unsigned long canonicalize_ip(unsigned long ip)
>         return ip;
>  }
>
> -static notrace void kcov_append_to_buffer(unsigned long *area, int size,
> +static notrace void kcov_append_to_buffer(unsigned long *trace, int size,
>                                           unsigned long ip)
>  {
>         /* The first 64-bit word is the number of subsequent PCs. */
> -       unsigned long pos = READ_ONCE(area[0]) + 1;
> +       unsigned long pos = READ_ONCE(trace[0]) + 1;
>
>         if (likely(pos < size)) {
>                 /*
> @@ -208,9 +208,9 @@ static notrace void kcov_append_to_buffer(unsigned long *area, int size,
>                  * overitten by the recursive __sanitizer_cov_trace_pc().
>                  * Update pos before writing pc to avoid such interleaving.
>                  */
> -               WRITE_ONCE(area[0], pos);
> +               WRITE_ONCE(trace[0], pos);
>                 barrier();
> -               area[pos] = ip;
> +               trace[pos] = ip;
>         }
>  }
>
> @@ -224,8 +224,8 @@ void notrace __sanitizer_cov_trace_pc_guard(u32 *guard)
>         if (!check_kcov_mode(KCOV_MODE_TRACE_PC, current))
>                 return;
>
> -       kcov_append_to_buffer(current->kcov_state.area,
> -                             current->kcov_state.size,
> +       kcov_append_to_buffer(current->kcov_state.trace,
> +                             current->kcov_state.trace_size,
>                               canonicalize_ip(_RET_IP_));
>  }
>  EXPORT_SYMBOL(__sanitizer_cov_trace_pc_guard);
> @@ -241,8 +241,8 @@ void notrace __sanitizer_cov_trace_pc(void)
>         if (!check_kcov_mode(KCOV_MODE_TRACE_PC, current))
>                 return;
>
> -       kcov_append_to_buffer(current->kcov_state.area,
> -                             current->kcov_state.size,
> +       kcov_append_to_buffer(current->kcov_state.trace,
> +                             current->kcov_state.trace_size,
>                               canonicalize_ip(_RET_IP_));
>  }
>  EXPORT_SYMBOL(__sanitizer_cov_trace_pc);
> @@ -251,9 +251,9 @@ EXPORT_SYMBOL(__sanitizer_cov_trace_pc);
>  #ifdef CONFIG_KCOV_ENABLE_COMPARISONS
>  static void notrace write_comp_data(u64 type, u64 arg1, u64 arg2, u64 ip)
>  {
> -       struct task_struct *t;
> -       u64 *area;
>         u64 count, start_index, end_pos, max_pos;
> +       struct task_struct *t;
> +       u64 *trace;
>
>         t = current;
>         if (!check_kcov_mode(KCOV_MODE_TRACE_CMP, t))
> @@ -265,22 +265,22 @@ static void notrace write_comp_data(u64 type, u64 arg1, u64 arg2, u64 ip)
>          * We write all comparison arguments and types as u64.
>          * The buffer was allocated for t->kcov_state.size unsigned longs.
>          */
> -       area = (u64 *)t->kcov_state.area;
> +       trace = (u64 *)t->kcov_state.trace;
>         max_pos = t->kcov_state.size * sizeof(unsigned long);
>
> -       count = READ_ONCE(area[0]);
> +       count = READ_ONCE(trace[0]);
>
>         /* Every record is KCOV_WORDS_PER_CMP 64-bit words. */
>         start_index = 1 + count * KCOV_WORDS_PER_CMP;
>         end_pos = (start_index + KCOV_WORDS_PER_CMP) * sizeof(u64);
>         if (likely(end_pos <= max_pos)) {
>                 /* See comment in kcov_append_to_buffer(). */
> -               WRITE_ONCE(area[0], count + 1);
> +               WRITE_ONCE(trace[0], count + 1);
>                 barrier();
> -               area[start_index] = type;
> -               area[start_index + 1] = arg1;
> -               area[start_index + 2] = arg2;
> -               area[start_index + 3] = ip;
> +               trace[start_index] = type;
> +               trace[start_index + 1] = arg1;
> +               trace[start_index + 2] = arg2;
> +               trace[start_index + 3] = ip;
>         }
>  }
>
> @@ -381,11 +381,13 @@ static void kcov_start(struct task_struct *t, struct kcov *kcov,
>
>  static void kcov_stop(struct task_struct *t)
>  {
> +       int saved_sequence = t->kcov_state.sequence;
> +
>         WRITE_ONCE(t->kcov_mode, KCOV_MODE_DISABLED);
>         barrier();
>         t->kcov = NULL;
> -       t->kcov_state.size = 0;
> -       t->kcov_state.area = NULL;
> +       t->kcov_state = (typeof(t->kcov_state)){};
> +       t->kcov_state.sequence = saved_sequence;
>  }
>
>  static void kcov_task_reset(struct task_struct *t)
> @@ -734,6 +736,8 @@ static long kcov_ioctl(struct file *filep, unsigned int cmd, unsigned long arg)
>                 }
>                 kcov->state.area = area;
>                 kcov->state.size = size;
> +               kcov->state.trace = area;
> +               kcov->state.trace_size = size;
>                 kcov->mode = KCOV_MODE_INIT;
>                 spin_unlock_irqrestore(&kcov->lock, flags);
>                 return 0;
> @@ -925,10 +929,12 @@ void kcov_remote_start(u64 handle)
>                 local_lock_irqsave(&kcov_percpu_data.lock, flags);
>         }
>
> -       /* Reset coverage size. */
> -       *(u64 *)area = 0;
>         state.area = area;
>         state.size = size;
> +       state.trace = area;
> +       state.trace_size = size;
> +       /* Reset coverage size. */
> +       state.trace[0] = 0;
>
>         if (in_serving_softirq()) {
>                 kcov_remote_softirq_start(t);
> --
> 2.50.1.470.g6ba607880d-goog
>

