Return-Path: <linux-kernel+bounces-868335-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B906DC04ED0
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 10:05:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A3D42188AEF6
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 08:05:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E1FD2FE04E;
	Fri, 24 Oct 2025 08:04:52 +0000 (UTC)
Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1724B2FD7D9
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 08:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761293091; cv=none; b=Zzert5eqs98xkheaei/gsqltUzAZtbbjksTe7kEK5V0YWsHMDc0+9bi8Me2z6g+gRMml/ElWJqdWbcKoPZ20zzlTvf6hu+4/RqTbc0+eOSSKYmAwy8ZNODz5y8y9EsMyJf6r40vE9PugFhCAZlDefdtn8pYaQW5jGtDrJ0QOuiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761293091; c=relaxed/simple;
	bh=uni5/q7wgu22e7PzLdPH1ONXX5dFs+/nb2vDY+DwIyE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=btZrHWmLT9i8bLWt+RWYpTqwSZrmzH4IhRbOW8Nz66r2MCFfFVH1UPilN22UuzDNiAhGnplSGHcDqiwwSuXRRrSVA0Q06czzBuORrkthgH65Mr2UgpWMect5HOkX9ewgQXYVuLLA3M1OQHZjJ6IjcQ2Qj5+DzZeTQ/NF8CrR2uw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-88e456972d5so252692685a.3
        for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 01:04:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761293089; x=1761897889;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2H0+Y+0nbHCT1nPmHP2N1suTimvZ79Q7MXGtF4XoMw0=;
        b=hNXKjrJa/G4XtyZYJVBoM0XrZ4jvOwzlVYZvEidyfC5scmV7RXiKxgO1fJ/+JQZxqU
         bIAEu+1xtrHps82FcZGZbCtTnPt/8YsbChIxN+gyJPqoM/7z/iZH8nXr2kR0LFwuxu/E
         L2tpfdEd2aMSmAPOwo/FhC2bPi+mTAtIUe+KYT76QNAf9QOXQBKPXlSZs4zeNUQM+3FJ
         ATnezCV1xj4NoDtqLA8PbGXWxmj8l7Fwm3iZEB+WDdfWPVn49KwK8CXzYf+0tSfVsQiQ
         w0d+d2Q7wrN9Qy18MceaV9G7O2DpDIu5zmiZ51cseGkjonpbd4ZAjgM6d0tCpGG6SjKD
         xFSw==
X-Forwarded-Encrypted: i=1; AJvYcCVvOWGXc0jmqchK+nF3PuPGEBCbfgAGPzQ8i1Wg0/NbsLeXN9ssot50CzWgMXttF+hNwdxmfiGYiGYy59g=@vger.kernel.org
X-Gm-Message-State: AOJu0YxU8ijcElDITNQRUyYl40B2+YxYfnrhCXDFHYRqDzt2tJuw6PS6
	dQYOi6m9oMx1Je8toeFX8swi+nb2kqbWJVxO2i0C42i/L5IKVtovO4Qs+KJoPbZa
X-Gm-Gg: ASbGncu7CS6RfGVHPWc/xNFx4r1Gkrl4U5OFhNA+ojg24hyzZL5RMs1MDTPWg8jLiYk
	GM9oS3SEu43P1tOwIvSJQc0zffo4fhKF8t5G8McxjlL+Rs02sdwT6lmZjPQ3olVkqf0FgSUEID9
	MBP679djkSvBDjG2gn2m3BNCRUYDyZNtEN3cckV8YLPeyZ1qL2C6+62TbdgBgGd8r5GgDQSSkXv
	T84R/hu8vbTHZx6QzwRu502uxnoFoBiE7QNtAUNGY4TBAmDt0y2SJA/c/o2lX3enAZFNLpkwbzT
	wwACQn63DmeYMCQoGnFCbfbw7phW1pfyWoeqw0IzgJI+LxHvuMG0iUFovoCU6FYtkblrqUpuolO
	r2/5BmaVEskptUNJIalSTk3TUQp+2u4JIRgpsSO6XeUQJKAZXTb1UMKRhUo3xYp00ZnrgC7wcK/
	yegq7zhKhJsTb/P6bAKGcGZxGtlnvUmWkovXwo/uKI7g==
X-Google-Smtp-Source: AGHT+IE9onSmde2ZKLB7912wnXxZgfVZpvT1850MTtyNUfJEBRuamXQRm13LnAKkJ9N1+iJ6Lnjp+g==
X-Received: by 2002:a05:620a:19a8:b0:892:5b57:ea3c with SMTP id af79cd13be357-8925b57eb59mr2357703185a.2.1761293088579;
        Fri, 24 Oct 2025 01:04:48 -0700 (PDT)
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com. [209.85.222.169])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-89c0dbcd0absm339993185a.9.2025.10.24.01.04.48
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Oct 2025 01:04:48 -0700 (PDT)
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-8906eb94264so196995185a.0
        for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 01:04:48 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWwzdlNhWV6qT1EeqQ06CDnVZawwq1smXX9xtEahrbhiEO8gwGZ9YU1aexMBZoLd6KAkrt53bek4LKTNmI=@vger.kernel.org
X-Received: by 2002:a05:6102:50a3:b0:5db:2f62:c15 with SMTP id
 ada2fe7eead31-5db2f621029mr1782604137.41.1761292628800; Fri, 24 Oct 2025
 00:57:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251022070543.1169173-1-ryan_chen@aspeedtech.com>
 <20251022070543.1169173-5-ryan_chen@aspeedtech.com> <b5441728-06a7-44ea-8876-3a9fc3cf55be@app.fastmail.com>
 <TY2PPF5CB9A1BE626A2F0F6307461D8F64BF2F0A@TY2PPF5CB9A1BE6.apcprd06.prod.outlook.com>
 <6a97fbb4-19c2-4ffa-9c73-26aea02c27e4@app.fastmail.com>
In-Reply-To: <6a97fbb4-19c2-4ffa-9c73-26aea02c27e4@app.fastmail.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 24 Oct 2025 09:56:57 +0200
X-Gmail-Original-Message-ID: <CAMuHMdXTZZK-Tk0gerpARfr+jUNGPhEfRqGOtTvTTJp=SZ2ayg@mail.gmail.com>
X-Gm-Features: AWmQ_bnSAouTBsQ6YdE-Y1_3m37NwmxEYp_NrgytrqguGhvssb4gZifd3I_f9eg
Message-ID: <CAMuHMdXTZZK-Tk0gerpARfr+jUNGPhEfRqGOtTvTTJp=SZ2ayg@mail.gmail.com>
Subject: Re: [PATCH v6 4/6] arm64: dts: aspeed: Add initial AST2700 SoC device tree
To: Arnd Bergmann <arnd@arndb.de>
Cc: Ryan Chen <ryan_chen@aspeedtech.com>, BMC-SW <BMC-SW@aspeedtech.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Joel Stanley <joel@jms.id.au>, Andrew Jeffery <andrew@codeconstruct.com.au>, 
	Jeremy Kerr <jk@codeconstruct.com.au>, Lee Jones <lee@kernel.org>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>, Nishanth Menon <nm@ti.com>, 
	=?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= <nfraprado@collabora.com>, 
	Taniya Das <quic_tdas@quicinc.com>, 
	"Lad, Prabhakar" <prabhakar.mahadev-lad.rj@bp.renesas.com>, 
	Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Eric Biggers <ebiggers@kernel.org>, 
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, 
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, 
	"linux-aspeed@lists.ozlabs.org" <linux-aspeed@lists.ozlabs.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Thu, 23 Oct 2025 at 22:11, Arnd Bergmann <arnd@arndb.de> wrote:
> On Thu, Oct 23, 2025, at 09:37, Ryan Chen wrote:
> >> > +  aliases {
> >> > +          serial0 = &uart0;
> >> > +          serial1 = &uart1;
> >> > +          serial2 = &uart2;
> >> > +          serial3 = &uart3;
> >> > +          serial4 = &uart4;
> >> > +          serial5 = &uart5;
> >> > +          serial6 = &uart6;
> >> > +          serial7 = &uart7;
> >> > +          serial8 = &uart8;
> >> > +          serial9 = &uart9;
> >> > +          serial10 = &uart10;
> >> > +          serial11 = &uart11;
> >> > +          serial12 = &uart12;
> >> > +          serial13 = &uart13;
> >> > +          serial14 = &uart14;
> >> > +  };
> >>
> >> This looks like you just list all the uarts that are present on the chip, which is
> >> not how the aliases are meant to be used. Move this block into the board
> >> specific file and only list the ones that are actually enabled on that particular
> >> board.
> >>
> >> In particular, the alias names are meant to be local to the board and don't
> >> usually correspond to the numbering inside of the chip. In the defconfig, we
> >> currently set CONFIG_SERIAL_8250_NR_UARTS=8, which is enough for any
> >> board we support so far, but that means only the first
> >> 8 aliases in the list will actually work.
> >
> > Understood. I'll move the aliases block from the SoC dtsi into the
> > EVB board dts. For the EVB, UART12 is used as the default console,
> > and the board labels match the SoC numbering, so I plan to keep:
> >
> > Does that look acceptable?
> > ast2700-evb.dts
> >       aliases {
> >               serial0 = &uart0;
> >               serial1 = &uart1;
> >               serial2 = &uart2;
> >               serial3 = &uart3;
> >               serial4 = &uart4;
> >               serial5 = &uart5;
> >               serial6 = &uart6;
> >               serial7 = &uart7;
> >               serial8 = &uart8;
> >               serial9 = &uart9;
> >               serial10 = &uart10;
> >               serial11 = &uart11;
> >               serial12 = &uart12;
> >               serial13 = &uart13;
> >               serial14 = &uart14;
> > }
>
> I think this would be broken for the defconfig if the consol is
> on serial12. I would recommend using serial0 as the console, like
>
> aliases {
>        serial0 = &uart12;
> }
>
> in this case. If additional uarts are enabled, add those as
> further aliases.

Indeed. Are all these serial ports exposed on the board?
Aliases is mean to list only the ones that are exposed, and the alias
number should match the label on the board/port ("serialN", "debugN",
...), ideally.

Typically only a few ports are exposed, so you may end up with something like:

arch/arm64/boot/dts/renesas/rzg3s-smarc.dtsi:           serial0 = &scif1;
arch/arm64/boot/dts/renesas/rzg3s-smarc.dtsi:           serial1 = &scif3;
arch/arm64/boot/dts/renesas/rzg3s-smarc.dtsi:           serial3 = &scif0;

I deliberately picked this example, as it shows how the serialN
numbering does not need to match the scifM (or uartM) numbering.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

