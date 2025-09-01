Return-Path: <linux-kernel+bounces-795161-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B8E0B3EDA4
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 20:08:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B522C207BF4
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 18:08:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91677324B11;
	Mon,  1 Sep 2025 18:07:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lA/ok2BR"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A23D24676D;
	Mon,  1 Sep 2025 18:07:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756750075; cv=none; b=JgIwvICpmdkU4IXgtQ0SOEe43Ak7kRsDl9XoDZU4lLtfbBp7T3pOhZyhE7Lg2VyowJqiCkXzca4ZAO3jmtK/lJx2cKvHxRgAJR1lro6oQGyNaOwiKiCf/mhUliKwWnrjeeiuVl3ByJbbycmp4Ae6HZTo9jY+I1cHkgi5ETBsqwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756750075; c=relaxed/simple;
	bh=qUHEx3K9Fy8B+KsZYMB+IIP81VsmjWAE994TUdk8HXo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tYCpGv7hWrOmpyCvStaztIH9xHiHu1eY/xThb99VgiKyfbqZUppRDfx0oD+bRVIDOJYIdABUaoivW9wnp/JHVFX1J+lhr/MoDUuue6v8mo6Uhd2YfQdWOA8t82o5IoUy9PVZKxs44LstA4Q3pFwxRpTFAQXTiZvHjDrsfYZizw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lA/ok2BR; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756750073; x=1788286073;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=qUHEx3K9Fy8B+KsZYMB+IIP81VsmjWAE994TUdk8HXo=;
  b=lA/ok2BRNUNzubRienCJIW6zpOe2zsUoAlSDcoU0LEacn7ybQ4aYeTUK
   P9zrYAD6YbOyI712xgyW7SRv206XQRP5vZVYsY0LsIfIvlojc+93qgSnD
   LPj9u/pFFKVSpSstaLOSl6WZWZW4RNO8l/25obgtGWKFqMCQ/Yiw73mdX
   3uKJ333nSmQ0LmkwAKDYLdmjZCOPFbpmYKCENVYH57vck0HTUsMx5dSFh
   3gd1S3UYLoKgpLN2MAXp6PsI1UWXYVBl9hw7Qy9EmII8QZnIJp8Jo18jr
   7HQBgFV16yol2tCfCAXf9TF9kg4p5sLDyUrNKcZbm1s660tWvOL9guspr
   g==;
X-CSE-ConnectionGUID: SzbfCmBiTu+vsc/1Ts44Cw==
X-CSE-MsgGUID: yKFBrlCIQ7akt5yToB2wOA==
X-IronPort-AV: E=McAfee;i="6800,10657,11540"; a="46591630"
X-IronPort-AV: E=Sophos;i="6.18,230,1751266800"; 
   d="scan'208";a="46591630"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2025 11:07:53 -0700
X-CSE-ConnectionGUID: GY/rp180RaOLchUaSJ/+NA==
X-CSE-MsgGUID: OsIOuWyIQnOfS6IZpzdaoA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,230,1751266800"; 
   d="scan'208";a="175426955"
Received: from lkp-server02.sh.intel.com (HELO 06ba48ef64e9) ([10.239.97.151])
  by orviesa004.jf.intel.com with ESMTP; 01 Sep 2025 11:07:48 -0700
Received: from kbuild by 06ba48ef64e9 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1ut8wT-0000tP-2s;
	Mon, 01 Sep 2025 18:07:45 +0000
Date: Tue, 2 Sep 2025 02:07:23 +0800
From: kernel test robot <lkp@intel.com>
To: Akashdeep Kaur <a-kaur@ti.com>, praneeth@ti.com, nm@ti.com, afd@ti.com,
	vigneshr@ti.com, d-gole@ti.com, kristo@kernel.org, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org,
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, vishalm@ti.com, sebin.francis@ti.com
Subject: Re: [PATCH v2 3/3] arm64: dts: ti: k3-pinctrl: Add the remaining
 macros
Message-ID: <202509020155.fcjWQKFc-lkp@intel.com>
References: <20250901122835.3022850-4-a-kaur@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250901122835.3022850-4-a-kaur@ti.com>

Hi Akashdeep,

kernel test robot noticed the following build errors:

[auto build test ERROR on robh/for-next]
[also build test ERROR on linus/master v6.17-rc4 next-20250901]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Akashdeep-Kaur/arm64-dts-ti-k3-am62p5-sk-Remove-the-unused-config-from-USB1_DRVVBUS/20250901-203422
base:   https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git for-next
patch link:    https://lore.kernel.org/r/20250901122835.3022850-4-a-kaur%40ti.com
patch subject: [PATCH v2 3/3] arm64: dts: ti: k3-pinctrl: Add the remaining macros
config: arm64-randconfig-053-20250901 (https://download.01.org/0day-ci/archive/20250902/202509020155.fcjWQKFc-lkp@intel.com/config)
compiler: clang version 22.0.0git (https://github.com/llvm/llvm-project 2e122990391b2ba062e6308a12cfedf7206270ba)
dtschema version: 2025.6.2.dev4+g8f79ddd
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250902/202509020155.fcjWQKFc-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202509020155.fcjWQKFc-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from arch/arm64/boot/dts/ti/k3-am625-beagleplay.dts:14:
   In file included from arch/arm64/boot/dts/ti/k3-am625.dtsi:12:
   In file included from arch/arm64/boot/dts/ti/k3-am62.dtsi:13:
>> arch/arm64/boot/dts/ti/k3-pinctrl.h:18:34: error: invalid token in macro parameter list
      18 | #define DS_ISO_OVERRIDE_EN_SHIFT(22)
         |                                  ^
   1 error generated.


vim +18 arch/arm64/boot/dts/ti/k3-pinctrl.h

    10	
    11	#define WKUP_LVL_EN_SHIFT       (7)
    12	#define WKUP_LVL_POL_SHIFT      (8)
    13	#define ST_EN_SHIFT		(14)
    14	#define PULLUDEN_SHIFT		(16)
    15	#define PULLTYPESEL_SHIFT	(17)
    16	#define RXACTIVE_SHIFT		(18)
    17	#define DRV_STR_SHIFT           (19)
  > 18	#define DS_ISO_OVERRIDE_EN_SHIFT(22)
    19	#define DS_ISO_BYPASS_EN_SHIFT  (23)
    20	#define DEBOUNCE_SHIFT		(11)
    21	#define FORCE_DS_EN_SHIFT	(15)
    22	#define DS_EN_SHIFT		(24)
    23	#define DS_OUT_DIS_SHIFT	(25)
    24	#define DS_OUT_VAL_SHIFT	(26)
    25	#define DS_PULLUD_EN_SHIFT	(27)
    26	#define DS_PULLTYPE_SEL_SHIFT	(28)
    27	#define WKUP_EN_SHIFT           (29)
    28	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

