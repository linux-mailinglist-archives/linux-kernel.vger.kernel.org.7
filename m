Return-Path: <linux-kernel+bounces-782463-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DF63AB320A9
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 18:42:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A50BB1BA6B6B
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 16:41:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11883305E19;
	Fri, 22 Aug 2025 16:41:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Z8c6Seb9"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3E8E1F463C
	for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 16:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755880859; cv=none; b=DeCRPMv+eBlsB9gjU00dNQkrU2M5LTtjlFkw1bPF5Q6CnsFTYU455Hcpyp1fDFVcJpAhznkD6AAWfLBubfuClAJFMn3Xs17W0n2gWTpJobteSDLSLUlZHNz9Crq2xsW8/MN2Oae8eQTvmtBRTYdlP3TUj4KBwWv27HVQHHvRNpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755880859; c=relaxed/simple;
	bh=AyQJnkOY7LhggcxleC8X8VhttDtWFJaZC+RIscRsowg=;
	h=Date:From:To:Cc:Subject:Message-ID; b=QFXuv//fck4L//f1QkXq5ryMHrRI6brqvqus0pYg6n8+sTQqbMcxjlXZwktBGnm6KNC9fP5r9lGpj0ZZ/PY5zR03nst9gMJ531Bs5z9iGCQNlrB7y8u0zjPttf0fW3gkaRqCWGgV8lm23lsqjl1Xx3QVzXbhoaMqcBcNtj5Gyr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Z8c6Seb9; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755880858; x=1787416858;
  h=date:from:to:cc:subject:message-id;
  bh=AyQJnkOY7LhggcxleC8X8VhttDtWFJaZC+RIscRsowg=;
  b=Z8c6Seb9KZUgIk2IZsHqxOVGfouoo+9o9JAFrV7bgq7eyl0qEwyZxLOF
   AoTMdMkc9K+M+K1ThOR2a7wMn0WKnb8yDG3vnn+289sQnW7+npIT53jXz
   t6eRHNDyJ+der4SicIeUEV7ljpY19J14y+3tddUmtKTPV6NBynNLceiQs
   KKGiiki1gwzHM+No+IkX+MQS9kisio9ZocNkVR+njT5pNvxmtUEVOQfag
   I5lGoHpOwuq/tjVcp10QDM5Is5dhMeVy7EvYXq7+Y34qNu3PNILk0qDaP
   7/dlauPCjVxqk9HHSDe3MtaXXYm9sWYipzgKIPN0CV+Jlm0J3O6BYb3av
   g==;
X-CSE-ConnectionGUID: 80vHh5d6ThaS1ZzvBjcuLQ==
X-CSE-MsgGUID: 5tUJNfkEQXOsNuOfnmakYw==
X-IronPort-AV: E=McAfee;i="6800,10657,11529"; a="80789829"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="80789829"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Aug 2025 09:40:58 -0700
X-CSE-ConnectionGUID: pPMgBbcrQ+qU81I634mJRg==
X-CSE-MsgGUID: WCU7oJxlTge4MboSVAp0Ig==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="168644961"
Received: from lkp-server02.sh.intel.com (HELO 4ea60e6ab079) ([10.239.97.151])
  by fmviesa006.fm.intel.com with ESMTP; 22 Aug 2025 09:40:56 -0700
Received: from kbuild by 4ea60e6ab079 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1upUoX-000LXj-1E;
	Fri, 22 Aug 2025 16:40:40 +0000
Date: Sat, 23 Aug 2025 00:40:20 +0800
From: kernel test robot <lkp@intel.com>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [paulmck-rcu:dev] BUILD SUCCESS
 e64961a5439c79daa0c7075b40fa5b0ba48ed819
Message-ID: <202508230014.cakEHR06-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git dev
branch HEAD: e64961a5439c79daa0c7075b40fa5b0ba48ed819  refscale: Use kcalloc() instead of kzalloc()

elapsed time: 1451m

configs tested: 23
configs skipped: 0

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
i386        buildonly-randconfig-001-20250822    gcc-12
i386        buildonly-randconfig-002-20250822    clang-20
i386        buildonly-randconfig-003-20250822    gcc-12
i386        buildonly-randconfig-004-20250822    gcc-12
i386        buildonly-randconfig-005-20250822    gcc-12
i386        buildonly-randconfig-006-20250822    gcc-12
m68k                              allnoconfig    gcc-15.1.0
microblaze                        allnoconfig    gcc-15.1.0
mips                              allnoconfig    gcc-15.1.0
nios2                             allnoconfig    gcc-11.5.0
openrisc                          allnoconfig    gcc-15.1.0
parisc                            allnoconfig    gcc-15.1.0
powerpc                           allnoconfig    gcc-15.1.0
riscv                             allnoconfig    gcc-15.1.0
sh                                allnoconfig    gcc-15.1.0
sparc                             allnoconfig    gcc-15.1.0
x86_64      buildonly-randconfig-001-20250822    clang-20
x86_64      buildonly-randconfig-002-20250822    gcc-12
x86_64      buildonly-randconfig-003-20250822    clang-20
x86_64      buildonly-randconfig-004-20250822    clang-20
x86_64      buildonly-randconfig-005-20250822    clang-20
x86_64      buildonly-randconfig-006-20250822    gcc-12
xtensa                            allnoconfig    gcc-15.1.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

