Return-Path: <linux-kernel+bounces-887247-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BADEBC37A58
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 21:13:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8F4A53A1E1C
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 20:12:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C80034C819;
	Wed,  5 Nov 2025 20:11:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bnmqisLF"
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFC5C30CDB9
	for <linux-kernel@vger.kernel.org>; Wed,  5 Nov 2025 20:10:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762373461; cv=none; b=ELYyDzfzPYOzQtylasA+DDeF4Cfr03NsnZBwfyD/FIL1Bct4Gaxt28pgxJwoKYfa/Snp3HoSeUrx49MX4GW8I4PDXtd7JfZXFRBQjuNIq8tHFaFWPhAJP08HQfcp+SmfZHmdGCft0hx/lJaqe6AElbLsghbOcbHGAfdD9z+CKXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762373461; c=relaxed/simple;
	bh=HVjUwdOw78msn3/jdQXnWRqAvOvh+8n3kTj/k7a1RvQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PRPBoWPDuODTOQHxDbUnlnLWIeEpUllOh+Hcd/AETvzD3/UVQNn9MRzG5gDzrmzLeYFekYsFxS3ZmjKwhEnq9qKbc2GRx3iSWwR5BvuHk27DLEuGspWRN/EtBC42GUHJd1v77/rGn4O2Ck9yTDsawE2FZxmNu5xWzNDNWRE8xzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bnmqisLF; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-429bccca1e8so171299f8f.0
        for <linux-kernel@vger.kernel.org>; Wed, 05 Nov 2025 12:10:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762373458; x=1762978258; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lfqqsBnisQAavJV9LRrMQzrEZPCcNFYgFzwVnKLBfWg=;
        b=bnmqisLFrRS5wl2hXc6eIhWsvIvlvWLatg3Nd7KQ/5f9d3YQ45HZrFzccW5HKd7Oux
         XeqmcFrzpoqwoocqQA4pFF/bkSHtwCJb/ioOpAwf3zGFperc53lkZ5dmt9Uamqvfm4Xy
         75VV+2TAEmRV+n+1PTvPcIo/NWwB7yRF+awABKkhi1hTrinb32A1aX66A5ltl9YvgfQ5
         nDxwBFm+i40YwF2du8YS1udoNck6R9x8daqgfY7KdKyZbiAZWrAzQn0uIa8ClZ1ptDLx
         U9pjink9krsakUnBTiYmdmE2kaj/Ps2yYWQ6+JAAH8ZW8qs+TylURPFlwaRi2ja7IsGg
         RFWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762373458; x=1762978258;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lfqqsBnisQAavJV9LRrMQzrEZPCcNFYgFzwVnKLBfWg=;
        b=K40FYglvgjtHBSJLkpsiAexMEIr9POCDpMXXVDfjUhfCelvPqAeyvv0EdaOmc5S8IV
         3o5w1Ipk+DjMLmtT1RLb7TN3n2eC2fq9PdNpLbOMnD+x+YuJq/UTZqne6cqTXhpW/6Vn
         t7rv4miaOaPGcXKocjB484bl12Gy5TQJlDMUOb/tvJrz+LTrtm16WAO/DLcYmgy9iqLN
         QMXOzgdUwLi7D9Lc/dBX8wRj95Pv1FOmdU7tqHNEopaBd3NHIocKF+6rcDyeb5YUOFvU
         xoja8FFtQYpA+oc9diGdzEttAdFgq7pYo5b8xjWUbYqerzPExG3xn7OIeoRyfgDdoCMo
         Pi+A==
X-Forwarded-Encrypted: i=1; AJvYcCUp20yUWBqe8+ccdYcarMFm/OiJtmt/AYsE6Iwgc+uKzPdVMA6DxklWFJZ0Fa7KzsGWRRyxThTynL+Xlw4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzkNrOTX57TJAL8q6itsxNQOW1a/3TZt608op9lidGLsdCCYFoi
	Oyh/gxHf16El5OV1gYVuvbJun6JjUj3xqgu0XMpTqMe3DPbqBoD8Luhe
X-Gm-Gg: ASbGncttz1cIWsQHU2SeD/vT0389UJ9P5BwEImcSjrsmPMvWCzqPAh3vQXNLUS9TkvK
	7jAWR6oROXqZKBNRGOrtUv4UV+iDcqv3ZMX5/ENwXdfLqmgBWY5zKqlgPslre9iOd5wl0OyxibX
	sHRtjXk9UCLrtupavkF+mDif8gWTl37JGUhOnndo6jrZbnHR1ePLyqhCRV2iafLvMPpSsm1Ou+x
	pQHVP1xxs7LvNPpGH42tlglqfOUp1UXPl19mB83Os6G5RMb1k5TqN/eulAizdsZKQRkj4LvYz+W
	Xm6yIO/L2nEBg+kZMkTyWbZFAVARWYl5zJexgKAkoHxOMFnSgg04dgPi+ydxyBFZA8BTquf53D8
	keI7UYzROp4U7fVTAEZ1D9MPrBHuoImYXTlYMe5if/PX+y63UlkAoaFufBvXlUO75gEJalr+ui+
	iJ3QHZSJsg29RZoiuEF9gFqqeeAY2qMH9ngMDMi0WuwQWHp8ts2soUgCWlmk3vt0xuO3L0gRrM
X-Google-Smtp-Source: AGHT+IE3JU2/MHg/OIZde/XCPMdKXkgSkZSj6exPteW1+q13R6TsC2yTPJbcDctJMHoID6XiIDqcVg==
X-Received: by 2002:a05:6000:178a:b0:426:d82f:889e with SMTP id ffacd0b85a97d-429e32e3fb0mr4204906f8f.14.1762373457967;
        Wed, 05 Nov 2025 12:10:57 -0800 (PST)
Received: from snowdrop.snailnet.com (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429eb41102bsm619857f8f.17.2025.11.05.12.10.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Nov 2025 12:10:57 -0800 (PST)
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
Subject: [PATCH v5 next 9/9] lib: test_mul_u64_u64_div_u64: Test the 32bit code on 64bit
Date: Wed,  5 Nov 2025 20:10:35 +0000
Message-Id: <20251105201035.64043-10-david.laight.linux@gmail.com>
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

There are slight differences in the mul_u64_add_u64_div_u64() code
between 32bit and 64bit systems.

Compile and test the 32bit version on 64bit hosts for better test
coverage.

Signed-off-by: David Laight <david.laight.linux@gmail.com>
Reviewed-by: Nicolas Pitre <npitre@baylibre.com>
---

Changes for v4: 
- Fix build on non x86-64

 lib/math/test_mul_u64_u64_div_u64.c | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/lib/math/test_mul_u64_u64_div_u64.c b/lib/math/test_mul_u64_u64_div_u64.c
index d8d2c18c4614..338d014f0c73 100644
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
 
@@ -153,6 +167,21 @@ static void __exit test_exit(void)
 
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


