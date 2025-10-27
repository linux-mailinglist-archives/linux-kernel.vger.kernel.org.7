Return-Path: <linux-kernel+bounces-871837-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D6325C0E7E3
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 15:42:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 483C242809A
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 14:33:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAE9D308F27;
	Mon, 27 Oct 2025 14:30:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HNUxjh6l"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 401D61990D9
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 14:30:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761575445; cv=none; b=Agnww/o96Lm/Oh3WzJArMAmsVzri98a7loFZgbTTCyU+xCm/87VnQHV7xchpxqgLlsWmXFaJNuDsooIec4Ot42VyPx5SuntYp5B5N/na1f1UdVHN67WgBGYPfLIuHoUuq18Ob54A1Ijx2+HyLkwmpdOH0BegLH+3SFIAr3dw154=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761575445; c=relaxed/simple;
	bh=VR8KtBaG7IyyfxNYO4i5dAF9bwTcxkF/LmitIazWy0E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HRPf5U7x0HcMD1mVmJVrgSJBm/wDPfZQGOdkU2BY4+fbPACSs4JLVU57SWLKcmpZiQFj77eb1wrHjoOB/ieSSZWSwQrrxh2xi3TR9MU02qpRvgL0vvWTKw4UpSmdZMqGXI2iqEntOlH3ncOrpFRnBatbVSJZL6/B3y9OnNjkxWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HNUxjh6l; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761575443; x=1793111443;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=VR8KtBaG7IyyfxNYO4i5dAF9bwTcxkF/LmitIazWy0E=;
  b=HNUxjh6l75ddBNa+j68QN21EKDQ9PR3Rx8+zZKE4LtvFsWJ6lmXmIMQh
   1VkwgI1r66swLa1tpcYqPgMbJ/OrIzJbm+u1Rjmq8nihMYo3nUatzP7zz
   m9/eeo5HidQmTFl9W6P2E3zvJV1KwrlTIvycAgF2Rw6ioMOL1Y8ZXwGlq
   EnBOIupaQEzEbWnTOCpoFiKLjrZL26iy2uIFL0LMT4dmNl9hOM7M4Chrz
   PB9hDN+MWtjdYy8qq8vaEdeRbjniqJgZbmhFAKlFgkw5EDtS+agIZsJw8
   3LTok7hmrcO7LoY8g+B3wJiDNvBAB6meDj2jKVVVBHNJM/Pe21eURPoRq
   g==;
X-CSE-ConnectionGUID: 2434Yg92SqSMih3Qwg7URg==
X-CSE-MsgGUID: hvG9uq74Tk+F3YrzND69jQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="74329821"
X-IronPort-AV: E=Sophos;i="6.19,259,1754982000"; 
   d="scan'208";a="74329821"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2025 07:30:43 -0700
X-CSE-ConnectionGUID: YcuEGmf5TY6zHORASV2khw==
X-CSE-MsgGUID: 4CVwV2hMT+WxDcaxiHeVWA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,259,1754982000"; 
   d="scan'208";a="185524715"
Received: from egrumbac-mobl6.ger.corp.intel.com (HELO ashevche-desk.local) ([10.245.244.5])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2025 07:30:41 -0700
Received: from andy by ashevche-desk.local with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1vDOF4-000000032JH-3mWA;
	Mon, 27 Oct 2025 16:30:38 +0200
Date: Mon, 27 Oct 2025 16:30:38 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Mark Brown <broonie@kernel.org>
Cc: Christian Eggers <ceggers@arri.de>,
	Javier Carrasco <javier.carrasco.cruz@gmail.com>,
	Krystian Garbaciak <krystian.garbaciak@diasemi.com>,
	linux-kernel@vger.kernel.org
Subject: Re: regmap: Modeling a shared page selection register
Message-ID: <aP-CDpbvgPpP3H8l@smile.fi.intel.com>
References: <2241758.yiUUSuA9gR@n9w6sw14>
 <aP8xPOG68qL2IQ-A@smile.fi.intel.com>
 <7560d98c-84f3-4405-aa1e-0da79eb47866@sirena.org.uk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7560d98c-84f3-4405-aa1e-0da79eb47866@sirena.org.uk>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Oct 27, 2025 at 01:15:36PM +0000, Mark Brown wrote:
> On Mon, Oct 27, 2025 at 10:45:48AM +0200, Andy Shevchenko wrote:
> 
> > Right, the logic behind paging implementation in regmap is a bit tricky
> > (and has some known non-critical bugs, FWIW). There is no documentation
> > and it appears that most of the drivers using it, do it wrongly.
> 
> Which bugs are you referring to here?

For example one I tried to fix that makes the value pf the selector register in
virtual address space not synchronised with the page number.


-- 
With Best Regards,
Andy Shevchenko



