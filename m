Return-Path: <linux-kernel+bounces-837975-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B426BBAE293
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 19:22:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CD7857AE70A
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 17:20:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5007718A93F;
	Tue, 30 Sep 2025 17:22:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="bKjRUnX8"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FF332FBE16
	for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 17:22:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759252922; cv=none; b=f8jcMOAGkEtCAqFpOOjj2RvGE6YmKc8gDQPqR4I7vdJ9FQgp0SFoj+ZuZfvVwRI34nffTy4YFOGzloJ9rSRYNxB4jOjWLQ2J8lN9HtUW/2/6ECQ1nwOJlOiornaAXL9XnBTKFJnW2dnPkJ2foayC88RxCRL213hehDi4UOAmhG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759252922; c=relaxed/simple;
	bh=ibgKtleGddQNNgCtzt0Ilfee0hjVtNcwD0tKiiu4HR8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Me26pfSPnJ+xVjdxU/w95PMFb12MurkEIVszzDtkd4IeAGRMNAI96gTAZilBMdPciYctYK68V9O3YI+T0SkNEUEei3gmzKoZi20uwjT3fauwUcnxz4BjaL5VfKq1hWIZMfPogtJTy/q9znob/hk+LHpzLImLs8A5+xJSrGSM4Pg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=bKjRUnX8; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-46e3af7889fso36747785e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 10:22:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1759252919; x=1759857719; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=q/JHX8hQ6J2JNvKJcwR9e7CWvf1mvN1dNFPy1HSjY60=;
        b=bKjRUnX8TV784Rh7C0MPBSEWW6p0oij/8pmH0Mx9T0gyvJWFcwNxGHWbCMRN8ey4VC
         an6gaAFT+uH2PNE1UWeRkyN1YioWN5H14X/VIpGOYbTxkkzNRAkVXo2LwH1qtXhVQpl6
         4B8WyVBhlkEHaeGf1JLvKpL+lvHbtnmdxXzTjc0G/dF6t0xJXs2ogHAbPdASsY/vsIma
         xNHFqSN9LyApm/UWTT8rtO5XZYWUReVSET+FNgC1ipG3UaUoAgrmk0l62bnC7MHQyped
         aMLAYqGe3kRnBiMUvwmdUGtzgntHuwDdUyzYqsmvnRDQIw0ezgveqcM2BwTUFeb9EGTO
         fTXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759252919; x=1759857719;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=q/JHX8hQ6J2JNvKJcwR9e7CWvf1mvN1dNFPy1HSjY60=;
        b=E1sXyeaFdJ8byICNNC8DbZem1Z1GZCxAD0aGG/ORxTnRJ43ZGsdyyjLGMNrqM7kog2
         8k8RMEgyp5phsp+tTv8Ke0LL6L6pZpHbDEZbA3T68FHD35VoqNuj9WRk1ixyBkyeDl/6
         oRgaIDEaopi4Qx+iaucJAMZkG4lTiucCkTfN66pRs5Wk8O2miObIP5Yr0jV0yHfC8EXM
         TsTAT9mBuWgXAQXD+tvexlww3g6wap+uGVfr67+ywxvE34H/V3VES8M69Kntb4irGAj6
         QP6q6tzb2QfbYzoKZA5a/IZuak6FxNCLJ6dK9VD3xbVge6Vk18AuU8eGi+1oLi5dBfUm
         GHqA==
X-Gm-Message-State: AOJu0YylCLIdPb6uGfNl4bCgkjxcGuvmtzeTu+Xo6O7kg0IFL5y018ak
	bz1NYJA+CiA0QkmICk/fXOko4CZ4JTR9o5MVi/cyQv81S5MIfipRMx5mdkDuyWfsfzU=
X-Gm-Gg: ASbGncvPOt8hkuQi6naJ9QTayzy1vnIafudwbsG9Gg14p+xFxsLTe4o5kISvllSaFFu
	Fj++YKMqc5HW0SQR5T2J4uLqWopBzNhl+CH2J0qcQ0ZKGdzjFrmeKPwbfiY6nIRphgEOAQwNivv
	N/mKmZOtN7q1ahdxCtSYWjTQqzDTAMqifsvEC6zEVhVf2UpWeI538a2JmrqN8sAeHCZf+4wqXGe
	pl+54n4Oy16MXDe7R3Dpx2K+QVKRbP4kiex/j2g38DY5GiaQ2ySMehHteDfJyR7xFSmhea+GxQS
	gTmyDVVUN2+FqX6+BRanmBn0/ISadRSYJ3+nhvtHE1tPWLIlaOsHYJxT5kVFgkHdBRyZLuFiIxe
	M6QLx/BW2JE+xmj41CSR6asI3GSdVRJeIBIQelkjypK0KdHkrWedY65UM/FS9o7somGB+MZ6CqB
	d87zfS
X-Google-Smtp-Source: AGHT+IEI//gAdpmdg72DS3miwlWKBIpxB/Jy0Pf275A937m8GRKUvUi6OGUpg+qdz7IkdcItagOvHw==
X-Received: by 2002:a05:600c:8b8b:b0:46e:1c16:7f42 with SMTP id 5b1f17b1804b1-46e6127dc4emr4989045e9.11.1759252918851;
        Tue, 30 Sep 2025 10:21:58 -0700 (PDT)
Received: from [127.0.0.1] (88.36.160.45.gramnet.com.br. [45.160.36.88])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46e61a17a0dsm2459465e9.17.2025.09.30.10.21.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Sep 2025 10:21:58 -0700 (PDT)
From: Marcos Paulo de Souza <mpdesouza@suse.com>
Date: Tue, 30 Sep 2025 14:21:09 -0300
Subject: [PATCH v5 3/5] printk: nbcon: Allow KDB to acquire the NBCON
 context
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250930-nbcon-kgdboc-v5-3-8125893cfb4f@suse.com>
References: <20250930-nbcon-kgdboc-v5-0-8125893cfb4f@suse.com>
In-Reply-To: <20250930-nbcon-kgdboc-v5-0-8125893cfb4f@suse.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1759252905; l=3158;
 i=mpdesouza@suse.com; s=20231031; h=from:subject:message-id;
 bh=ibgKtleGddQNNgCtzt0Ilfee0hjVtNcwD0tKiiu4HR8=;
 b=j+AGEj6TmAPGZVFRoAWgYOJ0dGmVgfloYMM7xrQSYUF7XplRNe9oRrGgmQTN0Z8UHKyO3E39z
 i64d6h9h5TpAEv6DpT+i01waCHMVDmmb7sdci1BV215+YlO0R+eL7Gh
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
 include/linux/kdb.h   | 15 +++++++++++++++
 kernel/printk/nbcon.c |  6 +++++-
 2 files changed, 20 insertions(+), 1 deletion(-)

diff --git a/include/linux/kdb.h b/include/linux/kdb.h
index ecbf819deeca118f27e98bf71bb37dd27a257ebb..36b46c85733fe1df28cde7760e5c26e96de40c05 100644
--- a/include/linux/kdb.h
+++ b/include/linux/kdb.h
@@ -207,11 +207,26 @@ static inline const char *kdb_walk_kallsyms(loff_t *pos)
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
index c23abed5933527cb7c6bcc42057fadbb44a43446..6e4641350fe8985438f53bcd32f3adf72d9d6835 100644
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


