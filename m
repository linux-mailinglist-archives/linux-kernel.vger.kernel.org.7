Return-Path: <linux-kernel+bounces-766762-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 46295B24AC8
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 15:39:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EA7393B87B2
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 13:39:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F13582EBDDE;
	Wed, 13 Aug 2025 13:38:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YUKwEYU2"
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72A202EAB94
	for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 13:38:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755092327; cv=none; b=GCEpqswPMSLlQbe03zzmqjoE/RL7wM26xVmjRdJUZJmZHjSDkvauwvOl7UtVOnEZeJ+9AYwal95SKZ6OR6uMKXo1YqTo1Goaw+oFW6VtPs+gDG99CvVAOffbIKCGusDwVu7XwK6yc2F1kju+QbeTyuSBEgHGmIkVE0TMhtjZk4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755092327; c=relaxed/simple;
	bh=ATCeCXY9ExH+Cvg4r15EUaOEE6ibGwuLUwDitn12MTQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RE0bgK6o7wiCG436EtK9kV+m1PgHpS5aFwva02qiY88L0gELyRIcLNXk/1swr6IQIMJ8lNOZ/sYkde1gdFv4hJV95ufA5v1psDkdo0EAkmZKoBpHS5SS0hwzsWeFhVjpfEYlADYIykfTlgHRLNTLFj9+TqjtdiwxdfBm6YqbXmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YUKwEYU2; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-3b8de193b60so3761880f8f.0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 06:38:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755092324; x=1755697124; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WCmoTAq+24iKRI4CSHEBG8UaeJTBmRNFmOmZvFaISJE=;
        b=YUKwEYU2bWSnjxDaEz1aMAlUu8zoOnjXj30O2SYSndjx2luwz/SE6LlhbUv4zRi0q0
         u61l8KCbDfl8hwIOztdOHXLUzd5L6/xRfUk1TqdTjKM6CGSe7MEofL/XPZoZCVu9TOxR
         4syxXtlkpOPNgN2zOCz0MU1FZaKjEf62ntp9c1cKBk6R9qmArWzan9KYKmWkw8B34Fcd
         J/DfTtQ8WRBwm6h7hEn1nY6DLJxj80NGqb43zMtxc4HrPkUHhXKtW/zkQVJQKS+Mciho
         CRdmbiqWdSOVSqEMZZ1XXWLqp+aZj0Ido85HDti5hURqhwvH95LBMhv1jmKCCkSP6AQW
         iH4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755092324; x=1755697124;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WCmoTAq+24iKRI4CSHEBG8UaeJTBmRNFmOmZvFaISJE=;
        b=qdecpOWnTFfpmxA0aE2mUzP0m2YD6pFOm9hRQ5hopgAEQkO3QTSt5yV9cTx2VLY2Bk
         cld2vqr18+4kjxgeixqS0pEa6W9n01lzpM8Vw+Rmen4GS+NWZSAOG+2YMlgs5FbsRIh8
         8DNkVizhT2vtBLxBSoDroYEeFq7MUYu55/qDKWiEpGVq4Zcg3IMYWg4WZBzA9aIiF3XU
         qudQ0z5ejPjy9eF42DjQFrcMY5Zr2RHG8U40Vgkt4hCdlt3CGoXfQ0mEExBJAEjjQN//
         z5yns/5C/0AAkDJF2FmvPJnw8ufLmkdKDCMJy/atyCQXkOdPOWlddPie737N2hcCiOVP
         7Sxg==
X-Forwarded-Encrypted: i=1; AJvYcCV5OspCam+2hTzYm9ALcT1bgAT5dMtpR4/KvRqw9pjO69u64mQG4DoqzNicUIpLd/adWOOf0dKQJDh/kPU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwXE41IdysLY5uq6Da2XMKNxjyA7mDWp3AlObIg+9X5YeHWBXok
	BAaTotlcYMk3YG0jhChl/Nd8ZHBZ51j/2nyOn1OgtMjXVaoN1FwXODTS
X-Gm-Gg: ASbGncuHL3uPShJKm3hiR8Fmp/2XktVLK+vECHcgk6QOW8xerHnHHUXqAW1sdLFA/Ru
	Yxa3AazGLCdyvztRWqvU1985Es17k7zv4dCSxa4sm6L0SNArN1uIVFqvTvfFjSIQmPTMZASlrVz
	GrH4pfK4v4jls9TLNQDL2vjXtLyrlwV9zWccHaODBYU7+evRoXzAqx7TngeyV+x2zmKcbWpsZIr
	LkyaLMyZ7fmodzVZuqzDUmp9vIr03G8PrMNXRn/0X0IIJsf18MD2oaFYbdsJqE/74QWBgnUM4BM
	Ol32ugEdb8A6ktxTZ6M8Hfp735fQM/WpxOWGh9piPOJI+13swbWf7DQL5K+9OSLZD79GwhxjNyD
	8aUR/WgNDJPiWOKNtBD0GEHtDd+2Qh0e2OI1qG9yKFDaMB7PZ/0+Weyr8sx4iLYJwtEqX2equ/m
	m+SzrWokcDCDfvwQcQD/SaeXcjPA==
X-Google-Smtp-Source: AGHT+IHW7Qd1SAbOSY879BbiErQpR32SX8ht+p3w2HKrir466M04lOt+huUQxcKj+6by6JWF/cRHzQ==
X-Received: by 2002:a05:6000:4308:b0:3b7:84fc:ef4c with SMTP id ffacd0b85a97d-3b917d2d303mr2420863f8f.6.1755092323832;
        Wed, 13 Aug 2025 06:38:43 -0700 (PDT)
Received: from xl-nested.c.googlers.com.com (87.220.76.34.bc.googleusercontent.com. [34.76.220.87])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b8f8b1bc81sm25677444f8f.69.2025.08.13.06.38.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Aug 2025 06:38:43 -0700 (PDT)
From: Ethan Graham <ethan.w.s.graham@gmail.com>
To: ethangraham@google.com,
	glider@google.com
Cc: andreyknvl@gmail.com,
	brendan.higgins@linux.dev,
	davidgow@google.com,
	dvyukov@google.com,
	jannh@google.com,
	elver@google.com,
	rmoar@google.com,
	shuah@kernel.org,
	tarasmadan@google.com,
	kasan-dev@googlegroups.com,
	kunit-dev@googlegroups.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH v1 RFC 6/6] crypto: implement KFuzzTest targets for PKCS7 and RSA parsing
Date: Wed, 13 Aug 2025 13:38:12 +0000
Message-ID: <20250813133812.926145-7-ethan.w.s.graham@gmail.com>
X-Mailer: git-send-email 2.51.0.rc0.205.g4a044479a3-goog
In-Reply-To: <20250813133812.926145-1-ethan.w.s.graham@gmail.com>
References: <20250813133812.926145-1-ethan.w.s.graham@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ethan Graham <ethangraham@google.com>

Add KFuzzTest targets for pkcs7_parse_message, rsa_parse_pub_key, and
rsa_parse_priv_key to serve as real-world examples of how the framework is used.

These functions are ideal candidates for KFuzzTest as they perform complex
parsing of user-controlled data but are not directly exposed at the syscall
boundary. This makes them difficult to exercise with traditional fuzzing tools
and showcases the primary strength of the KFuzzTest framework: providing an
interface to fuzz internal, non-exported kernel functions.

The targets are defined directly within the source files of the functions they
test, demonstrating how to colocate fuzz tests with the code under test.

Signed-off-by: Ethan Graham <ethangraham@google.com>
---
 crypto/asymmetric_keys/pkcs7_parser.c | 15 ++++++++++++++
 crypto/rsa_helper.c                   | 29 +++++++++++++++++++++++++++
 2 files changed, 44 insertions(+)

diff --git a/crypto/asymmetric_keys/pkcs7_parser.c b/crypto/asymmetric_keys/pkcs7_parser.c
index 423d13c47545..e8477f8b0eaf 100644
--- a/crypto/asymmetric_keys/pkcs7_parser.c
+++ b/crypto/asymmetric_keys/pkcs7_parser.c
@@ -13,6 +13,7 @@
 #include <linux/err.h>
 #include <linux/oid_registry.h>
 #include <crypto/public_key.h>
+#include <linux/kfuzztest.h>
 #include "pkcs7_parser.h"
 #include "pkcs7.asn1.h"
 
@@ -169,6 +170,20 @@ struct pkcs7_message *pkcs7_parse_message(const void *data, size_t datalen)
 }
 EXPORT_SYMBOL_GPL(pkcs7_parse_message);
 
+struct pkcs7_parse_message_arg {
+	const void *data;
+	size_t datalen;
+};
+
+FUZZ_TEST(test_pkcs7_parse_message, struct pkcs7_parse_message_arg)
+{
+	KFUZZTEST_EXPECT_NOT_NULL(pkcs7_parse_message_arg, data);
+	KFUZZTEST_ANNOTATE_LEN(pkcs7_parse_message_arg, datalen, data);
+	KFUZZTEST_EXPECT_LE(pkcs7_parse_message_arg, datalen, 16 * PAGE_SIZE);
+
+	pkcs7_parse_message(arg->data, arg->datalen);
+}
+
 /**
  * pkcs7_get_content_data - Get access to the PKCS#7 content
  * @pkcs7: The preparsed PKCS#7 message to access
diff --git a/crypto/rsa_helper.c b/crypto/rsa_helper.c
index 94266f29049c..79b7ddc7c48d 100644
--- a/crypto/rsa_helper.c
+++ b/crypto/rsa_helper.c
@@ -9,6 +9,7 @@
 #include <linux/export.h>
 #include <linux/err.h>
 #include <linux/fips.h>
+#include <linux/kfuzztest.h>
 #include <crypto/internal/rsa.h>
 #include "rsapubkey.asn1.h"
 #include "rsaprivkey.asn1.h"
@@ -166,6 +167,20 @@ int rsa_parse_pub_key(struct rsa_key *rsa_key, const void *key,
 }
 EXPORT_SYMBOL_GPL(rsa_parse_pub_key);
 
+struct rsa_parse_pub_key_arg {
+	const void *key;
+	size_t key_len;
+};
+
+FUZZ_TEST(test_rsa_parse_pub_key, struct rsa_parse_pub_key_arg)
+{
+	KFUZZTEST_EXPECT_NOT_NULL(rsa_parse_pub_key_arg, key);
+	KFUZZTEST_EXPECT_LE(rsa_parse_pub_key_arg, key_len, 16 * PAGE_SIZE);
+
+	struct rsa_key out;
+	rsa_parse_pub_key(&out, arg->key, arg->key_len);
+}
+
 /**
  * rsa_parse_priv_key() - decodes the BER encoded buffer and stores in the
  *                        provided struct rsa_key, pointers to the raw key
@@ -184,3 +199,17 @@ int rsa_parse_priv_key(struct rsa_key *rsa_key, const void *key,
 	return asn1_ber_decoder(&rsaprivkey_decoder, rsa_key, key, key_len);
 }
 EXPORT_SYMBOL_GPL(rsa_parse_priv_key);
+
+struct rsa_parse_priv_key_arg {
+	const void *key;
+	size_t key_len;
+};
+
+FUZZ_TEST(test_rsa_parse_priv_key, struct rsa_parse_priv_key_arg)
+{
+	KFUZZTEST_EXPECT_NOT_NULL(rsa_parse_priv_key_arg, key);
+	KFUZZTEST_EXPECT_LE(rsa_parse_priv_key_arg, key_len, 16 * PAGE_SIZE);
+
+	struct rsa_key out;
+	rsa_parse_priv_key(&out, arg->key, arg->key_len);
+}
-- 
2.51.0.rc0.205.g4a044479a3-goog


