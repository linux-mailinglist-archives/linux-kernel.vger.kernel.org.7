Return-Path: <linux-kernel+bounces-627648-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 88F5CAA5368
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Apr 2025 20:13:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 56AEF9C0780
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Apr 2025 18:12:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AA5A27A129;
	Wed, 30 Apr 2025 18:11:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="Uyv7PWya"
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31E0B2749CA
	for <linux-kernel@vger.kernel.org>; Wed, 30 Apr 2025 18:11:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746036672; cv=none; b=W0LJhD4iDnFGqYoJbIyLZoKDucRbuOq41mwuiW3VoqN5hGLhyxvmG7NQxe/3NWe+n5O1U1j5aStl6b/JcqjpwNIn9Qkya+BnSfZiuolIj+X+Fkq47X3tobD4IA6ijYfsamaFjnPYTdD+mv/NrRTsIiEvNx5YbQ+ecszNICGDzU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746036672; c=relaxed/simple;
	bh=bMXlR3kt9skr+e9ELWUswYfD9xPZ2tPfw1ObAbC8KUc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QEUieirCa22iWgQxwWJGAYibTnNgozMuWMosh4p3KhwzEBhKw3EvL0bW6u54mDoLJ0fA/NV3EDPRlZ5qhaFam1g/kpApg3qPQOiWbq/6i+KylZTQEt8AF3H6j1KJzAvg9s3rG87CuAfEKhFbBBr/KCTq+rVihVnM74Jqn4fzUto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=Uyv7PWya; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-47664364628so2283191cf.1
        for <linux-kernel@vger.kernel.org>; Wed, 30 Apr 2025 11:11:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1746036668; x=1746641468; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QuUPWWLzKmYqWhInWYNc7CiuufhIISijzghWvAw6RtM=;
        b=Uyv7PWyaAi78kHmlSyvADm5QjadUKCiAVBUhPg8dkBkzJ29ungrtK7wkLzXIWYdcul
         7fKzQKQcAgMOaaUof+VHjASoT6WUl0iUmOk0Ej2Ti6ex+E8rQ1oO71mxeXZlNIh6+cHT
         pvI8scHPZEo4FnTox9XW7CaMBz32ujpMViUes9AWsylOHjsrQBTJkgDjCQr5IL5er1V7
         Qovifsh2LVgfvofhj9vIJNJQGaGrfVVKTcrP2GSlaNLZee1PiMoHSfsqv/8V35uolSJ1
         +aGkggL62IjOWxjmr0w1UAng+OGpIdoYSvKrsO/hee2FB3+AbNF9RXOw0XFVRr86LCif
         vpDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746036668; x=1746641468;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QuUPWWLzKmYqWhInWYNc7CiuufhIISijzghWvAw6RtM=;
        b=PlA5NehNLP87u/eEl0+6NPoY10WL0ZM1Pihq2CRHHcMGEUAb05RZJft0S6ZEL9Ywna
         seDtwzsW8seGWJ6MpZAa/OoZTwjqBESX0q47M2sF0zur+a7uWw+d42RYrq6wCjixeU6R
         IuYk3szhQHOk2+HYHQ7xXloOXfT0RoMJJ9y3gTOTLyzwc7+UbeSJ0Bs7fjF1VUCGC0pn
         kn++wjnYAsOCbKE90AP5tRIt59FC9CqosHbayxqzaPZw07oBbif4lilymbsNgmgaxb3+
         +yETONot5proO6Yi3wknrcdewvCkScm50mf3UvVHIp4YI1ZcJVcPy5qdNP3Py3Hh+kWk
         uYyQ==
X-Forwarded-Encrypted: i=1; AJvYcCU/uxKscMK/AOWMldU8LQXQ6JfU7p8fiCKsPIpDFuIDaN1mIHgeaH82meQOl+RRAuB/Kz+u32udOnGnSXk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxA6YUZtKtpa9GuFZhJZ2zk1aqHwQfJmFsR3eBfLQP1lePdsBc+
	3Ala8ZJdTF3ZoQT5cga21uycbj0SoCMMiFQo6TjUMs+YAcNNQZWpiLAND7Ezv+4=
X-Gm-Gg: ASbGncuW+k79UP3FOrHVgbvOa+Ivd9ciLpeQ99TTnjC/aJ9mBZC42DsJHQU5+5kImSn
	kxhGRO0AwMurj2l3hQVhXnH0r2KoCwsox1aDGWKwbWpulmEDGkMvOfB5Dk4k8+zm8nWeKQ3nlC9
	QWmQErjGVSRXnziDGo432dnGAmIiZrWBgtcWaTRNZ8GGYImuLUaIhAYuO86Wp4M7EQkYGpljZGC
	nUW7q8NhJZb3WD4tS43Bdfre2YsfGz2pcJ/CpDETCRAMj0kuYShEAwmMoyC94cLvGIumYqxm/Cm
	cuL2daCZ5/AgQ0APH30+QMfOyYME4RHdeRwivpq5NW4otIO9ezi/2DJ4OxrDnA6HqdiVJ0AVpDR
	H/+Wa3SfTxazRTYmrX1vhGemavU5o12yC975xQ5c=
X-Google-Smtp-Source: AGHT+IEaZIWXv6Bvielxfh+difKI8YG5mPgBV8OQe/8x1U7+Bv7PmZBhST/VtgsnHh0AUwspKKCAzw==
X-Received: by 2002:ac8:6f0a:0:b0:47c:67b5:73da with SMTP id d75a77b69052e-48ad879b665mr6405971cf.13.1746036667977;
        Wed, 30 Apr 2025 11:11:07 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F.lan (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-48a64fe04efsm5897421cf.19.2025.04.30.11.11.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Apr 2025 11:11:07 -0700 (PDT)
From: Gregory Price <gourry@gourry.net>
To: linux-cxl@vger.kernel.org
Cc: linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	dave@stgolabs.net,
	jonathan.cameron@huawei.com,
	dave.jiang@intel.com,
	alison.schofield@intel.com,
	vishal.l.verma@intel.com,
	ira.weiny@intel.com,
	dan.j.williams@intel.com,
	corbet@lwn.net
Subject: [RFC PATCH v2 05/18] cxl: docs/platform/example-configs documentation
Date: Wed, 30 Apr 2025 14:10:35 -0400
Message-ID: <20250430181048.1197475-6-gourry@gourry.net>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250430181048.1197475-1-gourry@gourry.net>
References: <20250430181048.1197475-1-gourry@gourry.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add example ACPI Table configurations for different sample platforms.

Signed-off-by: Gregory Price <gourry@gourry.net>
---
 Documentation/driver-api/cxl/index.rst        |   1 +
 .../cxl/platform/example-configs.rst          |  13 +
 .../example-configurations/flexible.rst       | 296 ++++++++++++++++++
 .../example-configurations/hb-interleave.rst  | 107 +++++++
 .../multi-dev-per-hb.rst                      |  90 ++++++
 .../example-configurations/one-dev-per-hb.rst | 136 ++++++++
 6 files changed, 643 insertions(+)
 create mode 100644 Documentation/driver-api/cxl/platform/example-configs.rst
 create mode 100644 Documentation/driver-api/cxl/platform/example-configurations/flexible.rst
 create mode 100644 Documentation/driver-api/cxl/platform/example-configurations/hb-interleave.rst
 create mode 100644 Documentation/driver-api/cxl/platform/example-configurations/multi-dev-per-hb.rst
 create mode 100644 Documentation/driver-api/cxl/platform/example-configurations/one-dev-per-hb.rst

diff --git a/Documentation/driver-api/cxl/index.rst b/Documentation/driver-api/cxl/index.rst
index 5e5699803d4c..5fa66e668b49 100644
--- a/Documentation/driver-api/cxl/index.rst
+++ b/Documentation/driver-api/cxl/index.rst
@@ -28,6 +28,7 @@ that have impacts on each other.  The docs here break up configurations steps.
 
    platform/bios-and-efi
    platform/acpi
+   platform/example-configs
 
 .. toctree::
    :maxdepth: 1
diff --git a/Documentation/driver-api/cxl/platform/example-configs.rst b/Documentation/driver-api/cxl/platform/example-configs.rst
new file mode 100644
index 000000000000..90a10d7473c6
--- /dev/null
+++ b/Documentation/driver-api/cxl/platform/example-configs.rst
@@ -0,0 +1,13 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+Example Platform Configurations
+###############################
+
+.. toctree::
+   :maxdepth: 1
+   :caption: Contents
+
+   example-configurations/one-dev-per-hb.rst
+   example-configurations/multi-dev-per-hb.rst
+   example-configurations/hb-interleave.rst
+   example-configurations/flexible.rst
diff --git a/Documentation/driver-api/cxl/platform/example-configurations/flexible.rst b/Documentation/driver-api/cxl/platform/example-configurations/flexible.rst
new file mode 100644
index 000000000000..13a97c03e25a
--- /dev/null
+++ b/Documentation/driver-api/cxl/platform/example-configurations/flexible.rst
@@ -0,0 +1,296 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+=====================
+Flexible Presentation
+=====================
+This system has a single socket with two CXL host bridges. Each host bridge
+has two CXL memory expanders with a 4GB of memory (32GB total).
+
+On this system, the platform designer wanted to provide the user flexibility
+to configure the memory devices in various interleave or NUMA node
+configurations.  So they provided every combination.
+
+Things to note:
+
+* Cross-Bridge interleave is described in one CFMWS that covers all capacity.
+* One CFMWS is also described per-host bridge.
+* One CFMWS is also described per-device.
+* This SRAT describes one-node for each of the above CFMWS.
+* The HMAT describes performance for each node in the SRAT.
+
+CEDT ::
+
+            Subtable Type : 00 [CXL Host Bridge Structure]
+                 Reserved : 00
+                   Length : 0020
+   Associated host bridge : 00000007
+    Specification version : 00000001
+                 Reserved : 00000000
+            Register base : 0000010370400000
+          Register length : 0000000000010000
+
+            Subtable Type : 00 [CXL Host Bridge Structure]
+                 Reserved : 00
+                   Length : 0020
+   Associated host bridge : 00000006
+    Specification version : 00000001
+                 Reserved : 00000000
+            Register base : 0000010380800000
+          Register length : 0000000000010000
+
+            Subtable Type : 01 [CXL Fixed Memory Window Structure]
+                 Reserved : 00
+                   Length : 002C
+                 Reserved : 00000000
+      Window base address : 0000001000000000
+              Window size : 0000000400000000
+ Interleave Members (2^n) : 01
+    Interleave Arithmetic : 00
+                 Reserved : 0000
+              Granularity : 00000000
+             Restrictions : 0006
+                    QtgId : 0001
+             First Target : 00000007
+            Second Target : 00000006
+
+            Subtable Type : 01 [CXL Fixed Memory Window Structure]
+                 Reserved : 00
+                   Length : 002C
+                 Reserved : 00000000
+      Window base address : 0000002000000000
+              Window size : 0000000200000000
+ Interleave Members (2^n) : 00
+    Interleave Arithmetic : 00
+                 Reserved : 0000
+              Granularity : 00000000
+             Restrictions : 0006
+                    QtgId : 0001
+             First Target : 00000007
+
+            Subtable Type : 01 [CXL Fixed Memory Window Structure]
+                 Reserved : 00
+                   Length : 002C
+                 Reserved : 00000000
+      Window base address : 0000002200000000
+              Window size : 0000000200000000
+ Interleave Members (2^n) : 00
+    Interleave Arithmetic : 00
+                 Reserved : 0000
+              Granularity : 00000000
+             Restrictions : 0006
+                    QtgId : 0001
+             First Target : 00000006
+
+            Subtable Type : 01 [CXL Fixed Memory Window Structure]
+                 Reserved : 00
+                   Length : 002C
+                 Reserved : 00000000
+      Window base address : 0000003000000000
+              Window size : 0000000100000000
+ Interleave Members (2^n) : 00
+    Interleave Arithmetic : 00
+                 Reserved : 0000
+              Granularity : 00000000
+             Restrictions : 0006
+                    QtgId : 0001
+             First Target : 00000007
+
+            Subtable Type : 01 [CXL Fixed Memory Window Structure]
+                 Reserved : 00
+                   Length : 002C
+                 Reserved : 00000000
+      Window base address : 0000003100000000
+              Window size : 0000000100000000
+ Interleave Members (2^n) : 00
+    Interleave Arithmetic : 00
+                 Reserved : 0000
+              Granularity : 00000000
+             Restrictions : 0006
+                    QtgId : 0001
+             First Target : 00000007
+
+            Subtable Type : 01 [CXL Fixed Memory Window Structure]
+                 Reserved : 00
+                   Length : 002C
+                 Reserved : 00000000
+      Window base address : 0000003200000000
+              Window size : 0000000100000000
+ Interleave Members (2^n) : 00
+    Interleave Arithmetic : 00
+                 Reserved : 0000
+              Granularity : 00000000
+             Restrictions : 0006
+                    QtgId : 0001
+             First Target : 00000006
+
+            Subtable Type : 01 [CXL Fixed Memory Window Structure]
+                 Reserved : 00
+                   Length : 002C
+                 Reserved : 00000000
+      Window base address : 0000003300000000
+              Window size : 0000000100000000
+ Interleave Members (2^n) : 00
+    Interleave Arithmetic : 00
+                 Reserved : 0000
+              Granularity : 00000000
+             Restrictions : 0006
+                    QtgId : 0001
+             First Target : 00000006
+
+SRAT ::
+
+         Subtable Type : 01 [Memory Affinity]
+                Length : 28
+      Proximity Domain : 00000001
+             Reserved1 : 0000
+          Base Address : 0000001000000000
+        Address Length : 0000000400000000
+             Reserved2 : 00000000
+ Flags (decoded below) : 0000000B
+             Enabled : 1
+       Hot Pluggable : 1
+        Non-Volatile : 0
+
+         Subtable Type : 01 [Memory Affinity]
+                Length : 28
+      Proximity Domain : 00000002
+             Reserved1 : 0000
+          Base Address : 0000002000000000
+        Address Length : 0000000200000000
+             Reserved2 : 00000000
+ Flags (decoded below) : 0000000B
+             Enabled : 1
+       Hot Pluggable : 1
+        Non-Volatile : 0
+
+         Subtable Type : 01 [Memory Affinity]
+                Length : 28
+      Proximity Domain : 00000003
+             Reserved1 : 0000
+          Base Address : 0000002200000000
+        Address Length : 0000000200000000
+             Reserved2 : 00000000
+ Flags (decoded below) : 0000000B
+             Enabled : 1
+       Hot Pluggable : 1
+        Non-Volatile : 0
+
+         Subtable Type : 01 [Memory Affinity]
+                Length : 28
+      Proximity Domain : 00000004
+             Reserved1 : 0000
+          Base Address : 0000003000000000
+        Address Length : 0000000100000000
+             Reserved2 : 00000000
+ Flags (decoded below) : 0000000B
+             Enabled : 1
+       Hot Pluggable : 1
+        Non-Volatile : 0
+
+         Subtable Type : 01 [Memory Affinity]
+                Length : 28
+      Proximity Domain : 00000005
+             Reserved1 : 0000
+          Base Address : 0000003100000000
+        Address Length : 0000000100000000
+             Reserved2 : 00000000
+ Flags (decoded below) : 0000000B
+             Enabled : 1
+       Hot Pluggable : 1
+        Non-Volatile : 0
+
+         Subtable Type : 01 [Memory Affinity]
+                Length : 28
+      Proximity Domain : 00000006
+             Reserved1 : 0000
+          Base Address : 0000003200000000
+        Address Length : 0000000100000000
+             Reserved2 : 00000000
+ Flags (decoded below) : 0000000B
+             Enabled : 1
+       Hot Pluggable : 1
+        Non-Volatile : 0
+
+         Subtable Type : 01 [Memory Affinity]
+                Length : 28
+      Proximity Domain : 00000007
+             Reserved1 : 0000
+          Base Address : 0000003300000000
+        Address Length : 0000000100000000
+             Reserved2 : 00000000
+ Flags (decoded below) : 0000000B
+             Enabled : 1
+       Hot Pluggable : 1
+        Non-Volatile : 0
+
+HMAT ::
+
+               Structure Type : 0001 [SLLBI]
+                    Data Type : 00   [Latency]
+ Target Proximity Domain List : 00000000
+ Target Proximity Domain List : 00000001
+ Target Proximity Domain List : 00000002
+ Target Proximity Domain List : 00000003
+ Target Proximity Domain List : 00000004
+ Target Proximity Domain List : 00000005
+ Target Proximity Domain List : 00000006
+ Target Proximity Domain List : 00000007
+                        Entry : 0080
+                        Entry : 0100
+                        Entry : 0100
+                        Entry : 0100
+                        Entry : 0100
+                        Entry : 0100
+                        Entry : 0100
+                        Entry : 0100
+
+               Structure Type : 0001 [SLLBI]
+                    Data Type : 03   [Bandwidth]
+ Target Proximity Domain List : 00000000
+ Target Proximity Domain List : 00000001
+ Target Proximity Domain List : 00000002
+ Target Proximity Domain List : 00000003
+ Target Proximity Domain List : 00000004
+ Target Proximity Domain List : 00000005
+ Target Proximity Domain List : 00000006
+ Target Proximity Domain List : 00000007
+                        Entry : 1200
+                        Entry : 0400
+                        Entry : 0200
+                        Entry : 0200
+                        Entry : 0100
+                        Entry : 0100
+                        Entry : 0100
+                        Entry : 0100
+
+SLIT ::
+
+     Signature : "SLIT"    [System Locality Information Table]
+    Localities : 0000000000000003
+  Locality   0 : 10 20 20 20 20 20 20 20
+  Locality   1 : FF 0A FF FF FF FF FF FF
+  Locality   2 : FF FF 0A FF FF FF FF FF
+  Locality   3 : FF FF FF 0A FF FF FF FF
+  Locality   4 : FF FF FF FF 0A FF FF FF
+  Locality   5 : FF FF FF FF FF 0A FF FF
+  Locality   6 : FF FF FF FF FF FF 0A FF
+  Locality   7 : FF FF FF FF FF FF FF 0A
+
+DSDT ::
+
+  Scope (_SB)
+  {
+    Device (S0D0)
+    {
+        Name (_HID, "ACPI0016" /* Compute Express Link Host Bridge */)  // _HID: Hardware ID
+        ...
+        Name (_UID, 0x07)  // _UID: Unique ID
+    }
+    ...
+    Device (S0D5)
+    {
+        Name (_HID, "ACPI0016" /* Compute Express Link Host Bridge */)  // _HID: Hardware ID
+        ...
+        Name (_UID, 0x06)  // _UID: Unique ID
+    }
+  }
diff --git a/Documentation/driver-api/cxl/platform/example-configurations/hb-interleave.rst b/Documentation/driver-api/cxl/platform/example-configurations/hb-interleave.rst
new file mode 100644
index 000000000000..fa0885d82deb
--- /dev/null
+++ b/Documentation/driver-api/cxl/platform/example-configurations/hb-interleave.rst
@@ -0,0 +1,107 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+============================
+Cross-Host-Bridge Interleave
+============================
+This system has a single socket with two CXL host bridges. Each host bridge
+has a single CXL memory expander with a 4GB of memory.
+
+Things to note:
+
+* Cross-Bridge interleave is described.
+* The expanders are described by a single CFMWS.
+* This SRAT describes one-node for both host bridges.
+* The HMAT describes a single node's performance.
+
+CEDT ::
+
+            Subtable Type : 00 [CXL Host Bridge Structure]
+                 Reserved : 00
+                   Length : 0020
+   Associated host bridge : 00000007
+    Specification version : 00000001
+                 Reserved : 00000000
+            Register base : 0000010370400000
+          Register length : 0000000000010000
+
+            Subtable Type : 00 [CXL Host Bridge Structure]
+                 Reserved : 00
+                   Length : 0020
+   Associated host bridge : 00000006
+    Specification version : 00000001
+                 Reserved : 00000000
+            Register base : 0000010380800000
+          Register length : 0000000000010000
+
+            Subtable Type : 01 [CXL Fixed Memory Window Structure]
+                 Reserved : 00
+                   Length : 002C
+                 Reserved : 00000000
+      Window base address : 0000001000000000
+              Window size : 0000000200000000
+ Interleave Members (2^n) : 01
+    Interleave Arithmetic : 00
+                 Reserved : 0000
+              Granularity : 00000000
+             Restrictions : 0006
+                    QtgId : 0001
+             First Target : 00000007
+            Second Target : 00000006
+
+SRAT ::
+
+         Subtable Type : 01 [Memory Affinity]
+                Length : 28
+      Proximity Domain : 00000001
+             Reserved1 : 0000
+          Base Address : 0000001000000000
+        Address Length : 0000000200000000
+             Reserved2 : 00000000
+ Flags (decoded below) : 0000000B
+             Enabled : 1
+       Hot Pluggable : 1
+        Non-Volatile : 0
+
+HMAT ::
+
+               Structure Type : 0001 [SLLBI]
+                    Data Type : 00   [Latency]
+ Target Proximity Domain List : 00000000
+ Target Proximity Domain List : 00000001
+ Target Proximity Domain List : 00000002
+                        Entry : 0080
+                        Entry : 0100
+
+               Structure Type : 0001 [SLLBI]
+                    Data Type : 03   [Bandwidth]
+ Target Proximity Domain List : 00000000
+ Target Proximity Domain List : 00000001
+ Target Proximity Domain List : 00000002
+                        Entry : 1200
+                        Entry : 0400
+
+SLIT ::
+
+     Signature : "SLIT"    [System Locality Information Table]
+    Localities : 0000000000000003
+  Locality   0 : 10 20
+  Locality   1 : FF 0A
+
+DSDT ::
+
+  Scope (_SB)
+  {
+    Device (S0D0)
+    {
+        Name (_HID, "ACPI0016" /* Compute Express Link Host Bridge */)  // _HID: Hardware ID
+        ...
+        Name (_UID, 0x07)  // _UID: Unique ID
+    }
+    ...
+    Device (S0D5)
+    {
+        Name (_HID, "ACPI0016" /* Compute Express Link Host Bridge */)  // _HID: Hardware ID
+        ...
+        Name (_UID, 0x06)  // _UID: Unique ID
+    }
+  }
diff --git a/Documentation/driver-api/cxl/platform/example-configurations/multi-dev-per-hb.rst b/Documentation/driver-api/cxl/platform/example-configurations/multi-dev-per-hb.rst
new file mode 100644
index 000000000000..6adf7c639490
--- /dev/null
+++ b/Documentation/driver-api/cxl/platform/example-configurations/multi-dev-per-hb.rst
@@ -0,0 +1,90 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+================================
+Multiple Devices per Host Bridge
+================================
+
+In this example system we will have a single socket and one CXL host bridge.
+There are two CXL memory expanders with 4GB attached to the host bridge.
+
+Things to note:
+
+* Intra-Bridge interleave is not described here.
+* The expanders are described by a single CEDT/CFMWS.
+* This CEDT/SRAT describes one node for both devices.
+* There is only one proximity domain the HMAT for both devices.
+
+CEDT ::
+
+            Subtable Type : 00 [CXL Host Bridge Structure]
+                 Reserved : 00
+                   Length : 0020
+   Associated host bridge : 00000007
+    Specification version : 00000001
+                 Reserved : 00000000
+            Register base : 0000010370400000
+          Register length : 0000000000010000
+
+            Subtable Type : 01 [CXL Fixed Memory Window Structure]
+                 Reserved : 00
+                   Length : 002C
+                 Reserved : 00000000
+      Window base address : 0000001000000000
+              Window size : 0000000200000000
+ Interleave Members (2^n) : 00
+    Interleave Arithmetic : 00
+                 Reserved : 0000
+              Granularity : 00000000
+             Restrictions : 0006
+                    QtgId : 0001
+             First Target : 00000007
+
+SRAT ::
+
+         Subtable Type : 01 [Memory Affinity]
+                Length : 28
+      Proximity Domain : 00000001
+             Reserved1 : 0000
+          Base Address : 0000001000000000
+        Address Length : 0000000200000000
+             Reserved2 : 00000000
+ Flags (decoded below) : 0000000B
+             Enabled : 1
+       Hot Pluggable : 1
+        Non-Volatile : 0
+
+HMAT ::
+
+               Structure Type : 0001 [SLLBI]
+                    Data Type : 00   [Latency]
+ Target Proximity Domain List : 00000000
+ Target Proximity Domain List : 00000001
+                        Entry : 0080
+                        Entry : 0100
+
+               Structure Type : 0001 [SLLBI]
+                    Data Type : 03   [Bandwidth]
+ Target Proximity Domain List : 00000000
+ Target Proximity Domain List : 00000001
+                        Entry : 1200
+                        Entry : 0200
+
+SLIT ::
+
+     Signature : "SLIT"    [System Locality Information Table]
+    Localities : 0000000000000003
+  Locality   0 : 10 20
+  Locality   1 : FF 0A
+
+DSDT ::
+
+  Scope (_SB)
+  {
+    Device (S0D0)
+    {
+        Name (_HID, "ACPI0016" /* Compute Express Link Host Bridge */)  // _HID: Hardware ID
+        ...
+        Name (_UID, 0x07)  // _UID: Unique ID
+    }
+    ...
+  }
diff --git a/Documentation/driver-api/cxl/platform/example-configurations/one-dev-per-hb.rst b/Documentation/driver-api/cxl/platform/example-configurations/one-dev-per-hb.rst
new file mode 100644
index 000000000000..8b732dc8c5b6
--- /dev/null
+++ b/Documentation/driver-api/cxl/platform/example-configurations/one-dev-per-hb.rst
@@ -0,0 +1,136 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+==========================
+One Device per Host Bridge
+==========================
+
+This system has a single socket with two CXL host bridges. Each host bridge
+has a single CXL memory expander with a 4GB of memory.
+
+Things to note:
+
+* Cross-Bridge interleave is not being used.
+* The expanders are in two separate but adjascent memory regions.
+* This CEDT/SRAT describes one-node per device
+* The expanders have the same performance and will be in the same memory tier.
+
+CEDT ::
+
+            Subtable Type : 00 [CXL Host Bridge Structure]
+                 Reserved : 00
+                   Length : 0020
+   Associated host bridge : 00000007
+    Specification version : 00000001
+                 Reserved : 00000000
+            Register base : 0000010370400000
+          Register length : 0000000000010000
+
+            Subtable Type : 00 [CXL Host Bridge Structure]
+                 Reserved : 00
+                   Length : 0020
+   Associated host bridge : 00000006
+    Specification version : 00000001
+                 Reserved : 00000000
+            Register base : 0000010380800000
+          Register length : 0000000000010000
+
+            Subtable Type : 01 [CXL Fixed Memory Window Structure]
+                 Reserved : 00
+                   Length : 002C
+                 Reserved : 00000000
+      Window base address : 0000001000000000
+              Window size : 0000000100000000
+ Interleave Members (2^n) : 00
+    Interleave Arithmetic : 00
+                 Reserved : 0000
+              Granularity : 00000000
+             Restrictions : 0006
+                    QtgId : 0001
+             First Target : 00000007
+
+            Subtable Type : 01 [CXL Fixed Memory Window Structure]
+                 Reserved : 00
+                   Length : 002C
+                 Reserved : 00000000
+      Window base address : 0000001100000000
+              Window size : 0000000100000000
+ Interleave Members (2^n) : 00
+    Interleave Arithmetic : 00
+                 Reserved : 0000
+              Granularity : 00000000
+             Restrictions : 0006
+                    QtgId : 0001
+             First Target : 00000006
+
+SRAT ::
+
+         Subtable Type : 01 [Memory Affinity]
+                Length : 28
+      Proximity Domain : 00000001
+             Reserved1 : 0000
+          Base Address : 0000001000000000
+        Address Length : 0000000100000000
+             Reserved2 : 00000000
+ Flags (decoded below) : 0000000B
+             Enabled : 1
+       Hot Pluggable : 1
+        Non-Volatile : 0
+
+         Subtable Type : 01 [Memory Affinity]
+                Length : 28
+      Proximity Domain : 00000002
+             Reserved1 : 0000
+          Base Address : 0000001100000000
+        Address Length : 0000000100000000
+             Reserved2 : 00000000
+ Flags (decoded below) : 0000000B
+             Enabled : 1
+       Hot Pluggable : 1
+        Non-Volatile : 0
+
+HMAT ::
+
+               Structure Type : 0001 [SLLBI]
+                    Data Type : 00   [Latency]
+ Target Proximity Domain List : 00000000
+ Target Proximity Domain List : 00000001
+ Target Proximity Domain List : 00000002
+                        Entry : 0080
+                        Entry : 0100
+                        Entry : 0100
+
+               Structure Type : 0001 [SLLBI]
+                    Data Type : 03   [Bandwidth]
+ Target Proximity Domain List : 00000000
+ Target Proximity Domain List : 00000001
+ Target Proximity Domain List : 00000002
+                        Entry : 1200
+                        Entry : 0200
+                        Entry : 0200
+
+SLIT ::
+
+     Signature : "SLIT"    [System Locality Information Table]
+    Localities : 0000000000000003
+  Locality   0 : 10 20 20
+  Locality   1 : FF 0A FF
+  Locality   2 : FF FF 0A
+
+DSDT ::
+
+  Scope (_SB)
+  {
+    Device (S0D0)
+    {
+        Name (_HID, "ACPI0016" /* Compute Express Link Host Bridge */)  // _HID: Hardware ID
+        ...
+        Name (_UID, 0x07)  // _UID: Unique ID
+    }
+    ...
+    Device (S0D5)
+    {
+        Name (_HID, "ACPI0016" /* Compute Express Link Host Bridge */)  // _HID: Hardware ID
+        ...
+        Name (_UID, 0x06)  // _UID: Unique ID
+    }
+  }
-- 
2.49.0


