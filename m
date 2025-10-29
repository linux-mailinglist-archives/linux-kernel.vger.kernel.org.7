Return-Path: <linux-kernel+bounces-875657-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 53F3CC19859
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 10:57:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D863E1891C3C
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 09:57:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6DB7329C52;
	Wed, 29 Oct 2025 09:56:46 +0000 (UTC)
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAD3F325487
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 09:56:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761731806; cv=none; b=Q28SahcdZ39vJnfLS4u/rZWfGdkFPfzlIsrLQGJ4y3ndQlHMrFMQDQZFp3EoZNOPMZr3LqB1u0YEOw7V7WhEBlJlZkCULPyU54LTzWQAaEpNYKX5c4rDm7vP2Hl9NeUnWJfzfYe56ATTm2981Wn3Wc11+5e0oGVCwDsIhCoKoLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761731806; c=relaxed/simple;
	bh=WFpySCPpyBEuYY1GGmOmu9SMBn1hRDK+TPw/QGcBR+Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LO1Z8cwqA8eYuKJ0TgEftIy6c8dTz/RWE/PPcx+6Y7txsDp2GMaEoup9epUhICCILtyuKvq/0IRMfH54FOkTwGuUZhrgn17Iu3rv2UNB8m7Yo3NYKtqdXKbTKAPiE2aRfDS8H9azpU563VUt//OyxHDca+LFEUB29pXek0GVFts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-87fc4d29301so68412706d6.2
        for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 02:56:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761731803; x=1762336603;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tdMmTEVXmrdUQVal1cKnxdF6jTyKX4No0foVL6qsIc0=;
        b=v/70GwUlfZ4jzK4CEudqN1soGdPJy55syUwMOI4wL4vgaYTaeQ1NKPofaX/hUGIRkG
         OQQrkwKQ7YvBB/DHMZ2qH9eWFX4lkwpdNCTyPPtWT9dPUPtPcEhfJEVTZM9OHq7v8YJY
         LUusQzEgAowN3yUrFWOQ3tayjnfeC8Dn0H4Nsy8ufxKkTzopZXyxF0DVMmcbHbmIon3T
         +h8BP11nDlGWFQoZDpm8Ys+jD6RhQ4SXxnvOqteH4UNVihpGqFwljWwxWl4TpJjFOgqN
         NqQLTFbv5iWo8JNkrf4ugmc23MLQh5I38pbzfBvELAbvGw5cnOhiXpGNRYvlbXym4Wg4
         GGwA==
X-Forwarded-Encrypted: i=1; AJvYcCWLzQcD/JtocREkR/YB+/zQlhj1cHqD20hRZp7Pzn4jyVneXnLcXsAns8MYlrvcBKHIbJXAed/3bmcPkNM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8aE6CdagN5uGD5fbzPjdvtvHtf8TU0uCUBk5lVp/cGgM72ZbQ
	z2S4hRi/xNKz9urP1dCo2VTE8fxoYC8mzy3jIRtGoxCGPIwshwolpjtT/xt7RkQo
X-Gm-Gg: ASbGncuZOt6jKv8s2zAZNOCGMW2CR3lP+6Ye1CcXcd+UWx4DOIT/gHgruPFI0kEegNC
	8JqVeQvUds/Kme3ieXhVkepIm8LHITefvyQTaSXrF3zm6711372lnicRXBw05WenbDv2ZaZKW23
	tiVX9Ttu4aJ3WBCpuLth5uur8JR1031WnTf5C60FBGVgghweoIAAAC+w9ntQhniIISLi1F0yrfa
	vsPQGzvSMTtS+B2AYbRQgO2fU+VAop/VPvyDy49voIIEfv8xPlV0F+Ner5knfhIaGcSOQgEosQ1
	XFZ5HE77XllSqOgB85kHedV/1Gtw4dv3DpoM2N8ZaQVFrFP9PAqLPDDWI6zmcjdtMoM7DmG9zNc
	DGRhRrQ5GJAeVH68PufqQhV747270pkb5ScburOvV4HEEO9mrY50NEpinWL9pfw0XC4u5ohbSPU
	93wjR2CLj1yQviFpuosIkES6Y55S0g8z7xLXqZ76WcbFrHuYtvpp6v
X-Google-Smtp-Source: AGHT+IEXwrxXZtRS7vLqXrKKgb0bnYHs0dXSnFaumfgTVTL47MJdEUCbnIheDsaMvP2ILfrjB0C2Tg==
X-Received: by 2002:a05:622a:1a99:b0:4ec:3cfb:557d with SMTP id d75a77b69052e-4ed15c03b48mr24969841cf.62.1761731803256;
        Wed, 29 Oct 2025 02:56:43 -0700 (PDT)
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com. [209.85.160.175])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4eba386b6b9sm89898501cf.33.2025.10.29.02.56.42
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Oct 2025 02:56:43 -0700 (PDT)
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-4ecf2244f58so31018261cf.3
        for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 02:56:42 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUzF/qFG61crAzZc2eUIbmvWKR98xQPPDb297ohlkTSjfTI8chMu0x8Aw5g3tSOO0k5RrgNCTXR8uYjm9A=@vger.kernel.org
X-Received: by 2002:a05:6102:d87:b0:5d5:f6ae:390a with SMTP id
 ada2fe7eead31-5db906e1ea2mr632557137.40.1761731454123; Wed, 29 Oct 2025
 02:50:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251022070543.1169173-1-ryan_chen@aspeedtech.com>
 <20251022070543.1169173-5-ryan_chen@aspeedtech.com> <b5441728-06a7-44ea-8876-3a9fc3cf55be@app.fastmail.com>
 <TY2PPF5CB9A1BE626A2F0F6307461D8F64BF2F0A@TY2PPF5CB9A1BE6.apcprd06.prod.outlook.com>
 <6a97fbb4-19c2-4ffa-9c73-26aea02c27e4@app.fastmail.com> <TY2PPF5CB9A1BE6CF8336D211641A18E2DEF2F1A@TY2PPF5CB9A1BE6.apcprd06.prod.outlook.com>
 <71df9bdf-53b2-45e2-a9e3-5b00a556f957@lunn.ch> <TY2PPF5CB9A1BE6F3E95C7FD61CF4F90ECAF2FEA@TY2PPF5CB9A1BE6.apcprd06.prod.outlook.com>
 <fdbc471f-514e-4521-b7a1-dcf6127d64ff@lunn.ch> <TY2PPF5CB9A1BE6DD93D0F397C961D5CB5AF2FCA@TY2PPF5CB9A1BE6.apcprd06.prod.outlook.com>
 <01573262-69a8-44cf-ae02-2e9842c59dde@lunn.ch> <TY2PPF5CB9A1BE665D988A413B8BCD5CA27F2FAA@TY2PPF5CB9A1BE6.apcprd06.prod.outlook.com>
 <7c0c966b-c45f-47ad-9243-b945036a9bd2@app.fastmail.com>
In-Reply-To: <7c0c966b-c45f-47ad-9243-b945036a9bd2@app.fastmail.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 29 Oct 2025 10:50:43 +0100
X-Gmail-Original-Message-ID: <CAMuHMdVueyxmATwS_EnqBBPtX-O0bw6Ubnj-Dey8wN=pEvo_zA@mail.gmail.com>
X-Gm-Features: AWmQ_blS6idckwhpIjkOWHP0NGDWxrc7vZpSwkjlsFZQOSpuaInPPIOtTjyVPpU
Message-ID: <CAMuHMdVueyxmATwS_EnqBBPtX-O0bw6Ubnj-Dey8wN=pEvo_zA@mail.gmail.com>
Subject: Re: [PATCH v6 4/6] arm64: dts: aspeed: Add initial AST2700 SoC device tree
To: Arnd Bergmann <arnd@arndb.de>
Cc: Ryan Chen <ryan_chen@aspeedtech.com>, Andrew Lunn <andrew@lunn.ch>, 
	BMC-SW <BMC-SW@aspeedtech.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, 
	Andrew Jeffery <andrew@codeconstruct.com.au>, Jeremy Kerr <jk@codeconstruct.com.au>, 
	Lee Jones <lee@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
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

Hi Arnd,

On Wed, 29 Oct 2025 at 08:26, Arnd Bergmann <arnd@arndb.de> wrote:
> On Wed, Oct 29, 2025, at 03:31, Ryan Chen wrote:
> >> Subject: Re: [PATCH v6 4/6] arm64: dts: aspeed: Add initial AST2700 SoC device
> >> tree
> >>
> >> On Mon, Oct 27, 2025 at 02:42:01AM +0000, Ryan Chen wrote:
> >> > > Subject: Re: [PATCH v6 4/6] arm64: dts: aspeed: Add initial AST2700
> >> > > SoC device tree
> >> > >
> >> > > > SoC0, referred to as the CPU die, contains a dual-core Cortex-A35
> >> > > > cluster and two Cortex-M4 cores, along with its own clock/reset
> >> > > > domains and high-speed peripheral set.
> >> > >
> >> > > > SoC1, referred to as the I/O die, contains the Boot MCU and its
> >> > > > own clock/reset domains and low-speed peripheral set, and is
> >> > > > responsible for system boot and control functions.
> >> > >
> >> > > So is the same .dtsi file shared by both systems?
> >> >
> >> > This .dtsi represents the Cortex-A35 view only and is not shared with
> >> > the Cortex-M4 or the Boot MCU side, since they are separate 32-bit and
> >> > 64-bit systems running independent firmware.
> >>
> >> DT describes the hardware. The .dtsi file could be shared, you just need
> >> different status = <>; lines in the dtb blob.
> >
> > Could you please share an example of a .dtsi that is shared between
> > different CPU architectures?
>
> I can think of three that are shared between arm and riscv, with both
> able to boot Linux using a variation of the same device tree, with
> the .dtsi file being included from the respective other side:
>
> arch/riscv/boot/dts/renesas/r9a07g043f.dtsi
> arch/arm/boot/dts/allwinner/sun8i-t113s.dtsi
> arch/arm64/boot/dts/sophgo/sg2000.dtsi
>
> All of these however use the same basic physical address layout
> as seen from the two CPUs, with only the set of on-chip devices
> being slightly different, such as using the native irqchip
> instance per CPU.

I can't speak for the last two ones, but the first one is not what Ryan
is looking for, as r9a07g043 has either an ARM (r9a07g043u) or a
RISC-V (r9a07g043f) CPU core, not both.

> In the AST2700 design, even though we have both Cortex-A35 (64-bit)
> > and Cortex-M4 (32-bit) cores, each runs in a distinct address space
> > and sees a different memory map.
>
> This is similar to the Cortex-M4 on i.MX7D. This is supported by
> the Linux code, but I don't see the corresponding dts file for it now,
> it may have never been merged.

The keyword here is "System DT", where you have a single file describing
the whole SoC. From this, separate DTS files are generated that
describe the view for the application CPU core, real-time CPU core,
control CPU core, etc...

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

