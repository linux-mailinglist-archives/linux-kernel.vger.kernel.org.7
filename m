Return-Path: <linux-kernel+bounces-737320-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 73D3EB0AABB
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 21:33:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2B40F4E3B06
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 19:32:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57F45207A20;
	Fri, 18 Jul 2025 19:32:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="B2Y5kCyi"
Received: from out-187.mta1.migadu.com (out-187.mta1.migadu.com [95.215.58.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FC0F205E26
	for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 19:32:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752867162; cv=none; b=gw6f0WYUg5k8CElZbOtQv1MWUATo3DdFEFNiJtX2ijK8mhd/8fZ7AhbhMpGw7rlhqZ4FqduCT8Zh/ziC/vWUXuSPTa0Ja7r4rtpXzFnaglR5HSZrZ1MIRh2d4jpjWTWKL78xfTNM+kowwzfv8qkE82cb026W5G1qkrYtKhNqH+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752867162; c=relaxed/simple;
	bh=K99HOChkwzj9Qt2ERmthagrt4Bk0oLacVF2RjD5dmqo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uhPyDYxR0ecOmZI2z8EAFmiwr852cDu/VQKp2fcW4xBl34lXJCW1NuuBAgR2OjkIKueZPBQMBz/Gr3fVPQp9KOIuzpaa5LLwYfIliRtSh/OwNNHNkhDQmI6CtK/5i/ouQ9dck4LPX8vx2skVkHpsQ/uKhvuhRO5ZT4q9lvwssfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=B2Y5kCyi; arc=none smtp.client-ip=95.215.58.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1752867157;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=nb5TyoE8w1XMbRA9VrHo2sosP4NiPXF72ApZr9GbCQI=;
	b=B2Y5kCyiFXzpvBdHcFzP+4L6doXPWOJwgls3lHy3mTjyj/mWZxPYqDEDjQxxSZAMcgkRxv
	/L0UOmCmWgK/vg5vmcvo1voDsBOCCTp8nteCD3TPwQFwzTDC42epwo+IqGnuQ4nAFuu+tS
	W1alD7YDizezeoUMyU6gfcBmTf5aKJ8=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Jason Wessel <jason.wessel@windriver.com>,
	Daniel Thompson <danielt@kernel.org>,
	Douglas Anderson <dianders@chromium.org>
Cc: linux-hardening@vger.kernel.org,
	Thorsten Blum <thorsten.blum@linux.dev>,
	kgdb-bugreport@lists.sourceforge.net,
	linux-kernel@vger.kernel.org
Subject: [PATCH] kernel: debug: Replace deprecated strcpy() with strscpy()
Date: Fri, 18 Jul 2025 21:32:21 +0200
Message-ID: <20250718193220.316685-2-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

strcpy() is deprecated; use strscpy() instead.

Link: https://github.com/KSPP/linux/issues/88
Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 kernel/debug/gdbstub.c | 29 +++++++++++++++--------------
 1 file changed, 15 insertions(+), 14 deletions(-)

diff --git a/kernel/debug/gdbstub.c b/kernel/debug/gdbstub.c
index f625172d4b67..22fe969c5d2e 100644
--- a/kernel/debug/gdbstub.c
+++ b/kernel/debug/gdbstub.c
@@ -30,6 +30,7 @@
 #include <linux/kgdb.h>
 #include <linux/kdb.h>
 #include <linux/serial_core.h>
+#include <linux/string.h>
 #include <linux/reboot.h>
 #include <linux/uaccess.h>
 #include <asm/cacheflush.h>
@@ -547,7 +548,7 @@ static void gdb_cmd_setregs(struct kgdb_state *ks)
 		error_packet(remcom_out_buffer, -EINVAL);
 	} else {
 		gdb_regs_to_pt_regs(gdb_regs, ks->linux_regs);
-		strcpy(remcom_out_buffer, "OK");
+		strscpy(remcom_out_buffer, "OK");
 	}
 }
 
@@ -577,7 +578,7 @@ static void gdb_cmd_memwrite(struct kgdb_state *ks)
 	if (err)
 		error_packet(remcom_out_buffer, err);
 	else
-		strcpy(remcom_out_buffer, "OK");
+		strscpy(remcom_out_buffer, "OK");
 }
 
 #if DBG_MAX_REG_NUM > 0
@@ -630,7 +631,7 @@ static void gdb_cmd_reg_set(struct kgdb_state *ks)
 	i = i / 2;
 	kgdb_hex2mem(ptr, (char *)gdb_regs, i);
 	dbg_set_reg(regnum, gdb_regs, ks->linux_regs);
-	strcpy(remcom_out_buffer, "OK");
+	strscpy(remcom_out_buffer, "OK");
 }
 #endif /* DBG_MAX_REG_NUM > 0 */
 
@@ -642,7 +643,7 @@ static void gdb_cmd_binwrite(struct kgdb_state *ks)
 	if (err)
 		error_packet(remcom_out_buffer, err);
 	else
-		strcpy(remcom_out_buffer, "OK");
+		strscpy(remcom_out_buffer, "OK");
 }
 
 /* Handle the 'D' or 'k', detach or kill packets */
@@ -656,7 +657,7 @@ static void gdb_cmd_detachkill(struct kgdb_state *ks)
 		if (error < 0) {
 			error_packet(remcom_out_buffer, error);
 		} else {
-			strcpy(remcom_out_buffer, "OK");
+			strscpy(remcom_out_buffer, "OK");
 			kgdb_connected = 0;
 		}
 		put_packet(remcom_out_buffer);
@@ -676,7 +677,7 @@ static int gdb_cmd_reboot(struct kgdb_state *ks)
 	/* For now, only honor R0 */
 	if (strcmp(remcom_in_buffer, "R0") == 0) {
 		printk(KERN_CRIT "Executing emergency reboot\n");
-		strcpy(remcom_out_buffer, "OK");
+		strscpy(remcom_out_buffer, "OK");
 		put_packet(remcom_out_buffer);
 
 		/*
@@ -739,7 +740,7 @@ static void gdb_cmd_query(struct kgdb_state *ks)
 
 	case 'C':
 		/* Current thread id */
-		strcpy(remcom_out_buffer, "QC");
+		strscpy(remcom_out_buffer, "QC");
 		ks->threadid = shadow_pid(current->pid);
 		int_to_threadref(thref, ks->threadid);
 		pack_threadid(remcom_out_buffer + 2, thref);
@@ -773,7 +774,7 @@ static void gdb_cmd_query(struct kgdb_state *ks)
 			int len = strlen(remcom_in_buffer + 6);
 
 			if ((len % 2) != 0) {
-				strcpy(remcom_out_buffer, "E01");
+				strscpy(remcom_out_buffer, "E01");
 				break;
 			}
 			kgdb_hex2mem(remcom_in_buffer + 6,
@@ -785,14 +786,14 @@ static void gdb_cmd_query(struct kgdb_state *ks)
 			kdb_parse(remcom_out_buffer);
 			kdb_common_deinit_state();
 
-			strcpy(remcom_out_buffer, "OK");
+			strscpy(remcom_out_buffer, "OK");
 		}
 		break;
 #endif
 #ifdef CONFIG_HAVE_ARCH_KGDB_QXFER_PKT
 	case 'S':
 		if (!strncmp(remcom_in_buffer, "qSupported:", 11))
-			strcpy(remcom_out_buffer, kgdb_arch_gdb_stub_feature);
+			strscpy(remcom_out_buffer, kgdb_arch_gdb_stub_feature);
 		break;
 	case 'X':
 		if (!strncmp(remcom_in_buffer, "qXfer:", 6))
@@ -822,7 +823,7 @@ static void gdb_cmd_task(struct kgdb_state *ks)
 		}
 		kgdb_usethread = thread;
 		ks->kgdb_usethreadid = ks->threadid;
-		strcpy(remcom_out_buffer, "OK");
+		strscpy(remcom_out_buffer, "OK");
 		break;
 	case 'c':
 		ptr = &remcom_in_buffer[2];
@@ -837,7 +838,7 @@ static void gdb_cmd_task(struct kgdb_state *ks)
 			}
 			kgdb_contthread = thread;
 		}
-		strcpy(remcom_out_buffer, "OK");
+		strscpy(remcom_out_buffer, "OK");
 		break;
 	}
 }
@@ -851,7 +852,7 @@ static void gdb_cmd_thread(struct kgdb_state *ks)
 	kgdb_hex2long(&ptr, &ks->threadid);
 	thread = getthread(ks->linux_regs, ks->threadid);
 	if (thread)
-		strcpy(remcom_out_buffer, "OK");
+		strscpy(remcom_out_buffer, "OK");
 	else
 		error_packet(remcom_out_buffer, -EINVAL);
 }
@@ -913,7 +914,7 @@ static void gdb_cmd_break(struct kgdb_state *ks)
 			(int) length, *bpt_type - '0');
 
 	if (error == 0)
-		strcpy(remcom_out_buffer, "OK");
+		strscpy(remcom_out_buffer, "OK");
 	else
 		error_packet(remcom_out_buffer, error);
 }
-- 
2.50.1


