Return-Path: <linux-kernel+bounces-859487-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C51FBEDCEA
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Oct 2025 01:23:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id EB6494E2495
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Oct 2025 23:23:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF0B02857CF;
	Sat, 18 Oct 2025 23:23:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="l5JYYWYS"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5613C1A316E;
	Sat, 18 Oct 2025 23:23:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760829807; cv=none; b=pZO9m5yCD5mn3gx4LQkqBEtKtIL1FLovVPEdP5hssTYxZSzlr1szPuzZ/LduTPpXg6I6NkIVjg0e/I6mZT66wFdzi5hw8kvN9mzAZ6OOW/Wau1eO9dFnmypO2SmbKrfY5I3i7Mv84baCPkAGjOz+080nvrALDVoa6CByvMvjiHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760829807; c=relaxed/simple;
	bh=9MLdj9wpJXNrazCJbFGZFgXo0Adj941uIsE+4ls2ZM0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lQZBerstGdC9gtXiJPgbKSR3Kqswr9FaEiQb0CVV6fk7zAUFU5/axKXo40q4xtDZVSSkgaaUv/BUBrjZ7/IxMZ5HwlyaaQNpmbCNkPllM0ptwoeBkJn8mGU39FOUCDHK46p8T2kW+2Pk52o0TVuoqRnB5UW5zoj4bdUKecZRhV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=l5JYYWYS; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760829805; x=1792365805;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=9MLdj9wpJXNrazCJbFGZFgXo0Adj941uIsE+4ls2ZM0=;
  b=l5JYYWYS8F8N6F2HYj6aRLgCo2QgArSLgbFrg0lvXPKyl3w54ICmZVws
   TF9jewMB924VFoAUi6V0iqi2oDkC2D104O0Gif95fK8fzfmDTcUSfPqDe
   fFTQDiDXAK2Uax67dOMeOadGaWr04hoDvrL/QUyX/w91OHDKen689vL6S
   699q7a7MXv9vyqk5Re/X4BbQ8TONP30jVllm6JGXGO9uQy8DU7nCMFGwj
   Dp096abbuD+LkCpPL4JUuydlZnQ70x01J5JEbYZPR5VWjpr21seexSwlQ
   7mzWLA818HzqM42VxhFJCTn/yBxEBRtoenUfT/DLEUEWyqW4d2+BP7fgJ
   w==;
X-CSE-ConnectionGUID: 2EJhhfkVT8SRoC79j9cOVQ==
X-CSE-MsgGUID: qcSP+GC6Q6ioignPD99WKg==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="65621589"
X-IronPort-AV: E=Sophos;i="6.19,239,1754982000"; 
   d="scan'208";a="65621589"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2025 16:23:25 -0700
X-CSE-ConnectionGUID: Md/aauc6THu4J5WtQX8jPw==
X-CSE-MsgGUID: 33V5Xx+lRm+o3dlrbXe5kw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,239,1754982000"; 
   d="scan'208";a="182977975"
Received: from lkp-server02.sh.intel.com (HELO 66d7546c76b2) ([10.239.97.151])
  by fmviesa006.fm.intel.com with ESMTP; 18 Oct 2025 16:23:21 -0700
Received: from kbuild by 66d7546c76b2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1vAGFT-0008gj-1N;
	Sat, 18 Oct 2025 23:22:42 +0000
Date: Sun, 19 Oct 2025 07:21:21 +0800
From: kernel test robot <lkp@intel.com>
To: Elaine Zhang <zhangqing@rock-chips.com>, mturquette@baylibre.com,
	sboyd@kernel.org, sugar.zhang@rock-chips.com, heiko@sntech.de,
	robh@kernel.org, krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-clk@vger.kernel.org, linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org, huangtao@rock-chips.com
Subject: Re: [PATCH v2 3/5] clk: rockchip: Add clock controller for the
 RV1126B
Message-ID: <202510190651.YrDKfo1d-lkp@intel.com>
References: <20251017063107.1606965-4-zhangqing@rock-chips.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251017063107.1606965-4-zhangqing@rock-chips.com>

Hi Elaine,

kernel test robot noticed the following build errors:

[auto build test ERROR on rockchip/for-next]
[also build test ERROR on clk/clk-next linus/master v6.18-rc1 next-20251017]
[cannot apply to pza/imx-drm/next]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Elaine-Zhang/clk-rockchip-Implement-rockchip_clk_register_armclk_multi_pll/20251017-180259
base:   https://git.kernel.org/pub/scm/linux/kernel/git/mmind/linux-rockchip.git for-next
patch link:    https://lore.kernel.org/r/20251017063107.1606965-4-zhangqing%40rock-chips.com
patch subject: [PATCH v2 3/5] clk: rockchip: Add clock controller for the RV1126B
config: arm-defconfig (https://download.01.org/0day-ci/archive/20251019/202510190651.YrDKfo1d-lkp@intel.com/config)
compiler: clang version 22.0.0git (https://github.com/llvm/llvm-project 754ebc6ebb9fb9fbee7aef33478c74ea74949853)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251019/202510190651.YrDKfo1d-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202510190651.YrDKfo1d-lkp@intel.com/

All errors (new ones prefixed by >>):

>> ld.lld: error: undefined symbol: rk3576_rst_init
   >>> referenced by clk-rv1126b.c:1050 (drivers/clk/rockchip/clk-rv1126b.c:1050)
   >>>               drivers/clk/rockchip/clk-rv1126b.o:(rv1126b_clk_init) in archive vmlinux.a

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

