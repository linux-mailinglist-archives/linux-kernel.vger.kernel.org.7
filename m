Return-Path: <linux-kernel+bounces-772652-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 40E5EB295A3
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 01:14:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DD60320300C
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Aug 2025 23:14:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF1831DEFF5;
	Sun, 17 Aug 2025 23:14:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="pZBKp2xi"
Received: from out-189.mta0.migadu.com (out-189.mta0.migadu.com [91.218.175.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2203136358
	for <linux-kernel@vger.kernel.org>; Sun, 17 Aug 2025 23:14:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755472466; cv=none; b=ZbAFxikHPGmhweinpTyduLRyLWDP4FkMFtfo09jpMQYkYSQCwEYWx+hRjaFyPe2T8JLlJMCodGYsYz+NyUdKXPgb/I4m2rVeJXzYSdfpRcUCIlJUaGOdtjeTPi6krkhjMUbqaUMVzEKxwiYtijroxJSfmQX0k7TNXyv2CVgPNLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755472466; c=relaxed/simple;
	bh=IuNTL0UjZ9FyMq5j1Kv6qX3bLqNk3omOsZHSbhDCGg8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=h+ttoZ0NQnl8Kymor7c2QCbQDFAMYC62xEfnnGi+UIQxEEe5UGcT+NtB1XJpG+OwBtcEP/BqAPceAw/Cvb6WM8qPWwPLbVkFYiBH8iML5n/Wql34sHyjmmKxmvCPkNh+rCq/kk4OWkG0HZeLjSorKGJSBWg+/q5d4xA9cuGWbLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=pZBKp2xi; arc=none smtp.client-ip=91.218.175.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1755472457;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=ax3TNvSzFaZdgmycqC+0R/nd1Ix/btsJ7d2lf/pRXeU=;
	b=pZBKp2xioJNvNEhor/hALZ1n6tKDAahkJ7G8YHTDzCaZ3Cj1FUP96VhdAXxTJxqdSR+D/8
	XaFkKkp4Qpu7XbkpUYXdegblwCR4v2wLC/+GZmyo70cM/xz8mdCVSyE1LJG6V/Gq2u4+Lk
	10mfJqAmVanY4YfUplPqa/r5cCbbPyk=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Jason Wessel <jason.wessel@windriver.com>,
	Daniel Thompson <danielt@kernel.org>,
	Douglas Anderson <dianders@chromium.org>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	kgdb-bugreport@lists.sourceforge.net,
	linux-kernel@vger.kernel.org
Subject: [PATCH RESEND] kernel: debug: gdbstub: Replace deprecated strcpy() with strscpy()
Date: Mon, 18 Aug 2025 01:13:49 +0200
Message-ID: <20250817231349.633458-2-thorsten.blum@linux.dev>
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
Reviewed-by: Douglas Anderson <dianders@chromium.org>
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


