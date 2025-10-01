Return-Path: <linux-kernel+bounces-839328-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D1285BB1612
	for <lists+linux-kernel@lfdr.de>; Wed, 01 Oct 2025 19:39:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8045219C06DE
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Oct 2025 17:39:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B6122D0C92;
	Wed,  1 Oct 2025 17:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="em+ovc0A"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA54E288DB
	for <linux-kernel@vger.kernel.org>; Wed,  1 Oct 2025 17:39:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759340354; cv=none; b=KRccXO3OthSSSmAtJ6EGncDi/w56VBkkcVVN6a4ESvlv4remi5qN6qtWBEUoR1Av/2QkGrHL7sHyTjEQaEH+ZCDUDk9lCCv8Pf2ke79+xaEb0IulPDpYJvabHs5KzjH4OMGEW+A9mi5TosHkcoeHekhi8sStqQOJMGUtzEO73+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759340354; c=relaxed/simple;
	bh=gDN4rQFXIfJ2OHr0qmVg9+Rya/HlHCM+Gis/Uhz+N5I=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=fPTj334pmqmQfcSdYYnQbpIhdNM0YbK/fv124lkuCv3lGtaBReHyCgAExv00c8zmP/myZcwrcRPVLGwilINLBCHAYp2Tw+KMPxNtHdGg8xBBa6vH51NSeVXieLo9hBw/myt2YLbwvpCQKd0zd0eTf2RQSPTYlHpd16lM0fjxkuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=em+ovc0A; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1759340353; x=1790876353;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=gDN4rQFXIfJ2OHr0qmVg9+Rya/HlHCM+Gis/Uhz+N5I=;
  b=em+ovc0AhUPayCeY7qOawXnAv7CJBXQAX4dopjuScsYPbybmRZyi5QhI
   1N/wJ5HxMet8RIXMl4HsO2zcRvrfJSMYYckLeb/yXamKuz1niq3jK0dS0
   eAiURFcWDoT+AyvthiyS7p7h60o2SiOrdDbqZ3BugzuGArVpkOjPsaB8K
   XVnYJQrC6eGw5za5FCetN5dWN+mKCl5DbPUSuF/FtGzZLJLBwecDbV3/T
   olOj2LFGcjmc6Jy+T+LYCpDAaJgVkvy0F4fx+haTBuiKvWhCUq4AJSeS8
   wlHP2tp9/8lEUft603WlsHOQOuZruo3G4H7TuOxeQYj25l2fp2QrWbDlS
   w==;
X-CSE-ConnectionGUID: 43swFMeeRKmmPMnldxNgrA==
X-CSE-MsgGUID: TsuTgQqiQNefzCGLkdqJzQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11569"; a="60838153"
X-IronPort-AV: E=Sophos;i="6.18,307,1751266800"; 
   d="scan'208";a="60838153"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Oct 2025 10:39:12 -0700
X-CSE-ConnectionGUID: Q8RMbm91TdGqwS5wzOWU7g==
X-CSE-MsgGUID: WAXjez6vQpWMImb/X6fj1A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,307,1751266800"; 
   d="scan'208";a="209563264"
Received: from davehans-spike.ostc.intel.com (HELO ray2.sr71.net) ([10.165.164.11])
  by orviesa002.jf.intel.com with ESMTP; 01 Oct 2025 10:39:10 -0700
From: Dave Hansen <dave.hansen@linux.intel.com>
To: torvalds@linux-foundation.org
Cc: x86@kernel.org,
	linux-kernel@vger.kernel.org,
	Dave Hansen <dave.hansen@linux.intel.com>
Subject: [GIT PULL] x86/entry for 6.18-rc1
Date: Wed,  1 Oct 2025 10:39:08 -0700
Message-Id: <20251001173908.905725-1-dave.hansen@linux.intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Linus,

Please a pair of x86/entry changes for 6.18-rc1. The FRED one adjusts
the kernel to the latest spec. The spec change prevents attackers from
abusing kernel entry points.

The second one came about because of the LASS work[1]. It moves the
vsyscall emulation code away from depending on X86_PF_INSTR which is
not available on some CPUs. Those CPUs are pretty obscure these days,
but this still seems like the right thing to do. It also makes this
code consistent with some things that the LASS code is going to do.

1. https://lore.kernel.org/lkml/20250620135325.3300848-1-kirill.shutemov@linux.intel.com/

--

The following changes since commit 8f5ae30d69d7543eee0d70083daf4de8fe15d585:

  Linux 6.17-rc1 (2025-08-10 19:41:16 +0300)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_entry_for_6.18-rc1

for you to fetch changes up to 3da01ffe1aeaa0d427ab5235ba735226670a80d9:

  x86/fred: Remove ENDBR64 from FRED entry points (2025-08-13 15:05:32 -0700)

----------------------------------------------------------------
 - Use RIP instead of X86_PF_INSTR for vsyscall emulation
 - Remove ENDBR64 from FRED entry points

----------------------------------------------------------------
Kirill A. Shutemov (1):
      x86/vsyscall: Do not require X86_PF_INSTR to emulate vsyscall

Xin Li (Intel) (1):
      x86/fred: Remove ENDBR64 from FRED entry points

 arch/x86/entry/entry_64_fred.S        |  2 +-
 arch/x86/entry/vsyscall/vsyscall_64.c | 17 ++++++++++++++---
 2 files changed, 15 insertions(+), 4 deletions(-)

