Return-Path: <linux-kernel+bounces-816755-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 39132B577F8
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 13:21:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 87BC23B67E5
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 11:21:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B03E42FF16A;
	Mon, 15 Sep 2025 11:20:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Hx51oz+b"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1C802FD1A6
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 11:20:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757935254; cv=none; b=VfAEH3sO7O14qJ2JuuPWWJJQ7ZzEZqTTYnBi+oHoYbNzlztqqFmp90/uo/H+qyzTfxozgYaoDGO+Zph0V6evXCYCRul4H+zmm5jJ/juYs+h5MJMobJ78myDXgBqjz9eQr91Nn7ZUA1cAluj1ctDeBj2bpyASr6fb04Hfk7U3XHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757935254; c=relaxed/simple;
	bh=1ZJkclrLq0L8xExl+pZv7kQNadVFoXUXwGQ6z2d35qc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KNAHHvLpxHxZ/qL+jtMxOhmGEh6TwLH33zncMwXUEQFwGzUoMHJ98m9xtQZ6gJ+DaTd1I630Gx0iFyzM1oVHJNtSqInyqiKtSw+cNKheyhscZYnOFa1cTSWf/BrdRkEsZpmOrtECHb15QpY3gHnjiijBtJuZKvpswXevDglLeMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Hx51oz+b; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-45f2cf99bbbso5718645e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 04:20:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1757935250; x=1758540050; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PmY1cJvfVrvlF04JWQNfoehkYVLSZXxvwYISJVXZfyc=;
        b=Hx51oz+by3OU93t6hDDUHSQ8ybKvZhUgoIHhLTcMOMZZSuvEuwb9zJf4gf5jHUjAZq
         wh8k+nHmjaNeYf2vW5uy6tE552dFCDlJcpzn3LUkbIWQjFgvLZJahcpssJuXg2ZSHI9r
         YIEbtRsmf3ghpeVsDcW6zFBXsNQxOWjdrykY/iWX8EPIW0U1HHWjvwACjQJ1ByEUtQ9h
         l8BEdVSSn9QcFUdB/3iKPlsSPzJE81h21cBvyMELgP+Vi2cL6Kv67sD8gmf1PdxH28u3
         TEHKdB6j7URoFArgtENOwRy92/NUcwzkKIk+reVVOBRncYR1sjGr+SwyH99WvfUcv0Ae
         ZIlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757935250; x=1758540050;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PmY1cJvfVrvlF04JWQNfoehkYVLSZXxvwYISJVXZfyc=;
        b=skRq6DjexMc4PiYO5ptuVU7JA1YC+b6GSKxwDPA2ZCAIP6CprGPjymXlYT2MyRgwni
         R8+FIMGFPSdm/iK38SdPXOp+BQssMzI9jNpfNSagSwSMpwBiw374hWUUEZlv3goytwI+
         VO/mL6d3aK9CuVLEtayTQVw4w6FHt/JSIUrp3MZEjVEhCd0h9XCy0pGVB6KIWIVaAWmd
         7tLVVl6ztrMqqk57YPEz91KtglcyKFAkNQotRBNV5pDPc7m4/Q7230Tn4obRm6G5fFU0
         i92cqqKXEvG+8ufXbaDRJ18U+/jsAapWW4otR0Zkv8JtebrQ7kRtwNGv1tXdnqDFBnPh
         xkxA==
X-Gm-Message-State: AOJu0Yy+FZMyOwHMaDSL6WPaCnVbqP1XJZEiFI0XP8rtUaVuE+M0SMmE
	gjIGQHEoRJADnm3g1SHHYDVPkkI4TO53oikZFRhg2Ho8RWty8NPJrQBnfSCVbNa3SIY=
X-Gm-Gg: ASbGncu4YXE039kWNGD6ITWVpBPGP1r80l1GmQMruXq8UZ4yJ33CEdeRBJF+JSCvL9k
	09ZwWw1bgIV0AeoUFTsru5ZDVy/i4Qkd/kox3qSJ5xM5HIOwIe7R/KBliHOCr3ajWeRElEWjk/V
	TdwuBkugMaW4hF4Il/deO/wP4xRDSGZ/g4A4A3xxYACdZ0cUhQeH8h2JqsEd0h1k6oI8GgfN5Pm
	cHWVglEWnJl2RUjj5GOxJWNqwkSdZQj4m4oJa4TfhPHiDtwhV7U7iPvRoXyiaZ9kCWug1520c58
	qD1UT4F9GLG/KVwFO+7B4YtaguEs29gET5VSCdtosHxKK7Bkhy4WyUOV0W2fViE2oio1JXvdRgd
	TePj3tD6DDR0tFGphRwsK2gjolffr43MvmOYzQeSluc0DZPuZSJZRID151ZU=
X-Google-Smtp-Source: AGHT+IGlWfRECteUeqWG19Me150i9rjMnbdx7/D23+rW9fFbCBguFXR8IRgiSVYJDjYgD0CsbLEDZw==
X-Received: by 2002:a7b:c84e:0:b0:45d:f7cb:70f4 with SMTP id 5b1f17b1804b1-45f211d642amr78363415e9.13.1757935250199;
        Mon, 15 Sep 2025 04:20:50 -0700 (PDT)
Received: from [127.0.0.1] (210.37.160.45.gramnet.com.br. [45.160.37.210])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45e01519f67sm91903345e9.1.2025.09.15.04.20.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Sep 2025 04:20:49 -0700 (PDT)
From: Marcos Paulo de Souza <mpdesouza@suse.com>
Date: Mon, 15 Sep 2025 08:20:32 -0300
Subject: [PATCH v4 3/5] printk: nbcon: Allow KDB to acquire the NBCON
 context
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250915-nbcon-kgdboc-v4-3-e2b6753bb566@suse.com>
References: <20250915-nbcon-kgdboc-v4-0-e2b6753bb566@suse.com>
In-Reply-To: <20250915-nbcon-kgdboc-v4-0-e2b6753bb566@suse.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Petr Mladek <pmladek@suse.com>, Steven Rostedt <rostedt@goodmis.org>, 
 John Ogness <john.ogness@linutronix.de>, 
 Sergey Senozhatsky <senozhatsky@chromium.org>, 
 Jason Wessel <jason.wessel@windriver.com>, 
 Daniel Thompson <danielt@kernel.org>, 
 Douglas Anderson <dianders@chromium.org>
Cc: linux-kernel@vger.kernel.org, kgdb-bugreport@lists.sourceforge.net, 
 Marcos Paulo de Souza <mpdesouza@suse.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1757935236; l=2856;
 i=mpdesouza@suse.com; s=20231031; h=from:subject:message-id;
 bh=1ZJkclrLq0L8xExl+pZv7kQNadVFoXUXwGQ6z2d35qc=;
 b=0pb5pcuu6eardkQEXwleqAFJum0KV7L9rVB4tEQHX+nWTaDNXo1rQ6Ap19NFW3sCW1QkqS88C
 r7lP/vpvhcOCLzoBGv+HqqOlqTpWGw3iPr0BDz6SYarl5io3Z83ZUrc
X-Developer-Key: i=mpdesouza@suse.com; a=ed25519;
 pk=/Ni/TsKkr69EOmdZXkp1Q/BlzDonbOBRsfPa18ySIwU=

KDB can interrupt any console to execute the "mirrored printing" at any
time, so add an exception to nbcon_context_try_acquire_direct to allow
to get the context if the current CPU is the same as kdb_printf_cpu.

This change will be necessary for the next patch, which fixes
kdb_msg_write to work with NBCON consoles by calling ->write_atomic on
such consoles. But to print it first needs to acquire the ownership of
the console, so nbcon_context_try_acquire_direct is fixed here.

Signed-off-by: Marcos Paulo de Souza <mpdesouza@suse.com>
---
 include/linux/kdb.h   | 6 ++++++
 kernel/printk/nbcon.c | 7 ++++++-
 2 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/include/linux/kdb.h b/include/linux/kdb.h
index ecbf819deeca118f27e98bf71bb37dd27a257ebb..9417ad7f124e95987caced07bc8684a1a6c04df4 100644
--- a/include/linux/kdb.h
+++ b/include/linux/kdb.h
@@ -207,11 +207,17 @@ static inline const char *kdb_walk_kallsyms(loff_t *pos)
 /* Dynamic kdb shell command registration */
 extern int kdb_register(kdbtab_t *cmd);
 extern void kdb_unregister(kdbtab_t *cmd);
+
+#define KDB_IS_ACTIVE() (READ_ONCE(kdb_printf_cpu) != raw_smp_processor_id())
+
 #else /* ! CONFIG_KGDB_KDB */
 static inline __printf(1, 2) int kdb_printf(const char *fmt, ...) { return 0; }
 static inline void kdb_init(int level) {}
 static inline int kdb_register(kdbtab_t *cmd) { return 0; }
 static inline void kdb_unregister(kdbtab_t *cmd) {}
+
+#define KDB_IS_ACTIVE() false
+
 #endif	/* CONFIG_KGDB_KDB */
 enum {
 	KDB_NOT_INITIALIZED,
diff --git a/kernel/printk/nbcon.c b/kernel/printk/nbcon.c
index ff218e95a505fd10521c2c4dfb00ad5ec5773953..8644e019e2391797e623fcc124d37ed4d460ccd9 100644
--- a/kernel/printk/nbcon.c
+++ b/kernel/printk/nbcon.c
@@ -10,6 +10,7 @@
 #include <linux/export.h>
 #include <linux/init.h>
 #include <linux/irqflags.h>
+#include <linux/kdb.h>
 #include <linux/kthread.h>
 #include <linux/minmax.h>
 #include <linux/percpu.h>
@@ -248,13 +249,17 @@ static int nbcon_context_try_acquire_direct(struct nbcon_context *ctxt,
 		 * since all non-panic CPUs are stopped during panic(), it
 		 * is safer to have them avoid gaining console ownership.
 		 *
-		 * If this acquire is a reacquire (and an unsafe takeover
+		 * One exception is if kdb is active, which may print
+		 * from multiple CPUs during a panic.
+		 *
+		 * Second exception is a reacquire (and an unsafe takeover
 		 * has not previously occurred) then it is allowed to attempt
 		 * a direct acquire in panic. This gives console drivers an
 		 * opportunity to perform any necessary cleanup if they were
 		 * interrupted by the panic CPU while printing.
 		 */
 		if (other_cpu_in_panic() &&
+		    !KDB_IS_ACTIVE() &&
 		    (!is_reacquire || cur->unsafe_takeover)) {
 			return -EPERM;
 		}

-- 
2.51.0


