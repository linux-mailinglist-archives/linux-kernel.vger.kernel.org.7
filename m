Return-Path: <linux-kernel+bounces-771865-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 57A42B28C5A
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Aug 2025 11:28:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CF16A3B3EEF
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Aug 2025 09:28:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E92622FDEC;
	Sat, 16 Aug 2025 09:28:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TRWxEgvG"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99ECD634
	for <linux-kernel@vger.kernel.org>; Sat, 16 Aug 2025 09:28:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755336520; cv=none; b=dLKN0MwpzZqkK25hq/KauxY+7SL4TXS5DhZvE5j+/X8lvo6C840TmFaRkpaWDD++IQ5Idfwe+bTQ45rkZxe98ikrXGpyvGLtcjojsEuh52ZybY4vs1RgQUWzdJO+xclLBa6ww/txCCuMlHzmAQIkcyxXZ8VT5xRh9yKFnrEJ2P0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755336520; c=relaxed/simple;
	bh=Rn9UConvvnSANKtYygpj4VC/hkURXLINnkb5ZsYqGlw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Ajr9hmpu97dENQXSeb2VJc8zDywE4yGpU+U2q6Y/iL+wdWaOAAYirm+AMOK22gfDAS97OuGrAvyTOROxgBPmV92UwLUpcB54dpxXhVklMicvuCErhebpB810mXe5Cs/PInkWnT/XCsarNMaH5m00l9SEq7GEQ6zIA4LTXMsYq+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TRWxEgvG; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755336519; x=1786872519;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=Rn9UConvvnSANKtYygpj4VC/hkURXLINnkb5ZsYqGlw=;
  b=TRWxEgvGTORVP55Q30WH/uMSB36MzO7wpqU4SPcubFOriQ8gV+2p7zdH
   2ju1042iRIPGh/rNbEXzM5uU4SiN3avpsrKLAm40bKKbZozcOTLuYULoV
   vbqOsTuFqIN/epoI0ifl79vytseE9mn829/Zmb2fghkxjz74Q652JqALg
   RS4JvlIVJFUonM3MiDY0q8kaGsszpOxpeqOz13wYPWEcHZmPVP9MO9Ati
   nkIVBX/0HEwdEJOQGAP5RztPXCmfHeLJAcsiMlDroSYjxq2x7cqty5jkm
   je/gXTjok4gaFjm6M16m6HB4pqY94YiJPtdZhwKlQt+dJMk56SsCxy5CF
   g==;
X-CSE-ConnectionGUID: sLNYg5iES0GsPUlcYlfkxw==
X-CSE-MsgGUID: yErd5ld3Q1+O7NiDsB9aEQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11523"; a="57353218"
X-IronPort-AV: E=Sophos;i="6.17,293,1747724400"; 
   d="scan'208";a="57353218"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Aug 2025 02:28:38 -0700
X-CSE-ConnectionGUID: 4J00drCaQ5+PqMTVmQOv9g==
X-CSE-MsgGUID: XHhYQworS32YIkR1WP400g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,293,1747724400"; 
   d="scan'208";a="167102001"
Received: from lkp-server02.sh.intel.com (HELO 4ea60e6ab079) ([10.239.97.151])
  by fmviesa006.fm.intel.com with ESMTP; 16 Aug 2025 02:28:36 -0700
Received: from kbuild by 4ea60e6ab079 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1unDDF-000CmW-32;
	Sat, 16 Aug 2025 09:28:33 +0000
Date: Sat, 16 Aug 2025 17:28:29 +0800
From: kernel test robot <lkp@intel.com>
To: =?iso-8859-1?Q?Cl=E9ment_L=E9ger?= <cleger@rivosinc.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Alexandre Ghiti <alexghiti@rivosinc.com>
Subject: mm/maccess.c:41:17: sparse: sparse: incorrect type in argument 2
 (different address spaces)
Message-ID: <202508161713.RWu30Lv1-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   dfd4b508c8c6106083698a0dd5e35aecc7c48725
commit: ca1a66cdd685030738cf077e3955fdedfe39fbb9 riscv: uaccess: do not do misaligned accesses in get/put_user()
date:   2 months ago
config: riscv-randconfig-r122-20250816 (https://download.01.org/0day-ci/archive/20250816/202508161713.RWu30Lv1-lkp@intel.com/config)
compiler: clang version 22.0.0git (https://github.com/llvm/llvm-project 93d24b6b7b148c47a2fa228a4ef31524fa1d9f3f)
reproduce: (https://download.01.org/0day-ci/archive/20250816/202508161713.RWu30Lv1-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202508161713.RWu30Lv1-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
   WARNING: invalid argument to '-march': '_zacas_zabha'
>> mm/maccess.c:41:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const [noderef] __user *from @@     got unsigned long long [usertype] * @@
   mm/maccess.c:41:17: sparse:     expected void const [noderef] __user *from
   mm/maccess.c:41:17: sparse:     got unsigned long long [usertype] *
>> mm/maccess.c:43:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const [noderef] __user *from @@     got unsigned int [usertype] * @@
   mm/maccess.c:43:17: sparse:     expected void const [noderef] __user *from
   mm/maccess.c:43:17: sparse:     got unsigned int [usertype] *
>> mm/maccess.c:45:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const [noderef] __user *from @@     got unsigned short [usertype] * @@
   mm/maccess.c:45:17: sparse:     expected void const [noderef] __user *from
   mm/maccess.c:45:17: sparse:     got unsigned short [usertype] *
>> mm/maccess.c:46:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const [noderef] __user *from @@     got unsigned char [usertype] * @@
   mm/maccess.c:46:9: sparse:     expected void const [noderef] __user *from
   mm/maccess.c:46:9: sparse:     got unsigned char [usertype] *
>> mm/maccess.c:73:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void [noderef] __user *to @@     got unsigned long long [usertype] * @@
   mm/maccess.c:73:17: sparse:     expected void [noderef] __user *to
   mm/maccess.c:73:17: sparse:     got unsigned long long [usertype] *
>> mm/maccess.c:75:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void [noderef] __user *to @@     got unsigned int [usertype] * @@
   mm/maccess.c:75:17: sparse:     expected void [noderef] __user *to
   mm/maccess.c:75:17: sparse:     got unsigned int [usertype] *
>> mm/maccess.c:77:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void [noderef] __user *to @@     got unsigned short [usertype] * @@
   mm/maccess.c:77:17: sparse:     expected void [noderef] __user *to
   mm/maccess.c:77:17: sparse:     got unsigned short [usertype] *
>> mm/maccess.c:78:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void [noderef] __user *to @@     got unsigned char [usertype] * @@
   mm/maccess.c:78:9: sparse:     expected void [noderef] __user *to
   mm/maccess.c:78:9: sparse:     got unsigned char [usertype] *
   mm/maccess.c:98:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const [noderef] __user *from @@     got unsigned char [usertype] * @@
   mm/maccess.c:98:17: sparse:     expected void const [noderef] __user *from
   mm/maccess.c:98:17: sparse:     got unsigned char [usertype] *

vim +41 mm/maccess.c

eab0c6089b6897 Christoph Hellwig    2020-06-08  15  
e4137f08816bbf Sabyrzhan Tasbolatov 2024-10-11  16  /*
e4137f08816bbf Sabyrzhan Tasbolatov 2024-10-11  17   * The below only uses kmsan_check_memory() to ensure uninitialized kernel
e4137f08816bbf Sabyrzhan Tasbolatov 2024-10-11  18   * memory isn't leaked.
e4137f08816bbf Sabyrzhan Tasbolatov 2024-10-11  19   */
fe557319aa06c2 Christoph Hellwig    2020-06-17  20  #define copy_from_kernel_nofault_loop(dst, src, len, type, err_label)	\
b58294ead14cde Christoph Hellwig    2020-06-08  21  	while (len >= sizeof(type)) {					\
b58294ead14cde Christoph Hellwig    2020-06-08  22  		__get_kernel_nofault(dst, src, type, err_label);	\
e4137f08816bbf Sabyrzhan Tasbolatov 2024-10-11  23  		kmsan_check_memory(src, sizeof(type));			\
b58294ead14cde Christoph Hellwig    2020-06-08  24  		dst += sizeof(type);					\
b58294ead14cde Christoph Hellwig    2020-06-08  25  		src += sizeof(type);					\
b58294ead14cde Christoph Hellwig    2020-06-08  26  		len -= sizeof(type);					\
b58294ead14cde Christoph Hellwig    2020-06-08  27  	}
b58294ead14cde Christoph Hellwig    2020-06-08  28  
fe557319aa06c2 Christoph Hellwig    2020-06-17  29  long copy_from_kernel_nofault(void *dst, const void *src, size_t size)
b58294ead14cde Christoph Hellwig    2020-06-08  30  {
2423de2e6f4d86 Arnd Bergmann        2021-08-11  31  	unsigned long align = 0;
2423de2e6f4d86 Arnd Bergmann        2021-08-11  32  
2423de2e6f4d86 Arnd Bergmann        2021-08-11  33  	if (!IS_ENABLED(CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS))
2423de2e6f4d86 Arnd Bergmann        2021-08-11  34  		align = (unsigned long)dst | (unsigned long)src;
2423de2e6f4d86 Arnd Bergmann        2021-08-11  35  
fe557319aa06c2 Christoph Hellwig    2020-06-17  36  	if (!copy_from_kernel_nofault_allowed(src, size))
2a71e81d321987 Christoph Hellwig    2020-06-08  37  		return -ERANGE;
b58294ead14cde Christoph Hellwig    2020-06-08  38  
b58294ead14cde Christoph Hellwig    2020-06-08  39  	pagefault_disable();
2423de2e6f4d86 Arnd Bergmann        2021-08-11  40  	if (!(align & 7))
fe557319aa06c2 Christoph Hellwig    2020-06-17 @41  		copy_from_kernel_nofault_loop(dst, src, size, u64, Efault);
2423de2e6f4d86 Arnd Bergmann        2021-08-11  42  	if (!(align & 3))
fe557319aa06c2 Christoph Hellwig    2020-06-17 @43  		copy_from_kernel_nofault_loop(dst, src, size, u32, Efault);
2423de2e6f4d86 Arnd Bergmann        2021-08-11  44  	if (!(align & 1))
fe557319aa06c2 Christoph Hellwig    2020-06-17 @45  		copy_from_kernel_nofault_loop(dst, src, size, u16, Efault);
fe557319aa06c2 Christoph Hellwig    2020-06-17 @46  	copy_from_kernel_nofault_loop(dst, src, size, u8, Efault);
b58294ead14cde Christoph Hellwig    2020-06-08  47  	pagefault_enable();
b58294ead14cde Christoph Hellwig    2020-06-08  48  	return 0;
b58294ead14cde Christoph Hellwig    2020-06-08  49  Efault:
b58294ead14cde Christoph Hellwig    2020-06-08  50  	pagefault_enable();
b58294ead14cde Christoph Hellwig    2020-06-08  51  	return -EFAULT;
b58294ead14cde Christoph Hellwig    2020-06-08  52  }
fe557319aa06c2 Christoph Hellwig    2020-06-17  53  EXPORT_SYMBOL_GPL(copy_from_kernel_nofault);
b58294ead14cde Christoph Hellwig    2020-06-08  54  
fe557319aa06c2 Christoph Hellwig    2020-06-17  55  #define copy_to_kernel_nofault_loop(dst, src, len, type, err_label)	\
b58294ead14cde Christoph Hellwig    2020-06-08  56  	while (len >= sizeof(type)) {					\
b58294ead14cde Christoph Hellwig    2020-06-08  57  		__put_kernel_nofault(dst, src, type, err_label);	\
e4137f08816bbf Sabyrzhan Tasbolatov 2024-10-11  58  		instrument_write(dst, sizeof(type));			\
b58294ead14cde Christoph Hellwig    2020-06-08  59  		dst += sizeof(type);					\
b58294ead14cde Christoph Hellwig    2020-06-08  60  		src += sizeof(type);					\
b58294ead14cde Christoph Hellwig    2020-06-08  61  		len -= sizeof(type);					\
b58294ead14cde Christoph Hellwig    2020-06-08  62  	}
b58294ead14cde Christoph Hellwig    2020-06-08  63  
fe557319aa06c2 Christoph Hellwig    2020-06-17  64  long copy_to_kernel_nofault(void *dst, const void *src, size_t size)
b58294ead14cde Christoph Hellwig    2020-06-08  65  {
2423de2e6f4d86 Arnd Bergmann        2021-08-11  66  	unsigned long align = 0;
2423de2e6f4d86 Arnd Bergmann        2021-08-11  67  
2423de2e6f4d86 Arnd Bergmann        2021-08-11  68  	if (!IS_ENABLED(CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS))
2423de2e6f4d86 Arnd Bergmann        2021-08-11  69  		align = (unsigned long)dst | (unsigned long)src;
2423de2e6f4d86 Arnd Bergmann        2021-08-11  70  
b58294ead14cde Christoph Hellwig    2020-06-08  71  	pagefault_disable();
2423de2e6f4d86 Arnd Bergmann        2021-08-11  72  	if (!(align & 7))
fe557319aa06c2 Christoph Hellwig    2020-06-17 @73  		copy_to_kernel_nofault_loop(dst, src, size, u64, Efault);
2423de2e6f4d86 Arnd Bergmann        2021-08-11  74  	if (!(align & 3))
fe557319aa06c2 Christoph Hellwig    2020-06-17 @75  		copy_to_kernel_nofault_loop(dst, src, size, u32, Efault);
2423de2e6f4d86 Arnd Bergmann        2021-08-11  76  	if (!(align & 1))
fe557319aa06c2 Christoph Hellwig    2020-06-17 @77  		copy_to_kernel_nofault_loop(dst, src, size, u16, Efault);
fe557319aa06c2 Christoph Hellwig    2020-06-17 @78  	copy_to_kernel_nofault_loop(dst, src, size, u8, Efault);
b58294ead14cde Christoph Hellwig    2020-06-08  79  	pagefault_enable();
b58294ead14cde Christoph Hellwig    2020-06-08  80  	return 0;
b58294ead14cde Christoph Hellwig    2020-06-08  81  Efault:
b58294ead14cde Christoph Hellwig    2020-06-08  82  	pagefault_enable();
b58294ead14cde Christoph Hellwig    2020-06-08  83  	return -EFAULT;
b58294ead14cde Christoph Hellwig    2020-06-08  84  }
ca79a00bb9a899 Sabyrzhan Tasbolatov 2024-10-16  85  EXPORT_SYMBOL_GPL(copy_to_kernel_nofault);
b58294ead14cde Christoph Hellwig    2020-06-08  86  

:::::: The code at line 41 was first introduced by commit
:::::: fe557319aa06c23cffc9346000f119547e0f289a maccess: rename probe_kernel_{read,write} to copy_{from,to}_kernel_nofault

:::::: TO: Christoph Hellwig <hch@lst.de>
:::::: CC: Linus Torvalds <torvalds@linux-foundation.org>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

