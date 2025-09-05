Return-Path: <linux-kernel+bounces-803433-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C257B45FC1
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 19:12:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 18700A4483F
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 17:12:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4162C31327F;
	Fri,  5 Sep 2025 17:12:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vIOPt9wW"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8477C2F7ACD;
	Fri,  5 Sep 2025 17:12:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757092336; cv=none; b=JgnIzx/tjORK/8FPrAC2CoeztXVapbK9OA8TDjoBzBfGeac3PF5+ELio3kPPl6ZhoGD0pAMjZHIk6R2omXSND0TUSYo0FM0qvSf5c98VNOBsez+IZxGm+9vWSs51vgRnATmS1jMmIe/PpKCzEdsEI8uQlWwGe6diaoE73zVuwCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757092336; c=relaxed/simple;
	bh=0LIeXiXhq+MVpwMowgaW4t1syNyKCUfe70m6waz5aKc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jMuBY8G5Gv5WUvxezP8U5dy7IOqgAuc/lEUbAwRIQJHRtlLM+/B1NCay3IiPZ7M6e6XbCCGtcjeY6i2qUu31iuMh/YYoLoYUmVN1fh+upDkO0awV3CCryf7shFb1JPCermuXWnN+ayydaCChaQfJj5ZkOHjKSoJDenAbPxQJHTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vIOPt9wW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28ED9C4CEF7;
	Fri,  5 Sep 2025 17:12:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757092336;
	bh=0LIeXiXhq+MVpwMowgaW4t1syNyKCUfe70m6waz5aKc=;
	h=From:To:Cc:Subject:Date:From;
	b=vIOPt9wWs40lSc1J2nOm6tx6/Nz1M4vI/Dih5fo5IA0m4jlC4opIxotg8EQM/ZbYs
	 F9eBelDMEegw9jWTUN9XVeDoCrxzMtm+BoLMg48TquZXtujKOHfftkFvg6Sj7e5EJL
	 obi/1MvFZLjCRqSKr02Q4bY2kV5uCtcjYHfzgcvNiAs8SdX7sKVmt+F4IoJNouHkeb
	 Go4RyOODDIfiaq7zs6YwH2CMsptkcU/r1EJ5p5oW/5ZIM3v0trTFEqcWrpcAj34RKZ
	 bOoRm11lfqojoRCGCBiG+OrtpvnX3y5b3+NThGNaTnaa2TOzQ2MkeKKW2MYlv9bhyC
	 4kfuhlbLGLcMA==
From: Benno Lossin <lossin@kernel.org>
To: Benno Lossin <lossin@kernel.org>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>,
	Fiona Behrens <me@kloenk.dev>,
	Christian Schrefl <chrisi.schrefl@gmail.com>
Cc: rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] rust: pin-init: rename `project` -> `project_this` in doctest
Date: Fri,  5 Sep 2025 19:12:06 +0200
Message-ID: <20250905171209.944599-1-lossin@kernel.org>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The next commit makes the `#[pin_data]` attribute generate a `project`
function that would collide with any existing ones.

Link: https://github.com/Rust-for-Linux/pin-init/pull/75/commits/67fc90312149fd797078578612aac83b459a6ca4
Signed-off-by: Benno Lossin <lossin@kernel.org>
---
 rust/pin-init/src/lib.rs | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/rust/pin-init/src/lib.rs b/rust/pin-init/src/lib.rs
index 62e013a5cc20..2d0d9fd12524 100644
--- a/rust/pin-init/src/lib.rs
+++ b/rust/pin-init/src/lib.rs
@@ -994,7 +994,7 @@ macro_rules! try_init {
 /// }
 ///
 /// impl<T> Foo<T> {
-///     fn project(self: Pin<&mut Self>) -> Pin<&mut T> {
+///     fn project_this(self: Pin<&mut Self>) -> Pin<&mut T> {
 ///         assert_pinned!(Foo<T>, elem, T, inline);
 ///
 ///         // SAFETY: The field is structurally pinned.

base-commit: 8f5ae30d69d7543eee0d70083daf4de8fe15d585
-- 
2.50.1


