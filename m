Return-Path: <linux-kernel+bounces-888460-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E97CC3AE0D
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 13:26:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 361F11A46680
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 12:26:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9127D32A3F5;
	Thu,  6 Nov 2025 12:26:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ime/d6rH"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C99971DA23;
	Thu,  6 Nov 2025 12:26:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762431973; cv=none; b=dyJS2LAZ9vhMS3EagnJxj73rRxURGCsQXu2t5tX8u39DWKtkqI0oMYSXb42ZaMPVsytYXKWD35QOMCOg6UP31NPI5vYZ4nmTMVB2N3IcgNvIkYaxN4o1OfvAFvwJg5nU0lnWfLYHWW51nN/rD7FLCMp6GdenftkRTkGy7V5VK5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762431973; c=relaxed/simple;
	bh=ZP5wovO+j4hfcwNDZDeeimIUq2gu+TUgl4x0zXenIq0=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=oqFmKNJoZ0AAW0EW02KdsVLNlP3pV7Zlro/ttsL/ahBckjjluLiaRSWYk2wLAvuvA8Oam0+EqGPnPvPh1MI/JxC9tc974pQ8e33JBpwr1Q3DfV4AAyuoxxJUvN/77+LEG8cX3rpUmiM0CVeczvw0ORb41v+OWB2j/6fF4WAYTeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ime/d6rH; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762431971; x=1793967971;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=ZP5wovO+j4hfcwNDZDeeimIUq2gu+TUgl4x0zXenIq0=;
  b=Ime/d6rH+ap66STTlOGptq1OsVeHCwdLQ9pSgt6Wj687r2e0TmyfkInL
   Uu9q7k2s2hey3vg1jJd+rpZlpkGsG+2Af8U4JOyozgu7LPz036vGxvjJb
   exHOfFKgWLVujV//zYcsGHh6ObZySGBXaaznTU1JfG36T0FrGEkwsYJEH
   qLMbD9yykPx/zBBls7JWAJRg4KR2KOulEB/iXlvg5WZi+AO/pKnyRuL7V
   2XmZceCgyNgJRXxMnyRxh0SOwX8J4rI3DwENIn/xc4Q3p47d8blZh8tfF
   SA+eFv4BgGp6dIE4YMqm2j8R55JHDBNvo+8ILKQPP8QNsJeLsOvf2/PBW
   A==;
X-CSE-ConnectionGUID: wDh3OCVfQvSzZjV8ah1qoQ==
X-CSE-MsgGUID: u3qOKSOrTyefFOq7BaZWlg==
X-IronPort-AV: E=McAfee;i="6800,10657,11604"; a="68424824"
X-IronPort-AV: E=Sophos;i="6.19,284,1754982000"; 
   d="scan'208";a="68424824"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2025 04:26:09 -0800
X-CSE-ConnectionGUID: 1oGosF+SSvG6dqyepFyS6g==
X-CSE-MsgGUID: WToDPPAJRiubM7evEB2BuA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,284,1754982000"; 
   d="scan'208";a="224994212"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.187])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2025 04:26:08 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Thu, 6 Nov 2025 14:26:03 +0200 (EET)
To: Marcos Vega <marcosmola2@gmail.com>
cc: platform-driver-x86@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] platform/x86: hp-wmi: Add Omen MAX 16-ah0xx fan support
 and thermal profile
In-Reply-To: <176243164304.2946.1841460166696016305.b4-ty@linux.intel.com>
Message-ID: <81699228-710c-144c-0909-1fe5be0604ca@linux.intel.com>
References: <20251106115017.77782-1-marcosmola2@gmail.com> <176243164304.2946.1841460166696016305.b4-ty@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-220971142-1762431963=:981"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-220971142-1762431963=:981
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Thu, 6 Nov 2025, Ilpo J=C3=A4rvinen wrote:

> On Thu, 06 Nov 2025 12:50:17 +0100, Marcos Vega wrote:
>=20
> > New HP Omen laptops follow the same WMI thermal profile as Victus 16-r1=
000 and 16-s1000.
> >=20
> > Add DMI board 8D41 to omen_thermal_profile_boards as well as victus_s_t=
hermal_profile_boards.
> >=20
> > Tested on: HP Omen MAX 16-ah0xx (8D41)
> > Result:
> > * RPMs can be read
> > * echo 0 | sudo tee /sys/devices/platform/hp-wmi/hwmon/*/pwm1_enable al=
lows the fans to run on max RPM.
> >=20
> > [...]
>=20
>=20
> Thank you for your contribution, it has been applied to my local
> review-ilpo-fixes branch. Note it will show up in the public
> platform-drivers-x86/review-ilpo-fixes branch only once I've pushed my
> local branch there, which might take a while.
>=20
> The list of commits applied:
> [1/1] platform/x86: hp-wmi: Add Omen MAX 16-ah0xx fan support and thermal=
 profile
>       commit: 836a26660b97c62b1ed734e38a78bd20949dfa22

Actually, I take this back, I don't think you're supposed to add it to=20
both lists.

--=20
 i.

--8323328-220971142-1762431963=:981--

