Return-Path: <linux-kernel+bounces-786236-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CAA2B356F0
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 10:33:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 456E5189E4D4
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 08:33:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 557302FA0F2;
	Tue, 26 Aug 2025 08:33:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IyOy3/p7"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80EB52F99BD
	for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 08:33:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756197181; cv=none; b=SDBD5je3dgnlL/rReSNAXd2cUj61osL67VXyRo9Yv1pgLQwI4AYwocDG9ZLvkRyp8fsO83FpS5dzsRm62SUMGcsd1JQ9a6pJsZHPKPxUdFE49Aw8PciB9YArg1Q3Lttuj3INhVmR/iBFuXvgmc1fRUqSl8dd3M/AlzLeg5ixeFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756197181; c=relaxed/simple;
	bh=FjVXVuF1xn0IxzPYpX/KhacBnVflH7IadABK4fObM6U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Gk4QX6aAPtHnzj9NFUKLwNkidJsjVLTwdb04HyBfq2zgzLIC96LzjywJVp4KeXPBQXom+s7+U5kzZvYDoCpiUys0Z7EMeBkRCjibk/pHmTdDBbalIzq88+8oZeQHJbWLqSXjhrBX6RSbVFS7bLJLcj3z78URhGckmmu5ZnwMWY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IyOy3/p7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3358BC116B1
	for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 08:33:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756197181;
	bh=FjVXVuF1xn0IxzPYpX/KhacBnVflH7IadABK4fObM6U=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=IyOy3/p7IOVfAJpH1rA7uszKC7eN/YhNGsD8sBD1nCPCPAmqDZXamsZ17OwunQ5BS
	 o1JOCDtKDp177eWggA4HZ1evXA3WE9fQaFSwqKnxCY1IM/QBctg+02gZ/WOZBRe2R1
	 ZvUIcb1XDjc8ZxOpm3sG/DNqhdx21te2N5Rjfiy8h3xoFSPEsd2yE5tKgYLOntHeK3
	 WTNlFds/Dh8UV2rWUm413Iev8vjnciSeIUEfCHz+GtTI4C+1rl9LS860VF+Vvl0eLm
	 T+hwcxdvxliIPDH1lKM9IbXeCj8kk5Vc2qALGMF6CLNunFU8s63KqkIcv4jM+wtKcl
	 Tek/TbODpw2Zw==
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-61c4f73cfa0so4112361a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 01:33:01 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWJSqJJtj/Vl35d+iGKDJQS1/V+sPA0rCgeEyNc5ZeLOK9wzQGZ6K7/MUK3T57VqOHtBpMvHzRWNt1veI0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwzEOMu8sy7VdqfVR6ha5ZpT/HpqYELksDS/+dD5okFJmicOZ6t
	Ez1A0PvxQaBM5m9J3qxp8Z4FLb3sCfX8fBkeadh3QDSGVJIAUCvIL/Yw5qC+5kTbIT5YgQTYT9A
	hHEcTlz0KFJ42vzvoTfQR065lsuKeB6A=
X-Google-Smtp-Source: AGHT+IERbkTyzj+RHu5TkKBknnsaDb5gk0cJDOCT93hgIUxeh6Ko1mDfwDxFcko7i2c+sF3jdPl2NNcVvHiL4PIpAaE=
X-Received: by 2002:a05:6402:44d2:b0:615:78c6:7aed with SMTP id
 4fb4d7f45d1cf-61c1b705611mr9585880a12.32.1756197179778; Tue, 26 Aug 2025
 01:32:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250826064631.9617-1-yangtiezhu@loongson.cn> <20250826064631.9617-2-yangtiezhu@loongson.cn>
In-Reply-To: <20250826064631.9617-2-yangtiezhu@loongson.cn>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Tue, 26 Aug 2025 16:32:46 +0800
X-Gmail-Original-Message-ID: <CAAhV-H5wW_04NHQ7z+SCPb6-T5Hc__n+x=ykg-u9vn4b4GXuww@mail.gmail.com>
X-Gm-Features: Ac12FXy0nLJKelVgOhaUqkw-rRI1Okua2pWt9oXv_S0FhdaFrsPpYhr3PJI-9AY
Message-ID: <CAAhV-H5wW_04NHQ7z+SCPb6-T5Hc__n+x=ykg-u9vn4b4GXuww@mail.gmail.com>
Subject: Re: [RFC PATCH 1/2] objtool/LoongArch: Fix fall through warning about efi_boot_kernel()
To: Tiezhu Yang <yangtiezhu@loongson.cn>
Cc: Josh Poimboeuf <jpoimboe@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Nathan Chancellor <nathan@kernel.org>, loongarch@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 26, 2025 at 2:46=E2=80=AFPM Tiezhu Yang <yangtiezhu@loongson.cn=
> wrote:
>
> When compiling with LLVM and CONFIG_LTO_CLANG is set, there exists
> the following objtool warning:
>
>   vmlinux.o: warning: objtool: __efistub_efi_boot_kernel()
>   falls through to next function __efistub_exit_boot_func()
>
> This is because efi_boot_kernel() doesn't end with a return instruction
> or an unconditional jump, then objtool has determined that the function
> can fall through into the next function.
>
> Actually, efi_boot_kernel()'s last instruction is "jirl $ra, $a3, 0", it
> is a call to a noreturn function pointer real_kernel_entry() which points
> to the symbol kernel_entry() in arch/loongarch/kernel/head.S.
>
> drivers/firmware/efi/libstub/loongarch.c:
>
> typedef void __noreturn (*kernel_entry_t)(bool efi, unsigned long cmdline=
,
>                                           unsigned long systab);
>
> efi_status_t efi_boot_kernel(void *handle, efi_loaded_image_t *image,
>                              unsigned long kernel_addr, char *cmdline_ptr=
)
> {
>         kernel_entry_t real_kernel_entry;
>         ...
>         real_kernel_entry =3D (void *)kernel_entry_address(kernel_addr, i=
mage);
>
>         real_kernel_entry(true, (unsigned long)cmdline_ptr,
>                           (unsigned long)efi_system_table);
> }
>
> According to the description of tools/objtool/Documentation/objtool.txt,
> in order to silence this warning, at the beginning just add the noreturn
> real_kernel_entry() to objtool's hard-coded global_noreturns array, but
> there is no effect, because it is not a valid symbol.
>
> There exists an alternative way to silence this warning, the first thing
> is to remove the attribute __noreturn for real_kernel_entry(), otherwise
> the compiler can not generate instructions after that, and then just add
> "while (1);" at the end of efi_boot_kernel(), so that efi_boot_kernel()
> ends with an unconditional jump instruction "b".
>
> Note that at the end of efi_boot_kernel(), using unreachable() has no
> effect because it can still generate fall-through code, using BUG() is
> not proper because it will generate the following ld.lld warning:
>
>   vmlinux.o:(.init__bug_table) is being placed in '.init__bug_table'
>
> Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
> ---
>  drivers/firmware/efi/libstub/loongarch.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/firmware/efi/libstub/loongarch.c b/drivers/firmware/=
efi/libstub/loongarch.c
> index 3782d0a187d1..e309fd78fca7 100644
> --- a/drivers/firmware/efi/libstub/loongarch.c
> +++ b/drivers/firmware/efi/libstub/loongarch.c
> @@ -10,7 +10,7 @@
>  #include "efistub.h"
>  #include "loongarch-stub.h"
>
> -typedef void __noreturn (*kernel_entry_t)(bool efi, unsigned long cmdlin=
e,
> +typedef void (*kernel_entry_t)(bool efi, unsigned long cmdline,
>                                           unsigned long systab);
From my point of view this is incorrect, this function is indeed a
noreturn function, and this modification makes LoongArch different to
other architectures.

Maybe it is better to let objtool ignore the whole
drivers/firmware/efi/libstub directory. Because efistub is discarded
at runtime so it is useless for stack unwinder.

Huacai

>
>  efi_status_t check_platform_features(void)
> @@ -81,4 +81,7 @@ efi_status_t efi_boot_kernel(void *handle, efi_loaded_i=
mage_t *image,
>
>         real_kernel_entry(true, (unsigned long)cmdline_ptr,
>                           (unsigned long)efi_system_table);
> +
> +       /* We should never get here */
> +       while (1);
>  }
> --
> 2.42.0
>

