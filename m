Return-Path: <linux-kernel+bounces-839140-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EB0CBB0E65
	for <lists+linux-kernel@lfdr.de>; Wed, 01 Oct 2025 17:00:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 726FB16AB25
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Oct 2025 14:59:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F40BA305942;
	Wed,  1 Oct 2025 14:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nj0W6Rp+"
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C800302CA7
	for <linux-kernel@vger.kernel.org>; Wed,  1 Oct 2025 14:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759330242; cv=none; b=StQSDCoOzJ5AIkCLx2p7vKn1ARiwa38J9rbqJlS9BIvuc6j0ArgkzL5SqvmOV+bwIWTf+5ndKFY6XpApNzenAdUM6QoMj4X/DMEeXpOjgZmV4AHi3EJJi+TexgdCvVzvkFIjqWKsbmhvPJfSpQegKJ4J/4cCOAzCWYoHi4DHZCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759330242; c=relaxed/simple;
	bh=yxMt2qCaQ5tmnS47uYirHSPMgaRld5JIVD6U/IxjrEI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=o7SU2eL34vEAreQHsW//zb6HfOZ9hYGGjmIa611kVAAXb+nPSPFAqEYho+uf0b/eqaB9bC1JdTfePkL1ieKY++lBXmSGfrLnDWiSDgeXKTaf8QD0rHttWht3IxnSMmc/QgqjbpmN5TpIge8Wm4d+1XTjItHWdtMtCXyTWnMjUgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nj0W6Rp+; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-b4539dddd99so406170866b.1
        for <linux-kernel@vger.kernel.org>; Wed, 01 Oct 2025 07:50:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759330239; x=1759935039; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A8lRt4XHwJ7UvsCLPeu4+rhzugEZMDTQiB2MnJ1uj9o=;
        b=nj0W6Rp+iv64HY/R1qIgf+PlLyiqlc9pNq8Y1/tFDoyP/TRDeAv7iQ+oaU6PootYYf
         0LBn8BxyCRrBqz6CIPf+jG9OPBsAQQ+j2MToY9RThgQqUsCzxWLsp9fG+xDAPIXQKx/V
         gxpnT/h/+feNbJ0BNd2vQ3Hg9SRYVw7bYasTx7Mhajsc5ClZCpuE+fiv+grzrWFvPJ9e
         C78t4U3SL8LYq1hikmPRCNuhxFqaGoXxVv/0a6LGHBfZU2ix/TZ2CFN9bhcts3FwXUsI
         0wm5Oxb83X40fUvXjr6vOXuCXaDmQa+ZB2hgOVA9gj7hYo4s7rracW9c6Wv08gdHaFsz
         Fs2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759330239; x=1759935039;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A8lRt4XHwJ7UvsCLPeu4+rhzugEZMDTQiB2MnJ1uj9o=;
        b=q20iRhpzDzc4wVolbXUFUFpgFpcgAwwUu0a0d6AgdX6T/WoaS/NlYYk4DeCmsHGL+k
         /DCi6si1a6/dE30ZF80OXvEZQSktE2vYQoA39QO5TE9UCCZmGhfFvdXsuyG5z/FLxWAp
         wmj/LzSSI3bF+jx3YP0bgexMMIULtuDPewmLcykuA3jJ+sKRU9ebsv8fV91Esc3W9RLz
         qBk0ewsO7GvTc2/V3zW/Lt4/2rttLDW+zkMAiXMKoNjBr8cWWV19NhKRfzIX6Wte6Z6a
         J5TXjbz05/kydMWEjgSNzi0CpZHWpsZ4idQ5ihUa6Uy+273rKxV0lUWCrrfFueZVskXB
         b6tA==
X-Gm-Message-State: AOJu0YwDM68RfcSVWJxmpOklRQYNtpi7SvIAGhPcPkHZWRVfPzWgN7RP
	6oDmjkWjw+TL8HUO2GqWDm+k7cpQLiq8kW8Tv5+Fxmnn8pUGOg2YeinH0wzJTneNivCzQNc3HIz
	n/CpYTVBQbou1lqdQ7WmNEWCxbAgSmjE=
X-Gm-Gg: ASbGncvzRy5UJ+soEBILcRb1+QNbE3ILSzDXQZ8iJ0k/Ht2tcXz1/kF6lTf2j285253
	TwZDUqzE/U+5ON+c2IqjI+/Mx747YiduNIWTUjPy+xTjmuoSJAbcevaNqtDRQHLFVG3CCmshQiX
	XONZN25ux99AaOnTJjCpVJdO+hi234UKpah6xx357apkRzmH90J35FAkOJykobmu9quF2dRrypv
	reaThakbhBD3qC23XjN/5mEMje1p6KZoPGcllY=
X-Google-Smtp-Source: AGHT+IEhW4lQ4WJT42kTkGOTiSAPW7s/VSisFri50F+d7aFn93mDixmo8lCDZlBNBzV6Hf2cQ06jYV3kJ9ZpzgiY6Ps=
X-Received: by 2002:a17:907:6ea5:b0:b41:873d:e218 with SMTP id
 a640c23a62f3a-b46e2ff48damr449585766b.14.1759330238487; Wed, 01 Oct 2025
 07:50:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251001111451.299163-1-yongxuan.wang@sifive.com> <20251001111451.299163-2-yongxuan.wang@sifive.com>
In-Reply-To: <20251001111451.299163-2-yongxuan.wang@sifive.com>
From: Andy Chiu <andybnac@gmail.com>
Date: Wed, 1 Oct 2025 09:50:25 -0500
X-Gm-Features: AS18NWCjePyVL2irwP1oRSr4D1JRwAnvm3VjfUjkW76exkwwNp3e-bPQLEqNsE4
Message-ID: <CAFTtA3N9xBv9=pd1=yvS+KRiLgDx-Nd52jEBm_1Fn1BMMwviVA@mail.gmail.com>
Subject: Re: [PATCH v 1/2] riscv: ptrace: Optimize the allocation of vector regset
To: Yong-Xuan Wang <yongxuan.wang@sifive.com>
Cc: linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, 
	greentime.hu@sifive.com, vincent.chen@sifive.com, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, Oleg Nesterov <oleg@redhat.com>, 
	Charlie Jenkins <charlie@rivosinc.com>, Jesse Taube <jesse@rivosinc.com>, 
	Han Gao <rabenda.cn@gmail.com>, Conor Dooley <conor.dooley@microchip.com>, 
	Thomas Gleixner <tglx@linutronix.de>, "Bill O'Donnell" <bodonnel@redhat.com>, 
	Joel Granados <joel.granados@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Yong-Xuan,

On Wed, Oct 1, 2025 at 6:15=E2=80=AFAM Yong-Xuan Wang <yongxuan.wang@sifive=
.com> wrote:
>
> The vector regset uses the maximum possible vlen value to estimate the
> .n field. But not all the hardwares support the maximum vlen. Linux
> might wastes time to prepare a large memory buffer(about 2^6 pages) for
> the vector regset.
>
> The regset can only copy vector registers when the process are using
> vector. Add .active callback and determine the n field of vector regset
> in riscv_v_setup_ctx_cache() doesn't affect the ptrace syscall and
> coredump. It can avoid oversized allocations and better matches real
> hardware limits.
>
> Signed-off-by: Yong-Xuan Wang <yongxuan.wang@sifive.com>
> Reviewed-by: Greentime Hu <greentime.hu@sifive.com>

Reviewed-by: Andy Chiu <andybnac@gmail.com>

Thanks,
Andy

> ---
>  arch/riscv/include/asm/vector.h |  1 +
>  arch/riscv/kernel/ptrace.c      | 24 +++++++++++++++++++++---
>  arch/riscv/kernel/vector.c      |  2 ++
>  3 files changed, 24 insertions(+), 3 deletions(-)
>
> diff --git a/arch/riscv/include/asm/vector.h b/arch/riscv/include/asm/vec=
tor.h
> index b61786d43c20..e7aa449368ad 100644
> --- a/arch/riscv/include/asm/vector.h
> +++ b/arch/riscv/include/asm/vector.h
> @@ -51,6 +51,7 @@ void put_cpu_vector_context(void);
>  void riscv_v_thread_free(struct task_struct *tsk);
>  void __init riscv_v_setup_ctx_cache(void);
>  void riscv_v_thread_alloc(struct task_struct *tsk);
> +void __init update_regset_vector_info(unsigned long size);
>
>  static inline u32 riscv_v_flags(void)
>  {
> diff --git a/arch/riscv/kernel/ptrace.c b/arch/riscv/kernel/ptrace.c
> index 8e86305831ea..e6272d74572f 100644
> --- a/arch/riscv/kernel/ptrace.c
> +++ b/arch/riscv/kernel/ptrace.c
> @@ -153,6 +153,17 @@ static int riscv_vr_set(struct task_struct *target,
>                                  0, riscv_v_vsize);
>         return ret;
>  }
> +
> +static int riscv_vr_active(struct task_struct *target, const struct user=
_regset *regset)
> +{
> +       if (!(has_vector() || has_xtheadvector()))
> +               return -ENODEV;
> +
> +       if (!riscv_v_vstate_query(task_pt_regs(target)))
> +               return 0;
> +
> +       return regset->n;
> +}
>  #endif
>
>  #ifdef CONFIG_RISCV_ISA_SUPM
> @@ -184,7 +195,7 @@ static int tagged_addr_ctrl_set(struct task_struct *t=
arget,
>  }
>  #endif
>
> -static const struct user_regset riscv_user_regset[] =3D {
> +static struct user_regset riscv_user_regset[] __ro_after_init =3D {
>         [REGSET_X] =3D {
>                 USER_REGSET_NOTE_TYPE(PRSTATUS),
>                 .n =3D ELF_NGREG,
> @@ -207,11 +218,10 @@ static const struct user_regset riscv_user_regset[]=
 =3D {
>         [REGSET_V] =3D {
>                 USER_REGSET_NOTE_TYPE(RISCV_VECTOR),
>                 .align =3D 16,
> -               .n =3D ((32 * RISCV_MAX_VLENB) +
> -                     sizeof(struct __riscv_v_regset_state)) / sizeof(__u=
32),
>                 .size =3D sizeof(__u32),
>                 .regset_get =3D riscv_vr_get,
>                 .set =3D riscv_vr_set,
> +               .active =3D riscv_vr_active,
>         },
>  #endif
>  #ifdef CONFIG_RISCV_ISA_SUPM
> @@ -233,6 +243,14 @@ static const struct user_regset_view riscv_user_nati=
ve_view =3D {
>         .n =3D ARRAY_SIZE(riscv_user_regset),
>  };
>
> +#ifdef CONFIG_RISCV_ISA_V
> +void __init update_regset_vector_info(unsigned long size)
> +{
> +       riscv_user_regset[REGSET_V].n =3D (size + sizeof(struct __riscv_v=
_regset_state)) /
> +                                       sizeof(__u32);
> +}
> +#endif
> +
>  struct pt_regs_offset {
>         const char *name;
>         int offset;
> diff --git a/arch/riscv/kernel/vector.c b/arch/riscv/kernel/vector.c
> index 901e67adf576..3ed071dab9d8 100644
> --- a/arch/riscv/kernel/vector.c
> +++ b/arch/riscv/kernel/vector.c
> @@ -66,6 +66,8 @@ void __init riscv_v_setup_ctx_cache(void)
>         if (!(has_vector() || has_xtheadvector()))
>                 return;
>
> +       update_regset_vector_info(riscv_v_vsize);
> +
>         riscv_v_user_cachep =3D kmem_cache_create_usercopy("riscv_vector_=
ctx",
>                                                          riscv_v_vsize, 1=
6, SLAB_PANIC,
>                                                          0, riscv_v_vsize=
, NULL);
> --
> 2.43.0
>

