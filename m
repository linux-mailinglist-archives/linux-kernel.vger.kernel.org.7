Return-Path: <linux-kernel+bounces-742840-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DF4BDB0F740
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 17:40:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E55EF3B11BE
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 15:39:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB8CB20297B;
	Wed, 23 Jul 2025 15:39:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LIFFLFiK"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51B501F91C5;
	Wed, 23 Jul 2025 15:39:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753285186; cv=none; b=jKjYFUha1Niph6rxfKa7lhBo743xHKp3iwqDvCNkdJfG2sKYDnyfnK9m3T2It0enxJZKWqjRfp9C9FILSIllBCzUoFclpuvcZUl1GtEcXzgDqoSm/KzusiDqCVma/SqwHrOBMRA/yHr57Zr6F7kL02ej0fE8JQDQUHcA2SUSnac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753285186; c=relaxed/simple;
	bh=EN3fEWrIqTQmRtxNc+NrLRwSUuvS2xfQhnpKvMdE6hQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DeiPvkVct2SxZoAH+j69LwfkR3/GcuR5x6s1cqv5qppGzvX4QF5sxFtmk0UXfFS4uQDAk26+mpgiUUl676q6pfaA0XdRWD8uyEzKGgOrZvQEWiWTFjyDJDxOOl+qWk5rTRyQwM2ybTSUUUWsglaeIWFQWsN1DYYQ/Ub+oL8k998=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LIFFLFiK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96E63C4CEF8;
	Wed, 23 Jul 2025 15:39:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753285185;
	bh=EN3fEWrIqTQmRtxNc+NrLRwSUuvS2xfQhnpKvMdE6hQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=LIFFLFiKFOXj/WDVZVTFvFvJ6ObMYU+jLTTrNH5yp6boT6J4ecKORk8oyPRbVaaOv
	 ofDHFU1kmpR6oJydwVjhKxcrJEIJRLPtbzOowqFln4W/8ql/JX1EtHoBKReyJndH6B
	 sMUg7xbtBVHdhWbKGwvXhRylL0ARMmMvB2uLhsX7nPJO23aAIdxBEVyQPlpi9w84ks
	 2NPUzN9KXQpr7RCW/bp6EP9jc6/yzDIT3ic/M65exuG1F/yxnagWf2s1Uj1IzLlXzR
	 +UuaD+KsExLOrezpAHq5unIptqWzpedIX5G8fm/Za11B2I/gfjEbgnOk6p2Zldm6E8
	 DTj6mGOOtPJ6g==
From: Tamir Duberstein <tamird@kernel.org>
Date: Wed, 23 Jul 2025 11:39:40 -0400
Subject: [PATCH 1/3] scripts: generate_rust_analyzer: Add compiler_builtins
 -> core dep
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250723-rust-analyzer-pin-init-v1-1-3c6956173c78@kernel.org>
References: <20250723-rust-analyzer-pin-init-v1-0-3c6956173c78@kernel.org>
In-Reply-To: <20250723-rust-analyzer-pin-init-v1-0-3c6956173c78@kernel.org>
To: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
 Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
 Danilo Krummrich <dakr@kernel.org>
Cc: rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Tamir Duberstein <tamird@kernel.org>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openssh-sha256; t=1753285182; l=865;
 i=tamird@kernel.org; h=from:subject:message-id;
 bh=EN3fEWrIqTQmRtxNc+NrLRwSUuvS2xfQhnpKvMdE6hQ=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgtYz36g7iDMSkY5K7Ab51ksGX7hJgs
 MRt+XVZTrIzMVIAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QKifUuA0ugvc3R2z2Fq0NTvUAoBDFG0aT4tLsOdA03XWzBPl/ikk1T2KqieWUWjFDsTy/uiWyXD
 M5VupC5BGxQ8=
X-Developer-Key: i=tamird@kernel.org; a=openssh;
 fpr=SHA256:264rPmnnrb+ERkS7DDS3tuwqcJss/zevJRzoylqMsbc

Add a dependency edge from `compiler_builtins` to `core` to
`scripts/generate_rust_analyzer.py` to match `rust/Makefile`. This has
been incorrect since commit 8c4555ccc55c ("scripts: add
`generate_rust_analyzer.py`")

Signed-off-by: Tamir Duberstein <tamird@kernel.org>
---
 scripts/generate_rust_analyzer.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/generate_rust_analyzer.py b/scripts/generate_rust_analyzer.py
index 7c3ea2b55041..4639a756a932 100755
--- a/scripts/generate_rust_analyzer.py
+++ b/scripts/generate_rust_analyzer.py
@@ -83,7 +83,7 @@ def generate_crates(srctree, objtree, sysroot_src, external_src, cfgs, core_edit
     append_crate(
         "compiler_builtins",
         srctree / "rust" / "compiler_builtins.rs",
-        [],
+        ["core"],
     )
 
     append_crate(

-- 
2.50.1


