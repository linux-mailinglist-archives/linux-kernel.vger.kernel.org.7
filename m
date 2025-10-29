Return-Path: <linux-kernel+bounces-875110-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EB57C183AF
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 05:21:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 26628420CF0
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 04:21:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3EC12F5478;
	Wed, 29 Oct 2025 04:21:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Bk3CgiKM"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56C632F5463
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 04:21:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761711673; cv=none; b=B78LV1VH+A1FkPfUBjjV4JeIUu8TJOB0KHLkrjEAAXnu54ktAN1nqps+MvZztfFqDvAo1iP2CZ/rzKwH6cjXOR0Vl0bonW2rrGHYIGzFB0ycf0CBpYTR/plnx3GRKPQF/tta1iSl6LIARi7eg6Nsv/aFHPJ6Zi0FZ4awXXrCTWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761711673; c=relaxed/simple;
	bh=k92QA5za9+f78U5qrvozAswYIELUsEv9BnnrIg10L/I=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=nQj+BM+Vsq+Nfqb/C6EU2l32SARNPKTRQjxN+2/mUDTsE9JG+LsoGXtJ79tAJqdvchwuiX4yCx3Y43pHVRVQoM9NFRnBtz/Z3AC6GgXElz0LRkcdRbcP85+/CTUpqARsPucWTXszJYNbLLvuMgqvpw4Wxm7xYit6PGlMx4hbEtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Bk3CgiKM; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761711671; x=1793247671;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=k92QA5za9+f78U5qrvozAswYIELUsEv9BnnrIg10L/I=;
  b=Bk3CgiKMwjoa99bUAgFgjgF8QjYGqGi2DOgu1WkaqDZ2RNRQ83x5pinz
   mMViTQPe36bKlORByGrVwsw5i79vCqcNVoEAmvFox+M1xg5PYeH5W77D0
   Ww7+1mc+BcooNhHnJDAjnjBT25wzGJU/CvA7ORA/632dD+1xHOivPiR/2
   L7orWmkat1cyCVckwfCJNprGd5U18x6gr2sR0UaSOQuA8F8tmRbV76apQ
   u8ksTLWgo1kCOFHuxF2Qyhj1+Ua8O7c6xyN+uBLZ/dkWj7zLrmKrctbQJ
   WPz0jl5L6uiAOPzdoUcLkWg412szdOqNjNTuyG1uLo5zeQH9t478YFS9b
   w==;
X-CSE-ConnectionGUID: O0XQlBPmSB2406ImViRCLQ==
X-CSE-MsgGUID: xkYsjPM6TZ+u04Mw2uYKIQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="81243996"
X-IronPort-AV: E=Sophos;i="6.19,263,1754982000"; 
   d="scan'208";a="81243996"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2025 21:21:11 -0700
X-CSE-ConnectionGUID: zkABTT1EQqWwOKetxsdjCA==
X-CSE-MsgGUID: lHSFdfJrSdCTiq++m50U8A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,263,1754982000"; 
   d="scan'208";a="185177781"
Received: from igk-lkp-server01.igk.intel.com (HELO c2fcd27ee2f4) ([10.211.93.152])
  by orviesa009.jf.intel.com with ESMTP; 28 Oct 2025 21:21:09 -0700
Received: from kbuild by c2fcd27ee2f4 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vDxgJ-000000000s8-1a82;
	Wed, 29 Oct 2025 04:21:07 +0000
Date: Wed, 29 Oct 2025 05:20:58 +0100
From: kernel test robot <lkp@intel.com>
To: "Rob Herring (Arm)" <robh@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: arch/nios2/boot/dts/10m50_devboard.dtb: gpio@180014d0
 (altr,pio-1.0): 'oneOf' conditional failed, one must be fixed:
Message-ID: <202510290539.UPoG7YbJ-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   e53642b87a4f4b03a8d7e5f8507fc3cd0c595ea6
commit: 695f375b2a881544d112edbb60a35a884c7604ae dt-bindings: gpio: Convert altr,pio-1.0 to DT schema
date:   3 months ago
config: nios2-randconfig-2052-20251024 (https://download.01.org/0day-ci/archive/20251029/202510290539.UPoG7YbJ-lkp@intel.com/config)
compiler: nios2-linux-gcc (GCC) 11.5.0
dtschema version: 2025.9.dev12+gd6be03029
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251029/202510290539.UPoG7YbJ-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202510290539.UPoG7YbJ-lkp@intel.com/

dtcheck warnings: (new ones prefixed by >>)
   arch/nios2/boot/dts/10m50_devboard.dtb: ethernet@400 (altr,tse-msgdma-1.0): reg-names:3: 's1' was expected
   	from schema $id: http://devicetree.org/schemas/net/altr,tse.yaml
   arch/nios2/boot/dts/10m50_devboard.dtb: ethernet@400 (altr,tse-msgdma-1.0): reg-names: ['control_port', 'rx_csr', 'rx_desc', 'rx_resp', 'tx_csr', 'tx_desc'] is too long
   	from schema $id: http://devicetree.org/schemas/net/altr,tse.yaml
   arch/nios2/boot/dts/10m50_devboard.dtb: ethernet@400 (altr,tse-msgdma-1.0): compatible: ['altr,tse-msgdma-1.0', 'altr,tse-1.0'] is too long
   	from schema $id: http://devicetree.org/schemas/net/altr,tse.yaml
   arch/nios2/boot/dts/10m50_devboard.dtb: ethernet@400 (altr,tse-msgdma-1.0): Unevaluated properties are not allowed ('altr,enable-hash', 'altr,enable-sup-addr' were unexpected)
   	from schema $id: http://devicetree.org/schemas/net/altr,tse.yaml
   arch/nios2/boot/dts/10m50_devboard.dtb: /sopc@0/clock@0: failed to match any schema with compatible: ['altr,pll-1.0']
   arch/nios2/boot/dts/10m50_devboard.dtb: /sopc@0/clock@1: failed to match any schema with compatible: ['altr,pll-1.0']
>> arch/nios2/boot/dts/10m50_devboard.dtb: gpio@180014d0 (altr,pio-1.0): 'oneOf' conditional failed, one must be fixed:
   	'interrupts' is a required property
   	'interrupts-extended' is a required property
   	from schema $id: http://devicetree.org/schemas/gpio/altr-pio-1.0.yaml
>> arch/nios2/boot/dts/10m50_devboard.dtb: gpio@180014d0 (altr,pio-1.0): 'interrupt-controller' is a required property
   	from schema $id: http://devicetree.org/schemas/gpio/altr-pio-1.0.yaml
>> arch/nios2/boot/dts/10m50_devboard.dtb: gpio@180014d0 (altr,pio-1.0): '#interrupt-cells' is a required property
   	from schema $id: http://devicetree.org/schemas/gpio/altr-pio-1.0.yaml
>> arch/nios2/boot/dts/10m50_devboard.dtb: gpio@180014c0 (altr,pio-1.0): 'edge_type', 'level_trigger' do not match any of the regexes: '^pinctrl-[0-9]+$'
   	from schema $id: http://devicetree.org/schemas/gpio/altr-pio-1.0.yaml
>> arch/nios2/boot/dts/10m50_devboard.dtb: gpio@180014c0 (altr,pio-1.0): 'interrupt-controller' is a required property
   	from schema $id: http://devicetree.org/schemas/gpio/altr-pio-1.0.yaml
>> arch/nios2/boot/dts/10m50_devboard.dtb: gpio@180014c0 (altr,pio-1.0): '#interrupt-cells' is a required property
   	from schema $id: http://devicetree.org/schemas/gpio/altr-pio-1.0.yaml
   arch/nios2/boot/dts/10m50_devboard.dtb: leds (gpio-leds): 'fpga0', 'fpga1', 'fpga2', 'fpga3' do not match any of the regexes: '(^led-[0-9a-f]$|led)', '^pinctrl-[0-9]+$'
   	from schema $id: http://devicetree.org/schemas/leds/leds-gpio.yaml

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

