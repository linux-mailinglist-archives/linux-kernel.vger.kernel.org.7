Return-Path: <linux-kernel+bounces-781394-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A122DB311F1
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 10:37:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 748B4189B413
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 08:37:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68D962EB86C;
	Fri, 22 Aug 2025 08:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JxdVYRkB"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FBCA17BA3
	for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 08:37:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755851833; cv=none; b=Gso1G/fSi8HiEGmntJZierTAe4p3XNlSjSDzQ6PLEPnmUqV1Zq0PI/0lKMSH9P/ZMPXEa1x/KkZoI+44HbbNC9EiJwb92XIWCUqi1vsM5f+jAYKdkYMs772lokzwP/tuadArExzJeNgxKcmEx0mp2thkEriJ72RIUdfAmVOB7iA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755851833; c=relaxed/simple;
	bh=eVTZyiZvgqa682S9nJU3vD53mTkSTA+NUYHYOx/YAOg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=c77Ql/wVtivkGrYKp7JZSxxcueb3eRhWh0lCZ5goTVtedFhuI0BUSqbVgULBNZ7bj8S5JOQR22qWgmmcdxUUABP41mkq0Fo1llzLTltqoyuPHoeVlaDhsQNTTdt9m56RexFbuh8DK5B940WvCYrg82cEhrpLQzuqG0CTk2IjPZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JxdVYRkB; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755851833; x=1787387833;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=eVTZyiZvgqa682S9nJU3vD53mTkSTA+NUYHYOx/YAOg=;
  b=JxdVYRkB5NWuzr2s98oOjwCFDna28lM6woDmBmXWoZUwA3jaxjepgr90
   QqSG+bqRE3x9DvvNRokghNL6uNwvxPYR51WBctHuAcPjydJXJDKR5/UlO
   ZNZzzXh0t7klVMi4gCPYLwHDX/8u6wM1YyU9jhmpLAEM7d0oQipxdsvmF
   b4wqhBdi/xVF6y7y8dYnE1XuRtCmnZiKW1CNPxU2VXyJrWwbRaVVp+Fc8
   EzVh0glosm+u2i4y9Ebjp/IfT6Otvx1iTrjR7BkHDiDHZ4XrfYP0tvA6j
   J2/Fkug3L3ZvIhIdGvx2bXSY1Q5OCFm6EouWI2rVGC9Ja6sjbEgktnv1X
   g==;
X-CSE-ConnectionGUID: g04Q4VtNT+yeQZfWycFbvQ==
X-CSE-MsgGUID: gj/g/T+ZQHGC83k+pUq0jA==
X-IronPort-AV: E=McAfee;i="6800,10657,11529"; a="58080538"
X-IronPort-AV: E=Sophos;i="6.17,309,1747724400"; 
   d="scan'208";a="58080538"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Aug 2025 01:37:12 -0700
X-CSE-ConnectionGUID: KTQIfo8ZQ6iQkd9L1JMxkQ==
X-CSE-MsgGUID: ryAUjIpNQ5KD8eRUby/dLg==
X-ExtLoop1: 1
Received: from lkp-server02.sh.intel.com (HELO 4ea60e6ab079) ([10.239.97.151])
  by fmviesa003.fm.intel.com with ESMTP; 22 Aug 2025 01:37:11 -0700
Received: from kbuild by 4ea60e6ab079 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1upNGg-000L4V-0s;
	Fri, 22 Aug 2025 08:37:06 +0000
Date: Fri, 22 Aug 2025 16:36:54 +0800
From: kernel test robot <lkp@intel.com>
To: Song Liu <song@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Alexei Starovoitov <ast@kernel.org>
Subject: {standard input}:27156: Error: operands mismatch -- statement `sub.l
 -228(%fp),-184(%fp)' ignored
Message-ID: <202508221639.OF7OHpcE-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   3957a5720157264dcc41415fbec7c51c4000fc2d
commit: aced132599b3c8884c050218d4c48eef203678f6 bpf: Add range tracking for BPF_NEG
date:   8 weeks ago
config: m68k-randconfig-r133-20250822 (https://download.01.org/0day-ci/archive/20250822/202508221639.OF7OHpcE-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 11.5.0
reproduce: (https://download.01.org/0day-ci/archive/20250822/202508221639.OF7OHpcE-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202508221639.OF7OHpcE-lkp@intel.com/

All errors (new ones prefixed by >>):

   {standard input}: Assembler messages:
>> {standard input}:27156: Error: operands mismatch -- statement `sub.l -228(%fp),-184(%fp)' ignored

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

