Return-Path: <linux-kernel+bounces-757505-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F85BB1C2EA
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 11:09:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CB51F3A4F2C
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 09:09:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9DFD23D288;
	Wed,  6 Aug 2025 09:09:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QaJA4UjC"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EDA51F948
	for <linux-kernel@vger.kernel.org>; Wed,  6 Aug 2025 09:09:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754471388; cv=none; b=YlX3+smnJk7c4tUf+4to8EYOs5m2DmdkpRfY3JbgvXDRUxY85/3GLERJ3CSUMwa5yeEJqwZeoEhWBTIbbLjKrl5t4bpvA29UD0oU31FijSWt/92/kLXYuxFwcRAIjhbhXXkfju7mJ+93RZyTYCath0wQkzR/1dqJq7t88PiRboI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754471388; c=relaxed/simple;
	bh=YF27rcW+wXqHCUE2fpYGKsNDE9fs1ZMhw3o5hYnT3I8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=TscOxie8XUFUh2BMbImHH2qsUFAUUfXlWuiUHYqHL455rhg0ta4e5upkAP2/90PTL9tt6Ofdxhf72qvHPTl58bJX28WlskHnNpZF8n+iNpm1nPA8fc8fCRZn+KXHwdwBNETq/7i4MDq/x9SXTOl0zaaVgUfomq4N6B2J/Qrz/KE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QaJA4UjC; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1754471386; x=1786007386;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=YF27rcW+wXqHCUE2fpYGKsNDE9fs1ZMhw3o5hYnT3I8=;
  b=QaJA4UjCdHlpbyshO/VWVhPPHHzdM3n2taVuji3mViVZIwbSEgfX9FXK
   Vlki0Qin19yjVjxVs+635KyLirHNGLbxqklYGoUQGLa0e0i4bX1S9hgCT
   qY74TVnsjegHxP9hx+Xp4NYpvMxYJzN0zkIY/xgexfQf4zjE/zsPnPUrm
   Na9+i8PCBj6YJImVYv60SmNUUfT2UxjKXezmDv6DzEvfLTa+ZvsAKIPMS
   61oYITx1EqE2GZF48qncKBVR5FYEGEEg21O9mGwUCfCfWsB4OYRC4j5rN
   q6I5ocbjwCPaAIM7/0M99fgIEllXwzqwrh5i6jgjarCdOjGkRTT8owsPx
   w==;
X-CSE-ConnectionGUID: kEfswgNfRFqAXj92RfFRpA==
X-CSE-MsgGUID: y5rrQs/9QziWAK6GMQnvxA==
X-IronPort-AV: E=McAfee;i="6800,10657,11513"; a="82230887"
X-IronPort-AV: E=Sophos;i="6.17,268,1747724400"; 
   d="scan'208";a="82230887"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2025 02:09:46 -0700
X-CSE-ConnectionGUID: 5JOug7IMTa+s4grjhXJaGA==
X-CSE-MsgGUID: pRHtou3TTB6mOFwsfAKzwQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,268,1747724400"; 
   d="scan'208";a="164255586"
Received: from igk-lkp-server01.igk.intel.com (HELO b3b7d4258b7c) ([10.91.175.65])
  by fmviesa007.fm.intel.com with ESMTP; 06 Aug 2025 02:09:44 -0700
Received: from kbuild by b3b7d4258b7c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uja9W-0002Ad-0f;
	Wed, 06 Aug 2025 09:09:42 +0000
Date: Wed, 6 Aug 2025 11:09:05 +0200
From: kernel test robot <lkp@intel.com>
To: Pablo Neira Ayuso <pablo@netfilter.org>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: ld.lld: error: undefined symbol: xt_recseq
Message-ID: <202508061149.iM5f5qtm-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   479058002c32b77acac43e883b92174e22c4be2d
commit: 9fce66583f06c212e95e4b76dd61d8432ffa56b6 netfilter: Exclude LEGACY TABLES on PREEMPT_RT.
date:   12 days ago
config: i386-buildonly-randconfig-2001-20250806 (https://download.01.org/0day-ci/archive/20250806/202508061149.iM5f5qtm-lkp@intel.com/config)
compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250806/202508061149.iM5f5qtm-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202508061149.iM5f5qtm-lkp@intel.com/

All errors (new ones prefixed by >>):

>> ld.lld: error: undefined symbol: xt_recseq
   >>> referenced by x_tables.h:362 (include/linux/netfilter/x_tables.h:362)
   >>>               net/ipv4/netfilter/ip_tables.o:(ipt_do_table) in archive vmlinux.a
   >>> referenced by x_tables.h:369 (include/linux/netfilter/x_tables.h:369)
   >>>               net/ipv4/netfilter/ip_tables.o:(ipt_do_table) in archive vmlinux.a
   >>> referenced by x_tables.h:387 (include/linux/netfilter/x_tables.h:387)
   >>>               net/ipv4/netfilter/ip_tables.o:(ipt_do_table) in archive vmlinux.a
   >>> referenced 4 more times
--
>> ld.lld: error: undefined symbol: xt_alloc_table_info
   >>> referenced by ip_tables.c:1735 (net/ipv4/netfilter/ip_tables.c:1735)
   >>>               net/ipv4/netfilter/ip_tables.o:(ipt_register_table) in archive vmlinux.a
   >>> referenced by ip_tables.c:1126 (net/ipv4/netfilter/ip_tables.c:1126)
   >>>               net/ipv4/netfilter/ip_tables.o:(do_ipt_set_ctl) in archive vmlinux.a
--
>> ld.lld: error: undefined symbol: xt_check_match
   >>> referenced by ip_tables.c:471 (net/ipv4/netfilter/ip_tables.c:471)
   >>>               net/ipv4/netfilter/ip_tables.o:(translate_table) in archive vmlinux.a
--
>> ld.lld: error: undefined symbol: xt_request_find_target
   >>> referenced by ip_tables.c:544 (net/ipv4/netfilter/ip_tables.c:544)
   >>>               net/ipv4/netfilter/ip_tables.o:(translate_table) in archive vmlinux.a
--
>> ld.lld: error: undefined symbol: xt_check_target
   >>> referenced by ip_tables.c:510 (net/ipv4/netfilter/ip_tables.c:510)
   >>>               net/ipv4/netfilter/ip_tables.o:(translate_table) in archive vmlinux.a
--
>> ld.lld: error: undefined symbol: xt_percpu_counter_free
   >>> referenced by ip_tables.c:566 (net/ipv4/netfilter/ip_tables.c:566)
   >>>               net/ipv4/netfilter/ip_tables.o:(translate_table) in archive vmlinux.a
   >>> referenced by ip_tables.c:654 (net/ipv4/netfilter/ip_tables.c:654)
   >>>               net/ipv4/netfilter/ip_tables.o:(cleanup_entry) in archive vmlinux.a
--
>> ld.lld: error: undefined symbol: xt_unregister_table
   >>> referenced by ip_tables.c:1712 (net/ipv4/netfilter/ip_tables.c:1712)
   >>>               net/ipv4/netfilter/ip_tables.o:(__ipt_unregister_table) in archive vmlinux.a
--
>> ld.lld: error: undefined symbol: xt_find_table
   >>> referenced by ip_tables.c:1794 (net/ipv4/netfilter/ip_tables.c:1794)
   >>>               net/ipv4/netfilter/ip_tables.o:(ipt_unregister_table_pre_exit) in archive vmlinux.a
   >>> referenced by ip_tables.c:1802 (net/ipv4/netfilter/ip_tables.c:1802)
   >>>               net/ipv4/netfilter/ip_tables.o:(ipt_unregister_table_exit) in archive vmlinux.a
--
>> ld.lld: error: undefined symbol: xt_copy_counters
   >>> referenced by ip_tables.c:1167 (net/ipv4/netfilter/ip_tables.c:1167)
   >>>               net/ipv4/netfilter/ip_tables.o:(do_ipt_set_ctl) in archive vmlinux.a
--
>> ld.lld: error: undefined symbol: xt_find_table_lock
   >>> referenced by ip_tables.c:1171 (net/ipv4/netfilter/ip_tables.c:1171)
   >>>               net/ipv4/netfilter/ip_tables.o:(do_ipt_set_ctl) in archive vmlinux.a
   >>> referenced by ip_tables.c:1018 (net/ipv4/netfilter/ip_tables.c:1018)
   >>>               net/ipv4/netfilter/ip_tables.o:(do_ipt_get_ctl) in archive vmlinux.a
--
>> ld.lld: error: undefined symbol: xt_table_unlock
   >>> referenced by ip_tables.c:1196 (net/ipv4/netfilter/ip_tables.c:1196)
   >>>               net/ipv4/netfilter/ip_tables.o:(do_ipt_set_ctl) in archive vmlinux.a
   >>> referenced by ip_tables.c:0 (net/ipv4/netfilter/ip_tables.c:0)
   >>>               net/ipv4/netfilter/ip_tables.o:(do_ipt_get_ctl) in archive vmlinux.a
   >>> referenced by ip_tables.c:1076 (net/ipv4/netfilter/ip_tables.c:1076)
   >>>               net/ipv4/netfilter/ip_tables.o:(__do_replace) in archive vmlinux.a
   >>> referenced 1 more times
..

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

