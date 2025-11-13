Return-Path: <linux-kernel+bounces-899575-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id CC071C58653
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 16:31:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id CFA3C4EEB80
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 15:20:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F45C2F0C71;
	Thu, 13 Nov 2025 15:05:33 +0000 (UTC)
Received: from mail-vs1-f47.google.com (mail-vs1-f47.google.com [209.85.217.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44F912F0C63
	for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 15:05:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763046332; cv=none; b=bo33bsb/fbBZ5aIPnyoRMcXMQH0eIsd+FeJPSSoPqTWMFu1RkAmDIpNlkD2zkgfQ6gZgTiSuPiWunfVX+E6+hKqM4h1Pe3+VVYkHIeUvmc6Df71X8bBYWNlu67hymilcJdNyCLEazONrlGXQO0uPWxTn6qqLOa/5VKwZkEIq1kA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763046332; c=relaxed/simple;
	bh=OulVxmqHukNU8jDi3wbWx/yy4OfpnoJmnUbmnzZwvDg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DI7MjGV92NtbUuJsBJeDL5vm0P7w6aLm6U7khP1LDuFCIwKms6WvUAeTLvwqYB1UalHhzUX/hMyDDM54yZhuy1BpC21coil8kQ6LYIOUxabgTOwpsNYwXT5rDZTjqycUn5yaO9WxlFq6bHk9rfbOu+7+TphYhAaG/mvy2W8hmBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.217.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f47.google.com with SMTP id ada2fe7eead31-5dfc2a9b79fso80390137.0
        for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 07:05:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763046330; x=1763651130;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bwlUmhYLedxffSiGPT0olVCco0Fmu8rqsu17IPvjiOY=;
        b=BsKhSrhf3vvzJVbXe0QilVKDGIUD4BP7gV3ZddA2vYowv1LQZiiv+qu47Bdd+7G6Tk
         NZfFWoUNzD0HWEVQa4ubHW+98zWykdpzafY561n2J7HTQ0k5okCGb09sZJMX7DfzJs/7
         Xsg8mI4kt1zQJ2re1LE9XSf2uLcDEECJPottYEzrciQmnN7kXeag1MtecEHcNZWvd8pA
         OjN34O0YAWuPCNXvZTPe9rGTTqEXPBZlqcpfjkrDAS93W769FAq/ej+fm0pfxdCV2lnz
         YZBHCx/n22KT/EKa+C2B7rJR5WXPTO5zEsDbhioqUpK9sDYGGfQagOHnpY4hvthwwrg7
         FddQ==
X-Forwarded-Encrypted: i=1; AJvYcCX25WMPVDO1lG62ayanMPAUZOA4XsxeyBPCHBvC5Hs4dQI3/Ei5O2uDNYb9tnyhPBNpqEUcXyN+3X7SKUM=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywbh9Ya1JAYSwOlDwYtH+IWMsbCg+3UabydSF+Q5GK8G4irS8eO
	iIITf6R3A+lnmNpfaJboW6mp8sHrGmf5d+9pCuZP2hwKY9HzzZYUrq1Sw+pfNNjtC0A=
X-Gm-Gg: ASbGncsOncU/DYU/PtypXg00V5O6E48IVL/07kHbcySY9nqREBIOC2ZoSrtjXkXuXIb
	wmEq4TbQ3gCWjDpTsQ82u17eY6/o9PCVfS7JiKCxa/Akn3PB8PhulXwxwu0JTwlJivCyvZ1CGfQ
	bEN4b5PT+fvOA08+4KzTHPF6Tkppu4WTK3QAcfe0l3vXlz+Vu7JtEvmeKPbv71xcOTGY+6eD90j
	6GbfwBK/CD9n87H8sKhwDG41hDurq14aHXTirDBF4Zvq9wduMnY1yUhXy3+vN8FUgkSStdRV2or
	gA2oRddQhoEu/OCZEjPXCMn+T72mx2c+yCc2FsK/TlEFe1lCP1fsBMSa7m+CCPUp7A7hqRFP6MB
	kQmDHnKVvglTrxtsK/yjkz4JJIKT/gTLKQAatzlb1BUFQaLWKIvWuB4XYR/3ksJFhqFcAvr9pcQ
	FOv336SDWxZczeJWFm34MUROTUOkxP40RLeFthmg==
X-Google-Smtp-Source: AGHT+IGxUluBMRsv/aNkgO6wChh9PosqTvamsLsq9HNwxLJLSIcKpT2RuIzwBe1IgaFE0t/ztz8iNg==
X-Received: by 2002:a05:6102:38cb:b0:5df:af0f:30a1 with SMTP id ada2fe7eead31-5dfaf0f3604mr1936997137.31.1763046329751;
        Thu, 13 Nov 2025 07:05:29 -0800 (PST)
Received: from mail-ua1-f50.google.com (mail-ua1-f50.google.com. [209.85.222.50])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-5dfb70ea4aasm657817137.8.2025.11.13.07.05.29
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Nov 2025 07:05:29 -0800 (PST)
Received: by mail-ua1-f50.google.com with SMTP id a1e0cc1a2514c-93723104137so288048241.3
        for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 07:05:29 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUyrJpJJtER+perlfi6PC/C2YnwcXqK2rt7in/SxfSyTuQSdgJIEzFALykwi4vc1HqAy20iib2jiu3dlns=@vger.kernel.org
X-Received: by 2002:a05:6102:498:b0:5df:8f4:61e6 with SMTP id
 ada2fe7eead31-5df098d049amr1727150137.32.1763046328910; Thu, 13 Nov 2025
 07:05:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251023135810.1688415-1-claudiu.beznea.uj@bp.renesas.com> <20251023135810.1688415-8-claudiu.beznea.uj@bp.renesas.com>
In-Reply-To: <20251023135810.1688415-8-claudiu.beznea.uj@bp.renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 13 Nov 2025 16:05:17 +0100
X-Gmail-Original-Message-ID: <CAMuHMdVaB15yLcGObzF_zuNKSqioE4ktD_u4xkJ-YJuQiD4fdw@mail.gmail.com>
X-Gm-Features: AWmQ_blisT-axhMgcAs5oMipnI2iYyBHU5ygZXj2OjcwlBET81JTXEQGhpMKWtU
Message-ID: <CAMuHMdVaB15yLcGObzF_zuNKSqioE4ktD_u4xkJ-YJuQiD4fdw@mail.gmail.com>
Subject: Re: [PATCH v8 7/7] arm64: dts: renesas: rzg3s-smarc: Enable USB support
To: Claudiu <claudiu.beznea@tuxon.dev>
Cc: vkoul@kernel.org, kishon@kernel.org, robh@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, p.zabel@pengutronix.de, magnus.damm@gmail.com, 
	yoshihiro.shimoda.uh@renesas.com, biju.das.jz@bp.renesas.com, 
	linux-phy@lists.infradead.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org, 
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>, 
	Wolfram Sang <wsa+renesas@sang-engineering.com>
Content-Type: text/plain; charset="UTF-8"

On Thu, 23 Oct 2025 at 20:41, Claudiu <claudiu.beznea@tuxon.dev> wrote:
> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>
> Enable USB support (host, device, USB PHYs).
>
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Tested-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

Thanks, will queue in renesas-devel for v6.19.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

