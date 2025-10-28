Return-Path: <linux-kernel+bounces-874263-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E2E6EC15DA7
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 17:37:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 8CC043555AA
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 16:37:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3ACE033CEA2;
	Tue, 28 Oct 2025 16:37:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Rnz4ibPE"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7503D336EDA;
	Tue, 28 Oct 2025 16:37:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761669455; cv=none; b=MiWDBBeFpVSJztGSPz4515XuiA3Kx0fVtQmHvEm4fKAvhCNCXGo4rBmE3hVggBzKZA+ClxctZUnxxhtgT8FUse4MZ6FkIB7FkgjeOKjk6neAF5A0XWPIyBiNsXeFKVHNIMYz4JpDiNrCk6wqQ5fNeJDzEESFw3OqC24GSizgsTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761669455; c=relaxed/simple;
	bh=W9mEmL7jIDLBMLBX7j3ZXla+oXrlDLCVbAxW1tbngG4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=NC0RWa/RuD7l4TXM1HSk44JvkwsgjnDgH4j+VNldAOfvW2cEVMsyaxNJ1GzwExgqHONafn8PHnCfqdoC1LQ2W51+ynCaWvVeSV9+RdhdOa3MPI3hnY1RG4bi5VmC0hZRvzU2ta2gXgknByVmRVsqmm6cWVis3u+KGHW11EoDfKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Rnz4ibPE; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761669454; x=1793205454;
  h=from:to:cc:in-reply-to:references:subject:message-id:
   date:mime-version:content-transfer-encoding;
  bh=W9mEmL7jIDLBMLBX7j3ZXla+oXrlDLCVbAxW1tbngG4=;
  b=Rnz4ibPEHBxHk5kp6gtuhbI00xrHoU4FTMpPqGrghuTgdhnq55b3ZVYl
   bFsHKoKjIg3+q08SBI0zJtwsTeX/NPp/HRuKAeOAg3K1b+NqJ6/uzh9nw
   X0H0bYZBndJ17DX58VMe613+QVuuXYMmTZtRglZl0rlVFDE5wPFQnTATB
   1kMXkiCAdnfmJhkbMrlxA6MJg3H40UPwNelDqrKaV47ZnsleHnR2zyouI
   C2frevHyeYxqZEgSrRigsVuXOtWY5UiR8PrJM8xmy+OoliIwVg9ropRRq
   IYgvpd5QaxT7g7331XyFObLo+HY7zrRkUdk//ObKP/4CJ+0HMz2ZF6dod
   w==;
X-CSE-ConnectionGUID: Vz+9Ws9GQAuRSmyK1UXLMg==
X-CSE-MsgGUID: B2LbszDLSuCwZPro06nHFA==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="63813471"
X-IronPort-AV: E=Sophos;i="6.19,261,1754982000"; 
   d="scan'208";a="63813471"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2025 09:37:33 -0700
X-CSE-ConnectionGUID: ERBcBXWcSganTId7wMNOqQ==
X-CSE-MsgGUID: 2H5xkJCUSMynp9IjSUTaUA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,261,1754982000"; 
   d="scan'208";a="185095243"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.182])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2025 09:37:30 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: Daniel Scally <djrscally@gmail.com>, Hans de Goede <hansg@kernel.org>, 
 Qiu Wenbo <qiuwenbo@gnome.org>
Cc: Andy Shevchenko <andy@kernel.org>, 
 Sakari Ailus <sakari.ailus@linux.intel.com>, 
 platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20251028063009.289414-1-qiuwenbo@gnome.org>
References: <20251024050537.92440-1-qiuwenbo@gnome.org>
 <20251028063009.289414-1-qiuwenbo@gnome.org>
Subject: Re: [PATCH v2] platform/x86: int3472: Fix double free of GPIO
 device during unregister
Message-Id: <176166944603.2044.3460752500171416214.b4-ty@linux.intel.com>
Date: Tue, 28 Oct 2025 18:37:26 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0

On Tue, 28 Oct 2025 14:30:09 +0800, Qiu Wenbo wrote:

> regulator_unregister() already frees the associated GPIO device. On
> ThinkPad X9 (Lunar Lake), this causes a double free issue that leads to
> random failures when other drivers (typically Intel THC) attempt to
> allocate interrupts. The root cause is that the reference count of the
> pinctrl_intel_platform module unexpectedly drops to zero when this
> driver defers its probe.
> 
> [...]


Thank you for your contribution, it has been applied to my local
review-ilpo-fixes branch. Note it will show up in the public
platform-drivers-x86/review-ilpo-fixes branch only once I've pushed my
local branch there, which might take a while.

The list of commits applied:
[1/1] platform/x86: int3472: Fix double free of GPIO device during unregister
      commit: f0f7a3f542c1698edb69075f25a3f846207facba

--
 i.


