Return-Path: <linux-kernel+bounces-888216-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ED9E4C3A35A
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 11:24:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5832B1A480B8
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 10:15:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2766030CDAA;
	Thu,  6 Nov 2025 10:14:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eTYNA+OR"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 078A624A066;
	Thu,  6 Nov 2025 10:14:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762424071; cv=none; b=hFVPIaioaVeCzxczC37I+VuXemIZy+iacqFooL9nmuIoOBUIht9YEZRM7ZuB5SeAY6pdb1XqNgpmZFOzhAOIzMl81OcxTL28EHH8t3Zp3aByX48Qes6fgrRQVpXTQxf6tYh6zAnfMk8wXUD+N3WLo/yOMNWhyfBW24Gl+SxSaMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762424071; c=relaxed/simple;
	bh=7M1iZ3rkswdCuq+agy1wdVidfs0s79R5fvdWf58PmJo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=laJ+bDnZcQzn9fufqACtH5fNUgKKnhK0d9AMqx0Tgg4SEbbvi6oAuPUBXW7qCmAXEqBqcm8vz75q1Tay8HhnJKly+XWEko2CiRBpHFku0I2JerLa0KawXbtRW4iGx4DMCiMMoVEKFl8PQIZPH0KdQSU3sXuxL72QrK1pUgP1rNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eTYNA+OR; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762424070; x=1793960070;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=7M1iZ3rkswdCuq+agy1wdVidfs0s79R5fvdWf58PmJo=;
  b=eTYNA+ORZEOzszNXCQmwmj+2sSbaYs269dfMPhPemQFO1Lb/VEKQL6tv
   TaR/wdYSkJ9/xCWR63h7PnMVOLS5qDCaXUvRjUGP7Uc6C1+/DL6t2Ptx7
   2mziLCowMt118jAElwMGhN2ux30V01eeZgirZ65OiRNZ/DbkUUtZc/wtJ
   EiXmwRRMxcG/XVnPNaDcmav6J3OQ5aNl+yGhKrPP57Zco75bLHrcYha1b
   nkaaLXWXWX5HCjmjje+8RLG/7TS/D0sn55xlBqpi/KNDB3QuzuXzoBipw
   YzU8PhwADE8NCfL6k8dPNE8fRr5MiD22h/AaSNW8cWMbW1fZ8COtWbXmK
   g==;
X-CSE-ConnectionGUID: TqUw5X3MQiOIPPcXqaeTzA==
X-CSE-MsgGUID: RcqR5B67QL6nh4w+SuFihg==
X-IronPort-AV: E=McAfee;i="6800,10657,11604"; a="76006629"
X-IronPort-AV: E=Sophos;i="6.19,284,1754982000"; 
   d="scan'208";a="76006629"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2025 02:14:29 -0800
X-CSE-ConnectionGUID: csGG4W1HRHGKYYRqfmPPhg==
X-CSE-MsgGUID: sN3CCagrQVCdLhCLqF0J1A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,284,1754982000"; 
   d="scan'208";a="188000772"
Received: from black.igk.intel.com ([10.91.253.5])
  by fmviesa008.fm.intel.com with ESMTP; 06 Nov 2025 02:14:27 -0800
Received: by black.igk.intel.com (Postfix, from userid 1003)
	id 7F88995; Thu, 06 Nov 2025 11:14:26 +0100 (CET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Jonathan Corbet <corbet@lwn.net>,
	Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 0/2] doc: Handle IDTENTRY and fix apic.c
Date: Thu,  6 Nov 2025 11:12:24 +0100
Message-ID: <20251106101416.1924707-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Handle DEFINE_IDTENTRY_IRQ() and fix apic.c kernel-doc issues.
Assumed to go via doc Git tree. Please, Ack.

Andy Shevchenko (2):
  doc: kdoc: Handle DEFINE_IDTENTRY_*() cases
  x86/apic: Update kernel-doc to avoid warnings

 arch/x86/kernel/apic/apic.c     |  4 +++-
 scripts/lib/kdoc/kdoc_parser.py | 27 +++++++++++++++++++++++----
 2 files changed, 26 insertions(+), 5 deletions(-)

-- 
2.50.1


