Return-Path: <linux-kernel+bounces-749321-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B025B14CE6
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 13:18:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6DCA618A37CD
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 11:18:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 729E528D823;
	Tue, 29 Jul 2025 11:17:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2bUBFlyi"
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F251A288C26
	for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 11:17:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753787876; cv=none; b=l82u6tMiD/U1PLAg0BOd8czDBRMEh1cZcqU4YR1BN6WmhjpnQmgiNxsb/w4keXYjyQOWFsi9/OpTw1YDhNI8iSC+yOQl4MbEhln9FXu1ILfq0yMe7vptr/M3n/My0GrChX2uU65LwOdFq29j6YSmWKdR5kpvUeEWb2BzngdTvJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753787876; c=relaxed/simple;
	bh=VavxcMit2RZ9iqKN8RuPlF7sbKrr+xf78GvYlaxU9zc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=F7HRGo53szG5UNZuVs0fFiUKPJfbnVWA08lgm/28e/wBZRVzNNECLRWjXEqQBepnIHKuw2svwTGpRViceVW9CBvI034WHBCgHsfc7j+tX3CcW2Q3iTAbMK5yyxEctePvaVi3DiV9kqvXodAGtAbcdJvPdH5NcVENHiVLecxd9Ec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=2bUBFlyi; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-32b7113ed6bso58739391fa.1
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 04:17:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753787873; x=1754392673; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ltMJxWBOHtolA4fHUO1dAMcF/j+HeyAumwrml6j94Dk=;
        b=2bUBFlyi6FIVtOM2BU21iOrBUeoVKB0202lEZqkjS6dWLJUwcQPnjWXieDew+n43Bh
         LGgHjkOXYt86C7nqsPXA5h03mQB/x4bKU5kW89VuCaFkcxrqR9myy5smfvytvSK+UGPP
         PYOYBNP+JCpjNcz4X3vxdYrPWqQksqE2/rSmxxCmMgdC7UaHk9jhpzXbPQXHql9GJmVO
         2LleOoD8TzUJPY+nRC80VeoEmTF/s9fCE9fFH7ItUu58AmFkcDwHvsaGIeuT+Qyf3skm
         p9MemPBlC8YuiiuSab/4kpsFOgt1bHxA2Ghng7VNKmoI43T95UKrbmNUggJ9oI1fMtpA
         lPuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753787873; x=1754392673;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ltMJxWBOHtolA4fHUO1dAMcF/j+HeyAumwrml6j94Dk=;
        b=WdR+VzdaMdEz6jLb7bCxXc8yLtljW0OtuUlW5qIzvIulPp4+ZrZVX0VnOD4ztAkCGu
         NftxXXRwJMm2+9Uw7KOrngk9Yds7VTRUvqMVyUKDDQWf5m7KVnNR2Dvr0blXDI33WpXr
         R4KOv5dJi0WEIfIF2/mgSHXNmDdXquMVTHSHJjHCIT3uVsapZtvD0PAsmiHmO7nD61cD
         rYuh8Hp7RntkdD4Q/Hs2BLlhERQLoHKn8sUvEqGPj/9A1+Yr96yZzxIxi5j5Z8Smg/kx
         i06H+DhsSqXdOC6YDekwdWxzQVKbWSolOVrc+AWW+SSY2ZL7ZA+CCIIppg5pSVe7xKb1
         FATg==
X-Forwarded-Encrypted: i=1; AJvYcCXWUn34kZqH+EKWgW31kq9hehOLZkZ2xsvAvRa6L4od7SuI/rw5a08gtQJz1NdCQA2o0JlWCFXnsVAKwL8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8xasOAAnKNQco/2m2GLatv0dq6XRcKXMY5ma0fPlePhmTqIyb
	8CIto5+qF7J3pBgIs7Xl3s0OY1plz6fe9WEUWP6YEU/TBF/wrFlkjWPtZ2TpNsWvPnb9uK4hVcJ
	jbahHHEo2QtBQ+F7YS95wynMO0gCAwZiYKKevNYO7
X-Gm-Gg: ASbGncuMYM1B08saQKHEnHFthx5OPfyssObarCYtBvPSznFNyxRkf/oncIC93HqVKI4
	xIpO3IDrLgcXXPzCuZeQfF9gEaBg0AcF5jHkpKGYF+D/hL1HreS4FfcVLwQUS1TZ6VblPBQkCkl
	A33rm4kuK3z25GLWAT2bXN9I5O+4yGfDNG0of4OaMF3+kkEWz/l/BUTrPQ0TfACUd3g1ZRx5pxV
	lDzMiC6CXmoMIK9ANc50Sf8JbXlshQRgGj2jk5T0m+Ys+Ml
X-Google-Smtp-Source: AGHT+IE1lzpVUF119n4xxFLHaM0CJydh7lEzZgVU1OQ8ZpULUdA5KdGtvu67om6Lq5vZVPvpUmKVAV+SOFxzlEODR7k=
X-Received: by 2002:a05:651c:3254:10b0:331:e6e3:5f9a with SMTP id
 38308e7fff4ca-331ee70ee1bmr36539531fa.3.1753787872852; Tue, 29 Jul 2025
 04:17:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250728152548.3969143-1-glider@google.com> <20250728152548.3969143-9-glider@google.com>
In-Reply-To: <20250728152548.3969143-9-glider@google.com>
From: Dmitry Vyukov <dvyukov@google.com>
Date: Tue, 29 Jul 2025 13:17:41 +0200
X-Gm-Features: Ac12FXzvXT6ZDgqBgnzLORTrdzHWOr68Bbqui0G02Gy0qCyfBlS9fa_n-K2ksxM
Message-ID: <CACT4Y+aEwxFAuKK4WSU8wuAvG01n3+Ch6qBiMSdGjPqNgwscag@mail.gmail.com>
Subject: Re: [PATCH v3 08/10] kcov: add ioctl(KCOV_RESET_TRACE)
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
> Provide a mechanism to reset the coverage for the current task
> without writing directly to the coverage buffer.
> This is slower, but allows the fuzzers to map the coverage buffer
> as read-only, making it harder to corrupt.
>
> Signed-off-by: Alexander Potapenko <glider@google.com>

Reviewed-by: Dmitry Vyukov <dvyukov@google.com>


>
> ---
> v2:
>  - Update code to match the new description of struct kcov_state
>
> Change-Id: I8f9e6c179d93ccbfe0296b14764e88fa837cfffe
> ---
>  Documentation/dev-tools/kcov.rst | 26 ++++++++++++++++++++++++++
>  include/uapi/linux/kcov.h        |  1 +
>  kernel/kcov.c                    | 15 +++++++++++++++
>  3 files changed, 42 insertions(+)
>
> diff --git a/Documentation/dev-tools/kcov.rst b/Documentation/dev-tools/kcov.rst
> index 6446887cd1c92..e215c0651e16d 100644
> --- a/Documentation/dev-tools/kcov.rst
> +++ b/Documentation/dev-tools/kcov.rst
> @@ -470,3 +470,29 @@ local tasks spawned by the process and the global task that handles USB bus #1:
>                 perror("close"), exit(1);
>         return 0;
>      }
> +
> +
> +Resetting coverage with an KCOV_RESET_TRACE
> +-------------------------------------------
> +
> +The ``KCOV_RESET_TRACE`` ioctl provides a mechanism to clear collected coverage
> +data for the current task. It resets the program counter (PC) trace and, if
> +``KCOV_UNIQUE_ENABLE`` mode is active, also zeroes the associated bitmap.
> +
> +The primary use case for this ioctl is to enhance safety during fuzzing.
> +Normally, a user could map the kcov buffer with ``PROT_READ | PROT_WRITE`` and
> +reset the trace from the user-space program. However, when fuzzing system calls,
> +the kernel itself might inadvertently write to this shared buffer, corrupting
> +the coverage data.
> +
> +To prevent this, a fuzzer can map the buffer with ``PROT_READ`` and use
> +``ioctl(fd, KCOV_RESET_TRACE, 0)`` to safely clear the buffer from the kernel
> +side before each fuzzing iteration.
> +
> +Note that:
> +
> +* This ioctl is safer but slower than directly writing to the shared memory
> +  buffer due to the overhead of a system call.
> +* ``KCOV_RESET_TRACE`` is itself a system call, and its execution will be traced
> +  by kcov. Consequently, immediately after the ioctl returns, cover[0] will be
> +  greater than 0.
> diff --git a/include/uapi/linux/kcov.h b/include/uapi/linux/kcov.h
> index e743ee011eeca..8ab77cc3afa76 100644
> --- a/include/uapi/linux/kcov.h
> +++ b/include/uapi/linux/kcov.h
> @@ -23,6 +23,7 @@ struct kcov_remote_arg {
>  #define KCOV_DISABLE                   _IO('c', 101)
>  #define KCOV_REMOTE_ENABLE             _IOW('c', 102, struct kcov_remote_arg)
>  #define KCOV_UNIQUE_ENABLE             _IOW('c', 103, unsigned long)
> +#define KCOV_RESET_TRACE               _IO('c', 104)
>
>  enum {
>         /*
> diff --git a/kernel/kcov.c b/kernel/kcov.c
> index a92c848d17bce..82ed4c6150c54 100644
> --- a/kernel/kcov.c
> +++ b/kernel/kcov.c
> @@ -740,6 +740,21 @@ static int kcov_ioctl_locked(struct kcov *kcov, unsigned int cmd,
>                 return 0;
>         case KCOV_UNIQUE_ENABLE:
>                 return kcov_handle_unique_enable(kcov, arg);
> +       case KCOV_RESET_TRACE:
> +               unused = arg;
> +               if (unused != 0 || current->kcov != kcov)
> +                       return -EINVAL;
> +               t = current;
> +               if (WARN_ON(kcov->t != t))
> +                       return -EINVAL;
> +               mode = kcov->mode;
> +               if (mode < KCOV_MODE_TRACE_PC)
> +                       return -EINVAL;
> +               if (kcov->state.bitmap)
> +                       bitmap_zero(kcov->state.bitmap,
> +                                   kcov->state.bitmap_size);
> +               WRITE_ONCE(kcov->state.trace[0], 0);
> +               return 0;
>         case KCOV_DISABLE:
>                 /* Disable coverage for the current task. */
>                 unused = arg;
> --
> 2.50.1.470.g6ba607880d-goog
>

