Return-Path: <linux-kernel+bounces-892695-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 7ED6CC45A1E
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 10:28:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D0F044E99E9
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 09:25:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E85E32FF168;
	Mon, 10 Nov 2025 09:24:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cCNs/tO5"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 354F22FF652
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 09:24:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762766675; cv=none; b=i97u1MOmIt0CuQXOO51bGuXf6VT/3FFZ7YLg7XsM8g1NwJ+IA8Z91vVszdcvvpN8Ej0UXf6J/+U0XrkOBar9oTi9JgY9+JQvILZgZWjgkLrgh+hIyUTwmX9V87fUGp2/pNmd4dqZhh5VEPZZ1KBf58b1rkNSxuqZqK5FvLXonK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762766675; c=relaxed/simple;
	bh=12tkn2eW7OKiky0Am/v0/JrN2IhWAn/ZzkRw2A93Cwg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CexwhtdZKt+aPkE0Frr1sb0yON+mTwYuG5VasOnAO01+TaKZ5DEvq7MwsUqFYPsUs5huOv5Y2VuXJcBU+/jhjeFFe/TGaYcS+a5ImMRYLajuA2qsBCeJVtUEstzfUWzlwTlCprUHMydyqOTwXn90Xcbx5yiL3aURE3n14uMujx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cCNs/tO5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AAC9EC4AF0B
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 09:24:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762766674;
	bh=12tkn2eW7OKiky0Am/v0/JrN2IhWAn/ZzkRw2A93Cwg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=cCNs/tO5EsnPNMxP/SotUQtXnQ71dpVJYG81OT+YmAutR+A3zcT/umYw89tAP8tUa
	 VfvSnUkU16V2PMbU60VLwi53xHVE+2nGCsh82OdHqTPN/o8gTJsM9O7zgC/dL9TUXN
	 ibFyX6BZXBisNgDLNOHPwQtdUEYzZ7YNTZwqRdFf2xV/7MiPQyt7PngcRM+1vIUEEC
	 xIKrsanxxl6lMxVViy1XF/C40Z75OS6raZAQh10wv/Q92ddsy14/YzyrAZGqlr52K8
	 9iSlYPoN8kIBaqMP6x1c0SoFmDBDI95/BnP8svcSK9OhGWaSwfMaI1MNadleEUoYHi
	 ReyQ3gASQxydg==
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-6408f9cb1dcso4718077a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 01:24:34 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXIYNw4w8Wiypz6nSmTvGpRQaprHSxvfxVJr419hWb/IGRZy4yROkbhNR18WUC9XLsLkc5oAjmYQqlGzY8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzp4QKnDYzdXIqtbk48i+a8wGAKnE0dY/sDfpTj/BsRnkU3VzWT
	5Ipm4s8jer7MvIcmQd+NoPT/Qe1GnnR8/6IhQbXwemzpKvoiE9Kx/yDX3bUdctRVPCOQ8eO1cGj
	7sNxDTg+f5Sb+sgIH//D8Xx24iM2LeYY=
X-Google-Smtp-Source: AGHT+IHKLwR3YcjGB27F6aLZCc3GGMDReeuLQsVw8nwIi5NtUxvpWutqEIYChjtFC5B0M3L6kaUwrciXh/cEPB/BUMM=
X-Received: by 2002:a17:907:6eaa:b0:b70:b077:b957 with SMTP id
 a640c23a62f3a-b72e02d4af4mr791414866b.15.1762766673263; Mon, 10 Nov 2025
 01:24:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251021091114.982820-1-maqianga@uniontech.com>
In-Reply-To: <20251021091114.982820-1-maqianga@uniontech.com>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Mon, 10 Nov 2025 17:24:31 +0800
X-Gmail-Original-Message-ID: <CAAhV-H6T-V8zV9L9wH-mGJNHAP3BGyQxDwKCWtKOxUGdtL4zOg@mail.gmail.com>
X-Gm-Features: AWmQ_bmSDX66uxK8yo85VkAuS7JO9qpqETnO9k2fkOAx8Ls_pzNpFjyp-PE2Kno
Message-ID: <CAAhV-H6T-V8zV9L9wH-mGJNHAP3BGyQxDwKCWtKOxUGdtL4zOg@mail.gmail.com>
Subject: Re: [PATCH] LoongArch: kexec_file: print out debugging message if required
To: Qiang Ma <maqianga@uniontech.com>
Cc: kernel@xen0n.name, loongarch@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Applied, thanks.

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

