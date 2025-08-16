Return-Path: <linux-kernel+bounces-771982-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 31611B28D79
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Aug 2025 13:44:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 10DA34E04CE
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Aug 2025 11:44:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D7402D0619;
	Sat, 16 Aug 2025 11:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QazUCY8n"
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 481DC2E11BC;
	Sat, 16 Aug 2025 11:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755344668; cv=none; b=FSpVAL9j13FIs3TDSG2Sn/P3MOA+K0uzBm6QiYXnAVmgq2KJNNt4NpTZ1i8U/oAPqRc8NaBT6FNiuVz60k5sYKo8PuUZ1b8ycPsEjAKJyv2ysbdqv9DEgfWQhSa8MsBdmlVlrVN01R6GslF+QXR+jRwu4EdCMZjob9ugZ9toKyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755344668; c=relaxed/simple;
	bh=sadl+94nfOOO+PFAVTq5awVo/e+yg+dtDdZJ+TmTfNU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=AQZAWIjCYg9K7XB4Gilp659sTqI3ePsxk8Ii4sy48Ep0UypOkqmhCjCbb8VONFgUo4axEFSfg1GfPRfIRO0S1t0e/mxqYMFe89kbIKXM7MrE/zPSp31Uqbb1Uqw9n40uaGLYxolU5robMXhVPhnR4Vh2RMaDahHtQxiNG+DMaWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QazUCY8n; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-b4716fb8e74so2491395a12.0;
        Sat, 16 Aug 2025 04:44:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755344666; x=1755949466; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8Fe47Jpwa/1lJM+lMXCCDio5n2It2kWlFgs8x2tPHgA=;
        b=QazUCY8nNEH2L6eHe/PcearZs6d/axVWew8wx5BYUt6GC5xpW5L3Bvv0ogHGMbpCmF
         inNFybPATv7iBd+3m+hinxI63+2LZMKWRVmE1JsiLnqFYO5BIGfMPTQtuJ9LtoL5EmWp
         2VUI4/t88MCRjyDYtXrq5mFuh+5WnX2SxaRnpJ38AHC7390hYh7ePG1fBt8uVcoHUorm
         wl6ocJ3eJ5312v5DbxMiykkWCnQ2n1/IyoyVidQC7pJ1paCE8A4WB8a+2mZ5i6yXc8Va
         XBkAvyMbWFoFfV5/zMxnclUVssSoFokt2mz0fT8LvTVmZnO/AP4t8NQaVdS21jDpJQfH
         nc/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755344666; x=1755949466;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8Fe47Jpwa/1lJM+lMXCCDio5n2It2kWlFgs8x2tPHgA=;
        b=DQdPO+E/dd9Wizegv9FLVTj1NzdOA6iTqgiRnYnY2buo7OjrAWYhSRTKWmYuXANM4d
         X+okHZZmrgjLalz1izIVqavWMPZCskASn2FlBM67lVJR4P8qFjmgmMCnNSVuhpeDWIry
         2Bx1Omv79SIYJ7jwEkwIP0+X3K4mMIkzpUKU7/R5SWU9dP3AmVAWWGf4XnDDI5eVvDjd
         JX6VoPEHEF4APWv9CtWcTvLdi89K3DsjPahlgZAf+q+fbKWtUZ1QEyHw4eiHAas/9cc/
         x0kk4mP+JmmNiRsLopH6z5niO/a6S2AVEFcL9w+T3a4QsNBoOEuBgxjiCw05zze5TvCT
         Bm1g==
X-Forwarded-Encrypted: i=1; AJvYcCX+Ph5rq5Cj5gKQF5W3j66Cd6PBNykD9gdty1wB98j8xnYs+F5TxW/gr2bBQdiRw91uGid281npQbSpl1jbAQg=@vger.kernel.org, AJvYcCXS9CyPqUCyX4mZQfx9n8z8R00vfIFlcjbU6JplsC0G3gbLhYkjXeCDWKkioqERQQzYbeoo8tbVknWmbjM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzvWvfeZyjEkAaeIKbikdBEJX5NFE8wj5/FN7t6ehLW7fJBW/Tw
	067hwgFigkXnh+IMqYxfhwfNiavFX+6CtUWfG9rChtJRx/KkKjOiKUAl
X-Gm-Gg: ASbGncuOZxFCeoh/hqLWhu+CWzwh8gvqKCZPEg/FMgPLTpkwL8eUI9f3yKH3gqkmcks
	5hMAHgyzhoPrcHLVaKxlZJX5rtONiaxWH428ZRISo4Aw89gPrcDxEhTU7Sfo7uF+5KApmgHfpRZ
	mWHiizAlQ58Mr3TBLUFiCatA0p7xLw1XVqp89udw1mdzBz06UFx7Vzwrt0NHeKzzp1iGZNHY2Y6
	dgaG7TVcpY/zhJYkty4X4Je4OqOjYAgzO8zc3AdSJWvuhUp+R2nN4p1JPp9UuolG2T/8atOWWh7
	Ll+K8xvnbH5ZD+D0bzeqqtqMKeJchN3H2CwjJ4B733FpGFUqddijA9OdVB+WXgn5D0D0ZbxE4qH
	xi2wqUsn7GBsXNS7xECfdOX2Y6BboG8kaZl9q
X-Google-Smtp-Source: AGHT+IF/UJIWVXa9nNhvGyN80X24vI3JbpvvYOS/CJUaQpPwgL1aSMZ5otCohS5FAAXW7z4ww0yE3A==
X-Received: by 2002:a17:903:1b04:b0:240:150e:57ba with SMTP id d9443c01a7336-2446d6d33d2mr81048185ad.3.1755344666323;
        Sat, 16 Aug 2025 04:44:26 -0700 (PDT)
Received: from shankari-IdeaPad.. ([103.24.60.31])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2446cadff5asm34551165ad.42.2025.08.16.04.44.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Aug 2025 04:44:25 -0700 (PDT)
From: Shankari Anand <shankari.ak0208@gmail.com>
To: Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>
Cc: Boqun Feng <boqun.feng@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>,
	rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Shankari Anand <shankari.ak0208@gmail.com>
Subject: [PATCH] rust: cred: update AlwaysRefCounted import to sync::aref
Date: Sat, 16 Aug 2025 17:14:09 +0530
Message-Id: <20250816114409.10107-1-shankari.ak0208@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Update the import of `AlwaysRefCounted` in `cred.rs` to use `sync::aref`
instead of `types`.

This is part of the ongoing effort to move `ARef` and
`AlwaysRefCounted` to the `sync` module for better modularity.

Suggested-by: Benno Lossin <lossin@kernel.org>
Link: https://github.com/Rust-for-Linux/linux/issues/1173
Signed-off-by: Shankari Anand <shankari.ak0208@gmail.com>
---
It part of a subsystem-wise split series, as suggested in:
https://lore.kernel.org/rust-for-linux/CANiq72=NSRMV_6UxXVgkebmWmbgN4i=sfRszr-G+x3W5A4DYOg@mail.gmail.com/T/#u
This split series is intended to ease review and subsystem-level maintenance.

The original moving patch is here: (commit 07dad44aa9a93)
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=07dad44aa9a93b16af19e8609a10b241c352b440

Gradually the re-export from types.rs will be eliminated in the
future cycle.
---
 rust/kernel/cred.rs | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/rust/kernel/cred.rs b/rust/kernel/cred.rs
index 2599f01e8b28..4a2229542fb7 100644
--- a/rust/kernel/cred.rs
+++ b/rust/kernel/cred.rs
@@ -8,11 +8,7 @@
 //!
 //! Reference: <https://www.kernel.org/doc/html/latest/security/credentials.html>
 
-use crate::{
-    bindings,
-    task::Kuid,
-    types::{AlwaysRefCounted, Opaque},
-};
+use crate::{bindings, sync::aref::AlwaysRefCounted, task::Kuid, types::Opaque};
 
 /// Wraps the kernel's `struct cred`.
 ///

base-commit: 8f5ae30d69d7543eee0d70083daf4de8fe15d585
-- 
2.34.1


