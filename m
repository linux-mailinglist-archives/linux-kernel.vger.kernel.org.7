Return-Path: <linux-kernel+bounces-881889-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 916D5C29271
	for <lists+linux-kernel@lfdr.de>; Sun, 02 Nov 2025 17:39:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0361C188D0A0
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Nov 2025 16:40:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6AC82673BA;
	Sun,  2 Nov 2025 16:39:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UXJWD8gM"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 652EA23B615
	for <linux-kernel@vger.kernel.org>; Sun,  2 Nov 2025 16:39:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762101577; cv=none; b=NeX8wEI13xvmu2hoG68zXllK23R2xD9QCpHZ0ijdkOQhkn9xPMH6WW/ZV2ZcEz6Okezm1udqQ5bN1KY30eM/wOiFmfOLtRby0jF50ae4cD9bzfnJmNkDb+Ig6fSkUgBu/HReovR1lDG2Mqg3jVm1HIXRsrMyK5ZYnMb6SCyjiuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762101577; c=relaxed/simple;
	bh=jpyxDNfZdCNZyktO+9Dc38Cd+dAAumraCzbRRsom1Hs=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=OO0mFWqkombGngKliwUrfe7yezgu/z1FSrVfUZp1DWnzyGvq0cg2lGjDIfVqZgayRrvJUk3U6DXpxxTH3RrhkToNsmofZUrsihVoS+I2BqXWdY4L313YpW4i43ijHwd7tD5mnG+y/8t0pW/MpUEHh1DxghwBstF9GzO80xkGrAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UXJWD8gM; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762101575; x=1793637575;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=jpyxDNfZdCNZyktO+9Dc38Cd+dAAumraCzbRRsom1Hs=;
  b=UXJWD8gMRJ9yia/nM3moRa3mwJ1kV3CSkFnsgKX4LIz72csjCOVBlIcV
   2rD+ROL8dQ/DK+ECtT9NyKnZb9p+Ke5MMxp3W3idPWW6JzTjcskz5YXMf
   gdrkDRERCh5SCSZv5meUR2jgHTiwybCdDIBEK7dBLYCRC4titnHUxUTgI
   5fIfYyfgbC3ZSVCFesRwLv2ewwQHGVJJkAX86QEvzgRmUw9TdiPKc2N18
   UKKSShqcTg8oeF4/qkTvwtlvZH109YHGeNZ7h+v/d9JnnfSZm5izsAMQF
   SrUzfKUPsfSDx8dZ1rv/z0H6fUIBVJ6nGDZGvIn4WdTEjdJF0uBtgYxxA
   A==;
X-CSE-ConnectionGUID: oOWa+4x8SJinMsNl9Oe7CQ==
X-CSE-MsgGUID: dtHAjZCSTpeDEKiCNdXmrQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11601"; a="75542720"
X-IronPort-AV: E=Sophos;i="6.19,274,1754982000"; 
   d="scan'208";a="75542720"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2025 08:39:35 -0800
X-CSE-ConnectionGUID: lWqWAaUiS9movxCgI5iTcg==
X-CSE-MsgGUID: UyVkSAroQkCREhUmWszrHQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,274,1754982000"; 
   d="scan'208";a="210213881"
Received: from lkp-server02.sh.intel.com (HELO 66d7546c76b2) ([10.239.97.151])
  by fmviesa002.fm.intel.com with ESMTP; 02 Nov 2025 08:39:33 -0800
Received: from kbuild by 66d7546c76b2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1vFb2M-000POA-0o;
	Sun, 02 Nov 2025 16:35:51 +0000
Date: Mon, 3 Nov 2025 00:27:09 +0800
From: kernel test robot <lkp@intel.com>
To: Marco Crivellari <marco.crivellari@suse.com>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	"Maciej W. Rozycki" <macro@orcam.me.uk>
Subject: <instantiation>:7:11: error: expected an immediate
Message-ID: <202511030036.kg3v3YEd-lkp@intel.com>
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
head:   691d401c7e0e5ea34ac6f8151bc0696db1b2500a
commit: 56651128e2fbad80f632f388d6bf1f39c928267a MIPS: Fix idle VS timer enqueue
date:   6 months ago
config: mips-gpr_defconfig (https://download.01.org/0day-ci/archive/20251103/202511030036.kg3v3YEd-lkp@intel.com/config)
compiler: clang version 18.1.8 (https://github.com/llvm/llvm-project 3b5b5c1ec4a3095ab096dd780e84d7ab81f3d7ff)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251103/202511030036.kg3v3YEd-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202511030036.kg3v3YEd-lkp@intel.com/

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

