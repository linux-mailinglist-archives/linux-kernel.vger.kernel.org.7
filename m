Return-Path: <linux-kernel+bounces-891967-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 28CA3C43EF0
	for <lists+linux-kernel@lfdr.de>; Sun, 09 Nov 2025 14:39:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0F8B44E2131
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Nov 2025 13:39:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA1E12FA0D4;
	Sun,  9 Nov 2025 13:38:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WtEuVHPV"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DAC52F7ACC
	for <linux-kernel@vger.kernel.org>; Sun,  9 Nov 2025 13:38:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762695535; cv=none; b=rfpqlORZyy2nX7GOz715EjekVg1+ubAf7pid48KL600Ue8ls9dHnGb7Um1LPA3GOGVqjewJbx+0WAEf5eKS7zNmt+yZnEB+Y1z+ZAk16W3LVex8LSgAqOVxtAQLIrT6U/AhqCJkg3bt26NfJbZP+BweDFcMhpJbFHzAHe2VdA6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762695535; c=relaxed/simple;
	bh=1x+Mo9nWh2WXI6lONcFe9DSrRcVoSKddorvdA0ovrps=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qr8UKRSAeQrMA3+0XdGGYwRHSXYAWlxzYVHc7UPAD2M1AEfL6iAsEBSpViPyaQBHZVpmu83ZBjeN0brqTklxGXk9VAR0ZmKVU3hGQ2R1wEE2OQiVoYAyCjNA34DpaX1A1ViUg4BZrVncr8K6AZs9ykQCTw5/Qze/q0Sz7L2BsbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WtEuVHPV; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762695533; x=1794231533;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=1x+Mo9nWh2WXI6lONcFe9DSrRcVoSKddorvdA0ovrps=;
  b=WtEuVHPVsAYKBZr9KHH+xxcft450+7mSZJ9i3PpiU58+hJq7rqial3DL
   tw+A6A1g7ZJ1wMogB/A2QOrQAvopXklAiq/qY3yUAV3aHEeX4n+FkM+la
   MsfYOoViUx1IXDLqZIaHH50qDiGI/xwFxWD1QLF7udEKFL7ULNGMzvMz+
   wVOr2F4as43TZOk3VhGKovAFGyj8ZuEhNmG5pz3jHB2Fp6LRdgwrQ/TAM
   glXQvw+lKnjTWm/3t/zWpE33VDM/DWB6l1+mqYt7ljJ+WrcFD44rwmxYI
   PZMAfaeLrx67lUdgttMvb0KTgX3KUofAOq+ZkDO3QrESDKA38Xdd+OdC8
   g==;
X-CSE-ConnectionGUID: RcCzLxavRGmPhqD7oAYNCQ==
X-CSE-MsgGUID: ObLP6QfUTnWihBvJyJAvvA==
X-IronPort-AV: E=McAfee;i="6800,10657,11607"; a="64682114"
X-IronPort-AV: E=Sophos;i="6.19,291,1754982000"; 
   d="scan'208";a="64682114"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2025 05:38:52 -0800
X-CSE-ConnectionGUID: ifjZIU4pSdODEVFMem63lw==
X-CSE-MsgGUID: JRKtoAiyTRuSZxiMKKrPuQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,291,1754982000"; 
   d="scan'208";a="192570350"
Received: from lkp-server01.sh.intel.com (HELO 6ef82f2de774) ([10.239.97.150])
  by orviesa003.jf.intel.com with ESMTP; 09 Nov 2025 05:38:49 -0800
Received: from kbuild by 6ef82f2de774 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1vI5d0-00022F-1d;
	Sun, 09 Nov 2025 13:38:46 +0000
Date: Sun, 9 Nov 2025 21:38:19 +0800
From: kernel test robot <lkp@intel.com>
To: Sourabh Jain <sourabhjain@linux.ibm.com>, linux-kernel@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, Sourabh Jain <sourabhjain@linux.ibm.com>,
	Aditya Gupta <adityag@linux.ibm.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Linux Memory Management List <linux-mm@kvack.org>,
	Baoquan he <bhe@redhat.com>, Dave Young <dyoung@redhat.com>,
	Hari Bathini <hbathini@linux.ibm.com>, Jiri Bohac <jbohac@suse.cz>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
	Pingfan Liu <piliu@redhat.com>,
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
	Shivang Upadhyay <shivangu@linux.ibm.com>,
	Vivek Goyal <vgoyal@redhat.com>, linuxppc-dev@lists.ozlabs.org,
	kexec@lists.infradead.org
Subject: Re: [PATCH v2 2/5] kexec: move sysfs entries to /sys/kernel/kexec
Message-ID: <202511092102.Qi35GqrR-lkp@intel.com>
References: <20251106045107.17813-3-sourabhjain@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251106045107.17813-3-sourabhjain@linux.ibm.com>

Hi Sourabh,

kernel test robot noticed the following build warnings:

[auto build test WARNING on akpm-mm/mm-everything]
[also build test WARNING on linus/master v6.18-rc4 next-20251107]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Sourabh-Jain/Documentation-ABI-add-kexec-and-kdump-sysfs-interface/20251106-125243
base:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-everything
patch link:    https://lore.kernel.org/r/20251106045107.17813-3-sourabhjain%40linux.ibm.com
patch subject: [PATCH v2 2/5] kexec: move sysfs entries to /sys/kernel/kexec
config: s390-randconfig-r131-20251109 (https://download.01.org/0day-ci/archive/20251109/202511092102.Qi35GqrR-lkp@intel.com/config)
compiler: clang version 16.0.6 (https://github.com/llvm/llvm-project 7cbf1a2591520c2491aa35339f227775f4d3adf6)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251109/202511092102.Qi35GqrR-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202511092102.Qi35GqrR-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> kernel/kexec_core.c:1315:16: sparse: sparse: symbol 'kexec_kobj' was not declared. Should it be static?

vim +/kexec_kobj +1315 kernel/kexec_core.c

  1314	
> 1315	struct kobject *kexec_kobj;
  1316	ATTRIBUTE_GROUPS(kexec);
  1317	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

