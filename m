Return-Path: <linux-kernel+bounces-753540-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 04B76B1844D
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 16:57:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8EC421C83474
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 14:57:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D10826E6FF;
	Fri,  1 Aug 2025 14:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KzpdQ/Th"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B7F122D9ED
	for <linux-kernel@vger.kernel.org>; Fri,  1 Aug 2025 14:56:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754060215; cv=none; b=bzZRlHBceOj4w0meUkOn6L/CbIy6kcKYgd1JSfQiKyi9g2PCxhxGob0UbELI8LFCNEiRxXwkl/mSIpHYPrcFg3AxN9LAzh2FcqRN003L6g8BuaVI9xyc4lpvdgabzIjwCPAcBq+OeszeO1XWOsXGWPNn2MouXBnLPPv5hkI9DX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754060215; c=relaxed/simple;
	bh=r0E35VIAkuo74voRf9YU/g+WLq5EnMCalL9y2IWLAj8=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=nOMLVmZqbqLNK6S3Azfj9IYVCHcAEHtItiu7JwMSeUOwUu4dItkvocGOfJaM3qP2gB2wZ9/mmzxVDEUC6Y82luUGGKa5IR+BUQO+giG8BxAGwOtNYN5ULTVZWQYeP5s+aqk5S6463XddUNvM60/c+FW5SYzHggIwdGdIWfDIKpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KzpdQ/Th; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1754060214; x=1785596214;
  h=message-id:subject:from:to:date:in-reply-to:references:
   content-transfer-encoding:mime-version;
  bh=r0E35VIAkuo74voRf9YU/g+WLq5EnMCalL9y2IWLAj8=;
  b=KzpdQ/ThZ36zgdZaIWWYMEQmmgqWyHEZN5e+KCWckcssdLjMX2rWIhwW
   8rgsFQANISvxLAS17aIVn+iWjZ6YD8Eriol+YTO1p3I0hSy7oW3KybPuI
   8OmhpHqC2WQPCsYH9HAfm22nwCYDvbY8Aswl8SaJsiekVd1JoXPTK7QOW
   YdXTXWDjFUmoMcmSQoe8FL44muHBwgA4kBQcehgxQTp5o94tl5QsDzlEQ
   EHnN7KjqFEOlqBtm0vPbbKSjV6fzDxg20X5fXbLZ9PIE0xjcoJ2Zwk32o
   rxpSfBIRtFjzDGp1h6J+MsUE2Ch7JPaAl++9GKT5eaJ7S9Wt0FsTa9Ti9
   g==;
X-CSE-ConnectionGUID: azTRX0wZRZSwV0WDENtH1w==
X-CSE-MsgGUID: i92hIEAvSBe1eBup1AMp/Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11509"; a="56489378"
X-IronPort-AV: E=Sophos;i="6.17,255,1747724400"; 
   d="scan'208";a="56489378"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Aug 2025 07:56:53 -0700
X-CSE-ConnectionGUID: pcYBPNepR0CHZUNq+XHD7g==
X-CSE-MsgGUID: kP3e0BFXSwSiAT8JkVa4BQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,255,1747724400"; 
   d="scan'208";a="167844863"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO [10.245.244.137]) ([10.245.244.137])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Aug 2025 07:56:52 -0700
Message-ID: <37abb9a1a4fde174a54a9d7868d31b2615df0e47.camel@linux.intel.com>
Subject: Re: [PATCH v3] Mark xe driver as BROKEN if kernel page size is not
 4kB
From: Thomas =?ISO-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>
To: Simon Richter <Simon.Richter@hogyros.de>,
 intel-xe@lists.freedesktop.org, 	dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Date: Fri, 01 Aug 2025 16:56:50 +0200
In-Reply-To: <274fefe9b46bb856e5968431ed524ebe1b8e8cd4.camel@linux.intel.com>
References: <460b95285cdf23dc6723972ba69ee726b3b3cfba.camel@linux.intel.com>
		 <20250801102130.2644-1-Simon.Richter@hogyros.de>
	 <274fefe9b46bb856e5968431ed524ebe1b8e8cd4.camel@linux.intel.com>
Organization: Intel Sweden AB, Registration Number: 556189-6027
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2025-08-01 at 16:39 +0200, Thomas Hellstr=C3=B6m wrote:
> On Fri, 2025-08-01 at 19:19 +0900, Simon Richter wrote:
> > This driver, for the time being, assumes that the kernel page size
> > is
> > 4kB,
> > so it fails on loong64 and aarch64 with 16kB pages, and ppc64el
> > with
> > 64kB
> > pages.
> >=20
> > Signed-off-by: Simon Richter <Simon.Richter@hogyros.de>
> > Cc: stable@vger.kernel.org
>=20
> Reviewed-by: Thomas Hellstr=C3=B6m <thomas.hellstrom@linux.intel.com>
> I will add a Fixes: tag and push this.
>=20
> Thanks,
> Thomas

Actually, I see that the patch in its current form will cause grief
when backporting since that depends line has changed during driver
lifetime. I noticed that when trying to find a good Fixes: tag.

Would you mind if we did the following:

>=20
>=20
> > ---
> > =C2=A0drivers/gpu/drm/xe/Kconfig | 2 +-
> > =C2=A01 file changed, 1 insertion(+), 1 deletion(-)
> >=20
> > diff --git a/drivers/gpu/drm/xe/Kconfig
> > b/drivers/gpu/drm/xe/Kconfig
> > index 2bb2bc052120..ea12ff033439 100644
> > --- a/drivers/gpu/drm/xe/Kconfig
> > +++ b/drivers/gpu/drm/xe/Kconfig
> > @@ -1,7 +1,7 @@
> > =C2=A0# SPDX-License-Identifier: GPL-2.0-only
> > =C2=A0config DRM_XE
> > =C2=A0	tristate "Intel Xe2 Graphics"
> > -	depends on DRM && PCI
> > +	depends on DRM && PCI && (PAGE_SIZE_4KB || COMPILE_TEST ||
> > BROKEN)

Scratch this change

> > =C2=A0	depends on KUNIT || !KUNIT
> > =C2=A0	depends on INTEL_VSEC || !INTEL_VSEC
> > =C2=A0	depends on X86_PLATFORM_DEVICES || !(X86 && ACPI)

And instead here add
	depends on PAGE_SIZE_4KB || COMPILE_TEST || BROKEN

Thanks,
Thomas


>=20
>=20


