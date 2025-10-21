Return-Path: <linux-kernel+bounces-863516-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id EDDA9BF8082
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 20:17:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 360F94F1655
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 18:17:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E16DB34E76E;
	Tue, 21 Oct 2025 18:17:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y2+NDogU"
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B2481EBA14
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 18:17:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761070632; cv=none; b=DSUELo1ziye5v66pDwo/awWR3++jerZcg61K7JH0tz9/4Ju9eHGjEnUPo9KbL9TY/+Plf3qMDxuB44WrJY1+XmvfXqvj6T3jEQcVIq/ooC+VKZUr+05npLCW4lir7Jr0c4K7NYzZmg1OSQZgrHQDxWghC8mWc4WQCh6ZKSBNR50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761070632; c=relaxed/simple;
	bh=uHaCegWf7G1lsvdrseJq4v473UN4vezxPgOeKsQYQfw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XfrIwhH+vYkHx2VCk+YUjb9d0U5GB/uKPiNd2t+pEOdbDdd4Ie5bWbxskKCIybZZ4FASDBJMfYNtk1rz2gKCYzKlce0sIsARTrscdtol+ksUlPFIHB2omC8HHuuuKxy8jlC6EsKJRVF/7C0+jgHRvgVeiVKBCb5+qJhDRzUnMJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y2+NDogU; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4710683a644so1602265e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 11:17:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761070628; x=1761675428; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RGD+FcEsW2FFxX+kG8Fzb0HeFi6smqsLpBgWiT17QWM=;
        b=Y2+NDogUB0iETGhC4CXgQ31LdQqAqcvVAm4cv4Pw/8PDCNWVifZnlYrzqoKW4e4vTo
         Srctj0xnbCDCBHoUhNqg2P4kyKOKh2qVA9cJnhfprMQbMt+Zt9c7/3Qm3KOPPXtHaVZo
         khk/CooUbfKTw+aRkP2QK6w3GPWSBVAdLeOygn6dgnx6lc/VFOePQ1ZfDCJk54Jm5DY6
         N7ukILX6OSpXOtC6JI+eu5dSfMkut8CnDEHnQiwgnMKlJ0hJ/6YzcXOV9i97w84Za4YI
         WU/GyPc84CpJksd52Y9dZYI53JJVbe1AUczn1pE+vIOUcWcVJABPV6IIDSNuPlkjr0R7
         yF2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761070628; x=1761675428;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RGD+FcEsW2FFxX+kG8Fzb0HeFi6smqsLpBgWiT17QWM=;
        b=KDgWMdxHq2UUwps6gAP4pPnmxgCsMUPVDVjvLlctc85Mt8jr6tWjRcK3NITa5tNxEB
         2Ks3bokpepRRrfK+oXRRq+82kJ+orbCMrOgmtBJCSZahxCxS3z5Zlkr6hloMkpq9/4G+
         lw8XqhRqL8c9fEsvjFoQ0BFNuWFLWSmkqDNutA5/v3g7tO7ziZPuNOJsFReUhuA28H+z
         8SE21LYUvlgUyj1GhQy7ohj7QlIwYnW6To+iJKEapwTzhlm57MGEWoCCkgzk7gl/eK5y
         leW4upkQDcU72jkN41SNAMg5b1MGWhtx2IHE64jqxPykrKWZhXdYEkOy46OMvd8K5yrU
         pl6w==
X-Forwarded-Encrypted: i=1; AJvYcCXuK8AxyYfPL2cUUzwqHi1Jjm35QXJcX9e7EYjg4B2iGVRXS8P+xI9NIKwIdjuDFfitk18IkTBsgOrh6Mw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzI9UXLj3OmhPtwLiP8DclVvwK6wUmSmcyWNX3oviQovOmap4gm
	tvvKy//3Y4IouavS2xIQKFxj6+jd3jYuT59qRCYvPejBFXfYvyJ1i9OcyKI9Zzks6ywLcCaYFU3
	15r3/doCInuU5ktQFMNqWsgK2QwAZf5I=
X-Gm-Gg: ASbGncueATcA6k4GA64Tw8kFe1MJ+bAysE+bgVysu60qqYII6lktKKyD6ZSM/99ZJPE
	kEaaNtbdRT0I2yxhg7ZxDp7wG/uvOX4GJ+mLtrCcSqc3HVvQH5MpwCJ5ehk7XVdE3xGuRdXYR+C
	xmTwHw55f/HOUxHl6ZBbilFH+SJtZDl7Q2J1Bw0h8F/Yptnv0rHln5UsjzxWEDjcONUGDXXgIw9
	7CkEHnDVAbF4T1JaAJeK54ELWaIdIa2txLEz2GtywNEdtku/kfozqW2/GyErWlMDLP2GXOc1VCf
X-Google-Smtp-Source: AGHT+IHAL3TwL3lSrbbeuTOnvc5N+BYP3uS+YNImwOULyrDGTO3KCuxddBINXlS3GnAhet25AeUZNxliKcrwhe5LULc=
X-Received: by 2002:a05:600c:5251:b0:471:846:80ac with SMTP id
 5b1f17b1804b1-475c400151emr4658295e9.18.1761070627745; Tue, 21 Oct 2025
 11:17:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251018142124.783206-1-dongml2@chinatelecom.cn> <20251018142124.783206-4-dongml2@chinatelecom.cn>
In-Reply-To: <20251018142124.783206-4-dongml2@chinatelecom.cn>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 21 Oct 2025 11:16:53 -0700
X-Gm-Features: AS18NWC-vk9wYK7_8tX_FVlBKQAbSU9jzlpKybVeQNDtOy8tuK9-TkGozXjUbPI
Message-ID: <CAADnVQLN96WZd0eWWb=__62g49y_wPfjTPKXaB_=o5jdVE7uKQ@mail.gmail.com>
Subject: Re: [PATCH RFC bpf-next 3/5] bpf,x86: add tracing session supporting
 for x86_64
To: Menglong Dong <menglong8.dong@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, John Fastabend <john.fastabend@gmail.com>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, Eduard <eddyz87@gmail.com>, 
	Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Matt Bobrowski <mattbobrowski@google.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Leon Hwang <leon.hwang@linux.dev>, bpf <bpf@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, 
	linux-trace-kernel <linux-trace-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 18, 2025 at 7:21=E2=80=AFAM Menglong Dong <menglong8.dong@gmail=
.com> wrote:
>  /* mov rax, qword ptr [rbp - rounded_stack_depth - 8] */
>  #define LOAD_TRAMP_TAIL_CALL_CNT_PTR(stack)    \
>         __LOAD_TCC_PTR(-round_up(stack, 8) - 8)
> @@ -3179,8 +3270,10 @@ static int __arch_prepare_bpf_trampoline(struct bp=
f_tramp_image *im, void *rw_im
>                                          void *func_addr)
>  {
>         int i, ret, nr_regs =3D m->nr_args, stack_size =3D 0;
> -       int regs_off, nregs_off, ip_off, run_ctx_off, arg_stack_off, rbx_=
off;
> +       int regs_off, nregs_off, session_off, ip_off, run_ctx_off,
> +           arg_stack_off, rbx_off;
>         struct bpf_tramp_links *fentry =3D &tlinks[BPF_TRAMP_FENTRY];
> +       struct bpf_tramp_links *session =3D &tlinks[BPF_TRAMP_SESSION];
>         struct bpf_tramp_links *fexit =3D &tlinks[BPF_TRAMP_FEXIT];
>         struct bpf_tramp_links *fmod_ret =3D &tlinks[BPF_TRAMP_MODIFY_RET=
URN];
>         void *orig_call =3D func_addr;
> @@ -3222,6 +3315,8 @@ static int __arch_prepare_bpf_trampoline(struct bpf=
_tramp_image *im, void *rw_im
>          *
>          * RBP - nregs_off [ regs count      ]  always
>          *
> +        * RBP - session_off [ session flags ] tracing session
> +        *
>          * RBP - ip_off    [ traced function ]  BPF_TRAMP_F_IP_ARG flag
>          *
>          * RBP - rbx_off   [ rbx value       ]  always
> @@ -3246,6 +3341,8 @@ static int __arch_prepare_bpf_trampoline(struct bpf=
_tramp_image *im, void *rw_im
>         /* regs count  */
>         stack_size +=3D 8;
>         nregs_off =3D stack_size;
> +       stack_size +=3D 8;
> +       session_off =3D stack_size;

Unconditional stack increase? :(

