Return-Path: <linux-kernel+bounces-885371-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 99A17C32B6F
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 19:56:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 52C593A9597
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 18:56:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C67B133F8C8;
	Tue,  4 Nov 2025 18:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q7cG+qxu"
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF7D633E352
	for <linux-kernel@vger.kernel.org>; Tue,  4 Nov 2025 18:56:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762282586; cv=none; b=DUWOa/H3l4EgSfD5Ohg9MYNd0tQe/+jKKjteGgtYVTSp3HkrxoBpxeWqTpPJfdDqJUmEs3ONftDa7qMCG4f0vlVLyo75PPo9wNDL7ciVSMCmFXrz+MJi++59ShekeReh8vDK7Ne+Qv1STsCkTreSF2XtfVQdFp7TyToZpfc28fk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762282586; c=relaxed/simple;
	bh=1YsclRHRX16kW+F4BUH8OrD5tzZOGvtmNO3gu7zn/jA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=I1MJhjJLrBDu5U/9Bf4x2QKtJaHr+gTpj7AB4sYHao1PSSsjD7vTDI6z2WVjZoreueEfQtb8qh5i0BTCtt8Ra2c1Un4g1t1mLxi3uXjP9Z2sstwMiCLaltM6+/GAl+oriREg/QwmveD84CiQXukl3uxdW/pGOYwxaEC8m9dUpz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q7cG+qxu; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-429c7869704so3898662f8f.2
        for <linux-kernel@vger.kernel.org>; Tue, 04 Nov 2025 10:56:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762282583; x=1762887383; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qyVxNDhzeuX7e1Hm9faErYkOpONAjmcZigzr7RrJCec=;
        b=Q7cG+qxuTZO9/oKWznlk4GnwNt+gPg1QoN0Ax+GsQW1a5+HQastrg2vjEhxI1/6fpL
         DecHEAzvbzUhPLHrutkj6olqaK+R/IDQqMtnyaSQTMzXo3d4nmXsxPZ9OY/kY7fQvn8y
         ZSNP52LRIvPjqKPt916loBesIEUN+RQzYdKl9iu1qKjYgTBrFUaMX1kk/3hRI4h94+ws
         IE+O3wFhtbZ+/4KN+xNK61IY0oqaBKj92bBgLW+Nb8KXXWM+tGSvJcmWuOAubpQYReUS
         jO/XyoV7SZ8Gur+NBO7vfX/IAmJgfYjDfnR7wCNRRajrMGGdDZ32jtfts8pMJmNWPbq8
         4Rgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762282583; x=1762887383;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qyVxNDhzeuX7e1Hm9faErYkOpONAjmcZigzr7RrJCec=;
        b=HrDIQ6pyz/nSj5s1x89jJ8Ij7cnX8tHW31LCkHkc+tBL4JcRifwCpKrTjMcQGtY0DE
         UBYDqBqHJM2Eg57phLUVkKP3EyC1zoP3gmRDHT/OT8+3QAW0YuV/sf8dFoBOrxsaDH2I
         xt/e7yhhwGImjy9KVd7OMzsrtscj9YfC7jqLwsjnPS16SDGdxYdI27ZyJvdX1b3ziq1t
         MIYUOiCJEruwbbL3VBpZQqrfGT+WUFHRR5xzZz3xOG3SKr+H0eC7hGZxro8nBzSuo5fj
         ho8PY7bTHbGXnp7Pao1gZmsh+dZQb1yrqBnnUQ2yre8vcX1nLPHLlEVfUzxWrzSrJ70+
         Ea/g==
X-Forwarded-Encrypted: i=1; AJvYcCUXeUxZMkYf9g3CMVQv1l+UB5GFpcO0vwTT3hRcbRCIZiXMLu/Hd2cm+tclQ+hEDESuD7UoLBPJMFIbV7g=@vger.kernel.org
X-Gm-Message-State: AOJu0YztRZwuNpBXoEMY/pjUsSHoGy+Wp67o2JkOuA3zclKb7qk5hBg1
	+9kViSAUPepPOlkZ56bmlslEUugIZq/cdceTxnBQnQ42URdtO+H5RQggGooy4QcTaRPZMmlYRsD
	Wfs5cHfsF9dhvioFCLtN03zGED2zfTJg=
X-Gm-Gg: ASbGnctkfKswAunOucsuCrE2hj869/piXHwS7TgdG7HGyGEXh0fpwQtBB9eYH15Gg7n
	cEnBgiUsyh/g3eFxN0s0EhDtkTFNyHJmzb2S1uh0kWEyQSF255oyPqG5KC+cBap0KMzJgF0AY2d
	lSd5OTeSRs5MlGk4bSfmW0QKqfm6ShXjdn12zO/VvUIsfP56pEECYbc71hLTvKAaE7ffqxkTq7f
	ZLv8UvWzqP8lFlMJ8OUULspc4RXW5DSbdaU2OWjqShwnXqV50cGqpLr9fVahqQ4wAlWGavvDGeL
X-Google-Smtp-Source: AGHT+IFJOInFmzbqZmECILRroALB/RTVl7MjNKGkZgcM/wZQZhU9czd1hU9lNpogQZguKz7XWer3EishDJ+kqONidvU=
X-Received: by 2002:a05:6000:4105:b0:3eb:4e88:585 with SMTP id
 ffacd0b85a97d-429e3305dbcmr291156f8f.29.1762282582747; Tue, 04 Nov 2025
 10:56:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251104104913.689439-1-dongml2@chinatelecom.cn>
In-Reply-To: <20251104104913.689439-1-dongml2@chinatelecom.cn>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 4 Nov 2025 10:56:09 -0800
X-Gm-Features: AWmQ_bn3-3pUzEzIlIcXVV-BIX9Cml9X2hduNwfYMH_N1D55oNwjtosZOsMwPrI
Message-ID: <CAADnVQJTOFjXe5=01KfOnBD86YU_Vy1YGezLQum3LnhFHAD+gg@mail.gmail.com>
Subject: Re: [PATCH bpf-next] bpf,x86: do RSB balance for trampoline
To: Menglong Dong <menglong8.dong@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, Eduard <eddyz87@gmail.com>, 
	Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, 
	John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	"David S. Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, X86 ML <x86@kernel.org>, 
	"H. Peter Anvin" <hpa@zytor.com>, jiang.biao@linux.dev, 
	Menglong Dong <menglong.dong@linux.dev>, bpf <bpf@vger.kernel.org>, 
	Network Development <netdev@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 4, 2025 at 2:49=E2=80=AFAM Menglong Dong <menglong8.dong@gmail.=
com> wrote:
>
> In origin call case, we skip the "rip" directly before we return, which
> break the RSB, as we have twice "call", but only once "ret".

RSB meaning return stack buffer?

and by "breaks RSB" you mean it makes the cpu less efficient?
Or you mean call depth accounting that is done in sw ?

> Do the RSB balance by pseudo a "ret". Instead of skipping the "rip", we
> modify it to the address of a "ret" insn that we generate.
>
> The performance of "fexit" increases from 76M/s to 84M/s. Before this
> optimize, the bench resulting of fexit is:
>
> fexit          :   76.494 =C2=B1 0.216M/s
> fexit          :   76.319 =C2=B1 0.097M/s
> fexit          :   70.680 =C2=B1 0.060M/s
> fexit          :   75.509 =C2=B1 0.039M/s
> fexit          :   76.392 =C2=B1 0.049M/s
>
> After this optimize:
>
> fexit          :   86.023 =C2=B1 0.518M/s
> fexit          :   83.388 =C2=B1 0.021M/s
> fexit          :   85.146 =C2=B1 0.058M/s
> fexit          :   85.646 =C2=B1 0.136M/s
> fexit          :   84.040 =C2=B1 0.045M/s

This is with or without calldepth accounting?

> Things become a little more complex, not sure if the benefits worth it :/
>
> Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
> ---
>  arch/x86/net/bpf_jit_comp.c | 32 +++++++++++++++++++++++++++++---
>  1 file changed, 29 insertions(+), 3 deletions(-)
>
> diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
> index d4c93d9e73e4..a9c2142a84d0 100644
> --- a/arch/x86/net/bpf_jit_comp.c
> +++ b/arch/x86/net/bpf_jit_comp.c
> @@ -3185,6 +3185,7 @@ static int __arch_prepare_bpf_trampoline(struct bpf=
_tramp_image *im, void *rw_im
>         struct bpf_tramp_links *fmod_ret =3D &tlinks[BPF_TRAMP_MODIFY_RET=
URN];
>         void *orig_call =3D func_addr;
>         u8 **branches =3D NULL;
> +       u8 *rsb_pos;
>         u8 *prog;
>         bool save_ret;
>
> @@ -3431,17 +3432,42 @@ static int __arch_prepare_bpf_trampoline(struct b=
pf_tramp_image *im, void *rw_im
>                 LOAD_TRAMP_TAIL_CALL_CNT_PTR(stack_size);
>         }
>
> +       if (flags & BPF_TRAMP_F_SKIP_FRAME) {
> +               u64 ret_addr =3D (u64)(image + (prog - (u8 *)rw_image));
> +
> +               rsb_pos =3D prog;
> +               /*
> +                * reserve the room to save the return address to rax:
> +                *   movabs rax, imm64
> +                *
> +                * this is used to do the RSB balance. For the SKIP_FRAME
> +                * case, we do the "call" twice, but only have one "ret",
> +                * which can break the RSB.
> +                *
> +                * Therefore, instead of skipping the "rip", we make it a=
s
> +                * a pseudo return: modify the "rip" in the stack to the
> +                * second "ret" address that we build bellow.
> +                */
> +               emit_mov_imm64(&prog, BPF_REG_0, ret_addr >> 32, (u32)ret=
_addr);
> +               /* mov [rbp + 8], rax */
> +               EMIT4(0x48, 0x89, 0x45, 0x08);
> +       }
> +
>         /* restore return value of orig_call or fentry prog back into RAX=
 */
>         if (save_ret)
>                 emit_ldx(&prog, BPF_DW, BPF_REG_0, BPF_REG_FP, -8);
>
>         emit_ldx(&prog, BPF_DW, BPF_REG_6, BPF_REG_FP, -rbx_off);
>         EMIT1(0xC9); /* leave */
> +       emit_return(&prog, image + (prog - (u8 *)rw_image));
>         if (flags & BPF_TRAMP_F_SKIP_FRAME) {
> -               /* skip our return address and return to parent */
> -               EMIT4(0x48, 0x83, 0xC4, 8); /* add rsp, 8 */
> +               u64 ret_addr =3D (u64)(image + (prog - (u8 *)rw_image));
> +
> +               /* fix the return address to second return address */
> +               emit_mov_imm64(&rsb_pos, BPF_REG_0, ret_addr >> 32, (u32)=
ret_addr);

So the first "movabs rax, imm64" is not needed ?
Why compute ret_addr there and everything ?
I mean it could have been prog +=3D sizeof(movabs), right?

> +               /* this is the second(real) return */
> +               emit_return(&prog, image + (prog - (u8 *)rw_image));
>         }
> -       emit_return(&prog, image + (prog - (u8 *)rw_image));

