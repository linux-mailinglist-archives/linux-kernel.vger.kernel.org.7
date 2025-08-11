Return-Path: <linux-kernel+bounces-761696-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ADFC3B1FD7B
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 03:20:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BFBE3173D80
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 01:20:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFD2C1A256E;
	Mon, 11 Aug 2025 01:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UZMGcJND"
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78B7BEEC8;
	Mon, 11 Aug 2025 01:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754875194; cv=none; b=f/zOWbBZj/hlJJJX+x9dTgsL0mJlGQFe0I72jnTbW8Aea2iVA/nLeAaYC4rNgosEdjsxO5b8diHXBwtrYVfjZpV6EkOHa1GKlR75oh/pQW0SHegiafDzwjTpdHOXpIFqZR5J7F4aCDvmvfM+Z+5frB5OH/PSmEpTZ/UB4r/zjSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754875194; c=relaxed/simple;
	bh=WrqR1E+lwuj+usOuwVOVEpSZT5+J8H51r/sbYgj0naE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Vi5i3byrtq3xW0h3h/u3azrfKB4uIKpdP6bI8P7UiJa5w37UqOg6O13F6cCBJHXKDvOiifqzwhGFas7HXKHcgt7Q8NaWaYS8wUTacPdIDldwvc4449bLAwZeTWGCHZQOpJWbLLDBhUR+vw62Dt9AsotRxiKN/wtPWFiNwCZQLUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UZMGcJND; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-615c29fc31eso7325005a12.0;
        Sun, 10 Aug 2025 18:19:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754875191; x=1755479991; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qkeHcyxJkTHYSHNibW8ssztQBo3aMnnMqKla/7jGqlw=;
        b=UZMGcJND/Q1MvfAJ6JOqix/c1NDg/kkVt3RkhcyQntBTY2eE4BkYtzba2z8O8Ee8N/
         9WhyTxBsTpOZfRZwbmwOByqJRjGvFeQUcAApsWEk8G3u/qkUqu4D1nJRf+xFx+t8iNWh
         3OFG6RgegYJuBCrYwri+OqjFbAJnKdl76yxEV38jEJzrGES7l1DOnlPdWV+/t+0MAR4a
         HsJ6wKcxa97TpxKiH/QbHSpzMgl9vSilYrBs2m6/EpmxU1fHczED+bNm5kO4X5UkUHil
         tQ0A+kJ/6vzMWvAZclZyhLK45q3LL+ZsxJ5S408PhGWM6aLMPsYGV8UwtBajqaeMGttN
         Dr+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754875191; x=1755479991;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qkeHcyxJkTHYSHNibW8ssztQBo3aMnnMqKla/7jGqlw=;
        b=ZDBSVMlKHSmJvN0EVd1zaN1OcZEXh8Bi4+3+tfABuFPkjc2CaAnidzqLta1ycFaqsO
         Dnhu5cW84cEOYl0098+yhgyJM3jURfwmWzRO8MXA0IWbZY443RMw77y+KsD7Ro1iwL82
         SI6CaOo0cfP6CfDI6ADJzo9zZC1Psy2dCfPAflkeyMtqSgE3pKH42p8pzVqsEsUVAVKL
         T7zxNaSGUVFBCEm9d31SkHm+wtRkgDGwfSQ0I33JmEpspppak59MJFxqeRwYWhPkR5yT
         OohH+5u+hgbvJep4M+QfFKD7tskLj472f9m2m8H0tmsKUC/lYaKmree3CMzsMd2b1BnF
         uSig==
X-Forwarded-Encrypted: i=1; AJvYcCUrURyjmaO/DWoNztixmKuRcqymNnl3cYiabJcIQDB0ZAJJD3cfn7TQp2DVJ4JW82/KKyd1eZO2YU/qev4Cyvo=@vger.kernel.org, AJvYcCVQyiqkL8KEoy5PB1c6v+Mhq6Vss1s2t5DiSZmvWA7J75+/7ts3h1COeFfcrHVK6rjl+lt1eE3VGvMR0jo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxu6NKNzyLowstuBlsfjwqz1BYEHrB7fGC4yK0ZPsNgsUG5K98a
	2oOdVvUSv1vNzkC/yeLp9vyYyV1IBR8vM3AIveMT0po1OCKnXGIIgEv+
X-Gm-Gg: ASbGnctHtoyxmj+j8CQc0B/caSEwzopu1rghAb6cCqvi0upTeiVyI7RRB9/XvrlLK8d
	D5z7A3ReZsUskJ7+dylud7ryMVxlElFtzguqJ4lK7BtN1vSKVDsd2XG3jnYuo3mdgVs8431UR3F
	GgolmV6TgY4cuvFKuTNkQS79NVpIRUlPtlC5t3lOny7HXnzpd3cdOJQNRyj7OS2dyIi1yDl1ctR
	rDtUgJZpwTk3waMXpFKN46dF5dFkkYc7/WQpC/7es0Poex7I4y+EHfWd5voH8rjDC9m4yT1yEi2
	NDfG0cJ1wkU3oJzZ57fkJOs5t8Ww5IWiSJ4tRKpGA4fFnAY5RpjydNyeucheXJ19EAQdC7z7lsV
	iHRLfWn3NHWqJz++/KKP3ZV9siUFfmQCNf1I=
X-Google-Smtp-Source: AGHT+IGHeFsBy0ZMfEksdIuPmJB8a8RALCdpok1GmhlMEKrmNokPHN8eNrX+hb1xtNNVF84odqNV2A==
X-Received: by 2002:a05:6402:3483:b0:618:196b:1f8a with SMTP id 4fb4d7f45d1cf-618196b217dmr4253122a12.4.1754875190610;
        Sun, 10 Aug 2025 18:19:50 -0700 (PDT)
Received: from fedora ([2405:201:5501:4085:eece:e0ff:6b68:de2e])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-615a8f17829sm17381133a12.19.2025.08.10.18.19.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Aug 2025 18:19:49 -0700 (PDT)
From: Ritvik Gupta <ritvikfoss@gmail.com>
To: Thomas Gleixner <tglx@linutronix.de>,
	Peter Zijlstra <peterz@infradead.org>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>
Cc: skhan@linuxfoundation.org,
	linux-kernel@vger.kernel.org,
	rust-for-linux@vger.kernel.org,
	llvm@lists.linux.dev
Subject: [PATCH] rust: kernel: cpu: mark `CpuId::current()` inline
Date: Mon, 11 Aug 2025 06:49:58 +0530
Message-ID: <20250811012000.444173-1-ritvikfoss@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When building the kernel using llvm-20.1.7-rust-1.89.0-x86_64,
this symbol is generated:

$ llvm-nm --demangle vmlinux | grep CpuId
ffffffff84c77450 T <kernel::cpu::CpuId>::current

However, this Rust symbol is a trivial wrapper around
`raw_smp_processor_id` function. It doesn't make sense
to go through a trivial wrapper for such functions,
so mark it inline.

After applying this patch, the above command will produce no output.

Suggested-by: Alice Ryhl <aliceryhl@google.com>
Link: https://github.com/Rust-for-Linux/linux/issues/1145
Signed-off-by: Ritvik Gupta <ritvikfoss@gmail.com>
---
 rust/kernel/cpu.rs | 1 +
 1 file changed, 1 insertion(+)

diff --git a/rust/kernel/cpu.rs b/rust/kernel/cpu.rs
index 5de730c8d817..cb6c0338ef5a 100644
--- a/rust/kernel/cpu.rs
+++ b/rust/kernel/cpu.rs
@@ -109,6 +109,7 @@ pub fn as_u32(&self) -> u32 {
     /// unexpectedly due to preemption or CPU migration. It should only be
     /// used when the context ensures that the task remains on the same CPU
     /// or the users could use a stale (yet valid) CPU ID.
+    #[inline]
     pub fn current() -> Self {
         // SAFETY: raw_smp_processor_id() always returns a valid CPU ID.
         unsafe { Self::from_u32_unchecked(bindings::raw_smp_processor_id()) }

base-commit: 8f5ae30d69d7543eee0d70083daf4de8fe15d585
-- 
2.50.1


