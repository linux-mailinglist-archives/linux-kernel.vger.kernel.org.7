Return-Path: <linux-kernel+bounces-893425-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 78187C475CA
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 15:54:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 667164E6224
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 14:54:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76041314B70;
	Mon, 10 Nov 2025 14:53:52 +0000 (UTC)
Received: from mail-ua1-f44.google.com (mail-ua1-f44.google.com [209.85.222.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 820973148DB
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 14:53:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762786432; cv=none; b=qqf5wVSx1rLW+YheI4/fBx8TyK1ABrdR/ljvD6fmZ6DLQpSXHJVmh4HXSmjoBF87hQFcnE66KofM18h6DG2iZuZ2oogJupal+/xknYpORom6QGy7nOiqyermpZfdQc9Kfaj+NK1VgMDimDk6iqR0J0qUeA2q6jE1vSge5AP/i/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762786432; c=relaxed/simple;
	bh=uh2nsHm1TccBHviN7yt6RF3Wbnsj4I0JcKQPHH3BVJ4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GSgJ/oIvSNf7ypBW3nmFywHgxDvTRY3ciWaB5NvbASaQNSj9Z2Ako51ZNcMIF5NatQGsGWCM41RM14v2CAFv73SjANdLA9kk4M3LG0E8mSeUMCG1d4YHEo+Q2TfL6pBk1ssnSfLowflMld+lkg+Qvwm5DfQxlIrmIlyaZ6mGbdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f44.google.com with SMTP id a1e0cc1a2514c-9372410c6faso517851241.3
        for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 06:53:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762786429; x=1763391229;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HBDbEJ0nGZ51BHCYDbGr9xQJt2w4kKvCTSyIXM32/kQ=;
        b=eNjk72COUDG6X/kE8MFyGzXRROINpKT2+nedeP5gYgKuZTfbRXVLYd0vv+iniaOKnI
         PqIKLR/apMR/IH57qZ9uFsa+NwGWs1SBDC2kFmExGpu2m4/soZMl6EE0dMf+245CHmdO
         D/aLK2T0cTVadaeC5KUykCu3cqvcWsVg/GRQ2IJmVMkx72q0w760aRSN+juBzw8yDgzd
         iy3cI1rb95yYMeiGeKilWyenQ6ltSg5cOza39xUkOpEM+s7paCC/LSVVBHYJF5Dn+FHj
         9zsqzpLVouGGwOf1qJUHjfS0/DHEVY+sApxtuJ+xWGKhb0/Lm6Jw1AskTIcDI1qNJey8
         ZgHg==
X-Forwarded-Encrypted: i=1; AJvYcCUg+ufPiNkqDTVdKwCH4fKxHmyH+OojbbkQYET2TX3kGtpbUZFlipfWDlkYxO/i6+Hlyih2bltS1k5nw0I=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy952Pe9otqnvKlzVNzNWr/qK12G3+ehPUgQ7nEeyAK9a4qoJOc
	LSTT1V0Cs33FEzGH9DMBLn1hCO3nAIyAdWpT/rYLy5Bb96p5UJUGejdvVM6tw5ik
X-Gm-Gg: ASbGncssW4fA+RWFb3eZ0HJylWcXqOK+bJ8YuRyw3wNKxi+McAQ7R7RHxQz2/LyYgY4
	2QiPqq2yAJB51LglYIvpXptjkQiXH0/MAkAt0z7uVqra3LTu5YNBEcu+EN+8lr8M9N3YNkClBdh
	NJyN5/ZiBhHmpZZGkPn6Gj+wRpDoTcopX+fwlQIy5h4C1oEZfGaXSd/3Ow4gVTo5/ZoMIFQWe+t
	Qm1C+lwHHQwisdHmqurCL0dq1UBB3PsrzyDF0nGDUPmhWgDMbvcswRH30i1zhLWMQwlq68JySQ/
	zSXqlGfDJfH8OvI7INmCbbblWPk7O0BnQC1WC3ySQ5O+SRt3R7pKGiD5L7/hlFMQQNfh1ddZaMC
	utf0M2DU/KV8wn2E6qwwHSn8E5qPVgprATGtqkA77fpevTeyNHRNuNMVLs/VohSP8qTd+qZ/K52
	8gZpibe1Ej0Y1olqBfqjj/2JhMC8pKaBUgfjtoOvlNq3iqy5UvL2+u
X-Google-Smtp-Source: AGHT+IF9y094sfvNQvl7EBF2Pswrp0yDkFL2DgykoRkSdXMJmRvTO3Qurz3CcJu5CKgONbBQzm8/1A==
X-Received: by 2002:a05:6102:3046:b0:5db:ca9e:b577 with SMTP id ada2fe7eead31-5ddc482d466mr2434443137.35.1762786429113;
        Mon, 10 Nov 2025 06:53:49 -0800 (PST)
Received: from mail-vk1-f181.google.com (mail-vk1-f181.google.com. [209.85.221.181])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5599582860asm7617190e0c.16.2025.11.10.06.53.47
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Nov 2025 06:53:48 -0800 (PST)
Received: by mail-vk1-f181.google.com with SMTP id 71dfb90a1353d-55965c96fd7so781568e0c.0
        for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 06:53:47 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWRoQ8zv/qlivYV3jmh9V6Doy8MLDeH4r7NgXUI/Rov7wWXCVK0r5aCG37WBfFJU7XBNpIbBuBKUNGfc3o=@vger.kernel.org
X-Received: by 2002:a05:6102:4423:b0:5db:ce1d:679c with SMTP id
 ada2fe7eead31-5ddc467ef04mr2317202137.8.1762786427413; Mon, 10 Nov 2025
 06:53:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251028175458.1037397-1-prabhakar.mahadev-lad.rj@bp.renesas.com> <20251028175458.1037397-4-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20251028175458.1037397-4-prabhakar.mahadev-lad.rj@bp.renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 10 Nov 2025 15:53:35 +0100
X-Gmail-Original-Message-ID: <CAMuHMdV1jaDDrAruoMK860UP7UXRBf88nY5rr9WaR8Nggy9yEw@mail.gmail.com>
X-Gm-Features: AWmQ_bliN2EbPfNna_bfXmkjvrkOSZzdIDZ9FQoc0Y55u7pPWnoWcSMG6AzvldQ
Message-ID: <CAMuHMdV1jaDDrAruoMK860UP7UXRBf88nY5rr9WaR8Nggy9yEw@mail.gmail.com>
Subject: Re: [PATCH v2 3/5] arm64: dts: renesas: r9a09g077: Add GMAC nodes
To: Prabhakar <prabhakar.csengg@gmail.com>
Cc: Magnus Damm <magnus.damm@gmail.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Biju Das <biju.das.jz@bp.renesas.com>, 
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>, 
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"

Hi Prabhakar,

On Tue, 28 Oct 2025 at 18:55, Prabhakar <prabhakar.csengg@gmail.com> wrote:
> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>
> Add Ethernet MAC (GMAC) device nodes to the RZ/T2H (R9A09G077) SoC DTSI.
> The RZ/T2H integrates three GMAC interfaces based on the Synopsys
> DesignWare MAC (version 5.20).
>
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Thanks for your patch!

> --- a/arch/arm64/boot/dts/renesas/r9a09g077.dtsi
> +++ b/arch/arm64/boot/dts/renesas/r9a09g077.dtsi

> @@ -495,6 +933,13 @@ sdhi1_vqmmc: vqmmc-regulator {
>                 };
>         };
>
> +       stmmac_axi_setup: stmmac-axi-config {

I will move this up while applying, to preserve sort order
(alphabetical).

> +               snps,lpi_en;
> +               snps,wr_osr_lmt = <0xf>;
> +               snps,rd_osr_lmt = <0xf>;
> +               snps,blen = <16 8 4 0 0 0 0>;
> +       };
> +
>         timer {
>                 compatible = "arm,armv8-timer";
>                 interrupts = <GIC_PPI 13 IRQ_TYPE_LEVEL_LOW>,

The rest LGTM, so
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
i.e. will queue in renesas-devel for v6.19, with the above fixed.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

