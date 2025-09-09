Return-Path: <linux-kernel+bounces-807138-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE927B4A093
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 06:20:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7458B4E59E8
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 04:20:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE69C2E0B42;
	Tue,  9 Sep 2025 04:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="itXIm1sE"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8519C2C3257
	for <linux-kernel@vger.kernel.org>; Tue,  9 Sep 2025 04:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757391604; cv=none; b=iKSPVa3VllbBjK/p24+BRlRd8yO/uqvUMQw3Clfe8NtI+X7pOqvpt43g9d70YWtX6y6J8z+wl8Yzl8HctBE+n2r3zqLOewmbP8w7pSvdi6F6fAHOtSGqKexInz0TWIqv9KDpPbh6tK/8y78DE3jBVZxikKWa9hxahOfp65gunao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757391604; c=relaxed/simple;
	bh=kcJMNEpEeX4hcspzTai+arozdN7w9isGuN5jMeekjZA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bU8vNoITC9HhVj+I8G+u3hIeD1b1GzD/zzC0TZiiqb05y19Eyva+mEaKY0Y6eQ8Fm862l1kzq2t+bgGPJtuTb9nqLkOqjGav88IA7z7NXh3Xoe4CxRWsDam93xfBfKKzSKQC6fH4ouCIYKFDEhMGFvCyVjhYrOFFF27l7a9E48M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=itXIm1sE; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757391601;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=54MsxNCmmlAlcM5f+BHWGLYP6L+NuEk1hd/wbu7HmzE=;
	b=itXIm1sE7Wsw/T2sTwg/lSrMp/cna6MZ6tO99hGCLeKLgDiZa0h8ViBIHN9OTqPYhaY+XN
	7YH1Cpms3ATfLvMvR891g/PfovoJNaYois9xQwHk8WcHebT8tDaSaW7b2wJxYQTVKSpG4L
	UKV268n7sCZLGvMczUD5jliuPL8EPGU=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-124-fzgyxxnUM6y8jucEf5fBSA-1; Tue, 09 Sep 2025 00:19:59 -0400
X-MC-Unique: fzgyxxnUM6y8jucEf5fBSA-1
X-Mimecast-MFC-AGG-ID: fzgyxxnUM6y8jucEf5fBSA_1757391598
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-b47630f9aa7so4107305a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 08 Sep 2025 21:19:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757391598; x=1757996398;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=54MsxNCmmlAlcM5f+BHWGLYP6L+NuEk1hd/wbu7HmzE=;
        b=C0nrPCezHr77+89n6fkh2yd+tx3LLJbjOsbrCU4MOmbbC2z8LZ1QCI1f2KMgoFIbCo
         ZKyuDBiQicFGT8Kf0Yrg3NALglJOC1pdNxSi3geSSQqk3X7qYHaSZSyKeen1GlGiaIbg
         78qf4LYUfWGvP5JGuYtAH4OAyIJDnM653v1KLo7vQgiBXog3zy9SVuSEFhdlIzqj7AHx
         P9PjZBnPIWVCoii4t8gHbTkTJ5knFYvf1Qk5C7A93Azi+7ce20c0UHzE/bhcE45PuEXr
         a2J0YhuIuOVVIGwEDLxlrktai0xbLBw8X8tnJ5RCydZEbKT5y9npPW/4rAo8VhhvqEJf
         yuOg==
X-Forwarded-Encrypted: i=1; AJvYcCVl2eVce3GdRiwv1QbosGTWFeEZoBQlJgl2AbgcazL35n4/IS7l1f7khULUGrThThahLPtPP1N5vifpUXQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YymQicst4nwANzy4jUhVR9Ukj98jYhS+enlIUbyDM6S5RMOB//H
	F4LVZCCPnrba6v6atFWax+6RPsfkBshkMqpOeyXNDPSGsGxZ4p6cSh2d85Ocl32ps+ERw70TbLN
	KuqKwcNBaUEyoIILm3zr68uIBpKv5IfR3F5b8EuIwgOnxVC+gaTnsv9dA4blUx4kBUg==
X-Gm-Gg: ASbGncuf5KNeFTdeKAfur8MCti303gVNVbT9ZTNkEojR4e+Bz8GFPtuZMTVfkgd1Azz
	d7kQzV2TwvOQ7m9z/GQC2ywChTWJOSBnPNvja4zhPa277+JfBRWcLFBuCwU6hrp1fwvE98YsljW
	Nkpl9wPf1WrbRUDkavEvVTcJoTm5/wRv2VdopHnrPf6CZp/cZ6pssd9PNclp7t9rM71/CgKpypJ
	WBDEjUkrrSdM6LB5xwlo7xng52IsR57u0wIFYCUmG507Gmxm8zYGfFy4M4hBgGIEvapF0/AsQru
	5bIRNWI85HG2WvcIjkuEC1knjeVc/04=
X-Received: by 2002:a17:903:b0e:b0:258:fa62:ab17 with SMTP id d9443c01a7336-258fa62ac03mr15850375ad.29.1757391598385;
        Mon, 08 Sep 2025 21:19:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEv36p9UxA54Z3porfTlTxG7LAGzqKIDTmwybjkcWmGH9oQOVl5p8+shON8WpdrhlHXD9O2lQ==
X-Received: by 2002:a17:903:b0e:b0:258:fa62:ab17 with SMTP id d9443c01a7336-258fa62ac03mr15850235ad.29.1757391597940;
        Mon, 08 Sep 2025 21:19:57 -0700 (PDT)
Received: from localhost ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-24c9952bccasm157077385ad.105.2025.09.08.21.19.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Sep 2025 21:19:57 -0700 (PDT)
From: Coiby Xu <coxu@redhat.com>
To: linux-integrity@vger.kernel.org
Cc: Mimi Zohar <zohar@linux.ibm.com>,
	Roberto Sassu <roberto.sassu@huawei.com>,
	Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
	Eric Snowberg <eric.snowberg@oracle.com>,
	Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	linux-security-module@vger.kernel.org (open list:SECURITY SUBSYSTEM),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] ima: setting security.ima to fix security.evm for a file with IMA signature
Date: Tue,  9 Sep 2025 12:19:53 +0800
Message-ID: <20250909041954.1626914-1-coxu@redhat.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When both IMA and EVM fix modes are enabled, accessing a file with IMA
signature won't cause security.evm to be fixed. But this doesn't happen
to a file with correct IMA hash already set because accessing it will
cause setting security.ima again which triggers fixing security.evm
thanks to security_inode_post_setxattr->evm_update_evmxattr.

Let's use the same mechanism to fix security.evm for a file with IMA
signature.

Signed-off-by: Coiby Xu <coxu@redhat.com>
---
 security/integrity/ima/ima_appraise.c | 27 +++++++++++++++++++++------
 1 file changed, 21 insertions(+), 6 deletions(-)

diff --git a/security/integrity/ima/ima_appraise.c b/security/integrity/ima/ima_appraise.c
index f435eff4667f..18c3907c5e44 100644
--- a/security/integrity/ima/ima_appraise.c
+++ b/security/integrity/ima/ima_appraise.c
@@ -595,12 +595,27 @@ int ima_appraise_measurement(enum ima_hooks func, struct ima_iint_cache *iint,
 		integrity_audit_msg(audit_msgno, inode, filename,
 				    op, cause, rc, 0);
 	} else if (status != INTEGRITY_PASS) {
-		/* Fix mode, but don't replace file signatures. */
-		if ((ima_appraise & IMA_APPRAISE_FIX) && !try_modsig &&
-		    (!xattr_value ||
-		     xattr_value->type != EVM_IMA_XATTR_DIGSIG)) {
-			if (!ima_fix_xattr(dentry, iint))
-				status = INTEGRITY_PASS;
+		/*
+		 * Fix mode, but don't replace file signatures.
+		 *
+		 * When EVM fix mode is also enabled, security.evm will be
+		 * fixed automatically when security.ima is set because of
+		 * security_inode_post_setxattr->evm_update_evmxattr.
+		 */
+		if ((ima_appraise & IMA_APPRAISE_FIX) && !try_modsig) {
+			if (!xattr_value ||
+			    xattr_value->type != EVM_IMA_XATTR_DIGSIG) {
+				if (ima_fix_xattr(dentry, iint))
+					status = INTEGRITY_PASS;
+			} else if (xattr_value->type == EVM_IMA_XATTR_DIGSIG &&
+				   evm_revalidate_status(XATTR_NAME_IMA)) {
+				if (!__vfs_setxattr_noperm(&nop_mnt_idmap,
+							   dentry,
+							   XATTR_NAME_IMA,
+							   xattr_value,
+							   xattr_len, 0))
+					status = INTEGRITY_PASS;
+			}
 		}
 
 		/*

base-commit: b320789d6883cc00ac78ce83bccbfe7ed58afcf0
-- 
2.51.0


