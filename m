Return-Path: <linux-kernel+bounces-769293-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B08D1B26C7F
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 18:27:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A479C1C2479B
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 16:25:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AC1525E44D;
	Thu, 14 Aug 2025 16:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HoJLLvQc"
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9FAD253B52;
	Thu, 14 Aug 2025 16:25:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755188704; cv=none; b=alIvFAWIEDDU1eU9q4eW52RBLnPTyqBQNRRU8dbpU9U3XDWWkFvKCu38MqOA1NrqiZwEjMXQxP6Dh6yq4GZdap0330JI0rRANPESS2f8UIoVfZ7Km3Gu9juB32ZpdA7VJZfzLG1NgH/WJ48Cp+n1GMbrgxFR7THn22WHj6/xSTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755188704; c=relaxed/simple;
	bh=hggZl1hUNjtS+yxbTKAMKZPLnobfNpl1BLrhH7DJ5Og=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WIGRQLuetIkdqcye8ol2L8Vi6BCrjhdhJ0dp0onS8PLSKg8fKj1/HkxxEn07LIi2hI9Q5mSYazXYVdHvYGrnzMoMD52iH/+7yD2vhexwBdg9CjCNsFzNXJKgDzb7H2rEQr4tqlL6Oj5k8cuwXIMVDGVFp6SjbeQi/dauUu9wP+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HoJLLvQc; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-45a1b001f55so5520725e9.0;
        Thu, 14 Aug 2025 09:25:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755188701; x=1755793501; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w+08RhFQ3E8rEdHvCmYPxaRV3kS3t/PKb8CTOgucXX4=;
        b=HoJLLvQcsaKLVkUYAqvZoZFTyCkHPHOEnOdkqKnE/i0nb6wGmjNjLDSp7JrVzGHDGL
         /wXDRHI4f3yY3iKrsbw46VF+klFNtDToVdQ4/9xtJjE/Xl6V9jOnANKb8FrauYmo1YoL
         r0BTX6ckWBvVDpxZPnsC48R+suA1TaL/jqtivSUtEm7dwKn5sGr6BlZq/ySByttfVlbr
         mKv5c9sYKSG01AVItRILNxcT1ZNthxb8AE7MamYJuBpIZuqzHLGy2GyZ75bLWktqNnhg
         AGH71kGCNAGjq3Kbd5NKn0pqO17aEv51LRwMQB9MoxPgRJUxyAoi+G1raX5261eiAQwb
         ZNCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755188701; x=1755793501;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=w+08RhFQ3E8rEdHvCmYPxaRV3kS3t/PKb8CTOgucXX4=;
        b=ExetYu/v/pzrHT/2G5je0238DpZuH8c1pHGTdWoSwR5TGv7iNy8nUT0K+dnw4hBvUg
         +cqdGE9Vc9avGfFqsEZ+7uMk63jB7f/CntMCersQnYpa86bF/FVAHiPb1I3l/VBuo83W
         mynjlZrNsXgUqRHz/uoR8I9c64XKO4kekz7rE19JBNxSgFkLetuDrrxRAnbbZmAjPL2x
         xWI2DdmJUS1xWrhFftda7sFfbmXOOz6RlgrtU4iZlcSjEpefDhx6qd90L0h/i5KM5xpx
         W5u+Zi4xXd1kuYnP0qs8mQN9b2FHXsNis2SE03R8BPbFsK55MYPpjkFkeOIyj1f+Nb0a
         d5mA==
X-Gm-Message-State: AOJu0Ywu/0CTW435nhBNKyPk3UHMvIQQeuNiC8NjRTIfawVjwB2u5GXk
	M0wdi6uuSu1iAzHSgF+06P7GJxMj38jBcLWdhQTDZM60Z1rDccBIXsjNHnQ6uN/Tofk=
X-Gm-Gg: ASbGncsjVtAGzb/QNC52BzWOZru17fnoNNc2pYGXDQa4zebyaprMBUQbnmr73qF4dAR
	3Kti3bbks5rZ6Uf680N8bs57HWe4FvDIfTkWeRVCPcbqlPAzkpTmPgpw0g+AzHZkkv54jCw10Yn
	IkWoyNDLnmBLnvHgrZ3maJ1yvj5YSQPPsmTXpoTqiANhxTT2EzlGW7KWySJiHfTobDI+CQQoBHg
	DxfgQ83LTEtwYpp/LLuFSXvUdv8V5tnAvei1/SFHN8DvlE32eUgE6VrCs7F8MYFiik9x6w8LqqN
	HWJs3mfHnh1BmOGA6sXydDswXdz7gToN6Eq600M8NHN52o6wtfnvCmFu8XgiB3wqZv/BSiAdg+k
	e9QIYqqdqto4HKbSg8wSQO81gUXw=
X-Google-Smtp-Source: AGHT+IELZEsgLdNZx5W51MHx5RIr7lqU3FsCHjD+cBJfWQBjahRFfsU9rjaggpH9iCHvyXA/j6ELRA==
X-Received: by 2002:a05:600c:35ca:b0:459:dc99:51bf with SMTP id 5b1f17b1804b1-45a1b656c57mr26939775e9.25.1755188700538;
        Thu, 14 Aug 2025 09:25:00 -0700 (PDT)
Received: from PC.. ([2407:d000:a:88a6:87bf:5f6f:5688:e40])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45a1c78b33csm28514215e9.25.2025.08.14.09.24.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Aug 2025 09:25:00 -0700 (PDT)
From: Areej Hamid <areejhamid8560@gmail.com>
To: rust-for-linux@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	ojeda@kernel.org,
	alex.gaynor@gmail.com,
	boqun.feng@gmail.com,
	gary@garyguo.net,
	bjorn3_gh@protonmail.com,
	lossin@kernel.org,
	a.hindborg@linaro.org,
	aliceryhl@google.com,
	tmgross@umich.edu,
	dakr@kernel.org,
	viresh.kumar@linaro.org,
	tamird@gmail.com,
	dingxiangfei2009@gmail.com,
	gregkh@linuxfoundation.org,
	thomas.weissschuh@domain.com,
	Areej Hamid <areejhamid8560@gmail.com>
Subject: [PATCH v2] rust: lib: add if_cfg! macro for conditional compilation
Date: Thu, 14 Aug 2025 21:22:11 +0500
Message-ID: <20250814162211.566168-2-areejhamid8560@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <ec0dcd14-e974-43ff-b4f4-3dfe2f31a91c@t-8ch.de>
References: <ec0dcd14-e974-43ff-b4f4-3dfe2f31a91c@t-8ch.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add the `if_cfg!` macro to simplify conditional compilation using `cfg`
attributes. The macro expands to paired `#[cfg(cond)]` and
`#[cfg(not(cond))]` blocks, allowing compile-time selection between
code branches in both expression and statement contexts.

Note: Previous documentation incorrectly stated that both branches
must be valid Rust code. In reality, `if_cfg!()` compiles only the
active branch, allowing the inactive branch to reference items that
may not exist under certain configurations.

Suggested-by: Benno Lossin <lossin@kernel.org>
Link: https://github.com/Rust-for-Linux/linux/issues/1183
Signed-off-by: Areej Hamid <areejhamid8560@gmail.com>
---
 rust/kernel/lib.rs | 51 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 51 insertions(+)

diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
index ed53169e795c..6bcce24600e3 100644
--- a/rust/kernel/lib.rs
+++ b/rust/kernel/lib.rs
@@ -294,6 +294,57 @@ macro_rules! asm {
     };
 }
 
+/// Conditionally compiles and executes code based on a `#[cfg]` condition.
+///
+/// Expands to `#[cfg(cond)] { ... }` and `#[cfg(not(cond))] { ... }`,
+/// allowing conditional compilation in both expression and statement positions.
+///
+/// # Key difference from `cfg!()`
+/// - `cfg!()` evaluates a configuration flag at compile time, but both branches must be valid Rust code
+/// - `if_cfg!()` compiles only the active branch, so the inactive branch can reference
+///   functions, types, or constants that may not exist under certain configurations
+///
+/// # Examples
+///
+/// Demonstrates the difference between `if_cfg!()` and `cfg!()`:
+/// ```ignore
+/// # use kernel::if_cfg;
+/// // FOR CONFIG_64BIT
+/// // Only the active branch is compiled - inactive branch can be invalid
+/// let x = if_cfg!(if CONFIG_64BIT {
+///     42  // valid code
+/// } else {
+///     undefined_function()  // invalid, but completely ignored by compiler
+/// });
+/// assert_eq!(x, 42);
+/// ```
+///
+/// Using `cfg!()` instead would fail compilation:
+/// ```ignore
+/// // This fails because Rust must validate both branches
+/// let x = if cfg!(CONFIG_64BIT) {
+///     42
+/// } else {
+///     undefined_function()  // compilation error - function doesn't exist
+/// };
+/// assert_eq!(x, 42);
+/// ```
+#[macro_export]
+macro_rules! if_cfg {
+    (if $cond:tt { $($then:tt)* } else { $($else:tt)* }) => {{
+        #[cfg($cond)]
+        { $($then)* }
+        #[cfg(not($cond))]
+        { $($else)* }
+    }};
+    (if $cond:tt { $($then:tt)* }) => {{
+        #[cfg($cond)]
+        { $($then)* }
+        #[cfg(not($cond))]
+        { () }
+    }};
+}
+
 /// Gets the C string file name of a [`Location`].
 ///
 /// If `file_with_nul()` is not available, returns a string that warns about it.
-- 
2.43.0


