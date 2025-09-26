Return-Path: <linux-kernel+bounces-833453-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BFFB1BA1FDA
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 01:45:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8D57B1C04526
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 23:45:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5520F2EF67A;
	Thu, 25 Sep 2025 23:45:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FVBmFKgR"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA20B78F39
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 23:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758843925; cv=none; b=lcdccUYFubPjyq1sxDJ31lRbeO57R8SrIR6A7k/99GOou32qvCaxYJZY2bAv6cA/QX827B1egkIr5KPfjMYqKm4hSMkdZ7oxmiGwiFpnbRjTfjcaApstai8vynV3Hwsir+XQRYVi+Cd1Hora9gnlEqZuSEiQdHxrVGra1GCMKkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758843925; c=relaxed/simple;
	bh=qnzcSqkrw05lFjyonOVGGDH1fyI94qn3kHI5lWyeGfs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Jj0+DzhI5MSbSoHtdPmu+ljZp8cvm4P9OnweSgQZuu44QxgedcueHm+RC+tZrrR2lNYY7ON9ggatUJDAPCY2QsuhIimNEzXegcxOIlljXUxkrNCA79vGHf2LnZisJZ82Bs8WVvmy4YoK4GzdHsWDaEOpkhade+G7eSY+Rw0ICnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FVBmFKgR; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-45f2f894632so30275e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 16:45:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758843922; x=1759448722; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=k+/60p2igLHxhXduVxBRgrzlVIOHLKXxhij7umLu7HU=;
        b=FVBmFKgRSiWKavs2FK96pagDgBR8GumPp2+fIA8XIZLeZPfVIePvH5Rh/PVP5x8BJw
         Ynu5PduS16zDXWaqrAne10hoA3xYNg3WzQ6JpY1D9nXe2VgPZ3VE3OKiLDf8GSrM8deq
         jIuI4vdBDLsvX9tVR+5vYQTHvsHztb0m17LszZn8Qq2mykvOmz79ijXophDnKHGU6q72
         XT0l0qxonGCsJIl/beLXB9rRAsWqn6a9CvL+Pnxejz2zRFSvwEXdhF23u5oWeGsPI2qQ
         rvrS+fjfLlXFDVsS9McT9KNk/Jrkq7sd3ufIU/linVb7UInLmM0IuVBeu6IUgH2Fb+6Q
         LCOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758843922; x=1759448722;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k+/60p2igLHxhXduVxBRgrzlVIOHLKXxhij7umLu7HU=;
        b=PzncXZbMUaZEgY9BHGIwSodyRWcd//pZw1aCNPTbCoDfwxpWECjLjytnbV67q5TwW8
         Qr8RX4cjLJuCFuVHspUT7O6Qh6r+fdDir7aQ+4Ej1kTcFIYfAolpG8Uq8Pw+Vh2LTGJ5
         r+3C9an8lgZlgTesgf2uhJVr/URLRiGhLWsnctHY8ox2t2YNgdJz6n+22goTG4QP17KA
         CEjA0JwIkEw7Gx3hK+RDbiiPERKhCuctqQyzxsg1caEH2tgk0wdMiA4w/ECLIky0pH2R
         KbXqMyrcPV2eM1l0+f+hMms/cFoj2a192hWddgQ8wh06uQ7hUMwW1tGXBIs572Pjf92r
         h7VQ==
X-Forwarded-Encrypted: i=1; AJvYcCVF2kTW/l8CqC5qaKHYq0nwkcVLOwCvVEt3Px2q9kH+PU22isLWcVimxYo7siaSQo2Yrj9juxSx7rJuK/0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyKhwIYUgKgVuNRQRTSZ3b6AsMyESWCT2ggPpg39BzSS1AWaGBL
	tsHBW47wnwTaA+7+A0KrIUHBq1k/LVJY2Y9XWVlrs8+aFJG8UOB26EzeURsBiCmWFg==
X-Gm-Gg: ASbGncsYrj6UIvC2hU0TFPL2v3W4HCAn7Ux2Zuc07jvwGRidPLbtBFkbW3sCZ9a4NPT
	LeYuN4e8gEfovngzh9vEiglbQvQqlmkXArZITQXkpWUQL/Le75woGNw6ABp3x/zVDCEvnVCfeiC
	4xLWim8xfCD5k3F1IwNDIuOqo4SvBsabjgCs++iMwJOmBI0jpjKycdG+sJNJJKHWENzYACXGNnA
	MbZXbTgX4iUEXzgvFW60lv/9ZDbfXkVjKRc3NZTMOX10Uh+qIVNg8VODbveKWVMQ4fUI2NboM5T
	ZA+wiN4y3xRb+lCXFHb/5Rpjvt3iP7xalQf5KwGgSrjge4q1EuKgmXNuxDx4dqeYPR9xKaQgAk8
	DsyGRhw11KMxkOfV0cbZGduta22w=
X-Google-Smtp-Source: AGHT+IEI1KfavPKBZUkfMpl0ut11FyDudWgx4jPvjefzfrIyZcrrL6+wiJ9w8Z8vTR/+ZXY7evgJfw==
X-Received: by 2002:a05:600c:c112:b0:45a:2861:3625 with SMTP id 5b1f17b1804b1-46e3b014890mr435905e9.4.1758843921935;
        Thu, 25 Sep 2025 16:45:21 -0700 (PDT)
Received: from localhost ([2a00:79e0:9d:4:802b:ac1b:7bf0:4c9a])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-40fc88b0779sm4547044f8f.58.2025.09.25.16.45.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Sep 2025 16:45:21 -0700 (PDT)
From: Jann Horn <jannh@google.com>
Date: Fri, 26 Sep 2025 01:45:06 +0200
Subject: [PATCH 1/2] ima: add dont_audit action to suppress audit actions
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250926-ima-audit-v1-1-64d75fdc8fdc@google.com>
References: <20250926-ima-audit-v1-0-64d75fdc8fdc@google.com>
In-Reply-To: <20250926-ima-audit-v1-0-64d75fdc8fdc@google.com>
To: Mimi Zohar <zohar@linux.ibm.com>, 
 Roberto Sassu <roberto.sassu@huawei.com>, 
 Dmitry Kasatkin <dmitry.kasatkin@gmail.com>, 
 Eric Snowberg <eric.snowberg@oracle.com>
Cc: Frank Dinoff <fdinoff@google.com>, linux-kernel@vger.kernel.org, 
 linux-integrity@vger.kernel.org, Jann Horn <jannh@google.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1758843915; l=3033;
 i=jannh@google.com; s=20240730; h=from:subject:message-id;
 bh=qnzcSqkrw05lFjyonOVGGDH1fyI94qn3kHI5lWyeGfs=;
 b=WpV3JAso+B4JtzmfkpfNA6IW1wg12HJNMo/QnUy96JxFE53vQ9eNMALgdy1bT0bXMVr2BW2ZV
 wsPqi/reRJdCOjebvufGVMmZ9JHjorJ6xo4ejdgDnRMzlgtJ0RNJYVq
X-Developer-Key: i=jannh@google.com; a=ed25519;
 pk=AljNtGOzXeF6khBXDJVVvwSEkVDGnnZZYqfWhP1V+C8=

"measure", "appraise" and "hash" actions all have corresponding "dont_*"
actions, but "audit" currently lacks that. This means it is not
currently possible to have a policy that audits everything by default,
but excludes specific cases.

This seems to have been an oversight back when the "audit" action was
added.

Add a corresponding "dont_audit" action to enable such uses.

Signed-off-by: Jann Horn <jannh@google.com>
---
 Documentation/ABI/testing/ima_policy |  2 +-
 security/integrity/ima/ima_policy.c  | 14 +++++++++++++-
 2 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/Documentation/ABI/testing/ima_policy b/Documentation/ABI/testing/ima_policy
index c2385183826c..5d548dd2c6e7 100644
--- a/Documentation/ABI/testing/ima_policy
+++ b/Documentation/ABI/testing/ima_policy
@@ -20,7 +20,7 @@ Description:
 		  rule format: action [condition ...]
 
 		  action: measure | dont_measure | appraise | dont_appraise |
-			  audit | hash | dont_hash
+			  audit | dont_audit | hash | dont_hash
 		  condition:= base | lsm  [option]
 			base:	[[func=] [mask=] [fsmagic=] [fsuuid=] [fsname=]
 				[uid=] [euid=] [gid=] [egid=]
diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
index 128fab897930..c5bad3a0c43a 100644
--- a/security/integrity/ima/ima_policy.c
+++ b/security/integrity/ima/ima_policy.c
@@ -45,6 +45,7 @@
 #define APPRAISE	0x0004	/* same as IMA_APPRAISE */
 #define DONT_APPRAISE	0x0008
 #define AUDIT		0x0040
+#define DONT_AUDIT	0x0080
 #define HASH		0x0100
 #define DONT_HASH	0x0200
 
@@ -1064,7 +1065,7 @@ void ima_update_policy(void)
 enum policy_opt {
 	Opt_measure, Opt_dont_measure,
 	Opt_appraise, Opt_dont_appraise,
-	Opt_audit, Opt_hash, Opt_dont_hash,
+	Opt_audit, Opt_dont_audit, Opt_hash, Opt_dont_hash,
 	Opt_obj_user, Opt_obj_role, Opt_obj_type,
 	Opt_subj_user, Opt_subj_role, Opt_subj_type,
 	Opt_func, Opt_mask, Opt_fsmagic, Opt_fsname, Opt_fsuuid,
@@ -1086,6 +1087,7 @@ static const match_table_t policy_tokens = {
 	{Opt_appraise, "appraise"},
 	{Opt_dont_appraise, "dont_appraise"},
 	{Opt_audit, "audit"},
+	{Opt_dont_audit, "dont_audit"},
 	{Opt_hash, "hash"},
 	{Opt_dont_hash, "dont_hash"},
 	{Opt_obj_user, "obj_user=%s"},
@@ -1478,6 +1480,14 @@ static int ima_parse_rule(char *rule, struct ima_rule_entry *entry)
 
 			entry->action = AUDIT;
 			break;
+		case Opt_dont_audit:
+			ima_log_string(ab, "action", "dont_audit");
+
+			if (entry->action != UNKNOWN)
+				result = -EINVAL;
+
+			entry->action = DONT_AUDIT;
+			break;
 		case Opt_hash:
 			ima_log_string(ab, "action", "hash");
 
@@ -2097,6 +2107,8 @@ int ima_policy_show(struct seq_file *m, void *v)
 		seq_puts(m, pt(Opt_dont_appraise));
 	if (entry->action & AUDIT)
 		seq_puts(m, pt(Opt_audit));
+	if (entry->action & DONT_AUDIT)
+		seq_puts(m, pt(Opt_dont_audit));
 	if (entry->action & HASH)
 		seq_puts(m, pt(Opt_hash));
 	if (entry->action & DONT_HASH)

-- 
2.51.0.536.g15c5d4f767-goog


