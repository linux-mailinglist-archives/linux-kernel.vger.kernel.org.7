Return-Path: <linux-kernel+bounces-734785-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 723E9B08653
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 09:16:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F2A8D188B7CD
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 07:17:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD4562163B2;
	Thu, 17 Jul 2025 07:16:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ypo9tK6O"
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA7271F4717
	for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 07:16:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752736607; cv=none; b=XaYeoj67pl59vKcn9mtJGcGOzbmZ6K86RBmNnagwdJEv99lsla0UaALzkUtONsPXdbVectK434d/Fmq31r0x6YH0pxbzxAIZhU4InJRr8lGN+HRAmTUPRRcKglZ6O4auWjdONkzHHNegcj2hnm/TryPzfHtD59GiLCZf4ypseXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752736607; c=relaxed/simple;
	bh=pQbYU/ZisgZ7m51h8Lj/betvQUNKhzX0W/ltLCati4w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gCtwbkdFrEA+Ec1vm/ScrWYftjiQJv6dE29CGA7I5FOZWAZHzveJ0gBn3uCzjRAIHr+kjozHtW3v/NORSZ9iN/TI4jnp0WChUMKqpBRLuM8d4mEcPux1CVpis7ttUrFy7MNQNWOwlaqO0lhhbFv0U0m0pzGgIc9/oTajDHoOIR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ypo9tK6O; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-3135f3511bcso626188a91.0
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 00:16:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752736605; x=1753341405; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=WIe9kkvkYYKGSFuvVvovx0O+wBZjypzfMuU0ydKokdQ=;
        b=ypo9tK6OruspEwFfAp1om/wL63Fj7X1Go7EF4IQ7hFli5X5IeOq5HLX/Z51v5hZThA
         bks90dafTVyi2HXkpog6563VuaFHhVrH5+nxjY4Nt/G4/jPyDGjyLYG+cxgZk2hdUymn
         ZaCIbr6B0W5aBxg5xMRJ5IytDcyki2TT7JDc2pCwlnkQK39XjodhmpLLIO9hmrCvlQSe
         lLjtmLSuRXZ+RxNqmz9K1A1T5ttbsGc2G1J6NuuH/eDi1lEunLCMhdlVsUYsKbjNvD7i
         AQ5AwPQkmiJ4xsTV8VzZhoa3ji6TtMdNWgceWRpSGoneYRqiei8bah48nYo8VnQby9yJ
         Z9Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752736605; x=1753341405;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WIe9kkvkYYKGSFuvVvovx0O+wBZjypzfMuU0ydKokdQ=;
        b=sypsnofwcrO1Tuv5qEjf97cDwT7fBalQYbhdQygSTWXmbRi47w++FoA/l5RxZQXrWB
         HFPv+5t55ZUrxK0yN2CHfR/vbnots6w6ZYyc7iIy8HR5x5MUkMaC82ONH77IjNlieO35
         ZVP9tgT1e3zEzhKukOS0W2aL29RvYg2ak+SGjRwEkmhm08WyDtNhznZ8BuBVHCM05HGq
         9879zUGkUsr8qQcH5M7mM3TZefI4GDZWJEjAYYBUearnPE32yfgfYq4MlBkDeZDNvygi
         FBgmEAgeUhBfMtaJDuXtOSe6MlEU3WfhkrWivYh1QA0psHkmlHv+Fk8O8qVECFU631EA
         O2pA==
X-Forwarded-Encrypted: i=1; AJvYcCX9byD18tFMMXOV5o5BvmTgfQYGAuqgMPO4zPtBPmYp63Bk5kwghTFZnK5nNmBnqzx+iWDZ/CQXpibMlCs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2j8N3/y7qmx1D7zRs6C9z6MJqcLrrmD/sKcQdx4n3jdOQian4
	9S5FNKmlrb+/a/Tngk83E4q1VU4iXRqrlfnICmFP5sFYa3WWcQgvupSLPr+EHfUMq6ql8Iyq6zD
	w3CsMEMo7VwUk2neg1d/tEexcbW+LKU0HvsdIHLTW
X-Gm-Gg: ASbGncs8Zi9zFPxslvRDpt9jPMQAj7vunf5+kLMQI22pabxAWZgPxYr3YLQUYXDAb2F
	J8y2NdRJroN0OpQEIhpgoMoKHJ7Y3A2Csg4+x/nxlcY7QHGg4LUDtj5jPcOyjZW+vQaotKYCLtR
	BNV+wX7LDMO2JrjLFS7iKHMOAblyDFl4dSW6UqxYMttaQjFB6FoKzuo2KKc6XeC/LTQimyk/62o
	Rf1YYvUoR+vmPimHIoeoOsOCurFaBZZR4P3z68=
X-Google-Smtp-Source: AGHT+IGuwDb/Zb1AOUTWi1jQ+mRgDJH9YnPmVg2E4AO4ywS69LBaM9bnyyo6EMPuiJfBPIDutXQNY8IhHCijuUmDxDg=
X-Received: by 2002:a17:90b:2684:b0:311:ff18:b84b with SMTP id
 98e67ed59e1d1-31c9f47c7d7mr7122717a91.25.1752736604492; Thu, 17 Jul 2025
 00:16:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250717024834.689096-1-sohambagchi@outlook.com>
In-Reply-To: <20250717024834.689096-1-sohambagchi@outlook.com>
From: Marco Elver <elver@google.com>
Date: Thu, 17 Jul 2025 09:16:07 +0200
X-Gm-Features: Ac12FXwIGhVeEpUQ0grjozMyt1Ndc63XTLmOY3WAMnQKcc2xypvxOlA-e1Ryozk
Message-ID: <CANpmjNOu2bqqevOcPGmZR1Dp69KFY9-TW3i2i_37BCTcE5rYSg@mail.gmail.com>
Subject: Re: [PATCH] smp_wmb() in kcov_move_area() after memcpy()
To: Soham Bagchi <sohambagchi@outlook.com>
Cc: dvyukov@google.com, andreyknvl@gmail.com, akpm@linux-foundation.org, 
	tglx@linutronix.de, arnd@arndb.de, kasan-dev@googlegroups.com, 
	linux-kernel@vger.kernel.org, Alexander Potapenko <glider@google.com>
Content-Type: text/plain; charset="UTF-8"

[+Cc glider@google.com]

On Thu, 17 Jul 2025 at 04:48, Soham Bagchi <sohambagchi@outlook.com> wrote:

Patch title should be something like "kcov: use write barrier after
memcpy() in kcov_move_area()".

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
> Signed-off-by: Soham Bagchi <sohambagchi@outlook.com>

Thanks for the patch.

Besides the minor nits, this looks good.

> ---
>  kernel/kcov.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
>
> diff --git a/kernel/kcov.c b/kernel/kcov.c
> index 187ba1b80bd..d6f015eff56 100644
> --- a/kernel/kcov.c
> +++ b/kernel/kcov.c
> @@ -978,6 +978,15 @@ static void kcov_move_area(enum kcov_mode mode, void *dst_area,
>         memcpy(dst_entries, src_entries, bytes_to_move);
>         entries_moved = bytes_to_move >> entry_size_log;
>
> +       /**

This is incorrect comment style - this is a kernel-doc comment, but
not appropriate here.

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

