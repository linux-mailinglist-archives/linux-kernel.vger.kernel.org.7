Return-Path: <linux-kernel+bounces-882707-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 98733C2B2FF
	for <lists+linux-kernel@lfdr.de>; Mon, 03 Nov 2025 11:58:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EF4283B5311
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 10:54:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFEB13002DB;
	Mon,  3 Nov 2025 10:54:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="V66ueO/+"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C7412FFFA7;
	Mon,  3 Nov 2025 10:54:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762167282; cv=none; b=HQVQ4sUA+ntY2RVdm9MXL33qJp2cKBRQF2IqTLH8Kr6ZpvnQzclcOuYO5H5U/iRCpQDr7hUEUawFWSxpEI/PbQX/dOAty+XrIMtmaD3ZcPpoo7q0qCozL/WRKmbeQ0seiDeeO7s8oKgP9xRX68xyYcoBE7Z9lZfRyyvs4CcUjE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762167282; c=relaxed/simple;
	bh=eAO6uuVvRpX5kBZXZELX/CH9fZ5qwDFj2NrOEEcA+3Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f8/hkhAA1cfYIfpVnNwGUg4N8D/jh2xoL0AGAvqwcmcwGOhwZsjDvCZY6U78CHL78k4h2cTjCz5KFaCo4mQ/XZIWiLe/QDU7MacmnkLhPxTnFNkLzmMM4ToQs1VqyIWP2HFtJ2l8GbXBEQrtp51LUWRRl5vi1kl7BkdvGkZiEE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=V66ueO/+; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762167281; x=1793703281;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=eAO6uuVvRpX5kBZXZELX/CH9fZ5qwDFj2NrOEEcA+3Q=;
  b=V66ueO/+M/kt1xjAWKtItZstuJhT+0PmRAAsEnsMyaXVxub7Ip3vaKBS
   2kiKALpEd/RZj3liPRrUqVFiu1Uug1bRxKtg1bRQ3dkmkP+t3U6kzXbZF
   jnhJiC/c2YD36ywGqZTeslqcAxIcv7v8gJ0zPO9yqfJerw+6loUyjRynd
   ucFsUJu6MkrBDpHqmj81CDW7ANqn2+W6o7ubq95jRDVCrxSMJSyQxIEHo
   zbclRoDYa8jHXCFPfOXuuS9OQnrh1cUaHogNkR1tKwdAnW8HSPIjmiJcI
   V8YO8ZBghkVK6WzQ/E4P0esUAARgdH4+SkiTORzN/BHlG7WY0sHyVPQwl
   g==;
X-CSE-ConnectionGUID: uFIRB/UvSWy0/ovMrFfzjw==
X-CSE-MsgGUID: TNSl54AkTPWyGY3LdSQuSw==
X-IronPort-AV: E=McAfee;i="6800,10657,11601"; a="68099832"
X-IronPort-AV: E=Sophos;i="6.19,276,1754982000"; 
   d="scan'208";a="68099832"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2025 02:54:40 -0800
X-CSE-ConnectionGUID: UQnYsNNPS/uLYv5iauyKBg==
X-CSE-MsgGUID: Sv09t+vDRviq/kcdagPr7g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,276,1754982000"; 
   d="scan'208";a="186710667"
Received: from lkp-server02.sh.intel.com (HELO 66d7546c76b2) ([10.239.97.151])
  by fmviesa006.fm.intel.com with ESMTP; 03 Nov 2025 02:54:35 -0800
Received: from kbuild by 66d7546c76b2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1vFsCn-000Q30-2G;
	Mon, 03 Nov 2025 10:54:33 +0000
Date: Mon, 3 Nov 2025 18:54:28 +0800
From: kernel test robot <lkp@intel.com>
To: Laurentiu Mihalcea <laurentiumihalcea111@gmail.com>,
	Abel Vesa <abelvesa@kernel.org>, Peng Fan <peng.fan@nxp.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Fabio Estevam <festevam@gmail.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Daniel Baluta <daniel.baluta@nxp.com>,
	Shengjiu Wang <shengjiu.wang@nxp.com>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-clk@vger.kernel.org, imx@lists.linux.dev,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Pengutronix Kernel Team <kernel@pengutronix.de>
Subject: Re: [PATCH v3 3/8] clk: imx: add driver for imx8ulp's sim lpav
Message-ID: <202511031829.Ju1yYI9x-lkp@intel.com>
References: <20251029135229.890-4-laurentiumihalcea111@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251029135229.890-4-laurentiumihalcea111@gmail.com>

Hi Laurentiu,

kernel test robot noticed the following build errors:

[auto build test ERROR on abelvesa/clk/imx]
[also build test ERROR on abelvesa/for-next linus/master pza/reset/next v6.18-rc4 next-20251103]
[cannot apply to pza/imx-drm/next]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Laurentiu-Mihalcea/reset-imx8mp-audiomix-Fix-bad-mask-values/20251029-225054
base:   https://git.kernel.org/pub/scm/linux/kernel/git/abelvesa/linux.git clk/imx
patch link:    https://lore.kernel.org/r/20251029135229.890-4-laurentiumihalcea111%40gmail.com
patch subject: [PATCH v3 3/8] clk: imx: add driver for imx8ulp's sim lpav
config: arm-randconfig-001-20251103 (https://download.01.org/0day-ci/archive/20251103/202511031829.Ju1yYI9x-lkp@intel.com/config)
compiler: clang version 22.0.0git (https://github.com/llvm/llvm-project d2625a438020ad35330cda29c3def102c1687b1b)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251103/202511031829.Ju1yYI9x-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202511031829.Ju1yYI9x-lkp@intel.com/

All errors (new ones prefixed by >>, old ones prefixed by <<):

>> ERROR: modpost: "__devm_auxiliary_device_create" [drivers/clk/imx/clk-imx8ulp-sim-lpav.ko] undefined!

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

