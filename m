Return-Path: <linux-kernel+bounces-887239-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F676C37A4D
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 21:12:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4A70B4EB652
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 20:11:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BB9D345CB9;
	Wed,  5 Nov 2025 20:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K6L8TGAq"
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3E6D311C17
	for <linux-kernel@vger.kernel.org>; Wed,  5 Nov 2025 20:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762373455; cv=none; b=TOFv+ug2QNkDAhBHxLOKEQzgMu3hhQlhxHminbVqD4roS8JuDK2ZMvHuUdJmNnA5iOlYIemzrtrjb9Jz4B6WdNFQcRc+M5om8GEyre4c1aMJAFH92YX2eTUxcpKtMldJoXePxQEiAzdu/YCMQOqacYzm/Q/3DZnhtTWhDYUUJfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762373455; c=relaxed/simple;
	bh=zXxfYSuarlcdX7wkRJ5fQQu9ihnL5EPvoYU9sZehLCY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=E8MfEQRgS61f9dTHRaA0pZhLveM/BGHem61iLmpcgNoP6ksSll30V07/dq1unpmB89pCeWRLLfk6ZGDx131mmu63nOYBj6QUnPBWyqXyLx799ov7/ix07pEkceqciPxOelql+V584/bpCe1y3/bB3knS1nJqL7VzemwagSpj8nQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K6L8TGAq; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-429c2f6a580so219328f8f.1
        for <linux-kernel@vger.kernel.org>; Wed, 05 Nov 2025 12:10:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762373452; x=1762978252; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wd2SwmO3s42C6B+THDT/QkC+mSXRUeoaYVSZH4hdUjs=;
        b=K6L8TGAqIa8ZgPdm1d6KhupvbsrX1ngc6RwWsv8QTS4QlHTl7Ao1Tn0M2YWMi9IJzh
         KmC+P7+8G2r9g/0d8ka+1kNN2Ni+kP2cvMChZnjlYUg0SBAd34m1bTi/6l9FQ+OW+8mt
         4GHGqedT4SmvjRwl5luE64pJqtEaIwPRzhKjuGoOUUQjFad8I7LhwRx48qbViFQfPeCI
         wByVK27OjXDr1m9Z+HCiTinJMmtCd8B1O2WWhakFj7mi7QZBAuXttJebcBApXWpCf71+
         7uQOOpUz54L5fXOqTb9Z4LDpUnMSwNseLNAL5UbKJ8XGvUQQsswheIJlm6+mMU5P3ogv
         Vlxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762373452; x=1762978252;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wd2SwmO3s42C6B+THDT/QkC+mSXRUeoaYVSZH4hdUjs=;
        b=abrWT5IpEfYvOCHxudtVkGw0svs9b3qvGXLiQePS2prMLzudYuEZu6xObWunN9IPMZ
         p+2NBmj/XlYTqCBn/y8ukO73/tHknfJW06Ooba4wGruwhuOnP1Gc7tf3NMa17hU9hWvO
         xV7XAeKkVYbtZqz/KcQeVw9t5omeh8o64vulU0vkvrLwEIBuSHb6aJSU92T5xaBv/P/C
         gFa1oAcY70AQSzEOYnOrWiDy0BHhrXmtuJjfzgYHNHghjIhQ2xVUPsxsRXl4fYwazT+P
         7lQZuFk1ctrijUNic0ZxJKs9YDVgRarBzaJhEj/fBfcv82UGBzDIiWDDvMR1aaou1fUR
         KfwQ==
X-Forwarded-Encrypted: i=1; AJvYcCWFgwV8jhuLwJ0g7yOWc9Rn16ORSBT0Ze/IAv8Wefc7N2ZGSmQ077ZeoAZv7wftjVVAesRX4pIHVWlX2yA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyARw2s+TPA5xVax7TUJDkAJ8cGDcKq2K+PPtz/0CTp435CDhxD
	hdM8SWEm33l+euy8qPX3fDHRk15J7+FrVUw890ZUq4Krx4bZsbrQvY2Q
X-Gm-Gg: ASbGncv7Wxha8hlgjCb1txVjZCCC/gylRYsT5y/1pzf0IeRsfVr7yx9Nx9GkjxF2Dz+
	7F4AbTDlEw+HnA4KAzpLWknghQ+eaCdmMjjEDNjS+RyxgRxNgD+cp3jT7yJUuMdJy0aOuqXwlqL
	8IRvX/h0cSzM7cy7N9J0obZgRrTNXOmdw/fIXqtCqrv9UQcV2YRD6ABAjT86bcjWCQJGrYQ89vN
	YA4XaUai/WFlbtGEBTC9eA/zBx2sxa+ZgUDurMzM57azHue6+1EBY7euPuZUANJGHm38Qykorx1
	0tRs1v7m7ORpldTQNWuvK0AW7YnijFhyXV7RyWSZBAyf8I6CiuU4Jb/LOl7IKALOhb1RdeE9W+1
	pvR4ByWDF7TWCj53AgPuFJYht57Y3bT27YPgTjVqr4I4VdbNlliDAIZATrVY5kPUgJflopf+4IQ
	Ejpdn0AzqKV0X3UWiw5sMRBYYi4C6kbXtplTAlq4qVr/Mq+4bVu8QT6H4E8RAavA==
X-Google-Smtp-Source: AGHT+IG/v2aU/SD3lKp9paG2qiBsbug343WJyIT+sF8b2IVKz7rvwz5faz/6qSbgxne+g0g++yxLJw==
X-Received: by 2002:a05:6000:42ca:b0:429:c851:69a3 with SMTP id ffacd0b85a97d-429e32dd891mr2286605f8f.6.1762373451981;
        Wed, 05 Nov 2025 12:10:51 -0800 (PST)
Received: from snowdrop.snailnet.com (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429eb41102bsm619857f8f.17.2025.11.05.12.10.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Nov 2025 12:10:51 -0800 (PST)
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
	Khazhismel Kumykov <khazhy@chromium.org>,
	Jens Axboe <axboe@kernel.dk>,
	x86@kernel.org
Subject: [PATCH v5 next 1/9] lib: mul_u64_u64_div_u64() rename parameter 'c' to 'd'
Date: Wed,  5 Nov 2025 20:10:27 +0000
Message-Id: <20251105201035.64043-2-david.laight.linux@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20251105201035.64043-1-david.laight.linux@gmail.com>
References: <20251105201035.64043-1-david.laight.linux@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Change to prototype from mul_u64_u64_div_u64(u64 a, u64 b, u64 c)
to mul_u64_u64_div_u64(u64 a, u64 b, u64 d).
Using 'd' for 'divisor' makes more sense.

An upcoming change adds a 'c' parameter to calculate (a * b + c)/d.

Signed-off-by: David Laight <david.laight.linux@gmail.com>
Reviewed-by: Nicolas Pitre <npitre@baylibre.com>
---
 lib/math/div64.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/lib/math/div64.c b/lib/math/div64.c
index bf77b9843175..0ebff850fd4d 100644
--- a/lib/math/div64.c
+++ b/lib/math/div64.c
@@ -184,10 +184,10 @@ u32 iter_div_u64_rem(u64 dividend, u32 divisor, u64 *remainder)
 EXPORT_SYMBOL(iter_div_u64_rem);
 
 #ifndef mul_u64_u64_div_u64
-u64 mul_u64_u64_div_u64(u64 a, u64 b, u64 c)
+u64 mul_u64_u64_div_u64(u64 a, u64 b, u64 d)
 {
 	if (ilog2(a) + ilog2(b) <= 62)
-		return div64_u64(a * b, c);
+		return div64_u64(a * b, d);
 
 #if defined(__SIZEOF_INT128__)
 
@@ -212,37 +212,37 @@ u64 mul_u64_u64_div_u64(u64 a, u64 b, u64 c)
 
 #endif
 
-	/* make sure c is not zero, trigger runtime exception otherwise */
-	if (unlikely(c == 0)) {
+	/* make sure d is not zero, trigger runtime exception otherwise */
+	if (unlikely(d == 0)) {
 		unsigned long zero = 0;
 
 		OPTIMIZER_HIDE_VAR(zero);
 		return ~0UL/zero;
 	}
 
-	int shift = __builtin_ctzll(c);
+	int shift = __builtin_ctzll(d);
 
 	/* try reducing the fraction in case the dividend becomes <= 64 bits */
 	if ((n_hi >> shift) == 0) {
 		u64 n = shift ? (n_lo >> shift) | (n_hi << (64 - shift)) : n_lo;
 
-		return div64_u64(n, c >> shift);
+		return div64_u64(n, d >> shift);
 		/*
 		 * The remainder value if needed would be:
-		 *   res = div64_u64_rem(n, c >> shift, &rem);
+		 *   res = div64_u64_rem(n, d >> shift, &rem);
 		 *   rem = (rem << shift) + (n_lo - (n << shift));
 		 */
 	}
 
-	if (n_hi >= c) {
+	if (n_hi >= d) {
 		/* overflow: result is unrepresentable in a u64 */
 		return -1;
 	}
 
 	/* Do the full 128 by 64 bits division */
 
-	shift = __builtin_clzll(c);
-	c <<= shift;
+	shift = __builtin_clzll(d);
+	d <<= shift;
 
 	int p = 64 + shift;
 	u64 res = 0;
@@ -257,8 +257,8 @@ u64 mul_u64_u64_div_u64(u64 a, u64 b, u64 c)
 		n_hi <<= shift;
 		n_hi |= n_lo >> (64 - shift);
 		n_lo <<= shift;
-		if (carry || (n_hi >= c)) {
-			n_hi -= c;
+		if (carry || (n_hi >= d)) {
+			n_hi -= d;
 			res |= 1ULL << p;
 		}
 	} while (n_hi);
-- 
2.39.5


