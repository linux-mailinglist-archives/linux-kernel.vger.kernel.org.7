Return-Path: <linux-kernel+bounces-863402-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EFC3BF7CA7
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 18:54:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D390D19A58C2
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 16:55:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EA43348873;
	Tue, 21 Oct 2025 16:54:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="LDmR2LIF"
Received: from mail-oo1-f42.google.com (mail-oo1-f42.google.com [209.85.161.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4ADD2417C6
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 16:54:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761065677; cv=none; b=UnHhTaHJ/cjTAVt/S82BGVWrKYgNBvGgCt+rOkLS62S/urRSsC4BEZtwt1wm3gd4X6Ry+do7V2SUKxw6OOppTHLHsNxsLmGxOrXwv4s5v3dyf6xRgiXf1LB7JZxcIELEfYQ4sOHf4WnEj3XXy4DYluPvJKU4Z3ubcm2pfcJs+SM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761065677; c=relaxed/simple;
	bh=XURSssHuftoDoe3E17yrlio+PLVS3suZlc0AWmmwdMo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Z+d37NzSl7yvAAMkvAHYjjMRSPu86RuLqre5zTMlHL2RiCojpqNZwBaxWuBxpllXW7vgUGgeZfHiQDsLeiKCdgM/VMeSLqR5hw3B+tPoCqifn5AFCuNx7S6eWAxlv2X5i81LRUSrBP0Ad117O/XKBKegcFBpNZ36WLRU7+soITg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=arista.com; spf=pass smtp.mailfrom=arista.com; dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b=LDmR2LIF; arc=none smtp.client-ip=209.85.161.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=arista.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arista.com
Received: by mail-oo1-f42.google.com with SMTP id 006d021491bc7-6501434bd3aso132954eaf.1
        for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 09:54:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=google; t=1761065675; x=1761670475; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oNy+j4PmwvmvY+OsbiHCo48pl2iOpTBysiMrSrZOctk=;
        b=LDmR2LIFiorjnvFSDEiETVsifGkKQXNq65m5hJ4Njv+piD/J0xqvOe8BCCX2Q9jUrc
         rD1BnySo0/0qhXivAO0Mu0heRXJUZn45ARONqjJdg3OKg0TzTPME+0GeSUPAMLwSnuMQ
         Znw6EWOcbcv2F9Gq1FZV2DNef5cR2o4iJgKZtXl2LSGmnilfkOPXg1HZvZlxE3VYUiAF
         65bth5QBxNJxgHGq7dfZlGB0zrKcrxjWmd1+PljkLU5qeUxEix8f3PgSqdCkxJ9Eiz4t
         41L0PHQtsXnfMmcdIpv1YQ7gMOo6bWvpTxZjR04Voo8bSfQakyEiWD2qO2D9lvERIqnl
         Da+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761065675; x=1761670475;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oNy+j4PmwvmvY+OsbiHCo48pl2iOpTBysiMrSrZOctk=;
        b=A9S5oDNxt3S90pd6ForUL1TM+5MNJlmjsXoLEEo1JUMdT9AwUOXxCpDr4Q9IRbhinO
         ot8F/BP1jvvfOlzwyItiWqU2lHrSkKxQi2ETr4UxZm1veZ/UtB/xVuh7S5ygpbuX/xFm
         5/f3PKbdgO5EEpmy3aLmH1yfz6Mge/tg7pcZDgr2iFBhF/wTSbWDH0DQm8tbLBoU69x9
         mpcEIXg/9AOxHc2Zqo6PEwnm6ZJP7zpyPsi+StLExUBD1exiiLagJiUcNSVu/JYUkAvz
         jMyE6bRiRfSje8cbb2DIjUtGD/H9IwAwaTjERb3z7e2ZKDyS2axWkmlaOtVkywDCmKta
         DcDw==
X-Forwarded-Encrypted: i=1; AJvYcCVgCMUsp/N6rxJaUQGBSLseIwquc/QWx5FCWAzUEdkbX1u0t1AcppslWk3b4W+UhnZbg/cFrqIuxinxg3Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YwdSYp/FIb7197sVCTJeLv+gBD6yZh8rReuCLwXYKrAlnEF99aU
	/a/n7GGzA7Ie9Fg9w6f+ianjHYn1Z8aEWK0gnZhPKq3ODiLjpGqlXwtLhv9yixvy1BNBYh6GN1P
	s7kgXkmTn7YJ7wa2uxIEq/olkdCjMUlWowfh9zlly
X-Gm-Gg: ASbGncsrj9evrspbIyYeWvhSh2Lv4/YwTSuZ+/dDeTbjcQjbjxGZ9aDHipUZr6hralG
	m0tyk5k+NA3hL6HpGiIMOop81nYmcOPHh/5akgJKZck3i2yzBt0DBHYbMzfXf6juWSifPZPcbng
	SLoKaDaxngqihGMRqjo9jSsS6LaVAub5j0Sbnz4yq6nVkUS4ZA3j9HZmAYxJh1hcfHjoHCWOivU
	rTyT/VAX+flFTZ6+oZ1tHgYY47rFuE9KBMHd2UZQTYJEIjwVt8xxdiBa2vMudh2LyEb8nkn6CpO
	1pbpymE4pUbTHLf7w19TIxtlg6036w==
X-Google-Smtp-Source: AGHT+IHd+N85W3tNQEdP2S6Rfb+pCua46m8SSDvZmUaeZyp6Sbd1DD3c8I9EgfZgOajQFAujwfV04LkWWVcBVgHwfFU=
X-Received: by 2002:a05:6871:a90b:b0:3c9:88eb:39ba with SMTP id
 586e51a60fabf-3cd88b2efabmr830250fac.2.1761065674736; Tue, 21 Oct 2025
 09:54:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250926155612.2737443-1-adriana@arista.com>
In-Reply-To: <20250926155612.2737443-1-adriana@arista.com>
From: Adriana Nicolae <adriana@arista.com>
Date: Tue, 21 Oct 2025 19:54:23 +0300
X-Gm-Features: AS18NWAE34AW-EBbE9MlZrdkKS3cRaCCpN7jIooL-2OOkopjMrwBGF8_e1m_gQQ
Message-ID: <CAERbo5z81zhxzu3+BAd23QzgpFoCMH6-AsYm4sBfoA0YXO3TOg@mail.gmail.com>
Subject: Re: [PATCH 1/1] DMI: Scan for DMI tbale from DTS info
To: jdelvare@suse.com, linux-kernel@vger.kernel.org
Cc: Vasiliy Khoruzhick <vasilykh@arista.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello maintainers,

Following up on this patch, I was wondering if there have been any
prior discussions or similar requests?

I would also appreciate your feedback on the proposed changes.

Thank you,
Adriana

On Fri, Sep 26, 2025 at 6:56=E2=80=AFPM adriana <adriana@arista.com> wrote:
>
> Allow DMI decoding to use custom addresses stored in Device Tree
>
> Some bootloaders like U-boot, particularly for the ARM architecture,
> provide SMBIOS/DMI tables at a specific memory address. However, these
> systems often do not boot using a full UEFI environment, which means the
> kernel's standard EFI DMI scanner cannot find these tables.
>
> The bootloader can specify the physical addresses of the SMBIOS and
> SMBIOS3 tables in the /chosen node using the "linux,smbios-table" and
> linux,smbios3-table properties. This patch hooks into the DMI
> initialization process to read these properties, map the tables,
> and parse the DMI information.
>
> This extra scan is performed after the standard EFI check fails but
> before the fallback memory scan, not to alter the order of DMI scanning
> for current implementation.
>
> Signed-off-by: Adriana Nicolae <adriana@arista.com>
>
> diff --git a/drivers/firmware/dmi_scan.c b/drivers/firmware/dmi_scan.c
> index 70d39adf50dc..ea3ed40d0370 100644
> --- a/drivers/firmware/dmi_scan.c
> +++ b/drivers/firmware/dmi_scan.c
> @@ -10,6 +10,9 @@
>  #include <linux/random.h>
>  #include <asm/dmi.h>
>  #include <linux/unaligned.h>
> +#if IS_ENABLED(CONFIG_OF)
> +#include <linux/of.h>
> +#endif
>
>  #ifndef SMBIOS_ENTRY_POINT_SCAN_START
>  #define SMBIOS_ENTRY_POINT_SCAN_START 0xF0000
> @@ -670,6 +673,70 @@ static int __init dmi_smbios3_present(const u8 *buf)
>         return 1;
>  }
>
> +#if IS_ENABLED(CONFIG_OF)
> +/**
> + * dmi_scan_from_dt - Find and parse DMI/SMBIOS tables from the Device T=
ree
> + *
> + * Checks if the bootloader has passed SMBIOS table addresses via the /c=
hosen
> + * node in the Device Tree. This follows the standard kernel DT bindings=
 and
> + * assumes a fixed 32-byte mapping for the entry point.
> + * Returns true if a valid table is found and successfully parsed.
> + */
> +static bool __init dmi_scan_from_dt(void)
> +{
> +       struct device_node *chosen;
> +       const __be64 *prop;
> +       char buf[32];
> +       void __iomem *p;
> +       bool dmi_available =3D false;
> +       u64 addr;
> +       int len;
> +
> +       chosen =3D of_find_node_by_path("/chosen");
> +       if (!chosen)
> +               return false;
> +
> +       /* SMBIOSv3 (64-bit entry point) has priority */
> +       prop =3D of_get_property(chosen, "linux,smbios3-table", &len);
> +       if (prop && len >=3D sizeof(u64)) {
> +               addr =3D be64_to_cpup(prop);
> +
> +               p =3D dmi_early_remap(addr, 32);
> +               if (p =3D=3D NULL)
> +                       goto out;
> +
> +               memcpy_fromio(buf, p, sizeof(buf));
> +               dmi_early_unmap(p, 32);
> +
> +               if (!dmi_smbios3_present(buf)) {
> +                       dmi_available =3D true;
> +                       goto out;
> +               }
> +       }
> +
> +       prop =3D of_get_property(chosen, "linux,smbios-table", &len);
> +       if (prop && len >=3D sizeof(u64)) {
> +               addr =3D be64_to_cpup(prop);
> +
> +               p =3D dmi_early_remap(addr, 32);
> +               if (p =3D=3D NULL)
> +                       goto out;
> +
> +               memcpy_fromio(buf, p, sizeof(buf));
> +               dmi_early_unmap(p, 32);
> +
> +               if (!dmi_present(buf))
> +                       dmi_available =3D true;
> +       }
> +
> +out:
> +       of_node_put(chosen);
> +       return dmi_available;
> +}
> +#else
> +static bool __init dmi_scan_from_dt(void) { return false; }
> +#endif /* IS_ENABLED(CONFIG_OF) */
> +
>  static void __init dmi_scan_machine(void)
>  {
>         char __iomem *p, *q;
> @@ -718,6 +785,13 @@ static void __init dmi_scan_machine(void)
>                         dmi_available =3D 1;
>                         return;
>                 }
> +       } else if (IS_ENABLED(CONFIG_OF) && dmi_scan_from_dt()) {
> +               /*
> +                * If EFI is not present or failed, try getting SMBIOS
> +                * tables from the Device Tree.
> +                */
> +               dmi_available =3D 1;
> +               return;
>         } else if (IS_ENABLED(CONFIG_DMI_SCAN_MACHINE_NON_EFI_FALLBACK)) =
{
>                 p =3D dmi_early_remap(SMBIOS_ENTRY_POINT_SCAN_START, 0x10=
000);
>                 if (p =3D=3D NULL)

