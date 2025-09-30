Return-Path: <linux-kernel+bounces-837567-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F380BBACA18
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 13:04:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ADBB11C46AE
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 11:04:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4A40230D14;
	Tue, 30 Sep 2025 11:04:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eblLuuX/"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A37B01F1932
	for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 11:04:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759230285; cv=none; b=N8vsyQ7RsrJ/MjHHUQcnhDTdaYV9CGV76JxHeD3NKFZtGeqztDHcHmdNTdzKnWuec8uCHc11SDhTFMgwgB/lkaNX1HnXtJnZ7+QxBOkqBv0p66c73FNA3pQfwjUQNiEVql4oTgeJRShRQnrXWxV9m1yF8DbctrBWsUPjzC28AcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759230285; c=relaxed/simple;
	bh=rd6r3YZ5CreoOIGPhlv7qZcTbTgQxOS1EYltrH+4Vok=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JYEurIPv5eJXf092q6dTFaBHjviAOODYqT1H5vrjtYNshM6ez32ZM7iYMXM3k1p8i4FLpLVzm5xnL1WupFAh0HhcCimw2tn1GVWyogXUOxNHmujoAf1oUaCt4GgpwnP87aAYGZnsarhHwJxOBhTmBROxEp8eYZPl2241vyU+/NU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eblLuuX/; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-27ee41e0798so72126905ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 04:04:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759230283; x=1759835083; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IPM9cQm+a2uPRDlRKN6oUV7loYn+iemaYSScmwnHm2U=;
        b=eblLuuX/GahellGoPu7RbL4xOj4Uu2XBrdbde/Bv6Qy3uCBKLJSGEoK98khvYNYsGo
         eBdKMeDYb4TS8t9f+DgJLeUxAY8S0AZzU/98t47TvKEpXCf2lPBDXFk/lZoxNmfjUvii
         PqQd3A0MSHrLe0ZZYBHJVctYTsyVySHoK6VpacoKX4EXRBadWo09ljKBL7jQzsB0eqmH
         eFvAn+qPOm957mOKG/6lhhmBouJwXK2sHyQzoPhC3uKsKzucsUKqHgT46WNBPHkn8eV4
         eEo+nRS90RHqATqmK+30qB9BH2vAo7vHjWdRC/8Z9+iEz6a93fsXprTlghS3O8F0IMol
         XS7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759230283; x=1759835083;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IPM9cQm+a2uPRDlRKN6oUV7loYn+iemaYSScmwnHm2U=;
        b=eXS4OhL7vq/2tf8sgc6eqmcieV/JLHDBR6r7mOhCXg0lWS9av0evXJLiMcY41zGfuC
         KOkxE/dPNk1ONos2Tlv2uBFDRb6LBSnnRpGvuBloMz5cVwB5QJv0PplESWrWUbypGhy+
         clWDtV+VhNwHchJaz1IZlMKOU3TYZWBCzjo5+0ksud7Kzk0oSBhoq2u02IMX2tdqWkdL
         r/g6R/QZnbyjUNRWeurBXT8VsaVykwYTqB2+UD5iImL1/Q/5bXTfH0uyzM7gJeJK1grs
         bz21Y9YWsIr62wBLPk0QWxVO0B3c+QUFj9gikW3ru0gI9gBGZIHuoe7KEEiHRP+jLRYH
         gdNw==
X-Forwarded-Encrypted: i=1; AJvYcCV/ShYuzOI/DYw3zYw5pxTJT7d+/CI1HwZuM+vN39L2nSfxpn0TlQofLH/5UZb60l5d2mCT3DaEcbKBtL4=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywoc0Jk6TWIhrqy95WDSmhKQWBQeIawNP2E/e8TcaSI0X3FQFsG
	wLLReLZ1/4qYi68z4Y6B2peeV3K4RP4bVCoTwc9rNVLV3ABslF3QQVhf
X-Gm-Gg: ASbGnct/NjRw4y/KApqZXj+f3WubJ9PqaQ8Z7H0rnlEs5F+PvLsJhcZmkrJui45+LNK
	xPZJc4QCpxYqGxFJcZf4Az7zlYW1Osu1qzQvh5wdFoQEDL2RXWm5xT8FBDql3qVNDxoW3bXHb8R
	oLveNIP43fjwwLU9PG3U7y01irzwC3ZZzOKmfb2wdyPOI7M9Ak/PnbMaRqAevIe5bfOk/R8Tt+b
	NvJQP7l8XoVNh9O/HCrG1m5xqgUsFVuW1VEuiVrw+mBoYlyXhEhpkysYaeZ70I16rxYokni1592
	ak9grRgrB6qGBpvM89QXFNxRi3IIy4+tiEbakT2cl1TyTd8dOiHEklLfZJYT98lo/xnrese/DZz
	OErD/eVLZqfXGX+6T6C+X41edPe3ys/aWI+bMhlgGppE6CkemKAvwhPwhxjoWdw==
X-Google-Smtp-Source: AGHT+IHzSgoeQhshCVoioYm/kSlIiIPlDW7b2JR6FtckzXalSYNpdGWehRFnw4TklcYXNFKx4nNzww==
X-Received: by 2002:a17:903:2348:b0:275:3ff9:ab88 with SMTP id d9443c01a7336-27ed4a4e174mr220944555ad.49.1759230282147;
        Tue, 30 Sep 2025 04:04:42 -0700 (PDT)
Received: from LAPTOP-1SG6V2T1 ([45.14.71.13])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-27ed66fb07dsm155372575ad.36.2025.09.30.04.04.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Sep 2025 04:04:41 -0700 (PDT)
From: Tong Li <djfkvcing117@gmail.com>
To: Miguel Ojeda <ojeda@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Tong Li <djfkvcing117@gmail.com>,
	=?UTF-8?q?Onur=20=C3=96zkan?= <work@onurozkan.dev>
Subject: [PATCH v2] rust: file: add intra-doc link for 'EBADF'
Date: Tue, 30 Sep 2025 19:02:58 +0800
Message-ID: <20250930110258.23827-1-djfkvcing117@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <CANiq72n+tBB=NasbJr95YJ=HPgSc35uwKALRyHDOyh4nG6xUOA@mail.gmail.com>
References: <CANiq72n+tBB=NasbJr95YJ=HPgSc35uwKALRyHDOyh4nG6xUOA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The `BadFdError` doc comment mentions the `EBADF` constant but does
not currently provide a navigation target for readers of the
generated docs. Turning the references into intra-doc links matches
the rest of the module and makes the documentation easier to
explore.

Suggested-by: Onur Özkan <work@onurozkan.dev>
Link: https://github.com/Rust-for-Linux/linux/issues/1186
Signed-off-by: Tong Li <djfkvcing117@gmail.com>
---
 rust/kernel/fs/file.rs | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/rust/kernel/fs/file.rs b/rust/kernel/fs/file.rs
index 67a3654f0fd3..f3153f4c8560 100644
--- a/rust/kernel/fs/file.rs
+++ b/rust/kernel/fs/file.rs
@@ -448,9 +448,9 @@ fn drop(&mut self) {
     }
 }
 
-/// Represents the `EBADF` error code.
+/// Represents the [`EBADF`] error code.
 ///
-/// Used for methods that can only fail with `EBADF`.
+/// Used for methods that can only fail with [`EBADF`].
 #[derive(Copy, Clone, Eq, PartialEq)]
 pub struct BadFdError;
 
-- 
2.51.0


