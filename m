Return-Path: <linux-kernel+bounces-770134-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D7A07B27749
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 05:55:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 78B3F18956B1
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 03:55:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEC3A218AA3;
	Fri, 15 Aug 2025 03:55:02 +0000 (UTC)
Received: from baidu.com (mx24.baidu.com [111.206.215.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F094481B1
	for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 03:54:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=111.206.215.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755230102; cv=none; b=KFIjDdUQQNBPVV2SDHAZVbe+/vcess4g5U/vo/vcSWmyMUry9Bob/eNtzBs2ZmuXuLYxEis58pisZK+OB5jLijtf/m+fDL8ox6z4Xgqq+hVVnE5QNztjDH/y/93EocblQQLQYxm5ejQf3YnI9R9AhOKM51qKsR5swNctn4nha04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755230102; c=relaxed/simple;
	bh=a6TZari1f48MJhvH/cSOKPB1QSp5gsriWnBb+T7eZpc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=uRI4PFoM+P9+3wU9JuyT7wHoyzEpevJdiJW62DJvNPmCchv3vnC5ftD8PKgucrkF7e/Vvs39EocOLAn+m6qnEg2MYmmUP1PNeVxSA6h9EaUw5lv18AeDb4c4c17QpCO0iSD1FxQjw0w8UO7rRFpg7HckJtZqy+Bt1228TpBpxUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com; spf=pass smtp.mailfrom=baidu.com; arc=none smtp.client-ip=111.206.215.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baidu.com
From: lirongqing <lirongqing@baidu.com>
To: <tglx@linutronix.de>, <bp@alien8.de>, <peterz@infradead.org>,
	<jpoimboe@kernel.org>, <pawan.kumar.gupta@linux.intel.com>,
	<mingo@redhat.com>, <dave.hansen@linux.intel.com>, <x86@kernel.org>,
	<hpa@zytor.com>, <david.kaplan@amd.com>, <linux-kernel@vger.kernel.org>
CC: Li RongQing <lirongqing@baidu.com>
Subject: [PATCH] x86/bugs: Fix GDS mitigation check for CPUs without ARCH_CAP_GDS_CTRL
Date: Fri, 15 Aug 2025 11:53:34 +0800
Message-ID: <20250815035334.4230-1-lirongqing@baidu.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: bjkjy-exc8.internal.baidu.com (172.31.50.52) To
 bjkjy-exc3.internal.baidu.com (172.31.50.47)
X-FEAS-Client-IP: 172.31.50.47
X-FE-Policy-ID: 52:10:53:SYSTEM

From: Li RongQing <lirongqing@baidu.com>

The commit 8c7261abcb7ad("x86/bugs: Add attack vector controls for GDS")
caused call traces during secondary CPU initialization because it didn't
properly handle CPUs that lack the ARCH_CAP_GDS_CTRL capability.

For CPUs without ARCH_CAP_GDS_CTRL support, we should set the mitigation
to GDS_MITIGATION_UCODE_NEEDED rather than GDS_MITIGATION_OFF, as these
CPUs may still be vulnerable but cannot disable mitigation.

Add the missing check for ARCH_CAP_GDS_CTRL to properly determine the
mitigation state for affected CPUs.

[    2.809147] unchecked MSR access error: RDMSR from 0x123 at rIP: 0xffffffffb3452807 (update_gds_msr+0x87/0xe0)
(update_gds_msr+0x87/0xe0)
[    2.809147] Call Trace:
[    2.809147]  <TASK>
[    2.809147]  identify_secondary_cpu+0x72/0x90
[    2.809147]  start_secondary+0x7a/0x140
[    2.809147]  common_startup_64+0x13e/0x141
[    2.809147]  </TASK>
[    2.809147] unchecked MSR access error: WRMSR to 0x123 (tried to write 0x0000000000000010) at rIP: 0xffffffffb34527b8
(update_gds_msr+0x38/0xe0)
[    2.809147] Call Trace:
[    2.809147]  <TASK>
[    2.809147]  identify_secondary_cpu+0x72/0x90
[    2.809147]  start_secondary+0x7a/0x140
[    2.809147]  common_startup_64+0x13e/0x141
[    2.809147]  </TASK>
[    2.809147] ------------[ cut here ]------------
[    2.809147] WARNING: CPU: 1 PID: 0 at arch/x86/kernel/cpu/bugs.c:1053 update_gds_msr+0x9b/0xe0

Fixes: 8c7261abcb7ad ("x86/bugs: Add attack vector controls for GDS")
Signed-off-by: Li RongQing <lirongqing@baidu.com>
---
 arch/x86/kernel/cpu/bugs.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index b74bf93..3af911c 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -1071,6 +1071,8 @@ static void __init gds_select_mitigation(void)
 			gds_mitigation = GDS_MITIGATION_FULL;
 		else {
 			gds_mitigation = GDS_MITIGATION_OFF;
+			if (!(x86_arch_cap_msr & ARCH_CAP_GDS_CTRL))
+				gds_mitigation = GDS_MITIGATION_UCODE_NEEDED;
 			return;
 		}
 	}
-- 
2.9.4


