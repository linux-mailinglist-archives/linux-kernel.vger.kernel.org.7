Return-Path: <linux-kernel+bounces-755107-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CBFFB1A15F
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 14:25:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 442CD1644C6
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 12:25:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 028C025A2BB;
	Mon,  4 Aug 2025 12:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="V3GIEtPh"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6749258CF2
	for <linux-kernel@vger.kernel.org>; Mon,  4 Aug 2025 12:25:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754310310; cv=none; b=AzyP4hMUBWRWr6rUOR+l1jRfFLOqwMAVkCA6csUVP+1J7ygxBtv0tz9JuawcR2xoQLcPC2P+8garcZ9msaH+BLIm9W6VJoidvILMbOXsTHxqbXfNjULuva4scgE6p53IGiotVRgyC/f2K/nBDKnC4pQl9QSTNYS7rbGratQpdIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754310310; c=relaxed/simple;
	bh=QyObvuBavR8Fp92sAOMcW5VTuwoo0CS0qTgV1RiRtZU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=tBR5DyewLLUoUJCDNYKxHwcMXs9gzCd4TQuz7520VabV6qf6AwhLTHkVA2kSS4vaGSkVxPr4bBDgr5ru++OAx9wrp3j+t8/qD8czP6rs7ZFai36ioLlCWGjY0B9NbluSPDVOEFeODxGNLYq6cxCJvTjxai1d3UTK9rf0pE4e5W4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=V3GIEtPh; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1754310308; x=1785846308;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=QyObvuBavR8Fp92sAOMcW5VTuwoo0CS0qTgV1RiRtZU=;
  b=V3GIEtPhRcWAdUeR7p1NgZTLDrBinqya27ttY2YyyJ0101ePxrH6N0AV
   ScuFbLEh/6Qnr+eUEo8mBYBcfKFRE0wtj6n4xmik/1mDzr1cjvii1sCzq
   3ZO26qTtkSEa5vxmzug7CsQLOGNIkEy/eeXGFXTWC1uDMMDS5kup0s/Pt
   kE4hYeWHpgAYpRbhyBhnzedDKsuyqY8rpzrx88SPs6gtrNXCHPxlRiRp9
   iYPTWXAigg1aAXdNoaFUXNxfB/+R5SpntmlPdpzyhfTR8Ocxs86vl4Kd5
   aw0xRNtzjhXabDrD2c8pDRmQ9hkUNGCbs692yoNWY8PYZMZdPF8HhKSeV
   w==;
X-CSE-ConnectionGUID: meiznveFS8GmN9Uc9XTeyw==
X-CSE-MsgGUID: yMOVKb3CTNWpiURhfImd5w==
X-IronPort-AV: E=McAfee;i="6800,10657,11511"; a="67147520"
X-IronPort-AV: E=Sophos;i="6.17,258,1747724400"; 
   d="scan'208";a="67147520"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2025 05:25:08 -0700
X-CSE-ConnectionGUID: rBByjWjnR0e3j6jk47hCQQ==
X-CSE-MsgGUID: 2R0yHzoZRrWN19wmgOWGIA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,258,1747724400"; 
   d="scan'208";a="194980807"
Received: from igk-lkp-server01.igk.intel.com (HELO b3b7d4258b7c) ([10.91.175.65])
  by fmviesa001.fm.intel.com with ESMTP; 04 Aug 2025 05:25:07 -0700
Received: from kbuild by b3b7d4258b7c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uiuFV-0001n9-00;
	Mon, 04 Aug 2025 12:25:05 +0000
Date: Mon, 4 Aug 2025 14:24:52 +0200
From: kernel test robot <lkp@intel.com>
To: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	"Gustavo A. R. Silva" <gustavo@embeddedor.com>,
	LKML <linux-kernel@vger.kernel.org>
Subject: [gustavoars:testing/wfamnae-next20250804 1/17]
 kernel/bpf/core.c:2612:22: warning: comparison of distinct pointer types
 ('struct bpf_prog_array *' and 'struct bpf_prog_array_hdr *')
Message-ID: <202508041430.BdK5xJ23-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/gustavoars/linux.git testing/wfamnae-next20250804
head:   77e4387959f9cf67aa8d2fa3cae21bdb5670245f
commit: 7c7e69659cdb6b689bfeff088a677871696d5482 [1/17] treewide_some: fix multiple -Wfamnae warnings that must be audited separately
config: x86_64-rhel-9.4-rust (https://download.01.org/0day-ci/archive/20250804/202508041430.BdK5xJ23-lkp@intel.com/config)
compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)
rustc: rustc 1.88.0 (6b00bc388 2025-06-23)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250804/202508041430.BdK5xJ23-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202508041430.BdK5xJ23-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> kernel/bpf/core.c:2612:22: warning: comparison of distinct pointer types ('struct bpf_prog_array *' and 'struct bpf_prog_array_hdr *') [-Wcompare-distinct-pointer-types]
    2612 |         if (!progs || progs == &bpf_empty_prog_array.hdr)
         |                       ~~~~~ ^  ~~~~~~~~~~~~~~~~~~~~~~~~~
   1 warning generated.


vim +2612 kernel/bpf/core.c

8c7dcb84e3b744 Delyan Kratunov 2022-06-14  2609  
8c7dcb84e3b744 Delyan Kratunov 2022-06-14  2610  void bpf_prog_array_free_sleepable(struct bpf_prog_array *progs)
8c7dcb84e3b744 Delyan Kratunov 2022-06-14  2611  {
8c7dcb84e3b744 Delyan Kratunov 2022-06-14 @2612  	if (!progs || progs == &bpf_empty_prog_array.hdr)
8c7dcb84e3b744 Delyan Kratunov 2022-06-14  2613  		return;
8c7dcb84e3b744 Delyan Kratunov 2022-06-14  2614  	call_rcu_tasks_trace(&progs->rcu, __bpf_prog_array_free_sleepable_cb);
8c7dcb84e3b744 Delyan Kratunov 2022-06-14  2615  }
8c7dcb84e3b744 Delyan Kratunov 2022-06-14  2616  

:::::: The code at line 2612 was first introduced by commit
:::::: 8c7dcb84e3b744b2b70baa7a44a9b1881c33a9c9 bpf: implement sleepable uprobes by chaining gps

:::::: TO: Delyan Kratunov <delyank@fb.com>
:::::: CC: Alexei Starovoitov <ast@kernel.org>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

