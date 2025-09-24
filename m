Return-Path: <linux-kernel+bounces-830546-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DCD8B99F31
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 14:58:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3F6624C62FC
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 12:58:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99408302CB2;
	Wed, 24 Sep 2025 12:58:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hdWQGmUB"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 642362FFDF3;
	Wed, 24 Sep 2025 12:58:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758718716; cv=none; b=LPzEe9rvboD1o60JhYZpppoISubvokMYSlALWqZ2NYKkyTO6ac1y9rBLsNuGDXwMkgwF3/KCgGduTlOkgrCjvsD625eL3W+aMIQmws5l9wltfnd+lPVHjzaVx/1aP3WcRmWeY1tE1xCnVGW9nfVZslMIPrhc7DZNekFBBsknz8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758718716; c=relaxed/simple;
	bh=RYmcHouPkXIndj1/8phik3xCIYSxXkJc8hb0T8jy+Kw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=TKrQ+1c1YUdK2yrr1s+bjaDrgSFawZji+98oTMI45tXiMQ6bUM7dZ5c9ZtSqig+m4O7BilWSiNvg/+QNNqxwuw/ItqhhQLOjoUQv1VE3hUhgsDedIKTEZEoFFejXjXFX1CWZasQbOQPM8ePnpCDCvXv5KT/SypeL25Csnmgfg7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hdWQGmUB; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758718714; x=1790254714;
  h=from:to:cc:in-reply-to:references:subject:message-id:
   date:mime-version:content-transfer-encoding;
  bh=RYmcHouPkXIndj1/8phik3xCIYSxXkJc8hb0T8jy+Kw=;
  b=hdWQGmUB4EnqbluFt8yUbQbJhnlJACi3BricUZk4QasqqH0kxIMnZCjW
   JOHrp2qT1jebhY7YT3ws6A5tNHXDA9KoAKbfsHoUgd21ln19xy3nQnujY
   /yeWcwfZAjM4dLtzU2bbRBb59StvXCBhZl3PuM5lSz/+o/1Rsd1mvyJrB
   KnPNhhtdTz+7nlIP+5gRHkPVXEYb3q7pvY3+M3uVzH185wEtGbnUSrleC
   HGE/X7XuwnL5hB68OlwCDhGCxEVFjIPvu4OaaX9JceWHOk2bisFYdB7Hd
   HdjblddCdhqs0y3ucKUH6sDC42aBuylxLUuPE34byE13/arpF0YfvnhwV
   w==;
X-CSE-ConnectionGUID: Rf6uUEFOQ8yCu2UfIpPDmQ==
X-CSE-MsgGUID: g6KsZNBESUaX2FYmmJB84Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11563"; a="71691219"
X-IronPort-AV: E=Sophos;i="6.18,290,1751266800"; 
   d="scan'208";a="71691219"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Sep 2025 05:58:33 -0700
X-CSE-ConnectionGUID: w/A0LUR6StaiO769Z+KroQ==
X-CSE-MsgGUID: FMKxu/nDSIKafl9oti9ezA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,290,1751266800"; 
   d="scan'208";a="177799161"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.210])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Sep 2025 05:58:30 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: Hans de Goede <hansg@kernel.org>, 
 Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
 "Enrico Weigelt, metux IT consult" <info@metux.net>, 
 Arnd Bergmann <arnd@kernel.org>, Bartosz Golaszewski <brgl@bgdev.pl>, 
 Linus Walleij <linus.walleij@linaro.org>, 
 platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <yaaegm5z2vtkl6ci5jpfnv42aywfjtoqw3bjgtli43ypask2r6@a7gg37rwkpx2>
References: <yaaegm5z2vtkl6ci5jpfnv42aywfjtoqw3bjgtli43ypask2r6@a7gg37rwkpx2>
Subject: Re: [PATCH] platform/x86: pcengines-apuv2: Use static device
 properties
Message-Id: <175871870580.14395.9288938251452136390.b4-ty@linux.intel.com>
Date: Wed, 24 Sep 2025 15:58:25 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0

On Mon, 11 Aug 2025 15:50:05 -0700, Dmitry Torokhov wrote:

> Convert the PC Engines APUv2/v3 board driver to use software nodes
> and static device properties for its on-board LEDs and front button.
> 
> This change replaces the legacy gpiod_lookup_table and platform_data
> with a modern software node implementation, which allows the leds-gpio
> and gpio-keys drivers to use the standard device properties API.
> 
> [...]


Thank you for your contribution, it has been applied to my local
review-ilpo-next branch. Note it will show up in the public
platform-drivers-x86/review-ilpo-next branch only once I've pushed my
local branch there, which might take a while.

The list of commits applied:
[1/1] platform/x86: pcengines-apuv2: Use static device properties
      commit: 5accc30cddb19143e3626f7df2bd1afe32983616

--
 i.


