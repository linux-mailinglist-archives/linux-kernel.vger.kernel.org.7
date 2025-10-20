Return-Path: <linux-kernel+bounces-860073-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 26420BEF3F0
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 06:22:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D45C93E1C37
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 04:22:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EB2D2C0F9A;
	Mon, 20 Oct 2025 04:21:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="Yj82uOv7"
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E52012BF3CC
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 04:21:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760934098; cv=none; b=CzmPpwqhsOkLEqJ7ejaHMZouWJHnGw/ZGGWMAWbG5hJzxTxzE7EHmuOdTuSVTm60SSzDwbXR8KLmB6E23ZH2xuKTQa9weZIDansPyKBTTSdTHSnnenrUBU8jhQWmHy0pTuT2aDLwcjaasEK5Dng/wTlySV7xRxGQTyGEYCIvaqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760934098; c=relaxed/simple;
	bh=ny7Y87UCldoCAyN22m3dB64S4BMG+0HtGPlSRdbS+ts=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pi+QYHaagJMyjAGMWxs+LVF5gSETj2dB27FEVjX/EnWZi9Zwza9pLqEKs88abUQS6Q1zWB/+4NbP7O1wAmoqtYp0HjhK2pG/Vk3FanfsdWnjiMmRD8LQJ+9uuOyH9oMvA0KNfTBcSsJVC01wBsBb+jBhkap42yVJrY1Z/WjI7wA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=Yj82uOv7; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-b49c1c130c9so2377132a12.0
        for <linux-kernel@vger.kernel.org>; Sun, 19 Oct 2025 21:21:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1760934096; x=1761538896; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TLsLBJWdfVYa2JlLG/bj2PxPL4kYEdygRJ5GLCZsFlo=;
        b=Yj82uOv7t4l8w08IcuvghlpVSIQNIqdAP3PgQ3T0bSWnZ/deTa27mbyzrTk8HBstmF
         24gIskfqE83tXsRjPiYBa98NYZnE98sS1GLQ7hP8+O9iAdO65FGSGB/32F/2rFjep+xU
         JqAQSP0cE0BU+KXy4IwbTpk1474Ud0P7o1UgnO904CGEgb1qOW+OAyht1YM3Dg9oGRaH
         RYZFQI9qWI4gy64klKPzStRERa2lf3ecozX21lZ8TyRrypKsZsMNOsELA51heVxHftgR
         Iz58LzlOtrMUrfJem8mwUDxUBni3i8hSTG13iL7Eg5xkPBGce8aQ5CoYsQYt2uqMP+vT
         6RTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760934096; x=1761538896;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TLsLBJWdfVYa2JlLG/bj2PxPL4kYEdygRJ5GLCZsFlo=;
        b=RLnn7/Ev4D0V9YH1YIX0yPcyXDzDKq7fWxDrgGazkPaaTMiec0jXQJsOVean8GI07Y
         8f6LcXdFlKsTbEkTnBAW/3uIJ4+ur1X+bez65JzkGx6LqYnVLMFdkcmLxpvajo2oxuoE
         CrBPF0ej4MK+YLgu6ykNn+6lG3tLSIOlaPBERiUhRwN52CDpjdRB6to1qK+P7Si+fOmW
         fh+kBT0lsbwMKymhlWlErOBFkMPs1bj6P+KW3beTU3/IM2oTI+uDsK/eY3GMiP9lhw2D
         bPh/qarDu+Vr9WgiAZ3qpDwKoGQOhGRSvwYNIy953v6riguL2rjftWrDMAxev33EVBO/
         LCyw==
X-Forwarded-Encrypted: i=1; AJvYcCXe8RH9rhBOkI2RbY/VyD+qPuRRz4WEghDvrnYyjnfJThmtcqSP4Lw86OzOL74wx6xAUGmHk80ZUK42Jdk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyO6u1MU+iTJOR7v2aVy1ngAJl7SDhztliBfUx3k2zx1YKh0IaX
	Gn2SczOWTb46F5S32ezt8XsZrYlnHDYDmqvcCNbOsmwi0dvMeKsK+IfPu6kDzwLSVfs=
X-Gm-Gg: ASbGncudYcQi5Rk0RwuTDGgI8cB9CWdpfFZBendYHkOqfaVaWbHznNZe2hnsXOjGBh8
	DToG8sq7CNJCTXIbSPE2zzBtlG7i+rrZScqpsesQr0x+ZS9jwS3hRvzkygwpKlcxXlTWGqx5y2l
	ACllLwKrrr8T+UV7+bOyuwbsqcN3dCVmXdW0T32A+GCD1fSuR6Q3gMz8/bitl/SRz2bfbRVXQW5
	8Oqofa4AgWpNcViN7oIVs77AMkS8K1N1hGj7RKxaH1KkIX6jHFAZPfBjV7QDu7KHBrhEKQyUA2b
	u+oxPz10gdJ2Xe3NMdHRcL4xWOAfOVzq34ImVuaa2HSh2OS8vlOmATQYuCcShhiqr6NSoeAj+UJ
	F6ZQqospDHG0VQyTyAd3E2yjU3cn8axEsaZjQF8xVxzmBc4LbA6cygJJZeRGyCSHfCJhMekv6Jj
	VZZQZdKZnVtUWe6Q4ww6O4ubtn9BqGP9qoRCUrzW9DXNM+g3VmCr/flMj6Imr83mE=
X-Google-Smtp-Source: AGHT+IEVDRzQqxz41bjazvzEtq94PPu5+Ha6Ch7yR6vZUeSxKjd1JAWFRYIDj5wLQhSdXdNmOhf0qQ==
X-Received: by 2002:a17:903:1d1:b0:264:ee2:c3f5 with SMTP id d9443c01a7336-290c9cbcca1mr154193285ad.19.1760934096103;
        Sun, 19 Oct 2025 21:21:36 -0700 (PDT)
Received: from J9GPGXL7NT.bytedance.net ([61.213.176.55])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29246ec14e9sm68762035ad.9.2025.10.19.21.21.27
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 19 Oct 2025 21:21:35 -0700 (PDT)
From: Xu Lu <luxu.kernel@bytedance.com>
To: corbet@lwn.net,
	paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	alex@ghiti.fr,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	will@kernel.org,
	peterz@infradead.org,
	boqun.feng@gmail.com,
	mark.rutland@arm.com,
	anup@brainfault.org,
	atish.patra@linux.dev,
	pbonzini@redhat.com,
	shuah@kernel.org,
	parri.andrea@gmail.com,
	ajones@ventanamicro.com,
	brs@rivosinc.com,
	guoren@kernel.org
Cc: linux-doc@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	kvm@vger.kernel.org,
	kvm-riscv@lists.infradead.org,
	linux-kselftest@vger.kernel.org,
	apw@canonical.com,
	joe@perches.com,
	lukas.bulwahn@gmail.com,
	Xu Lu <luxu.kernel@bytedance.com>
Subject: [PATCH v4 03/10] riscv: hwprobe: Export Zalasr extension
Date: Mon, 20 Oct 2025 12:20:49 +0800
Message-ID: <20251020042056.30283-4-luxu.kernel@bytedance.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251020042056.30283-1-luxu.kernel@bytedance.com>
References: <20251020042056.30283-1-luxu.kernel@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Export the Zalasr extension to userspace using hwprobe.

Signed-off-by: Xu Lu <luxu.kernel@bytedance.com>
---
 Documentation/arch/riscv/hwprobe.rst  | 5 ++++-
 arch/riscv/include/uapi/asm/hwprobe.h | 1 +
 arch/riscv/kernel/sys_hwprobe.c       | 1 +
 3 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/Documentation/arch/riscv/hwprobe.rst b/Documentation/arch/riscv/hwprobe.rst
index 2aa9be272d5de..067a3595fb9d5 100644
--- a/Documentation/arch/riscv/hwprobe.rst
+++ b/Documentation/arch/riscv/hwprobe.rst
@@ -249,6 +249,9 @@ The following keys are defined:
        defined in the in the RISC-V ISA manual starting from commit e87412e621f1
        ("integrate Zaamo and Zalrsc text (#1304)").
 
+  * :c:macro:`RISCV_HWPROBE_EXT_ZALASR`: The Zalasr extension is supported as
+       frozen at commit 194f0094 ("Version 0.9 for freeze") of riscv-zalasr.
+
   * :c:macro:`RISCV_HWPROBE_EXT_ZALRSC`: The Zalrsc extension is supported as
        defined in the in the RISC-V ISA manual starting from commit e87412e621f1
        ("integrate Zaamo and Zalrsc text (#1304)").
@@ -360,4 +363,4 @@ The following keys are defined:
 
     * :c:macro:`RISCV_HWPROBE_VENDOR_EXT_XSFVFWMACCQQQ`: The Xsfvfwmaccqqq
         vendor extension is supported in version 1.0 of Matrix Multiply Accumulate
-	Instruction Extensions Specification.
\ No newline at end of file
+	Instruction Extensions Specification.
diff --git a/arch/riscv/include/uapi/asm/hwprobe.h b/arch/riscv/include/uapi/asm/hwprobe.h
index aaf6ad9704993..d3a65f8ff7da4 100644
--- a/arch/riscv/include/uapi/asm/hwprobe.h
+++ b/arch/riscv/include/uapi/asm/hwprobe.h
@@ -82,6 +82,7 @@ struct riscv_hwprobe {
 #define		RISCV_HWPROBE_EXT_ZAAMO		(1ULL << 56)
 #define		RISCV_HWPROBE_EXT_ZALRSC	(1ULL << 57)
 #define		RISCV_HWPROBE_EXT_ZABHA		(1ULL << 58)
+#define		RISCV_HWPROBE_EXT_ZALASR	(1ULL << 59)
 #define RISCV_HWPROBE_KEY_CPUPERF_0	5
 #define		RISCV_HWPROBE_MISALIGNED_UNKNOWN	(0 << 0)
 #define		RISCV_HWPROBE_MISALIGNED_EMULATED	(1 << 0)
diff --git a/arch/riscv/kernel/sys_hwprobe.c b/arch/riscv/kernel/sys_hwprobe.c
index 0b170e18a2beb..0529e692b1173 100644
--- a/arch/riscv/kernel/sys_hwprobe.c
+++ b/arch/riscv/kernel/sys_hwprobe.c
@@ -99,6 +99,7 @@ static void hwprobe_isa_ext0(struct riscv_hwprobe *pair,
 		EXT_KEY(ZAAMO);
 		EXT_KEY(ZABHA);
 		EXT_KEY(ZACAS);
+		EXT_KEY(ZALASR);
 		EXT_KEY(ZALRSC);
 		EXT_KEY(ZAWRS);
 		EXT_KEY(ZBA);
-- 
2.20.1


