Return-Path: <linux-kernel+bounces-879597-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 58B5EC238A4
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 08:24:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F27C83BD439
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 07:24:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64BD732938B;
	Fri, 31 Oct 2025 07:24:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="blLc0mKc"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91BA332937E
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 07:24:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761895475; cv=none; b=R1uGwwLFEKIKD/yKVUdALSzfBVsKwvTnMy9VEToqBuNUKbGf+Y6883AuWJ1V2o/q7ULawdyHJLFexFbUwrVFwo5oUGLAbQrNaUVg3X7+mfIwMiuLr33xhbl2fFbNZqM/cW3ONz3hPaurLyshWZkXrRCbRyerzDSA4sfFwm7Ls9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761895475; c=relaxed/simple;
	bh=etsA7DMDGlHa2EKAk8aJtFmR84OwwPDSpcbJxRX3u8A=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=G1Hr8xm0741/JGO4omgzszo/cACxM0j5PEXQXOlhB5ciOOkmdQPrGhqiEhmYN2Qm2hmlQDh64sLe54cWkQAk76mNu+hLUT0k/65Lq74ER+qoOISKE2fnMTORu416bO91I0bdjSGX6AdNr/gF8EbTOIaOl87shrgfbJNhrRNPbik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=blLc0mKc; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761895474; x=1793431474;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=etsA7DMDGlHa2EKAk8aJtFmR84OwwPDSpcbJxRX3u8A=;
  b=blLc0mKclz9ojMEBIe5UZHZteVdnYh/AL+67C4Zd/M2eUv+hAFY/07+g
   gphfGqoQXbU1sibl2kBHUh6qUVg5OjssCugd6Ns2w9vKh+otF9kx+Q++b
   Lm4foMCm0ZpcR63esrHi1J8rOfHBygaKeB0Ph076kuD00z71FXWCv8wO4
   D9S1TQDVHetLYlYFXmrWo1S4Tsal55XvUTfJqpo9ODlV9a68Z6upMIJY8
   3hHs78hv3Wbqcd9j9d/Iqhw/V/Vii3K4wywnTlhnF45nud48Wdk1kCgRg
   BxmX3ZFfRtAXkMi52l8fSrweg2LVsvBlTBN5avV/ysDrZ0l9k33g4W16X
   Q==;
X-CSE-ConnectionGUID: G/dTK8KHQRiAJqUyW7SUAw==
X-CSE-MsgGUID: +lwTNgSxRyus7/j33WKvqQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11598"; a="86674081"
X-IronPort-AV: E=Sophos;i="6.19,268,1754982000"; 
   d="scan'208";a="86674081"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Oct 2025 00:24:33 -0700
X-CSE-ConnectionGUID: GV4fVGtOQCuFVsCBwLJ7wg==
X-CSE-MsgGUID: 467kVVMGREmynpL71I7SAw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,268,1754982000"; 
   d="scan'208";a="186281757"
Received: from lkp-server02.sh.intel.com (HELO 66d7546c76b2) ([10.239.97.151])
  by orviesa008.jf.intel.com with ESMTP; 31 Oct 2025 00:24:32 -0700
Received: from kbuild by 66d7546c76b2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1vEjUr-000MrI-05;
	Fri, 31 Oct 2025 07:24:29 +0000
Date: Fri, 31 Oct 2025 15:23:43 +0800
From: kernel test robot <lkp@intel.com>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-kernel@vger.kernel.org, x86@kernel.org,
	Peter Zijlstra <peterz@infradead.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [tip:core/rseq 39/42] vmlinux.o: error: objtool:
 irqentry_exit+0x323: call to class_user_rw_access_destructor() with UACCESS
 enabled
Message-ID: <202510311508.2nnmAG7r-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git core/rseq
head:   69c8e3d1610588d677faaa6035e1bd5de9431d6e
commit: 84eeeb00203526c29135d5352833d01e53fc1e16 [39/42] rseq: Switch to fast path processing on exit to user
config: x86_64-randconfig-016-20251031 (https://download.01.org/0day-ci/archive/20251031/202510311508.2nnmAG7r-lkp@intel.com/config)
compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251031/202510311508.2nnmAG7r-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202510311508.2nnmAG7r-lkp@intel.com/

All errors (new ones prefixed by >>):

>> vmlinux.o: error: objtool: irqentry_exit+0x323: call to class_user_rw_access_destructor() with UACCESS enabled
   vmlinux.o: error: objtool: .altinstr_replacement+0x12cc: redundant UACCESS disable
   vmlinux.o: error: objtool: .altinstr_replacement+0x12cf: redundant UACCESS disable

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

