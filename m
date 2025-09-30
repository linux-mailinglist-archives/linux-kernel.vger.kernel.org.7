Return-Path: <linux-kernel+bounces-836962-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CD8D4BAAFD9
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 04:27:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0B2F4189DD52
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 02:27:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E411221F11;
	Tue, 30 Sep 2025 02:27:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MQrjQbgz"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0202F21B9C1
	for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 02:27:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759199231; cv=none; b=CI7d28dy212Wmvq08jzJbGxRWXBiLhp6+mI6fVmWwh14TZbvU3IVwFbasP9eWbYkoG6g/TUBx95xOpjEI5WEY4vqtkvalDiPIYDwt+5iluG5nTTfGWLBVUJlTQPIVve7HlBQdkZpqMxIwl1DHM6Q0/U52jeDDBL+i+jka57sONg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759199231; c=relaxed/simple;
	bh=6RVM/NL0ZDYk67kJzkhFeoTVqrVSQZgDBYioTsdcFlc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=I2/BbiIvHNm/GPjCbu8ZwJY+Hs9BJzEtQrZUFxFjqnjh/acZ+FrupZwLJ/LF1N+3K+GT7xP7dTbiMHyTmnRj7Sxlcu5lVZsUScNnR7PUWYqnMA1tNnK+Tl398c2p60zUoWBfsE1Kx/DT/oUnGVRcwWZ+w4MDP6aC/VrBVbiphDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MQrjQbgz; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759199228;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=sg4kvyN9cH3Ka6BbQeKrM7RCNfTYVS9zo7EtNkElASs=;
	b=MQrjQbgz2MzxglUQ2WnBL1vkUXQnDC5hqPqa10VZrjTQentXGsTYPT/niM44re1yUqPbNb
	tSiAwsN2kHPQSlTeu7zFtkPp8pfjXj3KwG7v/gDta5oqGSBTsSXTaCyTWRbzt+JUiXahvT
	opNDhZ6hhopCS0Fuk4Et11a+83LotSU=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-580-m2FuElu9N_WVxbe70ECb6g-1; Mon, 29 Sep 2025 22:27:04 -0400
X-MC-Unique: m2FuElu9N_WVxbe70ECb6g-1
X-Mimecast-MFC-AGG-ID: m2FuElu9N_WVxbe70ECb6g_1759199223
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-b5b3715102fso1605973a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 19:27:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759199223; x=1759804023;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sg4kvyN9cH3Ka6BbQeKrM7RCNfTYVS9zo7EtNkElASs=;
        b=By3o9M/FZuPct6L6BvhP1f2w1GvEQVVbq48Zd2CgWX8NqWPxX5NPPAoop+s03v8rz2
         iQwwYpgKJBdUlLXEC2X76SvEWKVeu/wdid1nWU1yLlpYtcW1jSpu6rGIUuHtmnDTJaXw
         gm7hb8HEz4oyhOCYbT7vIlOYmOUKtZOJ9nqWpCS7Y+QZaD5q1H6wBkjsxf30KtXYw0Lq
         pKakykbWN8UABg13vgEuo7luS9PhSuG3irFwGekHIIqh6TcaMmI7YjhvE9rKilOwV7Qr
         GEqGURYouBu2dM2A2AzJR5/QyVRItN0cHxhi/f460aSkQ42wPnGKLW37vVcQjug8i8kR
         3Qwg==
X-Forwarded-Encrypted: i=1; AJvYcCUKF+goorLe31iheO2ytvQ2Yf7NOMQxC8Q+I1I+lQirag8x/y0p+hm5fwq+6jcSWUNsuRxuGsfCLqEg1FE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxCV4j1+AeBd+ZssCB97lqGKg9bK/26R6fWuFEmiJ4YJuAsoOX4
	/RePlkLaqSQOCQ2KEFnjlpeJROQd41F4xoFErewEhnnIm37VAqUNyzrUZn9SJRieuvdHIEeDqp6
	9uYKCPYPl3lHFre2MpjWb3dJQ7DB1nHrcU7BioRGLM45np2EI9qIXvbxtNdymKNrgFw==
X-Gm-Gg: ASbGncv3pGEXxWxJDXEwzpewllQ33rIb3k1FHQMXQlPTG0leor10AW3YQU1qR+30tMF
	haPlpQbvztI7fOHXAExLuayQm+dbaLHC4CZ0rkGEwM7JQhYLp6EN/e8lT5dZ0U6HLjQrNlUH8Bn
	ssbqnUfA6OzroGTacq+LT3El7frKNr7YmZy680Nix9ErNlqq0PWa+p0zyW/pEUWSW2qfj/bKaVZ
	48hGFrY+ICtAkOqg0xvQROHbgHISqKk9SF0bhMhEPFiM5UaOiFSZGVMLyh7hcNhyzUTRLk1Y9C+
	p86wYwU6wAhtYEtKXwLB3gdSKw4inr9Lp0+E
X-Received: by 2002:a17:903:2448:b0:278:f46b:d49c with SMTP id d9443c01a7336-28d16e88acamr27573255ad.9.1759199222954;
        Mon, 29 Sep 2025 19:27:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGw7cypH/nZLG0Swdh9MGBzOSAdgylrCMgf2ZcGSHw42AyW3kmcjyYfNc4ncFIysi/zvSQhvg==
X-Received: by 2002:a17:903:2448:b0:278:f46b:d49c with SMTP id d9443c01a7336-28d16e88acamr27572975ad.9.1759199222299;
        Mon, 29 Sep 2025 19:27:02 -0700 (PDT)
Received: from localhost ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-27ed69bd869sm145301875ad.120.2025.09.29.19.27.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Sep 2025 19:27:02 -0700 (PDT)
From: Coiby Xu <coxu@redhat.com>
To: linux-integrity@vger.kernel.org,
	Mimi Zohar <zohar@linux.ibm.com>
Cc: Roberto Sassu <roberto.sassu@huawei.com>,
	Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
	Eric Snowberg <eric.snowberg@oracle.com>,
	Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	linux-kernel@vger.kernel.org (open list),
	linux-security-module@vger.kernel.org (open list:SECURITY SUBSYSTEM)
Subject: [PATCH v2 1/2] evm: fix security.evm for a file with IMA signature
Date: Tue, 30 Sep 2025 10:26:56 +0800
Message-ID: <20250930022658.4033410-1-coxu@redhat.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When both IMA and EVM fix modes are enabled, accessing a file with IMA
signature but missing EVM HMAC won't cause security.evm to be fixed.

Add a function evm_fix_hmac which will be explicitly called to fix EVM
HMAC for this case.

Suggested-by: Mimi Zohar <zohar@linux.ibm.com>
Signed-off-by: Coiby Xu <coxu@redhat.com>
---
 include/linux/evm.h                   |  8 ++++++++
 security/integrity/evm/evm_main.c     | 28 +++++++++++++++++++++++++++
 security/integrity/ima/ima_appraise.c |  5 +++++
 3 files changed, 41 insertions(+)

diff --git a/include/linux/evm.h b/include/linux/evm.h
index ddece4a6b25d..913f4573b203 100644
--- a/include/linux/evm.h
+++ b/include/linux/evm.h
@@ -18,6 +18,8 @@ extern enum integrity_status evm_verifyxattr(struct dentry *dentry,
 					     const char *xattr_name,
 					     void *xattr_value,
 					     size_t xattr_value_len);
+int evm_fix_hmac(struct dentry *dentry, const char *xattr_name,
+		 const char *xattr_value, size_t xattr_value_len);
 int evm_inode_init_security(struct inode *inode, struct inode *dir,
 			    const struct qstr *qstr, struct xattr *xattrs,
 			    int *xattr_count);
@@ -51,6 +53,12 @@ static inline enum integrity_status evm_verifyxattr(struct dentry *dentry,
 {
 	return INTEGRITY_UNKNOWN;
 }
+
+static inline int evm_fix_hmac(struct dentry *dentry, const char *xattr_name,
+			       const char *xattr_value, size_t xattr_value_len)
+{
+	return -EOPNOTSUPP;
+}
 #endif
 
 static inline int evm_inode_init_security(struct inode *inode, struct inode *dir,
diff --git a/security/integrity/evm/evm_main.c b/security/integrity/evm/evm_main.c
index 0add782e73ba..1b3edc6d26e9 100644
--- a/security/integrity/evm/evm_main.c
+++ b/security/integrity/evm/evm_main.c
@@ -787,6 +787,34 @@ bool evm_revalidate_status(const char *xattr_name)
 	return true;
 }
 
+/**
+ * evm_fix_hmac - Calculate the HMAC and add it to security.evm for fix mode
+ * @dentry: pointer to the affected dentry which doesn't yet have security.evm
+ *          xattr
+ * @xattr_name: pointer to the affected extended attribute name
+ * @xattr_value: pointer to the new extended attribute value
+ * @xattr_value_len: pointer to the new extended attribute value length
+ *
+ * Expects to be called with i_mutex locked.
+ *
+ * Return: 0 on success, -EPERM/-ENOMEM/-EOPNOTSUPP on failure
+ */
+int evm_fix_hmac(struct dentry *dentry, const char *xattr_name,
+		 const char *xattr_value, size_t xattr_value_len)
+
+{
+	if (!evm_fixmode || !evm_revalidate_status((xattr_name)))
+		return -EPERM;
+
+	if (!(evm_initialized & EVM_INIT_HMAC))
+		return -EPERM;
+
+	if (is_unsupported_hmac_fs(dentry))
+		return -EOPNOTSUPP;
+
+	return evm_update_evmxattr(dentry, xattr_name, xattr_value, xattr_value_len);
+}
+
 /**
  * evm_inode_post_setxattr - update 'security.evm' to reflect the changes
  * @dentry: pointer to the affected dentry
diff --git a/security/integrity/ima/ima_appraise.c b/security/integrity/ima/ima_appraise.c
index f435eff4667f..f48ef5ec185e 100644
--- a/security/integrity/ima/ima_appraise.c
+++ b/security/integrity/ima/ima_appraise.c
@@ -601,6 +601,11 @@ int ima_appraise_measurement(enum ima_hooks func, struct ima_iint_cache *iint,
 		     xattr_value->type != EVM_IMA_XATTR_DIGSIG)) {
 			if (!ima_fix_xattr(dentry, iint))
 				status = INTEGRITY_PASS;
+		} else if (status == INTEGRITY_NOLABEL) {
+			if (!evm_fix_hmac(dentry, XATTR_NAME_IMA,
+					  (const char *)xattr_value,
+					  xattr_len))
+				status = INTEGRITY_PASS;
 		}
 
 		/*

base-commit: e129e479f2e444eaccd822717d418119d39d3d5c
-- 
2.51.0


