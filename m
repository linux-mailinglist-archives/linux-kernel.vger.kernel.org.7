Return-Path: <linux-kernel+bounces-626120-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EF0E7AA3E9B
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Apr 2025 02:24:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D82861894935
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Apr 2025 00:22:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0673615D5B6;
	Wed, 30 Apr 2025 00:12:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="KGnYNqMs"
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 339FB13D503
	for <linux-kernel@vger.kernel.org>; Wed, 30 Apr 2025 00:12:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745971959; cv=none; b=UC4z3Y1tFEnMsodnrMQ/no9JgcsAjg7miSQS5nZThxYFsqj/QqSOwnp9Ujqq5iNaJRkzg2qnbL9xItr6w7CI+l2J2nq/nOmXGyiD2CTwUkZyPvXtImvfP9A7L8keBwz5xNWs4JeMbiVcBdKkps709q8xcAPUcyC4F6oFee4e8CI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745971959; c=relaxed/simple;
	bh=e5jugkeDpF7bmgh2TQtKLh2FIKa3OmtMEyl3FUUtO6A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Qfce/AO+6YQS8PHSeBTnhkoK2yCfd5x2A6zr8usgSSaSjXl+/pVqLOxOjUAQqew2bFdGO+ZufbLz9wwzmhS0d255xxRr69wKgS/emzaD2ALiXsr6UsYwyh5IktfiAVa+yVj8U1pVYfkj7rEmh6GIgmOSUau+SNNhn5wGlBgGULY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=KGnYNqMs; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-4774ce422easo80639931cf.1
        for <linux-kernel@vger.kernel.org>; Tue, 29 Apr 2025 17:12:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1745971956; x=1746576756; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4xZ+86saRq9pG/NaKQJUIWXjX8l/pag4UramD96/2zo=;
        b=KGnYNqMskWvRNV5VGq4Tng9hJj1/C0PewR1NCDc8h841f5kWGvBdMi2eHuw0FMjpg8
         FrrRVstkzUsXCrDVULZQaUBXX3riJKMsRnCRersdaKZQsz2MBn1CLyjE/uyH/wrfDkzG
         oniFsrNkj95DfK3V//9h6rVnWh9UKSZSp0gRt1QggRgNDCbxs1c6Lv8tUfvNmH7vdGj6
         0Y42IETfnhh6dYh5UMH6ClQTMHvnNJNIU9qgYP/91BELEF3yOf8OOzbtq3Q87TJVgpqq
         3RF/tHlyvUHoYMkBXCcceWllR9lFTVj7m1Er+vWtudtA+rQ5HQIyx9R1pjqPnd1OvST7
         1InQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745971956; x=1746576756;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4xZ+86saRq9pG/NaKQJUIWXjX8l/pag4UramD96/2zo=;
        b=svtHlzidsFPqi8eIbXDDMtUX5OBPOClHP2k5KD7b/ufynvib0e+Qa5Hek55vl2dVJc
         Zxi+XJwc4/sY6x+wk1Rx00lzijoeW8hVXKodxf/SsehGHauPyg8LvuP6LfgBSSRxOqlU
         Hd6zWt/L8hZJEV1Np2v6miWIQcVaty1CcRI9jlpguGiYbcqEw0VjEyeSSVxdasrMs4Cn
         JPkverOVlvnDm7yR4VDtGyfji1vWeHIx8swhaVRdgJ9nBHGDn13EiegKF4qXn3qB80lM
         ItxjdkO/Ga2jtauLoA0YFH2/cLpanZtlIDCxe1Xz+GRvW7tvN6uB8JsTmZDegvFoCivR
         fRog==
X-Forwarded-Encrypted: i=1; AJvYcCWmeSgy9/Gadzvacp8Zr1KFxBHwdoDRbzx1qRXYA/1GkUWOt9r+b/CywQJA+xWiGGeqc0jHrrAZSMGHkDw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4rcEz4/eot3Y/IyvW9wgZaA3YbkLkbYmWKrTmZutGzu4sItFU
	OSkHEag2xYOw4tKku5C9kPGPoxlnKvCpDoPZVpB7XjgtCVgkeinfkH+URDiS0d8=
X-Gm-Gg: ASbGncv6gJAXihg1VZvB2lnvHOnRDGHvFDQ5LSzN8fVX+ZFz5tEIjPuW142TowMHEOO
	g/omehyQl93Yr+h9ghHtu7gehYGJ3xAugp+t55GgXk2vhNVzgUftXI5cMy1fJXBTLWwA4EQAH/7
	TdKomOKhDNGQY0DD8S/Dl8IjRBQ8X4uDMrSNI8nPVDpFaI9U/zDQXp/R06BWRBc2NFJ7zoOlBXM
	9SSHrCooA5ivXAjp6hexpmUqSawIzmP+zw8CbZ8KraG9rw3+lM7v83GtEEzT2QOW1ZzlcPJNt77
	4gsV9nDxw7uaLgmXchNj8FybzVRUP12XDioqfjEUZnioPtWT9AaK+/MK10xNB2PNf8OGTJdnBvA
	naQYIDvgFwTbT1iclYU+ecoYwNdgp
X-Google-Smtp-Source: AGHT+IFa3NzkxwjUZP3GFMLSdHf5Tca22UuV8p7IVcGENTe+mIIlXYwehMOv1AXXT0q/70/ru9M5rQ==
X-Received: by 2002:a05:622a:5448:b0:476:7bd1:68dd with SMTP id d75a77b69052e-489e69a78ecmr11590101cf.50.1745971955928;
        Tue, 29 Apr 2025 17:12:35 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F.lan (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-47e9f7a820esm87634411cf.41.2025.04.29.17.12.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Apr 2025 17:12:35 -0700 (PDT)
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
Subject: [RFC PATCH 02/17] cxl: docs/devices - device reference and uefi placeholder
Date: Tue, 29 Apr 2025 20:12:09 -0400
Message-ID: <20250430001224.1028656-3-gourry@gourry.net>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250430001224.1028656-1-gourry@gourry.net>
References: <20250430001224.1028656-1-gourry@gourry.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a simple device primer sufficient to understand the theory
of operation documentation.

Add carve-out for CDAT with a TODO.

Signed-off-by: Gregory Price <gourry@gourry.net>
---
 .../driver-api/cxl/devices/device-types.rst   | 169 ++++++++++++++++++
 Documentation/driver-api/cxl/devices/uefi.rst |   9 +
 Documentation/driver-api/cxl/index.rst        |   2 +
 3 files changed, 180 insertions(+)
 create mode 100644 Documentation/driver-api/cxl/devices/device-types.rst
 create mode 100644 Documentation/driver-api/cxl/devices/uefi.rst

diff --git a/Documentation/driver-api/cxl/devices/device-types.rst b/Documentation/driver-api/cxl/devices/device-types.rst
new file mode 100644
index 000000000000..e8dd051c2c71
--- /dev/null
+++ b/Documentation/driver-api/cxl/devices/device-types.rst
@@ -0,0 +1,169 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+Devices and Protocols
+#####################
+
+The type of CXL device (Memory, Accelerator, etc) dictates many configuration steps. This section
+covers some basic background on device types and on-device resources used by the platform and OS
+which impact configuration.
+
+Protocols
+*********
+
+There are three core protocols to CXL.  For the purpose of this documentation,
+we will only discuss very high level definitions as the specific hardware
+details are largely abstracted away from Linux.  See the CXL specification
+for more details.
+
+CXL.io
+======
+The basic interaction protocol, similar to PCIe configuration mechanisms.
+Typically used for initialization, configuration, and I/O access for anything
+other than memory (CXL.mem) or cache (CXL.cache) operations.
+
+The Linux CXL driver exposes access to .io functionalty via the various sysfs
+interfaces and /dev/cxl/ devices (which exposes direct access to device
+mailboxes).
+
+CXL.cache
+=========
+The mechanism by which a device may coherently access and cache host memory.
+
+Largely transparent to Linux once configured.
+
+CXL.mem
+=======
+The mechanism by which the CPU may coherently access and cache device memory.
+
+Largely transparent to Linux once configured.
+
+
+Device Types
+************
+
+Type-1
+======
+
+A Type-1 CXL device:
+
+* Supports cxl.io and cxl.cache protocols
+* Implements a fully coherent cache
+* Allow Device-to-Host coherence and Host-to-Device snoops.
+* Does NOT have host-managed device memory (HDM)
+
+Typical examples of type-1 devices is a Smart NIC - which may want to
+directly operate on host-memory (DMA) to store incoming packets. These
+devices largely rely on CPU-attached memory.
+
+Type-2
+======
+
+A Type-2 CXL Device:
+
+* Supports cxl.io, cxl.cache, and cxl.mem protocols
+* Optionally implements coherent cache and Host-Managed Device Memory
+* Is typically an accelerator device w/ high bandwidth memory.
+
+The primary difference between a type-1 and type-2 device is the presence
+of host-managed device memory, which allows the device to operate on a
+local memory bank - while the CPU sill has coherent DMA to the same memory.
+
+The allows things like GPUs to expose their memory via DAX devices or file
+descriptors, allows drivers and programs direct access to device memory
+rather than use block-transfer semantics.
+
+Type-3
+======
+
+A Type-3 CXL Device
+
+* Supports cxl.io and cxl.mem
+* Implements Host-Managed Device Memory
+* May provide either Volatile or Persistent memory capacity (or both).
+
+A basic example of a type-3 device is a simple memory expanded, whose
+local memory capacity is exposed to the CPU for access directly via
+basic coherent DMA.
+
+Switch
+======
+
+A CXL switch is a device capacity of routing any CXL (and by extension, PCIe)
+protocol between an upstream, downstream, or peer devices.  Many devices, such
+as Multi-Logical Devices, imply the presence of switching in some manner.
+
+Logical Devices and Heads
+=========================
+
+A CXL device may present one or more "Logical Devices" to one or more hosts
+(via physical "Heads").
+
+A Single-Logical Device (SLD) is a device which presents a single device to
+one or more heads.
+
+A Multi-Logical Device (MLD) is a device which may present multiple devices
+to one or more devices.
+
+A Single-Headed Device exposes only a single physical connection.
+
+A Multi-Headed Device exposes multiple physical connections.
+
+MHSLD
+-----
+A Multi-Headed Single-Logical Device (MHSLD) exposes a single logical
+device to multiple heads which may be connected to one or more discrete
+hosts.  An example of this would be a simple memory-pool which may be
+statically configured (prior to boot) to expose portions of its memory
+to Linux via the CEDT ACPI table.
+
+MHMLD
+-----
+A Multi-Headed Multi-Logical Device (MHMLD) exposes multiple logical
+devices to multiple heads which may be connected to one or more discrete
+hosts.  An example of this would be a Dynamic Capacity Device or which
+may be configured at runtime to expose portions of its memory to Linux.
+
+Example Devices
+***************
+
+Memory Expander
+===============
+The simplest form of Type-3 device is a memory expander.  A memory expander
+exposes Host-Managed Device Memory (HDM) to Linux.  This memory may be
+Volatile or Non-Volatile (Persistent).
+
+Memory Expanders will typically be considered a form of Single-Headed,
+Single-Logical Device - as its form factor will typically be an add-in-card
+(AIC) or some other similar form-factor.
+
+The Linux CXL driver provides support for static or dynamic configuration of
+basic memory expanders.  The platform may program decoders prior to OS init
+(e.g. auto-decoders), or the user may program the fabric if the platform
+defers these operations to the OS.
+
+Multiple Memory Expanders may be added to an external chassis and exposed to
+a host via a head attached to a CXL switch.  This is a "memory pool", and
+would be considered an MHSLD or MHMLD depending on the management capabilities
+provided by the switch platform.
+
+As of v6.14, Linux does not provide a formalized interface to manage non-DCD
+MHSLD or MHMLD devices.
+
+Dynamic Capacity Device (DCD)
+=============================
+
+A Dynamic Capacity Device is a Type-3 device which provides dynamic management
+of memory capacity. The basic premise of a DCD to provide an allocator-like
+interface for physical memory capacity to a "Fabric Manager" (an external,
+privileged host with privileges to change configurations for other hosts).
+
+A DCD manages "Memory Extents", which may be volatile or persistent. Extents
+may also be exclusive to a single host or shared across multiple.
+
+As of v6.14, Linux does not provide a formalized interface to manage DCD
+devices, however there is active work on LKML targeting future release.
+
+Example T2 Device
+=================
+
+Todo
diff --git a/Documentation/driver-api/cxl/devices/uefi.rst b/Documentation/driver-api/cxl/devices/uefi.rst
new file mode 100644
index 000000000000..a51583e6c44c
--- /dev/null
+++ b/Documentation/driver-api/cxl/devices/uefi.rst
@@ -0,0 +1,9 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+UEFI Data
+#########
+
+Coherent Device Attribute Table (CDAT)
+**************************************
+
+todo
diff --git a/Documentation/driver-api/cxl/index.rst b/Documentation/driver-api/cxl/index.rst
index dfc0a4aa9003..4dc99a6b08bd 100644
--- a/Documentation/driver-api/cxl/index.rst
+++ b/Documentation/driver-api/cxl/index.rst
@@ -19,6 +19,8 @@ that have impacts on each other.  The docs here break up configurations steps.
    :maxdepth: 2
    :caption: Device Reference
 
+   devices/device-types
+   devices/uefi
    devices/theory-of-operation
 
 .. toctree::
-- 
2.49.0


