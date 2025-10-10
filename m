Return-Path: <linux-kernel+bounces-848801-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 69104BCE99C
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 23:18:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4C2ED4E5ED8
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 21:18:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3446825C70C;
	Fri, 10 Oct 2025 21:18:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AOo3a5/L"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C59242AA3;
	Fri, 10 Oct 2025 21:18:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760131115; cv=none; b=dqzqT1bH/U2ob+lWWVoZFz+awniGbSt0G5ZkjP1ExCWYIF3p8ojPrOffVyjij0ALHF2xyiyntp0H7pEos4Mdt2lOG1D3qWU4ElXvuFBU3f/+WyEyHFBxJGYwoMm18k0MLiI5Zx5UoxtHnZpVrQTh0+2l3Vm5Kgq1G+wo3vDBS5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760131115; c=relaxed/simple;
	bh=ZB7gTALx625QNqK16XpJCnVnzCKeZXqVUYR+15Tq6Eo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EcVq/Hsb+ru31+Iap8D/i5ej2f32TWFJzWm8NCQVS+F/Ub9oruikGm8sSm0SlOsOTDGTDGvO36s7JMI7ZWoZS6ywU7gRe+lAzJ6XcjxxiBP/dTei6Ome+CWspLhcSRwsZVtQokP6uF/ma31606KZ1ya4bqHACpIMSt8wxNqVPgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AOo3a5/L; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760131113; x=1791667113;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ZB7gTALx625QNqK16XpJCnVnzCKeZXqVUYR+15Tq6Eo=;
  b=AOo3a5/LM8ePuokxOpekkeWfmv18wEKdv6sN6kietaqkJuMM1SX9ypUh
   LQMvHa8f74TrTF7adjs/asuDtIpsiGZ2XZaiWad5ySR6jDc2XaWPqiSuo
   Nt5OnOleWDWrG0IUFA6C4Mh/rO0MBCf8nWEGBDn+91oOB3bsF07dniFsH
   b0y8FotE2QADy3+nZvA55SZL93Q3Qi59n1Hab726qXxNCx0hE3vigEWx1
   cck5FqV0wSmtSAUWU22+5dT5QyFUx2oS/zzy1EZj+rr+C6UI9HW55LhY8
   FHZa3v9Bv3TJXcQwDshMuOc3Avaz3nhinhQp8DG39lwt7uijzQV0k93sN
   w==;
X-CSE-ConnectionGUID: ZlF5GpHJQaewYQxlysOspg==
X-CSE-MsgGUID: da7uLEcVQwCUsZgtvxb1pw==
X-IronPort-AV: E=McAfee;i="6800,10657,11578"; a="62386908"
X-IronPort-AV: E=Sophos;i="6.19,220,1754982000"; 
   d="scan'208";a="62386908"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2025 14:18:31 -0700
X-CSE-ConnectionGUID: fA3MzUJ8R5W/zcSKv2QBPQ==
X-CSE-MsgGUID: rr8eFiMJT5eYgQ8vSm6kFw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,220,1754982000"; 
   d="scan'208";a="180653184"
Received: from lkp-server01.sh.intel.com (HELO 6a630e8620ab) ([10.239.97.150])
  by orviesa009.jf.intel.com with ESMTP; 10 Oct 2025 14:18:26 -0700
Received: from kbuild by 6a630e8620ab with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1v7KVM-0003BB-16;
	Fri, 10 Oct 2025 21:18:24 +0000
Date: Sat, 11 Oct 2025 05:17:56 +0800
From: kernel test robot <lkp@intel.com>
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-mediatek@lists.infradead.org
Cc: oe-kbuild-all@lists.linux.dev, lee@kernel.org, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com, lgirdwood@gmail.com,
	broonie@kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	kernel@collabora.com, wenst@chromium.org,
	igor.belwon@mentallysanemainliners.org
Subject: Re: [PATCH v8 2/9] regulator: Add support for MediaTek MT6316 SPMI
 PMIC Regulators
Message-ID: <202510110504.A2lR6quW-lkp@intel.com>
References: <20251003091158.26748-3-angelogioacchino.delregno@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251003091158.26748-3-angelogioacchino.delregno@collabora.com>

Hi AngeloGioacchino,

kernel test robot noticed the following build errors:

[auto build test ERROR on broonie-regulator/for-next]
[also build test ERROR on lee-mfd/for-mfd-next jic23-iio/togreg lee-leds/for-leds-next lee-mfd/for-mfd-fixes linus/master v6.17 next-20251010]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/AngeloGioacchino-Del-Regno/dt-bindings-regulator-Document-MediaTek-MT6316-PMIC-Regulators/20251003-171606
base:   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next
patch link:    https://lore.kernel.org/r/20251003091158.26748-3-angelogioacchino.delregno%40collabora.com
patch subject: [PATCH v8 2/9] regulator: Add support for MediaTek MT6316 SPMI PMIC Regulators
config: alpha-randconfig-r073-20251009 (https://download.01.org/0day-ci/archive/20251011/202510110504.A2lR6quW-lkp@intel.com/config)
compiler: alpha-linux-gcc (GCC) 11.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251011/202510110504.A2lR6quW-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202510110504.A2lR6quW-lkp@intel.com/

All errors (new ones prefixed by >>):

   `xe_configfs_exit' referenced in section `.data.rel.ro' of drivers/gpu/drm/xe/xe_module.o: defined in discarded section `.exit.text' of drivers/gpu/drm/xe/xe_configfs.o
   alpha-linux-ld: drivers/base/regmap/regmap-spmi.o: in function `regmap_spmi_base_read':
>> drivers/base/regmap/regmap-spmi.c:26:(.text+0x11c): undefined reference to `spmi_register_read'
>> alpha-linux-ld: drivers/base/regmap/regmap-spmi.c:26:(.text+0x124): undefined reference to `spmi_register_read'
   alpha-linux-ld: drivers/base/regmap/regmap-spmi.o: in function `regmap_spmi_base_gather_write':
>> drivers/base/regmap/regmap-spmi.c:46:(.text+0x1f0): undefined reference to `spmi_register_zero_write'
>> alpha-linux-ld: drivers/base/regmap/regmap-spmi.c:46:(.text+0x1f4): undefined reference to `spmi_register_zero_write'
>> alpha-linux-ld: drivers/base/regmap/regmap-spmi.c:56:(.text+0x220): undefined reference to `spmi_register_write'
   alpha-linux-ld: drivers/base/regmap/regmap-spmi.c:56:(.text+0x228): undefined reference to `spmi_register_write'
   alpha-linux-ld: drivers/base/regmap/regmap-spmi.o: in function `regmap_spmi_ext_read':
>> drivers/base/regmap/regmap-spmi.c:124:(.text+0x3f0): undefined reference to `spmi_ext_register_read'
>> alpha-linux-ld: drivers/base/regmap/regmap-spmi.c:124:(.text+0x404): undefined reference to `spmi_ext_register_read'
>> alpha-linux-ld: drivers/base/regmap/regmap-spmi.c:136:(.text+0x444): undefined reference to `spmi_ext_register_readl'
   alpha-linux-ld: drivers/base/regmap/regmap-spmi.c:136:(.text+0x458): undefined reference to `spmi_ext_register_readl'
   alpha-linux-ld: drivers/base/regmap/regmap-spmi.o: in function `regmap_spmi_ext_gather_write':
>> drivers/base/regmap/regmap-spmi.c:164:(.text+0x528): undefined reference to `spmi_ext_register_write'
>> alpha-linux-ld: drivers/base/regmap/regmap-spmi.c:164:(.text+0x53c): undefined reference to `spmi_ext_register_write'
>> alpha-linux-ld: drivers/base/regmap/regmap-spmi.c:176:(.text+0x57c): undefined reference to `spmi_ext_register_writel'
   alpha-linux-ld: drivers/base/regmap/regmap-spmi.c:176:(.text+0x590): undefined reference to `spmi_ext_register_writel'

Kconfig warnings: (for reference only)
   WARNING: unmet direct dependencies detected for REGMAP_SPMI
   Depends on [n]: SPMI [=n]
   Selected by [y]:
   - REGULATOR_MT6316 [=y] && REGULATOR [=y] && (SPMI [=n] || COMPILE_TEST [=y])


vim +26 drivers/base/regmap/regmap-spmi.c

a01779f89fc8a2 Josh Cartwright 2013-10-28   15  
c9afbb05a9ffbe Josh Cartwright 2014-02-12   16  static int regmap_spmi_base_read(void *context,
a01779f89fc8a2 Josh Cartwright 2013-10-28   17  				 const void *reg, size_t reg_size,
a01779f89fc8a2 Josh Cartwright 2013-10-28   18  				 void *val, size_t val_size)
a01779f89fc8a2 Josh Cartwright 2013-10-28   19  {
c9afbb05a9ffbe Josh Cartwright 2014-02-12   20  	u8 addr = *(u8 *)reg;
c9afbb05a9ffbe Josh Cartwright 2014-02-12   21  	int err = 0;
c9afbb05a9ffbe Josh Cartwright 2014-02-12   22  
c9afbb05a9ffbe Josh Cartwright 2014-02-12   23  	BUG_ON(reg_size != 1);
c9afbb05a9ffbe Josh Cartwright 2014-02-12   24  
c9afbb05a9ffbe Josh Cartwright 2014-02-12   25  	while (val_size-- && !err)
c9afbb05a9ffbe Josh Cartwright 2014-02-12  @26  		err = spmi_register_read(context, addr++, val++);
c9afbb05a9ffbe Josh Cartwright 2014-02-12   27  
c9afbb05a9ffbe Josh Cartwright 2014-02-12   28  	return err;
c9afbb05a9ffbe Josh Cartwright 2014-02-12   29  }
c9afbb05a9ffbe Josh Cartwright 2014-02-12   30  
c9afbb05a9ffbe Josh Cartwright 2014-02-12   31  static int regmap_spmi_base_gather_write(void *context,
c9afbb05a9ffbe Josh Cartwright 2014-02-12   32  					 const void *reg, size_t reg_size,
c9afbb05a9ffbe Josh Cartwright 2014-02-12   33  					 const void *val, size_t val_size)
c9afbb05a9ffbe Josh Cartwright 2014-02-12   34  {
c9afbb05a9ffbe Josh Cartwright 2014-02-12   35  	const u8 *data = val;
c9afbb05a9ffbe Josh Cartwright 2014-02-12   36  	u8 addr = *(u8 *)reg;
c9afbb05a9ffbe Josh Cartwright 2014-02-12   37  	int err = 0;
c9afbb05a9ffbe Josh Cartwright 2014-02-12   38  
c9afbb05a9ffbe Josh Cartwright 2014-02-12   39  	BUG_ON(reg_size != 1);
c9afbb05a9ffbe Josh Cartwright 2014-02-12   40  
c9afbb05a9ffbe Josh Cartwright 2014-02-12   41  	/*
c9afbb05a9ffbe Josh Cartwright 2014-02-12   42  	 * SPMI defines a more bandwidth-efficient 'Register 0 Write' sequence,
c9afbb05a9ffbe Josh Cartwright 2014-02-12   43  	 * use it when possible.
c9afbb05a9ffbe Josh Cartwright 2014-02-12   44  	 */
c9afbb05a9ffbe Josh Cartwright 2014-02-12   45  	if (addr == 0 && val_size) {
c9afbb05a9ffbe Josh Cartwright 2014-02-12  @46  		err = spmi_register_zero_write(context, *data);
c9afbb05a9ffbe Josh Cartwright 2014-02-12   47  		if (err)
c9afbb05a9ffbe Josh Cartwright 2014-02-12   48  			goto err_out;
c9afbb05a9ffbe Josh Cartwright 2014-02-12   49  
c9afbb05a9ffbe Josh Cartwright 2014-02-12   50  		data++;
c9afbb05a9ffbe Josh Cartwright 2014-02-12   51  		addr++;
c9afbb05a9ffbe Josh Cartwright 2014-02-12   52  		val_size--;
c9afbb05a9ffbe Josh Cartwright 2014-02-12   53  	}
c9afbb05a9ffbe Josh Cartwright 2014-02-12   54  
c9afbb05a9ffbe Josh Cartwright 2014-02-12   55  	while (val_size) {
c9afbb05a9ffbe Josh Cartwright 2014-02-12  @56  		err = spmi_register_write(context, addr, *data);
c9afbb05a9ffbe Josh Cartwright 2014-02-12   57  		if (err)
c9afbb05a9ffbe Josh Cartwright 2014-02-12   58  			goto err_out;
c9afbb05a9ffbe Josh Cartwright 2014-02-12   59  
c9afbb05a9ffbe Josh Cartwright 2014-02-12   60  		data++;
c9afbb05a9ffbe Josh Cartwright 2014-02-12   61  		addr++;
c9afbb05a9ffbe Josh Cartwright 2014-02-12   62  		val_size--;
c9afbb05a9ffbe Josh Cartwright 2014-02-12   63  	}
c9afbb05a9ffbe Josh Cartwright 2014-02-12   64  
c9afbb05a9ffbe Josh Cartwright 2014-02-12   65  err_out:
c9afbb05a9ffbe Josh Cartwright 2014-02-12   66  	return err;
c9afbb05a9ffbe Josh Cartwright 2014-02-12   67  }
c9afbb05a9ffbe Josh Cartwright 2014-02-12   68  
c9afbb05a9ffbe Josh Cartwright 2014-02-12   69  static int regmap_spmi_base_write(void *context, const void *data,
c9afbb05a9ffbe Josh Cartwright 2014-02-12   70  				  size_t count)
c9afbb05a9ffbe Josh Cartwright 2014-02-12   71  {
c9afbb05a9ffbe Josh Cartwright 2014-02-12   72  	BUG_ON(count < 1);
c9afbb05a9ffbe Josh Cartwright 2014-02-12   73  	return regmap_spmi_base_gather_write(context, data, 1, data + 1,
c9afbb05a9ffbe Josh Cartwright 2014-02-12   74  					     count - 1);
c9afbb05a9ffbe Josh Cartwright 2014-02-12   75  }
c9afbb05a9ffbe Josh Cartwright 2014-02-12   76  
9c2e5cb38da220 Julia Lawall    2017-08-11   77  static const struct regmap_bus regmap_spmi_base = {
c9afbb05a9ffbe Josh Cartwright 2014-02-12   78  	.read				= regmap_spmi_base_read,
c9afbb05a9ffbe Josh Cartwright 2014-02-12   79  	.write				= regmap_spmi_base_write,
c9afbb05a9ffbe Josh Cartwright 2014-02-12   80  	.gather_write			= regmap_spmi_base_gather_write,
c9afbb05a9ffbe Josh Cartwright 2014-02-12   81  	.reg_format_endian_default	= REGMAP_ENDIAN_NATIVE,
c9afbb05a9ffbe Josh Cartwright 2014-02-12   82  	.val_format_endian_default	= REGMAP_ENDIAN_NATIVE,
c9afbb05a9ffbe Josh Cartwright 2014-02-12   83  };
c9afbb05a9ffbe Josh Cartwright 2014-02-12   84  
3cfe7a74d42b7e Nicolas Boichat 2015-07-08   85  struct regmap *__regmap_init_spmi_base(struct spmi_device *sdev,
3cfe7a74d42b7e Nicolas Boichat 2015-07-08   86  				       const struct regmap_config *config,
3cfe7a74d42b7e Nicolas Boichat 2015-07-08   87  				       struct lock_class_key *lock_key,
3cfe7a74d42b7e Nicolas Boichat 2015-07-08   88  				       const char *lock_name)
c9afbb05a9ffbe Josh Cartwright 2014-02-12   89  {
3cfe7a74d42b7e Nicolas Boichat 2015-07-08   90  	return __regmap_init(&sdev->dev, &regmap_spmi_base, sdev, config,
3cfe7a74d42b7e Nicolas Boichat 2015-07-08   91  			     lock_key, lock_name);
c9afbb05a9ffbe Josh Cartwright 2014-02-12   92  }
3cfe7a74d42b7e Nicolas Boichat 2015-07-08   93  EXPORT_SYMBOL_GPL(__regmap_init_spmi_base);
c9afbb05a9ffbe Josh Cartwright 2014-02-12   94  
3cfe7a74d42b7e Nicolas Boichat 2015-07-08   95  struct regmap *__devm_regmap_init_spmi_base(struct spmi_device *sdev,
3cfe7a74d42b7e Nicolas Boichat 2015-07-08   96  					    const struct regmap_config *config,
3cfe7a74d42b7e Nicolas Boichat 2015-07-08   97  					    struct lock_class_key *lock_key,
3cfe7a74d42b7e Nicolas Boichat 2015-07-08   98  					    const char *lock_name)
c9afbb05a9ffbe Josh Cartwright 2014-02-12   99  {
3cfe7a74d42b7e Nicolas Boichat 2015-07-08  100  	return __devm_regmap_init(&sdev->dev, &regmap_spmi_base, sdev, config,
3cfe7a74d42b7e Nicolas Boichat 2015-07-08  101  				  lock_key, lock_name);
c9afbb05a9ffbe Josh Cartwright 2014-02-12  102  }
3cfe7a74d42b7e Nicolas Boichat 2015-07-08  103  EXPORT_SYMBOL_GPL(__devm_regmap_init_spmi_base);
c9afbb05a9ffbe Josh Cartwright 2014-02-12  104  
c9afbb05a9ffbe Josh Cartwright 2014-02-12  105  static int regmap_spmi_ext_read(void *context,
c9afbb05a9ffbe Josh Cartwright 2014-02-12  106  				const void *reg, size_t reg_size,
c9afbb05a9ffbe Josh Cartwright 2014-02-12  107  				void *val, size_t val_size)
c9afbb05a9ffbe Josh Cartwright 2014-02-12  108  {
c9afbb05a9ffbe Josh Cartwright 2014-02-12  109  	int err = 0;
c9afbb05a9ffbe Josh Cartwright 2014-02-12  110  	size_t len;
c9afbb05a9ffbe Josh Cartwright 2014-02-12  111  	u16 addr;
c9afbb05a9ffbe Josh Cartwright 2014-02-12  112  
a01779f89fc8a2 Josh Cartwright 2013-10-28  113  	BUG_ON(reg_size != 2);
c9afbb05a9ffbe Josh Cartwright 2014-02-12  114  
c9afbb05a9ffbe Josh Cartwright 2014-02-12  115  	addr = *(u16 *)reg;
c9afbb05a9ffbe Josh Cartwright 2014-02-12  116  
c9afbb05a9ffbe Josh Cartwright 2014-02-12  117  	/*
c9afbb05a9ffbe Josh Cartwright 2014-02-12  118  	 * Split accesses into two to take advantage of the more
c9afbb05a9ffbe Josh Cartwright 2014-02-12  119  	 * bandwidth-efficient 'Extended Register Read' command when possible
c9afbb05a9ffbe Josh Cartwright 2014-02-12  120  	 */
c9afbb05a9ffbe Josh Cartwright 2014-02-12  121  	while (addr <= 0xFF && val_size) {
c9afbb05a9ffbe Josh Cartwright 2014-02-12  122  		len = min_t(size_t, val_size, 16);
c9afbb05a9ffbe Josh Cartwright 2014-02-12  123  
c9afbb05a9ffbe Josh Cartwright 2014-02-12 @124  		err = spmi_ext_register_read(context, addr, val, len);
c9afbb05a9ffbe Josh Cartwright 2014-02-12  125  		if (err)
c9afbb05a9ffbe Josh Cartwright 2014-02-12  126  			goto err_out;
c9afbb05a9ffbe Josh Cartwright 2014-02-12  127  
c9afbb05a9ffbe Josh Cartwright 2014-02-12  128  		addr += len;
c9afbb05a9ffbe Josh Cartwright 2014-02-12  129  		val += len;
c9afbb05a9ffbe Josh Cartwright 2014-02-12  130  		val_size -= len;
a01779f89fc8a2 Josh Cartwright 2013-10-28  131  	}
a01779f89fc8a2 Josh Cartwright 2013-10-28  132  
c9afbb05a9ffbe Josh Cartwright 2014-02-12  133  	while (val_size) {
c9afbb05a9ffbe Josh Cartwright 2014-02-12  134  		len = min_t(size_t, val_size, 8);
c9afbb05a9ffbe Josh Cartwright 2014-02-12  135  
dec8e8f6e6504a Jack Pham       2016-04-14 @136  		err = spmi_ext_register_readl(context, addr, val, len);
c9afbb05a9ffbe Josh Cartwright 2014-02-12  137  		if (err)
c9afbb05a9ffbe Josh Cartwright 2014-02-12  138  			goto err_out;
c9afbb05a9ffbe Josh Cartwright 2014-02-12  139  
c9afbb05a9ffbe Josh Cartwright 2014-02-12  140  		addr += len;
c9afbb05a9ffbe Josh Cartwright 2014-02-12  141  		val += len;
c9afbb05a9ffbe Josh Cartwright 2014-02-12  142  		val_size -= len;
c9afbb05a9ffbe Josh Cartwright 2014-02-12  143  	}
c9afbb05a9ffbe Josh Cartwright 2014-02-12  144  
c9afbb05a9ffbe Josh Cartwright 2014-02-12  145  err_out:
c9afbb05a9ffbe Josh Cartwright 2014-02-12  146  	return err;
c9afbb05a9ffbe Josh Cartwright 2014-02-12  147  }
c9afbb05a9ffbe Josh Cartwright 2014-02-12  148  
c9afbb05a9ffbe Josh Cartwright 2014-02-12  149  static int regmap_spmi_ext_gather_write(void *context,
a01779f89fc8a2 Josh Cartwright 2013-10-28  150  					const void *reg, size_t reg_size,
a01779f89fc8a2 Josh Cartwright 2013-10-28  151  					const void *val, size_t val_size)
a01779f89fc8a2 Josh Cartwright 2013-10-28  152  {
c9afbb05a9ffbe Josh Cartwright 2014-02-12  153  	int err = 0;
c9afbb05a9ffbe Josh Cartwright 2014-02-12  154  	size_t len;
c9afbb05a9ffbe Josh Cartwright 2014-02-12  155  	u16 addr;
c9afbb05a9ffbe Josh Cartwright 2014-02-12  156  
a01779f89fc8a2 Josh Cartwright 2013-10-28  157  	BUG_ON(reg_size != 2);
c9afbb05a9ffbe Josh Cartwright 2014-02-12  158  
c9afbb05a9ffbe Josh Cartwright 2014-02-12  159  	addr = *(u16 *)reg;
c9afbb05a9ffbe Josh Cartwright 2014-02-12  160  
c9afbb05a9ffbe Josh Cartwright 2014-02-12  161  	while (addr <= 0xFF && val_size) {
c9afbb05a9ffbe Josh Cartwright 2014-02-12  162  		len = min_t(size_t, val_size, 16);
c9afbb05a9ffbe Josh Cartwright 2014-02-12  163  
c9afbb05a9ffbe Josh Cartwright 2014-02-12 @164  		err = spmi_ext_register_write(context, addr, val, len);
c9afbb05a9ffbe Josh Cartwright 2014-02-12  165  		if (err)
c9afbb05a9ffbe Josh Cartwright 2014-02-12  166  			goto err_out;
c9afbb05a9ffbe Josh Cartwright 2014-02-12  167  
c9afbb05a9ffbe Josh Cartwright 2014-02-12  168  		addr += len;
c9afbb05a9ffbe Josh Cartwright 2014-02-12  169  		val += len;
c9afbb05a9ffbe Josh Cartwright 2014-02-12  170  		val_size -= len;
a01779f89fc8a2 Josh Cartwright 2013-10-28  171  	}
a01779f89fc8a2 Josh Cartwright 2013-10-28  172  
c9afbb05a9ffbe Josh Cartwright 2014-02-12  173  	while (val_size) {
c9afbb05a9ffbe Josh Cartwright 2014-02-12  174  		len = min_t(size_t, val_size, 8);
c9afbb05a9ffbe Josh Cartwright 2014-02-12  175  
c9afbb05a9ffbe Josh Cartwright 2014-02-12 @176  		err = spmi_ext_register_writel(context, addr, val, len);
c9afbb05a9ffbe Josh Cartwright 2014-02-12  177  		if (err)
c9afbb05a9ffbe Josh Cartwright 2014-02-12  178  			goto err_out;
c9afbb05a9ffbe Josh Cartwright 2014-02-12  179  
c9afbb05a9ffbe Josh Cartwright 2014-02-12  180  		addr += len;
c9afbb05a9ffbe Josh Cartwright 2014-02-12  181  		val += len;
c9afbb05a9ffbe Josh Cartwright 2014-02-12  182  		val_size -= len;
c9afbb05a9ffbe Josh Cartwright 2014-02-12  183  	}
c9afbb05a9ffbe Josh Cartwright 2014-02-12  184  
c9afbb05a9ffbe Josh Cartwright 2014-02-12  185  err_out:
c9afbb05a9ffbe Josh Cartwright 2014-02-12  186  	return err;
c9afbb05a9ffbe Josh Cartwright 2014-02-12  187  }
c9afbb05a9ffbe Josh Cartwright 2014-02-12  188  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

