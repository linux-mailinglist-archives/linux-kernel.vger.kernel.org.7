Return-Path: <linux-kernel+bounces-727795-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 36765B01FE3
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 16:57:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B8619B40290
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 14:55:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 137C32EA737;
	Fri, 11 Jul 2025 14:56:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Rc1AfxZ4"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3253C2EA15A;
	Fri, 11 Jul 2025 14:55:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752245760; cv=none; b=AfuNlHeDu9el2Ipvnas5N5UW1VXVLdLBwNkBuRXhrKOCmgiphkYPb9IOmiYNqzJT/nRL01fMG5E+L3/J015wmRIuGsfa11OwLm0RkyxYKc6pCMyv/eAtzl/MmYxAE3K9CXB7TTa+5SzPF4sNC0Dpl8B/gDg+sUHLDjP9ezw1IDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752245760; c=relaxed/simple;
	bh=DokzpyZwq6qWpehUvGkYf4G9lXgOCZS54AU/nsJtJzw=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=Xk1Of2UFMa68LGP0WwTUn2vIWnSp8xcL8/Ab/53sJtb20UZj9np7QwAQcafoWYDw3ghgArUGtupZfooRkYXNKn7CiRnf0Vr2yZzAqLrsr/JO5fkujdn+UaB23CaLgyKVy7cCEQuL7SQenfnM4s4APMFwHqV78BPTKHiAXEkBP0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Rc1AfxZ4; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752245758; x=1783781758;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=DokzpyZwq6qWpehUvGkYf4G9lXgOCZS54AU/nsJtJzw=;
  b=Rc1AfxZ4pNMdTU6+sJd2Jmbo4ni+xU1z3lXKBK9Z4CUOeX6ZePsm5hGB
   9pU1Pwd6xboykWGbK333mqV1qoIb4r4qekKiz2BVzCdzRbeCfoCE3Xzbu
   CSBPhVNhrQ+AIQ2AusYXbxHMgEJ0Uskgul4eJGEvpU0v1xf1Czg3jeL2D
   y5Wec6HgN5W6BYuVfvHrR4o/ah5S8IVfz7tC49knJQ10Wf+STHKC2G17q
   5MTTMlJ9DfYhdCha30uZMf2tM8ezpKoXKLClM+8pk6+h6kSNNkB9iRh0p
   ME3+MN5u4JyElpXEU1W0PgA2uOi35JutlRUi5sySARLuxAv013WJu0yLd
   w==;
X-CSE-ConnectionGUID: i/9MiDz7QQSUtENA2/RKZA==
X-CSE-MsgGUID: FO1nM1tgRG+idqU9UuBGkA==
X-IronPort-AV: E=McAfee;i="6800,10657,11491"; a="64805167"
X-IronPort-AV: E=Sophos;i="6.16,303,1744095600"; 
   d="scan'208";a="64805167"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2025 07:55:58 -0700
X-CSE-ConnectionGUID: bDSd06xoSn2M7zM9QGzM4g==
X-CSE-MsgGUID: nfZpRzn7Q861dAPm9A59ZQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,303,1744095600"; 
   d="scan'208";a="160936701"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.249])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2025 07:55:54 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Fri, 11 Jul 2025 17:55:50 +0300 (EEST)
To: Arnd Bergmann <arnd@kernel.org>, 
    "Derek J. Clark" <derekjohn.clark@gmail.com>
cc: Mark Pearson <mpearson-lenovo@squebb.ca>, Hans de Goede <hansg@kernel.org>, 
    Armin Wolf <W_Armin@gmx.de>, Arnd Bergmann <arnd@arndb.de>, 
    Alok Tiwari <alok.a.tiwari@oracle.com>, 
    Mario Limonciello <mario.limonciello@amd.com>, 
    Jelle van der Waa <jvanderwaa@redhat.com>, 
    platform-driver-x86@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] platform/x86: lenovo: gamezone needs "other mode"
In-Reply-To: <20250709151734.1268435-1-arnd@kernel.org>
Message-ID: <dd727ab6-a754-77fd-5876-fec076c8905a@linux.intel.com>
References: <20250709151734.1268435-1-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Wed, 9 Jul 2025, Arnd Bergmann wrote:

> From: Arnd Bergmann <arnd@arndb.de>
> 
> Registering the "other mode" notifier fails if that is disabled:
> 
> x86_64-linux-ld: drivers/platform/x86/lenovo/wmi-gamezone.o: in function `lwmi_gz_probe':
> wmi-gamezone.c:(.text+0x336): undefined reference to `devm_lwmi_om_register_notifier'
> 
> This could be fixed by adding a stub helper, but a Kconfig 'select'
> seems simpler here.
> 
> Fixes: 22024ac5366f ("platform/x86: Add Lenovo Gamezone WMI Driver")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/platform/x86/lenovo/Kconfig | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/platform/x86/lenovo/Kconfig b/drivers/platform/x86/lenovo/Kconfig
> index b76157b35296..e9e1c3268373 100644
> --- a/drivers/platform/x86/lenovo/Kconfig
> +++ b/drivers/platform/x86/lenovo/Kconfig
> @@ -250,8 +250,7 @@ config LENOVO_WMI_GAMEZONE
>  	depends on ACPI_WMI
>  	depends on DMI
>  	select ACPI_PLATFORM_PROFILE
> -	select LENOVO_WMI_EVENTS
> -	select LENOVO_WMI_HELPERS
> +	select LENOVO_WMI_TUNING

Why did you remove the other two?

Do select propagate properly these days across another select? I was under 
impression they don't which is one of the reasons use of select is 
discouraged.

-- 
 i.


