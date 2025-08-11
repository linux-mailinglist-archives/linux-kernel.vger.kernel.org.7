Return-Path: <linux-kernel+bounces-762730-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 74497B20A46
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 15:34:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 29D027A7E98
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 13:32:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72DB22DCF6F;
	Mon, 11 Aug 2025 13:33:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="L48A0qmO"
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59E852D7805
	for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 13:33:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754919218; cv=none; b=FBst5zxvoFHuUFh8jocYF+vzwhCcqvKjCQff1VFMa6XDrs0Rw8/ZraRYOl9WisShpdz6y03g4OSes27Yp5K9PI0mYxSfd7uJfU2BVjSnTfTIIpRp5LeVXNrmU/qieaOqkqM4c7cBSe2/MbrysKTphrM/0rZxkPK9ZJhz58PMrBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754919218; c=relaxed/simple;
	bh=BHf0HTOHyGX4EITGM2Q1C51Falk64PM/uaZX63oRSyY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=H4E6livzg/PC8dHuOV4K+lmr2WDgT/O+cmxYc/kbzFr3nAL7x3Z5PIavf9zcczj0R99qNyDSop+LES5xo1T4PlSg51ecF790kGiZc/2TYhI1BV3xchOf0Vg0sbRQ4+kUBDECiEB5TQhSAjLSNH/xOR3nT/8Lowj+PGNFU9nLp1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=L48A0qmO; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-3b78294a233so3790149f8f.3
        for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 06:33:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1754919214; x=1755524014; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bL/NquOlpF5TigMCebJLLc4bp+Hhqn9zNRjpj1kl/wY=;
        b=L48A0qmOi+0r1GWUvE4nRD033qDssh4hpvmIJ2p9dujoCUIeJrjDFLwRAbtoF9PXIb
         CDFOuWUiSEFkEIl45I5yns54Vz/Ek/APJq9TDov2rr3QY82l9xRd3tKFRTAqL0nw5q1N
         ipvjVAltaYlVXYzSOI0qHpNMVRp/00J7cTPuWYi57YrhWww7+4+9yKWKw9DHQ6fSJ9v4
         QLVJgEL3AsDE2neFsHdcRK5kxLL79g/Ko0MrR32VevKOhT355oFjBznR1Hw6Y3JKDBJp
         IjBMCb3h7eZLfnlfYLa6ral3nbWucvA41ZhJhwUyJdrZYURG8lk3kzITXC6JlbFAwEEC
         bZeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754919214; x=1755524014;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bL/NquOlpF5TigMCebJLLc4bp+Hhqn9zNRjpj1kl/wY=;
        b=TFJO8IaO2QDmBJlHzc6qDlcHXzLFEXfZnzZmV3BGpzN+fX3dUpPt/+/415pjN0KrWj
         hcL2QeFqkcOlo5EPu8xPbGA1Ytt6dh33A/ChEzZwN9c1NqzCEVv8v8g6lO25cjp/Obfu
         MZY+RsyK98BFtJMnRQZEUpjuGrnXlBAK0bp2cF0zxSkCIUSjoEga19rmO28JfnatvPcM
         KPLOySzmcQ/DQgciOXCsl4Mvtj3TwbOrWlFbyw2eQXqZ7bGVjLyXQw937QxG/+KTDAfo
         9fJ+DI/1vxJRF6Zzj8AYodm7T5V5ClINiWAx3krVravTzhLJElgVkr9veL1FfTjCyVGZ
         QthA==
X-Gm-Message-State: AOJu0YwFT5DVB7ouVK93dpl+voQCpmrs0w0SSX/fVmw32hxQwmoA4kAJ
	J4kaM8HCEolq6OR/dy53iXEETPs3tws7oNQJznFqVOADQU8rfZ7Jc6NcbsLKswyzFdQ=
X-Gm-Gg: ASbGncsIhoNeMF9utEVHa95cxPcS7Z/tu2WwpeNHD0y7cjAkoO01T7n8oo19ar0LONB
	Mt1DBaf8et44CU87EwxkZITg7qJ4+vAmJnPJ/xR9hnjjy2V2fgn0Eht+I7syJ5Qwqo9hHH00ImC
	5vZFDwqhAZT0LrMzxqaMNHJlKyHGnNf1ELxCmhLnommPWL9eKC58KaQNfQukUiss4D7WslH58u+
	dW8vL1NVcrZKfKUDTyFe4y3C5+yIvdhNR5dmOSsfWgvpQwFtm49V+yjZt168Dnybzq+rKh5oTzQ
	GeQ6OHYHqFijlFMVoX8E6QYjWKzNIHB6iLRwko5YSiRYEVzJdgWzozr4YvfiITac8g+rz3dIngP
	9Fd/9+Hp8qPY/MhQ9bqmLAxfXbvtIGVFFyi5pK5xoaEQLSA==
X-Google-Smtp-Source: AGHT+IHTuzaawVjBb6/L16J74AehOLxcbzZ1Rzz8jZVDxQY+drVz7VrKSxKZHRfLOt/fn9cWY6uuPg==
X-Received: by 2002:a05:6000:2003:b0:3b8:d082:41e with SMTP id ffacd0b85a97d-3b900b80484mr9566864f8f.57.1754919214456;
        Mon, 11 Aug 2025 06:33:34 -0700 (PDT)
Received: from [127.0.0.1] (71.36.160.45.gramnet.com.br. [45.160.36.71])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76bccfd18c9sm26667449b3a.91.2025.08.11.06.33.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Aug 2025 06:33:33 -0700 (PDT)
From: Marcos Paulo de Souza <mpdesouza@suse.com>
Date: Mon, 11 Aug 2025 10:32:45 -0300
Subject: [PATCH v2 1/3] printk: nbcon: Export console_is_usable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250811-nbcon-kgdboc-v2-1-c7c72bcdeaf6@suse.com>
References: <20250811-nbcon-kgdboc-v2-0-c7c72bcdeaf6@suse.com>
In-Reply-To: <20250811-nbcon-kgdboc-v2-0-c7c72bcdeaf6@suse.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1754919199; l=4427;
 i=mpdesouza@suse.com; s=20231031; h=from:subject:message-id;
 bh=BHf0HTOHyGX4EITGM2Q1C51Falk64PM/uaZX63oRSyY=;
 b=KDWxdcdW9zWcFr4T5qRdeM9cpZSTgwcJ8oVIShWifFHUS/LIMS0tEnhvf70f2aq+eoFmLRlt9
 hqx1Mk6TuP2DdR5qxdnNMfF69uX4T+WdhjZSW2UhmHYNlsloP101s4M
X-Developer-Key: i=mpdesouza@suse.com; a=ed25519;
 pk=/Ni/TsKkr69EOmdZXkp1Q/BlzDonbOBRsfPa18ySIwU=

The helper will be used on KDB code in the next commits.

Signed-off-by: Marcos Paulo de Souza <mpdesouza@suse.com>
---
 include/linux/console.h  | 44 ++++++++++++++++++++++++++++++++++++++++++++
 kernel/printk/internal.h | 41 -----------------------------------------
 2 files changed, 44 insertions(+), 41 deletions(-)

diff --git a/include/linux/console.h b/include/linux/console.h
index 8f10d0a85bb4536e4b0dda4e8ccbdf87978bbb4a..67af483574727c00eea1d5a1eacc994755c92607 100644
--- a/include/linux/console.h
+++ b/include/linux/console.h
@@ -605,6 +605,48 @@ extern bool nbcon_can_proceed(struct nbcon_write_context *wctxt);
 extern bool nbcon_enter_unsafe(struct nbcon_write_context *wctxt);
 extern bool nbcon_exit_unsafe(struct nbcon_write_context *wctxt);
 extern void nbcon_reacquire_nobuf(struct nbcon_write_context *wctxt);
+
+/*
+ * Check if the given console is currently capable and allowed to print
+ * records. Note that this function does not consider the current context,
+ * which can also play a role in deciding if @con can be used to print
+ * records.
+ */
+static inline bool console_is_usable(struct console *con, short flags, bool use_atomic)
+{
+	if (!(flags & CON_ENABLED))
+		return false;
+
+	if ((flags & CON_SUSPENDED))
+		return false;
+
+	if (flags & CON_NBCON) {
+		/* The write_atomic() callback is optional. */
+		if (use_atomic && !con->write_atomic)
+			return false;
+
+		/*
+		 * For the !use_atomic case, @printk_kthreads_running is not
+		 * checked because the write_thread() callback is also used
+		 * via the legacy loop when the printer threads are not
+		 * available.
+		 */
+	} else {
+		if (!con->write)
+			return false;
+	}
+
+	/*
+	 * Console drivers may assume that per-cpu resources have been
+	 * allocated. So unless they're explicitly marked as being able to
+	 * cope (CON_ANYTIME) don't call them until this CPU is officially up.
+	 */
+	if (!cpu_online(raw_smp_processor_id()) && !(flags & CON_ANYTIME))
+		return false;
+
+	return true;
+}
+
 #else
 static inline void nbcon_cpu_emergency_enter(void) { }
 static inline void nbcon_cpu_emergency_exit(void) { }
@@ -612,6 +654,8 @@ static inline bool nbcon_can_proceed(struct nbcon_write_context *wctxt) { return
 static inline bool nbcon_enter_unsafe(struct nbcon_write_context *wctxt) { return false; }
 static inline bool nbcon_exit_unsafe(struct nbcon_write_context *wctxt) { return false; }
 static inline void nbcon_reacquire_nobuf(struct nbcon_write_context *wctxt) { }
+static inline bool console_is_usable(struct console *con, short flags,
+				     bool use_atomic) { return false; }
 #endif
 
 extern int console_set_on_cmdline;
diff --git a/kernel/printk/internal.h b/kernel/printk/internal.h
index ef282001f200fdbbacae3171932bf9f049037a85..077927ed56c5f7ae22f76be4635a4b4614387de8 100644
--- a/kernel/printk/internal.h
+++ b/kernel/printk/internal.h
@@ -112,47 +112,6 @@ bool nbcon_kthread_create(struct console *con);
 void nbcon_kthread_stop(struct console *con);
 void nbcon_kthreads_wake(void);
 
-/*
- * Check if the given console is currently capable and allowed to print
- * records. Note that this function does not consider the current context,
- * which can also play a role in deciding if @con can be used to print
- * records.
- */
-static inline bool console_is_usable(struct console *con, short flags, bool use_atomic)
-{
-	if (!(flags & CON_ENABLED))
-		return false;
-
-	if ((flags & CON_SUSPENDED))
-		return false;
-
-	if (flags & CON_NBCON) {
-		/* The write_atomic() callback is optional. */
-		if (use_atomic && !con->write_atomic)
-			return false;
-
-		/*
-		 * For the !use_atomic case, @printk_kthreads_running is not
-		 * checked because the write_thread() callback is also used
-		 * via the legacy loop when the printer threads are not
-		 * available.
-		 */
-	} else {
-		if (!con->write)
-			return false;
-	}
-
-	/*
-	 * Console drivers may assume that per-cpu resources have been
-	 * allocated. So unless they're explicitly marked as being able to
-	 * cope (CON_ANYTIME) don't call them until this CPU is officially up.
-	 */
-	if (!cpu_online(raw_smp_processor_id()) && !(flags & CON_ANYTIME))
-		return false;
-
-	return true;
-}
-
 /**
  * nbcon_kthread_wake - Wake up a console printing thread
  * @con:	Console to operate on

-- 
2.50.0


