Return-Path: <linux-kernel+bounces-644511-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D723AB3D6C
	for <lists+linux-kernel@lfdr.de>; Mon, 12 May 2025 18:25:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D3BD9460738
	for <lists+linux-kernel@lfdr.de>; Mon, 12 May 2025 16:22:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1EDA252917;
	Mon, 12 May 2025 16:21:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="po0pglis"
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC9DE2517AF
	for <linux-kernel@vger.kernel.org>; Mon, 12 May 2025 16:21:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747066918; cv=none; b=Ydet1b26l/sbXEKX0vSYBvyFibJw9D9ueVI4Y1qIQuahXlGBOrxDZ7B+UTJ+eS7aBsmuhgaPq08cw7lXB1qh5ucsErh8h3SW1eH/tou29SZPKlI1RKOI4U+kFYnhyMhg3XckzTbyODSCaEutS/p0F9OlbXaj2wlFTxMV/3dNqow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747066918; c=relaxed/simple;
	bh=LxQydT9NcYzB9rb63wpRt/UEayoX55pNcemCp/ExSaA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=u2xCVcpfgyxQ2R209gk7C4WWkZEWxvxYUAdRgN7bLoYCxbdleCIjfECMzy6OafZJ3+414I13JFTKLbXMx1JdS49OwSHvwGBxrLWUlRdyGWw8L8/mUqdK9qnq24tHuAhl1l8E1nBd8/0s5QO1wsdCordntZenrp2MDIgX+pF3+QY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=po0pglis; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-477282401b3so51492431cf.1
        for <linux-kernel@vger.kernel.org>; Mon, 12 May 2025 09:21:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1747066915; x=1747671715; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I8UJn+qPm/CqygOdsDrWlSFpuesufqB+7bgKD2LpNho=;
        b=po0pglis75+crhbyCE2FcAprMvwOg40U9SHx8P42y+uEvjdRKHAtbErMjYNOeWhTPf
         /+YhXybyGWPnfz2RY1GwX25x+s/JZR9xtyP7cqG9PBaN7m/yyZQ/S2/LB8y/m/+x9RVh
         zQN1HRj3Ho54UEKAN8TF4QbS+3yf7bQOPcM4YfYUg9LBv9Hkid4uoYNsyOVeM1835u/H
         1vvDTxi2DpqyEoh4g5fgrQZzMFX8/GBb4b+uL/e6crq/O+KhUyXuWTekTTfz+2W5hLek
         IhfStyNH9MmnsJSyVjxkWQF5tV/4KIeyf02DvmgE7W+nCktJ+IqTydhv94WNhX7iEhKt
         h+2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747066915; x=1747671715;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=I8UJn+qPm/CqygOdsDrWlSFpuesufqB+7bgKD2LpNho=;
        b=sZwZHv8SlUBg3OfIZ2O7lGjlKiPByoj3lhQwFxBB5ew4hZgoRO0msbg5FjDun6M7mm
         wkJd++O0scID+MpDtsq/nUJv/CWmY2Mmx85hB6F2U6UGckste25+E+oPKsUYnk3wJZMB
         KcQiRUPlRi3+W59Kht4z+NOgid8GPPOzqxpwUbNWFQLWhAnY8M0w8LoiAIfDsOqUg/mD
         8p5R0zcmA9J0kFfQUCvkoHWBeRcrZDeRsedDJWhUiDGjJMSAdLgaFvYHUPZRM7Yck3PA
         Oy4gzzAk+j/t1UgN8qDFH4LotYFNaqQALwKYs8Ua6MF36A5/P9yjm9HBfvYADCgJujWj
         Ftzw==
X-Forwarded-Encrypted: i=1; AJvYcCWnC/3O1kVpYFOm6AySsBSzPKna354PFsc2yti8MUSBxc6qvAp8NALaMb8yuLkIBtLIvV5jP8teq+ARzEI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw53ertahdKC31cdCJoG1geRdLmlA72Ig0K2a/F9i5N8uYCVef4
	w0I+hjG1PQOou9XOkB8x7VRSkgmuZloZTISgqPGLtya6mzMzJhfR65rvpaMEMSg=
X-Gm-Gg: ASbGncsMPHEhBqq8Fg689dddSVyS+ERJtb4Fbj2FymopC8av5QHRFU4OkW6Zha0b6HY
	vk4S0yVHSnqlZsUO5uGD2L7gELwMcF0twLN601zc/Sp82um+kd/DTXGKl7rNFldEEHVon3FJlyX
	r8wwI8RepFuoi/GZ+gjVoVvTAwI9O9d/XQ8CU9f/ZTdH4IZyRFZsa/UDbKQUzkP+g1S3+KhWXY5
	v6+slrWtlYc0/zr+IvlWZY5rbW6GsR5aR83Ea1zDF/PjUfc5iG0/6KqCo68d4w+VWxQH0mR4Cfx
	rRgjgmhI4/N3TZCPBxy+RCOfP2ujPfah9UNSEaB/KFkYTfh9+wA6UsSz7fgsWxPetG0peMUg1Vm
	n4HM8kPdpKvRs1D+pt452bW9kHc+FlpVm9R9G
X-Google-Smtp-Source: AGHT+IF/Ciuu/RnaIzilFe33rOYM7yb8qG2/RD4RLkfHTbIO9NZZVIDaDNHHl1sBRQgVDQ1Sb37DNw==
X-Received: by 2002:a05:622a:11d5:b0:48c:428c:5b5b with SMTP id d75a77b69052e-49452712ee1mr237385871cf.1.1747066914598;
        Mon, 12 May 2025 09:21:54 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F.lan (pool-96-255-20-42.washdc.ftas.verizon.net. [96.255.20.42])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-49452583961sm52461791cf.58.2025.05.12.09.21.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 May 2025 09:21:54 -0700 (PDT)
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
Subject: [PATCH v3 08/17] cxl: docs/linux - early boot configuration
Date: Mon, 12 May 2025 12:21:25 -0400
Message-ID: <20250512162134.3596150-9-gourry@gourry.net>
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

Document __init time configurations that affect CXL driver probe
process and memory region configuration.

Signed-off-by: Gregory Price <gourry@gourry.net>
---
 Documentation/driver-api/cxl/index.rst        |   1 +
 .../driver-api/cxl/linux/early-boot.rst       | 131 ++++++++++++++++++
 2 files changed, 132 insertions(+)
 create mode 100644 Documentation/driver-api/cxl/linux/early-boot.rst

diff --git a/Documentation/driver-api/cxl/index.rst b/Documentation/driver-api/cxl/index.rst
index bc2228c77c32..d2eefe575604 100644
--- a/Documentation/driver-api/cxl/index.rst
+++ b/Documentation/driver-api/cxl/index.rst
@@ -34,6 +34,7 @@ that have impacts on each other.  The docs here break up configurations steps.
    :caption: Linux Kernel Configuration
 
    linux/overview
+   linux/early-boot
    linux/access-coordinates
 
 
diff --git a/Documentation/driver-api/cxl/linux/early-boot.rst b/Documentation/driver-api/cxl/linux/early-boot.rst
new file mode 100644
index 000000000000..8c1c497bc772
--- /dev/null
+++ b/Documentation/driver-api/cxl/linux/early-boot.rst
@@ -0,0 +1,131 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+=======================
+Linux Init (Early Boot)
+=======================
+
+Linux configuration is split into two major steps: Early-Boot and everything else.
+
+During early boot, Linux sets up immutable resources (such as numa nodes), while
+later operations include things like driver probe and memory hotplug.  Linux may
+read EFI and ACPI information throughout this process to configure logical
+representations of the devices.
+
+During Linux Early Boot stage (functions in the kernel that have the __init
+decorator), the system takes the resources created by EFI/BIOS (ACPI tables)
+and turns them into resources that the kernel can consume.
+
+
+BIOS, Build and Boot Options
+============================
+
+There are 4 pre-boot options that need to be considered during kernel build
+which dictate how memory will be managed by Linux during early boot.
+
+* EFI_MEMORY_SP
+
+  * BIOS/EFI Option that dictates whether memory is SystemRAM or
+    Specific Purpose.  Specific Purpose memory will be deferred to
+    drivers to manage - and not immediately exposed as system RAM.
+
+* CONFIG_EFI_SOFT_RESERVE
+
+  * Linux Build config option that dictates whether the kernel supports
+    Specific Purpose memory.
+
+* CONFIG_MHP_DEFAULT_ONLINE_TYPE
+
+  * Linux Build config that dictates whether and how Specific Purpose memory
+    converted to a dax device should be managed (left as DAX or onlined as
+    SystemRAM in ZONE_NORMAL or ZONE_MOVABLE).
+
+* nosoftreserve
+
+  * Linux kernel boot option that dictates whether Soft Reserve should be
+    supported.  Similar to CONFIG_EFI_SOFT_RESERVE.
+
+Memory Map Creation
+===================
+
+While the kernel parses the EFI memory map, if :code:`Specific Purpose` memory
+is supported and detected, it will set this region aside as
+:code:`SOFT_RESERVED`.
+
+If :code:`EFI_MEMORY_SP=0`, :code:`CONFIG_EFI_SOFT_RESERVE=n`, or
+:code:`nosoftreserve=y` - Linux will default a CXL device memory region to
+SystemRAM.  This will expose the memory to the kernel page allocator in
+:code:`ZONE_NORMAL`, making it available for use for most allocations (including
+:code:`struct page` and page tables).
+
+If `Specific Purpose` is set and supported, :code:`CONFIG_MHP_DEFAULT_ONLINE_TYPE_*`
+dictates whether the memory is onlined by default (:code:`_OFFLINE` or
+:code:`_ONLINE_*`), and if online which zone to online this memory to by default
+(:code:`_NORMAL` or :code:`_MOVABLE`).
+
+If placed in :code:`ZONE_MOVABLE`, the memory will not be available for most
+kernel allocations (such as :code:`struct page` or page tables).  This may
+significant impact performance depending on the memory capacity of the system.
+
+
+NUMA Node Reservation
+=====================
+
+Linux refers to the proximity domains (:code:`PXM`) defined in the SRAT to
+create NUMA nodes in :code:`acpi_numa_init`. Typically, there is a 1:1 relation
+between :code:`PXM` and NUMA node IDs.
+
+SRAT is the only ACPI defined way of defining Proximity Domains. Linux chooses
+to, at most, map those 1:1 with NUMA nodes. CEDT adds a description of SPA
+ranges which Linux may wish to map to one or more NUMA nodes.
+
+If there are CXL ranges in the CFMWS but not in SRAT, then a fake :code:`PXM`
+is created (as of v6.15). In the future, Linux may reject CFMWS not described
+by SRAT due to the ambiguity of proximity domain association.
+
+It is important to note that NUMA node creation cannot be done at runtime. All
+possible NUMA nodes are identified at :code:`__init` time, more specifically
+during :code:`mm_init`. The CEDT and SRAT must contain sufficient :code:`PXM`
+data for Linux to identify NUMA nodes their associated memory regions.
+
+The relevant code exists in: :code:`linux/drivers/acpi/numa/srat.c`.
+
+See the Example Platform Configurations section for more information.
+
+Memory Tiers Creation
+=====================
+Memory tiers are a collection of NUMA nodes grouped by performance characteristics.
+During :code:`__init`, Linux initializes the system with a default memory tier that
+contains all nodes marked :code:`N_MEMORY`.
+
+:code:`memory_tier_init` is called at boot for all nodes with memory online by
+default. :code:`memory_tier_late_init` is called during late-init for nodes setup
+during driver configuration.
+
+Nodes are only marked :code:`N_MEMORY` if they have *online* memory.
+
+Tier membership can be inspected in ::
+
+  /sys/devices/virtual/memory_tiering/memory_tierN/nodelist
+  0-1
+
+If nodes are grouped which have clear difference in performance, check the HMAT
+and CDAT information for the CXL nodes.  All nodes default to the DRAM tier,
+unless HMAT/CDAT information is reported to the memory_tier component via
+`access_coordinates`.
+
+Contiguous Memory Allocation
+============================
+The contiguous memory allocator (CMA) enables reservation of contiguous memory
+regions on NUMA nodes during early boot.  However, CMA cannot reserve memory
+on NUMA nodes that are not online during early boot. ::
+
+  void __init hugetlb_cma_reserve(int order) {
+    if (!node_online(nid))
+      /* do not allow reservations */
+  }
+
+This means if users intend to defer management of CXL memory to the driver, CMA
+cannot be used to guarantee huge page allocations.  If enabling CXL memory as
+SystemRAM in `ZONE_NORMAL` during early boot, CMA reservations per-node can be
+made with the :code:`cma_pernuma` or :code:`numa_cma` kernel command line
+parameters.
-- 
2.49.0


