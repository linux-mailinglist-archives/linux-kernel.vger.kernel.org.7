Return-Path: <linux-kernel+bounces-749316-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 28E23B14CD0
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 13:14:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2F9F618A3674
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 11:14:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7025328C027;
	Tue, 29 Jul 2025 11:14:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="xWL7sBpO"
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6AC72343C9
	for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 11:14:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753787656; cv=none; b=fv08ZNPnMnU97/E7wsAOGy52vpg+IubkSu9s29EyL/dgBZVLkmtKcWXYQhLwx3KTLuP5vIQEU0K4UyAbz9Gm51L0+qaM2vjwJMEjm36Si6uDXEr7nAZu61pm73lV4TnmkGWgHEFr7+xaW/z6eumix+pVjXIxrzorAwHxGZ+hf7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753787656; c=relaxed/simple;
	bh=SLFPrQ29px2+WU99vmfcOYoiIwf+zc1pu2D4HHxzXA0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=o4DuU6jKs4LhX8BLkhU+A7oreR+gcv4XzVlIB23uQ3yAhN6e8Pil9Bh2238VdFid1efXJDfPPpYOZGPRKd7GXg7ILW4VkVV+SpUTInf59TTnGqm5c7dioipsVbngbLj6kVnaSOeytnKBwHB5vuhrHVSBp2LNQWIwgkP0inWudzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=xWL7sBpO; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-32b553e33e6so44307571fa.2
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 04:14:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753787652; x=1754392452; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=mh389HBylGMlNQkfOeOZnOe2F5PAgAYVZIhMDMwa32I=;
        b=xWL7sBpOrQ2M9vT9QrX0mCo6BjjfYXw3dzbYavBn4t9taSY2/k+dYyuR4KbmjCyvAz
         Q+GdVuXeBTonE6nywDBpSPyYtAYRq84B9iDCH8wYLgMWtAJQbLiLkRLPI+ys7yxFS8T8
         yzt3FNfFGe+p1dPF0A3b2TVOkY0z3ZM7nBrnKm3gqvSaGl7p2PvsG0wx4DbN3GXpJvYi
         CXrjqHRTDwpD/ofcb9MXeEm2bbMcZTlznGXy9kjLcKTBrEaOIE2Qk9tam6HPZpwgZN0X
         PPylAg3RTTGFDXUOUqJaorF17DDa0IBoc+ggqmsY4pjqgVWPHBg7wLaQ/v2/4m6pd7fZ
         IuwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753787652; x=1754392452;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mh389HBylGMlNQkfOeOZnOe2F5PAgAYVZIhMDMwa32I=;
        b=e3lQbnL+dZ4DG02WBVFHa6QX6K7Fh+9zBgUebxBfLnmQe2SaAFfcySQHSsDds/7t6Y
         TDewdLCoSXqIA/sbG4rYmcApXg9/jXKVCqE8mwheNjnvU4BdolCzAMsIfnn6cvyt+g7q
         vtOMBsF2esKpy4BoalOsXWx+HdhmyyI30txnpyAICiyLF/Mr32Nnwr0qdnEZKSdaXCh5
         ALQDXpJdqIOpax5f6MPtlCQgqEUcFd5OQoAtfVBfLt1whDWxJ8kG0pOuLXU8te4Mhu/p
         PlYDJFvGAmBtci7iEZp7QLs5Eynr7joXoHDsI1LwKfw0RUtaUa1T25r1bLz3iltbMphT
         nz2Q==
X-Forwarded-Encrypted: i=1; AJvYcCWJ3rcivkXet12DCI64Dafn4OlB5epwqhKxJmHsFcI5xp8eyz6Tas/mQs4XlTDv9+L4OtO2MOou8egSUO0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyl2WSQLnrGXSZ/DDvQceitBnK+Aslbt2PRiG9xUriWP4EgPJnS
	48ucWBOKy10zRTh85UardsHpS+VgtYBd9L81PTPtYI5Wu+dDf6J/yXdmczp38QLNdHg98LiXD/L
	9r6413d6MFWdGVGHXAkrYojhK71i1t3ohPclJ3lov
X-Gm-Gg: ASbGncvBLx4OvXsybSe7pYBNSHZHyrfs2RN89AjrIyS3wmoZAr+fEJY/iw0NdWclJqv
	YdT7cD+GGEQJD1XaFCEx2z/MTfWjJlyNfMAcWZpWToF44BY+nAsUDui2m9XtW6UGV5qOZ+3muN0
	tJl3z9toTPNybgB0y7rQhMcAEk6JopXIg+KCaVcfWrdQ5W27y5iNyuy5A0rO+GpOti7F1gfoFHh
	4g/Ci1RNCQstEaUV+7cfl0I/DEHCmbEZXuBBQ==
X-Google-Smtp-Source: AGHT+IGrIENL0EeT+F4WzyJSuoMxJoh5sdQ9lBCkdKaVhAwkFRBlbliRf6qZo0ACHXuwIimvbX4pznyiuJl8bk6RRkU=
X-Received: by 2002:a05:651c:1118:10b0:32b:8778:6f0a with SMTP id
 38308e7fff4ca-331ee7dd1cemr28381121fa.27.1753787651778; Tue, 29 Jul 2025
 04:14:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250728152548.3969143-1-glider@google.com> <20250728152548.3969143-8-glider@google.com>
In-Reply-To: <20250728152548.3969143-8-glider@google.com>
From: Dmitry Vyukov <dvyukov@google.com>
Date: Tue, 29 Jul 2025 13:14:00 +0200
X-Gm-Features: Ac12FXwAMv8eL61LZ2q7cUqyG_EAxEjhHKT3t93dxq4uwCuf7mFhx_izynP-MnE
Message-ID: <CACT4Y+YLMO8hE3GqnXpSjoCD=PbFjGNWcKSN0BH10ASMHkHN8A@mail.gmail.com>
Subject: Re: [PATCH v3 07/10] kcov: add ioctl(KCOV_UNIQUE_ENABLE)
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
> ioctl(KCOV_UNIQUE_ENABLE) enables collection of deduplicated coverage
> in the presence of CONFIG_KCOV_ENABLE_GUARDS.
>
> The buffer shared with the userspace is divided in two parts, one holding
> a bitmap, and the other one being the trace. The single parameter of
> ioctl(KCOV_UNIQUE_ENABLE) determines the number of words used for the
> bitmap.
>
> Each __sanitizer_cov_trace_pc_guard() instrumentation hook receives a
> pointer to a unique guard variable. Upon the first call of each hook,
> the guard variable is initialized with a unique integer, which is used to
> map those hooks to bits in the bitmap. In the new coverage collection mode,
> the kernel first checks whether the bit corresponding to a particular hook
> is set, and then, if it is not, the PC is written into the trace buffer,
> and the bit is set.
>
> Note: when CONFIG_KCOV_ENABLE_GUARDS is disabled, ioctl(KCOV_UNIQUE_ENABLE)
> returns -ENOTSUPP, which is consistent with the existing kcov code.
>
> Measuring the exact performance impact of this mode directly can be
> challenging. However, based on fuzzing experiments (50 instances x 24h
> with and without deduplication), we observe the following:
>  - When normalized by pure fuzzing time, total executions decreased
>    by 2.1% (p=0.01).
>  - When normalized by fuzzer uptime, the reduction in total executions
>    was statistically insignificant (-1.0% with p=0.20).
> Despite a potential slight slowdown in execution count, the new mode
> positively impacts fuzzing effectiveness:
>  - Statistically significant increase in corpus size (+0.6%, p<0.01).
>  - Statistically significant increase in coverage (+0.6%, p<0.01).
>  - A 99.8% reduction in coverage overflows.
>
> Also update the documentation.
>
> Signed-off-by: Alexander Potapenko <glider@google.com>

Reviewed-by: Dmitry Vyukov <dvyukov@google.com>


> ---
> v3:
>  - s/check_kcov_mode/get_kcov_mode in objtool
>
> v2:
>  - Address comments by Dmitry Vyukov:
>    - rename CONFIG_KCOV_ENABLE_GUARDS to CONFIG_KCOV_UNIQUE
>    - rename KCOV_MODE_TRACE_UNIQUE_PC to KCOV_MODE_UNIQUE_PC
>    - simplify index allocation
>    - update documentation and comments
>  - Address comments by Marco Elver:
>    - change _IOR to _IOW in KCOV_UNIQUE_ENABLE definition
>    - rename sanitizer_cov_write_subsequent() to kcov_append_to_buffer()
>  - Use __test_and_set_bit() to avoid the lock prefix on the bit operation
>  - Update code to match the new description of struct kcov_state
>  - Rename kcov_get_mode() to kcov_arg_to_mode() to avoid confusion with
>    get_kcov_mode(). Also make it use `enum kcov_mode`.
>
> Change-Id: I9805e7b22619a50e05cc7c7d794dacf6f7de2f03
> ---
>  Documentation/dev-tools/kcov.rst |  43 ++++++++
>  include/linux/kcov.h             |   2 +
>  include/linux/kcov_types.h       |   8 ++
>  include/uapi/linux/kcov.h        |   1 +
>  kernel/kcov.c                    | 164 ++++++++++++++++++++++++++-----
>  tools/objtool/check.c            |   2 +-
>  6 files changed, 193 insertions(+), 27 deletions(-)
>
> diff --git a/Documentation/dev-tools/kcov.rst b/Documentation/dev-tools/kcov.rst
> index abf3ad2e784e8..6446887cd1c92 100644
> --- a/Documentation/dev-tools/kcov.rst
> +++ b/Documentation/dev-tools/kcov.rst
> @@ -192,6 +192,49 @@ Normally the shared buffer is used as follows::
>      up to the buffer[0] value saved above    |
>
>
> +Unique coverage collection
> +---------------------------
> +
> +Instead of collecting a trace of PCs, KCOV can deduplicate them on the fly.
> +This mode is enabled by the ``KCOV_UNIQUE_ENABLE`` ioctl (only available if
> +``CONFIG_KCOV_UNIQUE`` is on).
> +
> +.. code-block:: c
> +
> +       /* Same includes and defines as above. */
> +       #define KCOV_UNIQUE_ENABLE              _IOW('c', 103, unsigned long)
> +       #define BITMAP_SIZE                     (4<<10)
> +
> +       /* Instead of KCOV_ENABLE, enable unique coverage collection. */
> +       if (ioctl(fd, KCOV_UNIQUE_ENABLE, BITMAP_SIZE))
> +               perror("ioctl"), exit(1);
> +       /* Reset the coverage from the tail of the ioctl() call. */
> +       __atomic_store_n(&cover[BITMAP_SIZE], 0, __ATOMIC_RELAXED);
> +       memset(cover, 0, BITMAP_SIZE * sizeof(unsigned long));
> +
> +       /* Call the target syscall call. */
> +       /* ... */
> +
> +       /* Read the number of collected PCs. */
> +       n = __atomic_load_n(&cover[BITMAP_SIZE], __ATOMIC_RELAXED);
> +       /* Disable the coverage collection. */
> +       if (ioctl(fd, KCOV_DISABLE, 0))
> +               perror("ioctl"), exit(1);
> +
> +Calling ``ioctl(fd, KCOV_UNIQUE_ENABLE, bitmap_size)`` carves out ``bitmap_size``
> +unsigned long's from those allocated by ``KCOV_INIT_TRACE`` to keep an opaque
> +bitmap that prevents the kernel from storing the same PC twice. The remaining
> +part of the buffer is used to collect PCs, like in other modes (this part must
> +contain at least two unsigned long's, like when collecting non-unique PCs).
> +
> +The mapping between a PC and its position in the bitmap is persistent during the
> +kernel lifetime, so it is possible for the callers to directly use the bitmap
> +contents as a coverage signal (like when fuzzing userspace with AFL).
> +
> +In order to reset the coverage between the runs, the user needs to rewind the
> +trace (by writing 0 into the first buffer element past ``bitmap_size``) and zero
> +the whole bitmap.
> +
>  Comparison operands collection
>  ------------------------------
>
> diff --git a/include/linux/kcov.h b/include/linux/kcov.h
> index 2acccfa5ae9af..cea2e62723ef9 100644
> --- a/include/linux/kcov.h
> +++ b/include/linux/kcov.h
> @@ -10,6 +10,7 @@ struct task_struct;
>  #ifdef CONFIG_KCOV
>
>  enum kcov_mode {
> +       KCOV_MODE_INVALID = -1,
>         /* Coverage collection is not enabled yet. */
>         KCOV_MODE_DISABLED = 0,
>         /* KCOV was initialized, but tracing mode hasn't been chosen yet. */
> @@ -23,6 +24,7 @@ enum kcov_mode {
>         KCOV_MODE_TRACE_CMP = 3,
>         /* The process owns a KCOV remote reference. */
>         KCOV_MODE_REMOTE = 4,
> +       KCOV_MODE_UNIQUE_PC = 5,
>  };
>
>  #define KCOV_IN_CTXSW  (1 << 30)
> diff --git a/include/linux/kcov_types.h b/include/linux/kcov_types.h
> index 9d38a2020b099..8be930f47cd78 100644
> --- a/include/linux/kcov_types.h
> +++ b/include/linux/kcov_types.h
> @@ -18,6 +18,14 @@ struct kcov_state {
>         /* Buffer for coverage collection, shared with the userspace. */
>         unsigned long *trace;
>
> +       /* Size of the bitmap (in bits). */
> +       unsigned int bitmap_size;
> +       /*
> +        * Bitmap for coverage deduplication, shared with the
> +        * userspace.
> +        */
> +       unsigned long *bitmap;
> +
>         /*
>          * KCOV sequence number: incremented each time kcov is reenabled, used
>          * by kcov_remote_stop(), see the comment there.
> diff --git a/include/uapi/linux/kcov.h b/include/uapi/linux/kcov.h
> index ed95dba9fa37e..e743ee011eeca 100644
> --- a/include/uapi/linux/kcov.h
> +++ b/include/uapi/linux/kcov.h
> @@ -22,6 +22,7 @@ struct kcov_remote_arg {
>  #define KCOV_ENABLE                    _IO('c', 100)
>  #define KCOV_DISABLE                   _IO('c', 101)
>  #define KCOV_REMOTE_ENABLE             _IOW('c', 102, struct kcov_remote_arg)
> +#define KCOV_UNIQUE_ENABLE             _IOW('c', 103, unsigned long)
>
>  enum {
>         /*
> diff --git a/kernel/kcov.c b/kernel/kcov.c
> index 2005fc7f578ee..a92c848d17bce 100644
> --- a/kernel/kcov.c
> +++ b/kernel/kcov.c
> @@ -28,6 +28,10 @@
>  #include <linux/log2.h>
>  #include <asm/setup.h>
>
> +#ifdef CONFIG_KCOV_UNIQUE
> +atomic_t kcov_guard_max_index = ATOMIC_INIT(0);
> +#endif
> +
>  #define kcov_debug(fmt, ...) pr_debug("%s: " fmt, __func__, ##__VA_ARGS__)
>
>  /* Number of 64-bit words written per one comparison: */
> @@ -163,9 +167,9 @@ static __always_inline bool in_softirq_really(void)
>         return in_serving_softirq() && !in_hardirq() && !in_nmi();
>  }
>
> -static notrace bool check_kcov_mode(enum kcov_mode needed_mode, struct task_struct *t)
> +static notrace enum kcov_mode get_kcov_mode(struct task_struct *t)
>  {
> -       unsigned int mode;
> +       enum kcov_mode mode;
>
>         /*
>          * We are interested in code coverage as a function of a syscall inputs,
> @@ -173,7 +177,7 @@ static notrace bool check_kcov_mode(enum kcov_mode needed_mode, struct task_stru
>          * coverage collection section in a softirq.
>          */
>         if (!in_task() && !(in_softirq_really() && t->kcov_softirq))
> -               return false;
> +               return KCOV_MODE_INVALID;
>         mode = READ_ONCE(t->kcov_mode);
>         /*
>          * There is some code that runs in interrupts but for which
> @@ -183,7 +187,7 @@ static notrace bool check_kcov_mode(enum kcov_mode needed_mode, struct task_stru
>          * kcov_start().
>          */
>         barrier();
> -       return mode == needed_mode;
> +       return mode;
>  }
>
>  static notrace unsigned long canonicalize_ip(unsigned long ip)
> @@ -202,7 +206,7 @@ static notrace void kcov_append_to_buffer(unsigned long *trace, int size,
>
>         if (likely(pos < size)) {
>                 /*
> -                * Some early interrupt code could bypass check_kcov_mode() check
> +                * Some early interrupt code could bypass get_kcov_mode() check
>                  * and invoke __sanitizer_cov_trace_pc(). If such interrupt is
>                  * raised between writing pc and updating pos, the pc could be
>                  * overitten by the recursive __sanitizer_cov_trace_pc().
> @@ -219,14 +223,76 @@ static notrace void kcov_append_to_buffer(unsigned long *trace, int size,
>   * This is called once per basic-block/edge.
>   */
>  #ifdef CONFIG_KCOV_UNIQUE
> +DEFINE_PER_CPU(u32, saved_index);
> +/*
> + * Assign an index to a guard variable that does not have one yet.
> + * For an unlikely case of a race with another task executing the same basic
> + * block for the first time with kcov enabled, we store the unused index in a
> + * per-cpu variable.
> + * In an even less likely case of the current task losing the race and getting
> + * rescheduled onto a CPU that already has a saved index, the index is
> + * discarded. This will result in an unused hole in the bitmap, but such events
> + * should have minor impact on the overall memory consumption.
> + */
> +static __always_inline u32 init_pc_guard(u32 *guard)
> +{
> +       /* If the current CPU has a saved free index, use it. */
> +       u32 index = this_cpu_xchg(saved_index, 0);
> +       u32 old_guard;
> +
> +       if (likely(!index))
> +               /*
> +                * Allocate a new index. No overflow is possible, because 2**32
> +                * unique basic blocks will take more space than the max size
> +                * of the kernel text segment.
> +                */
> +               index = atomic_inc_return(&kcov_guard_max_index);
> +
> +       /*
> +        * Make sure another task is not initializing the same guard
> +        * concurrently.
> +        */
> +       old_guard = cmpxchg(guard, 0, index);
> +       if (unlikely(old_guard)) {
> +               /* We lost the race, save the index for future use. */
> +               this_cpu_write(saved_index, index);
> +               return old_guard;
> +       }
> +       return index;
> +}
> +
>  void notrace __sanitizer_cov_trace_pc_guard(u32 *guard)
>  {
> -       if (!check_kcov_mode(KCOV_MODE_TRACE_PC, current))
> -               return;
> +       enum kcov_mode mode = get_kcov_mode(current);
> +       u32 pc_index;
>
> -       kcov_append_to_buffer(current->kcov_state.trace,
> -                             current->kcov_state.trace_size,
> -                             canonicalize_ip(_RET_IP_));
> +       switch (mode) {
> +       case KCOV_MODE_UNIQUE_PC:
> +               pc_index = READ_ONCE(*guard);
> +               if (unlikely(!pc_index))
> +                       pc_index = init_pc_guard(guard);
> +
> +               /*
> +                * Use the bitmap for coverage deduplication. We assume both
> +                * s.bitmap and s.trace are non-NULL.
> +                */
> +               if (likely(pc_index < current->kcov_state.bitmap_size))
> +                       if (__test_and_set_bit(pc_index,
> +                                              current->kcov_state.bitmap))
> +                               return;
> +               /*
> +                * If the PC is new, or the bitmap is too small, write PC to the
> +                * trace.
> +                */
> +               fallthrough;
> +       case KCOV_MODE_TRACE_PC:
> +               kcov_append_to_buffer(current->kcov_state.trace,
> +                                     current->kcov_state.trace_size,
> +                                     canonicalize_ip(_RET_IP_));
> +               break;
> +       default:
> +               return;
> +       }
>  }
>  EXPORT_SYMBOL(__sanitizer_cov_trace_pc_guard);
>
> @@ -238,7 +304,7 @@ EXPORT_SYMBOL(__sanitizer_cov_trace_pc_guard_init);
>  #else /* !CONFIG_KCOV_UNIQUE */
>  void notrace __sanitizer_cov_trace_pc(void)
>  {
> -       if (!check_kcov_mode(KCOV_MODE_TRACE_PC, current))
> +       if (get_kcov_mode(current) != KCOV_MODE_TRACE_PC)
>                 return;
>
>         kcov_append_to_buffer(current->kcov_state.trace,
> @@ -256,7 +322,7 @@ static void notrace write_comp_data(u64 type, u64 arg1, u64 arg2, u64 ip)
>         u64 *trace;
>
>         t = current;
> -       if (!check_kcov_mode(KCOV_MODE_TRACE_CMP, t))
> +       if (get_kcov_mode(t) != KCOV_MODE_TRACE_CMP)
>                 return;
>
>         ip = canonicalize_ip(ip);
> @@ -374,7 +440,7 @@ static void kcov_start(struct task_struct *t, struct kcov *kcov,
>         t->kcov = kcov;
>         /* Cache in task struct for performance. */
>         t->kcov_state = *state;
> -       /* See comment in check_kcov_mode(). */
> +       /* See comment in get_kcov_mode(). */
>         barrier();
>         WRITE_ONCE(t->kcov_mode, mode);
>  }
> @@ -409,6 +475,10 @@ static void kcov_reset(struct kcov *kcov)
>         kcov->mode = KCOV_MODE_INIT;
>         kcov->remote = false;
>         kcov->remote_size = 0;
> +       kcov->state.trace = kcov->state.area;
> +       kcov->state.trace_size = kcov->state.size;
> +       kcov->state.bitmap = NULL;
> +       kcov->state.bitmap_size = 0;
>         kcov->state.sequence++;
>  }
>
> @@ -549,18 +619,23 @@ static int kcov_close(struct inode *inode, struct file *filep)
>         return 0;
>  }
>
> -static int kcov_get_mode(unsigned long arg)
> +static enum kcov_mode kcov_arg_to_mode(unsigned long arg, int *error)
>  {
> -       if (arg == KCOV_TRACE_PC)
> +       if (arg == KCOV_TRACE_PC) {
>                 return KCOV_MODE_TRACE_PC;
> -       else if (arg == KCOV_TRACE_CMP)
> +       } else if (arg == KCOV_TRACE_CMP) {
>  #ifdef CONFIG_KCOV_ENABLE_COMPARISONS
>                 return KCOV_MODE_TRACE_CMP;
>  #else
> -               return -ENOTSUPP;
> +               if (error)
> +                       *error = -ENOTSUPP;
> +               return KCOV_MODE_INVALID;
>  #endif
> -       else
> -               return -EINVAL;
> +       } else {
> +               if (error)
> +                       *error = -EINVAL;
> +               return KCOV_MODE_INVALID;
> +       }
>  }
>
>  /*
> @@ -595,12 +670,47 @@ static inline bool kcov_check_handle(u64 handle, bool common_valid,
>         return false;
>  }
>
> +static long kcov_handle_unique_enable(struct kcov *kcov,
> +                                     unsigned long bitmap_words)
> +{
> +       struct task_struct *t = current;
> +
> +       if (!IS_ENABLED(CONFIG_KCOV_UNIQUE))
> +               return -ENOTSUPP;
> +       if (kcov->mode != KCOV_MODE_INIT || !kcov->state.area)
> +               return -EINVAL;
> +       if (kcov->t != NULL || t->kcov != NULL)
> +               return -EBUSY;
> +
> +       /*
> +        * Cannot use zero-sized bitmap, also the bitmap must leave at least two
> +        * words for the trace.
> +        */
> +       if ((!bitmap_words) || (bitmap_words >= (kcov->state.size - 1)))
> +               return -EINVAL;
> +
> +       kcov->state.bitmap_size = bitmap_words * sizeof(unsigned long) * 8;
> +       kcov->state.bitmap = kcov->state.area;
> +       kcov->state.trace_size = kcov->state.size - bitmap_words;
> +       kcov->state.trace = ((unsigned long *)kcov->state.area + bitmap_words);
> +
> +       kcov_fault_in_area(kcov);
> +       kcov->mode = KCOV_MODE_UNIQUE_PC;
> +       kcov_start(t, kcov, kcov->mode, &kcov->state);
> +       kcov->t = t;
> +       /* Put either in kcov_task_exit() or in KCOV_DISABLE. */
> +       kcov_get(kcov);
> +
> +       return 0;
> +}
> +
>  static int kcov_ioctl_locked(struct kcov *kcov, unsigned int cmd,
>                              unsigned long arg)
>  {
>         struct task_struct *t;
>         unsigned long flags, unused;
> -       int mode, i;
> +       enum kcov_mode mode;
> +       int error = 0, i;
>         struct kcov_remote_arg *remote_arg;
>         struct kcov_remote *remote;
>
> @@ -618,9 +728,9 @@ static int kcov_ioctl_locked(struct kcov *kcov, unsigned int cmd,
>                 t = current;
>                 if (kcov->t != NULL || t->kcov != NULL)
>                         return -EBUSY;
> -               mode = kcov_get_mode(arg);
> -               if (mode < 0)
> -                       return mode;
> +               mode = kcov_arg_to_mode(arg, &error);
> +               if (mode == KCOV_MODE_INVALID)
> +                       return error;
>                 kcov_fault_in_area(kcov);
>                 kcov->mode = mode;
>                 kcov_start(t, kcov, mode, &kcov->state);
> @@ -628,6 +738,8 @@ static int kcov_ioctl_locked(struct kcov *kcov, unsigned int cmd,
>                 /* Put either in kcov_task_exit() or in KCOV_DISABLE. */
>                 kcov_get(kcov);
>                 return 0;
> +       case KCOV_UNIQUE_ENABLE:
> +               return kcov_handle_unique_enable(kcov, arg);
>         case KCOV_DISABLE:
>                 /* Disable coverage for the current task. */
>                 unused = arg;
> @@ -646,9 +758,9 @@ static int kcov_ioctl_locked(struct kcov *kcov, unsigned int cmd,
>                 if (kcov->t != NULL || t->kcov != NULL)
>                         return -EBUSY;
>                 remote_arg = (struct kcov_remote_arg *)arg;
> -               mode = kcov_get_mode(remote_arg->trace_mode);
> -               if (mode < 0)
> -                       return mode;
> +               mode = kcov_arg_to_mode(remote_arg->trace_mode, &error);
> +               if (mode == KCOV_MODE_INVALID)
> +                       return error;
>                 if ((unsigned long)remote_arg->area_size >
>                     LONG_MAX / sizeof(unsigned long))
>                         return -EINVAL;
> diff --git a/tools/objtool/check.c b/tools/objtool/check.c
> index 60eb5faa27d28..f4ec041de0224 100644
> --- a/tools/objtool/check.c
> +++ b/tools/objtool/check.c
> @@ -1154,7 +1154,7 @@ static const char *uaccess_safe_builtin[] = {
>         "__tsan_unaligned_write16",
>         /* KCOV */
>         "write_comp_data",
> -       "check_kcov_mode",
> +       "get_kcov_mode",
>         "__sanitizer_cov_trace_pc",
>         "__sanitizer_cov_trace_pc_guard",
>         "__sanitizer_cov_trace_const_cmp1",
> --
> 2.50.1.470.g6ba607880d-goog
>

