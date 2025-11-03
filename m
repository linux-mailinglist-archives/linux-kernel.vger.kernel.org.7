Return-Path: <linux-kernel+bounces-883763-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C7D9C2E5BE
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 00:02:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E1B10189059A
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 23:03:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D9BF2FD1D0;
	Mon,  3 Nov 2025 23:02:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="icGdeO6b"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1E1623184F
	for <linux-kernel@vger.kernel.org>; Mon,  3 Nov 2025 23:02:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762210957; cv=none; b=aeFp5OUb1/q/n8afpb99sZmkfzI92iz2ajfSpPYwrYHnjE6pjVQ3sozre+Fz8CdV0n2BR+SPnQLHDEgzB+te6ibRNBdG7h+8V9nBJBcDMEo6oljJC2ZukXotiBlKvgiKVYsyYymNsGcdBW7F3CqGQhIzkq1UTvl6JdCFZGK0HkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762210957; c=relaxed/simple;
	bh=ol0xGUVXjreC2pqQIbNikjtDqRI23mUHgPA4ks/7abQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SrH8l/Rf/hFlr09B6yvLaDVSELZDUiIseH8x2vbhFX90oiL1BWwAIePkU7t6bxOu8U9x24a5m54QIVX/MY9xlRgyG34m8d+5lfwlV6UElnKIi97EWcsA1VF3wF8wh4/sXkWQRW/rfo0x8gfwv2YtpC9TGAPyg+7G+K+yXQWhjBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=icGdeO6b; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762210956; x=1793746956;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ol0xGUVXjreC2pqQIbNikjtDqRI23mUHgPA4ks/7abQ=;
  b=icGdeO6bsQKf2OdDASWifHH1K4JIQyQdu6m7Tk23MjzGMXCXgF0kBrBu
   NfImTkfx5YlyKF2z4mf2vrxJsCQN0z9dLhJvF9/yPZkRYhiDbLJZexfMQ
   vqNZ2k6vsbcQGzoI3XPhPacMxIxaZtDMeQsL8v8BksnzrnjrkyPKvr7WA
   /LOuQ2+IEtKlWAld/yBsxpQ/9FKc3RG8WCWwbGte9FIjRy7wdlDm8iHgT
   J6RfqgKH27/BmE84AeOjohGpg3JvX0mp2x9n7mC5GlhEqTRHL8JrL03rr
   8U6QS3mfl5o1wB5TduT3PWe0qSmDKqNglMNKiRvyRvEZy9ldnBrtLwpDn
   g==;
X-CSE-ConnectionGUID: +oXQhmT1TEO4t+8T4t1LDA==
X-CSE-MsgGUID: H/9/GqALSXWlyYTGJPzPCQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11602"; a="51867301"
X-IronPort-AV: E=Sophos;i="6.19,277,1754982000"; 
   d="scan'208";a="51867301"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2025 15:02:35 -0800
X-CSE-ConnectionGUID: 7+tr4xMtR7SwdtQst+rOYw==
X-CSE-MsgGUID: 5wjyYfJsRf6oCa3jYu2VNw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,277,1754982000"; 
   d="scan'208";a="187144068"
Received: from lkp-server02.sh.intel.com (HELO 66d7546c76b2) ([10.239.97.151])
  by orviesa008.jf.intel.com with ESMTP; 03 Nov 2025 15:02:34 -0800
Received: from kbuild by 66d7546c76b2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1vG3Yg-000QbE-0n;
	Mon, 03 Nov 2025 23:02:05 +0000
Date: Tue, 4 Nov 2025 07:00:38 +0800
From: kernel test robot <lkp@intel.com>
To: Heiko Stuebner <heiko@sntech.de>, lee@kernel.org, srini@kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev, heiko@sntech.de,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/2] nvmem: Add driver for the eeprom in qnap-mcu
 controllers
Message-ID: <202511040659.c2R6OqbJ-lkp@intel.com>
References: <20251102163955.294427-2-heiko@sntech.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251102163955.294427-2-heiko@sntech.de>

Hi Heiko,

kernel test robot noticed the following build errors:

[auto build test ERROR on lee-leds/for-leds-next]
[also build test ERROR on lee-mfd/for-mfd-next lee-mfd/for-mfd-fixes linus/master v6.18-rc4 next-20251103]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Heiko-Stuebner/nvmem-Add-driver-for-the-eeprom-in-qnap-mcu-controllers/20251103-004523
base:   https://git.kernel.org/pub/scm/linux/kernel/git/lee/leds.git for-leds-next
patch link:    https://lore.kernel.org/r/20251102163955.294427-2-heiko%40sntech.de
patch subject: [PATCH v3 1/2] nvmem: Add driver for the eeprom in qnap-mcu controllers
config: hexagon-allmodconfig (https://download.01.org/0day-ci/archive/20251104/202511040659.c2R6OqbJ-lkp@intel.com/config)
compiler: clang version 17.0.6 (https://github.com/llvm/llvm-project 6009708b4367171ccdbf4b5905cb6a803753fe18)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251104/202511040659.c2R6OqbJ-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202511040659.c2R6OqbJ-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/nvmem/qnap-mcu-eeprom.c:28:10: error: call to undeclared function 'kzalloc'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
      28 |         reply = kzalloc(bytes + sizeof(cmd), GFP_KERNEL);
         |                 ^
>> drivers/nvmem/qnap-mcu-eeprom.c:28:8: error: incompatible integer to pointer conversion assigning to 'u8 *' (aka 'unsigned char *') from 'int' [-Wint-conversion]
      28 |         reply = kzalloc(bytes + sizeof(cmd), GFP_KERNEL);
         |               ^ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> drivers/nvmem/qnap-mcu-eeprom.c:45:2: error: call to undeclared function 'kfree'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
      45 |         kfree(reply);
         |         ^
   3 errors generated.


vim +/kzalloc +28 drivers/nvmem/qnap-mcu-eeprom.c

    20	
    21	static int qnap_mcu_eeprom_read_block(struct qnap_mcu *mcu, unsigned int offset,
    22					      void *val, size_t bytes)
    23	{
    24		const u8 cmd[] = { 0xf7, 0xa1, offset, bytes };
    25		u8 *reply;
    26		int ret = 0;
    27	
  > 28		reply = kzalloc(bytes + sizeof(cmd), GFP_KERNEL);
    29		if (!reply)
    30			return -ENOMEM;
    31	
    32		ret = qnap_mcu_exec(mcu, cmd, sizeof(cmd), reply, bytes + sizeof(cmd));
    33		if (ret)
    34			goto out;
    35	
    36		/* First bytes must mirror the sent command */
    37		if (memcmp(cmd, reply, sizeof(cmd))) {
    38			ret = -EIO;
    39			goto out;
    40		}
    41	
    42		memcpy(val, reply + sizeof(cmd), bytes);
    43	
    44	out:
  > 45		kfree(reply);
    46		return ret;
    47	}
    48	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

