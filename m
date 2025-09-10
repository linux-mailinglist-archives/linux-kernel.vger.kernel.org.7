Return-Path: <linux-kernel+bounces-811041-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B4F2B52350
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 23:09:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8410E1BC2099
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 21:09:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C529C3093B2;
	Wed, 10 Sep 2025 21:08:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b45hZ9xN"
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82407308F08
	for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 21:08:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757538538; cv=none; b=XyoKgP6ltDd9I4URfaY6l5K4lgbpQMo2lR5U4EKb5oJQmEW/LlXwtKyb8G2EFblZ6fVq+lo9mSGxglnUJaaQreIJWWgr2kZ5JzAlqpaVOOQ6iWMHkVQS3z8e40cIWnkTOrzfJqJv0t1+y4Lz1lBJuxl2WwOCcqVKm4xFMNI3/ZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757538538; c=relaxed/simple;
	bh=1Q/a3h/EZLDdL/iDtMeose6z/HkLi1zASjsW2HRieAs=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eftaQQC9HblABwMubXYo1IqHRDfMaFPYP8XaOozdbgPZ1TZTXrOiiJE6Bv7hkIfQtswDyuXnkAmzFJkt1T8ZmRLJkVrg4g8WaLEL/QhYd54QWOHD6dlK+HBThJOOgqd7YJSIm7zO58JQaSf/X+EtK5JewmjDCj9W4DX63uJ2WfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b45hZ9xN; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-b52403c47b7so53329a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 14:08:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757538536; x=1758143336; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PoU41vAOIpVNELj4irIC4q3Jm1Ldsh0LgzJx2OMnxMY=;
        b=b45hZ9xNzeoz+nskHAJV3qMhLeZbUjSrKD7hNY1fAWaKwrOh7pnAjkZFFdoD8Hvxcz
         fk97zGunuQQHw9i1xCHbZCQHQNmZ9gngOyQ16eChx2OX9dvjLo1RDWfOhp5Kow1qsBqr
         EWICLVHrdaDcsEo3RPcr+o86igFt1W/Dxq6cpD8EXVfa6mer2aDnBR9/LHGzG6uxzWd3
         cuEnlpeL/pELdI1z4ssGer6du4ZCgUBoXuCT4zv1dIHoj5lRqHnohwqvdxwafgK5++Uv
         zhebMwQrsgwv6esWofpkSZCL+uqjoPJH2QRI7lzzuJoK9LsuueTefPpKtvMwtmgSiDAB
         Ofxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757538536; x=1758143336;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PoU41vAOIpVNELj4irIC4q3Jm1Ldsh0LgzJx2OMnxMY=;
        b=tBQRLLvYJPLrcO4Qs1hroINAyYxV+3sap4ft4MWQtKtqIJv7DVzrh6Ldc83s0U9YCI
         8CaQeZrVAiB4DA/oaYfD4089C/zuwWEId23OU2cQFeVt1d4ZSK6p6ENGsAC/qYS2yGiM
         xa7/kTS4552DQUCNmNWUDgGiMEdFfM1ddhqP94AWAtSFsTVxVjsngxWVBSNCbhcB/f9U
         8DhdItfLLbUWC/7yAfGdE1Aes4tFQucSpNbRrg9+rYSi7m5dkUcV3F4UYQQcHRFza3He
         IeHUrnWg6qURh4SDevpwfpEiBATBh2Z1qzH38UTHnP60S+HmoUFgszQyKlquCqsZJ+zt
         Q8bA==
X-Forwarded-Encrypted: i=1; AJvYcCW0UM5tlcgIqT9iWK6TpIaCnyFexCATtu1zHsxLoIXD/0zI/7UNccVeSutUMD2tpK3zVU3DqyLmOm8PGok=@vger.kernel.org
X-Gm-Message-State: AOJu0YyvRfg6OVnI0gQV4dSd7SoR1nIHlJA2nRCiLeb3ToBfrmhN1qN/
	8cW9u8Q1PPNDbuIxbj+ZIx7K+Sh/Zo2hzPwjPhq7rmdgkgt4Xlod93VM
X-Gm-Gg: ASbGncvUIkT4x/kyEv7EI5t1yJuUWfN6VAXHf9OshY7HD3Zx2sUl8dVg7lc4e2G1JRk
	5BCif4iJFv8FuBWTEhbrzx2XQduXaAQp/s4sLUZWPwDJPwuT17vzCXuNsHvBQzNqRNGAL3I5Mea
	iCwJ4FsXAdjuQNB+P1U2fHUy+Yvqx7uyIK3+tvbmqQYBIo6s4PJktjHyyJyLp3koEU6iqKtKp0s
	h06fyjD2NQYlAANKeJcSqsFs9IveoEzf1TGdYxYXcck2H9lIzSTWFCKi0DWRX43TINCgTwhMakl
	wTK5ooUnaUM1qHZ/3w5nva9/6D80S/nalOfnsvr8N4BdPmUujqInniUUDblmbt7lFGyFFrh5MKD
	J5nW/3xxJ62TJOFPED6Q2BQjPuqNE7EECnsjdRSUJGc8=
X-Google-Smtp-Source: AGHT+IFYpcOfe8s8u6cl2CiV5vYRwJC0Ntokhz++l2ArSWZj7u6JOJ8cTNyyBkVu0U+vkZheGKRhlw==
X-Received: by 2002:a17:903:2fca:b0:249:1128:582f with SMTP id d9443c01a7336-25badb4524cmr7380945ad.17.1757538535649;
        Wed, 10 Sep 2025 14:08:55 -0700 (PDT)
Received: from localhost ([216.228.125.130])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-25a2a345072sm36079545ad.77.2025.09.10.14.08.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Sep 2025 14:08:55 -0700 (PDT)
From: Yury Norov <yury.norov@gmail.com>
To: Thomas Gleixner <tglx@linutronix.de>,
	Yury Norov <yury.norov@gmail.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] bitmap: cpumask: introduce and_andnot search helper and iterator
Date: Wed, 10 Sep 2025 17:08:46 -0400
Message-ID: <20250910210850.404834-2-yury.norov@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250910210850.404834-1-yury.norov@gmail.com>
References: <20250910210850.404834-1-yury.norov@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Yury Norov (NVIDIA)" <yury.norov@gmail.com>

Like other similar iterators, it helps to get rid of temporary
on-stack bitmaps and associate housekeeping code.

Signed-off-by: Yury Norov (NVIDIA) <yury.norov@gmail.com>
---
 include/linux/cpumask.h | 22 ++++++++++++++++++++++
 include/linux/find.h    | 38 ++++++++++++++++++++++++++++++++++++++
 lib/find_bit.c          |  9 +++++++++
 3 files changed, 69 insertions(+)

diff --git a/include/linux/cpumask.h b/include/linux/cpumask.h
index ff8f41ab7ce6..8f8cb29d56d9 100644
--- a/include/linux/cpumask.h
+++ b/include/linux/cpumask.h
@@ -406,6 +406,28 @@ unsigned int cpumask_random(const struct cpumask *src)
 #define for_each_cpu_and(cpu, mask1, mask2)				\
 	for_each_and_bit(cpu, cpumask_bits(mask1), cpumask_bits(mask2), small_cpumask_bits)
 
+/**
+ * for_each_cpu_and_andnot_from - iterate over every cpu in all masks
+ * @cpu: the (optionally unsigned) integer iterator
+ * @mask1: the first cpumask pointer
+ * @mask2: the second cpumask pointer
+ * @mask3: the third cpumask pointer
+ *
+ * This saves a temporary CPU mask in many places.  It is equivalent to:
+ *	struct cpumask tmp;
+ *	cpumask_and(&tmp, &mask1, &mask2);
+ *	cpumask_andnot(&tmp, &tmp, &mask3);
+ *	for_each_cpu_from(cpu, &tmp)
+ *		...
+ *
+ * After the loop, cpu is >= nr_cpu_ids.
+ */
+#define for_each_cpu_and_andnot_from(cpu, mask1, mask2, mask3)				\
+	for_each_and_andnot_bit_from(cpu, cpumask_bits(mask1),				\
+					  cpumask_bits(mask2),				\
+					  cpumask_bits(mask3),				\
+					  small_cpumask_bits)
+
 /**
  * for_each_cpu_andnot - iterate over every cpu present in one mask, excluding
  *			 those present in another.
diff --git a/include/linux/find.h b/include/linux/find.h
index 9d720ad92bc1..d43c811aef5c 100644
--- a/include/linux/find.h
+++ b/include/linux/find.h
@@ -14,6 +14,9 @@ unsigned long _find_next_and_bit(const unsigned long *addr1, const unsigned long
 					unsigned long nbits, unsigned long start);
 unsigned long _find_next_andnot_bit(const unsigned long *addr1, const unsigned long *addr2,
 					unsigned long nbits, unsigned long start);
+unsigned long _find_next_and_andnot_bit(const unsigned long *addr1, const unsigned long *addr2,
+					 const unsigned long *addr3, unsigned long size,
+					 unsigned long n);
 unsigned long _find_next_or_bit(const unsigned long *addr1, const unsigned long *addr2,
 					unsigned long nbits, unsigned long start);
 unsigned long _find_next_zero_bit(const unsigned long *addr, unsigned long nbits,
@@ -135,6 +138,36 @@ unsigned long find_next_andnot_bit(const unsigned long *addr1,
 }
 #endif
 
+/**
+ * find_next_and_andnot_bit - find the next set bit in *addr1 and *addr2
+ *			       excluding all the bits in *addr3
+ * @addr1: The first address to base the search on
+ * @addr2: The second address to base the search on
+ * @addr3: The third address to base the search on
+ * @size: The bitmap size in bits
+ * @offset: The bitnumber to start searching at
+ *
+ * Returns the bit number for the next such bit
+ * If no bits found, returns >= @size.
+ */
+static __always_inline
+unsigned long find_next_and_andnot_bit(const unsigned long *addr1,
+		const unsigned long *addr2, const unsigned long *addr3,
+		unsigned long size, unsigned long offset)
+{
+	if (small_const_nbits(size)) {
+		unsigned long val;
+
+		if (unlikely(offset >= size))
+			return size;
+
+		val = *addr1 & *addr2 & ~*addr3 & GENMASK(size - 1, offset);
+		return val ? __ffs(val) : size;
+	}
+
+	return _find_next_and_andnot_bit(addr1, addr2, addr3, size, offset);
+}
+
 #ifndef find_next_or_bit
 /**
  * find_next_or_bit - find the next set bit in either memory regions
@@ -595,6 +628,11 @@ unsigned long find_next_bit_le(const void *addr, unsigned
 	     (bit) = find_next_andnot_bit((addr1), (addr2), (size), (bit)), (bit) < (size);\
 	     (bit)++)
 
+#define for_each_and_andnot_bit_from(bit, addr1, addr2, addr3, size)			\
+	for (; (bit) = find_next_and_andnot_bit((addr1), (addr2), (addr3),		\
+						 (size), (bit)), (bit) < (size);	\
+	       (bit)++)
+
 #define for_each_or_bit(bit, addr1, addr2, size) \
 	for ((bit) = 0;									\
 	     (bit) = find_next_or_bit((addr1), (addr2), (size), (bit)), (bit) < (size);\
diff --git a/lib/find_bit.c b/lib/find_bit.c
index d4b5a29e3e72..aec79207c566 100644
--- a/lib/find_bit.c
+++ b/lib/find_bit.c
@@ -206,6 +206,15 @@ unsigned long _find_next_andnot_bit(const unsigned long *addr1, const unsigned l
 EXPORT_SYMBOL(_find_next_andnot_bit);
 #endif
 
+unsigned long _find_next_and_andnot_bit(const unsigned long *addr1,
+					const unsigned long *addr2,
+					const unsigned long *addr3,
+					unsigned long nbits, unsigned long start)
+{
+	return FIND_NEXT_BIT(addr1[idx] & addr2[idx] & ~addr3[idx], /* nop */, nbits, start);
+}
+EXPORT_SYMBOL(_find_next_and_andnot_bit);
+
 #ifndef find_next_or_bit
 unsigned long _find_next_or_bit(const unsigned long *addr1, const unsigned long *addr2,
 					unsigned long nbits, unsigned long start)
-- 
2.43.0


