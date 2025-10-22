Return-Path: <linux-kernel+bounces-865999-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 74C20BFE8C0
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 01:32:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id DDA9D355A4E
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 23:32:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD7A73081AF;
	Wed, 22 Oct 2025 23:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc.com header.i=@rivosinc.com header.b="Prbll6mU"
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C557030DECE
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 23:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761175797; cv=none; b=NXe+304drFV1uDEiAMraXtpliIPB9ykCcfWrLze41EwSW+UM+bzwRS9QsdHczfxLujE5p7xTYbk+XD7BBaEIt7vhiF/3xSWythmrMXhFBLH65FIL6cbAnTEGD9XIFkFNwGtAV2U7tSRFikK5Jp/9K3/WEnDH8WuDDIz2AgjZe8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761175797; c=relaxed/simple;
	bh=9AtWvDKQ9q5op9YLRgkrDiWaHEAhrRbEgloHu05lQww=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=I6ThzgyCHzFUj0lNYE9jvg57fOvEefOjXipsQ0qSdgDTu8P6LbxI7yMxk1CTBGdDHuMYK1/VAO2piHHOHHoF+iumekiG6U4zqpKURVK9HN+Hn1jn0APSVPPuiUi5hCk9OjT0Jygk0TH/9/Dz6Z6CxaqjqQ4Z3WuB2np7Qzc4RGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc.com header.i=@rivosinc.com header.b=Prbll6mU; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-7a226a0798cso150616b3a.2
        for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 16:29:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc.com; s=google; t=1761175793; x=1761780593; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oeDKcuIcO6+2FhxyceVVS2WWiuktyVdq1WpyUni2wlA=;
        b=Prbll6mU1vI2MIpiqqmRiIMlDhiQcn+TUaFuVhmIhP9Km349sm77sL5AchQZcY5TAR
         xvHg/0tFiWpuZkcaFGtF2pN4qUVVyNc91wZNE6/8yTuVQVIE6aAHdYuMD3QYF9hDeMZY
         x7FnR3eUvoggqvZjevW7xrtHIJ8MIZ2P2yb08axLCQzV+8Lj0J0pyQtXRzhHb1QHdbIA
         ldxf/lzEE5AuLENUCZIrNQ3R3fptlDCGVGMoDNrcD0S1qv7yOoTFdKE+kXdxMb2BwwP/
         u5QayRieaRlGqiy5HcMDfXS8tM6OK6duQ5tAEMfP2Y5SgoXEqv5EE92YK4IiZaH3sKmI
         qKwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761175793; x=1761780593;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oeDKcuIcO6+2FhxyceVVS2WWiuktyVdq1WpyUni2wlA=;
        b=O7f3Bd033xfocStdBP3m7+47FhxPlTKWXf3XHD5EB9FEv0JQsIiMT3JVFintbmOT9r
         V/ExMq0/2LT+y+krv3sFKGsygmzgSbX+6GjivFoEMEkYb1iv4T8nXj8+rIh1Qff9DH/L
         6kG0qP/ElJqaw/kW/89nm86xIx8OvVoFNIgGUs3bHhU+J2fvYtfvFnMZWhMtUkI9Ta1F
         v+3yF5uKoE7fwkpYYiQIcj1g4U4eAGgu638ObG8H0z/DnCj8w6jHHksd/iFSnTTP7Ehi
         iF27ivp7GFy5I7HkIqyaxYrCKcj9VKE1eCVhTyCajjF3jncrBmBn549rkrZCjWS5NtB0
         Z0bQ==
X-Gm-Message-State: AOJu0Yw+HoNdxZBzg4uxa9lWZ2xqwVPAe/uvMF73XOh8yU3KIcc6SbEc
	MMdsoLuBQ8S1zbsF5t3C/GO7H+h/iPs67chh/ZeVQIom9O/ohXs4PZBUsddRKFrjttg=
X-Gm-Gg: ASbGncuY7latBJlkREip+sMz77FTpqV2Zz3IRfX7G5LiKdgyvG/fi0jfI+6D+bX/aRS
	DlWVdIAqPdCmDREnjGtFJICY+wQwaUHkI+kNQPQr4DRBr1s6UGiGealbqZSZxhASTR88bvtmuye
	W5UzHXyA4ge3AnskjIkrOZYsRBkFU3W5ECVIyd+QTUq/W/Q2TNjJ3hYTUzyYKLd5M1mMc+tbT+m
	OwYQbK/tLEb3yyCiYaXrH9q9Mx2I4vhPBrtNKr44iikmwexEq4tQZa2HqBXSPTBB4WJzNiXllSa
	p3RIdq0tLMldqUE2ST8esWJGnDc9cC8V8WkNodsLfVHYRq+8L+7DNivFwBWzgOr5VPQ7B1rWelK
	5K+sx+ryjkEZb2UvjfNu4oF2TsmaZHfc3R+IIOpGUNigGq5Wewq6e9UEkjDQR56Dq1amfVs3P8T
	lMJKBmGrnJFw==
X-Google-Smtp-Source: AGHT+IEyYaBVYRUloskvUCZ/yxzw7bPY2t7mEI/bU4QrTEjElNpmobT/VekcDiyMNALIqBN5WCBgDg==
X-Received: by 2002:a05:6a00:2e1b:b0:7a2:7157:6d95 with SMTP id d2e1a72fcca58-7a2715777f0mr2234795b3a.14.1761175792856;
        Wed, 22 Oct 2025 16:29:52 -0700 (PDT)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a274dc12b2sm392646b3a.67.2025.10.22.16.29.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Oct 2025 16:29:52 -0700 (PDT)
From: Deepak Gupta <debug@rivosinc.com>
Date: Wed, 22 Oct 2025 16:29:33 -0700
Subject: [PATCH v22 07/28] riscv/mm: manufacture shadow stack pte
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251022-v5_user_cfi_series-v22-7-fdaa7e4022aa@rivosinc.com>
References: <20251022-v5_user_cfi_series-v22-0-fdaa7e4022aa@rivosinc.com>
In-Reply-To: <20251022-v5_user_cfi_series-v22-0-fdaa7e4022aa@rivosinc.com>
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

This patch implements creating shadow stack pte (on riscv). Creating
shadow stack PTE on riscv means that clearing RWX and then setting W=1.

Reviewed-by: Alexandre Ghiti <alexghiti@rivosinc.com>
Reviewed-by: Zong Li <zong.li@sifive.com>
Signed-off-by: Deepak Gupta <debug@rivosinc.com>
---
 arch/riscv/include/asm/pgtable.h | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/riscv/include/asm/pgtable.h b/arch/riscv/include/asm/pgtable.h
index 4c4057a2550e..e4eb4657e1b6 100644
--- a/arch/riscv/include/asm/pgtable.h
+++ b/arch/riscv/include/asm/pgtable.h
@@ -425,6 +425,11 @@ static inline pte_t pte_mkwrite_novma(pte_t pte)
 	return __pte(pte_val(pte) | _PAGE_WRITE);
 }
 
+static inline pte_t pte_mkwrite_shstk(pte_t pte)
+{
+	return __pte((pte_val(pte) & ~(_PAGE_LEAF)) | _PAGE_WRITE);
+}
+
 /* static inline pte_t pte_mkexec(pte_t pte) */
 
 static inline pte_t pte_mkdirty(pte_t pte)
@@ -765,6 +770,11 @@ static inline pmd_t pmd_mkwrite_novma(pmd_t pmd)
 	return pte_pmd(pte_mkwrite_novma(pmd_pte(pmd)));
 }
 
+static inline pmd_t pmd_mkwrite_shstk(pmd_t pte)
+{
+	return __pmd((pmd_val(pte) & ~(_PAGE_LEAF)) | _PAGE_WRITE);
+}
+
 static inline pmd_t pmd_wrprotect(pmd_t pmd)
 {
 	return pte_pmd(pte_wrprotect(pmd_pte(pmd)));

-- 
2.43.0


