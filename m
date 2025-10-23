Return-Path: <linux-kernel+bounces-866774-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC99CC009E4
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 13:03:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 012833AF0C4
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 11:03:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0CD230BB97;
	Thu, 23 Oct 2025 11:03:10 +0000 (UTC)
Received: from mail-vs1-f41.google.com (mail-vs1-f41.google.com [209.85.217.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA97130ACF1
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 11:03:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761217390; cv=none; b=H80tlEpdNxWqWqGjwuvlTuiFD/3IfRaUlPAqZyaewwrRSMtVlXlFXNAfcAHKo9jPSDsNHAjiLrSf+TFe0WnBUZwMf7Cz6jPR1Y8gwagxrRVEtDwM2IijZZwYYZDwiwYtA4uiCaKgXpa8NyQsef7yytVu2atylh/2gduQbMrRQOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761217390; c=relaxed/simple;
	bh=tg+8iAuL9v348WQn+/MKpxNJ48PFBRZL9CF/o4UEAoE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mQPbdaBeqc5IboEdtlmkQ7QBIIvPg3d8D8Vz88Pxvw+kFJsahL2uruThEDyb81i5MnLNJBFdp3g5a3gcI3E8nKmwosq9B/dH6cA/ZHAsIyIofG4JZ99x/ciPkHiOIu7qzCUctPaWtASA+qZTB36QEDDRNNuVIlgTAIFmqLYdcg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.217.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f41.google.com with SMTP id ada2fe7eead31-5ccccc1f7caso326992137.1
        for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 04:03:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761217386; x=1761822186;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WjWvH/pQF78pnjKmIZIOC/klk9iC3EtNoJr9L6Gp1mo=;
        b=HlbbQX8vRus6FcUPgzDpHXXsqaZktQ5gRg1uWyW9QjDtYdQuwMv1mv70W2un1ieNP5
         Kjoof7k0J3J0NtcN0bmQG1wNjZscsytA9M6H30FX3W+9gI6Fc9EYYiTCQzmwAqFsoOVQ
         ixUCgykGn5b5s6JpGunbbllJMo6B22f3TyRLGKZaCib54QSgwIm1+2jLSn4tHwN3wHzz
         VNqd8O6mBSVOR4FN/HUEEyWrIH8j5StBHq/cCgyka91ofgUR7/kF1VuKy5E6Vygi8uhW
         ADBCpY5UC6MQI+MzQ1rSl46jgOtWQS3nPIOD1HD0UzbY1xQxeBnLlv2FvK7+L4lcm7Zq
         7o1g==
X-Forwarded-Encrypted: i=1; AJvYcCUxtuvk5ZVJkz9wWVfFncVZmMcGNdgC2PpJfkE2K/0jrilbqHNuPd/qpIaiMiT9QkRqOH3OITJlW8ORXBA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJLxjDedO8IvwNsW9nNHn11xc+MNMB7kXJei3IHxuA5GFZ3tlD
	Ul+2xdWz1rH17CX0eYzKENd/hgHc2BIhD28D342wji7ZU0VGjMs54dl7sCsGUVUV
X-Gm-Gg: ASbGnctEfC4uGUSWSVKHR7B4ep63wK9rjTjuMF5wuuQd5lHhgEDRURm0vS3a8BZpkgX
	tZ/1/EuH96/NIdIvRtmiC0dqNN9sinKVFoOljgexhzDdUH4q7QHXTD3VOb0RpHdOmrIyW1sbMlg
	Yb3prFrAj8i7e+ScSyW3NOhHkVuUt1H6lHakKSqBo8EHtORtnsHUO3gcLDv2qENiKLjE30iutQA
	VNf33WIqG4x8T7VN2aQHODkVfjcmJXq6G144cecUXXSyD3yw1LBArszHMz30Ec30gU3iFiYraEH
	Q2d9TJsZ8R+MlkA3ZeJCrI1q9nfx5ywFPXSIuViQ+uhg8CYE5s/ET9eetyaHr8Jx4MFS8Wls74h
	9TmI0bpOGYAagQfcwG2EdVRCq3+HwzSP5Q42gfJtZJnDXNP3OVVfmasG0G08rSVQpig03RLo+3k
	Sdmy7xjl5hb2hbsCS8v1XoDfjbf6RISxFwtR3Xzw==
X-Google-Smtp-Source: AGHT+IGES0aIH1hVqNuzTzRKs9IhApESNzqAqaANmmHI8uP4o5fd772y2ECD99gsl9xuaKLrRFSipg==
X-Received: by 2002:a05:6102:3a13:b0:5d5:fefc:9fd0 with SMTP id ada2fe7eead31-5d7dd319363mr6937594137.0.1761217386311;
        Thu, 23 Oct 2025 04:03:06 -0700 (PDT)
Received: from mail-ua1-f53.google.com (mail-ua1-f53.google.com. [209.85.222.53])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-5db2c7c9d3asm718943137.6.2025.10.23.04.03.05
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Oct 2025 04:03:05 -0700 (PDT)
Received: by mail-ua1-f53.google.com with SMTP id a1e0cc1a2514c-932bf9df69dso219707241.1
        for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 04:03:05 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWf5K8dgIy2+ionPFmkqYtyhuzauTWnikhXrvAmhuSIxlrq1X0/0qjtmSbLZet8l+NpOOn1RKGRGxuiT7g=@vger.kernel.org
X-Received: by 2002:a05:6102:2acc:b0:520:a44f:3ddf with SMTP id
 ada2fe7eead31-5d7dd5a3793mr5929967137.10.1761217385274; Thu, 23 Oct 2025
 04:03:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251007133657.390523-1-claudiu.beznea.uj@bp.renesas.com>
 <20251007133657.390523-3-claudiu.beznea.uj@bp.renesas.com>
 <CAMuHMdXF14x68Wk5YdOBS2D2N6LtnQjfGzrsMdSJegX-gc3faQ@mail.gmail.com> <6c69d2a2-5dfe-450f-8a39-2ef6e7a6dbea@tuxon.dev>
In-Reply-To: <6c69d2a2-5dfe-450f-8a39-2ef6e7a6dbea@tuxon.dev>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 23 Oct 2025 13:02:54 +0200
X-Gmail-Original-Message-ID: <CAMuHMdXLiN0kUVJtdEYVnsmnCEbN4hSs5KEhMXJhf7p29xv=0Q@mail.gmail.com>
X-Gm-Features: AWmQ_bm3rJeUf0KSNhlRfvLpl1M_xWwhhcqbJogOZCts4Aa1eBeKq-NYF1bmLWY
Message-ID: <CAMuHMdXLiN0kUVJtdEYVnsmnCEbN4hSs5KEhMXJhf7p29xv=0Q@mail.gmail.com>
Subject: Re: [PATCH v5 2/6] PCI: rzg3s-host: Add Renesas RZ/G3S SoC host driver
To: Claudiu Beznea <claudiu.beznea@tuxon.dev>
Cc: lpieralisi@kernel.org, kwilczynski@kernel.org, mani@kernel.org, 
	robh@kernel.org, bhelgaas@google.com, krzk+dt@kernel.org, conor+dt@kernel.org, 
	magnus.damm@gmail.com, p.zabel@pengutronix.de, linux-pci@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, 
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>, 
	Wolfram Sang <wsa+renesas@sang-engineering.com>
Content-Type: text/plain; charset="UTF-8"

Hi Claudiu,

On Thu, 23 Oct 2025 at 12:54, Claudiu Beznea <claudiu.beznea@tuxon.dev> wrote:
> On 10/23/25 11:00, Geert Uytterhoeven wrote:
> > On Tue, 7 Oct 2025 at 15:37, Claudiu <claudiu.beznea@tuxon.dev> wrote:
> >> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> >>
> >> The Renesas RZ/G3S features a PCIe IP that complies with the PCI Express
> >> Base Specification 4.0 and supports speeds of up to 5 GT/s. It functions
> >> only as a root complex, with a single-lane (x1) configuration. The
> >> controller includes Type 1 configuration registers, as well as IP
> >> specific registers (called AXI registers) required for various adjustments.
> >>
> >> Hardware manual can be downloaded from the address in the "Link" section.
> >> The following steps should be followed to access the manual:
> >> 1/ Click the "User Manual" button
> >> 2/ Click "Confirm"; this will start downloading an archive
> >> 3/ Open the downloaded archive
> >> 4/ Navigate to r01uh1014ej*-rzg3s-users-manual-hardware -> Deliverables
> >> 5/ Open the file r01uh1014ej*-rzg3s.pdf
> >>
> >> Link: https://www.renesas.com/en/products/rz-g3s?queryID=695cc067c2d89e3f271d43656ede4d12
> >> Tested-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> >> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> >
> > Thanks for your patch!
> >
> >> --- /dev/null
> >> +++ b/drivers/pci/controller/pcie-rzg3s-host.c
> >
> >> +static void rzg3s_pcie_irq_compose_msi_msg(struct irq_data *data,
> >> +                                          struct msi_msg *msg)
> >> +{
> >> +       struct rzg3s_pcie_msi *msi = irq_data_get_irq_chip_data(data);
> >> +       struct rzg3s_pcie_host *host = rzg3s_msi_to_host(msi);
> >> +       u32 drop_mask = RZG3S_PCI_MSIRCVWADRL_ENA |
> >> +                       RZG3S_PCI_MSIRCVWADRL_MSG_DATA_ENA;
> >
> > This should include bit 2 (which is hardwired to zero (for now)),
> > so I think you better add
> >
> >     #define RZG3S_PCI_MSIRCVWADRL_ADDR  GENMASK(31, 3)
> >
> >> +       u32 lo, hi;
> >> +
> >> +       /*
> >> +        * Enable and msg data enable bits are part of the address lo. Drop
> >> +        * them.
> >> +        */
> >> +       lo = readl_relaxed(host->axi + RZG3S_PCI_MSIRCVWADRL) & ~drop_mask;
> >
> > ... and use FIELD_GET() with the new definition here.
>
> Bits 31..3 of RZG3S_PCI_MSIRCVWADRL contains only bits 31..3 of the MSI
> receive window address low, AFAIU. Using FIELD_GET() for bits 31..3 on the
> value read from RZG3S_PCI_MSIRCVWADRL and passing this value to
> msg->address_lo will lead to an NVMe device not working.

Oops, yes you are right, I went a bit too far with the FIELD_GET()
suggestion. But replacing drop_mask by RZG3S_PCI_MSIRCVWADRL_ADDR
would still be worthwhile, IMHO.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

