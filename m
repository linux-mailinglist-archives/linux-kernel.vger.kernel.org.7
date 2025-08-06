Return-Path: <linux-kernel+bounces-757641-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 38695B1C49C
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 13:07:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E3EF118A6D9B
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 11:08:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B369328A72D;
	Wed,  6 Aug 2025 11:07:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Q17CCEQU"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 402B91F3BA9
	for <linux-kernel@vger.kernel.org>; Wed,  6 Aug 2025 11:07:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754478459; cv=none; b=uPQ/LTIGNzGijkFkCjukzNm1AnrXcRM36ZVMIp5tCIc/vZNEQ2PsGOjaz4kXeC5DRSni5tWQxR6ntVrsKzw4+b2KOD+T7AT4PMWSpRZtovXVomFBw7ys3L7k7V3wXJPdGqhPfyBLxBDpxwj9iMBGglPU895S0y8Xbn3ueSw/2AE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754478459; c=relaxed/simple;
	bh=cZS1pffNPCIxdnQpzhHfQ1QRclK26H09sfqRT157YX4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=tKrdeCmuZ2UxZmsl++d94cJdPwbee7qWzzQZ8muXnMjlEW/v5DPCaI5xYkGNYPcpr+LVu6z6kr0PdImW/HiFW84IlX7zJyxfdb5sGZ+cdieB6rN+o84avp0CMKzeaq46rRP917L51bxy10D8xnBocM+lM4SmEkk3ePyk45+2KAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Q17CCEQU; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1754478457; x=1786014457;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=cZS1pffNPCIxdnQpzhHfQ1QRclK26H09sfqRT157YX4=;
  b=Q17CCEQU2RUZhXQw6vCKge5+p1H28ehIk5w1guyCQNqdWTawO9b2FF3i
   5UJ3eJ71STlM5+r0co7n8KUu4YetHa+uKftit2xdZhYD8urHN/87etq91
   4NoQoiKyqFK3O8m10tzdiFtAx3g/tIuNinFlcO37vEHTSmJUqrWO0fyVn
   rqw76Sdrx9s/SVhkWkOPaPPKowTDl74znJbL6KAU8Vyzyiey8INM32pZu
   F8UEY3pAIicuECSvISMxh7H2gVZIF/pKGd0sIXHC89GfN5t5iNQYi6l4r
   /upFw7M7ZY9M1c8e2gNa52aUT6MkpzURfYtjRt8TonvuMgMVfeiZPXMne
   Q==;
X-CSE-ConnectionGUID: USNums3PTBe8iEb0ZBup6g==
X-CSE-MsgGUID: bvWQ1sbuS7+qHTewh7wUhA==
X-IronPort-AV: E=McAfee;i="6800,10657,11513"; a="79340445"
X-IronPort-AV: E=Sophos;i="6.17,268,1747724400"; 
   d="scan'208";a="79340445"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2025 04:07:36 -0700
X-CSE-ConnectionGUID: EUpgbu0VS7WWfTCim3UMlg==
X-CSE-MsgGUID: rZ07HN3EQduzfSpvaOGRYg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,268,1747724400"; 
   d="scan'208";a="165117281"
Received: from lkp-server02.sh.intel.com (HELO 4ea60e6ab079) ([10.239.97.151])
  by fmviesa009.fm.intel.com with ESMTP; 06 Aug 2025 04:07:35 -0700
Received: from kbuild by 4ea60e6ab079 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1ujbzY-0001aS-1I;
	Wed, 06 Aug 2025 11:07:32 +0000
Date: Wed, 6 Aug 2025 19:06:34 +0800
From: kernel test robot <lkp@intel.com>
To: Samuel Holland <samuel.holland@sifive.com>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-kernel@vger.kernel.org, Palmer Dabbelt <palmer@rivosinc.com>,
	Jesse Taube <mr.bossman075@gmail.com>
Subject: ld.lld: error: Function Import: link error: linking module flags
 'Code Model': IDs have conflicting values: 'i32 3' from vmlinux.a(init.o at
 861458), and 'i32 1' from vmlinux.a(net-traces.o at 1004198)
Message-ID: <202508061842.68gt097v-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Samuel,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   479058002c32b77acac43e883b92174e22c4be2d
commit: 2c0391b29b27f315c1b4c29ffde66f50b29fab99 riscv: Allow NOMMU kernels to access all of RAM
date:   4 months ago
config: riscv-randconfig-002-20250806 (https://download.01.org/0day-ci/archive/20250806/202508061842.68gt097v-lkp@intel.com/config)
compiler: clang version 22.0.0git (https://github.com/llvm/llvm-project 8f09b03aebb71c154f3bbe725c29e3f47d37c26e)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250806/202508061842.68gt097v-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202508061842.68gt097v-lkp@intel.com/

All errors (new ones prefixed by >>):

   ld.lld: error: Function Import: link error: linking module flags 'Code Model': IDs have conflicting values: 'i32 3' from vmlinux.a(init.o at 861458), and 'i32 1' from vmlinux.a(trace.o at 871118)
   ld.lld: error: Function Import: link error: linking module flags 'Code Model': IDs have conflicting values: 'i32 3' from vmlinux.a(init.o at 861458), and 'i32 1' from vmlinux.a(memcontrol.o at 876278)
   ld.lld: error: Function Import: link error: linking module flags 'Code Model': IDs have conflicting values: 'i32 3' from vmlinux.a(init.o at 861458), and 'i32 1' from vmlinux.a(mballoc.o at 886958)
>> ld.lld: error: Function Import: link error: linking module flags 'Code Model': IDs have conflicting values: 'i32 3' from vmlinux.a(init.o at 861458), and 'i32 1' from vmlinux.a(net-traces.o at 1004198)
   ld.lld: error: Function Import: link error: linking module flags 'Code Model': IDs have conflicting values: 'i32 3' from vmlinux.a(init.o at 861458), and 'i32 1' from vmlinux.a(tcp.o at 1010198)
   ld.lld: error: Function Import: link error: linking module flags 'Code Model': IDs have conflicting values: 'i32 3' from vmlinux.a(init.o at 861458), and 'i32 1' from vmlinux.a(skbuff.o at 1001978)
   ld.lld: error: Function Import: link error: linking module flags 'Code Model': IDs have conflicting values: 'i32 3' from vmlinux.a(init.o at 861458), and 'i32 1' from vmlinux.a(filter.o at 1003058)
   ld.lld: error: Function Import: link error: linking module flags 'Code Model': IDs have conflicting values: 'i32 3' from vmlinux.a(init.o at 861458), and 'i32 1' from vmlinux.a(core.o at 965138)
   ld.lld: error: Function Import: link error: linking module flags 'Code Model': IDs have conflicting values: 'i32 3' from vmlinux.a(init.o at 861458), and 'i32 1' from vmlinux.a(tun.o at 969458)
   ld.lld: error: Function Import: link error: linking module flags 'Code Model': IDs have conflicting values: 'i32 3' from vmlinux.a(init.o at 861458), and 'i32 1' from vmlinux.a(slub.o at 875858)
   ld.lld: error: Function Import: link error: linking module flags 'Code Model': IDs have conflicting values: 'i32 3' from vmlinux.a(init.o at 861458), and 'i32 1' from vmlinux.a(core.o at 873038)
   ld.lld: error: Function Import: link error: linking module flags 'Code Model': IDs have conflicting values: 'i32 3' from vmlinux.a(init.o at 861458), and 'i32 1' from vmlinux.a(protocol.o at 1029638)
   ld.lld: error: Function Import: link error: linking module flags 'Code Model': IDs have conflicting values: 'i32 3' from vmlinux.a(init.o at 861458), and 'i32 1' from vmlinux.a(inode.o at 886838)
   ld.lld: error: Function Import: link error: linking module flags 'Code Model': IDs have conflicting values: 'i32 3' from vmlinux.a(init.o at 861458), and 'i32 1' from vmlinux.a(vmscan.o at 874418)
   ld.lld: error: Function Import: link error: linking module flags 'Code Model': IDs have conflicting values: 'i32 3' from vmlinux.a(init.o at 861458), and 'i32 1' from vmlinux.a(ip6_output.o at 1014818)
   ld.lld: error: Function Import: link error: linking module flags 'Code Model': IDs have conflicting values: 'i32 3' from vmlinux.a(init.o at 861458), and 'i32 1' from vmlinux.a(blk-mq.o at 912518)
   ld.lld: error: Function Import: link error: linking module flags 'Code Model': IDs have conflicting values: 'i32 3' from vmlinux.a(init.o at 861458), and 'i32 1' from vmlinux.a(tls_sw.o at 1013618)
   ld.lld: error: Function Import: link error: linking module flags 'Code Model': IDs have conflicting values: 'i32 3' from vmlinux.a(init.o at 861458), and 'i32 1' from vmlinux.a(ring_buffer.o at 870998)
   ld.lld: error: Function Import: link error: linking module flags 'Code Model': IDs have conflicting values: 'i32 3' from vmlinux.a(init.o at 861458), and 'i32 1' from vmlinux.a(tcp.o at 965558)
   ld.lld: error: Function Import: link error: linking module flags 'Code Model': IDs have conflicting values: 'i32 3' from vmlinux.a(init.o at 861458), and 'i32 1' from vmlinux.a(journal.o at 888518)
   ld.lld: error: too many errors emitted, stopping now (use --error-limit=0 to see all errors)

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

