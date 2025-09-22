Return-Path: <linux-kernel+bounces-827278-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4576AB9158C
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 15:16:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B40E03A7D30
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 13:15:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CEAF30CD8D;
	Mon, 22 Sep 2025 13:13:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Su2olIrD"
Received: from mail-pl1-f226.google.com (mail-pl1-f226.google.com [209.85.214.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B726230C112
	for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 13:13:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758546827; cv=none; b=Mw/fs0hQNgnuxUvKNaBmqlJfwzDKmv1QJ823rwdJJRsxOc4/6KmWesqZnqWFATJoKd3zJNvON+Em+VWsxuV7Blntvl0Ez+tKeOzxH/1LtPTrMUNdYgLYujFiTB1/aFWf3amvXWcasstnSL3zRGlCMnpvuHUv+fymVvrYuFAVk/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758546827; c=relaxed/simple;
	bh=A9OvrotW4jcY4abstMzMdE2Fr7lqpxPDDdAjSmUJ5zI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=deJDfxpe0VELca04gR9jAt90aDkYSjKRRV50JwttAp3avZ1mRzmaMxJhXe9eut8ddRZXuQ+S3Fr2YWo5TJwCjAiEdVZOJpjS+3wXmRhnZni3C30mhN7m8b0+tQJtjS0QPl3AP133Y3909NXO39S9hv2Y0p7UnyBGxxqfl25OskQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=Su2olIrD; arc=none smtp.client-ip=209.85.214.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pl1-f226.google.com with SMTP id d9443c01a7336-26d0fbe238bso21952115ad.3
        for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 06:13:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758546825; x=1759151625;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cllVqBWeUZFFE5PARRbxq8nSMDDye/AwcKTKDZm3VNE=;
        b=BCLpNZ5kIGWe4LUDMULkw9VoqBjF98aIeEy7oDhiWDXXD7fIkt0e6lWNddQhvycDfX
         bNNcFFSMnjFVJ+UlQatQ+NZzpvJZ6yrXIS3iaQmkCNMmlDW1E67H6D/o+JbaBedc/9Ri
         i7sfhqKg2ZiNBaXMPU70jUcnZ33/RCRJkPi2rzanBX04lgtEz04q2JUa05O/wNv1zsdv
         I4jrdBhNs04BQka0T00DorK+5pUSATKRQDBBz7n3JdPcltwPrNvU3Ep41IfWer55QTg6
         xscV8rBCI4WjeH1bd555ZMPd3WaET6TxWr77QKHBafAtCOjp/lFTHUJfJW639o25LORM
         lFXA==
X-Forwarded-Encrypted: i=1; AJvYcCXUiIDEJHFurGgeJJl4lI97mQUdOYcuxOtal2qJM6k+61zAnsLHHXXT6eNTPES8wPL/xLcxANmhdrVJbLk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyUNWUOKrLGr5wW2yBWonl486ves4uH81sLbx+4vL6CqnPcilzU
	r5WviXZxFhDittCLVlNoMO1Pv2XQpOljt7TsoJDB+hDBnHOn7lxPkcnBW+R/JaUF3RGOnBxu7l4
	nL6CevcHQ1e+OHMmXoBbgt+nG4u9t6AxKlJgvhLfwaDnGCzFldF/jwKeCM5ibqyiKwLWcwpxgyC
	jwNrFre1+y9xMv3ikPfTn0FtxLXwZjs0kStySpPLxVy0VdOXZp9Y3/T+jp3KTqPdxQtxAQBdlfN
	gwGiDiMFH940tkXew==
X-Gm-Gg: ASbGnctiOUx+CYXfYGfX50CiB6cP3ZTmS1gxH6WMAD3xTR6Ol1tfcweD7G37FUf2nMX
	cI1ImKleiJ/QxGnVHkG4132pZvRMj4jkEyBG/ERq8oOCYmqDSCiZYoTFV7Pl1Aef4P3CYfmxb1k
	CSkYCnWeLs62nrDTALk/LktCKbBboGZunlIZm5hb6+OBtDOf0C+wB+zyKKbMw3YfnxpjycADSO6
	JmAVPXadLCG60VcMAJ7cV0nZgpjDwCZ80Il8+L9f77RBpk7gBoXizGCnP8KsVg8Otf2BtfbMhRl
	Ss/mB8ESq+C7DYxy8lKvDb0okGThS0En9Rposj+gAYsjO75+foTn4ybZ0CQCQS+ySrDK2czLdIi
	9QAoG5K4CIsBLo5IYIxgXVWwbFkU4AASNAHRbO/lnsj/pDWX9KFndoyTuPa9XQwEaEiGaKPGcmO
	Qw
X-Google-Smtp-Source: AGHT+IF2OQlaOX6EmaLE9SlZi9Fpadwtb/FVnjtDdfARw9IJ6upBi8/HtE30UwO3zVdF2UCRsfxVs68Mmwfc
X-Received: by 2002:a17:902:e549:b0:26e:62c9:1cc4 with SMTP id d9443c01a7336-26e62c92042mr113631495ad.4.1758546824819;
        Mon, 22 Sep 2025 06:13:44 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-101.dlp.protect.broadcom.com. [144.49.247.101])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-33060759820sm784580a91.3.2025.09.22.06.13.44
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 22 Sep 2025 06:13:44 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-lf1-f72.google.com with SMTP id 2adb3069b0e04-57a2d267632so1960822e87.0
        for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 06:13:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1758546822; x=1759151622; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cllVqBWeUZFFE5PARRbxq8nSMDDye/AwcKTKDZm3VNE=;
        b=Su2olIrD1e5X3ARCutK/TFXGGgvFmzowd7ybPXzcx7p9+wOOkw2kjRQSF1sMPB4CFl
         MjjDKQ0BD476BEDEgrRmBhn/F3dE1zxmmULeopPAlmLdHoUoH87u5O4ajvYrMiLeGIVJ
         xooeyC/XhzArBn9ArVlwycuYxQ7yrvVVM2Xdg=
X-Forwarded-Encrypted: i=1; AJvYcCVWXXJEwJBkQVartLm7hpL6hgUSDbyoBGNygjSqo5+oJXHmLyEcrBGpX5zmqh48BvsuBKaH95+h4vs1Fss=@vger.kernel.org
X-Received: by 2002:a05:6512:638e:b0:579:ff59:a5a8 with SMTP id 2adb3069b0e04-579ff59a5c2mr3196438e87.37.1758546822379;
        Mon, 22 Sep 2025 06:13:42 -0700 (PDT)
X-Received: by 2002:a05:6512:638e:b0:579:ff59:a5a8 with SMTP id
 2adb3069b0e04-579ff59a5c2mr3196426e87.37.1758546821902; Mon, 22 Sep 2025
 06:13:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250920021024.847323-1-william.zhang@broadcom.com>
In-Reply-To: <20250920021024.847323-1-william.zhang@broadcom.com>
From: Kursad Oney <kursad.oney@broadcom.com>
Date: Mon, 22 Sep 2025 09:13:26 -0400
X-Gm-Features: AS18NWC52Kyz4JfaKcm9yf_fl8ruTBMuvkdeTwXMowcj5URJe47hbkczPk9a-z0
Message-ID: <CAMm8Nh0oGokMDFt8ghomX1_SA3sbfv_xJVUXd2V1XeBA0OR08g@mail.gmail.com>
Subject: Re: [PATCH] ARM: module: fix unwind section relocation out of range error
To: William Zhang <william.zhang@broadcom.com>
Cc: linux-arm-kernel@lists.infradead.org, song@kernel.org, 
	linus.walleij@linaro.org, florian.fainelli@broadcom.com, ardb@kernel.org, 
	anand.gore@broadcom.com, 
	Broadcom Kernel List <bcm-kernel-feedback-list@broadcom.com>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, "Peter Zijlstra (Intel)" <peterz@infradead.org>, 
	linux-kernel@vger.kernel.org, Petr Pavlu <petr.pavlu@suse.com>, 
	Russell King <linux@armlinux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

Hi William,


On Fri, Sep 19, 2025 at 10:10=E2=80=AFPM William Zhang
<william.zhang@broadcom.com> wrote:
>
> In an armv7 system that uses non-3G/1G split and with more than 512MB
> physical memory, driver load may fail with following error:
>    section 29 reloc 0 sym '': relocation 42 out of range (0xc2ab9be8 ->
> 0x7fad5998)
>
> This happens when relocation R_ARM_PREL31 from the unwind section
> .ARM.extab and .ARM.exidx are allocated from the VMALLOC space while
> .text section is from MODULES_VADDR space. It exceeds the +/-1GB
> relocation requirement of R_ARM_PREL31 hence triggers the error.
>
> The fix is to mark .ARM.extab and .ARM.exidx sections as executable so
> they can be allocated within .text section and always meet range
> requirement.

Not "within" .text, but "along with" or "in close proximity to".

>
> Co-developed-by: Ard Biesheuvel <ardb@kernel.org>
> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> Signed-off-by: William Zhang <william.zhang@broadcom.com>

I think a Fixes tag might be appropriate?

>
> ---
>
>  arch/arm/kernel/module-plts.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
>
> diff --git a/arch/arm/kernel/module-plts.c b/arch/arm/kernel/module-plts.=
c
> index 354ce16d83cb..5f5bf5e63bd6 100644
> --- a/arch/arm/kernel/module-plts.c
> +++ b/arch/arm/kernel/module-plts.c
> @@ -225,6 +225,18 @@ int module_frob_arch_sections(Elf_Ehdr *ehdr, Elf_Sh=
dr *sechdrs,
>                         mod->arch.init.plt =3D s;
>                 else if (s->sh_type =3D=3D SHT_SYMTAB)
>                         syms =3D (Elf32_Sym *)s->sh_addr;
> +#if defined(CONFIG_ARM_UNWIND) && !defined(CONFIG_VMSPLIT_3G)
> +               else if (s->sh_type =3D=3D ELF_SECTION_UNWIND ||
> +                        (strncmp(".ARM.extab", secstrings + s->sh_name, =
10) =3D=3D 0)) {
> +                       /*
> +                        * To avoid the possible relocation out of range =
issue for
> +                        * R_ARM_PREL31, mark unwind section .ARM.extab a=
nd .ARM.exidx as
> +                        * executable so they will be allocated within .t=
ext section to meet
> +                        * +/-1GB range requirement of the R_ARM_PREL31 r=
elocation
> +                        */
> +                       s->sh_flags |=3D SHF_EXECINSTR;
> +               }
> +#endif
>         }
>
>         if (!mod->arch.core.plt || !mod->arch.init.plt) {
> --
> 2.43.7
>

