Return-Path: <linux-kernel+bounces-760564-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BDE3B1ECF5
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 18:26:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E793018C7ED5
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 16:26:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CA3A27BF84;
	Fri,  8 Aug 2025 16:25:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BBVHZ9eF"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A91D285CB6;
	Fri,  8 Aug 2025 16:25:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754670357; cv=none; b=IhiZsib4jEQq2LEAQfOmgwDIsKiiXOTUUPkHxIxsNgenwcOIMujXwDAJoh2csBy9Q+G6Oe5hlaUCYWSovZ79Pj7oh5LKO0l0zuUFbxL1ff9tt2nkTkJAaYWsFmB2HvziPlpErnBVW13bdFmABnQZ279YzJteqYJzi1qzaPDMJ5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754670357; c=relaxed/simple;
	bh=N3V9K20j7E42kieVerfXchbpQA3MX98F24XbSw0J9R8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NuH2EX/EgK7gnJ1F148eiXiHs+2pedke8hYNPfKg+yJ8GMr5Qbgvc7g+xlm64wbUt+RZsu54t8w0qH3MYvHIIEObeYvmwZYeF+dV/EfnC+Jw8U5rG67FpIBpLNxVdQyX2Wqv7R2jr4beLv/ZkZW42UWlaArFl04vtmdGVCaJvmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BBVHZ9eF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71861C4AF09;
	Fri,  8 Aug 2025 16:25:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754670357;
	bh=N3V9K20j7E42kieVerfXchbpQA3MX98F24XbSw0J9R8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=BBVHZ9eFpBq4eJiJL3BWT3VrGSG8hV0Ok7MjrXpt0y4DRYNY51v+o9vxT8AM6wfRs
	 R4qnBkqicWhZqyJwuaTLIPY62HvqZ2Ish6h/v4APpRomlta0pA/cQODhaPUF4BXgH0
	 jKzhW1DKJ9KUHVLz86XQDBZFbDxqDAuY0332JMWFxO9E3WgNn+3Q6U1YBh3sae9rgk
	 FYEfTS1r/YZl/uhQo2U/wNp6z3Z5DoYMQQjMF+XExlrGmsrKdeBH1yN551Bmm8hzgJ
	 qsU12r2sfKoTd+T/dtAvr4ddDHBI8KI08HmWYBPsO0KYMHvnLDXy6KCFFZn2PodzuH
	 fdh4sOFVgvUFw==
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-ae9c2754a00so455252266b.2;
        Fri, 08 Aug 2025 09:25:57 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVPJTJjv/pVJ/CL7/ytv5z7BVQECY/k7a4TOBPYBifuwvwgFsjv1eYH5tYorcMZOVirsjCt5+uSY5gAz0a1@vger.kernel.org, AJvYcCXvd07gf5R1mg9TVy69m+Z3tMFuGaXwCQuJb6vkfp+BtPd97XqFQHUDi2Dai37DPZwk4j0bLTs3xIIA@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/s5Y9xAEU6KHB8nWdU+N968BwY/NuRmcJoa60WeiwULYsR1Gl
	Rj75d7AeCn4hxeAwWzccngEp09C/TDkcfwyqDLXmw/9g5Px+qBR555KnUboUbeddiSKRs5/4Ie0
	Ksm64NeT2t3mjCNXouKhq+dEgk+85YQ==
X-Google-Smtp-Source: AGHT+IGpJRH/5DxEa3SJBgmBwL+JR/F5fpHgzucqKgi/8Qcil00B5T3faZ7Bwgotz3rjbaGnUPdILVXdFoqC2/vW9dM=
X-Received: by 2002:a17:907:6d20:b0:ae3:8c9b:bd61 with SMTP id
 a640c23a62f3a-af9c63aefaemr285427166b.12.1754670355993; Fri, 08 Aug 2025
 09:25:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250808142515.142058-1-ben.dooks@codethink.co.uk>
In-Reply-To: <20250808142515.142058-1-ben.dooks@codethink.co.uk>
From: Rob Herring <robh@kernel.org>
Date: Fri, 8 Aug 2025 11:25:44 -0500
X-Gmail-Original-Message-ID: <CAL_JsqJntD-o6zMo-vaCQ+f=QDuyEmUgBJqjztoriq4QF7=zEg@mail.gmail.com>
X-Gm-Features: Ac12FXzB8mkiazh1BcaeRY1dvzZOLoceAaVH5KBb2IeL6_RpxOy97bw0i09lTxU
Message-ID: <CAL_JsqJntD-o6zMo-vaCQ+f=QDuyEmUgBJqjztoriq4QF7=zEg@mail.gmail.com>
Subject: Re: [RFC/PATCH] drivers/of: add debug for early dump of the dtb strcutrue
To: Ben Dooks <ben.dooks@codethink.co.uk>
Cc: saravanak@google.com, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 8, 2025 at 9:26=E2=80=AFAM Ben Dooks <ben.dooks@codethink.co.uk=
> wrote:
>
> When testing for boot issues, it was helpful to dump the
> list of nodes and properties in the device-tree passed into
> the kernel.

Shouldn't the bootloader be able to dump that?

> Add CONFIG_OF_EARLY_DUMP option to dump the list of nodes
> and properties to the standard console output early in the
> boot sequence. Note, you may need to have some sort of

s/may/will/

> early or debug console output if there are issues stopping
> the kernel starting properly.

Seems to me this is giving the user the haystack to find the needle...

> Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
> ---
>  drivers/of/Kconfig |  8 ++++++++
>  drivers/of/fdt.c   | 39 +++++++++++++++++++++++++++++++++++++++
>  2 files changed, 47 insertions(+)
>
> diff --git a/drivers/of/Kconfig b/drivers/of/Kconfig
> index 50697cc3b07e..ed2c52c54a7d 100644
> --- a/drivers/of/Kconfig
> +++ b/drivers/of/Kconfig
> @@ -126,4 +126,12 @@ config OF_OVERLAY_KUNIT_TEST
>  config OF_NUMA
>         bool
>
> +config OF_EARLY_DUMP
> +       bool "Dump node list at startup"

This needs to depend on OF_EARLY_FLATTREE.

> +       help
> +         This debug feature runs through all the nodes/properties at sta=
rtup
> +         to show if the dtb has been passed correctly from the boot stag=
e.
> +
> +         If unsure, say N here
> +
>  endif # OF
> diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
> index 0edd639898a6..ab40db0e71a5 100644
> --- a/drivers/of/fdt.c
> +++ b/drivers/of/fdt.c
> @@ -1164,6 +1164,43 @@ static void * __init early_init_dt_alloc_memory_ar=
ch(u64 size, u64 align)
>         return memblock_alloc_or_panic(size, align);
>  }
>
> +#ifdef CONFIG_OF_EARLY_DUMP
> +static int __init early_init_iterate_nodes(unsigned long node,
> +                                          const char *uname,
> +                                          int depth, void *data)
> +{
> +       void *blob =3D initial_boot_params;
> +       int cur;
> +
> +       pr_info("node '%s', depth %d\n", uname, depth);

Can you add indentation for the depth rather than printing the depth?

I'm not completely sure if calling this is safe always. How early this
will run depends on the architecture. So need to test on a variety of
architectures. Or perhaps limit in kconfig to tested architectures.
I'd rather not do that though.

> +
> +       for (cur =3D fdt_first_property_offset(blob, node);
> +            cur >=3D 0;
> +            cur =3D fdt_next_property_offset(blob, cur)) {
> +               const char *pname;
> +               const __be32 *val;
> +               u32 sz;
> +
> +               val =3D fdt_getprop_by_offset(blob, cur, &pname, &sz);
> +               if (!val) {
> +                       pr_warn(" Cannot locate property at 0x%x\n", cur)=
;
> +                       continue;

If this fails, you should probably just stop and bail out.

> +               }
> +
> +               pr_info("node %s: property %s\n", uname, pname ? pname : =
"unnamed");

Can unnamed actually happen?

> +       }
> +
> +       return 0;
> +}
> +
> +static inline void early_init_dump_dt(void)
> +{
> +       of_scan_flat_dt(early_init_iterate_nodes, NULL);

This way to iterate is left over from before having libfdt. Is there
not a libfdt way to iterate thru all nodes?

> +}
> +#else
> +static inline void early_init_dump_dt(void) { }
> +#endif /* CONFIG_OF_EARLY_DUMP */
> +
>  bool __init early_init_dt_verify(void *dt_virt, phys_addr_t dt_phys)
>  {
>         if (!dt_virt)
> @@ -1178,6 +1215,8 @@ bool __init early_init_dt_verify(void *dt_virt, phy=
s_addr_t dt_phys)
>         initial_boot_params_pa =3D dt_phys;
>         of_fdt_crc32 =3D crc32_be(~0, initial_boot_params,
>                                 fdt_totalsize(initial_boot_params));
> +
> +       early_init_dump_dt();

Use "if (IS_ENABLED(CONFIG_OF_EARLY_DUMP))" here instead of #ifdef.

>
>         /* Initialize {size,address}-cells info */
>         early_init_dt_scan_root();
> --
> 2.37.2.352.g3c44437643
>

