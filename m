Return-Path: <linux-kernel+bounces-795514-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B13FB3F3B7
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 06:25:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 217B0205289
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 04:25:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 426972E0B4B;
	Tue,  2 Sep 2025 04:25:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="UKQFevt1"
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 070F32E11BF
	for <linux-kernel@vger.kernel.org>; Tue,  2 Sep 2025 04:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756787107; cv=none; b=KCb3e84dqvlfRidipkRBjDwmoc/P99US+D5b1tcWetXngWTddRPcPDpuyHZW27P7MPhTL++qANx9e7b5fYRl9JqJm+wARV7G3cNHw2/IXLOfK1b9UCIi9+45wbqoxg6PtLmiP00r67lFlJ1TYNlWnj5TVYCHb1ONpefIF1yJUL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756787107; c=relaxed/simple;
	bh=d3KdXT/c2Yk9m0PpM0HCDs6YwY7JVVIjaErZMTVmByc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MHza96QCpcyPprn+TQD0zqpKUyC3PNc0hu6Am65PiGU8FEbtHpLMMFPwTh57ec7AsqmWHss+6Hp3LlQK4maSKm3Rsm3sTY0YnFRaDftmXlJDfUV+UmW0Cq1iITW4pGL8GhuDAahILIMptZkijyyICNEHruNWau/PIbYdoBS4Dtc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=UKQFevt1; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-327ceef65afso4909165a91.0
        for <linux-kernel@vger.kernel.org>; Mon, 01 Sep 2025 21:25:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1756787105; x=1757391905; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KsWJ8LfQ5pRsnjiKNBF8VnH1ORJpnctEr1VaNmcMPZo=;
        b=UKQFevt1/gJ6QMDPw4+zG4ssrtHgIPPkvTaJcBthtF6bGLwhiiBTlb/6qwO606K9oc
         udGtNPDWj12rzKfX+J2fOIHDlxuKI7cUoPJ4DiXFVY5BdNTOl5QfIEU0IAIKxKv+1sGU
         A8fDa4b4B0NNcUTJwqeWfVc3nqXH79ABvsDpCpGKSoDVqfOg6ZyjBsEQgHpfVdrYcZQf
         GeR25xyF8Zry73q83EyjatuX98XEZ2n07+bXH0RPAKINIkAqFoxUyGCt8o0vAWQS9XOs
         FOmIYhTHqHrqvf0oz4REOtSIJmFcIbAzkQ/kPmS3CYi9dGrDAORZJbNXr1Ik8a0x0T4L
         ToqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756787105; x=1757391905;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KsWJ8LfQ5pRsnjiKNBF8VnH1ORJpnctEr1VaNmcMPZo=;
        b=RByoxBXX7MF+AqxQHgAq/8bPk71Fc0uult5vJc04lCk+h2BgIZLPoFrasOZz0oAudY
         IdQ4sXVuaZ0wxzTdsnMQS9xxwscOVH+yGOZRsujnKBocXg0NYhshljBb8lJ8mDO+OTvd
         scK5EH5dhYhzGDJTA2Y7Td/79eC1J3qiuuWtl9Uvq6r363g6GP6aFRSUiOLb4MC2oQoK
         d9v1f7+W6R+Ekt6E1Wy61TYxmr60+ww9K/bvMY25NXAUSRhCMp4PWr/U8hVwTE6cJw0w
         BGZhNZQ7QDhwhGYpxbKZpsSE6PwucPzSV1rG8AzgeXl9hw3ycI/IJpxWyrfRFKBpBjBv
         H/xw==
X-Forwarded-Encrypted: i=1; AJvYcCWZYRbqB9FwA+JMqbP9eTFN0nZPxmwWoOpuAKqr9IJRfhIWoawkAss2zdP2bD57ev0d2wOUnJZwjzO5yrk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyYf2nqYvnC7VjBtKDRzIYSwvIiMjppOe2Kuhku2WT6jDUmZgrh
	tW25AcrABNVRhR0ZPWzFUtH+nV7hyuOdFjy9kJ56JwfzxFk5PKyv5p1TbclhkyLSVhc=
X-Gm-Gg: ASbGnctCPXmC/uXeTU8qwE+ZqqWsUdaN43B2CecTW9Zoi7xgmuHYWFEl88aj4SQSnoA
	AXIGdSNDqo9rhH3Q8iKaEQl/0tCU49PztYuvpyY/d4WQR1ftYE1kmIBWCpawXIba747RDWfpVGx
	IHEv3QkPAh7/HqR5BsNhePUzOQ3uqlFhPNz5nSfym833fvdjYSc8S1hLXqzTmy8FHNEsRfYXF7/
	CPxnc2aSIvIKlXdqnhlkMsH1TxYyvaIlJ5yzszOg+B9tvYEmdB6uC3BIVC4DIPQFoEBiJXKr4rP
	8vU+e5PWc828raHVA4c1VDfViibtYGm6zgo7+cyeFNZMsFnhRCw5sR2tlPPHM8eTnP7IX6XgCg2
	Cd+3KoXa50Xxm2u9pu+XjxJu0n68TPynQDZRCWw9JtlJcckOBm480LHI7g194epMFhlY5Z74Qdf
	T1SXPWpNy8OXel9/jay8Y0F62OsTj8Cog9BIxgjagW3H4=
X-Google-Smtp-Source: AGHT+IE5ILaPlbdaJvy0lHhCLMkEi7dV07tKF7N1W6t5v1Wvwl43pItJx8N4YHBrAE+BIEHm1Y1uhQ==
X-Received: by 2002:a17:90a:d40b:b0:327:a04b:aac with SMTP id 98e67ed59e1d1-328156be03emr14100705a91.24.1756787105177;
        Mon, 01 Sep 2025 21:25:05 -0700 (PDT)
Received: from J9GPGXL7NT.bytedance.net ([61.213.176.56])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-327e21d14a8sm12216706a91.2.2025.09.01.21.24.59
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 01 Sep 2025 21:25:04 -0700 (PDT)
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
Subject: [PATCH v2 4/4] riscv: Use Zalasr for smp_load_acquire/smp_store_release
Date: Tue,  2 Sep 2025 12:24:32 +0800
Message-Id: <20250902042432.78960-5-luxu.kernel@bytedance.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250902042432.78960-1-luxu.kernel@bytedance.com>
References: <20250902042432.78960-1-luxu.kernel@bytedance.com>
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


