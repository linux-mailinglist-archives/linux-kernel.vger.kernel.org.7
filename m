Return-Path: <linux-kernel+bounces-734838-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 710ACB086FA
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 09:37:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BF5621A6756C
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 07:36:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92C91262FFF;
	Thu, 17 Jul 2025 07:31:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E1E8MUZ/"
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59C732505AA;
	Thu, 17 Jul 2025 07:31:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752737502; cv=none; b=jj7gYfHIiH7Ot2+YSCguUOcFf/xAj6YM2vYO/8UlTCiSTBJYrpwaKDzw6FGUbltH7vDVxLDQ2vsshgXMXRdBheaWJmOMaV2aFKjNRSLF3JcRHlSESWkiBEsM3c0PwB4LvuC02GY3FeDaxjpB+8M0bTxSf/ObBidJIooQhF9Sgjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752737502; c=relaxed/simple;
	bh=QHm2yWaTWYtvMy+u4Z3PskTRE1ZkHxEQbdTMExRi6Yc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ksaOS9ddLmHwY1I+WvEk6K+3UJ9cE88Xv9JOxjQoqXMFI0uNm2XZbaM8qU9blput3c8CgtIykd49/O4fZVh4/ReVs+LvGr8deJailqW3etbei5hOKbNiReMs5Fao14LWyPv//ephm8tMD7iiSXgER4wXdwcOuoFp7wfYqDkm7NY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E1E8MUZ/; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-235ea292956so5553335ad.1;
        Thu, 17 Jul 2025 00:31:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752737500; x=1753342300; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=aEHWKPvL9BsWl4HsE19k3rGKnmVSPNrb4udTO8b5iDY=;
        b=E1E8MUZ/k1roAT9f8HnvrvW5CEPBhI7eO3HZ2YENYGPGwCe+MDiw4v1a8YXJauhjVz
         yzhJCBzmCwpPQ+u9yyZHPH4O4TOPedzHUTNxR4xn4hFfpgmaHDoFLGJGgp/Y6Qqk7ZPm
         mmEkvB8cJuaw1bth+WMrYWDx+Br32dQ8y8rO9fy3SDkGTKwo5SWZRu/0JnQ96/0zLfLD
         wn9QsUvcJ2QOcIIihBHumv2i4uIJIDTfQujvOQKzCQEMF+zbb/6sU+n0cq3SwmTAbk5m
         XgRSlKDeniUVV74htGin4nT0HzQWNPaAYVLqboMAjnmu5HLJJGAxdwM7Y3AIJEsomshq
         Ncew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752737500; x=1753342300;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aEHWKPvL9BsWl4HsE19k3rGKnmVSPNrb4udTO8b5iDY=;
        b=MG6664zoV8+3vz900+MSvQyXmzkRBPSw3DMvZ7BxC5l9bMJvM1HWBs9wfvaZjaiNoN
         LB38136y9OncttzJABPwvhgA2Sv6Ajk7MxqjflXdywMVdRvAFQvwtvq0EuvDpAt7V4TZ
         sEgWbbnBv2rb8Vkidq54TiI+Dcb+fEqIKIuERO2lEUxZkdZfHNu1ZBxuKjn3LEurotel
         eqBT1OLjPJ8k3YFFbmHy82l1TspRQD6QmHoJkbmH+lat3djsWclOJsYO68iIp21d2jd8
         +lNU7I6eKceTvoTMIOjxeGwwHLzrDevgPMX/K7x5BO/JC5Z9xi82c3Arje4Ko5JSm8gm
         6ZKQ==
X-Forwarded-Encrypted: i=1; AJvYcCWXnGWQYvS/dul93SwaLYU8OYUDS8iHo3SJZzn2BE2/7f9Xkybp7Oipvc1kJvzB9pi/JNHgg3RP3X0s10HTnQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0T+zZGPoAhoemcdRRk6wKGyi5X3CRIMqzlnRFMPCIPLZmbHDb
	nJ5uFG05aEwoHi+2Svq7M1binjRm9U/Vl2KTq8dyG38qtoab+Xb/8AACF1/fzM0U
X-Gm-Gg: ASbGnctUUFNhbBtrvq2OGrHdohIZjVSOrBNsxvR3Fvffni/K8zANz83n9o6yz/FYuXa
	12oMpRRO/wEPHZUjgnCFpKfFxlpbkjg85wOS/32LpudD455+ASsGuRg14zGNInsB1Psfo2vMQI1
	0hSqTUwlHk9TuqwiuT5aLtJplLzXJH3I8IvcHfoxldgqeoeDSdHzTA3DT90YlN0fP5N1tOJxvNw
	8WVbW3iIKrg79Abpvs0vjexZAmOr0oBdybvc9gB4BFRuGq1tVBxMzupZO3ZrGVTGg1M3WpHbyse
	lFaID61lYkRghc0wasR3BzXB4+y1Z4VhKGrsiZBljlMrr3LlPRza93QcpntoIHI4N2gUrss/k+p
	HVQ0W5ZgAWa4c8fIRI/bY0cnSDTt7cg8Fp8zIxq8QVg==
X-Google-Smtp-Source: AGHT+IEM9hFS7RRi5xscGL304UngA15PaZsV2O7OSTiYraeOcwkv1Fh1mL89aHnTR/HWUrt2pvecZw==
X-Received: by 2002:a17:903:ace:b0:234:adce:3ebc with SMTP id d9443c01a7336-23e2578a8aemr92998545ad.52.1752737500222;
        Thu, 17 Jul 2025 00:31:40 -0700 (PDT)
Received: from shankari-IdeaPad.. ([2409:4080:e0f:ae0a:ee10:e231:d467:2ec0])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23de4286d8csm142743175ad.33.2025.07.17.00.31.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Jul 2025 00:31:39 -0700 (PDT)
From: Shankari Anand <shankari.ak0208@gmail.com>
To: linux-kernel@vger.kernel.org,
	rust-for-linux@vger.kernel.org
Cc: Abdiel Janulgue <abdiel.janulgue@gmail.com>,
	Danilo Krummrich <dakr@kernel.org>,
	Daniel Almeida <daniel.almeida@collabora.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Trevor Gross <tmgross@umich.edu>,
	Bjorn Helgaas <bhelgaas@google.com>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Shankari Anand <shankari.ak0208@gmail.com>
Subject: [PATCH 6/7] samples: rust: update ARef and AlwaysRefCounted imports from sync::aref
Date: Thu, 17 Jul 2025 13:01:08 +0530
Message-Id: <20250717073108.14943-1-shankari.ak0208@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Update call sites in samples to import `ARef` and
`AlwaysRefCounted` from `sync::aref` instead of `types`.

This aligns with the ongoing effort to move `ARef` and
`AlwaysRefCounted` to sync.

Suggested-by: Benno Lossin <lossin@kernel.org>
Link: https://github.com/Rust-for-Linux/linux/issues/1173
Signed-off-by: Shankari Anand <shankari.ak0208@gmail.com>
---
Its part of a subsystem-wise split series, as suggested in:
https://lore.kernel.org/rust-for-linux/CANiq72=NSRMV_6UxXVgkebmWmbgN4i=sfRszr-G+x3W5A4DYOg@mail.gmail.com/T/#u
This split series is intended to ease review and subsystem-level maintenance.

The original moving patch is here:
https://lore.kernel.org/rust-for-linux/DBCLH4WXYTJL.FDZ9B39OO3TY@kernel.org/T/#mb67fbddcd894665d6ec6b0854e37930dedab468b

Gradually the re-export from types.rs will be eliminated in the
future cycle.
---
 samples/rust/rust_dma.rs             | 2 +-
 samples/rust/rust_driver_pci.rs      | 2 +-
 samples/rust/rust_driver_platform.rs | 2 +-
 samples/rust/rust_misc_device.rs     | 3 +--
 4 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/samples/rust/rust_dma.rs b/samples/rust/rust_dma.rs
index 9e05d5c0cdae..4f080c912fb8 100644
--- a/samples/rust/rust_dma.rs
+++ b/samples/rust/rust_dma.rs
@@ -4,7 +4,7 @@
 //!
 //! To make this driver probe, QEMU must be run with `-device pci-testdev`.
 
-use kernel::{bindings, device::Core, dma::CoherentAllocation, pci, prelude::*, types::ARef};
+use kernel::{bindings, device::Core, dma::CoherentAllocation, pci, prelude::*, sync::aref::ARef};
 
 struct DmaSampleDriver {
     pdev: ARef<pci::Device>,
diff --git a/samples/rust/rust_driver_pci.rs b/samples/rust/rust_driver_pci.rs
index 15147e4401b2..adcdfbb57c6b 100644
--- a/samples/rust/rust_driver_pci.rs
+++ b/samples/rust/rust_driver_pci.rs
@@ -4,7 +4,7 @@
 //!
 //! To make this driver probe, QEMU must be run with `-device pci-testdev`.
 
-use kernel::{bindings, c_str, device::Core, devres::Devres, pci, prelude::*, types::ARef};
+use kernel::{bindings, c_str, device::Core, devres::Devres, pci, prelude::*, sync::aref::ARef};
 
 struct Regs;
 
diff --git a/samples/rust/rust_driver_platform.rs b/samples/rust/rust_driver_platform.rs
index 8b42b3cfb363..da7d0f3ae90d 100644
--- a/samples/rust/rust_driver_platform.rs
+++ b/samples/rust/rust_driver_platform.rs
@@ -2,7 +2,7 @@
 
 //! Rust Platform driver sample.
 
-use kernel::{c_str, device::Core, of, platform, prelude::*, types::ARef};
+use kernel::{c_str, device::Core, of, platform, prelude::*, sync::aref::ARef};
 
 struct SampleDriver {
     pdev: ARef<platform::Device>,
diff --git a/samples/rust/rust_misc_device.rs b/samples/rust/rust_misc_device.rs
index e7ab77448f75..911b9320d3c0 100644
--- a/samples/rust/rust_misc_device.rs
+++ b/samples/rust/rust_misc_device.rs
@@ -105,8 +105,7 @@
     miscdevice::{MiscDevice, MiscDeviceOptions, MiscDeviceRegistration},
     new_mutex,
     prelude::*,
-    sync::Mutex,
-    types::ARef,
+    sync::{aref::ARef, Mutex},
     uaccess::{UserSlice, UserSliceReader, UserSliceWriter},
 };
 
base-commit: 8ecb65b7b68ea48350833ba59c1257718e859768
-- 
2.34.1


