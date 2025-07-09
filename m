Return-Path: <linux-kernel+bounces-723971-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B880AFED21
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 17:08:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E11AA189848D
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 15:06:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB9D32E6113;
	Wed,  9 Jul 2025 15:06:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Yb9zncWh"
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2894D149C41
	for <linux-kernel@vger.kernel.org>; Wed,  9 Jul 2025 15:05:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752073560; cv=none; b=CBDIK2ULpjaMgfr7iR5102WQ90nT6O+s32oLdnjcbSiueJ3TIL5eIwO+TePiSuBjWAc7juC21FogY2uKhnhBkS1gZHVBV3XATVwJexb//sB+ndB8irug1vsIo2iGzltNtmPnxcayF8T7Tzqt/pCLpUgS/Ddwlqmj3VW8isSaFEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752073560; c=relaxed/simple;
	bh=8zi1n/cqktYcdVteHqm30BaQ/b2Xuu45f0ZR2Kufhwk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=esRJIrbilSeLmiQJW0JD3wpsjftYQV7/krmi9QHf28WdImwaPln5Zab3WQhCNB52bxTdeRCjXnHY6Ly58mb5tgDfq9UDTls2td03bWQ2OXeyBAXz29ThDCMuM/L1J5DyC4+QfjMO0F8U7eyEc0GXeoIKoupUDSS1m/Ri810UHLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Yb9zncWh; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-32cdc9544ceso49064671fa.0
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jul 2025 08:05:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752073556; x=1752678356; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=X3EFJZWHFKRnvYs24gJy3y+hySRApe+N9eZ4FMpwih8=;
        b=Yb9zncWhqL+J7wAH/L1btZ00izSb9JmN9Tu4qQi1OWJ+YFnskyOC8MyhV6KoGxXXe+
         yHSFa4cc/QrXOFe4pD0juoK71DNtZIoeCjwu3y2XD8+9UlojyBLNRdP63z5Pp95QAONS
         76xnHa0ICPMubuGHwKWpHgC1csM6PJlCQ77jt1RaC/6C0tRxwvLROSLxS5ORdgNOp9s7
         e5Ovo1CLrybK1p3qm9PW8QgtH2orDsUd3ECFelk3FQ2a3Ki61A2x+0q2m8HR70mk29mo
         rUyzYnQfHGjVsqqo+PmP41Y2Ee8WKrnCDpAkhH9vQGfLeIXaMJn4xh4hfRRDv8O54o6k
         AKhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752073556; x=1752678356;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=X3EFJZWHFKRnvYs24gJy3y+hySRApe+N9eZ4FMpwih8=;
        b=LMG98jPeADH0kGd6FZyVTsMNAqUy5/+yb+zonveBheW2Oo+6OCzqPmoVmeHWGIAjr8
         C+/LuE4MHZqMXz3R/Llwgo0p086DWasp/Hk6DMGbbdmnHrRUAgwkn+yU2JM68UJHVEom
         mLem1LfIHgKEodlofL9xCSEiq5LsCSKBdS8A1HA3eBLVbGotdsVpAkCT923X5j+Ffkwo
         P5hCm3cYxonO28czQNGLYzuvTPfrgnFbQaJ90OzVU8GhNCPa21uBKcYAVpCKrGtMtYo/
         ulOKEma0HgJZAUQobSHiyd4kaOjFmz3MmmMlmqqtdlWkMC41PW9uLbMiLt2rsFwWGRbY
         aPSQ==
X-Forwarded-Encrypted: i=1; AJvYcCWXYorbk0uPDgaBdjKMawfCQ3C/5JM46XmPyVImF/loYjoJ3+QOE5CDdF2VbxEwLob3sNIsmGPxrzhptPo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxnHncxhQNOx1C54hPFjY2u55nMXQCwDDVrWOI/LkQHHRjL0g3S
	22WVZeR9BmMeLO3vb1/Ml6YxSqN7dsioYx4CI/jkZ4eFLjmwnEsUIkOX73LdGr4YPHP2+6omB/4
	HmHHFaXdxEmtlfqHxzxhTWIVCyc9Rqa/yOTs3e9zG
X-Gm-Gg: ASbGnctx6s9/g5XsJf+q1bpL6jYlWAEhGVC6K/oo9RhdnZ5iCEPge56LrgsN+rsP0bM
	UPAkUrm7mDerPndRpjH8sUH+sSUFyhQ3bDt9Rs5j0gZXnrZBaDT4/vt30FUTYsLOuFNEythgvyt
	oquEGUkuQ7bfabAYeXfx8i7XDm5SwC+Tv2PNIOPkJUbGn6QqLjUnJncUM3nBiIBwm4nL8Mi52ZS
	uXY
X-Google-Smtp-Source: AGHT+IFP6WPvJjtqBbnQ2MWPG384RQqW2r8lGchjb4/ElWhgg6uXTvtdL/0jT8YeUWkGRk6O/eusAu4Raqeehjg3aWE=
X-Received: by 2002:a05:651c:304c:b0:32b:a9a4:cd3b with SMTP id
 38308e7fff4ca-32f500208b3mr296861fa.1.1752073555389; Wed, 09 Jul 2025
 08:05:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250626134158.3385080-1-glider@google.com> <20250626134158.3385080-8-glider@google.com>
In-Reply-To: <20250626134158.3385080-8-glider@google.com>
From: Dmitry Vyukov <dvyukov@google.com>
Date: Wed, 9 Jul 2025 17:05:44 +0200
X-Gm-Features: Ac12FXzeQAhmBo1BEER1qVGdHBxq8SPxRNE1VAHT5W_fT8Mz44wAcz5cFMNrv3E
Message-ID: <CACT4Y+Za7vRTQ6M6kKs-+4N4+D6q05OKf422LZCMBBy-k4Cqqw@mail.gmail.com>
Subject: Re: [PATCH v2 07/11] kcov: add trace and trace_size to struct kcov_state
To: Alexander Potapenko <glider@google.com>
Cc: quic_jiangenj@quicinc.com, linux-kernel@vger.kernel.org, 
	kasan-dev@googlegroups.com, Aleksandr Nogikh <nogikh@google.com>, 
	Andrey Konovalov <andreyknvl@gmail.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, Ingo Molnar <mingo@redhat.com>, 
	Josh Poimboeuf <jpoimboe@kernel.org>, Marco Elver <elver@google.com>, 
	Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"

On Thu, 26 Jun 2025 at 15:42, Alexander Potapenko <glider@google.com> wrote:
>
> Keep kcov_state.area as the pointer to the memory buffer used by
> kcov and shared with the userspace. Store the pointer to the trace
> (part of the buffer holding sequential events) separately, as we will
> be splitting that buffer in multiple parts.
> No functional changes so far.
>
> Signed-off-by: Alexander Potapenko <glider@google.com>
>
> ---
> Change-Id: I50b5589ef0e0b6726aa0579334093c648f76790a
>
> v2:
>  - Address comments by Dmitry Vyukov:
>    - tweak commit description
>  - Address comments by Marco Elver:
>    - rename sanitizer_cov_write_subsequent() to kcov_append_to_buffer()
>  - Update code to match the new description of struct kcov_state
> ---
>  include/linux/kcov_types.h |  9 ++++++-
>  kernel/kcov.c              | 54 ++++++++++++++++++++++----------------
>  2 files changed, 39 insertions(+), 24 deletions(-)
>
> diff --git a/include/linux/kcov_types.h b/include/linux/kcov_types.h
> index 53b25b6f0addd..233e7a682654b 100644
> --- a/include/linux/kcov_types.h
> +++ b/include/linux/kcov_types.h
> @@ -7,9 +7,16 @@
>  struct kcov_state {
>         /* Size of the area (in long's). */
>         unsigned int size;
> +       /*
> +        * Pointer to user-provided memory used by kcov. This memory may

s/kcov/KCOV/ for consistency

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
> index 8e98ca8d52743..038261145cf93 100644
> --- a/kernel/kcov.c
> +++ b/kernel/kcov.c
> @@ -195,11 +195,11 @@ static notrace unsigned long canonicalize_ip(unsigned long ip)
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
> @@ -209,9 +209,9 @@ static notrace void kcov_append_to_buffer(unsigned long *area, int size,
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
> @@ -225,8 +225,8 @@ void notrace __sanitizer_cov_trace_pc_guard(u32 *guard)
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
> @@ -242,8 +242,8 @@ void notrace __sanitizer_cov_trace_pc(void)
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
> @@ -252,9 +252,9 @@ EXPORT_SYMBOL(__sanitizer_cov_trace_pc);
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
> @@ -266,22 +266,22 @@ static void notrace write_comp_data(u64 type, u64 arg1, u64 arg2, u64 ip)
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
> @@ -382,11 +382,13 @@ static void kcov_start(struct task_struct *t, struct kcov *kcov,
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
> +       t->kcov_state = (typeof(t->kcov_state)){ 0 };

In a previous patch you used the following syntax, let's stick to one
of these forms:

data->saved_state = (struct kcov_state){};


> +       t->kcov_state.sequence = saved_sequence;
>  }
>
>  static void kcov_task_reset(struct task_struct *t)
> @@ -736,6 +738,8 @@ static long kcov_ioctl(struct file *filep, unsigned int cmd, unsigned long arg)
>                 }
>                 kcov->state.area = area;
>                 kcov->state.size = size;
> +               kcov->state.trace = area;
> +               kcov->state.trace_size = size;
>                 kcov->mode = KCOV_MODE_INIT;
>                 spin_unlock_irqrestore(&kcov->lock, flags);
>                 return 0;
> @@ -928,10 +932,12 @@ void kcov_remote_start(u64 handle)
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
> @@ -1004,8 +1010,8 @@ void kcov_remote_stop(void)
>         struct task_struct *t = current;
>         struct kcov *kcov;
>         unsigned int mode;
> -       void *area;
> -       unsigned int size;
> +       void *area, *trace;
> +       unsigned int size, trace_size;
>         int sequence;
>         unsigned long flags;
>
> @@ -1037,6 +1043,8 @@ void kcov_remote_stop(void)
>         kcov = t->kcov;
>         area = t->kcov_state.area;
>         size = t->kcov_state.size;
> +       trace = t->kcov_state.trace;
> +       trace_size = t->kcov_state.trace_size;
>         sequence = t->kcov_state.sequence;
>
>         kcov_stop(t);
> --
> 2.50.0.727.gbf7dc18ff4-goog
>

