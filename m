Return-Path: <linux-kernel+bounces-733194-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B5B00B07162
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 11:16:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F3B9D1AA1C68
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 09:16:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0FCD2EA470;
	Wed, 16 Jul 2025 09:16:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fVEZTUcE"
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBC75233149;
	Wed, 16 Jul 2025 09:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752657372; cv=none; b=i6GD5Fzawiud4vgaD9Am5PTg5luNLfKtSQ1Ux7fkOhCno5h6sUA/9tRbXgvlfrN/DwH8JNUTEKPR6CVBW7THUPi/SpmhwLqa89sXrEzyUVsViDPXlfDO7YbWSrkXdnO7mbn5Q6KjEfKlm2VgaKZF52QAK6PF3bkMcJW79caD2mQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752657372; c=relaxed/simple;
	bh=mRBSsVfrZZ7GEMb39cgg8tu1x4zfVjX+Z21VmOrtvqc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=DWAhfjNHCXBwdNVWQNBukA2PQC/PNsPajZyoazveCefCpoz5D1WMTDr3EQo3nRPuVCUEyzEGC2QVSe3VCw8g9ZSLekVYrFBCymRswPFIS6/1SRcbs+sSrPAyVDkVit8kC6/SH2aRasOl44UYKF2Hw498jTK/+kc701lRNWAXsoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fVEZTUcE; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-7490cb9a892so3875216b3a.0;
        Wed, 16 Jul 2025 02:16:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752657370; x=1753262170; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=I34hikJCfMG5D+whgcXVeQl11LvJe5/t5Zwp0VdKmNA=;
        b=fVEZTUcEzOyqlYwzUzAv0ggdGpRg9wqsaw11w/0gpgvhOiHvWIVQuVaO4LI5By3UMA
         Fto7jWEQr420IBitBUhO6RN1aNn3q19peOGTCowf5MtaypsVQeYG0Wro4PP9Yns9HjPH
         ATiXggRIMdlCKoHo+HK3PCuzYN4C4GHfwV1My99Q76yx1oY0OFmMzO+crwLBvOusiTHr
         uPLjzo7RuNYzQhbSXwhyo1UlDrYJofhCXhx57GlAlaYHYxQh63q8kiJVQFWIDzdgYRC+
         AegYtkUizAPVeRzVXN2jvGvfhurVW7gbxeYsDjDzwE6EpPJD9tVQFMuKPHlp72leAYJM
         VVig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752657370; x=1753262170;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=I34hikJCfMG5D+whgcXVeQl11LvJe5/t5Zwp0VdKmNA=;
        b=EHjjCYpjkLTZd7TKf/kuwBEZ1duMPD6PBy9slsr9/0IrQ7o1Pau2gXeQPvmy+knRh7
         76DGXLMIJPuJW5JVIH8A0WrVm7+V6tBmbOfmdTSYqB5XdHWo+HxbWHufjEUZLAFuoBXP
         3tCIp2eOM35eU4WIcuSj98Q3SpRqYx00koQ/nECNA50BAuH4zw9N9Udfhj+Q3ZA9MSYR
         gQ5ZzpZjqhwG6nBXJoCnRHY+c+tTnxihNlxqqjjjkGue6toRcK42O88K77M3yv4KS2Wg
         qiHDCyDATicB09tkkynV6qxZBCht6JuL+2Fwl2P3rBIYWVpzXbxnsawkz0XixU9ZMrDX
         zN9A==
X-Forwarded-Encrypted: i=1; AJvYcCV6UToY4o2GCmgzyZVzC2eNRWUOobWKweA3orSmqe+qshZbryfl+aZd/t1iorggTeP5Gdg7FRSXwH8kTYM=@vger.kernel.org, AJvYcCXNH5pj20a2ogPXkNpEJTJSZD32oQnbOoX7o9wNClZLmnAyhMPejieyWEqZYgrxUlths4ojbcO3EKtND00c7pw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzItDt+g3WNjPOj2ZYKOkiUqpMwS7+WvxjWDlCzfCPvuSsWVrUC
	J4kxFzAQnAlH7ahepdThv+kveeIliyJ3DTqHXMWVnyx6qHnE7gnSxpC1
X-Gm-Gg: ASbGncvZdWsbL4ilKrh38tCrJZq0k5gO0uhvuNO75ho6s2oU4ib/WjSEoEcYyOtWB5V
	9kb5ao+hlsSeZradvRTTxMLYQbm3OtzBSfNvnLQ9OyszhZe800Ii+tOOeMBlZQ2ZTQvTUvSLxiC
	vj9CVpG80P8qccZUobcSFjy1PqKbAMGcbFYW67RYhMAwId/8IhGiqgaSwOSuOvdO6XARY+3i8sj
	w3ewAMfvqhebZHL7X7WpBiJKo2VMlu/teY4IRnUlOT6/pJgVLPMzWUUIkJ3628t8crDBdGNoGUy
	zDDjXJ7XZVsIv5uthJaQGiF6bEK6TVgonfaG3UPErmWdIHxOWVWlzDj0AO1Of2zg2jXiDx6bO0q
	BmhspFDDIzwJZVmLwSHsPVcUBHMONaz2duaq5gaJFqA==
X-Google-Smtp-Source: AGHT+IFvxBNA1DqEVoDatnUst33ZWJi9rrlHQ9KvAXUeBzHED7dR0VaBgCBruBTk3KzgsiA0qgbqQA==
X-Received: by 2002:a05:6a21:70c8:b0:220:7b2e:5b3f with SMTP id adf61e73a8af0-237d702aa8amr3834092637.19.1752657370104;
        Wed, 16 Jul 2025 02:16:10 -0700 (PDT)
Received: from shankari-IdeaPad.. ([2409:4080:410:5eb2:5b3d:132b:96fe:c1fc])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b3bbe58125bsm13544022a12.27.2025.07.16.02.16.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Jul 2025 02:16:09 -0700 (PDT)
From: Shankari Anand <shankari.ak0208@gmail.com>
To: Alice Ryhl <aliceryhl@google.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	linux-mm@kvack.org,
	rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	"Liam R . Howlett" <Liam.Howlett@oracle.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>,
	Shankari Anand <shankari.ak0208@gmail.com>
Subject: [PATCH 3/7] rust: mm: update ARef and AlwaysRefCounted imports from sync::aref
Date: Wed, 16 Jul 2025 14:41:58 +0530
Message-Id: <20250716091158.812860-1-shankari.ak0208@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Update call sites in the mm subsystem to import `ARef` and
`AlwaysRefCounted` from `sync::aref` instead of `types`.

This aligns with the ongoing effort to move `ARef` and
`AlwaysRefCounted` to sync.

Suggested-by: Benno Lossin <lossin@kernel.org>
Link: https://github.com/Rust-for-Linux/linux/issues/1173
Signed-off-by: Shankari Anand <shankari.ak0208@gmail.com>
---
It part of a subsystem-wise split series, as suggested in:
https://lore.kernel.org/rust-for-linux/CANiq72=NSRMV_6UxXVgkebmWmbgN4i=sfRszr-G+x3W5A4DYOg@mail.gmail.com/T/#u
This split series is intended to ease review and subsystem-level maintenance.

The original moving patch is here:
https://lore.kernel.org/rust-for-linux/20250625111133.698481-1-shankari.ak0208@gmail.com/

Gradually the re-export from types.rs will be eliminated in the
future cycle.
---
 rust/kernel/mm.rs             | 3 ++-
 rust/kernel/mm/mmput_async.rs | 2 +-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/rust/kernel/mm.rs b/rust/kernel/mm.rs
index 43f525c0d16c..4764d7b68f2a 100644
--- a/rust/kernel/mm.rs
+++ b/rust/kernel/mm.rs
@@ -13,7 +13,8 @@
 
 use crate::{
     bindings,
-    types::{ARef, AlwaysRefCounted, NotThreadSafe, Opaque},
+    sync::aref::{ARef, AlwaysRefCounted},
+    types::{NotThreadSafe, Opaque},
 };
 use core::{ops::Deref, ptr::NonNull};
 
diff --git a/rust/kernel/mm/mmput_async.rs b/rust/kernel/mm/mmput_async.rs
index 9289e05f7a67..b8d2f051225c 100644
--- a/rust/kernel/mm/mmput_async.rs
+++ b/rust/kernel/mm/mmput_async.rs
@@ -10,7 +10,7 @@
 use crate::{
     bindings,
     mm::MmWithUser,
-    types::{ARef, AlwaysRefCounted},
+    sync::aref::{ARef, AlwaysRefCounted},
 };
 use core::{ops::Deref, ptr::NonNull};
 
-- 
2.34.1


