Return-Path: <linux-kernel+bounces-856376-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 17701BE400B
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 16:49:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BDB494E2DBB
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 14:49:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B325F34AAFF;
	Thu, 16 Oct 2025 14:48:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="HGx/OlzI"
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B82F34575E
	for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 14:48:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760626106; cv=none; b=QiFnlLWecvX/t7pQ3zkj2tMIq7Gg5SE/kLcOWSR2E2nTETATNVIXRKOcGMn9MAZjDUFidPF9mXFskyHurNfllhCjwK5S6ZA86CGoVOIkbN9jYviOgJXuRdPthCckFBNibfWa5DvhsNffpB+AbIPJeI7uQXer6HOtwda5IJzd68E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760626106; c=relaxed/simple;
	bh=w4gD0M3Q/XSOw/nngXbwWx9bgWlfGjxJRzd3ChPyNCU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=oUmq1tCVFzfnR9RQUY0IRf2O2jWxyly4bhedxKyu06+VvksIjNihNsO687wKT9nE5kwR8Hw71iHYzZQWqG02nQegn5jgfwwgUqd4q1OeE9CjlsO7ms2EyzbE+r/b/qowNjga3klAUDvjrrFWNulY4KhvIzOYth39v6HIGj0nEFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=HGx/OlzI; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-426ed6f4db5so1210375f8f.0
        for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 07:48:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1760626101; x=1761230901; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jfCWX5L/45fJp2sEG2KyRgkMyFNZ66dpS278Lbw0JYI=;
        b=HGx/OlzI8H4s5U1eXOYO0zrPIVdFz39liwCH7qLxcd2Cu0uqJdPvBtUzLjhNc++qNe
         SmlEM38CWCm38BfxGVAvKh0/25BPF+T8AEsmJzWLsb+MjBJckFAJMQZDs8feuMR4txqU
         3EtP3Fpm/FHpcMliBI3Jw+qTAd6I/nERum9Cszd9UYplgQv7rVGqoYvf45ytCsA/6FVo
         0yvaNUcU5AE/TTbMLbhZuudfhjcsOTBb/iwrH6CazCh4qZYYRN+0D1y/I9aIg2y3Hv7d
         LZAIMM+Pn5oVUq3E65g4gJ4XJs7/NtBRQI/+3PCh/75DXSvxx/gIwVlS+mrz1A9+6Fu8
         eEdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760626101; x=1761230901;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jfCWX5L/45fJp2sEG2KyRgkMyFNZ66dpS278Lbw0JYI=;
        b=ROlDYHAvbIerYnoRmKTWSPshAecb1sUC2KdttmUqHx/x+mtJYZlB06PYWHdn3P6NMr
         c1Txkp+3uEXZqVDa7l1JRYsYcu+ZgtdK6W64Lx8dVEk+/XHHfpaBfBP6HQxLDgXE81rS
         VQj/gS5rAmV085SqqElmpN/hHn8TckCHQhGsdVxj/WMaIsbcu20YWCiK5cpDhMHmluFO
         Bqq3R70riSVdq2iQzH2Q/L5kh7FtzoEpVEgnRViUusBpOikilIgHQgc1a+lv/g5wTte2
         RhAKRiM/njMkZI3Y7uFyfmMaFuo79RTT3gdOFYWgknpcl1oA8VrqCDe6QGBgPjxPvlzK
         oAOw==
X-Gm-Message-State: AOJu0YyZ7PzdiA7ar4Pb1/xz3ZyZtssMooHL7FesFeOC3eu73UlSE1w2
	4LRO3PMnG6rzdOYR5S1mtlPnM2LXLqMyhQ6ZfXDsLo+aU1Bm9OykAzzVRTXbgxHXvdU=
X-Gm-Gg: ASbGnctM5wrcM+tRf56PFUnriAhICJ6W0uptfeV/IggzpFUfwBUpwiH9rgKm3e8b9f6
	M7idgFSTRQcru7EhMWduFuQ496FCYFyUfjzEtL4s5izWea4+3HvNVI10N1B95f7N2ecHZxtly+L
	tdaLFghlkDNbllt2zbO2sD6NnsebkrlN9Fcqzp4yHmAEZlvokzst6PtY0KbnoLYtcEPO3T6kn6y
	dyDoGbP2jBkDLcO+2QA4pHAMSOjeKZWnNr6bMBxwRpWz7WRIg1TDzfSlQ9J0N5fRpSFy4W97Y+r
	A3TXrCeT/3Uo+e35tYLgbaouq6Nv4ksmsCnRzb9VBev3//4sRNEVBVcwxvRvI0ROLhVVKfmWJnt
	z0ebo3TgsuOFjTK2Xw5NsrVS/jokpGV9lpfWgdeoBbwPgNrumQuFVaOJqIEKkqwx9DwLer18z
X-Google-Smtp-Source: AGHT+IGo4Cc39I4nG0TJafwo9a7Xh0M7RgPDDdK38+wx36MPX6UKlkPJY4aUzlKdaIdl7azK5RZkUA==
X-Received: by 2002:a05:6000:2089:b0:427:521:134c with SMTP id ffacd0b85a97d-42705211378mr179936f8f.6.1760626100623;
        Thu, 16 Oct 2025 07:48:20 -0700 (PDT)
Received: from [127.0.0.1] ([2804:5078:81f:9200:58f2:fc97:371f:2])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29099afe03bsm32947795ad.107.2025.10.16.07.48.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Oct 2025 07:48:20 -0700 (PDT)
From: Marcos Paulo de Souza <mpdesouza@suse.com>
Date: Thu, 16 Oct 2025 11:47:57 -0300
Subject: [PATCH v6 4/5] printk: nbcon: Export nbcon_write_context_set_buf
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251016-nbcon-kgdboc-v6-4-866aac60a80e@suse.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1760626083; l=2693;
 i=mpdesouza@suse.com; s=20231031; h=from:subject:message-id;
 bh=w4gD0M3Q/XSOw/nngXbwWx9bgWlfGjxJRzd3ChPyNCU=;
 b=dZo7itqbk12g83O1fhCyQdj0pIWugmoj09SChDZC69yIlg7d6dpLBkG10GOymxcJOcVZ8wmZe
 FWgFREMMqR2CxzMWI075Chogqro1oX6YKizm7mW2YL0RNJAInC3OWh6
X-Developer-Key: i=mpdesouza@suse.com; a=ed25519;
 pk=/Ni/TsKkr69EOmdZXkp1Q/BlzDonbOBRsfPa18ySIwU=

This function will be used in the next patch to allow a driver to set
both the message and message length of a nbcon_write_context. This is
necessary because the function also initializes the ->unsafe_takeover
struct member. By using this helper we ensure that the struct is
initialized correctly.

Reviewed-by: Petr Mladek <pmladek@suse.com>
Reviewed-by: John Ogness <john.ogness@linutronix.de>
Signed-off-by: Marcos Paulo de Souza <mpdesouza@suse.com>
---
 include/linux/console.h | 4 ++++
 kernel/printk/nbcon.c   | 4 ++--
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/include/linux/console.h b/include/linux/console.h
index 0d589a933b6b..81d2c247c01f 100644
--- a/include/linux/console.h
+++ b/include/linux/console.h
@@ -603,6 +603,8 @@ static inline bool console_is_registered(const struct console *con)
 extern void nbcon_cpu_emergency_enter(void);
 extern void nbcon_cpu_emergency_exit(void);
 extern bool nbcon_can_proceed(struct nbcon_write_context *wctxt);
+extern void nbcon_write_context_set_buf(struct nbcon_write_context *wctxt,
+					char *buf, unsigned int len);
 extern bool nbcon_enter_unsafe(struct nbcon_write_context *wctxt);
 extern bool nbcon_exit_unsafe(struct nbcon_write_context *wctxt);
 extern void nbcon_reacquire_nobuf(struct nbcon_write_context *wctxt);
@@ -655,6 +657,8 @@ static inline bool console_is_usable(struct console *con, short flags, bool use_
 static inline void nbcon_cpu_emergency_enter(void) { }
 static inline void nbcon_cpu_emergency_exit(void) { }
 static inline bool nbcon_can_proceed(struct nbcon_write_context *wctxt) { return false; }
+static inline void nbcon_write_context_set_buf(struct nbcon_write_context *wctxt,
+					       char *buf, unsigned int len) { }
 static inline bool nbcon_enter_unsafe(struct nbcon_write_context *wctxt) { return false; }
 static inline bool nbcon_exit_unsafe(struct nbcon_write_context *wctxt) { return false; }
 static inline void nbcon_reacquire_nobuf(struct nbcon_write_context *wctxt) { }
diff --git a/kernel/printk/nbcon.c b/kernel/printk/nbcon.c
index 5be018493909..fdd1cbebe77d 100644
--- a/kernel/printk/nbcon.c
+++ b/kernel/printk/nbcon.c
@@ -854,8 +854,8 @@ static bool __nbcon_context_update_unsafe(struct nbcon_context *ctxt, bool unsaf
 	return nbcon_context_can_proceed(ctxt, &cur);
 }
 
-static void nbcon_write_context_set_buf(struct nbcon_write_context *wctxt,
-					char *buf, unsigned int len)
+void nbcon_write_context_set_buf(struct nbcon_write_context *wctxt,
+				 char *buf, unsigned int len)
 {
 	struct nbcon_context *ctxt = &ACCESS_PRIVATE(wctxt, ctxt);
 	struct console *con = ctxt->console;

-- 
2.51.0


