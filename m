Return-Path: <linux-kernel+bounces-819700-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C8A4B7DD8F
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 14:35:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B5A09585FD0
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 22:29:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97C9D32E2EC;
	Tue, 16 Sep 2025 22:29:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WSHnxAnm"
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DC4432E2D7
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 22:29:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758061749; cv=none; b=WFbctPZf2tldoAdMuzqSV22KF1QXiz11qG7jnGuUAqy4fdcsEwbIwk7DfcKWSobJ1nGhxAVxKWFPzoZd2Fkqydn6ubCbaMpNGZeJGS4yLPqkWkDL8zIBajJXXervBc6benpLomftly2Gry7UzL//MgpJAtHcaGwBOAG7RTnmWcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758061749; c=relaxed/simple;
	bh=GQRiMPLso4udFX4CB+sEYglBh5mmBczyDU9O0TBC65U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sXgcVmBBKHAU2cfAp3bXJ+nt97y0B8N5gP+6PL668obi9OX6BGpqN76cwCGIrkuOEb16Zg3H7OOn5P2JhWNqPwJYVXczIbXXCRhnTCZr5W5yYhuoL+2S9JIUoGsSImPhobiKCmtNQuGGJrYZUGMA6rGWl10S+Bq6x7zG64MkD4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WSHnxAnm; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-b54a2ab01ffso4251826a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 15:29:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758061747; x=1758666547; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4WprOe5/M+42SgMOPYQkTmIUA2Q1389Nu0dnK2gJe/0=;
        b=WSHnxAnmisQm9BwcqNhUrEh1Mb18UqZhLC3Umb/0KOoNk8zxCMQifaExiwN0eon23A
         6lPiKFE+EL6UHzah3cpzGfV51V0swQiDYDNmnY+LAxMwkxFK4tpl20gQpSvBWmxG9JdN
         mDFORNM6fZgmxVwdu42iY3Zc66DUXGMdTG8WxJXfVOEPUfLDbkqpbs81bKymEOo5a5N2
         xkNsEys5ihXe2SDfxFiD2XK534u0I0ctuCcy/DzYpD0kAOEh13lIpLbvxE9rXBrRTLwy
         BD9HVs4UeRVjX+0LNyEoN5aKvpEZq2hjo5nKlUJE4XLfohE5vroCKiCbCfoRPwFsuyav
         ex6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758061747; x=1758666547;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4WprOe5/M+42SgMOPYQkTmIUA2Q1389Nu0dnK2gJe/0=;
        b=FMWUEo9nnOiSBtGQJ4GZUo7er/t41wXpVGgoOa4uJzStRxKgBZRT/iF2zebeu5JSim
         UATtCOzr0t+6qjHSjgpYyqdl06arRs42RxqSqjrSBh4ZwILFJfhBedlBvF6O1Tx1s4A9
         IiC0pA0MQYhgJYy0igKWOf8lmvxfveRYD3CApRmqrbkE/mG33SsMEDpIW4uL4Lgeo2zn
         cSUaCpkp4xRg5YyQzyzEfoqOgJ1wnOjO428v/AeYqsPkGoX3o4T0950G1tfWuq4CVm8D
         Id/SrMTx61jh8F6UpI0hoqADYAUoOMxVgIWkypziR9OlKlDZU0wT2r3x1FNgbeIC9Dvw
         yZQA==
X-Forwarded-Encrypted: i=1; AJvYcCUcFz1hUUuRDBhBifCcd9xmbqgn0LuqyGIx71W4a/9iqasfGBrL+2fxoMT2qr/jH4Pnx4Sd6SDWWJ+noG8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwOWy9vlwdXSRglDtaoBY9l/0eBfaD+TDi7UIju2m8Jzum9S6fT
	o0Ls4DBXDqfsSJhXewL/trf6n5i+xk5tH1xFgOiSI4RdZXD628KxFeVnNh3NafG3GxAC1a9S1FD
	/a9K24uZ07UB2gcyDX1jsP+aBUyLRoFI=
X-Gm-Gg: ASbGncs3b4Gqef0a1tEgxFw9eITrQI0HnUPpbpXoI2ASfnQHWDrKcJ2CKNI+arosGxP
	WNcXvxDP3Aza7kodJ8KEEHAVDr2NPpCN5tjFUkCU32qZ61+/kGrRSTFfGLhrQkJY+e4xX0fZB4a
	dN0A3T9XrHxwRAXfBQXfQFbkBVt0SvzCcvmbqj7F3Hs1j6V7ZKY0ZrLGFDhTn6lgHfs4Rdy2eqw
	E5JvLGO3aNguGQRI+tXZc0=
X-Google-Smtp-Source: AGHT+IHBOnFSbfOjCWswssFIXUYknwoi8bxg+YaSZ0NlMLbN3Szk7M4gcBk+o1k+eZZc+Hhru+MlV+o4dEFHedKtN1s=
X-Received: by 2002:a17:903:2410:b0:24c:9a51:9a33 with SMTP id
 d9443c01a7336-25d24e9df3dmr201990295ad.22.1758061746563; Tue, 16 Sep 2025
 15:29:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250916215301.664963-1-jolsa@kernel.org> <20250916215301.664963-3-jolsa@kernel.org>
In-Reply-To: <20250916215301.664963-3-jolsa@kernel.org>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 16 Sep 2025 15:28:52 -0700
X-Gm-Features: AS18NWDXq8G0jhAXIKx9oMvchpwy_wkQP4mw4ZzusEgUYtrbuckohtBJ2yrw2Bw
Message-ID: <CAEf4BzYTJcq=Kk6W9Gz90gM=mw2fS2T-QBurUhdjBNinReDSjQ@mail.gmail.com>
Subject: Re: [PATCHv4 bpf-next 2/6] uprobe: Do not emulate/sstep original
 instruction when ip is changed
To: Jiri Olsa <jolsa@kernel.org>, Ingo Molnar <mingo@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>
Cc: Oleg Nesterov <oleg@redhat.com>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, x86@kernel.org, 
	Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>, 
	John Fastabend <john.fastabend@gmail.com>, Hao Luo <haoluo@google.com>, 
	Steven Rostedt <rostedt@goodmis.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 16, 2025 at 2:53=E2=80=AFPM Jiri Olsa <jolsa@kernel.org> wrote:
>
> If uprobe handler changes instruction pointer we still execute single
> step) or emulate the original instruction and increment the (new) ip
> with its length.
>
> This makes the new instruction pointer bogus and application will
> likely crash on illegal instruction execution.
>
> If user decided to take execution elsewhere, it makes little sense
> to execute the original instruction, so let's skip it.
>
> Acked-by: Oleg Nesterov <oleg@redhat.com>
> Acked-by: Andrii Nakryiko <andrii@kernel.org>
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>  kernel/events/uprobes.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
> index 7ca1940607bd..2b32c32bcb77 100644
> --- a/kernel/events/uprobes.c
> +++ b/kernel/events/uprobes.c
> @@ -2741,6 +2741,13 @@ static void handle_swbp(struct pt_regs *regs)
>
>         handler_chain(uprobe, regs);
>
> +       /*
> +        * If user decided to take execution elsewhere, it makes little s=
ense
> +        * to execute the original instruction, so let's skip it.
> +        */
> +       if (instruction_pointer(regs) !=3D bp_vaddr)
> +               goto out;
> +

Peter, Ingo,

Are you guys ok with us routing this through the bpf-next tree? We'll
have a tiny conflict because in perf/core branch there is
arch_uprobe_optimize() call added after handler_chain(), so git merge
will be a bit confused, probably. But it should be trivially
resolvable.

>         if (arch_uprobe_skip_sstep(&uprobe->arch, regs))
>                 goto out;
>
> --
> 2.51.0
>

