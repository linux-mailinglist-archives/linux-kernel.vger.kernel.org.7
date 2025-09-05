Return-Path: <linux-kernel+bounces-802989-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C26BB4592D
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 15:35:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 58CE91B24807
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 13:35:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 831913568F5;
	Fri,  5 Sep 2025 13:34:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rSvtGq3x"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAA5F3568ED;
	Fri,  5 Sep 2025 13:34:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757079252; cv=none; b=SCr8Oi9c1OZUp3HrFQpc82LltA4V6571vL+kq4I6ba2Yf8WWbZNldCEZb8aRN3I/f/Upxf65L0v4pzSQZd1F0RaLGW+wV5k1mY5hpWqzuGWqaxXSG4a90uVgST/DATw0gjoMLT1Ve7PikgsQ3JV6GqFJxgBIdn9PiwVnpMW7ezQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757079252; c=relaxed/simple;
	bh=sn6vetOgCrcrDb0Zwhe3R7oKWElKEyh3pKeO1pF+0Kk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DGn/fwzYWcKAynNjlPb6rfkNgmEqm5y/IesvBvXjkquZthCs/pkFvo6oqQAMqCiVS6IzPjC8/GnGYxkPv4SirBiVTj25wQBIYg3qlyQhg5wdKEKAeOZeLleU3Hggd7B0u66/B8yJbSVr5dlCgQMT9Lsemh49LFHdm5odtsYx+os=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rSvtGq3x; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB7FEC4CEF5;
	Fri,  5 Sep 2025 13:34:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757079252;
	bh=sn6vetOgCrcrDb0Zwhe3R7oKWElKEyh3pKeO1pF+0Kk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rSvtGq3xOaOh9G6ySBCfZroTKhIQ/ITdJkRguq2TgqD19ISr6m8g2tdl9ltfZyp++
	 Q0L2x009wZhV1cf1Q5BRGQUdgR/fOSGvk9BmZvw5xlWWpNpl045r/UdW9asii+Yg6Z
	 bKyRUS29BO9W8co17/+PgxZfq+RhnNIj3LOTX134JicTgyfn9YKFg5oOSrvU15mtRe
	 snM8hRm16ocvgZQC2V+FUXPO+UGCrRr7owTUgDS/2dk37JktCw9aM6CFGPOnBEUV3a
	 FzlKpaNRtqgsLciZMsGUgtZybBXoOF89dZAwE8SQeZP43GYvpiQopBnsMsNsVx3uF3
	 dSB9VTjrt3qMg==
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
	Fiona Behrens <me@kloenk.dev>
Cc: rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] rust: pin-init: examples: error: use `Error` in `fn main()`
Date: Fri,  5 Sep 2025 15:33:58 +0200
Message-ID: <20250905133401.3312707-2-lossin@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250905133401.3312707-1-lossin@kernel.org>
References: <20250905133401.3312707-1-lossin@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When running this example with no cargo features enabled, the compiler
warns on 1.89:

  error: struct `Error` is never constructed
    --> examples/error.rs:11:12
     |
  11 | pub struct Error;
     |            ^^^^^
     |
     = note: `-D dead-code` implied by `-D warnings`
     = help: to override `-D warnings` add `#[allow(dead_code)]`

Thus use the error in the main function to avoid this warning.

Link: https://github.com/Rust-for-Linux/pin-init/pull/79/commits/1f4f749b5b151d0dfdf9672af323e39a33e920fd
Signed-off-by: Benno Lossin <lossin@kernel.org>
---
 rust/pin-init/examples/error.rs | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/rust/pin-init/examples/error.rs b/rust/pin-init/examples/error.rs
index e0cc258746ce..8f4e135eb8ba 100644
--- a/rust/pin-init/examples/error.rs
+++ b/rust/pin-init/examples/error.rs
@@ -24,4 +24,6 @@ fn from(_: AllocError) -> Self {
 }
 
 #[allow(dead_code)]
-fn main() {}
+fn main() {
+    let _ = Error;
+}

base-commit: 8f5ae30d69d7543eee0d70083daf4de8fe15d585
-- 
2.50.1


