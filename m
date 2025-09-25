Return-Path: <linux-kernel+bounces-833035-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 907F4BA10DB
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 20:41:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 50AA14A04A5
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 18:41:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7A4A31A804;
	Thu, 25 Sep 2025 18:41:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aUE9gCqu"
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9E7E31A554
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 18:41:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758825672; cv=none; b=I5sC6uqXepb+9QO9s66Fsyf6lY7ddl1kit1scWTSnDALxj4V2TSaqDs8/4G6VjfNv/xnRtsdxHUL6JJm81JkZvWYjqjCJ4MWd6Vpv0Ye57MxmknUK7+u3FQ9epbSWlrAOeePR8/ZSHvjIuXvnBkYW/RoZK7D/W3jOlRS2EZIJeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758825672; c=relaxed/simple;
	bh=4HyO/Omc0vHIbcGIr8eQR588wv9P0GcwZPgiYarPRNU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Tcj8oaC43uNZZIT2vFRRM1t3k+94JTCrs8oWaqXXjKl0RK+9gCBmz9wVqKVX2i0lGaP2xB4F9O5IDaINwlm4/2ImT5r7N4oT2sy+hAUe/28Soj4/rrmSWTTg7D9s3aT8JqvLl2GgK1LiSTLD9ydvTHw/cuyw2tuR/4u/7ZJrPDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aUE9gCqu; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-32b8919e7c7so1659840a91.2
        for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 11:41:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758825670; x=1759430470; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rEVxXuxy2iSH4P0+ikQL58PMDB8CgXAp3tIeCVGBulg=;
        b=aUE9gCquWkY78WVnTKFKVQAruEQAmRQoQo/hME6eATizrCtxhHIO7IYiwddQ9VsI/3
         A229sduPkRgv4LfibQDVu9P6E1WJ4hcp+X6H4yjeRdOJgUIN3dJ7VR30Xt7fEtX97OmW
         ikoUJI+CkB6Tr6LMhPmCBmxePi2obhObTjmiJzUXIyGzfjnzz8XSVI4a+lF1IvDuQpkE
         7uFBlYbuHW97pyl2emPLDS48OiTM7uN7O5QUrYVIvukBO4QFjYQzxMzVwEHrFOhZbLMG
         WSTtX7RAijyieeYneTWjA4TwG2jqbr2ftZg3pj87SjI0gp9fLF6LHX1ryuY3zddQPy/s
         auqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758825670; x=1759430470;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rEVxXuxy2iSH4P0+ikQL58PMDB8CgXAp3tIeCVGBulg=;
        b=VNaTqdjaLPO0zJ+tOADnxUf8CzjQGuzuFASLRNl8SUUlGu6G8jlvOe1mOMALyHNm9x
         cHfGJnRtUzZEWzy1W2bcqe/6z/eTKrLLptEANxzT9kXxVXEBM7OvjEGXY+APx9qwASRM
         gEfgListJEUgKmQ1eLIyUh1OO43/TgcWepUoFfR3ZpFyxCHNSasjKshQ2B3ub7TIaniJ
         pKqWVOBHSAWfivnkOjdfskkZH3zClKw26TcNnSpruc+ULl9ntTiSeTvFX9586Q/8ZG76
         T6KiYcUiLgUub59WgjV8nuev16D1wG8o9xpu+rIfaMi/7zPNQG1yRzAo2GNFlVE2fd3t
         b65Q==
X-Forwarded-Encrypted: i=1; AJvYcCVgXBGhVtSpuqApfzRMGY3OvEoIOCELKGAhCKHrXTiHvmldiFxUxP7i5puIuvK3g0pZSTnH4iJRNK4M6i8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyExqM0YvyJzUETjIbnNJDR+vmIrm570NurlNc5TE8yYNgDlXM8
	Mb6MGW5Zl+oyto1XrDOzM5l6r95hC70+YHI44NPIWA517XoRelL+1W7GL1YXVCEWl71BRcCayVh
	TU2vPoKIWYCLzmxvuYLM96fKqkEH5/ag=
X-Gm-Gg: ASbGncvwgCSE92z5ktbuWTlv8bpQ0a+JD5tlSbNz6zdR4EPBiP9OWn5gt5bblGetHGO
	2Hin9b9QOOONZQzO8DpossjfgLj1zgsEg2nXfkiW6aEgNd/dut7Uz1F2HCY/5AdAl5D9vg+utCJ
	CHqpWzeZmIQ7mh0EWP1V4GnWOrDvnLWVLJvekXSZduCMCLL5B9RpEs4VQe/GmmG82Q7e9akhqk9
	kO+gVAu0DiZdH8NHo0UZ8U=
X-Google-Smtp-Source: AGHT+IGif1F0rH2+wJaNW1qXDTLPrW2/+7ZSS24YvD5gYvwrK7txwD5NgoCPK+1mrFy90rRGnvqMUSh5PdeT8seK+mo=
X-Received: by 2002:a17:90a:a783:b0:330:6c5a:4af4 with SMTP id
 98e67ed59e1d1-3342a2df0e7mr3743478a91.35.1758825669903; Thu, 25 Sep 2025
 11:41:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <580ea2de-799a-4ddc-bde9-c16f3fb1e6e7@paulmck-laptop> <20250923142036.112290-19-paulmck@kernel.org>
In-Reply-To: <20250923142036.112290-19-paulmck@kernel.org>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 25 Sep 2025 11:40:54 -0700
X-Gm-Features: AS18NWDkeNOIzlcIpXV73ff3DZBfv87h1AghtZqbjYi5a1vEtT0YGqQqdWBwurE
Message-ID: <CAEf4BzazpB6XHL+HRO0HaegiwCUpXaTi+QSnPAxsW9BHBL=50Q@mail.gmail.com>
Subject: Re: [PATCH 19/34] rcu: Update Requirements.rst for RCU Tasks Trace
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: rcu@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-team@meta.com, 
	rostedt@goodmis.org, Andrii Nakryiko <andrii@kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Peter Zijlstra <peterz@infradead.org>, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 23, 2025 at 7:21=E2=80=AFAM Paul E. McKenney <paulmck@kernel.or=
g> wrote:
>
> This commit updates the documentation to declare that RCU Tasks Trace
> is implemented as a thin wrapper around SRCU-fast.
>
> Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> Cc: Andrii Nakryiko <andrii@kernel.org>
> Cc: Alexei Starovoitov <ast@kernel.org>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: <bpf@vger.kernel.org>
> ---
>  .../RCU/Design/Requirements/Requirements.rst         | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/Documentation/RCU/Design/Requirements/Requirements.rst b/Doc=
umentation/RCU/Design/Requirements/Requirements.rst
> index f24b3c0b9b0dc6..4a116d7a564edc 100644
> --- a/Documentation/RCU/Design/Requirements/Requirements.rst
> +++ b/Documentation/RCU/Design/Requirements/Requirements.rst
> @@ -2779,12 +2779,12 @@ Tasks Trace RCU
>  ~~~~~~~~~~~~~~~
>
>  Some forms of tracing need to sleep in readers, but cannot tolerate
> -SRCU's read-side overhead, which includes a full memory barrier in both
> -srcu_read_lock() and srcu_read_unlock().  This need is handled by a
> -Tasks Trace RCU that uses scheduler locking and IPIs to synchronize with
> -readers.  Real-time systems that cannot tolerate IPIs may build their
> -kernels with ``CONFIG_TASKS_TRACE_RCU_READ_MB=3Dy``, which avoids the IP=
Is at
> -the expense of adding full memory barriers to the read-side primitives.
> +SRCU's read-side overhead, which includes a full memory barrier in
> +both srcu_read_lock() and srcu_read_unlock().  This need is handled by
> +a Tasks Trace RCU API implemented as thin wrappers around SRCU-fast,
> +which avoids the read-side memory barriers, at least for architectures
> +that apply noinstr to kernel entry/exit code (or that build with
> +``CONFIG_TASKS_TRACE_RCU_NO_MB=3Dy``.

For my own education (and due to laziness to try to figure this out on
my own), what's the situation where you'd want to stick to the
old-school "heavy-weight" SRCU vs SRCU-fast variant?

>
>  The tasks-trace-RCU API is also reasonably compact,
>  consisting of rcu_read_lock_trace(), rcu_read_unlock_trace(),
> --
> 2.40.1
>

