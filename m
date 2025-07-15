Return-Path: <linux-kernel+bounces-732468-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E10CB0671A
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 21:43:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 33DE14E7ACB
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 19:43:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 478D62BE7DF;
	Tue, 15 Jul 2025 19:43:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NrUZv1pk"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BBB28633F
	for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 19:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752608613; cv=none; b=Nswu5rb9V/Y8a8PN6YtOFvsqLvsKTMX6OHxwqmmm2d9dNUmErok+arcsCz+Ncju4Imog6POm4C1oiuafd4avaUl1WOJbG/Bo443i7Lfbte/K4k9Qzx44wPqPsku342KYSBZ2+MGhKYWAQ4oO93kzk1o8xMz9LP/isMt5DSFityc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752608613; c=relaxed/simple;
	bh=/sgVpb/dNcZJDSjr3jnNaUZfH0ZhHlTTgWwp6dw5A9Q=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=ZND0T7UlhwARHqo+JVPCB8Iyjqv0Y+hejpQulWID1JZJRj6kx4hPP+/d/jtduQcHyovNx4Pk+fZbn+vF0exGty9fKeWYEK2iRKuZ6UkfXq0mpCqoGFyMXyM1x65L2EoQnKiWdR+8aYpF4ReQ81j+AbunXeSnb3HbUetVPG2cC+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NrUZv1pk; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752608612; x=1784144612;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=/sgVpb/dNcZJDSjr3jnNaUZfH0ZhHlTTgWwp6dw5A9Q=;
  b=NrUZv1pkoQF3t+aUpG+cCXT8anwDykRsuPVMukFHP32HByLpSXOVfnyH
   SsxmTJ21/80tqusUH1hG1wzebEgNe2su7MEORYTXKqDGAkVcaQcI2yfO8
   MR2YWmFChizZ1EP3b9aqCS60sKHI3ZdYyk6kpfIMoR/83ExjXjt0UTXWv
   Ab1CtI0846zxudjeQw7meH7/3rwdfQmhO4PabE4G6hqJIfYHF9mN4DpdZ
   hLKQkJbuNnyNNnVB/dQFqmOejz9UDKeHzA3gg6d4IlPPj3AVBD1q52y/n
   uwtqoWGI8K3rOf/kpPvHwz6vOHG2nR/73kTdOWY4Dd8XkBsA2i3lOXlHS
   g==;
X-CSE-ConnectionGUID: 6uAm2472RzutoPEitleP0g==
X-CSE-MsgGUID: tqzdaY/fTZKfJBfey8JZKg==
X-IronPort-AV: E=McAfee;i="6800,10657,11493"; a="65103234"
X-IronPort-AV: E=Sophos;i="6.16,314,1744095600"; 
   d="scan'208";a="65103234"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jul 2025 12:43:32 -0700
X-CSE-ConnectionGUID: Lugcj4Y4T+WdN387dk2/wQ==
X-CSE-MsgGUID: CimoqXWpTOype68qOE5ssw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,314,1744095600"; 
   d="scan'208";a="157400477"
Received: from lkp-server01.sh.intel.com (HELO 9ee84586c615) ([10.239.97.150])
  by fmviesa006.fm.intel.com with ESMTP; 15 Jul 2025 12:43:30 -0700
Received: from kbuild by 9ee84586c615 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1ublYm-000BUt-0V;
	Tue, 15 Jul 2025 19:43:28 +0000
Date: Wed, 16 Jul 2025 03:43:00 +0800
From: kernel test robot <lkp@intel.com>
To: Alex Elder <elder@riscstar.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	"Rob Herring (Arm)" <robh@kernel.org>
Subject: arch/mips/boot/dts/qca/ar9132_tl_wr1043nd_v1.dtb: uart@18020000
 (ns8250): clock-names:0: 'core' was expected
Message-ID: <202507160314.wrC51lXX-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   155a3c003e555a7300d156a5252c004c392ec6b0
commit: 2c0594f9f0629a8b4d46e7e1bd069a0bafc2e350 dt-bindings: serial: 8250: support an optional second clock
date:   3 months ago
config: mips-randconfig-051-20250716 (https://download.01.org/0day-ci/archive/20250716/202507160314.wrC51lXX-lkp@intel.com/config)
compiler: clang version 16.0.6 (https://github.com/llvm/llvm-project 7cbf1a2591520c2491aa35339f227775f4d3adf6)
dtschema version: 2025.6.2.dev4+g8f79ddd
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250716/202507160314.wrC51lXX-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202507160314.wrC51lXX-lkp@intel.com/

dtcheck warnings: (new ones prefixed by >>)
   arch/mips/boot/dts/qca/ar9132_tl_wr1043nd_v1.dtb: /: failed to match any schema with compatible: ['tplink,tl-wr1043nd-v1', 'qca,ar9132']
   arch/mips/boot/dts/qca/ar9132_tl_wr1043nd_v1.dtb: /: failed to match any schema with compatible: ['tplink,tl-wr1043nd-v1', 'qca,ar9132']
   arch/mips/boot/dts/qca/ar9132_tl_wr1043nd_v1.dtb: /interrupt-controller: failed to match any schema with compatible: ['qca,ar9132-cpu-intc', 'qca,ar7100-cpu-intc']
   arch/mips/boot/dts/qca/ar9132_tl_wr1043nd_v1.dtb: /interrupt-controller: failed to match any schema with compatible: ['qca,ar9132-cpu-intc', 'qca,ar7100-cpu-intc']
   arch/mips/boot/dts/qca/ar9132_tl_wr1043nd_v1.dtb: uart@18020000 (ns8250): $nodename:0: 'uart@18020000' does not match '^serial(@.*)?$'
   	from schema $id: http://devicetree.org/schemas/serial/8250.yaml#
>> arch/mips/boot/dts/qca/ar9132_tl_wr1043nd_v1.dtb: uart@18020000 (ns8250): clock-names:0: 'core' was expected
   	from schema $id: http://devicetree.org/schemas/serial/8250.yaml#
   arch/mips/boot/dts/qca/ar9132_tl_wr1043nd_v1.dtb: /ahb/apb/gpio@18040000: failed to match any schema with compatible: ['qca,ar9132-gpio', 'qca,ar7100-gpio']
   arch/mips/boot/dts/qca/ar9132_tl_wr1043nd_v1.dtb: /ahb/apb/gpio@18040000: failed to match any schema with compatible: ['qca,ar9132-gpio', 'qca,ar7100-gpio']
   arch/mips/boot/dts/qca/ar9132_tl_wr1043nd_v1.dtb: /ahb/apb/pll-controller@18050000: failed to match any schema with compatible: ['qca,ar9132-pll', 'qca,ar9130-pll']
   arch/mips/boot/dts/qca/ar9132_tl_wr1043nd_v1.dtb: /ahb/apb/pll-controller@18050000: failed to match any schema with compatible: ['qca,ar9132-pll', 'qca,ar9130-pll']
   arch/mips/boot/dts/qca/ar9132_tl_wr1043nd_v1.dtb: wdt@18060008 (qca,ar7130-wdt): $nodename:0: 'wdt@18060008' does not match '^(timer|watchdog)(@.*|-([0-9]|[1-9][0-9]+))?$'
   	from schema $id: http://devicetree.org/schemas/watchdog/qca,ar7130-wdt.yaml#
   arch/mips/boot/dts/qca/ar9132_tl_wr1043nd_v1.dtb: wdt@18060008 (qca,ar7130-wdt): Unevaluated properties are not allowed ('clock-names', 'clocks', 'interrupts' were unexpected)
   	from schema $id: http://devicetree.org/schemas/watchdog/qca,ar7130-wdt.yaml#
   arch/mips/boot/dts/qca/ar9132_tl_wr1043nd_v1.dtb: /ahb/apb/interrupt-controller@18060010: failed to match any schema with compatible: ['qca,ar9132-misc-intc', 'qca,ar7100-misc-intc']

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

