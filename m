Return-Path: <linux-kernel+bounces-835538-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E0E1BA7690
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Sep 2025 21:07:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B35601896693
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Sep 2025 19:08:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78581258CE1;
	Sun, 28 Sep 2025 19:07:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vXTx54hs"
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EEF61E520C
	for <linux-kernel@vger.kernel.org>; Sun, 28 Sep 2025 19:07:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759086459; cv=none; b=JKfoB7BEy0vhumSXb/OpxCOg6FO8X4Z5necySemyt3k10O8t1i2OKuK5/AvmiQufTCr7Iuge660zmvsMK05Tx1LDNCUsyiAx77Z25iIt8DiF6WyBleel7Gm1n2bJV3PqioNjDQ68/6iWFoLS/glpmktTDedEvX/S5UzBrMn0ytU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759086459; c=relaxed/simple;
	bh=H6Wm9ozMmZV2pb3ZG6RNK4gxFNnU5cfXK0YmgrPvVBU=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=SCsZp8hUBEh2rDK4HSkv86m552FnV9PykbXqDf4iHcqPHr59F6RnDP4u9uGNM2Sm0XKK7NhtwAtglyG2UyDL2XnzaKemIPjMhiVEE2AbSYFN/yly1HxXYHGjtwEycN/7Hfx41hn6peSn4SXqBqAr15wRRSAZZjaIssMLj5XzXRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--skhawaja.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vXTx54hs; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--skhawaja.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-77f64c5cf62so2781219b3a.2
        for <linux-kernel@vger.kernel.org>; Sun, 28 Sep 2025 12:07:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1759086457; x=1759691257; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=GB3kGFNim4Mm7zWG7PONZgVbhZKzbAMqfiGB/R/xfhA=;
        b=vXTx54hsNFY/rRDw9ghfloS0vUErh6pb3/O7hi2F0ErMYhgC03DrUSi2gW+eXyqUlR
         zTwXvDaP+aqcHrpzojOaD5zHXv9QICPq4SYyTxJUwZUZrmxtfzUq0b3tZl/8p/orJCez
         hxsK8oHYysJvGKoXxX3FVLE/gnQ0Mj1gR9MwCiIkDFbjyZmQbCZ0qr6kW6ub1JO9xH3g
         yHjuej1gcnN6aUJlb75BE8XkdsohGIRGKcywUOcueWZcN483qtpcxV3tEAHfv9pw4JJE
         Hs5EJ3OYe9hdY0W4Ub6JcAI6r5fabywIrgVlofWp2hZMNpzHr39kfxRNF4tHpac+0+/W
         mf1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759086457; x=1759691257;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GB3kGFNim4Mm7zWG7PONZgVbhZKzbAMqfiGB/R/xfhA=;
        b=OJXNUpHvrvbQlfMSRt6OGTusXW8s4n6EGmbMfqHm8GBntVY313g6HRYtpSgyw7xI9m
         OSv95vwL+qa96xiZvsChqbr7oWBIELAuZeGEsFFx/U/gSw5YFxhAzj/tb87vmDJOjH8W
         3kCLzSTp5x/3Q0DXF/lCom9xdSzp3JFK+yMUwdF/1/r1vDVWv+nr0vC1d1gcDaBwtEJ/
         k+g45AcS4TvxwU3fQhu2wmpuJpBFLr64o/Zxx6lrYvsIpf223MM6Kr/EB0VwjBTUWPmb
         IaqU+tJJK0Za2wubck1KMxaC9wyHgFxH/oBt3dVLb8XNjXTAl5Hm5s3rFbRkTPrQRVT1
         4tpA==
X-Forwarded-Encrypted: i=1; AJvYcCUroIVtpI4q5aTNsQyz+Y1X8GyncjeZF45F4Ffd3JrBvqXHjsB4ez9tzyu0zKXlACMrE9YaO/wCl+dAQIM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy83n+ZHWZrjXz4g49rNl0yeJDSrp0erSEfZAhWxx+UfO/gZ5uV
	xTcDWgIgvFQTQNJ8vFfwY0fEByOp0DqqsSmcp4SDwFDUtVjSWj2YD/1IhQnDWMk/FBUpbRppeeH
	PLpypn0b9HFEEPw==
X-Google-Smtp-Source: AGHT+IEfLwPi8l+BMF32ZHs+xLB/dePFHjMOHkrgXkLOgW2974cQQUCNMewG/1nxl9UuUE/7LK8bbJvx8GT7Aw==
X-Received: from pfdr8.prod.google.com ([2002:aa7:8b88:0:b0:781:178d:8149])
 (user=skhawaja job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:180f:b0:781:1562:1f9e with SMTP id d2e1a72fcca58-7811562213bmr10853721b3a.32.1759086456836;
 Sun, 28 Sep 2025 12:07:36 -0700 (PDT)
Date: Sun, 28 Sep 2025 19:06:08 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.51.0.536.g15c5d4f767-goog
Message-ID: <20250928190624.3735830-1-skhawaja@google.com>
Subject: [RFC PATCH 00/15] iommu: Add live update state preservation
From: Samiullah Khawaja <skhawaja@google.com>
To: David Woodhouse <dwmw2@infradead.org>, Lu Baolu <baolu.lu@linux.intel.com>, 
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, Jason Gunthorpe <jgg@ziepe.ca>, iommu@lists.linux.dev
Cc: Samiullah Khawaja <skhawaja@google.com>, Robin Murphy <robin.murphy@arm.com>, 
	Pratyush Yadav <pratyush@kernel.org>, Kevin Tian <kevin.tian@intel.com>, linux-kernel@vger.kernel.org, 
	Saeed Mahameed <saeedm@nvidia.com>, Adithya Jayachandran <ajayachandra@nvidia.com>, 
	Parav Pandit <parav@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, William Tu <witu@nvidia.com>, 
	Vipin Sharma <vipinsh@google.com>, dmatlack@google.com, zhuyifei@google.com, 
	Chris Li <chrisl@kernel.org>, praan@google.com
Content-Type: text/plain; charset="UTF-8"

Hi,

This RFC patch series introduces a mechanism for IOMMU state
preservation across live update, using the Intel VT-d driver as the
initial example implementation and demonstration platform.

Please take a look at the following LWN article to learn about KHO and
Live Update Orchestrator:

https://lwn.net/Articles/1033364/

This work is based on the LUOv3 patch series listed below. Please find
the details of various live update states, file descriptor and subsystem
preservation callbacks, and memory preservation mechanisms in the LUOv3
series.

https://lore.kernel.org/all/20250807014442.3829950-1-pasha.tatashin@soleen.com/

The kernel tree with all dependencies is uploaded to the following
Github location:

https://github.com/googleprodkernel/linux-liveupdate/tree/iommu/rfc-v1

Overall Goals:

The goal of this effort is to preserve the IOMMU domains, of devices
marked for preservation, managed by iommufd. This allows DMA mappings
and IOMMU context of a device assigned to a VM to be maintained across
a live update.

This will be ultimately achieved by preserving IOMMU page tables, IOMMU
root table and the relevant context entries across live update.

Current Implementation, Scope and Limitations:

This RFC provides foundational mechanisms and demonstrates the
end-to-end workflow. It only implements the preservation of the minimum
IOMMU state, which includes the root table and context tables.

Specifically, it includes:

 - Registration of the Intel VT-d IOMMU driver with the Live Update
   Orchestrator.
 - Registration of iommufd as a file handler with Live Update
   Orchestrator.
 - A subsystem-wide rw_semaphore to protect live update state and
   operations.
 - An API iommu_domain_preserve to preserve IOMMU domains for
   preservation. Currently it only marks them as preserved.
 - Implementation for preserving and restoring the Intel IOMMU root and
   context tables.
 - A selftest to validate the end-to-end preservation and restoration of
   an iommufd file descriptor.

This version does not yet preserve the DMA mappings (page tables)
themselves. This means that ongoing DMA from a device will not continue
to work across the live update. This is a known limitation that will be
addressed in future work.

It is important to note that the preservation of the device state itself
is outside the scope of this series.

The series also does not yet include a versioning scheme for the
persisted state; this will be added later.

Target Architectural Overview:

The target architecture for IOMMU state preservation across a live
update involves coordination between the Live Update Orchestrator,
iommufd, and the IOMMU drivers.

The core design uses the Live Update Orchestrator's file descriptor
preservation mechanism to preserve iommufd file descriptors. During
preservation, the LUO prepare callback for an iommufd walks through the
IOMMU domains it manages to identify the ones associated with devices
marked for preservation. Once identified, Generic Page Table support
will be used to preserve the page tables of these domains. The domains
are then marked as preserved.

The Live Update Orchestrator's subsystem mechanism will be used to
preserve the IOMMU context entries and the associated root table.

It is important to note that the preservation of the device state is
outside the scope of this patch series. This series focuses solely on
the IOMMU subsystem's role in supporting live update for such preserved
devices.

Critical Design Considerations:

After a live update, we can restore the IOMMU domain using two
approaches,

1. Reuse the preserved page tables:

During boot the next kernel can prepare the new domain reusing the
existing preserved page tables and reattach the devices to it. The
restored domain can be retrieved and reclaimed when the iommufd file
descriptor is restored.

2. Hotswap a new domain on finish:

During boot the next kernel can setup domains for all the preserved
devices without updating context entries, so these devices can keep on
using the old preserved page tables. The userspace VMM can restore the
iommufd, create IOAS/HWPT, attach devices to it and setup DMA mappings.
Once Live Update Orchestrator moves to the finish state, the context
entries of the preserved devices can be updated and replaced with the
new IOMMU domains and page tables that are cooked in the new kernel.

I am inclined towards the "Hotswap" approach, as it involves restoring
the minimum state from the previous kernel and lets user space
regenerate the mappings. This provides a clean way of discarding the old
kernel state and using the new kernel data structures. I will share more
details on the specifics of this approach in future versions of this
series.

High-Level Sequence Flow:

The following diagrams illustrate the high-level interactions during the
preservation phase. The diagrams also contain parts that are not
implemented in this series.

Prepare:

Before live update the PREPARE event of Liveupdate Orchestrator invokes
callbacks of the registered file and subsystem handlers.

 Userspace (VMM) |   LUO   |     iommufd     |   IOMMU Core    | Driver
-----------------|---------|-----------------|-----------------|--------
                 |         |                 |                 |
Preserve iommufd |         |                 |                 |
----------------->         |                 |                 |
                 | register|                 |                 |
<-----------------         |                 |                 |
                 |         |                 |                 |
                 |         |                 |                 |
  PREPARE        |         |                 |                 |
----------------->         |                 |                 |
                 |         |                 |                 |
                 | Call FS |                 |                 |
                 | handle  |                 |                 |
                 |--------->                 |                 |
                 |         | Preserve Domain |                 |
                 |         |----------------->                 |
                 |         |                 | Preserve using  |
		 |         |                 | Generic-Page    |
                 |         |                 |    Tables       |
                 |         |                 |----------------->
                 |         |                 |                 | Preserve
		 |         |                 |                 | Domain
		 |         |                 <------------------
		 |         <------------------                 |
                 |         | Return phys     |                 |
		 | save    | Address of      |                 |
		 <---------- state           |                 |
                 |         |                 |                 |
                 |         |                 |                 |
                 | subsys  |                 |                 |
                 | handle  |                 |                 |
                 |--------------------------------------------->
                 |         |                 |                 | Save iommu
		 |         |                 |                 | state
		 |         |                 |                 |
		 |         |                 |                 | Return phys
		 |         |                 |                 | Address of
		 |         |                 |                 | state
                 |         <------------------------------------
		 | save    |                 |                 |

Restore:

After a live update, the preserved state is restored during boot and/or
when userspace retrieves the preserved FDs.

 Userspace (VMM) |   LUO   |     iommufd     |   IOMMU Core    | Driver
-----------------|---------|-----------------|-----------------|--------
                 |         |                 |                 | Init
                 |         |                 |                 |
                 |         |                 |                 | get phys
                 |         |                 |                 | address
                 |         <------------------------------------
                 | Return  |                 |                 |
                 | addr    |                 |                 |
                 |         ------------------------------------>
                 |         |                 |                 | Restore root
                 |         |                 |                 | table
                 |         |                 |                 |
Retrieve iommufd |         |                 |                 |
-----------------> Call FS |                 |                 |
                 | handle  |                 |                 |
                 |--------->                 |                 |
                 |         | Restore         |                 |
                 <----------                 |                 |
                 |         |                 |                 |
Attach IOAS      |         |                 |                 |
--------------------------->                 |                 |
                 |         | Attach          |                 |
                 |         ------------------>                 |
                 |         |                 | attach          |
                 |         |                 ------------------> Attach domain
		 |         |                 |                 | w/o context
		 |         |                 |                 | update
                 |         |                 <------------------
                 <----------------------------                 |
                 |         |                 |                 |
                 |         |                 |                 |
FINISH           |         |                 |                 |
----------------->         |                 |                 |
                 |FS handle|                 |                 |
		 ---------->                 |                 |
                 |         | Hotswap context |                 |
                 |         ------------------>                 |
		 |         |                 | Update Context  |
                 |         |                 |----------------->
                 |         |                 |                 | Update
		 |         |                 |                 | Context
		 |         | Release old     <------------------
                 |         | page tables     |                 |
		 |         <------------------                 |
                 |         |                 |                 |

Tested:

This series was tested using QEMU with virtual IOMMU (VT-d) support. The
workflow was validated using a guest with virtio-net device bound to the
vfio-pci driver.

The new iommufd_liveupdate selftest was used to verify the end-to-end
preservation logic:

1. The selftest is run for the first time. It opens the VFIO device,
   attaches it to an iommufd instance, and then uses the
   LIVEUPDATE_IOCTL_FD_PRESERVE ioctl to mark the iommufd file descriptor
   for preservation.

2. The test then triggers the LIVEUPDATE_PREPARE event, which in turn
   triggers the preservation of the iommufd instance and the IOMMU
   state.

3. The guest is rebooted using kexec.

4. After reboot, the selftest is run a second time. It detects the
   LIVEUPDATE_STATE_UPDATED state and restores the iommud file
   descriptor via the LIVEUPDATE_IOCTL_FD_RESTORE ioctl.

Future Work:

This RFC is the foundation for a more complete solution. The planned
next steps are:

- Implement the chosen page table preservation and restoration strategy
  (Hotswap or Reuse).
- Keep the IOMMU translation enabled during shutdown.
- Add support for preserving PASID tables for devices that use them.
- Implement a versioning scheme for serialized data to ensure
  compatibility across kernel versions.
- Extend support to other IOMMU architectures (e.g., AMD-Vi, Arm SMMUv3).

I am looking forward to feedback on this initial approach and the target
architecture.

Samiullah Khawaja (12):
  iommu/vt-d: Register with Live Update Orchestrator
  iommu: Add rw_semaphore to serialize live update state
  iommu/vt-d: Prevent hotplugs when live update state is not normal
  iommu: Add preserve iommu_domain op
  iommu: Introduce API to preserve iommu domain
  iommu/vt-d: Add stub intel iommu domain preserve op
  iommu/vt-d: Add implementation of live update prepare callback
  iommu/vt-d: Implement live update preserve_iommu_context
  iommu/vt-d: Add live update freeze callback
  iommu/vt-d: Restore iommu root_table and context on live update
  iommu/vt-d: sanitize restored root table and iommu contexts
  iommufd/selftest: Add test to verify iommufd preservation

YiFei Zhu (3):
  iommufd: Add basic skeleton based on liveupdate_file_handle
  iommufd-luo: Implement basic prepare/cancel/finish/retrieve using
    folios
  iommufd: Persist iommu domains for live update

 MAINTAINERS                                   |   2 +
 drivers/iommu/intel/Makefile                  |   1 +
 drivers/iommu/intel/dmar.c                    |   9 +
 drivers/iommu/intel/iommu.c                   |  15 +-
 drivers/iommu/intel/iommu.h                   |   9 +
 drivers/iommu/intel/liveupdate.c              | 401 ++++++++++++++++++
 drivers/iommu/iommu.c                         |  24 ++
 drivers/iommu/iommufd/Makefile                |   1 +
 drivers/iommu/iommufd/iommufd_private.h       |  27 ++
 drivers/iommu/iommufd/liveupdate.c            | 236 +++++++++++
 drivers/iommu/iommufd/main.c                  |  16 +-
 include/linux/iommu.h                         |  22 +
 tools/testing/selftests/iommu/Makefile        |   1 +
 .../selftests/iommu/iommufd_liveupdate.c      | 196 +++++++++
 14 files changed, 956 insertions(+), 4 deletions(-)
 create mode 100644 drivers/iommu/intel/liveupdate.c
 create mode 100644 drivers/iommu/iommufd/liveupdate.c
 create mode 100644 tools/testing/selftests/iommu/iommufd_liveupdate.c


base-commit: 454219033bd8093293af8fbd4de47142530bdedc
-- 
2.51.0.536.g15c5d4f767-goog


