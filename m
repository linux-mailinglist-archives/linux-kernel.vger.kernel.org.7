Return-Path: <linux-kernel+bounces-811667-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B873B52C49
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 10:55:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 486315A2191
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 08:55:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9108C2E6CD0;
	Thu, 11 Sep 2025 08:55:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=onurozkan.dev header.i=@onurozkan.dev header.b="kwxRxUwz"
Received: from forward103a.mail.yandex.net (forward103a.mail.yandex.net [178.154.239.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEFF22638AF;
	Thu, 11 Sep 2025 08:55:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.86
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757580921; cv=none; b=W5wCWlDHei/20HSPqn4JI+5BwpdwCsLCobDk92y7zXimn4wkUMCDFMIJjYldm6KkoyV17jtlHoenNXTXixVZm9TGHMbK/8RpXgLP6V8WingA9hVBF3CF6Yxh3peqYsXdv6hzascChaADqiVrDu8J69xsSJIU06tmsB9jcF0y7qk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757580921; c=relaxed/simple;
	bh=nN9dy6AUF67evN5j0A/xzs6dC9QUmWEeqQVishGoCcU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=tikJ/xvl71Vss6vbGt9ezagiZcvEd+QoNVLHzU0ba1uQqCe1QwLt2bQyWXIKa5M40cGR6wCmJuAVawYgh3zj/fuvucfLZSiXU2q6PSpKqKt3hOGAVjG6T+9b1BarKIcLcmAn30/OhmZsi8NgueZPKcolWrtDQNviIVUbyP4+l7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=onurozkan.dev; spf=pass smtp.mailfrom=onurozkan.dev; dkim=pass (1024-bit key) header.d=onurozkan.dev header.i=@onurozkan.dev header.b=kwxRxUwz; arc=none smtp.client-ip=178.154.239.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=onurozkan.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=onurozkan.dev
Received: from mail-nwsmtp-smtp-production-main-84.vla.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-84.vla.yp-c.yandex.net [IPv6:2a02:6b8:c15:2a0e:0:640:b7ff:0])
	by forward103a.mail.yandex.net (Yandex) with ESMTPS id B30D48081A;
	Thu, 11 Sep 2025 11:55:09 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-84.vla.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id nsGpwY8Ls8c0-qcYCpz8N;
	Thu, 11 Sep 2025 11:55:09 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=onurozkan.dev;
	s=mail; t=1757580909;
	bh=D56v8K6jg5P7Z0Nemp2J29DkzwufyqTCXucNwK/WLOc=;
	h=Message-ID:Date:Cc:Subject:To:From;
	b=kwxRxUwz36OEc7Pg1i87BJlfJxQetjAhq+Ik0jiEvFzXG5D9uYDtURh+1wFPlvJIS
	 OmhyUhXz/7LhuTHz8vjU2XqDzWCqXxODJSDwjuBhYId62yblaN/YeNwaHf+Wh4FmgT
	 NNf+3KXYTsWkx7LHCpC/zbUpifwWQhJqY6eDv/dQ=
Authentication-Results: mail-nwsmtp-smtp-production-main-84.vla.yp-c.yandex.net; dkim=pass header.i=@onurozkan.dev
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
Subject: [PATCH] rust: resolve safety comment TODO in `as_str_unchecked`
Date: Thu, 11 Sep 2025 11:54:47 +0300
Message-ID: <20250911085447.17463-1-work@onurozkan.dev>
X-Mailer: git-send-email 2.50.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Resolved the TODO comment with a proper safety explanation.

Signed-off-by: Onur Özkan <work@onurozkan.dev>
---
 rust/kernel/str.rs | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/rust/kernel/str.rs b/rust/kernel/str.rs
index 6c892550c0ba..11c30c765828 100644
--- a/rust/kernel/str.rs
+++ b/rust/kernel/str.rs
@@ -380,7 +380,8 @@ pub fn to_str(&self) -> Result<&str, core::str::Utf8Error> {
     /// ```
     #[inline]
     pub unsafe fn as_str_unchecked(&self) -> &str {
-        // SAFETY: TODO.
+        // SAFETY: The safety precondition guarantees that the contents
+        // of this `CStr` are valid UTF-8.
         unsafe { core::str::from_utf8_unchecked(self.as_bytes()) }
     }

--
2.50.0


