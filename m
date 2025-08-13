Return-Path: <linux-kernel+bounces-767459-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 279F9B25494
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 22:39:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7D4EA1C22D15
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 20:39:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45A202D0C62;
	Wed, 13 Aug 2025 20:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dk7QgSt+"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05D0827EFE1;
	Wed, 13 Aug 2025 20:39:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755117548; cv=none; b=At+7+mMbysf0kjvBiXaqODBgMt2mroyB/rcJ94L0S4kbNqtCRiv3BZN87k8nueUFdm0G+a72bE9klWl0sNlHRXDMITSH4iXHpDd4cqi2pcbuhPGQpEWCeFxYBK4B1kAglOcJsx4LKMYWY5cf2bpP9zWrfBRv36GibtBP+tGQbXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755117548; c=relaxed/simple;
	bh=CjCb5b3c3XVR0SKfAN3cTznTc5gFjabIUuOSBKsePX4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nvuMcIZh84dHG91NLa4TTUFWyc8KGyUi9F2G/sQWDf1y6R0ZztrQxpJwRAY/dTyYsroybDXYardxt82ULfJ3n7R66aaUoXASrj2s5xzJwKL0cMqJBRG/fFcX6my/vnKpgScjB/SU1QWbjjzWN8OqwnK7rAuov2Gy3E8+Ep1MerI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dk7QgSt+; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-45a1b0bd237so1481855e9.2;
        Wed, 13 Aug 2025 13:39:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755117544; x=1755722344; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=PBx+aI2GZUNjzRZKCiUKPus1NJlwpPhIvyJpPhFBon8=;
        b=dk7QgSt+6tJnQ5SN4nC+qNzQKjqyJEW/NqhvB1JebGNnAfG7FQ3sP4NPH6PYOW0pHg
         66sQcUyGWTGQjFJuY07zP4A5t0kn8x+K5qI9y7CrGRupTYngGYla/oG9Wmd2Y08mSGkJ
         fdkeoqTgS7c2n+PL8R0y98SSihRy7NP9yBhvuATcm07HrlE/cvarsf03GPdcfbQn0Pjw
         +zuJ4Vuy8vGM8Ub6COEoCtA922nTBB739zxI47KPulOvHftkYQKBLR2jNyemI7A2GrRS
         0Wd0RZPtcMMOim4rKhQybMHECa/IwwHFheRAlmguuPYeHl3QlTgq2/KE2f4/R/zimajv
         Rr8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755117544; x=1755722344;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PBx+aI2GZUNjzRZKCiUKPus1NJlwpPhIvyJpPhFBon8=;
        b=lx4rnJw1+HAEjDddMgvu5HsvNjfrM7MZbpTsLK4yyJe0ZgyGAMQF6F+kQX/Ec5gRuC
         Ftq4tbkQL7lFmyyxjHP9ux/liRj55Km5lKerIHMzLQAHvtY5vWdb7SdvBapFveIH80vO
         iSysMkoNeErRquySWqb005m7fsCbJcna4SorkHfNUgAlGNimutNBCjcmhMIDhDcEoSUx
         KgxeofAX2TOQ2rhsLitRIzMWT+06oyDJch+6rIyMEG50bLRrYwFoKhyp5DKpJN6u2sTe
         5JETSUVs2+T9FrUkN0RdeQLhEAMLS66778KAwrHw6gbLJr0MOrSnwVMr28C/49WqyQiO
         ZxTQ==
X-Forwarded-Encrypted: i=1; AJvYcCVjbSQ/ZCtPiPaFrBXc6S7X4qurCxTVJ+tEKtqaP6WK/YsI1PsAYYSWJUIYo+8rBLBTxxUx+I9W0dgBSQE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyz1nnaqd4uxbzKfQHRI+O3qhGBnwsMiHUN266FKcKcu5V//Gfx
	a4KVJ9Eylmbi9g4rxW1qAPe5x7JrcMZiCcF8Tk3t/7WBVbZg131z5ZdZsRmZo52XIJtUig==
X-Gm-Gg: ASbGncuIGLzdbk+3+YSjlwQfjT7e2+Y7HQhPKFLPySGNpermwQfp8+LEv6OmEE2yI7x
	/iOn9s5mj2EoAkQ8KlHbrNrgssicNxtjlBpbcCwVB146oBDmxCTJjvdHkW0pNS/9V4s29zgikvU
	41QMw+2IQvBPJW6cH7Qo2+9GAN+1JneDAFRxpe9Wr2iBa8gjCObQt3YMbgVj290JrBVkDipNJCA
	YbV6GTdA2fPHlih3E8xBJDmqx2Z+0tbIFrZlwoAbj5PWprZKsMRVvtCuYdI4la/+4zWQPuwf4Ay
	e8Z8Hvw4fWw9/DiDHfcpb7X+BNlJLOL/VO4fXy58VKdmUInOX1qDOxxqrdk2lRIyDdBI8e3jkLs
	rezB868q6juBE5AbTSsHJc7hPe30j0lGwGNn+VsY=
X-Google-Smtp-Source: AGHT+IESLZ8kjjL1lvI2Mv+vn42VzZmwiuHVYUI0mGlwY35FF32aMQH+TZzu0vD93GA8PseijNSLCg==
X-Received: by 2002:a05:6000:26c9:b0:3b7:9589:1fd1 with SMTP id ffacd0b85a97d-3b9fc36b38emr490839f8f.44.1755117543720;
        Wed, 13 Aug 2025 13:39:03 -0700 (PDT)
Received: from PC.. ([2407:d000:a:88a6:5d81:9c3b:954d:498b])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b79c3bf93dsm48867283f8f.27.2025.08.13.13.38.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Aug 2025 13:39:03 -0700 (PDT)
From: Areej <areejhamid8560@gmail.com>
To: rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Tamir Duberstein <tamird@gmail.com>,
	Xiangfei Ding <dingxiangfei2009@gmail.com>,
	Areej <areejhamid8560@gmail.com>
Subject: [PATCH] rust: lib: add if_cfg! macro for conditional compilation
Date: Thu, 14 Aug 2025 01:38:26 +0500
Message-ID: <20250813203826.3145553-1-areejhamid8560@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a new if_cfg! macro to simplify conditional compilation using
cfg attributes. This macro expands to paired #[cfg(cond)] and 
#[cfg(not(cond))] blocks, allowing compile-time selection between 
code branches in both expression and statement contexts.

Suggested-by: Benno Lossin <lossin@kernel.org>
Link: https://github.com/Rust-for-Linux/linux/issues/1183
Signed-off-by: Areej Hamid <areejhamid8560@gmail.com>
---
 rust/kernel/lib.rs | 37 +++++++++++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
index ed53169e795c..47e73949392d 100644
--- a/rust/kernel/lib.rs
+++ b/rust/kernel/lib.rs
@@ -294,6 +294,42 @@ macro_rules! asm {
     };
 }
 
+/// Conditionally compiles and executes code based on a `#[cfg]` condition.
+///
+/// Expands to `#[cfg(cond)] { ... }` and `#[cfg(not(cond))] { ... }`,
+/// allowing conditional compilation in both expression and statement positions.
+///
+/// This macro is useful when both branches must be valid Rust code and the
+/// selection between them is done at compile time via a config option.
+/// # Examples
+/// ```
+/// # use kernel::if_cfg;
+/// // Select a value depending on CONFIG_64BIT.
+/// let x = if_cfg!(if CONFIG_64BIT {
+///     64
+/// } else {
+///     32
+/// });
+///
+/// // `x` will be 64 if CONFIG_64BIT is enabled, otherwise 32.
+/// assert!(x == 64 || x == 32);
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
@@ -337,3 +373,4 @@ pub fn file_from_location<'a>(loc: &'a core::panic::Location<'a>) -> &'a core::f
         c"<Location::file_with_nul() not supported>"
     }
 }
+
-- 
2.43.0


