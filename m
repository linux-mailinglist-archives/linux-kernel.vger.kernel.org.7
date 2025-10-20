Return-Path: <linux-kernel+bounces-861734-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id CD30FBF3856
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 22:54:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6F2A64E8B4F
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 20:54:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93BF12EC571;
	Mon, 20 Oct 2025 20:53:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc.com header.i=@rivosinc.com header.b="dtLMU1ry"
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB6B32E62AC
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 20:53:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760993621; cv=none; b=D6nPGuJBEUXEcnv9Wl0HG2oekK31o8RSbANtKEFF/N1pa9Vo8TnRixS/y7jIbcO/IWj3sa/Mzi/7Of7U9DluGuzsZp44JBwVx9DSE44Ucg6aL+EAcbMo1usih8tjcO8xnCMSV+qmvqhMa/EiqscjZaCQkdbpQTKl6cU4bwB6g5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760993621; c=relaxed/simple;
	bh=pkBAvc0IieGGas1vvYQtOkKUWHcQF724uRmRqVMGgPs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=EqfOeKHu/T5cu+pgXcWCgrSvDFlIr16slTctVR9aN1C/Kh44dRuEIBp636jg8jRW2NxNh4NHD3/EKTKE+i42RE9okj8RcYlqQG6BY1UWjKKWUZLqjTteuFnxqWZ6S758xTN5sFNuSInni9/P3gxLxRb0Our3c/QpjekxirxENTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc.com header.i=@rivosinc.com header.b=dtLMU1ry; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-791c287c10dso3732069b3a.1
        for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 13:53:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc.com; s=google; t=1760993616; x=1761598416; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RuPJu5G7SzSWQtkc01838lduYo70q11KgqBzT6e6NXg=;
        b=dtLMU1rycyARKWQIVOYGO+jYNn9U06eJs37DrBRdiCCa99/bUWpjMB4tbiCEeYMSfx
         VKlH+jOF9a5rgNxoQwf0w7mC0ddlVQsk7JlXLp+FYH9Tm93UzxvRPCjcEzii1GTHN0UD
         YBuIgifsH7ulKg5RuFgn7Q/XT3AfHWefFyiwRoOPrEXvg+3jiy/UgR3C6YL+TxB0zz1i
         qhP2JdroZ3dAe/5YEBBpk335TG4U3dlv2ug9/W/kq85yjAjQYXAsAyBNufozxL6xPzwo
         PYqjYFLPQEgekOMlmJcm02mrxoY9MMhS8h3ZHpt8cOVFdj3FsI1wl6ABAqMnAJB5SLiT
         seYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760993616; x=1761598416;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RuPJu5G7SzSWQtkc01838lduYo70q11KgqBzT6e6NXg=;
        b=hpwJ++yYfQvwAIQXK8KDe6mIXcX1C73TzK7BhnpA3vLoxZnoBaKGy8IhYWeYiJIM1i
         Mtw2KudKyzHrC53qDR0VZvLpc/xGiU30XeULfwiUbSz45JHU6lfYdHbz5XWR1eSULkTE
         bSiUNv6N0/t3gf7GWpzpQlyFRUy1uNyZJOjRplbHOEIGuIoFYEXz+EGSsMtdlmmFAHEk
         ayOTQigHGGwa3VQMFtnEUxZTS9eHnxVP9KzJrsCVy2mJ9h0ialtwjFU7IEXmxEJE19UH
         NKOy8HTilBwVcgx3rhApDMosvs3tSj9aEE/U1ENrJGBowDkEkPDqH0U8xKu9R3tjZ+xO
         QGSA==
X-Gm-Message-State: AOJu0YyTKEd9M1i/wmMEOOPniCcxemomnD7ZHNkkjHLiJnZFNlDhWAwG
	Dog8hPJpT03daWJ+KZOFyajIhQe1FYS0fHVTF6YRaCNPdNjWVn6/HWrY1gvWkfmz4MM=
X-Gm-Gg: ASbGncuY0uMKpPzRR1uRXrpJxbsYU1AytbaYuutmK/9mwdiAQdF6MsuMRnNE3KB1Mux
	OyBsIoIQayQSPRCTjpiqwS0ydnDW1F9b9NPfO+1W9d+VfmFMa0OUKFCEPM3/UpXxcHmt4rAdbWa
	4bYHZ5WSIN9asROTmUSE6xXmYKmOexJXcAkZF90/ah0toxbtyftlUXZEteuLTjtE0lt0m9VCWCF
	ZiY/uO6u2i8gf5KaEM+ATR927PFW0UXpENB4O8Xs5n9awUB6beDKaBoedvi6fCiL7/rYvJ52LfY
	FMFFeGJIDb6HM11unYnkB7SMzotiVz34MG/Dj7UYWcfr6pd9lnA2waNJFu3EV5h5aPjVRIpNrQo
	sv3j9YNgKY2IBTcRp++/Yb66MA5GWeGPNKfMpcmyb4yVc7cn4khqQ1qh3KJzdXGJBWyPzgwhu1x
	Sam3lRhPXSrw==
X-Google-Smtp-Source: AGHT+IEsg+UZtjwN6GyVBaH9enzTC3xW7GiUIy1dtvM7p6mWAAST23WNYHXDrDm86KscnwevzOzJsg==
X-Received: by 2002:a05:6a00:a8f:b0:792:574d:b2c with SMTP id d2e1a72fcca58-7a220acbcabmr20617941b3a.15.1760993616488;
        Mon, 20 Oct 2025 13:53:36 -0700 (PDT)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a22ff1591dsm9453867b3a.7.2025.10.20.13.53.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Oct 2025 13:53:36 -0700 (PDT)
From: Deepak Gupta <debug@rivosinc.com>
Date: Mon, 20 Oct 2025 13:53:30 -0700
Subject: [PATCH v22 01/28] mm: VM_SHADOW_STACK definition for riscv
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251020-v5_user_cfi_series-v22-1-9ae5510d1c6f@rivosinc.com>
References: <20251020-v5_user_cfi_series-v22-0-9ae5510d1c6f@rivosinc.com>
In-Reply-To: <20251020-v5_user_cfi_series-v22-0-9ae5510d1c6f@rivosinc.com>
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
 Zong Li <zong.li@sifive.com>, David Hildenbrand <david@redhat.com>, 
 Deepak Gupta <debug@rivosinc.com>
X-Mailer: b4 0.13.0

VM_HIGH_ARCH_5 is used for riscv

Reviewed-by: Zong Li <zong.li@sifive.com>
Reviewed-by: Alexandre Ghiti <alexghiti@rivosinc.com>
Acked-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Deepak Gupta <debug@rivosinc.com>
---
 include/linux/mm.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index d16b33bacc32..2032d3f195f1 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -380,6 +380,13 @@ extern unsigned int kobjsize(const void *objp);
 # define VM_SHADOW_STACK	VM_HIGH_ARCH_6
 #endif
 
+#if defined(CONFIG_RISCV_USER_CFI)
+/*
+ * Following x86 and picking up the same bitpos.
+ */
+# define VM_SHADOW_STACK	VM_HIGH_ARCH_5
+#endif
+
 #ifndef VM_SHADOW_STACK
 # define VM_SHADOW_STACK	VM_NONE
 #endif

-- 
2.43.0


