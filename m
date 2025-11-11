Return-Path: <linux-kernel+bounces-894387-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EDE36C49E7C
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 01:47:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AE4DF3A9031
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 00:47:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74BDC1C6FE1;
	Tue, 11 Nov 2025 00:47:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AK0I4Ch0"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D8F14C97
	for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 00:47:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762822022; cv=none; b=ql2PxWxjo3liPZtwSENPXy4vxHb8qSzlBNIPW0giZbU4Avu6l8KBQOjmbiA3PKtDYKu7/iSa5iSEOaQCdr0ZQLxsytLM42u8vEObk8JhE8M9eBn87dULER+8/KWgUf+YHA1Ar+xfRFq6O0T5NB1ADtp5Bal3JObsjFU7Dz/Nzno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762822022; c=relaxed/simple;
	bh=13X9oRDIHaK82czM0EQqJsxTNDLBYiiwPmO4T62xAl8=;
	h=Date:From:To:Cc:Subject:Message-ID; b=P4t8zO6J30qov25y3VzadknWrnCWYBLKT/3ia5PIRvIAyzB/LgdOngw0MDtEYlXj8qag0UkufKdmNcOerbSe7PiQhztDTBQK3he2FhR43kNyvsNqRK8KKykwPcc4mNCKDtXklQwC8ItRg+Ihpnxv2PuP8JeBp0sf13wwHNIRHOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AK0I4Ch0; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762822021; x=1794358021;
  h=date:from:to:cc:subject:message-id;
  bh=13X9oRDIHaK82czM0EQqJsxTNDLBYiiwPmO4T62xAl8=;
  b=AK0I4Ch0h87L9UtTOm7fWak4rMOyzbqEIQMH/PBICe8gsnpWd2Bg50Oh
   xmkPd/dYSU2RtjhEH7GxfzjQgs0GSyxuqs0XZauRgA7UD+loQbLqN+PfX
   kgCkvCoqD4BYoE1iFNn4eIFmXo1a60iGWqBdSv7XABEfhdLUooVS/yswu
   EiHw5orIFcFcjvKjhL1xEaXViA64LVXM+cVb9WhR3KApqiSyGQiFuof+Y
   a62aKS0cLhtP2g20Ly2h/3z+A2F/midh3KaFWpDeMJWGZpl8W3FYmOVsT
   xkLpAMu9B03vMU69azLqJLVUPxDmOCWf+7BHpFZO54S+bQk7drDkMorMn
   w==;
X-CSE-ConnectionGUID: 8HPIpDeXQ2uECrSHTtjEng==
X-CSE-MsgGUID: 2y4EWDlGS3GvNxkaehpnXQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11609"; a="64913922"
X-IronPort-AV: E=Sophos;i="6.19,295,1754982000"; 
   d="scan'208";a="64913922"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2025 16:47:01 -0800
X-CSE-ConnectionGUID: lHddsz4yTDWdG0uu2F2KPQ==
X-CSE-MsgGUID: KbSbljnxScWlVXarVLMcRw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,295,1754982000"; 
   d="scan'208";a="219536313"
Received: from lkp-server01.sh.intel.com (HELO 7b01c990427b) ([10.239.97.150])
  by fmviesa001.fm.intel.com with ESMTP; 10 Nov 2025 16:47:00 -0800
Received: from kbuild by 7b01c990427b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1vIcXB-0001Ao-2r;
	Tue, 11 Nov 2025 00:46:57 +0000
Date: Tue, 11 Nov 2025 08:46:53 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:x86/build] BUILD SUCCESS
 780813d7018067f2796f023b56b51385970be460
Message-ID: <202511110848.ByHYOMNE-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/build
branch HEAD: 780813d7018067f2796f023b56b51385970be460  x86/math-emu: Fix div_Xsig() prototype

elapsed time: 1506m

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

