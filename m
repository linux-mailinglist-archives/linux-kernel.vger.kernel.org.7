Return-Path: <linux-kernel+bounces-839293-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A9D2BB1441
	for <lists+linux-kernel@lfdr.de>; Wed, 01 Oct 2025 18:39:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 055DF17C071
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Oct 2025 16:39:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03CA4287262;
	Wed,  1 Oct 2025 16:39:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LVaUbinE"
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA9E6287244
	for <linux-kernel@vger.kernel.org>; Wed,  1 Oct 2025 16:39:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759336784; cv=none; b=m1rYejyfzW89tUFABwnxhMowCZhD8svVD6dZVfRDKN79b0isIXUTjPQVaGRZg82ryXI0K7X6qg8m6zCviopdSLrjVIeiOVoIzU8ri9yNAJQxvAgPpQpQz2qA3CRuyP3pAuw3lk/wDOaTJ+K3RG1WlVF9A8M0NQcbl1PkmG1+h1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759336784; c=relaxed/simple;
	bh=5pOEezS/qP6F4jEWoeOm7Fz3N7TCVGrsBiLzB3qwz1w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qDu+phQiC1ul3HObycKtZz0lT1OcDYFhWteKRxMn6TdV4mVlJhuBFEnUomIYNMyQDHzr8Ozi2lYTJ3cwh77hI6l/ykY97E+pnoHcN1Dw+hTKGCSPPgP/LVraABMYQHeGmcewr6IR2Vjbg4FcBgp1ZkJ0pcq51i5Rsw/KM0X2n9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LVaUbinE; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-77c1814ca1dso94281b3a.2
        for <linux-kernel@vger.kernel.org>; Wed, 01 Oct 2025 09:39:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759336782; x=1759941582; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RmGKlN/jBsVenanHceP4S7aQlFVvNQtOwGJQtiqwWbA=;
        b=LVaUbinEuK4XM9JBMP2MiBggPrSFpDlqa1rFmwMq79/y5Mse9lUi5GCYJ5Ag3oqV+q
         iyfZ/sKixrbEpRWGx4d+1xq+7NWAzgKwvWOoG0AP8hmSCXR0GtEm7PkLWxtQsH/wo2T1
         ZY1wuvPwuihxocXt27fu6e+wNI48FTpXtE6QhAIv8TNZFtawES2WKj7LXk2l+nkMDZHW
         YOkcVOFUr7MJji4vN7g5g+8p3Se/MCLg+BRr02S0DprzdSBT641P0YAV+30AYtHsUnfK
         Wri1ogMSLCXK1cpBpvs4GaO4sHfuktCXpR/iwWXUWD7g3t40h1oKlO+DHsOf7FRHfNwp
         zSaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759336782; x=1759941582;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RmGKlN/jBsVenanHceP4S7aQlFVvNQtOwGJQtiqwWbA=;
        b=PQWDIuV7Ihyqei+pj4BalYboZujgsOAwIlXZpEt/AZB7yy3Rt4XGkgTQXcmCpxOLdZ
         TMJeOLGcRHS7nsqhYpRMM8+VUg5yfC4eu1Q6QgtOTQJkEUvm1WV53ADFhsCAiki3O+n+
         z9/7yocGaeKubZ5+oqPa+sldNY7Dd1s0rmnDpq+k6gTJiGlAvLKzMoNk2A52sHVv7GtN
         QHWZ0SrxUS9XvPYGlR4HhYl5U3Ewfi88CyGNjc7LE8s5JlPX3T4pZLwAP641XNVcHXy9
         1U5q3O/a/oQyX7Stkxnv+u2Wl4st7KNYSlm9LuilKwj/api9+Ao1PVeAV/DoB/ZxMf4t
         0j6g==
X-Forwarded-Encrypted: i=1; AJvYcCVPVdKje8gd2/2K1sTmf4yfZWHRdHVSpR7QkXnFISpc1EDu7YTUXpqVk3kyTFBR912+7Y2/Qdbhtc/pIK0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxKd2mTwEV5AHbeLVSzHlS6fLTomthSfgOkoOMMynpzhwWegK6w
	EJofTbLz+16mnRmQYxbBlz+LxRy9jIlK9zNnHirXcB4Lrn6h79h3bFCBQ69uo2xv+tsyof7q2Fq
	fxvelL3WrTYMIfdYlZ+u7ZDWMTtPKgs0=
X-Gm-Gg: ASbGncu9LnhjmwbwdaZaxLR4JxhWSS6Wh2gUzNqskvLAhY15owsj0ODTkK+xzKhpML5
	KS/4vBJq8guYywn/qg1IdbzkeIVG6eHdbNleY1RyWekN6qTiRL+f54pJT0NYj2m2sK5fApZSc0F
	/b8omcss3U9tK4qChGJoVh7B1w13xZ7+x7f/BmwjkiRB1Y1oHYccHypJpuNzxR16QHtswE1Oefy
	KiexugCzUzJ66rNJ18hSltoQWuAODZO9IzPVjFkfU5/ATE=
X-Google-Smtp-Source: AGHT+IE9y4z9vj8j7yKhBcDb2apGorlG7PINT4jHURs+aWjIj8z/pwVAMIEXfRoJqNuQ3Mw/cwz7seK+Az+n+Pf6vm4=
X-Received: by 2002:a17:90b:1e0e:b0:330:7a11:f111 with SMTP id
 98e67ed59e1d1-339a6f84d53mr4930805a91.35.1759336781992; Wed, 01 Oct 2025
 09:39:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251001132449.178759-1-jolsa@kernel.org>
In-Reply-To: <20251001132449.178759-1-jolsa@kernel.org>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 1 Oct 2025 09:39:27 -0700
X-Gm-Features: AS18NWBXWfduYxqUtnH1tABDYMsrbfqkNZtEA8ABmNwPyaBnTu4oL0vq-aat2Hk
Message-ID: <CAEf4BzYMDgo2JQEkV7e6rnX1Jwu4QMFdqEsnRcxL2J0ukLxU=Q@mail.gmail.com>
Subject: Re: [PATCH] uprobe: Move arch_uprobe_optimize right after handlers execution
To: Jiri Olsa <jolsa@kernel.org>
Cc: Oleg Nesterov <oleg@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	x86@kernel.org, Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>, 
	John Fastabend <john.fastabend@gmail.com>, Hao Luo <haoluo@google.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Alan Maguire <alan.maguire@oracle.com>, David Laight <David.Laight@aculab.com>, 
	=?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas@t-8ch.de>, 
	Ingo Molnar <mingo@kernel.org>, Jann Horn <jannh@google.com>, Alejandro Colomar <alx@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 1, 2025 at 6:25=E2=80=AFAM Jiri Olsa <jolsa@kernel.org> wrote:
>
> It's less confusing to optimize uprobe right after handlers execution
> and before we do the check for changed ip register to avoid situations
> where changed ip register would skip uprobe optimization.
>
> Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>  kernel/events/uprobes.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>

makes sense

Acked-by: Andrii Nakryiko <andrii@kernel.org>

> diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
> index 5dcf927310fd..c14ec27b976d 100644
> --- a/kernel/events/uprobes.c
> +++ b/kernel/events/uprobes.c
> @@ -2765,6 +2765,9 @@ static void handle_swbp(struct pt_regs *regs)
>
>         handler_chain(uprobe, regs);
>
> +       /* Try to optimize after first hit. */
> +       arch_uprobe_optimize(&uprobe->arch, bp_vaddr);
> +
>         /*
>          * If user decided to take execution elsewhere, it makes little s=
ense
>          * to execute the original instruction, so let's skip it.
> @@ -2772,9 +2775,6 @@ static void handle_swbp(struct pt_regs *regs)
>         if (instruction_pointer(regs) !=3D bp_vaddr)
>                 goto out;
>
> -       /* Try to optimize after first hit. */
> -       arch_uprobe_optimize(&uprobe->arch, bp_vaddr);
> -
>         if (arch_uprobe_skip_sstep(&uprobe->arch, regs))
>                 goto out;
>
> --
> 2.51.0
>

