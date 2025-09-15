Return-Path: <linux-kernel+bounces-816192-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 62BA8B570C9
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 09:00:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3F22E189B48E
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 07:00:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22C092C08B6;
	Mon, 15 Sep 2025 07:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=onurozkan.dev header.i=@onurozkan.dev header.b="bpBXyycm"
Received: from forward204d.mail.yandex.net (forward204d.mail.yandex.net [178.154.239.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F5E21448D5;
	Mon, 15 Sep 2025 07:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.217
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757919611; cv=none; b=vANlVGQQHwKIU0/9UnhimTTt448liaCCEvwgSyuk4THea0Zp+3gSzdL08Rw+nF/wmJ1vNspnJpxu7cyl9y2QIvHuVKQbpJZtjo/ewVAWPkIpAOGGCOc+ZOLB5sN7WSlSVgOBkBcqRJNpvzItTyP6IAPuQ78a/TXiQDoVMYDhYn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757919611; c=relaxed/simple;
	bh=AINEtlF9zDs/KqgilrXBWPJYmYnlTEXucuu0u+qehgo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=svg7BsskHq1rn243UR9s+lhkU+OEgbmtZMKVIuT4L+arwYu9OujGRbSjau9DBvbS1uSByM6CYLnehRFQK+f3HtMRUtPk6kEPNu++JiBo6U+WFGbPmIhsV6aU55/Ytfc7xPrgt4p5nD3V626deA6evC2YWl0/AzlH80RIQYuaXJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=onurozkan.dev; spf=pass smtp.mailfrom=onurozkan.dev; dkim=pass (1024-bit key) header.d=onurozkan.dev header.i=@onurozkan.dev header.b=bpBXyycm; arc=none smtp.client-ip=178.154.239.217
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=onurozkan.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=onurozkan.dev
Received: from forward101d.mail.yandex.net (forward101d.mail.yandex.net [IPv6:2a02:6b8:c41:1300:1:45:d181:d101])
	by forward204d.mail.yandex.net (Yandex) with ESMTPS id 069788312D;
	Mon, 15 Sep 2025 09:54:47 +0300 (MSK)
Received: from mail-nwsmtp-smtp-production-main-73.iva.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-73.iva.yp-c.yandex.net [IPv6:2a02:6b8:c0c:1c0b:0:640:ca38:0])
	by forward101d.mail.yandex.net (Yandex) with ESMTPS id 281C2C00AD;
	Mon, 15 Sep 2025 09:54:39 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-73.iva.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id 2sIJm4gMJSw0-Cu8AWOwK;
	Mon, 15 Sep 2025 09:54:38 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=onurozkan.dev;
	s=mail; t=1757919278;
	bh=7j7KllmYbwGFWgkEMmc393MH3+GM0PPgQZB5TltDAzU=;
	h=Message-ID:Date:Cc:Subject:To:From;
	b=bpBXyycmTN+USmco2JtC1caDgi8Nv6UWoTUPz18ghHsZLzK8B6BBxpznD5u1bGdpB
	 5xyWcGTw4GZ8r/6YpLSEQeWdl5guymJAlZMSMfw3bkngyuU0a+ZXsSW8ZHa8VtRp41
	 +Lz0RhjA4mCVfghe3de2cA8YYxgyUAtxI0tFFkUs=
Authentication-Results: mail-nwsmtp-smtp-production-main-73.iva.yp-c.yandex.net; dkim=pass header.i=@onurozkan.dev
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
	daniel@sedlak.dev,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Onur=20=C3=96zkan?= <work@onurozkan.dev>
Subject: [PATCH] rust: less allocation in CString::try_from
Date: Mon, 15 Sep 2025 09:54:01 +0300
Message-ID: <20250915065401.20141-1-work@onurozkan.dev>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Allocates buffer with the correct capacity upfront by
using the length of the `CStr` to avoid extra and unnecessary
re-allocation when converting from `CStr` to `CString`.

Signed-off-by: Onur Özkan <work@onurozkan.dev>
---
 rust/kernel/str.rs | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/rust/kernel/str.rs b/rust/kernel/str.rs
index 6c892550c0ba..98d41d995e45 100644
--- a/rust/kernel/str.rs
+++ b/rust/kernel/str.rs
@@ -946,9 +946,10 @@ impl<'a> TryFrom<&'a CStr> for CString {
     type Error = AllocError;

     fn try_from(cstr: &'a CStr) -> Result<CString, AllocError> {
-        let mut buf = KVec::new();
+        let bytes = cstr.to_bytes_with_nul();

-        buf.extend_from_slice(cstr.to_bytes_with_nul(), GFP_KERNEL)?;
+        let mut buf = KVec::with_capacity(bytes.len(), GFP_KERNEL)?;
+        buf.extend_from_slice(bytes, GFP_KERNEL)?;

         // INVARIANT: The `CStr` and `CString` types have the same invariants for
         // the string data, and we copied it over without changes.
--
2.51.0


