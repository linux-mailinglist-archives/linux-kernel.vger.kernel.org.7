Return-Path: <linux-kernel+bounces-776380-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 357ACB2CCBA
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 21:01:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D47281BC5531
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 19:02:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D316526A09F;
	Tue, 19 Aug 2025 19:01:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MjlNt0fb"
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E08F92032D
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 19:01:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755630099; cv=none; b=Q7Cy34zQ+cA4ajVPu2jXWQglWNiJkJDUfOmr4HGfBU4okRtjSHMrkaoDKD3gC+ROxxFrOKqwAMQs8Bufn77YDIwXdtphbs/QWlQPQpq5CzNoaM+nxjy4zMkNxvNKwOfn7+VOhaa/97WiISvUutI7Z91WbLlXAIxEWLbKvrZoY+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755630099; c=relaxed/simple;
	bh=4uWhrX/2mNAcS/gMBK/6vJDEGnvfAe/pLU7PZA5FgBQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MQuE7b6T7MAOvVNPxrvHIa2n1Edk1Hq+VhwjksVzq31MKjPMAso/Rrp2pQupQmgIIrCpZcV9qx94T8cqVvzl3Plp2lV9k8TmVPCaZfQSmdy+X2oR7aKljVmluMqPWNIah1PJkUjslgpM4xydCRMyO7IuS/i25DbQuCi/nUGH8GU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MjlNt0fb; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-b471738daabso5182202a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 12:01:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755630095; x=1756234895; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=8qvuArYaZMFJV1RHzhtqqlTOKt/BCHit5YfuHRk9sg0=;
        b=MjlNt0fbUvuhz2Ygws2evfcA+L458A8/0Cpk6w9ZMa52adsSC0TdwxlPVNcrSkbp6U
         VZqKaCHruJSd8msKcMIBRnznkW91bbzHNLTJvOhvaqLBsyZOfYAMcmn9/BLqbWFnv5q/
         zV/PJGR+GqrlYoKwhO8bkJl0zAkG8FV5UDSjrCShvINmBoj4OK+yWEYFWy1Mbl5Wnb3x
         rm+4+WdaQu4/woy5SdOsxruYHypXd4p8ZK/sCzP0l0sm5bVFmja4BwaMSr3EwnT5KAeL
         aA5po0NmIH9VwMqwxlYiecITI2EGaS6zBtd3Ka94ybzSPcTlDf+MyP701+dCFfiqYeVY
         44jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755630095; x=1756234895;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8qvuArYaZMFJV1RHzhtqqlTOKt/BCHit5YfuHRk9sg0=;
        b=gd+r/k3EpSXKnbO+z/iRZ7ADkypvH+Q7vkt6kF+H3tctk/h/i7t7ODMMRlIlKIT9x7
         w+rs6FM+YZz/3Ht3fNxEHDh7d2m2lVH9cF3aBT9KGSNPr82a3/k7DIAUSydGVeswsti4
         nAs8JQJPLQYlaGP7UCLLgkrx6Ce9f8dtLCpF2Gdgs9nxJRHjHrZXW3a+eSIHLI+gCWFn
         9kN5huJcEH7oRPZKQ31he9Z4JjOvITZn1wcEL2YuMLgDzrOrij89lRmyLWRSPQ5jLrjD
         +IS9ib1HRHCp33zj5+LTnfQjDZT8kcia/EA0qeRR5+Iq4+W5aqVI2psZHjAlACu4UTEl
         pzAw==
X-Forwarded-Encrypted: i=1; AJvYcCXQwjPIeRYBksP9qwEewZYQM3mycp2sUrkH0FhryE0ZR838G4Rmb+FVZvlreeE76SaWlFzV1t1bgzZKwMc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzWvYxW9Ckv4qRDIdsBKZ4HaG0fr1GQrv99R3mx+qG0veCDCx9e
	4OuQuiOWkRTRBLOvZ6L73emliXvHRXWnmh1a8PMKE7oorEui+n3Jx9nYLDYxtxBlL4JW7Q54RdS
	0Dxjbz6jmFEiR+vX4e87w5r8HeESwOyyi3G/RXXn6YTKn3plZAhY0j723
X-Gm-Gg: ASbGnctoHsNSgaYSJbrLGSj3qDPaCQBZViK3NCkdGiwKvd8IHHJ/kUigEfXSUKDzMKN
	g8b9Ik+68c3gjAgXWdqUlejquEY1ZzmU3zzdvubg7nR20slD6HdZ48GxdSIVpzTfjt36cIDeXcA
	FHyGxceHSW/Jo+8ONCuurI7L3jyHFiajJt9qAGkkeiLsXzvxNHdg03KRv3GO/INyAMZ2T5ocX53
	aIg47RRsSCLSyutl8RJjYe6s7CP7lsXlgZNj3tdMNPx
X-Google-Smtp-Source: AGHT+IE/w9Ed+cmdAkyXk323HUtGTRtDIoia0hEETGRFT1hPBd7ibD+QoVmW4KplXUj3MKNL/ms1zGGJh8UY8mXETjM=
X-Received: by 2002:a17:902:ce01:b0:235:f078:4746 with SMTP id
 d9443c01a7336-245ef25bb33mr618995ad.42.1755630094952; Tue, 19 Aug 2025
 12:01:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250815213742.321911-3-thorsten.blum@linux.dev>
In-Reply-To: <20250815213742.321911-3-thorsten.blum@linux.dev>
From: Marco Elver <elver@google.com>
Date: Tue, 19 Aug 2025 21:00:58 +0200
X-Gm-Features: Ac12FXwZea5-tAvhMnunHuHJNaxPoH5DoA6U1F3MtQeyJo61FGS19PYEFJ-wqmY
Message-ID: <CANpmjNOLKQsVTvqV+OdMrNOaHoWnUq1TU-nTRBKGCzY87E7xUw@mail.gmail.com>
Subject: Re: [PATCH] kcsan: test: Replace deprecated strcpy() with strscpy()
To: Thorsten Blum <thorsten.blum@linux.dev>
Cc: Dmitry Vyukov <dvyukov@google.com>, linux-hardening@vger.kernel.org, 
	kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 15 Aug 2025 at 23:38, Thorsten Blum <thorsten.blum@linux.dev> wrote:
>
> strcpy() is deprecated; use strscpy() instead.
>
> Link: https://github.com/KSPP/linux/issues/88
> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>

Reviewed-by: Marco Elver <elver@google.com>

Taking this into the -kcsan tree, but might be a while until it hits mainline.

> ---
>  kernel/kcsan/kcsan_test.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/kernel/kcsan/kcsan_test.c b/kernel/kcsan/kcsan_test.c
> index 49ab81faaed9..ea1cb4c8a894 100644
> --- a/kernel/kcsan/kcsan_test.c
> +++ b/kernel/kcsan/kcsan_test.c
> @@ -125,7 +125,7 @@ static void probe_console(void *ignore, const char *buf, size_t len)
>                                 goto out;
>
>                         /* No second line of interest. */
> -                       strcpy(observed.lines[nlines++], "<none>");
> +                       strscpy(observed.lines[nlines++], "<none>");
>                 }
>         }
>
> @@ -231,7 +231,7 @@ static bool __report_matches(const struct expect_report *r)
>
>                         if (!r->access[1].fn) {
>                                 /* Dummy string if no second access is available. */
> -                               strcpy(cur, "<none>");
> +                               strscpy(expect[2], "<none>");
>                                 break;
>                         }
>                 }
> --
> 2.50.1
>
> --
> You received this message because you are subscribed to the Google Groups "kasan-dev" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to kasan-dev+unsubscribe@googlegroups.com.
> To view this discussion visit https://groups.google.com/d/msgid/kasan-dev/20250815213742.321911-3-thorsten.blum%40linux.dev.

