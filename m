Return-Path: <linux-kernel+bounces-881230-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CE88C27C79
	for <lists+linux-kernel@lfdr.de>; Sat, 01 Nov 2025 12:08:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 218CF3B1860
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Nov 2025 11:08:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8943D2F39DA;
	Sat,  1 Nov 2025 11:07:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XJ//iB0m"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D6D02F360F;
	Sat,  1 Nov 2025 11:07:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761995270; cv=none; b=VycBhYcUL/beM0v4oyl3SULDMVDub9qsSrwa79/DPzt1MAH7meERC1piUA6LRpczDuBkeD5Zyzmcw1ogAZWQq9b2DNL18/K+AI19i46DFR/23794znoOri5ck76SoIbSt3V06Ybfi56vMlsKtEOAM61qp3zfL71dWgpLb29u+is=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761995270; c=relaxed/simple;
	bh=KiBsSbViKMDxxR1+aLrfoJnj3kQ563rOF1uBzwFrkzk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PADyIJ9ZuYm5qyXqU/nAxKNmIeBMIJ4rKBA8Cbkk/yp/NXKIRP+7pQ+Q13uMf+Nb8ucaq1onFgRpogUIoBWeV62vz2AiRXMb9fRpX7AvqBlY2VKdWN1yRHRzC9b3G+bvOLpEwgYBa+UVfFFUl4Rbgh4qfDdeEsaTxHF2kG5XPvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XJ//iB0m; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761995268; x=1793531268;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=KiBsSbViKMDxxR1+aLrfoJnj3kQ563rOF1uBzwFrkzk=;
  b=XJ//iB0mB6neVhSRyP/moEQBI5mAO6DCKv6YccilFUE5Q1jeKqG9HZzC
   CT3TDis81BdLOUba4U9eP8brPdLsq84E8bje/miK/XBlupth46OkPT8FF
   PpSd5ly+IVHvj9TgFHKpWNzGxFC0JyWgR5WBP6SPdVNB3uwpnSK8hEvH7
   56iYxkYz6lgLYNPx+HxjyOt9jxvWQ/PFem556lH7pDD0J4FJMl9LPSx5A
   bcCQk6nuS2S7JI+CnrA7GbXX5OGq37NMpoQXrH2u1grvCMtdcNv+vnlKq
   aBO8/jwZHW6OkXFe+/qNz/xnttIRCILTQI7oNh3DmDTDrD6a2iSDSQh0P
   w==;
X-CSE-ConnectionGUID: Oattsm47RY6SwhVhnxAaQQ==
X-CSE-MsgGUID: rXV18VYJTN2mtV+GOQ+unw==
X-IronPort-AV: E=McAfee;i="6800,10657,11599"; a="64173310"
X-IronPort-AV: E=Sophos;i="6.19,271,1754982000"; 
   d="scan'208";a="64173310"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Nov 2025 04:07:47 -0700
X-CSE-ConnectionGUID: 7NZDx6euQNyyDNaldPJczg==
X-CSE-MsgGUID: 2+Wci7r0R0ir1K52qe1bzw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,271,1754982000"; 
   d="scan'208";a="185665250"
Received: from lkp-server02.sh.intel.com (HELO 66d7546c76b2) ([10.239.97.151])
  by orviesa006.jf.intel.com with ESMTP; 01 Nov 2025 04:07:45 -0700
Received: from kbuild by 66d7546c76b2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1vF9SL-000OAU-1R;
	Sat, 01 Nov 2025 11:07:39 +0000
Date: Sat, 1 Nov 2025 19:06:36 +0800
From: kernel test robot <lkp@intel.com>
To: Khairul Anuar Romli <khairul.anuar.romli@altera.com>,
	Dinh Nguyen <dinguyen@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Mahesh Rao <mahesh.rao@altera.com>, devicetree@vger.kernel.org,
	open list <linux-kernel@vger.kernel.org>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH 2/2] arm64: dts: intel: Add Agilex5 SVC node with memory
 region
Message-ID: <202511011821.wW4mmrec-lkp@intel.com>
References: <a3182556c07839dcd9227fa6a4a9d295507f3e8e.1761643239.git.khairul.anuar.romli@altera.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a3182556c07839dcd9227fa6a4a9d295507f3e8e.1761643239.git.khairul.anuar.romli@altera.com>

Hi Khairul,

kernel test robot noticed the following build errors:

[auto build test ERROR on robh/for-next]
[also build test ERROR on linus/master v6.18-rc3 next-20251031]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Khairul-Anuar-Romli/arm64-dts-intel-Add-Agilex5-SVC-node-with-memory-region/20251028-183009
base:   https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git for-next
patch link:    https://lore.kernel.org/r/a3182556c07839dcd9227fa6a4a9d295507f3e8e.1761643239.git.khairul.anuar.romli%40altera.com
patch subject: [PATCH 2/2] arm64: dts: intel: Add Agilex5 SVC node with memory region
config: arm64-randconfig-002-20251101 (https://download.01.org/0day-ci/archive/20251101/202511011821.wW4mmrec-lkp@intel.com/config)
compiler: clang version 22.0.0git (https://github.com/llvm/llvm-project cc271437553452ede002d871d32abc02084341a8)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251101/202511011821.wW4mmrec-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202511011821.wW4mmrec-lkp@intel.com/

All errors (new ones prefixed by >>):

>> ERROR: Input tree has errors, aborting (use -f to force output)

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

