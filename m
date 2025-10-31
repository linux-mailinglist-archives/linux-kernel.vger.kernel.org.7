Return-Path: <linux-kernel+bounces-880200-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id D4C40C25192
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 13:52:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 47AE54F59D1
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 12:50:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C473A1F872D;
	Fri, 31 Oct 2025 12:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="D19vYi3x"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84B2B1CAA92
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 12:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761914998; cv=none; b=q4GMs42n6fnBa/TFDlrx/PGwVUDDUJTeRD9v2o2eNoCPfvhLeQh5b+0FTknD5EVg7HrvZ6o5CUiaFaqyopNdL7uc6cdh2v6dJzqRYO6hrLW7PTHpVBnrD6GXKzSAL74REIciXCxgTS3F/HHTt9QM83o3vd6HeXGV2hBCcor0SxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761914998; c=relaxed/simple;
	bh=iyfki0XMqj6hV7s7LkMG8FKV1Q88PTVmM/XWUcQ59VQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cVRVn2gNRZZ3w0ji76SJ7HN3G7rcRE0MvMQ2LPTEL+YQmTcwnineLw3CGMhujPsu11+4tpxjLqmeJUP42lxGBdOG4+oEfSfAnyqasJKj/1/g/H09DCyD+2yw9OnTwaqNZAW4hiV+WPQpCvTYwpdn1ES/Wwx1FHkD1z94UrBcb+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=D19vYi3x; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761914997; x=1793450997;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=iyfki0XMqj6hV7s7LkMG8FKV1Q88PTVmM/XWUcQ59VQ=;
  b=D19vYi3x1ClzJdBjq0jQgQKjyrNabAJPczuzfPtEA9wY/FxjAF2TprGy
   97FvyU/swwLHuAnVCmB09yloHAMfkKeewD5krd+jT7i/Tn0J3ShXHMK6x
   2qdjK3ODU2yDUfMitiVSSwq2XW/7F+OYTNB14y4Jz44mfl2hnPkh5Eo/m
   rbpnO5YsjkO7Sd81QFsuIPrYgIxYOdGAtg26ipnn0egXASJGw9t/owgnX
   06BkvERLNSMLnVXpULu/2YnCf+50XDE21vOxCPZLMNospSRitVP/VGXea
   z6QQMfKqIDM5e86s7DOuySl6z5rauTwqJeG+hMhPBV46MOwTR3mZLfcA6
   A==;
X-CSE-ConnectionGUID: o4VJZSc1QRKtOqhPzDKjmQ==
X-CSE-MsgGUID: Y2xyLUqVThiPhroA2vGauQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11598"; a="74752097"
X-IronPort-AV: E=Sophos;i="6.19,269,1754982000"; 
   d="scan'208";a="74752097"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Oct 2025 05:49:56 -0700
X-CSE-ConnectionGUID: V6dekupzQtOeZ8RTEWA6wQ==
X-CSE-MsgGUID: AfVcmcwpRzq+/FBvcjCiNQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,269,1754982000"; 
   d="scan'208";a="185890051"
Received: from mgoodin-mobl3.amr.corp.intel.com (HELO ashevche-desk.local) ([10.124.220.66])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Oct 2025 05:49:54 -0700
Received: from andy by ashevche-desk.local with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1vEoZh-00000004GSO-0MJc;
	Fri, 31 Oct 2025 14:49:49 +0200
Date: Fri, 31 Oct 2025 14:49:48 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Charles Keepax <ckeepax@opensource.cirrus.com>
Cc: Mark Brown <broonie@kernel.org>,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	Sander Vanheule <sander@svanheule.net>,
	linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>
Subject: Re: [PATCH v3 1/5] regcache: Add ->populate() callback to separate
 from ->init()
Message-ID: <aQSwbNeCV51qUNWr@smile.fi.intel.com>
References: <20251031080540.3970776-1-andriy.shevchenko@linux.intel.com>
 <20251031080540.3970776-2-andriy.shevchenko@linux.intel.com>
 <aQSUBdjGIV8h1fJH@opensource.cirrus.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aQSUBdjGIV8h1fJH@opensource.cirrus.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Oct 31, 2025 at 10:48:37AM +0000, Charles Keepax wrote:
> On Fri, Oct 31, 2025 at 09:03:16AM +0100, Andy Shevchenko wrote:
> > In the future changes we would like to change the flow of the cache handling.
> > Add ->populate() callback in order to prepare for that.
> 
> Reviewed-by: Charles Keepax <ckeepax@opensource.cirrus.com>

Thank you!

-- 
With Best Regards,
Andy Shevchenko



