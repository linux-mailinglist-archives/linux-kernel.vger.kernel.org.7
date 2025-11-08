Return-Path: <linux-kernel+bounces-891673-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD78CC43388
	for <lists+linux-kernel@lfdr.de>; Sat, 08 Nov 2025 19:48:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4DE9C3AE1FC
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Nov 2025 18:48:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CDC62749C9;
	Sat,  8 Nov 2025 18:48:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TVIwHVGx"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79C28C8CE
	for <linux-kernel@vger.kernel.org>; Sat,  8 Nov 2025 18:48:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762627715; cv=none; b=jvS3fg848hDCQ9nUEQhx7uVIytVs1SYkqIYWvDqediT8dTj9la7elNZHFK84tEAwZCcTae/3P3rACRVqPPWS/N7VlfG+65p8ipRaHcXOPzn1qGe8c5m3TcFyNO+mXuJ/wOcahvjAUe/Wt2VsF9aF7BDqAMP4PqgMYnCh1GpM6vM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762627715; c=relaxed/simple;
	bh=gpu123vfzgiO+uXbDLOjr0RbZza2OJayHW4Xsy1/Beg=;
	h=Date:From:To:Cc:Subject:Message-ID; b=PdXNWJ/j1QE0sTjicrR2Ui2ebOemavEsxrQYEFxHfrNRXPgYWuFhxxbNFI0JLC15iW+5iVHvzKpxwKb/Krei5LUou6R6W/Ledbajd/6B0jpMAWv9OilrrxeYTmIAIOIM5pdxYjivdvuxYRwfy2l/yFYgmNPcx71jDgaS9Q8o4sU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TVIwHVGx; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762627714; x=1794163714;
  h=date:from:to:cc:subject:message-id;
  bh=gpu123vfzgiO+uXbDLOjr0RbZza2OJayHW4Xsy1/Beg=;
  b=TVIwHVGxR65FT58xh0SAhdmmzcea3qMkRrMDVJ0OxaVAUhVRSykL2xaU
   TLrBGXgFFOL74t16cI3EtwY9GUKNZM7cybg8hSP+pBK0He/GnZZfCN3ls
   9Bo+/QbAyNlHJZ/4wVoBqcC2VgggeLikPJ+eIxtcu3IxOqb6kU7ePW4gi
   0T2+3+88JftsbQJCDPvM+ASwkPvlfJgs2opUqq0ynQvt+pfvW8iLgZM17
   tJG+XyzZmYQG9PO4bCQyOUjjF61QXSzCpUeOFf9v2+nM3F8I5dvE19i5a
   3f+NMgUDoMeWcfEk7mgrnqeehVQpaVeE/SHMpsu1f5Uwmt9+yczDcCw2o
   A==;
X-CSE-ConnectionGUID: wXo+TboFS2y/q3RrFWUN5w==
X-CSE-MsgGUID: fvwBk3SASze98OovpYuL/g==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="64670466"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="64670466"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Nov 2025 10:48:34 -0800
X-CSE-ConnectionGUID: sbK6DTKgSiW7KYZqdnZkNA==
X-CSE-MsgGUID: rlLdi7hySv6Y4maZkj1N4Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,290,1754982000"; 
   d="scan'208";a="188487814"
Received: from lkp-server01.sh.intel.com (HELO 6ef82f2de774) ([10.239.97.150])
  by orviesa008.jf.intel.com with ESMTP; 08 Nov 2025 10:48:33 -0800
Received: from kbuild by 6ef82f2de774 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1vHnzD-0001LU-0Q;
	Sat, 08 Nov 2025 18:48:31 +0000
Date: Sun, 09 Nov 2025 02:48:27 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:x86/apic] BUILD SUCCESS
 ed4f9638d905a97cebd49ecea85cc9b706b73761
Message-ID: <202511090222.Jl9hESNk-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/apic
branch HEAD: ed4f9638d905a97cebd49ecea85cc9b706b73761  x86/apic: Fix frequency in apic=verbose log output

elapsed time: 1502m

configs tested: 9
configs skipped: 125

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
i386            allnoconfig    gcc-14
x86_64          allnoconfig    clang-20
x86_64                kexec    clang-20
x86_64             rhel-9.4    clang-20
x86_64         rhel-9.4-bpf    gcc-14
x86_64        rhel-9.4-func    clang-20
x86_64  rhel-9.4-kselftests    clang-20
x86_64       rhel-9.4-kunit    gcc-14
x86_64         rhel-9.4-ltp    gcc-14

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

