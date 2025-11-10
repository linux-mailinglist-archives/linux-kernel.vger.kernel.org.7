Return-Path: <linux-kernel+bounces-893509-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 637F0C47977
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 16:40:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8176D4F2205
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 15:35:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72183257841;
	Mon, 10 Nov 2025 15:35:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JtFxUy8E"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E882B19F41C
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 15:35:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762788910; cv=none; b=DnkFOrsmYLJ0trJ9UkMfz5fr7N1BNHjz4agUvYDScjhb6uKUClNcU0dL3ZS1Dh4lXLkVZlBi7fHgSo4O4dFGlQCXc48J70lbhODy4pG0tRmjCbIKbExMnVDOZF/u7nMSiPQLl/YR2k5jjahem/KZ6GthNFfrFLzsI93rMU5Glc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762788910; c=relaxed/simple;
	bh=Vll0viGrFpBgqaCXcM3MMzrDn7mBoXFqsinEjxNKOpw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bjzAxP8gfa1ckRxs9n2r7/vrV+5im/3RvnUg6McmMqQXHwCC8pDCXIym8vbdw/fpww4DCyLFRj0lhszixN1GrOxjRLP+fFnTQf1L6vHS/yAzWdFd7sOS/+mUmRKUyWRTUYtjLfv+OIotIyNC0FQ1SuVlx/3MIn+6oMV1jm7QTOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JtFxUy8E; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762788909; x=1794324909;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Vll0viGrFpBgqaCXcM3MMzrDn7mBoXFqsinEjxNKOpw=;
  b=JtFxUy8ELntVUy/p787Efur5MP7eKoeY26BWFhSpZtDH2vI1GrXl8ICl
   2K6TYCghNNMfJUAsIoHxKhkD0aR9sD/nCBqMI1k361y0ZpVAD7x+OmvTf
   ynXKoIT2YV8ABAUk1GjgQC940akPyXkqgVPRaNIwEP/ByQZ/D5hkHx1eg
   M7ozQ4ZsKgS4v0JlMm940Xc5SDNWlegbCcQa5S7GbbUSie8PpBShrCft1
   LVRPN6kGSWinjzHMuCwOaQem6OkZksN/aqVkTQXL4VEm5415wES4w+1Bh
   XYpksdzru6ANBWGyUrjsYMAAuqw6AXUbXzEEbIai0/i/pSAReH4ebeeKU
   A==;
X-CSE-ConnectionGUID: kHRB9UHDSKKP/6u/JnMWJQ==
X-CSE-MsgGUID: A4GGhHc6RKWnPZxZAF4OEA==
X-IronPort-AV: E=McAfee;i="6800,10657,11609"; a="64046011"
X-IronPort-AV: E=Sophos;i="6.19,294,1754982000"; 
   d="scan'208";a="64046011"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2025 07:35:08 -0800
X-CSE-ConnectionGUID: rLXXQdKCShWF+873cb7XZg==
X-CSE-MsgGUID: XJORpZfnSCO8aEgPdepsLQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,294,1754982000"; 
   d="scan'208";a="188446952"
Received: from kniemiec-mobl1.ger.corp.intel.com (HELO ashevche-desk.local) ([10.245.245.235])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2025 07:35:07 -0800
Received: from andy by ashevche-desk.local with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1vITv6-00000007V7i-0nnn;
	Mon, 10 Nov 2025 17:35:04 +0200
Date: Mon, 10 Nov 2025 17:35:03 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Kuan-Wei Chiu <visitorckw@gmail.com>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>,
	Jonathan Cameron <jic23@kernel.org>
Subject: Re: [PATCH v1 1/1] math.h: Amend kernel-doc and add a note about
 signed type limits
Message-ID: <aRIGJ8xo-6TeJUmc@smile.fi.intel.com>
References: <20251106152051.2361551-1-andriy.shevchenko@linux.intel.com>
 <aRID4efkPf6x6Gqi@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aRID4efkPf6x6Gqi@google.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Nov 10, 2025 at 11:25:21PM +0800, Kuan-Wei Chiu wrote:
> On Thu, Nov 06, 2025 at 04:20:51PM +0100, Andy Shevchenko wrote:

...

> > + * NOTE, for signed type if @x is the minimum, the returned result is undefined
> > + * as there is not enough bits to represent it as a positive number.
> 
> Nit: s/is/are

I hope Andrew can combine this with the original patch.

> Otherwise, the patch is:
> Reviewed-by: Kuan-Wei Chiu <visitorckw@gmail.com>

Thank you!

-- 
With Best Regards,
Andy Shevchenko



