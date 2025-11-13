Return-Path: <linux-kernel+bounces-899843-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AEF5EC58DFD
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 17:52:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 666C9425EB2
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 16:45:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73D9735A15C;
	Thu, 13 Nov 2025 16:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VLtYn+GB"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AD5B35A141
	for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 16:37:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763051860; cv=none; b=L6gG88Trx6BYhjSGn1CD97rQHBp3lWglu5EOWzwD07ojITEkCIafxJDl2xF9fix/8KM1MHmw9pB1y9wsiDomho0cHBhy0lSaXraawW3oCppZk2r8vslRLC33QY68+IFA4Hn6umMYZLkv22iTO4ljQgANtM3O08T4ZBbfKg/rlVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763051860; c=relaxed/simple;
	bh=L2dJ8M6bmfI5rWS0eXljqH0I3hgmIRg5+3CvR8yK6O0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m25JxMuYMPvE6+q6UO0LLlzaqf1m6FJOzzioHEyOGXgTE0IHqAFEHH+RdpNoYGPvdzFdfCH+irkvI+XpDrCY+jt/LeWFxNWS/oFBTZ0IPLo1HgaJXZXhc2XGG6WrNmk4PIWgF6jqAEInhMUUIuNQOjAiSxv1LcC7VONpdCKwLYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VLtYn+GB; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1763051859; x=1794587859;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=L2dJ8M6bmfI5rWS0eXljqH0I3hgmIRg5+3CvR8yK6O0=;
  b=VLtYn+GB7sebDt0Ui+XINPzFrD0TH+p1fBmsxct9bbDmokVc2EeKyI7A
   4n7MQOVC+KnezfhuBzppUwLt54yAEFgD7JRhe7Pj98l6/z3QPtdhasExj
   eDBKBN53Amt1/YltE/zmIiFmtsdVheh5LVnPbgrdLoJUqZOto2OOaJ7/i
   RjHagy7Y1FUdAQEV2wQyKAZqhxtPzN750HopNciOmhi2xvb9kPC3Brt6x
   MVc3FFbKFy+qOSRL3oA5lsfohJY/ztLy0d48iHgY/o83YTWzYih0oqf33
   bwuZhiHZV3zgezgwtvznGUS2XAfwD+Oc6HqOh/kkxUCshLqkjwAI5Jujo
   g==;
X-CSE-ConnectionGUID: Y0xo0Mk9RP+ue35bVCGK0A==
X-CSE-MsgGUID: KLd4HLEbRyeTVqspSdFmlw==
X-IronPort-AV: E=McAfee;i="6800,10657,11612"; a="65045376"
X-IronPort-AV: E=Sophos;i="6.19,302,1754982000"; 
   d="scan'208";a="65045376"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2025 08:37:38 -0800
X-CSE-ConnectionGUID: AxHjYY+HQ/WDwsFLkMMLsA==
X-CSE-MsgGUID: +4p+XrXRQaqBFv8amwvoWA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,302,1754982000"; 
   d="scan'208";a="220358822"
Received: from lkp-server01.sh.intel.com (HELO 7b01c990427b) ([10.239.97.150])
  by fmviesa001.fm.intel.com with ESMTP; 13 Nov 2025 08:37:37 -0800
Received: from kbuild by 7b01c990427b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1vJaKE-0005Zh-1r;
	Thu, 13 Nov 2025 16:37:34 +0000
Date: Fri, 14 Nov 2025 00:37:28 +0800
From: kernel test robot <lkp@intel.com>
To: Gregory Price <gourry@gourry.net>, linux-mm@kvack.org
Cc: oe-kbuild-all@lists.linux.dev, kernel-team@meta.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] memory-tiers: multi-definition fixup
Message-ID: <202511140039.XVfj2ju0-lkp@intel.com>
References: <20251113145815.2926823-1-gourry@gourry.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251113145815.2926823-1-gourry@gourry.net>

Hi Gregory,

kernel test robot noticed the following build warnings:



url:    https://github.com/intel-lab-lkp/linux/commits/UPDATE-20251113-230036/Gregory-Price/mm-constify-oom_control-scan_control-and-alloc_context-nodemask/20251113-033247
base:   the 8th patch of https://lore.kernel.org/r/20251112192936.2574429-9-gourry%40gourry.net
patch link:    https://lore.kernel.org/r/20251113145815.2926823-1-gourry%40gourry.net
patch subject: [PATCH] memory-tiers: multi-definition fixup
config: m68k-allnoconfig (https://download.01.org/0day-ci/archive/20251114/202511140039.XVfj2ju0-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 15.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251114/202511140039.XVfj2ju0-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202511140039.XVfj2ju0-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from mm/oom_kill.c:37:
>> include/linux/memory-tiers.h:197:12: warning: 'mt_set_node_type' defined but not used [-Wunused-function]
     197 | static int mt_set_node_type(int node, int type)
         |            ^~~~~~~~~~~~~~~~


vim +/mt_set_node_type +197 include/linux/memory-tiers.h

   196	
 > 197	static int mt_set_node_type(int node, int type)

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

