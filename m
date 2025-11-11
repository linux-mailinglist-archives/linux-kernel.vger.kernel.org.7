Return-Path: <linux-kernel+bounces-895884-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CA0CC4F2FE
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 18:07:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0EF014EA902
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 17:06:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AFED377EB0;
	Tue, 11 Nov 2025 17:06:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CCbAAPJD"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82725335082
	for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 17:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762880765; cv=none; b=YTEPZvsINoo45zZXLoSUOf2ssx00B9neVx8pIJKyzgmnCkubOXuVI5EN7Mt7WzdbtawcFHnTddn0Sbrebsr3UhOvJLkfpj57aTrZrYhEfC+7uR06tsq9QMlDJna2NSVE2zdUuFg4hK3C/iOZKkEZUOgvAtOxIVQTiMFJbSsHAuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762880765; c=relaxed/simple;
	bh=XL/CyadMrb47wUnBF338CuG74XxtXqjp9UkdM4cjWpA=;
	h=Date:From:To:Cc:Subject:Message-ID; b=HMq7U38DLac/peFvPvZdNnfnXOva/ndaqXQ2gpoWJ1laqGMycfZoBSdWVIeANmlDTzmLZoJZpjon+oclD2UzgDM8tkaLzwjDAzKiF1Um5rZBllTj1+XO3n/138+TkIX42guWeBZSlZYVDC5gY+1xexXMtsp/hQxc/0qJMq6frw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CCbAAPJD; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762880761; x=1794416761;
  h=date:from:to:cc:subject:message-id;
  bh=XL/CyadMrb47wUnBF338CuG74XxtXqjp9UkdM4cjWpA=;
  b=CCbAAPJDBcJdZwi0fKJdh/16sebKlw+63WF9878JxfZ7ag7mH3ya73QY
   0CjfFbjc298bEyxP+qgq7HxjM76vzKXpA4l5iXF1B77uqgUefTlCDaYSe
   49kqj2ltqgNP3BNVhazK36C0m4oo4I/Ex0dAfbcXI4kQx34LNU+3TNEbP
   SpWw/dv8c0l4swx05SJxH/LdoPgcDDh1aJFmkRt8XAj8SgPT09WOpoVmh
   T3uTPpRulT8piypwVsfq2fA9TL3cnZkG7twiKalyRAhyCYwX533gPDXdf
   JL9lWeuDB/kgM0O6SzmAkG+VsAgItYAVWI2K6dTA//fB88e9uRfb4dW4Y
   g==;
X-CSE-ConnectionGUID: 4bW7RbKlTVi/1yqruhvcag==
X-CSE-MsgGUID: BTS1s4clTY6APPsjbpQ2tQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11610"; a="64983263"
X-IronPort-AV: E=Sophos;i="6.19,297,1754982000"; 
   d="scan'208";a="64983263"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2025 09:05:59 -0800
X-CSE-ConnectionGUID: pFE9AqKVTUSHd/TQlT2t+Q==
X-CSE-MsgGUID: Ex7PmgdnRpyQloPEoCSS0w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,297,1754982000"; 
   d="scan'208";a="188975986"
Received: from lkp-server01.sh.intel.com (HELO 7b01c990427b) ([10.239.97.150])
  by orviesa007.jf.intel.com with ESMTP; 11 Nov 2025 09:05:59 -0800
Received: from kbuild by 7b01c990427b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1vIrob-0003PV-0c;
	Tue, 11 Nov 2025 17:05:57 +0000
Date: Wed, 12 Nov 2025 01:05:14 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:x86/microcode] BUILD SUCCESS
 8489bd5ff7bebcdb43c30632e62f422909bc3047
Message-ID: <202511120109.XgytD8qj-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/microcode
branch HEAD: 8489bd5ff7bebcdb43c30632e62f422909bc3047  Merge tag 'v6.18-rc5' into x86/microcode, to resolve conflicts

elapsed time: 1527m

configs tested: 2
configs skipped: 119

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
i386    allnoconfig    gcc-14
x86_64  allnoconfig    clang-20

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

