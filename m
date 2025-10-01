Return-Path: <linux-kernel+bounces-839312-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C6DA5BB1561
	for <lists+linux-kernel@lfdr.de>; Wed, 01 Oct 2025 19:15:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5C46B3B9129
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Oct 2025 17:15:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3EDC2D191C;
	Wed,  1 Oct 2025 17:15:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bvvg2Kbi"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C007226CF6
	for <linux-kernel@vger.kernel.org>; Wed,  1 Oct 2025 17:15:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759338935; cv=none; b=ABDvvnh91NzB3vIwCNofzqXww4Jn3wUjwfo4UrmhmwCfB1ylv+fxdbXoU3nXJBNtM07+0W8XwdK6OBmavKGyBNMWj3WROet8Fa3l2uMLitHzw7Ijo/+WHsexTZHUGwKMAk0ILxrFiUP7tA8gVMZvjoKNGMJW7MJRs7pSVIcUZug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759338935; c=relaxed/simple;
	bh=Fa/i0851KfrhtyZ/TxP3R6h5YD6Oc8Aog2S4zBr9bXg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=XdBi+0S5B7lf7Si+yCSHazLulSFwoHYJYd0HmxQaHLYP1ZoDzyDhArlWAQhztL1FsyMPOSUmEYBATEAyUQlokliVxR6ei006O4pITiyF7Y6pc0XCStrI+j5SRenW1wx90YPdmZwCQcShCQ15gUctgJwP2uTcuDLOVmxnatLfsg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bvvg2Kbi; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1759338933; x=1790874933;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Fa/i0851KfrhtyZ/TxP3R6h5YD6Oc8Aog2S4zBr9bXg=;
  b=bvvg2KbiWP6agDOGYQUfQpEGEMLP0E9VzqujC1FyKpECTVTFaDAnexRY
   S9AdAy1woTqxZmx+HX+GcK7DBFispzBM3Ye4WnIwWjj5L3FQromizsVN5
   qPtmB4Tq7Jrf5CkGOR6pClWlSysodZCPayK7gJJZXHsurG5ncHgWdIZyK
   5OE2D03D8fIa7IZG0BiF7+z6w+o+hqpZt/BRO/2ngL10DDtbDLdrOlGHa
   q4nK8jyJSEY7pF2zMpAbmvtu2jFaIdVlMB9RvU0Eh3jCdPT1W8nZozsQX
   bbe5osVdZCOkRKQhhRx3wC/d73/BMs7fYAY5gBwQOeUOq/rYuocovAdHu
   Q==;
X-CSE-ConnectionGUID: zH2iui+2QVy7CvU4Zw64DA==
X-CSE-MsgGUID: IiVEJWJYQjWpajrKgUffcg==
X-IronPort-AV: E=McAfee;i="6800,10657,11569"; a="60835763"
X-IronPort-AV: E=Sophos;i="6.18,307,1751266800"; 
   d="scan'208";a="60835763"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Oct 2025 10:15:31 -0700
X-CSE-ConnectionGUID: b8I2ZVrEQqGGTyEbGAYWng==
X-CSE-MsgGUID: a4I/CmJ2TLC3eCdWFoxF4g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,307,1751266800"; 
   d="scan'208";a="209558498"
Received: from davehans-spike.ostc.intel.com (HELO ray2.sr71.net) ([10.165.164.11])
  by orviesa002.jf.intel.com with ESMTP; 01 Oct 2025 10:15:30 -0700
From: Dave Hansen <dave.hansen@linux.intel.com>
To: torvalds@linux-foundation.org
Cc: x86@kernel.org,
	linux-kernel@vger.kernel.org,
	Dave Hansen <dave.hansen@linux.intel.com>
Subject: [GIT PULL] x86/mm for 6.18-rc1
Date: Wed,  1 Oct 2025 10:15:29 -0700
Message-Id: <20251001171529.901044-1-dave.hansen@linux.intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Linus,

Please pull a single x86/mm change for 6.18-rc1. This came out of Rik van
Riel's work to get the INVLPGB instruction working. It just removes an
open-coded TLB flush operation by using an existing helper.

--

The following changes since commit c17b750b3ad9f45f2b6f7e6f7f4679844244f0b9:

  Linux 6.17-rc2 (2025-08-17 15:22:10 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_mm_for_6.18-rc1

for you to fetch changes up to 86e6815b316ec0ea8c4bb3c16a033219a52b6060:

  x86/mm: Change cpa_flush() to call flush_kernel_range() directly (2025-08-22 07:55:21 -0700)

----------------------------------------------------------------
Change cpa_flush() to call flush_kernel_range() directly

----------------------------------------------------------------
Yu-cheng Yu (1):
      x86/mm: Change cpa_flush() to call flush_kernel_range() directly

 arch/x86/mm/pat/set_memory.c | 20 +++++++-------------
 1 file changed, 7 insertions(+), 13 deletions(-)

