Return-Path: <linux-kernel+bounces-752689-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AF08B1798A
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 01:22:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2CDE73B5218
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 23:22:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E8EF285054;
	Thu, 31 Jul 2025 23:19:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="rzeHB25B"
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 787DB265CCD
	for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 23:19:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754003982; cv=none; b=GuhA2/ZnMK0Xap/ciNL+7A8mklzgMRM+YaBUor12+mbutsQOqfWTe8LcKHIEo2YNOP3hjZ5rQzBi8evlHKbUkWZAWj2jCPshaDwjPcY/UwRe7tLYSFe6uhnt+5ryvYeNNZOkNj9mAtJV/iOWM9BSuIE3lF32VLHCzZEeW+HcoZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754003982; c=relaxed/simple;
	bh=1FCtprg+5iy5TwUAdOVeniUOl54kIVW1HbeIvQ2AWDc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=eSSldJMZDM5XZJlyfBkYouLev0EV8a5V5KTEiuFkdDfjJV4N8EIeC0CN+zKeDV9i7itokMFCZ0p6RxVrUOqYxSesDKkaMCRjxV2zYL8dfW1erQHZgDhegTg7eRYm0J/Gp37fqWvrtNKnWg6BcEAp1XyXkq/fwnrzM8w4dt8S6k4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=rzeHB25B; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-b170c99aa49so992495a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 16:19:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1754003979; x=1754608779; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ez7fajQ4lWgiIPATC51FeBxCIECW6n3uAlkHVBFvak8=;
        b=rzeHB25BkP8OtL88dznDNbD9BTMSKv8OS7sBjQ0Wjci8efkXrBnnhupRC++7/qFYDf
         ZdO0Y6RajlzZVjGqYHx+J0D9233OeTp0mZLdrrtl4+NyR6QG6vHY6d56gs34RdZoN3Qb
         yGsf78ALnN/kN3rhzzzXDK3fUGvWZlnZAM0vhAfzpFA5a4kAEH3zLnQfd6PvpbDpGd7f
         uEFk7fvbISptW8fxN0SgPdkz+iJp6RlZztGvPf8DNgHU9UmpmQvBmw1rSvH+XmJRfHQx
         HUOI0fG3KPsF5hcAfQ96pTa+EM0+L58/kjk+WZE4oggGwtXpG+8Rj3Wl7YG5WhvJMlcQ
         4MFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754003979; x=1754608779;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ez7fajQ4lWgiIPATC51FeBxCIECW6n3uAlkHVBFvak8=;
        b=lp+qeX8DOfM3os9Qdb1ZZvOyKXsXmyH4AwiJmigiHvxN0v3ezT2C/YvrA4uj530pt7
         rjg5LZ0O538Sk655KYwjqYsMmulmXEjknJ076Rl7GkHXBb9+iT324w5X66kmHcO/2JUa
         GFlf9/QWnOSnQSJFtEllsERkKIB3h0qz14HOHdeZMbaklOiGDToxiaaN1DwaRtk+RzaW
         uk4d2EkpHNQwCle7B3cYvGJg8pHF9YU8HDxqqgiStGGKv6oxepFvNdoSs+rrmXxuou87
         AHJzgSU7rkMbqcVg5bEb1ohkMSkMlUSeOVQOgjMGkiPwdX5J0JfTCQyI4n3/qbj+RP7j
         IKsQ==
X-Gm-Message-State: AOJu0YxPD9bm0FnM3GrN/rPXDDOlhH4WIc9ifb60MBs8nktu6SPSKpQq
	j5cVfkKP7NkAO6D3f2bOXf+Q28JKVQF87KQ6qMd6HYgDGWwP9Ali901uFvceXfb2vKI=
X-Gm-Gg: ASbGncv0P2aPq0LPmf9B5fXxoHk3LTH3xUq4nMt6ABCTXOAIiU9ockVPM4p60euelhx
	QU9tLjmSINU3eibrbZuQ3sNUgG9L0tU8NBJNEKDPKjy9zXmFcLQilMwW7i+0XECWqTvhXRDrT7/
	KJlCY6FZGPX9H4f4+9TA5iM4yFBuCX7+hddcJe0l4/Ibth2eQc3mAXbBQzDRwHOWYG+9pzLyNSK
	7IHZJRuhbssapZOXGrqe4KYQasskRaG81WgfBBkH3nke96zh1qjUf9kw1/9miz8d4UtyL1DinSS
	Hc2KGuvTBvB6nyxVudaQhMc8ZhthOpT9V8OtDuuNj4Wj44g5topOnymI6o6daujpZiRuCaooxCP
	ivKPoqRTIeEJmHtEG/RnHScJq0WoY1YBR
X-Google-Smtp-Source: AGHT+IF2xo1ZfVMwTGmqa0w+CJyQOLIX1YGoKzAdOOg0c/bt0OowoMzz4A7p4t8/qA7S3n5MiZF/3Q==
X-Received: by 2002:a17:90b:2b46:b0:31e:d643:6cb9 with SMTP id 98e67ed59e1d1-31f5dd7f18dmr11303515a91.1.1754003979507;
        Thu, 31 Jul 2025 16:19:39 -0700 (PDT)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31f63da8fcfsm5773085a91.7.2025.07.31.16.19.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Jul 2025 16:19:39 -0700 (PDT)
From: Deepak Gupta <debug@rivosinc.com>
Date: Thu, 31 Jul 2025 16:19:17 -0700
Subject: [PATCH v19 07/27] riscv/mm: manufacture shadow stack pte
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250731-v5_user_cfi_series-v19-7-09b468d7beab@rivosinc.com>
References: <20250731-v5_user_cfi_series-v19-0-09b468d7beab@rivosinc.com>
In-Reply-To: <20250731-v5_user_cfi_series-v19-0-09b468d7beab@rivosinc.com>
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
index c0d7e67c67ff..792cb9792e8f 100644
--- a/arch/riscv/include/asm/pgtable.h
+++ b/arch/riscv/include/asm/pgtable.h
@@ -431,6 +431,11 @@ static inline pte_t pte_mkwrite_novma(pte_t pte)
 	return __pte(pte_val(pte) | _PAGE_WRITE);
 }
 
+static inline pte_t pte_mkwrite_shstk(pte_t pte)
+{
+	return __pte((pte_val(pte) & ~(_PAGE_LEAF)) | _PAGE_WRITE);
+}
+
 /* static inline pte_t pte_mkexec(pte_t pte) */
 
 static inline pte_t pte_mkdirty(pte_t pte)
@@ -776,6 +781,11 @@ static inline pmd_t pmd_mkwrite_novma(pmd_t pmd)
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


