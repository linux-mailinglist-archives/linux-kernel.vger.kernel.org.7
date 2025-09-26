Return-Path: <linux-kernel+bounces-833861-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C5CBBA33D1
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 11:51:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 089043B0F2E
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 09:51:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18C7329C343;
	Fri, 26 Sep 2025 09:51:12 +0000 (UTC)
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7F7C265623
	for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 09:51:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758880271; cv=none; b=kNPO58tnT2IDDH+C7OB41U3D+liRSuPFBL/vafVQt1yFJB2fN0MNqolhCUrULEj57JDtUpRn4gcR1eqVZaJrSngFQwYEI1WnS/alBfO7CCrGITve63m6Lgyn3ATMEIGwlJMbBsJDk/UwfUoGnQFpFyu2IbwlccVRi+HPFw6DHRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758880271; c=relaxed/simple;
	bh=yNpF3gakBewbf4gWfzySUblL/HPEFTHdWDap5s8c2rw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XD43LYis4LjJ+jWOKo1pBvCr06zGxFkNhJUwOEkAVcd+GUpKGSGmvRvPalfVimMt4bdbIqTLXc50Sg4DfoyP9XFMpr3mRhIMEmwegr4uDnG3r0iCHp1FgGy+Jw4wglxrKQtxbn73sTVCJ1dwN3LqfjRpZrENmNneLxjCBzKu0ZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-816ac9f9507so296666585a.1
        for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 02:51:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758880268; x=1759485068;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Wz1Y2OO7aX1FKDkec9bCJzTd14gDBikA8iaq+l9tIyk=;
        b=GUFTl+ctNQjwUEuI6RXVKIeHvXf0d23QzhVCYLC+vDJeeOWSO3rnRW5u7a5IBkRWWh
         NV8JTTlzEDtCLGW7mbrtTlepieQ5cY/FrlwsbX6rruZQWHYjGyQJmCNz1g6vVjht4ai9
         xdUuC3hwU98dWVrW2FJErQ9xSmWpQNtW6dwvEgpysnObhsbJnEAQcwW6q1D8xfAYBJgb
         lTDBUIpWPSZzfo2E5EOCHWl1WMwZSXZmaXtkutuGj6vdHun4t9dCRsiou8u16KIG8V7K
         joNgAuPZTXkSZ8REPFJVYFuvdG/MTeo6t6JHMqXCKo57J9rCjqlQutcCzMfNml8l3ToJ
         +bpA==
X-Forwarded-Encrypted: i=1; AJvYcCX6hRSFVUCO8hkGPJr0rP/3PljLRGHXtMQLiGjc8998GDmpguq9TaioM+YilsKApG4BmHsRxzX2uHX/hpg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzRf/u2lCYTzMTwqYTePDd58o4+rz8mem/q8LgwPwKIR3ZlOqFh
	ZoS1egmjkkxVhwZ5cZ6fH5tqfzAG1DYM0ZHQcdjOjn3haHdxVWqjGNKv+GO7G3iT
X-Gm-Gg: ASbGncsF4v0J2PzBvcBWRgbZKFG79Od5eUrQEP8425/Jvf90/oTonK4uEh0IOtGSQ10
	e5pooMEiSLFLBU2ApaOEGdf4r8og5gJtRK+xm5vhB3WWJkM0/5AJvSvK7cR8HN9IhLgfpOs9clQ
	VdxzumPiQwuK0LsDx2M3pMad/bAUU+ihb4ZcLCZpVSuKoPVuVn+E+BceMdoKcK116U05dxLTL0w
	trly8fhh2VU95mK9YChXSB0I4ceTh/ASRXL8JARf3nsjpkif864XN3WWvfqpNm1UDQLo7axEkB8
	eaQfRRkikSddyvGUsXngt0wfnlv2tB/34O9GT/5Nolq1xYsffN8hNNSpkVIOmZlJtxPsJFJ9VQV
	5HtYCQInaYPBkK6GPCuCo96+QgEAfSmnv91Mh8sslK6kzms6jBNnNFA9mvUQXEGkuFuORuy/hNg
	Y=
X-Google-Smtp-Source: AGHT+IHLkZrYvTlqEDnwIuIeq5NCtHrb6PGWNoFFmLtmN08+2rptwlvQz6dLMoZlEdEtk9NAKCY63g==
X-Received: by 2002:ad4:5cad:0:b0:787:f736:bc66 with SMTP id 6a1803df08f44-800dd11da10mr71364666d6.1.1758880268400;
        Fri, 26 Sep 2025 02:51:08 -0700 (PDT)
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com. [209.85.222.171])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-80135b5579fsm24087226d6.1.2025.09.26.02.51.08
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Sep 2025 02:51:08 -0700 (PDT)
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-8571a0947d1so204024885a.0
        for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 02:51:08 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUnNyJC+9Np1hoFUUESu1XsUQhjwUz9FvlhUBAejs3K2Ioi1Qzkjuyu/Yp2ZnXd48OVeb04K45SO5iPIVY=@vger.kernel.org
X-Received: by 2002:a05:6102:1452:20b0:58f:1e8b:a1c1 with SMTP id
 ada2fe7eead31-5ae14991836mr1929645137.2.1758879937242; Fri, 26 Sep 2025
 02:45:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250912122444.3870284-1-claudiu.beznea.uj@bp.renesas.com> <20250912122444.3870284-4-claudiu.beznea.uj@bp.renesas.com>
In-Reply-To: <20250912122444.3870284-4-claudiu.beznea.uj@bp.renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 26 Sep 2025 11:45:25 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWmjj_bKhGqhWcRvWap1U5izT347Ffo5wqs6OP9BvO8PA@mail.gmail.com>
X-Gm-Features: AS18NWDiRHr7QXCMqaoImEEYFri-rFsQBU5GFbqAD2ZmUrWNkjrXvGfEFMFxCMM
Message-ID: <CAMuHMdWmjj_bKhGqhWcRvWap1U5izT347Ffo5wqs6OP9BvO8PA@mail.gmail.com>
Subject: Re: [PATCH v4 3/6] arm64: dts: renesas: r9a08g045: Add PCIe node
To: Claudiu <claudiu.beznea@tuxon.dev>
Cc: bhelgaas@google.com, lpieralisi@kernel.org, kwilczynski@kernel.org, 
	mani@kernel.org, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	magnus.damm@gmail.com, p.zabel@pengutronix.de, linux-pci@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, 
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>, 
	Wolfram Sang <wsa+renesas@sang-engineering.com>
Content-Type: text/plain; charset="UTF-8"

Hi Clausiu,

On Fri, 12 Sept 2025 at 14:24, Claudiu <claudiu.beznea@tuxon.dev> wrote:
> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>
> The RZ/G3S SoC has a variant (R9A08G045S33) which supports PCIe. Add the
> PCIe node.
>
> Tested-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> ---
>
> Changes in v4:
> - moved the node to r9a08g045.dtsi
> - dropped the "s33" from the compatible string
> - added port node
> - re-ordered properties to have them grouped together

Thanks for the update!

> --- a/arch/arm64/boot/dts/renesas/r9a08g045.dtsi
> +++ b/arch/arm64/boot/dts/renesas/r9a08g045.dtsi
> @@ -717,6 +717,72 @@ eth1: ethernet@11c40000 {
>                         status = "disabled";
>                 };
>
> +               pcie: pcie@11e40000 {
> +                       compatible = "renesas,r9a08g045-pcie";
> +                       reg = <0 0x11e40000 0 0x10000>;
> +                       ranges = <0x02000000 0 0x30000000 0 0x30000000 0 0x8000000>;
> +                       /* Map all possible DRAM ranges (4 GB). */
> +                       dma-ranges = <0x42000000 0 0x40000000 0 0x40000000 0x1 0x0>;

I would write the last part as "1 0x00000000", for consistency with
other 36-bit addresses and lengths.

The rest LGTM, so
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

