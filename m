Return-Path: <linux-kernel+bounces-871640-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F900C0DE7F
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 14:13:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EAFBD3A6FDD
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 13:07:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 033892580FB;
	Mon, 27 Oct 2025 13:07:26 +0000 (UTC)
Received: from mail-io1-f50.google.com (mail-io1-f50.google.com [209.85.166.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF3D22472BA
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 13:07:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761570445; cv=none; b=JtrlSCpOTChgndV4eIJcPVJpIxau7ze+lCqR93gQnY4IxsnMBMKUnX/aIwuJVEoshyQpekBTjjfoyB5QtaEWZskdruVz738yS58xX7MMvZUgWziotitnr2iTTQo3R6K9GWlE/O0r/WGyjpIr2PoMvPrqQv16byU87xSsj1J6ETA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761570445; c=relaxed/simple;
	bh=bwESskb9ZqdlwJb+BKR+lDbeJG3koqiFva6ys/hs5kU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EXLixY9LGWZTmmUsr+DYVdylwRKlglkB1VcXe9aJef59LVjOcerflreQy4R5U/iucP3JkkCqXt9trSDugkOtFzmK/9ZkhqdVos2F3UtifkQBqBUBUjr8sPEkbmydDc3Xatr0wwKRuX8n3vv0jcYvMr+V8V7pAuQZrvjnmghEiys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.166.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f50.google.com with SMTP id ca18e2360f4ac-94359aa7f60so263487539f.0
        for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 06:07:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761570443; x=1762175243;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yOYdLIvACytBpVHjrdATGnV0/c7ZzUCpXjvbRDnZ37c=;
        b=YjJL9p9fnJGl3jSAYVIASUrwwdeb5IrwtCtOUNgkKgU0Z2zJaCWgH3w1eX+l4/ipyX
         fQLzQ/2hxXJYYgCtwdAF2Z4yFQf7N1bxbbVAKDxtu/uG5Tr0cSyQqEqK7wVhlKYeezBG
         8EaR2FsGSSzU6t3UZptlx9GBx5hzi9JsRpxQ1yfiakcDtCIOxX8+CAAm1trmRSCT3rUr
         qpKYpxgDQo1S3+UnftqcO0UUjJQM3U03mSHXuUqPwAEYKvgq4ftKm7I2BGoi6GgtddI4
         dtsy/VRaITZIwln14iGQ7nV5hLcUPZY4cPESMQvsR2izVkEkFC1vpgpV+lx8bVteEsww
         DASg==
X-Forwarded-Encrypted: i=1; AJvYcCVZr62oEr2mnYeGHS9hF/RI7Qgng3AAZsGDL23ucIND4S77pL582R37SVVK1LBN5q+EsHqKQc4TrJ7wuMA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzSJ3P4pDw6mncNLOtNBExd7auvlmtmymTw+slL/EutXGFnJMH4
	qDHsfx+VE6YocTHp3jPOTTioAOsvNZvIiY9H2isysV63ez7x8e16mOkjLuR5gQ9O
X-Gm-Gg: ASbGncuRtCyqMjUfTu174Z0yj5yuDKQ2BasHhPZUaT5tGWPVLv0BxvTu3G3EVu6pjNc
	blK1pVgmgya6HXIjFjiS4nyTLfinDVCdcD+FKaSwH1BNcGAJRey6HRw60v4jhH3e+tK2KONTWBW
	lYR/5vKY3wmexKSW4eViIc4TBE7soVHk8b/g1PRjlm6GBVSNlBjBerO1pPe6bHDu2oOw7NqlN+X
	rAURLYAJUgwG2JQq/C14T82+yVkHFSg90JoFfkjdGA2q2J9KmtN9dsJ3kUFIvYuaUp1otbqK8yK
	TQdDFAejvtaLHqi+uhquwf6ERJgFa7flV/Jc+DGFUvy7uI2gctLhTvAuBN9UKCd/M2jBWLTGbAn
	GEn5gfppj7nR1XwAW+klS/Nrz7PJK1yv4avb9JFeKxVCpA12qlVA2UOffZ9432zdepiOs1FQNZB
	hb9Umh25Oljp7w8Pa99gqq03V4PeTY9YchwPgy59GK2g==
X-Google-Smtp-Source: AGHT+IHfuWXbvLQpJRNWxr2H/EOiLBAmgrAacx9a0utbK/fHXFfqVzwQFNzu//+ZStZNGNYyCF11vQ==
X-Received: by 2002:a05:6830:6d15:b0:7c6:76b9:db24 with SMTP id 46e09a7af769-7c676b9dccemr72049a34.4.1761570072323;
        Mon, 27 Oct 2025 06:01:12 -0700 (PDT)
Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com. [209.85.167.179])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7c5301e32fesm2197346a34.16.2025.10.27.06.01.12
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Oct 2025 06:01:12 -0700 (PDT)
Received: by mail-oi1-f179.google.com with SMTP id 5614622812f47-44d9bd21422so1732544b6e.2
        for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 06:01:12 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUbJGUo/x1nqrNN9tATl+qKq7k0hVcyCizcd3QRuBiaDy08X18RIokoxbShgQ9g8OlAVPWD369u78kTMaI=@vger.kernel.org
X-Received: by 2002:a05:6102:26d4:b0:522:86ea:42c with SMTP id
 ada2fe7eead31-5d7dd5a64c5mr10674902137.11.1761569636629; Mon, 27 Oct 2025
 05:53:56 -0700 (PDT)
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
 <01573262-69a8-44cf-ae02-2e9842c59dde@lunn.ch>
In-Reply-To: <01573262-69a8-44cf-ae02-2e9842c59dde@lunn.ch>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 27 Oct 2025 13:53:45 +0100
X-Gmail-Original-Message-ID: <CAMuHMdXAOPemhTjdJqminXhi+1+Dsc5rN1GLqAUcfF3ZyphRoQ@mail.gmail.com>
X-Gm-Features: AWmQ_bnc0FKdJRTj1IhXsyeFKk3WmW431oeoaAfsizI36RwwOH6YiF14-6GD61A
Message-ID: <CAMuHMdXAOPemhTjdJqminXhi+1+Dsc5rN1GLqAUcfF3ZyphRoQ@mail.gmail.com>
Subject: Re: [PATCH v6 4/6] arm64: dts: aspeed: Add initial AST2700 SoC device tree
To: Andrew Lunn <andrew@lunn.ch>
Cc: Ryan Chen <ryan_chen@aspeedtech.com>, Arnd Bergmann <arnd@arndb.de>, 
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

Hi Andrew,

On Mon, 27 Oct 2025 at 13:01, Andrew Lunn <andrew@lunn.ch> wrote:
> On Mon, Oct 27, 2025 at 02:42:01AM +0000, Ryan Chen wrote:
> > > Subject: Re: [PATCH v6 4/6] arm64: dts: aspeed: Add initial AST2700 SoC device
> > > tree
> > >
> > > > SoC0, referred to as the CPU die, contains a dual-core Cortex-A35
> > > > cluster and two Cortex-M4 cores, along with its own clock/reset
> > > > domains and high-speed peripheral set.
> > >
> > > > SoC1, referred to as the I/O die, contains the Boot MCU and its own
> > > > clock/reset domains and low-speed peripheral set, and is responsible
> > > > for system boot and control functions.
> > >
> > > So is the same .dtsi file shared by both systems?
> >
> > This .dtsi represents the Cortex-A35 view only and is not shared
> > with the Cortex-M4 or the Boot MCU side, since they are separate
> > 32-bit and 64-bit systems running independent firmware.
>
> DT describes the hardware. The .dtsi file could be shared, you just
> need different status = <>; lines in the dtb blob.
>
> > > How do you partition devices
> > > so each CPU cluster knows it has exclusive access to which peripherals?
> >
> > Before the system is fully brought up, Boot MCU configure hardware
> > controllers handle the resource partitioning to ensure exclusive access.
>
> Are you saying it modifies the .dtb blob and changes some status =
> "okay"; to "disabled";?

"reserved" is the appropriate status value for that.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

