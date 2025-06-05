Return-Path: <linux-kernel+bounces-693402-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C6435ADFE89
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jun 2025 09:19:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 75F973AD8B3
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jun 2025 07:18:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D39224A057;
	Thu, 19 Jun 2025 07:19:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lPA/Y2FZ"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2320F242D6E
	for <linux-kernel@vger.kernel.org>; Thu, 19 Jun 2025 07:19:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750317554; cv=none; b=WHFGUB/DiWCaxTSYV/lqKvNTvnoUQ3EppAtuc680+n44lpsTcTBnTiYdpek29Dw+NaPA5L5j6axys5LIdXasjmXSeBvekbV+JeKHDhqpMwnibJu/cPrwiQw2paQ9ELAlFYfRqT1sWRk65Ut7poImoDibqoPTKvCgkIDBpDhXIqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750317554; c=relaxed/simple;
	bh=98JOeQbdHFLnotA+noW+iaW7ngQU/8uiWvpLuOb+XPU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=hQM2ZgpHJiAbKFO7+ApuFSWD/EtDqFd3gpu0G5ksJEl0M15HX3ka7/x7YlS8E34SxrFBaiu97bFUXDmEF9SQSx1i3fkAGQoUUw7a/l5AZ3GeMEHzOR0eDMNQ1vHHucroJKhqMW0TuM3Hir6q69d0kEsIWkeemBkPE72VP9NiVxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lPA/Y2FZ; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750317553; x=1781853553;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=98JOeQbdHFLnotA+noW+iaW7ngQU/8uiWvpLuOb+XPU=;
  b=lPA/Y2FZ3/gDwhAASUfPk8fST2oWw6Fr572Ilmn+HddMGy9Z/91Kd9Ip
   rF5YIqFseZqPCzp94HkW/iP1c12zp/CqlK8wY12mDF9ZSNQVm+VHVL7Yu
   jkvCCipX4BgmdcnKMfemkyJcWZ+YXWOYW5m7AwNMs15QGTjrkFTtqavPy
   9PkWsEAiaTCGcsXY0mD2XZfcektnHZ+EQbh9V/1JO0yjUoalEHinwZHsz
   x+af/l0FJZidFHrEalFBN95+Z9iqHHtVobT9qVCws1aV1vnc5rWofzIPz
   m8zDqVT7abCTowyW/FlDdQcwofqFFZ7HRJ2AkNJQLsQit49Aule8A09Fe
   w==;
X-CSE-ConnectionGUID: zhyDSJ7gRmuYdyu6+Rhkmw==
X-CSE-MsgGUID: 5sTWhZ7oQ5uZdIlFTd28GA==
X-IronPort-AV: E=McAfee;i="6800,10657,11468"; a="51794304"
X-IronPort-AV: E=Sophos;i="6.16,247,1744095600"; 
   d="scan'208";a="51794304"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jun 2025 00:19:12 -0700
X-CSE-ConnectionGUID: EW0CZaffRPCAeEilQ3aOlg==
X-CSE-MsgGUID: SEPnU+x+TcC19xzE5bcUZw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,247,1744095600"; 
   d="scan'208";a="155124740"
Received: from igk-lkp-server01.igk.intel.com (HELO 28ae90bf6994) ([10.91.175.65])
  by orviesa004.jf.intel.com with ESMTP; 19 Jun 2025 00:19:10 -0700
Received: from kbuild by 28ae90bf6994 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uS9Y4-0001KS-18;
	Thu, 19 Jun 2025 07:19:00 +0000
Date: Thu, 5 Jun 2025 09:43:43 +0800
From: kernel test robot <lkp@intel.com>
To: Frank Li <Frank.Li@nxp.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Hans Verkuil <hverkuil@xs4all.nl>,
	"Rob Herring (Arm)" <robh@kernel.org>,
	Sakari Ailus <sakari.ailus@linux.intel.com>
Subject: arch/arm/boot/dts/nxp/imx/imx6q-h100.dtb: mipi@21dc000
 (fsl,imx6-mipi-csi2): 'port' does not match any of the regexes:
 '^pinctrl-[0-9]+$', '^port@[1-4]$'
Message-ID: <202506050912.DQmua49D-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   1af80d00e1e026c317c6ec19b1072f81ba7af64c
commit: 48dbb76cef65fabaa3ac97461eda90495e954ecd dt-bindings: media: convert imx.txt to yaml format
date:   4 weeks ago
config: arm-randconfig-2052-20250514 (https://download.01.org/0day-ci/archive/20250605/202506050912.DQmua49D-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 10.5.0
dtschema version: 2025.3.dev27+g32749b3
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250605/202506050912.DQmua49D-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202506050912.DQmua49D-lkp@intel.com/

dtcheck warnings: (new ones prefixed by >>)
   arch/arm/boot/dts/nxp/imx/imx6qdl.dtsi:907.28-915.6: Warning (unique_unit_address_if_enabled): /soc/bus@2000000/iomuxc-gpr@20e0000: duplicate unit-address (also used in node /soc/bus@2000000/pinctrl@20e0000)
   arch/arm/boot/dts/nxp/imx/imx6q-h100.dtb: /ldb: failed to match any schema with compatible: ['fsl,imx6q-ldb', 'fsl,imx53-ldb']
   arch/arm/boot/dts/nxp/imx/imx6q-h100.dtb: /ldb: failed to match any schema with compatible: ['fsl,imx6q-ldb', 'fsl,imx53-ldb']
   arch/arm/boot/dts/nxp/imx/imx6q-h100.dtb: iomuxc-gpr@20e0000 (fsl,imx6q-iomuxc-gpr): 'ipu1_csi0_mux', 'ipu2_csi1_mux' do not match any of the regexes: '^pinctrl-[0-9]+$'
   	from schema $id: http://devicetree.org/schemas/soc/imx/fsl,imx-iomuxc-gpr.yaml#
   arch/arm/boot/dts/nxp/imx/imx6q-h100.dtb: pcf8523@68 (nxp,pcf8523): $nodename:0: 'pcf8523@68' does not match '^rtc(@.*|-([0-9]|[1-9][0-9]+))?$'
   	from schema $id: http://devicetree.org/schemas/rtc/nxp,pcf8523.yaml#
   arch/arm/boot/dts/nxp/imx/imx6q-h100.dtb: /soc/bus@2100000/i2c@21a0000/tc358743@f: failed to match any schema with compatible: ['toshiba,tc358743']
>> arch/arm/boot/dts/nxp/imx/imx6q-h100.dtb: mipi@21dc000 (fsl,imx6-mipi-csi2): 'port' does not match any of the regexes: '^pinctrl-[0-9]+$', '^port@[1-4]$'
   	from schema $id: http://devicetree.org/schemas/media/fsl,imx6-mipi-csi2.yaml#
   arch/arm/boot/dts/nxp/imx/imx6q-h100.dtb: /soc/bus@2100000/vdoa@21e4000: failed to match any schema with compatible: ['fsl,imx6q-vdoa']
   arch/arm/boot/dts/nxp/imx/imx6q-h100.dtb: /soc/ipu@2400000: failed to match any schema with compatible: ['fsl,imx6q-ipu']
   arch/arm/boot/dts/nxp/imx/imx6q-h100.dtb: /soc/ipu@2800000: failed to match any schema with compatible: ['fsl,imx6q-ipu']
   arch/arm/boot/dts/nxp/imx/imx6q-h100.dtb: /display-subsystem: failed to match any schema with compatible: ['fsl,imx-display-subsystem']

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

