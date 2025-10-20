Return-Path: <linux-kernel+bounces-861000-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EBCDBF18DD
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 15:35:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1E37F422157
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 13:35:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DDFE319879;
	Mon, 20 Oct 2025 13:34:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LLbFebj0"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D2453176EF
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 13:34:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760967285; cv=none; b=bMWAbOfeMcekXon+gNdAUR49NY0YlUMGvRcRZrgqQGeVPb3sfvdGtiZhg/Yx3DaOZQcwL4sYGsqgpmLxFHuZ8Qeu2E1IA0+ODlMgWd8fThR3FFAneyd8NmA1yyFv8bInsby2OqAlcOFpW6+9S3rrs6DyjuIu00QZBWEwzpQT4oI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760967285; c=relaxed/simple;
	bh=qaL9YbmZJTW/ixYO94qG+wib+260CKv9uoYvrwMFIF8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TvupkB8K4S8dAmDeFTg39AYNRZ7xTzJd/Pa9geUJj3kTrkO8osL+lZLrOwsH/P1z8jYxiKa6jrSPcx3XcuXuMg2XqSQSGg5M2P7Ou1mx+pj27y4XlEnZ30vfLbPqbWNDtvxURbJoCs7GJ0rY0+/yCYX8sJTsRITcnNOWuOJ8jSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LLbFebj0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A985C113D0
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 13:34:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760967285;
	bh=qaL9YbmZJTW/ixYO94qG+wib+260CKv9uoYvrwMFIF8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=LLbFebj0QTtB6YA74PS9tZdmJXL4RcwkLs2Dje0VXKlCPsBntF9N4S5BhECVaKh8m
	 T0J3oqUTtaQAMyJ/F2CXEQFDJZC6j1Miqb90fy8elhcxnKksssCim0Qx6cM4x5wnIX
	 f1GtlWBkwBv/GDq74+7rbV93xpPZZTo0UndgA/KA4xkHLVvBFK97ISffCpWWv6+tz/
	 /0N7AnyJZSY7oG2JIY8wdEd67OGnwo3JlbebG0p/mxRj8Dc5NOmGKf4ZqnekmpTjaJ
	 8RQmuvjv0Ot0TPGwwngkdYuh3UYIuhKGRruWaVQ84Aru0/71Ns+75YrwLV9iWjqo9v
	 louuYmT31YEzA==
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-3f99ac9acc4so4012393f8f.3
        for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 06:34:45 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVUUiak5v9zcHWosYVd9plSKSM+Nw/wKfPxsGnDAYyXCcFxfk2UStPHJsC3MzMAa6q0hpQR12wEb+a7Vxk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzEv5Dp3e7JhR0jSCDkgNdp6/Ql+6kX3jwCA6HI+jAXMyPLlWhk
	mvl4ovYxmKDhLE8IjycM9GnR0sYVcRgjqZ0cT6d1zOynvu7Stk6dhW532FghXAgzuVKBGT4dbt7
	DYWydka7xKlzOEDwSSIBrpblJ+To9iSk=
X-Google-Smtp-Source: AGHT+IFQwlCf7FjnCPutO24ZzoIvXCKxA8V6xzsVKhuniPH312m1I40LeS2q7hRVe9Mx5ZgcbJzBUyetjP4FtY8fo7s=
X-Received: by 2002:a05:6000:2c0c:b0:427:928:78a0 with SMTP id
 ffacd0b85a97d-42709287a50mr7648478f8f.63.1760967283331; Mon, 20 Oct 2025
 06:34:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251020042056.30283-1-luxu.kernel@bytedance.com> <20251020042056.30283-5-luxu.kernel@bytedance.com>
In-Reply-To: <20251020042056.30283-5-luxu.kernel@bytedance.com>
From: Guo Ren <guoren@kernel.org>
Date: Mon, 20 Oct 2025 21:34:27 +0800
X-Gmail-Original-Message-ID: <CAJF2gTRyXPxtw1mvMEAt2NLMUecu++DyN8n+HxmcpbPPF_KB3Q@mail.gmail.com>
X-Gm-Features: AS18NWDpy2g1Qp1BbuHJudf6VVHWVv_M97q7whwhpvd314t5p96b7PWN5zNzj08
Message-ID: <CAJF2gTRyXPxtw1mvMEAt2NLMUecu++DyN8n+HxmcpbPPF_KB3Q@mail.gmail.com>
Subject: Re: [PATCH v4 04/10] riscv: Introduce Zalasr instructions
To: Xu Lu <luxu.kernel@bytedance.com>
Cc: corbet@lwn.net, paul.walmsley@sifive.com, palmer@dabbelt.com, 
	aou@eecs.berkeley.edu, alex@ghiti.fr, robh@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, will@kernel.org, peterz@infradead.org, 
	boqun.feng@gmail.com, mark.rutland@arm.com, anup@brainfault.org, 
	atish.patra@linux.dev, pbonzini@redhat.com, shuah@kernel.org, 
	parri.andrea@gmail.com, ajones@ventanamicro.com, brs@rivosinc.com, 
	linux-doc@vger.kernel.org, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, kvm@vger.kernel.org, 
	kvm-riscv@lists.infradead.org, linux-kselftest@vger.kernel.org, 
	apw@canonical.com, joe@perches.com, lukas.bulwahn@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 20, 2025 at 12:21=E2=80=AFPM Xu Lu <luxu.kernel@bytedance.com> =
wrote:
>
> Introduce l{b|h|w|d}.{aq|aqrl} and s{b|h|w|d}.{rl|aqrl} instruction
> encodings.
>
> Signed-off-by: Xu Lu <luxu.kernel@bytedance.com>
> ---
>  arch/riscv/include/asm/insn-def.h | 79 +++++++++++++++++++++++++++++++
>  1 file changed, 79 insertions(+)
>
> diff --git a/arch/riscv/include/asm/insn-def.h b/arch/riscv/include/asm/i=
nsn-def.h
> index d5adbaec1d010..3fec7e66ce50f 100644
> --- a/arch/riscv/include/asm/insn-def.h
> +++ b/arch/riscv/include/asm/insn-def.h
> @@ -179,6 +179,7 @@
>  #define RV___RS1(v)            __RV_REG(v)
>  #define RV___RS2(v)            __RV_REG(v)
>
> +#define RV_OPCODE_AMO          RV_OPCODE(47)
>  #define RV_OPCODE_MISC_MEM     RV_OPCODE(15)
>  #define RV_OPCODE_OP_IMM       RV_OPCODE(19)
>  #define RV_OPCODE_SYSTEM       RV_OPCODE(115)
> @@ -208,6 +209,84 @@
>         __ASM_STR(.error "hlv.d requires 64-bit support")
>  #endif
>
> +#define LB_AQ(dest, addr)                                      \
> +       INSN_R(OPCODE_AMO, FUNC3(0), FUNC7(26),                 \
> +              RD(dest), RS1(addr), __RS2(0))
> +
> +#define LB_AQRL(dest, addr)                                    \
> +       INSN_R(OPCODE_AMO, FUNC3(0), FUNC7(27),                 \
> +              RD(dest), RS1(addr), __RS2(0))
> +
> +#define LH_AQ(dest, addr)                                      \
> +       INSN_R(OPCODE_AMO, FUNC3(1), FUNC7(26),                 \
> +              RD(dest), RS1(addr), __RS2(0))
> +
> +#define LH_AQRL(dest, addr)                                    \
> +       INSN_R(OPCODE_AMO, FUNC3(1), FUNC7(27),                 \
> +              RD(dest), RS1(addr), __RS2(0))
> +
> +#define LW_AQ(dest, addr)                                      \
> +       INSN_R(OPCODE_AMO, FUNC3(2), FUNC7(26),                 \
> +              RD(dest), RS1(addr), __RS2(0))
> +
> +#define LW_AQRL(dest, addr)                                    \
> +       INSN_R(OPCODE_AMO, FUNC3(2), FUNC7(27),                 \
> +              RD(dest), RS1(addr), __RS2(0))
> +
> +#define SB_RL(src, addr)                                       \
> +       INSN_R(OPCODE_AMO, FUNC3(0), FUNC7(29),                 \
> +              __RD(0), RS1(addr), RS2(src))
> +
> +#define SB_AQRL(src, addr)                                     \
> +       INSN_R(OPCODE_AMO, FUNC3(0), FUNC7(31),                 \
> +              __RD(0), RS1(addr), RS2(src))
> +
> +#define SH_RL(src, addr)                                       \
> +       INSN_R(OPCODE_AMO, FUNC3(1), FUNC7(29),                 \
> +              __RD(0), RS1(addr), RS2(src))
> +
> +#define SH_AQRL(src, addr)                                     \
> +       INSN_R(OPCODE_AMO, FUNC3(1), FUNC7(31),                 \
> +              __RD(0), RS1(addr), RS2(src))
> +
> +#define SW_RL(src, addr)                                       \
> +       INSN_R(OPCODE_AMO, FUNC3(2), FUNC7(29),                 \
> +              __RD(0), RS1(addr), RS2(src))
> +
> +#define SW_AQRL(src, addr)                                     \
> +       INSN_R(OPCODE_AMO, FUNC3(2), FUNC7(31),                 \
> +              __RD(0), RS1(addr), RS2(src))
> +
> +#ifdef CONFIG_64BIT
> +#define LD_AQ(dest, addr)                                      \
> +       INSN_R(OPCODE_AMO, FUNC3(3), FUNC7(26),                 \
> +              RD(dest), RS1(addr), __RS2(0))
> +
> +#define LD_AQRL(dest, addr)                                    \
> +       INSN_R(OPCODE_AMO, FUNC3(3), FUNC7(27),                 \
> +              RD(dest), RS1(addr), __RS2(0))
> +
> +#define SD_RL(src, addr)                                       \
> +       INSN_R(OPCODE_AMO, FUNC3(3), FUNC7(29),                 \
> +              __RD(0), RS1(addr), RS2(src))
> +
> +#define SD_AQRL(src, addr)                                     \
> +       INSN_R(OPCODE_AMO, FUNC3(3), FUNC7(31),                 \
> +              __RD(0), RS1(addr), RS2(src))
> +#else
> +#define LD_AQ(dest, addr)                                      \
> +       __ASM_STR(.error "ld.aq requires 64-bit support")
> +
> +#define LD_AQRL(dest, addr)                                    \
> +       __ASM_STR(.error "ld.aqrl requires 64-bit support")
> +
> +#define SD_RL(dest, addr)                                      \
> +       __ASM_STR(.error "sd.rl requires 64-bit support")
> +
> +#define SD_AQRL(dest, addr)                                    \
> +       __ASM_STR(.error "sd.aqrl requires 64-bit support")
> +#endif
> +
>  #define SINVAL_VMA(vaddr, asid)                                        \
>         INSN_R(OPCODE_SYSTEM, FUNC3(0), FUNC7(11),              \
>                __RD(0), RS1(vaddr), RS2(asid))
> --
> 2.20.1
>
I didn't find problem.

Reviewed-by: Guo Ren <guoren@kernel.org>

--=20
Best Regards
 Guo Ren

