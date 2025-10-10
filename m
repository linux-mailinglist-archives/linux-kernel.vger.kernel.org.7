Return-Path: <linux-kernel+bounces-848343-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 3927CBCD786
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 16:18:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id CDB83355BFF
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 14:18:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13BBE2F6588;
	Fri, 10 Oct 2025 14:16:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KLRMleA5"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 129792F656E
	for <linux-kernel@vger.kernel.org>; Fri, 10 Oct 2025 14:16:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760105813; cv=none; b=P/szvUPfqjl9LQ5tLjnbuXZ+jNjJivOcjwiXmVsHXm5SOw9290x3/bV2Sfx5bYtpZ/GZsiiBrC3MgX/Z+n33J5Szr+We2jB29aAk5dFTkCe25PGxSpn2lDGre8v3CqMozZ0Zmj6Ea9zGCN08RbW4m+CO4PPp1bzilcZnylKlytI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760105813; c=relaxed/simple;
	bh=80h6mrAaud97uc9EduYzED8S14ed6d870EpHss4JGBc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R6+FOKL6vgyVY8yQvYOERenFljLsN/s3wDYmXmZxNrh7/kxA//kueI73GV+6GYgu3XnK197qE7+RWc1oQl8CTIBojt5jARmK28ELV+Y6owbmBfcbFnBbnO1mynQkpjgxag7aoybftJtGwASaXoBK/y47pfbm3V2/8u+Cd5Lix6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KLRMleA5; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760105811; x=1791641811;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=80h6mrAaud97uc9EduYzED8S14ed6d870EpHss4JGBc=;
  b=KLRMleA5JUxaUPQ58Mqo5+JbDtZI9q9OoiMfzWhaJNCJ2XaBJSiiYEOS
   UL8WvAQIZ0fmXPVaNsyrsWp+KSyMInv6SM6BqZQ4VlqOIowNHyLb4Xb4G
   tETkBYVGP6mSOgFt53yplGPLOfrL3ksyzYkiVoGNB0u+cshUBDD5IqZdH
   1pygJp2QvQuqa5sZNh2ntSQHTCWJvoCbZh98wZAqb2R+f4vNNfmJN44zV
   0AiDM+WoAVCe1s+u+XP2Zzr8oQdHHuS9eNsgvyZl6wnm0cSOfLbuQY8ja
   KT5tFq283cJ11RSu6k9msePiIpV2CmO7JKzB/BSFctyi19+cD7QiCA+21
   g==;
X-CSE-ConnectionGUID: kCaOFwWVQHCruup70T0aJw==
X-CSE-MsgGUID: KurIKBROS4ivYAvTdcK3cg==
X-IronPort-AV: E=McAfee;i="6800,10657,11578"; a="72582399"
X-IronPort-AV: E=Sophos;i="6.19,219,1754982000"; 
   d="scan'208";a="72582399"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2025 07:16:51 -0700
X-CSE-ConnectionGUID: 8LBWA8r0S8KeaHF8A8VjEQ==
X-CSE-MsgGUID: BIOHHL5DRvuQZ8fJ2wR0Yw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,219,1754982000"; 
   d="scan'208";a="186122752"
Received: from lkp-server01.sh.intel.com (HELO 6a630e8620ab) ([10.239.97.150])
  by orviesa005.jf.intel.com with ESMTP; 10 Oct 2025 07:16:46 -0700
Received: from kbuild by 6a630e8620ab with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1v7DvJ-0002qV-0H;
	Fri, 10 Oct 2025 14:16:45 +0000
Date: Fri, 10 Oct 2025 22:16:30 +0800
From: kernel test robot <lkp@intel.com>
To: "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>,
	linux-coco@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Steven Price <steven.price@arm.com>,
	Gavin Shan <gshan@redhat.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Jeremy Linton <jeremy.linton@arm.com>,
	Sami Mujawar <sami.mujawar@arm.com>,
	"Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>
Subject: Re: [PATCH] coco: guest: arm64: Update ARM CCA guest driver
Message-ID: <202510102121.hLzgHTck-lkp@intel.com>
References: <20251008132758.784275-1-aneesh.kumar@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251008132758.784275-1-aneesh.kumar@kernel.org>

Hi Aneesh,

kernel test robot noticed the following build errors:

[auto build test ERROR on arm64/for-next/core]
[also build test ERROR on arm/for-next arm/fixes kvmarm/next soc/for-next linus/master v6.17 next-20251009]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Aneesh-Kumar-K-V-Arm/coco-guest-arm64-Update-ARM-CCA-guest-driver/20251009-203207
base:   https://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-next/core
patch link:    https://lore.kernel.org/r/20251008132758.784275-1-aneesh.kumar%40kernel.org
patch subject: [PATCH] coco: guest: arm64: Update ARM CCA guest driver
config: arm64-allmodconfig (https://download.01.org/0day-ci/archive/20251010/202510102121.hLzgHTck-lkp@intel.com/config)
compiler: clang version 19.1.7 (https://github.com/llvm/llvm-project cd708029e0b2869e80abe31ddb175f7c35361f90)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251010/202510102121.hLzgHTck-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202510102121.hLzgHTck-lkp@intel.com/

All errors (new ones prefixed by >>):

>> ld.lld: error: cannot open drivers/virt/coco/arm-cca-guest/: Is a directory

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

