Return-Path: <linux-kernel+bounces-826451-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F26B8B8E928
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 00:48:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B34D13BE143
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Sep 2025 22:48:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 759072566DD;
	Sun, 21 Sep 2025 22:48:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BIqrglhB"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA2042036FE
	for <linux-kernel@vger.kernel.org>; Sun, 21 Sep 2025 22:48:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758494926; cv=none; b=KNCzZ7aaVD5yi/SbDDAH441klCa0qfuBI+6k+AnErIrAIn+q0pyFtPxMOvoUSEYZpP3gjnKIFHZF9/53bhdsZeGfahIS4M/MkSrU65b6JRW/iw6+p4+idRi3AacsCXYR/lU5WYGOgKlcllkp13spxjO3uXNkneL1xGu0Qy6jlHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758494926; c=relaxed/simple;
	bh=1JarWI3CkW9Z9jL8tKK4+TvQOF6MxzdmWChnC+2S4nU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mDv98evNGlh5deEpGMyCSkoggvk5FjTln7cxSqNIZtIXWF4Dh6bvJJ910ykd230Ko1yQzld/AkKnkGfXwODJ7kC3KSIpYy8bTcPnblNyVW7G6lWpnlzI14FO44TcNGl/46HwEojsxtVKwYkYgXDiV/AyxJoJXdgKmixuzYUjBlk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BIqrglhB; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758494926; x=1790030926;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=1JarWI3CkW9Z9jL8tKK4+TvQOF6MxzdmWChnC+2S4nU=;
  b=BIqrglhBcG0iZPRvd7MEVQsCn2YgA0UBfqY730L+b4j2rpsgIX1ITnNf
   AwtLLBMkBOFxkll2M4RIokPe/12o+LSuUPVaaC6oB5E60nLgQpjvsgVep
   GTYKqMIqinpFytHE2r43J1KjAYPUd23tTKdUJX5FtdGFl8ER/CVeqxjCH
   JEkkZC+9Z/4aqTMC+dWT+0mO5gRXpuYuzRDKsASZe60rcVCeXvynAAFcV
   u8akNxc3cDYfwFG+Vc4v5gsRW+TX5OM32Y+B1zN/9Fce7sX+x/iojZMV4
   ckwkbOKl3B5lkFJjrC997786ehsR+m62Y5/4ZV398QefMEvnQUOopcKUu
   g==;
X-CSE-ConnectionGUID: FDJhru38SaOqCv1GQwOUmg==
X-CSE-MsgGUID: zwyx7+cBSRypAZbuw5N1wQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="64562332"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="64562332"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2025 15:48:45 -0700
X-CSE-ConnectionGUID: wHpj7XPsRCSUmjwC9prZKA==
X-CSE-MsgGUID: WGc6mH6FSfuXoGsEn1Y/lw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,283,1751266800"; 
   d="scan'208";a="177129778"
Received: from cbae1-mobl.amr.corp.intel.com (HELO cbae1-mobl.intel.com) ([10.124.135.148])
  by fmviesa010.fm.intel.com with ESMTP; 21 Sep 2025 15:48:43 -0700
From: "Chang S. Bae" <chang.seok.bae@intel.com>
To: linux-kernel@vger.kernel.org
Cc: x86@kernel.org,
	tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	chao.gao@intel.com,
	abusse@amazon.de,
	tony.luck@intel.com,
	chang.seok.bae@intel.com
Subject: [PATCH v6 0/7] x86: Support for Intel Microcode Staging Feature
Date: Sun, 21 Sep 2025 15:48:34 -0700
Message-ID: <20250921224841.3545-1-chang.seok.bae@intel.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi all,

This posting incorporates the following updates:

  * Addressed Boris' feedbacks:
    * Trimmed down changelogs to key points
    * Clarified error messages
    * Folded a one-liner helper
    - Fixed typos
    - Corrected header include ordering

  * Collected Tony's review tag

Boris also commented on the heuristic, worth highlighting:

 >> +    * To tolerate this behavior, allow up to twice the expected
 >> +    * number of transactions (i.e., a 10-chunk image can take up to
 >> +    * 20 attempts).
 >
 > Looks quirky but ok, let's try it in practice first
 ...
 > If this is part of normal operation, your send-max-2x-the-size heuristic might
 > fail quickly here. I'd track the number of chunks it wants you to send and
 > then set a per-chunk limit and when it reaches that limit, then cancel the
 > transaction. Dunno, let's try the simple scheme first...

As the series continues to take shape, I hope this iteration can build
momentum towards the integration.

The branch is available here:
  git://github.com/intel-staging/microcode.git staging_v6

Previous posting:
  https://lore.kernel.org/lkml/20250823155214.17465-1-chang.seok.bae@intel.com/

Thanks,
Chang

Chang S. Bae (7):
  x86/cpu/topology: Make primary thread mask available with SMP=n
  x86/microcode: Introduce staging step to reduce late-loading time
  x86/microcode/intel: Establish staging control logic
  x86/microcode/intel: Define staging state struct
  x86/microcode/intel: Implement staging handler
  x86/microcode/intel: Support mailbox transfer
  x86/microcode/intel: Enable staging when available

 arch/x86/include/asm/msr-index.h         |   9 +
 arch/x86/include/asm/topology.h          |  12 +-
 arch/x86/kernel/cpu/microcode/core.c     |  11 +
 arch/x86/kernel/cpu/microcode/intel.c    | 359 +++++++++++++++++++++++
 arch/x86/kernel/cpu/microcode/internal.h |   4 +-
 arch/x86/kernel/cpu/topology.c           |   4 -
 arch/x86/kernel/cpu/topology_common.c    |   3 +
 arch/x86/kernel/smpboot.c                |   3 -
 8 files changed, 391 insertions(+), 14 deletions(-)


base-commit: 835794d1ae4cb94b77f631f810018c286561181a
-- 
2.48.1


