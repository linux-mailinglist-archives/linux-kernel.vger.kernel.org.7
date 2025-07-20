Return-Path: <linux-kernel+bounces-738012-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C9E07B0B31A
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Jul 2025 03:42:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E7B261899516
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Jul 2025 01:42:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70EA785C5E;
	Sun, 20 Jul 2025 01:41:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YALmb5YN"
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42A9F2E659
	for <linux-kernel@vger.kernel.org>; Sun, 20 Jul 2025 01:41:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752975712; cv=none; b=k0V3e67n94q2i8GDs270ER1CriTSqcDxvmtd+dlUwsC+qgVBwe4hryX82CsPnySXQJMRd1WcC/LjaXoHSmoLoZhOzBfmuxW5Ybv6oKLTGK5ZWbHyGMd//+wK4a5c8/VLHYbkMvaC02EFOqhT0TxtYV41ccX2K8JO3Gu7YNoqOXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752975712; c=relaxed/simple;
	bh=/SDkdyKaKIFEFzsZV8o1loN3ZRKVfR3GVWeCqkV7OS4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JyhD3NrfSHDw66iWW/6JX+VXWvDhVRr6m+TwMT/wrSFUWuG0+IHCyl2YzAXyZBED1x0xJtUfeMyyQGzX/kK5o7D4ru9Zl+CbqxCNRsEe3mnKh1t5MkNU4EaBXwoXsybAHtH0/AH1Uv6MBoBvT3BICuKhWQvEBb9tafInXCD61mE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YALmb5YN; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-7184015180fso38156257b3.2
        for <linux-kernel@vger.kernel.org>; Sat, 19 Jul 2025 18:41:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752975710; x=1753580510; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wzB35YwOoVMDvAldxIG/XLrrroGNc/7v4iBnS17WBts=;
        b=YALmb5YNx7wlK7nxlmU93G1gmeMQ60eCIkIVxADlW8aArDyvMLirdboRxJHdWzdPGz
         bNEsqt4zBd3f58QJvpRs/ahl1HS+PTWch2KDcAajhAHls9lmTUY3/NZU53TpKYBAt3Mm
         e78kV/6Awfr9cFg27vKqz5OnKV0VNuMZy7xul7HK07bICeecUvbdU5OfAAlsEBeX2BTq
         jknXtOrNBfQfmcALh1nDQU8K+vK4EVeA2De8nPNR8xAR23IMYFKRSm/tO0ty+bZ6j8o0
         SlmSPSrWdDgTsWtDCkXGZzlN01xJ8/NQiA4OPhrhRJloiqnmlMIGAuHsTDnQ/Ajxtxz6
         Bq7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752975710; x=1753580510;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wzB35YwOoVMDvAldxIG/XLrrroGNc/7v4iBnS17WBts=;
        b=pUQ4KECHEge6LqGT1zSoHupwp2vI1FZ5yf3lS2oQEN+q1trUke3Xl3SzkQf1nll7bw
         8xDsPlOu+LUNSW/mqVRSiYaJpCFDwXaJUcBWxasvoToa0KXDieGXRJbSseC9vqRlZdYj
         rBj9pyz5W+8M5FYwlfCR4euWUoDRBD0ROb+j6YdUsFXnlcWvErZTsaJoyznHNVsYM5FJ
         knZNXPQVwQFAmDrk0fMekXdNoMsYem772FiIf+1kOxLANd3axuW/+ZiZqN8nsC6+kZKx
         LRkn8wCIUGTeSTAnZAuS9G7mCFgTvMPHroKVxiNCVIUTeRBZtb8DazF5/BrVBNWUdT1g
         ArHw==
X-Forwarded-Encrypted: i=1; AJvYcCV1Fs0PCxTuwd0xfgKYI6Q+N6bQ3ojV4OZOga0u1yVJUY5BLdIvg2DGL5pgYf+jG/9Vs3ezvUIaPqt2tQ0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxWkb6HiNXsFVaoakM5cno+pOo2VDCRI8mpgbqRGSywVGgz2ki3
	u0Y4LB9tLFlTjsmYpZVun35T2mmBerTU2RlWDVOjqCywvxkNwDbBFyJE
X-Gm-Gg: ASbGncsc7Y2qwPzC9L+1AMbv9pg8xXlL5j5R7I5RhCL2BPG4qY/nn4U4X/aOdggSnrt
	YSql9OTPNyC9bu/0O80wS48Z22vl0rbKXMtG7i+m5OCtlv74vtm4G+E9d0k0TsxE0r15kCuGkBE
	IRa1ZXFY4rVB2qxTBfJ/xje+UturBv/iQIGvfsRDBZQqzNpiS53OT+vUh2YxzQFAY0RFgM9rgP9
	5th/GsiFm6uWX9mjd33OKY6mhUUhB1k6W7+CCtXr2gpPQxv2WZS2TX01v9Zx5Pw2hcfG7MAxuVz
	0NtpVN+o1k/rFTc3Jm4rIOeas9HVAdm/cFHM9MLvalDePsS0JnmkWpyXvcjSoXk1qDhTyCZrlQh
	8jN4L58CJicAHWw/z36aG5BHUUzBi9wrCY0cn/aTyRYqBMd8Gq87ZjkNGGQ==
X-Google-Smtp-Source: AGHT+IGkQ7yDbYo8GIf8IOIqQQGQRZLkhFebaocZD4NufEGyS+xep3AyRA1uDheAmC6Y5Jwo3eCkZQ==
X-Received: by 2002:a05:690c:2703:b0:70e:923:2173 with SMTP id 00721157ae682-718370ee35fmr155645107b3.5.1752975710121;
        Sat, 19 Jul 2025 18:41:50 -0700 (PDT)
Received: from localhost (c-73-224-175-84.hsd1.fl.comcast.net. [73.224.175.84])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e8d7cc0b159sm1499191276.9.2025.07.19.18.41.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Jul 2025 18:41:49 -0700 (PDT)
From: Yury Norov <yury.norov@gmail.com>
To: Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Andrew Morton <akpm@linux-foundation.org>,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Fernando Fernandez Mancera <ffmancera@riseup.net>,
	"Xin Li (Intel)" <xin@zytor.com>,
	x86@kernel.org,
	linux-kernel@vger.kernel.org
Cc: Yury Norov <yury.norov@gmail.com>
Subject: [PATCH 1/2] bitmap: add bitmap_weight_from()
Date: Sat, 19 Jul 2025 21:41:44 -0400
Message-ID: <20250720014146.432316-2-yury.norov@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250720014146.432316-1-yury.norov@gmail.com>
References: <20250720014146.432316-1-yury.norov@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Yury Norov (NVIDIA) <yury.norov@gmail.com>

bitmap_weight_from is useful in topo_unit_count() and potentially
more spots.

Signed-off-by: Yury Norov (NVIDIA) <yury.norov@gmail.com>
---
 include/linux/bitmap.h | 11 +++++++++++
 lib/bitmap.c           | 28 ++++++++++++++++++++++++++++
 2 files changed, 39 insertions(+)

diff --git a/include/linux/bitmap.h b/include/linux/bitmap.h
index 595217b7a6e7..3cde3bd766b7 100644
--- a/include/linux/bitmap.h
+++ b/include/linux/bitmap.h
@@ -56,6 +56,7 @@ struct device;
  *  bitmap_weight(src, nbits)                   Hamming Weight: number set bits
  *  bitmap_weight_and(src1, src2, nbits)        Hamming Weight of and'ed bitmap
  *  bitmap_weight_andnot(src1, src2, nbits)     Hamming Weight of andnot'ed bitmap
+ *  bitmap_weight_from(src, start, nbits)       Hamming Weight starting from @start
  *  bitmap_set(dst, pos, nbits)                 Set specified bit area
  *  bitmap_clear(dst, pos, nbits)               Clear specified bit area
  *  bitmap_find_next_zero_area(buf, len, pos, n, mask)  Find bit free area
@@ -181,6 +182,8 @@ unsigned int __bitmap_weight_and(const unsigned long *bitmap1,
 				 const unsigned long *bitmap2, unsigned int nbits);
 unsigned int __bitmap_weight_andnot(const unsigned long *bitmap1,
 				    const unsigned long *bitmap2, unsigned int nbits);
+unsigned int __bitmap_weight_from(const unsigned long *bitmap,
+					unsigned int start, unsigned int nbits);
 void __bitmap_set(unsigned long *map, unsigned int start, int len);
 void __bitmap_clear(unsigned long *map, unsigned int start, int len);
 
@@ -446,6 +449,14 @@ unsigned int bitmap_weight(const unsigned long *src, unsigned int nbits)
 	return __bitmap_weight(src, nbits);
 }
 
+static __always_inline
+unsigned int bitmap_weight_from(const unsigned long *src, unsigned int start, unsigned int nbits)
+{
+	if (small_const_nbits(start + nbits - 1))
+		return hweight_long(*src & GENMASK(start + nbits - 1, start));
+	return __bitmap_weight_from(src, start, nbits);
+}
+
 static __always_inline
 unsigned long bitmap_weight_and(const unsigned long *src1,
 				const unsigned long *src2, unsigned int nbits)
diff --git a/lib/bitmap.c b/lib/bitmap.c
index b97692854966..eb9905071e3b 100644
--- a/lib/bitmap.c
+++ b/lib/bitmap.c
@@ -335,12 +335,40 @@ EXPORT_SYMBOL(__bitmap_subset);
 	w;									\
 })
 
+#define BITMAP_WEIGHT_FROM(FETCH, start, bits)					\
+({										\
+	unsigned long __start = (start), __bits = (bits);			\
+	unsigned int idx, w = 0;						\
+										\
+	if (unlikely(__start >= bits))						\
+		goto out;							\
+										\
+	idx = __start / BITS_PER_LONG;						\
+	w = (FETCH) & BITMAP_FIRST_WORD_MASK(__start);				\
+										\
+	for (++idx; idx < __bits / BITS_PER_LONG; idx++)			\
+		w += hweight_long(FETCH);					\
+										\
+	if (__bits % BITS_PER_LONG)						\
+		w += hweight_long((FETCH) & BITMAP_LAST_WORD_MASK(__bits));	\
+										\
+out:										\
+	w;									\
+})
+
 unsigned int __bitmap_weight(const unsigned long *bitmap, unsigned int bits)
 {
 	return BITMAP_WEIGHT(bitmap[idx], bits);
 }
 EXPORT_SYMBOL(__bitmap_weight);
 
+unsigned int __bitmap_weight_from(const unsigned long *bitmap,
+					unsigned int start, unsigned int bits)
+{
+	return BITMAP_WEIGHT_FROM(bitmap[idx], start, bits);
+}
+EXPORT_SYMBOL(__bitmap_weight_from);
+
 unsigned int __bitmap_weight_and(const unsigned long *bitmap1,
 				const unsigned long *bitmap2, unsigned int bits)
 {
-- 
2.43.0


