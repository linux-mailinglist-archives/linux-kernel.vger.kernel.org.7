Return-Path: <linux-kernel+bounces-623117-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 29833A9F122
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Apr 2025 14:42:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6AD281A82BCF
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Apr 2025 12:42:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 511E32741BE;
	Mon, 28 Apr 2025 12:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="TDZbsVYD";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="UD1wW/mG"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA49F26FA78;
	Mon, 28 Apr 2025 12:40:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745844019; cv=none; b=J4HMlUDxEYXCZ13KQbG7Yjit1KuMeKq6t/crQnwAas54xrcITqyWMligK31nRZWg2bVotVE0wlbSXifbkiedt4p30CexViLR2OF01AWfE3V3cRod7Ib8IYXPk4o4XwgoHE87mc6dDzrubeHsh4skbyMp+m+O3GppJ/qZPpLGVLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745844019; c=relaxed/simple;
	bh=HQLcfa8CaI5ExDZqkRSeOEeJwuLKsNYi1GOJJ28A+8k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Q20DSRWMuG4HZMCKLs41dTDQGHLOR3U/0qkKrw/sfZXwnnOX9aft1aRpzMCDmBEVt1hG09NnA44/45cJqyonh2nkzZDkXH/gbkTppDCvCeuJrA3SwnopFaLfrMaf2XeYdJIk8pNs71RAk4mzONhhx1P42znly+SHvTV+qON5cwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=TDZbsVYD; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=UD1wW/mG; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1745844016;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=F/pw8wmkd0xKcovIdkDVLZ9oevdZmMFufDwKnizO/wc=;
	b=TDZbsVYDviz8q+3+gRWPWagV90ztMeLDLom8jk5F3RmlRHLWwxjt4uYOtWMuJrs0t/NP50
	VNJb0pLRtI7edvyJEV4XxP84eissUfGnWAcuQ0rYw+s8xKdg/kL3sr7ZLNwaIOUY5ACiY5
	VqKp3zAuWxtVPjpE397ITycHDv7ll/QXc7ANQW2LqCmm6Q1ir/nzsTnVduxLUPRP7rOwJy
	OB2XnZ2WV0Ru0wXv9ImQUQyCFyOv30XwjLOHH/9giIDu8nCFicw3BiF1binGZvikAzRVAD
	psH4HncwrEJ/TWa+R+BF6UbQBlbZ73ZRCRZrJpZXF3AVvo5+E6G474UAS5oCIw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1745844016;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=F/pw8wmkd0xKcovIdkDVLZ9oevdZmMFufDwKnizO/wc=;
	b=UD1wW/mGQrDhfY1TKM5SshCLjY1HXUbma+nTJqYOBYNXEEvPo01edTscho8FCGKLEHOsuT
	ZiajE+r1WqyzT3CQ==
Date: Mon, 28 Apr 2025 14:40:16 +0200
Subject: [PATCH v2 15/15] tools/nolibc: implement wait() in terms of
 waitpid()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250428-nolibc-misc-v2-15-3c043eeab06c@linutronix.de>
References: <20250428-nolibc-misc-v2-0-3c043eeab06c@linutronix.de>
In-Reply-To: <20250428-nolibc-misc-v2-0-3c043eeab06c@linutronix.de>
To: Willy Tarreau <w@1wt.eu>, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>, 
 Shuah Khan <shuah@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1745844007; l=1268;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=HQLcfa8CaI5ExDZqkRSeOEeJwuLKsNYi1GOJJ28A+8k=;
 b=r3v1ZxwU6rznEjDY9nXpXALVJJQXvujCbkZBw2Oqf8gwunfOEffDHSL7EhlXLv/yBpyTsT7y2
 g10hNVhfQZsCiBZy3vGa1obxCRVZRL7XDn4XL3CT7c3q0GKRu7XShC5
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

Newer architectures like riscv 32-bit are missing sys_wait4().
Make use of the fact that wait(&status) is defined to be equivalent to
waitpid(-1, status, 0) to implment it on all architectures.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
Acked-by: Willy Tarreau <w@1wt.eu>
---
 tools/include/nolibc/sys/wait.h | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/tools/include/nolibc/sys/wait.h b/tools/include/nolibc/sys/wait.h
index f27be86ad5e480f3817b4500ac42fae445cdfc27..4d44e3da0ba814d00368027d893e2eb1155b86f3 100644
--- a/tools/include/nolibc/sys/wait.h
+++ b/tools/include/nolibc/sys/wait.h
@@ -31,12 +31,6 @@ pid_t sys_wait4(pid_t pid, int *status, int options, struct rusage *rusage)
 #endif
 }
 
-static __attribute__((unused))
-pid_t wait(int *status)
-{
-	return __sysret(sys_wait4(-1, status, 0, NULL));
-}
-
 static __attribute__((unused))
 pid_t wait4(pid_t pid, int *status, int options, struct rusage *rusage)
 {
@@ -113,4 +107,10 @@ pid_t waitpid(pid_t pid, int *status, int options)
 	return info.si_pid;
 }
 
+static __attribute__((unused))
+pid_t wait(int *status)
+{
+	return waitpid(-1, status, 0);
+}
+
 #endif /* _NOLIBC_SYS_WAIT_H */

-- 
2.49.0


