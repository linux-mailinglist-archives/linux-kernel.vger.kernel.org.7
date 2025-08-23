Return-Path: <linux-kernel+bounces-783129-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 59D1CB329DC
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Aug 2025 17:52:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DC9EA9E83A1
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Aug 2025 15:52:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 222E12DC320;
	Sat, 23 Aug 2025 15:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="H7DpLjua"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2747412B93
	for <linux-kernel@vger.kernel.org>; Sat, 23 Aug 2025 15:52:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755964341; cv=none; b=ApTzgYSPyoy+wMCckFS5AmmPYEEXnvuA0o5DNUbWEN0nOrWBuE0lquWGP6L+t4W2zAUu66HOYoXp3uGeKHkFNZwPtTJeYY41AbjMHTCjBH6Z+lTpCdVALQXvJCuZmdQDvIWRmf7/DQRtoikFh/Cf7Ob/5EBodF+iufOxPMPxAVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755964341; c=relaxed/simple;
	bh=3B2BEQSFKo5adIPpDlaf0ZuW9wCYQwTd0hHNU98ZyCI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=u7Xc1XnOymPD0ZD026HF0GqPZejYRNxDoIyoz9P+bf5IYFA30k2FVqgBpIW57FQQiH0r877kZFskvO6/AYRAWh16SymIljqRMcF3Ctmh6IbRiinNdU8EVkRnTR8X5eVbkRdmRedRn/1GmUAhTmv9DJVwEN+MQgzrjaa+0/0742o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=H7DpLjua; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755964339; x=1787500339;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=3B2BEQSFKo5adIPpDlaf0ZuW9wCYQwTd0hHNU98ZyCI=;
  b=H7DpLjuaWUylyb12P8GZRc9wzhh9nDS0W8P38TtVf1+SbCZK+er9rI0G
   8ciZlMNS399RMkCmfTGkEGtgIOB2A3lW0M9yBo+DoOBsg91O6DM86SG+S
   HkVwC6oGObN5VcC/UjK5VZqaB9faGCfd3/OfSrZoj4T6ZSDBZx28SB2kp
   ODmipiyyG2O52RQFPPR948B/uEpOsy+JdWJ1G/45kBDVtspl81xOlh74o
   mobSbhXgfkO2FiOe3EEysgHubP183/WTrqm1Fnc/vmY+rxzI4ZkcV+rIo
   cGOTF4hk1yeWmSghHONjLimvreuRMAoGMkeXIId17UkMydb9a57jcfD0C
   A==;
X-CSE-ConnectionGUID: UxWD/0bITW2meoSZ3yuAkQ==
X-CSE-MsgGUID: KeCvTcYkQ5W9ZPpoiPzwrQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="75832785"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="75832785"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2025 08:52:18 -0700
X-CSE-ConnectionGUID: 2EHdQvXxQJaBK5h6Pi7eZw==
X-CSE-MsgGUID: TjBdDtopQFixz5eWIM10EQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="169748217"
Received: from cbae1-mobl.amr.corp.intel.com (HELO cbae1-mobl.intel.com) ([10.124.85.190])
  by fmviesa010.fm.intel.com with ESMTP; 23 Aug 2025 08:52:17 -0700
From: "Chang S. Bae" <chang.seok.bae@intel.com>
To: linux-kernel@vger.kernel.org
Cc: x86@kernel.org,
	tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	chao.gao@intel.com,
	abusse@amazon.de,
	chang.seok.bae@intel.com
Subject: [PATCH v5 0/7] x86: Support for Intel Microcode Staging Feature
Date: Sat, 23 Aug 2025 08:52:03 -0700
Message-ID: <20250823155214.17465-1-chang.seok.bae@intel.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250813172649.15474-1-chang.seok.bae@intel.com>
References: <20250813172649.15474-1-chang.seok.bae@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi all,

This is another iteration -- changes since v4 [*]:

  * Reworked the preparatory change before referencing
    cpu_primary_thread_mask, based on Dave’s feedback. This is now patch1.

  * Incorporated further feedback from Dave on the staging code, mainly
    to improve clarity, reduce ambiguity, and fix minor issues. Each
    patch includes some details.

  * Collected Chao’s review tag (thanks!) for the first and last patches.

As usual, the series is also available here:
  git://github.com/intel-staging/microcode.git staging_v5

[*] https://lore.kernel.org/lkml/20250813172649.15474-1-chang.seok.bae@intel.com/

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
 arch/x86/kernel/cpu/microcode/intel.c    | 386 +++++++++++++++++++++++
 arch/x86/kernel/cpu/microcode/internal.h |   4 +-
 arch/x86/kernel/cpu/topology.c           |   4 -
 arch/x86/kernel/cpu/topology_common.c    |   3 +
 arch/x86/kernel/smpboot.c                |   3 -
 8 files changed, 418 insertions(+), 14 deletions(-)


base-commit: 7182bf4176f93be42225d2ef983894febfa4a1b1
-- 
2.48.1


