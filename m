Return-Path: <linux-kernel+bounces-830544-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E2319B99F22
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 14:58:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A31924C6041
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 12:58:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A34F302171;
	Wed, 24 Sep 2025 12:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FbQFgBYv"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FC992417C2;
	Wed, 24 Sep 2025 12:58:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758718699; cv=none; b=U49n6cMueKU/cTm/EvyLcYKl02C43JdjZYwT1L5cPgAWvtBE4iFR9sCxLNhX/VTBbngM6Qrl4tlIA7eQPXxnVj3QMwod8OuTrNRmdE92mNFcNrGDqylEnP7aPtdP17+t2Yxhmg3SYEAwZp+iMDbLDNajiJgNHjVutQfEdvzvpsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758718699; c=relaxed/simple;
	bh=8q2piqw+En3iDfggstQ7qEcJddMj9hReIH0MXbimx6E=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=mhGToTxSt2SuY97T1lOzzSYMmluqftEGgKjQc2FXjXC9kXwBVTcg28W08aOv5YkAXxo7ZJEGifaKVMLu66tpl6YHsu0qfBizNDGD2Ei1QJXrkcd/DfEoGW7Jbzn/yeUkWtnRWi2bu85BU1+2OOfT1cPgaI0ITwcJjVEgkpaBxg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FbQFgBYv; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758718697; x=1790254697;
  h=from:to:cc:in-reply-to:references:subject:message-id:
   date:mime-version:content-transfer-encoding;
  bh=8q2piqw+En3iDfggstQ7qEcJddMj9hReIH0MXbimx6E=;
  b=FbQFgBYvB/CMEPUMgvx+pUcYjbjiXHtT1dfGKS/eCLhzqySgglLNRHvc
   6iw6yaHVssghxuSGNspm20Q1p8vz+JXrukl2YMdy4gKaH/4PdHM2gZLdt
   ZszvuqtkqMuTmV1wgUzbYnWW6pVkfRkA8qgXvJpi1KVkaWF6MI+PHrdS1
   MifOEHC7t6+Wnri3RLr3KP0mQ8AHHwSjHpscR5CEmbVrTgCPs+Gq8U6AQ
   zeFJHcu49rbegaEQ35J7Fsdz6tWQB3ggv6RF3oa4446aHW8devGy0K8l8
   xtGMlIUtUaijHeojuO2dtkm0dlkrI6JJ0HIZnLm73nrNSwVH0fQTsc45j
   A==;
X-CSE-ConnectionGUID: AUpEcnifRbCL65zY8wSi4w==
X-CSE-MsgGUID: H5V3KxhQTASLOyfMbvZ1lw==
X-IronPort-AV: E=McAfee;i="6800,10657,11563"; a="71691179"
X-IronPort-AV: E=Sophos;i="6.18,290,1751266800"; 
   d="scan'208";a="71691179"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Sep 2025 05:58:16 -0700
X-CSE-ConnectionGUID: OGc/pHIXTFWUNoUQKKQzFw==
X-CSE-MsgGUID: h1Euq0i8RWa66OxyS+U1Zw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,290,1751266800"; 
   d="scan'208";a="177799096"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.210])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Sep 2025 05:58:13 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: Santosh Kumar Yadav <santoshkumar.yadav@barco.com>, 
 Hans de Goede <hansg@kernel.org>, 
 Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Peter Korsgaard <peter.korsgaard@barco.com>, 
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, 
 Arnd Bergmann <arnd@arndb.de>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
 platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <2meuzip4qnxvle4bwk4hbow4j34ii3cwb46xd5inq5btif5mjg@iiygy6ir7vtr>
References: <2meuzip4qnxvle4bwk4hbow4j34ii3cwb46xd5inq5btif5mjg@iiygy6ir7vtr>
Subject: Re: [PATCH] platform/x86: barco-p50-gpio: use software nodes for
 gpio-leds/keys
Message-Id: <175871868912.14395.3763768947038329370.b4-ty@linux.intel.com>
Date: Wed, 24 Sep 2025 15:58:09 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0

On Sun, 10 Aug 2025 21:31:37 -0700, Dmitry Torokhov wrote:

> In preparation of dropping support for legacy GPIO API from gpio-keys
> switch the driver to use software nodes/properties to describe
> GPIO-connected LED and button.
> 
> 


Thank you for your contribution, it has been applied to my local
review-ilpo-next branch. Note it will show up in the public
platform-drivers-x86/review-ilpo-next branch only once I've pushed my
local branch there, which might take a while.

The list of commits applied:
[1/1] platform/x86: barco-p50-gpio: use software nodes for gpio-leds/keys
      commit: ff289dc249fd7699081494bd70a91b5718d27114

--
 i.


