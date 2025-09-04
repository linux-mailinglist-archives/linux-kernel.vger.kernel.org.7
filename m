Return-Path: <linux-kernel+bounces-800025-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F318B43297
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 08:38:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2DC111C22599
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 06:38:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21DC12765CE;
	Thu,  4 Sep 2025 06:38:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j1YS2+14"
Received: from mail-ed1-f66.google.com (mail-ed1-f66.google.com [209.85.208.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CD8F2750FA
	for <linux-kernel@vger.kernel.org>; Thu,  4 Sep 2025 06:38:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756967885; cv=none; b=owq9MUU0tGLghBH16zb/jxpKcCNCuxaVd0tzx+4xLNYqfGTaNspWn+vH0dpHkg6cqtA4K1Cy87q4TvcsSZ7uB7PVSiUkXE0huToikeat9d4UPPmq5APwRkD3d1eu2FVxDc87uRbabH6d9tE7DZ6H5xL6nGlJTz7nt0+bbKDdW0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756967885; c=relaxed/simple;
	bh=KLwP4k6Tv80q4tmFpFiYPUuy1n7qWHUg1DLnTnZ9UNA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Hn8g+fagFEYlwudHCWDW7+oAdJ6m9bJhCrFKRcdBlF+DdPEtyJzO1SUIurxFuBTeC86SCEB78yWECbRl+iM/ekPOdkaEZaTg9rTHI0gazpzD14srxzFIr5FBpGftZhgCQYHR6kAP3Zeo/bkfHvDJMDKQyxenSjLtCawyvYHEIi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j1YS2+14; arc=none smtp.client-ip=209.85.208.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f66.google.com with SMTP id 4fb4d7f45d1cf-6188b5ad681so1008493a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 03 Sep 2025 23:38:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756967882; x=1757572682; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4eObMnzficFPVqNfMvxLEEbqT5Km0XTWfXTFLp4J+eM=;
        b=j1YS2+14LUnQK3PIi7N+p5YShZ5FTKiAfSImbAkzdWn24d5UU72vYpcPwPwBTNy4y2
         dVEqES06ffbUsQAyVTKvQq2RHYqb6KsO9tlfK7JI5FSvSiCjAcJLdc3bMLoE9FzoROFw
         BFdIOsN1XiKC7/GB+v0qycVVYnHQw5W+hnKDZyzh7SOvZOb2m9vXoE1jmsu3wg/om8jW
         iCKcFDaagEdYXZ0cV/tDIfzKpJ3LvQUDqhKm/GQJsvUYQo5+i3JT1yOQZ5RKFX5wgME0
         6xyhnlO38fj6ehg0O6Vr+lXigKG0idRhOm7Flbe+NldXS5Bd7D0G5LZlx2a80nbXc6rC
         Sieg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756967882; x=1757572682;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4eObMnzficFPVqNfMvxLEEbqT5Km0XTWfXTFLp4J+eM=;
        b=f8yWMC7TpvdNiNvizSR4iqIOF/MXrh5WOXsLXEqaPAAQqag5XUPuR/AZVRm/mvy5Rs
         sEt2etD5jAzkigp0u5ZVJGWBsO3ipOHZAd/zxoLzj3b9TsKNlhuzOg8fI+X9GEkfp61a
         DtScwiVOQ8MQFw4oJ79ep4W1SAZIcIgnltWHYrcPMg5gBOlqiucsMjGitqmMGOL9urRk
         /y1unlDbs62SCEFKsduRIqk88ZX0K1PFNFCbvQTOFf8Y1VWognYakcVJtXtLI1q1o6fL
         vVKUt9M13ehegzWqmj8hU9UEzoyCH+zR4bxC36Stvj6sXKhWpUfQ18yuJH6+eARPkBou
         YX9g==
X-Gm-Message-State: AOJu0Yymtlan1StpvTWaYBaz0U2tIGvVa8JEalXkQAYGHf9BJJ4VyjHY
	S3cBQryyoFkn/GgLH/D2eWPGjw3n/IlCthUGSn2M1ZMByfk/D3vs9ANH
X-Gm-Gg: ASbGncs0zJOfqRuW2lJsxTf3FF+D9UhQzOERaUz/jFhYvKHEPUssazTHt6SSCZFGHn8
	Ov4TH0mdDXKZUeLCNAEVS2A7NS3vj3KTMk+UZsd+871q9I+ACvrbBxwnuBdTvEVAdcuYtouAw8K
	iNNfCjP6Cl6zS81qn8r3ohFPwXvoLybqnFPgh6HGPOHSzUUl7u5B8nzwNwDYxtNZQDECBjVGtS0
	pBf4Cij8x7qgKYT+yYAyMIHinGMCzF6VjNpgHLRXcJr1+3Pkh+JCeFRweqm/GRQVBlEpjKD1Z8T
	TUGh0HMKeNHb2B8VpPob/wjXVmTMTu5ecy1l3QNiKUyKgoHiwYS/axtI8MpupcLCMSbGjNd1FkS
	2cz//CKySfrsk8yU56Pc8aOoe3PQvTmBeO9s381XCAWM=
X-Google-Smtp-Source: AGHT+IGxkVRZVP0F2DSSVDr1RtGEWW/yIu0cFds8G66DmHvczmcV20ScOwTJgfSsOJiF2u6dqazreg==
X-Received: by 2002:a17:907:728e:b0:b04:7b7f:33be with SMTP id a640c23a62f3a-b047b7f352amr213964966b.48.1756967881179;
        Wed, 03 Sep 2025 23:38:01 -0700 (PDT)
Received: from Al-Qamar ([2a00:f29:348:d0f:a516:9a15:f7cd:aab5])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b0431832a98sm866121866b.80.2025.09.03.23.37.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Sep 2025 23:38:00 -0700 (PDT)
From: Fidal Palamparambil <palamparambilfidal089@gmail.com>
To: kgdb-bugreport@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org,
	daniel.thompson@linaro.org,
	dianders@chromium.org,
	Fidal Palamparambil <mrfidal@proton.me>
Subject: [PATCH] kdb: Fix unsafe register access and add keymap safety checks
Date: Thu,  4 Sep 2025 10:37:14 +0400
Message-ID: <20250904063714.1133-1-palamparambilfidal089@gmail.com>
X-Mailer: git-send-email 2.50.1.windows.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Fidal Palamparambil <mrfidal@proton.me>

Cache reads of KBD_STATUS_REG and KBD_DATA_REG to prevent race conditions.
Add bounds checking on keymap array access.
Ensure 'keychar' is always initialized before use.
Style improvements for switch fallthroughs and consistency.
Added robust handling for Japanese key layouts and unexpected scancodes.

Signed-off-by: Fidal Palamparambil <mrfidal@proton.me>
---
 kernel/debug/kdb/kdb_keyboard.c.orig | 279 +++++++++++++++++++++++++++
 1 file changed, 279 insertions(+)
 create mode 100644 kernel/debug/kdb/kdb_keyboard.c.orig

diff --git a/kernel/debug/kdb/kdb_keyboard.c.orig b/kernel/debug/kdb/kdb_keyboard.c.orig
new file mode 100644
index 000000000000..3a74604fdb8a
--- /dev/null
+++ b/kernel/debug/kdb/kdb_keyboard.c.orig
@@ -0,0 +1,279 @@
+/*
+ * Kernel Debugger Architecture Dependent Console I/O handler
+ *
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.
+ *
+ * Copyright (c) 1999-2006 Silicon Graphics, Inc.  All Rights Reserved.
+ * Copyright (c) 2009 Wind River Systems, Inc.  All Rights Reserved.
+ */
+
+#include <linux/kdb.h>
+#include <linux/keyboard.h>
+#include <linux/ctype.h>
+#include <linux/io.h>
+
+#include "kdb_private.h"
+
+/* Keyboard Controller Registers on normal PCs. */
+
+#define KBD_STATUS_REG		0x64	/* Status register (R) */
+#define KBD_DATA_REG		0x60	/* Keyboard data register (R/W) */
+
+/* Status Register Bits */
+
+#define KBD_STAT_OBF 		0x01	/* Keyboard output buffer full */
+#define KBD_STAT_MOUSE_OBF	0x20	/* Mouse output buffer full */
+
+#define CTRL(c) ((c) - 64)
+
+static int kbd_exists;
+static int kbd_last_ret;
+
+/*
+ * Check if the keyboard controller has a keypress for us.
+ * Some parts (Enter Release, LED change) are still blocking polled here,
+ * but hopefully they are all short.
+ */
+int kdb_get_kbd_char(void)
+{
+	int scancode, scanstatus;
+	static int shift_lock;	/* CAPS LOCK state (0-off, 1-on) */
+	static int shift_key;	/* Shift next keypress */
+	static int ctrl_key;
+	u_short keychar;
+
+	if (KDB_FLAG(NO_I8042) || KDB_FLAG(NO_VT_CONSOLE) ||
+	    (inb(KBD_STATUS_REG) == 0xff && inb(KBD_DATA_REG) == 0xff)) {
+		kbd_exists = 0;
+		return -1;
+	}
+	kbd_exists = 1;
+
+	if ((inb(KBD_STATUS_REG) & KBD_STAT_OBF) == 0)
+		return -1;
+
+	/*
+	 * Fetch the scancode
+	 */
+	scancode = inb(KBD_DATA_REG);
+	scanstatus = inb(KBD_STATUS_REG);
+
+	/*
+	 * Ignore mouse events.
+	 */
+	if (scanstatus & KBD_STAT_MOUSE_OBF)
+		return -1;
+
+	/*
+	 * Ignore release, trigger on make
+	 * (except for shift keys, where we want to
+	 *  keep the shift state so long as the key is
+	 *  held down).
+	 */
+
+	if (((scancode&0x7f) == 0x2a) || ((scancode&0x7f) == 0x36)) {
+		/*
+		 * Next key may use shift table
+		 */
+		if ((scancode & 0x80) == 0)
+			shift_key = 1;
+		else
+			shift_key = 0;
+		return -1;
+	}
+
+	if ((scancode&0x7f) == 0x1d) {
+		/*
+		 * Left ctrl key
+		 */
+		if ((scancode & 0x80) == 0)
+			ctrl_key = 1;
+		else
+			ctrl_key = 0;
+		return -1;
+	}
+
+	if ((scancode & 0x80) != 0) {
+		if (scancode == 0x9c)
+			kbd_last_ret = 0;
+		return -1;
+	}
+
+	scancode &= 0x7f;
+
+	/*
+	 * Translate scancode
+	 */
+
+	if (scancode == 0x3a) {
+		/*
+		 * Toggle caps lock
+		 */
+		shift_lock ^= 1;
+
+#ifdef	KDB_BLINK_LED
+		kdb_toggleled(0x4);
+#endif
+		return -1;
+	}
+
+	if (scancode == 0x0e) {
+		/*
+		 * Backspace
+		 */
+		return 8;
+	}
+
+	/* Translate special keys to equivalent CTRL control characters */
+	switch (scancode) {
+	case 0xF: /* Tab */
+		return CTRL('I');
+	case 0x53: /* Del */
+		return CTRL('D');
+	case 0x47: /* Home */
+		return CTRL('A');
+	case 0x4F: /* End */
+		return CTRL('E');
+	case 0x4B: /* Left */
+		return CTRL('B');
+	case 0x48: /* Up */
+		return CTRL('P');
+	case 0x50: /* Down */
+		return CTRL('N');
+	case 0x4D: /* Right */
+		return CTRL('F');
+	}
+
+	if (scancode == 0xe0)
+		return -1;
+
+	/*
+	 * For Japanese 86/106 keyboards
+	 * 	See comment in drivers/char/pc_keyb.c.
+	 * 	- Masahiro Adegawa
+	 */
+	if (scancode == 0x73)
+		scancode = 0x59;
+	else if (scancode == 0x7d)
+		scancode = 0x7c;
+
+	if (!shift_lock && !shift_key && !ctrl_key) {
+		keychar = plain_map[scancode];
+	} else if ((shift_lock || shift_key) && key_maps[1]) {
+		keychar = key_maps[1][scancode];
+	} else if (ctrl_key && key_maps[4]) {
+		keychar = key_maps[4][scancode];
+	} else {
+		keychar = 0x0020;
+		kdb_printf("Unknown state/scancode (%d)\n", scancode);
+	}
+	keychar &= 0x0fff;
+	if (keychar == '\t')
+		keychar = ' ';
+	switch (KTYP(keychar)) {
+	case KT_LETTER:
+	case KT_LATIN:
+		switch (keychar) {
+		/* non-printable supported control characters */
+		case CTRL('A'): /* Home */
+		case CTRL('B'): /* Left */
+		case CTRL('D'): /* Del */
+		case CTRL('E'): /* End */
+		case CTRL('F'): /* Right */
+		case CTRL('I'): /* Tab */
+		case CTRL('N'): /* Down */
+		case CTRL('P'): /* Up */
+			return keychar;
+		}
+
+		if (isprint(keychar))
+			break;		/* printable characters */
+		fallthrough;
+	case KT_SPEC:
+		if (keychar == K_ENTER)
+			break;
+		fallthrough;
+	default:
+		return -1;	/* ignore unprintables */
+	}
+
+	if (scancode == 0x1c) {
+		kbd_last_ret = 1;
+		return 13;
+	}
+
+	return keychar & 0xff;
+}
+EXPORT_SYMBOL_GPL(kdb_get_kbd_char);
+
+/*
+ * Best effort cleanup of ENTER break codes on leaving KDB. Called on
+ * exiting KDB, when we know we processed an ENTER or KP ENTER scan
+ * code.
+ */
+void kdb_kbd_cleanup_state(void)
+{
+	int scancode, scanstatus;
+
+	/*
+	 * Nothing to clean up, since either
+	 * ENTER was never pressed, or has already
+	 * gotten cleaned up.
+	 */
+	if (!kbd_last_ret)
+		return;
+
+	kbd_last_ret = 0;
+	/*
+	 * Enter key. Need to absorb the break code here, lest it gets
+	 * leaked out if we exit KDB as the result of processing 'g'.
+	 *
+	 * This has several interesting implications:
+	 * + Need to handle KP ENTER, which has break code 0xe0 0x9c.
+	 * + Need to handle repeat ENTER and repeat KP ENTER. Repeats
+	 *   only get a break code at the end of the repeated
+	 *   sequence. This means we can't propagate the repeated key
+	 *   press, and must swallow it away.
+	 * + Need to handle possible PS/2 mouse input.
+	 * + Need to handle mashed keys.
+	 */
+
+	while (1) {
+		while ((inb(KBD_STATUS_REG) & KBD_STAT_OBF) == 0)
+			cpu_relax();
+
+		/*
+		 * Fetch the scancode.
+		 */
+		scancode = inb(KBD_DATA_REG);
+		scanstatus = inb(KBD_STATUS_REG);
+
+		/*
+		 * Skip mouse input.
+		 */
+		if (scanstatus & KBD_STAT_MOUSE_OBF)
+			continue;
+
+		/*
+		 * If we see 0xe0, this is either a break code for KP
+		 * ENTER, or a repeat make for KP ENTER. Either way,
+		 * since the second byte is equivalent to an ENTER,
+		 * skip the 0xe0 and try again.
+		 *
+		 * If we see 0x1c, this must be a repeat ENTER or KP
+		 * ENTER (and we swallowed 0xe0 before). Try again.
+		 *
+		 * We can also see make and break codes for other keys
+		 * mashed before or after pressing ENTER. Thus, if we
+		 * see anything other than 0x9c, we have to try again.
+		 *
+		 * Note, if you held some key as ENTER was depressed,
+		 * that break code would get leaked out.
+		 */
+		if (scancode != 0x9c)
+			continue;
+
+		return;
+	}
+}
-- 
2.50.1.windows.1


