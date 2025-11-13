Return-Path: <linux-kernel+bounces-899162-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B2C0BC56FD6
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 11:51:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E55E93BF366
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 10:42:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76A26332EDA;
	Thu, 13 Nov 2025 10:42:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b="YgRcZuLm"
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA45D33120B
	for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 10:42:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763030555; cv=none; b=MsjiZ5b7e8PGqMKVr7dPesLEn0CeRyS3tFPjD89sFCERFzPEsPnuS2E7Z27Psv45+e+4JFI4gx9De3PcZ+SeBm9JbXjcI53XXwKDfWDsEg63q1++FW0nlzYXIiFnv4V0bBlC7tTrq0Dj5zUSZN0MUDulBxPlwC0oog3CBkM4FGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763030555; c=relaxed/simple;
	bh=PMmKSFKj6pzkYGzgLnVnV4jlBP4NMbJ4YiWVaQ7L768=;
	h=MIME-Version:In-Reply-To:References:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ATwBk/l3Xp4TJX66zl5ea4KfpfYuuX9DPt6HRm787h+Ylkqg2pgYmmdiJqssvqTPRaFmjJbGZMcBzWbv/khwQ4yB0LMQs0yY4tS/LqF9Y0Py0h6s2rRsZdgW3L90AxNbnwyPrFmjKm9le/sqy4fcW9td24MqN0yMi/TO0vobAHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b=YgRcZuLm; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com [209.85.218.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 5840140255
	for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 10:42:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20251003; t=1763030548;
	bh=WaWROQhILaIk4AODRxLJvdFvDxUCFVP6Fxty2SkZyI4=;
	h=MIME-Version:In-Reply-To:References:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type;
	b=YgRcZuLm86cfnKM7UX2EDXrfVXVcH1g7Mf8TnnZtarKdu91czDC6BrbC3vYLgRRBM
	 VyLumaupXBK1Uk/2VGv8993+5Y/RGuN/5BFUp0dOhf+S4lEHIN9ku8GjBD2tRDGrG4
	 TCJj0QgRG7WKIcMzKaZhf0YYhWhtMFlh2pqcbPqMoo3dgplzXKBcmuLfNm3mI0jF2W
	 PBgw0rnGSysHsT5sLzllM3U4Y9BYpLjjLRf5AxjjCadjKyS+84AGVuE1i2pvOSY0+C
	 qcaTmiQKywpplVhHdBrsKu0W/GkM1bOOJ0Wyx2hd450k9VLIghw1gsYnFx8Gs9Jx+4
	 V1melovOopT6Te1FMo+IZALYEgsLSfCFeRuKU7vRFcdbBe5t85DEoRcXUFCsG7niPJ
	 oPtQG6hlmpmhV9YPDsUIpY/W/Mk7z/WBBQbnYYKfRRcD4aGaLC5Kd3gD0VNhmQunIt
	 HuZnLFItLu/9zgO12WTZgdx09CSDVu4c6j9+6d5d+NKHCg+lOKxFa7OXojLQfknTKQ
	 u5syzlvV4wEdIG3AsYCGnwd1Yg/jiEGKNbV3yHO/B/pgIPNUbVggOyFqrXwLXN+XGt
	 oU7qzDJRUtYZezsomLqD5RI5Sc3VklJXSwv7LpxN32c2BYTPDzOaIz9oI++HojWsgL
	 wuwmwZwYUO6oKa3j1HTYpMVU=
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-b70b21e6cdbso93408866b.1
        for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 02:42:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763030547; x=1763635347;
        h=cc:to:subject:message-id:date:user-agent:from:references
         :in-reply-to:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WaWROQhILaIk4AODRxLJvdFvDxUCFVP6Fxty2SkZyI4=;
        b=DrWRJ+f9WG3M3jAn/E9Q1SvkdiORsRvZG5+TBjjMBzIQxcuoEyYLmfH3WhzjRGCTs5
         /viSPSwQfXgH9T2BKk9u0WNV4nXeUDMp/Dz3UMhBQtD8+MlopEHtjnC2CMKP0BSg85mn
         MK6A5qiz4LkeAO3daWdmbDYlczaBBoMymLSl0Iyvm6OhOoZ4PSsnevDw5xfAXXT3oEWT
         vfMRp2mz+wQZc66WOOAbvVKVZMY0VaRPmqTmumK6mDxKO2wHp65+06FPs4mfZCWB1BZS
         rbGQpDq17FHUdyAzzKb6QUEdUMG4QPu76eSEc/Hffm3qDExf6xRyu5xlwEFP1wij6ksx
         NHcA==
X-Forwarded-Encrypted: i=1; AJvYcCXBsj0jXdkVeX+4FUKCWAx/11LnSBEg0Vt9EjAoqd580gvBjr5dZfDzNbzrBh0weMmDQXolQi1HnGgNwoQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyGm0PhTqE9jI51AuQ0mh2EQ9HOMYNDwTG6+PVIWyTrzuCIqnZc
	Y8A3+in8JDf7ADn8fXR3NjYcbzvvfog6EtAMGMUfURM0yepUyMzYsH0kLXZV8VkmzjexaqvGEYq
	ucckXC5B/bdx0BbLwkuN1ZNYtAcAW5MpaY5ZJ09BDD2j/2av1Dm/nEYM3++VR+QVMl3xx+RGv9M
	2SBs0nVm0IagHLswPDTvtk629QoMtYQpkuu4VFEVJvzkDS5TK5EDO2nYaq
X-Gm-Gg: ASbGncsObgOT5t2UaYS/bC5qEWyTO0FgnVPAGjWDLSeKlHjTFvJ4AY5jTK2afl9a+/T
	3sh1VBrLu4Ip/0wLGTWMkhpSerBe3WMrGhsiL83NXV/h2DLD6jcYTg7M4fH0C050XLoN0cQ6yrG
	PNpwoCcY8vtEKh4y6CvaJvT7RkoIxnfD/a4RXIhtwRRBatDCKg8dn+7g==
X-Received: by 2002:a17:907:3e1f:b0:b72:b7cd:f59e with SMTP id a640c23a62f3a-b7348087148mr254968066b.8.1763030547564;
        Thu, 13 Nov 2025 02:42:27 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFTJg98+9M8c886tFyGLEzoK9vA4EcA/KrEpft00B6n0vwqztesDMLxb4eNFEPEpnVvcr/HOe2M0PsqZg0bCHc=
X-Received: by 2002:a17:907:3e1f:b0:b72:b7cd:f59e with SMTP id
 a640c23a62f3a-b7348087148mr254965466b.8.1763030547147; Thu, 13 Nov 2025
 02:42:27 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 13 Nov 2025 02:42:26 -0800
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 13 Nov 2025 02:42:26 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <ZQ2PR01MB13076544E2136E7E7C2EEDA1E6CD2@ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn>
References: <20251107095530.114775-1-hal.feng@starfivetech.com>
 <CAJM55Z_rczBo4D3HsC90QW1=fp3NWgK-tsEo6LHTZNXEBHTDqA@mail.gmail.com> <ZQ2PR01MB13076544E2136E7E7C2EEDA1E6CD2@ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn>
From: Emil Renner Berthing <emil.renner.berthing@canonical.com>
User-Agent: alot/0.0.0
Date: Thu, 13 Nov 2025 02:42:26 -0800
X-Gm-Features: AWmQ_blOZ9S9m9Ve_xD05iTkInH_Tetx_kG4fJGOm32UTmonVLiTkEgBwiVrXdU
Message-ID: <CAJM55Z9KyNK1n4i9FxbLor4HTQKqK8WKA2svjPVvKXihw_E+sg@mail.gmail.com>
Subject: RE: [PATCH v2 0/8] Add support for StarFive VisionFive 2 Lite board
To: Albert Ou <aou@eecs.berkeley.edu>, Bjorn Helgaas <bhelgaas@google.com>, 
	Conor Dooley <conor+dt@kernel.org>, E Shattow <e@freeshell.de>, 
	Hal Feng <hal.feng@starfivetech.com>, 
	Heinrich Schuchardt <heinrich.schuchardt@canonical.com>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Manivannan Sadhasivam <mani@kernel.org>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Paul Walmsley <pjw@kernel.org>, 
	"Rafael J . Wysocki" <rafael@kernel.org>, Rob Herring <robh@kernel.org>, 
	Viresh Kumar <viresh.kumar@linaro.org>
Cc: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, 
	"linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Quoting Hal Feng (2025-11-13 04:42:05)
> > On 12.11.25 21:54, Emil Renner Berthing wrote:
> > Quoting Hal Feng (2025-11-07 10:55:22)
> > > VisionFive 2 Lite is a mini SBC based on the StarFive JH7110S
> > > industrial SoC which can run at -40~85 degrees centigrade and up to
> > > 1.25GHz.
[...]
> > Currently the JH7110 device trees are layed out like this, with a nice separation
> > between the SoC description and board descriptions:
> >
> > jh7110.dtsi               # JH7110 SoC description
> > |- jh7110-common.dtsi     # Peripherals common to all JH7110 boards
> >    |- jh7110-starfive-visionfive-2.dtsi # Peripherals common to VF2 boards
> >    |  |- <VF2 boards>     # Final VF2 board descriptions
> >    |- jh7110-milkv-marscm.dtsi # Peripherals common to Mars CM boards
> >    |  |- <Mars CM boards> # Final Mars CM board descriptions
> >    |- <other boards>      # Other JH7110 board descriptions
> >
> > With this series it moves to
> >
> > jh711x.dtsi
> > |- jh711x-common.dtsi
> >    |- jh7110-common.dtsi
> >    |  |- <jh7110 boards>
> >    |- jh7110s-common.dtsi
> >       |- <jh7110s boards>
> >
> > ..which I can't even give clear labels like above. In other words when new
> > patches are sent in it would not be easy to explain exactly where each change
> > should go and why.
> > I'm also worried that you'll find that more of the peripherals on the JH7110S
> > need special handling and a new jh7110s-... compatible string. Then I guess
> > they'll need to jump from jh7110x.dtsi two levels down to jh7110{,s}-
> > common.dtsi which then both describe SoC and board properties.
> >
> > If you're serious about calling this a new SoC then I'd expect something more
> > like this:
> >
> > jh711x.dtsi                  # Peripherals common to both SoCs
> > |- jh7110.dtsi               # JH7110 SoC description
> > |  |- jh7110-common.dtsi     # Peripherals common to all JH7110 boards
> > |     |- jh7110-starfive-visionfive-2.dtsi # Peripherals common to VF2 boards
> > |     |  |- <VF2 boards>     # Final VF2 board descriptions
> > |     |- jh7110-milkv-marscm.dtsi # Peripherals common to Mars CM boards
> > |     |  |- <Mars CM boards> # Final Mars CM board descriptions
> > |     |- <other boards>      # Other JH7110 board descriptions
> > |- jh7110s.dtsi              # JH7110S SoC description
> >    |- jh7110s-common.dtsi    # Peripherals common to all JH7110S boards
> >       |- <JH7110S boards>    # Final JH7110S board descriptions
> >
> > I know this will mean some duplication in jh7110{,s}-common.dtsi, but I
> > would prefer that to not having a clear explanation of what each file describes.
> >
> > Do you think this layout could work for you?
>
> Yeah, it is clearer for developers and maintainers.
>
> Considering Conor's suggestion, what about:
>
> jh7110.dtsi               # JH7110 SoC description
> |- jh7110-common.dtsi     # Peripherals common to all JH7110 boards
>    |- jh7110-starfive-visionfive-2.dtsi # Peripherals common to VF2 boards
>    |  |- <VF2 boards>     # Final VF2 board descriptions
>    |- jh7110-milkv-marscm.dtsi # Peripherals common to Mars CM boards
>    |  |- <Mars CM boards> # Final Mars CM board descriptions
>    |- <other boards>      # Other JH7110 board descriptions
> |- <JH7110S boards>
>
> Move the opp table from jh7110.dtsi to jh7110-common.dtsi.
> Remove jh7110s-common.dtsi, because only one board uses JH7110S now.

This patchset adds 2 different boards. Has this changed?

Also this would mean that you're not using the starfive,jh7110s compatible or
any other starfive,jh7110s-.. compatible strings, so effectively you're not
treating it as a new chip, but just a board that needs a different opp table.

I see now that the opp table is effectively the only difference between the two
chips in this patchset, so if that's closer to reality then what you suggest is
fine with me.

/Emil

