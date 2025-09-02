Return-Path: <linux-kernel+bounces-796186-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B38F6B3FD05
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 12:51:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2F1F6188758B
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 10:52:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 973722F5318;
	Tue,  2 Sep 2025 10:51:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="REDAS6jp"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEC252F4A11;
	Tue,  2 Sep 2025 10:51:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756810305; cv=none; b=e9yDQKrR0ULBWWQ0razjZj/pPxIHO0ebPd0I2+P/w/nwo9978IJpDxUC0q0mNOY9QA/IYQ1QItG+kS0IYv0cyOp9clD+4DH14RADCZrgkSSejspfG8Zzl8Z0cXt6n04LFOOH/ZP76qYjw0/+IWUxroIcEhULhrOa/YN4sfgED8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756810305; c=relaxed/simple;
	bh=HHIiljZbBs7wiZU0q755bflQRtXvz3PG1wZFKE7WtPo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mswq8KmED10iqdEsBTuqhMzthmlxAifzzpRZ0tbSSrbhXDTg0CCajDN1WoYXL2MQ+u6tjTltFeiNquUzuI6buSPOhvU9Cy0aL5pHb0MgRN4/rHvxygJyalDem9L6zzZQEwANERSY85enc0FimqX9S8K23VLIz9fUXmiETbOCRUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=REDAS6jp; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756810304; x=1788346304;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=HHIiljZbBs7wiZU0q755bflQRtXvz3PG1wZFKE7WtPo=;
  b=REDAS6jpf53K/qWKg8w7bbCsfsrJV2JHPI47G3h/LRsgd/pw26eX7C7Q
   +lrtNUHzcReinG3fFQShrvfUaoMvF1gyok2GAhC7+ewIecVevU80K4Cjm
   5PUbqjyRnCeT9B4PHmzm3z2PmiBtXrBFIYW866wr55BOsw72Fctfe79E/
   yqHuROyoZQh09XOK+ii2T0xoDA8CL/pPoJ5ltiy/c2ze7IjUHSU7Eaezt
   hstsr1AU1cUgDAgHGdB6z6umRBXg6kSgVW6DKEqjy9yT8TNZv3ucxU4n5
   0HSg7Ygf3oBeQKNTLWd1s+MLVqApbcw2UgnbHcdihmxt4W1Kq3oDGZCHb
   A==;
X-CSE-ConnectionGUID: YLWaLe2GQcC42woVqhiYSw==
X-CSE-MsgGUID: /OQ9Yzd7TKW4JscYxoXnKw==
X-IronPort-AV: E=McAfee;i="6800,10657,11540"; a="76677897"
X-IronPort-AV: E=Sophos;i="6.18,230,1751266800"; 
   d="scan'208";a="76677897"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2025 03:51:43 -0700
X-CSE-ConnectionGUID: BHKg1GMbSFi57jzkUzT7CA==
X-CSE-MsgGUID: 7VxRjEs5SmO746tklY799w==
X-ExtLoop1: 1
Received: from lkp-server02.sh.intel.com (HELO 06ba48ef64e9) ([10.239.97.151])
  by fmviesa003.fm.intel.com with ESMTP; 02 Sep 2025 03:51:39 -0700
Received: from kbuild by 06ba48ef64e9 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1utObw-0001rP-1t;
	Tue, 02 Sep 2025 10:51:36 +0000
Date: Tue, 2 Sep 2025 18:50:38 +0800
From: kernel test robot <lkp@intel.com>
To: Yao Zi <ziyao@disroot.org>, Drew Fustini <fustini@kernel.org>,
	Guo Ren <guoren@kernel.org>, Fu Wei <wefu@redhat.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	Michal Wilczynski <m.wilczynski@samsung.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-riscv@lists.infradead.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	Icenowy Zheng <uwu@icenowy.me>, Han Gao <rabenda.cn@gmail.com>,
	Yao Zi <ziyao@disroot.org>
Subject: Re: [PATCH 3/4] reset: th1520: Support reset controllers in more
 subsystems
Message-ID: <202509021804.FXl7up6q-lkp@intel.com>
References: <20250901042320.22865-4-ziyao@disroot.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250901042320.22865-4-ziyao@disroot.org>

Hi Yao,

kernel test robot noticed the following build warnings:

[auto build test WARNING on pza/reset/next]
[also build test WARNING on next-20250902]
[cannot apply to robh/for-next pza/imx-drm/next linus/master v6.17-rc4]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Yao-Zi/dt-bindings-reset-thead-th1520-reset-Add-controllers-for-more-subsys/20250901-122656
base:   https://git.pengutronix.de/git/pza/linux reset/next
patch link:    https://lore.kernel.org/r/20250901042320.22865-4-ziyao%40disroot.org
patch subject: [PATCH 3/4] reset: th1520: Support reset controllers in more subsystems
config: alpha-randconfig-r133-20250902 (https://download.01.org/0day-ci/archive/20250902/202509021804.FXl7up6q-lkp@intel.com/config)
compiler: alpha-linux-gcc (GCC) 8.5.0
reproduce: (https://download.01.org/0day-ci/archive/20250902/202509021804.FXl7up6q-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202509021804.FXl7up6q-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> drivers/reset/reset-th1520.c:157:10: sparse: sparse: Initializer entry defined twice
   drivers/reset/reset-th1520.c:161:10: sparse:   also defined here
   drivers/reset/reset-th1520.c:808:10: sparse: sparse: Initializer entry defined twice
   drivers/reset/reset-th1520.c:820:10: sparse:   also defined here

vim +157 drivers/reset/reset-th1520.c

   135	
   136	static const struct th1520_reset_map th1520_ap_resets[] = {
   137		[TH1520_RESET_ID_BROM] = {
   138			.bit = BIT(0),
   139			.reg = TH1520_BROM_RST_CFG,
   140		},
   141		[TH1520_RESET_ID_C910_TOP] = {
   142			.bit = BIT(0),
   143			.reg = TH1520_C910_RST_CFG,
   144		},
   145		[TH1520_RESET_ID_NPU] =  {
   146			.bit = BIT(0),
   147			.reg = TH1520_IMG_NNA_RST_CFG,
   148		},
   149		[TH1520_RESET_ID_WDT0] = {
   150			.bit = BIT(0),
   151			.reg = TH1520_WDT0_RST_CFG,
   152		},
   153		[TH1520_RESET_ID_WDT1] = {
   154			.bit = BIT(0),
   155			.reg = TH1520_WDT1_RST_CFG,
   156		},
 > 157		[TH1520_RESET_ID_C910_C0] = {
   158			.bit = BIT(1),
   159			.reg = TH1520_C910_RST_CFG,
   160		},
   161		[TH1520_RESET_ID_C910_C1] = {
   162			.bit = BIT(2),
   163			.reg = TH1520_C910_RST_CFG,
   164		},
   165		[TH1520_RESET_ID_C910_C2] = {
   166			.bit = BIT(3),
   167			.reg = TH1520_C910_RST_CFG,
   168		},
   169		[TH1520_RESET_ID_C910_C3] = {
   170			.bit = BIT(4),
   171			.reg = TH1520_C910_RST_CFG,
   172		},
   173		[TH1520_RESET_ID_CHIP_DBG_CORE] = {
   174			.bit = BIT(0),
   175			.reg = TH1520_CHIP_DBG_RST_CFG,
   176		},
   177		[TH1520_RESET_ID_CHIP_DBG_AXI] = {
   178			.bit = BIT(1),
   179			.reg = TH1520_CHIP_DBG_RST_CFG,
   180		},
   181		[TH1520_RESET_ID_AXI4_CPUSYS2_AXI] = {
   182			.bit = BIT(0),
   183			.reg = TH1520_AXI4_CPUSYS2_RST_CFG,
   184		},
   185		[TH1520_RESET_ID_AXI4_CPUSYS2_APB] = {
   186			.bit = BIT(1),
   187			.reg = TH1520_AXI4_CPUSYS2_RST_CFG,
   188		},
   189		[TH1520_RESET_ID_X2H_CPUSYS] = {
   190			.bit = BIT(0),
   191			.reg = TH1520_X2H_CPUSYS_RST_CFG,
   192		},
   193		[TH1520_RESET_ID_AHB2_CPUSYS] = {
   194			.bit = BIT(0),
   195			.reg = TH1520_AHB2_CPUSYS_RST_CFG,
   196		},
   197		[TH1520_RESET_ID_APB3_CPUSYS] = {
   198			.bit = BIT(0),
   199			.reg = TH1520_APB3_CPUSYS_RST_CFG,
   200		},
   201		[TH1520_RESET_ID_MBOX0_APB] = {
   202			.bit = BIT(0),
   203			.reg = TH1520_MBOX0_RST_CFG,
   204		},
   205		[TH1520_RESET_ID_MBOX1_APB] = {
   206			.bit = BIT(0),
   207			.reg = TH1520_MBOX1_RST_CFG,
   208		},
   209		[TH1520_RESET_ID_MBOX2_APB] = {
   210			.bit = BIT(0),
   211			.reg = TH1520_MBOX2_RST_CFG,
   212		},
   213		[TH1520_RESET_ID_MBOX3_APB] = {
   214			.bit = BIT(0),
   215			.reg = TH1520_MBOX3_RST_CFG,
   216		},
   217		[TH1520_RESET_ID_TIMER0_APB] = {
   218			.bit = BIT(0),
   219			.reg = TH1520_TIMER0_RST_CFG,
   220		},
   221		[TH1520_RESET_ID_TIMER0_CORE] = {
   222			.bit = BIT(1),
   223			.reg = TH1520_TIMER0_RST_CFG,
   224		},
   225		[TH1520_RESET_ID_TIMER1_APB] = {
   226			.bit = BIT(0),
   227			.reg = TH1520_TIMER1_RST_CFG,
   228		},
   229		[TH1520_RESET_ID_TIMER1_CORE] = {
   230			.bit = BIT(1),
   231			.reg = TH1520_TIMER1_RST_CFG,
   232		},
   233		[TH1520_RESET_ID_PERISYS_AHB] = {
   234			.bit = BIT(0),
   235			.reg = TH1520_PERISYS_AHB_RST_CFG,
   236		},
   237		[TH1520_RESET_ID_PERISYS_APB1] = {
   238			.bit = BIT(0),
   239			.reg = TH1520_PERISYS_APB1_RST_CFG,
   240		},
   241		[TH1520_RESET_ID_PERISYS_APB2] = {
   242			.bit = BIT(0),
   243			.reg = TH1520_PERISYS_APB2_RST_CFG,
   244		},
   245		[TH1520_RESET_ID_GMAC0_APB] = {
   246			.bit = BIT(0),
   247			.reg = TH1520_GMAC0_RST_CFG,
   248		},
   249		[TH1520_RESET_ID_GMAC0_AHB] = {
   250			.bit = BIT(1),
   251			.reg = TH1520_GMAC0_RST_CFG,
   252		},
   253		[TH1520_RESET_ID_GMAC0_CLKGEN] = {
   254			.bit = BIT(2),
   255			.reg = TH1520_GMAC0_RST_CFG,
   256		},
   257		[TH1520_RESET_ID_GMAC0_AXI] = {
   258			.bit = BIT(3),
   259			.reg = TH1520_GMAC0_RST_CFG,
   260		},
   261		[TH1520_RESET_ID_UART0_APB] = {
   262			.bit = BIT(0),
   263			.reg = TH1520_UART0_RST_CFG,
   264		},
   265		[TH1520_RESET_ID_UART0_IF] = {
   266			.bit = BIT(1),
   267			.reg = TH1520_UART0_RST_CFG,
   268		},
   269		[TH1520_RESET_ID_UART1_APB] = {
   270			.bit = BIT(0),
   271			.reg = TH1520_UART1_RST_CFG,
   272		},
   273		[TH1520_RESET_ID_UART1_IF] = {
   274			.bit = BIT(1),
   275			.reg = TH1520_UART1_RST_CFG,
   276		},
   277		[TH1520_RESET_ID_UART2_APB] = {
   278			.bit = BIT(0),
   279			.reg = TH1520_UART2_RST_CFG,
   280		},
   281		[TH1520_RESET_ID_UART2_IF] = {
   282			.bit = BIT(1),
   283			.reg = TH1520_UART2_RST_CFG,
   284		},
   285		[TH1520_RESET_ID_UART3_APB] = {
   286			.bit = BIT(0),
   287			.reg = TH1520_UART3_RST_CFG,
   288		},
   289		[TH1520_RESET_ID_UART3_IF] = {
   290			.bit = BIT(1),
   291			.reg = TH1520_UART3_RST_CFG,
   292		},
   293		[TH1520_RESET_ID_UART4_APB] = {
   294			.bit = BIT(0),
   295			.reg = TH1520_UART4_RST_CFG,
   296		},
   297		[TH1520_RESET_ID_UART4_IF] = {
   298			.bit = BIT(1),
   299			.reg = TH1520_UART4_RST_CFG,
   300		},
   301		[TH1520_RESET_ID_UART5_APB] = {
   302			.bit = BIT(0),
   303			.reg = TH1520_UART5_RST_CFG,
   304		},
   305		[TH1520_RESET_ID_UART5_IF] = {
   306			.bit = BIT(1),
   307			.reg = TH1520_UART5_RST_CFG,
   308		},
   309		[TH1520_RESET_ID_QSPI0_IF] = {
   310			.bit = BIT(0),
   311			.reg = TH1520_QSPI0_RST_CFG,
   312		},
   313		[TH1520_RESET_ID_QSPI0_APB] = {
   314			.bit = BIT(1),
   315			.reg = TH1520_QSPI0_RST_CFG,
   316		},
   317		[TH1520_RESET_ID_QSPI1_IF] = {
   318			.bit = BIT(0),
   319			.reg = TH1520_QSPI1_RST_CFG,
   320		},
   321		[TH1520_RESET_ID_QSPI1_APB] = {
   322			.bit = BIT(1),
   323			.reg = TH1520_QSPI1_RST_CFG,
   324		},
   325		[TH1520_RESET_ID_SPI_IF] = {
   326			.bit = BIT(0),
   327			.reg = TH1520_SPI_RST_CFG,
   328		},
   329		[TH1520_RESET_ID_SPI_APB] = {
   330			.bit = BIT(1),
   331			.reg = TH1520_SPI_RST_CFG,
   332		},
   333		[TH1520_RESET_ID_I2C0_APB] = {
   334			.bit = BIT(0),
   335			.reg = TH1520_I2C0_RST_CFG,
   336		},
   337		[TH1520_RESET_ID_I2C0_CORE] = {
   338			.bit = BIT(1),
   339			.reg = TH1520_I2C0_RST_CFG,
   340		},
   341		[TH1520_RESET_ID_I2C1_APB] = {
   342			.bit = BIT(0),
   343			.reg = TH1520_I2C1_RST_CFG,
   344		},
   345		[TH1520_RESET_ID_I2C1_CORE] = {
   346			.bit = BIT(1),
   347			.reg = TH1520_I2C1_RST_CFG,
   348		},
   349		[TH1520_RESET_ID_I2C2_APB] = {
   350			.bit = BIT(0),
   351			.reg = TH1520_I2C2_RST_CFG,
   352		},
   353		[TH1520_RESET_ID_I2C2_CORE] = {
   354			.bit = BIT(1),
   355			.reg = TH1520_I2C2_RST_CFG,
   356		},
   357		[TH1520_RESET_ID_I2C3_APB] = {
   358			.bit = BIT(0),
   359			.reg = TH1520_I2C3_RST_CFG,
   360		},
   361		[TH1520_RESET_ID_I2C3_CORE] = {
   362			.bit = BIT(1),
   363			.reg = TH1520_I2C3_RST_CFG,
   364		},
   365		[TH1520_RESET_ID_I2C4_APB] = {
   366			.bit = BIT(0),
   367			.reg = TH1520_I2C4_RST_CFG,
   368		},
   369		[TH1520_RESET_ID_I2C4_CORE] = {
   370			.bit = BIT(1),
   371			.reg = TH1520_I2C4_RST_CFG,
   372		},
   373		[TH1520_RESET_ID_I2C5_APB] = {
   374			.bit = BIT(0),
   375			.reg = TH1520_I2C5_RST_CFG,
   376		},
   377		[TH1520_RESET_ID_I2C5_CORE] = {
   378			.bit = BIT(1),
   379			.reg = TH1520_I2C5_RST_CFG,
   380		},
   381		[TH1520_RESET_ID_GPIO0_DB] = {
   382			.bit = BIT(0),
   383			.reg = TH1520_GPIO0_RST_CFG,
   384		},
   385		[TH1520_RESET_ID_GPIO0_APB] = {
   386			.bit = BIT(1),
   387			.reg = TH1520_GPIO0_RST_CFG,
   388		},
   389		[TH1520_RESET_ID_GPIO1_DB] = {
   390			.bit = BIT(0),
   391			.reg = TH1520_GPIO1_RST_CFG,
   392		},
   393		[TH1520_RESET_ID_GPIO1_APB] = {
   394			.bit = BIT(1),
   395			.reg = TH1520_GPIO1_RST_CFG,
   396		},
   397		[TH1520_RESET_ID_GPIO2_DB] = {
   398			.bit = BIT(0),
   399			.reg = TH1520_GPIO2_RST_CFG,
   400		},
   401		[TH1520_RESET_ID_GPIO2_APB] = {
   402			.bit = BIT(1),
   403			.reg = TH1520_GPIO2_RST_CFG,
   404		},
   405		[TH1520_RESET_ID_PWM_COUNTER] = {
   406			.bit = BIT(0),
   407			.reg = TH1520_PWM_RST_CFG,
   408		},
   409		[TH1520_RESET_ID_PWM_APB] = {
   410			.bit = BIT(1),
   411			.reg = TH1520_PWM_RST_CFG,
   412		},
   413		[TH1520_RESET_ID_PADCTRL0_APB] = {
   414			.bit = BIT(0),
   415			.reg = TH1520_PADCTRL0_APSYS_RST_CFG,
   416		},
   417		[TH1520_RESET_ID_CPU2PERI_X2H] = {
   418			.bit = BIT(1),
   419			.reg = TH1520_CPU2PERI_X2H_RST_CFG,
   420		},
   421		[TH1520_RESET_ID_CPU2AON_X2H] = {
   422			.bit = BIT(0),
   423			.reg = TH1520_CPU2AON_X2H_RST_CFG,
   424		},
   425		[TH1520_RESET_ID_AON2CPU_A2X] = {
   426			.bit = BIT(0),
   427			.reg = TH1520_AON2CPU_A2X_RST_CFG,
   428		},
   429		[TH1520_RESET_ID_NPUSYS_AXI] = {
   430			.bit = BIT(0),
   431			.reg = TH1520_NPUSYS_AXI_RST_CFG,
   432		},
   433		[TH1520_RESET_ID_NPUSYS_AXI_APB] = {
   434			.bit = BIT(1),
   435			.reg = TH1520_NPUSYS_AXI_RST_CFG,
   436		},
   437		[TH1520_RESET_ID_CPU2VP_X2P] = {
   438			.bit = BIT(0),
   439			.reg = TH1520_CPU2VP_X2P_RST_CFG,
   440		},
   441		[TH1520_RESET_ID_CPU2VI_X2H] = {
   442			.bit = BIT(0),
   443			.reg = TH1520_CPU2VI_X2H_RST_CFG,
   444		},
   445		[TH1520_RESET_ID_BMU_AXI] = {
   446			.bit = BIT(0),
   447			.reg = TH1520_BMU_C910_RST_CFG,
   448		},
   449		[TH1520_RESET_ID_BMU_APB] = {
   450			.bit = BIT(1),
   451			.reg = TH1520_BMU_C910_RST_CFG,
   452		},
   453		[TH1520_RESET_ID_DMAC_CPUSYS_AXI] = {
   454			.bit = BIT(0),
   455			.reg = TH1520_DMAC_CPUSYS_RST_CFG,
   456		},
   457		[TH1520_RESET_ID_DMAC_CPUSYS_AHB] = {
   458			.bit = BIT(1),
   459			.reg = TH1520_DMAC_CPUSYS_RST_CFG,
   460		},
   461		[TH1520_RESET_ID_SPINLOCK] = {
   462			.bit = BIT(0),
   463			.reg = TH1520_SPINLOCK_RST_CFG,
   464		},
   465		[TH1520_RESET_ID_CFG2TEE] = {
   466			.bit = BIT(0),
   467			.reg = TH1520_CFG2TEE_X2H_RST_CFG,
   468		},
   469		[TH1520_RESET_ID_DSMART] = {
   470			.bit = BIT(0),
   471			.reg = TH1520_DSMART_RST_CFG,
   472		},
   473		[TH1520_RESET_ID_GPIO3_DB] = {
   474			.bit = BIT(0),
   475			.reg = TH1520_GPIO3_RST_CFG,
   476		},
   477		[TH1520_RESET_ID_GPIO3_APB] = {
   478			.bit = BIT(1),
   479			.reg = TH1520_GPIO3_RST_CFG,
   480		},
   481		[TH1520_RESET_ID_PERI_I2S] = {
   482			.bit = BIT(0),
   483			.reg = TH1520_I2S_RST_CFG,
   484		},
   485		[TH1520_RESET_ID_PERI_APB3] = {
   486			.bit = BIT(0),
   487			.reg = TH1520_PERI_APB3_RST_CFG,
   488		},
   489		[TH1520_RESET_ID_PERI2PERI1_APB] = {
   490			.bit = BIT(1),
   491			.reg = TH1520_PERI_APB3_RST_CFG,
   492		},
   493		[TH1520_RESET_ID_VPSYS_APB] = {
   494			.bit = BIT(0),
   495			.reg = TH1520_VP_SUBSYS_RST_CFG,
   496		},
   497		[TH1520_RESET_ID_PERISYS_APB4] = {
   498			.bit = BIT(0),
   499			.reg = TH1520_PERISYS_APB4_RST_CFG,
   500		},
   501		[TH1520_RESET_ID_GMAC1_APB] = {
   502			.bit = BIT(0),
   503			.reg = TH1520_GMAC1_RST_CFG,
   504		},
   505		[TH1520_RESET_ID_GMAC1_AHB] = {
   506			.bit = BIT(1),
   507			.reg = TH1520_GMAC1_RST_CFG,
   508		},
   509		[TH1520_RESET_ID_GMAC1_CLKGEN] = {
   510			.bit = BIT(2),
   511			.reg = TH1520_GMAC1_RST_CFG,
   512		},
   513		[TH1520_RESET_ID_GMAC1_AXI] = {
   514			.bit = BIT(3),
   515			.reg = TH1520_GMAC1_RST_CFG,
   516		},
   517		[TH1520_RESET_ID_GMAC_AXI] = {
   518			.bit = BIT(0),
   519			.reg = TH1520_GMAC_AXI_RST_CFG,
   520		},
   521		[TH1520_RESET_ID_GMAC_AXI_APB] = {
   522			.bit = BIT(1),
   523			.reg = TH1520_GMAC_AXI_RST_CFG,
   524		},
   525		[TH1520_RESET_ID_PADCTRL1_APB] = {
   526			.bit = BIT(0),
   527			.reg = TH1520_PADCTRL1_APSYS_RST_CFG,
   528		},
   529		[TH1520_RESET_ID_VOSYS_AXI] = {
   530			.bit = BIT(0),
   531			.reg = TH1520_VOSYS_AXI_RST_CFG,
   532		},
   533		[TH1520_RESET_ID_VOSYS_AXI_APB] = {
   534			.bit = BIT(1),
   535			.reg = TH1520_VOSYS_AXI_RST_CFG,
   536		},
   537		[TH1520_RESET_ID_VOSYS_AXI_X2X] = {
   538			.bit = BIT(0),
   539			.reg = TH1520_VOSYS_X2X_RST_CFG,
   540		},
   541		[TH1520_RESET_ID_MISC2VP_X2X] = {
   542			.bit = BIT(0),
   543			.reg = TH1520_MISC2VP_X2X_RST_CFG,
   544		},
   545		[TH1520_RESET_ID_DSPSYS] = {
   546			.bit = BIT(0),
   547			.reg = TH1520_SUBSYS_RST_CFG,
   548		},
   549		[TH1520_RESET_ID_VISYS] = {
   550			.bit = BIT(1),
   551			.reg = TH1520_SUBSYS_RST_CFG,
   552		},
   553		[TH1520_RESET_ID_VOSYS] = {
   554			.bit = BIT(2),
   555			.reg = TH1520_SUBSYS_RST_CFG,
   556		},
   557		[TH1520_RESET_ID_VPSYS] = {
   558			.bit = BIT(3),
   559			.reg = TH1520_SUBSYS_RST_CFG,
   560		},
   561	};
   562	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

