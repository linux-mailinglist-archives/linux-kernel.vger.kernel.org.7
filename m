Return-Path: <linux-kernel+bounces-833454-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 63823BA1FE0
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 01:45:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 13D1A563DEB
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 23:45:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 728AC2F0669;
	Thu, 25 Sep 2025 23:45:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wsUcBhCT"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C188C2E7F2A
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 23:45:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758843926; cv=none; b=XKGvCYHPCYn9sItjeyTtwZ8dHvSWSwMrXatZSg4FP4vFn9eiwRByuXIFPMEg3ZZu+y9EVQ76DfsiGhz/HkKAryomVcNL4xm17QEnnNke2EySMLsaXwBBc2p0ps376UMf8vm7xLuQUfxiGJDHbQJ6UGRWYIZEFSBFsYubtJ+aOEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758843926; c=relaxed/simple;
	bh=zc5PDYPZ7GdBtFvuYFvu8FWqBQP+b/s/g+l/C+lBL/A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fMBkul4IiTrZauqVGW/jqA6p+f4jhpLGhSSiUyR8mF4QWzgtWOPqrz0ZYMpP4J9fKEbqthiHs9yDQzqLtzb2G5jCCsQMkw2Oby+aorklwA6+09P9lHee7Fajw1ruYK+N9yL3suTAIwNVPwtanEeqfZZ7ca749O/lrwTnChEnOdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wsUcBhCT; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-46e32c0e273so15425e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 16:45:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758843923; x=1759448723; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ol0A50kwMXAn/GaWuyEx9F/yDfrD7aKDcgThOlWqa7k=;
        b=wsUcBhCT1oZnj1txTqtlOvc7p5CO0IqzefuZ3SyKFGLb2Eqt2VNb2dG9MkwTdnCX53
         tR0O+cujtfrqUMOWU8jdrMIFNJEkwhQwbqzp7T+tv4xolIG63GrS7xWPwgiyMgVttNbj
         IdifOcPEFLYeF2wNyJujtz91pbITuiA7EfeS/vFg4xxv5Ut6NHY3cmRRdGwJZlPVC11v
         dqe6PQBPzp7xPPQYYXAFTo/UGGpuTiaVIn2U26xbfIDUE+VhtnJnPA/UCq/nhaum3N9e
         za60WYQtM4ScgeNffqShIskHnVMdPuGqB0X3muKOPAhvCttX1DG4BCxyYDmAqahH+iz8
         HUYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758843923; x=1759448723;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ol0A50kwMXAn/GaWuyEx9F/yDfrD7aKDcgThOlWqa7k=;
        b=MaqfFb9zOPZ7Qs84RHCjxrm7P5xEpK5iGEMTOsxYdYYHTACe8/YH2lveWZwPVwtRw5
         G33YvvINggsLtkYoUlwvIFpSqYxJmUt3QQkrTB6DAu5JK8kZEhKZJPO5KqbVB3ydXC5Q
         Fam6Fvp3dYjFaXmz8GcaK6DRuZ4LnjvbqHd8II5adKrfEPBMmCnHKy66506EBZes7cro
         cuGYbp2p0HMr6ZJa0VOXbL6Wzkn+8MQRPyctac/avGpcYL9V64vqxyqZ/LK2g7yzjqIj
         7JiptTOqSb0vWTqIDCrNKCiHNnLJQRv3tGPJfGwObz3+vIuNpPl6e3PlglKo6u1quH2b
         6zjA==
X-Forwarded-Encrypted: i=1; AJvYcCVjb0iNyN4MGeUOtRn8+ckWE06B+hmyW1tkLFQheCWVs2U8f10gaf8VM3LPQXUEod8FMy2F+8ovJveBkr4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyN9S4iqkF8KnEnIEsMOyADq4yT4nUXOtq6jAQ/I+P/a7juhedn
	CMhm4kxv6Usd1uoiWLlL5+dJFL9BNQcdB7NLyvQf0Y6dSWiVe2S3KIzt+KXaLVw0hg==
X-Gm-Gg: ASbGncvfuTvoB2yk3D5OSt9yZLxxc2qpYeUU0Whnl1ICkkcj/rml+VVq8EX4JUVM7R9
	b1IJE9/z1n+MmHycxpGIXZmppbZ75OL3Nmb7yL+0LhQAKaoa3yLVEmiNjRNdFo2O43joH2EQGSq
	LTuPphtOEx/51oTq/8i4jp2xZmGt2z6BLStOBfBq7i2StvPEuznyUfUEYkUm3yBrt8dRugiMGsY
	hePnLAeKEhF07eBOKpf0RtT0w8smAshFjid3OF6jWZhUudXRm1FqLE9rYRTP3mc74rt+0jDWpL4
	33OzOVTVe/K7/Dkem31KBkngWQmyclNkNUqNB+wE1rul2oj+NsUHjBel6fHY58CnIwTK7zMG/eG
	Pth6KY9Hf/Tp7lDLrK4J2K8+V+c1l
X-Google-Smtp-Source: AGHT+IEeVIekGoQsa4rT2uNuLKasNfOTdtHTfwRcmmtPgJYSMssBKLy/KQ1C+vnJw/xi7QWtaEQg/w==
X-Received: by 2002:a05:600c:6219:b0:45f:2940:d194 with SMTP id 5b1f17b1804b1-46e3af7cb37mr783415e9.2.1758843922890;
        Thu, 25 Sep 2025 16:45:22 -0700 (PDT)
Received: from localhost ([2a00:79e0:9d:4:802b:ac1b:7bf0:4c9a])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-46e33be359dsm49540085e9.13.2025.09.25.16.45.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Sep 2025 16:45:22 -0700 (PDT)
From: Jann Horn <jannh@google.com>
Date: Fri, 26 Sep 2025 01:45:07 +0200
Subject: [PATCH 2/2] ima: add fs_subtype condition for distinguishing FUSE
 instances
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250926-ima-audit-v1-2-64d75fdc8fdc@google.com>
References: <20250926-ima-audit-v1-0-64d75fdc8fdc@google.com>
In-Reply-To: <20250926-ima-audit-v1-0-64d75fdc8fdc@google.com>
To: Mimi Zohar <zohar@linux.ibm.com>, 
 Roberto Sassu <roberto.sassu@huawei.com>, 
 Dmitry Kasatkin <dmitry.kasatkin@gmail.com>, 
 Eric Snowberg <eric.snowberg@oracle.com>
Cc: Frank Dinoff <fdinoff@google.com>, linux-kernel@vger.kernel.org, 
 linux-integrity@vger.kernel.org, Jann Horn <jannh@google.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1758843915; l=5956;
 i=jannh@google.com; s=20240730; h=from:subject:message-id;
 bh=zc5PDYPZ7GdBtFvuYFvu8FWqBQP+b/s/g+l/C+lBL/A=;
 b=I1cM55SBW7Rg1+33aO8Wo7b0pVoP0LwvprwmWHcQ9HccOEFM5xfURqglA10HBLMb4yAyj+/XM
 9/0Y5HO09OqCsOcWqz/AfcZloR9j8Iy1QjGxY7Wo9qM6pC/rT5mIg4K
X-Developer-Key: i=jannh@google.com; a=ed25519;
 pk=AljNtGOzXeF6khBXDJVVvwSEkVDGnnZZYqfWhP1V+C8=

Linux systems often use FUSE for several different purposes, where the
contents of some FUSE instances can be of more interest for auditing
than others.

Allow distinguishing between them based on the filesystem subtype
(s_subtype) using the new condition "fs_subtype".

The subtype string is supplied by userspace FUSE daemons
when a FUSE connection is initialized, so policy authors who want to
filter based on subtype need to ensure that FUSE mount operations are
sufficiently audited or restricted.

Signed-off-by: Jann Horn <jannh@google.com>
---
 Documentation/ABI/testing/ima_policy |  1 +
 security/integrity/ima/ima_policy.c  | 43 ++++++++++++++++++++++++++++++++----
 2 files changed, 40 insertions(+), 4 deletions(-)

diff --git a/Documentation/ABI/testing/ima_policy b/Documentation/ABI/testing/ima_policy
index 5d548dd2c6e7..d4b3696a9efb 100644
--- a/Documentation/ABI/testing/ima_policy
+++ b/Documentation/ABI/testing/ima_policy
@@ -23,6 +23,7 @@ Description:
 			  audit | dont_audit | hash | dont_hash
 		  condition:= base | lsm  [option]
 			base:	[[func=] [mask=] [fsmagic=] [fsuuid=] [fsname=]
+				[fs_subtype=]
 				[uid=] [euid=] [gid=] [egid=]
 				[fowner=] [fgroup=]]
 			lsm:	[[subj_user=] [subj_role=] [subj_type=]
diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
index c5bad3a0c43a..164d62832f8e 100644
--- a/security/integrity/ima/ima_policy.c
+++ b/security/integrity/ima/ima_policy.c
@@ -38,6 +38,7 @@
 #define IMA_GID		0x2000
 #define IMA_EGID	0x4000
 #define IMA_FGROUP	0x8000
+#define IMA_FS_SUBTYPE	0x10000
 
 #define UNKNOWN		0
 #define MEASURE		0x0001	/* same as IMA_MEASURE */
@@ -120,6 +121,7 @@ struct ima_rule_entry {
 		int type;	/* audit type */
 	} lsm[MAX_LSM_RULES];
 	char *fsname;
+	char *fs_subtype;
 	struct ima_rule_opt_list *keyrings; /* Measure keys added to these keyrings */
 	struct ima_rule_opt_list *label; /* Measure data grouped under this label */
 	struct ima_template_desc *template;
@@ -398,6 +400,7 @@ static void ima_free_rule(struct ima_rule_entry *entry)
 	 * the defined_templates list and cannot be freed here
 	 */
 	kfree(entry->fsname);
+	kfree(entry->fs_subtype);
 	ima_free_rule_opt_list(entry->keyrings);
 	ima_lsm_free_rule(entry);
 	kfree(entry);
@@ -602,6 +605,12 @@ static bool ima_match_rules(struct ima_rule_entry *rule,
 	if ((rule->flags & IMA_FSNAME)
 	    && strcmp(rule->fsname, inode->i_sb->s_type->name))
 		return false;
+	if (rule->flags & IMA_FS_SUBTYPE) {
+		if (!inode->i_sb->s_subtype)
+			return false;
+		if (strcmp(rule->fs_subtype, inode->i_sb->s_subtype))
+			return false;
+	}
 	if ((rule->flags & IMA_FSUUID) &&
 	    !uuid_equal(&rule->fsuuid, &inode->i_sb->s_uuid))
 		return false;
@@ -1068,7 +1077,7 @@ enum policy_opt {
 	Opt_audit, Opt_dont_audit, Opt_hash, Opt_dont_hash,
 	Opt_obj_user, Opt_obj_role, Opt_obj_type,
 	Opt_subj_user, Opt_subj_role, Opt_subj_type,
-	Opt_func, Opt_mask, Opt_fsmagic, Opt_fsname, Opt_fsuuid,
+	Opt_func, Opt_mask, Opt_fsmagic, Opt_fsname, Opt_fs_subtype, Opt_fsuuid,
 	Opt_uid_eq, Opt_euid_eq, Opt_gid_eq, Opt_egid_eq,
 	Opt_fowner_eq, Opt_fgroup_eq,
 	Opt_uid_gt, Opt_euid_gt, Opt_gid_gt, Opt_egid_gt,
@@ -1100,6 +1109,7 @@ static const match_table_t policy_tokens = {
 	{Opt_mask, "mask=%s"},
 	{Opt_fsmagic, "fsmagic=%s"},
 	{Opt_fsname, "fsname=%s"},
+	{Opt_fs_subtype, "fs_subtype=%s"},
 	{Opt_fsuuid, "fsuuid=%s"},
 	{Opt_uid_eq, "uid=%s"},
 	{Opt_euid_eq, "euid=%s"},
@@ -1284,7 +1294,8 @@ static bool ima_validate_rule(struct ima_rule_entry *entry)
 		if (entry->flags & ~(IMA_FUNC | IMA_MASK | IMA_FSMAGIC |
 				     IMA_UID | IMA_FOWNER | IMA_FSUUID |
 				     IMA_INMASK | IMA_EUID | IMA_PCR |
-				     IMA_FSNAME | IMA_GID | IMA_EGID |
+				     IMA_FSNAME | IMA_FS_SUBTYPE |
+				     IMA_GID | IMA_EGID |
 				     IMA_FGROUP | IMA_DIGSIG_REQUIRED |
 				     IMA_PERMIT_DIRECTIO | IMA_VALIDATE_ALGOS |
 				     IMA_CHECK_BLACKLIST | IMA_VERITY_REQUIRED))
@@ -1297,7 +1308,8 @@ static bool ima_validate_rule(struct ima_rule_entry *entry)
 		if (entry->flags & ~(IMA_FUNC | IMA_MASK | IMA_FSMAGIC |
 				     IMA_UID | IMA_FOWNER | IMA_FSUUID |
 				     IMA_INMASK | IMA_EUID | IMA_PCR |
-				     IMA_FSNAME | IMA_GID | IMA_EGID |
+				     IMA_FSNAME | IMA_FS_SUBTYPE |
+				     IMA_GID | IMA_EGID |
 				     IMA_FGROUP | IMA_DIGSIG_REQUIRED |
 				     IMA_PERMIT_DIRECTIO | IMA_MODSIG_ALLOWED |
 				     IMA_CHECK_BLACKLIST | IMA_VALIDATE_ALGOS))
@@ -1310,7 +1322,8 @@ static bool ima_validate_rule(struct ima_rule_entry *entry)
 
 		if (entry->flags & ~(IMA_FUNC | IMA_FSMAGIC | IMA_UID |
 				     IMA_FOWNER | IMA_FSUUID | IMA_EUID |
-				     IMA_PCR | IMA_FSNAME | IMA_GID | IMA_EGID |
+				     IMA_PCR | IMA_FSNAME | IMA_FS_SUBTYPE |
+				     IMA_GID | IMA_EGID |
 				     IMA_FGROUP))
 			return false;
 
@@ -1597,6 +1610,22 @@ static int ima_parse_rule(char *rule, struct ima_rule_entry *entry)
 			result = 0;
 			entry->flags |= IMA_FSNAME;
 			break;
+		case Opt_fs_subtype:
+			ima_log_string(ab, "fs_subtype", args[0].from);
+
+			if (entry->fs_subtype) {
+				result = -EINVAL;
+				break;
+			}
+
+			entry->fs_subtype = kstrdup(args[0].from, GFP_KERNEL);
+			if (!entry->fs_subtype) {
+				result = -ENOMEM;
+				break;
+			}
+			result = 0;
+			entry->flags |= IMA_FS_SUBTYPE;
+			break;
 		case Opt_keyrings:
 			ima_log_string(ab, "keyrings", args[0].from);
 
@@ -2145,6 +2174,12 @@ int ima_policy_show(struct seq_file *m, void *v)
 		seq_puts(m, " ");
 	}
 
+	if (entry->flags & IMA_FS_SUBTYPE) {
+		snprintf(tbuf, sizeof(tbuf), "%s", entry->fs_subtype);
+		seq_printf(m, pt(Opt_fs_subtype), tbuf);
+		seq_puts(m, " ");
+	}
+
 	if (entry->flags & IMA_KEYRINGS) {
 		seq_puts(m, "keyrings=");
 		ima_show_rule_opt_list(m, entry->keyrings);

-- 
2.51.0.536.g15c5d4f767-goog


