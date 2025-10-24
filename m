Return-Path: <linux-kernel+bounces-868257-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 505B2C04B72
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 09:28:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1F450400FDC
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 07:26:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3B332D248F;
	Fri, 24 Oct 2025 07:26:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="j22hTJkz"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69E471EE7DC;
	Fri, 24 Oct 2025 07:26:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761290762; cv=none; b=KGMmmCdRi1zGfMvfZWciidNvi8gKvQ6Bk4yFlUxrPwVKipI/GBNXAgyCEXni2eZXSGePd2YwjtKrepZEiqAH2lycATJQLj/3gGpDe701ClPpkq8++sknxoWYQJxS5nGCi7zefsQazdgeGuWPDHdGhfYUJ3i7PN3Vn31BJdQVyi0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761290762; c=relaxed/simple;
	bh=0N7yLI9ieWoPqqSuDXrLYITQPFd5DRrzMbTU7U2jF0Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iRkGLHEOyN4Yo4tsyF6uF/ghoUW0Jw5t5x7rJGkPc3aA3fls6hmTcQjCA9vLgKYQZR/TMhgiefxUt4J9zhQxsT/KRZ693mbmMRJfwWwxgH+Wr0kMyBAzCDkAfx7RFIslAm58TN4BFqaqWLye6a5sFOuWW1EGkE+ByM4KsYPw0H8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=j22hTJkz; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761290761; x=1792826761;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=0N7yLI9ieWoPqqSuDXrLYITQPFd5DRrzMbTU7U2jF0Q=;
  b=j22hTJkzTadOXqUu4sFmVoKSTNCJA/jIXB0y5/XcVGfu99pu42YBS7qW
   Zvm8gDNQn9WIVKhCJm38quyg/mDnQppOKkWhdU4zZcLa5aEgBM79FezDx
   nNhYBnLOmSHOr9aYbpdw4xJshFVUV2Rbn6ygmyLiK7Is8gcUTV52SZEkw
   QPVNDP1Jeq/Hv/36y3LJZ+eVjRzc5sWwDgi5FAE2q3t+fvBZs24pqAzsO
   keYVKYBmBMiJrEh+McQbruodNYrS9Vss51IHDSy0p6qbuTOSuYNAN7MqT
   lp0IZ/rr4XHeKejhg29weimFLIMw5KtoW8K+A31fySBzRZjEscNyZZAQK
   A==;
X-CSE-ConnectionGUID: v/nzPAY5S5eu5LOkasHaEA==
X-CSE-MsgGUID: B4brBiV4S6O1CABoaJDdDg==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="67114668"
X-IronPort-AV: E=Sophos;i="6.19,251,1754982000"; 
   d="scan'208";a="67114668"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2025 00:26:00 -0700
X-CSE-ConnectionGUID: fW9MN2wrR7W4MfzQWm8O/g==
X-CSE-MsgGUID: kT2alW3hTEKaCji85JT9pA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,251,1754982000"; 
   d="scan'208";a="188753802"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO kekkonen.fi.intel.com) ([10.245.245.64])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2025 00:25:57 -0700
Received: from kekkonen.localdomain (localhost [IPv6:::1])
	by kekkonen.fi.intel.com (Postfix) with SMTP id 4107F11F879;
	Fri, 24 Oct 2025 10:25:55 +0300 (EEST)
Date: Fri, 24 Oct 2025 10:25:55 +0300
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6 krs, Bertel Jungin Aukio 5, 02600 Espoo
From: Sakari Ailus <sakari.ailus@linux.intel.com>
To: Qiu Wenbo <qiuwenbo@gnome.org>
Cc: Daniel Scally <djrscally@gmail.com>, Hans de Goede <hansg@kernel.org>,
	Qiu Wenbo <qiuwenbo@kylinsec.com.cn>,
	platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Andy Shevchenko <andy@kernel.org>
Subject: Re: [PATCH] platform/x86: int3472: Fix double free of GPIO device
 during unregister
Message-ID: <aPsqA8Zbneaeh3ZL@kekkonen.localdomain>
References: <20251024050537.92440-1-qiuwenbo@gnome.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251024050537.92440-1-qiuwenbo@gnome.org>

Hi Qiu,

Thanks for the patch.

On Fri, Oct 24, 2025 at 01:05:37PM +0800, Qiu Wenbo wrote:
> From: Qiu Wenbo <qiuwenbo@kylinsec.com.cn>
> 
> regulator_unregister() already frees the associated GPIO device. On
> ThinkPad X9 (Lunar Lake), this causes a double free issue that leads to
> random failures when other drivers (typically Intel THC) attempt to
> allocate interrupts. The root cause is that the reference count of the
> pinctrl_intel_platform module unexpectedly drops to zero when this
> driver defers its probe.
> 
> This behavior can also be reproduced by unloading the module directly.
> 
> Fix the issue by removing the redundant release of the GPIO device
> during regulator unregistration.
> 
> Fixes: 1e5d088a52c2 ("platform/x86: int3472: Stop using devm_gpiod_get()")

Shouldn't this be also cc'd to stable@

Reviewed-by: Sakari Ailus <sakari.ailus@linux.intel.com>

-- 
Regards,

Sakari Ailus

