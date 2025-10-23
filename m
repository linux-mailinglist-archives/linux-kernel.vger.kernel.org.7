Return-Path: <linux-kernel+bounces-866436-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 88167BFFC19
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 10:00:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 8765D3519A5
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 08:00:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 694422E7623;
	Thu, 23 Oct 2025 08:00:37 +0000 (UTC)
Received: from mail-vk1-f181.google.com (mail-vk1-f181.google.com [209.85.221.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6E942BFC60
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 08:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761206436; cv=none; b=K7OMZjEMfs0oLxuY/3frYk3wGEvZRTIDFhFJM8HbpXDOIykUa7qlOZHRcFoZxQizhSqZi52xcfA/gyB9sGxE9+kgQi4GhF3Ptin2FkNjip02r1o7EQA9KaRilGs4E7k1w3P5jxvUiMRC4Cp98AKcMls1IATSo79ukNOgyWtqr3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761206436; c=relaxed/simple;
	bh=KpSaMjSEZziIYn4V8EA3oAQHYYGym/G8ks3Kmoko+Q4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dyaBpkUfwuQ0OVSeD7yWiqaKBYjA5VK6O1uElFDjkdm8b9ff+XXSa1OQt6Ji6XbYoh+TfUEN1gvclXdHj6Tep0/3wxZmc3HUr3ErGl9qoWNIu1rjwPbq4yUDc2nEWgwIb7L9LQxnBjKENNnK5dmci8B/XhsVzyTX7rGCP3+wX4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f181.google.com with SMTP id 71dfb90a1353d-54aa4b86b09so254826e0c.0
        for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 01:00:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761206433; x=1761811233;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XF9ym20BXQJuQdpG7CWrlv8nMa2KXEsJ8BzTyt5Bosk=;
        b=LeOBqNQxt8wNy2l2pbq2RJCmvGTJj4MKY9kJs16nBkPXfn9DMN+6KaaipluEj530CS
         dp4fCdoMT3YUwn9OtVEkwNP93MeGBMIDbkbNDeuncH5ppKOBO1yp+P8yU9EmvpPCnePm
         pZ/UJ/1rgrDMB/AxR+hDY/YZb+GXlGsU64HsH/s4SRo1082D6IqJNXXg8IBrRIvzMD3p
         VjJLPAhcfQDwR3bK5OBRfj1zMxQSWonQpnKhmjinQPxJBPV3gemCy+utxvlnYDeKaJ+Q
         5DegM02OF6F4IqkH2f5Cm4q723uOhhEs5JrjZYB1EGf0aD+XzOKfj31O8S8MuD3paeNJ
         TXTg==
X-Forwarded-Encrypted: i=1; AJvYcCXseXdwFFhKUowPGqDOUy8BbMp4rfvURmoFDlB2UwWgu7navcbCocHQZq+SEX+xqsCD8WwNx6pfuckUFpo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxa+aMHlScggsLfsfnpN41rTfl06GOoNuuPD6zDi195DXNn4y8v
	/fTZZmyt4wl5cYGa3chIjKApz9Q1IIXu9asCVT5efv9QmpSFoFqRvs33yp0iieSj
X-Gm-Gg: ASbGncu7x8OBK6tIxqen/tC1RXRomsX5NfPAwoiD5ujxMIuBHn6yBdk7vcXFOawm78z
	mqBFeFMlAdQO+fgmfyJf4uOkCJqGdfFgSTGif78FY8z+p6hqd5tc9JW7Haqyzwoe8YxVlWyHvWb
	w8PZy9Ndxu5SG4QddYmX/gLDTkGpXPojAkXkDL4SdPmjNta5GitPXYv/ye1wom81LWAP0ccWfng
	hAj0NlHVyGkeOnQ0eX0e5JK8jqEsiTIG0T390028jOyLmy/9WqkDxYEC7uzT3zTRC3+wu4xmzz3
	bMeSP4k5ZcEA19Sj3cMWIiXzgtejrkUkOhs2pxFN5RNeRcygtPkxzNn71wN0mqzIBnNI+ByoEXw
	EvNWMQQD5yEkE7j2FA1w0Wi3iM6Z47bYE3O4cc3+hVDzuRt9lRGpF50UZ/A2nM1engjfZo0ehiv
	YBkKNTO3ZWFTvuZbIXHgxCRRKGq/3d10lr1BtBk2eGfdLUvU9Y
X-Google-Smtp-Source: AGHT+IEqg9bETS0HA542MZOyEwHRHA6wHMqlAFe8RKqBz3aEcxl+9O9Z4VOoUYEiR/eKa2FdKOE7bQ==
X-Received: by 2002:a05:6122:6593:b0:54c:da0:f709 with SMTP id 71dfb90a1353d-5564eebb778mr6848917e0c.13.1761206433496;
        Thu, 23 Oct 2025 01:00:33 -0700 (PDT)
Received: from mail-vs1-f47.google.com (mail-vs1-f47.google.com. [209.85.217.47])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-557bd89f41csm528563e0c.1.2025.10.23.01.00.33
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Oct 2025 01:00:33 -0700 (PDT)
Received: by mail-vs1-f47.google.com with SMTP id ada2fe7eead31-5a3511312d6so231462137.3
        for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 01:00:33 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCW8OeBSLRHjfxusIYUHeaoKgRnI6J5VTvwlg3B8es63bYUEEUcDYrJtid/94BvW0D2/WjvbsVIm6HljkYs=@vger.kernel.org
X-Received: by 2002:a05:6102:32d3:b0:5d5:f40a:4cf1 with SMTP id
 ada2fe7eead31-5d7dd6a4e59mr6656672137.24.1761206432910; Thu, 23 Oct 2025
 01:00:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251007133657.390523-1-claudiu.beznea.uj@bp.renesas.com> <20251007133657.390523-3-claudiu.beznea.uj@bp.renesas.com>
In-Reply-To: <20251007133657.390523-3-claudiu.beznea.uj@bp.renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 23 Oct 2025 10:00:21 +0200
X-Gmail-Original-Message-ID: <CAMuHMdXF14x68Wk5YdOBS2D2N6LtnQjfGzrsMdSJegX-gc3faQ@mail.gmail.com>
X-Gm-Features: AS18NWB9_OOBrClG3W5gj81JVaeCg1e2FLiq_rBpovw0Id2oH40EKE5zSy4p5SM
Message-ID: <CAMuHMdXF14x68Wk5YdOBS2D2N6LtnQjfGzrsMdSJegX-gc3faQ@mail.gmail.com>
Subject: Re: [PATCH v5 2/6] PCI: rzg3s-host: Add Renesas RZ/G3S SoC host driver
To: Claudiu <claudiu.beznea@tuxon.dev>
Cc: lpieralisi@kernel.org, kwilczynski@kernel.org, mani@kernel.org, 
	robh@kernel.org, bhelgaas@google.com, krzk+dt@kernel.org, conor+dt@kernel.org, 
	geert+renesas@glider.be, magnus.damm@gmail.com, p.zabel@pengutronix.de, 
	linux-pci@vger.kernel.org, linux-renesas-soc@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>, 
	Wolfram Sang <wsa+renesas@sang-engineering.com>
Content-Type: text/plain; charset="UTF-8"

Hi Claudiu,

On Tue, 7 Oct 2025 at 15:37, Claudiu <claudiu.beznea@tuxon.dev> wrote:
> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>
> The Renesas RZ/G3S features a PCIe IP that complies with the PCI Express
> Base Specification 4.0 and supports speeds of up to 5 GT/s. It functions
> only as a root complex, with a single-lane (x1) configuration. The
> controller includes Type 1 configuration registers, as well as IP
> specific registers (called AXI registers) required for various adjustments.
>
> Hardware manual can be downloaded from the address in the "Link" section.
> The following steps should be followed to access the manual:
> 1/ Click the "User Manual" button
> 2/ Click "Confirm"; this will start downloading an archive
> 3/ Open the downloaded archive
> 4/ Navigate to r01uh1014ej*-rzg3s-users-manual-hardware -> Deliverables
> 5/ Open the file r01uh1014ej*-rzg3s.pdf
>
> Link: https://www.renesas.com/en/products/rz-g3s?queryID=695cc067c2d89e3f271d43656ede4d12
> Tested-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

Thanks for your patch!

> --- /dev/null
> +++ b/drivers/pci/controller/pcie-rzg3s-host.c

> +static void rzg3s_pcie_irq_compose_msi_msg(struct irq_data *data,
> +                                          struct msi_msg *msg)
> +{
> +       struct rzg3s_pcie_msi *msi = irq_data_get_irq_chip_data(data);
> +       struct rzg3s_pcie_host *host = rzg3s_msi_to_host(msi);
> +       u32 drop_mask = RZG3S_PCI_MSIRCVWADRL_ENA |
> +                       RZG3S_PCI_MSIRCVWADRL_MSG_DATA_ENA;

This should include bit 2 (which is hardwired to zero (for now)),
so I think you better add

    #define RZG3S_PCI_MSIRCVWADRL_ADDR  GENMASK(31, 3)

> +       u32 lo, hi;
> +
> +       /*
> +        * Enable and msg data enable bits are part of the address lo. Drop
> +        * them.
> +        */
> +       lo = readl_relaxed(host->axi + RZG3S_PCI_MSIRCVWADRL) & ~drop_mask;

... and use FIELD_GET() with the new definition here.

> +       hi = readl_relaxed(host->axi + RZG3S_PCI_MSIRCVWADRU);
> +
> +       msg->address_lo = lo;
> +       msg->address_hi = hi;
> +       msg->data = data->hwirq;
> +}

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

