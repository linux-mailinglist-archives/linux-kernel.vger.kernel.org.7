Return-Path: <linux-kernel+bounces-899494-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 19C22C57ECE
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 15:25:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 85AE6351315
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 14:22:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15C382877D9;
	Thu, 13 Nov 2025 14:22:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EDqFMzgJ"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4734283FF9;
	Thu, 13 Nov 2025 14:22:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763043747; cv=none; b=TbImzd/WVjALUszBFiYiYP23vCX4FwfTz07Vd0PERV/SArAJpp4ifJIMGVj1rNOqQAzifhPdYda+z/qrUoH7/1OdF6kc5lADwyKsjANLPwFE4K9ef3mA6h1ImlJF4tqQL930CwmRulkWt35RPhuS8En9wcqRDsExpi4rXd8honU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763043747; c=relaxed/simple;
	bh=VHm3dGajIZFdLCEjo6RhvwU9h8nLup+9R9J4A/jkTNg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tKRFJbEkuuWmQV++YK/6RYalut6eqEDfwa3Ib3vx3f69a3wCoseN8C9hLtKqzzFqR11Gy+85MVcjkoAEdGu4LwAGUEgzbB120SCJfUGwR4GRFhefAUySs8D6tkk/5K7JWRs3MirL0gJ7uvXDLD10QVJ6R9XRvsTILG9Rg+5+Dv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EDqFMzgJ; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1763043745; x=1794579745;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=VHm3dGajIZFdLCEjo6RhvwU9h8nLup+9R9J4A/jkTNg=;
  b=EDqFMzgJ/4M94rH7nQsRsXC9A8qASf00ChPpudlRjF1C7XBJVuLIlA4z
   Bs7Gu2qZPC2IT9F+Dsl+vjWVLpwtNGIgk2f7wj4/sNooQfj95D+nihNwt
   PX80imEnV2muW5DTwrCMkSJtHcjyq9+ahT27uLWmNjFc/GNCqb3x6hhW8
   YkcdbtdDLNScymRt853XiF+uKo+wkCzG35O/eadcW2a2OXI1RU5DzVB3X
   P+n4OFajCZuJpRWm3mQZbAJFN6liEY9fLzeaQbdzkh3K+lo2UJqkKlPZ6
   7eNgGSAaF/cVrU/+bu0GnRRyt1KraXpzeF/1B0VNRUDvm9tXI0xPQcff5
   w==;
X-CSE-ConnectionGUID: M8kOA35qRzGRIEpnmu3DMA==
X-CSE-MsgGUID: zOEzfD/rQgeprshKyZUXtQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11612"; a="65030916"
X-IronPort-AV: E=Sophos;i="6.19,302,1754982000"; 
   d="scan'208";a="65030916"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2025 06:22:25 -0800
X-CSE-ConnectionGUID: 0nmFRwd+RIia7e4u2IYFLg==
X-CSE-MsgGUID: PUjJmhXRRUaIrm0G484j1g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,302,1754982000"; 
   d="scan'208";a="220313531"
Received: from lkp-server01.sh.intel.com (HELO 7b01c990427b) ([10.239.97.150])
  by fmviesa001.fm.intel.com with ESMTP; 13 Nov 2025 06:22:21 -0800
Received: from kbuild by 7b01c990427b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1vJYDL-0005QF-0Q;
	Thu, 13 Nov 2025 14:22:19 +0000
Date: Thu, 13 Nov 2025 22:21:53 +0800
From: kernel test robot <lkp@intel.com>
To: Yuntao Wang <yuntao.wang@linux.dev>, Rob Herring <robh@kernel.org>,
	Saravana Kannan <saravanak@google.com>
Cc: oe-kbuild-all@lists.linux.dev,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Catalin Marinas <catalin.marinas@arm.com>,
	AKASHI Takahiro <takahiro.akashi@linaro.org>,
	James Morse <james.morse@arm.com>,
	Chen Zhou <chenzhou10@huawei.com>, Baoquan He <bhe@redhat.com>,
	Zhen Lei <thunder.leizhen@huawei.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Linux Memory Management List <linux-mm@kvack.org>,
	Changyuan Lyu <changyuanl@google.com>,
	Alexander Graf <graf@amazon.com>,
	"Mike Rapoport (Microsoft)" <rppt@kernel.org>,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	Yuntao Wang <yuntao.wang@linux.dev>
Subject: Re: [PATCH 04/10] of/reserved_mem: Use dt_root_addr_size_bytes()
 instead of open-coding it
Message-ID: <202511132259.fWi45yHp-lkp@intel.com>
References: <20251112143520.233870-5-yuntao.wang@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251112143520.233870-5-yuntao.wang@linux.dev>

Hi Yuntao,

kernel test robot noticed the following build warnings:

[auto build test WARNING on robh/for-next]
[also build test WARNING on linus/master v6.18-rc5 next-20251113]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Yuntao-Wang/of-fdt-Introduce-dt_root_addr_size_cells-and-dt_root_addr_size_bytes/20251112-232000
base:   https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git for-next
patch link:    https://lore.kernel.org/r/20251112143520.233870-5-yuntao.wang%40linux.dev
patch subject: [PATCH 04/10] of/reserved_mem: Use dt_root_addr_size_bytes() instead of open-coding it
config: nios2-randconfig-002-20251113 (https://download.01.org/0day-ci/archive/20251113/202511132259.fWi45yHp-lkp@intel.com/config)
compiler: nios2-linux-gcc (GCC) 11.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251113/202511132259.fWi45yHp-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202511132259.fWi45yHp-lkp@intel.com/

All warnings (new ones prefixed by >>, old ones prefixed by <<):

>> WARNING: modpost: vmlinux: section mismatch in reference: dt_root_addr_size_bytes+0x0 (section: .text.unlikely) -> dt_root_addr_cells (section: .init.data)
>> WARNING: modpost: vmlinux: section mismatch in reference: dt_root_addr_size_bytes+0x4 (section: .text.unlikely) -> dt_root_size_cells (section: .init.data)
WARNING: modpost: vmlinux: section mismatch in reference: dt_root_addr_size_bytes+0x8 (section: .text.unlikely) -> dt_root_addr_cells (section: .init.data)
WARNING: modpost: vmlinux: section mismatch in reference: dt_root_addr_size_bytes+0xc (section: .text.unlikely) -> dt_root_size_cells (section: .init.data)
ERROR: modpost: "__divsi3_table" [lib/lz4/lz4_compress.ko] undefined!

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

