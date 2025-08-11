Return-Path: <linux-kernel+bounces-763146-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FFDAB2114B
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 18:14:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BEC3F3E7824
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 16:00:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC1C62E610E;
	Mon, 11 Aug 2025 15:45:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jZdJ1Dvr"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BBC52DEA8C;
	Mon, 11 Aug 2025 15:45:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754927141; cv=none; b=V1oiznyRuPGXKyPcQVW3aK0VNdLBAABCOcCTKCjp6hoG4pZpGQZdZx8R1HL8UpXqttr5Bb04vg9Fp95yhFOfySvf/Pdz0eEWmsFpN/5I1/ZnMxCEISzgJuFt2nvmgW0jIJldMnXhJ62ELi+WMrQNrsc6snJW8Lir+FD+ZXGQIB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754927141; c=relaxed/simple;
	bh=ze7iO4CCo+BsXp6xKvvrHdv60Ak7GG+2erHtdx10wo4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ww8OpOSFytT8AJ7yGcRgjn+1cFdW97xT3hXrgAEY7nZgAvUHDBBi/PrkuNszFbulsQS6a3Ve4xJQOhHcTuACBzwG+UC27Np6h44wZF9W2uR+qxbeJoaWitVDgZGS3cg4d4HiTZCUKqLGix7J3elzs5m5KY8X1HxvzSJXML+FjE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jZdJ1Dvr; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1754927130; x=1786463130;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ze7iO4CCo+BsXp6xKvvrHdv60Ak7GG+2erHtdx10wo4=;
  b=jZdJ1DvreLLeoZZKWuLbb4zKTeLkbjgLD7ciwPJuK+2tbP1HMbPFOdak
   cbvMlaYjYtO+ZM2Mq05hDNvdEBB4sQfnVo92SnqkzDfMxyuzaHctcASPE
   l8nRmhRfnSsBdd12DvgqdVN0I2E2nYAHA6ed4Q3Xki5Ng1yZN+Ik2TDED
   UlO0mjfYCOiHtLSOYxvVC3s/Y/87tnAo2KED73sEFpQSJp4JtkaDE33UT
   ynwsKnX621b7hlS8Pka1eNawDmu0cycQhHbNoe+zU7YH8bSRJvWSrEAf3
   3EdzfWe5BIz9+zb3MCoaD/UpVdtN7Q3mCws/im3U6P+meJfavfl78i4pO
   Q==;
X-CSE-ConnectionGUID: u+FdEoNKQGewbGzBU6SHvg==
X-CSE-MsgGUID: fcFvA0teR/C08ursTkPP8Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11518"; a="56896032"
X-IronPort-AV: E=Sophos;i="6.17,278,1747724400"; 
   d="scan'208";a="56896032"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2025 08:45:29 -0700
X-CSE-ConnectionGUID: Ze1Kv4D0SrKJcmvFw3LIEA==
X-CSE-MsgGUID: 8qCxYcdRSWKPMYdF/zyGaQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,278,1747724400"; 
   d="scan'208";a="166345247"
Received: from smile.fi.intel.com ([10.237.72.52])
  by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2025 08:45:26 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1ulUiB-000000054CZ-2wR5;
	Mon, 11 Aug 2025 18:45:23 +0300
Date: Mon, 11 Aug 2025 18:45:23 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Hans de Goede <hansg@kernel.org>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Santosh Kumar Yadav <santoshkumar.yadav@barco.com>,
	Peter Korsgaard <peter.korsgaard@barco.com>,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Arnd Bergmann <arnd@arndb.de>, platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] platform/x86: barco-p50-gpio: use software nodes for
 gpio-leds/keys
Message-ID: <aJoQE2CQv3nzaSqc@smile.fi.intel.com>
References: <2meuzip4qnxvle4bwk4hbow4j34ii3cwb46xd5inq5btif5mjg@iiygy6ir7vtr>
 <aJnlnx2qF6P61jJN@smile.fi.intel.com>
 <7c2d08e3-d1e2-433e-b726-307246ab17e9@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7c2d08e3-d1e2-433e-b726-307246ab17e9@kernel.org>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Aug 11, 2025 at 04:20:33PM +0200, Hans de Goede wrote:
> On 11-Aug-25 2:44 PM, Andy Shevchenko wrote:
> > On Sun, Aug 10, 2025 at 09:31:37PM -0700, Dmitry Torokhov wrote:

...

> > Otherwise LGTM as here it looks like we establish platform device ourselves and
> > hence no need some additional magic Hans mentioned in the other series.
> 
> Not entirely like with the x86-android-tablets patches this
> declares a software-node for the gpiochip:
> 
> static const struct software_node gpiochip_node = {
> 	.name = DRIVER_NAME,
> };
> 
> and registers that node, but nowhere does it actually
> get assigned to the gpiochip.
> 
> This is going to need a line like this added to probe():
> 
> 	p50->gc.fwnode = software_node_fwnode(&gpiochip_node);
> 
> note the software_node_fwnode() call MUST be made after
> registering the software-nodes (group).
> 
> Other then needing this single line things are indeed
> much easier when the code containing the software
> properties / nodes is the same code as which is
> registering the gpiochip.

Ah, good point!

-- 
With Best Regards,
Andy Shevchenko



