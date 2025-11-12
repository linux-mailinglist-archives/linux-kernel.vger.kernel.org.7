Return-Path: <linux-kernel+bounces-896986-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A0AD2C51BEF
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 11:45:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 29C363ADE73
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 10:33:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41AC9305053;
	Wed, 12 Nov 2025 10:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HfL+bSEw"
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E235F2BE7C3
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 10:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762943481; cv=none; b=MM8cjjoBMizn6bkfv9X6VxsEMJg709HAfMFUCfWUH1gbCmDihS0x57Y/BoaRAlFYYuDslgr+uqGeSaK6vGel5ACNo7fBsY355cpKa6aL7FwxIbUP+AK9rEzS2QQQpmf18EiXlZVHEHnKOn/lLfWl1x5XsBtOlF9TtJD64piOMJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762943481; c=relaxed/simple;
	bh=M9rPE1goU/HVcEQFn/k8fKVTrLfA/gTQELK3Ta2iG8Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UeT+nfaovQDka/8Iprnjga9klwhXZXIw40tllUVsICFS8BBRN37xSg9XdaAPmmGlQnI4LLHSNt2tnGzZ8tGpRPHxBC+tuLDn6y2e8B/0JxuwwqjdcsuW5BwvmEo1zasL3cXdIOtCBtrM/YUMJ2rlwq1AR/l4UQxxWaSbygQ/61I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HfL+bSEw; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-37b983fbd45so1139701fa.3
        for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 02:31:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762943478; x=1763548278; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=waFQrQEMkwV0AnBAZW1IyENDtfIMwyrwUkcDrilArcw=;
        b=HfL+bSEw6Yy5CWliBdg7XzNU6cg9MA0e8spTEBhxCId3jDA2SmXCPDw4HzHPEHZM6r
         zr8t591muJkwcuhy5JLlXSbhT8tJNfbBUpwCTjobmsBKItkF5VAJ6VlQhEa1x0+kddEE
         2HeSJ9NxopTKLfah4u2rXl+/56OyQxepB+LLfBczzzjAFI5VyceMvE+OKliDMfq2/sqY
         yCPvB2IIUSoIpfAKb76FBa5L7po1r4KA882OpKDLvdbxnZsIkZx2r58ke5dWEu18lAO4
         LMt8oSNsjrhIS2mnJkfuIRXonGcvbAwmTDpZGZwWR3AUEZJOZ+wXjp0Xw5GSo/BQuvVA
         wsOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762943478; x=1763548278;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=waFQrQEMkwV0AnBAZW1IyENDtfIMwyrwUkcDrilArcw=;
        b=QZF38QjHuiD3qr0/jk/TN7Y2ifkOQhQADIY9kcQjYjX8h/yiTpxZ7ZMB2H4PNQJlXn
         4VPKy2h/iJ7h5VVF6GXUmZlL3fCcMsOTlxKDIE/LIxDQ6MxWEldVd6d9T94WZdG3yizv
         4P0TjqWK/iLo6Hbk6vpCS+WSOOOgQvQXVon/alctc1fIUllWS5eeqaRV/2yqdjvEu9Jl
         1RJO/ej0wRPVcnnv15AEBC9A21a1o4xYB16C+/eV+z5weNddLnXPYpAyi45UKkFpgV4q
         D9VKfxiW2bch5ALa5tGT1jmLBoRekxPr3Dmq6gDSWzscOwQbdJUlZ9UGWW3aM8PpLCGZ
         svgA==
X-Forwarded-Encrypted: i=1; AJvYcCViVPYUxRtI56qvKfWPVBt15VPNhy9iFTl+zNUnAOnqS5WaJ7QyHZtEHRyemBjOSuqPi9oxTZ4NbiVzj6E=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw984oMsY7vgsCbg++awVviHUkljVTVefi9V2hTt7K+t+MPpzeL
	iThf6PSd2wDRcPJYLNfr/yKChrJYKyTmPh8TBeWvA/uH+1oOlgvPfUsAdDfGReM0WEEnt74P5xV
	wf+OpIXgFr6u6Y5C/vuBJLyj1qnVvz6E=
X-Gm-Gg: ASbGncsVV4VD/f/bPsYrJfy517m7nwqfSTa9599EU+fZPVxBu2dvb2nnn98Sp70jUZk
	I/+X84/SCp8/5z87IyLpoH7gcDowbnnWOpdOHPFL5Kpij0cnfWHd+7bqck7KoLrW/jUU6rZJHA0
	gcYyITGd4+bOAERYFot55rZVOhkMRom0sxUJoqRjp6HgGNizKXskn+XodKZaAc+vzaXzfC0u5SB
	omkzQ7ZKadszUsLnxnolzZBL3UV3RJHf2I3aaLfu3uhAG5yr/yE/npKamWVHv3x58TlZos=
X-Google-Smtp-Source: AGHT+IFjqgrhQOtTb5gBhAyMW1L6vKw3JdPMp9cVBsW7gktCSYBmB2KY0NW2W13eaBsDxYqKpi5mZFREAYsMq4231Cw=
X-Received: by 2002:a05:6512:10c2:b0:594:28f6:b065 with SMTP id
 2adb3069b0e04-59576df6d1cmr753013e87.17.1762943477499; Wed, 12 Nov 2025
 02:31:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251112043730.992152-1-hpa@zytor.com> <20251112043730.992152-8-hpa@zytor.com>
In-Reply-To: <20251112043730.992152-8-hpa@zytor.com>
From: Uros Bizjak <ubizjak@gmail.com>
Date: Wed, 12 Nov 2025 11:31:05 +0100
X-Gm-Features: AWmQ_bl_6enZNq-U70wxnLPV5q31f2DKNvw7Lw1-kfdYqLTgPTZDCUhJgguZtAk
Message-ID: <CAFULd4aMOueG5y3K7F57ryLtt-JUhE-yfsDODC=5+bgjF_gtSw@mail.gmail.com>
Subject: Re: [PATCH v2 7/9] x86/vdso: abstract out vdso system call internals
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: "Jason A. Donenfeld" <Jason@zx2c4.com>, "Peter Zijlstra (Intel)" <peterz@infradead.org>, "Theodore Ts'o" <tytso@mit.edu>, 
	=?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>, 
	Xin Li <xin@zytor.com>, Andrew Cooper <andrew.cooper3@citrix.com>, 
	Andy Lutomirski <luto@kernel.org>, Ard Biesheuvel <ardb@kernel.org>, Borislav Petkov <bp@alien8.de>, 
	Brian Gerst <brgerst@gmail.com>, Dave Hansen <dave.hansen@linux.intel.com>, 
	Ingo Molnar <mingo@redhat.com>, James Morse <james.morse@arm.com>, 
	Jarkko Sakkinen <jarkko@kernel.org>, Josh Poimboeuf <jpoimboe@kernel.org>, Kees Cook <kees@kernel.org>, 
	Nam Cao <namcao@linutronix.de>, Oleg Nesterov <oleg@redhat.com>, Perry Yuan <perry.yuan@amd.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Thomas Huth <thuth@redhat.com>, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, linux-sgx@vger.kernel.org, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 12, 2025 at 5:38=E2=80=AFAM H. Peter Anvin <hpa@zytor.com> wrot=
e:
>
> Abstract out the calling of true system calls from the vdso into
> macros.
>
> It has been a very long time since gcc did not allow %ebx or %ebp in
> inline asm in 32-bit PIC mode; remove the corresponding hacks.
>
> Remove the use of memory output constraints in gettimeofday.h in favor
> of "memory" clobbers. The resulting code is identical for the current
> use cases, as the system call is usually a terminal fallback anyway,
> and it merely complicates the macroization.
>
> This patch adds only a handful of more lines of code than it removes,
> and in fact could be made substantially smaller by removing the macros
> for the argument counts that aren't currently used, however, it seems
> better to be general from the start.
>
> Signed-off-by: H. Peter Anvin (Intel) <hpa@zytor.com>

[...]

> diff --git a/arch/x86/include/asm/vdso/sys_call.h b/arch/x86/include/asm/=
vdso/sys_call.h
> new file mode 100644
> index 000000000000..6b1fbcdcbd5c
> --- /dev/null
> +++ b/arch/x86/include/asm/vdso/sys_call.h
> @@ -0,0 +1,119 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Macros for issuing an inline system call from the vDSO.
> + */
> +
> +#ifndef X86_ASM_VDSO_SYS_CALL_H
> +#define X86_ASM_VDSO_SYS_CALL_H
> +
> +#include <linux/compiler.h>
> +#include <asm/cpufeatures.h>
> +#include <asm/alternative.h>
> +
> +/*
> + * Note: only three arguments are currently supported,
> + * because there are no constraint letters for r10, r8, r9.

The above comment does not apply when using local variables associated
with a register.

> + */
> +#ifdef CONFIG_X86_64
> +/* Using dummy output registers instead of clobbers avoids messing up
> +   user-specified clobbers. */
> +#define __sys_instr    "syscall"
> +#define __sys_clobber  "rcx", "r11", "memory"
> +#define __sys_nr(x,y)  __NR_ ## x
> +#define __sys_reg1     "rdi"
> +#define __sys_reg2     "rsi"
> +#define __sys_reg3     "rdx"
> +#define __sys_reg4     "r10"
> +#define __sys_reg5     "r8"
> +#define __sys_reg6     "r9"
> +#else
> +#define __sys_instr    "call __kernel_vsyscall"
> +#define __sys_clobber  "memory"
> +#define __sys_nr(x,y)  __NR_ ## x ## y
> +#define __sys_reg1     "ebx"
> +#define __sys_reg2     "ecx"
> +#define __sys_reg3     "edx"
> +#define __sys_reg4     "esi"
> +#define __sys_reg5     "edi"
> +#define __sys_reg6     "ebp"
> +#endif

[...]

> +#define VDSO_SYSCALL6(name,suf32,a1,a2,a3,a4,a5,a6)                    \
> +       ({                                                              \
> +               register long _sys_arg1 asm(__sys_reg1) =3D (long)(a1);  =
 \
> +               register long _sys_arg2 asm(__sys_reg2) =3D (long)(a2);  =
 \
> +               register long _sys_arg3 asm(__sys_reg3) =3D (long)(a3);  =
 \
> +               register long _sys_arg4 asm(__sys_reg4) =3D (long)(a4);  =
 \
> +               register long _sys_arg5 asm(__sys_reg5) =3D (long)(a5);  =
 \
> +               register long _sys_arg6 asm(__sys_reg6) =3D (long)(a6);  =
 \
> +               _VDSO_SYSCALL(name,suf32,                               \
> +                             "r" (_sys_arg1), "r" (_sys_arg2),         \
> +                             "r" (_sys_arg3), "r" (_sys_arg4),         \
> +                             "r" (_sys_arg5), "r" (_sys_arg6));        \
> +       })

Unfortunately, %ebp is still special with -fno-omit-frame-pointer, so
using "ebp" as _sys_arg6 on 32-bit targets will result in:

error: bp cannot be used in =E2=80=98asm=E2=80=99 here

Please see how %ebp register is handled in
arch/x86/include/asm/vmware.h, vmware_hypercall_hb_out() and
vmware_hypercall_hb_in().

Uros.

