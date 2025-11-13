Return-Path: <linux-kernel+bounces-899914-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id EF623C593E0
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 18:44:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D9A324FE6AC
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 17:07:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4916A359F80;
	Thu, 13 Nov 2025 16:53:59 +0000 (UTC)
Received: from mail-vs1-f48.google.com (mail-vs1-f48.google.com [209.85.217.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 628773596FC
	for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 16:53:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763052838; cv=none; b=SS2NNg6/7TSKOM/6QnmX7fOKKl6gGoRSOyPxrsB5o6vrCgmKYIRu97hCxen5mZAedCnvngRRfuUeWYy4KRZZKJP6+m0wTmg6lM5W08bmUagGoHD303uxjSCcObDOl9tCOJci24QG9fplq0D1f5kJSmON9lw4g2aL0biFtlPCZzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763052838; c=relaxed/simple;
	bh=JsV/8/54jQvxd0kSYYLeIfmgPFGknt20dq0zvf6pcTo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Dz1XiaYoSsHTsRqaD+QM78CRHC8gSsWDRs0NHw7/wEmfVIZ6zm0nXzVzBohv8A7QSM4ezWpp259LMtKcjwq7vcZeJoiuQ7Cy6tWWrodr1mwykeALewUCfFQthf4HTTt7Ve++j3RwNWIty88h3Ci8LiK7zKTRNrAdSXC0IXcWr5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.217.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f48.google.com with SMTP id ada2fe7eead31-5dd8a02e808so806694137.0
        for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 08:53:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763052836; x=1763657636;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ALBRC4wvbYHISURwEdik4fuZyBrb01I5jhftggw+rBA=;
        b=S6CPPnTw1fVHXmojsgxy7qGFtY99LKVF/UXDUeWQvU5h2VmMn1hdJyXrig4U7d3DA3
         4a1h+EawrV1jaERxqRp9PNRlAcBjEWCGRA+7cTeRLofSzjB06z5sTuvlMwYxx7buj2Ed
         xVIiYWdCEYdpnnWnPbQqGvo/PIngT+JRGb3ZTaZlFaf+lql19xg/E6t1BMQuY4CtoP/l
         flpMf3+JZKwFAqe88Vf/U6DYDh5IpnOzPDhPjXsAhxvUphcU4sQeeSbgkCtpt1VfI8WM
         PTkaPcmsJVIla5njzU2wHRoIhuTq+kgvMQ61U8+ZoMNsAJUA0mWoaKNqV6U9tPc/xE5t
         PRwQ==
X-Forwarded-Encrypted: i=1; AJvYcCVKHyNuG1lgvAY1chaSSg0Dc/bGzkXxaQdRoF3QcbCnrx+rJiLhbBg1HekfBOp+kR/PDRy5SPuwE4+58RU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9rF0SpOLFL/UN9YrTuoZULOoBEZePXw998tLVCqZ7WSt3tUgh
	qxtT9qizJ2a2ozFgyQSBEk2lm6tWCU6hoxiksDzyM/8w+LAMM8qe2vr5dbBJwyyy23w=
X-Gm-Gg: ASbGncuflq5neeVzc4y9RcpMCCva//FtlYGacYnjXxmcsV7wmkWmt5bn3VtzMv4rbDO
	ce83Y/Ej+0jDrGr1Y2WSGS6yGogUA00k0PPeQyWd3wF/Kh0zFtuGWAxc5Af2CCPULrP/sS7wRoK
	AEbbemlUlIuQQiqqkUaP5wUfAAiw1E7Oknm528V54mJYZy6UCnexmxtbr2orm34idWuqWiQU/8Q
	lhTRGReANpYzj5/wOUFjcBj8wGdCc8n6gZm0SU/hh7wp+zLeAeobnEFy5w5/3EwitF0WED78UQG
	99mw3pZ4YrGosquPxHG7fAO3K0ImbykN/pq+SU+gSqPnPa5JZfxmyD3rlXk/0ORQiPCk8G/5lwj
	d6b8r+gehxyNnMDbPegrvq7DhDvIlFNmd1/LE9rrFqGXka2dikYd1UfgOUyqbPOEaHIGY+dBxzR
	N28/BzBeiu2hg6l0BCxcDxS3JEJar9u1b+6X9pvQ==
X-Google-Smtp-Source: AGHT+IEcAydYUQp1KegMebfxkqGzV5uxirHapYaqlBTeK1Ftja/h8VB1qAlppgYPVQdRoSYHti4wRA==
X-Received: by 2002:a05:6102:5a8c:b0:534:cfe0:f86c with SMTP id ada2fe7eead31-5dfc55b339fmr187799137.15.1763052835907;
        Thu, 13 Nov 2025 08:53:55 -0800 (PST)
Received: from mail-ua1-f47.google.com (mail-ua1-f47.google.com. [209.85.222.47])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-937611e0a69sm784185241.15.2025.11.13.08.53.55
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Nov 2025 08:53:55 -0800 (PST)
Received: by mail-ua1-f47.google.com with SMTP id a1e0cc1a2514c-9371aca0a4dso631388241.1
        for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 08:53:55 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVfMiAKSdmnsjWtAYKqeFNhoqtzb3FGwqDgmhtNqWfWYoljsutb0b+W5OeMhOghuS/UeAmuB8bE+pmjTD0=@vger.kernel.org
X-Received: by 2002:a05:6102:4b82:b0:5db:25b5:9b5e with SMTP id
 ada2fe7eead31-5dfc5b93ff4mr177461137.22.1763052835289; Thu, 13 Nov 2025
 08:53:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251101050034.738807-1-prabhakar.mahadev-lad.rj@bp.renesas.com> <20251101050034.738807-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20251101050034.738807-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 13 Nov 2025 17:53:42 +0100
X-Gmail-Original-Message-ID: <CAMuHMdWfHwht8VUSyWHJi90kgt1gnz7Nh4VEBfoBveaZsfquhA@mail.gmail.com>
X-Gm-Features: AWmQ_bmlVtkk56vOIDIOnwx-1JovK4RapbFc85Q7wu_rCX62rAKZtONV7Zi4F7w
Message-ID: <CAMuHMdWfHwht8VUSyWHJi90kgt1gnz7Nh4VEBfoBveaZsfquhA@mail.gmail.com>
Subject: Re: [PATCH 2/4] dt-bindings: clock: renesas,r9a09g056-cpg: Add USB3.0
 core clocks
To: Prabhakar <prabhakar.csengg@gmail.com>
Cc: Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Magnus Damm <magnus.damm@gmail.com>, linux-renesas-soc@vger.kernel.org, 
	linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org, Biju Das <biju.das.jz@bp.renesas.com>, 
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>, 
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"

On Sat, 1 Nov 2025 at 06:00, Prabhakar <prabhakar.csengg@gmail.com> wrote:
> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>
> Add definitions for USB3.0 core clocks in the R9A09G056 CPG DT bindings
> header file.
>
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
i.e. will queue in a branch shared by clock driver and DTS source files.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

