Return-Path: <linux-kernel+bounces-882801-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 427C1C2B875
	for <lists+linux-kernel@lfdr.de>; Mon, 03 Nov 2025 12:53:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 788274FAD7C
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 11:47:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE9C8304969;
	Mon,  3 Nov 2025 11:46:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dUwKB64c"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39A2B30596A
	for <linux-kernel@vger.kernel.org>; Mon,  3 Nov 2025 11:46:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762170404; cv=none; b=dD1SUm4q+sTxvAJ1SBqCRcSW+T4wX1Ds4ReGRrDPGXSBZOq0FLEtIAHNy2qwpSxAikYlXmDmqO6v7EUsigft7wNDhjiltXmfMWuIua2ykdclgwoz5Pu38hJEJpVej4F9PhcMWoXuUCcYAPrk/htyjPeIumRLX+yhfGKGhd1Lr5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762170404; c=relaxed/simple;
	bh=YrohOYUDuCTlgYP2vIcXJNugC3ML9XVUo5qBxlQ6SVw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ljl6Kzzj7kCaZ0J5u2LaH9oNJcowPU0+FHkwYuuUUVIVaxt0l1eVa2IJn1t6L7m1Cn7MUvXVulIck0OI0GTLTqLVmoegL9o7HWIX4Qcsx1Rfy+MUs51zIX605L5+iCuzS7x475BxXmcVNU7cNXBZ9/nP3PP9cb+y0vSbgkCtIMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dUwKB64c; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762170403; x=1793706403;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=YrohOYUDuCTlgYP2vIcXJNugC3ML9XVUo5qBxlQ6SVw=;
  b=dUwKB64ctzBcegR/EJsfSHCuGIJmK71IVNVk8aYS+LGPeMX/lXoaYdM2
   VZcA2bSDIdtH6xkJxD/OdmTaDUrdSX08X6y45koMS8eN4udFlrxI0mZPM
   C/nw9t2JaEkhyugwW9IoIB6pUnpPqbgGTUL3K/ZPHi4AFMK9TGh/mx4eP
   dodQAfLyeQjnegRI3N+/pQo5BG3w37Yfr6bbebIxbeL4i84EezWELrq9G
   774vuCU0BK9JnurrAvF7lXlvceVjlg3bd7gYFm6Vw2OZgwW39HRqyyGVu
   7/7qc4PDw9pYPgW3QhJYLFsjBCpPOM9jlhILheK8twwnokY1cOH+Mi1Om
   g==;
X-CSE-ConnectionGUID: diFtPClxTE2iET3bS5Ihyw==
X-CSE-MsgGUID: FR/zi+EJRWyRZJ/af+53oQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11601"; a="75352416"
X-IronPort-AV: E=Sophos;i="6.19,276,1754982000"; 
   d="scan'208";a="75352416"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2025 03:46:42 -0800
X-CSE-ConnectionGUID: /RYqh75jRdGSXQ0M1PBSiw==
X-CSE-MsgGUID: I7zkLZyVQBCJudA3QgITkA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,276,1754982000"; 
   d="scan'208";a="217483653"
Received: from lkp-server02.sh.intel.com (HELO 66d7546c76b2) ([10.239.97.151])
  by orviesa002.jf.intel.com with ESMTP; 03 Nov 2025 03:46:40 -0800
Received: from kbuild by 66d7546c76b2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1vFszp-000Q64-1m;
	Mon, 03 Nov 2025 11:45:24 +0000
Date: Mon, 3 Nov 2025 19:36:57 +0800
From: kernel test robot <lkp@intel.com>
To: Heiko Stuebner <heiko@sntech.de>, lee@kernel.org, srini@kernel.org
Cc: oe-kbuild-all@lists.linux.dev, heiko@sntech.de,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/2] nvmem: Add driver for the eeprom in qnap-mcu
 controllers
Message-ID: <202511031906.3aAxVbZO-lkp@intel.com>
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
config: sh-allmodconfig (https://download.01.org/0day-ci/archive/20251103/202511031906.3aAxVbZO-lkp@intel.com/config)
compiler: sh4-linux-gcc (GCC) 15.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251103/202511031906.3aAxVbZO-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202511031906.3aAxVbZO-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/nvmem/qnap-mcu-eeprom.c: In function 'qnap_mcu_eeprom_read_block':
>> drivers/nvmem/qnap-mcu-eeprom.c:28:17: error: implicit declaration of function 'kzalloc' [-Wimplicit-function-declaration]
      28 |         reply = kzalloc(bytes + sizeof(cmd), GFP_KERNEL);
         |                 ^~~~~~~
>> drivers/nvmem/qnap-mcu-eeprom.c:28:15: error: assignment to 'u8 *' {aka 'unsigned char *'} from 'int' makes pointer from integer without a cast [-Wint-conversion]
      28 |         reply = kzalloc(bytes + sizeof(cmd), GFP_KERNEL);
         |               ^
>> drivers/nvmem/qnap-mcu-eeprom.c:45:9: error: implicit declaration of function 'kfree' [-Wimplicit-function-declaration]
      45 |         kfree(reply);
         |         ^~~~~


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

