Return-Path: <linux-kernel+bounces-879840-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id E1493C242AE
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 10:32:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 70B134F0983
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 09:32:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3DF9329E49;
	Fri, 31 Oct 2025 09:31:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="X2Yucodj"
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44F4E2F6931
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 09:31:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761903110; cv=none; b=LilWzZhK4BM2q9vaAABQEqy8Ir2pWaxzuRgFwTc2KtRS8BrU8tawSUruQqcLYhiZqiSQG6wT8Vs+Wcpu1qIdYhwemfW9x86qbeHGvpP9EYkMB5nFuJeTlwCG1GPQPEe3JMR80PYKs4ZktSdSav0/UGM9OZlzZp37jDQM2AmmnP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761903110; c=relaxed/simple;
	bh=Ju5scJcqvKgVinWmnh8oTtH0OXNKUbGJQrfL2pV2xBU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rv3TcE+G1WzExPH3g2lf3cS1qwbhfFjf2qlMkct8YYyrSWBp3PXZwBOG8C0CCcrTIvCUIjuBVmwnBkkPoTcSR7UVmsQ0wXiqFhaFUzToff3TCO+Qk09D8GoGZ8yCVFVmDleShuAtRFz0m5UCtTq3fd5jOyaa56ZbqFeylxQsKMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=X2Yucodj; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-785d3a5f641so23014677b3.1
        for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 02:31:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1761903108; x=1762507908; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=rfyBZJmdoTsV5mASRVjVSK13eALqQJfbT9fGRd81eVU=;
        b=X2Yucodj23ySRgOlNARkCqiDs2q18jfJa5fCPKDwY4D00wvipJfIEtsYZN5buqaig/
         mxSuYSmPKNzUfh0aiMY19gHV60T7ZHD3EnGxRzJOqHLZE/BVpXynqfkdO+HPUaUfGHha
         Dz2Ct24OpzvejDI3oXh7IBr+w3vjd8xDj5gj/I2IJQx6hHJoj4jmZ/Dni8f1+oPoIT9M
         Dd+hKOSNz4RRzUvMuz0uDXGuqQ+p28RxeAVixHU8jbzYjkq6mEApHelXmgoDGYQiiP4V
         3S0E/aff5P52U+05k7tscgoNH8+EvJ+03hoHOZZ7PHJJDrAsnIMDYApIW/AajdCntfoi
         wxMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761903108; x=1762507908;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rfyBZJmdoTsV5mASRVjVSK13eALqQJfbT9fGRd81eVU=;
        b=biXfCT9Sf8PKFZcEBYGR+5Cs7Pt+OMhFx2+wdKA8j46YkwkcjFkJ/szxt9Yn0vR031
         CxKS2x9H5nDSgBJuKxzFEVJh9Y/r1HadFiAv3S7djTuBva5gPSXt8klUnFB+sgykOOj7
         uLBTXU5SQ1Wqh5W8u8Iztup+Xtc8KCR43qW4iu6BNM3TrwJYoinc4RfkNIHjT0gPYWTc
         llP2dzuCngkWMi4YajFF0CJ8huAXSgzlvjbwv38C9PQZ1KRpecD27DJCx4tsxM2h/TMj
         WcGYfJ0q5YKAXYikjlavIXkFxDAeuCfegO7fO/xWAdZCJlb1GCmOMJCoWZUiTtfBvgSR
         O2dQ==
X-Forwarded-Encrypted: i=1; AJvYcCV43Z4XNEDS9QZz+dk7BSvSWG2/6z3EPrDLDkZGG6g0d6BAD+OvZWFSTIcGyJkmZe7u4iCM06TRbgHCdmA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzlrx1ZuHppd8BGefurt9x8x4gkuC42x71viXb9oKKB9gv34yAl
	AH4wFGnOKNaWM3WqDu3S24i808mAt4DJsReeVTG9b6fYmdO5deNrI2K5CewezhL/bK5ZbBaAalr
	ClmjuvikbFS98lCigThgBouVmxWaYm4lmFBi3ae08hQ==
X-Gm-Gg: ASbGncvcx808fuG5ZMOAJrSwbPk+Ga/FHGIwoSvztmINGD5oEFIOculnE1ESF5kZ/mj
	SCkBIjDLP3e3cRzg8eI7+sNso62+goZHpjGLM+VO2np+zJfaCz+FNWMLFRVqR/lTzyh1qOqLcXn
	pj6drPrm1OjUO6jlzAij1go7yxaCnJ93eZs2XlnItkyJLEsMPoeVd9ahozo4MiD2O02x7H5YW9U
	fGFbgyUXxVT4GhqsSD6AVRzJCVWUojLAsWq2KQYl3qtYdUA0fTSyPh6bIiCPdZosmsY+u09Jg+c
	+t72SBL/jFOy2a8xCqvbxvEWD6+lAe8XnINcoLxt3D9SIZHdSQc=
X-Google-Smtp-Source: AGHT+IEj9iIFsZIJy7VYK8k+eD82W99U6thDDvr3Il/rycdxbwYPZw7iXiAb8sYHSRlB0te//hksUCovkbAvYVNVBnU=
X-Received: by 2002:a05:690c:4b89:b0:786:5499:6340 with SMTP id
 00721157ae682-786549968camr624657b3.21.1761903108203; Fri, 31 Oct 2025
 02:31:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251022114527.618908-1-adriana@arista.com> <20251031084101.701159-1-adriana@arista.com>
 <20251031084101.701159-3-adriana@arista.com>
In-Reply-To: <20251031084101.701159-3-adriana@arista.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Fri, 31 Oct 2025 11:31:11 +0200
X-Gm-Features: AWmQ_bmWyYlCW0A93XcRB_MwyaKSsdQLSr0mMsiasbGEhlTJwVwCdJ2Jtv0fY24
Message-ID: <CAC_iWjKEK6ardoCS9YUArhU-5UJfdb8cCGiiH=Ly=KkXTh=hvg@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] drivers: firmware: dmi_scan: Add support for
 reading SMBIOS from DT
To: adriana <adriana@arista.com>
Cc: ardb@kernel.org, trini@konsulko.com, robh@kernel.org, krzk@kernel.org, 
	jdelvare@suse.com, frowand.list@gmail.com, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org, vasilykh@arista.com, arm.ebbr-discuss@arm.com, 
	boot-architecture@lists.linaro.org, linux-efi@vger.kernel.org, 
	uefi-discuss@lists.uefi.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"

Hi Adriana,

On Fri, 31 Oct 2025 at 10:41, adriana <adriana@arista.com> wrote:
>
> From: Adriana Nicolae <adriana@arista.com>

We'll need a description of why the change is needed here.

[...]

>
>  #ifndef SMBIOS_ENTRY_POINT_SCAN_START
>  #define SMBIOS_ENTRY_POINT_SCAN_START 0xF0000
> @@ -670,6 +673,54 @@ static int __init dmi_smbios3_present(const u8 *buf)
>         return 1;
>  }
>
> +#if IS_ENABLED(CONFIG_OF)
> +/**
> + * dmi_scan_from_dt - Find and parse DMI/SMBIOS tables from the Device Tree
> + *
> + * Checks if the bootloader has passed SMBIOS table addresses via the /chosen
> + * node in the Device Tree. This follows the standard kernel DT bindings and
> + * assumes a fixed 32-byte mapping for the entry point.
> + * Returns true if a valid table is found and successfully parsed.
> + */
> +static bool __init dmi_scan_from_dt(void)
> +{
> +       struct device_node *chosen;
> +       const __be64 *prop;
> +       char buf[32];
> +       void __iomem *p;
> +       bool dmi_available = false;
> +       u64 addr;
> +       int len;
> +
> +       chosen = of_find_node_by_path("/chosen");
> +       if (!chosen)
> +               return false;
> +
> +       prop = of_get_property(chosen, "linux,smbios3-table", &len);
> +       if (prop && len >= sizeof(u64)) {
> +               addr = be64_to_cpup(prop);
> +
> +               p = dmi_early_remap(addr, 32);

Please put '32' into a define that explains what it is

> +               if (p == NULL)

I think if (!p) is preferred

> +                       goto out;
> +
> +               memcpy_fromio(buf, p, sizeof(buf));
> +               dmi_early_unmap(p, 32);
> +
> +               if (!dmi_smbios3_present(buf)) {
> +                       dmi_available = true;
> +                       goto out;
> +               }
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
> @@ -718,6 +769,13 @@ static void __init dmi_scan_machine(void)
>                         dmi_available = 1;
>                         return;
>                 }
> +       } else if (IS_ENABLED(CONFIG_OF) && dmi_scan_from_dt()) {

Can you fold the IS_ENABLED() in dmi_scan_from_dt() please?

> +               /*
[...]

Thanks
/Ilias

