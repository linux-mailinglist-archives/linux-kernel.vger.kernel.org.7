Return-Path: <linux-kernel+bounces-727844-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BAE4B02080
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 17:34:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ED57B3A5D79
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 15:34:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9B2B2ED160;
	Fri, 11 Jul 2025 15:34:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PUNTLEV8"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88E8F2E7BD4;
	Fri, 11 Jul 2025 15:34:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752248071; cv=none; b=bd9mAx46vV1tJdf8vh6rilPK9lldI5SMvM4VRR9Uxi+6yWC0omr5v++UGQAoFjJKXGjEZupYrkRsLYyPVBIA3foIe7ADDlnhkdIMXje1TSnhR6zzJ0c5iA2GI2sjSIcIv1O6sBwiMdNDLB/8mehQVUUtKaS+XDtwS9nNJGSpzQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752248071; c=relaxed/simple;
	bh=ojsCePNq/X8gf7m07hkU+sqPZUt+ziDxVzUMSsGV7Os=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=Mo4AjtucyvAF/AAQX2By0+F5Xc6mSGWU47en7/HMZascUBb6I6fnnjl12q/xuBqhxhXu4jK85YVyg7C5KrT7cSdO+0QRklFHc++B5D0x8ey3aXh+ww5TZNvqrKmUI9FysjKqgLEUmbovKdIxs0ybD7nW344rfiiNfdolzL+Vd/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PUNTLEV8; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752248069; x=1783784069;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=ojsCePNq/X8gf7m07hkU+sqPZUt+ziDxVzUMSsGV7Os=;
  b=PUNTLEV8HHMYsQaWr5A1kGEF7bmDQ3RmMh9StwVjGUhFN3jjcOdv6GmS
   RGun+PkCkyR9ku4HAJIiTSpnatqx09PfsbB3QeUQfPpm/aWc0VYqfT/eZ
   KpJ490mzGb10bHpP+k0hacR4G9yFgJ11ec1Ntf/6e6C2ehX7NrClCpXBl
   aN/AqLgaWKa9nnWUBPrJJIW9mq/zwSYcku9Sjh5XTMupiqDR7EqROYvQD
   R/bqFWtwxdslQrJflVYGIQnSmDEzdPwOovTB5SAyAUvBTtP8ELD1hvhK7
   HohVMegl0DZ9GGYODdL/sQIDjZje9YFr7haqzTH5tJI5nAzdwrqc3D16E
   A==;
X-CSE-ConnectionGUID: GpyJ6jmyRe61xLBQYlwOaQ==
X-CSE-MsgGUID: n8dRyFSuTRyncv+4CtNygA==
X-IronPort-AV: E=McAfee;i="6800,10657,11491"; a="79982856"
X-IronPort-AV: E=Sophos;i="6.16,304,1744095600"; 
   d="scan'208";a="79982856"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2025 08:34:28 -0700
X-CSE-ConnectionGUID: Gb3zMplmT1WQomsGOwm0pg==
X-CSE-MsgGUID: WXMHAZLRQZCqjbmBfjaHIQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,304,1744095600"; 
   d="scan'208";a="156179376"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.249])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2025 08:34:25 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Fri, 11 Jul 2025 18:34:21 +0300 (EEST)
To: Arnd Bergmann <arnd@arndb.de>
cc: Arnd Bergmann <arnd@kernel.org>, 
    "Derek J. Clark" <derekjohn.clark@gmail.com>, 
    Mark Pearson <mpearson-lenovo@squebb.ca>, Hans de Goede <hansg@kernel.org>, 
    Armin Wolf <W_Armin@gmx.de>, ALOK TIWARI <alok.a.tiwari@oracle.com>, 
    Mario Limonciello <mario.limonciello@amd.com>, 
    Jelle van der Waa <jvanderwaa@redhat.com>, 
    platform-driver-x86@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] platform/x86: lenovo: gamezone needs "other mode"
In-Reply-To: <fd1f6732-e091-48e8-90c9-4bc18aface58@app.fastmail.com>
Message-ID: <ffd00f91-6569-714d-29dc-65c14b64d914@linux.intel.com>
References: <20250709151734.1268435-1-arnd@kernel.org> <dd727ab6-a754-77fd-5876-fec076c8905a@linux.intel.com> <fd1f6732-e091-48e8-90c9-4bc18aface58@app.fastmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1037290638-1752248061=:933"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1037290638-1752248061=:933
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Fri, 11 Jul 2025, Arnd Bergmann wrote:

> On Fri, Jul 11, 2025, at 16:55, Ilpo J=C3=A4rvinen wrote:
> > On Wed, 9 Jul 2025, Arnd Bergmann wrote:
> >> index b76157b35296..e9e1c3268373 100644
> >> --- a/drivers/platform/x86/lenovo/Kconfig
> >> +++ b/drivers/platform/x86/lenovo/Kconfig
> >> @@ -250,8 +250,7 @@ config LENOVO_WMI_GAMEZONE
> >>  =09depends on ACPI_WMI
> >>  =09depends on DMI
> >>  =09select ACPI_PLATFORM_PROFILE
> >> -=09select LENOVO_WMI_EVENTS
> >> -=09select LENOVO_WMI_HELPERS
> >> +=09select LENOVO_WMI_TUNING
> >
> > Why did you remove the other two?
> >
> > Do select propagate properly these days across another select?
>=20
> Yes, as far as I know it has always done this, with the one
> exception that it does not propagate when trying to select
> another symbol that has missing dependencies
>=20
> > I was under impression they don't which is one of the reasons
> > use of select is discouraged.
>=20
> I have seen that mentioned before in commit logs, but I
> think this was a misunderstanding. Using 'select' is still
> discouraged, but for other reasons:
>=20
> - complexity quickly gets out of hand when selecting something
>   that has other dependencies, as the driver selecting them
>   must duplicate all those dependencies and keep them in sync

Okay, thanks for these clarifications.

I think I'll take this patch but change it to still keep the other selects=
=20
as wmi-gamezone.c is directly using those too anyway.

> - mixing 'depends on' and 'select' for the same dependency
>   in different drivers tends to cause dependency loops
>=20
> - selecting user-visible symbols has side-effects if another
>   symbol depends on that, e.g. the "select I2C" in some subsystems
>   causes the I2C submenu to appear.
>=20
>     Arnd
>=20

--=20
 i.

--8323328-1037290638-1752248061=:933--

