Return-Path: <linux-kernel+bounces-807078-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CA00B49FC7
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 05:13:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A1BA04E13E4
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 03:13:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 489AA25A645;
	Tue,  9 Sep 2025 03:13:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qodm2IXg"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A00FB1F130A
	for <linux-kernel@vger.kernel.org>; Tue,  9 Sep 2025 03:13:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757387611; cv=none; b=hNHNd0aJ/vGh3/7dJL6I/cQej3m7+vfV8Wtog7fVMfaPRMDPeMERTr8O/rY63h/xOWAag52KPGEyIt92MMb10N9TD7wv4s1y/sPp+iSz9mQg78EHnRuOGODpjN+ypbuW3+4eLBE1KWf296ajHvE3sH9+17BJKcJDttXqkZFzbTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757387611; c=relaxed/simple;
	bh=ottD7mxoZqXzW+xlD2Ywt/8ARzZMWkFYuTnoE++zsW0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VNcZFw9HpAycKtzQdsRJTudSeAiSxgFSsbNltmt5jdKAkEgycaAR0+epjdREwICkxWhM7Oz3zF898AA9pmIMcEtaj+hnUdAuhOlSsUXAsQlmn+cvOfWPQKDdxQjnWA/EdskjdYrdurXkr2RQWP/qpvWlDIIFJY0pFBVmCIqYq2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qodm2IXg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 494F9C4CEF8
	for <linux-kernel@vger.kernel.org>; Tue,  9 Sep 2025 03:13:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757387611;
	bh=ottD7mxoZqXzW+xlD2Ywt/8ARzZMWkFYuTnoE++zsW0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=qodm2IXge5tpFcZosOrhbmlWVzSn+yt/w9RwAknQ2DYklO2IvpMFfUp7Sdpw+G2Ja
	 uEg6it377QKC1Dx4+YwnoqwAAGtRjxBLU7bQolKqLvWtovBrYA0hk/UDL87eVY2xfo
	 xAXtS+8Qi15qpc9ZQSGVwLH21oDl745W5/N93Nw+Jx0VfsEkJWL8SE/gSZQAIg/3DN
	 HZ/8s+ZHmZn+oqA1SPrdFj2NyTc/HJu5elBvoiCNxc+pg9gKSOw2I7I9/pBVvgGkAR
	 +rZOHYKeoCIyqBZCmnLUK5QpdkfCu3CvYyl3MuErjngzJ223f9dLwCv6m5gKuN7MhZ
	 P9khaoEutoIDw==
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-aff0775410eso90625066b.0
        for <linux-kernel@vger.kernel.org>; Mon, 08 Sep 2025 20:13:31 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVeU+qB2bq9Lq1mNYaGS2DjW+b62Q1rwi4jHZD5FoYnyumnnRc8jxRpPDo26d03evSk+Ye0b40Io7PcBPM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzuebA+vR9OpESFzBUEpNpBwEqR1A9CZUsv+wW9j8Nwd3HB7tPD
	x0YwzUwgrayEKfOhOjzLd+2atshyHYJQzKsTQluf3G8+M/WifC/EAEbgQYN5xe5GI7zuQlLmAD1
	clOpd3azvraAws2k+qSrfBWm3m3sEqYg=
X-Google-Smtp-Source: AGHT+IHDIzbBeuTrN9C/W9PYYylmD7SBKmmU8PRnhIjfPCAKWGKw7Ya9urIBhs1fvPzVgALZvYxEPgczh7Wn/qD90EA=
X-Received: by 2002:a17:906:ef04:b0:af9:8739:10ca with SMTP id
 a640c23a62f3a-b0493282aecmr1472056566b.28.1757387609793; Mon, 08 Sep 2025
 20:13:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250909023448.1820120-1-cuitao@kylinos.cn>
In-Reply-To: <20250909023448.1820120-1-cuitao@kylinos.cn>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Tue, 9 Sep 2025 11:13:17 +0800
X-Gmail-Original-Message-ID: <CAAhV-H7ECnVeOgf93SEXLHLc4wvhQMjQXDbGKCR-KXKWf8Vgtg@mail.gmail.com>
X-Gm-Features: Ac12FXwXwHys7zQAyWM-ogTTO7qfQJvtIZ0LCTS-5oA4JyuHePgMeYjFf0z-gtw
Message-ID: <CAAhV-H7ECnVeOgf93SEXLHLc4wvhQMjQXDbGKCR-KXKWf8Vgtg@mail.gmail.com>
Subject: Re: [PATCH] LoongArch: Added detection of return values of some steps
 in the system init process
To: cuitao <cuitao@kylinos.cn>
Cc: loongarch@lists.linux.dev, kernel@xen0n.name, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi, Cuitao,

Don't over-design!

On Tue, Sep 9, 2025 at 10:35=E2=80=AFAM cuitao <cuitao@kylinos.cn> wrote:
>
> Check the return value after early_memremap_ro and kobject_create_and_add=
,
> and check whether the memory allocation was successful after kstrdup
>
> Signed-off-by: cuitao <cuitao@kylinos.cn>
> ---
>  arch/loongarch/kernel/env.c | 30 ++++++++++++++++++++++++++----
>  1 file changed, 26 insertions(+), 4 deletions(-)
>
> diff --git a/arch/loongarch/kernel/env.c b/arch/loongarch/kernel/env.c
> index c0a5dc9aeae2..eaa9e054209c 100644
> --- a/arch/loongarch/kernel/env.c
> +++ b/arch/loongarch/kernel/env.c
> @@ -23,7 +23,13 @@ EXPORT_SYMBOL(loongson_sysconf);
>  void __init init_environ(void)
>  {
>         int efi_boot =3D fw_arg0;
> -       char *cmdline =3D early_memremap_ro(fw_arg1, COMMAND_LINE_SIZE);
> +       char *cmdline;
> +
> +       cmdline =3D early_memremap_ro(fw_arg1, COMMAND_LINE_SIZE);
 early_memremap_ro() is "return ((void __iomem *)TO_CACHE(phys_addr))"
on LoongArch, there is no chance to return NULL.

> +       if (!cmdline) {
> +               pr_err("Failed to map command line memory\n");
> +               return;
> +       }
>
>         if (efi_boot)
>                 set_bit(EFI_BOOT, &efi.flags);
> @@ -46,10 +52,18 @@ static int __init init_cpu_fullname(void)
>
>         /* Parsing cpuname from DTS model property */
>         root =3D of_find_node_by_path("/");
After 7b937cc243e5b1df8780a0aa743ce800df6c6 ("of: Create of_root if no
dtb provided by firmware"), there is no chance to have no root.

> +       if (!root) {
> +               pr_warn("Failed to find root device node\n");
> +               return -ENODEV;
> +       }
>         ret =3D of_property_read_string(root, "model", &model);
>         if (ret =3D=3D 0) {
>                 cpuname =3D kstrdup(model, GFP_KERNEL);
> -               loongson_sysconf.cpuname =3D strsep(&cpuname, " ");
> +               if (cpuname) {
> +                       loongson_sysconf.cpuname =3D strsep(&cpuname, " "=
);
> +               } else {
> +                       pr_warn("Failed to allocate memory for cpuname\n"=
);
Have a cpuname in the model string is not mandatory, print a warning for wh=
at?

> +               }
>         }
>         of_node_put(root);
>
> @@ -67,14 +81,18 @@ static int __init fdt_cpu_clk_init(void)
>         struct device_node *np;
>
>         np =3D of_get_cpu_node(0, NULL);
> -       if (!np)
> +       if (!np) {
> +               pr_warn("Failed to get CPU node\n");
The same, this is not mandatory.

>                 return -ENODEV;
> +       }
>
>         clk =3D of_clk_get(np, 0);
>         of_node_put(np);
>
> -       if (IS_ERR(clk))
> +       if (IS_ERR(clk)) {
> +               pr_warn("Failed to get CPU clock\n");
The same, this is not mandatory.


Huacai

>                 return -ENODEV;
> +       }
>
>         cpu_clock_freq =3D clk_get_rate(clk);
>         clk_put(clk);
> @@ -109,6 +127,10 @@ static int __init boardinfo_init(void)
>         struct kobject *loongson_kobj;
>
>         loongson_kobj =3D kobject_create_and_add("loongson", firmware_kob=
j);
> +       if (!loongson_kobj) {
> +               pr_warn("loongson: Firmware registration failed.\n");
> +               return -ENOMEM;
> +       }
>
>         return sysfs_create_file(loongson_kobj, &boardinfo_attr.attr);
>  }
> --
> 2.33.0
>

