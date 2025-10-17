Return-Path: <linux-kernel+bounces-857505-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 41DCEBE6F8C
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 09:41:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id E2C3835B124
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 07:41:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEF6923EA80;
	Fri, 17 Oct 2025 07:40:57 +0000 (UTC)
Received: from mail-vs1-f46.google.com (mail-vs1-f46.google.com [209.85.217.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEFC11EE019
	for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 07:40:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760686857; cv=none; b=Oub5SyWzLhAyb5N3n1q2ou8vEMYXH2Z56/AB8fgS6kJmQgUKZ78Kd4Q2LlSs8ijG/Cj47fgXUOK2wwyu+D5X2AMmjqHuWvKDFrGRb7CyY3KTSeDBmBhwBtYC+5Zd/Ywec6NvcpzqCHauJ3NtwhSs9uRcFTdCmNeQAw4jqQPj054=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760686857; c=relaxed/simple;
	bh=cLKqVn8Z2TBqSDRqJdQ7TokPZf5KyC181WbIfaA6di8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dKPZtrJlDhI7vOzTIJpaTBJr8EBjLoGZfIjSzAA2PnQjhtVm5HQIki1aMt0VzMZ+8T7iPGPOS1onmQMkyfDt/ElDb8ABgvhRVlxeD1MF9OiWojy4M7bhebyVaEa6Rc12PMDxZ0OrzpNfFJdiBZi3Y7YAnxLRaVJ0VZiwDmye12E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.217.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f46.google.com with SMTP id ada2fe7eead31-55784771e9dso717684137.1
        for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 00:40:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760686854; x=1761291654;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FsO/hn7ZxXSEVqf0RwtjiX3Woc/Jh2yXP3yIe9HcSiA=;
        b=CMWanTGcpypHzfHJI+uiok24o6evtXBsqoRoJnOAT8syiyEnXlKf41t9rLqz8iwVs/
         rcQYiJatjiVOUF+CYAtnoiebuna+buVG468e+Vlfp7AmCZo0bYLr3kXJ5F/VjAPgGJgS
         GaJAun/0t8caMobonJRKR5jSzwDSHjiKmngUJKsMmNKMZ3uh0ccB8nsw/hgIL1LWicoX
         wiiGZHNwqwdocUlkH5y8PxpndM3EApQAm87A9GI9px4ooH+IhLxS5UmlgVj6/n6Cz8T0
         L9+LJTcPEBekPq5BbPV80nCaFilVIedQ3z02i+HodQq5ELScomtLJslNdBbrBclECu0A
         ZZDQ==
X-Forwarded-Encrypted: i=1; AJvYcCWoTGv+Zd7yd9fLF+53v2udHtpYge0CJySOF1xuYaWSdBCz0KMopFyLVRSgGIDyq5eKZuRAneYJB3GLVPI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyYK3LVD4Nh/km4xOnlhMuPM6VQd0BtRVAQa/w/dTvzryiJOULr
	L7lFUoPmjuFChW3O8wMHhI+8ZnX+n273TwWJBOnXUFa+1cXSnZ8Wr4ZK0cZmA1sz
X-Gm-Gg: ASbGnctpaeisfq6bZCKgA9OTcoT5hLnGczg+Emb4TthSbkKG+tozqXJ5oLb3B3ZqYDc
	5Wpjav4S9UhCnlQoyIi/6upOnRqvnFdD+GeNrXdmPM5tGFZfNDXvaZqaD/QZg4vHiaghWs02bHm
	JFAFWqeCg+C+jOQDWo7S2GDDIz0e4J3dDV+ylaKawo95HD0SvnAygzrsVDhPwr1iKMfkLHmABgC
	Dux3rCG9WxM5p1gIUCxrpRjc0apznVbPGq10g8qLZLkVg+PVn66DizHuqlc8S7rJ50CF2MApMVe
	Chr/4vpymgND5Ut5Ikmby3lDo153VKrUriTE0UGF3txoSzHBIUnhGzX822pdgDv1bgQ0fCbQmNj
	lKRzHaQA66I/jRjbXyCuqn0al3DbHJr9MSJRkbob/wRPzThfc4eJrTPQciBMHdxtu0CxOiqWxQ6
	KnPDKLAm2gVVpDY8upZzQfaZ1UxxZ5+3HQcVtnqMZucg6oLGdM
X-Google-Smtp-Source: AGHT+IHoTtJBnyNUc4B6I41Z3uwzX/v5As7PoOiyCKQJjX/BdsV3du+y+uZjXDcY3dj1FUK/b/nufQ==
X-Received: by 2002:a05:6102:b11:b0:535:af8c:ba68 with SMTP id ada2fe7eead31-5d7dd6d76b9mr1144784137.33.1760686854364;
        Fri, 17 Oct 2025 00:40:54 -0700 (PDT)
Received: from mail-ua1-f49.google.com (mail-ua1-f49.google.com. [209.85.222.49])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-932bebf59fbsm189536241.11.2025.10.17.00.40.53
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Oct 2025 00:40:53 -0700 (PDT)
Received: by mail-ua1-f49.google.com with SMTP id a1e0cc1a2514c-930d9fdeb96so478324241.3
        for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 00:40:53 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVBUmR0aid+7qKDfoCNpojv+fDPGyzq+LcWN7RHagZL4lYJYNqA87KTs4aQpVdT+exwVOFFiEWztp/eDQ8=@vger.kernel.org
X-Received: by 2002:a05:6102:3a13:b0:523:712d:4499 with SMTP id
 ada2fe7eead31-5d7dd6a442emr1096341137.26.1760686853648; Fri, 17 Oct 2025
 00:40:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251015142816.1274605-1-herve.codina@bootlin.com>
 <20251015142816.1274605-3-herve.codina@bootlin.com> <aPHiAObA61OVf8mY@ninjato>
 <20251017093649.2d5549e4@bootlin.com>
In-Reply-To: <20251017093649.2d5549e4@bootlin.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 17 Oct 2025 09:40:42 +0200
X-Gmail-Original-Message-ID: <CAMuHMdV0As4XKG0P0y+pJpTT82Bq8qpq2rHufeX4_q0j-eOPPA@mail.gmail.com>
X-Gm-Features: AS18NWADsUKWogewe8kUaA0j69ci3ZpGRe2zEccgQpiOEHAKGQSGuqQNAabIlZg
Message-ID: <CAMuHMdV0As4XKG0P0y+pJpTT82Bq8qpq2rHufeX4_q0j-eOPPA@mail.gmail.com>
Subject: Re: [PATCH 2/4] iio: adc: Add support for the Renesas RZ/N1 ADC
To: Herve Codina <herve.codina@bootlin.com>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>, Jonathan Cameron <jic23@kernel.org>, 
	David Lechner <dlechner@baylibre.com>, =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Geert Uytterhoeven <geert+renesas@glider.be>, Magnus Damm <magnus.damm@gmail.com>, 
	Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, linux-iio@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Pascal Eberhard <pascal.eberhard@se.com>, 
	Miquel Raynal <miquel.raynal@bootlin.com>, Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Herv=C3=A9,

On Fri, 17 Oct 2025 at 09:37, Herve Codina <herve.codina@bootlin.com> wrote=
:
> Wolfram Sang <wsa+renesas@sang-engineering.com> wrote:
> > On Wed, Oct 15, 2025 at 04:28:14PM +0200, Herve Codina (Schneider Elect=
ric) wrote:
> > > +static void rzn1_adc_vc_setup_conversion(struct rzn1_adc *rzn1_adc, =
u32 ch,
> > > +                                    int adc1_ch, int adc2_ch)
> > > +{
> > > +   u32 vc =3D 0;
> > > +
> > > +   if (adc1_ch !=3D -1)
> > > +           vc |=3D RZN1_ADC_VC_ADC1_ENABLE | RZN1_ADC_VC_ADC1_CHANNE=
L_SEL(adc1_ch);
> > > +
> > > +   if (adc2_ch !=3D -1)
> > > +           vc |=3D RZN1_ADC_VC_ADC2_ENABLE | RZN1_ADC_VC_ADC2_CHANNE=
L_SEL(adc2_ch);
> >
> > Are you open to either use an errno (maybe EACCES) or define something
> > custom (maybe RZN1_ADC_NO_CHANNEL) instead of hardcoded -1? I think I
> > like the latter a tad more.
>
> I prefer RZN1_ADC_NO_CHANNEL too instead of an error code and I will use
> that instead of -1 in the next iteration.

Or just -ENODEV or -ENOENT, and change the checks above to
"if (adc1_ch >=3D 0)"?

Gr{oetje,eeting}s,

                        Geert

--=20
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
.org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds

