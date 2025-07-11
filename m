Return-Path: <linux-kernel+bounces-728240-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 32FA7B02553
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 21:54:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CAE13A67F04
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 19:52:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F4172FCE24;
	Fri, 11 Jul 2025 19:47:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="HpLm/KVW"
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 217FF2FC3BC
	for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 19:47:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752263238; cv=none; b=pa+4D26AK66LI9TQYTwSZAW/Y0movkWOaASU7yT7SWF+hURg315pQBA6bq8RFqR1JrbqEnzlc60eWrFz9hhF/hiVeIaiXaIGLoAGTkd70qIHdYzconO1N/7qbmoDsdwfjrEinz9/jLGF8DcXSSqAoLsaKuj9itseyrsuLCQ/ejI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752263238; c=relaxed/simple;
	bh=sFaiwL1IAfb6PyE/FjSk9WIwHTzXUZv50mJ+nuqII80=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PMwSKzf3mCYxQhpBTaRcmoVbnxQTx+tAD4TXSRWdr9/BsWchSX+B+3UhtKymfyP++V1Zl2WarkBghGEyOPjE46m4fblbE7sQ5/tTjuYarcP0X8idIy/EZUmF5NOY2V23dhIpONMUY+UxaPcflaWf2B0DS4a2UHiF+slbQDr3rMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=HpLm/KVW; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-739b3fe7ce8so2409854b3a.0
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 12:47:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1752263235; x=1752868035; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=97idN3yevHtenW1UOqMmzI1HJzUNQ+IzroMxOnaMZVo=;
        b=HpLm/KVWRihW4QczSnrIJOdLgHZbkafOBIjxX1WioMpo4HeCptlwJye7aHn3ZnLzxK
         hDXNU2sRJ9txaqcwAChUQ2Kttt8OZz8Gk+eVUfZYgQ4F2bFmEf/XlJ3kieFwHbO7gEuX
         bVLJOJFH3yT274TDpUCKlPvsZUXFDOR7i9sgcxoMPs9+MjLWzvBplyJZuj+w4o8qecTC
         3dSt/91jWP+GwIqSZqsj0hQnz5sFUaQhSCG7IHvdMYX2gJpmknW//ZrIw1XOFV0gY9C/
         lINW1UOYrv9rJHlxXszX2I57acbqvH2JsMtWxaOuhzWKPx0M7GnKtDHMybZXvPm8VowC
         qO9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752263235; x=1752868035;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=97idN3yevHtenW1UOqMmzI1HJzUNQ+IzroMxOnaMZVo=;
        b=NkkroND9Vd0VnqlXUMYOrWSb2DvB5WeJ1coo1vb/KCMRAmQtFJnlx2tbB8Z7C6PPSG
         cWoqB+Sm8TLXuPoRdo46dWCpHlKQWJnd/rUynvpnJ9UwHLBpwWznL1iZB7o8QuEg8j5O
         cb9pwznf12fryRxHziFYLEPNuytBoZ9FEsmh10RvZc+203uMaOlTzhx3EckWEBQ8b50u
         GeZA07vGmwt4n5vlKznYgXzte7Xb0rv16faEzjABTFhJGMWmiTYWIcVlFKJf1kJBqVOy
         IKRO6Ovm/icC3qiGazD2y6eMnuo9HA6lUWEoPMc1wh5W7+cJRLCUYZfAcDxvOfjPDiFA
         uf/g==
X-Gm-Message-State: AOJu0YxoyjP3VHFCT3zyawEoEdt+SWvbDKScvVOmWgUZwErQcr7Fo6IQ
	BFIq73Jjf8UqQiK8tjhKV3Xk8Td/1Ugezex0bdFdiWFBewY25eS83BFKWUOiKOvQkEQ=
X-Gm-Gg: ASbGncsCfEughsfVUpqFGVyRVeLvrSct5RKRSOYQkXwFkPLpvhb6PXJeRqJoJtKSZLf
	g66inGmKeLhemF8fCJ3NlUd+JuWweFhtvMxg/BAebRgDB+xPvjEB5wVIgt5BrUSSfTjsDnrhkXB
	X/x+xV28gqtCMihlK6rW0QWDFSAx7GksH29AuMEeKTnkM6u9zsNMsSAx6jRS34KtbpjGV0CrBdY
	1hCEX41tX0kQR04Ac6mwphTS50IOkGr8hR0sTKGPUV/dRkQirBDEpI07/ozuNswL5ZE098RD4HU
	CC1N3OJ5LgIbPgptAns1+jskxwRx8W1kcllrlmAYvjs6tmKsfqiIIt07WcsFYziWP+04nkYfQBN
	DMnSYHBYpPWPjiJqp0hXalPWrmXjGMzRD8MPSDSOFzDY=
X-Google-Smtp-Source: AGHT+IHwJTDGg9rq2j66Wqz5or/ZUFf1xTDlZS7Yi3n13nxS/K1PihYkRUSmg1+BL+hU8IT5qsS4UQ==
X-Received: by 2002:a05:6a20:c906:b0:218:5954:1293 with SMTP id adf61e73a8af0-23120901f07mr9038519637.34.1752263235265;
        Fri, 11 Jul 2025 12:47:15 -0700 (PDT)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74eb9e06995sm5840977b3a.38.2025.07.11.12.47.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Jul 2025 12:47:14 -0700 (PDT)
From: Deepak Gupta <debug@rivosinc.com>
Date: Fri, 11 Jul 2025 12:46:25 -0700
Subject: [PATCH v18 20/27] riscv/hwprobe: zicfilp / zicfiss enumeration in
 hwprobe
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250711-v5_user_cfi_series-v18-20-a8ee62f9f38e@rivosinc.com>
References: <20250711-v5_user_cfi_series-v18-0-a8ee62f9f38e@rivosinc.com>
In-Reply-To: <20250711-v5_user_cfi_series-v18-0-a8ee62f9f38e@rivosinc.com>
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
index aaf6ad970499..45ac92452e13 100644
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
index 0b170e18a2be..59fbc9c2d126 100644
--- a/arch/riscv/kernel/sys_hwprobe.c
+++ b/arch/riscv/kernel/sys_hwprobe.c
@@ -113,6 +113,8 @@ static void hwprobe_isa_ext0(struct riscv_hwprobe *pair,
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


