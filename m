Return-Path: <linux-kernel+bounces-727952-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B9EAAB021B6
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 18:27:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AF7F5545442
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 16:27:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0517E2F0E42;
	Fri, 11 Jul 2025 16:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IwL9UHJl"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEDB52F0C55
	for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 16:26:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752251212; cv=none; b=sLu9kJU4oihz5YZpg7mOuoX4+KkczKsnuoiJn/eFcag3sQHIcy/WPfpeH1bFRRTdg6wsaG90CjgVX9qWKhzt22mUJp4O8AAh/ySc3EvnVAB/xNsNrKQ001zZo6iYA7BhFVBqfrf+20fLnq4Ch8u/eTWW6t9/CXnArWTxbIfGvj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752251212; c=relaxed/simple;
	bh=ps7kQ6rczBKh7tRIYxrze2SFwB5jLge2FmHNWfri1nE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GJDzxM+9nfz1j+gzysb/ryJVl+WdYWHJpJAGP4p+2rrvgHkbxYp8AjFpwaIf+OgjZBzW401DVXIONwHHGyU5NEMLEMWnhdZ0YLij3INbD1mplm++CYdZsr98J/3Y+Tnn5RlOZarOAtcW9N0pDSqViyMhhjKmyO4kl7yfF0ewg6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IwL9UHJl; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752251211; x=1783787211;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ps7kQ6rczBKh7tRIYxrze2SFwB5jLge2FmHNWfri1nE=;
  b=IwL9UHJlkykPmJ74EjAW46I4p9F2VUhr2FZ9HEPZddx2FUtvMgVDI4n2
   Gqp1MT7pzUr1/PAoVjrrN33/2a7aG6jQcVLD0JnbfcQtYHulvpE7kw1fc
   Jtf8vRFyWTe3X9+Ku4qXcinSilO1VlXU/B4L3bEEnRPt4rGFmiR5vqZPh
   X/KvFchsnRa6BPBSSbJwzI5iaPvDk9U4CVnVRAfgFPDxMkz25jfymR0ni
   bCK77gElpPt7RCozmtkRB7xwcQ2vS6aGbHchA3dUUmG6IZRmB/OR+GJ8J
   EHCHLPwfwNniPuNMNxK2wepKmXp11U6gJ1WlDcMxBXKyrS12pJw3Bn8/x
   g==;
X-CSE-ConnectionGUID: CQ+lIyjpTA+VCrFa+D57CA==
X-CSE-MsgGUID: QzMrpO0SSf2pC+cr2BknuA==
X-IronPort-AV: E=McAfee;i="6800,10657,11491"; a="53773897"
X-IronPort-AV: E=Sophos;i="6.16,304,1744095600"; 
   d="scan'208";a="53773897"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2025 09:26:50 -0700
X-CSE-ConnectionGUID: VStXBdpUQAOvwh3slveaTQ==
X-CSE-MsgGUID: CfN9kn3WQSukLDsLsDVA7A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,304,1744095600"; 
   d="scan'208";a="156896665"
Received: from smile.fi.intel.com ([10.237.72.52])
  by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2025 09:26:48 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1uaGaD-0000000Ea45-2Jrb;
	Fri, 11 Jul 2025 19:26:45 +0300
Date: Fri, 11 Jul 2025 19:26:45 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Feng Tang <feng.tang@linux.alibaba.com>
Cc: Petr Mladek <pmladek@suse.com>, linux-kernel@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Nathan Chancellor <nathan@kernel.org>
Subject: Re: [PATCH v1 4/7] panic: sys_info: Replace struct sys_info_name
 with plain array of strings
Message-ID: <aHE7RfMy2St7kPma@smile.fi.intel.com>
References: <20250711095413.1472448-1-andriy.shevchenko@linux.intel.com>
 <20250711095413.1472448-5-andriy.shevchenko@linux.intel.com>
 <aHEr8NO4xHGPNjJo@U-2FWC9VHC-2323.local>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aHEr8NO4xHGPNjJo@U-2FWC9VHC-2323.local>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Jul 11, 2025 at 11:21:20PM +0800, Feng Tang wrote:
> On Fri, Jul 11, 2025 at 12:51:10PM +0300, Andy Shevchenko wrote:
> > There is no need to keep a custom structure just for the need of
> > a plain array of strings. Replace struct sys_info_name with plain
> > array of strings.
> > 
> > With that done, simplify the code, in particular, naturally use
> > for_each_set_bit() when iterating over si_bits_global bitmap.
> 
> IIUC, this will not work.
> 
> Actually there is a hole in the bitmap definition:
> 
> #define SYS_INFO_PANIC_CONSOLE_REPLAY	0x00000020
> 
> Ad Petr pointed in his review, it's only for panic use, that's why
> we make it invisible in sys_info.c. Eventually, we plan to deprecate
> 'panic_print', and use 'panic_sys_info' and 'panic_console_replay' to
> replace it. After that happens that user only see string interface,
> we can change these bitmap definition and remove the hole, and use
> your cleanup here.

Yeah, the hole should be move to the end of the bitmap, so we can have all
visible entries be sequential.

-- 
With Best Regards,
Andy Shevchenko



