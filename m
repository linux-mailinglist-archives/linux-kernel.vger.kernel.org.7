Return-Path: <linux-kernel+bounces-824647-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A3629B89C36
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 16:00:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 11490A01376
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 13:59:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5ACDB313D72;
	Fri, 19 Sep 2025 13:59:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GP5fByxu"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FAF8313D58
	for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 13:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758290376; cv=none; b=nGYj8XQ0AY+oc+iXagjtKpMXeHEl67KQ1VYPn8drRTF1AGFGD52njXYVlwXO340OVEAIh+ESd9eKbDus2UrsdHhjN8vxQpzFQ6D7R7ba+bgtyqgMjYjhscmh5T33fb8qMMT7UJ5u/yr94K4Q7tvAH/EhrtNUnWEykgu34V0WEPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758290376; c=relaxed/simple;
	bh=81q+MTaKBG8CfXjRMrYDmASQ3S/UvV9H34HP13VPEQQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sNPzDgjIhZPQyErPpY2sgArbYIWWVsbhzaC63n6gLdFbTEpipCzasoFEfPO04gxDQkTT0bN1/qz1TMbJ6yjrQkhIKgPSNeOSClwYc+Zw9CQOQi95mw9MGaMBR4kEB7r0cUR2ejoSJwwxLYYPBubMY5DEYhQPshbHxJf2O38MBlc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GP5fByxu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06664C4CEFE
	for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 13:59:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758290376;
	bh=81q+MTaKBG8CfXjRMrYDmASQ3S/UvV9H34HP13VPEQQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=GP5fByxuaEjXADf8m/MkJbtHV8GYlgKZs2keCDGTNOXPOSZc3Tx5Owtf9hgEYN7+u
	 OwTu3fEhL4vpg9b8uXXIiEImyaPZ627LLu9ASwYEUUkuHXxJZ2UMdrAFxVtxTAdWd+
	 8sgHsfjHDmhekexBpbYj9g/ba+DH/Gz1oVVeVjyqpbcEaSbaUKdp0PbHpTLn4OE6eX
	 tMXpiHgZ8u7xm2nBjgVmATisDB6Ssd0ac/wySodHxhV/noJ8w9tt/TVMPNbZaxRQ7l
	 osFkyN3BLG091FGY8RieUPc3bExcvB8j/0veZ3TtuWKBslcI/uZHt69okyRgg+XenE
	 Iaj+xoMB27GcQ==
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-55f7ab2a84eso2528896e87.1
        for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 06:59:35 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVQZOKh3SpN1Ojy3UjkQ6xMbRw9J19LtXS0VnL62UFTa7cW+9U6l88D6YXST2snE9XDzCeSrrLV4XYn1zc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwEfpJyCtPnsZ8Z83P9kJBB1Tmayfn0DSROAqAm/2iTZ0mD3jJq
	f+D6tsQCXkQOI4v/mm+M8sYvGNxTJchiauiOtPeMz2z7y51E9HY47KVPJeR4nrymTraXoi6aMBI
	/VxwDB/hDP3c7k9cGNn78eDmTbJ8Loa0=
X-Google-Smtp-Source: AGHT+IE2JsaESq2LH0BwFhzGZicRptZYyiQAutqhKUmtEukYJlEAcmn6+ZMx9m5iDT8EwVZIVletlt8bWMjmPNl4PYY=
X-Received: by 2002:ac2:4e0a:0:b0:56b:8c56:f590 with SMTP id
 2adb3069b0e04-579e1b69156mr1267187e87.7.1758290374310; Fri, 19 Sep 2025
 06:59:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250919122321.946462-1-abarnas@google.com> <20250919122321.946462-2-abarnas@google.com>
In-Reply-To: <20250919122321.946462-2-abarnas@google.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Fri, 19 Sep 2025 15:59:21 +0200
X-Gmail-Original-Message-ID: <CAMj1kXEVThBdH7H7NX+Ma8j0_85GevzczFgvvozK-TsqT2geFw@mail.gmail.com>
X-Gm-Features: AS18NWBXGy-3dQXH8iKb7BJvegBRmMgS6hSgacUSgWyOsOJxDrJciKIzKDkVygo
Message-ID: <CAMj1kXEVThBdH7H7NX+Ma8j0_85GevzczFgvvozK-TsqT2geFw@mail.gmail.com>
Subject: Re: [PATCH 1/2] arch: arm64: Fail module loading if dynamic SCS
 patching fails
To: =?UTF-8?Q?Adrian_Barna=C5=9B?= <abarnas@google.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	Dylan Hatch <dylanbhatch@google.com>, Mark Rutland <mark.rutland@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, 19 Sept 2025 at 14:23, Adrian Barna=C5=9B <abarnas@google.com> wrot=
e:
>
> Disallow a module to load if SCS dynamic patching fails for its code. For
> module loading, instead of running a dry-run to check for patching errors=
,
> try to run patching in the first run and propagate any errors so module
> loading will fail.
>
> Signed-off-by: Adrian Barna=C5=9B <abarnas@google.com>
> ---
>  arch/arm64/include/asm/scs.h      |  2 +-
>  arch/arm64/kernel/module.c        |  6 ++++--
>  arch/arm64/kernel/pi/map_kernel.c |  2 +-
>  arch/arm64/kernel/pi/patch-scs.c  | 15 +++++++++++----
>  arch/arm64/kernel/pi/pi.h         |  2 +-
>  5 files changed, 18 insertions(+), 9 deletions(-)
>
> diff --git a/arch/arm64/include/asm/scs.h b/arch/arm64/include/asm/scs.h
> index a76f9b387a26..ffcfcda87f10 100644
> --- a/arch/arm64/include/asm/scs.h
> +++ b/arch/arm64/include/asm/scs.h
> @@ -53,7 +53,7 @@ enum {
>         EDYNSCS_INVALID_CFA_OPCODE              =3D 4,
>  };
>
> -int __pi_scs_patch(const u8 eh_frame[], int size);
> +int __pi_scs_patch(const u8 eh_frame[], int size, bool is_module);
>

Calling the parameter 'is_module' puts the policy in the SCS patching
code, which now has to reason about how patching a module differs from
patching other code.

So I'd prefer to call this 'two_pass' or 'dry_run' or whatever, where
setting it guarantees that when an error is returned, no function will
be left in an inconsistent state.

>  #endif /* __ASSEMBLY __ */
>
> diff --git a/arch/arm64/kernel/module.c b/arch/arm64/kernel/module.c
> index 40148d2725ce..5d6d228c6156 100644
> --- a/arch/arm64/kernel/module.c
> +++ b/arch/arm64/kernel/module.c
> @@ -484,10 +484,12 @@ int module_finalize(const Elf_Ehdr *hdr,
>         if (scs_is_dynamic()) {
>                 s =3D find_section(hdr, sechdrs, ".init.eh_frame");
>                 if (s) {
> -                       ret =3D __pi_scs_patch((void *)s->sh_addr, s->sh_=
size);
> -                       if (ret)
> +                       ret =3D __pi_scs_patch((void *)s->sh_addr, s->sh_=
size, true);
> +                       if (ret) {
>                                 pr_err("module %s: error occurred during =
dynamic SCS patching (%d)\n",
>                                        me->name, ret);
> +                               return -ENOEXEC;
> +                       }
>                 }
>         }
>
> diff --git a/arch/arm64/kernel/pi/map_kernel.c b/arch/arm64/kernel/pi/map=
_kernel.c
> index 0f4bd7771859..7187eda9e8a5 100644
> --- a/arch/arm64/kernel/pi/map_kernel.c
> +++ b/arch/arm64/kernel/pi/map_kernel.c
> @@ -98,7 +98,7 @@ static void __init map_kernel(u64 kaslr_offset, u64 va_=
offset, int root_level)
>
>                 if (enable_scs) {
>                         scs_patch(__eh_frame_start + va_offset,
> -                                 __eh_frame_end - __eh_frame_start);
> +                                 __eh_frame_end - __eh_frame_start, fals=
e);
>                         asm("ic ialluis");
>
>                         dynamic_scs_is_enabled =3D true;
> diff --git a/arch/arm64/kernel/pi/patch-scs.c b/arch/arm64/kernel/pi/patc=
h-scs.c
> index 55d0cd64ef71..78266fb1fa61 100644
> --- a/arch/arm64/kernel/pi/patch-scs.c
> +++ b/arch/arm64/kernel/pi/patch-scs.c
> @@ -225,7 +225,7 @@ static int scs_handle_fde_frame(const struct eh_frame=
 *frame,
>         return 0;
>  }
>
> -int scs_patch(const u8 eh_frame[], int size)
> +int scs_patch(const u8 eh_frame[], int size, bool is_module)
>  {
>         int code_alignment_factor =3D 1;
>         bool fde_use_sdata8 =3D false;
> @@ -276,12 +276,19 @@ int scs_patch(const u8 eh_frame[], int size)
>                                 return EDYNSCS_INVALID_CIE_SDATA_SIZE;
>                         }
>                 } else {
> +                       /*
> +                        * For loadable module instead of running a dry r=
un try
> +                        * to patch scs instruction in place and trigger =
error
> +                        * if failed, to prevent module loading.
> +                        */

Move this comment to the module loader, and explain why the two pass
approach is not needed in this case.

>                         ret =3D scs_handle_fde_frame(frame, code_alignmen=
t_factor,
> -                                                  fde_use_sdata8, true);
> +                                                  fde_use_sdata8, !is_mo=
dule);
>                         if (ret)
>                                 return ret;
> -                       scs_handle_fde_frame(frame, code_alignment_factor=
,
> -                                            fde_use_sdata8, false);
> +
> +                       if (!is_module)
> +                               scs_handle_fde_frame(frame, code_alignmen=
t_factor,
> +                                                    fde_use_sdata8, fals=
e);
>                 }
>
>                 p +=3D sizeof(frame->size) + frame->size;
> diff --git a/arch/arm64/kernel/pi/pi.h b/arch/arm64/kernel/pi/pi.h
> index 46cafee7829f..4ccbba24fadc 100644
> --- a/arch/arm64/kernel/pi/pi.h
> +++ b/arch/arm64/kernel/pi/pi.h
> @@ -27,7 +27,7 @@ extern pgd_t init_pg_dir[], init_pg_end[];
>  void init_feature_override(u64 boot_status, const void *fdt, int chosen)=
;
>  u64 kaslr_early_init(void *fdt, int chosen);
>  void relocate_kernel(u64 offset);
> -int scs_patch(const u8 eh_frame[], int size);
> +int scs_patch(const u8 eh_frame[], int size, bool is_module);
>
>  void map_range(u64 *pgd, u64 start, u64 end, u64 pa, pgprot_t prot,
>                int level, pte_t *tbl, bool may_use_cont, u64 va_offset);
> --
> 2.51.0.534.gc79095c0ca-goog
>

