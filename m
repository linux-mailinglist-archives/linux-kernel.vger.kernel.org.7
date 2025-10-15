Return-Path: <linux-kernel+bounces-855042-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ADFA4BE0065
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 20:14:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0FF5F19C8264
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 18:14:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E8A9303CA3;
	Wed, 15 Oct 2025 18:13:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc.com header.i=@rivosinc.com header.b="SlxRf0vR"
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B616530146E
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 18:13:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760552026; cv=none; b=KV7BqvEpjRI4iyQYvCVa9B6a1Z65dThfRUMobizLY5M7xfsc7x1BjLWU4aYb7wbjXM5LIHuk519/MhTk42KbliQCtJ3DFObkMPU9kY5aUjkOL26aUvhf5GfjKB6p1pqo5PN8oD4PoB+Swb/ZMU6J3TBB/PgU6cItp0oBT1lcuz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760552026; c=relaxed/simple;
	bh=pkBAvc0IieGGas1vvYQtOkKUWHcQF724uRmRqVMGgPs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dAaTHRXkkotEl0xg9dMvf8qQBEmAMSplbZUULvFj3kwlT8vb924CC7b+zvGGcDmX+1LksNB9W7UTsPghGGDEzW1z+Ii3qj+KCn4uF8cqKPypYMoKTxZizYTRxzlDbseHyjGmTHQBlSZzojAPoFkEvIq7TwSN6CuaDFp24Z6t69s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc.com header.i=@rivosinc.com header.b=SlxRf0vR; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-782e93932ffso6132830b3a.3
        for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 11:13:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc.com; s=google; t=1760552024; x=1761156824; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RuPJu5G7SzSWQtkc01838lduYo70q11KgqBzT6e6NXg=;
        b=SlxRf0vR86f+JdCivXZVuho/Ou6syE5bOrJYIXDsr1N2NnwLQbpE78vAaPkCMa2gD5
         dswCw9Tpnzgdx6fOQImJ8FDo+uaL3zooSIaAr+OoRC8AO09sxFOyX7JBhGbv/SSEO08I
         7DXG5Rf+/bP+fG56dUZF39Nz3Yp2eE3Fs9Fo07/ICgZd66wTBnJ5CeBSNjUvdgl4SwI7
         u7zTs60+yqT8Qr0oNNkHlkGcEyjErRmMPy7p2zj0XGysRaFXGPknSakU64SwZqU/UwHx
         TlMkA8o4Mt6Szf6U7VMqHfptggkKy0v3e470kSwy0S9ofTiwojfRpcJHy8gsEqDwbHMF
         vWUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760552024; x=1761156824;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RuPJu5G7SzSWQtkc01838lduYo70q11KgqBzT6e6NXg=;
        b=TGCCn1oJF3UsPn59kWrE6PAUaTRLodu21H2JNGA6l0tQdYKU529XCi74C2EpiLr8d0
         27PMPFgwJTj7gZ0PdaHNDrIQhc+DFyGxOoPu7nTe9kuI8vyRIR8tvHYQURufSlqXNOb4
         EqaHhMgXm6jsRmYwZ8U2kETF+P8/ATB1bzrkr1o6LnqwGXji6cailfwqTNudtSLgb9TM
         oNV7oFlTCL7uWURAFIcPDlInvpD4RJ9KO7o2M8lLxZ0vzpf11Pz4avhwiwjj3Xq8OXLd
         1IEbPhW9g6xqFuoMHZxCQRHVq9I2DzZ5+kmEVVbqh3v2zedtBdwj8mA2tMrnHDlX8UYf
         tQ1Q==
X-Gm-Message-State: AOJu0YwXspMqE18nyavEjEqXTEm+sx6mU6cgKa6wsy1/myhNmLgFHCWe
	tPjiKr5id3REh+8oPXMAWyJJASbESxW688JxL95LetA7kJWAmdK/G+Wep72Xcae7ET4=
X-Gm-Gg: ASbGnct+Z6qKVcg1vQpsLna6qdfCWMt7KdJifqHmAgc0HLPXPliTwNuVCOiUoKk7RNa
	745U+UVWAFSUvKf79y5MliMDsMHwNgGFu1RiZZ2TFEDaQ1ifrciL5632fV8MxLhp0xj+4CdKjSW
	ITVBheo6+o52gWVYPxHSI9zZvNc+gT3i08C1qmtFd+vIl/ThoO4u7xzPwtHwvqjDc6W5SARngz+
	XkPmWXxjyafqxHxtjcZ2QFl/kH61b/k4vvMoVUqqTmy2m8V5a7K+WNxq8Fu53r/AY9Zee/xd1CP
	k8ohTyGECQTAcuWPUOR6KblVDoevnMOInhWDYJkjXrLzFpDj7SrP7SzWv83m0BbBszSc0Nbhutn
	UziwLQsCld/VgklkUFm8bxiLUXvhhBTP2eWXpYa8kcuUECdi6pHirDxP5MF5gqg==
X-Google-Smtp-Source: AGHT+IE532Sc+sFZCiNmEvoJegTZ+cHh1Xu19llh3mJ+MHzVrRYzHyEQ1nhDnGpeZ7e3G8zwayd1Xg==
X-Received: by 2002:a17:903:2c10:b0:27e:e96a:4c3 with SMTP id d9443c01a7336-29027374b5amr339106065ad.14.1760552023763;
        Wed, 15 Oct 2025 11:13:43 -0700 (PDT)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2909930a72esm3126625ad.21.2025.10.15.11.13.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Oct 2025 11:13:43 -0700 (PDT)
From: Deepak Gupta <debug@rivosinc.com>
Date: Wed, 15 Oct 2025 11:13:33 -0700
Subject: [PATCH v21 01/28] mm: VM_SHADOW_STACK definition for riscv
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251015-v5_user_cfi_series-v21-1-6a07856e90e7@rivosinc.com>
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


