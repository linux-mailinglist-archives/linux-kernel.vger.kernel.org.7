Return-Path: <linux-kernel+bounces-796897-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F1B3B408F8
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 17:32:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 692A51B6015F
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 15:32:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52F682D6E57;
	Tue,  2 Sep 2025 15:31:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aw9jMbfM"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66F781B21BF;
	Tue,  2 Sep 2025 15:31:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756827112; cv=none; b=jWyfqNwaqwqNrc74+x5pqbNib2a0B5IODUMUozs8EzHDCk0RgqH/Jxca9NF4IqeqHYszcP5WxInHM297Q2knGzut+ynhLVIQUgs0cTYXIMvrHHqeXXyIRJe36teGec3XUi73pdzbmWlPcgpmYrJ2tAuEBJ/HyNgBFMTicgBj5ho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756827112; c=relaxed/simple;
	bh=8NZMZNjbtp245s6IL9uaQhkZ2sXfxrtlX8J5YKgAfj4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TH1rB1LqnAesuub1WRX3tKLewUep3iy4J/36micwcqmNMJAWoh8fK4/2YdMMAMig9km92JvRJ2izW4PZE4dqcj5A0TVbo/qtObnOaDVgWNTV+CMgbZFl7Sp0Wcf3oAb8QYX1Txs9PufQcwK5gcXTK29FyAnfbkfQHv8k0CX6o88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aw9jMbfM; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756827112; x=1788363112;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=8NZMZNjbtp245s6IL9uaQhkZ2sXfxrtlX8J5YKgAfj4=;
  b=aw9jMbfMhCgVuCvrjKlaGRjqGtDzEJs9v7viDJ8gL0mdgUescS+v46Mv
   ga1ZkJ6YCKm70O/tcR8ByLel9/rXQ37oUyxybX7kNOwzP6wruUbbzsqxf
   +nOEhXU/sRrfhmaebohlQTebwOAkopf1mXU3aMV6HR7PCTjKqg2rEMfFx
   ew6O6nmJWj67FDqEwHDxJ1VFPVz3HofbjOHI6Ol+FJCviXH+EG8Y8K1X0
   dKWn2hk3vXVfUEB/ejVQRTALqobCSddpPKI0UYpzGkjKy+kKB+ZpJVO8B
   gUFLOKcVRrtoN2FFgLKTBEyS1V+5n6gElUT7jRUOr2GRl0PrADdkuPaIb
   A==;
X-CSE-ConnectionGUID: eDsgh4ktTW29M7DZZ1bKlQ==
X-CSE-MsgGUID: Gou2ymoOTeWQwhy5d4c+JQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11541"; a="58806210"
X-IronPort-AV: E=Sophos;i="6.18,230,1751266800"; 
   d="scan'208";a="58806210"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2025 08:31:51 -0700
X-CSE-ConnectionGUID: x3UzqLZLRTWYlXAH3ggxIA==
X-CSE-MsgGUID: azBEhj9BQ8iE8iD7rTEZhw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,230,1751266800"; 
   d="scan'208";a="170865090"
Received: from smile.fi.intel.com ([10.237.72.52])
  by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2025 08:31:48 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1utSz3-0000000AjQp-3NKC;
	Tue, 02 Sep 2025 18:31:45 +0300
Date: Tue, 2 Sep 2025 18:31:45 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Adrian =?utf-8?Q?Barna=C5=9B?= <abarnas@google.com>
Cc: Hans de Goede <hansg@kernel.org>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Andy Shevchenko <andy@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-staging@lists.linux.dev
Subject: Re: [PATCH v2 3/3] staging: media: atomisp: Remove trailing comments
Message-ID: <aLcN4c-tj5uPIaze@smile.fi.intel.com>
References: <20250902071847.2330409-1-abarnas@google.com>
 <20250902071847.2330409-4-abarnas@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250902071847.2330409-4-abarnas@google.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Sep 02, 2025 at 07:18:47AM +0000, Adrian Barnaś wrote:
> Remove trailing comments in pci/hive_isp_css_common/host/vmem.c.

To avoid churn this should be patch 2 in a new series before current patch 2.

Otherwise the entire series LGTM.

-- 
With Best Regards,
Andy Shevchenko



