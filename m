Return-Path: <linux-kernel+bounces-885824-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F1E41C33FD2
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 06:27:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DD67318C1DD2
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 05:27:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC03B26562D;
	Wed,  5 Nov 2025 05:27:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ttig9jM+"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69392263C8A;
	Wed,  5 Nov 2025 05:26:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762320421; cv=none; b=YBv4ugUMF6SMgOapMVjY864A+hLtexJjxQg2DRriaWcqqOSFPt24DbIb53QIsfKXY3RYWkpu/Vc1+8qXa6Zp1i/E6uR5Z+AKMmozAejri4kvC8MRvhsF2pDy1HyOyOuu7FWKyMtaUepIp5bEbaUsRxypy7UmhNumKBdMJ1mdX6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762320421; c=relaxed/simple;
	bh=VFDrT7v9nzeQc0ET3dcKyt9fXBWzIXludixrYjczo8Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mrP1549WCU7NbW+hrJg18k8ha0N/0UYDCM6nHIiFpgpOAKd3sveVlGuzE+7r5WrdNh4qQbU2Vei25uVsOVOMaxW4pP2j84c3aRRxlvswOx6zslk6OW0wA+BPvnkC4RD+h6KjRZR9g/W6bNKkDwgbYnrczPT8kDezENvrdKPDXXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ttig9jM+; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762320419; x=1793856419;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=VFDrT7v9nzeQc0ET3dcKyt9fXBWzIXludixrYjczo8Y=;
  b=Ttig9jM+cJOO8NQOhojGb4BSPm/Z5IfWkD/eTvnua7L5PF097SKsOBim
   K68RfKSA58dsMzJmJk8lslopouZrd23w4SOkrXZbB/HG0yQI3rgl1GmnT
   5alrn7M1EU+lPDWs6u42lHvcC0WAarp3+5PuRvFU6Medq8k8xxaTSrvHe
   L5SobP2jdcD49gjGcdCk5MhlDhITgc+0MSu8BhCKQR1zNFy7UZEuUjr45
   cKeI3irofZGTObkFL22d7Upw/HxWahhl5B23QS76uQrF+GjZE6+JMS5zD
   fSV0GKVkTqT8hU7l8ovMouCjyP18odAu39JfuP2Q1kf5OhwBUZ38H7P/I
   w==;
X-CSE-ConnectionGUID: WzTRIPbnRDyQ82Kb4M3REw==
X-CSE-MsgGUID: m6+BZhjcR4aJz9NSI5ZmaQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11603"; a="64525532"
X-IronPort-AV: E=Sophos;i="6.19,281,1754982000"; 
   d="scan'208";a="64525532"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2025 21:26:40 -0800
X-CSE-ConnectionGUID: OXlpr7hMSQOGDq2+tKgeiw==
X-CSE-MsgGUID: /Dik2WviQ4q6fl6ZlucOYw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,281,1754982000"; 
   d="scan'208";a="187656381"
Received: from ldmartin-desk2.corp.intel.com (HELO ashevche-desk.local) ([10.124.221.135])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2025 21:26:38 -0800
Received: from andy by ashevche-desk.local with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1vGW2T-00000005g1S-2rVY;
	Wed, 05 Nov 2025 07:26:33 +0200
Date: Wed, 5 Nov 2025 07:26:32 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: kernel test robot <lkp@intel.com>, Randy Dunlap <rdunlap@infradead.org>
Cc: Jonathan Corbet <corbet@lwn.net>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	oe-kbuild-all@lists.linux.dev, linux-media@vger.kernel.org
Subject: Re: [PATCH v1 1/1] kernel-doc: Issue warnings that were silently
 discarded
Message-ID: <aQrgCBm1QQxIJZyK@smile.fi.intel.com>
References: <20251104215502.1049817-1-andriy.shevchenko@linux.intel.com>
 <202511050720.nJ9ccENC-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202511050720.nJ9ccENC-lkp@intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Nov 05, 2025 at 07:14:57AM +0800, kernel test robot wrote:
> Hi Andy,
> 
> kernel test robot noticed the following build warnings:

Right, the change restores the check, so these should be fixed separately.

-- 
With Best Regards,
Andy Shevchenko



