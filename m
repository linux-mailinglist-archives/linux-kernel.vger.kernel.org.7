Return-Path: <linux-kernel+bounces-771594-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E37E1B2892F
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Aug 2025 02:22:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E764B1CC20EB
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Aug 2025 00:20:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 215534A0A;
	Sat, 16 Aug 2025 00:19:50 +0000 (UTC)
Received: from baidu.com (mx22.baidu.com [220.181.50.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35DE310957
	for <linux-kernel@vger.kernel.org>; Sat, 16 Aug 2025 00:19:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.181.50.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755303589; cv=none; b=juwU5nHw9esvg+u8AG63/RiR6V5sRQmALJRF9nWZ3Y2snaeajSWtNZG+gP7jwwjYsZCm2USvw44MrvGYxAT82aReb3bMYCLdydn689l35F9D234BOgqWsJ0uIf9soqifUM8Axlt78Y2Wpu1a9iahpvQ/K1bYZer2Tct1Y1N7QN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755303589; c=relaxed/simple;
	bh=d3JBlurWXIm51JZT55vsAQhmgIB/GLQhiMmJ26sDsDM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=mH14mOUxfgXRuqgy4GwUeAmPhcaxBU9pacOi/7+48vVY29mBovgfxrEgxLUMr2loE4Zcs5RKnkDJ2eMBnej+KwHfKECnVtysh0nddTADsTCcsyuVTxbKulGAjgyP2xtKBs4mozoP8b2XsOFytDE2GQ3ZGhN5QpSb6PyAR1EDrIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com; spf=pass smtp.mailfrom=baidu.com; arc=none smtp.client-ip=220.181.50.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baidu.com
From: lirongqing <lirongqing@baidu.com>
To: <tglx@linutronix.de>, <bp@alien8.de>, <peterz@infradead.org>,
	<jpoimboe@kernel.org>, <pawan.kumar.gupta@linux.intel.com>,
	<mingo@redhat.com>, <dave.hansen@linux.intel.com>, <x86@kernel.org>,
	<hpa@zytor.com>, <david.kaplan@amd.com>, <linux-kernel@vger.kernel.org>
CC: Li RongQing <lirongqing@baidu.com>
Subject: [PATCH][v2] x86/bugs: Fix GDS mitigation select for non-ARCH_CAP_GDS_CTRL CPUs
Date: Sat, 16 Aug 2025 08:19:05 +0800
Message-ID: <20250816001905.2270-1-lirongqing@baidu.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: bjkjy-exc2.internal.baidu.com (172.31.50.46) To
 bjkjy-exc3.internal.baidu.com (172.31.50.47)
X-FEAS-Client-IP: 172.31.50.47
X-FE-Policy-ID: 52:10:53:SYSTEM

From: Li RongQing <lirongqing@baidu.com>

The current GDS mitigation logic incorrectly returns early when
ARCH_CAP_GDS_CTRL is not present, which leads to two problems:

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

The change fixes the following runtime issues observed:

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
Signed-off-by: Li RongQing <lirongqing@baidu.com>
---
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


