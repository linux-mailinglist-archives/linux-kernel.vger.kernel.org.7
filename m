Return-Path: <linux-kernel+bounces-868572-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E68E6C05855
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 12:10:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D10901A07C42
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 10:10:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD94330EF81;
	Fri, 24 Oct 2025 10:10:06 +0000 (UTC)
Received: from mail-ua1-f54.google.com (mail-ua1-f54.google.com [209.85.222.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0725D30E84E
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 10:10:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761300606; cv=none; b=eL/0o8phZjXi9oPNMOL1j+JLGDDj0abOGBkLGOnBGNLIdpQcruy0U76fq+nV7pYEVLc47VtV8o0kUYa+AGaQANDB6w83c4uV4A9cR0lQWta1/Tzxu42bDNE03HwzeSJXm5uKjrwctZPnbdXIlhegdhh2vbzuFAJ39iHFKa4FznE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761300606; c=relaxed/simple;
	bh=6MpM/czxf/6Hh1L0dLLUemfAUkQnQOxKAeYfzG6IdBI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Kflo97QHP3Hhe7eGq7amsFUMbwKQZoZnq8byCtmheTiDLWnD61KGcALzlrexPoOlF2Bmsjwi6593YDIcmT2obEnlcuSrD01REYBKsMYvx8ECEd0LL0SWFZXzAmOQsifXuhIYBGXKbVDuQfkCiGBJ0tH7byY5GrGzFryppNnxUY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f54.google.com with SMTP id a1e0cc1a2514c-8eafd5a7a23so1848685241.1
        for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 03:10:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761300604; x=1761905404;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UT8Wdcyo2x3pLAZUDoU//zKTO9XrNWcZhxUqd4p60Fk=;
        b=b8+6QKwU1XClVmZkO7EQ62XEng4sPjJil8jCuaMDAa8EQhJK74BLUJeYKaQKhEVlvW
         kRQ+RcRTBrewgjA+TcxdPKuMCSennIiyG4zx0A91UQZYJPFSeHyLg85dJ0KPI6Lxf26F
         pohO0LkW1FU17LX4g8nKHjDCxslqdvWgbHiHzglkHI9EBjqgw7KA9HvDn+gRsRUQaAm2
         bPKHFqaZR3eAntKdl2uAXLZiQOanmkX4RkLCvr0g1G8u4OIY3mBSQQ/rk4hSOhvqzhgW
         jjOyout685Xbib9+ZU7I6pnVDpSl85LLjlq5PE8PcAgLPlk6XboLF1uCaFfDOu1CpCRN
         pcmw==
X-Forwarded-Encrypted: i=1; AJvYcCWB2eSbbQo8hBax+Kd1dvqmMjyKjVnStgFL64PkMEv6ikUg3rfVs07bY33YGxbrayz6goK10xeOgko3x2c=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywtz3YbJzyrqJKWJQtVTZVHaQuR+20Bbs999cy4bO1Sp1VisQso
	d370YfiDkJE7BOpXrebgQVLyAqhhXNDj0E9l/ZF3fkZh4eQha5Hn55tOVcyWJg57
X-Gm-Gg: ASbGncshr1zyvvkJPCwd1/ugoSXLdw9qQRN7aNyqeOVShqQue/d6R4eu0v0VnfhuR7G
	yMdA03sIctD/IcbWjRzdCSJDWkLUFI5QoNwQ77kP6hunhQomyY8HS2e/5e2En8Sx1gr4PwHhZKv
	XOd2Pdscn27EtD6ONUz5ImwPCCsEHNazGcE4YrMnJvQcyzcEZLEONz4namTT+KhSOg+bRcNFVRf
	L3SmI4l0AuS0rajkPqS8MCspdAHoiashdBn2gdSM2nPfERGIsO8TGfRyPa9VhDN6YgYObR+KqaQ
	wr4zlotjP6+QeK+fFutdTtk0/yCbzmkzKNnoCxXxI6dS8v3AnfT7GUCk0LGwbsk6HPNsYTPs8kR
	YYirQyFA+b7YIywihNwvKyHSn+5iXdQc9hGe9fALeFeiyvolZ9/zRbXPOtoy/IQvLpMGjfH8A8C
	Sno9D+mo48m9lVxxBjsYLF2K/sG4O/ogRSWgnjHDIE94BkCaPs
X-Google-Smtp-Source: AGHT+IGuP6rgG6izAIDrQIG9LcNQpV/aih8Kuq5tK4TLORzfoQppy2er26cBbjK/QsN5hgLE0409WQ==
X-Received: by 2002:a05:6122:787:b0:552:3366:e822 with SMTP id 71dfb90a1353d-557cda985bemr517300e0c.1.1761300603578;
        Fri, 24 Oct 2025 03:10:03 -0700 (PDT)
Received: from mail-vs1-f48.google.com (mail-vs1-f48.google.com. [209.85.217.48])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-557bd8e5e87sm1877940e0c.11.2025.10.24.03.10.03
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Oct 2025 03:10:03 -0700 (PDT)
Received: by mail-vs1-f48.google.com with SMTP id ada2fe7eead31-5db24071011so2426298137.1
        for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 03:10:03 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXA660HXrNd4VDTVONJNxJl6Gky0J1vqrH/DptxP1S8RI6kfRbkFX6l8oLX5lLPzZp6j0cWx3UxREyxW/A=@vger.kernel.org
X-Received: by 2002:a05:6102:54a3:b0:5d4:1499:99a4 with SMTP id
 ada2fe7eead31-5db3e20ccfdmr599456137.13.1761300602852; Fri, 24 Oct 2025
 03:10:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251014151325.160062-1-prabhakar.mahadev-lad.rj@bp.renesas.com> <20251014151325.160062-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20251014151325.160062-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 24 Oct 2025 12:09:52 +0200
X-Gmail-Original-Message-ID: <CAMuHMdV=e3rj77BV0eb++KniTqHSTmDpX-1O5AFBODxOf+s7ZA@mail.gmail.com>
X-Gm-Features: AS18NWBX708mbwXNFoDh6ZLkVdZtZB1QvklxJwBzxdLMFKS22IAaBo88zTThT5I
Message-ID: <CAMuHMdV=e3rj77BV0eb++KniTqHSTmDpX-1O5AFBODxOf+s7ZA@mail.gmail.com>
Subject: Re: [PATCH 1/2] dt-bindings: clock: renesas,r9a09g077/87: Add XSPI0/1 IDs
To: Prabhakar <prabhakar.csengg@gmail.com>
Cc: Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Magnus Damm <magnus.damm@gmail.com>, linux-renesas-soc@vger.kernel.org, 
	linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org, Biju Das <biju.das.jz@bp.renesas.com>, 
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>, 
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"

On Tue, 14 Oct 2025 at 17:13, Prabhakar <prabhakar.csengg@gmail.com> wrote:
> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>
> Add clock definitions for XSPI0/1 to both R9A09G077 and R9A09G087 SoCs.
> These definitions are required for describing XSPI devices in DT
>
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
i.e. will queue in a branch shared by renesas-devel and renesas-clk once
the issues around PATCH 2/2 are resolved.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

