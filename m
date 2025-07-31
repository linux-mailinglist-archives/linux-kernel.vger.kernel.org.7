Return-Path: <linux-kernel+bounces-751785-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 183E7B16D71
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 10:24:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8AE0D1AA34E8
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 08:24:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 251D424166B;
	Thu, 31 Jul 2025 08:24:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XvpHxejh"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDD9082C60
	for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 08:24:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753950244; cv=none; b=Sv+Uh4I0V/HRnWFS3iJ2/QvdK1uMGFNBxEJDCM8hB+fizvv0kkpIrmDqZU/vIel62NZyGFxgeg6nzku8Rtn5TJsEPE0wAigu/RA4NU1W5vM707bhTr4eEgcLBsiErGXQ09xB7ubUpPpzUJqaeBb8gj9oyUO2+HbDcxNBQWhEckY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753950244; c=relaxed/simple;
	bh=vZdZhm9xDF4gkYxa7DvvCi+1X0MEoSDFakhsxDjtwt4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=sT//pb4w/vHMvWn57SOThBcd4QzOWunqfK3MHj044Z7z2PiGVyPFbzBiwER2DA38akCUzzYVDKNzUL/RRrHet/dwA0rMsbglIeMiz44zoemD+i4RUTyUh7lYS2yXwQHNsl/qqwapSvEKb9+7HuNsXD+EVx3w28LNO0P+pQpQ6Co=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XvpHxejh; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753950243; x=1785486243;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=vZdZhm9xDF4gkYxa7DvvCi+1X0MEoSDFakhsxDjtwt4=;
  b=XvpHxejhv49C9/qnzZfuvzeagEufTGiQvGCSo03mw+yXfQgFYBQGxEQw
   IkZtDQnksIWvsktqauDhBuVNt+EZrCUGUeY4kvGz7OFAwnj4eMyFFgxdV
   UTvOafXlk1pcemglrtZoHxaOGQQdj44TjZcrf0x0UrWYvHpTtwYAwCeUK
   V5Z+1nY2JQ9AIBGAAmbBi5HORNnc7Yz/92aKSDtyMY5juuXljYNHGTb1y
   9ayxVOREDT7dl170koiQkM1/GryVwni8degctRJ5+tCKg0LCrDvm6wJiQ
   rbXhRFDFaYmH9pebezFi5GX0FWM1HCCeACc1lwUSZlPdKpAAJ5Wqa1qHB
   w==;
X-CSE-ConnectionGUID: 7XZQAVv3SJ25tq+jHLuhIA==
X-CSE-MsgGUID: I4wTpeCLTSqmTj8B4fC/Cg==
X-IronPort-AV: E=McAfee;i="6800,10657,11507"; a="56196353"
X-IronPort-AV: E=Sophos;i="6.16,353,1744095600"; 
   d="scan'208";a="56196353"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jul 2025 01:24:02 -0700
X-CSE-ConnectionGUID: CZfv+/DSRk+rl6+M54rjlQ==
X-CSE-MsgGUID: +yLlr+rmT4aWzQ5IT7BDfw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,353,1744095600"; 
   d="scan'208";a="167430187"
Received: from mjarzebo-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.246.108])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jul 2025 01:23:58 -0700
From: Jani Nikula <jani.nikula@linux.intel.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Miquel Raynal <miquel.raynal@bootlin.com>, Richard Weinberger
 <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>, Rodrigo Vivi
 <rodrigo.vivi@intel.com>, Tomas Winkler <tomasw@gmail.com>, Alexander
 Usyskin <alexander.usyskin@intel.com>, Raag Jadav <raag.jadav@intel.com>,
 linux-mtd@lists.infradead.org, intel-gfx@lists.freedesktop.org,
 intel-xe@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mtd: MTD_INTEL_DG should depend on DRM_I915 or DRM_XE
In-Reply-To: <CAMuHMdUJF6V4v1+zbKKG1A_UvHUXU-ySXe7Xj_ryZtRnk2B2nQ@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <07f67ab8ee78f6bf2559131e193381aafff7479a.1753870424.git.geert+renesas@glider.be>
 <d947168fd02d6f820159b456099e6aa8f465b633@intel.com>
 <CAMuHMdUJF6V4v1+zbKKG1A_UvHUXU-ySXe7Xj_ryZtRnk2B2nQ@mail.gmail.com>
Date: Thu, 31 Jul 2025 11:23:54 +0300
Message-ID: <b58c7cdee44b573c84e0f79dad2655f8286bc89a@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Wed, 30 Jul 2025, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> Hi Jani,
>
> On Wed, 30 Jul 2025 at 12:32, Jani Nikula <jani.nikula@linux.intel.com> wrote:
>> On Wed, 30 Jul 2025, Geert Uytterhoeven <geert+renesas@glider.be> wrote:
>> > Intel Discrete Graphics non-volatile memory is onlt present on intel
>> > discrete graphics devices, and its auxiliary device is instantiated by
>> > the Intel i915 and Xe2 DRM drivers.  Hence add dependencies on DRM_I915
>> > and DRM_XE, to prevent asking the user about this driver when
>> > configuring a kernel without Intel graphics support.
>> >
>> > Fixes: ceb5ab3cb6463795 ("mtd: add driver for intel graphics non-volatile memory device")
>> > Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
>> > ---
>> >  drivers/mtd/devices/Kconfig | 4 ++--
>> >  1 file changed, 2 insertions(+), 2 deletions(-)
>> >
>> > diff --git a/drivers/mtd/devices/Kconfig b/drivers/mtd/devices/Kconfig
>> > index 46cebde79f34b0b7..f0ab74d695347117 100644
>> > --- a/drivers/mtd/devices/Kconfig
>> > +++ b/drivers/mtd/devices/Kconfig
>> > @@ -185,8 +185,8 @@ config MTD_POWERNV_FLASH
>> >
>> >  config MTD_INTEL_DG
>> >       tristate "Intel Discrete Graphics non-volatile memory driver"
>> > -     depends on AUXILIARY_BUS
>> > -     depends on MTD
>> > +     depends on AUXILIARY_BUS && MTD
>> > +     depends on DRM_I915 || DRM_XE || COMPILE_TEST
>>
>> I understand the intent, but IIUC auxiliary bus usage should not require
>> a "depends on" relationship. Couldn't you have MTD_INTEL_DG=y and
>> DRM_I915=m just fine?
>
> That is indeed a good point!
>
> What about
>
>     depends on DRM_I915!=n || DRM_XE!=n || COMPILE_TEST
>
> instead?

Fine by me, up to Alexander.

BR,
Jani.



-- 
Jani Nikula, Intel

