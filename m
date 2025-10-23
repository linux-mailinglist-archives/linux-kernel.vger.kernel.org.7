Return-Path: <linux-kernel+bounces-867167-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A0171C01BB7
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 16:22:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 01D401885886
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 14:22:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85F4C32AACA;
	Thu, 23 Oct 2025 14:21:30 +0000 (UTC)
Received: from mail-ua1-f46.google.com (mail-ua1-f46.google.com [209.85.222.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E74B32AABB
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 14:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761229290; cv=none; b=oNDVrVMpweqnsGdm6BSWURdTybYAeCxNPSLgCPHYZwpxvaYcMDYsSAc494XAfA1MrDY7LeF/m4Gq94/JmejVnK5rxaHc7Y3wJ1o6vs54DRrCMgS6LJNbCh/UyGwb5z9L1D0A31l9Y29EPsHNZmiA7C42ZRiCQoG11RbAwWrn6P0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761229290; c=relaxed/simple;
	bh=TR7zlOg9lSlA9ANoIApwm25S9VrQTmkZ7BlIZp3yWzs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Eyd2V9OyKCBVtGOzS7Rldsy9VFSWjWLvX0udnOdYCEIgdpT9u+wNBgmP4qBJBoQ8lOkV6bhp9HQgfmk/BAmFKxZ04UEV34+mXNvFser1wHjmPPebIjcnk95n7bDluTkDo4EySbho8HGlX15Tcf5N51ikMmtz7r370A/Rjw/mQgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f46.google.com with SMTP id a1e0cc1a2514c-932bced8519so678451241.1
        for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 07:21:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761229287; x=1761834087;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pUiJSOGezbV9/gcxRXe7vCcpv1VybDaME+fAsfjpYbw=;
        b=RokupwHa2gW9KywisA2tVPFaXRjRbwOrJ1HlhV67bjhl4Cy68XNPNFZmgoiXCtrpAd
         KUCr3c4qTJXr/h5LymV9P0FUAWXqT8izMBy8aDL/1sk8hcOTiUYuQBwWXYyrwhDncA3u
         /Gb6T292RnjZ8RyTcDcGfiP6Ucl21NlvJCVeDOH0dlKhLWmtudpwpoqWeuj/1tcxkIhX
         koGDvX3oD9NHYlK5RhWAgVdPty5q8fyOFU4tM9wIooLaYcuVa0AFW2Vi21sfwfF+ri/K
         i/Q9/AcJp1jPyWBHXQ+RtRuf2362p5rI8IMvs130HRWn45aAgEoFpHHyieXIzvgVhR5i
         pNTw==
X-Forwarded-Encrypted: i=1; AJvYcCViIPpuP8UG1CQi/b4WgKo0uRc1VzN1VgPmH5zSXEja1akFN4X8flqxGYZ8LJEbsGwgVmIu/nHUIpPi5rs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJtXRgIhNSQfHimTWZsiGD3qIZ37UI28ieuBNgBICze/fzkTfE
	9vGVjtVrjwiyJydF0d3F1jV47AO3WuEvP/mlOIcu1Mu09HkiPqrsv9C1pIEea0Sd
X-Gm-Gg: ASbGnctGqYuhirBNjKEgNIBMn4RDWR3bhUYEloZ9ytr/EuMeemEraHswzd4oy6poZYT
	LZB2XdUNnt527PvzalMkndUK9jhxjbrs1mUZ6mD7yLnFsMEpkax8uz4FjbWUQg8LNjE5z5kX/21
	TEANqIVKX3OGvJNYBzYENum6n5bI9x+bM6E96k87JsrLInW4nt6dSMBhSUiVbE4VBRXgb0WYowd
	Xda02X/yhTeNXUgHgGbcD+gH4e5cZmrEFK2U4MQqheE9QgwdI9TzMHMSFq7JPAlihhTe3epdQBZ
	xI+A941qqRgSQ7krewNIG9yoQGVBCblQgYcJcIbtsWPKXLVgnxnBLLP4QnsgWelVTbmHIW5PyWg
	75QDX7v50+/d/AmTcGD7GYTxtckIH72l5fBNc+QvDU7U46OfdE1xBNiadWRlmNP0TSpid6VqfYY
	vjQlZqMSivKVwWwAlskrtYS14X00H4TyDBICfUhSYofQ==
X-Google-Smtp-Source: AGHT+IEdK3D5ea1erUCvDuMpANwWZoLJiiMSymPpkVAcxzNbYYt6mvEbcVgDXRs12iubpqQJfedKOQ==
X-Received: by 2002:a05:6102:3f52:b0:5be:d04d:d2c6 with SMTP id ada2fe7eead31-5d7dd423a07mr8070511137.9.1761229286945;
        Thu, 23 Oct 2025 07:21:26 -0700 (PDT)
Received: from mail-vk1-f173.google.com (mail-vk1-f173.google.com. [209.85.221.173])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-5db2c77c69bsm883697137.2.2025.10.23.07.21.24
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Oct 2025 07:21:25 -0700 (PDT)
Received: by mail-vk1-f173.google.com with SMTP id 71dfb90a1353d-557c75fe551so271860e0c.3
        for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 07:21:24 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWS0ognhq+1XJXxE36V215wn5v/45arOWCi40pmfHNWFaEU3UxtHud5zgiuBIdXCfsDuJmDIBE/w0oRfTo=@vger.kernel.org
X-Received: by 2002:a05:6102:5106:b0:5a8:4256:1f14 with SMTP id
 ada2fe7eead31-5d7dd5eb057mr7937173137.35.1761229283909; Thu, 23 Oct 2025
 07:21:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251007133657.390523-1-claudiu.beznea.uj@bp.renesas.com>
 <20251007133657.390523-3-claudiu.beznea.uj@bp.renesas.com>
 <CAMuHMdXF14x68Wk5YdOBS2D2N6LtnQjfGzrsMdSJegX-gc3faQ@mail.gmail.com>
 <6c69d2a2-5dfe-450f-8a39-2ef6e7a6dbea@tuxon.dev> <CAMuHMdXLiN0kUVJtdEYVnsmnCEbN4hSs5KEhMXJhf7p29xv=0Q@mail.gmail.com>
 <f09bf940-3d45-49b1-8d7f-9c1a96acb187@tuxon.dev>
In-Reply-To: <f09bf940-3d45-49b1-8d7f-9c1a96acb187@tuxon.dev>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 23 Oct 2025 16:21:11 +0200
X-Gmail-Original-Message-ID: <CAMuHMdXx=5YQSmSsw1+3otw9S_Hf+Tv+N1Y1iHiU0OOTyz4bjw@mail.gmail.com>
X-Gm-Features: AWmQ_bntosPEVOR4ph6dmWLKdA_CbWSKXTDRFcmNnJAAp9ekneiOOs4jYqpQulM
Message-ID: <CAMuHMdXx=5YQSmSsw1+3otw9S_Hf+Tv+N1Y1iHiU0OOTyz4bjw@mail.gmail.com>
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

On Thu, 23 Oct 2025 at 16:13, Claudiu Beznea <claudiu.beznea@tuxon.dev> wrote:
> On 10/23/25 14:02, Geert Uytterhoeven wrote:
> > On Thu, 23 Oct 2025 at 12:54, Claudiu Beznea <claudiu.beznea@tuxon.dev> wrote:
> >> On 10/23/25 11:00, Geert Uytterhoeven wrote:
> >>> On Tue, 7 Oct 2025 at 15:37, Claudiu <claudiu.beznea@tuxon.dev> wrote:
> >>>> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> >>>>
> >>>> The Renesas RZ/G3S features a PCIe IP that complies with the PCI Express
> >>>> Base Specification 4.0 and supports speeds of up to 5 GT/s. It functions
> >>>> only as a root complex, with a single-lane (x1) configuration. The
> >>>> controller includes Type 1 configuration registers, as well as IP
> >>>> specific registers (called AXI registers) required for various adjustments.
> >>>>
> >>>> Hardware manual can be downloaded from the address in the "Link" section.
> >>>> The following steps should be followed to access the manual:
> >>>> 1/ Click the "User Manual" button
> >>>> 2/ Click "Confirm"; this will start downloading an archive
> >>>> 3/ Open the downloaded archive
> >>>> 4/ Navigate to r01uh1014ej*-rzg3s-users-manual-hardware -> Deliverables
> >>>> 5/ Open the file r01uh1014ej*-rzg3s.pdf
> >>>>
> >>>> Link: https://www.renesas.com/en/products/rz-g3s?queryID=695cc067c2d89e3f271d43656ede4d12
> >>>> Tested-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> >>>> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> >>>
> >>> Thanks for your patch!
> >>>
> >>>> --- /dev/null
> >>>> +++ b/drivers/pci/controller/pcie-rzg3s-host.c
> >>>
> >>>> +static void rzg3s_pcie_irq_compose_msi_msg(struct irq_data *data,
> >>>> +                                          struct msi_msg *msg)
> >>>> +{
> >>>> +       struct rzg3s_pcie_msi *msi = irq_data_get_irq_chip_data(data);
> >>>> +       struct rzg3s_pcie_host *host = rzg3s_msi_to_host(msi);
> >>>> +       u32 drop_mask = RZG3S_PCI_MSIRCVWADRL_ENA |
> >>>> +                       RZG3S_PCI_MSIRCVWADRL_MSG_DATA_ENA;
> >>>
> >>> This should include bit 2 (which is hardwired to zero (for now)),
> >>> so I think you better add
> >>>
> >>>     #define RZG3S_PCI_MSIRCVWADRL_ADDR  GENMASK(31, 3)
> >>>
> >>>> +       u32 lo, hi;
> >>>> +
> >>>> +       /*
> >>>> +        * Enable and msg data enable bits are part of the address lo. Drop
> >>>> +        * them.
> >>>> +        */
> >>>> +       lo = readl_relaxed(host->axi + RZG3S_PCI_MSIRCVWADRL) & ~drop_mask;
> >>>
> >>> ... and use FIELD_GET() with the new definition here.
> >>
> >> Bits 31..3 of RZG3S_PCI_MSIRCVWADRL contains only bits 31..3 of the MSI
> >> receive window address low, AFAIU. Using FIELD_GET() for bits 31..3 on the
> >> value read from RZG3S_PCI_MSIRCVWADRL and passing this value to
> >> msg->address_lo will lead to an NVMe device not working.
> >
> > Oops, yes you are right, I went a bit too far with the FIELD_GET()
> > suggestion. But replacing drop_mask by RZG3S_PCI_MSIRCVWADRL_ADDR
> > would still be worthwhile, IMHO.
>
> OK, you mean updating it like:
>
> +#define RZG3S_PCI_MSIRCVWADRL_ADDR  GENMASK(31, 3)
>
> // ...
>
>
> -    lo = readl_relaxed(host->axi + RZG3S_PCI_MSIRCVWADRL) & ~drop_mask;
> +    lo = readl_relaxed(host->axi + RZG3S_PCI_MSIRCVWADRL) &
>           RZG3S_PCI_MSIRCVWADRL_ADDR;

Exactly.
Thanks!

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

