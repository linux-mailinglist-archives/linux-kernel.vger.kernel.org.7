Return-Path: <linux-kernel+bounces-862627-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CB9EBF5C8A
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 12:31:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1AA734E693F
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 10:31:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7DF5230BEC;
	Tue, 21 Oct 2025 10:31:38 +0000 (UTC)
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9468B354AEF
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 10:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761042698; cv=none; b=FET/Pus5T24i7CuyFHW+b9h/OBXeEtA+nP/r+iBlTh8HHroDCeRFidISkpuOUVhbnthmz0qjLkGdY/bxIRZY55LmeJZ5QsG2WbX0yKqrLT1dS0/tadO7f4kqFEun1Z5nzDbr5twICZVj4ArIdVDlznc89dGEPo+JbSLXgNFjhQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761042698; c=relaxed/simple;
	bh=va4WxH64kPG8XCl6w3KCXlFAiPzGBJtiTtCajxRETjY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HUYZMRFYFIXjueJvr7mV/EZaMJr0/HzPHkTagmIcMMwBCfbjBsKA8YvgLLVcB768AECrrKrBim+/ICOB7iUHJm104AOm46BJFT2NSv8p4cJsaZ6Rd6UFn9c0hbIuRATchPR/JlulF2rfbObaFChIhOSyXlvO/27JV7c8xNrbDrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-891667bcd82so662430885a.1
        for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 03:31:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761042695; x=1761647495;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tDNH9pDF9LBAisWYpnrCUtwA+9hrIVu2UeAytlJC/r0=;
        b=M8HfohBB4CZkTFvsq0Qg9EfGC37+T4WbsPcHeI14QW+28mtaa+HI01nmdq31PfzJqU
         Mnspe1kMdIkxYYq05xZV4feZfFBquIbc1djD7RyhhdEyZk5RHq08B8+/Gu/VqS84x0La
         bit3hUjeJyaEgiuc72BTZcAPvchYIgTA7RS9EHUSHnsNk0fRVWchSDUAjhUiUs2Jg9Om
         w2kYtHinvjbd7nXV5q+66+28XCsAK39kV01xzGj4vQjVRRjh5sdxTjfyIl3ep5tEcLvw
         pOU5vumNJa376aTaafel0AkOuh7Zd15NLpMyVtmt/j/E/u5GZF44386bGwAH5vukWzGu
         nsSw==
X-Forwarded-Encrypted: i=1; AJvYcCV4jNRu26lXIQDU16dkfMziHpdljNDzvgOvulhns51pkRmWw6gKyIgpU8xO1a4lV6AOs8pTHidlnxc3pF4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/aQ8dGdwweDLWu9gz5NgdSzlIKUGST705zS86UJMM2AMzBfa+
	AGap/tie3pCa59VZuA3a/A6Apk6948Oco6fLAj2Ro8kTjjzqDUPBnebZg4TZgTUR
X-Gm-Gg: ASbGncvLxzoIFpZEEHjL278ZL3ejS/kYw3GWvAVwNs+GmRIg/rdtSZNA+dGiuHzb5MY
	RZpWqK7QtPYRda0Mxo/HpVdLmOe0zfkdF7kb9Iy0kIsRLkrlqMLvuTz0J/T3qYV1YQd2KtRsh14
	YgpjGvu+yncRPGYPiHjHR3pzoERoNZ8389YlbHOI8FDbj4eHm9mxcve/uPef7gNz56YpoW1JeQa
	TXYsImDdRb93hUsAnfSoK0bGjUQ4GlvJsZAJ51kXxWg8QXeIK8peJE/lq1g6kjciepM7Pk5gcAw
	Rt07Xr4NL1fxIeZzasj4/oNaydr634z5cBE2efj8IYAiQ4zLBgeNw8DnGYvKDHLln1lWTXruW0p
	/8y3QwaLmnVuOKjwwoXuDBreQB4x1q6EEvXklHsgSP5MHxVsfaJ66hWmfHtYI0QgM1evQjyepQf
	xkB9z3sWy2xpo9bezArRYMfK0sR6VshiCPGgcF1qk1rLy0PAChtJF6
X-Google-Smtp-Source: AGHT+IHQZt/kqSsKx6hmWxQdAZCL0XWvq3AntG18JpqzFLTWMHOe8XwX7ZoiJwzuSbq7nK8LjedrMA==
X-Received: by 2002:a05:620a:2950:b0:88f:5740:b46a with SMTP id af79cd13be357-890542f7855mr2050210485a.16.1761042695203;
        Tue, 21 Oct 2025 03:31:35 -0700 (PDT)
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com. [209.85.222.171])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-891cd09870csm736868385a.16.2025.10.21.03.31.35
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Oct 2025 03:31:35 -0700 (PDT)
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-891667bcd82so662429285a.1
        for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 03:31:35 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXn1LtRTr8Pag9UaFd0bXU/nxPGE2IVKo5Og6NkUpCWQhk9iO0jYAGzRxKifD1eRnvTd0nRmr4pAxAcg/A=@vger.kernel.org
X-Received: by 2002:a05:6102:e08:b0:529:7c2f:ceb5 with SMTP id
 ada2fe7eead31-5d7dd5035afmr5261434137.1.1761042379969; Tue, 21 Oct 2025
 03:26:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251015192611.241920-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20251015192611.241920-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 21 Oct 2025 12:26:08 +0200
X-Gmail-Original-Message-ID: <CAMuHMdW1B7Yk1hUU9MSJsiL8wSmjAUGN7Qd_wgBHv8Ct=-wi4Q@mail.gmail.com>
X-Gm-Features: AS18NWA5TDVRnTdlKeYEusciZZnf69CtVCQ6CEB6928Ztx_Tex5oqUI1hZkbQkE
Message-ID: <CAMuHMdW1B7Yk1hUU9MSJsiL8wSmjAUGN7Qd_wgBHv8Ct=-wi4Q@mail.gmail.com>
Subject: Re: [PATCH v11 0/7] Add support for DU/DSI clocks and DSI driver
 support for the Renesas RZ/V2H(P) SoC
To: Prabhakar <prabhakar.csengg@gmail.com>
Cc: Andrzej Hajda <andrzej.hajda@intel.com>, Neil Armstrong <neil.armstrong@linaro.org>, 
	Robert Foss <rfoss@kernel.org>, Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
	Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, 
	Biju Das <biju.das.jz@bp.renesas.com>, Magnus Damm <magnus.damm@gmail.com>, 
	dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org, 
	linux-clk@vger.kernel.org, Fabrizio Castro <fabrizio.castro.jz@renesas.com>, 
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>, 
	Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Content-Type: text/plain; charset="UTF-8"

Hi Prabhakar et al,

On Wed, 15 Oct 2025 at 21:26, Prabhakar <prabhakar.csengg@gmail.com> wrote:
> This patch series adds DU/DSI clocks and provides support for the
> MIPI DSI interface on the RZ/V2H(P) SoC.
>
> v10->v11:
> - Split CPG_PLL_CLK1_K/M/PDIV macro change into separate patch
> - Updated rzv2h_cpg_plldsi_div_determine_rate()
>   while iterating over the divider table
> - Added Acked-by tag from Tomi for patch 2/7 and 3/7
> - Added Reviewed-by tag from Geert for patch 2/7 and 3/7

I think this series is ready for merging.

> Lad Prabhakar (7):
>   clk: renesas: rzv2h-cpg: Add instance field to struct pll
>   clk: renesas: rzv2h-cpg: Use GENMASK for PLL fields
>   clk: renesas: rzv2h-cpg: Add support for DSI clocks
>   clk: renesas: r9a09g057: Add clock and reset entries for DSI and LCDC
>   dt-bindings: display: bridge: renesas,dsi: Document RZ/V2H(P) and
>     RZ/V2N
>   drm: renesas: rz-du: mipi_dsi: Add LPCLK clock support
>   drm: renesas: rz-du: mipi_dsi: Add support for RZ/V2H(P) SoC

As this touches both clk and drm, let's discuss the merge strategy.
My proposal:
  1. I queue patches 1-3 in an immutable branch with a signed tag,
     to be used as a base for the remaining patches,
  2. I queue patch 4 on top of 1 in renesas-clk for v6.19,
  3. The DRM people queue patches 5-7 on top of 1.

Does that sound fine for you?
Thanks!

Gr{oetje,eeting}s,

                        Geert


--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

