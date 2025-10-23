Return-Path: <linux-kernel+bounces-867023-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CD6CCC015FC
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 15:27:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 71D371891738
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 13:27:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 196F5320A0B;
	Thu, 23 Oct 2025 13:25:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc.com header.i=@rivosinc.com header.b="E4/7ITCB"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AD2731691F
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 13:25:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761225943; cv=none; b=S/uHpJQK1Pdm84tS3zyaN6j4C8dDcP3f/5o+0P22xcLM0KBPt9INRz/Ec6nRyyb529Vh36r5dJX/KDYe6PIwyxp+4bi/ZUUaZeOmisSDYtXb4R+gzZuCJgbVKsjzMUcIrUAYXZujEGZFB7OVK3jlTuhed0tyY/okIWm07kxT4KI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761225943; c=relaxed/simple;
	bh=pkBAvc0IieGGas1vvYQtOkKUWHcQF724uRmRqVMGgPs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=loWkqILRCP4Dx0EtwNLF/XBCni6Xc8CieNAQyDqC7ybVNrmvLbbYdOc+4/s+wTkAPagRLZF4OCpWycITTXoh+XGvLaQ/GNsnx9IieMqLgCXzWELvvIRw6XtOicjMiZyD3Y2eJ2qf2MiZe8jgZXa2jtzvYYsbrta9BOHpikO6RdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc.com header.i=@rivosinc.com header.b=E4/7ITCB; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-290ab379d48so7851705ad.2
        for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 06:25:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc.com; s=google; t=1761225939; x=1761830739; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RuPJu5G7SzSWQtkc01838lduYo70q11KgqBzT6e6NXg=;
        b=E4/7ITCBWptg72BiEBB3U0Y+HLUU4GATknwICuFutAexZPdv4pMZWSZhcpO8Edwrkx
         zcis20coaEekRXCV7qkgbWBC+/55gwvA/+eXuCRpvZOpY/A8DSZgqT3rOzIAOqJZFBdo
         nixvpcnXF4FVxwaj1jvRzuKBQfYJX96JXmB568BmU4KHswqhqIA6F59fBPbz3rSDb1Wk
         q+jaRovJNf3dFAKlTEL7xN35MdPywwsNWOP7qyw34Erk6uYm2k+swJbYFI31gyEA3wtu
         SsN5LwkvbciaTMy8e2AOGw5wbyr9mZHVGHmvIgb1lxJ0/FW2g9HLjJ1T4ZzWyAd3KqkQ
         rK5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761225939; x=1761830739;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RuPJu5G7SzSWQtkc01838lduYo70q11KgqBzT6e6NXg=;
        b=AUfjx+zJcqe8lAEpVqi7Je4YidSe39gvr/TarLH6QIdBSDB7vdAHlPGGFEfNzP8V4o
         90+NqZozCTX2PzUNd7YQoyXhMa+VjVSavtdm2gctg6XVKCNAKmaKsjrAYVWKYehYnNfQ
         8gZMPc5PRSN8c633xXMeymxYp75Cg6OWNedDl0SQK4MwpHpjE3onZMS605cSATPJx0cf
         gN4MieG5HCA++eixFToIVzbA5BdBS4fka6RtZTlxa8a/IF7v+J23DEqtcW9lFVPiCcr4
         ric5kqAeEu/Ejj6TTi65ORo6een/AzMdWVT3/v0TN9PhhhdIT+3DsLKTdjb/W6iKWL2i
         VARw==
X-Gm-Message-State: AOJu0YzmJ6Tq5T24NlBD6J8HzC08/UItkwNHtAfnFz/jy9LNuF0MzNEt
	BYQk5H0mG+yBHUQ4vTDb3v29ehnmwZ/QF2KOxM6FTI8oz98puu+QN/fD7ohK74Ckasw=
X-Gm-Gg: ASbGncux/51m3MPEtilQSP3nDeUVIcDwtxIl612f7bxgl0/vMBIyaEKlHkwx2CxLPW9
	o86aQvSXH36RUJta/EGPi1tIjUh0EClR0s3BQBxM8neLKlCc4Krnb9Tob2nmaovcUNvHs3yXYxY
	tokWE/929bFamP6xCE/blQ3O3/qZxmlozCMH6ub4R1v3KT0oslqLpLGG4LrHuWzZXN8vv/ysPwn
	bB6nnvFuyWg+f6PgMrjU/hC1eENk1gOjxSEkUwWJ/jhl50Y0Qps4SpVJsv4yNmHTiGeE4ob2LG9
	phcOo1EXm4hUsSWhunsvG4RC4p+lXQ9yE37/6mvhgAq/VlaM9GTE5Cg2PgR/l//K/jCCt1ZG/yb
	ZdKd+AtunoJAjNaEoBnbPr7Hks/lh1Km741xriq77s3LThhDeBtMokzdrFl2mM5eDq+ZbM2sjSQ
	dVdW8652YbkBp6NK3fW842
X-Google-Smtp-Source: AGHT+IHiowaMdQQMukarKWR4DwE59dag2M41jW8yOYSmyuKRWbrYlIpW80BNasPiFne9iuxrtQYkag==
X-Received: by 2002:a17:902:e889:b0:27e:f1d1:74e0 with SMTP id d9443c01a7336-290c9ca3304mr315130655ad.17.1761225938726;
        Thu, 23 Oct 2025 06:25:38 -0700 (PDT)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2946e23e4b3sm23432035ad.103.2025.10.23.06.25.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Oct 2025 06:25:38 -0700 (PDT)
From: Deepak Gupta <debug@rivosinc.com>
Date: Thu, 23 Oct 2025 06:25:30 -0700
Subject: [PATCH v22 01/28] mm: VM_SHADOW_STACK definition for riscv
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251023-v5_user_cfi_series-v22-1-1d53ce35d8fd@rivosinc.com>
References: <20251023-v5_user_cfi_series-v22-0-1d53ce35d8fd@rivosinc.com>
In-Reply-To: <20251023-v5_user_cfi_series-v22-0-1d53ce35d8fd@rivosinc.com>
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


