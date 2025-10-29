Return-Path: <linux-kernel+bounces-875661-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 712EEC1987A
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 10:58:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 86BEC19C3216
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 09:58:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AADEE328618;
	Wed, 29 Oct 2025 09:58:15 +0000 (UTC)
Received: from mail-io1-f44.google.com (mail-io1-f44.google.com [209.85.166.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 244C42F6596
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 09:58:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761731895; cv=none; b=XbSdRTUJBCsKnb0FXpWKHklyzU4LU85BfWrNr+CI37X73BJjWZoI1fiphfjYWz2uKFOsGoAS5jXhWlxeFfuwq7z7sadpIciChulVs5M5klpDfibViJDxYDppLPSEUb43IcB1wFs3W6Sw1hcMUFaAtfGNTUTqxxsqsGySlrnHor0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761731895; c=relaxed/simple;
	bh=6umXQY7PxYDhxCFHBGVvm62ZCKDd9XvEuaC2neC8JOQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BaryaAfTUkjliBmEoycM1Hf50ECI/ouR+HxpYwVclPuGF+rDLisWNHSspBC6pZsJiqP5cIKenLfqEt//+AqachrGWg8QVrnDdm3U2hruQELMVzsseaQrw7xMJl7iOHQEogzEwHQzOpzlDuagigNxFbzGzNoc+QVHVkRGwTYomCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.166.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f44.google.com with SMTP id ca18e2360f4ac-943b8b69734so467482539f.3
        for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 02:58:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761731892; x=1762336692;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dn3HJmw1LqF1sl88KtOEIxVUxtlj7baFmpOOANtcNAA=;
        b=mQcTA6HvIWjBJEJzX1andwBxFiI2ARAlB0AvefsSSU54LhZRdJPzUkC1tw41GM+Eyo
         0GFaJWthDRLaLG2D53dXdci7Y4eSmTWDGHCb4LxyXek6bOpZlTa2T4UoCKf7JPLdlVw2
         iYtTQyhKo9s1Z+RdMmgej5J/cc3MOoNQlaVzA9ehUzVicHGVybkclhm3wqu//ut3kc5P
         t42aqERkJizLE7d2l4TXL3GcS0zOQxRGM/gFTQZrv3lL/tOHhMDinqCN02wjC8kI2QKT
         JS6jhtHAe93gPg6T8d5WQKDL+zKhNCVgUv+OcWpv6T4WSJw1DV2LzRubN+eT4TdrnnId
         dCnA==
X-Forwarded-Encrypted: i=1; AJvYcCXAtUreV4ejo5OiclRWYOx4GPVdI0T0jj0dA0zCFX8rz4zgvsRJFaLKr9n7T2W6SVpj9Zm53oOJbrqhvtw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwSYzNPdVnSintiaOV9SX605RpxRqoG/dUFzz7otLMUsQzM+hP3
	oXF1PupCndzqCx2enCh9fut9H5Ncel06lazQQp4U2zzogiTf/tigK3GktDmwVWVS
X-Gm-Gg: ASbGncuODDLy8eGbv0CLFj1otr9nY9/vSzaREk3c5CqonN757fPrGT9EG8ImpMLIR74
	b4+yNMUqnPs7nhKAGKeS18sSPdYoMCj5WinAo1nEOFa49mG8p4Kd3kUbVgCDgElI51mpiJESL7q
	DX7p+M9dPgUefHuKlYQZzUjYrd93FS0GL7fy0SPmBo+cQnU1Ze7hhlMESWQZp8tcOBg8vmJM2kL
	3h9gqhzWkjlyoNq2b99N0Kf9YPxzKIoDAQ4a9E1nMGAv0ZUq0kkSGqJBMlQMq+2FqJuNCaAa2A+
	1iR2GVe3/KWYa5v4it9U/i5amPWbwQx0aRzQ+IaQMwmKfRxKipeuCjDs5RmCPH504uATQzj/6fL
	7IE7MemZxz4rj3b77znAkt1NCNTWUIuRbywBUH3zolLXdBccWsbAiNApNgJutw53Ge/ALAJxoQI
	CnfK5+HZcMuUe3upDas7y+vcQvHxiyJNnfgbydUA==
X-Google-Smtp-Source: AGHT+IH2TXxqZJrpO8wgcWMGnFMGestfRw8J4c39fHbTqWKqyzT0NZP2zVSEssm/NDMLUugyReiCXw==
X-Received: by 2002:a92:cda3:0:b0:423:fcd6:5488 with SMTP id e9e14a558f8ab-432f8fad5a7mr36621095ab.12.1761731891933;
        Wed, 29 Oct 2025 02:58:11 -0700 (PDT)
Received: from mail-io1-f49.google.com (mail-io1-f49.google.com. [209.85.166.49])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-431f688b589sm52781005ab.25.2025.10.29.02.58.11
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Oct 2025 02:58:11 -0700 (PDT)
Received: by mail-io1-f49.google.com with SMTP id ca18e2360f4ac-94359aa7f60so479539139f.0
        for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 02:58:11 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWEskru+5Lm+wh9LKdmWpTYj07IZrPnQ8cFK9IOZ4zlYwXZhDlWr3q+w9rfvwwdJuwmTI1JX++yM9uS5+c=@vger.kernel.org
X-Received: by 2002:a05:6102:942:b0:5d7:de89:ddd6 with SMTP id
 ada2fe7eead31-5db9057bad9mr557441137.1.1761731536861; Wed, 29 Oct 2025
 02:52:16 -0700 (PDT)
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
 <01573262-69a8-44cf-ae02-2e9842c59dde@lunn.ch> <CAMuHMdXAOPemhTjdJqminXhi+1+Dsc5rN1GLqAUcfF3ZyphRoQ@mail.gmail.com>
 <TY2PPF5CB9A1BE6D0FC241696E44EB1F463F2FAA@TY2PPF5CB9A1BE6.apcprd06.prod.outlook.com>
In-Reply-To: <TY2PPF5CB9A1BE6D0FC241696E44EB1F463F2FAA@TY2PPF5CB9A1BE6.apcprd06.prod.outlook.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 29 Oct 2025 10:52:05 +0100
X-Gmail-Original-Message-ID: <CAMuHMdWKsyt_bXaJ=smtCaGst_5O2trQakxmaKp2K1Jzc=Y9uA@mail.gmail.com>
X-Gm-Features: AWmQ_bnPsVrgzrwpS4yuU54P6rGfuwJuhD3QhZm5C-G0nVGXJf4URRbbI7AGLcc
Message-ID: <CAMuHMdWKsyt_bXaJ=smtCaGst_5O2trQakxmaKp2K1Jzc=Y9uA@mail.gmail.com>
Subject: Re: [PATCH v6 4/6] arm64: dts: aspeed: Add initial AST2700 SoC device tree
To: Ryan Chen <ryan_chen@aspeedtech.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Arnd Bergmann <arnd@arndb.de>, BMC-SW <BMC-SW@aspeedtech.com>, 
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
Content-Transfer-Encoding: quoted-printable

Hi Ryan,

On Wed, 29 Oct 2025 at 03:38, Ryan Chen <ryan_chen@aspeedtech.com> wrote:
> > Subject: Re: [PATCH v6 4/6] arm64: dts: aspeed: Add initial AST2700 SoC=
 device
> > On Mon, 27 Oct 2025 at 13:01, Andrew Lunn <andrew@lunn.ch> wrote:
> > > On Mon, Oct 27, 2025 at 02:42:01AM +0000, Ryan Chen wrote:
> > > > > Subject: Re: [PATCH v6 4/6] arm64: dts: aspeed: Add initial
> > > > > AST2700 SoC device tree
> > > > >
> > > > > > SoC0, referred to as the CPU die, contains a dual-core
> > > > > > Cortex-A35 cluster and two Cortex-M4 cores, along with its own
> > > > > > clock/reset domains and high-speed peripheral set.
> > > > >
> > > > > > SoC1, referred to as the I/O die, contains the Boot MCU and its
> > > > > > own clock/reset domains and low-speed peripheral set, and is
> > > > > > responsible for system boot and control functions.
> > > > >
> > > > > So is the same .dtsi file shared by both systems?
> > > >
> > > > This .dtsi represents the Cortex-A35 view only and is not shared
> > > > with the Cortex-M4 or the Boot MCU side, since they are separate
> > > > 32-bit and 64-bit systems running independent firmware.
> > >
> > > DT describes the hardware. The .dtsi file could be shared, you just
> > > need different status =3D <>; lines in the dtb blob.
> > >
> > > > > How do you partition devices
> > > > > so each CPU cluster knows it has exclusive access to which periph=
erals?
> > > >
> > > > Before the system is fully brought up, Boot MCU configure hardware
> > > > controllers handle the resource partitioning to ensure exclusive ac=
cess.
> > >
> > > Are you saying it modifies the .dtb blob and changes some status =3D
> > > "okay"; to "disabled";?
> >
> > "reserved" is the appropriate status value for that.
>
> Thanks for the clarification.
>
> Since the SoC-level .dtsi is shared by all users (potentially other platf=
orms),
> I don=E2=80=99t actually know in advance which peripherals will be assign=
ed to
> which CPU. For this reason, marking nodes as `status =3D "reserved"` in t=
he
> .dtsi might be misleading.

Sure, not in the SoC-specific .dtsi.

> I think it=E2=80=99s more appropriate to keep all peripherals as
> `status =3D "disabled"` in the common .dtsi, and let each board-level .dt=
s or
> firmware-specific DT decide whether a device should be `okay` or `reserve=
d`
> depending on the actual resource assignment.

Correct.

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

