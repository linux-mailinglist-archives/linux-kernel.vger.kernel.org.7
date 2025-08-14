Return-Path: <linux-kernel+bounces-768451-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D43EB26128
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 11:39:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 540AC9E3251
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 09:35:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A54DD301483;
	Thu, 14 Aug 2025 09:31:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a7/KtSvh"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECE202FFDD0;
	Thu, 14 Aug 2025 09:31:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755163893; cv=none; b=aoDQvEULfr6kC+yD+gVlBIa2ne986AuCOXW0OWJg2/uZXei0L544ESA8vGpabBcms1Gr/ZqOCf5677vvtUpyzk14JLNrS6gzY63uIXqOQ2Bsy0KKzuTcmQd0br4/TJYOh2yzLhl/w0DD0v/hvylgiG+yrySoYytknNY6OnNXvmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755163893; c=relaxed/simple;
	bh=rP2tRfc2DpvgO+T9w0iFdJBp9QBo/IiD+hKPLCR4Gt0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=U3z0vw270x1qPzcMMhg2YDoOU7bRE769AJ9ayWuiMY20YivR/fcEZGf9i3qJeMTTlwHmMt/u/AGPOnJhSfMgdqOcrhEplbK4jURqVV9TKAIQVJ6LC3GFZIJJvxXSRyz/fNc4cp43YMU8X1Xs8z/IHbqN5gUY4XWhFooV6+uCTR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a7/KtSvh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85144C4CEEF;
	Thu, 14 Aug 2025 09:31:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755163892;
	bh=rP2tRfc2DpvgO+T9w0iFdJBp9QBo/IiD+hKPLCR4Gt0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=a7/KtSvhfOMh2MdEGQANBjmmDFgAJlEdPU1Ku2QmkJF44D69R6sAa5jHB3ULz0+Bn
	 H9soEzU2eIfqWwkP/17bIngUZZ9HWeTWE5y4/fCMxLqSEIZGnKJQbjv0O25QtLcfwE
	 ZrU3YF+ZAb3qg0ua+inRZLKRyYEXUZPZgM+1kCsPnkGiKyvfZEZ8Vl/4NH82cuZI5F
	 nB+K8Yk5vtSCQ08aX9/Rsg6tRabOmHv4WrnyZwQ/09UoqWtN6oPjWleDQ/BgD4jD5E
	 kHmdLhmdKQ0rLpFXtHbl4JIurU2V6+S+h2zCu1HKnvVOvl+BrZjbGlZGmw9kpYBqpp
	 x2aP5thp/gA3A==
From: Benno Lossin <lossin@kernel.org>
To: Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>,
	Paul Moore <paul@paul-moore.com>,
	Fiona Behrens <me@kloenk.dev>,
	Jocelyn Falempe <jfalempe@redhat.com>
Cc: rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 07/11] rust: security: replace `core::mem::zeroed` with `pin_init::zeroed`
Date: Thu, 14 Aug 2025 11:30:34 +0200
Message-ID: <20250814093046.2071971-8-lossin@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250814093046.2071971-1-lossin@kernel.org>
References: <20250814093046.2071971-1-lossin@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

All types in `bindings` implement `Zeroable` if they can, so use
`pin_init::zeroed` instead of relying on `unsafe` code.

If this ends up not compiling in the future, something in bindgen or on
the C side changed and is most likely incorrect.

Signed-off-by: Benno Lossin <lossin@kernel.org>
---
 rust/kernel/security.rs | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/rust/kernel/security.rs b/rust/kernel/security.rs
index 0c63e9e7e564..11a6493525f3 100644
--- a/rust/kernel/security.rs
+++ b/rust/kernel/security.rs
@@ -25,8 +25,7 @@ impl SecurityCtx {
     /// Get the security context given its id.
     #[inline]
     pub fn from_secid(secid: u32) -> Result<Self> {
-        // SAFETY: `struct lsm_context` can be initialized to all zeros.
-        let mut ctx: bindings::lsm_context = unsafe { core::mem::zeroed() };
+        let mut ctx: bindings::lsm_context = pin_init::zeroed();
 
         // SAFETY: Just a C FFI call. The pointer is valid for writes.
         to_result(unsafe { bindings::security_secid_to_secctx(secid, &mut ctx) })?;
-- 
2.50.1


