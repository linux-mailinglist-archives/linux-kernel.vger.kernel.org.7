Return-Path: <linux-kernel+bounces-627650-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 51B11AA536D
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Apr 2025 20:13:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1B3359C518B
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Apr 2025 18:13:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07E9127A47C;
	Wed, 30 Apr 2025 18:11:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="Muuz36gD"
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9171E264637
	for <linux-kernel@vger.kernel.org>; Wed, 30 Apr 2025 18:11:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746036675; cv=none; b=EmlO8bRWfOQ4Y5j43ykZhLMlXEWzuYddnmAj83NpHOJpp9I8ZTyOb4EusjXPVvjg1VyFELJPI9qgkZ4AHRQ4lX7ndI30bmyklO3WcKiv4v4xUyha4bU2c840w405dQ8xaZpsrdqWk1VQE92HDA6pKJiliX+nHDTNOtG85YRWv2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746036675; c=relaxed/simple;
	bh=qXpnbfIY4MHNlBZ+ICKzhTwqxRePbWx527+2t0bvHME=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aDO1gVCDa1PaYEJlK5Rto6DvjGpeQJMrvmrl9giRwLTgrO+aVrUUMNvAWochk9JGU8H2fFFcoCw2XIBMVh4u3W32tAMJrbJpiDWsMOxwSZB3zwQlVb7SMg5igh8AXUtCgUPX92caP+p8CcP9aJTz/hsAn9PB+KMvjBz8ulVlnS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=Muuz36gD; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-47688ae873fso2445531cf.0
        for <linux-kernel@vger.kernel.org>; Wed, 30 Apr 2025 11:11:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1746036671; x=1746641471; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fJ/G4knbx3sdIg268xzLvXJt5d2OlhH6CUst4oqvV4o=;
        b=Muuz36gD8NyyDy0ggpRgiX3x/os7K2CDSD476Ivw2eOdppEtrMmpSIKzovoxCXnKD4
         6Cv4VscDCVFT8rBKK0TrGRE9xIDzslx3b3BOb6iGJ+DXqQGB+QITVHSfCLClweNRXKU5
         IA0mgiy1COLjDwR7Gd6kgqi8dWDry/DxWxJGXPCwnF0mEVXJW3oRNVAgYYaXFKk7j64s
         PX18XxN79LztwGVcDAdkSY010bwKUTif1WMf3W7nMv7xbtSNXwuYlZ7lXVsuHaAgtLzm
         yH20kKxDcf9OKXqsBKabwZBz05Dwzg3Ndy1QiPBWjyUq8R6MqhEaJLu3ueqHkK9zXHrB
         v/Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746036671; x=1746641471;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fJ/G4knbx3sdIg268xzLvXJt5d2OlhH6CUst4oqvV4o=;
        b=tJkCJ120tB2zJUABIHBufjtoVCilv+5f08UD/afsAkDR2NSR6Ch/B6euKt6dNapuX6
         5NbzE88SZ6aTf9EwVSH+bSpmqJENy7Br6LfmjP8uPbyd0J8wo4RT8pjy14lusxhCFYdd
         bqH10R3WWQOHxHGH5vTuIJh6zMOk5CIODMjKfaRPFKae/+PvvX+JoHVePlq+CCBlUiZu
         WBPSWGk9qK5L8zOPzee9ipnz05z3RcItX5jx9G0i/SaVTo/BVs7ut5J8oTwDQyk+mPTH
         a4fQLlXt3ah2NC/OFKYfZMU/Lp+sftlvz9riQ2dznw/G/TwlYvmpUel7cd5pgOYvpHqS
         Jbzg==
X-Forwarded-Encrypted: i=1; AJvYcCUk7yEerfb2UwjkM28won1yFhvYot87uBvZ4QFmcESFAiCF8xiYu9ru53pPz/TzhNKyalg+xaXAkaReCBg=@vger.kernel.org
X-Gm-Message-State: AOJu0YymyCgPfEe9dUQb0/54JSqrbvMuvdaEoncbGFzgW0F9FDppFO+2
	YFKPvDTKbDJJXFiFueZn92UfmAyt7Y8TQyRAuT+HiQPRSiw9vl1SfhPUG4BZrRY=
X-Gm-Gg: ASbGncvA8Dj6wrPZRH4a8urYE60jwb7YMn/u+Dbc8ShVj97/H1lQV2BFAnUGl2eDSvJ
	JwAqvUU2yIEkt6kFr3xChgF7z0f9aqqkUjKRev7xMn7in3Roh4244/z81o/Nrh8KrIKA6zIJxsz
	SndABwDfmHcGvdzDAKPIpjEFIgb+fXcvP0ir9nWe4vazrdHs/n92wUclWFvlN33wfDOMmK+dqiz
	sp8bH9CsQviO+zjmucO/0VmSRiHyYA4ixZ2NQ0L9d7lik1UjzGL5923VyNLZaE5U9WhM1dKAcQA
	W+59MSxWN6hn0b+ql6zOLd99PlfH68JBFfcN+qWIJyPEJwO01dEn8KzlVzglC+FtGAguP12NlLm
	vmYbrqWYvBleARTyqmWtgHn2J/Ayg
X-Google-Smtp-Source: AGHT+IHIAJajNhKleOD9+KQtZV+Yd7Q03vZYD8x7ZENKbLpEcaPEOkfUzLCBnnhcth+doGjRWmib/A==
X-Received: by 2002:a05:622a:2b46:b0:476:9296:80a4 with SMTP id d75a77b69052e-48ae7157635mr3010001cf.7.1746036671289;
        Wed, 30 Apr 2025 11:11:11 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F.lan (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-48a64fe04efsm5897421cf.19.2025.04.30.11.11.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Apr 2025 11:11:10 -0700 (PDT)
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
Subject: [RFC PATCH v2 07/18] cxl: docs/linux - early boot configuration
Date: Wed, 30 Apr 2025 14:10:37 -0400
Message-ID: <20250430181048.1197475-8-gourry@gourry.net>
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

Document __init time configurations that affect CXL driver probe
process and memory region configuration.

Signed-off-by: Gregory Price <gourry@gourry.net>
---
 Documentation/driver-api/cxl/index.rst        |   1 +
 .../driver-api/cxl/linux/early-boot.rst       | 130 ++++++++++++++++++
 2 files changed, 131 insertions(+)
 create mode 100644 Documentation/driver-api/cxl/linux/early-boot.rst

diff --git a/Documentation/driver-api/cxl/index.rst b/Documentation/driver-api/cxl/index.rst
index 284ac71bf292..fea07c4c2f91 100644
--- a/Documentation/driver-api/cxl/index.rst
+++ b/Documentation/driver-api/cxl/index.rst
@@ -35,6 +35,7 @@ that have impacts on each other.  The docs here break up configurations steps.
    :caption: Linux Kernel Configuration
 
    linux/overview
+   linux/early-boot
    linux/access-coordinates
 
 
diff --git a/Documentation/driver-api/cxl/linux/early-boot.rst b/Documentation/driver-api/cxl/linux/early-boot.rst
new file mode 100644
index 000000000000..275174d5b0bb
--- /dev/null
+++ b/Documentation/driver-api/cxl/linux/early-boot.rst
@@ -0,0 +1,130 @@
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
+is supported and detect, it will set this region aside as :code:`SOFT_RESERVED`.
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
+ranges which Linux may wish to map to one or more NUMA nodes
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


