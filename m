Return-Path: <linux-kernel+bounces-878402-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E19E2C2089B
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 15:17:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 44B2B4EFCEF
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 14:07:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B634C18A93F;
	Thu, 30 Oct 2025 14:07:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZZjbq4bS"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 846BB126BF1
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 14:07:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761833274; cv=none; b=sh/n+gNtR1YzhKVOxFn2j9qd5UsXSDIK0QcuMNdcSoRguSdt7o8FxNy7eTBCPb+r2xMSQtQMUn8s8gFh251XpFO+Zr2DKbBi7Qer8TVkT5e8xax2rCveme0UAWqYBimgLpfxgBaloirue1Ymo+TewJZ67oM58PdCP/U/FB0PR3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761833274; c=relaxed/simple;
	bh=4CPVv7hFL30viS0SHHkXvcnbsKyga8NM8ZRxzp4WpYM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VjNWt42HHoZBYpa1VRl01I3QWFTvmJOOXHqOM3DTKDoSoO3ukjxnu7QmKpWSC/e6/xQ4CR2CkBcNIQFMrkfVeRKlR5WMinLDNuI7gdbmwAoTlS609eCk5OXrPoNwBTnUauydoDWKyKTj9fyIdj9vK+DqahSWgoAJy+8MHPCkUR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZZjbq4bS; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761833272; x=1793369272;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=4CPVv7hFL30viS0SHHkXvcnbsKyga8NM8ZRxzp4WpYM=;
  b=ZZjbq4bSw+9a65fTzKUKxtUpqT8p4nUXZHrjL7VbqxqcMvCY1TpcgvPf
   geGBB8NFu70dU4o7ednESAdeAXH37wGMH0VGVXQwlGt3/VDDBo3RhMATz
   5zSeeBr7OIQkZoVMrFuOl1BCSnoBJy9pe+V1WNHCUdzaHDvyXBFKRDatw
   bfwTYjdek/74U1dSK+wS2MTk/DQBj0WOYmjgkQG1fO9clWfQBrjDwcCzN
   BliRbNSkmD6QJarHhOMSOsmFDX1AYyQDoRRCueOI1y8j4icHFknyOYvM/
   +c9qY+8VFrEkjE9lCIpCVtwsOcZ4DYi/G0dttIUjit3aqvPZthDis6LP6
   A==;
X-CSE-ConnectionGUID: /BINTJpLRqChpR9C4FuvjQ==
X-CSE-MsgGUID: Uap+jviXRhmmL5VBWY2RfA==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="67809979"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="67809979"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2025 07:07:52 -0700
X-CSE-ConnectionGUID: A3Dw8L3KREWjhLL5v/ETfQ==
X-CSE-MsgGUID: iecUXrMdQwSrEmw4K8Yo9g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,266,1754982000"; 
   d="scan'208";a="185843818"
Received: from fpallare-mobl4.ger.corp.intel.com (HELO ashevche-desk.local) ([10.245.245.174])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2025 07:07:50 -0700
Received: from andy by ashevche-desk.local with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1vETJc-00000003vrh-0mwX;
	Thu, 30 Oct 2025 16:07:48 +0200
Date: Thu, 30 Oct 2025 16:07:47 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Feng Tang <feng.tang@linux.alibaba.com>, linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Petr Mladek <pmladek@suse.com>
Subject: Re: [PATCH v3 0/6] panic: sys_info: Refactor and fix a potential
 issue
Message-ID: <aQNxM40aDIrpfE0K@smile.fi.intel.com>
References: <20251030132007.3742368-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251030132007.3742368-1-andriy.shevchenko@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Oct 30, 2025 at 12:44:16PM +0100, Andy Shevchenko wrote:

+Cc: Petr, sorry, forgot to add you to the Cc list.

> While targeting the compilation issue due to dangling variable,
> I have noticed more opportunities for refactoring that helps to
> avoid above mentioned compilation issue in a cleaner way and
> also fixes a potential problem with global variable access.
> Please, give it a try.
> 
> Changelog v3:
> - addressed an issue with empty parameter returned (Feng)
> - gathered tags (Feng)
> 
> Changelog v2:
> v2: https://lore.kernel.org/r/20251029111202.3217870-2-andriy.shevchenko@linux.intel.com
> - rebased on top of the current codebase
> - addressed an issue when converting to match_string() (Feng)
> - Cc'ed to Petr (requested by Feng)
> 
> v1: https://lore.kernel.org/r/20250711095413.1472448-1-andriy.shevchenko@linux.intel.com

-- 
With Best Regards,
Andy Shevchenko



