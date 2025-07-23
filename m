Return-Path: <linux-kernel+bounces-742841-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CDB73B0F741
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 17:40:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 728B9566005
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 15:40:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F5A029117A;
	Wed, 23 Jul 2025 15:39:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EaaQlCse"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78E2420E717;
	Wed, 23 Jul 2025 15:39:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753285187; cv=none; b=mmsA3GGc7k1m+2ygyjAeuFIxV4cZcdEJzrM0NaureOFS9FjqlI0Bse0lGA0UCxRoDaKL0y4f7+TReMET6ME86zB5O/1y/0kr/Yn+zBVfal5a3fojLy0t5inqadC+YrHJt8HXMZH1YAec62Vs5T7c/9ANTbDa6jgNizdc8Y78LLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753285187; c=relaxed/simple;
	bh=Qq+QNHbvlkwmHnd7h5o8fvUAS8OB/iKRqOMZu3LUMe4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=vEn+r3+NcUGpQ4sKKZoC8e4TPU5j/BjrpFZImhG8JnqnvUQIQ9nfWeQ8f4w+BM0Ih4f3kvncwBgWztpoSSbhJEKh03wNDSHfdrkZHhECqpOoILNT6mTl8+7bIfgGT/nTkY0KUWM3rMshGBDUuVh3qxPDvlqTECye6AvZHeVrJ+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EaaQlCse; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22087C4CEF6;
	Wed, 23 Jul 2025 15:39:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753285187;
	bh=Qq+QNHbvlkwmHnd7h5o8fvUAS8OB/iKRqOMZu3LUMe4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=EaaQlCsezXDFSwMlBWPKKz7jupSYU6eHo1QI/fvvfxDcUviW7FEjorhuSD+9hoQwt
	 e9UaPXQ8YJAeBEXrD/nQEmIZ5KJTigWpyyYECeYgauJuQureCi+N7dc9IrMMaq4PtS
	 oTO2Ktpvs8TwpTI4yKaFnxNZhRDJuaTheS9Pdj4AXYXPbgVfnl08gMF3GSV0ZqRYlQ
	 qvJeTpaiDcaWZQbiPWeTLrrKz/tLGdTSCRqjbpClFjumC+fCKJtJQJSqyLqDESO7Eo
	 0rlKT2dA7ZvvZdA+ckFV/nd/3da1Yateau1NkUypmwRJPRXjNzWyIPXC4SmSwx3mYW
	 Zx5f4qerosBZg==
From: Tamir Duberstein <tamird@kernel.org>
Date: Wed, 23 Jul 2025 11:39:41 -0400
Subject: [PATCH 2/3] scripts: generate_rust_analyzer: Add pin_init ->
 compiler_builtins dep
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250723-rust-analyzer-pin-init-v1-2-3c6956173c78@kernel.org>
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
X-Developer-Signature: v=1; a=openssh-sha256; t=1753285182; l=970;
 i=tamird@kernel.org; h=from:subject:message-id;
 bh=Qq+QNHbvlkwmHnd7h5o8fvUAS8OB/iKRqOMZu3LUMe4=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgtYz36g7iDMSkY5K7Ab51ksGX7hJgs
 MRt+XVZTrIzMVIAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QLEaZd+9L/cjr4ciZc/KfOScEuf1SjtVQm1HydRHd/yybSUWuArXg7nLEe8fYhG3FDF9/j3ELkH
 x+4zEMf0DzQY=
X-Developer-Key: i=tamird@kernel.org; a=openssh;
 fpr=SHA256:264rPmnnrb+ERkS7DDS3tuwqcJss/zevJRzoylqMsbc

Add a dependency edge from `pin_init` to `compiler_builtins` to
`scripts/generate_rust_analyzer.py` to match `rust/Makefile`. This has
been incorrect since commit d7659acca7a3 ("rust: add pin-init crate
build infrastructure").

Signed-off-by: Tamir Duberstein <tamird@kernel.org>
---
 scripts/generate_rust_analyzer.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/generate_rust_analyzer.py b/scripts/generate_rust_analyzer.py
index 4639a756a932..451d00dfc08d 100755
--- a/scripts/generate_rust_analyzer.py
+++ b/scripts/generate_rust_analyzer.py
@@ -110,7 +110,7 @@ def generate_crates(srctree, objtree, sysroot_src, external_src, cfgs, core_edit
     append_crate(
         "pin_init",
         srctree / "rust" / "pin-init" / "src" / "lib.rs",
-        ["core", "pin_init_internal", "macros"],
+        ["core", "compiler_builtins", "pin_init_internal", "macros"],
         cfg=["kernel"],
     )
 

-- 
2.50.1


