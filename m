Return-Path: <linux-kernel+bounces-726690-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 36BB4B0100A
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 02:03:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8A0CAB410E1
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 00:00:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7F9C2376E0;
	Fri, 11 Jul 2025 00:00:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cjhJu9uv"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 800E472604
	for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 00:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752192017; cv=none; b=HDfj3JFQhD+h8Pvo1ZZ/La/7eMt9yv+9noWjp1T3tb3W6sgxKmHrJmkVMw4X7d9auR3r/n1BNRZdyAlgFGVoWqI4O0SHvtmOejJ1i/k83IK/ySdKCaGis6xheBmCeT2HJK5bJVGa2Ulr1zi1CVE9mtMAvJv1T/cFFTFIsiSnCyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752192017; c=relaxed/simple;
	bh=b2b4cWg2djSkVTYjQ5f4Rk/HVmCESLdHPX2koHFh13M=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=ODZKiLAH4EMHiMZ2KY59Cqc1ghMf/vyVPETYZhogF+TRUrRyBjCcKiIS2JLaIxPhBK2+pupTdD0Tz1DWwZR+Z/NNk2Gnyyk/JCCJNtzlxo/Lo5HIhhrgiAk8coz5OofW/PhKYh9LJckUPiwE5EUNb+QtnOIdPgNzBizRv0HYFcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cjhJu9uv; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752192015; x=1783728015;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=b2b4cWg2djSkVTYjQ5f4Rk/HVmCESLdHPX2koHFh13M=;
  b=cjhJu9uvXL/8Kug4cv0fnRP7EQC2luKHSraeWieb+lXpujX3KW3UPuHE
   8hhCC4jTRQXT9J5C/iMeaGYUocbIO95ZMPYhO2GlYCk2MEHMYvzbg+a6R
   FN17VZnQosuyRS5tylWn5GP5Umq2yRmyI4upXc8quxYzetCZN12giavjg
   vRJ4F7TPEYJ7sY9IpM4XNX/MgReqG5PxiDLJgEdC3cZN06xQDC4VTBRmF
   S+ANtU8rXeHAspnJoVrYv+Qeo9iqeDz8dce44mRKe8E0qpS5Y4jwC9u/G
   VYsmNRBulSVZ6xHCk6Q9TX6Pivqi64GvV6+IOP1Tl3eIW1B/jBZw6LKRZ
   Q==;
X-CSE-ConnectionGUID: LckrRNf+R/OGGrb6A/Y8cA==
X-CSE-MsgGUID: /e5upKnUS1qxj1vIhNiq9A==
X-IronPort-AV: E=McAfee;i="6800,10657,11490"; a="65186190"
X-IronPort-AV: E=Sophos;i="6.16,302,1744095600"; 
   d="scan'208";a="65186190"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2025 17:00:14 -0700
X-CSE-ConnectionGUID: 7zMcqflwQvSe3hZZzeC0sA==
X-CSE-MsgGUID: 1MtURMLPR1ypAcLH3oCXrw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,302,1744095600"; 
   d="scan'208";a="156784220"
Received: from lkp-server01.sh.intel.com (HELO 9ee84586c615) ([10.239.97.150])
  by fmviesa008.fm.intel.com with ESMTP; 10 Jul 2025 17:00:12 -0700
Received: from kbuild by 9ee84586c615 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1ua1BS-0005bo-1t;
	Fri, 11 Jul 2025 00:00:10 +0000
Date: Fri, 11 Jul 2025 07:59:38 +0800
From: kernel test robot <lkp@intel.com>
To: Tor Vic <torvic9@mailbox.org>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-kernel@vger.kernel.org, Ingo Molnar <mingo@kernel.org>
Subject: vmlinux.o: warning: objtool: fat_ioctl_filldir+0x72c: stack state
 mismatch: cfa1=4+168 cfa2=4+160
Message-ID: <202507110734.nbN9j4St-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   bc9ff192a6c940d9a26e21a0a82f2667067aaf5f
commit: ea1dcca1de129dfdf145338a868648bc0e24717c x86/kbuild/64: Add the CONFIG_X86_NATIVE_CPU option to locally optimize the kernel with '-march=native'
date:   4 months ago
config: x86_64-buildonly-randconfig-003-20250711 (https://download.01.org/0day-ci/archive/20250711/202507110734.nbN9j4St-lkp@intel.com/config)
compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250711/202507110734.nbN9j4St-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202507110734.nbN9j4St-lkp@intel.com/

All warnings (new ones prefixed by >>):

   vmlinux.o: warning: objtool: ___bpf_prog_run+0x1e8: sibling call from callable instruction with modified stack frame
>> vmlinux.o: warning: objtool: fat_ioctl_filldir+0x72c: stack state mismatch: cfa1=4+168 cfa2=4+160
   vmlinux.o: warning: objtool: __ubsan_handle_type_mismatch+0xde: call to __msan_memset() with UACCESS enabled
   vmlinux.o: warning: objtool: __ubsan_handle_type_mismatch_v1+0xf3: call to __msan_memset() with UACCESS enabled
   vmlinux.o: warning: objtool: .text.aw_dev_dsp_update_cfg: unexpected end of section

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

