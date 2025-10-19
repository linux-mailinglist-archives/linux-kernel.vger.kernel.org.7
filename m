Return-Path: <linux-kernel+bounces-859549-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 37D50BEDF01
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Oct 2025 08:19:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id CAB634E6DA9
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Oct 2025 06:18:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80E3E239E9E;
	Sun, 19 Oct 2025 06:17:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZnqYxpf+"
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0554239581
	for <linux-kernel@vger.kernel.org>; Sun, 19 Oct 2025 06:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760854633; cv=none; b=PaKXEUocz0G7xW5UIKltV2QK2eVigN0DdBwLQyAT2gBnPnLJGjDBmvYILjAheJ4Tvk6ZbQ0sGra80cjBmBe1CS0eCkKFRaiVmHbGI9VWwph/BhiuHdQGbK4Wfy5+okvxpqCqwcyh5r1atsAgTK33EA7fFanw92bhltYg/a2Wjp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760854633; c=relaxed/simple;
	bh=qNpNVdVh5zeFXC+4CWsJxEPp98nIBvSuUO8EukRJmAQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jQ1m2cNi2LZx5E58YpDkVZ3VD1Lryp5ffaCq5vRVUn01rpMSWHksrWv23Q2xMmteWgi0HwnU+Vr0g2mNCy9NZFcU5J3RgcVyv8nhol5h6Yaj6FjDEv14e6Avol2tVAnoaAr2K2xCJA23k4osrrlGR21rtIL2jhYn1/tFUp00vMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZnqYxpf+; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-3307de086d8so2779238a91.2
        for <linux-kernel@vger.kernel.org>; Sat, 18 Oct 2025 23:17:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760854630; x=1761459430; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+dhzEiy+8NWdg0h4CeSLeODHjNB3Z/i+xinCfvk2bH8=;
        b=ZnqYxpf+3fcWr85Ymzqj+Bn6487vA/yF3RyPvRF8SkJOKH0Cxj0+vKBUtfWlSt1R6i
         Ivi0E/1rjjHStOWpi94dbxhsbfijoP20ZEAt6/2OK5fSdcbDceQfF/4av/sJNm38yy5X
         lZAPj834f4GcHp4uEMWuDyyetnYWM2mzxg0i4sCbYYqWXkvttwShQEvCpumGkZtda2Dr
         cr044/wl29gCbdpbTdHd2/rokOfIGGTMpc5eLWkvKJBkIfNJ8kGKlZr+Qec6l12SqTNx
         MNwPAIYB8bus2dHy9m4xM1fCn7iHZkNIzV+zkKF+wlyueThWqQ/DvgpLxobjoCzSx0W8
         y/lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760854630; x=1761459430;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+dhzEiy+8NWdg0h4CeSLeODHjNB3Z/i+xinCfvk2bH8=;
        b=sHF8Mg9GtCvZZhxCHNlFJzMQjc/Fm6k+MsVYwMZuvKVDEiUvy+ChC2mEEXgW3QvM6Y
         O5JJvV2Xl3Tk9lBqiZINDELjp+doxhTGuHKuvA152P3sgiATU8LiFa4460B4z2eI2mVI
         jlk5MXbTxtpq8d6YYY5hBt65ZMUO2GV0dAykzB30fovcwswWL204IqZv+UI/Q7HNScSI
         yPM5hvayu+y5dlL0Q5P6w0CH+cFgb55No6uQN6W+ZWlsbh7StTDAKDx3i85fuQxRkYB0
         L/ca9uGp0yyEMHbh+78tBZu00gZ5GwqsOZ5dSMU+lSTIXfVc1FFOB+9akP5Ey0EWZl3b
         aPxw==
X-Gm-Message-State: AOJu0YziJjwsQdkFZd0EkN8cw8USEq3lst5McIBOkaCnhRujBKstTYlM
	TLmq2R0Yd8UwywEQFiiSJ+tvpME2RAgD+ak1OBsCxxJahjd6tm+mHhCcJeGzmw==
X-Gm-Gg: ASbGncupHqfGqAwMbz0JLBSy2aJu33Drie3/Ig/GHFpX6rTUM3WzeNlkxzvklRGF6C6
	wyyOmZGjWnHzKvc3sPt/7lke5cOXPbTC6Mt6pem950aKfBUfszD8ceHxPIPZjHHypcsbFVTpBuW
	fLCuhkfjMZTgyvxy4Nf1crcEiVyQV6HOHO98VF238DcR/zJ1hqXPoci+6VYnXoRUV8kcnLu5dQr
	/vDHwktqq2qdQIwe8mwuVhORJGgOH/qZXjnHVFvz5K8jDFtRWh4bqBV4Mbm4WcewuLrFJpGr8c9
	GqOvKVjdhxYvZjZDdnrXhyOzRhQ5g2WN2HtZn6xj/Tio51q3vdf9IR614Fmo9IFMiuBp3CoKQZN
	EWtYhwG3C+YJT5yoLoQhdm9gDlnlH5M9noh3UObeHRc8tt42oNeu7SINuzKrjeR2iNoGQZuOPOl
	Ry+FMS5RXSK5FXKMI=
X-Google-Smtp-Source: AGHT+IHsfMse1ea3nbYNy4BvjdFagVFMuvl17zEl9LnMyhbIq3nsVQdQyV1KljR01j/1hJqe5RDh3A==
X-Received: by 2002:a17:90b:1e07:b0:32e:7340:a7f7 with SMTP id 98e67ed59e1d1-33bcf85abb4mr10954646a91.2.1760854630353;
        Sat, 18 Oct 2025 23:17:10 -0700 (PDT)
Received: from pop-os.. ([2601:647:6881:9060:bc87:d8fe:3e55:7ffb])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b6a76b6f302sm4332032a12.38.2025.10.18.23.17.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Oct 2025 23:17:09 -0700 (PDT)
From: Cong Wang <xiyou.wangcong@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: jiri@resnulli.us,
	stefanha@redhat.com,
	multikernel@lists.linux.dev,
	pasha.tatashin@soleen.com,
	Cong Wang <cwang@multiernel.io>,
	Andrew Morton <akpm@linux-foundation.org>,
	Baoquan He <bhe@redhat.com>,
	Alexander Graf <graf@amazon.com>,
	Mike Rapoport <rppt@kernel.org>,
	Changyuan Lyu <changyuanl@google.com>,
	kexec@lists.infradead.org,
	linux-mm@kvack.org
Subject: [RFC Patch v2 10/16] Documentation: Add multikernel usage
Date: Sat, 18 Oct 2025 23:16:24 -0700
Message-Id: <20251019061631.2235405-11-xiyou.wangcong@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251019061631.2235405-1-xiyou.wangcong@gmail.com>
References: <20251019061631.2235405-1-xiyou.wangcong@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Cong Wang <cwang@multiernel.io>

Signed-off-by: Cong Wang <cwang@multiernel.io>
---
 Documentation/multikernel/usage.rst | 215 ++++++++++++++++++++++++++++
 1 file changed, 215 insertions(+)
 create mode 100644 Documentation/multikernel/usage.rst

diff --git a/Documentation/multikernel/usage.rst b/Documentation/multikernel/usage.rst
new file mode 100644
index 000000000000..a2ec8d56ca1d
--- /dev/null
+++ b/Documentation/multikernel/usage.rst
@@ -0,0 +1,215 @@
+===================================
+Multikernel Kernfs Interface Usage
+===================================
+
+Overview
+========
+
+The multikernel kernfs interface provides a clean, user-friendly way to manage multikernel instances through the filesystem. The interface is located at ``/sys/fs/multikernel/`` and supports automatic instance creation from multikernel device trees.
+
+Architecture
+============
+
+::
+
+    /sys/fs/multikernel/
+    ├── device_tree         # Root-level DTB upload (write-only)
+    └── instances/          # Instance directory
+        ├── web-server/     # Instance created from DTB
+        │   ├── id          # Instance ID (read-only)
+        │   ├── status      # Instance status (read-only)
+        │   └── device_tree_source  # Instance DTB in DTS format (read-only)
+        ├── database/       # Another instance
+        │   ├── id
+        │   ├── status
+        │   └── device_tree_source
+        └── ...
+
+Workflow
+========
+
+Phase 1: Instance Creation (Automatic from DTB)
+------------------------------------------------
+
+1. **Create Multikernel Device Tree**
+
+   Create a device tree with multiple instances:
+
+   .. code-block:: dts
+
+      /dts-v1/;
+      / {
+          compatible = "multikernel-v1";
+
+          instances {
+              web-server {
+                  id = <1>;
+                  resources {
+                      cpus = <1>;
+                      memory-bytes = <0x20000000>;   // 512MB
+                  };
+              };
+
+              database {
+                  id = <2>;
+                  resources {
+                      cpus = <2 3>;
+                      memory-bytes = <0x40000000>;   // 1GB
+                  };
+              };
+          };
+      };
+
+2. **Upload Multikernel DTB**
+
+   .. code-block:: bash
+
+      # Compile device tree to binary format
+      dtc -O dtb -o multikernel.dtb multikernel.dts
+
+      # Upload DTB to create instances automatically
+      cat multikernel.dtb > /sys/fs/multikernel/device_tree
+
+   This automatically:
+
+   - Validates DTB format and multikernel-v1 compatibility
+   - Parses each instance in the ``/instances`` node
+   - Creates instance directories under ``instances/``
+   - Reserves memory and CPU resources for each instance
+   - Updates each instance status to "ready"
+
+3. **Check Created Instances**
+
+   .. code-block:: bash
+
+      # List created instances
+      ls /sys/fs/multikernel/instances/
+      # Output: database  web-server
+
+      # Check instance details
+      cat /sys/fs/multikernel/instances/web-server/id
+      # Output: 1
+
+      cat /sys/fs/multikernel/instances/web-server/status
+      # Output: ready
+
+      # View instance device tree
+      cat /sys/fs/multikernel/instances/web-server/device_tree_source
+      # Output: DTS format showing the instance configuration
+
+Phase 2: Kernel Loading (Kexec Integration)
+--------------------------------------------
+
+1. **Load Kernel Image**
+
+   .. code-block:: bash
+
+      # Load kernel for instance ID 1 (web-server)
+      kexec_file_load(..., KEXEC_MULTIKERNEL | KEXEC_MK_ID(1))
+
+   This:
+
+   - Finds pre-reserved resources for instance ID 1
+   - Creates kimage using pre-allocated memory and CPU resources
+   - Updates status to "loading" → "active"
+   - Preserves instance DTB for KHO (Kexec HandOver) restoration
+
+2. **Instance DTB Preservation**
+
+   The multikernel system automatically preserves each instance's device tree during kexec for restoration in the spawn kernel. The spawn kernel will:
+
+   - Detect multikernel KHO data during early boot
+   - Restore the instance's DTB and recreate the instance structure
+   - Re-reserve the same memory and CPU resources
+
+Device Tree Format
+==================
+
+Multikernel DTB Structure
+--------------------------
+
+The multikernel device tree uses the ``/instances`` structure with ``multikernel-v1`` compatibility:
+
+.. code-block:: dts
+
+    /dts-v1/;
+    / {
+        compatible = "multikernel-v1";
+
+        instances {
+            web-server {
+                id = <1>;
+                resources {
+                    cpus = <1>;                      // CPU ID 1
+                    memory-bytes = <0x20000000>;     // 512MB
+                };
+            };
+
+            database {
+                id = <2>;
+                resources {
+                    cpus = <2 3>;                    // CPU IDs 2 and 3
+                    memory-bytes = <0x40000000>;     // 1GB
+                };
+            };
+
+            load-balancer {
+                id = <3>;
+                resources {
+                    cpus = <0>;                      // CPU ID 0
+                    memory-bytes = <0x10000000>;     // 256MB
+                };
+            };
+        };
+    };
+
+Per-Instance DTB Format
+-----------------------
+
+When viewing an instance's ``device_tree_source``, it appears in per-instance format:
+
+.. code-block:: dts
+
+    /dts-v1/;
+
+    /web-server {
+        compatible = "multikernel-v1";
+        id = <1>;
+        resources {
+            cpus = <1>;
+            memory-bytes = <0x20000000>; // 512 MB
+        };
+    };
+
+Resource Properties
+-------------------
+
+- **cpus**: Array of CPU IDs to assign to this instance
+- **memory-bytes**: Memory size in bytes (must be page-aligned)
+- **id**: Unique instance identifier used for kexec operations
+
+The system validates that:
+
+- CPU IDs are valid and available
+- Memory requests don't exceed available multikernel pool
+- Instance IDs are unique
+- All values are properly aligned
+
+Instance States
+===============
+
+- **empty**: Instance created but no resources allocated yet
+- **ready**: DTB processed, resources reserved, ready for kexec
+- **loading**: Kernel being loaded via kexec
+- **active**: Kernel running in this instance
+- **failed**: Error occurred during any phase
+
+Interface Restrictions
+======================
+
+The new kernfs interface has the following restrictions:
+
+- **No manual instance creation**: Use ``mkdir`` under ``instances/`` is disabled
+- **No direct DTB upload to instances**: Instances don't have writable ``device_tree`` files
+- **Centralized DTB management**: All instances must be created via the root ``device_tree`` file
+- **Read-only instance files**: All instance attributes are read-only for consistency
-- 
2.34.1


