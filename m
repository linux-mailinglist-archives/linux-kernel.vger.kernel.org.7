Return-Path: <linux-kernel+bounces-863419-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B1E27BF7D6A
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 19:15:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6564F19C16FE
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 17:15:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA57934B192;
	Tue, 21 Oct 2025 17:15:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ssn.edu.in header.i=@ssn.edu.in header.b="N5h+7Phz"
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8343134B185
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 17:14:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761066899; cv=none; b=RAn+/c/XptJRtojZ3wDhgbiEggR0Nb9PxL4Y/4ElEFGcPFaKEvT9kkp4/c52741jyQHPYoo/sFaWpWQtvwTW6q5GKZ50KL3Dx0yduq+hHUa7LttGCN2gAFDIJVrZByVHY+xEmCPR/pVpSBgasD5nZO8lkzsWmqdK9LvHJVMB4DA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761066899; c=relaxed/simple;
	bh=wHtx+6PJVL+KqxRsDUtN8kFqV3WQRw08tAAOotnZQrQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=G5tDuPkAM2e3/94cWfShycX6WkDWys3hTZMZ3RAdkJ627rBP6uBmepYvo9aT0nbYpoKggqzExUxIBNQLPi3lWPwWDS/eNyQktSKCcOYKkeoXJJG9KOqc0BpMzd0GrB+pngOQAlVUJFAefWnJIggiKH1J1qvnFIis6zX5lv6x0ic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ssn.edu.in; spf=pass smtp.mailfrom=ssn.edu.in; dkim=pass (1024-bit key) header.d=ssn.edu.in header.i=@ssn.edu.in header.b=N5h+7Phz; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ssn.edu.in
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ssn.edu.in
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-27ee41e074dso69286315ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 10:14:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ssn.edu.in; s=ssn; t=1761066893; x=1761671693; darn=vger.kernel.org;
        h=mime-version:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=o8BAnbX2/NbCI5ltmg3hGUxFJ1NakIlGpy+wfgJpxpU=;
        b=N5h+7PhzgFB+Vzm1mQ1m7oknsbrY8VcOzKXOoGmhsd3Gmj2c3s2wpeIpH/L2/7hKT5
         gH3hy1x6b3XKr6ybrqLJrgke6Dqu6vwptOYdyURxP5i+vFMU2xQfWQliL2uxBEAe7oAM
         UVsRomuEqn9Hjh6EfQukE6efVr2f8r/uugLWg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761066893; x=1761671693;
        h=mime-version:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=o8BAnbX2/NbCI5ltmg3hGUxFJ1NakIlGpy+wfgJpxpU=;
        b=E7yGqBXAsDtpzhSqx4by5hYYFANCIFEoYBsn2zAgO4KrVRi2xjsW5aqjUfChXcXurE
         N/tE5O/k6ix1Evowme2FPB7JBWv9mhBod6FvhhVLzg3/9dNQlMGaIK+/Wf3eUVO7EzgU
         CkHNnzPXcrcyYQPGWxAHhh8ikyRXoTmcz1FDn+oQxrpiWptNHjF7sGgcvXRSJJokIJkc
         NAAiQzL84Km0C+YPulUKGHGiLfFsP7S+Nmzsr4PUWVo3QbJRvnUrQRa84gTu6z6cwCLR
         CQ/P3QVlnBFKDqpA8UEw2LAbeh7mvuld4msyeyncf9mN9MnypLwtOeCH1dVQ9IYE71Et
         rrLQ==
X-Gm-Message-State: AOJu0YwjHZ31GX4W7n2+jjgd29GMfXbJRzrL9czfA2PfyWqCMX7pYq6r
	les0DuYJPpXrbN2kok/8c9trSlV6dEm1Nvj2dmQgNzTuAkonARJIF6mWmPwUsXoIVcrMTTc3SOr
	E+bc3B7krH9tC7bpxz5q2U4b6J/Nu4n1xg4GjCL2d/Z6a3AToaxisQ6pfI48lL+qiRkoM3L6494
	M=
X-Gm-Gg: ASbGncvKfVwSYzyLKDpor+jQVWje/x4iLOxr+oLXgegR4cOelnlMXsBfWdIaGlMCGDy
	fEgefZoFq46LVwlrA+E3og+jMcYWpQ4BCfDmlssBxRe80b7TMX3J0X7aa0Cnp7v0130Nmz6sufa
	hjO20Pek+7qqI7nwjzULgvgd62n5qsydwRjzXr/nP4hztMVnVpykCUuWJFBpRCJh8RZTHnNM18i
	t809Rc59wK/bhnKfETaGKoDS6MrgKk44zQW3sXN3hWyEIlY+62Q4PzGNe5NJTOJ6Vp/nKUEvZ8J
	4dFIYWLCp8pHvV+IKw6iDnYCriK/ZlsROK4lSKBRKmwKeLwHFGBQjnSiOAoe462UbhsKZ7KkZZf
	HtEAR/H2iJh3H+5DpRLt4ox4CWxBFg1ZAOv71Q6F1g1f6SmBEpL+kfMFfTqu87wnOBjZNR2jvDj
	iqQy8a6kV8mbCLDehiiOfTxv4OGyCR0UvCkH2gZWqrLkGFTcm64i3NlEB9tSO6Psg324gVcrJVK
	lWdr6C8UQSCXhI=
X-Google-Smtp-Source: AGHT+IF4RFGVZ1xNCOZTc0WkLly84dkjOvQDjI5ImpsM+CowNe+eAoByzAS57YHCF6/tlccf+qJ3kg==
X-Received: by 2002:a17:903:2309:b0:272:c95c:866 with SMTP id d9443c01a7336-290c9cb6305mr249301215ad.20.1761066893264;
        Tue, 21 Oct 2025 10:14:53 -0700 (PDT)
Received: from biancaa-HP-Pavilion-Laptop-15-eg2xxx.. ([2406:7400:1c3:33f3:d5f3:33d1:a1e0:46bc])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-292471fdcf9sm113994935ad.91.2025.10.21.10.14.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Oct 2025 10:14:53 -0700 (PDT)
From: Biancaa Ramesh <biancaa2210329@ssn.edu.in>
To: linux-kernel@vger.kernel.org
Cc: Biancaa Ramesh <biancaa2210329@ssn.edu.in>
Subject: [PATCH] Kconfig:Uses glibc so strscpy has to be manually- added
Date: Tue, 21 Oct 2025 22:44:46 +0530
Message-ID: <20251021171446.46942-1-biancaa2210329@ssn.edu.in>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"

Signed-off-by: Biancaa Ramesh <biancaa2210329@ssn.edu.in>
---
 scripts/kconfig/confdata.c | 16 +++++++++++++++-
 scripts/kconfig/symbol.c   | 16 +++++++++++++++-
 scripts/kconfig/util.c     | 17 ++++++++++++++++-
 3 files changed, 46 insertions(+), 3 deletions(-)

diff --git a/scripts/kconfig/confdata.c b/scripts/kconfig/confdata.c
index 9599a0408862..c0fef4cd6b60 100644
--- a/scripts/kconfig/confdata.c
+++ b/scripts/kconfig/confdata.c
@@ -22,6 +22,20 @@
 #include "internal.h"
 #include "lkc.h"
 
+#define HAVE_STRSCPY 0
+#ifndef HAVE_STRSCPY
+static size_t strscpy(char *dest, const char *src, size_t count)
+{
+    size_t i;
+    if (count == 0)
+        return 0;
+    for (i = 0; i < count - 1 && src[i]; i++)
+        dest[i] = src[i];
+    dest[i] = '\0';
+    return i;
+}
+#endif
+
 struct gstr autoconf_cmd;
 
 /* return true if 'path' exists, false otherwise */
@@ -140,7 +154,7 @@ static int conf_touch_dep(const char *name)
 	if (depfile_prefix_len + strlen(name) + 1 > sizeof(depfile_path))
 		return -1;
 
-	strcpy(depfile_path + depfile_prefix_len, name);
+	strscpy(depfile_path + depfile_prefix_len, name);
 
 	fd = open(depfile_path, O_WRONLY | O_CREAT | O_TRUNC, 0644);
 	if (fd == -1)
diff --git a/scripts/kconfig/symbol.c b/scripts/kconfig/symbol.c
index 7e81b3676ee9..0c6746854617 100644
--- a/scripts/kconfig/symbol.c
+++ b/scripts/kconfig/symbol.c
@@ -14,6 +14,20 @@
 #include "internal.h"
 #include "lkc.h"
 
+#define HAVE_STRSCPY 0
+#ifndef HAVE_STRSCPY
+static size_t strscpy(char *dest, const char *src, size_t count)
+{
+    size_t i;
+    if (count == 0)
+        return 0;
+    for (i = 0; i < count - 1 && src[i]; i++)
+        dest[i] = src[i];
+    dest[i] = '\0';
+    return i;
+}
+#endif
+
 struct symbol symbol_yes = {
 	.name = "y",
 	.type = S_TRISTATE,
@@ -795,7 +809,7 @@ bool sym_set_string_value(struct symbol *sym, const char *newval)
 	else
 		return true;
 
-	strcpy(val, newval);
+	strscpy(val, newval);
 	free((void *)oldval);
 	sym_clear_all_valid();
 
diff --git a/scripts/kconfig/util.c b/scripts/kconfig/util.c
index 5cdcee144b58..176ec03bb3f0 100644
--- a/scripts/kconfig/util.c
+++ b/scripts/kconfig/util.c
@@ -13,6 +13,21 @@
 #include <xalloc.h>
 #include "lkc.h"
 
+#define HAVE_STRSCPY 0
+#ifndef HAVE_STRSCPY
+static size_t strscpy(char *dest, const char *src, size_t count)
+{
+    size_t i;
+    if (count == 0)
+        return 0;
+    for (i = 0; i < count - 1 && src[i]; i++)
+        dest[i] = src[i];
+    dest[i] = '\0';
+    return i;
+}
+#endif
+
+
 /* hash table of all parsed Kconfig files */
 static HASHTABLE_DEFINE(file_hashtable, 1U << 11);
 
@@ -52,7 +67,7 @@ struct gstr str_new(void)
 	gs.s = xmalloc(sizeof(char) * 64);
 	gs.len = 64;
 	gs.max_width = 0;
-	strcpy(gs.s, "\0");
+	strscpy(gs.s, "\0");
 	return gs;
 }
 
-- 
2.43.0


-- 
::DISCLAIMER::

---------------------------------------------------------------------
The 
contents of this e-mail and any attachment(s) are confidential and
intended 
for the named recipient(s) only. Views or opinions, if any,
presented in 
this email are solely those of the author and may not
necessarily reflect 
the views or opinions of SSN Institutions (SSN) or its
affiliates. Any form 
of reproduction, dissemination, copying, disclosure,
modification, 
distribution and / or publication of this message without the
prior written 
consent of authorized representative of SSN is strictly
prohibited. If you 
have received this email in error please delete it and
notify the sender 
immediately.
---------------------------------------------------------------------
Header of this mail should have a valid DKIM signature for the domain 
ssn.edu.in <http://www.ssn.edu.in/>

