Return-Path: <linux-kernel+bounces-888034-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id CDA2EC39A13
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 09:47:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 78FF3350218
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 08:47:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38D743002C5;
	Thu,  6 Nov 2025 08:47:43 +0000 (UTC)
Received: from mail-ua1-f46.google.com (mail-ua1-f46.google.com [209.85.222.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DAF11C4A13
	for <linux-kernel@vger.kernel.org>; Thu,  6 Nov 2025 08:47:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762418862; cv=none; b=ZrhgmN1gAqJGsQYJnBWpLRanepYF65/B8IQDga5ie2tE/bWx2plB1id5mlqUBKexSxfw/0XAN1D3MkIh7PmIYehkCdYMmAlshVOMzAjBvtudwBlZtzDgBy8/GK74eH5/dAY5MyB5M4sz8MlUFoQRjaMo/09rA4kEFEgAq+jZzoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762418862; c=relaxed/simple;
	bh=r4WI112XNVPvAwbD+KTwJYuTD4uzGIUEVqXtqMZFfmI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=B4hZLR2+jrIUtjIM7jdp78Fhi3yPchhkU9VhQKjfIwClItqaOOFRABy4w79cFkwUyYH+stt74PCTgoD/7a6EsRHFjnjRGxy82KEpFSLEFUrWXCTTJeQan5AcTk01vEIace05ro3ut8C9urWKlURvgznbLPOH9MO+k95PjAtH6lU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f46.google.com with SMTP id a1e0cc1a2514c-932c2071cf5so1047352241.0
        for <linux-kernel@vger.kernel.org>; Thu, 06 Nov 2025 00:47:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762418860; x=1763023660;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zdhdbS5PtOsV4kjxfjLI8puwF2f4n5VCEZc3tH68S6k=;
        b=L8c65ZecAx7UdW+0k9xCBDmYUP+7ar7h/Gk0U9TtbbSKcO7/jR4Odycg0ddryyGyqO
         tviti7wrmEVxUUI8JlExbTnn8tD0zoOuJun99t2Fq7z4ny8TZMOPTmPY9QzaDT5rkx6B
         bM0EUrhtcETAPCApRHo0ZWtEdRlvb3hbchXYjYq65W1/IGo83vfOce/PZmdPaxDYS6u6
         L8ccLEbWcw8g1ACh+DzZcZpMUK8NP2hVKuqnQGWHLzPQBkZ3o9wdtjSNyAHumTaq2oLx
         LuST9j/gYWEn1ML17albVtLjwj8iommQOhWtmvSErTAGfdu+ofiM61cb6o7ZXbtJUXk5
         6Ocg==
X-Forwarded-Encrypted: i=1; AJvYcCVLxGeTI8TPtQ5eR5mp+mRN0Qq2uybZAWB23P4KrPF+2cButZVr9qJ+RYBcczvoRVeg6W/dltSuzlyyv4Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YybZ2Ny+84ygs/PON5qgbhJm5YrrqmX44qCmB87/58S70Ozy1iA
	3mKaKVdqAkCC88hJe0jfWyuxEgtCGAu8D41Ck6QJSvCEKvLv+zRHjgxu3ApWKzyN
X-Gm-Gg: ASbGncu8iwXHB/syZ8vNU7BS2MvdR/MaV30ZMlvhCqr5OzzC8ByJPb7WjqHcSEHFwXs
	I5dnZV7qOLXr5lQPL4CMm3XGchrXH/lWDYGjijKqvnfIPS/vE02KuOycokyXHO+LLlaWe7roxC/
	xorhGBiyHVBrtEdBsjzVhtrWRAFnjoTE3OsQxurba1hVFywm2o8j5R0KfcC6ipgJT3l48BbeRBo
	TRCOl3YBdqQ1uQSh6MDbZxgZ+1mFAH3yva7Q3UJSHakY3ClBPvGHEffYQSbFilVxBI7V+/NgNqP
	WGFBEs+zzO8pg9VXjxVpOmk/pQS+96mYui9GNkY+kSlIF1qvla/BnWXiGzGTKylf0CmCxyy336C
	jpST9yYCLHv97dMjjCEMa1YD4TLnXhCH8mYnRK0KDZpTlGGtrCiAf85DhDIDLQYOwYXAyZIHItV
	RTwmFmXOlpx7GW5LW4UyqHya8j0GyYqn9EpOOgGNzd5qTjbhRt
X-Google-Smtp-Source: AGHT+IHp3x4602h2wR8/OABsMkhyonQON+zJXPv183M3aQwuFEr+/Bfx/U+uP8iFQypng8/yWPBSlA==
X-Received: by 2002:a05:6102:944:b0:5a5:57f0:f426 with SMTP id ada2fe7eead31-5dd9fcb2d53mr836700137.5.1762418860030;
        Thu, 06 Nov 2025 00:47:40 -0800 (PST)
Received: from mail-vs1-f49.google.com (mail-vs1-f49.google.com. [209.85.217.49])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-937087f59f2sm788995241.1.2025.11.06.00.47.39
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Nov 2025 00:47:39 -0800 (PST)
Received: by mail-vs1-f49.google.com with SMTP id ada2fe7eead31-5dbd8bb36fcso612745137.1
        for <linux-kernel@vger.kernel.org>; Thu, 06 Nov 2025 00:47:39 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUkFK/EO4EkaP5pvE7ahUHHc4x56IL/ZzXUdUL9eCYVhtl1JUnm8cleBkC92DEreQfFiLKyZyzvmw/9Fb4=@vger.kernel.org
X-Received: by 2002:a05:6102:3053:b0:5db:e179:1c2f with SMTP id
 ada2fe7eead31-5dd9feef219mr849186137.18.1762418859485; Thu, 06 Nov 2025
 00:47:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251021080705.18116-1-ovidiu.panait.rb@renesas.com> <20251021080705.18116-3-ovidiu.panait.rb@renesas.com>
In-Reply-To: <20251021080705.18116-3-ovidiu.panait.rb@renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 6 Nov 2025 09:47:28 +0100
X-Gmail-Original-Message-ID: <CAMuHMdUR=_5Ex57gvgFXyxhSDkqdd0DjcTqV0m59tquxKzQnNg@mail.gmail.com>
X-Gm-Features: AWmQ_bkMn9K93ASfX-CEwYoeGvJMeNWd5c5VED4d6zuDLnmC2ge-cRo7TaazeRI
Message-ID: <CAMuHMdUR=_5Ex57gvgFXyxhSDkqdd0DjcTqV0m59tquxKzQnNg@mail.gmail.com>
Subject: Re: [PATCH v2 2/6] dt-bindings: rtc: renesas,rz-rtca3: Add RZ/V2H support
To: Ovidiu Panait <ovidiu.panait.rb@renesas.com>
Cc: claudiu.beznea.uj@bp.renesas.com, alexandre.belloni@bootlin.com, 
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	magnus.damm@gmail.com, mturquette@baylibre.com, sboyd@kernel.org, 
	p.zabel@pengutronix.de, linux-rtc@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Ovidiu,

Sorry, I still had outstanding review comments I hadn't sent yet, as
I hadn't finished my review yet.

On Tue, 21 Oct 2025 at 10:07, Ovidiu Panait
<ovidiu.panait.rb@renesas.com> wrote:
> The Renesas RZ/V2H RTC IP is based on the same RTCA3 IP as RZ/G3S
> (r9a08g045), with the following differences:
> - It lacks the time capture functionality
> - The maximum supported periodic interrupt frequency is 128Hz instead
>   of 256Hz
> - It requires two reset lines instead of one
>
> Add new compatible string "renesas,r9a09g057-rtca3" for RZ/V2H and update
> the binding accordingly:
> - Allow "resets" to contain one or two entries depending on the SoC.
> - Add "reset-names" property, but make it required only for RZ/V2H.
>
> Signed-off-by: Ovidiu Panait <ovidiu.panait.rb@renesas.com>
> ---
> v2 changes:
> - Added "reset-names" property and made it required for RZ/V2H.

Thanks for the update!

> --- a/Documentation/devicetree/bindings/rtc/renesas,rz-rtca3.yaml
> +++ b/Documentation/devicetree/bindings/rtc/renesas,rz-rtca3.yaml

> @@ -61,6 +63,39 @@ required:
>    - power-domains
>    - resets
>
> +allOf:
> +  - $ref: rtc.yaml#
> +
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const: renesas,r9a08g045-rtca3
> +    then:
> +      properties:
> +        resets:
> +          items:
> +            - description: VBATTB module reset
> +        reset-names:
> +          const: vbattb

Please add this property to the example at the bottom, too.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

