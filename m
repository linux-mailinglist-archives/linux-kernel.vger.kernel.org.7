Return-Path: <linux-kernel+bounces-884316-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B3EAAC2FDEF
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 09:29:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A6E4D18C291D
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 08:25:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4A32313537;
	Tue,  4 Nov 2025 08:18:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aw7QFVOD"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49E4D28643A
	for <linux-kernel@vger.kernel.org>; Tue,  4 Nov 2025 08:18:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762244327; cv=none; b=Zsy04QNlAtiFmjQoYlKL6C8zt3kQeOXEssINSkeF1XfaIwmvbQzlNv75C+CaOVE4CZmmmkU6cp37ocoZwGLxeUvWUmraxjph8b4vPD8lkegFcup66inmr++gzh0c9FvYYmxf6lwu3UQzfia/LCbTkcFBDVSJO/azod5njjqw8vc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762244327; c=relaxed/simple;
	bh=DrnE3OSkygbOqVfCWXNUxWKp1UYl1DB4Wj95apv3B/g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MLDW0kcIKlv24QED9yvzA7VarebZt7wQ1Gcu4UjW6rSCLuiBpLX50lP21JZ63VZVjdeLC2V2de1MFH8Xy/145Y4CsU2mIB/mEKh3cxqE3aQgJAesO7gcSSH/yY2Ighb8MXVSTmL9rz1BaFqdc6yaAVqQaOmwAW2VMf0hHfQyTYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aw7QFVOD; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762244324; x=1793780324;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=DrnE3OSkygbOqVfCWXNUxWKp1UYl1DB4Wj95apv3B/g=;
  b=aw7QFVODEYPyj/UXGLwR6FrhDDB2xrQku5JMjeaaCPgNP/iQTBPqJpF2
   lqeUmDyH8+hlRfmasevTrYLSwUWKmMPMBm1OZios2SpcfOat0r0itPk2o
   EeZ4E118+LPzz/pS3De/kYLjdYUC17RRaT1s8cRe3tKyMjZCXiRlgvNLS
   16OGy9jgv7GxqRzSR/1msO6N6lWcBfeo7HFEcgkAGLzkLaPWHtPOYfe7U
   ZQ4oike6VC9lAarSvDrEzB+PnmlOiuQQPjI2zK72sBT7By1ZiO/aFtjhl
   cpOIJr6+cXjPQFV5H1BHUS70qmsylOm9bj/5tLJc0VxWqnh5wphMp5zKT
   w==;
X-CSE-ConnectionGUID: M2lG6e5uRtCO2/Fyr8EBiA==
X-CSE-MsgGUID: sK5+6BgtRbaP6azFANRQ9w==
X-IronPort-AV: E=McAfee;i="6800,10657,11602"; a="64029189"
X-IronPort-AV: E=Sophos;i="6.19,278,1754982000"; 
   d="scan'208";a="64029189"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2025 00:18:43 -0800
X-CSE-ConnectionGUID: 5V3YlPf2QG2gI0tjfguykA==
X-CSE-MsgGUID: KwCYhnKNTJ2mU+jZ2wLmWA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,278,1754982000"; 
   d="scan'208";a="187542611"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO ashevche-desk.local) ([10.245.245.146])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2025 00:18:42 -0800
Received: from andy by ashevche-desk.local with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1vGCFT-00000005P4S-3DIZ;
	Tue, 04 Nov 2025 10:18:39 +0200
Date: Tue, 4 Nov 2025 10:18:39 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: David Laight <david.laight.linux@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Guan-Chun Wu <409411716@gms.tku.edu.tw>,
	Kuan-Wei Chiu <visitorckw@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/1] base64: Unroll the tables initialisers
Message-ID: <aQm2366wMJ1K1fp7@smile.fi.intel.com>
References: <20251103190510.627314-1-andriy.shevchenko@linux.intel.com>
 <20251103221857.1acaf6ab@pumpkin>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251103221857.1acaf6ab@pumpkin>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Nov 03, 2025 at 10:18:57PM +0000, David Laight wrote:
> On Mon,  3 Nov 2025 20:05:10 +0100
> Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
> 
> > Currently the initialisers of the tables have duplicate indices.
> > This prevents from building with `make W=1`.
> > 
> > To address the issue, unroll the table initialisers with generated
> > arrays by the following Python excerpt:
> > 
> > CHARS = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789"
> > 
> > def gen_table(ch62, ch63):
> >     table = [ 0xff ] * 256
> >     for idx, char in enumerate(CHARS):
> >         table[ord(char)] = idx
> >     table[ord(ch62)] = 62
> >     table[ord(ch63)] = 63
> > 
> >     for i in range(0, len(table), 8):
> >         print (f"\t{', '.join(f"0x{c:02x}" for c in table[i:i+8])},\t/* {i:-3d} - {i+7:-3d} */")

...

> > +	[BASE64_STD] = {
> > +		0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff,	/*   0 -   7 */
> 
> You need to use -1 not 0xff.

Whu? The s8 type is pretty much 8-bit, care to explain the point?

> > +		0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff,	/*   8 -  15 */
> > +		0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff,	/*  16 -  23 */
> > +		0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff,	/*  24 -  31 */
> > +		0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff,	/*  32 -  39 */
> 
> Nothing wrong with [ 0 ... 39 ] = -1,

Have you tried? It's unreadable if we use ranges.

> > +		0xff, 0xff, 0xff, 0x3e, 0xff, 0xff, 0xff, 0x3f,	/*  40 -  47 */
> > +		0x34, 0x35, 0x36, 0x37, 0x38, 0x39, 0x3a, 0x3b,	/*  48 -  55 */
> > +		0x3c, 0x3d, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff,	/*  56 -  63 */
> > +		0xff, 0x00, 0x01, 0x02, 0x03, 0x04, 0x05, 0x06,	/*  64 -  71 */
> > +		0x07, 0x08, 0x09, 0x0a, 0x0b, 0x0c, 0x0d, 0x0e,	/*  72 -  79 */
> > +		0x0f, 0x10, 0x11, 0x12, 0x13, 0x14, 0x15, 0x16,	/*  80 -  87 */
> > +		0x17, 0x18, 0x19, 0xff, 0xff, 0xff, 0xff, 0xff,	/*  88 -  95 */
> > +		0xff, 0x1a, 0x1b, 0x1c, 0x1d, 0x1e, 0x1f, 0x20,	/*  96 - 103 */
> > +		0x21, 0x22, 0x23, 0x24, 0x25, 0x26, 0x27, 0x28,	/* 104 - 111 */
> > +		0x29, 0x2a, 0x2b, 0x2c, 0x2d, 0x2e, 0x2f, 0x30,	/* 112 - 119 */
> > +		0x31, 0x32, 0x33, 0xff, 0xff, 0xff, 0xff, 0xff,	/* 120 - 127 */
> > +		0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff,	/* 128 - 135 */
> > +		0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff,	/* 136 - 143 */
> > +		0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff,	/* 144 - 151 */
> > +		0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff,	/* 152 - 159 */
> > +		0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff,	/* 160 - 167 */
> > +		0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff,	/* 168 - 175 */
> > +		0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff,	/* 176 - 183 */
> > +		0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff,	/* 184 - 191 */
> > +		0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff,	/* 192 - 199 */
> > +		0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff,	/* 200 - 207 */
> > +		0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff,	/* 208 - 215 */
> > +		0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff,	/* 216 - 223 */
> > +		0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff,	/* 224 - 231 */
> > +		0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff,	/* 232 - 239 */
> > +		0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff,	/* 240 - 247 */
> > +		0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff,	/* 248 - 255 */
> > +	},

...

> This is impenetrable crap...

Send your version for the review, please, we still have a build issue here.
But I definitely do not like current state of affairs.

-- 
With Best Regards,
Andy Shevchenko



