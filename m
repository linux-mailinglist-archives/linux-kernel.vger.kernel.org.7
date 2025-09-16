Return-Path: <linux-kernel+bounces-819113-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 72803B59BA9
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 17:13:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E07B55823C6
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 15:08:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F845342C81;
	Tue, 16 Sep 2025 15:07:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E3DCAUww"
Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com [209.85.160.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 017AE199935
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 15:07:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758035244; cv=none; b=cyoOsP/VwNfQy44x81cVD4rxBCMq3DFdWeyoBJdLDUSYmkFxhBQJuBvzHAFS1YKO9vSWNe6gYsOe0wHnIfOKuNZ3lRAy1JucqVK/5HZpJqDIu3a+UtAR+8fQqKz9sgNW21aGhHfPMs56l5yKBAWfgPTMr1Nef6EmtKViW8n6rU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758035244; c=relaxed/simple;
	bh=3Oa5bbReN+IFs41fx+WTdIGfcqpFvk15NI3xSEtBVcY=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=O5EYrf9hLAx1Xp0YTNFBGs/dJ9ZiEOtVYMQl5Avl6F8XDJSXAI8qnFKL8KI8IQNhfu29TOyp7757+u0UQTCwePl4CiUlUe+t1uIqXT4Owq5D8YSt3mFmhL7QYPcxGyziEuv+xeCLQ0VUFAizetkqF8Mp1Y0ygwx7Os+mq3r5tlo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E3DCAUww; arc=none smtp.client-ip=209.85.160.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-30ccec59b4bso4314543fac.3
        for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 08:07:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758035242; x=1758640042; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=YIrsty49EqHd/LfAleRnfHKxwp77+D8eONShnFHz9NY=;
        b=E3DCAUwwP20gD+l3VGEbXkX0+5M4i5OfJLwDBKN6tXnZ0l+DvnJqHJ53f0tN6Qw7Xh
         TsIIw3FwrGuCYfbaAXBx5DtLcEmy29gwc6AJ3lhxwOj7YJpmTdCExo0gdT6iJwTtLSXh
         L0W0pF5AkoFjhPo0KtPkFV8ZBuQgK84crCo+c5ddu5xrtpzvKQ4GCetWG+CIYY/ihxE7
         ZyhWkjWM9fORx3Bc5cKS02z/aAztvAjhYXnWDv5+aVCZRkCjYUaDhtp5HcuMTgGoHxk8
         5dp5dp/QvU+f+gSPk33EORk3E2CxMfv8Ndg3vSXIQ/SXBK3Zjw5OhEJXhRMshLWHJBb7
         LNSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758035242; x=1758640042;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YIrsty49EqHd/LfAleRnfHKxwp77+D8eONShnFHz9NY=;
        b=SBkf6UrGDkNE3u1Bgd3IFmU/j4xrquvmgf9bF2eiV7SGroKIyhK5Yg0Bc6UsuMnFQM
         HrRuxrKR9EBPoaStPVRETpi4h3x1eErVIdBk+krQyuArI+AMDA9ygSyQWS3Zpf44H8iu
         PTd/vvksMJFs9RyN0CxPFxxuolBymvHuUIkcivbo4e8TjKN5qc94EELrEfI03PbQf+ap
         iUhqRAFYDDzwQ2hcmH+vEqXAorxFM7Sm4dXDoWtUzhlLSSvr0aJt8nistSpBDLNtXQsX
         Xkqzw4NwcTTraTMSgzVGWOoSbltrypgY+gF7Whd94CYz1/rUHqGxyW0CiAtxqTp7vtzQ
         SlCg==
X-Forwarded-Encrypted: i=1; AJvYcCXT3Qb2HIkW4DQ45llFi/fdpm2w12x+s87bBDp1manAz7N/aSw2uAuqwlMOvYNURPjdOBuAoAfNIaBUijY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyhBzlk9zhRgN0TRJrdbNqSyTVJidPH6DEvSBaslSPdRG7BZfyV
	8nMdmOh/UjY3MbFfeo8GMdpi8Khd4VPBvwne0y0lgyQEhJvq4P7+dbHIZFdPWpE5KiyQrMGE1V5
	Emf1Rb43jqLRRtKYtOzuld/7e1lnJS04=
X-Gm-Gg: ASbGncuo02963njSq9BDL7ThNC9DhI1xDi0SUsJnL6/g48WSS58zXs76BWKy+/9HbAl
	RZBhksn2fuPSig+TX9UiA3AiGYULh4vYvguwWOcKcW3sgJhod0BBBBk0c/7j/Wxyp8mvS/0umUy
	0/a+RFwbvLh2rqXf7ggaowTyVnSbmKrP5LUhXyfDXzCQKcFFrM50GvasZA2DUbkjxyQusCH0pAX
	xV0
X-Google-Smtp-Source: AGHT+IHqwJTYrIGgbZivy75H7H4OJfKIv8NVlyijziCza4PY+MyorgVI5amHSBAz4eJ8RrCkN/C0W25+J1CKJVpcv3U=
X-Received: by 2002:a05:6871:29b:b0:315:b768:99eb with SMTP id
 586e51a60fabf-32e560c2b56mr8355537fac.30.1758035241848; Tue, 16 Sep 2025
 08:07:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Tong <djfkvcing117@gmail.com>
Date: Tue, 16 Sep 2025 23:07:09 +0800
X-Gm-Features: AS18NWAWQkjF12D-ms3vwDWWXU5h7qyiyDFpZGX8VJQFOABp8t_eXS34CBkSo8Y
Message-ID: <CAMfjjQ2a2HdFWcUWV10qP0qVmPS5vGiAJTa_7qGjoCTW5+Lm-Q@mail.gmail.com>
Subject: [PATCH] rust/fs: use intra-doc link for `EBADF` in `BadFdError` docs
To: rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: onur-ozkan <work@onurozkan.dev>, lossin@kernel.org, gary@garyguo.net, 
	alex.gaynor@gmail.com, david.m.ertman@intel.com, bjorn3_gh@protonmail.com, 
	Greg KH <gregkh@linuxfoundation.org>, ira.weiny@intel.com, leon@kernel.org, 
	dakr@kernel.org, tmgross@umich.edu, ojeda@kernel.org, boqun.feng@gmail.com, 
	a.hindborg@kernel.org, aliceryhl@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

rust/fs: use intra-doc link for `EBADF` in `BadFdError` docs

This patch changes the documentation for `BadFdError` in the `fs`
module so that the error variant `EBADF` is referenced via an
intra-doc link (i.e., [`EBADF`]) rather than plain text. This improves
the generated documentation (so the `EBADF` constant is linked), and
helps tools like rust-analyzer to resolve the reference from the docs.

Testing:
- regenerated documentation, confirmed the link to `EBADF` shows up correct=
ly,
- ran doctests to ensure no broken links in docs,
- built affected code with rustfmt / clippy to verify formatting and
lint cleanliness.

Suggested-by: Onur =C3=96zkan <work@onurozkan.dev>
Link: https://github.com/Rust-for-Linux/linux/issues/1186
Signed-off-by: djfkvcing117@gmail.com

---

From 87d6b4e61da0db96a018b86baa011b9c6635e665 Mon Sep 17 00:00:00 2001
From: Webb321 <140618222+Webb321@users.noreply.github.com>
Date: Tue, 16 Sep 2025 22:58:26 +0800
Subject: [PATCH] rust/fs: use intra-doc link for `EBADF` in `BadFdError` do=
cs
MIME-Version: 1.0
Content-Type: text/plain; charset=3DUTF-8
Content-Transfer-Encoding: 8bit

In `rust/kernel/fs/file.rs`, replace plain text `EBADF` references in
the doc comment of `BadFdError` with intra-doc links [`EBADF`].
This improves the generated documentation (so the `EBADF` constant is
linked), and helps tools like rust-analyzer to resolve the reference
from the docs.

Testing:
- regenerated documentation, confirmed the link to `EBADF` shows up correct=
ly,
- ran doctests to ensure no broken links in docs,
- built affected code with rustfmt / clippy to verify formatting and
lint cleanliness.

Suggested-by: Onur =C3=96zkan <work@onurozkan.dev>
Link: https://github.com/Rust-for-Linux/linux/issues/1186

Signed-off-by: djfkvcing117@gmail.com
---
 rust/kernel/fs/file.rs | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/rust/kernel/fs/file.rs b/rust/kernel/fs/file.rs
index 67a3654f0fd370..f3153f4c8560bb 100644
--- a/rust/kernel/fs/file.rs
+++ b/rust/kernel/fs/file.rs
@@ -448,9 +448,9 @@ impl Drop for FileDescriptorReservation {
     }
 }

-/// Represents the `EBADF` error code.
+/// Represents the [`EBADF`] error code.
 ///
-/// Used for methods that can only fail with `EBADF`.
+/// Used for methods that can only fail with [`EBADF`].
 #[derive(Copy, Clone, Eq, PartialEq)]
 pub struct BadFdError;

