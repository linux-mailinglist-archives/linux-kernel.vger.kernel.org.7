Return-Path: <linux-kernel+bounces-762855-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 41F84B20B6D
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 16:15:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 522BA2A7058
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 14:13:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E74DD21B9C1;
	Mon, 11 Aug 2025 14:13:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LWtYJ/PM"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C6BE217F31
	for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 14:13:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754921583; cv=none; b=hxJRpq58AferuUzOqMuY/JZtEJajXUrtoDwwaUnvnJSS2glFUHzG8Zd7SlZ8BqwMaL/+olhTcRttWtt2cCJFe+CwpW57pqGc9h/6Vv/J73JSK6k8bBM0SfM3JQt8bXaXTFMgh4aG0/zjzxSXLmqHPWJrat9LdNQFKCm6jWC5WfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754921583; c=relaxed/simple;
	bh=ELav7L/rjC/DoYOryidaLpumIaTmXrBrTPP8edfpB9M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eL93o21NybWor3HFFcXXC23JXAMJFZtAeVBYGMjni+E467D/6f8pewEAADGkLQ1c9ssqsAVpyMXd58TpLrZl8yIoVHmsm5D4T7nciendpTR+J3ZnK3Q90sWjQaPhCNCbbfupRgFkzaazghSZqjRu3IM6IsH7ox3AYx2lzAYVPPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LWtYJ/PM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4FC3C4CEF5
	for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 14:13:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754921582;
	bh=ELav7L/rjC/DoYOryidaLpumIaTmXrBrTPP8edfpB9M=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=LWtYJ/PMd3AcafPatMCuWdiNoeKHyElVNa9LarP54iIpkUVprzgjghPa/OLACTGPL
	 9t+5OcIwLfLlfESQJuBLADc9kF3YU1YGKCb2roA0CVWWCmm1T+IHPBj6ZKlnL0xJUT
	 hsag/J6L4OfwIT8yCm5px05CeRLQAAJNsbSHvESljgHlBUuNASA5e0gbKvzfWicCZO
	 iAILBErnKZzMpDCTEJ3k1HMiH97NeQ06ajb/xthV3niQC3Lg/5rcKq621epdQ5m46e
	 n9Qbjoy7SouLhFvM7+xiEWUSoNq768Kzvvfxuikr5YaNpQhkwGgDaP9fP6yXmkMEC5
	 oZ/Q0ks47iR3Q==
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-6154d14d6b7so5126334a12.2
        for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 07:13:02 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXEwQjprpx7txJByw1PDqlx0404A3KnpdRnJfGtDatryhfa+NJictzssXvgbslr0bsZiECCRiDa0gSs75w=@vger.kernel.org
X-Gm-Message-State: AOJu0YynUyWS3NkffpVRSCKYpUUUqykyqLB4fhdNvBCD0CsA01+dhXXE
	5CMVdt3jEXACY7A6EtGpvefBj72QU06FIYoYLMh+nOGytNtUaLemV2v/IcOLm37QVpSeSNhX4QJ
	C/y3HDL7vI9Gomc6xjfgZnbaKz2VUjVM=
X-Google-Smtp-Source: AGHT+IGZoI+Finas9RuvpJlULges/ui1XxmQ3rKGmYlYfjLyb3FwJXeqgk+WERRbR3Na0+3IZvzJ7f6kvYuH7yVGzgo=
X-Received: by 2002:a05:6402:2047:b0:617:e1d0:cf80 with SMTP id
 4fb4d7f45d1cf-617e2bc5aabmr9135849a12.14.1754921581341; Mon, 11 Aug 2025
 07:13:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250811092659.14903-1-youling.tang@linux.dev> <20250811092659.14903-4-youling.tang@linux.dev>
In-Reply-To: <20250811092659.14903-4-youling.tang@linux.dev>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Mon, 11 Aug 2025 22:12:37 +0800
X-Gmail-Original-Message-ID: <CAAhV-H4Sf=74-ni=qUkg3doC4iLrVt=m2bCYCgfmVC0WLNhiDQ@mail.gmail.com>
X-Gm-Features: Ac12FXyIA88QJIsDP-mLwA-4SwAZyUC9JhH_F7YcrkTIoEZQ6s0CHySqn9xPBBI
Message-ID: <CAAhV-H4Sf=74-ni=qUkg3doC4iLrVt=m2bCYCgfmVC0WLNhiDQ@mail.gmail.com>
Subject: Re: [PATCH 3/6] LoongArch/kexec_file: Add initrd loading
To: Youling Tang <youling.tang@linux.dev>
Cc: WANG Xuerui <kernel@xen0n.name>, Baoquan He <bhe@redhat.com>, kexec@lists.infradead.org, 
	loongarch@lists.linux.dev, linux-kernel@vger.kernel.org, 
	Youling Tang <tangyouling@kylinos.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi, Youling,

On Mon, Aug 11, 2025 at 5:28=E2=80=AFPM Youling Tang <youling.tang@linux.de=
v> wrote:
>
> From: Youling Tang <tangyouling@kylinos.cn>
>
> Add inird loading support and pass it to the second kernel via the
> cmdline 'initrd=3Dstart,size'.
I think Patch-3 and Patch-5 should be merged into Patch-2.

Huacai

>
> Signed-off-by: Youling Tang <tangyouling@kylinos.cn>
> ---
>  arch/loongarch/kernel/machine_kexec_file.c | 71 ++++++++++++++++++++++
>  1 file changed, 71 insertions(+)
>
> diff --git a/arch/loongarch/kernel/machine_kexec_file.c b/arch/loongarch/=
kernel/machine_kexec_file.c
> index bc91ae0afa4c..e1240644f529 100644
> --- a/arch/loongarch/kernel/machine_kexec_file.c
> +++ b/arch/loongarch/kernel/machine_kexec_file.c
> @@ -34,13 +34,84 @@ int arch_kimage_file_post_load_cleanup(struct kimage =
*image)
>         return kexec_image_post_load_cleanup_default(image);
>  }
>
> +/* Adds the "initrd=3Dstart,size" command line parameter to command line=
. */
> +static void cmdline_add_initrd(struct kimage *image, unsigned long *cmdl=
ine_tmplen,
> +                               char *modified_cmdline, unsigned long ini=
trd)
> +{
> +       int initrd_strlen;
> +
> +       initrd_strlen =3D sprintf(modified_cmdline + (*cmdline_tmplen), "=
initrd=3D0x%lx,0x%lx ",
> +               initrd, image->initrd_buf_len);
> +       *cmdline_tmplen +=3D initrd_strlen;
> +}
> +
> +/*
> + * Tries to add the initrd to the image. If it is not possible to find
> + * valid locations, this function will undo changes to the image and ret=
urn non
> + * zero.
> + */
>  int load_other_segments(struct kimage *image,
>                         unsigned long kernel_load_addr,
>                         unsigned long kernel_size,
>                         char *initrd, unsigned long initrd_len,
>                         char *cmdline, unsigned long cmdline_len)
>  {
> +       struct kexec_buf kbuf;
> +       unsigned long orig_segments =3D image->nr_segments;
> +       char *modified_cmdline =3D NULL;
> +       unsigned long cmdline_tmplen =3D 0;
> +       unsigned long initrd_load_addr =3D 0;
> +       int ret =3D 0;
> +
> +
> +       kbuf.image =3D image;
> +       /* not allocate anything below the kernel */
> +       kbuf.buf_min =3D kernel_load_addr + kernel_size;
> +
> +       modified_cmdline =3D kzalloc(COMMAND_LINE_SIZE, GFP_KERNEL);
> +       if (!modified_cmdline)
> +               return -EINVAL;
> +
> +       /* Ensure it's nul terminated */
> +       modified_cmdline[COMMAND_LINE_SIZE - 1] =3D '\0';
> +
> +       /* load initrd */
> +       if (initrd) {
> +               kbuf.buffer =3D initrd;
> +               kbuf.bufsz =3D initrd_len;
> +               kbuf.mem =3D KEXEC_BUF_MEM_UNKNOWN;
> +               kbuf.memsz =3D initrd_len;
> +               kbuf.buf_align =3D 0;
> +               /* within 1GB-aligned window of up to 32GB in size */
> +               kbuf.buf_max =3D round_down(kernel_load_addr, SZ_1G)
> +                                               + (unsigned long)SZ_1G * =
32;
> +               kbuf.top_down =3D false;
> +
> +               ret =3D kexec_add_buffer(&kbuf);
> +               if (ret)
> +                       goto out_err;
> +               initrd_load_addr =3D kbuf.mem;
> +
> +               kexec_dprintk("Loaded initrd at 0x%lx bufsz=3D0x%lx memsz=
=3D0x%lx\n",
> +                             initrd_load_addr, kbuf.bufsz, kbuf.memsz);
> +
> +               /* Add the initrd=3Dstart,size parameter to the command l=
ine */
> +               cmdline_add_initrd(image, &cmdline_tmplen, modified_cmdli=
ne, initrd_load_addr);
> +       }
> +
> +       if (cmdline_len + cmdline_tmplen > COMMAND_LINE_SIZE) {
> +               pr_err("Appending kdump cmdline exceeds cmdline size\n");
> +               ret =3D -EINVAL;
> +               goto out_err;
> +       }
> +       memcpy(modified_cmdline + cmdline_tmplen, cmdline, cmdline_len);
> +       cmdline =3D modified_cmdline;
>         image->arch.cmdline_ptr =3D (unsigned long)cmdline;
>
>         return 0;
> +
> +out_err:
> +       image->nr_segments =3D orig_segments;
> +       kfree(modified_cmdline);
> +       return ret;
>  }
> --
> 2.34.1
>

