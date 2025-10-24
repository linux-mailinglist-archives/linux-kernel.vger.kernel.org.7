Return-Path: <linux-kernel+bounces-868187-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 670FAC049BD
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 09:04:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 507D04ED2B6
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 07:04:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF21328D8ED;
	Fri, 24 Oct 2025 07:04:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lPS0X4Q6"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2107E28C874
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 07:04:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761289477; cv=none; b=piKVG4RZUPImwY/TN7i/EZckOpLUyaHKCMpk/1qXZwGHL1a7LTSwrcaUX0k1yqC34UinDBoIndWzhQWA8gKk5fJeHlseDKc4b6IHYiyQPWrJB3MLg8wgaE/whFgWTyK6oaUHlMQfmichWOLkv0ZsDuiGD85M2vn3jomg2APSvjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761289477; c=relaxed/simple;
	bh=aC27PHhmKovU7D855GtJzRNEbpQZ/LShb8gjYcHPdjk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cwfW1qPUws6lBSrVen8pRSNumOjD0pDwMO/4RHsZBV4Tfyg/oj5vDBdRJb9ZOkUps+eXmnH3DqmZXUC6mOTzb5jcUy84sp7uzWjqDuRArQAAcaPMXwi+BiL4CYlAKaz3bLbzIMj9vHURpGD/buw8knOn5yc1MfA+2o65KSIq+0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lPS0X4Q6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2983C116C6
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 07:04:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761289476;
	bh=aC27PHhmKovU7D855GtJzRNEbpQZ/LShb8gjYcHPdjk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=lPS0X4Q6rUGDZVp7kcB+Vc0LRouMvChtbWVCriBUj/UqNOdi4ZI8Rs5bG2okWc4sn
	 YaI4rOEJMo0DeT4v/ftWPeFS4u4pEeWGg9BbSMHHMQmyC0FBIBvkuTY2z8k33VsYDo
	 IVUAI/PTIKSCj1VBTkmaTCFlIhfdAB9csmi1pJfcy9q6L65wnyuq5T40/nE7Dnujsg
	 og/rro/98KI95qm0IUwGYTObdKwG4HLc/c8boo95KSIwdyLlpii0Bji49X2R3svbHY
	 GPVF/dcED3jQAAGy31vxsSrj3W6KCa6D9OD+yjl98qanCk0aZDJV81872p2ECiQhSB
	 XYuN2Di2HzUpg==
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-61feb87fe26so2945335a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 00:04:36 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXBaZ0aJajcikGOz+d071Uo8fSCoCtXfuHWLueXliKHSV+NzvrIegYAD8fUe420d0RWckTUDPhyZH/mJp8=@vger.kernel.org
X-Gm-Message-State: AOJu0YykkRixSe3ltTFCZaXNJFo1UzrrYWEd9tNSBLPoXySh0rFfA/6m
	Bk8N9IlvLlsGEc7dR9c7flgZ28N5ADO7l32XYO9hduaRCcFrNQpdSTitIlN3FJ6ojLYdIAt45Hw
	OCrndK51lt/CLH7aTt9VamOqw+DRHOKo=
X-Google-Smtp-Source: AGHT+IHYyTZcGIxi0Fl+OTaB+QvsYqVNksO0QasRF0cppR46oEv3S0a3JmoHXvshpZB1oJm++yaeW9PCGheC+RPrbnY=
X-Received: by 2002:a05:6402:430e:b0:63c:b2:c656 with SMTP id
 4fb4d7f45d1cf-63e6000378amr1199075a12.4.1761289475058; Fri, 24 Oct 2025
 00:04:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251021091114.982820-1-maqianga@uniontech.com>
In-Reply-To: <20251021091114.982820-1-maqianga@uniontech.com>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Fri, 24 Oct 2025 15:04:25 +0800
X-Gmail-Original-Message-ID: <CAAhV-H5P9GGbSz0=J+a1hVkLVLwQWq1LfH7dxq4XHLqpgx7wDQ@mail.gmail.com>
X-Gm-Features: AWmQ_blm-i60Rn_dKVR1u3qxE41hsHF68WOmrXhNujegOS84i4864dMEiTi6MD4
Message-ID: <CAAhV-H5P9GGbSz0=J+a1hVkLVLwQWq1LfH7dxq4XHLqpgx7wDQ@mail.gmail.com>
Subject: Re: [PATCH] LoongArch: kexec_file: print out debugging message if required
To: Qiang Ma <maqianga@uniontech.com>, Youling Tang <youling.tang@linux.dev>
Cc: kernel@xen0n.name, loongarch@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi, Youling,

What do you think about this?

Huacai

On Tue, Oct 21, 2025 at 5:12=E2=80=AFPM Qiang Ma <maqianga@uniontech.com> w=
rote:
>
> When specifying '-d' for kexec_file_load interface, loaded locations
> of kernel/initrd/cmdline etc can be printed out to help debug.
>
> Commit eb7622d908a0 ("kexec_file, riscv: print out debugging message
> if required") fixes the same issue on RISC-V.
>
> So, remove kexec_image_info() because the content has been printed
> out in generic code.
>
> And on Loongson-3A5000, the printed messages look like below:
>
> [  288.667939] kexec_file: kernel: 00000000d9aad283 kernel_size: 0x2e77f3=
0
> [  288.668414] kexec_file(EFI): No LoongArch PE image header.
> [  288.703104] kexec_file: Loaded initrd at 0x80000000 bufsz=3D0x1637cd0 =
memsz=3D0x1638000
> [  288.703674] kexec_file(ELF): Loaded kernel at 0x9c20000 bufsz=3D0x27f1=
800 memsz=3D0x2950000
> [  288.704092] kexec_file: nr_segments =3D 2
> [  288.704277] kexec_file: segment[0]: buf=3D0x00000000cc3e6c33 bufsz=3D0=
x27f1800 mem=3D0x9c20000 memsz=3D0x2950000
> [  288.741213] kexec_file: segment[1]: buf=3D0x00000000bb75a541 bufsz=3D0=
x1637cd0 mem=3D0x80000000 memsz=3D0x1638000
> [  288.757182] kexec_file: kexec_file_load: type:0, start:0xb15d000 head:=
0x18db60002 flags:0x8
>
> Signed-off-by: Qiang Ma <maqianga@uniontech.com>
> ---
>  arch/loongarch/kernel/machine_kexec.c | 22 ----------------------
>  1 file changed, 22 deletions(-)
>
> diff --git a/arch/loongarch/kernel/machine_kexec.c b/arch/loongarch/kerne=
l/machine_kexec.c
> index e4b2bbc47e62..2d64b7c81e5e 100644
> --- a/arch/loongarch/kernel/machine_kexec.c
> +++ b/arch/loongarch/kernel/machine_kexec.c
> @@ -39,34 +39,12 @@ static unsigned long systable_ptr;
>  static unsigned long start_addr;
>  static unsigned long first_ind_entry;
>
> -static void kexec_image_info(const struct kimage *kimage)
> -{
> -       unsigned long i;
> -
> -       pr_debug("kexec kimage info:\n");
> -       pr_debug("\ttype:        %d\n", kimage->type);
> -       pr_debug("\tstart:       %lx\n", kimage->start);
> -       pr_debug("\thead:        %lx\n", kimage->head);
> -       pr_debug("\tnr_segments: %lu\n", kimage->nr_segments);
> -
> -       for (i =3D 0; i < kimage->nr_segments; i++) {
> -               pr_debug("\t    segment[%lu]: %016lx - %016lx", i,
> -                       kimage->segment[i].mem,
> -                       kimage->segment[i].mem + kimage->segment[i].memsz=
);
> -               pr_debug("\t\t0x%lx bytes, %lu pages\n",
> -                       (unsigned long)kimage->segment[i].memsz,
> -                       (unsigned long)kimage->segment[i].memsz /  PAGE_S=
IZE);
> -       }
> -}
> -
>  int machine_kexec_prepare(struct kimage *kimage)
>  {
>         int i;
>         char *bootloader =3D "kexec";
>         void *cmdline_ptr =3D (void *)KEXEC_CMDLINE_ADDR;
>
> -       kexec_image_info(kimage);
> -
>         kimage->arch.efi_boot =3D fw_arg0;
>         kimage->arch.systable_ptr =3D fw_arg2;
>
> --
> 2.20.1
>

