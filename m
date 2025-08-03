Return-Path: <linux-kernel+bounces-754417-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 696B3B19412
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Aug 2025 15:13:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AD4457AA778
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Aug 2025 13:12:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81049258CE5;
	Sun,  3 Aug 2025 13:13:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kw7ncP4Y"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 828E2C2C9
	for <linux-kernel@vger.kernel.org>; Sun,  3 Aug 2025 13:13:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754226831; cv=none; b=rnOj2XSomkiYW78u12UmEvQpth2k4HVeHsIeiAjKFUW2SVDQLlUruGe5LAQ/2NY53qNT/s1dOJ9GOrvatQrcZJLdez5twvIvXOfPFdfY0eSVzZHoOK1HqmE1Ro6Jn9TXa9aJVwqnoV1/x4sU+Y17fhxPKyysv1tgL8tCO8GN2kM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754226831; c=relaxed/simple;
	bh=uOxYQznVsFKZX6gJObHrdGVChAt769B3AjUKWxpasFg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=qXpaQiZBPkxXzHPFwOecoV5XEQAiSDNISIM6KEEOBftSWx7yHgeG8/A2BfpOxhFJCnOaqsheGdg2BazU3jZWtc/90eSmiwBWhHO3ssAMksSf/cPSdfU/aujg1zqgFy4whNHEkACudUK2lZFHSQU6AfDp/fVPFNiHqO18nS/J4f4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kw7ncP4Y; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1754226829; x=1785762829;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=uOxYQznVsFKZX6gJObHrdGVChAt769B3AjUKWxpasFg=;
  b=kw7ncP4YBwY47SMbs9rqOmwLEvxwJmQKdLLo62KBP89kru50ERbOkbYl
   8/l7YGDR8adKIzqCYZk8AWY3lcNWK38UO1PaZ1XM9XxgPwfzYLrpm+WL6
   6gDM/5aBhm0N+YWdcAQi8Xn4LF0nex5hpUGDn+CJgouqXDQsOhOWQ6H4T
   0v8l3Iu0qbAfc/mx0RzVPqOB59UW7tvLRhVUlqjS89sTaPvFX4fq7iOVL
   tmEH9DWbcsur0YK0rbPJ+IUBAin6edgMoatOeWWTTmAbxhC/a74OVpyjx
   aKeoYYw4rPBdVEtIIxQANhe6BbJR8syO1N0fxukeeeS6NQtejrhPRJkXO
   A==;
X-CSE-ConnectionGUID: pi6zjQbNQQCeHxABBI765A==
X-CSE-MsgGUID: 1/o2bLgZTQKBJLGgCmdG9A==
X-IronPort-AV: E=McAfee;i="6800,10657,11510"; a="67072289"
X-IronPort-AV: E=Sophos;i="6.17,258,1747724400"; 
   d="scan'208";a="67072289"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Aug 2025 06:13:48 -0700
X-CSE-ConnectionGUID: ph4FFE+7RAS/G41Oqiu7tg==
X-CSE-MsgGUID: SMPjfLzVSJih5kt/3OO9YA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,258,1747724400"; 
   d="scan'208";a="164395772"
Received: from igk-lkp-server01.igk.intel.com (HELO b3b7d4258b7c) ([10.91.175.65])
  by fmviesa008.fm.intel.com with ESMTP; 03 Aug 2025 06:13:46 -0700
Received: from kbuild by b3b7d4258b7c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uiYX2-0001dH-1J;
	Sun, 03 Aug 2025 13:13:44 +0000
Date: Sun, 3 Aug 2025 15:13:22 +0200
From: kernel test robot <lkp@intel.com>
To: "Rob Herring (Arm)" <robh@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Stephen Boyd <sboyd@kernel.org>
Subject: arch/arm/boot/dts/nuvoton/nuvoton-npcm730-gsj.dtb:
 clock-controller@f0801000 (nuvoton,npcm750-clk): 'clock-controller' does not
 match any of the regexes: '^pinctrl-[0-9]+$'
Message-ID: <202508031542.43A5fCUg-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git =
master
head:   a6923c06a3b2e2c534ae28c53a7531e76cc95cfa
commit: 71b80a33653debf0374498e6f4141aae43038d0b dt-bindings: clock: Conver=
t nuvoton,npcm750-clk to DT schema
date:   10 days ago
config: arm-randconfig-2051-20250801 (https://download.01.org/0day-ci/archi=
ve/20250803/202508031542.43A5fCUg-lkp@intel.com/config)
compiler: clang version 22.0.0git (https://github.com/llvm/llvm-project 654=
0c93aa991dbc2b09cc5395493dadd7181551e)
dtschema version: 2025.6.2.dev4+g8f79ddd
reproduce (this is a W=3D1 build): (https://download.01.org/0day-ci/archive=
/20250803/202508031542.43A5fCUg-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new versio=
n of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202508031542.43A5fCUg-lkp@i=
ntel.com/

dtcheck warnings: (new ones prefixed by >>)
   	from schema $id: http://devicetree.org/schemas/arm/nuvoton/nuvoton,npcm=
=2Eyaml#
   arch/arm/boot/dts/nuvoton/nuvoton-npcm730-gsj.dtb: / (nuvoton,npcm750): =
memory: 'device_type' is a required property
   	from schema $id: http://devicetree.org/schemas/memory.yaml#
   arch/arm/boot/dts/nuvoton/nuvoton-npcm730-gsj.dtb: / (nuvoton,npcm750): =
memory: False schema does not allow {'reg': [[0, 1073741824]]}
   	from schema $id: http://devicetree.org/schemas/root-node.yaml#
   arch/arm/boot/dts/nuvoton/nuvoton-npcm730-gsj.dtb: cache-controller@3fc0=
00 (arm,pl310-cache): 'clocks' does not match any of the regexes: '^pinctrl=
-[0-9]+$'
   	from schema $id: http://devicetree.org/schemas/cache/l2c2x0.yaml#
   arch/arm/boot/dts/nuvoton/nuvoton-npcm730-gsj.dtb: /soc/rst@801000: fail=
ed to match any schema with compatible: ['nuvoton,npcm750-rst', 'syscon', '=
simple-mfd']
   arch/arm/boot/dts/nuvoton/nuvoton-npcm730-gsj.dtb: ahb (simple-bus): apb=
:ranges: [[0, 4026531840, 3145728]] is not of type 'boolean'
   	from schema $id: http://devicetree.org/schemas/simple-bus.yaml#
>> arch/arm/boot/dts/nuvoton/nuvoton-npcm730-gsj.dtb: clock-controller@f080=
1000 (nuvoton,npcm750-clk): 'clock-controller' does not match any of the re=
gexes: '^pinctrl-[0-9]+$'
   	from schema $id: http://devicetree.org/schemas/clock/nuvoton,npcm750-cl=
k.yaml#
>> arch/arm/boot/dts/nuvoton/nuvoton-npcm730-gsj.dtb: clock-controller@f080=
1000 (nuvoton,npcm750-clk): compatible: ['nuvoton,npcm750-clk', 'syscon'] i=
s too long
   	from schema $id: http://devicetree.org/schemas/clock/nuvoton,npcm750-cl=
k.yaml#
   arch/arm/boot/dts/nuvoton/nuvoton-npcm730-gsj.dtb: eth@f0802000 (snps,dw=
mac): $nodename:0: 'eth@f0802000' does not match '^ethernet(@.*)?$'
   	from schema $id: http://devicetree.org/schemas/net/snps,dwmac.yaml#
   arch/arm/boot/dts/nuvoton/nuvoton-npcm730-gsj.dtb: /ahb/spi@fb000000: fa=
iled to match any schema with compatible: ['nuvoton,npcm750-fiu']
   arch/arm/boot/dts/nuvoton/nuvoton-npcm730-gsj.dtb: /ahb/spi@c0000000: fa=
iled to match any schema with compatible: ['nuvoton,npcm750-fiu']
   arch/arm/boot/dts/nuvoton/nuvoton-npcm730-gsj.dtb: /ahb/spi@fb001000: fa=
iled to match any schema with compatible: ['nuvoton,npcm750-fiu']
   arch/arm/boot/dts/nuvoton/nuvoton-npcm730-gsj.dtb: apb (simple-bus): wat=
chdog@901C: 'ranges' is a required property
   	from schema $id: http://devicetree.org/schemas/simple-bus.yaml#
   arch/arm/boot/dts/nuvoton/nuvoton-npcm730-gsj.dtb: /ahb/apb/lpc_kcs@7000=
: failed to match any schema with compatible: ['nuvoton,npcm750-lpc-kcs', '=
simple-mfd', 'syscon']
   arch/arm/boot/dts/nuvoton/nuvoton-npcm730-gsj.dtb: /ahb/apb/lpc_kcs@7000=
/kcs1@0: failed to match any schema with compatible: ['nuvoton,npcm750-kcs-=
bmc']
--
   	from schema $id: http://devicetree.org/schemas/root-node.yaml#
   arch/arm/boot/dts/nuvoton/nuvoton-npcm730-gbs.dtb: cache-controller@3fc0=
00 (arm,pl310-cache): 'clocks' does not match any of the regexes: '^pinctrl=
-[0-9]+$'
   	from schema $id: http://devicetree.org/schemas/cache/l2c2x0.yaml#
   arch/arm/boot/dts/nuvoton/nuvoton-npcm730-gbs.dtb: uart-mux-controller (=
mmio-mux): $nodename:0: 'uart-mux-controller' does not match '^mux-controll=
er(@.*|-([0-9]|[1-9][0-9]+))?$'
   	from schema $id: http://devicetree.org/schemas/mux/mux-controller.yaml#
   arch/arm/boot/dts/nuvoton/nuvoton-npcm730-gbs.dtb: uart1-mode-mux-contro=
ller (mmio-mux): $nodename:0: 'uart1-mode-mux-controller' does not match '^=
mux-controller(@.*|-([0-9]|[1-9][0-9]+))?$'
   	from schema $id: http://devicetree.org/schemas/mux/mux-controller.yaml#
   arch/arm/boot/dts/nuvoton/nuvoton-npcm730-gbs.dtb: /soc/rst@801000: fail=
ed to match any schema with compatible: ['nuvoton,npcm750-rst', 'syscon', '=
simple-mfd']
   arch/arm/boot/dts/nuvoton/nuvoton-npcm730-gbs.dtb: ahb (simple-bus): apb=
:ranges: [[0, 4026531840, 3145728]] is not of type 'boolean'
   	from schema $id: http://devicetree.org/schemas/simple-bus.yaml#
>> arch/arm/boot/dts/nuvoton/nuvoton-npcm730-gbs.dtb: clock-controller@f080=
1000 (nuvoton,npcm750-clk): 'clock-controller' does not match any of the re=
gexes: '^pinctrl-[0-9]+$'
   	from schema $id: http://devicetree.org/schemas/clock/nuvoton,npcm750-cl=
k.yaml#
>> arch/arm/boot/dts/nuvoton/nuvoton-npcm730-gbs.dtb: clock-controller@f080=
1000 (nuvoton,npcm750-clk): compatible: ['nuvoton,npcm750-clk', 'syscon'] i=
s too long
   	from schema $id: http://devicetree.org/schemas/clock/nuvoton,npcm750-cl=
k.yaml#
   arch/arm/boot/dts/nuvoton/nuvoton-npcm730-gbs.dtb: eth@f0802000 (snps,dw=
mac): $nodename:0: 'eth@f0802000' does not match '^ethernet(@.*)?$'
   	from schema $id: http://devicetree.org/schemas/net/snps,dwmac.yaml#
   arch/arm/boot/dts/nuvoton/nuvoton-npcm730-gbs.dtb: /ahb/spi@fb000000: fa=
iled to match any schema with compatible: ['nuvoton,npcm750-fiu']
   arch/arm/boot/dts/nuvoton/nuvoton-npcm730-gbs.dtb: /ahb/spi@c0000000: fa=
iled to match any schema with compatible: ['nuvoton,npcm750-fiu']
   arch/arm/boot/dts/nuvoton/nuvoton-npcm730-gbs.dtb: /ahb/spi@fb001000: fa=
iled to match any schema with compatible: ['nuvoton,npcm750-fiu']
   arch/arm/boot/dts/nuvoton/nuvoton-npcm730-gbs.dtb: apb (simple-bus): wat=
chdog@901C: 'ranges' is a required property
   	from schema $id: http://devicetree.org/schemas/simple-bus.yaml#
   arch/arm/boot/dts/nuvoton/nuvoton-npcm730-gbs.dtb: /ahb/apb/lpc_kcs@7000=
: failed to match any schema with compatible: ['nuvoton,npcm750-lpc-kcs', '=
simple-mfd', 'syscon']
   arch/arm/boot/dts/nuvoton/nuvoton-npcm730-gbs.dtb: /ahb/apb/lpc_kcs@7000=
/kcs1@0: failed to match any schema with compatible: ['nuvoton,npcm750-kcs-=
bmc']
--
   arch/arm/boot/dts/nuvoton/nuvoton-npcm730-kudo.dtb: /: failed to match a=
ny schema with compatible: ['fii,kudo', 'nuvoton,npcm730']
   arch/arm/boot/dts/nuvoton/nuvoton-npcm730-kudo.dtb: / (fii,kudo): memory=
: 'device_type' is a required property
   	from schema $id: http://devicetree.org/schemas/memory.yaml#
   arch/arm/boot/dts/nuvoton/nuvoton-npcm730-kudo.dtb: / (fii,kudo): memory=
: False schema does not allow {'reg': [[0, 1073741824]]}
   	from schema $id: http://devicetree.org/schemas/root-node.yaml#
   arch/arm/boot/dts/nuvoton/nuvoton-npcm730-kudo.dtb: cache-controller@3fc=
000 (arm,pl310-cache): 'clocks' does not match any of the regexes: '^pinctr=
l-[0-9]+$'
   	from schema $id: http://devicetree.org/schemas/cache/l2c2x0.yaml#
   arch/arm/boot/dts/nuvoton/nuvoton-npcm730-kudo.dtb: /soc/rst@801000: fai=
led to match any schema with compatible: ['nuvoton,npcm750-rst', 'syscon', =
'simple-mfd']
   arch/arm/boot/dts/nuvoton/nuvoton-npcm730-kudo.dtb: ahb (simple-bus): ap=
b:ranges: [[0, 4026531840, 3145728]] is not of type 'boolean'
   	from schema $id: http://devicetree.org/schemas/simple-bus.yaml#
>> arch/arm/boot/dts/nuvoton/nuvoton-npcm730-kudo.dtb: clock-controller@f08=
01000 (nuvoton,npcm750-clk): 'clock-controller' does not match any of the r=
egexes: '^pinctrl-[0-9]+$'
   	from schema $id: http://devicetree.org/schemas/clock/nuvoton,npcm750-cl=
k.yaml#
>> arch/arm/boot/dts/nuvoton/nuvoton-npcm730-kudo.dtb: clock-controller@f08=
01000 (nuvoton,npcm750-clk): compatible: ['nuvoton,npcm750-clk', 'syscon'] =
is too long
   	from schema $id: http://devicetree.org/schemas/clock/nuvoton,npcm750-cl=
k.yaml#
   arch/arm/boot/dts/nuvoton/nuvoton-npcm730-kudo.dtb: eth@f0802000 (snps,d=
wmac): $nodename:0: 'eth@f0802000' does not match '^ethernet(@.*)?$'
   	from schema $id: http://devicetree.org/schemas/net/snps,dwmac.yaml#
   arch/arm/boot/dts/nuvoton/nuvoton-npcm730-kudo.dtb: /ahb/spi@fb000000: f=
ailed to match any schema with compatible: ['nuvoton,npcm750-fiu']
   arch/arm/boot/dts/nuvoton/nuvoton-npcm730-kudo.dtb: /ahb/spi@c0000000: f=
ailed to match any schema with compatible: ['nuvoton,npcm750-fiu']
   arch/arm/boot/dts/nuvoton/nuvoton-npcm730-kudo.dtb: /ahb/spi@fb001000: f=
ailed to match any schema with compatible: ['nuvoton,npcm750-fiu']
   arch/arm/boot/dts/nuvoton/nuvoton-npcm730-kudo.dtb: apb (simple-bus): wa=
tchdog@901C: 'ranges' is a required property
   	from schema $id: http://devicetree.org/schemas/simple-bus.yaml#
   arch/arm/boot/dts/nuvoton/nuvoton-npcm730-kudo.dtb: /ahb/apb/lpc_kcs@700=
0: failed to match any schema with compatible: ['nuvoton,npcm750-lpc-kcs', =
'simple-mfd', 'syscon']
   arch/arm/boot/dts/nuvoton/nuvoton-npcm730-kudo.dtb: /ahb/apb/lpc_kcs@700=
0/kcs1@0: failed to match any schema with compatible: ['nuvoton,npcm750-kcs=
-bmc']
--
   cooling-levels: size (2) error for type uint32-array
   cooling-levels: size (2) error for type uint32-array
   cooling-levels: size (2) error for type uint32-array
   arch/arm/boot/dts/nuvoton/nuvoton-npcm750-evb.dtb: / (nuvoton,npcm750-ev=
b): memory: False schema does not allow {'device_type': ['memory'], 'reg': =
[[0, 536870912]]}
   	from schema $id: http://devicetree.org/schemas/root-node.yaml#
   arch/arm/boot/dts/nuvoton/nuvoton-npcm750-evb.dtb: cache-controller@3fc0=
00 (arm,pl310-cache): 'clocks' does not match any of the regexes: '^pinctrl=
-[0-9]+$'
   	from schema $id: http://devicetree.org/schemas/cache/l2c2x0.yaml#
   arch/arm/boot/dts/nuvoton/nuvoton-npcm750-evb.dtb: /soc/rst@801000: fail=
ed to match any schema with compatible: ['nuvoton,npcm750-rst', 'syscon', '=
simple-mfd']
   arch/arm/boot/dts/nuvoton/nuvoton-npcm750-evb.dtb: ahb (simple-bus): apb=
:ranges: [[0, 4026531840, 3145728]] is not of type 'boolean'
   	from schema $id: http://devicetree.org/schemas/simple-bus.yaml#
>> arch/arm/boot/dts/nuvoton/nuvoton-npcm750-evb.dtb: clock-controller@f080=
1000 (nuvoton,npcm750-clk): 'clock-controller' does not match any of the re=
gexes: '^pinctrl-[0-9]+$'
   	from schema $id: http://devicetree.org/schemas/clock/nuvoton,npcm750-cl=
k.yaml#
>> arch/arm/boot/dts/nuvoton/nuvoton-npcm750-evb.dtb: clock-controller@f080=
1000 (nuvoton,npcm750-clk): compatible: ['nuvoton,npcm750-clk', 'syscon'] i=
s too long
   	from schema $id: http://devicetree.org/schemas/clock/nuvoton,npcm750-cl=
k.yaml#
   arch/arm/boot/dts/nuvoton/nuvoton-npcm750-evb.dtb: eth@f0802000 (snps,dw=
mac): $nodename:0: 'eth@f0802000' does not match '^ethernet(@.*)?$'
   	from schema $id: http://devicetree.org/schemas/net/snps,dwmac.yaml#
   arch/arm/boot/dts/nuvoton/nuvoton-npcm750-evb.dtb: /ahb/spi@fb000000: fa=
iled to match any schema with compatible: ['nuvoton,npcm750-fiu']
   arch/arm/boot/dts/nuvoton/nuvoton-npcm750-evb.dtb: /ahb/spi@c0000000: fa=
iled to match any schema with compatible: ['nuvoton,npcm750-fiu']
   arch/arm/boot/dts/nuvoton/nuvoton-npcm750-evb.dtb: /ahb/spi@fb001000: fa=
iled to match any schema with compatible: ['nuvoton,npcm750-fiu']
   arch/arm/boot/dts/nuvoton/nuvoton-npcm750-evb.dtb: apb (simple-bus): wat=
chdog@901C: 'ranges' is a required property
   	from schema $id: http://devicetree.org/schemas/simple-bus.yaml#
   arch/arm/boot/dts/nuvoton/nuvoton-npcm750-evb.dtb: /ahb/apb/lpc_kcs@7000=
: failed to match any schema with compatible: ['nuvoton,npcm750-lpc-kcs', '=
simple-mfd', 'syscon']
   arch/arm/boot/dts/nuvoton/nuvoton-npcm750-evb.dtb: /ahb/apb/lpc_kcs@7000=
/kcs1@0: failed to match any schema with compatible: ['nuvoton,npcm750-kcs-=
bmc']
--
   	from schema $id: http://devicetree.org/schemas/arm/nuvoton/nuvoton,npcm=
=2Eyaml#
   arch/arm/boot/dts/nuvoton/nuvoton-npcm750-runbmc-olympus.dtb: / (nuvoton=
,npcm750): memory: 'device_type' is a required property
   	from schema $id: http://devicetree.org/schemas/memory.yaml#
   arch/arm/boot/dts/nuvoton/nuvoton-npcm750-runbmc-olympus.dtb: / (nuvoton=
,npcm750): memory: False schema does not allow {'reg': [[0, 1073741824]]}
   	from schema $id: http://devicetree.org/schemas/root-node.yaml#
   arch/arm/boot/dts/nuvoton/nuvoton-npcm750-runbmc-olympus.dtb: cache-cont=
roller@3fc000 (arm,pl310-cache): 'clocks' does not match any of the regexes=
: '^pinctrl-[0-9]+$'
   	from schema $id: http://devicetree.org/schemas/cache/l2c2x0.yaml#
   arch/arm/boot/dts/nuvoton/nuvoton-npcm750-runbmc-olympus.dtb: /soc/rst@8=
01000: failed to match any schema with compatible: ['nuvoton,npcm750-rst', =
'syscon', 'simple-mfd']
   arch/arm/boot/dts/nuvoton/nuvoton-npcm750-runbmc-olympus.dtb: ahb (simpl=
e-bus): apb:ranges: [[0, 4026531840, 3145728]] is not of type 'boolean'
   	from schema $id: http://devicetree.org/schemas/simple-bus.yaml#
>> arch/arm/boot/dts/nuvoton/nuvoton-npcm750-runbmc-olympus.dtb: clock-cont=
roller@f0801000 (nuvoton,npcm750-clk): 'clock-controller' does not match an=
y of the regexes: '^pinctrl-[0-9]+$'
   	from schema $id: http://devicetree.org/schemas/clock/nuvoton,npcm750-cl=
k.yaml#
>> arch/arm/boot/dts/nuvoton/nuvoton-npcm750-runbmc-olympus.dtb: clock-cont=
roller@f0801000 (nuvoton,npcm750-clk): compatible: ['nuvoton,npcm750-clk', =
'syscon'] is too long
   	from schema $id: http://devicetree.org/schemas/clock/nuvoton,npcm750-cl=
k.yaml#
   arch/arm/boot/dts/nuvoton/nuvoton-npcm750-runbmc-olympus.dtb: eth@f08020=
00 (snps,dwmac): $nodename:0: 'eth@f0802000' does not match '^ethernet(@.*)=
?$'
   	from schema $id: http://devicetree.org/schemas/net/snps,dwmac.yaml#
   arch/arm/boot/dts/nuvoton/nuvoton-npcm750-runbmc-olympus.dtb: /ahb/spi@f=
b000000: failed to match any schema with compatible: ['nuvoton,npcm750-fiu']
   arch/arm/boot/dts/nuvoton/nuvoton-npcm750-runbmc-olympus.dtb: flash@1 (j=
edec,spi-nor): Unevaluated properties are not allowed ('npcm,fiu-rx-bus-wid=
th' was unexpected)
   	from schema $id: http://devicetree.org/schemas/mtd/jedec,spi-nor.yaml#
   arch/arm/boot/dts/nuvoton/nuvoton-npcm750-runbmc-olympus.dtb: flash@1 (j=
edec,spi-nor): 'npcm,fiu-rx-bus-width' does not match any of the regexes: '=
^#.*', '^(at25|bm|devbus|dmacap|dsa|exynos|fsi[ab]|gpio-fan|gpio-key|gpio|g=
pmc|hdmi|i2c-gpio),.*', '^(keypad|m25p|max8952|max8997|max8998|mpmc),.*', '=
^(pciclass|pinctrl-single|#pinctrl-single|PowerPC),.*', '^(pl022|pxa-mmc|rc=
ar_sound|rotary-encoder|s5m8767|sdhci),.*', '^(simple-audio-card|st-plgpio|=
st-spics|ts),.*', '^100ask,.*', '^70mai,.*', '^8dev,.*', '^GEFanuc,.*', '^I=
BM,.*', '^ORCL,.*', '^SUNW,.*', '^[a-zA-Z0-9#_][a-zA-Z0-9+\\-._@]{0,63}$', =
'^[a-zA-Z0-9+\\-._]*@[0-9a-zA-Z,]*$', '^abb,.*', '^abilis,.*', '^abracon,.*=
', '^abt,.*', '^acbel,.*', '^acelink,.*', '^acer,.*', '^acme,.*', '^actions=
,.*', '^active-semi,.*', '^ad,.*', '^adafruit,.*', '^adapteva,.*', '^adaptr=
um,.*', '^adh,.*', '^adi,.*', '^adieng,.*', '^admatec,.*', '^advantech,.*',=
 '^aeroflexgaisler,.*', '^aesop,.*', '^airoha,.*', '^al,.*', '^alcatel,.*',=
 '^aldec,.*', '^alfa-network,.*', '^allegro,.*', '^allegromicro,.*', '^alli=
edvision,.*', '^allo,.*', '^allwinner,.*', '^alphascale,.*', '^alps,.*', '^=
alt,.*', '^altr,.*', '^amarula,.*', '^amazon,.*', '^amcc,.*', '^amd,.*', '^=
amediatech,.*', '^amlogic,.*', '^ampere,.*', '^amphenol,.*', '^ampire,.*', =
'^ams,.*', '^amstaos,.*', '^analogix,.*', '^anbernic,.*', '^andestech,.*', =
'^anvo,.*', '^aoly,.*', '^aosong,.*', '^apm,.*', '^apple,.*', '^aptina,.*',=
 '^arasan,.*', '^archermind,.*', '^arcom,.*', '^arctic,.*', '^arcx,.*', '^a=
riaboard,.*', '^aries,.*', '^arm,.*', '^armadeus,.*', '^armsom,.*', '^arrow=
,.*', '^artesyn,.*', '^asahi-kasei,.*', '^asc,.*', '^asix,.*', '^aspeed,.*'=
, '^asrock,.*', '^asteralabs,.*', '^asus,.*', '^atheros,.*', '^atlas,.*', '=
^atmel,.*', '^auo,.*', '^auvidea,.*', '^avago,.*', '^avia,.*', '^avic,.*', =
'^avnet,.*', '^awinic,.*', '^axentia,.*', '^axis,.*', '^azoteq,.*', '^azw,.=
*', '^baikal,.*', '^bananapi,.*', '^beacon,.*', '^beagle,.*', '^belling,.*'=
, '^bhf,.*', '^bigtreetech,.*', '^bitmain,.*', '^blaize,.*', '^blutek,.*', =
'^boe,.*', '^bosch,.*', '^boundary,.*', '^brcm,.*', '^broadmobi,.*', '^bsh,=
=2E*', '^bticino,.*', '^buffalo,.*', '^bur,.*', '^bytedance,.*', '^calamp,.=
*', '^calao,.*', '^calaosystems,.*', '^calxeda,.*', '^cameo,.*', '^canaan,.=
*', '^caninos,.*', '^capella,.*', '^cascoda,.*', '^catalyst,.*', '^cavium,.=
*', '^cct,.*', '^cdns,.*', '^cdtech,.*', '^cellwise,.*', '^ceva,.*', '^char=
gebyte,.*', '^checkpoint,.*', '^chefree,.*', '^chipidea,.*', '^chipone,.*',=
 '^chipspark,.*', '^chongzhou,.*', '^chrontel,.*', '^chrp,.*', '^chunghwa,.=
*', '^chuwi,.*', '^ciaa,.*', '^cirrus,.*', '^cisco,.*', '^clockwork,.*', '^=
cloos,.*', '^cloudengines,.*', '^cnm,.*', '^cnxt,.*', '^colorfly,.*', '^com=
pulab,.*', '^comvetia,.*', '^congatec,.*', '^coolpi,.*', '^coreriver,.*', '=
^corpro,.*', '^cortina,.*', '^cosmic,.*', '^crane,.*', '^creative,.*', '^cr=
ystalfontz,.*', '^csky,.*', '^csot,.*', '^csq,.*', '^ctera,.*', '^ctu,.*', =
'^cubietech,.*', '^cudy,.*', '^cui,.*', '^cypress,.*', '^cyx,.*', '^cznic,.=
*', '^dallas,.*', '^dataimage,.*', '^davicom,.*', '^deepcomputing,.*', '^de=
ll,.*', '^delta,.*', '^densitron,.*', '^denx,.*', '^devantech,.*', '^dfi,.*=
', '^dfrobot,.*', '^dh,.*', '^difrnce,.*', '^digi,.*', '^digilent,.*', '^di=
monoff,.*', '^diodes,.*', '^dioo,.*', '^dlc,.*', '^dlg,.*', '^dlink,.*', '^=
dmo,.*', '^domintech,.*', '^dongwoon,.*', '^dptechnics,.*', '^dragino,.*', =
'^dream,.*', '^ds,.*', '^dserve,.*', '^dynaimage,.*', '^ea,.*', '^ebang,.*'=
, '^ebbg,.*', '^ebs-systart,.*', '^ebv,.*', '^eckelmann,.*', '^econet,.*', =
'^edgeble,.*', '^edimax,.*', '^edt,.*', '^ees,.*', '^eeti,.*', '^einfochips=
,.*', '^eink,.*', '^elan,.*', '^element14,.*', '^elgin,.*', '^elida,.*', '^=
elimo,.*', '^elpida,.*', '^embedfire,.*', '^embest,.*', '^emcraft,.*', '^em=
lid,.*', '^emmicro,.*', '^empire-electronix,.*', '^emtrion,.*', '^enclustra=
,.*', '^endless,.*', '^ene,.*', '^energymicro,.*', '^engicam,.*', '^englede=
r,.*', '^epcos,.*', '^epfl,.*', '^epson,.*', '^esp,.*', '^est,.*', '^ettus,=
=2E*', '^eukrea,.*', '^everest,.*', '^everspin,.*', '^evervision,.*', '^exa=
r,.*', '^excito,.*', '^exegin,.*', '^ezchip,.*', '^facebook,.*', '^fairchil=
d,.*', '^fairphone,.*', '^faraday,.*', '^fascontek,.*', '^fastrax,.*', '^fc=
s,.*', '^feixin,.*', '^feiyang,.*', '^fii,.*', '^firefly,.*', '^focaltech,.=
*', '^forlinx,.*', '^freebox,.*', '^freecom,.*', '^frida,.*', '^friendlyarm=
,.*', '^fsl,.*', '^fujitsu,.*', '^fxtec,.*', '^galaxycore,.*', '^gameforce,=
=2E*', '^gardena,.*', '^gateway,.*', '^gateworks,.*', '^gcw,.*', '^ge,.*', =
'^geekbuying,.*', '^gef,.*', '^gehc,.*', '^gemei,.*', '^gemtek,.*', '^genes=
ys,.*', '^genexis,.*', '^geniatech,.*', '^giantec,.*', '^giantplus,.*', '^g=
linet,.*', '^globalscale,.*', '^globaltop,.*', '^gmt,.*', '^gocontroll,.*',=
 '^goldelico,.*', '^goodix,.*', '^google,.*', '^goramo,.*', '^gplus,.*', '^=
grinn,.*', '^grmn,.*', '^gumstix,.*', '^gw,.*', '^hannstar,.*', '^haochuang=
yi,.*', '^haoyu,.*', '^hardkernel,.*', '^hechuang,.*', '^hideep,.*', '^hima=
x,.*', '^hirschmann,.*', '^hisi,.*', '^hisilicon,.*', '^hit,.*', '^hitex,.*=
', '^holt,.*', '^holtek,.*', '^honestar,.*', '^honeywell,.*', '^hoperf,.*',=
 '^hoperun,.*', '^hp,.*', '^hpe,.*', '^hsg,.*', '^htc,.*', '^huawei,.*', '^=
hugsun,.*', '^hwacom,.*', '^hxt,.*', '^hycon,.*', '^hydis,.*', '^hynitron,.=
*', '^hynix,.*', '^hyundai,.*', '^i2se,.*', '^ibm,.*', '^icplus,.*', '^idt,=
=2E*', '^iei,.*', '^ifi,.*', '^ilitek,.*', '^imagis,.*', '^img,.*', '^imi,.=
*', '^inanbo,.*', '^incircuit,.*', '^indiedroid,.*', '^inet-tek,.*', '^infi=
neon,.*', '^inforce,.*', '^ingenic,.*', '^ingrasys,.*', '^injoinic,.*', '^i=
nnocomm,.*', '^innolux,.*', '^inside-secure,.*', '^insignal,.*', '^inspur,.=
*', '^intel,.*', '^intercontrol,.*', '^invensense,.*', '^inventec,.*', '^in=
versepath,.*', '^iom,.*', '^irondevice,.*', '^isee,.*', '^isil,.*', '^issi,=
=2E*', '^ite,.*', '^itead,.*', '^itian,.*', '^ivo,.*', '^iwave,.*', '^jadar=
d,.*', '^jasonic,.*', '^jdi,.*', '^jedec,.*', '^jenson,.*', '^jesurun,.*', =
'^jethome,.*', '^jianda,.*', '^jide,.*', '^joz,.*', '^kam,.*', '^karo,.*', =
'^keithkoep,.*', '^keymile,.*', '^khadas,.*', '^kiebackpeter,.*', '^kinetic=
,.*', '^kingdisplay,.*', '^kingnovel,.*', '^kionix,.*', '^kobo,.*', '^kobol=
,.*', '^koe,.*', '^kontron,.*', '^kosagi,.*', '^kvg,.*', '^kyo,.*', '^lacie=
,.*', '^laird,.*', '^lamobo,.*', '^lantiq,.*', '^lattice,.*', '^lckfb,.*', =
'^lctech,.*', '^leadtek,.*', '^leez,.*', '^lego,.*', '^lemaker,.*', '^lenov=
o,.*', '^lg,.*', '^lgphilips,.*', '^libretech,.*', '^licheepi,.*', '^linaro=
,.*', '^lincolntech,.*', '^lineartechnology,.*', '^linksprite,.*', '^linksy=
s,.*', '^linutronix,.*', '^linux,.*', '^linx,.*', '^liontron,.*', '^liteon,=
=2E*', '^litex,.*', '^lltc,.*', '^logicpd,.*', '^logictechno,.*', '^longche=
er,.*', '^lontium,.*', '^loongmasses,.*', '^loongson,.*', '^lsi,.*', '^lunz=
n,.*', '^luxul,.*', '^lwn,.*', '^lxa,.*', '^m5stack,.*', '^macnica,.*', '^m=
antix,.*', '^mapleboard,.*', '^marantec,.*', '^marvell,.*', '^maxbotix,.*',=
 '^maxim,.*', '^maxlinear,.*', '^mbvl,.*', '^mcube,.*', '^meas,.*', '^mecer=
,.*', '^mediatek,.*', '^megachips,.*', '^mele,.*', '^melexis,.*', '^melfas,=
=2E*', '^mellanox,.*', '^memsensing,.*', '^memsic,.*', '^menlo,.*', '^mento=
r,.*', '^meraki,.*', '^merrii,.*', '^methode,.*', '^micrel,.*', '^microchip=
,.*', '^microcrystal,.*', '^micron,.*', '^microsoft,.*', '^microsys,.*', '^=
microtips,.*', '^mikroe,.*', '^mikrotik,.*', '^milkv,.*', '^miniand,.*', '^=
minix,.*', '^mips,.*', '^miramems,.*', '^mitsubishi,.*', '^mitsumi,.*', '^m=
ixel,.*', '^miyoo,.*', '^mntre,.*', '^mobileye,.*', '^modtronix,.*', '^moor=
tec,.*', '^mosaixtech,.*', '^motorcomm,.*', '^motorola,.*', '^moxa,.*', '^m=
pl,.*', '^mps,.*', '^mqmaker,.*', '^mrvl,.*', '^mscc,.*', '^msi,.*', '^msta=
r,.*', '^mti,.*', '^multi-inno,.*', '^mundoreader,.*', '^murata,.*', '^mxic=
,.*', '^mxicy,.*', '^myir,.*', '^national,.*', '^neardi,.*', '^nec,.*', '^n=
eofidelity,.*', '^neonode,.*', '^netcube,.*', '^netgear,.*', '^netlogic,.*'=
, '^netron-dy,.*', '^netronix,.*', '^netxeon,.*', '^neweast,.*', '^newhaven=
,.*', '^newvision,.*', '^nexbox,.*', '^nextthing,.*', '^ni,.*', '^nintendo,=
=2E*', '^nlt,.*', '^nokia,.*', '^nordic,.*', '^nothing,.*', '^novatek,.*', =
'^novtech,.*', '^numonyx,.*', '^nutsboard,.*', '^nuvoton,.*', '^nvd,.*', '^=
nvidia,.*', '^nxp,.*', '^oceanic,.*', '^ocs,.*', '^oct,.*', '^okaya,.*', '^=
oki,.*', '^olimex,.*', '^olpc,.*', '^oneplus,.*', '^onie,.*', '^onion,.*', =
'^onnn,.*', '^ontat,.*', '^opalkelly,.*', '^openailab,.*', '^opencores,.*',=
 '^openembed,.*', '^openpandora,.*', '^openrisc,.*', '^openwrt,.*', '^optio=
n,.*', '^oranth,.*', '^orisetech,.*', '^ortustech,.*', '^osddisplays,.*', '=
^osmc,.*', '^ouya,.*', '^overkiz,.*', '^ovti,.*', '^oxsemi,.*', '^ozzmaker,=
=2E*', '^panasonic,.*', '^parade,.*', '^parallax,.*', '^pda,.*', '^pegatron=
,.*', '^pericom,.*', '^pervasive,.*', '^phicomm,.*', '^phytec,.*', '^picoch=
ip,.*', '^pinctrl-[0-9]+$', '^pine64,.*', '^pineriver,.*', '^pixcir,.*', '^=
plantower,.*', '^plathome,.*', '^plda,.*', '^plx,.*', '^ply,.*', '^pni,.*',=
 '^pocketbook,.*', '^polaroid,.*', '^polyhex,.*', '^portwell,.*', '^poslab,=
=2E*', '^pov,.*', '^powertip,.*', '^powervr,.*', '^powkiddy,.*', '^pri,.*',=
 '^primeview,.*', '^primux,.*', '^probox2,.*', '^prt,.*', '^pulsedlight,.*'=
, '^purism,.*', '^puya,.*', '^qca,.*', '^qcom,.*', '^qemu,.*', '^qi,.*', '^=
qiaodian,.*', '^qihua,.*', '^qishenglong,.*', '^qnap,.*', '^quanta,.*', '^r=
adxa,.*', '^raidsonic,.*', '^ralink,.*', '^ramtron,.*', '^raspberrypi,.*', =
'^raydium,.*', '^rda,.*', '^realtek,.*', '^relfor,.*', '^remarkable,.*', '^=
renesas,.*', '^rervision,.*', '^retronix,.*', '^revotics,.*', '^rex,.*', '^=
richtek,.*', '^ricoh,.*', '^rikomagic,.*', '^riot,.*', '^riscv,.*', '^rockc=
hip,.*', '^rocktech,.*', '^rohm,.*', '^ronbo,.*', '^roofull,.*', '^roseappl=
epi,.*', '^rve,.*', '^saef,.*', '^samsung,.*', '^samtec,.*', '^sancloud,.*'=
, '^sandisk,.*', '^satoz,.*', '^sbs,.*', '^schindler,.*', '^schneider,.*', =
'^sciosense,.*', '^seagate,.*', '^seeed,.*', '^seirobotics,.*', '^semtech,.=
*', '^senseair,.*', '^sensirion,.*', '^sensortek,.*', '^sercomm,.*', '^sff,=
=2E*', '^sgd,.*', '^sgmicro,.*', '^sgx,.*', '^sharp,.*', '^shift,.*', '^shi=
mafuji,.*', '^shineworld,.*', '^shiratech,.*', '^si-en,.*', '^si-linux,.*',=
 '^siemens,.*', '^sifive,.*', '^siflower,.*', '^sigma,.*', '^sii,.*', '^sil=
,.*', '^silabs,.*', '^silan,.*', '^silead,.*', '^silergy,.*', '^silex-insig=
ht,.*', '^siliconfile,.*', '^siliconmitus,.*', '^silvaco,.*', '^simtek,.*',=
 '^sinlinx,.*', '^sinovoip,.*', '^sinowealth,.*', '^sipeed,.*', '^sirf,.*',=
 '^sis,.*', '^sitronix,.*', '^skov,.*', '^skyworks,.*', '^smartfiber,.*', '=
^smartlabs,.*', '^smartrg,.*', '^smi,.*', '^smsc,.*', '^snps,.*', '^sochip,=
=2E*', '^socionext,.*', '^solidrun,.*', '^solomon,.*', '^sony,.*', '^sophgo=
,.*', '^sourceparts,.*', '^spacemit,.*', '^spansion,.*', '^sparkfun,.*', '^=
spinalhdl,.*', '^sprd,.*', '^square,.*', '^ssi,.*', '^sst,.*', '^sstar,.*',=
 '^st,.*', '^st-ericsson,.*', '^starfive,.*', '^starry,.*', '^startek,.*', =
'^starterkit,.*', '^ste,.*', '^stericsson,.*', '^storlink,.*', '^storm,.*',=
 '^storopack,.*', '^summit,.*', '^sunchip,.*', '^sundance,.*', '^sunplus,.*=
', '^supermicro,.*', '^swir,.*', '^syna,.*', '^synology,.*', '^synopsys,.*'=
, '^tbs,.*', '^tbs-biometrics,.*', '^tcg,.*', '^tcl,.*', '^tcs,.*', '^tcu,.=
*', '^tdo,.*', '^team-source-display,.*', '^technexion,.*', '^technologic,.=
*', '^techstar,.*', '^techwell,.*', '^teejet,.*', '^teltonika,.*', '^tempo,=
=2E*', '^terasic,.*', '^tesla,.*', '^test,.*', '^tfc,.*', '^thead,.*', '^th=
ine,.*', '^thingyjp,.*', '^thundercomm,.*', '^thwc,.*', '^ti,.*', '^tianma,=
=2E*', '^tlm,.*', '^tmt,.*', '^topeet,.*', '^topic,.*', '^topland,.*', '^to=
ppoly,.*', '^topwise,.*', '^toradex,.*', '^toshiba,.*', '^toumaz,.*', '^tpk=
,.*', '^tplink,.*', '^tpo,.*', '^tq,.*', '^transpeed,.*', '^traverse,.*', '=
^tronfy,.*', '^tronsmart,.*', '^truly,.*', '^tsd,.*', '^turing,.*', '^tyan,=
=2E*', '^tyhx,.*', '^u-blox,.*', '^u-boot,.*', '^ubnt,.*', '^ucrobotics,.*'=
, '^udoo,.*', '^ufispace,.*', '^ugoos,.*', '^ultratronik,.*', '^uni-t,.*', =
'^uniwest,.*', '^upisemi,.*', '^urt,.*', '^usi,.*', '^usr,.*', '^utoo,.*', =
'^v3,.*', '^vaisala,.*', '^vamrs,.*', '^variscite,.*', '^vdl,.*', '^vertexc=
om,.*', '^via,.*', '^vialab,.*', '^vicor,.*', '^videostrong,.*', '^virtio,.=
*', '^virtual,.*', '^vishay,.*', '^visionox,.*', '^vitesse,.*', '^vivante,.=
*', '^vivax,.*', '^vocore,.*', '^voipac,.*', '^voltafield,.*', '^vot,.*', '=
^vscom,.*', '^vxt,.*', '^wacom,.*', '^wanchanglong,.*', '^wand,.*', '^waves=
hare,.*', '^wd,.*', '^we,.*', '^welltech,.*', '^wetek,.*', '^wexler,.*', '^=
whwave,.*', '^wi2wi,.*', '^widora,.*', '^wiligear,.*', '^willsemi,.*', '^wi=
nbond,.*', '^wingtech,.*', '^winlink,.*', '^winsen,.*', '^winstar,.*', '^wi=
relesstag,.*', '^wits,.*', '^wlf,.*', '^wm,.*', '^wobo,.*', '^wolfvision,.*=
', '^x-powers,.*', '^xen,.*', '^xes,.*', '^xiaomi,.*', '^xillybus,.*', '^xi=
ngbangda,.*', '^xinpeng,.*', '^xiphera,.*', '^xlnx,.*', '^xnano,.*', '^xunl=
ong,.*', '^xylon,.*', '^yadro,.*', '^yamaha,.*', '^yes-optoelectronics,.*',=
 '^yic,.*', '^yiming,.*', '^ylm,.*', '^yna,.*', '^yones-toptech,.*', '^ys,.=
*', '^ysoft,.*', '^yuridenki,.*', '^yuzukihd,.*', '^zarlink,.*', '^zealz,.*=
', '^zeitec,.*', '^zidoo,.*', '^zii,.*', '^zinitix,.*', '^zkmagic,.*', '^zt=
e,.*', '^zyxel,.*'
   	from schema $id: http://devicetree.org/schemas/vendor-prefixes.yaml#
   arch/arm/boot/dts/nuvoton/nuvoton-npcm750-runbmc-olympus.dtb: /ahb/spi@c=
0000000: failed to match any schema with compatible: ['nuvoton,npcm750-fiu']
   arch/arm/boot/dts/nuvoton/nuvoton-npcm750-runbmc-olympus.dtb: /ahb/spi@f=
b001000: failed to match any schema with compatible: ['nuvoton,npcm750-fiu']

--=20
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

