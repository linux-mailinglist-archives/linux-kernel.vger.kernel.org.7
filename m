Return-Path: <linux-kernel+bounces-827537-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D419B9201F
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 17:42:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B08A2174A5B
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 15:41:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BC032E88A1;
	Mon, 22 Sep 2025 15:41:53 +0000 (UTC)
Received: from mail-vk1-f178.google.com (mail-vk1-f178.google.com [209.85.221.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F6B52E03E4
	for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 15:41:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758555713; cv=none; b=Jww/hJhwnElzNR1N1dAeVELFiXTIsYCJpg1QMjnkTi1oWV2/nYR/HqyIW4dPAILaenidgFWOuO//4z+a+7xOiGVWtvCuVPmHdl15WBXYIEgapcraHR9g3gRP4GSS7kLB6PICYx/wim8twuUOZHKoJqRXbc/6/jUsNMKv81RrSbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758555713; c=relaxed/simple;
	bh=LPaxUgjulCIZky3hRfMrs4SMdXdUnOG63nKkquHAkQk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NMCItYn5mvNi3pi9A+AQLyq06O4N2FMvwowENMwOg1r/RI7by9ke13ZPqJF0K+dWv6euzzlfdgDUFgZ5gF2hjb8/sRBYu9QQ7NoU2IOtcl83SpzHLepNrxci0aYAhRUsJd/nwjtothP6SQIEjOPNmWg/+W1Qrdi5RFqaHeFPiyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f178.google.com with SMTP id 71dfb90a1353d-54a94a48debso747346e0c.2
        for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 08:41:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758555710; x=1759160510;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lkETsZJNMYJYRULnxLtQXFZTQmJ76gdUN2IchMcg1nI=;
        b=uxdgn4tyM7kHrgFQSQ9AGbrAbbecmFqDi1GPVwiGoOzQY5s4HqP7s9aqkX6e2kLr0T
         O80Giq3D8NYQEHaM40Gh31iACoJj2QBA3ps2T+huTICf08maBi7DQVE7Ef38y2nDxhQo
         TfptNM0qg2oZQ8NLBhxANBQhoiEiEstifvyfW4xwo5mnyrpfv7URuwLZVj2Zts1gnPcY
         z0wBYRIb7mJOxIrY+TH+K2NI97DviNdXECkcKaxhEPFz4ExQR5j5illeS0kTxCger3tv
         W1ocRwLA37t1gcEsYJZ/TxSctYbK7uMQVo7Ko07Moq52p1sXg3zZQudf3/dMObs9clEP
         xt7A==
X-Forwarded-Encrypted: i=1; AJvYcCXJqElno6+2JQUPDiSBzFrDZfUIgtjH/gB3/cTGfKbvKdCyD8hNfJ0PZZqwUtSwKGQTcwX/zkxqcTp6IIY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzltnxn98MAXMqoEoMBc8SK+wf3c//MeT+oqvn/mrwyCKkvhbFW
	0EUUSkIS371dL8ViRP7e2X0Lo16JTzZQlP7RVM+NUIwcGc0QjeHa1QFZLOwCP/Xy
X-Gm-Gg: ASbGnctUr3DpZowyztOjymZLo1Sli+J/MvU+MkfDlDLOMnmsLhb9PEemx1QvTY2gqo0
	DW7dIxe4b8vjm4zB8lx5aKVIVz6sN+kXRW1dIS3grSfYlgRsjpVgaAL9FWHTCRZfaZENzSLaFMX
	W5qwknmy3XkejPFylIyVaEXZG0XCXzp1X3n2B5myjGKPybiw3ytcfB8YOBDGZUuu05FsY+DAoit
	Pv53LkCgzAqibghycZ7Rf5xegJxTdwpHd0CW+0mCzYGjHlUMdZdvNmnexnS1UO0jA0aKT0vMK03
	gCM1/10pTFOLUJHrOMqPiCvngP+NUHH96XnlfbegH8sSUQ07bBTYHEPJtDdQD1MOfgeb6xZ8bmD
	yhM/1MufN4tTcBj/KIm8nbOvKjw6siU0s4wxfPMVwdb0Ejs5Ip8Gpy+tkqQLV
X-Google-Smtp-Source: AGHT+IH0rWq0VNB4MwJzhCgmL8DZIf2W8V+2e+WgEUhtyLGghX1mcbHB3fIGACoSjnsUxA5fmivwZA==
X-Received: by 2002:a05:6122:3c50:b0:54b:be27:b541 with SMTP id 71dfb90a1353d-54bbe27bacbmr646864e0c.8.1758555710062;
        Mon, 22 Sep 2025 08:41:50 -0700 (PDT)
Received: from mail-vs1-f50.google.com (mail-vs1-f50.google.com. [209.85.217.50])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-54a8bf1802asm1775975e0c.26.2025.09.22.08.41.48
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Sep 2025 08:41:48 -0700 (PDT)
Received: by mail-vs1-f50.google.com with SMTP id ada2fe7eead31-59eb88955d8so531363137.2
        for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 08:41:48 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUsoKCdUs12oi7VkZoltUxE89u/zeLV1XezXeWmhGOiAbjYn6ms+APsobmGKJVsgHvtUIL8fnQAn1H6LJs=@vger.kernel.org
X-Received: by 2002:a05:6102:6890:b0:534:cfe0:f83e with SMTP id
 ada2fe7eead31-588d388f544mr3285300137.3.1758555708237; Mon, 22 Sep 2025
 08:41:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250922153352.99197-1-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20250922153352.99197-1-marek.vasut+renesas@mailbox.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 22 Sep 2025 17:41:37 +0200
X-Gmail-Original-Message-ID: <CAMuHMdUG_y-gb6kGd+Bgo5AQvqv009RYwVjwN5dDC0WFOuyPcg@mail.gmail.com>
X-Gm-Features: AS18NWCFEiYkOlpoRVmaYaX7WRJp7yXl-rQ_0FdjEskYo2uwSKVFu_hC0WhJkpE
Message-ID: <CAMuHMdUG_y-gb6kGd+Bgo5AQvqv009RYwVjwN5dDC0WFOuyPcg@mail.gmail.com>
Subject: Re: [PATCH] PCI: rcar-host: Add static assertion to check !PCI_LOCKLESS_CONFIG
To: Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: linux-pci@vger.kernel.org, 
	=?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, Geert Uytterhoeven <geert+renesas@glider.be>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Magnus Damm <magnus.damm@gmail.com>, 
	Manivannan Sadhasivam <mani@kernel.org>, Marek Vasut <marek.vasut+renesas@gmail.com>, 
	Rob Herring <robh@kernel.org>, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, 
	linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Marek,

On Mon, 22 Sept 2025 at 17:34, Marek Vasut
<marek.vasut+renesas@mailbox.org> wrote:
> This driver can not function correctly without PCIe subsystem level
> config space access serialization. In case PCI_LOCKLESS_CONFIG is
> ever enabled on ARM, complain loudly so the driver can be updated
> accordingly.
>
> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>

Thanks for your patch!

> --- a/drivers/pci/controller/pcie-rcar-host.c
> +++ b/drivers/pci/controller/pcie-rcar-host.c
> @@ -35,6 +35,14 @@
>
>  #include "pcie-rcar.h"
>
> +/*
> + * This driver can not function correctly without PCIe subsystem level
> + * config space access serialization. In case PCI_LOCKLESS_CONFIG is
> + * ever enabled on ARM, complain loudly so the driver can be updated
> + * accordingly.
> + */
> +static_assert(!IS_ENABLED(CONFIG_PCI_LOCKLESS_CONFIG));
> +
>  struct rcar_msi {
>         DECLARE_BITMAP(used, INT_PCI_MSI_NR);
>         struct irq_domain *domain;

This causes a build failure when compile-testing, e.g. x86 allmodconfig.
Using "depends on !PCI_LOCKLESS_CONFIG" instead would avoid that,
but indeed has the disadvantage that it wouldn't complain loudly when
PCI_LOCKLESS_CONFIG would ever be enabled on ARM64...

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

