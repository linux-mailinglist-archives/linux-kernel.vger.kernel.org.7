Return-Path: <linux-kernel+bounces-774760-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 375C9B2B711
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 04:35:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EF83C7AAC80
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 02:33:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE34319DFAB;
	Tue, 19 Aug 2025 02:35:17 +0000 (UTC)
Received: from baidu.com (mx22.baidu.com [220.181.50.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3751A126F0A
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 02:35:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.181.50.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755570917; cv=none; b=bZQOspZa1jp7R6B4mfu1ShYHUjTYm0XTxVH0hR6pNKScnw70BcVdM1f+3rtinHyToG1abDb4FELiEiI4PcGDL/osQUHBSUyhLnkkIaybxYyEAzA9lSVO1oGv5zqngBt1LClcN/eV/nD84Ns/eHM4sPZBPeRAlH2O3TOUxrq0RBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755570917; c=relaxed/simple;
	bh=JkI+SepP6GD/HC8sol1nx0sksajYPato0I1SjzZVHRQ=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=p0+SDKPMDTdVDdCZqboPchJUj+5Om5O7vIEpbenLKKX0VJXzEcr1eu8MPnmV8FMPQfWiG1d4jI3hdcBP1J5Ga2PO4Q/yPPtYA94BC8fQ1QFtVGyoZHDa7kF5cFWKxkyjFAMhNW/ZTt63r7oHrNlatzgO1in6VJ9yBp1EQsWPZoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com; spf=pass smtp.mailfrom=baidu.com; arc=none smtp.client-ip=220.181.50.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baidu.com
From: lirongqing <lirongqing@baidu.com>
To: <tglx@linutronix.de>, <bp@alien8.de>, <peterz@infradead.org>,
	<jpoimboe@kernel.org>, <pawan.kumar.gupta@linux.intel.com>,
	<mingo@redhat.com>, <dave.hansen@linux.intel.com>, <x86@kernel.org>,
	<hpa@zytor.com>, <david.kaplan@amd.com>, <linux-kernel@vger.kernel.org>
CC: Li RongQing <lirongqing@baidu.com>
Subject: [PATCH][v3] x86/bugs: Fix GDS mitigation selecting when mitigation is off
Date: Tue, 19 Aug 2025 10:33:56 +0800
Message-ID: <20250819023356.2012-1-lirongqing@baidu.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: bjkjy-exc5.internal.baidu.com (172.31.50.49) To
 bjkjy-exc3.internal.baidu.com (172.31.50.47)
X-FEAS-Client-IP: 172.31.50.47
X-FE-Policy-ID: 52:10:53:SYSTEM

From: Li RongQing <lirongqing@baidu.com>

The current GDS mitigation logic incorrectly returns early when the
attack vector mitigation is turned off, which leads to two problems:

1. CPUs without ARCH_CAP_GDS_CTRL support are incorrectly marked with
   GDS_MITIGATION_OFF when they should be marked as
   GDS_MITIGATION_UCODE_NEEDED.

2. The mitigation state checks and locking verification that follow are
   skipped, which means:
   - fail to detect if the mitigation was locked
   - miss the warning when trying to disable a locked mitigation

Remove the early return to ensure proper mitigation state handling. This
allows:
- Proper mitigation classification for non-ARCH_CAP_GDS_CTRL CPUs
- Complete mitigation state verification

The change fixes the following runtime issues because mitigation is off
in non-ARCH_CAP_GDS_CTRL CPUs:

[    2.809147] unchecked MSR access error: WRMSR to 0x123 (tried to write 0x0000000000000010) at rIP: 0xffffffffb34527b8 (update_gds_msr+0x38/0xe0)
[    2.809147] Call Trace:
[    2.809147]  <TASK>
[    2.809147]  identify_secondary_cpu+0x72/0x90
[    2.809147]  start_secondary+0x7a/0x140
[    2.809147]  common_startup_64+0x13e/0x141
[    2.809147]  </TASK>
[    2.809147] ------------[ cut here ]------------
[    2.809147] WARNING: CPU: 1 PID: 0 at arch/x86/kernel/cpu/bugs.c:1053 update_gds_msr+0x9b/0xe0

Fixes: 8c7261abcb7ad ("x86/bugs: Add attack vector controls for GDS")
Suggested-by: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
Reviewed-by: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
Signed-off-by: Li RongQing <lirongqing@baidu.com>
---
Diff with v2: refine the commit header and Reviewed-by: Pawan Gupta
Diff with v1: directly remove return 

 arch/x86/kernel/cpu/bugs.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index b74bf93..9e0b9bf 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -1071,7 +1071,6 @@ static void __init gds_select_mitigation(void)
 			gds_mitigation = GDS_MITIGATION_FULL;
 		else {
 			gds_mitigation = GDS_MITIGATION_OFF;
-			return;
 		}
 	}
 
-- 
2.9.4


