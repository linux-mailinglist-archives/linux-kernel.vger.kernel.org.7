Return-Path: <linux-kernel+bounces-856965-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 64070BE58DA
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 23:17:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EF07654505C
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 21:17:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1834F2DA742;
	Thu, 16 Oct 2025 21:17:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SBtIRFEO"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CC6419067C;
	Thu, 16 Oct 2025 21:17:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760649468; cv=none; b=KeAnEljrFrv78dKFurZo2NdEhaV9H/0d1xHkDG3+alcJvQTXzicKv7KahZT0dQcguu3w3Sk9IQUVrO0u6wwoLX8Sbam4ZUh5BNHWrBCI4+wPlq1WMDXywU6MsinZM7ovxdybWzqGZVlOVwAPwj2oVpWqdKB9EmfoZ/bXTyHFjbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760649468; c=relaxed/simple;
	bh=9sb2klG7sKm8UU0jqADornOndrsInzButfgYDF73plw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AiO/akVx0WQh1aH8ShSKw7BODTLLm7MBg8ERYMNZzDzGVPLonTgzPD0adzPdSo3Fy7QLG0MHz5nnUywl88/dbpnILoZph8VpQZMXMYBH00HJdgvRmG06J2+/CyZ0LVldmVGFmdQIANLSCYe43YEhxit24cihSHAj23uIV7VdKDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SBtIRFEO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08F37C113D0;
	Thu, 16 Oct 2025 21:17:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760649466;
	bh=9sb2klG7sKm8UU0jqADornOndrsInzButfgYDF73plw=;
	h=From:To:Cc:Subject:Date:From;
	b=SBtIRFEOk60daxaS9JxJDiwh3a5JyqhXFsJgSnxMJGjLUrmkvbhMTZE1ZecFRj8k8
	 Frj9hAhg5+fDJaXlgbcpnqXdnAFuRuwJinc80cd8x2cN6kAEVk59wKpbYnj6UELQUI
	 qG8Y/NSFAmToR8FmKVfSnXMGOfX1Lhtvpke2Iiy8LBvGy80umubncleKfty4IaC6jD
	 FVYVcfAueL+a266kwqpFZkgFVL4qcPhqNMUSyKlQ0rqNBOwu18vf4O0DWTZBU5sSdt
	 CSzuNk4BqxVDWmWu0JNfY85WJjeDV5Mu5XmixeLIo51Ybd2xo5ZNdOYwtk+Qu2o0Qb
	 axo4/RhjWZHhQ==
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
	Alban Kurti <kurti@invicto.ai>
Cc: rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] rust: pin-init: fix broken rust doc link
Date: Thu, 16 Oct 2025 23:17:38 +0200
Message-ID: <20251016211740.653599-1-lossin@kernel.org>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Rust 1.92.0 warns when building the documentation that [`PinnedDrop`] is
an invalid reference. This is correct and it's weird that it didn't warn
before, so fix the link.

Signed-off-by: Benno Lossin <lossin@kernel.org>
---
 rust/pin-init/src/macros.rs | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/rust/pin-init/src/macros.rs b/rust/pin-init/src/macros.rs
index d6acf2cd291e..682c61a587a0 100644
--- a/rust/pin-init/src/macros.rs
+++ b/rust/pin-init/src/macros.rs
@@ -506,6 +506,8 @@
 /// Creates a `unsafe impl<...> PinnedDrop for $type` block.
 ///
 /// See [`PinnedDrop`] for more information.
+///
+/// [`PinnedDrop`]: crate::PinnedDrop
 #[doc(hidden)]
 #[macro_export]
 macro_rules! __pinned_drop {

base-commit: 3a8660878839faadb4f1a6dd72c3179c1df56787
-- 
2.51.0


