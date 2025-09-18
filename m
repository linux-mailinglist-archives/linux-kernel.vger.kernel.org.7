Return-Path: <linux-kernel+bounces-822389-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D5F9DB83BB2
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 11:16:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 92DB5524C2D
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 09:15:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE8892FFDF7;
	Thu, 18 Sep 2025 09:15:38 +0000 (UTC)
Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF9DF29BDB9
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 09:15:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758186938; cv=none; b=HqZ3/TJNAYDMjdl8HrtgDXmZ0N9/WFMo3MSzMYzPjDsNeux/TYFaPAoj4vSlXL2BTjEQhhLghlZRAo4Ws/NpSPDscq1AAoPISH7sGzUq/WWWQcGM/IgQjC4qoD3UX2/jggytbGHFXoQaPESXwggdOZuO/sr4HHmYubzW4cfdVO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758186938; c=relaxed/simple;
	bh=oA78+Hc2QsigW6eOAwWharYmhHBJia9T9YFq3+h/+4Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=R7Hr8K/5l4jVJnVUoIyTrqm+HOjCZlsL4lJtUxstWTOd+Boe7ADj9yeDVWNqYAK/AaGB+USEx5oelfWi4EByim4KRl0uAGJVxOOZb0/8OWoJWlwZxSTblopN+k8NamjDjC3+yu8G9C12IeypoOYreux5CvzwsS97mJtTPboOo+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-7f04816589bso75320485a.3
        for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 02:15:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758186935; x=1758791735;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BUI3LMEUjKeaMro6VS1cwSeOA9TFMizFtGUUlwJmP8Y=;
        b=mmJXII+Rgabzkb9bTi1do1hLV2opNK+8ciJvxIg15OrRoeJ6DfBGiuPFzJ1bkqhopp
         IR5Wx6Dwn1aGFh5yWJQgJ0TojnwyK9ShZA85jZxJW9qp4s3pHpGil32wHUPP7ZBKW+QL
         +zHwFRCr7eHVRediF4Q6aLhvLnIN1/3WVD4desdQ3KShL2MlUpz8gOqiEsEKhAZTK/w/
         hxG7NzKjDVFAwLZrrTp8468+SRqyNGf4mK+8nmzrBVZAl3wnGr0lRmOlj4spsbdT0GjA
         tQmHR7oVVie2NZ7eob3+2OudvqbFBphaHSyigjpDCb49MpAtiJbt6hbL85pEzMjONdjt
         T1hg==
X-Forwarded-Encrypted: i=1; AJvYcCWxXjiScTngrMiBISDHwLWHp+3kn17mvz4O7NkXb9LTRxV67klY+E5DERAZgP/GjaXBJb8gBqo5JF4Rueg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyY9NJjPv6hBo8Zp7gw6dtF3cv6B9GCPn8Zfkiz3nhHC6e7OjJR
	gtN2u1YvsmtPfWSvLD0g6/0otEKuYWfdTE2tjG0KCg3w/tiR8x7i0+DT2qhr49c6
X-Gm-Gg: ASbGncsgBLcKp+o+/7fU+LScur2Bo/ZMnsQXfJUpJd8m8mYv5p4fzw83R2oMSTBNdju
	SgehHT46RkSevalrxIZrutET74J1uBBnJix79UkROK12wcYeeC5nfkYMl9wllSmrToyhLN6DzX5
	RPNpS0km/jDPa+9Dd+lSkDrkVlGp0xF6Rve4FsXVL24l5xWnHUz42LceQGOQ5A0ip60kHTGm1ES
	uRN1ygf7JtgB+70oAYhY08jnblvkSdHaPsisXmI6c2WOMFyNcOxm02huzpCkf0T8TkMA1pZHE4+
	n5o8jMcGn36WYsNb6zgwh5HA65YCLXF5pngbaseRkL5zBOzGGPnK+rpQNGcBuYMOVR50U+hJ5QV
	iWBZ9PiHQXqY85Q+lZsnSn9JL+wJX2Axplas7msjNSMmlIK42K0vJ6DpbNb6NUV3QGipPKFrdgw
	zPKpk=
X-Google-Smtp-Source: AGHT+IEQKlQbo2ZI1j743T3R5Q4ayO9ugHE3ZxK6b3q4Z+NgRpeqZwDwHWLVPuDsEP4HiizXh03ytg==
X-Received: by 2002:a05:620a:40d4:b0:828:6f7e:879 with SMTP id af79cd13be357-8311390bd2dmr476471585a.52.1758186935352;
        Thu, 18 Sep 2025 02:15:35 -0700 (PDT)
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com. [209.85.219.50])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-83633fcab48sm134210385a.65.2025.09.18.02.15.35
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Sep 2025 02:15:35 -0700 (PDT)
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-78e9f48da30so6049676d6.1
        for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 02:15:35 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUsBoCf5COYFBSQz4JoY7kTQ79iTyuvu9A4cAHILYanYkmJkAFH+QzYg+ToJ8uJ9bDQzuVklTHyyLjgOeE=@vger.kernel.org
X-Received: by 2002:a05:6102:6c7:b0:4fb:fc47:e8c2 with SMTP id
 ada2fe7eead31-56d5088a6e8mr1645890137.9.1758186565181; Thu, 18 Sep 2025
 02:09:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250912122444.3870284-1-claudiu.beznea.uj@bp.renesas.com> <20250912122444.3870284-5-claudiu.beznea.uj@bp.renesas.com>
In-Reply-To: <20250912122444.3870284-5-claudiu.beznea.uj@bp.renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 18 Sep 2025 11:09:14 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWP638eB_p9xMAqZmOnuc6n7=n31h6AqV+287uvqQEdww@mail.gmail.com>
X-Gm-Features: AS18NWCGAnZ0XCOYl-nrDkcvcpM1hNQPPeX1PmUWoRk02X3Ow_sZmQjL_oQhdiM
Message-ID: <CAMuHMdWP638eB_p9xMAqZmOnuc6n7=n31h6AqV+287uvqQEdww@mail.gmail.com>
Subject: Re: [PATCH v4 4/6] arm64: dts: renesas: rzg3s-smarc-som: Update
 dma-ranges for PCIe
To: Claudiu <claudiu.beznea@tuxon.dev>
Cc: bhelgaas@google.com, lpieralisi@kernel.org, kwilczynski@kernel.org, 
	mani@kernel.org, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	magnus.damm@gmail.com, p.zabel@pengutronix.de, linux-pci@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, 
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>, 
	Wolfram Sang <wsa+renesas@sang-engineering.com>
Content-Type: text/plain; charset="UTF-8"

Hi Claudiu,

On Fri, 12 Sept 2025 at 14:24, Claudiu <claudiu.beznea@tuxon.dev> wrote:
> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>
> The first 128MB of memory is reserved on this board for secure area.
> Secure area is a RAM region used by firmware. The rzg3s-smarc-som.dtsi
> memory node (memory@48000000) excludes the secure area.
> Update the PCIe dma-ranges property to reflect this.
>
> Tested-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

Thanks for your patch!

> --- a/arch/arm64/boot/dts/renesas/rzg3s-smarc-som.dtsi
> +++ b/arch/arm64/boot/dts/renesas/rzg3s-smarc-som.dtsi
> @@ -214,6 +214,16 @@ &sdhi2 {
>  };
>  #endif
>
> +&pcie {
> +       /* First 128MB is reserved for secure area. */

Do you really have to take that into account here?  I believe that
128 MiB region will never be used anyway, as it is excluded from the
memory map (see memory@48000000).

> +       dma-ranges = <0x42000000 0 0x48000000 0 0x48000000 0x0 0x38000000>;

Hence shouldn't you add

    dma-ranges = <0x42000000 0 0x48000000 0 0x48000000 0x0 0x38000000>;

to the pcie node in arch/arm64/boot/dts/renesas/r9a08g045s33.dtsi
instead, like is done for all other Renesas SoCs that have PCIe?

> +};
> +
> +&pcie_port0 {
> +       clocks = <&versa3 5>;
> +       clock-names = "ref";
> +};

This is not related.

> +
>  &pinctrl {
>  #if SW_CONFIG3 == SW_ON
>         eth0-phy-irq-hog {

Gr{oetje,eeting}s,

                        Geert


--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

