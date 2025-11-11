Return-Path: <linux-kernel+bounces-895771-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CE45C4EDE2
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 16:52:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 18D604ED09D
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 15:50:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7069736B062;
	Tue, 11 Nov 2025 15:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="aZulMhDE"
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88FDB36A011
	for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 15:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762876197; cv=none; b=ch8wUWxc6azaAoBq+QZtYsEEtwiT2GCqAoa9vSp2eFs9N7rFPXyyIwZynnIBEAsdeOTblY95zEWkWTJP9wGmee2PQBd2du+FdJCWnUK8zJal7oOXiGX1COJ+2vKxPg9QwF7L6e/GARz5Na/lUbMzHODrtgWMhlbJ17WGYfhRmCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762876197; c=relaxed/simple;
	bh=ArffcqoJndIyYbZ2n+iylx2lu7vSzFeJ4OJe4C6LVPs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cImWLuGdBgefHBYKSUrWRqQiXavE9XZOr8xbvcjW3C0V6X0+dxrIDWaJgpovboFtjDNLTBRmibiq9ZgAu7gTkQFknfiBfbuA5ObI3o0aP7yEp3VN/ZoxK7aGxqidcTXeuE9WwxpDoGrtSGtPhZGiPCvM7QrRzi8kgUlkrcMc8hA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=aZulMhDE; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-47118259fd8so31047965e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 07:49:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1762876194; x=1763480994; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r30esyx8yD0HScczwGrkXPHaGSEXpXn8hasnGYmqj/c=;
        b=aZulMhDE3YOhVELKLbkzv831DFFjyrUiCLrLBYfMj7kUw0alDVXbfLpuI7JpDAe5a2
         xuN69UjJl6GxYHDg9TUyKkJuPphO5TT6zSuk/bKj/u2hgun75gfXZjRtQblxS2BIbBge
         Mz3vXHMG7bB3jPSNpxoDNjhnbLmkrkwi0TAJ2oTkPhB1RN0Fea4FjagA1clLIjfdhjDp
         aVP9TosgbHr72fHNLXc+n8Ki5O5WC/XYNxNN8/5fl6+EaErx4cbkRrQmPuX5mYNuB1SK
         /13CkowaAsq7/1aPN/kBuz+CNDnhrWz5XhTbunGvdD5/syY7+nEGHWnDiB4SEPuIhPiK
         sguQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762876194; x=1763480994;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=r30esyx8yD0HScczwGrkXPHaGSEXpXn8hasnGYmqj/c=;
        b=tlNFx14RoGUBj8ETcWheML/1Yyp0PtvftY9+7VqKHWOrKjVy2HVnxJgaIPYgENObD4
         M72B2GcQAiCdUqSoNns/v4Tii712gCkymMkOLDbFKi3DUmrhRYrQnMAluPWC06yU0G+A
         XszUjsj5MTgcoN2HKPepHFbd8cTsnkAvvgX2CVh9px/2h/tzEzCXKsslOLGdVAEL0mhy
         Yap36L597+kypGfyOQ32zsoFlcAaD2Q21XqCb8S/etUgsYMY3Z6SYDYhq6nDZ0qMs4UN
         tLvwus4gLvmce68T9deePwrcG5vhxbZU/M57KCxD5ABVPmytwuXc5Jgp+cl9YjKTd3Te
         ASmg==
X-Forwarded-Encrypted: i=1; AJvYcCXI5yK49YxU89StSpcN6GvGUtp9HG9d4bzkpuqanoXgvjmH9gMTAr241Cl6vEzsXCMfv2TUm5oScGKZ0qM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwcX/k/iIEfWmn3BxF2f5+iykYgMnFRmY5ksOGjRhXQMnalPi/1
	vcAnXnX6xTaGCY8Oujf8XDuQeFBwIxnwVMZFbbyWmwq2z1j6PsJZ8SHISrPq1Ggfznk=
X-Gm-Gg: ASbGncsW9bvaImTD4BVd+9PJp59RFLfokOcUOLqIgKnKPa39MvDZdZkODjXyopcJAAb
	x8XvNJcXxTyP1FdnkOvYOG/zRQJaIt/ZaJDgKaU3ZJj78GsLFzHeawGn6QM6wxuiZBoJT/FgMDf
	37CPvIMiHeBQKoCVejZvEOUP6ODCgywBUFjL+anzm676McBaPeTX6Y7e/Wqosv0AuRffIizVFM0
	xeAIwhaciQtuX9harARE1cPHjIyUXblhOF04PvIjtFWDpW0++3RedIVCfn9v3Lts0+5zMnI1Wsk
	isO3ghEvsPDb6Fhl8/9MhA5vlb1+wpJTfvrK4ypAKe3NFGjE3q7/yOZv70NSz69QukU0bvOSQ7g
	Rt581kHg+egxMRzgA/W7TFjtN7bvToR+yBaxjTul5w36+B2lKuxvlIqTNnZ2E2CE91sev54cEDj
	djzcro2QgolfO5/Yr52Q==
X-Google-Smtp-Source: AGHT+IExhQ/+BzedT09U+yGaxQf13zai+5Vmb9vWg/D2+w5V1sfzVsL0jINrbBSLXD9+jVM64JUSgw==
X-Received: by 2002:a05:600c:35c8:b0:477:7a1a:4b82 with SMTP id 5b1f17b1804b1-4777a1a4d15mr84388275e9.8.1762876193779;
        Tue, 11 Nov 2025 07:49:53 -0800 (PST)
Received: from zovi.suse.cz (nat2.prg.suse.com. [195.250.132.146])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42abe62b23csm28269916f8f.10.2025.11.11.07.49.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Nov 2025 07:49:53 -0800 (PST)
From: Petr Pavlu <petr.pavlu@suse.com>
To: David Howells <dhowells@redhat.com>,
	David Woodhouse <dwmw2@infradead.org>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Petr Pavlu <petr.pavlu@suse.com>,
	Daniel Gomez <da.gomez@kernel.org>,
	Sami Tolvanen <samitolvanen@google.com>,
	Aaron Tomlin <atomlin@atomlin.com>
Cc: keyrings@vger.kernel.org,
	linux-modules@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] sign-file: Remove support for signing with PKCS#7
Date: Tue, 11 Nov 2025 16:48:32 +0100
Message-ID: <20251111154923.978181-3-petr.pavlu@suse.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251111154923.978181-1-petr.pavlu@suse.com>
References: <20251111154923.978181-1-petr.pavlu@suse.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The PKCS#7 code in sign-file allows for signing only with SHA-1. Since
SHA-1 support for module signing has been removed, drop PKCS#7 support in
favor of using only CMS.

The use of the PKCS#7 code is selected by the following:

 #if defined(LIBRESSL_VERSION_NUMBER) || \
 	OPENSSL_VERSION_NUMBER < 0x10000000L || \
 	defined(OPENSSL_NO_CMS)
 #define USE_PKCS7
 #endif

Looking at the individual ifdefs:

* LIBRESSL_VERSION_NUMBER: LibreSSL added the CMS implementation from
  OpenSSL in 3.1.0, making the ifdef no longer relevant. This version was
  released on April 8, 2020.

* OPENSSL_VERSION_NUMBER < 0x10000000L: OpenSSL 1.0.0 was released on March
  29, 2010. Supporting earlier versions should no longer be necessary. The
  file Documentation/process/changes.rst already states that at least
  version 1.0.0 is required to build the kernel.

* OPENSSL_NO_CMS: OpenSSL can be configured with "no-cms" to disable the
  CMS support. In this case, sign-file will no longer be usable. The CMS
  support is now required.

In practice, since distributions now typically sign modules with SHA-2, for
which sign-file already required CMS support, removing PKCS#7 shouldn't
cause any issues.

Signed-off-by: Petr Pavlu <petr.pavlu@suse.com>
---
 scripts/sign-file.c | 66 +++------------------------------------------
 1 file changed, 3 insertions(+), 63 deletions(-)

diff --git a/scripts/sign-file.c b/scripts/sign-file.c
index 7070245edfc1..16f2bf2e1e3c 100644
--- a/scripts/sign-file.c
+++ b/scripts/sign-file.c
@@ -24,6 +24,7 @@
 #include <arpa/inet.h>
 #include <openssl/opensslv.h>
 #include <openssl/bio.h>
+#include <openssl/cms.h>
 #include <openssl/evp.h>
 #include <openssl/pem.h>
 #include <openssl/err.h>
@@ -39,29 +40,6 @@
 #endif
 #include "ssl-common.h"
 
-/*
- * Use CMS if we have openssl-1.0.0 or newer available - otherwise we have to
- * assume that it's not available and its header file is missing and that we
- * should use PKCS#7 instead.  Switching to the older PKCS#7 format restricts
- * the options we have on specifying the X.509 certificate we want.
- *
- * Further, older versions of OpenSSL don't support manually adding signers to
- * the PKCS#7 message so have to accept that we get a certificate included in
- * the signature message.  Nor do such older versions of OpenSSL support
- * signing with anything other than SHA1 - so we're stuck with that if such is
- * the case.
- */
-#if defined(LIBRESSL_VERSION_NUMBER) || \
-	OPENSSL_VERSION_NUMBER < 0x10000000L || \
-	defined(OPENSSL_NO_CMS)
-#define USE_PKCS7
-#endif
-#ifndef USE_PKCS7
-#include <openssl/cms.h>
-#else
-#include <openssl/pkcs7.h>
-#endif
-
 struct module_signature {
 	uint8_t		algo;		/* Public-key crypto algorithm [0] */
 	uint8_t		hash;		/* Digest algorithm [0] */
@@ -228,15 +206,10 @@ int main(int argc, char **argv)
 	bool raw_sig = false;
 	unsigned char buf[4096];
 	unsigned long module_size, sig_size;
-	unsigned int use_signed_attrs;
 	const EVP_MD *digest_algo;
 	EVP_PKEY *private_key;
-#ifndef USE_PKCS7
 	CMS_ContentInfo *cms = NULL;
 	unsigned int use_keyid = 0;
-#else
-	PKCS7 *pkcs7 = NULL;
-#endif
 	X509 *x509;
 	BIO *bd, *bm;
 	int opt, n;
@@ -246,21 +219,13 @@ int main(int argc, char **argv)
 
 	key_pass = getenv("KBUILD_SIGN_PIN");
 
-#ifndef USE_PKCS7
-	use_signed_attrs = CMS_NOATTR;
-#else
-	use_signed_attrs = PKCS7_NOATTR;
-#endif
-
 	do {
 		opt = getopt(argc, argv, "sdpk");
 		switch (opt) {
 		case 's': raw_sig = true; break;
 		case 'p': save_sig = true; break;
 		case 'd': sign_only = true; save_sig = true; break;
-#ifndef USE_PKCS7
 		case 'k': use_keyid = CMS_USE_KEYID; break;
-#endif
 		case -1: break;
 		default: format();
 		}
@@ -289,14 +254,6 @@ int main(int argc, char **argv)
 		replace_orig = true;
 	}
 
-#ifdef USE_PKCS7
-	if (strcmp(hash_algo, "sha1") != 0) {
-		fprintf(stderr, "sign-file: %s only supports SHA1 signing\n",
-			OPENSSL_VERSION_TEXT);
-		exit(3);
-	}
-#endif
-
 	/* Open the module file */
 	bm = BIO_new_file(module_name, "rb");
 	ERR(!bm, "%s", module_name);
@@ -314,7 +271,6 @@ int main(int argc, char **argv)
 		digest_algo = EVP_get_digestbyname(hash_algo);
 		ERR(!digest_algo, "EVP_get_digestbyname");
 
-#ifndef USE_PKCS7
 		/* Load the signature message from the digest buffer. */
 		cms = CMS_sign(NULL, NULL, NULL, NULL,
 			       CMS_NOCERTS | CMS_PARTIAL | CMS_BINARY |
@@ -323,19 +279,12 @@ int main(int argc, char **argv)
 
 		ERR(!CMS_add1_signer(cms, x509, private_key, digest_algo,
 				     CMS_NOCERTS | CMS_BINARY |
-				     CMS_NOSMIMECAP | use_keyid |
-				     use_signed_attrs),
+				     CMS_NOSMIMECAP | CMS_NOATTR |
+				     use_keyid),
 		    "CMS_add1_signer");
 		ERR(CMS_final(cms, bm, NULL, CMS_NOCERTS | CMS_BINARY) != 1,
 		    "CMS_final");
 
-#else
-		pkcs7 = PKCS7_sign(x509, private_key, NULL, bm,
-				   PKCS7_NOCERTS | PKCS7_BINARY |
-				   PKCS7_DETACHED | use_signed_attrs);
-		ERR(!pkcs7, "PKCS7_sign");
-#endif
-
 		if (save_sig) {
 			char *sig_file_name;
 			BIO *b;
@@ -344,13 +293,8 @@ int main(int argc, char **argv)
 			    "asprintf");
 			b = BIO_new_file(sig_file_name, "wb");
 			ERR(!b, "%s", sig_file_name);
-#ifndef USE_PKCS7
 			ERR(i2d_CMS_bio_stream(b, cms, NULL, 0) != 1,
 			    "%s", sig_file_name);
-#else
-			ERR(i2d_PKCS7_bio(b, pkcs7) != 1,
-			    "%s", sig_file_name);
-#endif
 			BIO_free(b);
 		}
 
@@ -377,11 +321,7 @@ int main(int argc, char **argv)
 	module_size = BIO_number_written(bd);
 
 	if (!raw_sig) {
-#ifndef USE_PKCS7
 		ERR(i2d_CMS_bio_stream(bd, cms, NULL, 0) != 1, "%s", dest_name);
-#else
-		ERR(i2d_PKCS7_bio(bd, pkcs7) != 1, "%s", dest_name);
-#endif
 	} else {
 		BIO *b;
 
-- 
2.51.1


