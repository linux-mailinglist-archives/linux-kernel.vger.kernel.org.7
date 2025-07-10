Return-Path: <linux-kernel+bounces-726281-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F14F1B00AF5
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 20:00:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0D8F41C8339B
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 18:01:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CEAD2FC3B2;
	Thu, 10 Jul 2025 18:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="G+hvFVJn"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C8322FC3BB
	for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 18:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752170442; cv=none; b=akHVWa58ypvP+RHxoRgi0xjpJGDk+K71TuInbOPJVA8fi0Bad85pzrpPMdiEGrRxTfHy+0qLp7nrcH3XbSfiX4f+WmTWF4nqErz+UCiREwBl9Bx5FfQ2/4Hz12+hA0+gzfX5qAd38WZ989WYFG6GEMgfzkA3G9u4bebwabPmn3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752170442; c=relaxed/simple;
	bh=7RI+HnaOh+uXNTmZfMZGBnaTG7C+laQUyuVuesT2xsY=;
	h=Date:From:To:Cc:Subject:Message-ID; b=stX5M1n6i8wvvzmyhxqWQ6GfviAVXDJylnW7LI2ikOzHPddvpCk68tTkTkv5SZKgBEEkcfvit9yBq/zSbI90eP3haN6KTtA+PImrNe8SbaE+N7L6IlyiOOOI+wmzmTcLv7c2lS05tRrDNPI0CSwFgcu0ESWCDbQHQlZNS09nGIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=G+hvFVJn; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752170441; x=1783706441;
  h=date:from:to:cc:subject:message-id;
  bh=7RI+HnaOh+uXNTmZfMZGBnaTG7C+laQUyuVuesT2xsY=;
  b=G+hvFVJnlxBbEbL4yzSF3uLbMAdrxOHeJl9I7wdONTYVGSLplSK0eEtU
   MKjDAM08ToWrYj7bO/dMLedF/QauS3ek3IBNPpojQOMzyqs8OU0G1AALU
   KeEDsRtRTzmmQc/NoJWIK5JswIVetIy8wtRuPA7TzyR6J/ecxyvlsEYye
   k7AyNIglcl/qj16+eSBvSkvZQ7BKzcOmdSMFBsyl75bNGyjHYYfRxAxT6
   jhcUgiyal2ymFWcOcBzaTgsRQikroLhyx/30pD5EaTvoCEMSLWiXHhj/g
   pdgX59PGreRyXXSLoNs9RY5eiOYejh1EFIcP9h6TT1WEcxYIIBm9XgTrz
   A==;
X-CSE-ConnectionGUID: LgHfzSEvS/mcGcDYreLC+A==
X-CSE-MsgGUID: 1BZ9wMkiQy2dw79RmRg7DA==
X-IronPort-AV: E=McAfee;i="6800,10657,11490"; a="54589786"
X-IronPort-AV: E=Sophos;i="6.16,301,1744095600"; 
   d="scan'208";a="54589786"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2025 11:00:40 -0700
X-CSE-ConnectionGUID: MfUeu33sT/emJmzFgYQ7cw==
X-CSE-MsgGUID: EWciiwuKTFu28kSQk2fJgg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,301,1744095600"; 
   d="scan'208";a="160488505"
Received: from lkp-server01.sh.intel.com (HELO 9ee84586c615) ([10.239.97.150])
  by orviesa003.jf.intel.com with ESMTP; 10 Jul 2025 11:00:39 -0700
Received: from kbuild by 9ee84586c615 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uZvZV-0005Jm-1K;
	Thu, 10 Jul 2025 18:00:37 +0000
Date: Fri, 11 Jul 2025 02:00:21 +0800
From: kernel test robot <lkp@intel.com>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [paulmck-rcu:dev] BUILD SUCCESS
 53e3ca6d0e76dee7714d88c15cc75d49befe708d
Message-ID: <202507110209.M8P1zrL7-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git dev
branch HEAD: 53e3ca6d0e76dee7714d88c15cc75d49befe708d  EXP arm64: enable PREEMPT_LAZY

elapsed time: 1449m

configs tested: 6
configs skipped: 0

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
i386  buildonly-randconfig-001-20250710    gcc-12
i386  buildonly-randconfig-002-20250710    gcc-12
i386  buildonly-randconfig-003-20250710    clang-20
i386  buildonly-randconfig-004-20250710    gcc-11
i386  buildonly-randconfig-005-20250710    clang-20
i386  buildonly-randconfig-006-20250710    clang-20

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

