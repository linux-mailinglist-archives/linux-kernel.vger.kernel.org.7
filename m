Return-Path: <linux-kernel+bounces-891843-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A823C43A3F
	for <lists+linux-kernel@lfdr.de>; Sun, 09 Nov 2025 09:37:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id DB6134E1B6C
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Nov 2025 08:37:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 635232C1780;
	Sun,  9 Nov 2025 08:37:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i6L5ZS5w"
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54D712C11E7
	for <linux-kernel@vger.kernel.org>; Sun,  9 Nov 2025 08:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762677451; cv=none; b=m3zt8cFq4D//737KKU6gxc1/HyOD/xUauJ2dz70iaHXJXjnyLLv5plSByT/FECFQ6CgggVYK475+AdLyVLPeFeYmckPbq46btHxMfw0tV0rw6MLsarxhFllW093XPxP8n+IuxUcmAcnfa5JimZOiotgerz3+ELsDDIIgJ8bSFQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762677451; c=relaxed/simple;
	bh=42SlGVlCpQ/P26E4xhlQely8LBdZ+0nU5CjNjqqzYWc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=meOiXp63KP3zWJGNguKf0NhSeU7DWQe6/13QM6WUWnjebjsxuW1CFD1zf4KMt8rjn63TiHveTqOhcIpEg2RB5mYzEXVPOmy/gdPp7O08w3iQHn/nMQ2EEG3YernaBhz+fzEKWJVHqHFUgWG8CbfaP1laUF3XKyHqqETUN0Tb9SM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i6L5ZS5w; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-7ae4656d6e4so2508034b3a.1
        for <linux-kernel@vger.kernel.org>; Sun, 09 Nov 2025 00:37:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762677450; x=1763282250; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+pai05e1hPAGzD+JDMKw8YIk3y/PWAM8SYYHTXpXZd4=;
        b=i6L5ZS5wX3TP1lo4pJiQqavQ0J6Xi/tg+ELg9wkcDMuChHgRyOUN4kaOpnyr1kwX/I
         +pbXsq1+RXa0A+uvLz8caUlYCB9SNtC2LW2DgVzExF700Ik4+nWNi1JSJkc2XRvXtW74
         2kesxCKFiddEFxlRPpCaeMJT6A+Q7i1h7jpSK2PuB7t/s379Dlx6JVtrRqNL++Lns2N4
         PJO2trjnMadwXdRZZmsKdqPEHFK4eDUxqTb+N/r/LPHS/ytf43Tivo2hCG6fdfDeI4i9
         4ndLovetXtz1THWVYTFDS2yQRNQKQ2lWhPzc68U0ORx7oxKqlWqQxNldTTgSUYS8co8R
         yCQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762677450; x=1763282250;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+pai05e1hPAGzD+JDMKw8YIk3y/PWAM8SYYHTXpXZd4=;
        b=SSu7rki3o04JQZBQ9YDtibeDNtWN6s1IW6Ia9mamO6sbPEcdCxWdwStKNCldlGRXyB
         bfrwGX6L3rRtrZiYgGiCVOREleuwWXweSowT0x3B/5J6Cf5wIMNTSKr84Wzr9Poh+HXI
         vtPPto/EBTZfnJ3DoSmQ/b/uybnN7o/aUUM0pFqyfdAO1qyLu4L5o9AXIyL/eezlP1PI
         9NP+heJL5syR3PvSgw/EDKAfduIwpiyPfq4wnz9NIDS5Z5+DKykPIqmp3NxzyOW9+GmK
         KPqp0zsoR0KmfwS73QLF9ZU7QgafYawO/t/LA2G3i6dJGuJ0WM7p4VsbH38BGVU1RXew
         w3xQ==
X-Gm-Message-State: AOJu0YzlYtiJ5qMH5f7sLarLgLag3cC75kySZrcLrtuLLk+imH5/XBg5
	0RVL8YL/dw6gelgtg7/1v3YEBvlAsAirTbQED25ybHndP2iy8c5T7qmm
X-Gm-Gg: ASbGnctvNwCD1tj6RVpYUBGM31KvSIO7TpQSQCEnUYw4sKqBP6PehQ++fw1PIYjNm5O
	ehPi02XGfEL5j1WAYAD49fzHySemN9cnfMo0nByDwJX07Wb9VYlxY6X3D/nlDIKWkExQtBeRJgK
	HWRTBGqcnYgG8dtVqD70+9EItwoOrtIFLBFk82k2eUpN/IivZWva701E9ZyHDVsYTj8ZMblW5gm
	FftgIp1va8fwyU/sIHzLjGufB7cdyMa+mMVSjNw7ircPqwVnjCwgavZwSGVPDt8eMt3bpcNqGiw
	kUHyTXnyLhWgsRqG+6TM5afrG9rzXfBX6k2ItXQOGyWsbZx4cAibb9OoUgP5aqTn/9aswRwi6hP
	6KEba0K0NgMORLyhFa+vZDNUky76fHeQB7N9r3jP+cIhCw3gjnfEOhMlL8c3Yx2tI0/e3Vdb+YL
	peqC3o6woWF5H1VPuogNIETitH
X-Google-Smtp-Source: AGHT+IFKEu4tYw0M4y2gVr7qt+7rNApZrwM+nFaRqD3qTEIP52a3V5zmhTK07hKkia27YNGZFVwKBA==
X-Received: by 2002:a05:6a20:3d82:b0:342:3b8a:f33e with SMTP id adf61e73a8af0-353a1ae221bmr6350944637.39.1762677449580;
        Sun, 09 Nov 2025 00:37:29 -0800 (PST)
Received: from DESKTOP-8TIG9K0.localdomain ([119.28.20.50])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-ba8f9ed21f6sm9934944a12.13.2025.11.09.00.37.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Nov 2025 00:37:29 -0800 (PST)
From: Xie Yuanbin <qq570070308@gmail.com>
To: nathan@kernel.org,
	nick.desaulniers+lkml@gmail.com,
	morbo@google.com,
	justinstitt@google.com,
	qq570070308@gmail.com,
	masahiroy@kernel.org,
	jack@suse.cz,
	akpm@linux-foundation.org,
	maninder1.s@samsung.com
Cc: linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev,
	will@kernel.org
Subject: [PATCH] Fix redundant judgment in WARN_ONCE with clang
Date: Sun,  9 Nov 2025 16:37:15 +0800
Message-ID: <20251109083715.24495-1-qq570070308@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For c code:
```c
extern int xx;
void test(void)
{
	if (WARN_ONCE(xx, "x"))
		__asm__ volatile ("nop":::);
}
```

Clang will generate the following assembly code:
```assemble
test:
	movl	xx(%rip), %eax // Assume xx == 0 (likely case)
	testl	%eax, %eax // judge once
	je	.LBB0_3    // jump to .LBB0_3
	testb	$1, test.__already_done(%rip)
	je	.LBB0_2
.LBB0_3:
	testl	%eax, %eax // judge again
	je	.LBB0_5    // jump to .LBB0_5
.LBB0_4:
	nop
.LBB0_5:
	retq
	// omit
```

In the above code, `xx == 0` should be a likely case, but in this case,
xx has been judged twice.

Test info:
1. kernel source:
linux-next
commit 9c0826a5d9aa4d52206d ("Add linux-next specific files for 20251107")
2. compiler:
clang: Debian clang version 21.1.4 (8) with
Debian LLD 21.1.4 (compatible with GNU linkers)
3. config:
base on default x86_64_defconfig, and setting:
CONFIG_MITIGATION_RETHUNK=n
CONFIG_STACKPROTECTOR=n

Add unlikely to __ret_cond to help the compiler optimize correctly.

Signed-off-by: Xie Yuanbin <qq570070308@gmail.com>
---
 include/linux/once_lite.h | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/include/linux/once_lite.h b/include/linux/once_lite.h
index 27de7bc32a06..194c5ebbfbc4 100644
--- a/include/linux/once_lite.h
+++ b/include/linux/once_lite.h
@@ -10,17 +10,17 @@
 #define DO_ONCE_LITE(func, ...)						\
 	DO_ONCE_LITE_IF(true, func, ##__VA_ARGS__)
 
-#define __ONCE_LITE_IF(condition)					\
-	({								\
-		static bool __section(".data..once") __already_done;	\
-		bool __ret_cond = !!(condition);			\
-		bool __ret_once = false;				\
-									\
-		if (unlikely(__ret_cond && !__already_done)) {		\
-			__already_done = true;				\
-			__ret_once = true;				\
-		}							\
-		unlikely(__ret_once);					\
+#define __ONCE_LITE_IF(condition)						\
+	({									\
+		static bool __section(".data..once") __already_done;		\
+		bool __ret_cond = !!(condition);				\
+		bool __ret_once = false;					\
+										\
+		if (unlikely(__ret_cond) && unlikely(!__already_done)) {	\
+			__already_done = true;					\
+			__ret_once = true;					\
+		}								\
+		unlikely(__ret_once);						\
 	})
 
 #define DO_ONCE_LITE_IF(condition, func, ...)				\
-- 
2.51.0


