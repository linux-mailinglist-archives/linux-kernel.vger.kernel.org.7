Return-Path: <linux-kernel+bounces-824146-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D13F2B8835E
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 09:39:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7432D1C86D3D
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 07:40:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C66812DEA95;
	Fri, 19 Sep 2025 07:38:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="NGvft+cw"
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 300122DC333
	for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 07:38:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758267482; cv=none; b=ChUVIBRGAZkD4hGaEqPdY+yvsvA2vus7C/4YTvpTZya26zbB/QN7sQnO5hw0COFBqw6PYD5uTiyhHwNKqd5uHKnwTAS2luCw+8sfc17Li+bNbwhStajsNUIsT/pA4jclgoZTpxVHB0S8P65dEQLuP3pKby9OsuzBDqAJmSkL0Ts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758267482; c=relaxed/simple;
	bh=ny7Y87UCldoCAyN22m3dB64S4BMG+0HtGPlSRdbS+ts=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ui1PbpilRl+ng5Zl0ToAbtUjFE3H624i363fNsfRG5JrpIXuZgnHd+jzEOiXH2T1HqIRRE/baoj/d+bJmt+FvVwkxsIJ+pyFKvU5t8QVgN2riZUphQEHP2HpD3FzLoEshDfZISPzRTmDGPZ1R3rMCmTNUPqEoi6bCEooDFg+o/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=NGvft+cw; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-7761b83fd01so1829905b3a.3
        for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 00:38:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1758267480; x=1758872280; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TLsLBJWdfVYa2JlLG/bj2PxPL4kYEdygRJ5GLCZsFlo=;
        b=NGvft+cwpOD6gUZN1ZSkAqe6YbS4jHbcoKFzSuVHrJzB0rJN6GUL+QIOBLUnjlQtLr
         jEH7bNBPYLhLIXag3CUNWbLGylLL+KH9nA6RZqNVAJZTTJeR+FR0S9JRCfH85leoQbq8
         6POFciiPZAwDj1XauVeYrHZRG0fq+9XQkC7BIDwrKFU57I+nNn7/9a/1264+GF9C0NyO
         K3FxX/hec6TAm0oWWXTErnHk9CmHg7y0kEWDIy66N50xUV8jfj8KYYbvuFCmiOTpb6fs
         hl22eqUBPIcRQfCo/UrxJ+fZBqhY7m0PoT5xXk6HlzR8z3IozxG+lcdmQD5dUhKwfnc9
         Az7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758267480; x=1758872280;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TLsLBJWdfVYa2JlLG/bj2PxPL4kYEdygRJ5GLCZsFlo=;
        b=iGZI+Yni91gbOtaNyLucwjvhMQXxRemC1AwT//hvh6bF2LLgqmFYP5Mu+98oh2O3y9
         VgpSzTJt8L9cqHgAKV9u+BnVyiUKAHvQ+iMuKXDPZzZY3BiDFWxkdFAwUi7xBLWxqcub
         TcuDZlu4i3RHGhw/c4r/n2ed8Ep9ROXeO0ggtxx+Fm5c/w60rG5NbRzlZrzzX3fgUjUa
         /3k18JvgBHCG2MOZCc5lT4440vaRPK+tgEK7oL965OKL7Nzbhppvq3JvG9RUmuOGUqwO
         tYYt9e6sxD9z0OS/5qLGhW7wCQmRUJeU2u+8yC73MokjC1Go0Nw3vTnPfCFN7xwK/QL7
         mV2Q==
X-Forwarded-Encrypted: i=1; AJvYcCWlwh5M6eqLMibknTLRpAzs6Gm33WMZ2HTDIfZlzb6oY1FxXOM0JP1SC4gJoBlSkbiMvWTriZAeFNC0diY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxrju7GKHrKlmlFvH6+XgfBNTWRn4pkgQz5lpb5FX7geWk6qscO
	SaUEuoa1sKIXzcCEO6ii0HVithUikfW0HrObU8QvmVH6F8KsPovU0JEkhIyRS/e5YJo=
X-Gm-Gg: ASbGncv+yxy+mxal3hnJHISpeiAsf/P6mGjI9qF7IjE3lCSdzsJB6SHm8f3hRtbgbQB
	fO7ZJj+ZQ739kDMTfYbn/7vNyvjcFYdPhu0Ju6mxmTzZiHgHHy/DnIiMnkDumjIdz0w51tT82fr
	t737BFXodZnA37UswX5/EPJbH8tg0Em5tF24cbF3LHHJ93tV6zphJnjoAaqpa2Ymf3k+TWjnN+N
	5z9jFxY3Tla5eWFgJFx15gqFpfH81UT1H7S1xY+mQEqzGtYS5TOR7z9sas8HjKko0bPYUSp5vRD
	EaM0QKy+5b1OzjgYv/ZA7phduf6/nZETnGS/zThtTt71y4lpdkH3pEymoUu99iWDIogjlnpJ/VL
	WCkeLcOHHn/6qT3jdn5ylvc0swq4yVxrGV+UKmHjezVWI1BNOcmyDh0ke0Sf2owjMIvaTuELsh6
	iU2Aypo/HAUT3KIJIj2aVb1zB5f3Lqbn82zfbPCd0FIg==
X-Google-Smtp-Source: AGHT+IEf5W21ek4SN0ll5sE3XkSqbMBzmLR+7/wUne5d4f1g+TFSnmeY9PodKHF4WkSxZeu62+QPKQ==
X-Received: by 2002:a05:6a21:3288:b0:264:94:3f5f with SMTP id adf61e73a8af0-2925c55263bmr3821388637.15.1758267480440;
        Fri, 19 Sep 2025 00:38:00 -0700 (PDT)
Received: from J9GPGXL7NT.bytedance.net ([61.213.176.57])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b550fd7ebc7sm2679096a12.19.2025.09.19.00.37.50
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 19 Sep 2025 00:38:00 -0700 (PDT)
From: Xu Lu <luxu.kernel@bytedance.com>
To: corbet@lwn.net,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	alex@ghiti.fr,
	will@kernel.org,
	peterz@infradead.org,
	boqun.feng@gmail.com,
	mark.rutland@arm.com,
	parri.andrea@gmail.com,
	ajones@ventanamicro.com,
	brs@rivosinc.com,
	anup@brainfault.org,
	atish.patra@linux.dev,
	pbonzini@redhat.com,
	shuah@kernel.org
Cc: devicetree@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	apw@canonical.com,
	joe@perches.com,
	linux-doc@vger.kernel.org,
	kvm@vger.kernel.org,
	kvm-riscv@lists.infradead.org,
	linux-kselftest@vger.kernel.org,
	Xu Lu <luxu.kernel@bytedance.com>
Subject: [PATCH v3 3/8] riscv: hwprobe: Export Zalasr extension
Date: Fri, 19 Sep 2025 15:37:09 +0800
Message-ID: <20250919073714.83063-4-luxu.kernel@bytedance.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250919073714.83063-1-luxu.kernel@bytedance.com>
References: <20250919073714.83063-1-luxu.kernel@bytedance.com>
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


