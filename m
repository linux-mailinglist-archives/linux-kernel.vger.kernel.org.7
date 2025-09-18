Return-Path: <linux-kernel+bounces-822466-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 90C05B83F21
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 12:00:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1D6C01C03259
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 10:00:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7663E2C2361;
	Thu, 18 Sep 2025 10:00:21 +0000 (UTC)
Received: from mail-vk1-f176.google.com (mail-vk1-f176.google.com [209.85.221.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E04A27D770
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 10:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758189621; cv=none; b=OC+4oUv3AdVUhm6qP96XOS/nCdRPJkoHNAKCpFFZLV3DrPUNr+jXOqMQ0RDOCholFHlQyvzUx/vPyvr5wwb2gfrz1E0BI+nZPpSakH+aDd2fJPsiqcxp90w+1Yw6xUev80o8XdIWXT+9Tggqk21Ubga1HSk+Z/HNdanJBJB5A+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758189621; c=relaxed/simple;
	bh=/OBhn+PWMDqXGRrapAeq9Q3SvZxxEYXxE4Nz5bqD3Xo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QM8HvjAuyk2Vtk/kPwrBIWqLsBoZnOWZKfpf24d+TE7A9ld6fmxHfrxBNqLxzulWFRFXe1sjuQjuUKw3nbByqHFlCA5XyiYP1L4kZCyDmslaZAyaZxVxpEdlLcsEVMkUivDI/ZN0inN2AeLXUlSr5cq+c7uU9aPjDRhQDT4N3rg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f176.google.com with SMTP id 71dfb90a1353d-54a786ed57cso421348e0c.3
        for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 03:00:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758189618; x=1758794418;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=heq3/GupfVYfNfyXxVtKecyYAD/tIXHJ4nXkThDhTOc=;
        b=S6CA3iiXcwEwJGUFcwtNFcm8GlTbJfwZvH+rRvpk1tlP/Px0fPBGapWXjz3PmnCRqM
         JRYJC+FbWSjHqwVazV4HKTuKFQarrCAK74EMRLZrWnsPQeJiIypnHcG8AqK2SgXLLE/D
         j73X1Cj9HHOkDY9MB5Oxmsp8fMB9/iuPDEHwNz0dU53s2wSbtOi4pZDlj+DM56mqJRbJ
         ud8OxOgA9F8ECPe2Au85m70+uFTscX0EjwpXIKLDXBw8MhtOdD9ioID0vfU5vdbCkxJ3
         QqSoAzhKounBGC2jwdg2vQlMYHOesvJueZf9Zl1V02W2uS7k+WhkIZMTVabewnSLn7ne
         kdWA==
X-Forwarded-Encrypted: i=1; AJvYcCX6Gdj7oiqtM0pu3x4J+zzs9Pm82yqMY5lDlBcA6bxRpwAOSfirSju5CoUjVNaCO7gKPbF75T3Jdl08N24=@vger.kernel.org
X-Gm-Message-State: AOJu0YxuCBus8TZvZ7AIj038UGaVzLNa/1W8U/EdmnneAIDVzcsxEd1C
	zg4lPeRiIeXi+gVN4jTLMrj2b2XZDnghRlqWsXxvu1Ca8rxTVl2IjEMwHLZu9Cq4
X-Gm-Gg: ASbGncumzmQXGjOzmF+rDVJWXKzdWOpLqFmdhDpeOJvU/0SNNni3E1HrDbrNA5HeJYd
	D0ev3XB4oWlTqB+okrbCiRRyrnPM5q8ARs3yk7ChbH6lnUUe1b8lRlE3EaokWEePbielNGni6SN
	MTaG1v4aJ2A2A1AqfJqQCBDNa/nK2+EKzRtP1fFX8LMUMKeqenGoPc9Q5HjOjXqJXBsD1QrFrYb
	KhkFsZshisojA5gJmqNtxrO6A2RpJm0RbvyuOF2eszuDqVMxaRLKtl8MPclTyc6dBMz4gHn8AQy
	TC0pDtFIkhBucRTO3/qfCs6Xr6DjD+d7KIqJWY7sQahZiwUFfi7TapwICMgVaRrriry/+xLuh+M
	VZo1padD5zL6rMkvPqs6USXyx3m78HUM16qzojTtWGfMBxfEyix28jyK1JrlWz1ONzQz2VXUNoK
	j27zw=
X-Google-Smtp-Source: AGHT+IHrpeFYpw7BPbX+FNXESiIeHmyCgr1pqC/y24WZmJPbJGzxyMnh24ZMyeH4lCOi57w2PD9Izg==
X-Received: by 2002:a05:6122:8c1e:b0:539:5717:ecff with SMTP id 71dfb90a1353d-54a608eb990mr1890010e0c.6.1758189617615;
        Thu, 18 Sep 2025 03:00:17 -0700 (PDT)
Received: from mail-vs1-f45.google.com (mail-vs1-f45.google.com. [209.85.217.45])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-54a729744fbsm437888e0c.18.2025.09.18.03.00.16
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Sep 2025 03:00:17 -0700 (PDT)
Received: by mail-vs1-f45.google.com with SMTP id ada2fe7eead31-557a6856135so627232137.0
        for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 03:00:16 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWjX4yatxfF7pwUPPD5alIljCah1s6mmTYe0FSquQbfXC5cZzeZjQ1iXuaOag4dLIfaiGqYFBV1LDLo3kA=@vger.kernel.org
X-Received: by 2002:a05:6102:5e89:b0:520:ec03:32e9 with SMTP id
 ada2fe7eead31-56d4ca46b90mr1938216137.3.1758189615787; Thu, 18 Sep 2025
 03:00:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250912122444.3870284-1-claudiu.beznea.uj@bp.renesas.com>
 <20250912122444.3870284-5-claudiu.beznea.uj@bp.renesas.com>
 <CAMuHMdWP638eB_p9xMAqZmOnuc6n7=n31h6AqV+287uvqQEdww@mail.gmail.com> <c2fc5f6b-0e7c-464e-89a6-35dc76177d18@tuxon.dev>
In-Reply-To: <c2fc5f6b-0e7c-464e-89a6-35dc76177d18@tuxon.dev>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 18 Sep 2025 12:00:04 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWeHoUe-=7TDetnDQbLQsKGf4pDGpSdz3xEVLs_Rst9qQ@mail.gmail.com>
X-Gm-Features: AS18NWA7yJuM6P3qfqTjc7fj_WIPx-OpKuRx0s7hlxrQZNP3abmLA3cANYn1ePk
Message-ID: <CAMuHMdWeHoUe-=7TDetnDQbLQsKGf4pDGpSdz3xEVLs_Rst9qQ@mail.gmail.com>
Subject: Re: [PATCH v4 4/6] arm64: dts: renesas: rzg3s-smarc-som: Update
 dma-ranges for PCIe
To: Claudiu Beznea <claudiu.beznea@tuxon.dev>
Cc: bhelgaas@google.com, lpieralisi@kernel.org, kwilczynski@kernel.org, 
	mani@kernel.org, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	magnus.damm@gmail.com, p.zabel@pengutronix.de, linux-pci@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, 
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>, 
	Wolfram Sang <wsa+renesas@sang-engineering.com>
Content-Type: text/plain; charset="UTF-8"

Hi Claudiu,

On Thu, 18 Sept 2025 at 11:47, Claudiu Beznea <claudiu.beznea@tuxon.dev> wrote:
> On 9/18/25 12:09, Geert Uytterhoeven wrote:
> > On Fri, 12 Sept 2025 at 14:24, Claudiu <claudiu.beznea@tuxon.dev> wrote:
> >> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> >>
> >> The first 128MB of memory is reserved on this board for secure area.
> >> Secure area is a RAM region used by firmware. The rzg3s-smarc-som.dtsi
> >> memory node (memory@48000000) excludes the secure area.
> >> Update the PCIe dma-ranges property to reflect this.
> >>
> >> Tested-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> >> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> >
> > Thanks for your patch!
> >
> >> --- a/arch/arm64/boot/dts/renesas/rzg3s-smarc-som.dtsi
> >> +++ b/arch/arm64/boot/dts/renesas/rzg3s-smarc-som.dtsi
> >> @@ -214,6 +214,16 @@ &sdhi2 {
> >>  };
> >>  #endif
> >>
> >> +&pcie {
> >> +       /* First 128MB is reserved for secure area. */
> >
> > Do you really have to take that into account here?  I believe that
> > 128 MiB region will never be used anyway, as it is excluded from the
> > memory map (see memory@48000000).
> >
> >> +       dma-ranges = <0x42000000 0 0x48000000 0 0x48000000 0x0 0x38000000>;
> >
> > Hence shouldn't you add
> >
> >     dma-ranges = <0x42000000 0 0x48000000 0 0x48000000 0x0 0x38000000>;

Oops, I really meant (forgot to edit after copying it):

    dma-ranges = <0x42000000 0 0x40000000 0 0x40000000 0x0 0x40000000>;

> >
> > to the pcie node in arch/arm64/boot/dts/renesas/r9a08g045s33.dtsi
> > instead, like is done for all other Renesas SoCs that have PCIe?
>
> I chose to add it here as the rzg3s-smarc-som.dtsi is the one that defines
> the available memory for board, as the available memory is something board
> dependent.

But IMHO it is independent from the amount of memory on the board.
On other SoCs, it has a comment:

     /* Map all possible DDR as inbound ranges */

>
> If you consider it is better to have it in the SoC file, please let me know.

Hence yes please.

However, I missed you already have:

    /* Map all possible DRAM ranges (4 GB). */
    dma-ranges = <0x42000000 0 0x40000000 0 0x40000000 0x1 0x0>;

in r9a08g045.dtsi, so life's good.

+
> >> +};
> >> +
> >> +&pcie_port0 {
> >> +       clocks = <&versa3 5>;
> >> +       clock-names = "ref";
> >> +};
> >
> > This is not related.
>
> Ah, right! Could you please let me know if you prefer to have another patch
> or to update the patch description?

Given the dma-ranges changes is IMHO not needed, this can just be
a separate patch.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

