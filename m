Return-Path: <linux-kernel+bounces-737770-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 76C39B0B059
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Jul 2025 16:08:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CBE3A7AC393
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Jul 2025 14:07:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCA1828751E;
	Sat, 19 Jul 2025 14:08:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uuXE0B+T"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 239EA148838;
	Sat, 19 Jul 2025 14:08:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752934101; cv=none; b=j5zP8BU4u4bQoIrWnFtc326hYrsdy0R8QKq54tvaIjuUB9YFi2aDGvKGkVzYVMryYLNwn60JMeamfHpSo7rBxNJFCeqc2ApfEBSiUl+qDiBWEmcFfrL50HpT7noHPGp95C/PZWaeKQhNZNOjKLovYgzZFXycQa6zV2DupUzrPvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752934101; c=relaxed/simple;
	bh=/ZE6qDBDE0e+mFjpEf4ZBiofYqJr75t+8cSnXB1mzMs=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:Subject:Cc:To:
	 References:In-Reply-To; b=JzBB9oipfQNy58uiH6Xc7vKVJdqKA2fvCPU5rqpNMSMJRUReUzXKs0ihx1Y0+wY5JsgKHZQI8xbLzmzoKrniVK5RspAYCKtLcGNZIZKxzInarJd3YlvEj0eLG7tWGTV5KLFuucNAPH/vA9go8+Olbj4AGxb2od6nSk7U4nVMG4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uuXE0B+T; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0B47C4CEE3;
	Sat, 19 Jul 2025 14:08:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752934100;
	bh=/ZE6qDBDE0e+mFjpEf4ZBiofYqJr75t+8cSnXB1mzMs=;
	h=Date:From:Subject:Cc:To:References:In-Reply-To:From;
	b=uuXE0B+TMEj6SCMhTYLsjH6eDRsbFPmET+81Kb+vX/1auRC8y5cOBTV7k0wmwrXNk
	 BvUOGus5IlzdV71bWQlrtfd20imGEHSvchyxKminV05KQU4gwf0OaOuyVDVIlTE9P1
	 vkBOM7HdlFahXllHshqd7Cgc/ah4V17BCkUGfbpHxiVYcqiZ1kuVgkK6Rf8HlRCXxG
	 Xw9LjortmFH7t1/nRgn5ZAWYmqQB3azz9/2XvKGHJg5NFHNt42wyxWgBORnYhkV+u7
	 AxM/SCibnKdJVtUq20ntXKCq4XOQIMxJypwH7KFE+bBxOPuy3fEK0vSBMPfr2ih8h6
	 I/BTfouQ1nemg==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sat, 19 Jul 2025 16:08:16 +0200
Message-Id: <DBG39YMN2TX6.1VR4PEQSI8PSG@kernel.org>
From: "Danilo Krummrich" <dakr@kernel.org>
Subject: [PATCH] rust: io: mem: enable IoRequest doc-tests
Cc: "Miguel Ojeda" <ojeda@kernel.org>, "Alex Gaynor"
 <alex.gaynor@gmail.com>, "Boqun Feng" <boqun.feng@gmail.com>, "Gary Guo"
 <gary@garyguo.net>, =?utf-8?q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, "Benno Lossin" <lossin@kernel.org>, "Andreas
 Hindborg" <a.hindborg@kernel.org>, "Alice Ryhl" <aliceryhl@google.com>,
 "Trevor Gross" <tmgross@umich.edu>, "Greg Kroah-Hartman"
 <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>,
 <linux-kernel@vger.kernel.org>, <rust-for-linux@vger.kernel.org>
To: "Daniel Almeida" <daniel.almeida@collabora.com>
X-Mailer: aerc 0.20.1
References: <20250717-topics-tyr-platform_iomem-v15-0-beca780b77e3@collabora.com> <20250717-topics-tyr-platform_iomem-v15-2-beca780b77e3@collabora.com> <DBG2XI0UZ3B5.I9KLFJUYQUMC@kernel.org>
In-Reply-To: <DBG2XI0UZ3B5.I9KLFJUYQUMC@kernel.org>

When introduced, the IoRequest doc-tests did depend on infrastructure
added in subsequent patches, hence they temporarily had to be disabled.

Now that we have the corresponding platform device infrastructure,
enable them.

Signed-off-by: Danilo Krummrich <dakr@kernel.org>
---
 rust/kernel/io/mem.rs | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/rust/kernel/io/mem.rs b/rust/kernel/io/mem.rs
index 58c384291f15..ecef19f7d176 100644
--- a/rust/kernel/io/mem.rs
+++ b/rust/kernel/io/mem.rs
@@ -43,7 +43,7 @@ pub unsafe fn new(device: &'a Device<Bound>, resource: &'=
a Resource) -> Self {
     /// The following example uses a [`platform::Device`] for illustration
     /// purposes.
     ///
-    /// ```ignore
+    /// ```no_run
     /// use kernel::{bindings, c_str, platform, of, device::Core};
     /// struct SampleDriver;
     ///
@@ -101,7 +101,7 @@ pub fn iomap_exclusive_sized<const SIZE: usize>(
     /// The following example uses a [`platform::Device`] for illustration
     /// purposes.
     ///
-    /// ```ignore
+    /// ```no_run
     /// use kernel::{bindings, c_str, platform, of, device::Core};
     /// struct SampleDriver;
     ///
--=20
2.50.0


