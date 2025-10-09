Return-Path: <linux-kernel+bounces-846899-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 01955BC95ED
	for <lists+linux-kernel@lfdr.de>; Thu, 09 Oct 2025 15:49:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 56DEF4EEF56
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 13:49:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B73F2AD0D;
	Thu,  9 Oct 2025 13:49:18 +0000 (UTC)
Received: from mail-vk1-f175.google.com (mail-vk1-f175.google.com [209.85.221.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D22892E8B6C
	for <linux-kernel@vger.kernel.org>; Thu,  9 Oct 2025 13:49:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760017758; cv=none; b=rybOgbr98ZGkQ1KjW8+nXCNyH2NWz1uWmca2osXXK3JxEYzpkA0RwGTLh88kxK8txtQut7faNlFonuahi3l03UAFZO3GKSUZjyVAh43CMAvkeOqc3y/43CW+TfPUsyeKxsE/2UDP8NTDXexHrdYBdpVLZT9Z134qzLGJ+AkZCvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760017758; c=relaxed/simple;
	bh=yimaDht2VPmckuijnK7RHpnVJdwPGNmnTY4r/gDwrBM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pQ2q6KWi02oa8w07UvFDkPMIXAcrkDwbDSVCRIp0FtnpRntANcYLNBRRFrGas8t8YVEbGCtCIEEgt8D97eDkxT6QWujylpxAOSQWbZSZnXRqDklbjLEx5Bg3y6Hn7TSjAZ780dnoB2zyUSzAyj/vTP5lnCBGcQyL1YVZoHbTqEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f175.google.com with SMTP id 71dfb90a1353d-54bbc2a8586so292300e0c.2
        for <linux-kernel@vger.kernel.org>; Thu, 09 Oct 2025 06:49:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760017755; x=1760622555;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rG+VBn74V/FeJGvzOBH4i7MNFu3atTCKtUYOgAi8OVI=;
        b=DVn7O1oznSbccqPACEfbnV16xqC13rCx5FACZQas6g+aefEOjDh/TxhtXZuuWj1RBs
         EgR7HVL7u17/FMEM23hfO3YirR8zTPSchMQ1DGVomKWcBYA08GelPedvgTL9bmnbi/N0
         ajaggkWOqIXqgNpy6HvuobyJlu7fv6fFalkFG++68kHTYOATEKw51IYll0gpLqrrI6bC
         E8Oi6MsUX88gpzDUwwz4qsVXKT6TeHHWAmNEn5hRxuGYGG3DKpMlmHZalU+wP/B7w/sV
         yI6/BblGe+g/0/DHFheaCIFKOBH5UQ9GBtGK183iI1cOXYs9unfRmib8X23sETa6eZrN
         LDyw==
X-Forwarded-Encrypted: i=1; AJvYcCW/lJJzJNyFvvtuuPne+coqfo5tKv+PgNE5Wz4aMu3DgAybo5EBt8M8IyAsqqTRytHDAnNOAluZYt+IzSw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzIRs2jykxFw5lv/Nsc/K/VVk36oJB0QaFYxltrDlcH+Tjj8H7w
	WpVQjMdr9R32Hl2ZU6o1chUwxntlVOe0QO4H3GBCEFWaGVULnMMhrEkiBoYfCrcN
X-Gm-Gg: ASbGncsDq+aZz7wepLj6nDILC2oAluY2tmu09zc98MokdX18w4GzUq45zdsOFh6tLg4
	Akd4DP9l2T0Zat/HqIKyoQBVQQU08Yr738tGIeBjWpSkG/ckzJbYnvQSNxMdRAT10ZwM5UiMJV3
	2WUKu0IGxokgN5wXAgBJ7ys79oaT4M+yuZX71VkRcmuFzT7ukXPeVPBXTdgdsaYRojGABAKSTAS
	/oCNWFLHwHKbYF4UtsFP8EKrIgROHojJRmtKAbnoRjVWlhRvKlRDEMa1gACLMFebt06bZP83o/m
	kON/CvKw/apj2yR1lGY7wozKX1zpgMP3yVuf9ull5GQGYUOONUiXZQ5+A4pws7CnPkzxoTimWpF
	i5aIbuwffqVCzhfhkTybMsjblRfmPfNvfC9ihU6I/TOSpJB891g4xQElb4x0op1vHDbUoLpTvLb
	vi180TZeGdN5trewP8plc=
X-Google-Smtp-Source: AGHT+IFwQ6YQcksFx4qktCaEqqz9AZwij1PYUtGoxMEFUC5Ek14nLPDGedI6pgBPC6pTQgdc2qrymw==
X-Received: by 2002:a05:6122:251d:b0:54a:92f1:f9e4 with SMTP id 71dfb90a1353d-554b8b9132amr2912249e0c.9.1760017755360;
        Thu, 09 Oct 2025 06:49:15 -0700 (PDT)
Received: from mail-vs1-f52.google.com (mail-vs1-f52.google.com. [209.85.217.52])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-554d17c4c1fsm222799e0c.3.2025.10.09.06.49.14
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Oct 2025 06:49:14 -0700 (PDT)
Received: by mail-vs1-f52.google.com with SMTP id ada2fe7eead31-5ccccc1f7caso478874137.1
        for <linux-kernel@vger.kernel.org>; Thu, 09 Oct 2025 06:49:14 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUcoG15ehEyAktBKjanK/zmjgiMeGLKbE5rYB6s50aAavRQWtckHnyS1/axlOmJA47cSMoUs68+FaU9fSg=@vger.kernel.org
X-Received: by 2002:a05:6102:b0f:b0:520:a44f:3ddf with SMTP id
 ada2fe7eead31-5d5e224f3f9mr2430732137.10.1760017754092; Thu, 09 Oct 2025
 06:49:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251001212709.579080-1-tommaso.merciai.xr@bp.renesas.com> <20251001212709.579080-10-tommaso.merciai.xr@bp.renesas.com>
In-Reply-To: <20251001212709.579080-10-tommaso.merciai.xr@bp.renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 9 Oct 2025 15:49:02 +0200
X-Gmail-Original-Message-ID: <CAMuHMdV0k0k4EQhQ9C_oPUPno7BsgN3tW3ydLrvzD783SgULyw@mail.gmail.com>
X-Gm-Features: AS18NWBiuLuEjgmzyDSlSzZ5zrYLpzbrdlxBs-yvgfRSKSU9hkobcBub0EljavI
Message-ID: <CAMuHMdV0k0k4EQhQ9C_oPUPno7BsgN3tW3ydLrvzD783SgULyw@mail.gmail.com>
Subject: Re: [PATCH 09/18] clk: renesas: r9a09g047: Add clock and reset
 entries for USB2
To: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
Cc: tomm.merciai@gmail.com, linux-renesas-soc@vger.kernel.org, 
	biju.das.jz@bp.renesas.com, Michael Turquette <mturquette@baylibre.com>, 
	Stephen Boyd <sboyd@kernel.org>, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, 
	Vinod Koul <vkoul@kernel.org>, Kishon Vijay Abraham I <kishon@kernel.org>, 
	Magnus Damm <magnus.damm@gmail.com>, linux-clk@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 1 Oct 2025 at 23:28, Tommaso Merciai
<tommaso.merciai.xr@bp.renesas.com> wrote:
> Add clock and reset entries for USB2.
>
> Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>

I couldn't verify all details, due to the lack of the Additional Manual,
but the rest LGTM, so
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
i.e. will queue in renesas-clk for v6.19.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

