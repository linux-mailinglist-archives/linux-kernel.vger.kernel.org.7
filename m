Return-Path: <linux-kernel+bounces-794429-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ADA2BB3E19B
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 13:31:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5DB281632D0
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 11:31:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94BE631DD8D;
	Mon,  1 Sep 2025 11:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="ajnBDXJu"
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 571C531A57A
	for <linux-kernel@vger.kernel.org>; Mon,  1 Sep 2025 11:30:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756726259; cv=none; b=Bp24u4SJf7y2lJ2ZFQ0ENPWMpnGfmIhRYZdBWIGvp2B/nBRjEeXNAWp/VIpJWxWXzhH4B1lKo/Khnd4cRoTP6f6mSanYsHySlf7+VEqJbT7drlRh5nMiTjEFeI5fa6gG0TXHJcR9UjHd2bIBLV4Iiw0rfcQLPP7165qt/CEBzps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756726259; c=relaxed/simple;
	bh=d3KdXT/c2Yk9m0PpM0HCDs6YwY7JVVIjaErZMTVmByc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Xci4Fa52hyhtouj8WL8mzaeWgLBhOsclTGcZdin4QfFSzHDHkmYEwDnps71DxWZRuiYV0kFX8PJmpjhMkBhjKLt4BQsuLmyk2xCgPZrIBSTvDA7XQ1+JZq/3WaPNzih7CKhjcvb6uuQOMYt5gvm0N62WpnLkaqvaTTKpoatHM6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=ajnBDXJu; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-76e4f2e4c40so3464796b3a.2
        for <linux-kernel@vger.kernel.org>; Mon, 01 Sep 2025 04:30:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1756726257; x=1757331057; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KsWJ8LfQ5pRsnjiKNBF8VnH1ORJpnctEr1VaNmcMPZo=;
        b=ajnBDXJuePZBwgzuiui5MFzkNE6r0owZ2e41VZpsnizyaGYcRN+dt3P/BrCkljmuxl
         BhmQkWmM/EocmXU2+vOGXa9qQipA+KwsdeDmNc8XG1mv9dTel9Uzd+wAeWkr6gNQsqqH
         Fqhn+XBAgBYMX+PrhGjDnhZUJqwUlZuirNnxvDhcW8RDbiO+ftlrTrkmCdwTRBOLnNba
         IENUppRLzIf0AXeJWK8NrtpRoBzRpibpPeBpHD1JulCs1y4Pr/0Yxh4SGSSg/ORtZyb4
         /DNB12EjLjMpcHu5y0wvBnqPspRm3qTsBcZxofmFnYKYwEJO4LEvgP9a9Utza6gGu/sE
         tMQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756726257; x=1757331057;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KsWJ8LfQ5pRsnjiKNBF8VnH1ORJpnctEr1VaNmcMPZo=;
        b=JYVsqKmhUPaH7CTnWYgD9RnJcKgFMHw+ZtQLK5xZj46sTcxjhGVM3wNUCF+lVr9IXD
         iLSRbgC9oL8DVa8L8gn8Mpj3QI8ap/49/5/W1gQgfVhhH3tSPXftr2bDvZmQYHPCvslK
         2s42XSQEMPKOcYws9Or1mWIaYGk9GNP8I0ZwXZvl4F9/Hx+Pn53P6Yrqi0kyVXNZIXYg
         GA9kIaCVCfh6FLk3Ps2CWbX7xNQmDajNEEolMEEvjeJHZ5fHTy5vtXy6yO0n6g1e8dHl
         WcPkPD9CjfGsLodCQbVW2M3PMxnCYUYK2a28ZsuI5s3N/PlReGxlo19ljF/Ivj+f7/tt
         f/2Q==
X-Forwarded-Encrypted: i=1; AJvYcCUzeVK1GXyAynSHt70/oXsq3/PgmGpPWA6DyylNSkNvmFt7d7zMeKDkpsB2+Fsy89c23aV+6o06eFXo3CA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZO4e53H4PdGtvSBAA21DJSM6wJBxhKFogJZBIUQ5SC4SfI/bP
	BqdWrAEY3mzxYlvgHqkcDNSMdj5C3y/6l5K9W8IH9pWeKqFlhBDafoPFOWRd/0q1rNY=
X-Gm-Gg: ASbGncv3sZps7iC73/lmx3vVpoZiwkVCRL9mFm6qbKleZuCc4S9anz3jnjCXnupGUa0
	Bvh/kVFLBJjQKE2cffiSFtULNJaNy73gpswKBtVX97Y+0fomrLwHmk4+uXpquHkRcBltY1opAq6
	vYOlAfqgwwJuSS65rRXIE2V0ruH7N+RUZIbz0wPuBj1/mDACIKF5WgnffKFlW/zm8YrAaDMzfdY
	I8JONUewF90bZiQvP3NgWmFXgfbrA57eR+8TZ9S6ct5568c9zFvS13eXE8GV34desHz/RpvJYoH
	FpLTEIQDD7Hg0TOE74e8GEDlSFh3ABORV1Ez+GFKZFI6nulR2vVES5xIlwXusbWqvL9Bue9QUIs
	1ePkIQ9VuJqFNhe0hwX6rBvwdGkV3QBROZz0Mv5nbFDw/2SwpSQMgElYxnNkF8bF6lHsQ4lLMNO
	jBn/bL/Z7cCGQ9EB6Za7hnRr7YHQWk+7sMS++D6lDynSU=
X-Google-Smtp-Source: AGHT+IHAP/HpWJz43wjzWV1AMfyaEGlxWi3s5h5cxx1rxnhDpNmQHxPjIrGV0BRKPAD8DAepB/KmuQ==
X-Received: by 2002:a05:6a20:394b:b0:243:a251:cf51 with SMTP id adf61e73a8af0-243d6f87714mr10685440637.54.1756726257360;
        Mon, 01 Sep 2025 04:30:57 -0700 (PDT)
Received: from J9GPGXL7NT.bytedance.net ([61.213.176.55])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7725ad1e9afsm2911441b3a.11.2025.09.01.04.30.51
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 01 Sep 2025 04:30:57 -0700 (PDT)
From: Xu Lu <luxu.kernel@bytedance.com>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	alex@ghiti.fr,
	ajones@ventanamicro.com,
	brs@rivosinc.com
Cc: devicetree@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	apw@canonical.com,
	joe@perches.com,
	Xu Lu <luxu.kernel@bytedance.com>
Subject: [PATCH 4/4] riscv: Use Zalasr for smp_load_acquire/smp_store_release
Date: Mon,  1 Sep 2025 19:30:22 +0800
Message-Id: <20250901113022.3812-5-luxu.kernel@bytedance.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250901113022.3812-1-luxu.kernel@bytedance.com>
References: <20250901113022.3812-1-luxu.kernel@bytedance.com>
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


