Return-Path: <linux-kernel+bounces-768598-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B084BB26314
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 12:45:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A740558345F
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 10:42:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B77522D8364;
	Thu, 14 Aug 2025 10:42:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PnHTTVHX"
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4FBF318133;
	Thu, 14 Aug 2025 10:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755168127; cv=none; b=didO9qkphZBOA0Km9BYA6z5XZvx6LOsKj/DLL9bzExXygChZuZw9VprzjB/bjOmoya8ul63nwshv5sr0+CxSbE+jhsdH9tB6usSfdqaPEInSCYzKi2Pwbh4/olwCLE1Mgod5uALHqLUg+3nkjql8zzpEoks4Uggkw86bkY8uJmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755168127; c=relaxed/simple;
	bh=YDHXqww6lfzE+/9Ryw7hZXv56iPIOFxc3rgl9NiHkmQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=oOPbH+59itNbJdDfMVRBCRMFEIwxARa32wE5tmhC+vHuxGCrWhfjE06Ktm5+feaexTTN4jtKLIorZkTj4UVCwYc2e8U9mJiMjo17bAEZGCcEqn5SgSZs55uVneR37gAijOLNdCGhRjtfqaUNKpTWxE/dVnTPZyrii4CHlf1Z6Ck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PnHTTVHX; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-b4716f92a0aso477353a12.0;
        Thu, 14 Aug 2025 03:42:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755168125; x=1755772925; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=mfIPc5wFs9ZcYbXsfBo/Pj0Ll3AvI3my6jaZhninXLc=;
        b=PnHTTVHXoygAPa9D+bEbDHapUM2a1n76+mDjlwzixtXN+g95TsQq1aSiag7o7DjR/J
         EX7U3S5XcETvty1dFuYcn4EeQ8LlhU8OX/idK0IBmlHDhL3zMUQq+EZxlY66fcJq7JxK
         SVMcpTBHRXdNc0JzaUHL+KZ6tHTYjueujIEubzEMS6+igCzWZCb4M8kZ3JB3YBqhiw/u
         XJLrCrtQge2p3bY1N5uBeByZ2RnbPNCYteNReSYLN3Yp3WPyb5Ks9OIhBjCPRsu3UJNu
         l7N637AUtyuDa2kbGHSPhBD/PzqslvzIjwsI9kJ32yYwbYueagZ2Z12XSjWTJlP+C/uM
         n5RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755168125; x=1755772925;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mfIPc5wFs9ZcYbXsfBo/Pj0Ll3AvI3my6jaZhninXLc=;
        b=TqR4QJBd8kJ7FUXY2IvgaLVVQRt7CmDPP7Qe9CS0jG14Dlu2AR/VR7jMQ2mJ5Rb/F5
         5HiESAEQ3/vviM2vmQnZfONW43EZrS8cq8ytRFQFYgAOXqjSlJE+k/tHMcxhZWt3tX4r
         SfXYVQ6QGcn5bKAHyZ5c8VqZkcNBixauD3FHcvfrKfvOwakX2ayOytIqiRDweUXN4a6p
         Ah2nlGT/vnJfH4WT9IKN4Qzh01vuv/f+nIO4FkkGK/zv/HeLNbdzwlNTrYxGPaCLImJM
         DzhjPEZwi8qgEjqnyrzCPAaQ6vg4hR73qWh6R7WqySQDHujDxBJYH5bVJYF7DWxAedMd
         NXWg==
X-Forwarded-Encrypted: i=1; AJvYcCU6Y5zOqXjs/lC/uxXNz01kEPQacYeiq8rOmly+EfA76/fKbBkEfoGtbwejy97pRb+0I88FbRjIV4+v4meOPK0=@vger.kernel.org, AJvYcCUK2ub+TuJ07X4Thmw9kYZcV3AlnOoma4GEl2aTS3twVwyekNXbzNxDfKVlWs4ujwApdMX7sljLmSNgYk0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzqWxI/7s6l+4oCsMFYpmVwYGNhHh9MqO+S59EMU8CeUXdoxrq4
	cSuxHKt2P2rVyLN1CT0MY8vn0mTglo0M21IpXv5i3n7HB9S29lQ463Ev
X-Gm-Gg: ASbGncspflFCKIZKQbH4lGMN2VlGPsIwNS83nQ/2EpUCsNTHztde5V16QWf7enKPdNd
	GMIPUo9ogQYIr7Y2pZu4A43Ew/uWkNZRblKVWis/eIIrdqpQa3akvVjXk0woEJxRXD4Z+qvCkyA
	6JVoviBVEorpnONLW+6O4Bnk+Ur9dnGfsTAH42UDZvGxtt03qktTk8e1BMeu/oDpx+bXX5GjpmS
	RCXsfyk67z25tZuD9yb8w9I74nwivzg6ODjsXK5C7byhqWue4P61dEHsfnNcd1NxCojpI5LkoQl
	JC1XINtNrqsOuBt0VYy+ZDAHr6lY7KrDeh8EnjjsbURo+6p9QQAAoGcR8/ZqJq6raKsE20fZVWm
	zimiOfkP+mtiPwX7w/LFLWYaIwKwblV37WzcR
X-Google-Smtp-Source: AGHT+IF+FD/C7tiTBlSi+3uSUeTawLz1xv8qvuCNxcOudad3itQtv+P2EYotXfwWxkimINBB1H6zKg==
X-Received: by 2002:a17:903:1b48:b0:242:ff89:d724 with SMTP id d9443c01a7336-244586d1433mr38347175ad.47.1755168124911;
        Thu, 14 Aug 2025 03:42:04 -0700 (PDT)
Received: from shankari-IdeaPad.. ([103.24.60.31])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-241d1f0f7bfsm347762665ad.41.2025.08.14.03.41.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Aug 2025 03:42:04 -0700 (PDT)
From: Shankari Anand <shankari.ak0208@gmail.com>
To: Abdiel Janulgue <abdiel.janulgue@gmail.com>,
	Danilo Krummrich <dakr@kernel.org>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>
Cc: Daniel Almeida <daniel.almeida@collabora.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Trevor Gross <tmgross@umich.edu>,
	rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Shankari Anand <shankari.ak0208@gmail.com>
Subject: [PATCH] rust: dma: Update ARef and AlwaysRefCounted imports from sync::aref
Date: Thu, 14 Aug 2025 16:11:33 +0530
Message-Id: <20250814104133.350093-1-shankari.ak0208@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Update call sites in the dma subsystem to import `ARef` and
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

The original moving patch is here: (commit 07dad44aa9a93)
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=07dad44aa9a93b16af19e8609a10b241c352b440

Gradually the re-export from types.rs will be eliminated in the
future cycle.
---
 rust/kernel/dma.rs       | 2 +-
 samples/rust/rust_dma.rs | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/rust/kernel/dma.rs b/rust/kernel/dma.rs
index 2bc8ab51ec28..68fe67624424 100644
--- a/rust/kernel/dma.rs
+++ b/rust/kernel/dma.rs
@@ -9,8 +9,8 @@
     device::{Bound, Core},
     error::{to_result, Result},
     prelude::*,
+    sync::aref::ARef,
     transmute::{AsBytes, FromBytes},
-    types::ARef,
 };
 
 /// Trait to be implemented by DMA capable bus devices.
diff --git a/samples/rust/rust_dma.rs b/samples/rust/rust_dma.rs
index c5e7cce68654..997a9c4cf2b3 100644
--- a/samples/rust/rust_dma.rs
+++ b/samples/rust/rust_dma.rs
@@ -10,7 +10,7 @@
     dma::{CoherentAllocation, Device, DmaMask},
     pci,
     prelude::*,
-    types::ARef,
+    sync::aref::ARef,
 };
 
 struct DmaSampleDriver {

base-commit: 8f5ae30d69d7543eee0d70083daf4de8fe15d585
-- 
2.34.1


