Return-Path: <linux-kernel+bounces-889892-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 78625C3EC65
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 08:39:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 23022188C74C
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Nov 2025 07:39:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25FF230C37D;
	Fri,  7 Nov 2025 07:39:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BTinbj2Y"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 743B330C361
	for <linux-kernel@vger.kernel.org>; Fri,  7 Nov 2025 07:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762501165; cv=none; b=iWhWpqjO7vBynDKRU+psu7LS8wOvLhdkxVRko214ThQM8WX4Q8h6oPFQuKkWg271FJzdVA8b11u+MeN40dKmJj2hDut+3HXKNccNPRqs2XkR2Gg6dkQIC0p7PyQWb7Pmt9crLTdX+h/YBNQCs72AF52Bb77NVNWSbUltKCWrJUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762501165; c=relaxed/simple;
	bh=F7X6D2bFuRGSi9b8DsU3MEjvlXD2IHMPAsoG2KIu+yY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=suyoXv9KBRlPtH/n7bo/C/12jLea+M67npKA2xJmQu22kK0CWFY81gab50cJeajnRNQmBmi556v6IE6p1Cq6qz8B84Z9/YjkWIdkCTymd6wyrhrT1ePvjA+Iv981p8hVUiOIE55JOyiA7jufxyO+0YcbGrkLofqVWQ/eGoipkLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BTinbj2Y; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762501163; x=1794037163;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=F7X6D2bFuRGSi9b8DsU3MEjvlXD2IHMPAsoG2KIu+yY=;
  b=BTinbj2YjLuEJFAMD49ub8nUBXoiPrZy0eUvVFg9nw+zLTo/WRNB+yp9
   paFS6y+rBo9ADPZuLuvjzC+CUKY0hV4HKh3lKiljbqTS7QzTcWneVniJD
   7EgqLC3XHQWwEZvcOxNPDqRFK+FfaySURk/5E4MB6jbpN6sis//tFAhXs
   cq4O7DRY/wfCVnszPf/QyAgzCE2hUaXAOSReNXvjEflqaEMuHkKbOW07O
   OYjSIJZSTb6aIwehkj5bEeJSq1DoFgSoGWi1tGtDwaMNYbsIHpS6sNTqS
   acO+EfHrMMob4oFBRCNeh9/qskBTY8ewnn5kOBEk2qFHDMuDlUW2mP5DK
   g==;
X-CSE-ConnectionGUID: cEkCHR7MT+Op6vS7MKu5HQ==
X-CSE-MsgGUID: fIZS8oFyRM2k6aSuPgZLRw==
X-IronPort-AV: E=McAfee;i="6800,10657,11605"; a="76098455"
X-IronPort-AV: E=Sophos;i="6.19,286,1754982000"; 
   d="scan'208";a="76098455"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2025 23:39:22 -0800
X-CSE-ConnectionGUID: gp7xzaDERJ+J8pgaa4uZug==
X-CSE-MsgGUID: xQQJIxsKRPOLXQCJnaY7iw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,286,1754982000"; 
   d="scan'208";a="188411125"
Received: from vpanait-mobl.ger.corp.intel.com (HELO ashevche-desk.local) ([10.245.245.27])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2025 23:39:20 -0800
Received: from andy by ashevche-desk.local with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1vHH41-00000006OEC-2iuS;
	Fri, 07 Nov 2025 09:39:17 +0200
Date: Fri, 7 Nov 2025 09:39:17 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Ira Weiny <ira.weiny@intel.com>
Cc: nvdimm@lists.linux.dev, linux-kernel@vger.kernel.org,
	Dan Williams <dan.j.williams@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Dave Jiang <dave.jiang@intel.com>
Subject: Re: [PATCH v1 1/1] libnvdimm/labels: Get rid of redundant 'else'
Message-ID: <aQ2iJUZUDf5FLAW-@smile.fi.intel.com>
References: <20251105183743.1800500-1-andriy.shevchenko@linux.intel.com>
 <690d4178c4d4_29fa161007f@iweiny-mobl.notmuch>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <690d4178c4d4_29fa161007f@iweiny-mobl.notmuch>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Nov 06, 2025 at 06:46:48PM -0600, Ira Weiny wrote:
> Andy Shevchenko wrote:
> > In the snippets like the following
> > 
> > 	if (...)
> > 		return / goto / break / continue ...;
> > 	else
> > 		...
> > 
> > the 'else' is redundant. Get rid of it.
> 
> I still need a why to in this commit message.

Sure.

[snip]

...

> > -	else if (claim_class == NVDIMM_CCLASS_UNKNOWN) {
> > -		/*
> > -		 * If we're modifying a namespace for which we don't
> > -		 * know the claim_class, don't touch the existing guid.
> > -		 */
> > -		return target;
> > -	} else
> > +	if (claim_class == NVDIMM_CCLASS_NONE)
> >  		return &guid_null;
> > +
> > +	/*
> > +	 * If we're modifying a namespace for which we don't
> > +	 * know the claim_class, don't touch the existing guid.
> > +	 */
> > +	return target;
> 
> This is not an equivalent change.

It's (okau. almost. later on that). The parameter to the function is enum and
the listed values of the enum is all there. The problematic part can be if
somebody supplies an arbitrary value here. Yes, in such a case it will change
behaviour and I think it is correct in my case as UNKNOWN is unknown, and NONE
is actually well known UUID.

...

> > -	else if (claim_class == NVDIMM_CCLASS_UNKNOWN) {
> > -		/*
> > -		 * If we're modifying a namespace for which we don't
> > -		 * know the claim_class, don't touch the existing uuid.
> > -		 */
> > -		return target;
> > -	} else
> > +	if (claim_class == NVDIMM_CCLASS_NONE)
> >  		return &uuid_null;
> > +
> > +	/*
> > +	 * If we're modifying a namespace for which we don't
> > +	 * know the claim_class, don't touch the existing uuid.
> > +	 */
> > +	return target;
> 
> This is not an equivalent change.

Same explanation as above. I'll put it into the commit message.

-- 
With Best Regards,
Andy Shevchenko



