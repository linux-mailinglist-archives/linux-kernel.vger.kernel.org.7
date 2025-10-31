Return-Path: <linux-kernel+bounces-879888-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 805E7C24539
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 11:03:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CCBAF3B7FB6
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 10:00:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7279334688;
	Fri, 31 Oct 2025 10:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="I133xcdR"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37F5B1F9F70
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 10:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761904807; cv=none; b=Sbd+M1PnSjl0NTIYMZRahhnAlXP6gWKSB9d3eIe1btfYHTG4R86n9e1vHxcBPNiwsM9WMzW2+imV7ABVJmkGY7gD9Ar/YvOU0RKs7sNjLM33QI3LWtFE+zq5Wh3MTnW7szMsKL491B/OFHFuFaBLwQGY3bcml9uOZ4PfvXrQy8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761904807; c=relaxed/simple;
	bh=h5qwRf0ce1SLJ0apgZD3wgSe98qLxjFEzkgcSLuDKYU=;
	h=Date:From:To:Cc:Subject:Message-ID; b=n7YDwQ0o64QUuI3GhPPPfriO93idhdC9nSk/2g3tzEbQf79N6yKXVT5pqVNKKj4vKUDcq0gTiwHS0nTPgpTCuOZO/ldf54OYyQG3ei6N2ap2/ZPYcmFDuDJzhU6nF5PnveddkNfwtPO05dgKS2G8vb8sWtDdnWM/XJo+K+9Mlwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=I133xcdR; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761904805; x=1793440805;
  h=date:from:to:cc:subject:message-id;
  bh=h5qwRf0ce1SLJ0apgZD3wgSe98qLxjFEzkgcSLuDKYU=;
  b=I133xcdR4xCX7CnCmRk0piAXPhPDncZmgrHZ4Av1ORKWamBmK1xBZyaA
   6R5ZdbaJBrkZNJIGKDQauJBsPfV62bzJMKp1iraDqvOEtkv/JcC47oDTq
   qVC4AvVqK+1RWMHes857WIV1MZ42VRi7M+A9wj0S/3QBXHe4Firnti7of
   In/nfUuWkjrVaGa9TxiSvzzXJShCFNgMIf8HdISY+x6oQs+HVRM+SHPCc
   B3dbseG/bGGOP6meEDUf+k8cUNKKt1IKldyoyV7nsQtaug61mrt2c1LNw
   glIPzer/FX0Vw55Jkfb7Z+Kd7tUH1luf1N6Ks5Jt4HfYivkfyKF+0MvEJ
   Q==;
X-CSE-ConnectionGUID: eZkZzWv3QBmU5fu1xpFKWQ==
X-CSE-MsgGUID: dmcMRTVFTj+7Vrq0IXiQPQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11598"; a="64104480"
X-IronPort-AV: E=Sophos;i="6.19,269,1754982000"; 
   d="scan'208";a="64104480"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Oct 2025 03:00:03 -0700
X-CSE-ConnectionGUID: igFjaZgwQk6UUYH9dcdaqQ==
X-CSE-MsgGUID: 5N3+CMOlTWKO7HB+pMyr6w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,269,1754982000"; 
   d="scan'208";a="190282405"
Received: from lkp-server02.sh.intel.com (HELO 66d7546c76b2) ([10.239.97.151])
  by orviesa003.jf.intel.com with ESMTP; 31 Oct 2025 03:00:02 -0700
Received: from kbuild by 66d7546c76b2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1vElv9-000MyY-28;
	Fri, 31 Oct 2025 09:59:50 +0000
Date: Fri, 31 Oct 2025 17:58:16 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:perf/core] BUILD SUCCESS
 aa7387e79a5cff0585cd1b9091944142a06872b6
Message-ID: <202510311710.kiWIYMXf-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git perf/core
branch HEAD: aa7387e79a5cff0585cd1b9091944142a06872b6  unwind_user/x86: Fix arch=um build

elapsed time: 1464m

configs tested: 8
configs skipped: 126

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
i386                          allnoconfig    gcc-14
x86_64                        allnoconfig    clang-20
x86_64  buildonly-randconfig-001-20251031    clang-20
x86_64  buildonly-randconfig-002-20251031    gcc-14
x86_64  buildonly-randconfig-003-20251031    clang-20
x86_64  buildonly-randconfig-004-20251031    gcc-14
x86_64  buildonly-randconfig-005-20251031    gcc-14
x86_64  buildonly-randconfig-006-20251031    gcc-14

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

