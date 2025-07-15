Return-Path: <linux-kernel+bounces-732589-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CD58B0692C
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 00:18:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 153133ABA38
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 22:18:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2B832C15B1;
	Tue, 15 Jul 2025 22:18:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="I7yD0NXv"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEA0272615
	for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 22:18:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752617931; cv=none; b=enrof4/IU/6AyFxdE8LvO8acwZp76vnIZ3cKcl7v9B2uU6So1NWXzWrTiwa+3UQ3XAFqZRrfXG06vmUszQzjWXRKKy6cvC4wejtHG8jrlwcO0SnW/GDk+FzcWu+wUY1Cofrc4QOG2fqc0MviBYddTTP0bWKEXYeuvu5ho1jjuts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752617931; c=relaxed/simple;
	bh=RrUG38UPoPx83mBx18hUOO16lRtjlEtzmrBZc9cW3Lo=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Ln5XzYIoYapaI7Qj2Vgo/jCB5GGmA2bhmwzFY9peTTFqomVapll8DxHUCd+Lrzu4Sy3hksjuVUVNiqGXt+eT3XwUZIJanwN0PCm2vtur93ZlHZENmPPU1Adk5gtf1odwpJZT1g5awyKrJSeURxjRZVHClPNzL376TFynFdJLl8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=I7yD0NXv; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752617930; x=1784153930;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=RrUG38UPoPx83mBx18hUOO16lRtjlEtzmrBZc9cW3Lo=;
  b=I7yD0NXv/eTVzJpO1Ng/umWjYHRGJRIK8EsbjUaBQ/7cYMNMQQCyEW6F
   6oZggbdZGnzkyziBdrUyQri2FuVIT0c5VjoojA2yux6fk3iMyGUaiyV4F
   FGLQD9gzMdXmPw0jWyu1Ngtq+qenYXzKbKmTlm6kDLrvoIfBFT/x62GRf
   G17yzmDu+iwq3o+VRnxz/ZXE0YEVRZhZ6R2S1BWLtBrMPJV9df8yWJgTW
   bwn4n3rz+d++q6boBNFSbyVkTlKTEuaDm1J9lC3PtxyvHbJsIay9UlyNJ
   7fi90bHJH8tObkrI9dZEmXcW9E65F3G+UEoGMc8DgfZyEvgUK7vAK+7+m
   Q==;
X-CSE-ConnectionGUID: FErFqziYRfKt35/1//+vHg==
X-CSE-MsgGUID: pWjSv8NHQCO1Mqunh+2uAw==
X-IronPort-AV: E=McAfee;i="6800,10657,11493"; a="54976886"
X-IronPort-AV: E=Sophos;i="6.16,314,1744095600"; 
   d="scan'208";a="54976886"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jul 2025 15:18:50 -0700
X-CSE-ConnectionGUID: 9ZYQA1cvTqSbqbxZkPgg5A==
X-CSE-MsgGUID: pf8kCVk5S3SqszxmLZWffg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,314,1744095600"; 
   d="scan'208";a="194472790"
Received: from lkp-server01.sh.intel.com (HELO 9ee84586c615) ([10.239.97.150])
  by orviesa001.jf.intel.com with ESMTP; 15 Jul 2025 15:18:48 -0700
Received: from kbuild by 9ee84586c615 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1ubnz3-000Bb7-1L;
	Tue, 15 Jul 2025 22:18:45 +0000
Date: Wed, 16 Jul 2025 06:18:09 +0800
From: kernel test robot <lkp@intel.com>
To: Marco Crivellari <marco.crivellari@suse.com>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	"Maciej W. Rozycki" <macro@orcam.me.uk>
Subject: <instantiation>:7:11: error: expected an immediate
Message-ID: <202507160634.HuBB6qKT-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Marco,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   155a3c003e555a7300d156a5252c004c392ec6b0
commit: 56651128e2fbad80f632f388d6bf1f39c928267a MIPS: Fix idle VS timer enqueue
date:   3 months ago
config: mips-rb532_defconfig (https://download.01.org/0day-ci/archive/20250716/202507160634.HuBB6qKT-lkp@intel.com/config)
compiler: clang version 18.1.8 (https://github.com/llvm/llvm-project 3b5b5c1ec4a3095ab096dd780e84d7ab81f3d7ff)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250716/202507160634.HuBB6qKT-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202507160634.HuBB6qKT-lkp@intel.com/

All errors (new ones prefixed by >>):

>> <instantiation>:7:11: error: expected an immediate
    ori $26, r4k_wait_idle_size - 2
             ^
   <instantiation>:10:13: error: expected an immediate
    addiu $26, r4k_wait_exit - r4k_wait_insn + 2
               ^
   <instantiation>:10:29: error: expected an immediate
    addiu $26, r4k_wait_exit - r4k_wait_insn + 2
                               ^
>> <instantiation>:7:11: error: expected an immediate
    ori $26, r4k_wait_idle_size - 2
             ^
   <instantiation>:10:13: error: expected an immediate
    addiu $26, r4k_wait_exit - r4k_wait_insn + 2
               ^
   <instantiation>:10:29: error: expected an immediate
    addiu $26, r4k_wait_exit - r4k_wait_insn + 2
                               ^

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

