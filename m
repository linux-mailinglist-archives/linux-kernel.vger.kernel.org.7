Return-Path: <linux-kernel+bounces-888117-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AF65C39E1F
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 10:46:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 53D444F7A1A
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 09:44:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD3C830E0ED;
	Thu,  6 Nov 2025 09:42:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jWF3KJmg"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68D9930CD8B;
	Thu,  6 Nov 2025 09:42:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762422174; cv=none; b=QQ6hGBdRup6AyvjAI/DyTM4+Fe4eOOmNU9RvelZmCNJFKpBZCWK+vNWO8UPYz9L25JphULWD7+lcjxapfiXlEkGL4SJjczZSI+XAn+qRLms2IP0I/E09JgNQ43YWJfsg/DFk4Mpa127qZ8T5h+Wb615MAj/Gd/FxAt/gFMU71JY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762422174; c=relaxed/simple;
	bh=z3PyUf6kq61mqDc1UtezB9GISlq/05POvavcle6zhzI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gu46P+7lNxSdemSpal8lnS7h1Q88CUtvdVr2kfA592HYttW5Fm3a5xwzK+wPUNtJ7M00UDa7B8eo6G+w45O2lSelcSuRy/9vvC0U47fHKV6kJ90gzTiT+0tYsbj72dfA73oGB+SvWjB0hD6kPN9rYWJSbZ2aAjwPqoO1nlm0eQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jWF3KJmg; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762422173; x=1793958173;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=z3PyUf6kq61mqDc1UtezB9GISlq/05POvavcle6zhzI=;
  b=jWF3KJmg20gcA7cgDV6ds/PS+1eB1jvW0Jz3xLCYfJaBHU8SweVER8Uz
   bgHxEmDV4T0+Wnv2CIGY/GzozQ5I92JziQt0NglczjBnAYnIMzFyv+78K
   4x9d6w8bxTUHzZQOjgSpLl8bbf8XhYKZTsZqoziDeA2L/FbUdhRPBLjt6
   ee1fgfZ5sBqEEhmqxGiipOTZaZkciB8kzfFIirXsGyYncNtroGZKYNvgK
   Ql3KGc/g6+YwVSsdTQ62U9DBhgIVDG+MIN3BfZ4uwGRQnb81q1/E9t3+2
   T5InqpqTsnFDRgpvT44FVPvoGYCjMrjkGlMmxRaBKN25op5FG1uO3w1zR
   A==;
X-CSE-ConnectionGUID: XqFkWLM+ShGvuGQd1TLhmw==
X-CSE-MsgGUID: pKqWqmjzTciCfepo4ZFzfQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11604"; a="90022283"
X-IronPort-AV: E=Sophos;i="6.19,284,1754982000"; 
   d="scan'208";a="90022283"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2025 01:42:52 -0800
X-CSE-ConnectionGUID: liKGduqaR0i10jRegW2LzA==
X-CSE-MsgGUID: h6InYS9IRwGIaH/JO/WaJA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,284,1754982000"; 
   d="scan'208";a="191992573"
Received: from jjgreens-desk21.amr.corp.intel.com (HELO ashevche-desk.local) ([10.124.221.229])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2025 01:42:47 -0800
Received: from andy by ashevche-desk.local with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1vGwVr-0000000633w-3MTI;
	Thu, 06 Nov 2025 11:42:39 +0200
Date: Thu, 6 Nov 2025 11:42:38 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Jeff Lin <jefflin994697@gmail.com>
Cc: Mariel.Tinaco@analog.com, cedricjustine.encarnacion@analog.com,
	chiang.brian@inventec.com, grantpeltier93@gmail.com,
	gregkh@linuxfoundation.org, jbrunet@baylibre.com, jdelvare@suse.com,
	johnerasmusmari.geronimo@analog.com, kimseer.paller@analog.com,
	krzysztof.kozlowski@linaro.org, leo.yang.sy0@gmail.com,
	linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux@roeck-us.net, ninad@linux.ibm.com, nuno.sa@analog.com,
	peterz@infradead.org, thorsten.blum@linux.dev, tzungbi@kernel.org,
	william@wkennington.com
Subject: Re: [PATCH v2] drivers/hwmon/pmbus: Add support for raa229141 in
 isl68137
Message-ID: <aQxtjo-wl-FkUbOx@smile.fi.intel.com>
References: <20250926014552.1625950-1-jefflin994697@gmail.com>
 <20251106093131.2009841-1-jefflin994697@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251106093131.2009841-1-jefflin994697@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Nov 06, 2025 at 05:31:31PM +0800, Jeff Lin wrote:
> The RAA229141A is a digital dual output multiphase (X+Y ≤ 12) PWM
> controller designed to be compliant with Intel VR13, VR13.HC, VR14 and
> VR14.Cloud specifications, targeting VCORE and auxiliary rails.
> 
> The RAA229141A supports the Intel SVID interface along with PMBus V1.3
> specifications, making it ideal for controlling the microprocessor core and
> system rails in Intel VR13, VR13.HC, VR14 and VR14.Cloud platforms.

Avoid In-Reply-to: email headers. I.o.w. start a new email thread when issue a
new version of the patch or series.

(No need to resend in _this_ case, unless maintainer requests to do so.)

-- 
With Best Regards,
Andy Shevchenko



