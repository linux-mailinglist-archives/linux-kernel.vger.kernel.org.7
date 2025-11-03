Return-Path: <linux-kernel+bounces-882909-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 502D1C2BD4F
	for <lists+linux-kernel@lfdr.de>; Mon, 03 Nov 2025 13:51:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A5684188A2F1
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 12:51:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD1813009C4;
	Mon,  3 Nov 2025 12:50:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CvrAwKd4"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DE2D2DA759
	for <linux-kernel@vger.kernel.org>; Mon,  3 Nov 2025 12:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762174236; cv=none; b=fq5y3Y0j4efJZeyyygHgOP7J82sUUZgTPJTA1qKHjbS39B6jYEEnVd7JDCEMHq3PhvZMPh2Ub0W8Dp5cvoxUnDC6LcnZdwOgASIUqDyNr8ZSkbKSGaTbe6ifQJKQPCixSei2xuyNfz84peBlBle+ZAazgzRMMgeAjgtLoi0Uu6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762174236; c=relaxed/simple;
	bh=nKQ87BqZEp5fZCIHzdaIWwzLb+XkHwNqcYDs0+6IYD8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RzQvukafwBCy87y0HKAXU0Nm4G4JBXSD5Dv2nw4BPFyNDYDcYMqNIy9mmZtvkqNdh9Xa5FmhrWbfharB5yHShWa1S30hQxdHZJ1jnqRJ8vsENYyHOmVGzOGh1WtFpZ5sX269b9+rbKy0FzbXfz0o4jELekUxNZw6v10EhlCquTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CvrAwKd4; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762174234; x=1793710234;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=nKQ87BqZEp5fZCIHzdaIWwzLb+XkHwNqcYDs0+6IYD8=;
  b=CvrAwKd4icGLiQXUvY+QDZyh9UkiIT3jd1nFQKidke2f5SEQTpNuKLTr
   sVDB120647/nEdhaJPExIzFhBQ2iceGoA8aTN6v0dfXYZAi0QYBj/4dSu
   V7iG5E1PL/6ap6icnk4ySGdM9XNfTz4zMCSkYWOQ8cBcNtO9HCgZsdWdi
   /rJHZl2rem28Hvu0ip7ml33Uq099+Rhz0oFdeZILMWsYTNNUlcQnQjaHU
   62Uf6vBcKC7OFOK+KU6eBCRvaS4m+eE9lmgQvapznrM4KDeQxXVTkQphc
   GxMcv+8FnfdIKmkvdbkZAgY94BBwq24mLI5rW0zjI9UlWTOMHHAWBpjl0
   w==;
X-CSE-ConnectionGUID: +CBUCq+iS+yyOzu+GiaO0Q==
X-CSE-MsgGUID: nB2mtmDnQTiTvr8DwVVyBA==
X-IronPort-AV: E=McAfee;i="6800,10657,11601"; a="89709859"
X-IronPort-AV: E=Sophos;i="6.19,276,1754982000"; 
   d="scan'208";a="89709859"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2025 04:50:33 -0800
X-CSE-ConnectionGUID: oYiqQey5RfWlxWenBS9wEg==
X-CSE-MsgGUID: VjgDbsSTRo2RvDueQK5X5Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,276,1754982000"; 
   d="scan'208";a="224102482"
Received: from black.igk.intel.com ([10.91.253.5])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2025 04:50:31 -0800
Date: Mon, 3 Nov 2025 13:50:29 +0100
From: Raag Jadav <raag.jadav@intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Greg KH <gregkh@linuxfoundation.org>, kees@kernel.org,
	broonie@kernel.org, arnd@arndb.de, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] mod_devicetable: Bump auxiliary_device_id name size
Message-ID: <aQilFRQYQVy-OEna@black.igk.intel.com>
References: <20251031190234.224813-1-raag.jadav@intel.com>
 <2025110105-upright-dinginess-3b2c@gregkh>
 <aQhk-lQSDhzRmqHu@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aQhk-lQSDhzRmqHu@smile.fi.intel.com>

On Mon, Nov 03, 2025 at 10:16:58AM +0200, Andy Shevchenko wrote:
> On Sat, Nov 01, 2025 at 07:18:22AM +0100, Greg KH wrote:
> > On Sat, Nov 01, 2025 at 12:32:34AM +0530, Raag Jadav wrote:
> > > Since auxiliary device id string is formed using the combination of parent
> > > and child device names, it may require more than 32 bytes if both the names
> > > are long enough. Bump the size to 40 bytes to satisfy such cases.
> > 
> > What in-kernel users need such a larger name?  If we allow larger names,
> > people will try to do crazy things and use memory addresses in them (has
> > happened already...)
> > 
> > > Suggested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > > Signed-off-by: Raag Jadav <raag.jadav@intel.com>
> > > ---
> > > Triggered by [1].
> > > 
> > > [1] https://lore.kernel.org/r/aQSwWLVKH_3TthTW@smile.fi.intel.com
> > 
> > How long would this driver submission's name be?  I couldn't figure it
> > out, and really, any device with a huge name is going to be a pain...
> 
> Right, Raag, please describe a use case.

The driver linked above compiles to intel_ehl_pse_io, so the child will
match against "intel_ehl_pse_io.gpio-elkhartlake" which is 34 bytes
(including termination).

Would that be sufficient or did I miss something?

Raag

