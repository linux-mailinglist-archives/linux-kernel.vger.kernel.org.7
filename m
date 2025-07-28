Return-Path: <linux-kernel+bounces-748578-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F7FCB14302
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 22:28:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1338B164E5B
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 20:28:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2229278E75;
	Mon, 28 Jul 2025 20:27:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TUmrXMkz"
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B44AC217F23
	for <linux-kernel@vger.kernel.org>; Mon, 28 Jul 2025 20:27:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753734452; cv=none; b=GGyPXANc5721D1UygluT7V92IT0H6RjbPPIMndS3glBu7NPK1dcSxsYNvAKEhROC54A4vtqclTEZiJs1cX7Guej92qTftXQplqQWWzx2tdeaAmsThrTZLkmzyQp0UlP3T7jfy4jXl3a18j7laBMYtgsi1+1itD0gsU46k3wCu14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753734452; c=relaxed/simple;
	bh=WDDgULr439kgXv/N5YL4Rk9chzIOziT1SqS7cwPnB2Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=T5jSfASEM4pMxldUxgqrthKKmn8MZaepy39TQ02LVvdDenLV6i7wq06tspTxxnUqGLNRuS505YIcIJwysP3fmLTFmczGmvvORGAkJAYq7ZeMWHaTGJNeFaS6GWTmCOdRp4+RW8FJWcZoMz6z5DFVkb687BBV2QiY7U3KrFe+DVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TUmrXMkz; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-b39011e5f8eso4378975a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jul 2025 13:27:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753734450; x=1754339250; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=k6z/pDkQGQHJDGGW0WyP2y56SRGD0QXG8oTjmKwbrE4=;
        b=TUmrXMkz0v2VKITb/3lxZvGsmbaHlT5+wnBoyeSJXCaKOLhxUMkEeZdNbpuZxFj+if
         6YuI1hSItfLqG7MSkk43jMtmxGY2UZqSu558BHKO9oYMKp+0nRrtB0QX+zuURo6iwGbv
         xELCqmjgH5bHINF5/QGY0/C4a2HznYK37X7SyRUSK59HRhhTLymKm6Nx1+fMlp0jhPgZ
         056blBCOhaPpdHWLcyFnWt9lN70DgE0O6PfhfPWs0c+UB7xn/DYn0fLVIO6VcuCsG1IG
         ezOrehF6+A6sWSIdajnN4rbEZF5DYoHZRCVp2JLMts+q5WLalhFrUpNI3sK3MUonrYlO
         jNGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753734450; x=1754339250;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=k6z/pDkQGQHJDGGW0WyP2y56SRGD0QXG8oTjmKwbrE4=;
        b=q4ZoYDzkMV9kvbFyQ86EMbPDC8KLVAVp9mu1SvK+nqnwfj7oChl5fNEHJEFwhBKSEs
         KYUfYoX48R/AVjfOzjE7ce9bZocI0TdJjVXYn7CYS8AP+oazqbb1TgKudc7GHZeZf8cG
         Mtcf0ldsw+og/yGoI6ut6Ll3n24kD1qS0zmumPrMGWe0uBxLradRg27sWxRBy7Ic9E7Y
         Ifxm5TZKSMu60k3/XXxE73cuDgvBUfFjQhg3vG21Ks3nj0v4RhBN+D2kWAFN3uj49F8z
         y/x4kiBBf0FHJq6bYwP/cNDAGZpBqpA1AsQRpd2WMwiGF4DZ7czHApHjigxsCsA3hCLd
         Lgsg==
X-Forwarded-Encrypted: i=1; AJvYcCXj915eG5SaevdEim2m3pMpi9DikBpsiUc9Z1sPdzNtQJN45nEC3eL68OKQNTG7klEyk1zwd1+A3/hl70I=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQhYCgcXyh5RxtVncGegeWl/+J987jAYARZ53H+5gvjLbdQCxc
	GEeUujCh8QJSiaZhd1l4nIIdcYfwRzlRldnuxYUW3KJfltbShdm1h6dRQ+9KX0VyJbCBxstcVSs
	lOqu+D+SIV2QJ/AsKNB+FJP8cXfs9zzyHiYWd5keZ
X-Gm-Gg: ASbGnctoiM9Q191iGlkpYFdHRa77rZmLjaymvK8tYH0hr6bThM4blIr2yl381IpNQCd
	MamuHNd8IVfqLiptR4uvUgPhbxQotjhWbzrfjevAwGnkBgGYRn4otCYEX0rhYC/DXLwtkoe8puw
	dRpGcglGxpS+L5+8tzsK6HpS5tioUdl3N7fDTXe5PKV97uvwaj+O3FRqWLdj0pjiSpQf5P/X0IA
	cQLN97VjgzuWGzyGnD4L9cpXgm85vNpD8ydiMXp0l/Zqol84g==
X-Google-Smtp-Source: AGHT+IHTsZAhRmKRmO9BItm1tujCHlY2sj9Ka+sACUwnvT/m2J+eLpM9xwe+06nfHk8StigQGDZ/ZcCxT5SmUhrt6TQ=
X-Received: by 2002:a17:90b:17ca:b0:31e:4112:4031 with SMTP id
 98e67ed59e1d1-31e77a4a2a3mr16714413a91.30.1753734449857; Mon, 28 Jul 2025
 13:27:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250728184318.1839137-1-soham.bagchi@utah.edu>
In-Reply-To: <20250728184318.1839137-1-soham.bagchi@utah.edu>
From: Marco Elver <elver@google.com>
Date: Mon, 28 Jul 2025 22:26:53 +0200
X-Gm-Features: Ac12FXyPiMnImA19a92DEHCy10HpY4KQmzQuVM_kBdjTuWMJ5YVQbefnl37AKdc
Message-ID: <CANpmjNOP5OFX4LDNkfYdJMTDUEmEDpw9ha41Og5zbKt+VKZuzA@mail.gmail.com>
Subject: Re: [PATCH 1/2] kcov: use write memory barrier after memcpy() in kcov_move_area()
To: Soham Bagchi <soham.bagchi@utah.edu>
Cc: dvyukov@google.com, andreyknvl@gmail.com, akpm@linux-foundation.org, 
	tglx@linutronix.de, glider@google.com, sohambagchi@outlook.com, arnd@arndb.de, 
	kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org, corbet@lwn.net, 
	workflows@vger.kernel.org, linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 28 Jul 2025 at 20:43, Soham Bagchi <soham.bagchi@utah.edu> wrote:
>
> KCOV Remote uses two separate memory buffers, one private to the kernel
> space (kcov_remote_areas) and the second one shared between user and
> kernel space (kcov->area). After every pair of kcov_remote_start() and
> kcov_remote_stop(), the coverage data collected in the
> kcov_remote_areas is copied to kcov->area so the user can read the
> collected coverage data. This memcpy() is located in kcov_move_area().
>
> The load/store pattern on the kernel-side [1] is:
>
> ```
> /* dst_area === kcov->area, dst_area[0] is where the count is stored */
> dst_len = READ_ONCE(*(unsigned long *)dst_area);
> ...
> memcpy(dst_entries, src_entries, ...);
> ...
> WRITE_ONCE(*(unsigned long *)dst_area, dst_len + entries_moved);
> ```
>
> And for the user [2]:
>
> ```
> /* cover is equivalent to kcov->area */
> n = __atomic_load_n(&cover[0], __ATOMIC_RELAXED);
> ```
>
> Without a write-memory barrier, the atomic load for the user can
> potentially read fresh values of the count stored at cover[0],
> but continue to read stale coverage data from the buffer itself.
> Hence, we recommend adding a write-memory barrier between the
> memcpy() and the WRITE_ONCE() in kcov_move_area().
>
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/tree/kernel/kcov.c?h=master#n978
> [2] https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/tree/Documentation/dev-tools/kcov.rst#n364
>
> Signed-off-by: Soham Bagchi <soham.bagchi@utah.edu>

Reviewed-by: Marco Elver <elver@google.com>

> ---
>  kernel/kcov.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
>
> diff --git a/kernel/kcov.c b/kernel/kcov.c
> index 187ba1b80bd..f6ee6d7dc2c 100644
> --- a/kernel/kcov.c
> +++ b/kernel/kcov.c
> @@ -978,6 +978,15 @@ static void kcov_move_area(enum kcov_mode mode, void *dst_area,
>         memcpy(dst_entries, src_entries, bytes_to_move);
>         entries_moved = bytes_to_move >> entry_size_log;
>
> +       /*
> +        * A write memory barrier is required here, to ensure
> +        * that the writes from the memcpy() are visible before
> +        * the count is updated. Without this, it is possible for
> +        * a user to observe a new count value but stale
> +        * coverage data.
> +        */
> +       smp_wmb();
> +
>         switch (mode) {
>         case KCOV_MODE_TRACE_PC:
>                 WRITE_ONCE(*(unsigned long *)dst_area, dst_len + entries_moved);
> --
> 2.34.1
>
> --
> You received this message because you are subscribed to the Google Groups "kasan-dev" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to kasan-dev+unsubscribe@googlegroups.com.
> To view this discussion visit https://groups.google.com/d/msgid/kasan-dev/20250728184318.1839137-1-soham.bagchi%40utah.edu.

