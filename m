Return-Path: <linux-kernel+bounces-856375-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 94140BE401D
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 16:50:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 39EBB1A658E4
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 14:50:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8344E345752;
	Thu, 16 Oct 2025 14:48:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="OFsfHcKs"
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F9B334575D
	for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 14:48:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760626102; cv=none; b=RWUrmpmbH6RpECrrs20fJhxdYntPPs56YICl15dzMjor2300d5AS49RZcMyclr1S+zosD+yNhACWth23v/hL7ajv+Slpt6ErpNgtVuG2OdzFA+cqXpItsBWT6xGPwSu0jN4CRAs+DxIe21l1bcthvftPbi6XMCNgKjV2A2PcIZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760626102; c=relaxed/simple;
	bh=1gtg55A6q6fYqQYhYt7iNdCwJ9yE+ZwzkgpLqb9S7w8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=U1hUo5Vry8vKPuyuK0LWp2mwYaoSJYSZUPDDfxsXVa+3iLITUdW/0WgIyDB/dd+1PSb8pmGUELY0wi6l7wJyBhViThOBt5xZvtJ5smhYk9zaj4tZ/jRC5cdo+ZUw41k21HU5zFVLvQxnSbB2pdyCqczBtGxoulNjYzvMQTdk5mk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=OFsfHcKs; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-3ee15b5435bso583572f8f.0
        for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 07:48:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1760626097; x=1761230897; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CIxAIlLH2WkPghxJtQLJXYy+AU+xIAHCNA8pGfVE8Mc=;
        b=OFsfHcKs5aedb1LOrZ97tlCLh6WK6hJclGgt79HQ3zkeRYX82BPAjLYlUzYtzWV9cv
         jyFqIvlUetaz+hEsJQ6YUYHTYMPDrUdnG4/YmKfCRCwA/132OvUPluX/k8VfMQdv0qdP
         oUbClOIvyE+m2Lq9Lzmr/dLkSBwg+GlPNyTRU8Z3PGf7glHZyh+s3OPudMq6wy6zp3pp
         oV8lHEPFlabE7sZGDOf1VlqMaxnLYRHQidLZX0FDzE/4NRuDB9nTuS8hCS2GaJXN4NO4
         x2hTcLH6zcc93hQrL6g2EXKn+B+/eVJwMKJtzfLfKZ7kJhbwM+GJsXmzVxAKoFGmXfLZ
         L08w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760626097; x=1761230897;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CIxAIlLH2WkPghxJtQLJXYy+AU+xIAHCNA8pGfVE8Mc=;
        b=SZFYPLlTQQTxQBvqH2uWquU4HkzdUUiCHzWuKzuY7DLTVjRzsgCAeGCxx4TmrpjC3O
         at3Dmc8+combeQyHKj5iLWPo3uuyKBKs/dmAjY5mrSrGvm9Txbws8Kr0IFUakD0jIvNc
         uWJn+j+ntFBtFpxUcgUhQK3H15a2qgVjZsRkNgg0ei1yfMu+xTnfE/sy4DUnGHjkxx79
         RjXnRknv+mWzwD9VsloNCotwo1Oafmuygz3uQ9eONAYdyE8Xgn0HgkpuaOVtJ4MZBLlx
         khOr8p2RdStniRWsDWkTFzmOXEfojSFfenxRh+6fHxiUJ/wdK+wbtVrUe0zy7EHLeMTx
         P+DQ==
X-Gm-Message-State: AOJu0YyMuSZ23w2YyC8AGHmzlxd3085dMzWLo+g0/ZcJdEClx2xr9H8u
	1g8Olhq0zsiZCh0OhQLSBPpSZQFuYs/Bq6f7IuWoVhSk2PRUb9JMh44quHA5IOTgN/c=
X-Gm-Gg: ASbGnct4vEndpL8MqwBgMz6elaAcorhsfiEiYkv7cDn7uel0xT0grQgMwWnhDoqblWj
	F4PGhsW1WVpN5RmOcQ+2HQyhy30xYjDybn3sqHGtaftgDA83XF6zp36a4yHsUtUzzPcQEUdVRfd
	d03nAlSW4x4IBHKeUJgrlFKgOqA7wHvJzLewMWyuMstgy/mVm0HHGalXtkJDmGtEvlwzWXK0oAI
	OCBQvy4ouCuwhJmpJsl7xjeVhsoCp6WCpNQ2/CdrL2KuwaDWyOoUJhzCKK4rS88wlJ4c+gdFkmm
	goGMGIgWAoMC/YpzeVT/3eB19+xzKPwLnF7HZXEFpBqrKoUopRXp4+jYZgDjja9LvFEzHWr4sJX
	Oex+UQ+tPKBENyTJPq/YLP5RmIZO/QXa0wVFnNR+RHqI2xamqxjEZIvaqOwDGhxiTVVjC+gSebn
	slPy+/0TQ=
X-Google-Smtp-Source: AGHT+IHmHSHNF3BYV3Uo2Nk3NIqyIqeAqZq5Krmm0v974TtwQGifmJ3M/YmEZCuGc9CDlunbtedN4g==
X-Received: by 2002:a05:6000:25c6:b0:3ee:1294:4784 with SMTP id ffacd0b85a97d-42704db5d28mr275699f8f.37.1760626097125;
        Thu, 16 Oct 2025 07:48:17 -0700 (PDT)
Received: from [127.0.0.1] ([2804:5078:81f:9200:58f2:fc97:371f:2])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29099afe03bsm32947795ad.107.2025.10.16.07.48.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Oct 2025 07:48:16 -0700 (PDT)
From: Marcos Paulo de Souza <mpdesouza@suse.com>
Date: Thu, 16 Oct 2025 11:47:56 -0300
Subject: [PATCH v6 3/5] printk: nbcon: Allow KDB to acquire the NBCON
 context
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251016-nbcon-kgdboc-v6-3-866aac60a80e@suse.com>
References: <20251016-nbcon-kgdboc-v6-0-866aac60a80e@suse.com>
In-Reply-To: <20251016-nbcon-kgdboc-v6-0-866aac60a80e@suse.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Petr Mladek <pmladek@suse.com>, Steven Rostedt <rostedt@goodmis.org>, 
 John Ogness <john.ogness@linutronix.de>, 
 Sergey Senozhatsky <senozhatsky@chromium.org>, 
 Jason Wessel <jason.wessel@windriver.com>, 
 Daniel Thompson <danielt@kernel.org>, 
 Douglas Anderson <dianders@chromium.org>
Cc: linux-kernel@vger.kernel.org, kgdb-bugreport@lists.sourceforge.net, 
 Marcos Paulo de Souza <mpdesouza@suse.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1760626083; l=3334;
 i=mpdesouza@suse.com; s=20231031; h=from:subject:message-id;
 bh=1gtg55A6q6fYqQYhYt7iNdCwJ9yE+ZwzkgpLqb9S7w8=;
 b=U2KpRJninMM0ae+wZQYBQS8JB7rjKsTHHbZ1MKu2cGffKSTkFIJ743yBfsDhNEBZf3gcp+7L6
 +0UZqm/BOG7DHC0H+CFX2whaOTmoRwyuezaGhSsDrwcgNxsfVE8filK
X-Developer-Key: i=mpdesouza@suse.com; a=ed25519;
 pk=/Ni/TsKkr69EOmdZXkp1Q/BlzDonbOBRsfPa18ySIwU=

KDB can interrupt any console to execute the "mirrored printing" at any
time, so add an exception to nbcon_context_try_acquire_direct to allow
to get the context if the current CPU is the same as kdb_printf_cpu.

This change will be necessary for the next patch, which fixes
kdb_msg_write to work with NBCON consoles by calling ->write_atomic on
such consoles. But to print it first needs to acquire the ownership of
the console, so nbcon_context_try_acquire_direct is fixed here.

Reviewed-by: John Ogness <john.ogness@linutronix.de>
Signed-off-by: Marcos Paulo de Souza <mpdesouza@suse.com>
---
 include/linux/kdb.h   | 16 ++++++++++++++++
 kernel/printk/nbcon.c |  6 +++++-
 2 files changed, 21 insertions(+), 1 deletion(-)

diff --git a/include/linux/kdb.h b/include/linux/kdb.h
index ecbf819deeca..db9d73b12a1a 100644
--- a/include/linux/kdb.h
+++ b/include/linux/kdb.h
@@ -14,6 +14,7 @@
  */
 
 #include <linux/list.h>
+#include <linux/smp.h>
 
 /* Shifted versions of the command enable bits are be used if the command
  * has no arguments (see kdb_check_flags). This allows commands, such as
@@ -207,11 +208,26 @@ static inline const char *kdb_walk_kallsyms(loff_t *pos)
 /* Dynamic kdb shell command registration */
 extern int kdb_register(kdbtab_t *cmd);
 extern void kdb_unregister(kdbtab_t *cmd);
+
+/* Return true when KDB as locked for printing a message on this CPU. */
+static inline
+bool kdb_printf_on_this_cpu(void)
+{
+	/*
+	 * We can use raw_smp_processor_id() here because the task could
+	 * not get migrated when KDB has locked for printing on this CPU.
+	 */
+	return unlikely(READ_ONCE(kdb_printf_cpu) == raw_smp_processor_id());
+}
+
 #else /* ! CONFIG_KGDB_KDB */
 static inline __printf(1, 2) int kdb_printf(const char *fmt, ...) { return 0; }
 static inline void kdb_init(int level) {}
 static inline int kdb_register(kdbtab_t *cmd) { return 0; }
 static inline void kdb_unregister(kdbtab_t *cmd) {}
+
+static inline bool kdb_printf_on_this_cpu(void) { return false };
+
 #endif	/* CONFIG_KGDB_KDB */
 enum {
 	KDB_NOT_INITIALIZED,
diff --git a/kernel/printk/nbcon.c b/kernel/printk/nbcon.c
index e1bf5409cb6b..5be018493909 100644
--- a/kernel/printk/nbcon.c
+++ b/kernel/printk/nbcon.c
@@ -10,6 +10,7 @@
 #include <linux/export.h>
 #include <linux/init.h>
 #include <linux/irqflags.h>
+#include <linux/kdb.h>
 #include <linux/kthread.h>
 #include <linux/minmax.h>
 #include <linux/panic.h>
@@ -249,13 +250,16 @@ static int nbcon_context_try_acquire_direct(struct nbcon_context *ctxt,
 		 * since all non-panic CPUs are stopped during panic(), it
 		 * is safer to have them avoid gaining console ownership.
 		 *
-		 * If this acquire is a reacquire (and an unsafe takeover
+		 * One exception is when kdb has locked for printing on this CPU.
+		 *
+		 * Second exception is a reacquire (and an unsafe takeover
 		 * has not previously occurred) then it is allowed to attempt
 		 * a direct acquire in panic. This gives console drivers an
 		 * opportunity to perform any necessary cleanup if they were
 		 * interrupted by the panic CPU while printing.
 		 */
 		if (panic_on_other_cpu() &&
+		    !kdb_printf_on_this_cpu() &&
 		    (!is_reacquire || cur->unsafe_takeover)) {
 			return -EPERM;
 		}

-- 
2.51.0


