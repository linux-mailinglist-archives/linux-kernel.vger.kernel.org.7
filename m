Return-Path: <linux-kernel+bounces-887301-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 38134C37CCC
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 21:56:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A1CA418C7392
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 20:57:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E81072D9ECA;
	Wed,  5 Nov 2025 20:56:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZsjC98xH"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0874B2D8395;
	Wed,  5 Nov 2025 20:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762376211; cv=none; b=oXiY2Kp4bhOMVXIp9CQHboeCVsOQ9JBTW1d3vohGljP+dKaUbyGPukdoV+CB13Tel8QJBlu2SK1fABHOsXUG68++1DQYvrdLFISRvIoqMfMuYKuKiVuF/hERexijCRenXmpUAq8n+xpX4j47UpPOtGifqYudmAk8XidWxIf9RS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762376211; c=relaxed/simple;
	bh=3YWwgQi9pamq55MRiyGIwd2ciVp732wOAixp3u9/Wuw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SOl/ZF9JCRKr55dEKVumx4SBOERjYkG/8CRXUkgRT4F0wwuPY30cu1vwPIt+gG6w16MUmj5vf6Iq7mKDeEfOXDNz1Rar2G4xm0ja2AEhXJ3ExsqpZG7tzngAF41yCMolXlpSQnTMzlwOM/BB6SSXRH6voNzFfC1JK2jnrdoX3/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZsjC98xH; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762376209; x=1793912209;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=3YWwgQi9pamq55MRiyGIwd2ciVp732wOAixp3u9/Wuw=;
  b=ZsjC98xH7KI0j1QD4JT6FzGSZSYhj5D4IqdonbwKSRNUUYsGeF4Mi12C
   kZoFNAZrH5mc9NVa7KiR3Ei6alkQXExbYIiDQyvaDWwd4qWvDY6sZLr9l
   3Ph0z1sTrBigW1te6+vvBxxWFZvvJmbPPaUSxsArbNmFbGk/QCMz0c4US
   tQ57/AY8wW9n1uN3YMR60l/ou5weYDLTEL+cz0KgAuR8twUCT0gpvg8jH
   d9K1i7iirv2j1c28la/bk3BA1TIeOb7FRLW4o3ReW6MvrJvzLal+otQNL
   8rBbZoSojLO6+LiNSQvhjLSCX9V63gnerPhDuoAkrxax3PRgF+Y9tuJqD
   g==;
X-CSE-ConnectionGUID: WWMiK09RQOSo9Tf+hbI3ag==
X-CSE-MsgGUID: rjLPVqIFT9aiFWSaOQONaw==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="64410268"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="64410268"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2025 12:56:48 -0800
X-CSE-ConnectionGUID: U0kr8VC2QQ+/FFBt+8TnkA==
X-CSE-MsgGUID: 1yNn68zFSRKVXmbGcuHY7w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,282,1754982000"; 
   d="scan'208";a="191664887"
Received: from lkp-server02.sh.intel.com (HELO 66d7546c76b2) ([10.239.97.151])
  by orviesa003.jf.intel.com with ESMTP; 05 Nov 2025 12:56:46 -0800
Received: from kbuild by 66d7546c76b2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1vGkYH-000T7k-29;
	Wed, 05 Nov 2025 20:56:22 +0000
Date: Thu, 6 Nov 2025 04:55:22 +0800
From: kernel test robot <lkp@intel.com>
To: Gatien Chevallier <gatien.chevallier@foss.st.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>
Cc: oe-kbuild-all@lists.linux.dev, devicetree@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	Gatien Chevallier <gatien.chevallier@foss.st.com>
Subject: Re: [PATCH 3/3] bus: rifsc: add debugfs entry to dump the firewall
 configuration
Message-ID: <202511060449.FdKTConU-lkp@intel.com>
References: <20251104-rifsc_debugfs-v1-3-7ebdfbf8d33f@foss.st.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251104-rifsc_debugfs-v1-3-7ebdfbf8d33f@foss.st.com>

Hi Gatien,

kernel test robot noticed the following build warnings:

[auto build test WARNING on 6146a0f1dfae5d37442a9ddcba012add260bceb0]

url:    https://github.com/intel-lab-lkp/linux/commits/Gatien-Chevallier/dt-bindings-bus-add-stm32mp21-RIFSC-compatible/20251104-215726
base:   6146a0f1dfae5d37442a9ddcba012add260bceb0
patch link:    https://lore.kernel.org/r/20251104-rifsc_debugfs-v1-3-7ebdfbf8d33f%40foss.st.com
patch subject: [PATCH 3/3] bus: rifsc: add debugfs entry to dump the firewall configuration
config: csky-randconfig-r062-20251105 (https://download.01.org/0day-ci/archive/20251106/202511060449.FdKTConU-lkp@intel.com/config)
compiler: csky-linux-gcc (GCC) 15.1.0

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202511060449.FdKTConU-lkp@intel.com/

cocci warnings: (new ones prefixed by >>)
>> drivers/bus/stm32_rifsc.c:538:6-33: opportunity for str_enabled_disabled(d_dbg_entry . dev_cid_filt_en)
>> drivers/bus/stm32_rifsc.c:540:6-28: opportunity for str_enabled_disabled(d_dbg_entry . dev_sem_en)
>> drivers/bus/stm32_rifsc.c:596:8-30: opportunity for str_enabled_disabled(sr_dbg_entry . sr_enable)

vim +538 drivers/bus/stm32_rifsc.c

   505	
   506	static int stm32_rifsc_conf_dump_show(struct seq_file *s, void *data)
   507	{
   508		struct rifsc_dbg_private *rifsc = (struct rifsc_dbg_private *)s->private;
   509		int i, j;
   510	
   511		seq_puts(s, "\n=============================================\n");
   512		seq_puts(s, "                 RIFSC dump\n");
   513		seq_puts(s, "=============================================\n\n");
   514	
   515		seq_puts(s, "\n=============================================\n");
   516		seq_puts(s, "                 RISUP dump\n");
   517		seq_puts(s, "=============================================\n");
   518	
   519		seq_printf(s, "\n| %-15s |", "Peripheral name");
   520		seq_puts(s, "| Firewall ID |");
   521		seq_puts(s, "| N/SECURE |");
   522		seq_puts(s, "| N/PRIVILEGED |");
   523		seq_puts(s, "| CID filtering |");
   524		seq_puts(s, "| Semaphore mode |");
   525		seq_puts(s, "| SCID |");
   526		seq_printf(s, "| %7s |\n", "SEMWL");
   527	
   528		for (i = 0; i < RIFSC_RISUP_ENTRIES && i < rifsc->nb_risup; i++) {
   529			struct rifsc_risup_debug_data d_dbg_entry;
   530	
   531			stm32_rifsc_fill_dev_dbg_entry(rifsc, &d_dbg_entry, i);
   532	
   533			seq_printf(s, "| %-15s |", d_dbg_entry.dev_name);
   534			seq_printf(s, "| %-11d |", d_dbg_entry.dev_id);
   535			seq_printf(s, "| %-8s |", d_dbg_entry.dev_sec ? "SEC" : "NSEC");
   536			seq_printf(s, "| %-12s |", d_dbg_entry.dev_priv ? "PRIV" : "NPRIV");
   537			seq_printf(s, "| %-13s |",
 > 538				   d_dbg_entry.dev_cid_filt_en ? "enabled" : "disabled");
   539			seq_printf(s, "| %-14s |",
 > 540				   d_dbg_entry.dev_sem_en ? "enabled" : "disabled");
   541			seq_printf(s, "| %-4d |", d_dbg_entry.dev_cid);
   542			seq_printf(s, "| %#-7x |\n", d_dbg_entry.dev_sem_cids);
   543		}
   544	
   545		seq_puts(s, "\n=============================================\n");
   546		seq_puts(s, "                  RIMU dump\n");
   547		seq_puts(s, "=============================================\n");
   548	
   549		seq_puts(s, "| RIMU's name |");
   550		seq_puts(s, "| CIDSEL |");
   551		seq_puts(s, "| MCID |");
   552		seq_puts(s, "| N/SECURE |");
   553		seq_puts(s, "| N/PRIVILEGED |\n");
   554	
   555		for (i = 0; i < RIFSC_RIMU_ENTRIES && rifsc->nb_rimu; i++) {
   556			struct rifsc_rimu_debug_data m_dbg_entry;
   557	
   558			stm32_rifsc_fill_rimu_dbg_entry(rifsc, &m_dbg_entry, i);
   559	
   560			seq_printf(s, "| %-11s |", m_dbg_entry.m_name);
   561			seq_printf(s, "| %-6s |", m_dbg_entry.cidsel ? "CIDSEL" : "");
   562			seq_printf(s, "| %-4d |", m_dbg_entry.m_cid);
   563			seq_printf(s, "| %-8s |", m_dbg_entry.m_sec ? "SEC" : "NSEC");
   564			seq_printf(s, "| %-12s |\n", m_dbg_entry.m_priv ? "PRIV" : "NPRIV");
   565		}
   566	
   567		if (rifsc->nb_risal > 0) {
   568			seq_puts(s, "\n=============================================\n");
   569			seq_puts(s, "                  RISAL dump\n");
   570			seq_puts(s, "=============================================\n");
   571	
   572			seq_puts(s, "| Memory  |");
   573			seq_puts(s, "| Subreg. |");
   574			seq_puts(s, "| N/SECURE |");
   575			seq_puts(s, "| N/PRIVILEGED |");
   576			seq_puts(s, "| Subreg. CID |");
   577			seq_puts(s, "| Resource lock |");
   578			seq_puts(s, "| Subreg. enable |");
   579			seq_puts(s, "| Subreg. start |");
   580			seq_puts(s, "|  Subreg. end  |\n");
   581	
   582			for (i = 0; i < rifsc->nb_risal; i++) {
   583				for (j = 0; j < RIFSC_RISAL_SUBREGIONS; j++) {
   584					struct rifsc_subreg_debug_data sr_dbg_entry;
   585	
   586					stm32_rifsc_fill_subreg_dbg_entry(rifsc, &sr_dbg_entry, i, j);
   587	
   588					seq_printf(s, "| LPSRAM%1d |", i + 1);
   589					seq_printf(s, "|    %1s    |", (j == 0) ? "A" : "B");
   590					seq_printf(s, "| %-8s |", sr_dbg_entry.sr_sec ? "SEC" : "NSEC");
   591					seq_printf(s, "| %-12s |", sr_dbg_entry.sr_priv ? "PRIV" : "NPRIV");
   592					seq_printf(s, "| 0x%-9x |", sr_dbg_entry.sr_cid);
   593					seq_printf(s, "| %-13s |",
   594						   sr_dbg_entry.sr_rlock ? "locked (1)" : "unlocked (0)");
   595					seq_printf(s, "| %-14s |",
 > 596						   sr_dbg_entry.sr_enable ? "enabled" : "disabled");
   597	
   598					seq_printf(s, "| 0x%-11x |", sr_dbg_entry.sr_start);
   599					seq_printf(s, "| 0x%-11x |\n", sr_dbg_entry.sr_start +
   600						   sr_dbg_entry.sr_length - 1);
   601				}
   602			}
   603		}
   604	
   605		return 0;
   606	}
   607	DEFINE_SHOW_ATTRIBUTE(stm32_rifsc_conf_dump);
   608	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

