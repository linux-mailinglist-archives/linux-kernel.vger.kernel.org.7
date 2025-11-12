Return-Path: <linux-kernel+bounces-898250-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 060B0C54AF2
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 23:09:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 870443AE36D
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 22:08:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BAE82E7BAD;
	Wed, 12 Nov 2025 22:08:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=antheas.dev header.i=@antheas.dev header.b="fQM32+Xh"
Received: from relay14.grserver.gr (relay14.grserver.gr [46.224.16.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9DE627E1D7
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 22:08:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.224.16.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762985301; cv=none; b=ejX88AiZ0QPKYSCJREWvLB6iAlkja0KGHMOrAh0aXyp4K3m3Wb0pRP/GEZEVyZXmoEofI/sqzAL0kqW/YivYXFDGki6cBe3aDN3qpvZPEo+39rrheC00uf+GyCQJyX7a1F2+bseWPFxcD5fpH1XgOETuOmiuy8wmXvklJBfNs8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762985301; c=relaxed/simple;
	bh=nFj3MPgKD8wiHxkzQl5+mK9jnuyJd5CVMF7U4hGoMuI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZHIdE8lfr2c0TAShwqx/jBtDSokyFjuWdmwPov7SR/lJ4B0jn/VbO+FJCiDXIesVrMSBWCRR1OTdp+FDXZwnq2FMB4V29T2KDa1o1IaxtPthNXPX6tkT2dckwAiUoBKhp54IAbPa60++RPusON6fOqjshH9kfdkOeRzioWr4n3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev; spf=pass smtp.mailfrom=antheas.dev; dkim=pass (2048-bit key) header.d=antheas.dev header.i=@antheas.dev header.b=fQM32+Xh; arc=none smtp.client-ip=46.224.16.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antheas.dev
Received: from relay14 (localhost [127.0.0.1])
	by relay14.grserver.gr (Proxmox) with ESMTP id CCC8E43F36
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 22:08:14 +0000 (UTC)
Received: from linux3247.grserver.gr (linux3247.grserver.gr [213.158.90.240])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by relay14.grserver.gr (Proxmox) with ESMTPS id BFEC743E30
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 22:08:13 +0000 (UTC)
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	by linux3247.grserver.gr (Postfix) with ESMTPSA id 1350D201CAC
	for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 00:08:12 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=antheas.dev;
	s=default; t=1762985293;
	bh=c263bVvypwdJeCaEVKrF3CaExbc+ogtgqHDqResTArk=;
	h=Received:From:Subject:To;
	b=fQM32+Xhwsi67PWAlFGeTAPw3ah4sSgt8KNy8T58I2A+401JmJ2Ciaqp6JfrD7TDN
	 mrCJIek+/JywJMZtL6kkG5RAHg7z2bkSrhWp40XoQA7d/bXfugPbRsy1uklT/ZSxAN
	 BJ30noUmYEApWx/huk3rDKUZKbIz28W9CSvdEvtt1pWanw8y091VTZnRdZpqwf1XuE
	 YAUMwd9f28WkMzYbBxaQ70FHLqW0DRJYmfxybz6NyS1CI0fJDhKDEjeuQZYixc6N+2
	 t2o7SGwMmyR6vAv17QFVLtoSl0EF1L57aTthLxsv2WGXjV5Lo4SQkMUlwCcagt4jSG
	 hBdK3HaasNh+Q==
Authentication-Results: linux3247.grserver.gr;
        spf=pass (sender IP is 209.85.208.181) smtp.mailfrom=lkml@antheas.dev smtp.helo=mail-lj1-f181.google.com
Received-SPF: pass (linux3247.grserver.gr: connection is authenticated)
Received: by mail-lj1-f181.google.com with SMTP id
 38308e7fff4ca-37a3d86b773so1706171fa.0
        for <linux-kernel@vger.kernel.org>;
 Wed, 12 Nov 2025 14:08:12 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCVuwr1c+84uno8SY6/Tm7Qa7LiCEbJRu423KtXzUIA2YgiwcXINwTemb9ob5ETzaDyVN0lnTSMh1NRnV4Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5mQNSAdBbjbFfuhuhCvZwzonvSIvoAzIYW1e3Yg00bs0tBXTs
	ny0wyTgXUjv2TpdT0h/do+SQ01T1PCDCCH6OvHULjrJfz66/8Re0Xg8OvV/lZv5oLgDVpy5lJxm
	ObKyLuyHHavVFb+aHTHylEXgtLLMW8CE=
X-Google-Smtp-Source: 
 AGHT+IGXgf+Lg0zEIPk/X5mf+uIHdsxnZGSlMH0aQHJGRVatz9TeHp1WXTXEyQ7PZHafLS09vgos3ZnaawMfkbsTS/E=
X-Received: by 2002:a05:651c:e18:b0:37a:2f0b:ef24 with SMTP id
 38308e7fff4ca-37b8c2dc2d4mr12431381fa.16.1762985292419; Wed, 12 Nov 2025
 14:08:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251101104712.8011-1-lkml@antheas.dev>
 <CAGwozwE+3vkm0-amRqnNJBzxTvXabgBF9h_G_vG_L7OJj91LBg@mail.gmail.com>
 <27a74ecc-bff7-f3ae-b23e-a8362ac3a6b3@linux.intel.com>
 <CAGwozwGpacR=wYXpf3vOiwWNxaV6pJ6CdE-E-G1gRRpO4VHVMg@mail.gmail.com>
 <74f91d3c-6494-4754-a10f-4d8c1d45f7ff@gmail.com>
In-Reply-To: <74f91d3c-6494-4754-a10f-4d8c1d45f7ff@gmail.com>
From: Antheas Kapenekakis <lkml@antheas.dev>
Date: Wed, 12 Nov 2025 23:08:00 +0100
X-Gmail-Original-Message-ID: 
 <CAGwozwEKqqJxxmtjJhy2MzNVhmBTMmy8xG5TZGkKJqJCgK=X5w@mail.gmail.com>
X-Gm-Features: AWmQ_bmAQVWsWS4B-rX0eFbpNfOxE54_DKqNtQJOsmT14pR81ypehUOlMWctnCk
Message-ID: 
 <CAGwozwEKqqJxxmtjJhy2MzNVhmBTMmy8xG5TZGkKJqJCgK=X5w@mail.gmail.com>
Subject: Re: [PATCH v8 00/10] HID: asus: Fix ASUS ROG Laptop's Keyboard
 backlight handling
To: Denis Benato <benato.denis96@gmail.com>
Cc: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	platform-driver-x86@vger.kernel.org, linux-input@vger.kernel.org,
	LKML <linux-kernel@vger.kernel.org>, Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
 Corentin Chary <corentin.chary@gmail.com>,
	"Luke D . Jones" <luke@ljones.dev>, Hans de Goede <hansg@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-PPP-Message-ID: 
 <176298529343.3647682.2191567193666860123@linux3247.grserver.gr>
X-PPP-Vhost: antheas.dev
X-Virus-Scanned: clamav-milter 1.4.3 at linux3247.grserver.gr
X-Virus-Status: Clean

On Wed, 12 Nov 2025 at 20:51, Denis Benato <benato.denis96@gmail.com> wrote=
:
>
>
> On 11/12/25 14:41, Antheas Kapenekakis wrote:
> > On Wed, 12 Nov 2025 at 14:22, Ilpo J=C3=A4rvinen
> > <ilpo.jarvinen@linux.intel.com> wrote:
> >> On Wed, 12 Nov 2025, Antheas Kapenekakis wrote:
> >>
> >>> On Sat, 1 Nov 2025 at 11:47, Antheas Kapenekakis <lkml@antheas.dev> w=
rote:
> >>>> This is a two part series which does the following:
> >>>>   - Clean-up init sequence
> >>>>   - Unify backlight handling to happen under asus-wmi so that all Au=
ra
> >>>>     devices have synced brightness controls and the backlight button=
 works
> >>>>     properly when it is on a USB laptop keyboard instead of one w/ W=
MI.
> >>>>
> >>>> For more context, see cover letter of V1. Since V5, I removed some p=
atches
> >>>> to make this easier to merge.
> >>> Small bump for this.
> >> I looked at v8 earlier but then got an impression some of Denis' comme=
nts
> >> against v7 were not taken into account in v8, which implies there will=
 be
> >> delay until I've time to delve into the details (I need to understand
> >> things pretty deeply in such a case, which does take lots of time).
> >>
> >> Alternatively, if Denis says v8 is acceptable, then I don't need to sp=
end
> >> so much time on it, but somehow I've a feeling he isn't happy with v8
> >> but just hasn't voiced it again...
> >>
> >> Please do realize that ignoring reviewer feedback without a very very =
good
> >> reason always risks adding delay or friction into getting things
> >> upstreamed. Especially, when the review comes from a person who has be=
en
> >> around for me to learn to trust their reviews or from a maintainer of =
the
> >> code in question.
> > Sure, sorry if it came out this way. Dennis had two comments on the V7
> > version of the series.
> >
> > The first one was that asusctl has a hang bug, which he hasn't had
> > time to look into yet. This should have been fixed by dropping the
> > HID_QUIRK_INPUT_PER_APP. I retested the series and that QUIRK was a
> > bit of a NOOP that does not need to be added in the future.
> So it is supposed to not regress it now, correct?
> > The second is he is concerned with dropping the 0x5d/0x5e inits. Luke
> > said (back in March) that it is fine to drop 0x5e because it is only
> > used for ANIME displays. However, for 0x5d, it is hard to verify some
> > of the older laptops because they have only been tested with 0x5d and
> > we do not have the hardware in question to test.
> >
> > For this series, I re-added "initialize LED endpoint early for old
> > NKEY keyboards" that re-adds 0x5d for the keyboards that cannot be
> > tested again so this comment should be resolved too. With that in
> > mind, we do end up with an additional quirk/command that may be
> > unneeded and will remain there forever, but since it was a point of
> > contention, it is not worth arguing over.
> >
> > So both comments should be resolved
> The driver should also not late-initialize anything.
>
> Windows doesn't do it and the official asus application
> can freely send LEDs changing commands to either WMI or USB
> so I don't see any reason to do things differently [than windows]
> and not prepare every USB endpoint to receive commands,
> this has not been addressed unless I confused v7 and v8?

Yes, it's been added on v8. 0x5d is init for the laptops it is
problematic for. Not because it does not work, but because it has not
been verified to work for those laptops.

> > @Denis: can give an ack if this is the case?
> >
> > As for Derek's comment, he has a PR for his project where he removes
> > the name match for Ally devices with ample time for it to be merged
> > until kernel 6.19 is released. In addition, that specific software for
> > full functionality relies on OOT drivers on the distros it ships with,
> > so it is minimally affected in either case.
> The part we are talking about depends on this driver (hid-asus)
> and there are people on asus-linux community using inputplumber
> for non-ally devices (the OOT driver is only for ally devices)
> therefore it is very important to us (and various other distributions)
> not to break that software in any way.

This driver is only used for Ally devices. If you mean that people
remap their keyboards using inputplumber I guess they could but I have
not seen it.

> Weighting pros and cons of changing the name I am not sure
> changing name brings any benefit? Or am I missing something here?
> It's simply used by userspace so the hardware should be loading
> regardless of the name...

Users see the name of their devices in their settings menu. They
should be accurate. Also, the early entry needs to be added anyway to
prevent kicking devices.

> Along with IP and your tool and asusctl there is also openrgb,
> and a newborn application for asus devices (I don't have contacts
> with that dev nor I remember the name of the tool)
> and I am not even that sure these are all asus-related
> applications.

My tool never checked for names, it briefly did for around a month
after its creation for some devices until capability matches. Around
6.1 and 6.7 the kernel changed the names of most USB devices and that
caused issues. It currently only uses name matches for VID/PID 0/0
devices created by the kernel. Specifically, WMI and AT Keyboards. I
am not sure there is a workaround for those. Asusctl also does not use
names either.

> Excercise EXTRA care touching this area as these are enough changes
> to make it difficult to understand what exactly is the problem if
> someone shows up with LEDs malfunctioning, laptop not entering sleep
> anymore or something else entirely. Plus over time
> ASUS has used various workarounds for windows problems
> and I am not eager to find out what those are since there is only
> a realistic way it's going to happen....

These changes are not doing something extraordinary. It's just a minor clea=
nup.

> > Moreover, that specific commit is needed for Xbox Ally devices anyway,
> > as the kernel kicks one of the RGB endpoints because it does not
> > register an input device (the check skipped by early return) so
> > userspace becomes unable to control RGB on a stock kernel
> > (hidraw/hiddev nodes are gone). For more context here, this specific
> > endpoint implements the RGB Lamparray protocol for Windows dynamic
> > lighting, and I think in an attempt to make it work properly in
> > Windows, Asus made it so Windows has to first disable dynamic lighting
> > for armoury crate RGB commands to work (the 0x5a ones over the 0xff31
> > hid page).
> Yes once ASUS introduces something new it sticks with that for
> future models so it's expected more and more laptops will have
> the same problem: I am not questioning if these patches are needed
> as they very clearly are; I am questioning if everything that these
> patches are doing are worth doing and aren't breaking/regressing
> either tools or the flow of actions between the EC and these USB devices.

Well, this series is needed to account for that. Sending the disable
command is out of scope for now though.

Antheas

> > Hopefully this clears things up
> >
> > Antheas
> >
> >>> Unrelated but I was b4ing this series on Ubuntu 24 and got BADSIG:
> >>> DKIM/antheas.dev. Is there a reference for fixing this on my host?
> >>> Perhaps it would help with spam
> >> I see BADSIG very often these days from b4 (thanks to gmail expiring
> >> things after 7 days or so, I recall hearing somewhere), I just ignore =
them
> >> entirely.
> >>
> >> AFAIK, that has never caused any delay to any patch in pdx86 domain so=
 if
> >> that is what you thought is happening here, it's not the case.
> >> If your patch does appear in the pdx86 patchwork, there's even less re=
ason
> >> to worry as I mostly pick patches to process using patchwork's list.
> > Turns out I had to update my DNS records. It should be good now.
> >
> >> --
> >>  i.
> snipp
> >>>> 2.51.2
> >>>>
> >>>>
>


