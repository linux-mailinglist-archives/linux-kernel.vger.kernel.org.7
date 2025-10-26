Return-Path: <linux-kernel+bounces-870172-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 53407C0A19C
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Oct 2025 02:17:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 305F84E3E9E
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Oct 2025 01:17:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7AFF18A921;
	Sun, 26 Oct 2025 01:16:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="autz9QPF"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 645537260F
	for <linux-kernel@vger.kernel.org>; Sun, 26 Oct 2025 01:16:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761441419; cv=none; b=OUsVKkABPF96FK5XGnK4tIFEIoJRjI/2PVgQXqRte+v5P4yjbhwECvqkjatJSltL+FFXJA1zVx5HwHJKIdsvhOgeKklkpcew81tD7OpMZTqNLd6Vu2me8QsMkHXwgp3Wt5HDnmUuUhil5MUM5m+YkLOAYgstGqhU7b6rgIEc58Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761441419; c=relaxed/simple;
	bh=Ct1CXD4NNcHfQwDoTIcp7uvzzrN4lQdH7Tm9n5lMwq4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=M4+d53XwvgyDGvRe7HKp9ui0xejEtcjReWBWXZKD0+gNB8I2f9/K2Pd4vK1VuVFMCjE2girI5DTVEvR2OZsjIIH/wTmldd16qgksgMvAjJ5/pQVBe9+WfmeRJAU3tChIzj/Cb44vm5F9FhWpq/MH5T06pty8Xuok99xOQx0xZ4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=autz9QPF; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761441417; x=1792977417;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=Ct1CXD4NNcHfQwDoTIcp7uvzzrN4lQdH7Tm9n5lMwq4=;
  b=autz9QPF8TsIF+dgkZjvqVhdvjjhBx+XGuBJkeNXx3G7wZhkDq8nNEZf
   5WjF38VEeY7zhPWmGd+Yvcb+/D1UA+N7Y7guayZaKTL0C1k+X8+cm0QOf
   VOD/qAmLmx3YtxxLgrYBrsT7UPI4hLdFCxtdOPsLrztnDK/NyfXx5OxyW
   +ID7w88dKFyXwor4S14OwCQZGOdS2PIJKValvbOpJ/QbNk+fQrs8VmEfP
   au/+0q8sXK0oehOyBrpxbJMxA13CyDk5gN4UCTzoFjcEz9CCUwKkTZa6S
   A8sa/Lurr84C77ydaJFK+9NdSFpDM2eDGbNjxr8rgVOpgN3F3GU4zUyNh
   A==;
X-CSE-ConnectionGUID: GXC+Vj99Szqj8dPTlXU7OA==
X-CSE-MsgGUID: E4FjV9EXQZS2s9coXvElyQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="62598844"
X-IronPort-AV: E=Sophos;i="6.19,255,1754982000"; 
   d="scan'208";a="62598844"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2025 18:16:56 -0700
X-CSE-ConnectionGUID: WsfUfZU1R6aYkY7Qxg84fw==
X-CSE-MsgGUID: ZZj6Iv/ATVWneOzhdr69/Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,255,1754982000"; 
   d="scan'208";a="189037789"
Received: from lkp-server02.sh.intel.com (HELO 66d7546c76b2) ([10.239.97.151])
  by orviesa004.jf.intel.com with ESMTP; 25 Oct 2025 18:16:55 -0700
Received: from kbuild by 66d7546c76b2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1vCpNN-000Flv-0k;
	Sun, 26 Oct 2025 01:16:53 +0000
Date: Sun, 26 Oct 2025 09:16:45 +0800
From: kernel test robot <lkp@intel.com>
To: Marco Crivellari <marco.crivellari@suse.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	"Maciej W. Rozycki" <macro@orcam.me.uk>
Subject: <instantiation>:7:11: error: expected an immediate
Message-ID: <202510260931.TWOAuaL6-lkp@intel.com>
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
head:   72761a7e31225971d0b29d9195e0ffa986b77867
commit: 56651128e2fbad80f632f388d6bf1f39c928267a MIPS: Fix idle VS timer enqueue
date:   6 months ago
config: mips-randconfig-r054-20251026 (https://download.01.org/0day-ci/archive/20251026/202510260931.TWOAuaL6-lkp@intel.com/config)
compiler: clang version 16.0.6 (https://github.com/llvm/llvm-project 7cbf1a2591520c2491aa35339f227775f4d3adf6)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251026/202510260931.TWOAuaL6-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202510260931.TWOAuaL6-lkp@intel.com/

All errors (new ones prefixed by >>):

>> <instantiation>:7:11: error: expected an immediate
    ori $26, r4k_wait_idle_size - 2
             ^
   <instantiation>:10:14: error: expected an immediate
    daddiu $26, r4k_wait_exit - r4k_wait_insn + 2
                ^
   <instantiation>:10:30: error: expected an immediate
    daddiu $26, r4k_wait_exit - r4k_wait_insn + 2
                                ^
>> <instantiation>:7:11: error: expected an immediate
    ori $26, r4k_wait_idle_size - 2
             ^
   <instantiation>:10:14: error: expected an immediate
    daddiu $26, r4k_wait_exit - r4k_wait_insn + 2
                ^
   <instantiation>:10:30: error: expected an immediate
    daddiu $26, r4k_wait_exit - r4k_wait_insn + 2
                                ^

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

