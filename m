Return-Path: <linux-kernel+bounces-878956-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 36006C21D9D
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 20:06:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BDA973B93FB
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 19:06:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F27330C606;
	Thu, 30 Oct 2025 19:06:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VdKJ/sFa"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5A06212559
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 19:06:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761851170; cv=none; b=ht2iSenlkqxtucsgVEWRXNE51IOaMg1mInf8Kfxwd6GLn5BoPSl5O3QgLmyZMPJQfjcdEWU84VpOounnUro6agH7XjpHzj3mQjL42b5dhrNIgT2glLNHpuA2ej+OyQHF+kbQHDvmh9Ks2ciRgxHq3LcDoApL5jkIyPexK8mjgR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761851170; c=relaxed/simple;
	bh=qeGWMrt89Hq4S5etIRDf0qqimgIpX3SIFm7Bwg1OHG0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YYMaenS1mYGVJuzntxfAheUuOV9OQG+CEG5qDYz8oFq+HSKzoBpCS4VWW4BmMgcDOBPL91lxLrYRtbh5GJ1ZSDH1HUOVAmMUSzOIEHzZQqfsT67Bd7xfAfmTHMgGp/PeinEGe3UlJBpOwrcGrROcV25yfwflUXnXWTx3rOmYwwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VdKJ/sFa; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761851168; x=1793387168;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=qeGWMrt89Hq4S5etIRDf0qqimgIpX3SIFm7Bwg1OHG0=;
  b=VdKJ/sFaOVMlaMFpcZd3thLFwQEqlLq6xJa2QZY4LcMUFTbKa4j/DJrX
   WnIugfdm1o2fD2xpq8WufRIs4lFhhY0xSQIJB9/JbI4c39S5v7HuY15G4
   AOQjg41gPZKKSfjTT/kotBvwCph6dgKTObPjsv1/gnzXLr8MyGu3vc4u2
   FzNjVLYtupk01w307V784lJ133DM+U+b4nX5bHBiRDhagrmkPPSP/ZsNa
   EdhWucpKVOpMA/5CWBWHx48zIJCiAvOW70QCjlUCGJcODB801RZNQewo0
   9un3Rbi57cbnJ3yK7m6b6R6oMstwOIcB9auvqmET23B/eUEiE5DH9fk/F
   g==;
X-CSE-ConnectionGUID: H/7IoLeISy2evsI1fyqmGQ==
X-CSE-MsgGUID: uKl8kjOeTeuv8DdSx6TM2Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11598"; a="75353853"
X-IronPort-AV: E=Sophos;i="6.19,267,1754982000"; 
   d="scan'208";a="75353853"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2025 12:06:02 -0700
X-CSE-ConnectionGUID: +usGFGO7SamoM3extqpkpQ==
X-CSE-MsgGUID: vI2Gvt7uR0WBV8+grWK+cg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,267,1754982000"; 
   d="scan'208";a="191174865"
Received: from fpallare-mobl4.ger.corp.intel.com (HELO ashevche-desk.local) ([10.245.245.174])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2025 12:06:01 -0700
Received: from andy by ashevche-desk.local with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1vEXyA-000000040Fz-1iIM;
	Thu, 30 Oct 2025 21:05:58 +0200
Date: Thu, 30 Oct 2025 21:05:58 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Mark Brown <broonie@kernel.org>
Cc: Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	Sander Vanheule <sander@svanheule.net>,
	linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>
Subject: Re: [PATCH v2 2/5] regcache: rbtree: Split ->populate() from ->init()
Message-ID: <aQO3FkXWKQ_p9vjg@smile.fi.intel.com>
References: <20251030173915.3886882-1-andriy.shevchenko@linux.intel.com>
 <20251030173915.3886882-3-andriy.shevchenko@linux.intel.com>
 <16d462b1-3ea5-40a3-99a9-ef3c2f5015cb@sirena.org.uk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16d462b1-3ea5-40a3-99a9-ef3c2f5015cb@sirena.org.uk>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Oct 30, 2025 at 06:05:39PM +0000, Mark Brown wrote:
> On Thu, Oct 30, 2025 at 06:37:02PM +0100, Andy Shevchenko wrote:
> 
> > +	.populate= regcache_rbtree_populate,
> 
> Missing space.

Do I need to send a new version for this? If so, I would wait a bit to see that
0day is happy about the series (again) and send a new version.


Thank you for the review!


-- 
With Best Regards,
Andy Shevchenko



