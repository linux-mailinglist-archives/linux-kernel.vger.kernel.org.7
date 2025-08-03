Return-Path: <linux-kernel+bounces-754332-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AF2EB192AA
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Aug 2025 06:16:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 78498178A79
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Aug 2025 04:16:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D9671F2371;
	Sun,  3 Aug 2025 04:16:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="j2xzEbpG"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26B1E1D6AA
	for <linux-kernel@vger.kernel.org>; Sun,  3 Aug 2025 04:16:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754194578; cv=none; b=V7W1OaLUZ5lRQyIFGC0t6xpC2ffvymuFeNLdsctWT8jVjz52hOqJZmjQG7QRAaarT76wG51gTRd9tvurJLuZaNBF/Qb6Lz6oettOB3HqE4X1zDPHPN1LgqAL4R4yO9C+8EsJmpFvN5g53xlbwQbhdjKZp0WP0zRs5wEVMKQwR1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754194578; c=relaxed/simple;
	bh=f4KmlBJofJBpqvjz6oGNZW1sVG4JqEB+saUijbZ0J+U=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=As7/DKApgnFEY9afAuJU3Nai4f/QTjMd468B6hUY371ucCuTXM9AP6T2OnzSDhG/ph0ye23JO6guwaPUNMP5dm0vOlKpMw9ZOUNOMjj32E/HTDem25XBNGkxK0yrSikT0jmDgim7/Nrv21FK8eP7PwBHcilD3fK4MeVzFPuDcbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=j2xzEbpG; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1754194578; x=1785730578;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=f4KmlBJofJBpqvjz6oGNZW1sVG4JqEB+saUijbZ0J+U=;
  b=j2xzEbpGP4qSFt2B7EA9hwq4whNpBjjcFO9XV3/Sz/OfC8R91A0UqQZ/
   nCNN8nz0ufjdaOGPnJodCjuF05P42Jk2v/cOhqjsqrIUaa93PT/fc49rm
   MAnB+dVNxAKoWyd30GOp0HsboPcdLsc+fjHXG1YLe3zDe4rcLcPBc1KoE
   UAX5xrZhhr7H75x70Lasi04y+zcMIJ0NrgnQ89vcXsi7xhpBAF9+YcPcV
   4NidVodFfBIiptV83yWZPCwv1u3/8PJFwWpi3RA3YstKNkjZde5eZPkjc
   eUWk8ioLudxNiYHY/3cIj5JmzsZWlPxTA/SfVCFBGPUdJqrX/GgIgJy3o
   w==;
X-CSE-ConnectionGUID: 9+0RsAKjSTqq9gZBVAA+FQ==
X-CSE-MsgGUID: fYFA0RSdSPKN8R8taU38+Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11510"; a="66764920"
X-IronPort-AV: E=Sophos;i="6.17,258,1747724400"; 
   d="scan'208";a="66764920"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Aug 2025 21:16:17 -0700
X-CSE-ConnectionGUID: ro/xmTXxRC6HDjQIGx194g==
X-CSE-MsgGUID: 5CODjbaAToKuk0MJRtoMag==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,258,1747724400"; 
   d="scan'208";a="163886552"
Received: from lkp-server01.sh.intel.com (HELO 160750d4a34c) ([10.239.97.150])
  by orviesa007.jf.intel.com with ESMTP; 02 Aug 2025 21:16:15 -0700
Received: from kbuild by 160750d4a34c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uiQ8q-0005ms-3D;
	Sun, 03 Aug 2025 04:16:12 +0000
Date: Sun, 3 Aug 2025 12:15:14 +0800
From: kernel test robot <lkp@intel.com>
To: Roman Kisel <romank@linux.microsoft.com>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-kernel@vger.kernel.org, Wei Liu <wei.liu@kernel.org>,
	Michael Kelley <mhklinux@outlook.com>
Subject: error: <unknown>:0:0: ran out of registers during register
 allocation in function 'hv_apicid_to_vp_index'
Message-ID: <202508031237.Z8WRU0oh-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Roman,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   186f3edfdd41f2ae87fc40a9ccba52a3bf930994
commit: 86c48271e0d60c82665e9fd61277002391efcef7 x86/hyperv: Fix APIC ID and VP index confusion in hv_snp_boot_ap()
date:   2 months ago
config: i386-buildonly-randconfig-005-20250803 (https://download.01.org/0day-ci/archive/20250803/202508031237.Z8WRU0oh-lkp@intel.com/config)
compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250803/202508031237.Z8WRU0oh-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202508031237.Z8WRU0oh-lkp@intel.com/

All errors (new ones prefixed by >>):

>> error: <unknown>:0:0: ran out of registers during register allocation in function 'hv_apicid_to_vp_index'
   1 error generated.

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

