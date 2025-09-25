Return-Path: <linux-kernel+bounces-831767-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BAE95B9D842
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 08:04:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F0CA57A3512
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 06:02:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99CA72E7BB3;
	Thu, 25 Sep 2025 06:04:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mNkSsCts"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2969A6FC3
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 06:04:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758780248; cv=none; b=Kb6QP2Qkd3l1nIREL4fLhMBDgGdl3qjUAMc9p19SXQcWbLDoTN9kR7gQ0MapXcV6Pqx4ga+5OUbhr8KrpjFvPfAYUhI1cer/qs43Qw38nsxw24pxhwY6wGFDU1mm7qexKaX9eClcfa72kWGP+2mZ2JsY3ZjCvjDoUAkHMFHcN2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758780248; c=relaxed/simple;
	bh=9AovDj4POpGD4NoA6Wyfmp+E+TOIY0KiPUs1Xo8Dwx8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hgk4pTQGsnNjQOSWl68UrWjUbQvcrwx2KOhT9kLXOzndRb0MDdU5cUwKYa4V+2P8m9ZuVMlYVTxVWWl/H17PTnrJCnQ52eVrj/UPHxwKL708Oyx3yH29fe+oGa91lYlLTNqCUFOiq4aKYt4t/NQcyxdSgqjNCNNirDPKy194v80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mNkSsCts; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758780247; x=1790316247;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=9AovDj4POpGD4NoA6Wyfmp+E+TOIY0KiPUs1Xo8Dwx8=;
  b=mNkSsCtsdILQ4TTxM+CeMkSuQNnUpsQPU904OvPWcrczpocAkfUaSz5F
   ZBbY6HINfHQoe6IUxQCxhjD1NpJLTwhppQcLH9byodoIoOcynw9Mg8W8W
   /aeDkCJBkOJ61YHsydqc/1OlOu7ktgX/JItdIkk0V4IY/Jh0l64P++6Fb
   HzU+jYL68zjbC0blA/UGol2cwM4lZxC/5bnsykvMtvWysZ+0pcWX2hRkw
   YERmnaSGv+bqrVBgK/ah+t5A0Vb3PD4p+PzESd9hj5ee25z6bVdKYur1s
   be9hWfvqYc8r2CtcYSG1rCOpBHoJ3ST162nFRf91zHimiD4v7B7Q+Wyfp
   A==;
X-CSE-ConnectionGUID: bYNMjWetSDKDGSC+SbZGng==
X-CSE-MsgGUID: RNIp2pdESVqUek6fgj3lXQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11563"; a="64727230"
X-IronPort-AV: E=Sophos;i="6.18,292,1751266800"; 
   d="scan'208";a="64727230"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Sep 2025 23:03:54 -0700
X-CSE-ConnectionGUID: smpQletMR/SbonHQoq1TZA==
X-CSE-MsgGUID: QeC6jsjxQXam48uCCLmjgg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,291,1751266800"; 
   d="scan'208";a="214371757"
Received: from lkp-server02.sh.intel.com (HELO 84c55410ccf6) ([10.239.97.151])
  by orviesa001.jf.intel.com with ESMTP; 24 Sep 2025 23:03:52 -0700
Received: from kbuild by 84c55410ccf6 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1v1f53-0004xV-1x;
	Thu, 25 Sep 2025 06:03:49 +0000
Date: Thu, 25 Sep 2025 14:03:40 +0800
From: kernel test robot <lkp@intel.com>
To: Heiko Stuebner <heiko@sntech.de>, lee@kernel.org, srini@kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-kernel@vger.kernel.org, heiko@sntech.de
Subject: Re: [PATCH v2 1/2] nvmem: Add driver for the eeprom in qnap-mcu
 controllers
Message-ID: <202509251340.DSObePVn-lkp@intel.com>
References: <20250923131815.1898332-2-heiko@sntech.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250923131815.1898332-2-heiko@sntech.de>

Hi Heiko,

kernel test robot noticed the following build errors:

[auto build test ERROR on lee-leds/for-leds-next]
[also build test ERROR on lee-mfd/for-mfd-next linus/master lee-mfd/for-mfd-fixes v6.17-rc7 next-20250924]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Heiko-Stuebner/nvmem-Add-driver-for-the-eeprom-in-qnap-mcu-controllers/20250923-212052
base:   https://git.kernel.org/pub/scm/linux/kernel/git/lee/leds.git for-leds-next
patch link:    https://lore.kernel.org/r/20250923131815.1898332-2-heiko%40sntech.de
patch subject: [PATCH v2 1/2] nvmem: Add driver for the eeprom in qnap-mcu controllers
config: powerpc-allyesconfig (https://download.01.org/0day-ci/archive/20250925/202509251340.DSObePVn-lkp@intel.com/config)
compiler: clang version 22.0.0git (https://github.com/llvm/llvm-project cafc064fc7a96b3979a023ddae1da2b499d6c954)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250925/202509251340.DSObePVn-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202509251340.DSObePVn-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from <built-in>:3:
   In file included from include/linux/compiler_types.h:171:
   include/linux/compiler-clang.h:28:9: warning: '__SANITIZE_ADDRESS__' macro redefined [-Wmacro-redefined]
      28 | #define __SANITIZE_ADDRESS__
         |         ^
   <built-in>:352:9: note: previous definition is here
     352 | #define __SANITIZE_ADDRESS__ 1
         |         ^
   In file included from drivers/nvmem/qnap-mcu-eeprom.c:12:
   include/linux/mfd/qnap-mcu.h:13:2: error: unknown type name 'u32'
      13 |         u32 baud_rate;
         |         ^
   include/linux/mfd/qnap-mcu.h:17:2: error: unknown type name 'bool'
      17 |         bool usb_led;
         |         ^
   include/linux/mfd/qnap-mcu.h:21:11: error: unknown type name 'u8'
      21 |                   const u8 *cmd_data, size_t cmd_data_size,
         |                         ^
   include/linux/mfd/qnap-mcu.h:21:25: error: unknown type name 'size_t'
      21 |                   const u8 *cmd_data, size_t cmd_data_size,
         |                                       ^
   include/linux/mfd/qnap-mcu.h:22:5: error: unknown type name 'u8'
      22 |                   u8 *reply_data, size_t reply_data_size);
         |                   ^
   include/linux/mfd/qnap-mcu.h:22:21: error: unknown type name 'size_t'
      22 |                   u8 *reply_data, size_t reply_data_size);
         |                                   ^
   include/linux/mfd/qnap-mcu.h:24:13: error: unknown type name 'u8'
      24 |                            const u8 *cmd_data, size_t cmd_data_size);
         |                                  ^
   include/linux/mfd/qnap-mcu.h:24:27: error: unknown type name 'size_t'
      24 |                            const u8 *cmd_data, size_t cmd_data_size);
         |                                                ^
>> drivers/nvmem/qnap-mcu-eeprom.c:28:10: error: call to undeclared function 'kzalloc'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
      28 |         reply = kzalloc(bytes + sizeof(cmd), GFP_KERNEL);
         |                 ^
>> drivers/nvmem/qnap-mcu-eeprom.c:28:8: error: incompatible integer to pointer conversion assigning to 'u8 *' (aka 'unsigned char *') from 'int' [-Wint-conversion]
      28 |         reply = kzalloc(bytes + sizeof(cmd), GFP_KERNEL);
         |               ^ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> drivers/nvmem/qnap-mcu-eeprom.c:45:2: error: call to undeclared function 'kfree'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
      45 |         kfree(reply);
         |         ^
   1 warning and 11 errors generated.


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

