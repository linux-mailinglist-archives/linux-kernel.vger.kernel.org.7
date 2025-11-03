Return-Path: <linux-kernel+bounces-883332-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id AABEDC2D164
	for <lists+linux-kernel@lfdr.de>; Mon, 03 Nov 2025 17:23:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D95924E177E
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 16:21:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C022B31B131;
	Mon,  3 Nov 2025 16:20:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="4cxwHzI0"
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34BF93164B4
	for <linux-kernel@vger.kernel.org>; Mon,  3 Nov 2025 16:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762186811; cv=none; b=MbIfE/ddhtTFtwu3f2Dd+a9qzi5D3e2zxV+q3wnAJLxpTXDjYH9TdGq4nG2a0+ng71Vma30CEYwJEo4loB657FjzxE0Hhg193jkfFPdEkSQpGFXmeBDhINEm8BEcSTdSOZqxPcapgNXg3RCEp+DjCUuKUKjQ6b7VaCXnGcHFuBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762186811; c=relaxed/simple;
	bh=9Cwz4yVXI1l3qeHRLhyx4TZ/Ev1Njh9gQAluw4KuMPo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=dhvAnqEW2UJhkTnorBpg78hHpM14sEJtcWg3qMScTSY+feHi+nbwKJqGy8QYFvysmbszcMQka1u63cD86Rn7tf/sW3wOQNJ9XLSk6z9vngR72PGMM/MvXR9XJ4IXlulJVwcThTLrtV8mxjE/kBYog/pPQeUGWfxALGSTOBxeBho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--sidnayyar.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=4cxwHzI0; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--sidnayyar.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-475de0566adso34915305e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 03 Nov 2025 08:20:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762186807; x=1762791607; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=I3NEOOYIbpeR+4we18GdYqD7b1OledoGg+btJU35ZGk=;
        b=4cxwHzI0AQ7iZu5m355hJAxmp43DNe8NLTTPMxhU66Jvx5j63K3bc/HwCkxT0latvQ
         EKQWh6CYyJKgX6ubDo/JA/Yw+NSB3c+H+YRb4Gz95zmUKM2LCgYYEMOCZS+0nz7zXoJI
         ScBdlLG3xmJzAyHc5musgPZgb/XeVPTHtydcbOMX+/vFohLDx+npb8oY8V9Y7wYaNd9W
         s6vEWqIBslb1LKqJnCBWOJ6bdyhCduby0FITfZFGNWN6Bgi4E0pONa2zgySBUMBfaDtQ
         xiXRLjp16Kyc+R2f2IgiuNuKzgUkRwU0pKNUJpAmGzV5e40qIr+SYhgPKs3x3tFiQwAm
         SXFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762186807; x=1762791607;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=I3NEOOYIbpeR+4we18GdYqD7b1OledoGg+btJU35ZGk=;
        b=oEYFclXhrs9FBU0e7djAZRXcSJPNW9n+u4kOSZsG9RZo+mEMa3tzxJluFyXqdE61lA
         T3jw2F+ll0R2naQy4yulozQ4ty3HhJMClU4DjZ6gZsS0abQItE76KSxL0TDnJmTeIvNC
         awMIp99vtpkRpe278NRC7XJdqjqKvTUWiJiVBCKCismYcD+0OOIcxt4x3Uic2EcoQg8u
         bkrWiKOqxdRhr5625nil1EI0X4n7qHptOQndyr23G5SD3rCyEXX5kEgVgiiRanV6lA0M
         3+aUEvNqAy9pprvEsn2yCg4RGO+SUxiWmxowcENIRqrGPPQSATuMA9O+XBHDV/MV2D0I
         gJVA==
X-Forwarded-Encrypted: i=1; AJvYcCWmbLpqEg8C2ruQ/v55JWa+fzkGWrbaGJjJVfZ7HSGFR/gfouJmneKxDz87YLBP0zbppvN3/f2hnzHt+3s=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZfDjRz8VL9Z1SVulufmyUnjB0B0hy5xd58HaicLc4rlwQoLNS
	bj9YZ/KGeFQIJQTeGZUuGTZBnl5X9RwmGLpL3f+iKK5YEsUPqcXf1NNaFCanurbxYoHfCycJEKF
	l885Rr/ViegyvWRWx5w==
X-Google-Smtp-Source: AGHT+IGWADIxrNkiKWiAtHE2F2qUzfmmzbjTu7H/WDRRQcPsxtPCSsOpwinifQgqwk4x+PMn602oe0eH71+Kf3k=
X-Received: from wmco23.prod.google.com ([2002:a05:600c:a317:b0:477:40c1:3e61])
 (user=sidnayyar job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:6995:b0:471:15c1:45b9 with SMTP id 5b1f17b1804b1-477308b0606mr131316165e9.29.1762186807379;
 Mon, 03 Nov 2025 08:20:07 -0800 (PST)
Date: Mon,  3 Nov 2025 16:19:51 +0000
In-Reply-To: <20251103161954.1351784-1-sidnayyar@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251103161954.1351784-1-sidnayyar@google.com>
X-Mailer: git-send-email 2.51.1.930.gacf6e81ea2-goog
Message-ID: <20251103161954.1351784-6-sidnayyar@google.com>
Subject: [PATCH v3 5/8] modpost: put all exported symbols in ksymtab section
From: Siddharth Nayyar <sidnayyar@google.com>
To: petr.pavlu@suse.com, corbet@lwn.net
Cc: arnd@arndb.de, linux-arch@vger.kernel.org, linux-kbuild@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-modules@vger.kernel.org, 
	mcgrof@kernel.org, nathan@kernel.org, nicolas.schier@linux.dev, 
	samitolvanen@google.com, sidnayyar@google.com, maennich@google.com, 
	gprocida@google.com
Content-Type: text/plain; charset="UTF-8"

Since the modules loader determines whether an exported symbol is GPL
only from the kflagstab section data, modpost can put all symbols in the
regular ksymtab and stop using the *_gpl versions of the ksymtab and
kcrctab.

Signed-off-by: Siddharth Nayyar <sidnayyar@google.com>
Reviewed-by: Petr Pavlu <petr.pavlu@suse.com>
---
 include/linux/export-internal.h | 21 +++++++++++----------
 scripts/mod/modpost.c           |  8 ++++----
 2 files changed, 15 insertions(+), 14 deletions(-)

diff --git a/include/linux/export-internal.h b/include/linux/export-internal.h
index 4123c7592404..726054614752 100644
--- a/include/linux/export-internal.h
+++ b/include/linux/export-internal.h
@@ -37,14 +37,14 @@
  * section flag requires it. Use '%progbits' instead of '@progbits' since the
  * former apparently works on all arches according to the binutils source.
  */
-#define __KSYMTAB(name, sym, sec, ns)						\
+#define __KSYMTAB(name, sym, ns)						\
 	asm("	.section \"__ksymtab_strings\",\"aMS\",%progbits,1"	"\n"	\
 	    "__kstrtab_" #name ":"					"\n"	\
 	    "	.asciz \"" #name "\""					"\n"	\
 	    "__kstrtabns_" #name ":"					"\n"	\
 	    "	.asciz \"" ns "\""					"\n"	\
 	    "	.previous"						"\n"	\
-	    "	.section \"___ksymtab" sec "+" #name "\", \"a\""	"\n"	\
+	    "	.section \"___ksymtab+" #name "\", \"a\""		"\n"	\
 		__KSYM_ALIGN						"\n"	\
 	    "__ksymtab_" #name ":"					"\n"	\
 		__KSYM_REF(sym)						"\n"	\
@@ -59,15 +59,16 @@
 #define KSYM_FUNC(name)		name
 #endif
 
-#define KSYMTAB_FUNC(name, sec, ns)	__KSYMTAB(name, KSYM_FUNC(name), sec, ns)
-#define KSYMTAB_DATA(name, sec, ns)	__KSYMTAB(name, name, sec, ns)
+#define KSYMTAB_FUNC(name, ns)	__KSYMTAB(name, KSYM_FUNC(name), ns)
+#define KSYMTAB_DATA(name, ns)	__KSYMTAB(name, name, ns)
 
-#define SYMBOL_CRC(sym, crc, sec)   \
-	asm(".section \"___kcrctab" sec "+" #sym "\",\"a\""	"\n" \
-	    ".balign 4"						"\n" \
-	    "__crc_" #sym ":"					"\n" \
-	    ".long " #crc					"\n" \
-	    ".previous"						"\n")
+#define SYMBOL_CRC(sym, crc)					\
+	asm("	.section \"___kcrctab+" #sym "\",\"a\""	"\n"	\
+	    "	.balign 4"				"\n"	\
+	    "__crc_" #sym ":"				"\n"	\
+	    "	.long " #crc				"\n"	\
+	    "	.previous"				"\n"	\
+	)
 
 #define SYMBOL_FLAGS(sym, flags)					\
 	asm("	.section \"___kflagstab+" #sym "\",\"a\""	"\n"	\
diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
index f5ce7aeed52d..8936db84779b 100644
--- a/scripts/mod/modpost.c
+++ b/scripts/mod/modpost.c
@@ -1867,9 +1867,9 @@ static void add_exported_symbols(struct buffer *buf, struct module *mod)
 		if (trim_unused_exports && !sym->used)
 			continue;
 
-		buf_printf(buf, "KSYMTAB_%s(%s, \"%s\", \"%s\");\n",
+		buf_printf(buf, "KSYMTAB_%s(%s, \"%s\");\n",
 			   sym->is_func ? "FUNC" : "DATA", sym->name,
-			   sym->is_gpl_only ? "_gpl" : "", sym->namespace);
+			   sym->namespace);
 
 		buf_printf(buf, "SYMBOL_FLAGS(%s, 0x%02x);\n",
 			   sym->name, get_symbol_flags(sym));
@@ -1890,8 +1890,8 @@ static void add_exported_symbols(struct buffer *buf, struct module *mod)
 			     sym->name, mod->name, mod->is_vmlinux ? "" : ".ko",
 			     sym->name);
 
-		buf_printf(buf, "SYMBOL_CRC(%s, 0x%08x, \"%s\");\n",
-			   sym->name, sym->crc, sym->is_gpl_only ? "_gpl" : "");
+		buf_printf(buf, "SYMBOL_CRC(%s, 0x%08x);\n",
+			   sym->name, sym->crc);
 	}
 }
 
-- 
2.51.1.930.gacf6e81ea2-goog


