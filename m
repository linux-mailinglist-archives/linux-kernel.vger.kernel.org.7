Return-Path: <linux-kernel+bounces-742842-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B6F32B0F742
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 17:40:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3E5403B6ADB
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 15:40:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9029C2EE995;
	Wed, 23 Jul 2025 15:39:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jKaiFHC3"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0AD02E8E08;
	Wed, 23 Jul 2025 15:39:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753285189; cv=none; b=MC/elkitybYFSrdTTwYn6FZTfmDioPJBWCFaytlK0p5bn4ST6RT6hSxQeEaXmUyQsn4eAuS5ui2tVopMOAzmsiBQeQ9i6XeDw+P9iKvsCTIWd6BPtx4yoFMa/TTMewEQ5gmWtu/70cChgQbh9+8hdCetLQc+0arVlYXFlX0RE8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753285189; c=relaxed/simple;
	bh=EcuByL0TsK2W2jbELU5/dTciZGgcZ1YeSi0ltT3ts5Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=S5Rdw1dZJ3qM8dJH2UMobK3RVTQvZ3hK45Dhs1vGhZ8ixWuMFZpT3SqVPeWixMebOqxaSo24pFnxVHaiUIbJooSrtIEkE7u2UsLzRhiwLcLQ5OC1i+ic6JUceYo5rKZelEfIbDl9t7WVNPGCp5ZP/vCIiiFX5NB0MbjXNEKRWtU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jKaiFHC3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A264C4CEEF;
	Wed, 23 Jul 2025 15:39:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753285188;
	bh=EcuByL0TsK2W2jbELU5/dTciZGgcZ1YeSi0ltT3ts5Y=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=jKaiFHC323tYWE1cETzOvPcQ0OFUnqMPI5R/HlRyE3uLKqdScIS+lveuWuXAqWM0o
	 I4Q7nlygasUyqOZWox9QmIwwk/MuBShuxUPbhsoX6Q1JZ6J2fYoqxUGHo2HaNm2Yry
	 0dgVVctJ/5Va5bBhteaY7v/lpOv3FNHRI9Hq/UTgWcARemNwPpNuaeuHGqRYS8uLXr
	 sf/Z3Ou95JNAh2imSoSModWgsYV3FYcbgNKI5W0lROAnea/o+Y7yf8YTiwvOjKHDEL
	 HJEtqdZwH4JKtXVu1CPiTXZDL5Kztxt7VfzWZk8p1RYljaBSNA4Fy/tQ/IB0iqRa+9
	 tiu9PtXsnuDPg==
From: Tamir Duberstein <tamird@kernel.org>
Date: Wed, 23 Jul 2025 11:39:42 -0400
Subject: [PATCH 3/3] scripts: generate_rust_analyzer: Add pin_init_internal
 deps
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250723-rust-analyzer-pin-init-v1-3-3c6956173c78@kernel.org>
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
X-Developer-Signature: v=1; a=openssh-sha256; t=1753285182; l=885;
 i=tamird@kernel.org; h=from:subject:message-id;
 bh=EcuByL0TsK2W2jbELU5/dTciZGgcZ1YeSi0ltT3ts5Y=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgtYz36g7iDMSkY5K7Ab51ksGX7hJgs
 MRt+XVZTrIzMVIAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QMMregKraXVmw7B0kKSAw6zEgYfNTQ/SNUNDSA3e8Eykl2C5LLg0zikE6mQ58tOS4Pq97xwH7xN
 6hDZwLG9vnwg=
X-Developer-Key: i=tamird@kernel.org; a=openssh;
 fpr=SHA256:264rPmnnrb+ERkS7DDS3tuwqcJss/zevJRzoylqMsbc

Commit d7659acca7a3 ("rust: add pin-init crate build infrastructure")
did not add dependencies to `pin_init_internal`, resulting in broken
navigation. Thus add them now.

Signed-off-by: Tamir Duberstein <tamird@kernel.org>
---
 scripts/generate_rust_analyzer.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/generate_rust_analyzer.py b/scripts/generate_rust_analyzer.py
index 451d00dfc08d..229acd4cf1fb 100755
--- a/scripts/generate_rust_analyzer.py
+++ b/scripts/generate_rust_analyzer.py
@@ -102,7 +102,7 @@ def generate_crates(srctree, objtree, sysroot_src, external_src, cfgs, core_edit
     append_crate(
         "pin_init_internal",
         srctree / "rust" / "pin-init" / "internal" / "src" / "lib.rs",
-        [],
+        ["std", "proc_macro"],
         cfg=["kernel"],
         is_proc_macro=True,
     )

-- 
2.50.1


