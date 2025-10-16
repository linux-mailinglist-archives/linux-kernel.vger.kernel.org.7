Return-Path: <linux-kernel+bounces-855668-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CCED1BE1EBB
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 09:27:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7F925485FEE
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 07:27:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC7CC2FD7DA;
	Thu, 16 Oct 2025 07:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VKy/hTJU"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B2822FCC16
	for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 07:27:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760599623; cv=none; b=a7u9Gr35up+yZFxO6lGwPZiR1Cg4BniB9sWBPTj5KzwEfQddvjOEsmiJ/3jf/P4SZqzMvdsZCA6T1FHXu8wnZuIK9IrhiNZ7BNuuPFizWehPinRXsBPeDZZ022SBor2TNJcYHfwRoKfjrPDCcfLhwWNoGHM+fVdrYMPY9zNFSr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760599623; c=relaxed/simple;
	bh=l0F0laf+iCtL5JuXaUI/oTJb2yYhJ9ZT5i4/qirUsn0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uMpY9yUx/XBHqKgNsMHHQU0zXSaL41pNqAI3Ckc3qjCfqIFVJCBH9OhjCDJXMoY+ZDoxif6iZAMjd6n7wifBdzz/ozkIQ35ZT4BTdcC6+aa5wqssdsxdYgQGc6YKfX/gAJJSaKD01m1hAS0hDlQxiwqFjPKXXhga8F3FKzp66Bk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VKy/hTJU; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760599622; x=1792135622;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=l0F0laf+iCtL5JuXaUI/oTJb2yYhJ9ZT5i4/qirUsn0=;
  b=VKy/hTJUCXhS1y09+PXuAYsEjm39EwoxClmq9AhYyOuwDIPHxbf0HQpM
   aL45jIY8y6aJmyFA8zT8r8XcBSk+TznhCqox7s2FuUw8sNIqnypTQkw0M
   Oe9Ujoklk+zYbfdBPNXYKR6xVb4BYj/ETB75tyz38p+Fm2cWBny0MUA0P
   qLqFRMn39DUvuODIqMO6cTFqhVNA4YmBsuxTPRbCQ2NHkcXpnPEbvxIKQ
   nX0EMOG1bSxSMSz00y1fMK9zgsyQvhws8GjFx/lRZu+3OI1W1omZrG1vB
   akXSQzvZfrIdAAcw5R7AvM/HDPMZwTjGTv+e/w9UD2ORFlEqIJPRCXLeF
   w==;
X-CSE-ConnectionGUID: SP9GsfLFS+yQQh4ya9z53w==
X-CSE-MsgGUID: diNmCMl1QFCx3ee58oE8Dw==
X-IronPort-AV: E=McAfee;i="6800,10657,11583"; a="62682782"
X-IronPort-AV: E=Sophos;i="6.19,233,1754982000"; 
   d="scan'208";a="62682782"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2025 00:27:01 -0700
X-CSE-ConnectionGUID: CrydLVaNS2ySysIWWmok1A==
X-CSE-MsgGUID: PIbLrSV+R+SEAuHxwOS9Nw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,233,1754982000"; 
   d="scan'208";a="186652836"
Received: from lkp-server02.sh.intel.com (HELO 66d7546c76b2) ([10.239.97.151])
  by orviesa004.jf.intel.com with ESMTP; 16 Oct 2025 00:26:59 -0700
Received: from kbuild by 66d7546c76b2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1v9IO0-0004Yd-1p;
	Thu, 16 Oct 2025 07:26:56 +0000
Date: Thu, 16 Oct 2025 15:26:01 +0800
From: kernel test robot <lkp@intel.com>
To: Yang Shi <yang@os.amperecomputing.com>, ryan.roberts@arm.com,
	cl@gentwo.org, catalin.marinas@arm.com, will@kernel.org
Cc: oe-kbuild-all@lists.linux.dev, yang@os.amperecomputing.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: mm: show direct mapping use in /proc/meminfo
Message-ID: <202510161508.mbPZHa8r-lkp@intel.com>
References: <20251013235118.3072941-1-yang@os.amperecomputing.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251013235118.3072941-1-yang@os.amperecomputing.com>

Hi Yang,

kernel test robot noticed the following build warnings:

[auto build test WARNING on arm64/for-next/core]
[also build test WARNING on linus/master v6.18-rc1 next-20251015]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Yang-Shi/arm64-mm-show-direct-mapping-use-in-proc-meminfo/20251014-075409
base:   https://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-next/core
patch link:    https://lore.kernel.org/r/20251013235118.3072941-1-yang%40os.amperecomputing.com
patch subject: [PATCH] arm64: mm: show direct mapping use in /proc/meminfo
config: arm64-randconfig-r121-20251016 (https://download.01.org/0day-ci/archive/20251016/202510161508.mbPZHa8r-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 8.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251016/202510161508.mbPZHa8r-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202510161508.mbPZHa8r-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> arch/arm64/mm/mmu.c:64:15: sparse: sparse: symbol 'direct_map_cnt' was not declared. Should it be static?

vim +/direct_map_cnt +64 arch/arm64/mm/mmu.c

    63	
  > 64	unsigned long direct_map_cnt[NR_DIRECT_MAP_TYPE];
    65	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

