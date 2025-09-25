Return-Path: <linux-kernel+bounces-833063-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EA533BA11E0
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 21:04:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A54C117431A
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 19:04:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08F4031B804;
	Thu, 25 Sep 2025 19:04:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y7y1HB/1"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59B56315D3F;
	Thu, 25 Sep 2025 19:04:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758827080; cv=none; b=RQ2BRdKaCHGjOPTaJFKk7XIT4i0mWnbPftYUBEZxb1p1i7wyn99XkkpWuyYW/pNZ+eNKYozSZJ6KvFi6kuJCe/fnd6sdWwRhimD46Ye6pttC4YHAkxz+aranWr2V9yjdV6TYdjpxW56XM/FNlC1j5AzPtg9p523vCtj9nMW4CeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758827080; c=relaxed/simple;
	bh=zFXFUcJmngO1/FA8jEXMP3GTYy3YhFwybmtErYXXRvg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PCLJFog0dhgBb0Ox3lZ0rLULRJreg9VwQYi27bSuq5sS/9ElvJ02VRE6ybrbpqXtEOjrPG9Oa+QrclPq84CKOiOdg3qAzjWZA6UU7v/FZxmI0JbHODxPOC98d9s3Bm3z6ZthU/NznICrjXRhDYj7eEwkQ0mUejNduhKce9TuXns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y7y1HB/1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F710C4CEF0;
	Thu, 25 Sep 2025 19:04:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758827079;
	bh=zFXFUcJmngO1/FA8jEXMP3GTYy3YhFwybmtErYXXRvg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Y7y1HB/1L/LBI34o3GnLTzKDuD5uzuYVahx1jelqh84wlETcRdUMqW2tQJcAaHMnP
	 26tNUpx6kFyZnMasgpzFPMQkZmCmQBAPtGkJMdwSemhuGazNLFniyvG3AwZGVJ+hVF
	 0CduWg8JUUaeMJMAawe7GSFfk6PvT8hdSuxeVa0/RI46TR0EPk63qK+OybS3j0hYyr
	 zDbkZ9SzwDmvL3SGMhl3C1TT2llQYAuLt/SAczEnjAXDKS1BsdbdZDbEKuFU+aFakJ
	 hb9lrGS8CR2GyH8VWxDlpq8TRU7AnITxmNlxMuh9sz0D40oT17eVOnHKDeDUZ5n9XB
	 IDLk/VglixPVQ==
From: Danilo Krummrich <dakr@kernel.org>
To: gregkh@linuxfoundation.org,
	stern@rowland.harvard.edu,
	ojeda@kernel.org,
	alex.gaynor@gmail.com,
	boqun.feng@gmail.com,
	gary@garyguo.net,
	bjorn3_gh@protonmail.com,
	lossin@kernel.org,
	a.hindborg@kernel.org,
	aliceryhl@google.com,
	tmgross@umich.edu,
	daniel.almeida@collabora.com
Cc: rust-for-linux@vger.kernel.org,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Danilo Krummrich <dakr@kernel.org>
Subject: [PATCH 2/2] rust: usb: keep usb::Device private for now
Date: Thu, 25 Sep 2025 20:59:27 +0200
Message-ID: <20250925190400.144699-2-dakr@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250925190400.144699-1-dakr@kernel.org>
References: <20250925190400.144699-1-dakr@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The USB abstractions target to support USB interface drivers.

While internally the abstraction has to deal with the interface's parent
USB device, there shouldn't be a need for users to deal with the parent
USB device directly.

Functions, such as for preparing and sending USB URBs, can be
implemented for the usb::Interface structure directly. Whether this
internal implementation has to deal with the parent USB device can
remain transparent to USB interface drivers.

Hence, keep the usb::Device structure private for now, in order to avoid
confusion for users and to make it less likely to accidentally expose
APIs with unnecessary indirections.

Should we start supporting USB device drivers, or need it for any other
reason we do not foresee yet, it should be trivial to make it public
again.

Signed-off-by: Danilo Krummrich <dakr@kernel.org>
---
 rust/kernel/usb.rs | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/rust/kernel/usb.rs b/rust/kernel/usb.rs
index 955fd93b6f52..14ddb711bab3 100644
--- a/rust/kernel/usb.rs
+++ b/rust/kernel/usb.rs
@@ -386,7 +386,7 @@ unsafe impl Sync for Interface {}
 ///
 /// [`struct usb_device`]: https://www.kernel.org/doc/html/latest/driver-api/usb/usb.html#c.usb_device
 #[repr(transparent)]
-pub struct Device<Ctx: device::DeviceContext = device::Normal>(
+struct Device<Ctx: device::DeviceContext = device::Normal>(
     Opaque<bindings::usb_device>,
     PhantomData<Ctx>,
 );
-- 
2.51.0


