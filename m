Return-Path: <linux-kernel+bounces-893429-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A18AFC475E8
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 15:55:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 1E41D34A129
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 14:55:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48D3A314B73;
	Mon, 10 Nov 2025 14:55:01 +0000 (UTC)
Received: from mail-vk1-f169.google.com (mail-vk1-f169.google.com [209.85.221.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D58F3101C9
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 14:54:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762786500; cv=none; b=AydwMpUxS63J+JhgplojhUqO6m5GI7x+ecfxeb2MQQLJG0dxxSFiwsyAzf4OCokGRBwIz6jgQwKe8VSXtq03LfuUdHqw0JQNRkQyU/ljj6spa2k2XQIpG10EMLsSxXy991RU54kt0Rrp+4STCOnGuhNO39uEp6We0vL8ErUq0fI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762786500; c=relaxed/simple;
	bh=vQ3cBdkCV5UnRvyJ+BfFBgghw/urt+jHpSl4y5jlUOc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LZATD0OvfKu3tTT2B1bQGowJhiR1Xrl5udr8k9Xw9u+Y0KPOk6/dq9stD60pngRupIjBsToULHjlBVtpjfZ/Lz5TFZedCuwukdROtnuekkXRbVyKXL0JgOsCAuMnTX2cpfq5+O1RK5pZs9170XLz3WPfJ4KvqJCOgMQ7kdj6No0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f169.google.com with SMTP id 71dfb90a1353d-5597330a34fso2217055e0c.2
        for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 06:54:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762786498; x=1763391298;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oz17y11bQKxObZgoQnh0w/nJtN9nCnBNZyOA3HIKdo4=;
        b=lBw5+zpxgLlV2JI+gxRujMV008wLSwRYJ0wTJtbYJbexXHGevOZpLOFCuw3Lc41i9J
         WQEOkRpMNgt9sAIhW2SmJc+3aZYmBjwxOse44gOk1cPNcNN85AA8CizOkH3RGk8dIZbe
         lbWDE0XNiM4VPDy3NGr5uPRlBVREujuv6+xsf4W6cTuEE5V6DT3oOn5t268C3fvcmeQQ
         f8eBQx4qyYpN7f3H/y+FGaU64EFdmRrTtussjiYa+OpRBudfNwgdF+6bsevElT7rNBM4
         OXtNnyb/ji01/VOPy1ap3GHAAngE9YJmr92/aSf8+oNRoYwL1vhSBlvFp6amG8O/pFh+
         WayQ==
X-Forwarded-Encrypted: i=1; AJvYcCVH4KL2EK35H4rE0K3l/N9lWvwiksPTla2Ql80vXDPsrilgVWbeynfLfpk20DXSOufryES93lfrcPKm7cU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQuW8ivcu33Fr6YQmnTkty2Y3bxPMv4t/QgZd4pyHu6nCtryEJ
	mWjEbyokrOVxUP6lPAO7GDYoN/TWM4yfaGmGZfrvtQouxM8D+TteF4RZVpyuM+xl
X-Gm-Gg: ASbGnctMvHgDU5G0BP6ABP41lE6W1dXnH9VcQ+BZvfn+SX3gyqomD3QU6hx6K9SQBO2
	CglQk70ha2qaW0P3V0IfGEX49r9+Qn/quqaHRkN9eIUm6C9e/b+6a4saSGoYTG8tAjBpbR1bh3O
	z7Np7qUdHU1xFRdhyKTkFdrlzUK/3Um7qdAFdRoF3OWTQVQJBbpAMoU8Ua5YT7mrgtKLJZ5aVsA
	HaGZFgCZRG20CEA9USLnUq8tiDuz/xejiGQQ//Aa5+jRqqTSH9baVyiEqTW17ur4GUhiDSp2ptL
	gbQoum3UqDkhAqEGMoTd7xZmWE/OoYfJUm9xiuLQCGl8PlRlUfLbZwq2Qnfs+QN7Rt0MQ/+pt5l
	kN7fk4qecur5HV5QA8vx2XbDLAlX6KNmlRh3U3/TkDfqyDa1GUmjjYDUyznV3P+y6lFKUVpbNPQ
	rojD9OGJyXr5T0y1+5MZO0O38tSLqqDwUY1xwFG2wr0Djx74r/k5MT
X-Google-Smtp-Source: AGHT+IGyrHzA3hOlBjekceqtnfC1U81PjJkCcN7m8tEzUxYe3C+cbtMrRkmZJ4RmDXB3rRSn2/OTFQ==
X-Received: by 2002:a05:6122:d96:b0:559:77c0:d46f with SMTP id 71dfb90a1353d-559b314c2aemr2923003e0c.0.1762786497768;
        Mon, 10 Nov 2025 06:54:57 -0800 (PST)
Received: from mail-vk1-f169.google.com (mail-vk1-f169.google.com. [209.85.221.169])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5599569b0cesm7753006e0c.8.2025.11.10.06.54.55
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Nov 2025 06:54:56 -0800 (PST)
Received: by mail-vk1-f169.google.com with SMTP id 71dfb90a1353d-559748bcf99so2902021e0c.3
        for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 06:54:55 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWtvaf+N7jTkxdFu4fBRxfFxPgoYvdVHU9jlmy7nzHxw/aYWp/WLP72mDd+nBkrvWN6ldaZaIRKBUINW8M=@vger.kernel.org
X-Received: by 2002:a05:6102:c54:b0:5db:c9cd:673d with SMTP id
 ada2fe7eead31-5ddc4751f8bmr2690307137.26.1762786495201; Mon, 10 Nov 2025
 06:54:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251028175458.1037397-1-prabhakar.mahadev-lad.rj@bp.renesas.com> <20251028175458.1037397-5-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20251028175458.1037397-5-prabhakar.mahadev-lad.rj@bp.renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 10 Nov 2025 15:54:44 +0100
X-Gmail-Original-Message-ID: <CAMuHMdVwJ4VYeiBeNvmk2sD_dn3L5ofZAos7sVFL7_OiEZDTGw@mail.gmail.com>
X-Gm-Features: AWmQ_bnBtlYoemCwnENT_ZEy-kRSg4EiufR8QdhrtXxJ183JUY_R7_bVGhsumwI
Message-ID: <CAMuHMdVwJ4VYeiBeNvmk2sD_dn3L5ofZAos7sVFL7_OiEZDTGw@mail.gmail.com>
Subject: Re: [PATCH v2 4/5] arm64: dts: renesas: r9a09g087: Add GMAC nodes
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
> Add Ethernet MAC (GMAC) device nodes to the RZ/N2H (R9A09G087) SoC DTSI.
> The RZ/T2H integrates three GMAC interfaces based on the Synopsys

RZ/N2H

> DesignWare MAC (version 5.20).
>
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

> --- a/arch/arm64/boot/dts/renesas/r9a09g087.dtsi
> +++ b/arch/arm64/boot/dts/renesas/r9a09g087.dtsi

> @@ -495,6 +936,13 @@ sdhi1_vqmmc: vqmmc-regulator {
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

