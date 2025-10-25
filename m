Return-Path: <linux-kernel+bounces-870029-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D631C09CAA
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Oct 2025 18:58:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 77CD23B91A7
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Oct 2025 16:42:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A059B2FDC54;
	Sat, 25 Oct 2025 16:33:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lKFrXs1e"
Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5756E303C96
	for <linux-kernel@vger.kernel.org>; Sat, 25 Oct 2025 16:33:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761409995; cv=none; b=GE0pSSGB7XNvo8RPFcqVtpjuAyUfbxCvIBXSXcZ7T9WkWoOOb1XHP9Mwj8SoRVbKTryRX4XwjHHgrpBrS186LMwWFgoxXkSd+YLowT73lxypDlvDhjy2yYu488gxdC4OeN/QF35CnFEBqDCzQuM5mQt0gajd1g25XzkZd9fgrv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761409995; c=relaxed/simple;
	bh=TQ6xv3dIaxpajiHEhlYy8yfOY1BsNMosBwcumiYnhcI=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FJQ3tpFcxYc4igDWIWlTiWiV/TJUUkY1FIAZeiIl9Z4zPH2ltC/egOcMKzYpaD3HwReUHJsiqQSwUnBezTocwvQ920xbrHN6X+hzun6SWTuzRsvkZ6VvB7jGVyEtR79ElV3uOJ9L7EJLJabBBRRE1qJKLTQ4plPBHcLdnOFGVt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lKFrXs1e; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-87fc4d29301so14031946d6.2
        for <linux-kernel@vger.kernel.org>; Sat, 25 Oct 2025 09:33:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761409992; x=1762014792; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7/JFSnIjaD6DTDEOO1oZNxHniLLcLZti7jNstgpjRDc=;
        b=lKFrXs1e6e6lPHpHa9z4ZxbRt7T8MGKjd1J2bi015MzRQRc6KUZTrcFReIhQ51DXfo
         j89TGYltFajWRc24+geH9TyA6bNoFIb1ujVo9capuSlRu38d1GBkDEN14X0sTH5/qtKn
         CQSvNCtszJU/SWXaUmAhK+AkmA9JF/ORG1atSqLipkDAuTJ8EzUG/QSJnCVGs96ou5A9
         pQNzOZMiOaN7O4ejI9mTZlqkM2Ssv0UCCene1k8ST7QgOFFV+3mmL/51cFTl/RIvQfRt
         Cr2rp4IQhD4JcaQyS4Vvt4x2aGc70GDuxibggMb5S5PE7AdzG3uAWMU6dG8/0lDmT43g
         BFNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761409992; x=1762014792;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7/JFSnIjaD6DTDEOO1oZNxHniLLcLZti7jNstgpjRDc=;
        b=s+K3YBSUYRkRr+Nh3SedRPecZm+f3h88Sld0QoTHLtd4o8VBJLYaVgpMyCJTK6EEyF
         vq0eVgga9yHZ9S32BAeaRh2YBr5p16v61yUjLMjPYg3kgQVSlEmEHdy1PDtuAt/vpfxy
         X4dpyGgi6P3QRaGMMvCEyZUjZHizM3srUrEEcY/Gp7MFQKBb0fwB2nvpldyeyoJla7V+
         laxfcY2WW+Mt2ja1sZ3dpp4427A59qyxm0UOCeQHtokvg4wkK2abxSZL/X0JEjIRtCAm
         aNCKMLBICbtDgW+CjZCa9oJsMBoF2nhkY08BmcAGsj03J3cLKxYoShcmpGCsyERgvJk1
         tBUg==
X-Forwarded-Encrypted: i=1; AJvYcCXx9uyjyOtFzirzVLDgVkQ9ZFbUFPx4Gk+wgvLhQo8+w7raDa8DqJKClTVR4qJJzzboyRS66uq6ABtWLkI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwwbiQdkQslVFLV7qx88ftolgR5kRA2VNjM/2Q8I4TrjKVrztRF
	/7UGypA91tcHiOSLY2MHqRCWjuZk65zj8Rxn47hwlhq0Wj5gpkRvah0h
X-Gm-Gg: ASbGnctEmmitRO8mWr9QfIqdnTG/tChwgp6/UnLksYQFNUqE8o/sIJnqCPWCOoy0fCp
	pgnVY2IJGx8MAhaJmE2YJkzZuQO6orOKEG6qOA1np9tNWZWikTHXyrxioPgQ3jX9izHW331+TuL
	NMqpF7ZX/fZii63vIDygSRTRio3sl6pdciab37hSe8R/rT++j3E+O4QxTmMuyk3GQtgRFt3ltQ7
	sgPPTxmqrQdGr8e7CrSyel+9pr2wu9luIZKL2nbNJmc46yEvpwEy3l5k7RMJ2nnmEmrn1l9yFiT
	YLkG9QHA/Dd9qEfyyJNPOHyOuwCIuQkASh36A2NyW+F1pBpWjgwpqPcN/2968hynKJm31c1sN18
	bubnQv64dAgQz7/CLOgzsxSQGWNJ3ziu+iEJ9eQYW0b5CgCiX3yDrCqfWWm7bbdbLLQcIyZVEza
	afEtzBjSM=
X-Google-Smtp-Source: AGHT+IHVYDsqKWbYt2Nmb/p8bTfk7JqCLafoGcRUy2c7z6Z4BfX/omQyQkhSyRFtxDz8s1NdOAjCIw==
X-Received: by 2002:a05:6214:248a:b0:7a3:b6ab:6f2 with SMTP id 6a1803df08f44-87c206612e2mr191871606d6.63.1761409991997;
        Sat, 25 Oct 2025 09:33:11 -0700 (PDT)
Received: from localhost ([12.22.141.131])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-87fc51e3809sm15261996d6.26.2025.10.25.09.33.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Oct 2025 09:33:10 -0700 (PDT)
From: "Yury Norov (NVIDIA)" <yury.norov@gmail.com>
To: Linus Walleij <linus.walleij@linaro.org>,
	Lee Jones <lee@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Yury Norov <yury.norov@gmail.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: [PATCH 09/21] bits: generalize BITMAP_{FIRST,LAST}_WORD_MASK
Date: Sat, 25 Oct 2025 12:32:51 -0400
Message-ID: <20251025163305.306787-2-yury.norov@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251025162858.305236-1-yury.norov@gmail.com>
References: <20251025162858.305236-1-yury.norov@gmail.com>
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


