Return-Path: <linux-kernel+bounces-757009-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D8F51B1BC38
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 23:59:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 82D8D3B88CB
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 21:59:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 400A124DFF4;
	Tue,  5 Aug 2025 21:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Oq0M75F3"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A24B3594C
	for <linux-kernel@vger.kernel.org>; Tue,  5 Aug 2025 21:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754431149; cv=none; b=c9hnnVOw2leIlsTpKG8mSZP1LdMoGPHb1X1B/P81ywnUTTuImapHhTcsVCGfGM6gQILH1yFRS7/amqUW2NM6bUywdTAm9QiXro51TOOmKw2RZsx7ns5+so+oUPh1+pi8PxhEz3eAyCwcyJ7eJOBB6I6Hbp50xfh/2p7I/2XYkIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754431149; c=relaxed/simple;
	bh=EaMvOaRV5chlfG7PUma2cPCP9U04BplrQiABKl+h3HY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L6P8gQXrtjAtDWGETJ+AvJVu7dsHw8J8vl91GvqKwP9aIzXL3/I7TtURCr3HLTeDRCRjIi2FD891xXk7zIO4y/Pey/cZ1QElvxAYPtmfIGqgzrMxtX9DQ+Vcyxx2Uw2AQiFrYP9FNqm2Hgz5H5d3CNLvBsOy2yvWN33N3s7VCqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Oq0M75F3; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1754431148; x=1785967148;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=EaMvOaRV5chlfG7PUma2cPCP9U04BplrQiABKl+h3HY=;
  b=Oq0M75F3pU02ulEMGA9XqpwPFvfK+qZsSGS2+pXdtCM44P064weaJ6SD
   6AlcC9ZzwC/z3O9V2PbKOv93q7/xoToRvBfvjiUBEnd1LbHVJ2V0fBunW
   M/Zf/yRD494YFBsacTjq9duHqLcu1fmKnA83ieRtaoa7NjBTSmQdAqGEE
   VXwd/tHocKSN+Ag/RJ3R8vl49Ju/mLIsKaIuWTS/q9Eu3CWngA0ydqlPU
   eJzkaOiJehWxTm0Fi0w8eIzJEFszqosRaTU1MBRhMJQEyXV/1kHa5QVVq
   dUbTLew34VLcvoypZkpZGwS1qeR8emeFIZMM2fLNTmvmb42NxX7FaK2XL
   Q==;
X-CSE-ConnectionGUID: epUVdxl9R7ai8TvJw3c0Lg==
X-CSE-MsgGUID: 6oR2DEWTRhOfVM3YaQ6oNA==
X-IronPort-AV: E=McAfee;i="6800,10657,11513"; a="74318919"
X-IronPort-AV: E=Sophos;i="6.17,268,1747724400"; 
   d="scan'208";a="74318919"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2025 14:59:07 -0700
X-CSE-ConnectionGUID: Ejd+COAuTdmDl7wfpaD/yg==
X-CSE-MsgGUID: 29bNG84tQTeFOGQQRD41fQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,268,1747724400"; 
   d="scan'208";a="169980994"
Received: from smile.fi.intel.com ([10.237.72.52])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2025 14:59:06 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1ujPgU-00000003rZ9-28WP;
	Wed, 06 Aug 2025 00:59:02 +0300
Date: Wed, 6 Aug 2025 00:59:02 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Arnd Bergmann <arnd@kernel.org>
Cc: Miquel Raynal <miquel.raynal@bootlin.com>,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Arnd Bergmann <arnd@arndb.de>, linux-mtd@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mtd: map: add back asm/barrier.h inclusion
Message-ID: <aJJ-pqFvHy2hCgop@smile.fi.intel.com>
References: <20250730135934.1712198-1-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250730135934.1712198-1-arnd@kernel.org>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Jul 30, 2025 at 03:59:24PM +0200, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> The mb() macro is used in this header:
> 
> In file included from include/linux/mtd/qinfo.h:5,
>                  from include/linux/mtd/pfow.h:8,
>                  from drivers/mtd/lpddr/lpddr_cmds.c:14:
> include/linux/mtd/map.h: In function 'inline_map_write':
> include/linux/mtd/map.h:428:9: error: implicit declaration of function 'mb' [-Wimplicit-function-declaration]

Oops, thanks!
Acked-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>


-- 
With Best Regards,
Andy Shevchenko



