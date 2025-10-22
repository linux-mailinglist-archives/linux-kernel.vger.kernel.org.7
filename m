Return-Path: <linux-kernel+bounces-864498-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CE16BFAE77
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 10:31:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3BF06506FF0
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 08:31:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6857E30DEB1;
	Wed, 22 Oct 2025 08:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="BUiKQY7G"
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4BD530147A
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 08:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761121835; cv=none; b=ljhPwfvqdTA8aHZeZLWMJB5O8Nw5btg7PWFosOMZeyem7AdZkcvPw1pdCzKwDzlDoRjwpXMJNSfLzl5rNNpdvWMdvkqPDEiQSfEUOSgyEjxJP9uII7Bc7r8zgYopq5y42d+YwyuFpUqjyis3/Mt90a6UC7nzteAKSOPmkUj5948=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761121835; c=relaxed/simple;
	bh=W4dnQ6OiL+B7d18Li0iqL0CW7ojtCaZYRhjm3iMI5R0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SsN6+HUCnXzn+8m9tyaIZhtix9C8A9fQ6RGuVOIEE4qTYCIW2nrYsDej9AIBSLZTM4emGibexCm9Qwl3yZFUhYJrnQLw59UZUOSSzb3kV8tV6/75cAgxLsuOFhgiEs+tm+/jL3ClQ5MGZJ0ibD5S8HUzggs/q5zVhL/mp3Nhz6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=BUiKQY7G; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4710665e7deso25183195e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 01:30:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1761121830; x=1761726630; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=j2I0pFy6f8OhKSW5/tXVB2hF1U9O55Rf8oI8wZFnUIk=;
        b=BUiKQY7GzUcZralMKKwXrVPZZngWNzCX+8fS4Wh04r0LYuqzs8ga+rveYnHZXfem5X
         35zRACBzxrJjUeo9VG35MpsOQ35D7p5PwJR1zzVKddPdio90aTltY7XOtVUoF0zGT/cO
         44R4KMWt6h7ivfw1t5OYF1SdXAjkbIqlgLBnbxbLZrARWa/rdvK9XOqZzp5P8AGl1tRP
         0KmRQtrnWVEkeELZgA9oY7VjootnMaxPm8UKBhiYdCewmLBsa/P0tTyMYsd1qYhGJczp
         94y8i3+jtsReW9b2uLVOnGGS55Sz6r5o3bCcoJPUWWd3dQN2Gbv4kIR9Hp5WQCFPy8wm
         1Y1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761121830; x=1761726630;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=j2I0pFy6f8OhKSW5/tXVB2hF1U9O55Rf8oI8wZFnUIk=;
        b=EXyzUTwmEiA+LunLuXDp5bktaoweCCsw6gK6wUj9RIIi5cudPOk8SZ1mCJl3Yg2Ppu
         Jw0+56PYh3AC7CvspmWNU48qGHjB9VY/I4VIugGy9ifKJ4PlNiyk26ujRKXD4MH+3+js
         913Y1moCFbVUAbfpS83bStOPqx0cb8zIg9gE+iExStM8xB7ixF2pdkS1k7fyz+Cu5lwU
         KkpFjBFtJcv2Y6auI28wYUhJ9arJNoFVc+H9KvMW/WBynMfTNBVafw9v8oMSeuLrSOpy
         KWefaMVRJKd6+GhEox41RwGyWnudjjFEl/dNhk56PzUNnF4CCmH2T6FA22d90hg3mcdt
         vvbQ==
X-Forwarded-Encrypted: i=1; AJvYcCUCMBWOmAfSRUggeAd+mJdfPX70+wRYL6uFaLAlhvpXYUcEVyb/jE63QXBLzOFLo+MZd23L/ax6C7DW+80=@vger.kernel.org
X-Gm-Message-State: AOJu0YyyO/rFsAgeKihs0tIjKvn3kbrq/YbASLEjKwheiaL3JEGtOMrU
	fwqwlGrAmcR84XAQF3oOcgQGoVEnahDR91TbzjorU1SripaYDDt2lnheQoZO+fbTuik=
X-Gm-Gg: ASbGncuQzM6/xozPKACuG/+iAMUbXJd1O8nN61HUtTYLL0EpjP7GV3foiS+nR5zrRpm
	u3fkY5LRv+4um88B27T3DUKWy24WV9DNdFq8bGLQ8mtFTjgQkI0fxeOzrnQ/TOnXlIgbYQUTQ6s
	1XDFI0fd/3xcBQIkbeY5eTHo33f6P5YiqJ748md1pdPjHd82vNsZ2XGtl8qkjF9ZXV5pHAQoPJq
	hL19QkXohbOqjHlO8BdcKoauKj6QCa/j7OT6psuy/s1MYqMSd5J0rF3K24YmBb7sBHdrlALHp4G
	AztFZF7XHCSqebTm5kTc/BNF+YqQc2XYdl8Gbx4A393XaVGFljcSztgZqqmYXHM2k0XQcPCPLr2
	eb9rmjr79XRFylAy9ZzZEyx8NqQmejFZ8F6uYrU/Xmpx0HzkGjRAvd4Oh3iISvgosG8cm21MInG
	LPEPGqVwMvLM+T7BoMOQ==
X-Google-Smtp-Source: AGHT+IEAsQvi1+jZRATkQNhN/Dc0L4u5Au+wsSC1TmJ90uNJgCNCcyTviA0okluf38Tbj562kD00bQ==
X-Received: by 2002:a05:600c:3b03:b0:46d:d949:daba with SMTP id 5b1f17b1804b1-47117874326mr141739475e9.4.1761121829730;
        Wed, 22 Oct 2025 01:30:29 -0700 (PDT)
Received: from zovi.suse.cz (nat2.prg.suse.com. [195.250.132.146])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-475c428f709sm33712955e9.8.2025.10.22.01.30.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Oct 2025 01:30:29 -0700 (PDT)
From: Petr Pavlu <petr.pavlu@suse.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Luis Chamberlain <mcgrof@kernel.org>,
	Petr Pavlu <petr.pavlu@suse.com>,
	Daniel Gomez <da.gomez@kernel.org>,
	Sami Tolvanen <samitolvanen@google.com>,
	Aaron Tomlin <atomlin@atomlin.com>,
	Randy Dunlap <rdunlap@infradead.org>,
	Petr Mladek <pmladek@suse.com>,
	linux-modules@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] taint/module: Remove unnecessary taint_flag.module field
Date: Wed, 22 Oct 2025 10:28:04 +0200
Message-ID: <20251022082938.26670-1-petr.pavlu@suse.com>
X-Mailer: git-send-email 2.51.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The TAINT_RANDSTRUCT and TAINT_FWCTL flags are mistakenly set in the
taint_flags table as per-module flags. While this can be trivially
corrected, the issue can be avoided altogether by removing the
taint_flag.module field.

This is possible because, since commit 7fd8329ba502 ("taint/module: Clean
up global and module taint flags handling") in 2016, the handling of module
taint flags has been fully generic. Specifically, module_flags_taint() can
print all flags, and the required output buffer size is properly defined in
terms of TAINT_FLAGS_COUNT. The actual per-module flags are always those
added to module.taints by calls to add_taint_module().

Signed-off-by: Petr Pavlu <petr.pavlu@suse.com>
---
The patch is based on linux-next (20251021) because I wanted to avoid
a conflict with "taint: add reminder about updating docs and scripts" [1],
which is currently queued in mm-nonmm-unstable.

[1] https://lore.kernel.org/all/20251015221626.1126156-1-rdunlap@infradead.org/

---
 include/linux/panic.h |  1 -
 kernel/module/main.c  |  2 +-
 kernel/panic.c        | 46 ++++++++++++++++++++-----------------------
 3 files changed, 22 insertions(+), 27 deletions(-)

diff --git a/include/linux/panic.h b/include/linux/panic.h
index 6f972a66c13e..a00bc0937698 100644
--- a/include/linux/panic.h
+++ b/include/linux/panic.h
@@ -86,7 +86,6 @@ static inline void set_arch_panic_timeout(int timeout, int arch_default_timeout)
 struct taint_flag {
 	char c_true;		/* character printed when tainted */
 	char c_false;		/* character printed when not tainted */
-	bool module;		/* also show as a per-module taint flag */
 	const char *desc;	/* verbose description of the set taint flag */
 };
 
diff --git a/kernel/module/main.c b/kernel/module/main.c
index c66b26184936..6f219751df7e 100644
--- a/kernel/module/main.c
+++ b/kernel/module/main.c
@@ -954,7 +954,7 @@ size_t module_flags_taint(unsigned long taints, char *buf)
 	int i;
 
 	for (i = 0; i < TAINT_FLAGS_COUNT; i++) {
-		if (taint_flags[i].module && test_bit(i, &taints))
+		if (test_bit(i, &taints))
 			buf[l++] = taint_flags[i].c_true;
 	}
 
diff --git a/kernel/panic.c b/kernel/panic.c
index 81b7911fb5ca..341c66948dcb 100644
--- a/kernel/panic.c
+++ b/kernel/panic.c
@@ -628,17 +628,13 @@ void panic(const char *fmt, ...)
 }
 EXPORT_SYMBOL(panic);
 
-#define TAINT_FLAG(taint, _c_true, _c_false, _module)			\
+#define TAINT_FLAG(taint, _c_true, _c_false)				\
 	[ TAINT_##taint ] = {						\
 		.c_true = _c_true, .c_false = _c_false,			\
-		.module = _module,					\
 		.desc = #taint,						\
 	}
 
 /*
- * TAINT_FORCED_RMMOD could be a per-module flag but the module
- * is being removed anyway.
- *
  * NOTE: if you modify the taint_flags or TAINT_FLAGS_COUNT,
  * please also modify tools/debugging/kernel-chktaint and
  * Documentation/admin-guide/tainted-kernels.rst, including its
@@ -646,26 +642,26 @@ EXPORT_SYMBOL(panic);
  * /proc/sys/kernel/tainted.
  */
 const struct taint_flag taint_flags[TAINT_FLAGS_COUNT] = {
-	TAINT_FLAG(PROPRIETARY_MODULE,		'P', 'G', true),
-	TAINT_FLAG(FORCED_MODULE,		'F', ' ', true),
-	TAINT_FLAG(CPU_OUT_OF_SPEC,		'S', ' ', false),
-	TAINT_FLAG(FORCED_RMMOD,		'R', ' ', false),
-	TAINT_FLAG(MACHINE_CHECK,		'M', ' ', false),
-	TAINT_FLAG(BAD_PAGE,			'B', ' ', false),
-	TAINT_FLAG(USER,			'U', ' ', false),
-	TAINT_FLAG(DIE,				'D', ' ', false),
-	TAINT_FLAG(OVERRIDDEN_ACPI_TABLE,	'A', ' ', false),
-	TAINT_FLAG(WARN,			'W', ' ', false),
-	TAINT_FLAG(CRAP,			'C', ' ', true),
-	TAINT_FLAG(FIRMWARE_WORKAROUND,		'I', ' ', false),
-	TAINT_FLAG(OOT_MODULE,			'O', ' ', true),
-	TAINT_FLAG(UNSIGNED_MODULE,		'E', ' ', true),
-	TAINT_FLAG(SOFTLOCKUP,			'L', ' ', false),
-	TAINT_FLAG(LIVEPATCH,			'K', ' ', true),
-	TAINT_FLAG(AUX,				'X', ' ', true),
-	TAINT_FLAG(RANDSTRUCT,			'T', ' ', true),
-	TAINT_FLAG(TEST,			'N', ' ', true),
-	TAINT_FLAG(FWCTL,			'J', ' ', true),
+	TAINT_FLAG(PROPRIETARY_MODULE,		'P', 'G'),
+	TAINT_FLAG(FORCED_MODULE,		'F', ' '),
+	TAINT_FLAG(CPU_OUT_OF_SPEC,		'S', ' '),
+	TAINT_FLAG(FORCED_RMMOD,		'R', ' '),
+	TAINT_FLAG(MACHINE_CHECK,		'M', ' '),
+	TAINT_FLAG(BAD_PAGE,			'B', ' '),
+	TAINT_FLAG(USER,			'U', ' '),
+	TAINT_FLAG(DIE,				'D', ' '),
+	TAINT_FLAG(OVERRIDDEN_ACPI_TABLE,	'A', ' '),
+	TAINT_FLAG(WARN,			'W', ' '),
+	TAINT_FLAG(CRAP,			'C', ' '),
+	TAINT_FLAG(FIRMWARE_WORKAROUND,		'I', ' '),
+	TAINT_FLAG(OOT_MODULE,			'O', ' '),
+	TAINT_FLAG(UNSIGNED_MODULE,		'E', ' '),
+	TAINT_FLAG(SOFTLOCKUP,			'L', ' '),
+	TAINT_FLAG(LIVEPATCH,			'K', ' '),
+	TAINT_FLAG(AUX,				'X', ' '),
+	TAINT_FLAG(RANDSTRUCT,			'T', ' '),
+	TAINT_FLAG(TEST,			'N', ' '),
+	TAINT_FLAG(FWCTL,			'J', ' '),
 };
 
 #undef TAINT_FLAG

base-commit: aaa9c3550b60d6259d6ea8b1175ade8d1242444e
-- 
2.51.1


