Return-Path: <linux-kernel+bounces-819931-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A3F9B8025A
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 16:43:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CE6FA1C02820
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 03:38:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A97BA2F83BC;
	Wed, 17 Sep 2025 03:38:07 +0000 (UTC)
Received: from chinatelecom.cn (smtpnm6-10.21cn.com [182.42.147.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BF9C25FA34
	for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 03:38:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=182.42.147.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758080287; cv=none; b=vBo+HJIFHi/hrLA0Wg30ui0psMAaqEEk+gkRy4D/UuRA/oEouTqjeVpsGc4DeWNfVwnaKGFW2Xsbw680WD0vy1uzbFhP6VSL/7mVQTVrciLCLh/IgMv6ZwlV2c9KDyqcCyAbvkoQMiu6ve4bbKtHVw7MVnmB8WO1CJF3gu84JkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758080287; c=relaxed/simple;
	bh=08VUFcXpF6AYclk8y6n1SHrN774oN8kabGwclYrzuCI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Ac69WKIykLEsf9JSpMbWg8qq3f/PMEMjM1rdhlAHHDDzODfpXIR+B/jurDbBpeZni7PNsFWzB2OXIwxdTOgO8KOKFFGgJjPFj0RADugg8bMeWtvLH7mTjrIVfmN87zGqTg6f3wMEyi7oF3tae/sxBS/thzkMQmuZFLxCEs0k6u8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=chinatelecom.cn; spf=pass smtp.mailfrom=chinatelecom.cn; arc=none smtp.client-ip=182.42.147.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=chinatelecom.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chinatelecom.cn
HMM_SOURCE_IP:192.168.139.44:0.1676807570
HMM_ATTACHE_NUM:0000
HMM_SOURCE_TYPE:SMTP
Received: from clientip-36.111.64.84 (unknown [192.168.139.44])
	by chinatelecom.cn (HERMES) with SMTP id 46200B023C14;
	Wed, 17 Sep 2025 11:29:15 +0800 (CST)
X-189-SAVE-TO-SEND: +liuq131@chinatelecom.cn
Received: from  ([36.111.64.84])
	by gateway-ssl-dep-79cdd9d55b-z742x with ESMTP id 5da354203705446287f19055e82e39d7 for tglx@linutronix.de;
	Wed, 17 Sep 2025 11:29:28 CST
X-Transaction-ID: 5da354203705446287f19055e82e39d7
X-Real-From: liuq131@chinatelecom.cn
X-Receive-IP: 36.111.64.84
X-MEDUSA-Status: 0
Sender: liuq131@chinatelecom.cn
From: Qiang Liu <liuq131@chinatelecom.cn>
To: tglx@linutronix.de
Cc: bp@alien8.de,
	peterz@infradead.org,
	jpoimboe@kernel.org,
	pawan.kumar.gupta@linux.intel.com,
	mingo@redhat.com,
	dave.hansen@linux.intel.com,
	x86@kernel.org,
	hpa@zytor.com,
	linux-kernel@vger.kernel.org,
	Qiang Liu <liuq131@chinatelecom.cn>
Subject: [PATCH] x86/bugs: Rate-limit the SPECTRE_V2 messages
Date: Wed, 17 Sep 2025 11:28:57 +0800
Message-Id: <20250917032857.22441-1-liuq131@chinatelecom.cn>
X-Mailer: git-send-email 2.27.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

During stress-ng testing, excessive SPECTRE_V2 messages overwhelmed the
low-speed serial device, causing system soft lockup. This issue can be
resolved by implementing rate-limiting for the relevant log outputs.

The log as below:
[121017.083236] Spectre V2 : WARNING: Unprivileged eBPF is enabled with eIBRS on, data leaks possible via Spectre v2 BHB attacks!
[121017.098606] Spectre V2 : WARNING: Unprivileged eBPF is enabled with eIBRS on, data leaks possible via Spectre v2 BHB attacks!
[121017.102398] Spectre V2 : WARNING: Unprivileged eBPF is enabled with eIBRS on, data leaks possible via Spectre v2 BHB attacks!
[121017.102421] Spectre V2 : WARNING: Unprivileged eBPF is enabled with eIBRS on, data leaks possible via Spectre v2 BHB attacks!
[121017.102532] Spectre V2 : WARNING: Unprivileged eBPF is enabled with eIBRS on, data leaks possible via Spectre v2 BHB attacks!
[121017.102550] Spectre V2 : WARNING: Unprivileged eBPF is enabled with eIBRS on, data leaks possible via Spectre v2 BHB attacks!
[121017.102569] Spectre V2 : WARNING: Unprivileged eBPF is enabled with eIBRS on, data leaks possible via Spectre v2 BHB attacks!
[121017.133670] Spectre V2 : WARNING: Unprivileged eBPF is enabled with eIBRS on, data leaks possible via Spectre v2 BHB attacks!
[121017.148497] Spectre V2 : WARNING: Unprivileged eBPF is enabled with eIBRS on, data leaks possible via Spectre v2 BHB attacks!
[121017.163674] Spectre V2 : WARNING: Unprivileged eBPF is enabled with eIBRS on, data leaks possible via Spectre v2 BHB attacks!
[121017.185720] Spectre V2 : WARNING: Unprivileged eBPF is enabled with eIBRS on, data leaks possible via Spectre v2 BHB attacks!
[121017.287675] Spectre V2 : WARNING: Unprivileged eBPF is enabled with eIBRS on, data leaks possible via Spectre v2 BHB attacks!
[121017.300205] Spectre V2 : WARNING: Unprivileged eBPF is enabled with eIBRS on, data leaks possible via Spectre v2 BHB attacks!
[121017.335075] Spectre V2 : WARNING: Unprivileged eBPF is enabled with eIBRS on, data leaks possible via Spectre v2 BHB attacks!
[121017.346428] Spectre V2 : WARNING: Unprivileged eBPF is enabled with eIBRS on, data leaks possible via Spectre v2 BHB attacks!
[121017.428517] Spectre V2 : WARNING: Unprivileged eBPF is enabled with eIBRS on, data leaks possible via Spectre v2 BHB attacks!
[121017.450328] Spectre V2 : WARNING: Unprivileged eBPF is enabled with eIBRS on, data leaks possible via Spectre v2 BHB attacks!
[121017.592131] Spectre V2 : WARNING: Unprivileged eBPF is enabled with eIBRS on, data leaks possible via Spectre v2 BHB attacks!
[121017.592865] Spectre V2 : WARNING: Unprivileged eBPF is enabled with eIBRS on, data leaks possible via Spectre v2 BHB attacks!
[121037.642577] watchdog: BUG: soft lockup - CPU#68 stuck for 23s! [stress-ng-procf:2483051]
[121037.642578] Modules linked in: ...
[121037.642697] CPU: 68 PID: 2483051 Comm: stress-ng-procf Kdump: loaded Tainted: ...
[121037.642698] Hardware name: XFUSION 2288H V6/BC13MBSBC, BIOS 1.29 11/25/2022
[121037.642706] RIP: 0010:console_unlock+0x283/0x350
[121037.642709] Code: 00 e8 01 15 00 00 55 9d 45 84 f6 0f 84 46 ff ff ff e8 71 f8 ff ff 85 c0 0f 85 e8 fd ff ff e9 34 ff ff ff e8 df 14 00 00 55 9d <8b> 44 24 04 85 c0 0f 84 f8 fd ff ff e8 9c 84 99 00 e9 ee fd ff ff
[121037.642710] RSP: 0018:ff607726b60abc00 EFLAGS: 00000246
[121037.642711] RAX: 0000000000000000 RBX: ffffffffaef699cc RCX: 0000000000000008
[121037.642712] RDX: 0000000000000000 RSI: 0000000000000004 RDI: ffffffffaef6c228
[121037.642713] RBP: 0000000000000246 R08: ffffffffadabd540 R09: 0000000000aaaaaa
[121037.642713] R10: 0000000000000001 R11: ff2cf962c6a5b550 R12: ff2cf962c2700000
[121037.642714] R13: 0000000000000000 R14: ffffffffaef6c228 R15: 000000000000008c
[121037.642715] FS:  00007f2021c07640(0000) GS:ff2cf9e0be700000(0000) knlGS:0000000000000000
[121037.642715] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[121037.642716] CR2: 0000000000e3b7a0 CR3: 0000003f41266005 CR4: 0000000000771ee0
[121037.642716] PKRU: 55555554
[121037.642717] Call Trace:
[121037.642722]  vprintk_emit+0x118/0x120
[121037.642727]  printk+0x58/0x73
[121037.642731]  bpf_unpriv_handler+0xbf/0x180
[121037.642733]  ? proc_taint+0x1d0/0x1d0
[121037.642738]  proc_sys_call_handler+0x13e/0x250
[121037.642742]  new_sync_read+0x10d/0x1b0
[121037.642745]  vfs_read+0x14e/0x1b0
[121037.642747]  ksys_read+0x5f/0xe0
[121037.642750]  do_syscall_64+0x3d/0x80
[121037.642753]  entry_SYSCALL_64_after_hwframe+0x61/0xc6

Fixes: 0de05d056afd ("x86/speculation: Warn about eIBRS + LFENCE + Unprivileged eBPF + SMT")
Fixes: 44a3918c8245 ("x86/speculation: Include unprivileged eBPF status in Spectre v2 mitigation reporting")
Signed-off-by: Qiang Liu <liuq131@chinatelecom.cn>
---
 arch/x86/kernel/cpu/bugs.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index 36dcfc5105be..22fb2113cbe6 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -1809,11 +1809,11 @@ void unpriv_ebpf_notify(int new_state)
 
 	switch (spectre_v2_enabled) {
 	case SPECTRE_V2_EIBRS:
-		pr_err(SPECTRE_V2_EIBRS_EBPF_MSG);
+		pr_err_ratelimited(SPECTRE_V2_EIBRS_EBPF_MSG);
 		break;
 	case SPECTRE_V2_EIBRS_LFENCE:
 		if (sched_smt_active())
-			pr_err(SPECTRE_V2_EIBRS_LFENCE_EBPF_SMT_MSG);
+			pr_err_ratelimited(SPECTRE_V2_EIBRS_LFENCE_EBPF_SMT_MSG);
 		break;
 	default:
 		break;
-- 
2.46.0


