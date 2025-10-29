Return-Path: <linux-kernel+bounces-876851-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id BBEBAC1C83E
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 18:41:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 41F3134C52B
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 17:41:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD8A13563E3;
	Wed, 29 Oct 2025 17:39:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hnM67xjS"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF30735581F
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 17:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761759565; cv=none; b=PSgWP/AgVvPLkIE4WQY9Qh6F8bP3JLKEsH+DeWsFeX+/LTg+PyLFuwWbIRGF6TaqV7HvYeKZkzGHjcvXi4ldVxhsWXCp93MkwID4b+CDTH1u9aISN/atjTbVo4zeooeJ3whdJukS3JG2IXJRdmlxsUYJ5ANI6HBT/SqrQY7f4Gw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761759565; c=relaxed/simple;
	bh=8vI5gDqoxAXmmgm15UQmqAAAqKT3ptVUQ39b7WRvVn4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=oFjWvU5Opcg0DdotepDN704GdOvf8VpR2tNd7Fs8yUgA0lVoSUo0VSkEZGmCLFjBw14mWI1U3P4pgoa+GKu2/XnArMftU59EEtp8239/yITzfs/3JjVGHzlv4EBQz3PPnZBZ1NgSF478UiIWpt5T1ZU0JhJGLfEXR4HOHczy1hk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hnM67xjS; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4770c34ca8eso840795e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 10:39:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761759560; x=1762364360; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u0RMEDdukqBuP/8S5mfLuGm61Krda2i2EoSkBYnqxhg=;
        b=hnM67xjSIAJ/s4ndKJdaspYTxuFl44namtLAEEKaJ0MpU8wREAPKf8GEud2U2BWeV4
         4LGUaS7SLbzBhM7dxr9w+RYO0MoyHIkmh/ImV0RXfj/r2wDWT1b21yh86A3aBgh9ITsn
         u6ayCdPfUlHO1NgupUknyOBsCW2syVBSfuKYNqnQk3UzQmQ7F/vHo92nxJeo1f9KD7xh
         3bq8SAo8OkqBq7CyeGuC8tn1JFYe2Xh4C8krr10Bk1wayTZ2NDRHSJRg10+4+3rzMzAz
         J5w7KZuuQ0wilGbGNy6BV4r3pC7/njmYZuaRBQPsMWLff3eMBhkEgEcjIy19280Ci5mq
         8LSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761759560; x=1762364360;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=u0RMEDdukqBuP/8S5mfLuGm61Krda2i2EoSkBYnqxhg=;
        b=nVLCrKk/tQwLhC9aEd+5SPc4pDofD9nzIvW/MUHlDQnbRM0Re21vUoHXzxX5lEGC4H
         wJWXkZtP4K0aecdq+DUyTnmqWMQC0YpxDBPbSYy8v+x89FKuxRzRmLE1TFqhLFYPZia0
         PBBitLfqcK8eVl+UWl4hJbpCK9+/2i0gw2B+vQ11OlTQv2uOgy8SvQGOTbPIcydL+Cah
         2FZivPEryBeq8tpoPNkWaMipaj4vPSpyCjt7IFXxXE0TAyKHNvDvf2OCc7gTlNXAQzR8
         YJ3Z4V9Z/EXbZ1zNTOqzKYLS5F/NAZabcPNrT9nSFUb/lIsyB2UEoMDc/ihJstFsKGXS
         6rnA==
X-Forwarded-Encrypted: i=1; AJvYcCVjmKXWKj11V5QazuB6EjmyOzTbQMHCt+2/3UNJlXMkNBJbGNeabRW2001h50mIdxMLPi5vT1roiIlWbsE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz073EFaQRxZVUAjgSbRTBcdUINEwmArAlLii7UI+SP+M+YPwgr
	zMgZsvw5bZlXAgm3AGpcAtFOE1jPKUpA9bPiVprnoH8VtBpV2P3RRgyM
X-Gm-Gg: ASbGncvUqg1SzavUQBEjTIKwCd72u2I7EXn1XCgg+wnV9iF7yS7BILBSHpOeSuAufxO
	HYwHWVPVl8B+b/BEaAU6ypXWrlvpY+sFyjedvCZGuFawuNtCrn4UO1igbYvLgKFUEQzh348B7+F
	Qeggdfda9uDXQUivT3/BM/SSQeQFtC3gF6aHyJpTrM0+4CAPvagnMYsijaQE2XK9OBkngDncU4X
	x0lx4EjY1uaHEbHidKS/IVbFXanPOd2zr5nRni53iuPwe49IQ9woe9U9ghLcMdujaDa60t1yq6k
	vNppHN8sEL9VHXYEHHAlhtZOQ5xEEEsyFxkO3SrV4PoHsHnQbU5+TKBV/ZkVPCbZCg7sBNY6dFS
	ax7EuaflQBLFmRdQd6Bz2I8NqUGro1JyJBQct13mw6DE+UJw4RjKfbRIsqnIC5eyBOT9U55Xv/A
	4RpbXR+Y+2n/xvE0hmPWD15mO8aCPwVqlHo8U4i+sAKtmcgxr+hyovbDZOxJLy
X-Google-Smtp-Source: AGHT+IFYEqHaRrv4oVtIJptEbue5rUEn2kWh/F/sNXC3+oJT4xx8jZmPLAz6pZX/kKSb6t0iSAncwg==
X-Received: by 2002:a05:600c:6748:b0:46e:1abc:1811 with SMTP id 5b1f17b1804b1-4771e3b7cf5mr33981705e9.27.1761759559709;
        Wed, 29 Oct 2025 10:39:19 -0700 (PDT)
Received: from snowdrop.snailnet.com (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4771e235ae1sm70646865e9.17.2025.10.29.10.39.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Oct 2025 10:39:19 -0700 (PDT)
From: David Laight <david.laight.linux@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org
Cc: David Laight <david.laight.linux@gmail.com>,
	u.kleine-koenig@baylibre.com,
	Nicolas Pitre <npitre@baylibre.com>,
	Oleg Nesterov <oleg@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Ingo Molnar <mingo@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Li RongQing <lirongqing@baidu.com>,
	Yu Kuai <yukuai3@huawei.com>,
	Khazhismel Kumykov <khazhy@chromium.org>,
	Jens Axboe <axboe@kernel.dk>,
	x86@kernel.org
Subject: [PATCH v4 next 9/9] lib: test_mul_u64_u64_div_u64: Test the 32bit code on 64bit
Date: Wed, 29 Oct 2025 17:38:28 +0000
Message-Id: <20251029173828.3682-10-david.laight.linux@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20251029173828.3682-1-david.laight.linux@gmail.com>
References: <20251029173828.3682-1-david.laight.linux@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There are slight differences in the mul_u64_add_u64_div_u64() code
between 32bit and 64bit systems.

Compile and test the 32bit version on 64bit hosts for better test
coverage.

Signed-off-by: David Laight <david.laight.linux@gmail.com>
---

Changes for v4:
- Fix build on non x86-64

 lib/math/test_mul_u64_u64_div_u64.c | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/lib/math/test_mul_u64_u64_div_u64.c b/lib/math/test_mul_u64_u64_div_u64.c
index a3c5e54f37ef..57d5c7158b10 100644
--- a/lib/math/test_mul_u64_u64_div_u64.c
+++ b/lib/math/test_mul_u64_u64_div_u64.c
@@ -74,6 +74,10 @@ done
  */
 
 static u64 test_mul_u64_add_u64_div_u64(u64 a, u64 b, u64 c, u64 d);
+#if __LONG_WIDTH__ >= 64
+#define TEST_32BIT_DIV
+static u64 test_mul_u64_add_u64_div_u64_32bit(u64 a, u64 b, u64 c, u64 d);
+#endif
 
 static int __init test_run(unsigned int fn_no, const char *fn_name)
 {
@@ -100,6 +104,12 @@ static int __init test_run(unsigned int fn_no, const char *fn_name)
 			result = test_mul_u64_add_u64_div_u64(a, b, 0, d);
 			result_up = test_mul_u64_add_u64_div_u64(a, b, d - 1, d);
 			break;
+#ifdef TEST_32BIT_DIV
+		case 2:
+			result = test_mul_u64_add_u64_div_u64_32bit(a, b, 0, d);
+			result_up = test_mul_u64_add_u64_div_u64_32bit(a, b, d - 1, d);
+			break;
+#endif
 		}
 
 		tests += 2;
@@ -131,6 +141,10 @@ static int __init test_init(void)
 		return -EINVAL;
 	if (test_run(1, "test_mul_u64_u64_div_u64"))
 		return -EINVAL;
+#ifdef TEST_32BIT_DIV
+	if (test_run(2, "test_mul_u64_u64_div_u64_32bit"))
+		return -EINVAL;
+#endif
 	return 0;
 }
 
@@ -152,6 +166,21 @@ static void __exit test_exit(void)
 
 #include "div64.c"
 
+#ifdef TEST_32BIT_DIV
+/* Recompile the generic code for 32bit long */
+#undef test_mul_u64_add_u64_div_u64
+#define test_mul_u64_add_u64_div_u64 test_mul_u64_add_u64_div_u64_32bit
+#undef BITS_PER_ITER
+#define BITS_PER_ITER 16
+
+#define mul_u64_u64_add_u64 mul_u64_u64_add_u64_32bit
+#undef mul_u64_long_add_u64
+#undef add_u64_long
+#undef mul_add
+
+#include "div64.c"
+#endif
+
 module_init(test_init);
 module_exit(test_exit);
 
-- 
2.39.5


