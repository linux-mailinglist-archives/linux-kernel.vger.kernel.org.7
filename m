Return-Path: <linux-kernel+bounces-657449-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D40C7ABF439
	for <lists+linux-kernel@lfdr.de>; Wed, 21 May 2025 14:21:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8FDBB163FC3
	for <lists+linux-kernel@lfdr.de>; Wed, 21 May 2025 12:21:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C837C2638A0;
	Wed, 21 May 2025 12:21:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="GfjDWImK"
Received: from out-177.mta1.migadu.com (out-177.mta1.migadu.com [95.215.58.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 847471F92E
	for <linux-kernel@vger.kernel.org>; Wed, 21 May 2025 12:21:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747830062; cv=none; b=Zwg5ETsjNIvyb0+xTDMbJbCEaZNJdFcjKsUXEPqkQqQ0E1KgYS508765mWb7n9OYnfnbUuo5xy7MgvzN8x/6OYHvkmFR76tDiNGrbIyAfMbYnByRxNMBAjGHpphBTWv4OUNcTEaPp6seHyKDbr7tMvFruhRynR1q+dEzO1BRTzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747830062; c=relaxed/simple;
	bh=GbdOj3vJ/q4X+/2t6OHFHhPM4HGzw4Vsiy/W4r3FnA0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=geblx+LTKGqf0zTI6rmad7Z1PP5Hx5aeju+pnjYtypztucsl4P3w6P5o9R3GE8eNdr8o3/bDYa+qw4Xozz8tmfK6sjktqemAjBVI/6JDE3bl3d0l3chHv182C43DEdW1FmYiMcGXlSo9el6mdQKxGT62QWrGRJhIozN3uqPdkMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=GfjDWImK; arc=none smtp.client-ip=95.215.58.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1747830048;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Q9TvMyMwPK6rkSNheoWI19m/ZeeUWO8Bp2DZADsG/EE=;
	b=GfjDWImK+YPwdTT3RQre0t6LulVAB1uMQBuCwkjb3p6+j4IOv34/Y/fQi8EGEH8AdmLymZ
	YWVVBfGn3EFJyXKoJlhb1iRwdVv/lPrB5KE9ohM4CpaRuPWcDs88Zv7cuyGbVrYv5ZZkVk
	cPpPJQ/+1S8H+96rQAn2kU2DC+UtT14=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Richard Henderson <richard.henderson@linaro.org>,
	Matt Turner <mattst88@gmail.com>
Cc: linux-hardening@vger.kernel.org,
	Thorsten Blum <thorsten.blum@linux.dev>,
	linux-alpha@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH RESEND] alpha: Replace strcpy() with strscpy() in setup_arch()
Date: Wed, 21 May 2025 14:20:15 +0200
Message-ID: <20250521122016.5891-2-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

strcpy() is deprecated; use strscpy() instead.

Since the destination buffer 'command_line' has a fixed length,
strscpy() automatically determines its size using sizeof() when the size
argument is omitted. This makes the explicit size argument for the
existing strscpy() call unnecessary - remove it.

No functional changes intended.

Link: https://github.com/KSPP/linux/issues/88
Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 arch/alpha/kernel/setup.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/alpha/kernel/setup.c b/arch/alpha/kernel/setup.c
index bebdffafaee8..8b51e6ca83d6 100644
--- a/arch/alpha/kernel/setup.c
+++ b/arch/alpha/kernel/setup.c
@@ -468,8 +468,8 @@ setup_arch(char **cmdline_p)
 	/* 
 	 * Locate the command line.
 	 */
-	strscpy(command_line, COMMAND_LINE, sizeof(command_line));
-	strcpy(boot_command_line, command_line);
+	strscpy(command_line, COMMAND_LINE);
+	strscpy(boot_command_line, command_line, COMMAND_LINE_SIZE);
 	*cmdline_p = command_line;
 
 	/* 
@@ -511,7 +511,7 @@ setup_arch(char **cmdline_p)
 	}
 
 	/* Replace the command line, now that we've killed it with strsep.  */
-	strcpy(command_line, boot_command_line);
+	strscpy(command_line, boot_command_line);
 
 	/* If we want SRM console printk echoing early, do it now. */
 	if (alpha_using_srm && srmcons_output) {
-- 
2.49.0


