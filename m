Return-Path: <linux-kernel+bounces-762731-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 48896B20A48
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 15:34:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 17C6C7A8F0F
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 13:32:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0D492DCF6C;
	Mon, 11 Aug 2025 13:33:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="B81o32Cu"
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12EBE2DAFA0
	for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 13:33:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754919227; cv=none; b=uThmMGr27nPgreKd4/NGgsRG75jdAWWFCoQUonU8FEQgfaBBpykD6BsFfCfBZFJJMRb2WkRLdYDkYuy2Fe4yHdELQifE9+g1A4j9FBYsQ+eRlhy+QcGV0UGQIwXc8tLOxTh+kZcWt8RJ+Y0ilkQRR5Qs04Arfr6GGigoQczmXxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754919227; c=relaxed/simple;
	bh=ufvmR164HIDVErbGEUZkCxgBjPQguwJct+qr4ByygZI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TARUW4HOfb3F4CkbhGdBdG8aZWx0PkTMBo4NcbXl33bF57uzRnnXdKUBCxJI3sMTQO6QWiVNp7yFw2QpASkQuuySNnfHLeKQ/8mDAdRVS7g651KFzXlPwv+saX9926JTfu70Z04erE3vI4FPVAgCLWBjM61yf0X6xlYnVpP/Wx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=B81o32Cu; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-3b7823559a5so2000913f8f.0
        for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 06:33:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1754919222; x=1755524022; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cbLmjZ7mpSHXmCBoNACkr+Z3uGmrZkDtS8F4oX6bjhs=;
        b=B81o32CuwezYTMxTxF9TH7I6CCwA5iSZ8D/W2m1QNk971l6ehCAofaYC+aP/DRkW/w
         9+eCQiQFJAFyDNOuo0EA7XhNJhv7pS3Hlo83Tb6fMPgFiu7HC3hfiCDZrX3+MpW9oXLo
         WMrsK69vbcRYf5n8+oteQ5vVFdBG32JRA3C6F55kSmNUSJ0r42V7FDa+pEBTDpAPrTiI
         s9fO4nr6r4wRUPUo3ZLJKQ5GUPKBj9bZlrY8rHhW5fJIRddOrZQLusjzrP3pg5R/oI76
         v3HoIfqAKByZlrp/Cr50chploRCyNVHS6o1D+iE7XkPA7oG+6X6f6cVSC6c1YI++H6yA
         7/ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754919222; x=1755524022;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cbLmjZ7mpSHXmCBoNACkr+Z3uGmrZkDtS8F4oX6bjhs=;
        b=DAuEly2CkEW6iLWmuLZzXkaYJexCeh1EsE4YR/+Wusf9JBwme7813d9VDtFlp9NlmC
         xIKqR3D42XOi5pNp08WjjosUa9hJt1Ka5uXuBrG3E35QoIHLYUPwHemGM+/Z3f3cCJyG
         Z6/wPASL/2b9bfyDCgWa29g+d3iwnJwm0wVQQ4SnPjiKkgQxQ+WWEzmFImQ2pEtzJRMn
         56xO3HdFLgd2jFU6ytKfrbPy9yji9pg+v5afhvmVMXU9qGn8SOT/QkCBKHUkOk3H2X+3
         7eoOWd6d9MTBbZGKfveTABHaSGlsmS/5x/WHuhUlFAQ0sJXKqbFDzSVwpmAeAW0Ly7JL
         TuUw==
X-Gm-Message-State: AOJu0Yzg/Ix5eR50CboL8QRb5kY8pd4FDEQI5UU98IVOHyy/s7cD2mxI
	5BceozDU3xIPj9zJzmw2PGs25uGIkNXEVN6KXPZmjwqzpvKns6igQsHLnLMHNMbLIpg=
X-Gm-Gg: ASbGncvW2jnj5OJyzNig5tinQJXJ1ZZ7R/gjGckm0pT7ErrP1rkfQqlJqpDtzT4bqM0
	AUD9hJg/DNZs9SdojNwAmopjQpHZBiyoxUalzNxpnOutZoT0jrZF6hucYHaDbYYHETyizGdR20h
	imIoheY9q3ARir4kbGyIZmo+Mshrkb3w6eGK9b/Q3hxV8F6BFOlplem7qlu9cozobZBNEhttO3H
	uXSkXz0nIkKKRBtSPReWk4upYsC27zmzJzUYhsWRnopNi8IXsblsGcG69CgAM87J7Hm/3aeq4Lq
	dRb50mhD0X6q6NPKtZw8v9wjbBnleEewLqrzp5i2JQIxfKlen6ik0PgsI1qoY9jxciyqKwupQdC
	WGlD2NliTvbDGmmPp7955MuGjo3tK3RL438i+TI7LR81dwg==
X-Google-Smtp-Source: AGHT+IGK59D88yKPWNRUvP+ILW4Vpaah51IRVhPO6OEWpPPAqEFM3jLI+j3e4vsddNCEhMgpbbmK1A==
X-Received: by 2002:a5d:5f8d:0:b0:3b8:d893:5230 with SMTP id ffacd0b85a97d-3b900b510dcmr10619010f8f.47.1754919222247;
        Mon, 11 Aug 2025 06:33:42 -0700 (PDT)
Received: from [127.0.0.1] (71.36.160.45.gramnet.com.br. [45.160.36.71])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76bccfd18c9sm26667449b3a.91.2025.08.11.06.33.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Aug 2025 06:33:41 -0700 (PDT)
From: Marcos Paulo de Souza <mpdesouza@suse.com>
Date: Mon, 11 Aug 2025 10:32:46 -0300
Subject: [PATCH v2 2/3] printk: nbcon: Introduce KDB helpers
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250811-nbcon-kgdboc-v2-2-c7c72bcdeaf6@suse.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1754919199; l=3028;
 i=mpdesouza@suse.com; s=20231031; h=from:subject:message-id;
 bh=ufvmR164HIDVErbGEUZkCxgBjPQguwJct+qr4ByygZI=;
 b=0z+ZxHNmXiP62d7RqMOp8U/qBmtiS8QwaHpae3RV/4o5+s7NEPv1b+j/TXHxNSxHwk7pebdRu
 UUXdMjY3XxnAJpBlLuBJEIWrZwYzFWgwSp94O2nWTyO6RKQytI7ZRFN
X-Developer-Key: i=mpdesouza@suse.com; a=ed25519;
 pk=/Ni/TsKkr69EOmdZXkp1Q/BlzDonbOBRsfPa18ySIwU=

These helpers will be used when calling console->write_atomic on
KDB code in the next patch. It's basically the same implementaion
as nbcon_device_try_acquire, but using NBCON_PORIO_EMERGENCY when
acquiring the context.

For release, differently from nbcon_device_release, we don't need to
flush the console, since all CPUs are stopped when KDB is active.

Signed-off-by: Marcos Paulo de Souza <mpdesouza@suse.com>
---
 include/linux/console.h |  6 ++++++
 kernel/printk/nbcon.c   | 26 ++++++++++++++++++++++++++
 2 files changed, 32 insertions(+)

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
index 646801813415f0abe40cabf2f28ca9e30664f028..79d8c7437806119ad9787ddc48382dc2c86c23c3 100644
--- a/kernel/printk/nbcon.c
+++ b/kernel/printk/nbcon.c
@@ -1855,3 +1855,29 @@ void nbcon_device_release(struct console *con)
 	console_srcu_read_unlock(cookie);
 }
 EXPORT_SYMBOL_GPL(nbcon_device_release);
+
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
+void nbcon_kdb_release(struct nbcon_write_context *wctxt)
+{
+	struct nbcon_context *ctxt = &ACCESS_PRIVATE(wctxt, ctxt);
+
+	nbcon_context_exit_unsafe(ctxt);
+	nbcon_context_release(ctxt);
+}

-- 
2.50.0


