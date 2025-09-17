Return-Path: <linux-kernel+bounces-821371-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 89630B81156
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 18:51:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 926667A6346
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 16:49:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1D552FB085;
	Wed, 17 Sep 2025 16:51:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V1pvPFy9"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B35B62F83DE
	for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 16:51:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758127883; cv=none; b=He+eItHXo4B9KtyW/ubk1YrWH+9CuZnvrpxUpJnVd7hs/5XiyMO6cjrL9JgKRIeDMdCcvZ1Hb7JBitg+SO0hBzfmZDV+Pwp+0mMa+tcMY+5FfmKDJoQOhheHoeLQxznNXXMIsXv5RuXXQW5wDwAK/absHmt0yrQrXqwm3NKaHUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758127883; c=relaxed/simple;
	bh=5CHAX/eFWIie6RcVxAtrIKJ7zhEjDBgEC9JG/XZEo8A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=fxDSsc+P1Vd9/Kajt0KAQ+YHBmER+EWm7EEWbKj86C/dFjbMhEel8CdU+nQ6gM85BnEHSh2ZJv1xn2XgWNKqzh+vmF0dK93Bow/ypVwEAvXSb8Rfm9WJyfkpTKHTpcrS+TsHkzRRa9cnd80S+l0Qs8jxFIf6jsv0ofxyGdwS/gM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V1pvPFy9; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-264417f3a26so186925ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 09:51:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758127881; x=1758732681; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=V5/sfcYMmxKdZz4FohXf1IpKXn8Gn6GevqVRpmEVs50=;
        b=V1pvPFy9QIZfbvuBSrOLgaPn1TyV7Ls9YzObwVNlqocs91d8+0McMrQMXMF9OGV7YE
         knABoLYVCq4in87LB2hRJTjCCsJ7vZ0ok6nvjO4R7Rd1qPcs8OuxZxAfxglB4vBT8YLc
         i72WenSdTBCRhIZwGEsqp1mX3Siiar56OktWc7NGCZg9r8gBlI+Uf9/bhIM2RCVksVSx
         7aQNdaFauxO5fkKFyB0Xw/WANmvMLOnAr/NcV1wk0pniNBaXVl2EkTgPAxsfb1hSFfNN
         PvJWmvV+3Xza+4OwG19SpA6LNrZVewA83d0ijZJb88oWgfo+iEQ5DPTjnsz+PfQZLdXV
         EC1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758127881; x=1758732681;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=V5/sfcYMmxKdZz4FohXf1IpKXn8Gn6GevqVRpmEVs50=;
        b=VJa0MT+ooQTd1DQEaTIk9b8kI2Gh47rHRVDKLP99tGnD5Pmf9qiIpMQVYx9UCykUmo
         Wut/WaSOf7y/dadVv9kNd7aPtLdBwXMlLYKkOHSgnSBHOy9txbVU6XQSG0Pv9F4bdFf9
         jiKs+l/M3uMXpbyysNaeAAhsijnEWNNdlvf4m8xXOT8aGfnv+jJ1+BYE8gk9bbdrc6T3
         52LVTTGdOXdHAa3Zo5ZeXRox/b2uOyrgBZV+LEx3EcERYQgApnD3DbKB58jHjsX1NeyV
         yeJQY4PhWU+H+x/5Y6gg1eBrsMScR3laILYQvs0LWh8rOAx7tu1nKn+cjb2oGlwz3Snt
         bwOA==
X-Gm-Message-State: AOJu0YxvirAAYaf/+0F2yRvZBYVyqWrIFZtkDlVVX85dLXPbSThfzlJ8
	9O/2W0GQUK+/rqnVyYRZEOcGaOmZ0erRpecHLsWUMVTirs1Pswqap1zUSKMjPl4LuaX8JM18+j0
	=
X-Gm-Gg: ASbGncv5pCeaL16iCYf7WBw6nBqvKlnZ6FKlZIg/e9sXiqafIVjklS4Mv6IzRoJgLYd
	5eRhNv+Lnvn2o3GfnUqj/Sk5QdFK8wDwNFkSwO5+6BbIc4DQzQqnPxvWu5rRObiukeoSijuqXm7
	GDRovZdtZraoaz36e+lmWxsMG8q1zuRUoFxv8O6Er2G9LS9xD86r4ziKeshVK3a4niEAtHUL2lR
	FJ3Oe1CtYYu9VX0R5ggKAVMFT8oKp5+Kxphqb+5eqyOvQo4HVm0OlQTug8omXLBHMIeQup7Q7/k
	iiXurEjvN3f7vMZMB43KVoUZqbRsTsf5mMyHD9U6sXSN5qLLl4FAsV5ktnkIfWWdzqd8NBqn8/P
	J5oh/mNhQquS37ylZOl6m3zR3hiG9
X-Google-Smtp-Source: AGHT+IFm8FE3BSR5+gXsvt5+56cKgJkHI6zUkJnv5mR/WV8vtAeVCagIoQZ92DZuSp+qmtL7Ky0Cmg==
X-Received: by 2002:a17:902:d2ca:b0:266:2e6b:f592 with SMTP id d9443c01a7336-2681217ae3emr34230875ad.25.1758127880709;
        Wed, 17 Sep 2025 09:51:20 -0700 (PDT)
Received: from LAPTOP-1SG6V2T1 ([149.40.62.106])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-269800531f4sm1003615ad.25.2025.09.17.09.51.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Sep 2025 09:51:20 -0700 (PDT)
From: djfkvcing117@gmail.com
To: linux-kernel@vger.kernel.org,
	rust-for-linux@vger.kernel.org
Cc: Onur <work@onurozkan.dev>,
	gregkh <gregkh@linuxfoundation.org>,
	lossin@kernel.org,
	gary@garyguo.net,
	Tong Li <djfkvcing117@gmail.com>
Subject: [PATCH v4] rust/fs: use intra-doc link for `EBADF` in `BadFdError` docs
Date: Thu, 18 Sep 2025 00:50:59 +0800
Message-ID: <20250917165106.22262-1-djfkvcing117@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Tong Li <djfkvcing117@gmail.com>

In rust/kernel/fs/file.rs, replace `EBADF` with [`EBADF`].

This helps rust-analyzer to resolve such references.

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


