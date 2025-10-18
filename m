Return-Path: <linux-kernel+bounces-859401-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 315BDBED842
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Oct 2025 21:07:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BA7DE19A3660
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Oct 2025 19:07:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBC9B25D540;
	Sat, 18 Oct 2025 19:07:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KU53z1k/"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C93181EF363
	for <linux-kernel@vger.kernel.org>; Sat, 18 Oct 2025 19:07:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760814432; cv=none; b=eCKaAlpVuwepw8R15jCmxJpqLkO5a/xaexu+vk9M6iYR/Hv+np6wtQqYNUG9qOrTHMPR1qkAdvFkQrCtTV2D6xC+2BJznexqam551obCaS97EweSRpbr6xxkElGZ5qVH9scPwyVavr4VRdNGjHC37ib/X48O51lVMvSQA5d3XJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760814432; c=relaxed/simple;
	bh=Kp1YgT8hnutL1+pbR3R6R8y0utIGuv6jGTfvzM42muM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UHI9VyVw1lDkv4nwLoyA4o9rHDnuKmljP22Ul6n6BtL/YSteydyNuj/Li4MGWveX7BOUgyxXwPtAAO+2FrKY7FgSaV1/F9yb1oV7TorvwKV3fi2XCI94Z5ILGWTkLKhFAyrrOVpGsDXyOBk8zlD650usfUe13Nzv4uVZ9IlmPeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KU53z1k/; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760814430; x=1792350430;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Kp1YgT8hnutL1+pbR3R6R8y0utIGuv6jGTfvzM42muM=;
  b=KU53z1k/VLrhIgmTW8tJ7pH4OozNqNw8WPBLpbcCsWzIIdc5Ej/LcVPH
   MyjXahaq+Kh5VS1Y0fyMROCUo9zCPVbNe9dPTU74AZxR3C15F2TdLaNgj
   yXHjjLKKkYS2cd95Nd8rj51bTonSyPQHDH+F48OXSQmKqdeSGrxL/qiZW
   rOM/7LRKSHuGtDz+SM3Z0lBTbhimFzzTTT5dGzOh3uVMEYx3xIMuaqdIz
   oDHuJH0XgXpYYT2LxxtvsmVZlVrpZkfY6SFDZ36gFNPGBoS/C0P+kbpE/
   d6k5kJyySLvTBL6W3ajN9efnR7kToN342qQWtWqKYkSVput+ev+8VnQ4S
   w==;
X-CSE-ConnectionGUID: 7EW4Ojl8Rlev5kQL88Ec5w==
X-CSE-MsgGUID: RT45+8sjSUSW8zPQfMOkEQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="66865995"
X-IronPort-AV: E=Sophos;i="6.19,239,1754982000"; 
   d="scan'208";a="66865995"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2025 12:07:09 -0700
X-CSE-ConnectionGUID: nkXuSXAWSreuliajbKE/+g==
X-CSE-MsgGUID: FakW8o3rSaeDKK0dz/Wx7w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,239,1754982000"; 
   d="scan'208";a="183483132"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO ashevche-desk.local) ([10.245.244.194])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2025 12:07:06 -0700
Received: from andy by ashevche-desk.local with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1vACGc-00000000xF1-3aLq;
	Sat, 18 Oct 2025 22:07:02 +0300
Date: Sat, 18 Oct 2025 22:07:02 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Szuying Chen <chensiying21@gmail.com>
Cc: akpm@linux-foundation.org, dan.j.williams@intel.com, gourry@gourry.net,
	jhubbard@nvidia.com, akinobu.mita@gmail.com, sumanthk@linux.ibm.com,
	peterz@infradead.org, huang.ying.caritas@gmail.com,
	linux-kernel@vger.kernel.org, Andrew_Su@asmedia.com.tw,
	Yd_Tseng@asmedia.com.tw, Ed_Huang@asmedia.com.tw,
	Cindy1_Hsu@asmedia.com.tw, Jesse1_Chang@asmedia.com.tw,
	Richard_Hsu@asmedia.com.tw, Chloe_Chen@asmedia.com.tw
Subject: Re: [PATCH] kernel: resourse: Add conditional handling for ACPI
 device
Message-ID: <aPPlVmJXKcMYmjXp@ashevche-desk.local>
References: <20251017023531.5616-1-Chloe_Chen@asmedia.com.tw>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251017023531.5616-1-Chloe_Chen@asmedia.com.tw>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Oct 17, 2025 at 10:35:31AM +0800, Szuying Chen wrote:
> To avoid address conflicts and related errors, specific checks for
> the ACPI device "AMDIF031" should be bypassed.

TL;DR: NAK.

No, this is not how we should do the quirks (besides the use of CamelCase).
Also, please provide more info why firmware may not be fixed properly at
the same time, so we won't need this on an updated version?

-- 
With Best Regards,
Andy Shevchenko



