Return-Path: <linux-kernel+bounces-771737-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A26BB28AE0
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Aug 2025 07:58:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8EE38B63DEE
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Aug 2025 05:57:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E0B41FBCAD;
	Sat, 16 Aug 2025 05:58:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=beagleboard-org.20230601.gappssmtp.com header.i=@beagleboard-org.20230601.gappssmtp.com header.b="2ec35vfY"
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E02261F419A
	for <linux-kernel@vger.kernel.org>; Sat, 16 Aug 2025 05:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755323901; cv=none; b=Cb0rEa8dPGXZkWE14ZbE5WJ6MRl2M2tPOii6OcGn9ASjqqaL1ub/Bulf+pTW7wYqfgeWe/3xnU6MNM+HiB2XrWK3qXXAhaZlPctT31fh3SddQZdqGwt1OobR6AaJlGwGYD/8lUgnkY/BNdC/9yXk5CDC4B9CutnnGpL2vquPzr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755323901; c=relaxed/simple;
	bh=Yr2juqHcjwAX7V6XPlZ5OUKAynUfQSZf7AeKvSLuCbk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=G/cEXHPdNQsvPrpMZbl4FI+EroOr3m9iWMg99Nkx8mGfj5Wwz5dO/apciSMeBN1G9ZwzMjqAbV+fSYZ/pvtH4uGVz6Q0HkGnYyai4EXAOmV6/Oxq/RlECfL6bd42VuYFYyLqssEeI8rcEzujXR6e6YkzdAzMTjonjNWGZVrKqg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=beagleboard.org; spf=fail smtp.mailfrom=beagleboard.org; dkim=pass (2048-bit key) header.d=beagleboard-org.20230601.gappssmtp.com header.i=@beagleboard-org.20230601.gappssmtp.com header.b=2ec35vfY; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=beagleboard.org
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=beagleboard.org
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-b472fd93ad1so728512a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 22:58:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=beagleboard-org.20230601.gappssmtp.com; s=20230601; t=1755323899; x=1755928699; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pGYJRlLAfDDQFgIHtOvKA7K9FZv3AyePi0bo+Jt7ZUk=;
        b=2ec35vfYrtA2GtCATHnGm9p4HEtOCEN1n92l256v9/drtUuSidEdA56Iq9FWpWCHjj
         q5ldAYohtMDbf9tDzfvj168fQTXhuL4JClNOHqBObEktV8iRlell1fyJEGhINHBoonYQ
         0nUi8BRaICnOvp6KVLwKun3DBFxR/d2sPgC00py6J2GMxUjJliAC6O8c14RM1RH5kRWL
         dDwS6F1+yvkznhpTbzqaSCbIUICKAteNS1QAzE1FiOaziOmz86YDQqFw60LaruVfKacs
         VzsTOCxv/qrhzAOAXRstoA7TfKSi9glHWxGOiaR0jn5sNb+LWgVFJRprCsURKXvW0DJ/
         lNDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755323899; x=1755928699;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pGYJRlLAfDDQFgIHtOvKA7K9FZv3AyePi0bo+Jt7ZUk=;
        b=lmXTZDkwNlEkEfiPXw3tcMbs2XoVu8KPhJwm4Sjfl+Zanobmeo59aAO3Ce6a+/Bc5n
         NHlii3N73q+AeG6m81CK8apYB6Wq/zAyxJmNbC8PXzekHAMCqYmtDp1CFpP15Gl1AkRn
         HonMfDgNh+U/EFvN9Z3rPPbGL9XnesLR41WDXy/pnqpSgYWP7BFKUQhblFPWehfpId7G
         JkxFDvxVRz4QSrWTrzSXMUxUBEIiUpVRTcaDliTRgAYFgo1YH0yj0AvdFm36U4FnfmYE
         VbMCCKziN7DhG15TFbyz7Uow4coOELzyL/EnoY5wTwKHp1ZBh3aTXmm6em4aubCV8HAr
         wOwA==
X-Forwarded-Encrypted: i=1; AJvYcCXZX+wHy1r/gYvb25Hc3/8SqchXYaKObDgFsqKD4agappU1MssXn7qubLS6T6l0ksFvJB/MIe8HbAgxeQM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwjIRwEQ+4DF4PSaZEMtGrfykCEHj3Q+N9Rj1ttEfe183WQBlcZ
	xXlg/JP1EAlIz55d5ghfnnu6vfw3mJPyvgrSeT4V+WaEi7URJg+OR4CAXAut3TcH2g==
X-Gm-Gg: ASbGncuqfTLrzxmp7U5Le/8cTKLQ7n0DT98OwwjxaIfE/0WguZoE1pjrOMscor8KBlO
	Tk1uIPak+I5JpF8oZ2egkmlYyTNBmeUNslZjFtgQy9QKcAL9reRl0FX0uNbhVegd5sjpoIW6BID
	6th7V2hDW2gFvSe+J+I7wbayOd3UfrrDoDmjXM3UKixl1oMnkNKD2FaodYPkF07vrI4ONxgip6W
	iklAI+k4NmWruql2U1QGJuAx7xj+a97azNMEBlmNvRgEyIzO3yuWshBQ2IVCjaKa4u/CyVjUpTD
	TU9sDZ2g0tIhBVMOLYVt8WD3e4eK38eyS/7t8LcaOtW64UGQiiWdsUniPXVZCouYHqpXidspCf3
	DL0UOa3hneEyjuDKocCAAaQaBue0J0Rw=
X-Google-Smtp-Source: AGHT+IECwErrJ72ldcH9XIsu07xOQeo3Hd9BNXnDurpEsGAP40OkZM+rhGLLoDKMSuhI4NsIH7rntg==
X-Received: by 2002:a17:902:d587:b0:240:3b9e:dd4c with SMTP id d9443c01a7336-2447900cfb3mr22388405ad.36.1755323899247;
        Fri, 15 Aug 2025 22:58:19 -0700 (PDT)
Received: from [192.168.1.9] ([2401:4900:8899:e205:7ddd:6d95:7c30:9bd3])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2446cb0a0a7sm28328245ad.65.2025.08.15.22.58.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Aug 2025 22:58:18 -0700 (PDT)
From: Ayush Singh <ayush@beagleboard.org>
Date: Sat, 16 Aug 2025 11:27:45 +0530
Subject: [PATCH v2 1/2] rust: kernel: of: Add DeviceNode abstraction
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250816-rust-overlay-abs-v2-1-48a2c8921df2@beagleboard.org>
References: <20250816-rust-overlay-abs-v2-0-48a2c8921df2@beagleboard.org>
In-Reply-To: <20250816-rust-overlay-abs-v2-0-48a2c8921df2@beagleboard.org>
To: Jason Kridner <jkridner@beagleboard.org>, 
 Deepak Khatri <lorforlinux@beagleboard.org>, 
 Robert Nelson <robertcnelson@beagleboard.org>, 
 Miguel Ojeda <ojeda@kernel.org>, Dhruva Gole <d-gole@ti.com>, 
 Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
 Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, Rob Herring <robh@kernel.org>, 
 Saravana Kannan <saravanak@google.com>, Benno Lossin <lossin@kernel.org>, 
 Benno Lossin <lossin@kernel.org>
Cc: rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, Ayush Singh <ayush@beagleboard.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3553; i=ayush@beagleboard.org;
 h=from:subject:message-id; bh=Yr2juqHcjwAX7V6XPlZ5OUKAynUfQSZf7AeKvSLuCbk=;
 b=owEBbQKS/ZANAwAKAQXO9ceJ5Vp0AcsmYgBooB3tm1FR2wzC3Tr3tawFGHveDicVohBvuue/f
 nQ9xyG5YRKJAjMEAAEKAB0WIQTfzBMe8k8tZW+lBNYFzvXHieVadAUCaKAd7QAKCRAFzvXHieVa
 dD0xD/wL3+Y/JbGH7Gd6yo2Hpb+9ULrOksiq/Y9T3498ZMUlV8lLfde0FJboUitzR6bBrGs3OFc
 XLdrUFkui6sJ+loOj/QKKscvspVQsZhepwSx63vRQ5fe6lLQJRIdCuB0vpblRd0FTPNTj+thw2p
 d809746/fZR72TlwhQjmPemj064YuPuF3zNlDcYqkXL8tvczXCXKX2S3WZ7J4QduY5elXJUfoY5
 HQShvB6BSaPzb1SWBqERgta9YdFJQpzHgaSahKs7ddyLnimfm8rIe1CjTrjxxdXeGXiYj6KnaMZ
 gCASyPzO9/E2Q7VWNIZoS2Dpem226PMA3YKSsJ/VDJJiu0meYOUIwfFsZ6dUwkA7Uq/qcUXkqsK
 jQunuJ4MVqysGTLXXrYXRNcf9PqpL0wWrdnoC4KRA8cZRN8Bd+BoiKj8QEUYjnzsRRhXaxCC5mY
 FTcL1fHmua7fhqCSVVMehwb0mvPYig4d8LehaCGPCBOp8G1KpCPHkZV69mXQTGa2VlPc7ruK8t4
 aShxxdW+9ueQJ3CElBEgi8yZ9uQZs5fwJmDr7zXPi4yHMGuyUzwvX4mSMLe84bV+NvCAhGRfRDy
 3knZA3zf1uCp9uEdLQUdu2viZB616RVIJnf8vP0ScFGxpmmNFuZp3qzc6zdgERnfYI6KBGwRijY
 EArbQXO79vcVeIg==
X-Developer-Key: i=ayush@beagleboard.org; a=openpgp;
 fpr=DFCC131EF24F2D656FA504D605CEF5C789E55A74

Allow getting struct device_node from struct fwnode_handle. This is
required when applying devicetree overlays using the
`of_overlay_fdt_apply`.

Signed-off-by: Ayush Singh <ayush@beagleboard.org>
---
 rust/bindings/bindings_helper.h |  1 +
 rust/helpers/of.c               |  5 +++++
 rust/kernel/device/property.rs  | 18 ++++++++++++++++++
 rust/kernel/of.rs               | 12 ++++++++++++
 4 files changed, 36 insertions(+)

diff --git a/rust/bindings/bindings_helper.h b/rust/bindings/bindings_helper.h
index 84d60635e8a9baef1f1a1b2752dc0fa044f8542f..f35764bf28647f6d567afcbe073c37b30a3b0284 100644
--- a/rust/bindings/bindings_helper.h
+++ b/rust/bindings/bindings_helper.h
@@ -58,6 +58,7 @@
 #include <linux/jump_label.h>
 #include <linux/mdio.h>
 #include <linux/miscdevice.h>
+#include <linux/of.h>
 #include <linux/of_device.h>
 #include <linux/pci.h>
 #include <linux/phy.h>
diff --git a/rust/helpers/of.c b/rust/helpers/of.c
index 86b51167c913f96b626e55adb51bdac2a9f04f56..fba7a26dfd45a6d4350aa2a3e5b43ddbcd1b2c70 100644
--- a/rust/helpers/of.c
+++ b/rust/helpers/of.c
@@ -6,3 +6,8 @@ bool rust_helper_is_of_node(const struct fwnode_handle *fwnode)
 {
 	return is_of_node(fwnode);
 }
+
+struct device_node *rust_helper_to_of_node(const struct fwnode_handle *fwnode)
+{
+	return to_of_node(fwnode);
+}
diff --git a/rust/kernel/device/property.rs b/rust/kernel/device/property.rs
index 49ee12a906dbadbe932e207fc7a0d1d622125f5f..e19c1aebd5d5a7f0eedf8ef264d36b943eaf1fc5 100644
--- a/rust/kernel/device/property.rs
+++ b/rust/kernel/device/property.rs
@@ -68,6 +68,24 @@ pub fn is_of_node(&self) -> bool {
         unsafe { bindings::is_of_node(self.as_raw()) }
     }
 
+    /// Returns `DeviceNode` if `&self` is an OF node.
+    pub fn to_of_node(&self) -> Option<&crate::of::DeviceNode> {
+        // SAFETY: The type invariant of `Self` guarantees that `self.as_raw() is a pointer to a
+        // valid `struct fwnode_handle`.
+        let of_node = unsafe { bindings::to_of_node(self.as_raw()) };
+
+        if of_node.is_null() {
+            None
+        } else {
+            // SAFETY: `of_node` is valid. Its lifetime is tied to `&self`. We
+            // return a reference instead of an `ARef<DeviceNode>` because `to_of_node()`
+            // doesn't increment the refcount. It is safe to cast from a
+            // `struct device_node*` to a `*const DeviceNode` because `DeviceNode` is
+            // defined as a `#[repr(transparent)]` wrapper around `device_node`.
+            Some(unsafe { &*of_node.cast() })
+        }
+    }
+
     /// Returns an object that implements [`Display`](core::fmt::Display) for
     /// printing the name of a node.
     ///
diff --git a/rust/kernel/of.rs b/rust/kernel/of.rs
index b76b35265df2ea6b8b6dcf3d3dab5519d6092bf9..74d42dce06f0e9f67a0e5bd1287117b4966d4af9 100644
--- a/rust/kernel/of.rs
+++ b/rust/kernel/of.rs
@@ -6,6 +6,7 @@
     bindings,
     device_id::{RawDeviceId, RawDeviceIdIndex},
     prelude::*,
+    types::Opaque
 };
 
 /// IdTable type for OF drivers.
@@ -63,3 +64,14 @@ macro_rules! of_device_table {
         $crate::module_device_table!("of", $module_table_name, $table_name);
     };
 }
+
+/// Devicetree device node
+#[repr(transparent)]
+pub struct DeviceNode(Opaque<bindings::device_node>);
+
+impl DeviceNode {
+    /// Obtain the raw `struct device_node *`.
+    pub fn as_raw(&self) -> *mut bindings::device_node {
+        self.0.get()
+    }
+}

-- 
2.50.1


