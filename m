Return-Path: <linux-kernel+bounces-885823-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 39EC7C33FC9
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 06:25:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BA33F18C1860
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 05:25:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94401260583;
	Wed,  5 Nov 2025 05:24:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ATHlrEdA"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 096B2208AD
	for <linux-kernel@vger.kernel.org>; Wed,  5 Nov 2025 05:24:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762320298; cv=none; b=gDyRmxVGdOeDsSVNqd7Bdf+vviTAYsQ9Q0nP8vOZ3kXDz/JAVv/6cuOUbP3b8SqFwNM0KUjwEXOCY6iaej68EUOe8OHHD0LfoSYaAkIec3tvtuhH+TVM7T6dyarDq8xUhyoYqC6RclbCVx+BJD9H4iPNSBE+PTa+91yw4Udy/Jg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762320298; c=relaxed/simple;
	bh=zTTLehS2Czjct0P8KDPBwMTLTK4Jd4p/w9OtxORDz14=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=By1icViGRDruDuDyMyMK7SCiD+IEwct2Qr6VAOi+cwubaOhMMsCz/eL/0tO+i4xEW6Osy5WtvJ/ixxpoL0CSf4Dfas8G36iaV+3kG7FGLzomefrZGaGvQkfFovQKvHaUXf7UTXI7TBd3iUkpAOnKHEH77ChVH2496lI5mLvsHLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ATHlrEdA; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762320298; x=1793856298;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=zTTLehS2Czjct0P8KDPBwMTLTK4Jd4p/w9OtxORDz14=;
  b=ATHlrEdAFhxJw3njAY37oAILlL/GTtm0JgIezkOtjBy//AjdsscE/odK
   06zKkMxBBSxkB3Oe/kuUCIjrVXDSrXlf5Pbf+euj+V2R0K7q1+YYPpmXT
   ALz97m6kj+dJr4MIVHf78JvlJmLFVcAX0puHrKqNYtMFzeG4BNDZd0iVC
   n05PawAD+qx+w29MTBxudbRTSWXYr5M8HIvr+wWeORPHmDWkOXofCxpjg
   eIDpiBOzGnQQwGhU8P7KPqtyB9ZA0/mg2TMyR0Qd5W6hCYLTi9knI21PK
   9N0CS6X4IP84DWJ6JwAxiowYMps03ZsOmO/4dkfKb+4XQQHritDQmjQPL
   A==;
X-CSE-ConnectionGUID: xbquydb/SjOqfAuV3Oe+Hg==
X-CSE-MsgGUID: nVbIoBOMS/2CNCfNOyRncA==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="68264175"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="68264175"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2025 21:24:57 -0800
X-CSE-ConnectionGUID: qjbMNB0bRcWADJ0Fc20qyQ==
X-CSE-MsgGUID: Lu1Y0AtwTzKzzTeabPpHrw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,281,1754982000"; 
   d="scan'208";a="187203493"
Received: from ldmartin-desk2.corp.intel.com (HELO ashevche-desk.local) ([10.124.221.135])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2025 21:24:55 -0800
Received: from andy by ashevche-desk.local with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1vGW0p-00000005g0E-1nc9;
	Wed, 05 Nov 2025 07:24:51 +0200
Date: Wed, 5 Nov 2025 07:24:50 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Theodore Ts'o <tytso@mit.edu>
Cc: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
	linux-kernel@vger.kernel.org
Subject: Re: regulator branch mess
Message-ID: <aQrfolXgeWs8A_gK@smile.fi.intel.com>
References: <aQoZ22aT27wHBpbI@smile.fi.intel.com>
 <aQocq1eRjOOjiRdY@finisterre.sirena.org.uk>
 <aQogTFANK1fMtloW@smile.fi.intel.com>
 <aQojdTvP94aYVW4l@finisterre.sirena.org.uk>
 <aQolne8AKHXdJw0-@smile.fi.intel.com>
 <aQonVNgqJI56nspA@smile.fi.intel.com>
 <aQoqPqVeQiHJ2tiF@finisterre.sirena.org.uk>
 <20251104221551.GA2968640@mit.edu>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251104221551.GA2968640@mit.edu>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Nov 04, 2025 at 05:15:51PM -0500, Theodore Ts'o wrote:
> Andy, I don't know what github is doing to confuse you, but my

I haven't told anything about Git Hub, I talked about web representation on
kernel.org.

> preferred way of understanding what is in a merge commit is to use the
> command line tools, which are less likely to lie (or at least, to be
> confusing):

Yep, less confusing. The problem of the confusion here is the merge commit
text, that only describes the merge of the small series but also implies bump
from v6.18-rc3 to v6.18-rc4. Other subsystems I follow usually do an explicit
back-merges to the rcX whenever is needed. But as I told Mark, I'm fine if
that was a deliberate (known) move. Now it's all clear.

Thanks for helping me to understand this!

> % git log --pretty=oneline regulator/for-next ^base/master
> 9de2057bbdfb58f4d9bb1476135317cd3fe6aa52 (regulator/for-next, regulator/for-6.19, regulator/HEAD) regulator: pf9453: optimize PMIC PF9453 driver
> 2ecc8c089802e033d2e5204d21a9f467e2517df9 regulator: pf9453: remove unused I2C_LT register
> 0144a2b29d95af8523c308116de65d398d6e935b regulator: pf9453: remove low power mode
> a2d4691b3fec6a2360e4ec953d06819ea055c3e7 regulator: pf9453: change the device ID register address
> 252abf2d07d33b1c70a59ba1c9395ba42bbd793e regulator: Small cleanup in of_get_regulation_constraints()
> 28039efa4d8e8bbf98b066133a906bd4e307d496 MAINTAINERS: remove obsolete file entry in DIALOG SEMICONDUCTOR DRIVERS
> dc74a00c7661a14a672ea7660caca5c4aa661a79 regulator: pca9450: add input supply links
> 4c33cef58965eb655a0ac8e243aa323581ec025f regulator: pca9450: link regulator inputs to supply groups
> 86df0030b71d7172317d957df17524a7fd6232d4 regulator: dt-bindings: nxp,pca9450: document input supplies
> 01313661b248c5ba586acae09bff57077dbec0a5 regulator: Let raspberrypi drivers depend on ARM
> d054cc3a2ccfb19484f3b54d69b6e416832dc8f4 regulator: rpmh-regulator: Add RPMH regulator support for PMR735D
> f76dbe127f1b5910e37dfe307d2de5c13d61ed89 regulator: dt-bindings: qcom,rpmh: Add support for PMR735D
> 5263cd81578f99a00b2dd7de1da2b570b96a1b7c rpmh-regulators: Update rpmh-regulator driver and
> fb25114cd760c13cf177d9ac37837fafcc9657b5 regulator: sy7636a: add gpios and input regulator
> 65efe5404d151767653c7b7dd39bd2e7ad532c2d regulator: rpmh-regulator: Add RPMH regulator support for Glymur
> 6a8cdef7dc2a4c0dbde3f7d7100b3d99712a766b regulator: rpmh-regulator: Add support for new resource name format
> 1356c98ef911e14ccfaf374800840ce5bdcb3bbd regulator: dt-bindings: rpmh-regulator: Update pmic-id DT prop info for new CMD-DB
> 835dfb12fc389f36eb007657f163bd1c539dcd45 regulator: dt-bindings: rpmh-regulator : Add compatibles for PMH01XX & PMCX0102
> 433e294c3c5b5d2020085a0e36c1cb47b694690a regulator: core: forward undervoltage events downstream by default
> 6277a486a7faaa6c87f4bf1d59a2de233a093248 regulator: dt-bindings: Convert Dialog DA9211 Regulators to DT schema

-- 
With Best Regards,
Andy Shevchenko



