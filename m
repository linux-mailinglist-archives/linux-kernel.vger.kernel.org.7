Return-Path: <linux-kernel+bounces-644508-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 911ABAB3D80
	for <lists+linux-kernel@lfdr.de>; Mon, 12 May 2025 18:27:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AEDCC3AA245
	for <lists+linux-kernel@lfdr.de>; Mon, 12 May 2025 16:22:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E7782528E4;
	Mon, 12 May 2025 16:21:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="jjs+vKH2"
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 269CE2500C5
	for <linux-kernel@vger.kernel.org>; Mon, 12 May 2025 16:21:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747066916; cv=none; b=sQJW1nciSfagfgOVCPfAj0GSov9rRqwnVkXWhT/L6NyKQ7rlr+TR+117e31aDhA2vzwpWowzEv57K4JH8O80XTv80Js5gxA271YCykcFe36pNeLPr9AwKUS8QJeMCANxk+M72RBJsUJEHi+ng9Tc5CvsvsymzAlTlIjhQ9lWrkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747066916; c=relaxed/simple;
	bh=FrqsnCms64xssgqd/+HDCq4f1uWyiTUT0WHx8B6TExI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Fieus/bC5Jkyx+kJaYdmZIAk2ENI05VuScwhjZ+lCIQwQXKzd+9Gi9fzosRxDycS25VXoaUQoXEjHIeM8rdniKaWVubL1+taUaXNuozpa2vFJ9Txba5uEZDqvn1O0xlTM9P9ntUNnqGNQoRmGbKuTmxpy9Vm1VXyq7qVq3dPmKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=jjs+vKH2; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-476b4c9faa2so67521131cf.3
        for <linux-kernel@vger.kernel.org>; Mon, 12 May 2025 09:21:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1747066912; x=1747671712; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mlTkMyf1jxpd4EvIj3V+ddlx0K3cVVTKy+9j4XvAUwA=;
        b=jjs+vKH2RxEVnBQK73P+0WhFTwbIs+qBqZywRYCsmQHneqTV/7OK7rCDv8JQ3w2wjM
         sd4e+q8ofUZtJnemAhAeYmtg0nL6GdDA2i0eSDbvqEqFy61JHRL5OM7KHkDX9MBBHIV6
         s9EIn7TE4IFElsqqfM5d2IzDsUaRFnKBIIJ8Wz/EZkkfWpzai4wK1lAxPqfFxVI08X/1
         TtCB2IIzfb/TGYyK3I/wHhCqWGcbo9fEo3vlvczwloAF3IcvQ+4c79nkidPN5WCxl8O5
         qEyw2rDPs+NWbSR9nfnt6dLWFI5QxKu5y+e8KHfTgZdng69WvjrvTdvLa9eYlYQe4ayO
         LhAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747066912; x=1747671712;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mlTkMyf1jxpd4EvIj3V+ddlx0K3cVVTKy+9j4XvAUwA=;
        b=sHIXu7r7qBdtGXHOerPhd8RaDNHFg66PwLTRQ8JWB+YAbfWI/MnaySrItfZvoPWJX0
         brjO9rekS32ac8kKxl27Z2YWxFrJ373KZWudjHaV0drsr4+jRDR5Z8/8wwJ5nA+2JsWc
         pDSPCQggObsu63P353aDoXii9pzBU0jXLek/Ohm8JW4lQxQqIj8B3FCGRn3qsY6xz+Ve
         IC+ej5h3SE/axVkw7hnStzwOE2SZQXk/ULG3gWO9oiT3E3CK9iznWmiPgXT1xzaNWDSA
         s5KDmRcnBEXXsXibtZFswcxyDd7Yyy2Xywdn2ZTGqEk86lp6eDZENCe678jCu4YjhKlm
         3QcA==
X-Forwarded-Encrypted: i=1; AJvYcCW3MvUeXXrzW/YcDGSoGGrQ0BxISusGBRAaHXxJ2PzNdA25/ZIQ/DnNOqb22Ikjq2FrqtklgrdX1GWVmGc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzpFbdGD3uSLmfkO1uMZOd7xbXd+9jvePDVBzPgMpTDhn1LDstj
	4ZoomVLTDcNHhQgTsN6vteVCc9cPJU61WgOKL2h3BGgj4PS//blfEcHBv3Ec9Ps=
X-Gm-Gg: ASbGnctmi7hSx1ENKgb0dU29t8oC4vM850ianyAeqapEgxeta/ei9jymPH6mKnfo3lT
	HDx6Gc+zoT9evxkoOdI72qO0d/mksFaxwkxoYd6xVTtnv64kPmUkv8aJlnSW7Xy0wdeUKnZydfc
	D7MZ1COYqPLOJDzNJDhpPTggE0/isMKFyjfpQCPP26PnaUaY6MEIMrkRU1AAc5OjRIkBE/PQMlX
	cdLjnG/EVXeZOagtw3Q4ITnq/TSNXeYzFrMkWbbOSWw5OZvAzAJHgZke48ab6IcnBFg8IOHwUZ+
	AxjrwTBRDbb8RZ4Oe2FI2clAdTOczPQkuIeShvSHn3QXwnqCym9eKAypnFMtHlvF1gQ5VkOxHiH
	UhKVoICo4+J133EOb0pdeROSHmOeUkvQb1E9P
X-Google-Smtp-Source: AGHT+IEfNfUHzJW1gy0tomAJEHsP0Ni2ouf40Q1xEewnGZ8Igtvdw96kyNakqf4sOLk/RAoM0LT4/g==
X-Received: by 2002:a05:622a:56:b0:491:1874:bd9d with SMTP id d75a77b69052e-4945275e65dmr200111601cf.28.1747066911623;
        Mon, 12 May 2025 09:21:51 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F.lan (pool-96-255-20-42.washdc.ftas.verizon.net. [96.255.20.42])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-49452583961sm52461791cf.58.2025.05.12.09.21.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 May 2025 09:21:51 -0700 (PDT)
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
Subject: [PATCH v3 06/17] cxl: docs/platform/example-configs documentation
Date: Mon, 12 May 2025 12:21:23 -0400
Message-ID: <20250512162134.3596150-7-gourry@gourry.net>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250512162134.3596150-1-gourry@gourry.net>
References: <20250512162134.3596150-1-gourry@gourry.net>
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
index 336322dc35a0..6a5fb7e00c52 100644
--- a/Documentation/driver-api/cxl/index.rst
+++ b/Documentation/driver-api/cxl/index.rst
@@ -27,6 +27,7 @@ that have impacts on each other.  The docs here break up configurations steps.
 
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
index 000000000000..e39daba65fa0
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
+* This SRAT describes one node for each of the above CFMWS.
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
index 000000000000..ce07e6162f26
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
+* This SRAT describes one node for both host bridges.
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
index 000000000000..b89ba3cab98f
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
+* This CEDT/SRAT describes one node per device
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


