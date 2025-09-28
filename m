Return-Path: <linux-kernel+bounces-835161-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D8DABA66A8
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Sep 2025 05:04:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BBFB117D5EB
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Sep 2025 03:04:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E9B91B423B;
	Sun, 28 Sep 2025 03:04:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aPZbDQpD"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0F0A17BA6
	for <linux-kernel@vger.kernel.org>; Sun, 28 Sep 2025 03:04:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759028648; cv=none; b=nuvunClGyTBnE9JB8lCDN8Ma+buF2hdKJj1++QRWTsyIh0Jo5T+i67nKU4FnXjmSVl7+Q6GJ/58+fqvmXMTMu0lZtt7kwSstLSFijNcdbygKBRBK0EqxepeYMW0ab1p8tkpexZ6vJMYDFRUf1ILQmRSv9+36b7kdvJSRKI7JG1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759028648; c=relaxed/simple;
	bh=VBcvsRhMgO/muYeWFgejs0y+LouNQ+vYo1QbX/Y+XRk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hqcDo1LgqMN4xptvKD1cCYj/fUkKOFUzAuuD9/fdCSZtpynlfsiXMZvfAzEcWBGzfE5UYSobUlDT/71miqMb9Oy/E7Auy4WJoErm/qoShkE4Wen3iOzJeMCDRfV7UjMe09j4sumHBkLgHR2dJHS2Rc1QwNMrTvt7aiRPUuXTXFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aPZbDQpD; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759028645;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=qEw52ze8SdcNH5GneUi5j01Dzu2Pu+0KVOCFzVwvrUY=;
	b=aPZbDQpDuvGV3cRuM4W5lURdNVxNcz0h6czpLBYeD4vL40WMCijfg9dQD3ICZvcsSR+EVR
	a9XVnI3TiVvJ9RFiZT5ynnHAYR3bgbYMuuGVULswKXqNxt74hiH+icPB+LTKLdugjicgqz
	TAzDTshX5oGfOokwAUc53VWZ/fAhK5c=
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-103-_7LX6C8dPhm3-GuW6LYQJA-1; Sat, 27 Sep 2025 23:04:03 -0400
X-MC-Unique: _7LX6C8dPhm3-GuW6LYQJA-1
X-Mimecast-MFC-AGG-ID: _7LX6C8dPhm3-GuW6LYQJA_1759028643
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-7810e5a22f3so4111944b3a.1
        for <linux-kernel@vger.kernel.org>; Sat, 27 Sep 2025 20:04:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759028643; x=1759633443;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qEw52ze8SdcNH5GneUi5j01Dzu2Pu+0KVOCFzVwvrUY=;
        b=ksztIGQ6K+8tD8S4amleH0Yx1j7irT4Cj8nYwUGFfDQFivJowC5EsiB/o3yPKukkj9
         5Ya4QQJZiCDHikn0koqDhkrYd76P7somvGqWdtYYKcWrgGkxx6n/Sut/fgBc2P/JPkpA
         HJTBR3FEWxquyyiTiv/T75+W7YBroZa3WWJEpKPcy1aVGkvdqFPJ/VHGB6a1rJyz/x7p
         GKCQ73xsbJqcp7Af3UCH4jXOaQSyLAKyttxOKO5TJbvoFLxcA/PhlyRNkrQFSrlSgXZU
         fZIq4xgENDFvZIV5MN/QFkNnQbuqK+Vg0EwEpUgTpzOIG1fFPaOSzcokYXFnLFv/lCEb
         e9DA==
X-Forwarded-Encrypted: i=1; AJvYcCWOjAxUCSKIOl82pXwbNyP7l3WBwpoXK9LRsuwpmMf7lqUUvRg4zzuy/iHTo9D0OevERJEuNuxCpDIC08M=@vger.kernel.org
X-Gm-Message-State: AOJu0YwXlqlZOQb4r5Ri3ONf5Ai4tep5Nqr6DqfyOj9GKkhbyzcgTR8v
	mBeVcYQw4A5unOFDHba23/4tK/9bQQ53prwdGRJeu0XAmgSQ59tLaQLhhsHeIcd2fcqyFm9dgkg
	C2XiGlTziKm9lFT5cusrs/aAILm2qd2sj21N8elCzxyQLPkUxz+UwogAnI7gm/DdT9/QozlvOmp
	96
X-Gm-Gg: ASbGnctLlRaofeve/tRmfQtnzYDoiirAfqeJlfTd96SaTwHMin7CUzhgDp0aRzNTsSQ
	S7rsMWnkhtgUublhKiQsBoUeAjbZyezXRKp0/TkOu9LEWibO8rj3v/sku+JJYK5+GjKfZ+sJ4J+
	qPVrZ4uDHyVaa1/Y49IqfaMMQur9hSys9MZz0kMk9Jsq3tjVUMaCdhdmdCEWuie6DXqCyPzIEIF
	R8J4bwk2yrIlKbNlez5ST+Rs/2yOL3iV2V6mNzCI4ZGSDQ8GiHP9i7EqXjg7KOhRG1lCF/wwdio
	Z+mQY8utOVCM7MvFV7x51zp8xXISGbo=
X-Received: by 2002:a05:6a00:8d6:b0:771:e4c6:10cc with SMTP id d2e1a72fcca58-780fcdd2cb1mr13863863b3a.6.1759028642772;
        Sat, 27 Sep 2025 20:04:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGrlGFESxb4zyWUKxHw78NUwK96T66HWHGPWOIZ8CPuMROnTHK9D2/BRaau3akM7vrrkSoTGQ==
X-Received: by 2002:a05:6a00:8d6:b0:771:e4c6:10cc with SMTP id d2e1a72fcca58-780fcdd2cb1mr13863837b3a.6.1759028642348;
        Sat, 27 Sep 2025 20:04:02 -0700 (PDT)
Received: from localhost ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-78102c1203fsm7854159b3a.92.2025.09.27.20.04.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Sep 2025 20:04:02 -0700 (PDT)
From: Coiby Xu <coxu@redhat.com>
To: linux-integrity@vger.kernel.org
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Karel Srot <ksrot@redhat.com>,
	Mimi Zohar <zohar@linux.ibm.com>,
	Roberto Sassu <roberto.sassu@huawei.com>,
	Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
	Eric Snowberg <eric.snowberg@oracle.com>,
	Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	linux-security-module@vger.kernel.org (open list:SECURITY SUBSYSTEM),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] ima: Fall back to default kernel module signature verification
Date: Sun, 28 Sep 2025 11:03:58 +0800
Message-ID: <20250928030358.3873311-1-coxu@redhat.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently, for any IMA policy that requires appraisal for kernel modules
e.g. ima_policy=secure_boot, PowerPC architecture specific policy,
booting will fail because IMA will reject a kernel module which will
be decompressed in the kernel space and then have its signature
verified.

This happens because when in-kernel module decompression
(CONFIG_MODULE_DECOMPRESS) is enabled, kmod will use finit_module
syscall instead of init_module to load a module. And IMA mandates IMA
xattr verification for finit_module unless appraise_type=imasig|modsig
is specified in the rule.  However currently initramfs doesn't support
xattr. And IMA rule "func=MODULE_CHECK appraise_type=imasig|modsig"
doesn't work either because IMA will treat to-be-decompressed kernel
module as not having module signature as it can't decompress kernel
module to check if signature exists.

So fall back to default kernel module signature verification when we have
no way to verify IMA xattr.

Reported-by: Karel Srot <ksrot@redhat.com>
Signed-off-by: Coiby Xu <coxu@redhat.com>
---
Another approach will be to make IMA decompress the kernel module to
check the signature. This requires refactoring kernel module code to
make the in-kernel module decompressing feature modular and seemingly
more efforts are needed. A second disadvantage is it feels
counter-intuitive to verify the same kernel module signature twice. And
we still need to make ima_policy=secure_boot allow verifying appended
module signature.

Anyways, I'm open to suggestions and can try the latter approach if
there are some benefits I'm not aware of or a better approach.

 security/integrity/ima/ima_appraise.c | 25 +++++++++++++++++++------
 1 file changed, 19 insertions(+), 6 deletions(-)

diff --git a/security/integrity/ima/ima_appraise.c b/security/integrity/ima/ima_appraise.c
index f435eff4667f..fcc75dd1486f 100644
--- a/security/integrity/ima/ima_appraise.c
+++ b/security/integrity/ima/ima_appraise.c
@@ -502,9 +502,10 @@ int ima_appraise_measurement(enum ima_hooks func, struct ima_iint_cache *iint,
 	enum integrity_status status = INTEGRITY_UNKNOWN;
 	int rc = xattr_len;
 	bool try_modsig = iint->flags & IMA_MODSIG_ALLOWED && modsig;
+	bool enforce_module_sig = iint->flags & IMA_DIGSIG_REQUIRED && func == MODULE_CHECK;
 
-	/* If not appraising a modsig, we need an xattr. */
-	if (!(inode->i_opflags & IOP_XATTR) && !try_modsig)
+	/* If not appraising a modsig or using default module verification, we need an xattr. */
+	if (!(inode->i_opflags & IOP_XATTR) && !try_modsig && !enforce_module_sig)
 		return INTEGRITY_UNKNOWN;
 
 	/*
@@ -517,8 +518,8 @@ int ima_appraise_measurement(enum ima_hooks func, struct ima_iint_cache *iint,
 	if (is_bprm_creds_for_exec(func, file))
 		audit_msgno = AUDIT_INTEGRITY_USERSPACE;
 
-	/* If reading the xattr failed and there's no modsig, error out. */
-	if (rc <= 0 && !try_modsig) {
+	/* If reading the xattr failed and there's no modsig or module verification, error out. */
+	if (rc <= 0 && !try_modsig && !enforce_module_sig) {
 		if (rc && rc != -ENODATA)
 			goto out;
 
@@ -549,8 +550,8 @@ int ima_appraise_measurement(enum ima_hooks func, struct ima_iint_cache *iint,
 	case INTEGRITY_UNKNOWN:
 		break;
 	case INTEGRITY_NOXATTRS:	/* No EVM protected xattrs. */
-		/* It's fine not to have xattrs when using a modsig. */
-		if (try_modsig)
+		/* Fine to not have xattrs when using a modsig or default module verification. */
+		if (try_modsig || enforce_module_sig)
 			break;
 		fallthrough;
 	case INTEGRITY_NOLABEL:		/* No security.evm xattr. */
@@ -580,6 +581,18 @@ int ima_appraise_measurement(enum ima_hooks func, struct ima_iint_cache *iint,
 	     rc == -ENOKEY))
 		rc = modsig_verify(func, modsig, &status, &cause);
 
+	/* Fall back to default kernel module signature verification */
+	if (rc && enforce_module_sig) {
+		rc = 0;
+		set_module_sig_enforced();
+		/* CONFIG_MODULE_SIG may be disabled */
+		if (is_module_sig_enforced()) {
+			rc = 0;
+			status = INTEGRITY_PASS;
+			pr_debug("Fall back to default kernel module verification for %s\n", filename);
+		}
+	}
+
 out:
 	/*
 	 * File signatures on some filesystems can not be properly verified.

base-commit: cec1e6e5d1ab33403b809f79cd20d6aff124ccfe
-- 
2.51.0


