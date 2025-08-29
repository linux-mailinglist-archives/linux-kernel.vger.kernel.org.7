Return-Path: <linux-kernel+bounces-791627-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 079FCB3B970
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 12:55:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5574B1CC0095
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 10:55:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A675314B67;
	Fri, 29 Aug 2025 10:54:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="m5n0O6Wt"
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BD0A311C30
	for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 10:54:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756464880; cv=none; b=djY5ljo4ae/P4LOzo6tiC2pkc3cepqnzxyOcmquZyTyWFdYJDGwUPmg6jXOGe/fABYD0H88JebcBy2sVZqDPCUzJ33qxa+C+qaA1xH8rd0DzAv7urmrRWJlL1TJ5IeM5xj0EQLjrlkeQfpMWMwmzANAGA2PpIW+FGoAaWepw5No=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756464880; c=relaxed/simple;
	bh=zCQKK9m+KKuyKhTLmtwoTILfUCZPd/hNRBlyLkdveFA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=SDYnmAmKeBvl0H7Jd7mxd5lDE01IfP1OLmEGUdT1cQcqf3xs75ZaDCMu6blVJuoh/YTaZu//9mDyfmGDr/BeUZEnamu2lWMH/LAhKA6G+J6+fcrX0F47AmDnCY1uOEbmrBno97iL/9O2AQDOPrjd6My72Pr3uJvwMUYfMF8gs5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--sidnayyar.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=m5n0O6Wt; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--sidnayyar.bounces.google.com
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-45a1b0b14daso11897825e9.2
        for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 03:54:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756464874; x=1757069674; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=qmPxRzAkCLsUXg26vuwkDnrhDTwJQL7buKLtRL62U1U=;
        b=m5n0O6WtgFU8lJRL6ltcrvQ0ZkaBnzp3kjOgjRI++TxlWGrLj+bMkP6InbIKodn5Oj
         L1dBqsJeoZP4O4x8kKxCOQ6wgLZtMI1QGK17oNzfZZYCTX1o3dbSWdx48a2xvaPIfNbB
         67DmQXtbgmld3OW2HKadXGFphXa67YCGeHEG5YaKV4Sfmpkhx7/K4ldv9AHv7EABronG
         cCS5IkeQBkyMqMsXpBc/y3o60gAAsZk+eBEHMui9rGsktuy/Su1nDfO/kI8rr6CxgRvZ
         yiS/8oLboSdwaZID1zollV9VktPaknCE69J5N0oxBfUgBRQ4MQtzt5YYOvnkUUXYL46+
         HzPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756464874; x=1757069674;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qmPxRzAkCLsUXg26vuwkDnrhDTwJQL7buKLtRL62U1U=;
        b=R6cdbKgPnCFlCAGVS7VHeeO75fZtjHI2pCqNxYYH66hBST2nuh/3kkkAm1YIf0XvUE
         byWqu7+eXW4S0ClfD3+YA0Ass0nkLtyRDBeKQwS4Odyw2bOSQN4dDIqTE2y+XExJO31/
         V83xNONHEHl2JgJafkMYmCe8+KoHPWhAmMkIEQZHXxOYWkuhk8P+qzuzYKkPLbPq8/np
         NjcPclQ20FOXUqSbIObC85y+MYrMLrVTnmjJ0TtxF0apiG5P2QUDrKRdisxcTtXJ1QQs
         iScDWPAQBMIRLGKNhZW+LaG6ZBL6KE82dYjtY9Vh5oxnXydhqXmwTV+CKXPa9xbJdeY4
         /7qw==
X-Forwarded-Encrypted: i=1; AJvYcCXWgb/aEUsHHFDSPrhH1uvs1MJo/kl+TKBQX2ZwqLzu2XOEbt7Lo4T4a742OuIwUp1YHEpi8u6eZvzO31w=@vger.kernel.org
X-Gm-Message-State: AOJu0YwuJmfgiEmILKm+mliB7JFAusdppToETaP6sjIkiOPGx4uEd18+
	R2FkQHHB8BBKEkcojevN1Vs80g3lbYyKSzv1LSt9MAU4E6+qr/faJ30zRnoCtIKXQFbuvMWv2HY
	9hff4sC4bU+tkTvocVg==
X-Google-Smtp-Source: AGHT+IElRmJCyExdp5sqN3Bq7s04CX81XnHqEMpfJfcSboz7fZGDW9C7V4YwGMPKStkjm9pWTX9m+C+ad9Vw1dk=
X-Received: from wmbji5.prod.google.com ([2002:a05:600c:a345:b0:459:7c15:15b9])
 (user=sidnayyar job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:34c8:b0:45b:8067:d8bf with SMTP id 5b1f17b1804b1-45b8067db82mr16690415e9.14.1756464874501;
 Fri, 29 Aug 2025 03:54:34 -0700 (PDT)
Date: Fri, 29 Aug 2025 10:54:13 +0000
In-Reply-To: <20250829105418.3053274-1-sidnayyar@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250829105418.3053274-1-sidnayyar@google.com>
X-Mailer: git-send-email 2.51.0.338.gd7d06c2dae-goog
Message-ID: <20250829105418.3053274-6-sidnayyar@google.com>
Subject: [PATCH 05/10] modpost: put all exported symbols in ksymtab section
From: Siddharth Nayyar <sidnayyar@google.com>
To: Nathan Chancellor <nathan@kernel.org>, Luis Chamberlain <mcgrof@kernel.org>, 
	Sami Tolvanen <samitolvanen@google.com>
Cc: Nicolas Schier <nicolas.schier@linux.dev>, Petr Pavlu <petr.pavlu@suse.com>, 
	Arnd Bergmann <arnd@arndb.de>, linux-kbuild@vger.kernel.org, linux-arch@vger.kernel.org, 
	linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Siddharth Nayyar <sidnayyar@google.com>
Content-Type: text/plain; charset="UTF-8"

Since the modules loader determines whether an exported symbol is GPL
only from the kflagstab section data, modpost can put all symbols in the
regular ksymtab and stop using the *_gpl versions of the ksymtab and
kcrctab.

Signed-off-by: Siddharth Nayyar <sidnayyar@google.com>
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
2.51.0.338.gd7d06c2dae-goog


