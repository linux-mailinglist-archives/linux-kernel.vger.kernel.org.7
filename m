Return-Path: <linux-kernel+bounces-779418-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DF448B2F3D3
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 11:27:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7BA1B1CE025A
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 09:26:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD8792EFD90;
	Thu, 21 Aug 2025 09:26:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=onurozkan.dev header.i=@onurozkan.dev header.b="M6KDZyOs"
Received: from forward201a.mail.yandex.net (forward201a.mail.yandex.net [178.154.239.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FB602D3A9E;
	Thu, 21 Aug 2025 09:26:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755768376; cv=none; b=kfb9sp/bpCSRAAD7Dfk2L7zkG8dMLOeeAaxMS+lK2he4l3l31TN3iJwS55QNTJERJpzi9uFat/J/fsJXLO0lmjoG4bwKDIsONYlXtV45SO4spInWkGjCvwwcarvvGm+C89BukxCMlEf5s410MbD76iVTDTlwdDA5lCSPYUyi6mM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755768376; c=relaxed/simple;
	bh=xiJVt3b12bT+770SFlGTWOwSte6zn4uAo5bc51xuing=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=HGvf/WvyzTyiRslA6ZLE28KgqRqHAgUTjG4tD+Dit2MToJ4TLvBiohs9cz0EOGl29KPGRK7WVWGJOE9/cUimsduqK0IXsSf42r2L0fvdYWOjGIBS3JPsqtv/wecYNOqzDCiHYtyfsyJWOocqpVJy6PrTHJyoozdtenvmJwzromI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=onurozkan.dev; spf=pass smtp.mailfrom=onurozkan.dev; dkim=pass (1024-bit key) header.d=onurozkan.dev header.i=@onurozkan.dev header.b=M6KDZyOs; arc=none smtp.client-ip=178.154.239.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=onurozkan.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=onurozkan.dev
Received: from forward101a.mail.yandex.net (forward101a.mail.yandex.net [IPv6:2a02:6b8:c0e:500:1:45:d181:d101])
	by forward201a.mail.yandex.net (Yandex) with ESMTPS id 0970085534;
	Thu, 21 Aug 2025 12:19:56 +0300 (MSK)
Received: from mail-nwsmtp-smtp-production-main-84.iva.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-84.iva.yp-c.yandex.net [IPv6:2a02:6b8:c0c:b18d:0:640:3620:0])
	by forward101a.mail.yandex.net (Yandex) with ESMTPS id 7B4088043E;
	Thu, 21 Aug 2025 12:19:48 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-84.iva.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id eJP0bXHMY8c0-3urUempZ;
	Thu, 21 Aug 2025 12:19:47 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=onurozkan.dev;
	s=mail; t=1755767987;
	bh=Ikr3sVoeYdCUnHYmqqED/eeVXLZZxsJi2mOKPrxTZwo=;
	h=Message-ID:Date:Cc:Subject:To:From;
	b=M6KDZyOsFs/LgHt4k3ZPsXIEP2c3Quo/+zgW/hGb2M1EUcC55GW6VbF9mVi/RfXlt
	 3LhuA0bcQ/pIC0ca82DsLQMKOV2oFPWWAX1P5rTIadquYP2Q54JW2VJc4ZBdAXvUz0
	 lhlVBg5991mXTNYbnaBboH4nEHYJpnDLjeLvSfVk=
Authentication-Results: mail-nwsmtp-smtp-production-main-84.iva.yp-c.yandex.net; dkim=pass header.i=@onurozkan.dev
From: =?UTF-8?q?Onur=20=C3=96zkan?= <work@onurozkan.dev>
To: rust-for-linux@vger.kernel.org
Cc: ojeda@kernel.org,
	alex.gaynor@gmail.com,
	boqun.feng@gmail.com,
	gary@garyguo.net,
	bjorn3_gh@protonmail.com,
	lossin@kernel.org,
	a.hindborg@kernel.org,
	aliceryhl@google.com,
	tmgross@umich.edu,
	dakr@kernel.org,
	tamird@gmail.com,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Onur=20=C3=96zkan?= <work@onurozkan.dev>
Subject: [PATCH] rust: uaccess: use to_result for error handling
Date: Thu, 21 Aug 2025 12:19:39 +0300
Message-ID: <20250821091939.14019-1-work@onurozkan.dev>
X-Mailer: git-send-email 2.50.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Simplifies error handling by replacing the manual check
of the return value with the `to_result` helper.

Signed-off-by: Onur Özkan <work@onurozkan.dev>
---
 rust/kernel/uaccess.rs | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/rust/kernel/uaccess.rs b/rust/kernel/uaccess.rs
index a8fb4764185a..9992eece2694 100644
--- a/rust/kernel/uaccess.rs
+++ b/rust/kernel/uaccess.rs
@@ -7,7 +7,7 @@
 use crate::{
     alloc::{Allocator, Flags},
     bindings,
-    error::Result,
+    error::{to_result, Result},
     ffi::{c_char, c_void},
     prelude::*,
     transmute::{AsBytes, FromBytes},
@@ -495,9 +495,7 @@ fn raw_strncpy_from_user(dst: &mut [MaybeUninit<u8>], src: UserPtr) -> Result<us
         )
     };

-    if res < 0 {
-        return Err(Error::from_errno(res as i32));
-    }
+    to_result(res as i32)?;

     #[cfg(CONFIG_RUST_OVERFLOW_CHECKS)]
     assert!(res <= len);
--
2.50.0


