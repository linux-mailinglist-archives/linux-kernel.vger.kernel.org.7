Return-Path: <linux-kernel+bounces-825367-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB22CB8BAEC
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Sep 2025 02:17:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A83355861C4
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Sep 2025 00:17:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B805715746E;
	Sat, 20 Sep 2025 00:17:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i/ZaZM18"
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E6D73A8F7
	for <linux-kernel@vger.kernel.org>; Sat, 20 Sep 2025 00:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758327430; cv=none; b=HI/J5SmP/56SZrNDuyjJtDD0Njt2vL/xwNCBy65A3dMF76Y6xjJ04QN5WIaqIPhagdhW8WTcdAFALiz+MaOyt5mxG5+wbnmLgM9K+SfdqAblwvJiFjaKjidNZ87WC+sy1wjaqX3JWCyCdhQZlglkOr+iBSJGhvaeph2BlULAApI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758327430; c=relaxed/simple;
	bh=8EsIGNTKJ8m5rB8Y0LcXTLQL2gLrzGdByDP1EajpD4w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IQW9Em3hg2j+xDEROz0CMbBK1opad0JNwSNg2RpArbANcFiBhLygJlUiTE6Ki7gUYWW3uj6HpGy6BQGwGETgVKvTgqpzYio0BevqbFhSUUl7qn5U6fGf9P2iKsoAO9jafvZPp6UNdH5JCxXha3KwYBADppy6DXCq+FBr53rdI60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i/ZaZM18; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2681660d604so25063205ad.0
        for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 17:17:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758327428; x=1758932228; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=900/JlLvHzQBBTnEYHEIHH/DD5Qv9IWD35hPvLMbdJ4=;
        b=i/ZaZM18ddg1/GF0pLM0wZHAVn6pr5YCNKquypHHW55nnahCg+eXWX+7+bAAdWXK2J
         tAoqnUUqZq2aE4VIeqx5jcbPUuO4S/j3fp0pi/Yx6UXeuqyxB8uwjW60hZSgCXVkLRoj
         eaVnhxpMA6WKX8TB8TYqNU9T0pVSK78/yTdmuWBU49TBzuyE+Y/3aUhKBslBmVwZ7C7t
         x4HQ+Dpv6LxM92ngArGmF3POYX15v4gnZpNX4InUwZ4wfCkw7zMUZSJby4sXI2fTkMU/
         s9u3zJaXP3xQ7EPBAQzpYe3zlS6MDiz0P0KDVJ4b6kSGdWWOHjaaaj5bqGCOh0wvnkD+
         UBrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758327428; x=1758932228;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=900/JlLvHzQBBTnEYHEIHH/DD5Qv9IWD35hPvLMbdJ4=;
        b=eMBCFXf43sc24751y2J/3Fo1rwpyeDAjmSJG7WmNkrsXkv8vgvLnp31oQxmgnoXhby
         +OfXTJ+7jMlQoC50EQuXTs2SvDuLUiW47z+lxfYDlonos46SSEkGr6r3+Alqa80fDZd+
         N+rhf5iL4cCgIPdLfUnc5ErL68V/LtPtv5oEASCZFx6bWUmyxDgj8ABUBJIzokP93+NX
         XsM0AHNzMgwpA/ENisADIkeUR+k0sC5HCaxDI/3wyVYf4ii2edHO1I49zxFqeXq2XMgh
         5mU+1eFOcKqffORYLBXK96YDlEuaUxIIDytfNUL1tPgMALG99BbpBjdLt7PByZfWIhim
         CHkA==
X-Gm-Message-State: AOJu0YwACwUr6SuCdHkw7ZGxh9oj2q0hNTnthY6AtwDukw173GZebGmy
	we2r21QwS9qgrmhSgQZ6J98LL5ftWwDeJ9nO97NRIwK8fBFaETCkDXKycBja+w==
X-Gm-Gg: ASbGnctpT2DMLgpENcolhazRRbzSQEon7Nn9QCAP+icqCx98UtIf9SnfI9mq5QqpJGZ
	7mSIywexfxV7UN9LjPGunOywiAdI/Xj8rpmuLzePTKGVWsRyJZFkgewnPbHw/JoAVlw9XABQ3lD
	oh1Mw7Pqcp/Lx+XfnvPLP/pQ8BzLjlTfBp0jd1Px/eyz4SWjHBSzRYp6v8LVaMkJXVD1yeuS/17
	OPdvazNfew3mDlOWas+XhlTD2Ce0vBoP8b1R2OiUzi8EHN5zAr7WLTMhynCHW0QtSAzeo6FMKrz
	5mSX1z062AZqT4jhL5Tmy+xd5bwTuUqkHDIqTMrh/0eDejOJRZaOhKzsgkeTb6MH1+JXC6yCSL3
	JFh9lpL4YmOAOLALNTRE2mA==
X-Google-Smtp-Source: AGHT+IG4qZkI4i+qkpcdhVzcOgNvusFXQs6A4ohwClPRCgkug6au6BzHhr9PFBfGbVV7dzxBpfmNmQ==
X-Received: by 2002:a17:903:144e:b0:260:b4c7:986d with SMTP id d9443c01a7336-269ba513a36mr67847115ad.36.1758327427716;
        Fri, 19 Sep 2025 17:17:07 -0700 (PDT)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-269800530c2sm66960705ad.3.2025.09.19.17.17.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Sep 2025 17:17:06 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id 74E4F420A80B; Sat, 20 Sep 2025 07:17:04 +0700 (WIB)
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Documentation <linux-doc@vger.kernel.org>,
	Linux Crypto <linux-crypto@vger.kernel.org>
Cc: Herbert Xu <herbert@gondor.apana.org.au>,
	"David S. Miller" <davem@davemloft.net>,
	Jonathan Corbet <corbet@lwn.net>,
	Bagas Sanjaya <bagasdotme@gmail.com>
Subject: [PATCH] crypto: Add explicit title heading to API docs
Date: Sat, 20 Sep 2025 07:16:51 +0700
Message-ID: <20250920001650.10474-2-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3518; i=bagasdotme@gmail.com; h=from:subject; bh=8EsIGNTKJ8m5rB8Y0LcXTLQL2gLrzGdByDP1EajpD4w=; b=owGbwMvMwCX2bWenZ2ig32LG02pJDBlnP6X3fTr1pWTH+R/JgpdF9/5kvjD/4RLR5f2HPkuyX 7ryyVTve0cpC4MYF4OsmCLLpES+ptO7jEQutK91hJnDygQyhIGLUwAmssuJkWHv9LJ/pu9ckuPY W3YmZJ9Ulzmf9CTbN8tAdbrr3rsHD7xk+M3OtTnivcv7ruxqiaDfimm7nRZxcf+v+RAy4fzcWVd 1z3EDAA==
X-Developer-Key: i=bagasdotme@gmail.com; a=openpgp; fpr=701B806FDCA5D3A58FFB8F7D7C276C64A5E44A1D
Content-Transfer-Encoding: 8bit

Documentation for crypto programming interfaces lack explicit title.
As such, all its sections become entries in the toctree index.

Add the title heading to tidy up toctree.

Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
---
 Documentation/crypto/api-aead.rst     | 3 +++
 Documentation/crypto/api-akcipher.rst | 3 +++
 Documentation/crypto/api-digest.rst   | 3 +++
 Documentation/crypto/api-kpp.rst      | 3 +++
 Documentation/crypto/api-rng.rst      | 3 +++
 Documentation/crypto/api-sig.rst      | 3 +++
 Documentation/crypto/api-skcipher.rst | 3 +++
 7 files changed, 21 insertions(+)

diff --git a/Documentation/crypto/api-aead.rst b/Documentation/crypto/api-aead.rst
index d15256f1ae3696..78d073319f96a3 100644
--- a/Documentation/crypto/api-aead.rst
+++ b/Documentation/crypto/api-aead.rst
@@ -1,3 +1,6 @@
+Authenticated Encryption With Associated Data (AEAD)
+====================================================
+
 Authenticated Encryption With Associated Data (AEAD) Algorithm Definitions
 --------------------------------------------------------------------------
 
diff --git a/Documentation/crypto/api-akcipher.rst b/Documentation/crypto/api-akcipher.rst
index ca1ecdd4a7d378..a31f5aef76678f 100644
--- a/Documentation/crypto/api-akcipher.rst
+++ b/Documentation/crypto/api-akcipher.rst
@@ -1,3 +1,6 @@
+Asymmetric Cipher
+=================
+
 Asymmetric Cipher Algorithm Definitions
 ---------------------------------------
 
diff --git a/Documentation/crypto/api-digest.rst b/Documentation/crypto/api-digest.rst
index 7a1e670d6ce1a4..02a2bcc26a6470 100644
--- a/Documentation/crypto/api-digest.rst
+++ b/Documentation/crypto/api-digest.rst
@@ -1,3 +1,6 @@
+Message Digest
+==============
+
 Message Digest Algorithm Definitions
 ------------------------------------
 
diff --git a/Documentation/crypto/api-kpp.rst b/Documentation/crypto/api-kpp.rst
index 7d86ab906bdf79..5794e2d10c9562 100644
--- a/Documentation/crypto/api-kpp.rst
+++ b/Documentation/crypto/api-kpp.rst
@@ -1,3 +1,6 @@
+Key-agreement Protocol Primitives (KPP)
+=======================================
+
 Key-agreement Protocol Primitives (KPP) Cipher Algorithm Definitions
 --------------------------------------------------------------------
 
diff --git a/Documentation/crypto/api-rng.rst b/Documentation/crypto/api-rng.rst
index 10ba7436cee48e..23a94c0b272eef 100644
--- a/Documentation/crypto/api-rng.rst
+++ b/Documentation/crypto/api-rng.rst
@@ -1,3 +1,6 @@
+Random Number Generator (RNG)
+=============================
+
 Random Number Algorithm Definitions
 -----------------------------------
 
diff --git a/Documentation/crypto/api-sig.rst b/Documentation/crypto/api-sig.rst
index aaec18e26d545f..4d8aba8aee8e04 100644
--- a/Documentation/crypto/api-sig.rst
+++ b/Documentation/crypto/api-sig.rst
@@ -1,3 +1,6 @@
+Asymmetric Signature
+====================
+
 Asymmetric Signature Algorithm Definitions
 ------------------------------------------
 
diff --git a/Documentation/crypto/api-skcipher.rst b/Documentation/crypto/api-skcipher.rst
index 04d6cc5357c810..4b7c8160790a3c 100644
--- a/Documentation/crypto/api-skcipher.rst
+++ b/Documentation/crypto/api-skcipher.rst
@@ -1,3 +1,6 @@
+Symmetric Key Cipher
+====================
+
 Block Cipher Algorithm Definitions
 ----------------------------------
 

base-commit: 381e8ee368234a51b3a4f231f6f24ff0b09d9f9e
-- 
An old man doll... just what I always wanted! - Clara


