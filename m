Return-Path: <linux-kernel+bounces-817234-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6192FB57FA9
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 16:56:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5FC52188A9C7
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 14:54:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC15C3376BC;
	Mon, 15 Sep 2025 14:51:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="F6qrvgO8"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C363D303C85
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 14:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757947893; cv=none; b=ftTj0u6OPGqUB41mqxQnphqM22UjPLqPMBe20Do9NJHQn9IbreT/qJD29hESltFwqnFa85jp8Ko37YvhzWK4k/r+y4qkP2KLLcM4BeONCIyOAE0O8MTUCQW3DGdL1wMtfx+U4jg6ORwo/ZOSSPQQdpbDP6vfFmDjUreATtZmSUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757947893; c=relaxed/simple;
	bh=ILSmyGjjjPTW+WRuEVQr2WchD7jAPn598TgvovC8S38=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oq8eiebWCL3/MVAqQNMjLloocK0PwCSamt1WjTukTU7KcFH+p3DWsVlb0DuXnQYwayrlRPyP1aMZVJqFhI61JVj/b5W8bN6DRhM8FEH8/cEg68e26t8KexLzdUZ5X0+O57o4oFSTjnaaaAtr0IWChCzpSTRnmjtS3Ztz/v3vORQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=F6qrvgO8; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757947892; x=1789483892;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=ILSmyGjjjPTW+WRuEVQr2WchD7jAPn598TgvovC8S38=;
  b=F6qrvgO83GMhz9FmxvWS4eeLx/14tk8iMcjJ2Hql4zijVOLcvkO47Xpk
   7VCH25rhzbTFAWJtkN5bsgCdxvDE2kiYiM343N7WfADyx6hqeTBjP6vvC
   toR77qtThY1YqR5bwQAN0yvhoC5FOK9lMD2k2+BIekJqk7KSxhcVZ4gcN
   ftNMnBtVBkYMI1O+xmk1sa6ZX7BKr6qQAxypMAXFEDhMXqTsqYJD+B127
   Wh+2De6krtolTsq1z6DTkhQxJlGzu8I1s7o37MHajnbnraNjbHdI0/XUs
   zEbRnhg+u7rlraYrVURDEBgo09FuitDr6s8dyCCC9q1ZoMQmYn4Rzjijs
   w==;
X-CSE-ConnectionGUID: Mq+IhUN4QmGiTiDAHu4hgQ==
X-CSE-MsgGUID: yHSuCtjRSWW+VbMlJ+Y5Jg==
X-IronPort-AV: E=McAfee;i="6800,10657,11554"; a="60277771"
X-IronPort-AV: E=Sophos;i="6.18,266,1751266800"; 
   d="scan'208";a="60277771"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2025 07:49:27 -0700
X-CSE-ConnectionGUID: M/Dv7FwLSbCvArd+GAedCw==
X-CSE-MsgGUID: wq03szasQkaogxWceGHEIA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,266,1751266800"; 
   d="scan'208";a="179900261"
Received: from smile.fi.intel.com ([10.237.72.51])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2025 07:49:27 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1uyAWC-00000003H7k-2Mal;
	Mon, 15 Sep 2025 17:49:24 +0300
Date: Mon, 15 Sep 2025 17:49:24 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: Lee Jones <lee@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] mfd: intel-lpss: Add Intel Wildcat Lake LPSS PCI IDs
Message-ID: <aMgndOuIP01o8ti0@smile.fi.intel.com>
References: <20250915112936.10696-1-ilpo.jarvinen@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250915112936.10696-1-ilpo.jarvinen@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Sep 15, 2025 at 02:29:36PM +0300, Ilpo Järvinen wrote:
> Add Intel Wildcat Lake PCI IDs.

Acked-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

-- 
With Best Regards,
Andy Shevchenko



