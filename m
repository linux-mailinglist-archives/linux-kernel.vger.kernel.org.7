Return-Path: <linux-kernel+bounces-797195-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E58BAB40D3A
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 20:34:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BF94A7AFADC
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 18:33:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37A04345723;
	Tue,  2 Sep 2025 18:34:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="CPXj3lm7"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6359B34DCEF
	for <linux-kernel@vger.kernel.org>; Tue,  2 Sep 2025 18:34:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756838057; cv=none; b=dHrHO3n1C3rSQPGxvZ27v8kLdfLhk/M3e3d5krIm3mPZXPSARdeMLyOK2lhH25Px1He9dvJPrGWwNUAezvlYwBnS6FOaqoKwRMkSIbbKyN1rvdSAVPuJvx+6ZBvae+fk8N7ZXBQJqEkckGp0K1eMT7Ai/wuqdw2HH59OGQc6c4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756838057; c=relaxed/simple;
	bh=/pJm51k0Rdgg7h4U6y2MCvfn06HwAtBOQoQcGVJQThM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MuGvzafZKRDxXaCzQBfnWFPvgYJ1cR8jbBX35lEJzbSNDmeBDQDR6kbMo7z4jzExC3pKTlHk8d0gt6Q3p0zhvC14z1OllNWsyK99S8MmlOmjFdTZyyBpVrFuC6KQwiqza5nWlYrL/p2EyDRvhh1sKmczpm1H6/reNFgdJeJHhJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=CPXj3lm7; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-45b7c01a708so20277625e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 02 Sep 2025 11:34:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1756838054; x=1757442854; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ozr279Qr3C7/dftyUFUfvHvaGGNWVlgEMFeuHaNz1sQ=;
        b=CPXj3lm7h4ZMcoqqe8J+Qb1lSof3aRHjZ9ZyXjARXTQIlK/cA/rig9x7dB+GiAFE4l
         HOIuy/D6c/qaeymAQUudgk4c5wXsXTV8JyORUI5DHrALy4oyB9C3DyoJU38L0RGqJYut
         w/szsR8Yy3bCZmZKLcjw3n/6lhmbvA6rthmDpHx9h4c+NDQhXZOw9EPAEKr55PhrZfKS
         qGjs654GAOz7roX3q5kkm8ifYxawVoCNoxY8eBsvoWGdL9oeJg+kn5XL4mDdX8ZR3Ala
         mqZFFB4ZYCX/OFAs4UrWH9vqjnoA2EuSWx52q0CX2cSe06XVgnUwezJxqZbIphaeV9a5
         uV7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756838054; x=1757442854;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ozr279Qr3C7/dftyUFUfvHvaGGNWVlgEMFeuHaNz1sQ=;
        b=giBtcVZ2H+XTlsMy8f1BXAz5inVcE7/TrxmZQb7ckN47FZGqtTEBFd3xUsuQ61XNxE
         9qPbFH8EhTDPwWV/f5tY1UkemDVsnCOiT+6Cst0r7bA+duZz90KpT8k1DEf7SdUfSpYo
         bn8En/iQDNrk2aDd+sVYhht7lxpLvL6rQvdWCtdfBREdWgtfPpK1NboH1Xk2owGTaqfP
         iJ9mv1s+/3KewREF9zjDhXmb2mk4eyntRLXRIZSMpLJtEkAhmaAwoD/qqG41/ZPCH7Uc
         JXgzzDt1bcXavUNQ2AhNPrWnDssXOgFruTL2YClTp0YNiHq8PiKWoC3UKLCGm6B+SA7l
         TcXQ==
X-Gm-Message-State: AOJu0Yw44G9Oy5jSdE2M9wLQaq2K5jsQdlUUx0ul3RgXTgp0GEGX5wDG
	TEKh0Uo0mevEdxFgtZm0jXdx4j2hXBA6hAZR4P/isESdGuGqndEAv9Z3jMk6nhGIa9c=
X-Gm-Gg: ASbGncs6iN2JqUPsPwePr1TXc28nzbn15BvE+wsyUz07BFH6VjnNiH7vss0ZpkeMVSk
	wTYSVpuOdQ8ay+xu9oj6UpgkCYzt8N28f1ONLrjFyP7Y2yq3VZku5eWnzREKz+D5fElwCc0CM3T
	uy43IDJusWaFSQaPfG5/Jljx62plXWdegcvCb/oLTMHmhZfyZYGA2cO13gQ7OEC3SwKw7N/I2JU
	cqax1HKrrkCQg9z8RRX91sLr4x4bh5OVxvxhAisa4sd6tjPkLfZLDK3yw7FRKgoiTXhyzoUoh19
	o0bjHkzokhFShOf4zgRpqO0pFstr6U0v0qPBJpe82ziLDMi821PTFmZJtMcIfvahnpD1hxvLIrb
	1VqsND1+zrEbO/LQ7OXQV4CWkQerFFg==
X-Google-Smtp-Source: AGHT+IFyoewyQkFD3NG61mGAIXizgMS8veX/EjIkv5VWOA4VeD/40JNT3aeC/9VsEcdOKAPv/TumTA==
X-Received: by 2002:a05:6000:26cb:b0:3ca:99ad:519e with SMTP id ffacd0b85a97d-3d1dca7bed7mr8080271f8f.4.1756838053592;
        Tue, 02 Sep 2025 11:34:13 -0700 (PDT)
Received: from [127.0.0.1] ([2804:5078:9a0:f000:58f2:fc97:371f:2])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7722a4e1d4fsm14028477b3a.73.2025.09.02.11.34.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Sep 2025 11:34:13 -0700 (PDT)
From: Marcos Paulo de Souza <mpdesouza@suse.com>
Date: Tue, 02 Sep 2025 15:33:53 -0300
Subject: [PATCH v3 2/4] printk: nbcon: Introduce KDB helpers
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250902-nbcon-kgdboc-v3-2-cd30a8106f1c@suse.com>
References: <20250902-nbcon-kgdboc-v3-0-cd30a8106f1c@suse.com>
In-Reply-To: <20250902-nbcon-kgdboc-v3-0-cd30a8106f1c@suse.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1756838042; l=4736;
 i=mpdesouza@suse.com; s=20231031; h=from:subject:message-id;
 bh=/pJm51k0Rdgg7h4U6y2MCvfn06HwAtBOQoQcGVJQThM=;
 b=OwV7zxr7qtBpl4tFe1W2+lxYPvdoZ/xhEiJjaExvY1Sh/xGKLCnnELpOYrDD0V7OjQdDn8eVs
 6rOYDz5TTAYBwwQQlG+wwAIcSTorufLSVyyFwf2tTcE+uxJkjFiMRnv
X-Developer-Key: i=mpdesouza@suse.com; a=ed25519;
 pk=/Ni/TsKkr69EOmdZXkp1Q/BlzDonbOBRsfPa18ySIwU=

These helpers will be used when calling console->write_atomic on
KDB code in the next patch. It's basically the same implementaion
as nbcon_device_try_acquire, but using NBCON_PORIO_EMERGENCY when
acquiring the context.

For release we need to flush the console, since some messages could be
added before the context was acquired, as KDB emits the messages using
con->{write,write_atomic} instead of storing them on the ring buffer.

Signed-off-by: Marcos Paulo de Souza <mpdesouza@suse.com>
---
 include/linux/console.h |  6 +++++
 kernel/printk/nbcon.c   | 66 +++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 72 insertions(+)

diff --git a/include/linux/console.h b/include/linux/console.h
index 67af483574727c00eea1d5a1eacc994755c92607..b34c5a0b86303e2fb4583fa467d8be43761cf756 100644
--- a/include/linux/console.h
+++ b/include/linux/console.h
@@ -605,6 +605,9 @@ extern bool nbcon_can_proceed(struct nbcon_write_context *wctxt);
 extern bool nbcon_enter_unsafe(struct nbcon_write_context *wctxt);
 extern bool nbcon_exit_unsafe(struct nbcon_write_context *wctxt);
 extern void nbcon_reacquire_nobuf(struct nbcon_write_context *wctxt);
+extern bool nbcon_kdb_try_acquire(struct console *con,
+				  struct nbcon_write_context *wctxt);
+extern void nbcon_kdb_release(struct nbcon_write_context *wctxt);
 
 /*
  * Check if the given console is currently capable and allowed to print
@@ -654,6 +657,9 @@ static inline bool nbcon_can_proceed(struct nbcon_write_context *wctxt) { return
 static inline bool nbcon_enter_unsafe(struct nbcon_write_context *wctxt) { return false; }
 static inline bool nbcon_exit_unsafe(struct nbcon_write_context *wctxt) { return false; }
 static inline void nbcon_reacquire_nobuf(struct nbcon_write_context *wctxt) { }
+static inline bool nbcon_kdb_try_acquire(struct console *con,
+					 struct nbcon_write_context *wctxt) { return false; }
+static inline void nbcon_kdb_release(struct console *con) { }
 static inline bool console_is_usable(struct console *con, short flags,
 				     bool use_atomic) { return false; }
 #endif
diff --git a/kernel/printk/nbcon.c b/kernel/printk/nbcon.c
index 646801813415f0abe40cabf2f28ca9e30664f028..ff218e95a505fd10521c2c4dfb00ad5ec5773953 100644
--- a/kernel/printk/nbcon.c
+++ b/kernel/printk/nbcon.c
@@ -1855,3 +1855,69 @@ void nbcon_device_release(struct console *con)
 	console_srcu_read_unlock(cookie);
 }
 EXPORT_SYMBOL_GPL(nbcon_device_release);
+
+/**
+ * nbcon_kdb_try_acquire - Try to acquire nbcon console, enter unsafe
+ *				section, and initialized nbcon write context
+ * @con:	The nbcon console to acquire
+ * @wctxt:	The nbcon write context to be used on success
+ *
+ * Context:	Under console_srcu_read_lock() for emiting a single kdb message
+ *		using the given con->write_atomic() callback. Can be called
+ *		only when the console is usable at the moment.
+ *
+ * Return:	True if the console was acquired. False otherwise.
+ *
+ * kdb emits messages on consoles registered for printk() without
+ * storing them into the ring buffer. It has to acquire the console
+ * ownerhip so that it could call con->write_atomic() callback a safe way.
+ *
+ * This function acquires the nbcon console using priority NBCON_PRIO_EMERGENCY
+ * and marks it unsafe for handover/takeover.
+ */
+bool nbcon_kdb_try_acquire(struct console *con,
+			   struct nbcon_write_context *wctxt)
+{
+	struct nbcon_context *ctxt = &ACCESS_PRIVATE(wctxt, ctxt);
+
+	memset(ctxt, 0, sizeof(*ctxt));
+	ctxt->console = con;
+	ctxt->prio    = NBCON_PRIO_EMERGENCY;
+
+	if (!nbcon_context_try_acquire(ctxt, false))
+		return false;
+
+	if (!nbcon_context_enter_unsafe(ctxt))
+		return false;
+
+	return true;
+}
+
+/**
+ * nbcon_kdb_release - Exit unsafe section and release the nbcon console
+ *
+ * @wctxt:	The nbcon write context initialized by a successful
+ *		nbcon_kdb_try_acquire()
+ *
+ * Context:	Under console_srcu_read_lock() for emiting a single kdb message
+ *		using the given con->write_atomic() callback. Can be called
+ *		only when the console is usable at the moment.
+ */
+void nbcon_kdb_release(struct nbcon_write_context *wctxt)
+{
+	struct nbcon_context *ctxt = &ACCESS_PRIVATE(wctxt, ctxt);
+
+	if (!nbcon_context_exit_unsafe(ctxt))
+		return;
+
+	nbcon_context_release(ctxt);
+
+	/*
+	 * Flush any new printk() messages added when the console was blocked.
+	 * Only the console used by the given write context was	blocked.
+	 * The console was locked only when the write_atomic() callback
+	 * was usable.
+	 */
+	__nbcon_atomic_flush_pending_con(ctxt->console,
+					 prb_next_reserve_seq(prb), false);
+}

-- 
2.50.0


