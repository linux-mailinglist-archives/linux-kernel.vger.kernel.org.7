Return-Path: <linux-kernel+bounces-727866-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E3C3B020CD
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 17:46:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2A42E1CA1016
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 15:47:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D998D2ED149;
	Fri, 11 Jul 2025 15:46:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ij9y8cry"
Received: from mail-il1-f171.google.com (mail-il1-f171.google.com [209.85.166.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5E0D2E7BD4
	for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 15:46:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752248812; cv=none; b=jsMcSHGbEL9XCmp/VrMIHSEmeeHnVPPP8YY5SsLXzxcIXc5tqgntxKv7er87TriwM80yq/HO5n2+/cwjCwggbJnmlsrOn6VkiBqRmQWSppiWaQaem8BkKe/FmzfSMyaV7TQ4NFNFYMErY5xdmMidnTb7ZvmSp8LYMQ0vD+dgSDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752248812; c=relaxed/simple;
	bh=hEHkwPv8vsX51jUtxtRrJb0yEIZ/va11qr9IMnIo72k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ao8qWq21EVc6THhuEHm0QHS2c8mf2LUSQdeYL4QgRe0layUsR1YB5pG8es3XlC6ZltdHNZ1XzMaH7W+zZMmO7uULoSOapw6XQfrnwjpqdL4RuqDAxwudl5WUzkRKj7M7s0oHo3DwD/T4wqHGaWVJTkEQOMnY14e2mRH5EJBXBN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ij9y8cry; arc=none smtp.client-ip=209.85.166.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-il1-f171.google.com with SMTP id e9e14a558f8ab-3df2fa612c4so217345ab.1
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 08:46:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752248810; x=1752853610; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z9LqmVHDuYjrYkUHFpQS2h/9pWr7Qcff0gqlSRds5QA=;
        b=ij9y8cry5zKbeSoguhwwvLt2kBdgfp7Xadvs2qxAIQ4Dx4FOj9/fqh9kAv8S0khnu6
         xpeol0AW6b14WGIRfDiEokDqd5ku+RCSMAG5rMy6pXRKVzuDlvQ2v/cO/H5az4LEmo1r
         hvOOlLBdu4kJyyR8nPzmPU2T1UZqgmjyOaSu5iMvWi/PBVz3XyEK71YDDAsfA2+hH3YH
         W52aPpWyfaNaNvFGtxjz01Q50UeZOQyPOKRMnYIYuyxutjwIB1SAhi3gxmbjMs4TpBuz
         C6FI0mZKoe9ayQ38Vl3H675DStK88/OqDHg/e4k+rt752ufjv2+7BjgZ8qt0zNoFBUCA
         XwFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752248810; x=1752853610;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z9LqmVHDuYjrYkUHFpQS2h/9pWr7Qcff0gqlSRds5QA=;
        b=FA38SJGbIo0sLMa3ycq+GLOHqXEyz3Iy3cxQN+9zOV6psvUYSEG1tuf3KFWexw83MN
         dYdAqYKy81mOi4GY85hwak1CNMqzohju/R0ZWRqnpUSrzY7xW0VHbr3XuUuWocyAn6Np
         krJ4AW1sGQsJV5LEjF6GU1DEPvsBRIqrDIfVqrZTq97gWyPlbQvnFR4eSezRAMHNdkIC
         8rGEcC0hUp7TkXmFmgMqP0qUwMD7RGw5LeLecwN7eI/eSH4HOvP6aM0RkK0BAHhotapk
         hOuvt0kI28hyXOlGqkALWe3Y7o3rqjMCgFkpzrQesG95eT5TCzmCE2fSCy010OForGww
         rYsQ==
X-Forwarded-Encrypted: i=1; AJvYcCUghULF5YxGMd38ncu401L9kYJte9ZzZNaMScMddCsSlMrUwtGF1JomtDvjYlHnX/6mzcL5A2G2zv7MH50=@vger.kernel.org
X-Gm-Message-State: AOJu0YzmfSNd3WfnVqP2u0Nk8++KoTzYrNJ8JH7G+3S5hNPLMqRTXvaS
	EzcDjwYxoHA2EyDL2ywbSIr+DqsvARbZa8/OktpRn41ix5tAX3XGU4MgD2QE1QYRNTkhlxE8u7i
	JO+eG64e/ebw4Ieqagszdfi3ni4Uobrw6onvuTh8y
X-Gm-Gg: ASbGncsyqAmjWWF/uW3oCp0VQiVv9qEfA12o5zQNAQji5BszGejvLbcVqN41ktKafCL
	TPuCH+0i0Laj+ebI/mOKKl33eRKY77sCM9JjgBuuYiXP2ZyWmWEryZiyyAJuXdVw6EjVeID7UrW
	OjJoJjcAJ5pV3nkb/2eHzdjIFmlZtcyzGBLmt2zILcXCvWSzo7YEFB5CcnRJTkOHGm5fd6cZUHb
	HE/YEosM/tiCT/cTA/2TWVxO2ehTSIUk494
X-Google-Smtp-Source: AGHT+IElNwBTran63IPg0x97+HFNaKKHbcj1unKuPYglJNVo+L/yKBGkHlmmaOLE3DhFEnvPNh7wVuKpa8qUZCoROHk=
X-Received: by 2002:a05:6e02:2181:b0:3e0:5c48:8431 with SMTP id
 e9e14a558f8ab-3e254924c8dmr3420505ab.19.1752248809533; Fri, 11 Jul 2025
 08:46:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250711-perf_fix_breakpoint_accounting-v1-1-b314393023f9@arm.com>
In-Reply-To: <20250711-perf_fix_breakpoint_accounting-v1-1-b314393023f9@arm.com>
From: Ian Rogers <irogers@google.com>
Date: Fri, 11 Jul 2025 08:46:38 -0700
X-Gm-Features: Ac12FXw9Cg9avYPcJ5rB7lmXzqZ-O_1TpTo4ihzBu-TkAjB6N4I4vj_GQT1A1HE
Message-ID: <CAP-5=fUghVs4hHxnAc6cTs+SfmR7+pS4bOpMXJF_kX5UchUt4g@mail.gmail.com>
Subject: Re: [PATCH] perf tests bp_account: Fix leaked file descriptor
To: Leo Yan <leo.yan@arm.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Aishwarya TCV <aishwarya.tcv@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 11, 2025 at 4:10=E2=80=AFAM Leo Yan <leo.yan@arm.com> wrote:
>
> Since the commit e9846f5ead26 ("perf test: In forked mode add check that
> fds aren't leaked"), the test "Breakpoint accounting" reports the error:
>
>   # perf test -vvv "Breakpoint accounting"
>   20: Breakpoint accounting:
>   --- start ---
>   test child forked, pid 373
>   failed opening event 0
>   failed opening event 0
>   watchpoints count 4, breakpoints count 6, has_ioctl 1, share 0
>   wp 0 created
>   wp 1 created
>   wp 2 created
>   wp 3 created
>   wp 0 modified to bp
>   wp max created
>   ---- end(0) ----
>   Leak of file descriptor 7 that opened: 'anon_inode:[perf_event]'
>
> A watchpoint's file descriptor was not properly released. This patch
> fixes the leak.
>
> Fixes: 032db28e5fa3 ("perf tests: Add breakpoint accounting/modify test")
> Reported-by: Aishwarya TCV <aishwarya.tcv@arm.com>
> Signed-off-by: Leo Yan <leo.yan@arm.com>

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  tools/perf/tests/bp_account.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/tools/perf/tests/bp_account.c b/tools/perf/tests/bp_account.=
c
> index 4cb7d486b5c178c622be4fc7e9c8c5a924df9d9b..047433c977bc9de4f8984268a=
2a9826d6bfa6f17 100644
> --- a/tools/perf/tests/bp_account.c
> +++ b/tools/perf/tests/bp_account.c
> @@ -104,6 +104,7 @@ static int bp_accounting(int wp_cnt, int share)
>                 fd_wp =3D wp_event((void *)&the_var, &attr_new);
>                 TEST_ASSERT_VAL("failed to create max wp\n", fd_wp !=3D -=
1);
>                 pr_debug("wp max created\n");
> +               close(fd_wp);
>         }
>
>         for (i =3D 0; i < wp_cnt; i++)
>
> ---
> base-commit: a62b7a37e6fcf4a675b1548e7c168b96ec836442
> change-id: 20250711-perf_fix_breakpoint_accounting-ea3e8b2e8f51
>
> Best regards,
> --
> Leo Yan <leo.yan@arm.com>
>

