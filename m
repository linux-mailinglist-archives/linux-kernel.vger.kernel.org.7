Return-Path: <linux-kernel+bounces-855716-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 532E2BE2151
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 10:03:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3D9854F77DC
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 08:03:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5AFE2FF145;
	Thu, 16 Oct 2025 08:03:07 +0000 (UTC)
Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB4FF2641D8
	for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 08:03:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760601787; cv=none; b=GuV3q3wrEjMAS69opV8S3P5Sd9i9e2PEYm28hdSEU5Mqv45bITvjLSi3VbVxSifJEJw7rjidjeId7+IiRugtMaYvMwtnb+hUVpOb8H8BRlXIleAXjy5WvFko88LzYyZkVgd1zI4U3nClBrRCbYBAoJXrhNVaoq6DHbrJuc+9mUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760601787; c=relaxed/simple;
	bh=1eGQTAnWNGY3mGah0Neq02H/T5/f9gtIvSd+fn8FW2g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZoOJPNKcHP9g4Mix/fdn5xH5efs9sC5eTPTZbwDEIPsGzYybOolCEA46FE8avhUpqgZQWp0vgJTYe5QC2w4nKW/i/TAXBPKxahHFbmwB2QINnCmTHNt2eCe4mD/m4imeivSvtDZ+Uch1NkCRfkXgpzrozUiRrG6hu+QlRkdE8Lc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-88f8f346c2cso61991485a.0
        for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 01:03:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760601783; x=1761206583;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Kd9DhXGFTz7VluvF3CXaOYryMfT47ujx56ubcyYXsIw=;
        b=AlD5b6th9r9I8fAGYiaZzZRFfbUVHI+ttS3E+22T2auowwadLSJewwaJS/xU14L1bD
         ILQ2Qw6A4PAUcFjgJr0fim0GAIqXpZUb+NtFA5//yMMadpXexgCEoXOt3+BVz+diNdR6
         Y98oLc1KETE3ssjDYWxjOWVJpFh4VYH9Bu8CjHokpJajSACTZnW8UbusanKogo6gcTEP
         jfzBEKM/aZhtwwrKh51/8CILlDNlAO7OR5iwCNcFsNF1knD/NYkSOcctxAyhj6miv9nm
         qlnhKKmhzr2//jByaa3WgRL1k8IBiJQxk6RvOLhGHnFgUtWesLgd4qTHOtXwKeJ5QYAw
         NcBA==
X-Forwarded-Encrypted: i=1; AJvYcCVAJrfBzX1T3DpIsvWYZHxhrPddzC+bMEvVXulOIa6h9mS/6k/8xQYU1CVwTze0FQGarj67+SQ8Wvo5vBQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwwYYfb/+OuXdqcZwlyInkuoiXPDfl65Gp6TYRhBWhGLATbFRmS
	bh5mblFzpi2aucyBlR9gqVy4LUfMlmP+/yGUUmTTJhwS+m4qf9dpkALqWzpAmxmy
X-Gm-Gg: ASbGnctnyffN0NnMVoDcN9rWmhdJvaPq7mV17TeB2EXm3MtkwyXg/sGahOhszNW5H7/
	2gvgll5PYbEQwitqN62/jhHTEHu1hDC8MIADLqyddUBZDl31s5+HHu4jJKOXHRixsdwK4+TfwzB
	1Gf9HW6dAoUe2NwfIPEqE1t0fEyIQUpS2Td/VEiQlPtFwN6qeLaTgGmXpsQV4dxwFu+Cjuf45UE
	8uuiKSpXenFVdR2lJWJbvOly0SofWvQdIjlBPCdlNwX+PsMdkroJqOVi61y8Cr1iUGpHgmfee4a
	pe21tb0uPkw3cnUHmJsRLHm4bFNbdIO2qYlz3XqwbgcBWUAaQKalfc96tZ+leH6vnsv3SpwyydG
	M4fGqmzjX9d6b0Ctjdm2C9Q8h4bia27ZC/YFvyzn3iNjCAz6h9ikvnT+nB0R4q/GCtCmawkYl91
	hh8AkBfkNUrPqevn6qs6Zh99koeswZuODkuPnd+D9r1CrDsYcF
X-Google-Smtp-Source: AGHT+IFqUtjIbbls3V4G9feA0tuxXBTTD8c8pQe9lvqXuZBhKTHnjo+B6ZszotDo6m4Mii9Khufl8Q==
X-Received: by 2002:a05:620a:4091:b0:85e:f506:2f55 with SMTP id af79cd13be357-88352ab09a7mr3930792685a.69.1760601783438;
        Thu, 16 Oct 2025 01:03:03 -0700 (PDT)
Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com. [209.85.219.43])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-88f38bf32d8sm147700485a.61.2025.10.16.01.03.03
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Oct 2025 01:03:03 -0700 (PDT)
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-78e4056623fso6721096d6.2
        for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 01:03:03 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUYKoOiKMnlcFRBmXadBQVO3WiWHAtVHGYGc8bEXvZgR5hR+3WfuVIDC0X3OYFeT2bOjAuqmwCic92ek7s=@vger.kernel.org
X-Received: by 2002:a05:6102:512a:b0:519:534a:6c20 with SMTP id
 ada2fe7eead31-5d5e23afcd1mr10705349137.30.1760601430958; Thu, 16 Oct 2025
 00:57:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251015232015.846282-1-robh@kernel.org>
In-Reply-To: <20251015232015.846282-1-robh@kernel.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 16 Oct 2025 09:56:59 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVBDN8-gWVs1f=1E2NgD6Dp4=ZFUnyzqHaQj9JWPpZepw@mail.gmail.com>
X-Gm-Features: AS18NWDjBoTWi0arzS-uHQaIyzTZ8PYUb4ECqZaEUF0sSO-4JEe-m7M7qjhxsvY
Message-ID: <CAMuHMdVBDN8-gWVs1f=1E2NgD6Dp4=ZFUnyzqHaQj9JWPpZepw@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: Fix inconsistent quoting
To: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Stephen Boyd <sboyd@kernel.org>, Thierry Reding <thierry.reding@gmail.com>, 
	Linus Walleij <linus.walleij@linaro.org>, Bartosz Golaszewski <brgl@bgdev.pl>, 
	Shawn Guo <shawnguo@kernel.org>, Fabio Estevam <festevam@gmail.com>, 
	=?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, 
	Jonathan Cameron <jic23@kernel.org>, Andy Shevchenko <andy@kernel.org>, 
	Jassi Brar <jassisinghbrar@gmail.com>, Mauro Carvalho Chehab <mchehab@kernel.org>, 
	Lee Jones <lee@kernel.org>, Joel Stanley <joel@jms.id.au>, 
	Andrew Jeffery <andrew@codeconstruct.com.au>, Andrew Lunn <andrew@lunn.ch>, 
	Vladimir Oltean <olteanv@gmail.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Daire McNamara <daire.mcnamara@microchip.com>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	=?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Manivannan Sadhasivam <mani@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, Vinod Koul <vkoul@kernel.org>, 
	Kishon Vijay Abraham I <kishon@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
	Geert Uytterhoeven <geert+renesas@glider.be>, Nicolas Ferre <nicolas.ferre@microchip.com>, 
	Alexandre Belloni <alexandre.belloni@bootlin.com>, Claudiu Beznea <claudiu.beznea@tuxon.dev>, 
	Florian Fainelli <f.fainelli@gmail.com>, Tony Lindgren <tony@atomide.com>, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org, 
	linux-gpio@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-iio@vger.kernel.org, linux-media@vger.kernel.org, 
	netdev@vger.kernel.org, linux-pci@vger.kernel.org, 
	linux-phy@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"

Hi Rob,

On Thu, 16 Oct 2025 at 01:20, Rob Herring (Arm) <robh@kernel.org> wrote:
> yamllint has gained a new check which checks for inconsistent quoting
> (mixed " and ' quotes within a file). Fix all the cases yamllint found
> so we can enable the check (once the check is in a release). Use
> whichever quoting is dominate in the file.
>
> Signed-off-by: Rob Herring (Arm) <robh@kernel.org>

Thanks for your patch!

Since you are mentioning mixed quotes, is one or the other preferred?
Shouldn't we try to be consistent across all files?

> --- a/Documentation/devicetree/bindings/pinctrl/renesas,pfc.yaml
> +++ b/Documentation/devicetree/bindings/pinctrl/renesas,pfc.yaml
> @@ -129,7 +129,7 @@ additionalProperties:
>
>      - type: object
>        additionalProperties:
> -        $ref: "#/additionalProperties/anyOf/0"
> +        $ref: '#/additionalProperties/anyOf/0'
>
>  examples:
>    - |
> @@ -190,7 +190,7 @@ examples:
>
>              sdhi0_pins: sd0 {
>                      groups = "sdhi0_data4", "sdhi0_ctrl";
> -                    function = "sdhi0";
> +                    function = "sdhi0';

Huh?

>                      power-source = <3300>;
>              };
>      };

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

