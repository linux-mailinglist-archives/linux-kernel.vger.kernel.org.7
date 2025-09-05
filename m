Return-Path: <linux-kernel+bounces-802990-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D3C9B45936
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 15:36:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AE103BA0424
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 13:34:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 896063570AE;
	Fri,  5 Sep 2025 13:34:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fq5eaeLB"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5C5035691E;
	Fri,  5 Sep 2025 13:34:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757079257; cv=none; b=LWZA/zFuSzU4mYSuWgBFc/r10+KPCjewnos4LYNCBqpCANeRB+utgbjkG0vdW3i6RT49GBZG6TKMS6xkuOJtHUjh+SeJ5XqCkhIoRViYXAo3q8U5rB181rAGyXgeWi6sas4kBN5IS9hSyXrl3SaPCIpoURJdqLT/zMmVdIwfLoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757079257; c=relaxed/simple;
	bh=oZw39Vfsy7dAUgkMIcsEniI/PEcMKy6V2bQ25bTHj5g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Z+IdXyK7PsJZkEpJfIlIhO51GCdC6VXm6N6QZsXo8z/xRwKBH74k9iNKofIFEHWu3MnCMacr6Q7tpYVJJT318C8rOHXLkCd6sUy3/j06puDfB26XhiFVuZdzz6IBLAm9EnEGGsMPpV0id8AK2Stxj2kCY7qFFoowOmJQ4AuO70Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Fq5eaeLB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 132DFC4CEF1;
	Fri,  5 Sep 2025 13:34:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757079255;
	bh=oZw39Vfsy7dAUgkMIcsEniI/PEcMKy6V2bQ25bTHj5g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Fq5eaeLB+1NCi7vq8l973HRJTjiPaC68Gwio2TNlx0FYPKD5oFhNlFqoKy4yBCjKi
	 +Y3/11NuN/x/EbXSC2bLggnV3sG/mnkn7xtrboq2aGvYy2L7qhs7rGBGSiTHqvt82S
	 vH0qgMbNRnZX+rwmWYCI0brmttGB2pkcA8F8qCLe+qjdNl5YwwYbz1e7cZ9YuMaynO
	 kTF/ZkDNxuI33NJ7hFWucLPhpW/KK9Y3CirxOHdLT1BeR2qF6+VtB7b/zYw5gxVvDk
	 SEA+0rAEOv0gF2aEXrS/O8uHlPQ7CcYLHbCydhM/D6qpetyaxjQbL/p97pF/hphkYD
	 o4L2hm/gOwFfQ==
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
	Danilo Krummrich <dakr@kernel.org>
Cc: rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] rust: pin-init: README: add information banner on the rename to `pin-init`
Date: Fri,  5 Sep 2025 15:33:59 +0200
Message-ID: <20250905133401.3312707-3-lossin@kernel.org>
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

Link: https://github.com/Rust-for-Linux/pin-init/pull/81/commits/3cf4658e2db96b4a6b26db9478250de2ffcfa1fe
Signed-off-by: Benno Lossin <lossin@kernel.org>
---
 rust/pin-init/README.md | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/rust/pin-init/README.md b/rust/pin-init/README.md
index a4c01a8d78b2..723e275445d4 100644
--- a/rust/pin-init/README.md
+++ b/rust/pin-init/README.md
@@ -6,6 +6,18 @@
 ![GitHub Workflow Status](https://img.shields.io/github/actions/workflow/status/Rust-for-Linux/pin-init/test.yml)
 # `pin-init`
 
+> [!NOTE]
+> 
+> This crate was originally named [`pinned-init`], but the migration to
+> `pin-init` is not yet complete. The `legcay` branch contains the current
+> version of the `pinned-init` crate & the `main` branch already incorporates
+> the rename to `pin-init`.
+>
+> There are still some changes needed on the kernel side before the migration
+> can be completed.
+
+[`pinned-init`]: https://crates.io/crates/pinned-init
+
 <!-- cargo-rdme start -->
 
 Library to safely and fallibly initialize pinned `struct`s using in-place constructors.
-- 
2.50.1


