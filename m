Return-Path: <linux-kernel+bounces-868734-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A4734C05FD7
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 13:34:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B78661B8803F
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 11:29:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A374B31D36B;
	Fri, 24 Oct 2025 11:08:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fvKY3vqR"
Received: from mail-yx1-f53.google.com (mail-yx1-f53.google.com [74.125.224.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ECA131CA46
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 11:08:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761304101; cv=none; b=W0pqGuDZESfYWgWWOlJVewmqCTKWy3MMLUaWq5feeUy8SZ8rF0IkwqVfHYT0eoogtEL6xIdMCh7owjJcd+Vh1XUudtwOwimJ08MrijJDyJ1RBYG4bMvcguFokKFnOwpPuIzsW2w1U9Kru6koRdAHYVfBvUqK4Z0SnUbKajRCeAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761304101; c=relaxed/simple;
	bh=Qr8VI2WDLpClCnobZqQ04jtUbm8hJFOmR+11wkVoEH0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jfzeATU5W1snnBfo/WSSTPq8e4Oc4FxAYSfNy/g5oHQczjBVEcTLYdeAg7cGHy5kjX+ydbG+PMnv3GZyN6EntXKZ7tclIJuEsA6xwInycgXeI8JVq6aPQW/YqLjPiaoTcKHdUTil7wtozQFT5J6b1zZNOkvOiCsRZCwqxiGZRPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=fvKY3vqR; arc=none smtp.client-ip=74.125.224.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yx1-f53.google.com with SMTP id 956f58d0204a3-63e393c49f1so2213730d50.0
        for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 04:08:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1761304099; x=1761908899; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Qr8VI2WDLpClCnobZqQ04jtUbm8hJFOmR+11wkVoEH0=;
        b=fvKY3vqRXJ4BlMy5YlT2X3pgnH0X8TCfebpEQmTBrVultn9dvT4bRv15fLjbWl+JDf
         GBuQLfKNL3x7MQIVZs3DnMGRKNHsDIs/SNuH8TQqJBFYcYuuj5y1zTcGDmR6N1EkSb0a
         EeaVqnYfYAp79CTp1wW6HPlqQb3lVycwm1XVTdhhbsJLiEwckbz5C2iS2hXVYMBK3aJd
         JEIZeUF7tRzxeDDZAdri+uvi2Rcf28zHRgepS9FBe1WdvlFlonscl6DBDAqyYCl3X+LW
         Vsiz4s+4YyebagfM0LC4QTbzQFMecYLWzy1LQkjnrJJ+JM+PbJ+nLf4sHJ1Qe2RH1sZJ
         F/rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761304099; x=1761908899;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Qr8VI2WDLpClCnobZqQ04jtUbm8hJFOmR+11wkVoEH0=;
        b=vklB0NJAliVQnlWSxxnqsSsOY0aG9u/hmymU0w6gfT4vhu4kgyxvGak0FAJTPKKNhF
         ymi72hfxJi4huF+F15NZvNG/PezPOG1zeuuk5dsUOLBmp1R4JIMB188c/HW0jrER3yo+
         LJCioAm1hFjJ371Tv9Akj/DHa42CBAdbgEDC/leXuglUvhkAgfRcpkpwIdCqDWGC3DQk
         dXN7RpRutBZ/+0mZoOghVo5/+7jLqXOBy5Xk1VzuhbNhv3hlmknd5i/qcwXpcEKk+vHV
         +kA/PVnBXqODL0gfMIRPW4eJEbfKQfF0wjAQtFirDjGUD6ZwcbiaZxMGtJ/hdTVuQJc3
         7PUw==
X-Forwarded-Encrypted: i=1; AJvYcCUWDDfgBLDGnxvdHwF8EDjm9MBvgRZ7YYOPZCXlYlBOnlIb1xuAAB+ziP4FHT9/FWn8ilJWdy+QZ/51EG4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxWic4pIVV5IIBCbUIIE8UR3Sne23JqHFlB6EYuRpjeyi6GntXk
	iMcTzUDKI0lcEugYsbjPhhX3TYAtprDfcE07AvpZ79LNaxe5FdsfTimakCjlcIZ7Kpu/YT737Zw
	mTHE8CmUl5pN4QU1Xk7IbdM/FPA/ty5QIa42q6EM2bg==
X-Gm-Gg: ASbGncuQoVHqex5QfArlVIR+dt90WC4+tFZ2y06KnCUYhhNEBDKGvcQhWb1AVF2qHD9
	ELcRaelvSs7w1391XwmCfsKGbHXP9DDkfxAahaCq7FcWG/kolJR10SyPvKcmjn7lYSEMFvAWpva
	3o/kG0EJgt3Xuokw54nhreJjAPBIDVeYIx4t+CIQhvpCgOQfF0BXkJBjgB0ep4s4IgJ7xJKIO39
	8udLDwCKdb8Qb4gNs7NT9SzQcRmxEpJYuTgVOWxH/R4Ur7tqCnd5ygSpDe0VZ3GX/MyQfj8rLRF
	044vbuLB5yS1Y7xRgIqbJhqZK2s5SWMOW59nDWju
X-Google-Smtp-Source: AGHT+IFOV3V8o2HZhqqETlepYcrBmej0YD+DE4piL9lAUn6eKlq7J5U55V3yx6LRy0lafFZakyuR4ta00/fEgft/O94=
X-Received: by 2002:a05:690e:4188:b0:63c:f5a6:f2fd with SMTP id
 956f58d0204a3-63f435a7561mr1131720d50.63.1761304099000; Fri, 24 Oct 2025
 04:08:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <0f006338-e69b-4b3f-b91f-0cc683544011@kernel.org>
 <20251022114527.618908-1-adriana@arista.com> <20251022201953.GA206947-robh@kernel.org>
 <CAERbo5z6BzHqQxXdxPxmxE_eDR7GGGbt3A8kB0gQiWFBE-28Ug@mail.gmail.com>
 <CAMj1kXGYinTKiyYhNYWJvoJeUJScCGnyq=ozLgjKAm7_wzG8QA@mail.gmail.com>
 <CAERbo5waY-=6BLZ2SiJSFAXzvU57mJdM9q05vAZw8zR2yExQ5w@mail.gmail.com>
 <CAMj1kXHin5YacS98ttzHqFqy6HMukXKoLZtr-+bLwVRsWZUugQ@mail.gmail.com>
 <CAERbo5zgS8XoGcFB3wejqDpx14-SBr5oWn7pu3=PE0djRiKZqg@mail.gmail.com> <CAMj1kXEnSKF4VcMdOvUUuM-pOEWB38qPhWvUm13rnkQiZXp6SA@mail.gmail.com>
In-Reply-To: <CAMj1kXEnSKF4VcMdOvUUuM-pOEWB38qPhWvUm13rnkQiZXp6SA@mail.gmail.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Fri, 24 Oct 2025 14:07:43 +0300
X-Gm-Features: AS18NWCWgWLVov8ueny0nkngqHk4IxEbg4f6wBusDI4Ru3Cin08S3Jv6tCbD0eM
Message-ID: <CAC_iWjKQ5Smx5hOM9Lgyq_KD6D7OXyDsfJ4mcEnfw4JuRtxy-g@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] DMI: Scan for DMI table from DTS info
To: Ard Biesheuvel <ardb@kernel.org>, Adriana Nicolae <adriana@arista.com>
Cc: Rob Herring <robh@kernel.org>, krzk@kernel.org, jdelvare@suse.com, 
	frowand.list@gmail.com, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org, vasilykh@arista.com, arm.ebbr-discuss@arm.com, 
	boot-architecture@lists.linaro.org, linux-efi@vger.kernel.org, 
	uefi-discuss@lists.uefi.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Ard, Adriana

Thanks for cc'ing me.

On Fri, 24 Oct 2025 at 12:49, Ard Biesheuvel <ardb@kernel.org> wrote:
>
> On Thu, 23 Oct 2025 at 16:48, Adriana Nicolae <adriana@arista.com> wrote:
> >
> > On Thu, Oct 23, 2025 at 4:54=E2=80=AFPM Ard Biesheuvel <ardb@kernel.org=
> wrote:
> > >
> > > (cc Ilias)
> > >
> > > On Thu, 23 Oct 2025 at 15:34, Adriana Nicolae <adriana@arista.com> wr=
ote:
> > > >
> > > > On Thu, Oct 23, 2025 at 11:21=E2=80=AFAM Ard Biesheuvel <ardb@kerne=
l.org> wrote:
> > > > >
> > > > > On Thu, 23 Oct 2025 at 04:21, Adriana Nicolae <adriana@arista.com=
> wrote:
> > > > > >
> > > > > > On Wed, Oct 22, 2025 at 11:19=E2=80=AFPM Rob Herring <robh@kern=
el.org> wrote:
> > > > > > >
> > > > > > > On Wed, Oct 22, 2025 at 04:45:25AM -0700, adriana wrote:
> > > > > > > > Some bootloaders like U-boot, particularly for the ARM arch=
itecture,
> > > > > > > > provide SMBIOS/DMI tables at a specific memory address. How=
ever, these
> > > > > > > > systems often do not boot using a full UEFI environment, wh=
ich means the
> > > > > > > > kernel's standard EFI DMI scanner cannot find these tables.
> > > > > > >
> > > > > > > I thought u-boot is a pretty complete UEFI implementation now=
. If
> > > > > > > there's standard way for UEFI to provide this, then that's wh=
at we
> > > > > > > should be using. I know supporting this has been discussed in=
 context of
> > > > > > > EBBR spec, but no one involved in that has been CC'ed here.
> > > > > >
> > > > > > Regarding the use of UEFI, the non UEFI boot is used on Broadco=
m iProc which
> > > > > > boots initially into a Hardware Security Module which validates=
 U-boot and then
> > > > > > loads it. This specific path does not utilize U-Boot's UEFI
> > > > > > implementation or the
> > > > > > standard UEFI boot services to pass tables like SMBIOS.
> > > > > >
> > > > >
> > > > > What prevents this HSM validated copy of u-boot from loading the =
kernel via EFI?
> > > > The vendor's U-Boot configuration for this specific secure boot pat=
h
> > > > (involving the
> > > > HSM) explicitly disables the CMD_BOOTEFI option due to security
> > > > mitigations, only
> > > > a subset of U-boot commands are whitelisted. We could patch the U-b=
oot
> > > > to include
> > > > that but it is preferable to follow the vendor's recommandations an=
d
> > > > just patch U-boot
> > > > to fill that memory location with SMBIOS address or directly with t=
he
> > > > entry point.
> > >
> > > And what security mitigations are deemed needed for the EFI code? You
> > > are aware that avoiding EFI boot means that the booting kernel keeps
> > > all memory protections disabled for longer than it would otherwise. I=
s
> > > this allowlisting based on simply minimizing the code footprint?
> > >
> > From the information I have, it might be just minimizing the footprint
> > but the vendor's U-Boot configuration for this specific path
> > explicitly disables the CMD_BOOTEFI option. While the vendor cites
> > security mitigations for this configuration, the specific details
> > could be a set of mitigation removing different boot methods and some
> > memory access commands.
> >
> > The core issue is that this non-EFI boot path is the vendor-validated
> > configuration. Enabling EFI would deviate from this setup, require
> > significant revalidation, and could impact vendor support. Modifying
> > U-Boot to populate the DT is a contained change without modifying the
> > U-boot vendor configuration.
> >
>
> I'm not sure I follow why changing U-Boot's code would not require
> revalidation if simply changing its build configuration without
> modifying the source code would require that.
>
> > Beyond our specific vendor constraints, this DT method might be used
> > by any other non-UEFI arm system needing to expose SMBIOS tables to
> > the kernel.
> >
>
> Fair point. So let's do this properly: get buy-in from the U-Boot
> folks and contribute your u-boot changes as well. And ideally, we'd
> get this into the DMTF spec but if you are not set up for that (I
> think you might need to be a member to be able to contribute), we can
> find some ARM folks who are.

+1
U-Boot does offer an EFI implementation indeed, but we can't magically
force people to use it.
The problem with SMBIOS is that afaict is still widely used by various
debugging tools, so we might as well support it.
I agree with Ard here. I think the best thing we can do is
- Make the node standard in the DT spec, so everyone gets a reference
- Gatekeep any alternative implementations for the kernel until
someone gets this into the DMTF spec as well
- Send a patch to U-Boot that adds that mode dynamically if booting is
!EFI and SMIOS support is enabled

Cheers
/Ilias

