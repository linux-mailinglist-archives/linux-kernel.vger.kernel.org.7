Return-Path: <linux-kernel+bounces-884175-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 62B06C2F846
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 07:54:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 275744EE52A
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 06:53:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40D332E8DF6;
	Tue,  4 Nov 2025 06:53:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QQPm7gJR"
Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com [209.85.167.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC97B2DE717
	for <linux-kernel@vger.kernel.org>; Tue,  4 Nov 2025 06:53:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762239199; cv=none; b=p0zSZlQM6Qb1PzNRM9x3DC/KqKdtSBPyfMcRmczwryXEejQG9hW3Akk+GGzGQCZXs/dY9JgnJ7V5hzv78BiOlFQFaboVakgDZVGbuCqsNmKiLrFaSgmxrnqcF8LJWxuJ7yTF2RaWBp68owQpoLowPXLYbEyb3ncOgAUWfYTZ4Lc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762239199; c=relaxed/simple;
	bh=8p0MCf6z8owtO8dtPW0HAmvbfGUyTkXxQfEU6TFdLiQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=myNjvD1tCpDbNCVcZNRN9OJKMnGd1hWyAZfJsiRQTqoLQC9iBXTQDO1Jt/8DOh4kNLOcwe0CzpfGtqy+N3G51p2b7v4m851ylpAdL/dkmt/KH0aR9vYXI0zqZcVslNbfNZF1eMxulnpkDqbXMEjy2pxBfSL5+JZtrcNGDwr2uOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QQPm7gJR; arc=none smtp.client-ip=209.85.167.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f182.google.com with SMTP id 5614622812f47-44fa3aae70eso1186857b6e.2
        for <linux-kernel@vger.kernel.org>; Mon, 03 Nov 2025 22:53:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762239196; x=1762843996; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yunsIVG2xwSWPJMISQ9png0ZDy6Yvl2IENc61OHh6yo=;
        b=QQPm7gJRofS9D7nRw7wDMcJlvvp4BRJ7YHUqz6RvqdkJawLZxIgJcbO3dWCXoELFIU
         r/SdWtzVCMOuVmmqtmItfYBQKSp/Jw8pACs3yiIUS9+bxoELE8f9iKdBn+CFfQ8VxP0O
         RkEtwf5SjcQG+zKYGaWzps3uXxj7EvP6YJWq/Y8Kfg5cQm246RTTENMJEd3euywR6B1h
         bQ59VcozYZMYS2FdjcDo8XJJ4oYTPQD9dC38Kg5tjsB9z0syk1kqZ2vk00rQVJGXcmJY
         y84u2WHQl1ggkG/e72/d0JRvtf3uhyRWM8ftqEuZpI1VgE/CILT4lBq50AoTF9J1oCOu
         M2Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762239196; x=1762843996;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yunsIVG2xwSWPJMISQ9png0ZDy6Yvl2IENc61OHh6yo=;
        b=vCiylF3sBiRnPGpEAkTmrTAB2zgunbXKclShd9d60ywcnyJ4ssbaD4V8ufXu3VoJSm
         B7S88zj5/hmGmZWT2vJDPiJV0dzn8qCX12CQVMZOrwlZht9KUHn50Lr+R239PNKTEVVT
         5WRnHoshhgvRgZD0SbKrHP8hninkM22FBiKncWpEGUbmNqJp6um54n8LNclGHfqnwOGN
         qk5EqmgLQeSjmELJCBhatvQcUcIM6E6aVzXTKAG2dl1ppPdSijYDlRLGJ9znS2wkreMv
         5VbcnTJ77s1cY5jUFVQAuDiGcRbBUo1EqmIXNbdJkg8uq8S37GcFiApryHGGiuT6bGoX
         Y5bQ==
X-Forwarded-Encrypted: i=1; AJvYcCW7PDA6QK28Dz+5SQbQF3Ucy74y0jzQyNFNS8kQBrPGp4gobSrrp7ptsfdMJPBnOES+4hQUiEkfmrHPJXQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwP6U5qyjR378qQaFWG7bgn0RpzjDZU35fiSXDYLQTE8CEQNrNA
	XuhH8sfLWpNS5L9NptRVkFYpQeHxo0oWu91a2GlIttY2LLFZgM3Qq5+xf2J5F7Brt7b0vMRBxTh
	vHK8Cwd5b893pV1+Oj6twWVLPQILUFhk=
X-Gm-Gg: ASbGncvpVSRz70LAPHaDgGal6sX0uIcMRN7JC8LBnOMNvS+mJf40CmT4I80M7vpjT+0
	W9WGli9A7TSHqt5ACAKti+IHPEEYNW5UHArsuR/U9vII+p+zdRzgCQL5e/JGhRyUbhdxabuBXZk
	W+EXGZCkOaC3x4jZvLoouXkfv/dvJOkNgv/V0Zx6M2M7jne/+7OHm73X8VhCKYB2MwQRqyDkc2a
	DcR/LeTQ9Zy4Fs3fo5q2HChivxVEgPR24cHk6aWmT0Aby40lSRI7W/yhk/wG666WHQMkA==
X-Google-Smtp-Source: AGHT+IGbn2X2/1JEEhqo1wnJ78iL2FeGF989Bo4JAY/FmMP1S8eKH8fgHgNdc4dVIuvXBjYdomI/sa/SfD70vvNJUAI=
X-Received: by 2002:a05:6808:10c3:b0:43f:7dee:4693 with SMTP id
 5614622812f47-44f95e27868mr6890297b6e.14.1762239195781; Mon, 03 Nov 2025
 22:53:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251103-1-v1-1-20e6641a57da@linux.dev>
In-Reply-To: <20251103-1-v1-1-20e6641a57da@linux.dev>
From: Hengqi Chen <hengqi.chen@gmail.com>
Date: Tue, 4 Nov 2025 14:53:04 +0800
X-Gm-Features: AWmQ_bnyRUlNuwLxwBl63QPbG926jSDDFvsN0rhY6T22CSGWWq6GN0Hkme8uPf4
Message-ID: <CAEyhmHQoLF9dcZ2CaasrpeH7RMiaQKyo0pFTrr7Nt1T64+dhuw@mail.gmail.com>
Subject: Re: [PATCH] LoongArch: BPF: Fix sign extension for 12-bit immediates
To: george <dongtai.guo@linux.dev>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Tiezhu Yang <yangtiezhu@loongson.cn>, 
	Huacai Chen <chenhuacai@kernel.org>, WANG Xuerui <kernel@xen0n.name>, 
	Youling Tang <tangyouling@loongson.cn>, bpf@vger.kernel.org, loongarch@lists.linux.dev, 
	linux-kernel@vger.kernel.org, George Guo <guodongtai@kylinos.cn>, 
	Bing Huang <huangbing@kylinos.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 3, 2025 at 4:42=E2=80=AFPM george <dongtai.guo@linux.dev> wrote=
:
>
> From: George Guo <guodongtai@kylinos.cn>
>
> When loading immediate values that fit within 12-bit signed range,
> the move_imm function incorrectly used zero extension instead of
> sign extension.
>
> The bug was exposed when scx_simple scheduler failed with -EINVAL
> in ops.init() after passing node =3D -1 to scx_bpf_create_dsq().
> Due to incorrect sign extension, `node >=3D (int)nr_node_ids`
> evaluated to true instead of false, causing BPF program failure.
>

Which bpf prog are you referring to?

> Verified by testing with the scx_simple scheduler (located in
> tools/sched_ext/). After building with `make` and running
> ./tools/sched_ext/build/bin/scx_simple, the scheduler now
> initializes successfully with this fix.
>
> Fix this by using sign extension (sext) instead of zero extension
> for signed immediate values in move_imm.
>
> Fixes: 5dc615520c4d ("LoongArch: Add BPF JIT support")
> Reported-by: Bing Huang <huangbing@kylinos.cn>
> Signed-off-by: George Guo <guodongtai@kylinos.cn>
> ---
> Signed-off-by: george <dongtai.guo@linux.dev>
> ---
>  arch/loongarch/net/bpf_jit.h | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/arch/loongarch/net/bpf_jit.h b/arch/loongarch/net/bpf_jit.h
> index 5697158fd1645fdc3d83f598b00a9e20dfaa8f6d..f1398eb135b69ae61a27ed81f=
80b4bb0788cf0a0 100644
> --- a/arch/loongarch/net/bpf_jit.h
> +++ b/arch/loongarch/net/bpf_jit.h
> @@ -122,7 +122,8 @@ static inline void move_imm(struct jit_ctx *ctx, enum=
 loongarch_gpr rd, long imm
>         /* addiw rd, $zero, imm_11_0 */
>         if (is_signed_imm12(imm)) {
>                 emit_insn(ctx, addiw, rd, LOONGARCH_GPR_ZERO, imm);
> -               goto zext;
> +               emit_sext_32(ctx, rd, is32);
> +               return;
>         }

This causes kernel panic on existing bpf selftests.

>
>         /* ori rd, $zero, imm_11_0 */
>
> ---
> base-commit: 6146a0f1dfae5d37442a9ddcba012add260bceb0
> change-id: 20251103-1-96faa240e8f4
>
> Best regards,
> --
> george <dongtai.guo@linux.dev>
>

