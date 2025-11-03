Return-Path: <linux-kernel+bounces-882541-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 28795C2AB0E
	for <lists+linux-kernel@lfdr.de>; Mon, 03 Nov 2025 10:13:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 17C5F4E90FB
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 09:13:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF4832E1EFF;
	Mon,  3 Nov 2025 09:13:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iPCfat0M"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 415A214F9D6
	for <linux-kernel@vger.kernel.org>; Mon,  3 Nov 2025 09:13:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762161183; cv=none; b=DwaLGqNlXCWB6H+WsJj/R94l0NiTr5XazFfogjOoxJP2vTxe5FPuv6Oyt2CcN3t1ndChqbikSEl9DiF/Cs1i1QN+V7icCVSGwZHUERsQbJUQ16WbRA/hf+Y+Hop6T/CaGJdSEqdsCLgPmYTJcAlPyoQYZUGcMn46kMauRJAWYIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762161183; c=relaxed/simple;
	bh=BLeGKlH4tFOe01XvDJYeXPH2ybj5CxCOnxzNCYyzS9Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tNtE/Kb2wPBhQKGxtriy75lyNAHrBuHuW6lUpubeVaItiLimZzqyhLE2hMZIbzdbR4z+HyXwvDvoXleCNNKmoJOh4aeb7VKXaUYa2ULHGeEnia/e0IL+LIi72j4eRU3khIUzz94oFEOfTTje0gJWGxF/oY7hsDBaKeNYWyST160=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iPCfat0M; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E00DDC116B1
	for <linux-kernel@vger.kernel.org>; Mon,  3 Nov 2025 09:13:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762161182;
	bh=BLeGKlH4tFOe01XvDJYeXPH2ybj5CxCOnxzNCYyzS9Y=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=iPCfat0ME0F/ezuDxC18wmk524gaGHcXIrStcp/20v6QVA0pKkQTKj3IrpIQirzLz
	 48tcfmefhU+Oh9TQZKifDzcHqaocRCw1itRArQz/0JO/eKwS4FAFKYLFRoXLRa2dA0
	 bMVpknFMIot0s0ZmeJBQcDjXbr5oTNXtptBrictpBvu2jYpByV9FPwPgstQPWB5gvv
	 8PfLJymn3pb1ehDKJ1vKr5gkLYREfoFyzN84zNplWlefUtURfBfHR1vrrpdoV/bFnW
	 C5V2QyHVmFT82vTCLj8rivb2T6Ojx0+z0ebXix09gb0FhZcMPAbYguNCmX7V3X7zTd
	 hM8ZfxD/mBOTg==
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-640741cdda7so5161218a12.2
        for <linux-kernel@vger.kernel.org>; Mon, 03 Nov 2025 01:13:02 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVheCpJxMrOuHolu9e986iUTRyIxEL1ALT2gXu9u8hueYq8wLa/CtKePn8GmfOaOPywlRhp4DA5q3SlbIQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyIxdMTMSDQt4TPz4WVAbYFahqtvMeiYQn59clTEZr6VOuTK4jc
	1FMn/rTvMx2JP0s9gLNpwZk8kJ06WXHEpxICqu8vqiAAceHEKsVblpDENH57dhPLUgYrYtnml8U
	/UuetNdbVvtfSfU0LlIzDI0da/JywLe4=
X-Google-Smtp-Source: AGHT+IH/hMANbcDUCQ1Ja+g59TP7QZglZupzPFtaLLGpzDVLHNdE2GZ9jMCMW4PouhF4L90eNs/1uFe1GslDFbf1mMk=
X-Received: by 2002:a17:907:2d29:b0:b71:8448:a8dd with SMTP id
 a640c23a62f3a-b718448abcdmr68886166b.31.1762161181401; Mon, 03 Nov 2025
 01:13:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251029-loongarch-uapi-ptrace-types-v1-1-5c84855a348d@weissschuh.net>
In-Reply-To: <20251029-loongarch-uapi-ptrace-types-v1-1-5c84855a348d@weissschuh.net>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Mon, 3 Nov 2025 17:12:58 +0800
X-Gmail-Original-Message-ID: <CAAhV-H4oDtOUB_CecFE2sPE-JSQNNWvFRmY8=ZdDOCdD8kdo7g@mail.gmail.com>
X-Gm-Features: AWmQ_bnIJsb9uCZ9U0bHJfiDhKTUuVzIxImeO2vZ69sxQ1m-TL0S9eXxKzMeQ6E
Message-ID: <CAAhV-H4oDtOUB_CecFE2sPE-JSQNNWvFRmY8=ZdDOCdD8kdo7g@mail.gmail.com>
Subject: Re: [PATCH] LoongArch: ptrace: Use UAPI types in UAPI header
To: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Cc: WANG Xuerui <kernel@xen0n.name>, Jiaxun Yang <jiaxun.yang@flygoat.com>, 
	loongarch@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi, Thomas,

On Wed, Oct 29, 2025 at 11:20=E2=80=AFPM Thomas Wei=C3=9Fschuh <linux@weiss=
schuh.net> wrote:
>
> The kernel UAPI headers already contain fixed-width integer types,
> there is no need to rely on libc types. There may not be a libc
> available or it may not provide <stdint.h>, like for example on nolibc.
>
> This also aligns the header with the rest of the LoongArch UAPI headers.
Thank you for your patch, but could you please tell me some history
and user guide about the three styles: u64, __u64 and unint64_t?

Huacai

>
> Fixes: 803b0fc5c3f2 ("LoongArch: Add process management")
> Signed-off-by: Thomas Wei=C3=9Fschuh <linux@weissschuh.net>
> ---
> I'd like to take this through the nolibc tree, as this currently breaks
> the upcoming nolibc ptrace support.
> ---
>  arch/loongarch/include/uapi/asm/ptrace.h | 40 ++++++++++++++------------=
------
>  1 file changed, 18 insertions(+), 22 deletions(-)
>
> diff --git a/arch/loongarch/include/uapi/asm/ptrace.h b/arch/loongarch/in=
clude/uapi/asm/ptrace.h
> index aafb3cd9e943..215e0f9e8aa3 100644
> --- a/arch/loongarch/include/uapi/asm/ptrace.h
> +++ b/arch/loongarch/include/uapi/asm/ptrace.h
> @@ -10,10 +10,6 @@
>
>  #include <linux/types.h>
>
> -#ifndef __KERNEL__
> -#include <stdint.h>
> -#endif
> -
>  /*
>   * For PTRACE_{POKE,PEEK}USR. 0 - 31 are GPRs,
>   * 32 is syscall's original ARG0, 33 is PC, 34 is BADVADDR.
> @@ -41,44 +37,44 @@ struct user_pt_regs {
>  } __attribute__((aligned(8)));
>
>  struct user_fp_state {
> -       uint64_t fpr[32];
> -       uint64_t fcc;
> -       uint32_t fcsr;
> +       __u64 fpr[32];
> +       __u64 fcc;
> +       __u32 fcsr;
>  };
>
>  struct user_lsx_state {
>         /* 32 registers, 128 bits width per register. */
> -       uint64_t vregs[32*2];
> +       __u64 vregs[32*2];
>  };
>
>  struct user_lasx_state {
>         /* 32 registers, 256 bits width per register. */
> -       uint64_t vregs[32*4];
> +       __u64 vregs[32*4];
>  };
>
>  struct user_lbt_state {
> -       uint64_t scr[4];
> -       uint32_t eflags;
> -       uint32_t ftop;
> +       __u64 scr[4];
> +       __u32 eflags;
> +       __u32 ftop;
>  };
>
>  struct user_watch_state {
> -       uint64_t dbg_info;
> +       __u64 dbg_info;
>         struct {
> -               uint64_t    addr;
> -               uint64_t    mask;
> -               uint32_t    ctrl;
> -               uint32_t    pad;
> +               __u64    addr;
> +               __u64    mask;
> +               __u32    ctrl;
> +               __u32    pad;
>         } dbg_regs[8];
>  };
>
>  struct user_watch_state_v2 {
> -       uint64_t dbg_info;
> +       __u64 dbg_info;
>         struct {
> -               uint64_t    addr;
> -               uint64_t    mask;
> -               uint32_t    ctrl;
> -               uint32_t    pad;
> +               __u64    addr;
> +               __u64    mask;
> +               __u32    ctrl;
> +               __u32    pad;
>         } dbg_regs[14];
>  };
>
>
> ---
> base-commit: 3a8660878839faadb4f1a6dd72c3179c1df56787
> change-id: 20251029-loongarch-uapi-ptrace-types-0c5c6756f7e0
>
> Best regards,
> --
> Thomas Wei=C3=9Fschuh <linux@weissschuh.net>
>
>

