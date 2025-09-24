Return-Path: <linux-kernel+bounces-830545-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F4019B99F28
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 14:58:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0D5A63283F1
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 12:58:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3855C302CB2;
	Wed, 24 Sep 2025 12:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="D5yEGyD9"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F21892417C2;
	Wed, 24 Sep 2025 12:58:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758718707; cv=none; b=YHjJ0HbD9g13wUASYnlxJkhRzFNn6thO4PqhV9YYLU/faBe5ARauHlZUTbsGSh4frl8N84utU9PdngboFrUaEllUcpgSodoSMW/ZezaGl8onjSPchC0bZ848zJatDJjTJ2VKgQTiTmOyvZJTlres/Ys7iTPReroTDNVqvr2fv+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758718707; c=relaxed/simple;
	bh=Qspc5dEwxdpjZ/rYHDAEPi8m3o0db6993aHytJX5kYQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=H4BQTt73gVigqew7239622GObOa937nIlq+TouUCcMGAcDnn8u9QfGo9TgsQnoWroXGP7OIvcRFibXVVrvkqPVWcSWzJumc+LfIF8hf+xT7t9NOAhYn/gPqKDqomO9Yk61sDiI+7olSCqJNsQdBQ0NDqlm5WVYLisBI1KOP9lfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=D5yEGyD9; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758718706; x=1790254706;
  h=from:to:cc:in-reply-to:references:subject:message-id:
   date:mime-version:content-transfer-encoding;
  bh=Qspc5dEwxdpjZ/rYHDAEPi8m3o0db6993aHytJX5kYQ=;
  b=D5yEGyD9ys5ImTf9gaJfB+z6BSOJK0/GrQJMKMB6wJW6NT+MugZEPeXR
   Gx+j7L7ZnY4ldVNpClOEUq86feV2UNXmOyAeXvOo1yslkQjJ6Ym2zfaV5
   wR0UnUJe/bU9S+egyIj9ucf7Toa9uGjZrW9QvwOL5ct8IdtPQYxkSxY+M
   slVzSOfJwexhZK1n2SJWF4vQazNXAVUptVyOIMzFbPGVxdM1aLvw1cqwH
   oNaHx7RZ6GXFnenDCtYKZ07JY0g6VMCYKF2rt0Dvh06BDvRdAgJa0anRs
   oUDaMk2Q6nP0Yms0/bSyUSXIQWKc8+vQ5L+bkWyOgWbYs6pGYVsVVX1lH
   A==;
X-CSE-ConnectionGUID: 0LvhTKCKROuoiUeGrfK1Tw==
X-CSE-MsgGUID: DplH608yR8SNMQDxuuuJKA==
X-IronPort-AV: E=McAfee;i="6800,10657,11563"; a="71691191"
X-IronPort-AV: E=Sophos;i="6.18,290,1751266800"; 
   d="scan'208";a="71691191"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Sep 2025 05:58:25 -0700
X-CSE-ConnectionGUID: GHOSdtPYTAGcqnN0/DSxuw==
X-CSE-MsgGUID: jK26LTCCRyaUw4/82EBZBA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,290,1751266800"; 
   d="scan'208";a="177799118"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.210])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Sep 2025 05:58:22 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: Hans de Goede <hansg@kernel.org>, 
 Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Arnd Bergmann <arnd@kernel.org>, Bartosz Golaszewski <brgl@bgdev.pl>, 
 Linus Walleij <linus.walleij@linaro.org>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
 platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <dzecghqrsrbe74akboqih7xculdm53rbhxa7dimt2ysdevyskd@hxhd2j3vnlt5>
References: <dzecghqrsrbe74akboqih7xculdm53rbhxa7dimt2ysdevyskd@hxhd2j3vnlt5>
Subject: Re: [PATCH] platform/x86: meraki-mx100: Use static device
 properties
Message-Id: <175871869699.14395.10857529593213042993.b4-ty@linux.intel.com>
Date: Wed, 24 Sep 2025 15:58:16 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0

On Mon, 11 Aug 2025 15:47:09 -0700, Dmitry Torokhov wrote:

> Convert the Meraki MX100 board driver to use software nodes and static
> device properties to describe the on-board LEDs and reset button.
> 
> This moves away from the legacy gpiod_lookup_table and platform_data
> mechanisms, allowing consumer drivers like leds-gpio and gpio-keys
> to rely on the unified device properties interface instead of
> board-specific data.
> 
> [...]


Thank you for your contribution, it has been applied to my local
review-ilpo-next branch. Note it will show up in the public
platform-drivers-x86/review-ilpo-next branch only once I've pushed my
local branch there, which might take a while.

The list of commits applied:
[1/1] platform/x86: meraki-mx100: Use static device properties
      commit: c33ca306d26336c9625c37e5e6585080d5882ac8

--
 i.


