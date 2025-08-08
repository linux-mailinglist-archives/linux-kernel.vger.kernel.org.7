Return-Path: <linux-kernel+bounces-759754-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 87757B1E200
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 08:13:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B0212177CAD
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 06:13:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F5DE222577;
	Fri,  8 Aug 2025 06:13:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="E0AnhSy0"
Received: from mail-24417.protonmail.ch (mail-24417.protonmail.ch [109.224.244.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9F6821D3F0;
	Fri,  8 Aug 2025 06:13:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.224.244.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754633617; cv=none; b=bX4pSvYvqkFhksyfKxl/rNNbl8KAySbgZHfHpazdkzDcBm9NULK1bHdMNYiHzXFjvhmC8+nzQ18PvnP7KrsPtET2SxrYs0fYKkcsvan+TPF04Qu6G08+QRVed6UMe9YDqop4p4OsjdbboGHcWDsqTeLgJGxXoeK/JaoaUAxdzyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754633617; c=relaxed/simple;
	bh=MuOPTDgQU29247DLgY8+Lmyrxez7rrt9iyp3vKghqp0=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=liNA18pA6zf1/LO7T67s/XaaNwEO8/W4KjxR9UQvmFJj06qNBJRK7FiRYJLqwrcAsnfispyvJUPr2C3Xs0TEyUQDaQJyc+qtv9I9WKV0+1RZpcgGMu/l882Z2NyHJoCBaJ3dKDQcPTOR7RDovYqrAX3GDNRTvQqY1AsD3OMJwb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com; spf=pass smtp.mailfrom=protonmail.com; dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b=E0AnhSy0; arc=none smtp.client-ip=109.224.244.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=protonmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
	s=protonmail3; t=1754633608; x=1754892808;
	bh=DVoGha/incWcNsAyXcYxtSakFRN5uHI6li9pSOPUlhc=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=E0AnhSy0hEoEfPK0zzuXvXFjJZ8CZFo06MDlyy+nRGDCXhrcQ3qxRrjDrLI3G3zDi
	 E4kI7ZXsOZ3ICsOGBo9HqhVRWZvmLxNO8RGz3AGrl8369pXo07hx1LrGQSggUi8AAf
	 aIH6+DrYxhodHKKXXjPtsv6GNclPFKuDXDGlgcF6YZ31nJAXtA2THhVnN0uhKz56Gl
	 qLHW88NODPg6NQluxu2KZVKZlV2HRtkVNDc2Kd6OC5L4RR7huHeAwno79zk7MF3HjS
	 lGP8fi32bcSbVsiTtxN/W8q+mvqD53ObtQ62yiUScBkR0g38BGKovLKmgO4VD2/Lui
	 ac2ae11zrZSww==
Date: Fri, 08 Aug 2025 06:13:22 +0000
To: linux-input@vger.kernel.org, rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
From: Rahul Rameshbabu <sergeantsagara@protonmail.com>
Cc: Jiri Kosina <jikos@kernel.org>, a.hindborg@kernel.org, alex.gaynor@gmail.com, aliceryhl@google.com, benno.lossin@proton.me, Benjamin Tissoires <benjamin.tissoires@redhat.com>, bjorn3_gh@protonmail.com, boqun.feng@gmail.com, dakr@kernel.org, db48x@db48x.net, gary@garyguo.net, ojeda@kernel.org, tmgross@umich.edu, peter.hutterer@who-t.net, Rahul Rameshbabu <sergeantsagara@protonmail.com>
Subject: [PATCH v3 RESEND 1/3] HID: core: Change hid_driver to use a const char* for name
Message-ID: <20250808061223.3770-2-sergeantsagara@protonmail.com>
In-Reply-To: <20250808061223.3770-1-sergeantsagara@protonmail.com>
References: <20250808061223.3770-1-sergeantsagara@protonmail.com>
Feedback-ID: 26003777:user:proton
X-Pm-Message-ID: 3c9259ab252a89170e4c977dbb40d846bf2ca300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

name is never mutated by the core HID stack. Making name a const char*
simplifies passing the string from Rust to C. Otherwise, it becomes
difficult to pass a 'static lifetime CStr from Rust to a char*, rather than
a const char*, due to lack of guarantee that the underlying data of the
CStr will not be mutated by the C code.

Signed-off-by: Rahul Rameshbabu <sergeantsagara@protonmail.com>
---
 include/linux/hid.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/hid.h b/include/linux/hid.h
index 568a9d8c749b..d65c202783da 100644
--- a/include/linux/hid.h
+++ b/include/linux/hid.h
@@ -816,7 +816,7 @@ struct hid_usage_id {
  * zero from them.
  */
 struct hid_driver {
-=09char *name;
+=09const char *name;
 =09const struct hid_device_id *id_table;
=20
 =09struct list_head dyn_list;
--=20
2.47.2



