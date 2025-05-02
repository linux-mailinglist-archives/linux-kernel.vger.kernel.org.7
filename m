Return-Path: <linux-kernel+bounces-629477-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AACCAA6D26
	for <lists+linux-kernel@lfdr.de>; Fri,  2 May 2025 10:56:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 128B44C066E
	for <lists+linux-kernel@lfdr.de>; Fri,  2 May 2025 08:56:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DF5622FACA;
	Fri,  2 May 2025 08:56:20 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12FEE22E40F;
	Fri,  2 May 2025 08:56:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746176180; cv=none; b=C1Kx6s35iya47djwRQjqTjLq5g4Dn2uQegyDnSTYH4b7ic2yjmnVpRDHK85sAn+eSqZJuzv/hHN5Ii9pEVmlF7cOjVmWYOSoANIFXU3plr8bAFwLZQQauh1W4VoLsvAQws7aySE8gq85Lb1ut2uKsN7MX3yT0luaob6DdRoikXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746176180; c=relaxed/simple;
	bh=ae3+Hz4hJ9ALh71sYiq5n/XhT19iK2yY+HMBltQrsOM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VyKQJ8HNAzApTiZTiVa8ZnepapElHZNp/qGrQjegctprSgp8N9+AL1dd65XI/zSKb9w9G+cMjRXc507a5VQPCEe1DNCvWOomC516j6mDbsIOkqbnXEOc+O6rZytk59O9KXZTtsqdoHAqvYVT81fQEawN40NZFEbCf0RI0U9m4eE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=fail smtp.mailfrom=gmail.com; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=gmail.com
X-CSE-ConnectionGUID: yyHLbRtjRxai6J3g0xzuLQ==
X-CSE-MsgGUID: faYczQxCSn+NUdGSdyMwYQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11420"; a="58065594"
X-IronPort-AV: E=Sophos;i="6.15,256,1739865600"; 
   d="scan'208";a="58065594"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 May 2025 01:56:16 -0700
X-CSE-ConnectionGUID: j/fiYNFrTiqCMmp0HTkabA==
X-CSE-MsgGUID: zMXaPiiHRNaG0zyxgMwnTg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,256,1739865600"; 
   d="scan'208";a="139737854"
Received: from smile.fi.intel.com ([10.237.72.55])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 May 2025 01:56:14 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andy.shevchenko@gmail.com>)
	id 1uAmBm-000000028HY-2ifl;
	Fri, 02 May 2025 11:56:10 +0300
Date: Fri, 2 May 2025 11:56:10 +0300
From: Andy Shevchenko <andy.shevchenko@gmail.com>
To: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
Cc: Marcelo Schmitt <marcelo.schmitt@analog.com>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	jic23@kernel.org, lars@metafoo.de, Michael.Hennerich@analog.com,
	dlechner@baylibre.com, nuno.sa@analog.com, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org
Subject: Re: [PATCH v2 3/7] iio: adc: ad4170: Add support for buffered data
 capture
Message-ID: <aBSIqmMIuaHQmlV-@smile.fi.intel.com>
References: <cover.1745841276.git.marcelo.schmitt@analog.com>
 <db98c6cc188b501d914293268b67b0bdf26a4a46.1745841276.git.marcelo.schmitt@analog.com>
 <CAHp75Vc9CMqkkrEjgGEYPnmkb1R=u+RUvD3FAZ+7bFqi5aDzdw@mail.gmail.com>
 <aBIoRc-gpBswohe-@debian-BULLSEYE-live-builder-AMD64>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aBIoRc-gpBswohe-@debian-BULLSEYE-live-builder-AMD64>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Wed, Apr 30, 2025 at 10:40:21AM -0300, Marcelo Schmitt wrote:

...

> > > +               return dev_err_probe(&st->spi->dev, ret,
> > > +                                    "Failed to register trigger\n");
> > 
> > One line?
> 
> It goes up to 89 columns if make in one line. I know there are other places in
> this driver where 80 columns are exceeded, but in this case it's easier to
> avoid going beyond 80 columns without drying up the error message.
> Anyway, I'll make it one line if it's confirmed to be the preferable way to have
> it.

The string literal endings are relaxed in the line limit for 10+ years...

-- 
With Best Regards,
Andy Shevchenko



