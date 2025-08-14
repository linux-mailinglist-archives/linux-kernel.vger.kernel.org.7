Return-Path: <linux-kernel+bounces-769519-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B002B26FBD
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 21:34:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E9F15683B1B
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 19:32:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 098941D5CFE;
	Thu, 14 Aug 2025 19:32:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QM/qGgU8"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60EB51C84B2;
	Thu, 14 Aug 2025 19:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755199946; cv=none; b=My8R4G1jhPSMu7k/uWIDRIcy2kHTe09b0s74TE1oRd8hdsV0pwRZ0xFhOVT4ID2roXG64SdyRoE4ZR79mIAeOXybBnAW/ex6jvMqBuR+PzR0ZZsIWGIEuds8uNJmEO4K72fKwmORZVXtIDr5kzTSygyLSNJ6hyXFmYyM2WG3K3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755199946; c=relaxed/simple;
	bh=sYNHy3au3eJJGLyMM/KY+GBcda4zdf0KZ+o9Rn0lDjo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WZi2ECAFOhZjWWezQr5kXRwyXhAW34v4+nRIRpcmAaNq8IXQ8Oal1dMFUGSFb2eC7Ga2ytDKMOjtXYtOTlTodXi4JtlcD+gZunAxVhYfXgJ0/6EwaJQsC6Hbr4pxiHZ4/FPgZ6m7RsFkKd9Hq/3VDOxV8z66cxnnucrx+1wp48c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QM/qGgU8; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755199944; x=1786735944;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=sYNHy3au3eJJGLyMM/KY+GBcda4zdf0KZ+o9Rn0lDjo=;
  b=QM/qGgU80J7/supyHIAviDnguX7UcjoJEbL9q/PjAD1irmHMML4CGQAx
   2h/ULz73Or52EI4i9udrUztbbrXCQXbLlrUIr2QnrTsv3V7y9cLUVdaIW
   ZynKYkdgp/kLRCbaJLonRG6ZvEy8YV5DOrtTeYzoH11pZeDzAeQ5YPoK1
   Hoa+CaIxIAGy6WVNAeDB8FyCprgMz3Li6wNpdvCynYWf9AxjMes7rZxD0
   kn9315ud2Nc0wlt4dPIo2/5U3zAv50u9uGgdWzVRaHoOrx2G+C0a4qmLE
   xfrPYuPX0BeKl8kEYAZRWDputYg73CkHv+/T5YqwxWKomIJlbAt1D1p+G
   g==;
X-CSE-ConnectionGUID: 4w2Qi4RCRTijK0UV0O1gBw==
X-CSE-MsgGUID: uWe/8uy3Q5mTHssJ1EhdNg==
X-IronPort-AV: E=McAfee;i="6800,10657,11522"; a="68226981"
X-IronPort-AV: E=Sophos;i="6.17,290,1747724400"; 
   d="scan'208";a="68226981"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Aug 2025 12:32:23 -0700
X-CSE-ConnectionGUID: Zw1G2UnqTsuBfPLENwqAVA==
X-CSE-MsgGUID: EWHfKfNOQs+XEJGaMZISwQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,290,1747724400"; 
   d="scan'208";a="166807007"
Received: from lkp-server02.sh.intel.com (HELO 4ea60e6ab079) ([10.239.97.151])
  by orviesa007.jf.intel.com with ESMTP; 14 Aug 2025 12:32:19 -0700
Received: from kbuild by 4ea60e6ab079 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1umdgP-000BGs-08;
	Thu, 14 Aug 2025 19:32:17 +0000
Date: Fri, 15 Aug 2025 03:31:56 +0800
From: kernel test robot <lkp@intel.com>
To: Xiandong Wang <xiandong.wang@mediatek.com>,
	Jassi Brar <jassisinghbrar@gmail.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Houlong Wei <houlong.wei@mediatek.com>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, sirius.wang@mediatek.com,
	vince-wl.liu@mediatek.com, jh.hsu@mediatek.com,
	Project_Global_Chrome_Upstream_Group@mediatek.com,
	Xiandong Wang <xiandong.wang@mediatek.com>
Subject: Re: [PATCH v1 2/4] [v1,02/04]mailbox: mtk-cmdq: Add cmdq driver for
 mt8189
Message-ID: <202508150338.bTVJvFtV-lkp@intel.com>
References: <20250814070401.13432-2-xiandong.wang@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250814070401.13432-2-xiandong.wang@mediatek.com>

Hi Xiandong,

kernel test robot noticed the following build errors:

[auto build test ERROR on jassibrar-mailbox/for-next]
[also build test ERROR on linus/master v6.17-rc1 next-20250814]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Xiandong-Wang/mailbox-mtk-cmdq-Add-cmdq-driver-for-mt8189/20250814-152237
base:   https://git.kernel.org/pub/scm/linux/kernel/git/jassibrar/mailbox.git for-next
patch link:    https://lore.kernel.org/r/20250814070401.13432-2-xiandong.wang%40mediatek.com
patch subject: [PATCH v1 2/4] [v1,02/04]mailbox: mtk-cmdq: Add cmdq driver for mt8189
config: x86_64-buildonly-randconfig-004-20250815 (https://download.01.org/0day-ci/archive/20250815/202508150338.bTVJvFtV-lkp@intel.com/config)
compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250815/202508150338.bTVJvFtV-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202508150338.bTVJvFtV-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/mailbox/mtk-cmdq-mailbox.c:781:3: error: field designator 'mminfra_offset' does not refer to any field in type 'const struct gce_plat'
     781 |         .mminfra_offset = 0x40000000, /* 1GB */
         |         ~^~~~~~~~~~~~~~~~~~~~~~~~~~~
>> drivers/mailbox/mtk-cmdq-mailbox.c:784:3: error: field designator 'dma_mask_bit' does not refer to any field in type 'const struct gce_plat'
     784 |         .dma_mask_bit = 35,
         |         ~^~~~~~~~~~~~~~~~~
>> drivers/mailbox/mtk-cmdq-mailbox.c:785:3: error: field designator 'secure_thread_nr' does not refer to any field in type 'const struct gce_plat'
     785 |         .secure_thread_nr = 2,
         |         ~^~~~~~~~~~~~~~~~~~~~
>> drivers/mailbox/mtk-cmdq-mailbox.c:786:3: error: field designator 'secure_thread_min' does not refer to any field in type 'const struct gce_plat'
     786 |         .secure_thread_min = 8,
         |         ~^~~~~~~~~~~~~~~~~~~~~
   4 errors generated.


vim +781 drivers/mailbox/mtk-cmdq-mailbox.c

   777	
   778	static const struct gce_plat gce_plat_mt8189 = {
   779		.thread_nr = 32,
   780		.shift = 3,
 > 781		.mminfra_offset = 0x40000000, /* 1GB */
   782		.control_by_sw = false,
   783		.sw_ddr_en = true,
 > 784		.dma_mask_bit = 35,
 > 785		.secure_thread_nr = 2,
 > 786		.secure_thread_min = 8,
   787		.gce_num = 2
   788	};
   789	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

