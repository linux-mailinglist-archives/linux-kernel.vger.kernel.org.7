Return-Path: <linux-kernel+bounces-896906-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A466C5175E
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 10:51:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EAAEA188BFB3
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 09:50:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AD4930171D;
	Wed, 12 Nov 2025 09:49:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rUAqT5pM"
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 444B03009E2
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 09:49:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762940947; cv=none; b=awOBQnJ9lRqmbleY9gmm2p602YEUPkqdeoTrWpk5PRaT9usAuTt15HJGt7MJgkl6BmoAM5ynwZEN2hzpS0xweTj3rJDDeLeIuoXApZEpRSUX/8BLaj/U9bGuvcmVfSkH6xOZ9aaJHXh9LLNvDmWLJya41kiI1/lWHhfszNJYltM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762940947; c=relaxed/simple;
	bh=AGsD4T3gMNQ1KRT7lKUBBW6vxzfVxu5iKK8s0HzZNZs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=jlcdBwvWlBGHR40J7qvpY8wW/QfWYmTw99nLfdu64xgGXWN46EkJu8T7Bt+eJH7NPr23eOuKJp6wbfAe7WSd0e70HpCuKhftYY6nOz4orpyKguZVbMY0rR4DtAXQZtjXcFTtsXrEv+MD1FG4mwHaf4fu3dgyXPS8ET1a1zAbBJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rUAqT5pM; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-477632ce314so2960745e9.3
        for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 01:49:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762940943; x=1763545743; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=wJECfAsHB36DMhlozaEm+9VXAALH7iGzmi/xISCYeNI=;
        b=rUAqT5pMyCwuOG4m9EwLaTY63/aRSye4EJ+lUuyWGPec7VqABx0B4SEsQ/1MOt+fCn
         KZ5q+SL6OIixoPunu5jvYztx20Co8UT4mNY7BcqpFzUntCsbjZsRNHtk7lLIbYFZM2in
         Y9mC6DELuB0FwBaF2L8U8tDhVg08eyEtyq3Nj2zBqeGxX7cHDESLCfmRh3XZCATT2RnU
         0+2HbJbUye6Hmmw8mdNwzEBRLgWp7ceRss45M26wjOmRg95Mq095BOacIy3tzl64bnOb
         bu3TOw2U9tgZn6Uogh8+7xnxRaFCn30j4H2t+UufC1GRL9+pdvoHmr+3hBG1WgpcTfnD
         d5SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762940943; x=1763545743;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wJECfAsHB36DMhlozaEm+9VXAALH7iGzmi/xISCYeNI=;
        b=CEhp9HydFj3dKurt4hC5TEyocvBpvR2RprczydOFcUS+EL6NKeThlq36SDcDhA4fK/
         in3jf0JJo7zxmi3t6jDa90+y9y4oIhmAf73fh9C1Q+dCFlm/BLIwEyIOdrA+oEUxgxYF
         9OBSysxdv61TRyr1ZcMPkidtczLZYKMcyY/98MrAnKwFiWZ9CpUjari3OgoKdGiQ6kmI
         sHHlUbgJNA1Kz1h7NG5b8r+3ydzGjcsDARjZT9m/T5HCkqgfao3t8Kkxr6xJxE1p2YUv
         OhKN93bvAPkjj6FP5eCbppnFdqN0T+SdrxooO2GqmwqACfKPz+ZHbGgY9Qn1Zq01zUnp
         HsKQ==
X-Forwarded-Encrypted: i=1; AJvYcCWXSY2h+hGHD6EBWYQLeHYWnaJwH9FB9czIP+8ccClX4XWU+ewut+e0zgIFSUSgmrNw8fimmoUUpI2U8Ko=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywy7O3vV9F0FGSybRONlUV4c/Vs2zcEIuYKsKhhNfTLAB5Qbfp0
	N21Usr14zsub1ZgdR8wlqJafMGS0ELwIb8/Jd+HEj35S2hFOhOqxed9WAd1GVmQFbmp1PO4eD63
	LUDeNDsAxW5TNDeS6NQ==
X-Google-Smtp-Source: AGHT+IF9HsqU0y7NwTtXTx+f+JzAdVqRcmDlc5vqaSZf2ouip/K5EKW1gkmsBGd/TFgY8Ew6kQuhb/VV435aZMM=
X-Received: from wmin8.prod.google.com ([2002:a7b:cbc8:0:b0:477:561f:772c])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:4695:b0:477:5c45:8117 with SMTP id 5b1f17b1804b1-477871eb76cmr19894835e9.41.1762940943550;
 Wed, 12 Nov 2025 01:49:03 -0800 (PST)
Date: Wed, 12 Nov 2025 09:48:33 +0000
In-Reply-To: <20251112-resource-phys-typedefs-v2-0-538307384f82@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251112-resource-phys-typedefs-v2-0-538307384f82@google.com>
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=2368; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=AGsD4T3gMNQ1KRT7lKUBBW6vxzfVxu5iKK8s0HzZNZs=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBpFFgLPLvMiSe5A3WoV7ftpvtqc+RY0+RozAJ0o
 zyS7UQJDmiJAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCaRRYCwAKCRAEWL7uWMY5
 RswTD/9woGknvS2f4z6xYZAQn7MpVp5wLdcWesznjd5WYtQvbbhDlw4UVBl1SWosAwpGiJH3m0E
 6YAQQVSL11schJ0p+KF/hl6DbF/nS1WXRDltJZiWBmgxRcPt/O/4UrWjnKvMdA++IA8Ts0m0M5Z
 FUeI6PwIqk7seOkQhRUCqVNx/P+DKVFQ7VvO5IhUlP0H8oitTKpYLoaLo0bwZWg01q9KxBTezzn
 kb3Um/nnOq3+TExTgUaQmidiWZqaVOSVCsQaEWclJcpgplutf+vCni+7whpBUUFS/gO/UiYTBMl
 WuBaYsaUAZUecxZBkl2z3LSTIfPz5GN3GLqdpuUZS9i0vmPo+ktCwLf4S+N5STuPkbviVAP3S7N
 UJvG9Oqa0vJSUu5xoNUJjVqnKnt2lYiZrmr0gCj3dW4rKRliBFKb0laDikWdJChjj2l073xd1Ho
 71HGQPixcryaHEjQWPCZ5iLrK4RTYCLm6p2ioDrbgX8MDsmPZH36wUwryAUYI0FX32fqahDJd5/
 PrXFXA3gdUsVKSPKyDlMMOyGSeJfpAEaPEHHbn8LXnHG182SXjDT67nxQWBokpphc6804MqOpB4
 wNJbW7sozGHZkhaInUdxKOpCOF0cZFlJUMw8ZrqLDCf0Xb0lVz6NwUfKqeiTYvOZsqDLjmr4ZKh nuVnfQRy1Efi5nw==
X-Mailer: b4 0.14.2
Message-ID: <20251112-resource-phys-typedefs-v2-2-538307384f82@google.com>
Subject: [PATCH v2 2/4] rust: io: move ResourceSize to top-level io module
From: Alice Ryhl <aliceryhl@google.com>
To: Danilo Krummrich <dakr@kernel.org>, Daniel Almeida <daniel.almeida@collabora.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	"=?utf-8?q?Bj=C3=B6rn_Roy_Baron?=" <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, 
	Abdiel Janulgue <abdiel.janulgue@gmail.com>, Robin Murphy <robin.murphy@arm.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Alice Ryhl <aliceryhl@google.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="utf-8"

Resource sizes are a general concept for dealing with physical
addresses, and not specific to the Resource type, which is just one way
to access physical addresses. Thus, move the typedef to the io module.

Still keep a re-export under resource. This avoids this commit from
being a flag-day, but I also think it's a useful re-export in general so
that you can import

	use kernel::io::resource::{Resource, ResourceSize};

instead of having to write

	use kernel::io::{
	    resource::Resource,
	    ResourceSize,
	};

in the specific cases where you need ResourceSize because you are using
the Resource type. Therefore I think it makes sense to keep this
re-export indefinitely and it is *not* intended as a temporary re-export
for migration purposes.

Cc: stable@vger.kernel.org # for v6.18
Signed-off-by: Alice Ryhl <aliceryhl@google.com>
---
 rust/kernel/io.rs          | 6 ++++++
 rust/kernel/io/resource.rs | 6 +-----
 2 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/rust/kernel/io.rs b/rust/kernel/io.rs
index ee182b0b5452dfcc9891d46cc6cd84d0cf7cdae7..6465ea94e85d689aef1f9031a4a5cc9505b9af6e 100644
--- a/rust/kernel/io.rs
+++ b/rust/kernel/io.rs
@@ -13,6 +13,12 @@
 
 pub use resource::Resource;
 
+/// Resource Size type.
+///
+/// This is a type alias to either `u32` or `u64` depending on the config option
+/// `CONFIG_PHYS_ADDR_T_64BIT`, and it can be a u64 even on 32-bit architectures.
+pub type ResourceSize = bindings::resource_size_t;
+
 /// Raw representation of an MMIO region.
 ///
 /// By itself, the existence of an instance of this structure does not provide any guarantees that
diff --git a/rust/kernel/io/resource.rs b/rust/kernel/io/resource.rs
index 11b6bb9678b4e36603cc26fa2d6552c0a7e8276c..7fed41fc20307fa7ce230da4b7841743631c965e 100644
--- a/rust/kernel/io/resource.rs
+++ b/rust/kernel/io/resource.rs
@@ -12,11 +12,7 @@
 use crate::str::{CStr, CString};
 use crate::types::Opaque;
 
-/// Resource Size type.
-///
-/// This is a type alias to either `u32` or `u64` depending on the config option
-/// `CONFIG_PHYS_ADDR_T_64BIT`, and it can be a u64 even on 32-bit architectures.
-pub type ResourceSize = bindings::resource_size_t;
+pub use super::ResourceSize;
 
 /// A region allocated from a parent [`Resource`].
 ///

-- 
2.51.2.1041.gc1ab5b90ca-goog


