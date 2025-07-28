Return-Path: <linux-kernel+bounces-747855-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1648AB13928
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 12:44:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 760623B6A0C
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 10:43:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADCC1248F4B;
	Mon, 28 Jul 2025 10:43:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hjq5Hzm3"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B590247DE1
	for <linux-kernel@vger.kernel.org>; Mon, 28 Jul 2025 10:43:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753699437; cv=none; b=dOkGd54C1WBXWiU1UMiMiCeTs6v8/zq1WnIiT4tYvqsrYpBUbzKs1EuPqWaaGSnlO+GaokFxlMrNVwI2V8EaaA8qwS5u3pBVHirl1/XA19thuSVf9M+47P0Co4CuimRPUIeGbA4KCwDV1LsoJ0nNME6yedX1ZNJ7Dl9DqBmBmXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753699437; c=relaxed/simple;
	bh=8rEvjgTcQCg9hFxS4+vi94+8/VxEg9odYX30L8yYhjk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SbiaQnDyAi/I9reZFypqa5kXYGsShRD1hqg1uGOsmlwmE54tmIGciqth1H+jTPxoavud1S9s2/s1waOtJfiV9mDJShIutJFN+MO5gGSJ9E+XIGR1v5CZW87I14Q13NUsnqsDuZ2W9Gxsgy5nT8Y8xYCmsMbgm01GmNlpdpuOncA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Hjq5Hzm3; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2403df11a2aso4124055ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jul 2025 03:43:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753699435; x=1754304235; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=iewguF/RLCE9KJBwA51y3Hv7HH9nRTZkotwtc/bcctg=;
        b=Hjq5Hzm3+qE0g3YbE6HdhnUAYTNLdWUcDrH+tyw2h5jcXcuvSJVjT8aUaNx2/6lyrL
         s2qTMBML/9K1qmOK03CO/mYxAQJ1T2StyldMqm0jnx6nSjlrXQFC6vItOmiLaVTc9BO2
         b1Y2d0ebJaACV/P5rOBX+TTGsbK20v8tlAhXlsQ4ZRD+7N80tx2ofoZbP3alTleGWmal
         b4+8O5+p7iidYytxhd1hx8s7eJJ0fPAv8MX7ok9WzKou5EYD6kBDYKOFTAKo+qTyjCQN
         /WCj72wMctY557wRfZLcXBEwOPrObKTaUnrVJdEJrWYSabiVmlO8w6AatpiGXMKvxEwP
         5KnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753699435; x=1754304235;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iewguF/RLCE9KJBwA51y3Hv7HH9nRTZkotwtc/bcctg=;
        b=v5UfQ2Ee4C8C77ynDGwxyTTEUVpQmOYX2suPbf9UDNFi2U0BVi8RI7rIN9f/WdnZkn
         c12ZHhICh+0KzcuYnsJJo57n7tpknRi4iFGB2QpISaPitnDCR3a6FXAhNxZNIPt57ky1
         GJvbrSXVgr8xobdzVm2+05wwneyD29MtzPF4hvdXf6B2iZIA9hfSBMpqOI2CvlxmkNQ3
         Pf0vjQe+CTSzvaFk17bLtaGdi6sRBdNwthlSlJJTT0m8Q0RrBJhid4+PRk2Fw4Pp6f3z
         xtZ/9LiAV6yHB72NjU8LfLOj6sZt3nnAczcwxyP9s7VNkgR1ulahdVBAGzLDYSS6djuA
         Lebw==
X-Forwarded-Encrypted: i=1; AJvYcCUvcrDp2jQH+x+6CLPYWLiE3Tom9LaAfvmLzmb2AApDJTzM+wY9m8uvQ79sVhEUn4FV38x9BcSE92zXcfs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+VI5i4QxpqSiJ564v9xFhBuDmgbSjLn27lPOPifu3tu+CfU6f
	IB7L2ifCpq8cfUknTAIZSBFRgeZ+yQM7IJyhylFP8C7nq35BHDNW1bvYw4g8QNpaWKs=
X-Gm-Gg: ASbGncsJGJcysMjv4lcCF9n56skE1qAb+dlTS/qHtHsAyJv0v2woxvzHPpxO4vIs5tO
	43rZvpBvIouz34amStjj/2zPLadJHKJd6iouch0MN28OiOO41ITT3OMPbVfG5FUEfnCWbvs1gOp
	0AObUDLisfHuPK3EffNC36JGH22ZN7+lnRbS6GYJu+lGt2QfUO1G5YyZnVqkUp93W3FTcyRv5oF
	7JLDUYsOYx4kPiWXwk4/zmgrXOJuD2x7T9v0ux1YDuv6kJ2QHLIiQyzd9U/nalLxbmUKMkLx6F/
	zMtHZbNF3CqipOj3ILXLgfv8g1DADNG38OBZ1nFco4qX9QyTkKTc9VcHVZDOcuZaijLD5JHePdo
	SRU0gZAa6aq53+iL4LvHSCaB6nf3/rzBlDzTeMQc=
X-Google-Smtp-Source: AGHT+IFO4Nhc1HiveTtGdp7dYCPm4Tar99uDZx+7GONVxZft3W3ylz46JyvrHmfSZxXa67vifvwQ9g==
X-Received: by 2002:a17:903:2f8a:b0:23f:8d03:c4ac with SMTP id d9443c01a7336-23fb2ff96ecmr167941025ad.2.1753699434632;
        Mon, 28 Jul 2025 03:43:54 -0700 (PDT)
Received: from localhost.localdomain ([49.36.70.111])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2403e6085e6sm10981475ad.129.2025.07.28.03.43.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Jul 2025 03:43:54 -0700 (PDT)
From: Dishank Jogi <jogidishank503@gmail.com>
To: elver@google.com
Cc: dvyukov@google.com,
	kasan-dev@googlegroups.com,
	linux-kernel@vger.kernel.org,
	rathod.darshan.0896@gmail.com,
	Dishank Jogi <jogidishank503@gmail.com>
Subject: [PATCH] kcsan: clean up redundant empty macro arguments in atomic ops.
Date: Mon, 28 Jul 2025 10:43:27 +0000
Message-ID: <20250728104327.48469-1-jogidishank503@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

---------------------------------------------------------

- Removed unnecessary trailing commas from DEFINE_TSAN_ATOMIC_RMW() macro
  calls within DEFINE_TSAN_ATOMIC_OPS() in kernel/kcsan/core.c

- It passes checkpatch.pl with no errors or warnings and
  introduces no functional changes.

---------------------------------------------------------

Signed-off-by: Dishank Jogi <jogidishank503@gmail.com>
---
 kernel/kcsan/core.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/kernel/kcsan/core.c b/kernel/kcsan/core.c
index 8a7baf4e332e..f2ec7fa4a44d 100644
--- a/kernel/kcsan/core.c
+++ b/kernel/kcsan/core.c
@@ -1257,12 +1257,12 @@ static __always_inline void kcsan_atomic_builtin_memorder(int memorder)
 #define DEFINE_TSAN_ATOMIC_OPS(bits)                                                               \
 	DEFINE_TSAN_ATOMIC_LOAD_STORE(bits);                                                       \
 	DEFINE_TSAN_ATOMIC_RMW(exchange, bits, _n);                                                \
-	DEFINE_TSAN_ATOMIC_RMW(fetch_add, bits, );                                                 \
-	DEFINE_TSAN_ATOMIC_RMW(fetch_sub, bits, );                                                 \
-	DEFINE_TSAN_ATOMIC_RMW(fetch_and, bits, );                                                 \
-	DEFINE_TSAN_ATOMIC_RMW(fetch_or, bits, );                                                  \
-	DEFINE_TSAN_ATOMIC_RMW(fetch_xor, bits, );                                                 \
-	DEFINE_TSAN_ATOMIC_RMW(fetch_nand, bits, );                                                \
+	DEFINE_TSAN_ATOMIC_RMW(fetch_add, bits);                                                 \
+	DEFINE_TSAN_ATOMIC_RMW(fetch_sub, bits);                                                 \
+	DEFINE_TSAN_ATOMIC_RMW(fetch_and, bits);                                                 \
+	DEFINE_TSAN_ATOMIC_RMW(fetch_or, bits);                                                  \
+	DEFINE_TSAN_ATOMIC_RMW(fetch_xor, bits);                                                 \
+	DEFINE_TSAN_ATOMIC_RMW(fetch_nand, bits);                                                \
 	DEFINE_TSAN_ATOMIC_CMPXCHG(bits, strong, 0);                                               \
 	DEFINE_TSAN_ATOMIC_CMPXCHG(bits, weak, 1);                                                 \
 	DEFINE_TSAN_ATOMIC_CMPXCHG_VAL(bits)
-- 
2.43.0


