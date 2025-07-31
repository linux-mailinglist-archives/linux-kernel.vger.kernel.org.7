Return-Path: <linux-kernel+bounces-751779-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C7307B16D56
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 10:19:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DC19B18C5B87
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 08:19:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C1BE219314;
	Thu, 31 Jul 2025 08:19:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=antheas.dev header.i=@antheas.dev header.b="at0sdac7"
Received: from relay10.grserver.gr (relay10.grserver.gr [37.27.248.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 804AB82C60;
	Thu, 31 Jul 2025 08:19:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=37.27.248.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753949967; cv=none; b=b4dqdk42HqDTor/bDSQCXBBYfzU+oMq4frFrnkDdVWUO2XYD7niHSC6VBUQxORVEtG0tegWh7+omsPTOhsnxOOxahslpPB+MckyVuRJu2TZRmgR2wwd3MmHGgEWhKPE6NL9gwC4M//vS6T6p4svysde7LGG+mkjwUDuf8LhRdVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753949967; c=relaxed/simple;
	bh=TLGgVvQH4mRQfzLlME4UJMpsbF8BuqWSZSfKXGXO+e0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XQnGbgz4vvNFk5Or4fyeImrjtEYtd0rvX0ynNyn3fPODm2rfw4I3PvLLyGpg6CcMjbtO9aS7xOZCSnZqssEBhCKNLLu17c+1+D3xZzvHcWxTflfP98Q1DMwHSp7qcUsmFfCGPFVuz2RkflNvFJERdKldUC7pNSf6tmkaaYBpadY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev; spf=pass smtp.mailfrom=antheas.dev; dkim=temperror (0-bit key) header.d=antheas.dev header.i=@antheas.dev header.b=at0sdac7; arc=none smtp.client-ip=37.27.248.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antheas.dev
Received: from relay10 (localhost.localdomain [127.0.0.1])
	by relay10.grserver.gr (Proxmox) with ESMTP id 8E0D645ADC;
	Thu, 31 Jul 2025 11:13:42 +0300 (EEST)
Received: from linux3247.grserver.gr (linux3247.grserver.gr [213.158.90.240])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by relay10.grserver.gr (Proxmox) with ESMTPS id 4DD3345B01;
	Thu, 31 Jul 2025 11:13:41 +0300 (EEST)
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	by linux3247.grserver.gr (Postfix) with ESMTPSA id 579CB1FEA6C;
	Thu, 31 Jul 2025 11:13:40 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=antheas.dev;
	s=default; t=1753949620;
	bh=TLGgVvQH4mRQfzLlME4UJMpsbF8BuqWSZSfKXGXO+e0=;
	h=Received:From:Subject:To;
	b=at0sdac72yGZkrZY8AygkLv2HxbeMEibhNaSnf3vlL08cq7Sx6bwjz2um0ZfKkfM6
	 kAalp1Nfvx0zUdxQxr/ghAh4PJhaS6jQw3urgFHAw2kIcujylrnXKC/NCcD24wt0/4
	 2XFLjp2HpCuAsnlaBiYfZ1AGvxmCwPNCglqE1uAFGYUi4evaHAHT4EL0jhoaK/HNf+
	 HBZrtmd5q+n9NwlU3fLh6Twn6FINDmUFWHdPIRW5X3SiFjk3ydh21i1zCZE0zoWYsJ
	 6BdDefr02sbCeDidXbA3dhe51u0NilNzWGJxozpgKXU0ZUKZRhDx74L48EXZWTnm2X
	 u4lvFb1I5rjzA==
Authentication-Results: linux3247.grserver.gr;
        spf=pass (sender IP is 209.85.208.170) smtp.mailfrom=lkml@antheas.dev smtp.helo=mail-lj1-f170.google.com
Received-SPF: pass (linux3247.grserver.gr: connection is authenticated)
Received: by mail-lj1-f170.google.com with SMTP id
 38308e7fff4ca-32b4876dfecso17030011fa.1;
        Thu, 31 Jul 2025 01:13:40 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AJvYcCULpXTPWNfhq6kyKH/l7zhGrhHj1VHzbgVZFSs7vtwFDRiec5v+rjF0nGtwX+hk6xTNT1HONN0kjeNmcjE=@vger.kernel.org,
 AJvYcCVhfpsx3aNfQCFC8JIsKtMziZsTC3gI2h4O0MgBGVPGKku2qzKYCblznXGTtQANtmnxmYPoyYLMjRQ=@vger.kernel.org,
 AJvYcCXDTESHBrn//U2QlP7C+LhMHzcHaSDf/VnE5P832thH4+hzLi9+C1h8BqoSa8hKzj6zrkEBbZOrG5ZPayGP@vger.kernel.org
X-Gm-Message-State: AOJu0YzSaJ1hYNZLTUUSOKv84S9+SiczBqmY+NP7n77pv7q2mmnLqLAM
	/G4Ag4gougFB2dEYug86BqM6/3oQcpIrtTxfR+qiLtxpncgVddoZojhUTnWKdozZFDXcPm5YRUY
	VfLT2jiZNw3d/tsUtyIVhH8C8d+kWc0A=
X-Google-Smtp-Source: 
 AGHT+IF0ihgUV15N1zIXFEuH45tqPEsAY2OR6GLZ8mMrN+svm0o36ZE8rzwxWvHVwZ1jKWK+F6v3vwE3umH7v8fKzNg=
X-Received: by 2002:a05:651c:510:b0:32b:4932:d5ad with SMTP id
 38308e7fff4ca-3323c079421mr4366471fa.10.1753949619830; Thu, 31 Jul 2025
 01:13:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250314-gpd_fan-v6-0-1dc992050e42@gmail.com>
 <20250314-gpd_fan-v6-1-1dc992050e42@gmail.com>
 <CAGwozwENLOOS5q1Bs5SEh3FFJAY-=kcVimf5U+tWzy6HaiGd=g@mail.gmail.com>
 <bb57fe1d-fde9-45f8-9f5c-0836a6e557ff@roeck-us.net>
 <CAGwozwGdZ5tzHg7_TF5d_AWVDmypP987XS-x_GWqrSF81PiG2Q@mail.gmail.com>
 <B751D49737DD10DC+00a0ff95-476a-4d0a-9bc6-40e77012a554@uniontech.com>
 <d4b6932f-fe95-4502-b7c9-650a61ab565d@roeck-us.net>
 <4CFDED845BBB7FFB+10019dea-8229-4681-9beb-5f351eb8faf4@uniontech.com>
In-Reply-To: 
 <4CFDED845BBB7FFB+10019dea-8229-4681-9beb-5f351eb8faf4@uniontech.com>
From: Antheas Kapenekakis <lkml@antheas.dev>
Date: Thu, 31 Jul 2025 10:13:28 +0200
X-Gmail-Original-Message-ID: 
 <CAGwozwG13swYjCB6_Wm2h8a2CdHxam+2y=g1m42pynkKqqdDLg@mail.gmail.com>
X-Gm-Features: Ac12FXzf1BHcqy2v2VfenzQOGlkZIJo8ogU8OIEcwV2oamlb1bseNq9J_McSupI
Message-ID: 
 <CAGwozwG13swYjCB6_Wm2h8a2CdHxam+2y=g1m42pynkKqqdDLg@mail.gmail.com>
Subject: Re: [PATCH v6 1/2] hwmon: add GPD devices sensor driver
To: Cryolitia PukNgae <liziyao@uniontech.com>
Cc: Guenter Roeck <linux@roeck-us.net>, Cryolitia@gmail.com,
	Jean Delvare <jdelvare@suse.com>, Jonathan Corbet <corbet@lwn.net>,
 linux-kernel@vger.kernel.org,
	linux-hwmon@vger.kernel.org, linux-doc@vger.kernel.org,
	Celeste Liu <CoelacanthusHex@gmail.com>, Yao Zi <ziyao@disroot.org>,
	Derek John Clark <derekjohn.clark@gmail.com>,
 =?UTF-8?Q?Marcin_Str=C4=85gowski?= <marcin@stragowski.com>,
	someone5678 <someone5678.dev@gmail.com>,
 Justin Weiss <justin@justinweiss.com>,
	command_block <mtf@ik.me>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-PPP-Message-ID: 
 <175394962057.3529077.1896839385380914421@linux3247.grserver.gr>
X-PPP-Vhost: antheas.dev
X-Virus-Scanned: clamav-milter 1.0.9 at linux3247.grserver.gr
X-Virus-Status: Clean

On Thu, 31 Jul 2025 at 05:30, Cryolitia PukNgae <liziyao@uniontech.com> wro=
te:
>
> Personally, I'd prefer to maintain this small driver in the hwmon
> subsystem until we need to write drivers for the same EC with more
> diverse subsystem functionality. We can then discuss and learn how to
> evolve it. I personally don't think that's going to happen in the near
> future.
>
> So, could we continue reviewing the current patch series? Where are we
> stuck?

Either is fine by me. The move is simply a rename anyway. My reasoning
was it will take a bit of back and forth to get approved and charge
limiting is a standard feature now on all manufacturers except GPD, so
I expect them to add it soon. But since it is a rename, it is not a
blocker for reviewing in any case.

If you want more comments I think you should send a new current
version so it can be reviewed again. It has been a while since the
previous one.

Antheas

> =E5=9C=A8 2025/7/31 01:26, Guenter Roeck =E5=86=99=E9=81=93:
> > On 7/30/25 02:24, Cryolitia wrote:
> >> Thank you for raising this valid concern. We've closely monitored GPD'=
s
> >> development plans and currently see no indication of EC functionality
> >> expansion beyond thermal sensors in the foreseeable future. Given this
> >> observation, we believe placing the driver in hwmon remains appropriat=
e
> >> for now.
> >>
> >> That said, we fully respect your maintainer perspective on
> >> future-proofing. If you feel strongly that platform/x86 would be a saf=
er
> >> long-term home despite the current scope, we're happy to move the driv=
er
> >> there immediately. We're committed to finding the most sustainable
> >> solution for upstream.
> >>
> >
> > As hwmon maintainer, I feel strongly (since you used the word) that mov=
ing
> > the driver (or any hwmon driver, for that matter) out of hwmon space wo=
uld
> > be a bad idea, but I won't prevent you from doing it either. It means l=
ess
> > work for me, after all.
> >
> > Guenter
> >
> >
>
>


