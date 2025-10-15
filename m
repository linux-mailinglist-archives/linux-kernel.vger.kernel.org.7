Return-Path: <linux-kernel+bounces-855062-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C4B4BE01DB
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 20:21:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 005495073D6
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 18:19:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 378B9350D50;
	Wed, 15 Oct 2025 18:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc.com header.i=@rivosinc.com header.b="GjYN+CL3"
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C16A34DCF7
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 18:14:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760552073; cv=none; b=kIv3NSQXO1vcm4acT1njYkOxzr4w1u/VzYeljqA+PbJVWqCG6lH7k3U9wOTO6ThLaW6SMlKSRrYkKjmr46qC6mQVEYpe7teQ4+UlW5ktD/fWgxvBKSDTpMHCRQh5R76x5k5wP4s9KGwvdff9chiN9eqfmtA+L1Kk+4qgdjOpLHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760552073; c=relaxed/simple;
	bh=I1jqcPRPd1hxfvYCXrKsXB3tX7WWaFK9J8/4Z0z3BE8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OmnEj67Toern7WswbFCQUKACPa9zIdGatLyBv9IsJTfeKKQYbbcHLSjv2bt3fPFXc7BadFSqaRs+estzY/FUz4yyr2sYI72zpOkNQPZxMzSx5jSJH7SwMbWSF6VtbfHmxYtIVE5kStt+zmEy3DD/JmxDsC2LClSVHOEECXxME0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc.com header.i=@rivosinc.com header.b=GjYN+CL3; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-26d0fbe238bso50075135ad.3
        for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 11:14:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc.com; s=google; t=1760552069; x=1761156869; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tlTCabZFxINt6Lm9QbVDHZ4MzlWsICTGzKM8x7gyE4c=;
        b=GjYN+CL3jeLDRhF3Z66apJUIhzmco+PPsSywbdqybXmwSgTEvMmUhuzAPgDMYELbzo
         NZm2DOu+c9smkjaJFkFzaJHwOusXqzJlxTe+xc1X9Hlgd4fTRNMvqRnh5qZ3ZbSjUJQ2
         MzQPKqAz0iVpC1dkcnQYWNEj42S8WZRV29tA0hUKpGtx7asQAbwVfwsYtm9ccdHPSeFj
         9PM5983xku0jqQq5ULbsr3eh8QmwMej9l5e8lrOZQoxdeZPVkYeVEutCfE7fvKFTcHJu
         44y36eaR7tl7HyVUw2eUWol4SA2kHvfxfa3Prg0c19MQ033rPaIJ4Uott+jGORpDYDBu
         ud3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760552069; x=1761156869;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tlTCabZFxINt6Lm9QbVDHZ4MzlWsICTGzKM8x7gyE4c=;
        b=tcidgTTNc4ZDgPR96nA08WJpo8tG5cB5cazTK5uyekave4aFUUSAiKc/ZqVH19jZSa
         1iJFjRysTGMFbyOuM3dRZ6xNXcYw9FBUteq/Cn/qTLTcdfCQsuaX2HxB5kh4GxV7/BWX
         NwHYmcZvmOGPBBUA9yfX0mXVWGrquK0oVtca3wFzYSKyIved8VmUNJkUKHq8/N/tpgBK
         ctTxo9lysHVnGJXcRHd+khwLN0Hi5gh6KCiaDdOxS2kCcdUE3/ziHrZGk7Cvve4jVSZw
         MTF9ndRapO69TguAAsVhq63Tb463xu1LsTA+xTnpNF4h3XzTx0BkyYLJ+iC+YyEYWCTQ
         kF9w==
X-Gm-Message-State: AOJu0YzQZOfV8DyOHgTO+keuQBhGr4j0e4b5uHGDbFH6SzuhFSK0STCp
	9FZ7Q225nfDXvCEVJYs5z5xi+ceLOAXyrbe0RTnkMX/mkF3KqvRnb3VSYSAU9f+p02w=
X-Gm-Gg: ASbGncvvZ1xW12cPiuzckM8ri3rILtb3BhqX+TSWVPNl2lKYaJ+YiTSlZY7rjdJrq9S
	BduJ4nssKMJ9vRfzblym+nrZOALRyknECbpVB7nqBBK6ZbBWPed+rhFF/8xPD1189aY3o+6MlRl
	QkzpYQxk8FSjEM4hEz50re8J5CrHzBwiDbNWe22XflUQE1qWHtO6OnJ34k34W6lfeU50XVuUkPE
	09QgJCabw8qtaedXA+9GeLSZdgQcag2mMNCUiILbb+y9BUr8q4QeMgHA+HZhy3iGAeaqVPKFoYW
	ynO5LRizRNx+gFAtxPXj82zdr9YRrkiFBJWvxnvIpjzIeCAJgOpKFWbc8igYIcQ870Sln4KtZyD
	5nAP/9ZhyUdIKrSKBESTP39dgluZZZEjXnHA4IOEqF0e0cb4Bboc=
X-Google-Smtp-Source: AGHT+IHEXT5xfzaQ9E7GA47DV8y7VdpAtjfIT1LAxVPzv4De3A/Ut9fEGvcfd0ReXWhAXtZ/RL7Blw==
X-Received: by 2002:a17:903:2acb:b0:268:1034:ac8b with SMTP id d9443c01a7336-2902739ad00mr410312175ad.26.1760552069224;
        Wed, 15 Oct 2025 11:14:29 -0700 (PDT)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2909930a72esm3126625ad.21.2025.10.15.11.14.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Oct 2025 11:14:28 -0700 (PDT)
From: Deepak Gupta <debug@rivosinc.com>
Date: Wed, 15 Oct 2025 11:13:52 -0700
Subject: [PATCH v21 20/28] riscv/hwprobe: zicfilp / zicfiss enumeration in
 hwprobe
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251015-v5_user_cfi_series-v21-20-6a07856e90e7@rivosinc.com>
References: <20251015-v5_user_cfi_series-v21-0-6a07856e90e7@rivosinc.com>
In-Reply-To: <20251015-v5_user_cfi_series-v21-0-6a07856e90e7@rivosinc.com>
To: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, 
 x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
 Vlastimil Babka <vbabka@suse.cz>, 
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
 Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Conor Dooley <conor@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
 Christian Brauner <brauner@kernel.org>, 
 Peter Zijlstra <peterz@infradead.org>, Oleg Nesterov <oleg@redhat.com>, 
 Eric Biederman <ebiederm@xmission.com>, Kees Cook <kees@kernel.org>, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>, 
 Jann Horn <jannh@google.com>, Conor Dooley <conor+dt@kernel.org>, 
 Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
 Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 Trevor Gross <tmgross@umich.edu>, Benno Lossin <lossin@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 linux-mm@kvack.org, linux-riscv@lists.infradead.org, 
 devicetree@vger.kernel.org, linux-arch@vger.kernel.org, 
 linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 alistair.francis@wdc.com, richard.henderson@linaro.org, jim.shu@sifive.com, 
 andybnac@gmail.com, kito.cheng@sifive.com, charlie@rivosinc.com, 
 atishp@rivosinc.com, evan@rivosinc.com, cleger@rivosinc.com, 
 alexghiti@rivosinc.com, samitolvanen@google.com, broonie@kernel.org, 
 rick.p.edgecombe@intel.com, rust-for-linux@vger.kernel.org, 
 Zong Li <zong.li@sifive.com>, Deepak Gupta <debug@rivosinc.com>
X-Mailer: b4 0.13.0

Adding enumeration of zicfilp and zicfiss extensions in hwprobe syscall.

Reviewed-by: Zong Li <zong.li@sifive.com>
Signed-off-by: Deepak Gupta <debug@rivosinc.com>
---
 arch/riscv/include/uapi/asm/hwprobe.h | 2 ++
 arch/riscv/kernel/sys_hwprobe.c       | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/arch/riscv/include/uapi/asm/hwprobe.h b/arch/riscv/include/uapi/asm/hwprobe.h
index 5d30a4fae37a..0efc9c7d1199 100644
--- a/arch/riscv/include/uapi/asm/hwprobe.h
+++ b/arch/riscv/include/uapi/asm/hwprobe.h
@@ -82,6 +82,8 @@ struct riscv_hwprobe {
 #define		RISCV_HWPROBE_EXT_ZAAMO		(1ULL << 56)
 #define		RISCV_HWPROBE_EXT_ZALRSC	(1ULL << 57)
 #define		RISCV_HWPROBE_EXT_ZABHA		(1ULL << 58)
+#define		RISCV_HWPROBE_EXT_ZICFILP	(1ULL << 59)
+#define		RISCV_HWPROBE_EXT_ZICFISS	(1ULL << 60)
 #define RISCV_HWPROBE_KEY_CPUPERF_0	5
 #define		RISCV_HWPROBE_MISALIGNED_UNKNOWN	(0 << 0)
 #define		RISCV_HWPROBE_MISALIGNED_EMULATED	(1 << 0)
diff --git a/arch/riscv/kernel/sys_hwprobe.c b/arch/riscv/kernel/sys_hwprobe.c
index 000f4451a9d8..d13d9d0d1669 100644
--- a/arch/riscv/kernel/sys_hwprobe.c
+++ b/arch/riscv/kernel/sys_hwprobe.c
@@ -114,6 +114,8 @@ static void hwprobe_isa_ext0(struct riscv_hwprobe *pair,
 		EXT_KEY(ZCMOP);
 		EXT_KEY(ZICBOM);
 		EXT_KEY(ZICBOZ);
+		EXT_KEY(ZICFILP);
+		EXT_KEY(ZICFISS);
 		EXT_KEY(ZICNTR);
 		EXT_KEY(ZICOND);
 		EXT_KEY(ZIHINTNTL);

-- 
2.43.0


