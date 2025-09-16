Return-Path: <linux-kernel+bounces-818466-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CACBAB5921D
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 11:25:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 845AD482922
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 09:25:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CA47296BA4;
	Tue, 16 Sep 2025 09:25:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DgVimv++"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89EE5299AAA
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 09:25:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758014738; cv=none; b=R58vZpu6oJ2KIjT63weIlYJDWmNv1PG96Abow0L6xeJwEAXHaxvOpzEY9qKUdLd9EW2RAAD1zWV5mEKVXb00nXd59B7rFiwNyhEpBj9s4R7WbxfTkFwsvlNdEec7qVdQqsEVGBXsmm10DV9YTnjKwDyBE+Y17Q/In2NDndaTMpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758014738; c=relaxed/simple;
	bh=94nfd9D2/3JrQ92cFxfHxwSHOkP/1U5/RVIAJbOP5v0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MLq8QcgljA5jqPMYq/oaKbgZ7xOTHJlO+w1RCmXHBvox4rgXN/sG77t3kDv+0gX5jAtLdsQ00Bf2LwsNzYK+fJYrYwXtmSVRyrs8lKQqAs/2kqDxCrCCk4ZokEJwAE6WzwBM5keYEZ9qdZ8zIXV4sNaBruL8i8F3NTNZZ4kLjCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DgVimv++; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6524AC4AF0B
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 09:25:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758014738;
	bh=94nfd9D2/3JrQ92cFxfHxwSHOkP/1U5/RVIAJbOP5v0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=DgVimv++zCTtvcsPbf0fL8LD41opT+4QyXK8f1XH3ct+STVNU6Qv1kuo4eYIefhXk
	 sJZa3HnsWVJ3jCL2Ud/3DFeSh4IEC+dUdR3RDXyWpmYVj0e5XSGy3LRdlnJNpDu6JA
	 1qOH9//dIRricRGIu0acwC5+9qmSYnT9IJ5gy8FsJvJa8Dj3zlbWLXvKxSnDpDKQlC
	 TJaCDwolBEufxPZsxOimiKY+qebkg2ioqJ59uvU7mK+kUkZ1knhO9bb+Ek9kbIT+c1
	 B+tRzstMeduDlrF1nykB/sw2eghONbeWEpLLZk2DE5qCULJUKGlKt7UjVomFxj5liL
	 sgPUUaoGhH9Jg==
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-3df15fdf0caso4041891f8f.0
        for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 02:25:38 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCU1RUUFb3rsMIc2//fa600bs3ocoSp/gpN4IWJ5PyPU1AoRMoAc4yg7YPspidfOyo6UDdrplSeE3nNSEqw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1ybHTdLWvaLHTd1nsmm9/XFzkZ7kCAhohbp/5GntM3skZrLmT
	qZUUUL6oru/P7GpWlBEviWo10o3AYJmhi/9ECZoDHLP/3a57iNTQ3zQNa12OCfG0GwPu54Lw411
	GbStzPPepcRWFTNqKxTHLBzyPRcf0UsY=
X-Google-Smtp-Source: AGHT+IFJHiRuQQ163JGnK5u5j/SLTzwdI+SdpUJ+UN87XgMbQzd6zH3QI8OublorMeiT+hg5VU2kmXWaq3EwVJlSQOg=
X-Received: by 2002:a05:6000:e:b0:3e9:9282:cff8 with SMTP id
 ffacd0b85a97d-3e99282d39amr6395145f8f.5.1758014736884; Tue, 16 Sep 2025
 02:25:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <6191817.lOV4Wx5bFT@fvogt-thinkpad>
In-Reply-To: <6191817.lOV4Wx5bFT@fvogt-thinkpad>
From: Guo Ren <guoren@kernel.org>
Date: Tue, 16 Sep 2025 17:25:24 +0800
X-Gmail-Original-Message-ID: <CAJF2gTQnkP0noK_s0ho36OdxN4-EOgFyvLeTgA+w+YTwUb2d9g@mail.gmail.com>
X-Gm-Features: AS18NWDYfF6_0jctcxDyY9_0G5irzA_3PV00ZRemrogDa3rebAgcSAfN-qRgBhA
Message-ID: <CAJF2gTQnkP0noK_s0ho36OdxN4-EOgFyvLeTgA+w+YTwUb2d9g@mail.gmail.com>
Subject: Re: [PATCH] riscv: kprobes: Fix probe address validation
To: Fabian Vogt <fvogt@suse.de>
Cc: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Marvin Friedrich <marvin.friedrich@suse.com>, Alexandre Ghiti <alex@ghiti.fr>, 
	Albert Ou <aou@eecs.berkeley.edu>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Paul Walmsley <paul.walmsley@sifive.com>, =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 10, 2025 at 11:25=E2=80=AFPM Fabian Vogt <fvogt@suse.de> wrote:
>
> When adding a kprobe such as "p:probe/tcp_sendmsg _text+15392192",
> arch_check_kprobe would start iterating all instructions starting from
> _text until the probed address. Not only is this very inefficient, but
> literal values in there (e.g. left by function patching) are
> misinterpreted in a way that causes a desync.

LGTM! This prevents bad p->offset from causing problems.

Acked-by: Guo Ren <guoren@kernel.org>

>
> Fix this by doing it like x86: start the iteration at the closest
> preceding symbol instead of the given starting point.
>
> Fixes: 87f48c7ccc73 ("riscv: kprobe: Fixup kernel panic when probing an i=
llegal position")
> Signed-off-by: Fabian Vogt <fvogt@suse.de>
> Signed-off-by: Marvin Friedrich <marvin.friedrich@suse.com>
> ---
>  arch/riscv/kernel/probes/kprobes.c | 13 +++++++++----
>  1 file changed, 9 insertions(+), 4 deletions(-)
>
> diff --git a/arch/riscv/kernel/probes/kprobes.c b/arch/riscv/kernel/probe=
s/kprobes.c
> index c0738d6c6498..8723390c7cad 100644
> --- a/arch/riscv/kernel/probes/kprobes.c
> +++ b/arch/riscv/kernel/probes/kprobes.c
> @@ -49,10 +49,15 @@ static void __kprobes arch_simulate_insn(struct kprob=
e *p, struct pt_regs *regs)
>         post_kprobe_handler(p, kcb, regs);
>  }
>
> -static bool __kprobes arch_check_kprobe(struct kprobe *p)
> +static bool __kprobes arch_check_kprobe(unsigned long addr)
>  {
> -       unsigned long tmp  =3D (unsigned long)p->addr - p->offset;
> -       unsigned long addr =3D (unsigned long)p->addr;
> +       unsigned long tmp, offset;
> +
> +       /* start iterating at the closest preceding symbol */
> +       if (!kallsyms_lookup_size_offset(addr, NULL, &offset))
> +               return false;
> +
> +       tmp =3D addr - offset;
>
>         while (tmp <=3D addr) {
>                 if (tmp =3D=3D addr)
> @@ -71,7 +76,7 @@ int __kprobes arch_prepare_kprobe(struct kprobe *p)
>         if ((unsigned long)insn & 0x1)
>                 return -EILSEQ;
>
> -       if (!arch_check_kprobe(p))
> +       if (!arch_check_kprobe((unsigned long)p->addr))
>                 return -EILSEQ;
>
>         /* copy instruction */
> --
> 2.51.0
>
>
>
>


--=20
Best Regards
 Guo Ren

