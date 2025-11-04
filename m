Return-Path: <linux-kernel+bounces-884518-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 22299C30598
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 10:53:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 17F2D3AE6F8
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 09:46:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44FC626E704;
	Tue,  4 Nov 2025 09:45:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MyWwNSl8"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A5D0313267
	for <linux-kernel@vger.kernel.org>; Tue,  4 Nov 2025 09:45:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762249553; cv=none; b=SvbW1DBTZYNu2bSMD8568FvDYJnXqKNfDpYlzeMfEKFYNFhXec9HB8joVeoacFl2p3vhhZ4H+g4M+nkg8+zhS7XHO0bEaSs4q367nGhZRXDLl8WcfYiT6s5qTUPuttywHk/LFQNZi3xQUBjGtxfmVnepH2YfakmUOgS8cjHZ81w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762249553; c=relaxed/simple;
	bh=PfzR491QLTBWUAYPoRuLBlqzoqrr7QKgCTjOlV/xI1I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FPhDgGBEimPiLx1BHnUiIUvcthvIR861SXc2wiRp80dwZhMqfgHhl3FrOBRZdUSGhW9/rtf+HwfccmICubn9pKOl1cwzknTATXOsRdJyzwd19u81jO+B4a4Mmx+zbVAkJ8vUQkiXH29iOaBNsu9B30MqGanPDUMHJWZRj8VAz5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MyWwNSl8; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762249552; x=1793785552;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=PfzR491QLTBWUAYPoRuLBlqzoqrr7QKgCTjOlV/xI1I=;
  b=MyWwNSl8WEV2eYu12sRkowjm34rMruEZNzgdQ7HA3mTdJYWVTncWso5x
   YT/A7ruRb7hTVriwMjwBr07JgVdb0t7UzWmaCEdPZK6gMjHI4CadYQyyc
   Km4zdN09qzK168wU9UowoGpT82NHCRWWQPODPRYg81GqI6ODx81cDwhTH
   rXYGBEyAzpdLuAAgidLjd2os2abz58JeJswyPzLHAxPRGcTbDB3CZPhwa
   m97Pvkcf3gCLIRSvsnIN6nNq2GgXg6hynLJXVOj/ZUIwtSFnm4deL42+M
   FT1+QYcmts5HWWPamFZU/djLAN5C20f1/oSAQH/cG+NnmXOPxNPIzBQST
   Q==;
X-CSE-ConnectionGUID: tzWm8tC2Qu6+TWAb4Anm+A==
X-CSE-MsgGUID: CP/tI8kXTzWpQSA7A1qb0g==
X-IronPort-AV: E=McAfee;i="6800,10657,11602"; a="67993808"
X-IronPort-AV: E=Sophos;i="6.19,278,1754982000"; 
   d="scan'208";a="67993808"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2025 01:44:07 -0800
X-CSE-ConnectionGUID: eviD7y8wQD6mxE6CP4vzVA==
X-CSE-MsgGUID: F4avzpCWQoWpJWSMhNFFHw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,278,1754982000"; 
   d="scan'208";a="191205788"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO ashevche-desk.local) ([10.245.245.146])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2025 01:44:05 -0800
Received: from andy by ashevche-desk.local with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1vGDa6-00000005QIA-2TUo;
	Tue, 04 Nov 2025 11:44:02 +0200
Date: Tue, 4 Nov 2025 11:44:02 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: David Laight <david.laight.linux@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Guan-Chun Wu <409411716@gms.tku.edu.tw>,
	Kuan-Wei Chiu <visitorckw@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/1] base64: Unroll the tables initialisers
Message-ID: <aQnK4jxPGOVsmjDt@smile.fi.intel.com>
References: <20251103190510.627314-1-andriy.shevchenko@linux.intel.com>
 <20251103221857.1acaf6ab@pumpkin>
 <aQm2366wMJ1K1fp7@smile.fi.intel.com>
 <20251104090740.716dd95f@pumpkin>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251104090740.716dd95f@pumpkin>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Nov 04, 2025 at 09:07:40AM +0000, David Laight wrote:
> On Tue, 4 Nov 2025 10:18:39 +0200
> Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
> > On Mon, Nov 03, 2025 at 10:18:57PM +0000, David Laight wrote:

...

> > > > +	[BASE64_STD] = {
> > > > +		0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff,	/*   0 -   7 */  
> > > 
> > > You need to use -1 not 0xff.  
> > 
> > Whu? The s8 type is pretty much 8-bit, care to explain the point?
> 
> I think it is clang that complains that the value is out of range.

I use clang on daily basis to compile kernel and I definitely compiled
the proposal I sent. So, no, not this one.

-- 
With Best Regards,
Andy Shevchenko



