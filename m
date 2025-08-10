Return-Path: <linux-kernel+bounces-761463-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 565C2B1FA69
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Aug 2025 16:25:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 142573A9801
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Aug 2025 14:24:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F15D8267B12;
	Sun, 10 Aug 2025 14:24:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="j5H5RdXC"
Received: from out-174.mta0.migadu.com (out-174.mta0.migadu.com [91.218.175.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E25FA263F28
	for <linux-kernel@vger.kernel.org>; Sun, 10 Aug 2025 14:24:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754835893; cv=none; b=KSJKhJsEc+2E7DKkDB6HI+6k4qM7tzlLT0U1FRnkQiSGLyMwUDPLFA+e8HIM+YTKbreSbwUNskct3ryVKWHxVQT6r9qKinlEmYZbzqJEB7MJR4vZrdNctmmcR98pBtOD3rHRv+qBVzqAYIKPq0gTgDVMncdyvqSd4CEjLNgLysE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754835893; c=relaxed/simple;
	bh=DKtYUTZwKfe/xnDN0Q/eysOMuDlr3kISgoRxy7/gk1Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QVDlD+dkK3e7EZd9teu4w815frDpym323P+xmzQZDfdOzTz/HiLtBqsn3Ugj4dOwERbyxMiCFAfaVlVZ8w4EfQ5z6b/u9vSLsUFOZTgqo0VspQ/1f9zJDChflzSknVHBwZfvWujgACUnCIr9s2tXsoD0su4+7WGNAVD0gKTHusk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=j5H5RdXC; arc=none smtp.client-ip=91.218.175.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1754835878;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=n4pmp2kBGyL11OgvKZgasa0Vva47EK/DLMdAgh/XFsY=;
	b=j5H5RdXCAWRchHzn+mg/WyfpaUoMpgzFGeVIbiUraHhtlasL2GmABZTOhxSLg3LFvmDbQD
	+rIjgzxZE0k8T4954C95AYhfEBivQ4okS3bwcM1NhYrgdPIBRPjlulk+VzQSCK09ogLzVi
	0yj7AQKp3SGDavXmSi3xhCQ8yJOiRp8=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Masahiro Yamada <masahiroy@kernel.org>,
	Thorsten Blum <thorsten.blum@linux.dev>,
	Randy Dunlap <rdunlap@infradead.org>,
	Nicolas Schier <nicolas.schier@linux.dev>,
	Shankari Anand <shankari.ak0208@gmail.com>,
	"nir.tzachar@gmail.com" <nir.tzachar@gmail.com>,
	Michal Marek <mmarek@suse.cz>
Cc: stable@vger.kernel.org,
	linux-kbuild@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] kconfig: nconf: NUL-terminate 'line' correctly in fill_window()
Date: Sun, 10 Aug 2025 16:22:37 +0200
Message-ID: <20250810142239.120294-2-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Use 'min(len, x)' as the index instead of just 'len' to NUL-terminate
the copied 'line' string at the correct position.

Add a newline after the local variable declarations to silence a
checkpatch warning.

Cc: stable@vger.kernel.org
Fixes: 692d97c380c6 ("kconfig: new configuration interface (nconfig)")
Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 scripts/kconfig/nconf.gui.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/scripts/kconfig/nconf.gui.c b/scripts/kconfig/nconf.gui.c
index 7206437e784a..ec021ebd2c52 100644
--- a/scripts/kconfig/nconf.gui.c
+++ b/scripts/kconfig/nconf.gui.c
@@ -175,8 +175,9 @@ void fill_window(WINDOW *win, const char *text)
 	for (i = 0; i < total_lines; i++) {
 		char tmp[x+10];
 		const char *line = get_line(text, i);
-		int len = get_line_length(line);
-		strncpy(tmp, line, min(len, x));
+		int len = min(get_line_length(line), x);
+
+		strncpy(tmp, line, len);
 		tmp[len] = '\0';
 		mvwprintw(win, i, 0, "%s", tmp);
 	}
-- 
2.50.1


