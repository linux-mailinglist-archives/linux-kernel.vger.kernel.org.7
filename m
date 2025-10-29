Return-Path: <linux-kernel+bounces-874945-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AB4AC17AC0
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 01:55:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id B26F03556E3
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 00:55:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A54B52D73B6;
	Wed, 29 Oct 2025 00:54:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="y8Pj8FWM"
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 791F32D738B
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 00:54:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761699298; cv=none; b=arFUxRLRYzdvfDrmTo18UhFkmb2YwjGu1P7OC3KM2c8okUOPWfN/VlU5SVs7LXFx0QKcEp2Raz1LnL6uxAoQZYl6AU5Tl+eED+rgQjbrzF5bfIrghhCcqgnTQkqaajvCERq+ahiQDCDyQ/zZRegAtKlYsGXxOWOLpQBJfXhphvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761699298; c=relaxed/simple;
	bh=QfA6ueu2RM00VYhWG6lIl1KGnKoJGm124vSmauR90CU=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=HiLPTiJrTyo0+1MvHx2ML8vcL6kfex60q3dRb7rt74uW4y0zWAWS6gYUKjLLb8PppbQslqDHGRptfJvKXvE31F+aj4ZYBKMgAFjZJEyfKjr3ZGIoFxjT7PzKVLuZmwmtebRRToNrFR/z2Xt0Bi0i0VSyRe+vJOqIp1saXIAGq8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--isaacmanjarres.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=y8Pj8FWM; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--isaacmanjarres.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-33bc5d7c289so11678795a91.0
        for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 17:54:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761699296; x=1762304096; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=U0ZBDM2WqDs4+hrpz4i4EEV6LSR579hv8hvS+XN4X+4=;
        b=y8Pj8FWMwtGr9UkUjrOvzhYi/5k06miqC50pJVyMoEwSTCzhtSGbDgkuslCRWR+9Pz
         2JJpYwpEQgQz2OVcjwIIeqravmNlMZJtEw/3CbWJiG4u8NhHnNAjAlglat/Ye/j849Ww
         PQqjv9eEk1LiSuE0CGvZuB/iDSvmTuRO7OVlKm0To78R4r7vYc+M/uQFf2XKxhA/AOU8
         DAmh7wGfTuI+vJDGGpOy67JW4nqAmNpAymFzUrEjaZPMNGMS9zMk/9MW/D5ohaRegwoY
         HO1k1wamrSU4jLDqinvf0PW3FJCL+q/EgdLSDhHn3OGhjXHzU+tY8Y3j34VALtuXW+UF
         dQgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761699296; x=1762304096;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=U0ZBDM2WqDs4+hrpz4i4EEV6LSR579hv8hvS+XN4X+4=;
        b=L4cRLlAxlZsSRR1G2bYYmXxnadKO+z21REObSqYIin2HFCb+trhBCxlI6rYwT2kt5U
         REHxWWcuCU3t1CkY/z/ClZ2jqCfKkVwLr9j8pD8U5ei/R2Fr45LufieBAGOVILX7JegT
         LQxWsq+CTXrcSw1HVVvAiIPI0T4l/12aiBcku8fEbdcbNNfYOUz1s2gs9DVm18tLGnV+
         O81cVt9XffKv4PD4Jmv6xqxpOJ8n6+DBpYppTNJ8Q5Ngh8Grqndt3VytTYXoGiyi2wBy
         TDDpovCinQtmT9LIIWHtFQtp86bWsAFr1AQN2uBaBHTEqu9/MI/Q80ImuUU/yvw2Vo5h
         8PaQ==
X-Forwarded-Encrypted: i=1; AJvYcCV+dOeUbgCI6jOn7X4eqD8K5dqjjXz1q4FKBqkzrK6sp7kpvk9CdbaYqlP8L39y55VZtW2KqApK19/i6Cg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1kzE+Tqf5LbQq1ivbXeXoecgv5ewdIp7l0yzZ/anXcLXUST6b
	tPHPbONpiO+12t8Q+6XFG3WWKWlt9uiXxkITfd5G05E1Qr4vz6k7cdu4M/3pNNvQa8bXTazgzx6
	gDC2vX+HPlH8pbOuAQHPxgI/vB+dIOtflm4yhlA==
X-Google-Smtp-Source: AGHT+IGjiXMadbpYiil9Vmkl6RnYWU3TmKaYZ7ofRAVV/o5scIk3NiDBTPH+cBn/nEjZom/bXwEj4x59awX7jYcm5CW3iA==
X-Received: from pjbpb12.prod.google.com ([2002:a17:90b:3c0c:b0:33b:ba24:b207])
 (user=isaacmanjarres job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:5404:b0:339:a243:e96d with SMTP id 98e67ed59e1d1-3403a2a22f9mr1156419a91.36.1761699295688;
 Tue, 28 Oct 2025 17:54:55 -0700 (PDT)
Date: Tue, 28 Oct 2025 17:54:47 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.51.1.851.g4ebd6896fd-goog
Message-ID: <20251029005448.495880-1-isaacmanjarres@google.com>
Subject: [PATCH v1] audit: Improve path logging for unlinked files
From: "Isaac J. Manjarres" <isaacmanjarres@google.com>
To: Paul Moore <paul@paul-moore.com>, Eric Paris <eparis@redhat.com>
Cc: surenb@google.com, aliceryhl@google.com, tweek@google.com, 
	"Isaac J. Manjarres" <isaacmanjarres@google.com>, kernel-team@android.com, audit@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

When logging the path associated with a denial, the path is scanned
to ensure that it does not contain control characters, unprintable
characters, double quote marks, or spaces. If it does, the hexadecimal
representation of the path is emitted.

This can make debugging difficult in scenarios where the file name that
was given to the file does not contain any of those characters,
but the hexadecimal representation of the path is still emitted when a
denial occurs because the file is unlinked.

For example, suppose a memfd is created with the name "MemoryHeapBase".
Memfds are unlinked, so when a denial related to that memfd is
encountered, and the the path name for it is obtained via d_path(), the
name will be: "/memfd:MemoryHeapBase (deleted)". Since the name has a
space, the audit logic will just print the hexadecimal representation
instead of the name:

type=1400 audit(0.0:319): avc:  denied  { read write } for
path=2F6D656D66643A4D656D6F72794865617042617365202864656C6574656429
dev="tmpfs" ino=75 scontext=u:r:audioserver:s0
tcontext=u:object_r:system_server:s0 tclass=memfd_file permissive=0

To improve debuggability of denials related to unlinked files, check
if the " (deleted)" suffix is detected in a path name and remove it
if so. This allows the actual filename to be validated and emitted
if appropriate, making denials easier to read and more actionable:

type=1400 audit(0.0:254): avc:  denied  { read write } for
path="/memfd:MemoryHeapBase" dev="tmpfs" ino=67
scontext=u:r:audioserver:s0 tcontext=u:object_r:system_server:s0
tclass=memfd_file permissive=0

Signed-off-by: Isaac J. Manjarres <isaacmanjarres@google.com>
---
 kernel/audit.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/kernel/audit.c b/kernel/audit.c
index 26a332ffb1b8..dcfa60e0277d 100644
--- a/kernel/audit.c
+++ b/kernel/audit.c
@@ -2184,7 +2184,7 @@ void audit_log_untrustedstring(struct audit_buffer *ab, const char *string)
 void audit_log_d_path(struct audit_buffer *ab, const char *prefix,
 		      const struct path *path)
 {
-	char *p, *pathname;
+	char *p, *pathname, *suffix;
 
 	if (prefix)
 		audit_log_format(ab, "%s", prefix);
@@ -2199,8 +2199,20 @@ void audit_log_d_path(struct audit_buffer *ab, const char *prefix,
 	if (IS_ERR(p)) { /* Should never happen since we send PATH_MAX */
 		/* FIXME: can we save some information here? */
 		audit_log_format(ab, "\"<too_long>\"");
-	} else
+	} else {
+		/*
+		 * Terminate the buffer where the " (deleted)" suffix starts so
+		 * that audit_log_untrustedstring() emits the pathname,
+		 * assuming it doesn't have other control characters or spaces.
+		 */
+		suffix = strstr(p, " (deleted)");
+		/* Ensure the string ends with the " (deleted)" suffix. */
+		if (suffix &&
+		    ((p + strlen(p) - strlen(" (deleted)")) == suffix))
+			*suffix = '\0';
+
 		audit_log_untrustedstring(ab, p);
+	}
 	kfree(pathname);
 }
 
-- 
2.51.1.851.g4ebd6896fd-goog


