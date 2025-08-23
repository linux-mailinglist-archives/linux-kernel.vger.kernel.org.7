Return-Path: <linux-kernel+bounces-783139-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 80423B329EC
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Aug 2025 17:55:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6EA371783B1
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Aug 2025 15:54:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA3112E92D2;
	Sat, 23 Aug 2025 15:54:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="O/gmpiar"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16F282E9746
	for <linux-kernel@vger.kernel.org>; Sat, 23 Aug 2025 15:54:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755964451; cv=none; b=BhKElV2GxpkTcpgPYC8Y18WLEDKa2/3gl7iiTZosR4UHvhB4xDXD472GIWF6FXHGQcU+i6IcHahomI8E9tHxJsO1GXEPxxG++Co8wAXkCfKZpnKkDAJz02b+ONtZz+I4uOUBE3uaWt0LngFGUcIsUtPn57dJ+WZM+GC1B3ZtFLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755964451; c=relaxed/simple;
	bh=tyl5Op/IP0MOl7WsJ3qAz9uWU9IDzwtw4TOMK3iSu9w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=U8c7fbZGLk+o8G7bbSDDZp0TcCxDp5pVLIgIshjyXFxfqyIFbqUjCKH/r8pXO5ngTPxj36PSB8lC5XFoCYJUXjF74sn6SwGnhxQgLL0egYfiNu2Xu+evbRGQ1Ekw+VPWdvm7WounSL2SDtRRKUwIUyQKmH7PS/daCX81Czb6svQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=O/gmpiar; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755964449; x=1787500449;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=tyl5Op/IP0MOl7WsJ3qAz9uWU9IDzwtw4TOMK3iSu9w=;
  b=O/gmpiarO12ypOsGzuIA7zdPHYBf/h3ra/LQ0+JU4tr8aJFAIzOutSsE
   jg2q6rT5/yGn8/7Vh+n943VRI7SAM/Gmhe8zmEOAaUzRf7R/go6Cm1hEB
   BWI/D+usogXbYftzCMWWCgTGktD+e2jd1QSAhuKnCpAPSx6YnLWQtf92H
   BD6b7VoPRKezJ6qms/ItKA0SLqd90dxsD9V+qSlSJgelzUw0UtyUlwU4g
   A1zIMNC4FL/t+S5z8WLlhEH8FrcKS9ZZbzrBu9J/MWBAcllpu/QwfAolI
   djmpo/b4TgJu3md2zt8JV2lBaisgCVUOTUS67YLRZvVjBsAFq/1p0qCu8
   g==;
X-CSE-ConnectionGUID: IWlIvtDrT7iuTWYjcsfflQ==
X-CSE-MsgGUID: r6W/fa/yTyaJRr1v6+n5Yg==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="68948456"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="68948456"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2025 08:54:08 -0700
X-CSE-ConnectionGUID: Rjo8z+dJQiSP6jM3LeCtfQ==
X-CSE-MsgGUID: qYzFbUgeSwy+Wlf9Cx/dtA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="169297100"
Received: from cbae1-mobl.amr.corp.intel.com (HELO cbae1-mobl.intel.com) ([10.124.85.190])
  by fmviesa008.fm.intel.com with ESMTP; 23 Aug 2025 08:54:08 -0700
From: "Chang S. Bae" <chang.seok.bae@intel.com>
To: linux-kernel@vger.kernel.org
Cc: x86@kernel.org,
	tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	chang.seok.bae@intel.com
Subject: [PATCH] x86/cpu/topology: Drop redundant CONFIG_X86_LOCAL_APIC check
Date: Sat, 23 Aug 2025 08:54:06 -0700
Message-ID: <20250823155406.17505-1-chang.seok.bae@intel.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

topology.c is only built when CONFIG_X86_LOCAL_APIC=y, so the #ifdef
there is unnecessary. Remove it.

Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
---
 arch/x86/kernel/cpu/topology.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/x86/kernel/cpu/topology.c b/arch/x86/kernel/cpu/topology.c
index e35ccdc84910..dcf05c64dd82 100644
--- a/arch/x86/kernel/cpu/topology.c
+++ b/arch/x86/kernel/cpu/topology.c
@@ -416,7 +416,6 @@ void topology_hotunplug_apic(unsigned int cpu)
 }
 #endif
 
-#ifdef CONFIG_X86_LOCAL_APIC
 static unsigned int max_possible_cpus __initdata = NR_CPUS;
 
 /**
@@ -569,4 +568,3 @@ static int __init setup_possible_cpus(char *str)
 	return 0;
 }
 early_param("possible_cpus", setup_possible_cpus);
-#endif
-- 
2.48.1


