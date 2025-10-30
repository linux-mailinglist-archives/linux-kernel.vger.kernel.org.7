Return-Path: <linux-kernel+bounces-878766-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CFECC216DE
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 18:18:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 113144F276E
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 17:15:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F4128368398;
	Thu, 30 Oct 2025 17:14:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FZk8XlzY"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BB63368387;
	Thu, 30 Oct 2025 17:14:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761844491; cv=none; b=tiNxeOf+beJ4YfWQ08cLIOh7eTNxVq0O3fxtpGa2JVxxy5F1JQkWoWOW01Jnq0BfRTsq5iyD3on9C3amvkqX5LM9i+tHghE3XSwvMCmoq1ntLlBQ4rCnbA0NNrmPlbvasOHkKMC6pRy7zD26z2OLgHN5ZT8WvEMV4YCnFZzzk9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761844491; c=relaxed/simple;
	bh=Hvg76oK1r3SHGVtlfQAeldp6j1ldYnxROPFqrI26wVc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=KkSMsdsEyfRHNheEdqN1K+YI4cwOnYIF5gVMaIoN1BTDJDmUuwgOycbzYcbswk2Nur9yV0fiXFqn7zGgNdK6Y0BG6zfgCMpGgBiUz3TEfT4/c7FNkUskT/9ijwo7UOTz/1PbRMIFTJ5btwtltv69xFDLyT2xwz8VkSEe9/ok8Wc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FZk8XlzY; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761844490; x=1793380490;
  h=from:to:cc:in-reply-to:references:subject:message-id:
   date:mime-version:content-transfer-encoding;
  bh=Hvg76oK1r3SHGVtlfQAeldp6j1ldYnxROPFqrI26wVc=;
  b=FZk8XlzY+ULrPm7DMb/PonRyVxU9wGNEYz6gbE1LkH3tPtQDKWKpBFhD
   MM2seV1BfRZJu41HE15zUA5OjC+dkp9pZpoBr0fScmdQE5ej0LDxdScN7
   lVTwmjqL8qK5or2ANTUsndeRS1TGjHIhW1S67dKptOsojU/2D5rGDoX4D
   QMJcCumxU/ptuKT57daYAQxKEM7IHJPFoTySLnd0nX9b2cLdisLRAxKpe
   J21+VFcFBhUvBtPxD1KJ5Wr065+G16pN7+kvZ576GGgb1U+CaJFXQZJ7U
   pDVByXYodiedkL6jERiwAChb0gCFFvC6rhCEpekOSUfzO1Lk7sAUO7LBy
   Q==;
X-CSE-ConnectionGUID: vossXKBRTL67joYJDE49/g==
X-CSE-MsgGUID: tULgpHeZTK+tELh4AYuWOw==
X-IronPort-AV: E=McAfee;i="6800,10657,11598"; a="75444761"
X-IronPort-AV: E=Sophos;i="6.19,267,1754982000"; 
   d="scan'208";a="75444761"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2025 10:14:49 -0700
X-CSE-ConnectionGUID: iO8rRb3MS9aA3/bTA5YtmA==
X-CSE-MsgGUID: eQtfmWqAQJWxYOm7yRaOtw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,267,1754982000"; 
   d="scan'208";a="185890742"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.175])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2025 10:14:45 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: platform-driver-x86@vger.kernel.org, Andy Shevchenko <andy@kernel.org>, 
 Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
 Hans de Goede <hansg@kernel.org>, Markus Elfring <Markus.Elfring@web.de>
Cc: LKML <linux-kernel@vger.kernel.org>, Anand Moon <linux.amoon@gmail.com>, 
 Christophe Jaillet <christophe.jaillet@wanadoo.fr>
In-Reply-To: <90a2385c-9d19-46f2-8d31-618d5c10aa91@web.de>
References: <90a2385c-9d19-46f2-8d31-618d5c10aa91@web.de>
Subject: Re: [PATCH] platform/x86: x86-android-tablets: Omit a variable
 reassignment in lenovo_yoga_tab2_830_1050_init_codec()
Message-Id: <176184447560.9294.8661793810422780479.b4-ty@linux.intel.com>
Date: Thu, 30 Oct 2025 19:14:35 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0

On Mon, 20 Oct 2025 17:02:25 +0200, Markus Elfring wrote:

> An error code was assigned to a variable and checked accordingly.
> This value was passed to a dev_err_probe() call in an if branch.
> This function is documented in the way that the same value is returned.
> Thus delete a redundant variable reassignment.
> 
> The source code was transformed by using the Coccinelle software.
> 
> [...]


Thank you for your contribution, it has been applied to my local
review-ilpo-next branch. Note it will show up in the public
platform-drivers-x86/review-ilpo-next branch only once I've pushed my
local branch there, which might take a while.

The list of commits applied:
[1/1] platform/x86: x86-android-tablets: Omit a variable reassignment in lenovo_yoga_tab2_830_1050_init_codec()
      commit: ba06b928f05bfd2785260819f6b34b658a04a4e6

--
 i.


