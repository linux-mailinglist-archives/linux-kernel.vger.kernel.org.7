Return-Path: <linux-kernel+bounces-786868-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D165B36D1E
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 17:07:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D7D161C44067
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 14:59:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13E0C22DF95;
	Tue, 26 Aug 2025 14:58:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="YvX02tss"
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81423270552
	for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 14:58:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756220289; cv=none; b=JUklRlGgKwMlps8t5CHKCD1coSI1t45yaZ4yIIrHqdnQYO/NWYW+497bsS05OpR5TIJUPFJTFoqjs2fsZANN17saJqSWj8NYjAWFFVFqdbWRGYA4++uub7Kan6/hZ93237Sdxv3UzXQ8Pid7BGm4o1h3ViDNOuaQ2pzYqAikWjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756220289; c=relaxed/simple;
	bh=d3KdXT/c2Yk9m0PpM0HCDs6YwY7JVVIjaErZMTVmByc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bC9Mbdj6IhtffMEgu+9lt0ivH7+oRMrlWmAjSHc8n4+lhhImaWUeZOxxGJXsGxY3QtZ1Rjx6nIn6TeHOG29m1dotEnrZlZeFtEl9eUrbAXUKrFle7Y2zscSuZ/I/l4ZO+nC9IbRIH/D3IJMCocTIou/HvrfKlcrnE5SmTKmhE3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=YvX02tss; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-7718408baf7so2592828b3a.3
        for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 07:58:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1756220287; x=1756825087; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KsWJ8LfQ5pRsnjiKNBF8VnH1ORJpnctEr1VaNmcMPZo=;
        b=YvX02tssGPLxPerLYSzEJ0L2u1CG/tzQ8yWXNUWoSp3JKI4UFafUQOC9+6yvrVw0hJ
         Uo/U1XwUNWFRutRQ/lWJW/08Aihv3V/Yf0MSTj0oGv//MnUzIBPOAJ1zo5neXpDi0/mC
         p1AU0McZh56EJR0PTfeoNxLwLriEBNu538PsX7IySJIABUfr0bmyz+aHS0vyYBGcLOKC
         Xbuf0SfSlB7eC/wPlRdvQc3Lia4fxkCW/PrNhwMnYBS3MbYhdR0oYkaWoXZRDdXhp+ks
         14tReNipWob3Y08GH82mLC82BxGp8gFT0vzHqOlyvFcdCBBSCtvR0JCGYspdG4/lWkxM
         C5dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756220287; x=1756825087;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KsWJ8LfQ5pRsnjiKNBF8VnH1ORJpnctEr1VaNmcMPZo=;
        b=hTuL5JTCgMAyujuRgOPlhF5j+Kr4B3IphHyG/XVx9pGyJ/BkXHPJePoZrYTA81Qev4
         GPX5IRBM6XRqmxSQb/vrHvUGH906ML7WD15fhlBD0gq7e9mYduAHVX0WAHeGOz6fU0FD
         ydsfsn6w+iHABsHpZ/gFA4136ij6yTe8+K0DAbi2dUuhyQbc10cvdXva20oolbtsZ8To
         9KcgxwZMSjiW9I+DAO71H6ByTv7nPddtzBtQShnZOR6AMgNN6Oacgy5LvYoXivrRfQRR
         OPmo9ZvC51W8wmmox/b+EQ+8J2WO6rq8evxcq67RAdo77Ondpaq0L60PCZYyEisFXtKS
         /ehQ==
X-Forwarded-Encrypted: i=1; AJvYcCVxhy972XqG1hyGoPxXlHQVU089pC+GkII3OyhHt6XjYccXeBL0aCep9e6gdjM/ZTPlTBJtFfRoeCywAjA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1qwUk7DJ+Fl0W1fLEFHm39KErwEtKze2i0rpC7ZOi76uC7P96
	A+rFWsHwcEopsF5nQolbo71J8igWzCKot5bH4gIxInjhVD2cAkwL/JpPNUrvtmbxQbc=
X-Gm-Gg: ASbGncvQQ1jIF8F4Jl/67FUr/KXGGQVaajXPKV6w0qXNSKTbYHkZ+LUlCTqD+a9o6/F
	/KYGNg1+NBg05O4f4t9h2iKAZNqZBVgzxdzFsB6dWQAD3CKakIgU8s8SfW09dRZmsKNRFSE3WcL
	QOYIwYLNsnG5j0c2xJwYDrvWNjny6wL0oYPWqfSL8P8SEzzxbm0Sw1SNtV9giVhtsaSYpVnJbd2
	PNgwWm/702J5JgSDELNmMww0/YeSePy3Z+Ne767LU4Zobd2yDVTMzOpxLbpqG9uIQyHQELgCiYV
	VxAuBn+9hLGrQ02Wb/hZEVz7YHL8Isz0HwivnN2M0JTZOw/zLIkPe2OPNHsUd/6pSMHKQ0ptMTO
	UT8z3HH/h6BrvZj119hfuPPyZP7R3a3oRKPEmmZt6hgCKa+WFvyCix/KhJAMfDb5ef839ONlLDV
	g+/t5ULQHrFinHI2V41CIy/yqsE/qfc+s8k/c7JeLK5+AmnYpuFbxkmg==
X-Google-Smtp-Source: AGHT+IGce0JQH+7jy1z8rLOiE3hj/ODdqdM5pZya1dvpwjYNjHu/6OJ1qk93cuk+FgxpNT18X9J8HQ==
X-Received: by 2002:a05:6a00:852:b0:771:eec7:a725 with SMTP id d2e1a72fcca58-771eec7eb56mr6685172b3a.8.1756220286726;
        Tue, 26 Aug 2025 07:58:06 -0700 (PDT)
Received: from J9GPGXL7NT.bytedance.net ([61.213.176.56])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-77059928c5asm7209799b3a.1.2025.08.26.07.58.02
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 26 Aug 2025 07:58:06 -0700 (PDT)
From: Xu Lu <luxu.kernel@bytedance.com>
To: paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	alex@ghiti.fr,
	ajones@ventanamicro.com,
	brs@rivosinc.com
Cc: linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Xu Lu <luxu.kernel@bytedance.com>
Subject: [RFC PATCH 4/4] riscv: Use Zalasr for smp_load_acquire/smp_store_release
Date: Tue, 26 Aug 2025 22:57:40 +0800
Message-Id: <20250826145740.92276-5-luxu.kernel@bytedance.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250826145740.92276-1-luxu.kernel@bytedance.com>
References: <20250826145740.92276-1-luxu.kernel@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace fence instructions with Zalasr instructions during acquire or
release operations.

Signed-off-by: Xu Lu <luxu.kernel@bytedance.com>
---
 arch/riscv/include/asm/barrier.h | 79 +++++++++++++++++++++++++++-----
 1 file changed, 68 insertions(+), 11 deletions(-)

diff --git a/arch/riscv/include/asm/barrier.h b/arch/riscv/include/asm/barrier.h
index b8c5726d86acb..b1d2a9a85256d 100644
--- a/arch/riscv/include/asm/barrier.h
+++ b/arch/riscv/include/asm/barrier.h
@@ -51,19 +51,76 @@
  */
 #define smp_mb__after_spinlock()	RISCV_FENCE(iorw, iorw)
 
-#define __smp_store_release(p, v)					\
-do {									\
-	compiletime_assert_atomic_type(*p);				\
-	RISCV_FENCE(rw, w);						\
-	WRITE_ONCE(*p, v);						\
+extern void __bad_size_call_parameter(void);
+
+#define __smp_store_release(p, v)						\
+do {										\
+	compiletime_assert_atomic_type(*p);					\
+	switch (sizeof(*p)) {							\
+	case 1:									\
+		asm volatile(ALTERNATIVE("fence rw, w;\t\nsb %0, 0(%1)\t\n",	\
+					 SB_RL(%0, %1) "\t\nnop\t\n",		\
+					 0, RISCV_ISA_EXT_ZALASR, 1)		\
+					 : : "r" (v), "r" (p) : "memory");	\
+		break;								\
+	case 2:									\
+		asm volatile(ALTERNATIVE("fence rw, w;\t\nsh %0, 0(%1)\t\n",	\
+					 SH_RL(%0, %1) "\t\nnop\t\n",		\
+					 0, RISCV_ISA_EXT_ZALASR, 1)		\
+					 : : "r" (v), "r" (p) : "memory");	\
+		break;								\
+	case 4:									\
+		asm volatile(ALTERNATIVE("fence rw, w;\t\nsw %0, 0(%1)\t\n",	\
+					 SW_RL(%0, %1) "\t\nnop\t\n",		\
+					 0, RISCV_ISA_EXT_ZALASR, 1)		\
+					 : : "r" (v), "r" (p) : "memory");	\
+		break;								\
+	case 8:									\
+		asm volatile(ALTERNATIVE("fence rw, w;\t\nsd %0, 0(%1)\t\n",	\
+					 SD_RL(%0, %1) "\t\nnop\t\n",		\
+					 0, RISCV_ISA_EXT_ZALASR, 1)		\
+					 : : "r" (v), "r" (p) : "memory");	\
+		break;								\
+	default:								\
+		__bad_size_call_parameter();					\
+		break;								\
+	}									\
 } while (0)
 
-#define __smp_load_acquire(p)						\
-({									\
-	typeof(*p) ___p1 = READ_ONCE(*p);				\
-	compiletime_assert_atomic_type(*p);				\
-	RISCV_FENCE(r, rw);						\
-	___p1;								\
+#define __smp_load_acquire(p)							\
+({										\
+	TYPEOF_UNQUAL(*p) val;							\
+	compiletime_assert_atomic_type(*p);					\
+	switch (sizeof(*p)) {							\
+	case 1:									\
+		asm volatile(ALTERNATIVE("lb %0, 0(%1)\t\nfence r, rw\t\n",	\
+					 LB_AQ(%0, %1) "\t\nnop\t\n",		\
+					 0, RISCV_ISA_EXT_ZALASR, 1)		\
+					 : "=r" (val) : "r" (p) : "memory");	\
+		break;								\
+	case 2:									\
+		asm volatile(ALTERNATIVE("lh %0, 0(%1)\t\nfence r, rw\t\n",	\
+					 LH_AQ(%0, %1) "\t\nnop\t\n",		\
+					 0, RISCV_ISA_EXT_ZALASR, 1)		\
+					 : "=r" (val) : "r" (p) : "memory");	\
+		break;								\
+	case 4:									\
+		asm volatile(ALTERNATIVE("lw %0, 0(%1)\t\nfence r, rw\t\n",	\
+					 LW_AQ(%0, %1) "\t\nnop\t\n",		\
+					 0, RISCV_ISA_EXT_ZALASR, 1)		\
+					 : "=r" (val) : "r" (p) : "memory");	\
+		break;								\
+	case 8:									\
+		asm volatile(ALTERNATIVE("ld %0, 0(%1)\t\nfence r, rw\t\n",	\
+					 LD_AQ(%0, %1) "\t\nnop\t\n",		\
+					 0, RISCV_ISA_EXT_ZALASR, 1)		\
+					 : "=r" (val) : "r" (p) : "memory");	\
+		break;								\
+	default:								\
+		__bad_size_call_parameter();					\
+		break;								\
+	}									\
+	val;									\
 })
 
 #ifdef CONFIG_RISCV_ISA_ZAWRS
-- 
2.20.1


