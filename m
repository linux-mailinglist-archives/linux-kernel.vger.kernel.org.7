Return-Path: <linux-kernel+bounces-817720-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 40A18B585A6
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 21:57:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 334C84C6BFA
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 19:56:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C218D2882A9;
	Mon, 15 Sep 2025 19:54:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I05tl7Zf"
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A783A28D8D0
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 19:54:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757966077; cv=none; b=CAXHKIJkuR0ADAobKatMQkzHE5d4MDMQ7Ce7Q4Mp7TwmmPW2GIhqZTlmc8JKFqaglDmRvoTh8S/ayXeS5aE+2Qv2ndf9NwSLX034+5ag8Fvw3Pk/ccpV8WpQIcpqgiRclFXL/bX+U/E9lRo0RlmwfT5yxv7TLOVh5CC9Wfk1nzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757966077; c=relaxed/simple;
	bh=1t5HGUdbEnqlFM4BN+7spAJCkMUdNy6xmmpKrD3jxGA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OPHLKs6dKekKoOjFrm+4bzR5769/rb5dWs4saPVP8rS8n+PD8aCca1FV2SGpZzNsgS86H1Q8iRtg5Epe1Nyf87O08SObYUYaD3DOHepVaFktd8JwT+FaZ7LS181a0Nj1da7rNpBN3mVRY9He7tyvYgr2u7e38/uvRyRAjCs2Ero=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I05tl7Zf; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-b54c707374fso1133923a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 12:54:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757966075; x=1758570875; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bKMoNUFr15hMIs+DA/sQ+YcEe3uvxbWw0rkaGFS6MZk=;
        b=I05tl7Zf8txDlXtRshtYw1C9ax2cMQ3SloWmynucveAWTn8oezeHCt5jLguUz9tzxY
         DnHMn9FugRtz+b6MFp5Lkrv3xWiDS2n5GCwQPRaFyl4+TrD08LcFZFEfm9EVNpePKiM6
         hYR8hwUaT4Qdgi7JG/2CuIlQ2Zz5Rjf/IzoPhorHpKZDINmr/KuRHRXRQq6Mn4gkY+b1
         dKOOLpRUrW9nbU/l/eRdXS4ZBdBWLO9z34zWr1+O+vRkG+SspkmQKD3Su2cSOr8SbCBF
         gGLaumziF7k3225ahhu1Jflvl8b1cn5bF1owOpn1+aKiCksjrpt8uV8LsulW1xyPJ5dg
         RlVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757966075; x=1758570875;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bKMoNUFr15hMIs+DA/sQ+YcEe3uvxbWw0rkaGFS6MZk=;
        b=bsjDQd6XIvBtqZ7Ejxqlltsp0N7x8lJkgVRAjojoaRRNpcSR3yKA2AMsdWfOXZTzXM
         Jl6UIgV82f6ATONBO/BSHphHo2X2dPdbTiK0KlK0SIyONTm/0WOCg8412StGylxOxmgz
         QvKJ7twcYyeOzp3YCciKlR2QQ/wPTFH1uP8HW8L7PxbZErQE7YrIyR5ilM7bjqoWk7uy
         xF3gnoo9X7zLSATD++kvzpvRYMb6ukR/iKcAds7pSIXHiAkoWW4VDNprK9QNJUjjuDqq
         /qc2zIFq+fa1F470dI7ljGpKkh/ZYcWii4JUGmScwlJkXH1KCa+0YiuOsk0KflL1iNrB
         qgOQ==
X-Forwarded-Encrypted: i=1; AJvYcCU6sXifUbwYY17t+BzZ22Y4BeIW8YGMBdaRQC0LDkhxgDcjy90jQvjHVNH9q3E73XiCTYlkBhsMIuY56EA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyrXzEIj1XvrXtlb46f3R+XrbezYH7Xy5SX0vbJIOetWRUnr3n5
	6ySBdgk99yP7DfpQQuubHrWD8l5QEwzppcTGSQoY3HVmR4CjalSenaoc8w2ZPPwAsl2dDOZUDic
	MCCetNNfl1Sv3nAaCJvRQI3PcoC+ln6c=
X-Gm-Gg: ASbGncu59bnAGjtIg7fMyw0zhPsV0av8zsBmIeZ0aUbFnBKfS33vi33KIia+IS55HVg
	gNJnP3mJswEU7p8IaS/96ozh5Ka/ypWUzP6H2KsI6vQjzfxPWE58gYeN/86Lo/7+rjhOzBJ/LH9
	LSjE5H4oVu8k+S+AHGkG0RHhKyRNk3qTnKVMcBBtuqIsLBKRJZxOESwCd2trv3rU40148fvQRaG
	HLSoMN4m8wM+BgkSUa3fEJfgUDypAGA9g==
X-Google-Smtp-Source: AGHT+IGhszUX/wIOL5NPxhRl5wThYAaRRneYHXfDR1OkxzwEwEhfmK0x+kYIpjKOZ/xwWV7ll61KtWzqWi210u8AngA=
X-Received: by 2002:a17:902:cec6:b0:266:88ae:be6d with SMTP id
 d9443c01a7336-26688aec242mr56968135ad.6.1757966074538; Mon, 15 Sep 2025
 12:54:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250913222323.894182-1-kriish.sharma2006@gmail.com>
In-Reply-To: <20250913222323.894182-1-kriish.sharma2006@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 15 Sep 2025 12:54:20 -0700
X-Gm-Features: Ac12FXzojP0XfNu0UL3urOwuEQZBsAsNl-Qq1OLXgb7nho1cime033bbY4rUq2g
Message-ID: <CAEf4BzY_f=iNKC2CVz-myfe_OERN9XWHiuNG6vng43-MXUAvSw@mail.gmail.com>
Subject: Re: [PATCH] bpf: verifier: fix WARNING in reg_bounds_sanity_check (2)
To: Kriish Sharma <kriish.sharma2006@gmail.com>
Cc: ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com, 
	andrii@kernel.org, martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org, 
	yonghong.song@linux.dev, kpsingh@kernel.org, sdf@fomichev.me, 
	haoluo@google.com, jolsa@kernel.org, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org, 
	syzbot+c950cc277150935cc0b5@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Sep 13, 2025 at 3:24=E2=80=AFPM Kriish Sharma
<kriish.sharma2006@gmail.com> wrote:
>
> syzbot reported a "REG INVARIANTS VIOLATION" triggered in reg_bounds_sani=
ty_check()
> due to inconsistent umin/umax and var_off state after min/max updates.
>
> reg_set_min_max() and adjust_reg_min_max_vals() could leave a register st=
ate
> partially updated before syncing the bounds, causing verifier_bug() to fi=
re.
>
> This patch ensures reg_bounds_sync() is called after updates, and additio=
nally
> marks registers unbounded if min/max values are inconsistent, so that umi=
n/umax,
> smin/smax, and var_off remain consistent.
>
> Fixes: d69eb204c255 ("Merge tag 'net-6.17-rc5' of git://git.kernel.org/pu=
b/scm/linux/kernel/git/netdev/net")
> Reported-by: syzbot+c950cc277150935cc0b5@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=3Dc950cc277150935cc0b5
> Signed-off-by: Kriish Sharma <kriish.sharma2006@gmail.com>
> ---
>  kernel/bpf/verifier.c | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
>
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index c4f69a9e9af6..8f5f02d39005 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -16299,6 +16299,19 @@ static void regs_refine_cond_op(struct bpf_reg_s=
tate *reg1, struct bpf_reg_state
>         }
>  }
>
> +/* Ensure that a register's min/max bounds are sane.
> + * If any of the unsigned/signed bounds are inconsistent, mark the
> + * register as unbounded to prevent verifier invariant violations.
> + */
> +static void __maybe_normalize_reg(struct bpf_reg_state *reg)
> +{
> +       if (reg->umin_value > reg->umax_value ||
> +               reg->smin_value > reg->smax_value ||
> +               reg->u32_min_value > reg->u32_max_value ||
> +               reg->s32_min_value > reg->s32_max_value)
> +                       __mark_reg_unbounded(reg);
> +}
> +
>  /* Adjusts the register min/max values in the case that the dst_reg and
>   * src_reg are both SCALAR_VALUE registers (or we are simply doing a BPF=
_K
>   * check, in which case we have a fake SCALAR_VALUE representing insn->i=
mm).
> @@ -16325,11 +16338,15 @@ static int reg_set_min_max(struct bpf_verifier_=
env *env,
>         regs_refine_cond_op(false_reg1, false_reg2, rev_opcode(opcode), i=
s_jmp32);
>         reg_bounds_sync(false_reg1);
>         reg_bounds_sync(false_reg2);
> +       __maybe_normalize_reg(false_reg1);
> +       __maybe_normalize_reg(false_reg2);
>
>         /* jump (TRUE) branch */
>         regs_refine_cond_op(true_reg1, true_reg2, opcode, is_jmp32);
>         reg_bounds_sync(true_reg1);
>         reg_bounds_sync(true_reg2);
> +       __maybe_normalize_reg(true_reg1);
> +       __maybe_normalize_reg(true_reg2);

We are actually taking a different approach to this problem. Eduard is
going to modify verifier logic to use the fact that register' tnum and
range bounds are incompatible to detect branches that cannot be taken,
and process it as dead code. This way we don't lose information (like
with the approach in this patch), but rather take advantage of it to
improve verification performance.

Thanks for your patch, but I think we should go with the more generic
solution I outlined above.

pw-bot: cr


>
>         err =3D reg_bounds_sanity_check(env, true_reg1, "true_reg1");
>         err =3D err ?: reg_bounds_sanity_check(env, true_reg2, "true_reg2=
");
> --
> 2.34.1
>

