Return-Path: <linux-kernel+bounces-870053-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 61B68C09C80
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Oct 2025 18:56:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F384F5843B9
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Oct 2025 16:47:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6783D31062C;
	Sat, 25 Oct 2025 16:40:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ln/OxjXg"
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B7573101B4
	for <linux-kernel@vger.kernel.org>; Sat, 25 Oct 2025 16:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761410450; cv=none; b=BgQKRydvXz9fLtp0N8Ow2UXia4zgyDcHmFEvG1ZNjEMLQNxWcY2iPFH4cVhvEwq/BtcExkxJPBAZ74c7brPnrLZWpVqRDrVQFas4YfN6fI0DRfp6RfqnX7XV9yhRjYbBhtXd29tIdffNp9Zm3bTjfgh6IL5nKTZePU6O322xlFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761410450; c=relaxed/simple;
	bh=TQ6xv3dIaxpajiHEhlYy8yfOY1BsNMosBwcumiYnhcI=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Hx9C9VCwdnfSJNa2Hfb71EgKrNKFHqZ2X52jpL9XiFtV9fmJ7n7q6Qa4F8cV0rU81gOSRm+jHXsCsD+G0eZte8T8vIlZggZrL7Q3eOI4YIVpoFgiOAW7Gs7CkPdkErLEnrIRIpqMsUSl+MjmQc2hGUHU9esEOcqb8ztpcWQJ8cQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ln/OxjXg; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-891667bcd82so404806785a.1
        for <linux-kernel@vger.kernel.org>; Sat, 25 Oct 2025 09:40:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761410448; x=1762015248; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7/JFSnIjaD6DTDEOO1oZNxHniLLcLZti7jNstgpjRDc=;
        b=Ln/OxjXgsOPS2s9LFBtqbJKkYsSJV7QxVb1DON30EnuJXURjWtTy8Tf7JuOPBPUSPA
         grM4G/+m4E34rHzlV3dFG07sh7Ym1qqwtujngCZMj+jnQFldnuYMBH18OusDE6uySlaK
         e+xXYTMUlXKsbGSlYYZ8zNW6C1gMN8oOhqaVCuBRpugP2vWN8vMcVycEkoZE1q07sCzu
         PjcyC9oOl1GGemEx6ZAb/1K3upFglkSzTX4rwo1SNI2FOpR3sSAqlB2bPLbn++iZxmJH
         xRxqkhaMt8r5URdZCVhjePinplkH9VhtWhlVPbxeZn0ySWYVSJj8zXa3qJOJn8zmLW1E
         dy8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761410448; x=1762015248;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7/JFSnIjaD6DTDEOO1oZNxHniLLcLZti7jNstgpjRDc=;
        b=OXwdHRjPshN9Q9iK+6Or14xRAkf4NQn5Tg8VCIMiTtBF21GcRs2IupqJzzZiGUwN8Z
         51tNucnBHqmZVckG9UGQp355uMBbizt/C6dl1npqZ+2XRDJ1+MYxhjeJBt2AqEvm+2ME
         z8JHV//jG8ukNg6jpoZAh7nxV1ADrOoJ7m2qFczv0cQfxo5c3kZTRXZJYDwIzvwK0ugH
         XoylW5cgITvY0v8Jku/Vomg+LhPOItJ3AWvHl9u6Y9YkfyB7ayleTY+k6az2wYT7hmcA
         0YaBxZxIGW4Lv1UrdtDCS/0WJ3XmxfwZ/O489h0fye/RgFxUJU6aQdoOVEI6a3LklwsU
         g8ag==
X-Forwarded-Encrypted: i=1; AJvYcCUPxWv94ueVR9HQxFJVM0asptKlimRxR+GXpcB4v9PrjBVyedrY13cRXtFtr4SJXv16hY8JJcgXAk0h6fE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxyuE5lohqA1Ci8/sYgLNFim/y+DXtwxe1bz1QVd9BXhNOpFgh1
	scjyo1cLM3/zqSVfKrz0qU8krmWU0aDzDES4rgMcGZkzOIHyO6k6DegE
X-Gm-Gg: ASbGncvZ3M/RdRd/YZnLxbP69/y+FSFIg1CTeGreDXw3QA1WBoynv0pSx5nCmVLQonS
	xFGnJqNkqQ4hFWML6mGc0IPeVJj4SuoBOuQN77ZPG6kUk23Bc1CB5sEuM/fgGP/mEIFKNg7BgsR
	/ae9D/owWHySDQRP581iK7qY/u/g/UeHPzpaFGX6J9CZLpI0qdphFe9pn0TzScOPbm4EcMpkiO7
	RXfW/lZT4nGxy1kGPttyvLejWhaFYTz9UsCt9kK2nUS6s6scXn+fgShASztbH69NpuwMmnDFnpK
	LecmC3Cf90DXLhB5dc/fSz/2bkhTRuiOmC7qnyKiZ1eMTWl85GEBkjFBWqsTDI9tTf3Dv+vHca/
	nPbnP7ASct/uQeKSHd5UJJK/3ykw9rNHY/LFxgFMc39oiYysxzkXK7B2VSsR06TrYnRGGkE71xz
	1zFQFs8nw=
X-Google-Smtp-Source: AGHT+IE7AlR8jMohfV6h5jj0NgFvybCbCIQqSaGfiLRRZ1bsf15FEk08CzXrd6JfM3gPkthDb4WjTg==
X-Received: by 2002:a05:620a:44d3:b0:89d:3318:a811 with SMTP id af79cd13be357-89da08560d8mr834089585a.15.1761410448026;
        Sat, 25 Oct 2025 09:40:48 -0700 (PDT)
Received: from localhost ([12.22.141.131])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-89f2421fc4csm174332885a.10.2025.10.25.09.40.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Oct 2025 09:40:47 -0700 (PDT)
From: "Yury Norov (NVIDIA)" <yury.norov@gmail.com>
To: Linus Torvalds <torvalds@linux-foundation.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Nicolas Frattaroli <nicolas.frattaroli@collabora.com>,
	Yury Norov <yury.norov@gmail.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 09/21] bits: generalize BITMAP_{FIRST,LAST}_WORD_MASK
Date: Sat, 25 Oct 2025 12:40:08 -0400
Message-ID: <20251025164023.308884-10-yury.norov@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251025164023.308884-1-yury.norov@gmail.com>
References: <20251025164023.308884-1-yury.norov@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The macros are helpful in many non-bitmap places too. Move them from
bitmap.h to bits.h.

Signed-off-by: Yury Norov (NVIDIA) <yury.norov@gmail.com>
---
 include/linux/bitmap.h | 7 +++++--
 include/linux/bits.h   | 8 ++++++++
 2 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/include/linux/bitmap.h b/include/linux/bitmap.h
index 595217b7a6e7..fbe2d12bceab 100644
--- a/include/linux/bitmap.h
+++ b/include/linux/bitmap.h
@@ -223,8 +223,11 @@ void bitmap_onto(unsigned long *dst, const unsigned long *orig,
 void bitmap_fold(unsigned long *dst, const unsigned long *orig,
 		unsigned int sz, unsigned int nbits);
 
-#define BITMAP_FIRST_WORD_MASK(start) (~0UL << ((start) & (BITS_PER_LONG - 1)))
-#define BITMAP_LAST_WORD_MASK(nbits) (~0UL >> (-(nbits) & (BITS_PER_LONG - 1)))
+#define BITMAP_FIRST_WORD_MASK(start) LAST_BITS(start)
+#define BITMAP_LAST_WORD_MASK(nbits) FIRST_BITS(nbits)
+
+#define BITMAP_FIRST_WORD_MASK_ULL(start) LAST_BITS(start)
+#define BITMAP_LAST_WORD_MASK_ULL(nbits) FIRST_BITS(nbits)
 
 #define bitmap_size(nbits)	(ALIGN(nbits, BITS_PER_LONG) / BITS_PER_BYTE)
 
diff --git a/include/linux/bits.h b/include/linux/bits.h
index c7c587e90e2d..0d2950b80a3b 100644
--- a/include/linux/bits.h
+++ b/include/linux/bits.h
@@ -5,6 +5,14 @@
 #include <vdso/bits.h>
 #include <uapi/linux/bits.h>
 
+/* Mask with first nbist set */
+#define FIRST_BITS(nbits) (~0UL >> (-(nbits) & (BITS_PER_LONG - 1)))
+#define FIRST_BITS_ULL(nbits) (~0ULL >> (-(nbits) & (BITS_PER_LONG_LONG - 1)))
+
+/* Mask with all bits before start unset */
+#define LAST_BITS(start) (~0UL << ((start) & (BITS_PER_LONG - 1)))
+#define LAST_BITS_ULL(start) (~0ULL << ((start) & (BITS_PER_LONG_LONG - 1)))
+
 #define BIT_MASK(nr)		(UL(1) << ((nr) % BITS_PER_LONG))
 #define BIT_WORD(nr)		((nr) / BITS_PER_LONG)
 #define BIT_ULL_MASK(nr)	(ULL(1) << ((nr) % BITS_PER_LONG_LONG))
-- 
2.43.0


