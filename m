Return-Path: <linux-kernel+bounces-768749-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E875DB264F7
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 14:05:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E24571C27725
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 12:05:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09F412FD1C5;
	Thu, 14 Aug 2025 12:05:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="cu0SHYHJ"
Received: from out-171.mta1.migadu.com (out-171.mta1.migadu.com [95.215.58.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E4532FC891
	for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 12:05:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755173115; cv=none; b=tQgTw2EKy5AroqmshXLSqE70kvj0ngeIqazqf6ScqHTXiI+ZYF3ItSxdcOEDnF7HUqVs3fBo1N59SushkOGuq9bPQ3BwxWmDxB8GANF6u9BM8OTRjD4Tt8uooMPhTIhpuq7e8nZRYhLrs7xrZcAHp1aI6vAF4f+vJKfEroIrBrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755173115; c=relaxed/simple;
	bh=ZUzZD9vc/qfpF+dRCR5SITztXA1r9JjOxRlbeJKLBDI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=d56GQyFJHZrcXQk90eXJ7xXQ9vvf6yBUc3ndzmHYhhHAzYddcad4SpnyaLe0rOk82jstHZGJoirHu5idPc3LY0VSpPXDDyjQWQgTudEF0rB54z8dnKnOKEItDgfRZSrzvkyux4m/o8x7vyTGAa4dsNO90XNyuHJkrIp4xQMtNDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=cu0SHYHJ; arc=none smtp.client-ip=95.215.58.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1755173099;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=RwwfVIkcE9AyO7mM/6kI4iyF3cvpAbFGcgfbwetU2M0=;
	b=cu0SHYHJzdsvKrJnBYh0JEyIE75X14ZAspzB7sFwJS4T2P226zXlonYvTzgIrwiUX0TO0l
	FqrPhwC846PghwqWAykyvP3GsbA6znNN58YHge3iYLU4lRjE+23JjW3oX0iOHtfOu238/J
	q2spVj3pG9boSfJCWgoZezEpVvIXHKQ=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Jason Wessel <jason.wessel@windriver.com>,
	Daniel Thompson <danielt@kernel.org>,
	Douglas Anderson <dianders@chromium.org>,
	Nir Lichtman <nir@lichtman.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Yuran Pereira <yuran.pereira@hotmail.com>
Cc: linux-hardening@vger.kernel.org,
	Thorsten Blum <thorsten.blum@linux.dev>,
	Daniel Thompson <daniel@riscstar.com>,
	kgdb-bugreport@lists.sourceforge.net,
	linux-kernel@vger.kernel.org
Subject: [PATCH] kdb: Replace deprecated strcpy() with strscpy()
Date: Thu, 14 Aug 2025 14:03:37 +0200
Message-ID: <20250814120338.219585-2-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

strcpy() is deprecated; use strscpy() instead and remove several manual
NUL-terminations.

Since the destination buffers 'cmd_cur' and 'cmd_hist[cmd_head]' have
the fixed length CMD_BUFLEN, strscpy() automatically determines their
size using sizeof() when the size argument is omitted. This makes the
explicit size arguments for the existing strscpy() calls unnecessary,
remove them.

No functional changes intended.

Link: https://github.com/KSPP/linux/issues/88
Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 kernel/debug/kdb/kdb_main.c | 32 ++++++++++++++------------------
 1 file changed, 14 insertions(+), 18 deletions(-)

diff --git a/kernel/debug/kdb/kdb_main.c b/kernel/debug/kdb/kdb_main.c
index 7a4d2d4689a5..ea7dc2540e40 100644
--- a/kernel/debug/kdb/kdb_main.c
+++ b/kernel/debug/kdb/kdb_main.c
@@ -727,14 +727,10 @@ static int kdb_defcmd(int argc, const char **argv)
 	mp->help = kdb_strdup(argv[3], GFP_KDB);
 	if (!mp->help)
 		goto fail_help;
-	if (mp->usage[0] == '"') {
-		strcpy(mp->usage, argv[2]+1);
-		mp->usage[strlen(mp->usage)-1] = '\0';
-	}
-	if (mp->help[0] == '"') {
-		strcpy(mp->help, argv[3]+1);
-		mp->help[strlen(mp->help)-1] = '\0';
-	}
+	if (mp->usage[0] == '"')
+		strscpy(mp->usage, argv[2] + 1, strlen(argv[2]) - 1);
+	if (mp->help[0] == '"')
+		strscpy(mp->help, argv[3] + 1, strlen(argv[3]) - 1);
 
 	INIT_LIST_HEAD(&kdb_macro->statements);
 	defcmd_in_progress = true;
@@ -860,7 +856,7 @@ static void parse_grep(const char *str)
 		kdb_printf("search string too long\n");
 		return;
 	}
-	strcpy(kdb_grep_string, cp);
+	strscpy(kdb_grep_string, cp);
 	kdb_grepping_flag++;
 	return;
 }
@@ -1076,12 +1072,12 @@ static int handle_ctrl_cmd(char *cmd)
 		if (cmdptr != cmd_tail)
 			cmdptr = (cmdptr + KDB_CMD_HISTORY_COUNT - 1) %
 				 KDB_CMD_HISTORY_COUNT;
-		strscpy(cmd_cur, cmd_hist[cmdptr], CMD_BUFLEN);
+		strscpy(cmd_cur, cmd_hist[cmdptr]);
 		return 1;
 	case CTRL_N:
 		if (cmdptr != cmd_head)
 			cmdptr = (cmdptr+1) % KDB_CMD_HISTORY_COUNT;
-		strscpy(cmd_cur, cmd_hist[cmdptr], CMD_BUFLEN);
+		strscpy(cmd_cur, cmd_hist[cmdptr]);
 		return 1;
 	}
 	return 0;
@@ -1285,19 +1281,19 @@ static int kdb_local(kdb_reason_t reason, int error, struct pt_regs *regs,
 		cmdbuf = kdb_getstr(cmdbuf, CMD_BUFLEN, kdb_prompt_str);
 		if (*cmdbuf != '\n') {
 			if (*cmdbuf < 32) {
-				if (cmdptr == cmd_head) {
+				if (cmdptr == cmd_head)
+					/* Copy the current command to the
+					 * history and let strscpy() replace the
+					 * last character with a NUL terminator.
+					 */
 					strscpy(cmd_hist[cmd_head], cmd_cur,
-						CMD_BUFLEN);
-					*(cmd_hist[cmd_head] +
-					  strlen(cmd_hist[cmd_head])-1) = '\0';
-				}
+						strlen(cmd_cur));
 				if (!handle_ctrl_cmd(cmdbuf))
 					*(cmd_cur+strlen(cmd_cur)-1) = '\0';
 				cmdbuf = cmd_cur;
 				goto do_full_getstr;
 			} else {
-				strscpy(cmd_hist[cmd_head], cmd_cur,
-					CMD_BUFLEN);
+				strscpy(cmd_hist[cmd_head], cmd_cur);
 			}
 
 			cmd_head = (cmd_head+1) % KDB_CMD_HISTORY_COUNT;
-- 
2.50.1


