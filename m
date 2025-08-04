Return-Path: <linux-kernel+bounces-755717-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EC1CB1AAD8
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 00:22:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 790D31651A4
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 22:22:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D112228FFE3;
	Mon,  4 Aug 2025 22:22:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GkolwitE"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8049A28FFC6
	for <linux-kernel@vger.kernel.org>; Mon,  4 Aug 2025 22:22:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754346133; cv=none; b=tWg6ZgP9dPWebRGPOHpNmQypq+J07qdX+Vz2ELcp4/0I+piVjszLOQHoh9Ui8GLyOT8+/Zq4Ze+ExEr0LyAhbh8rQYGYcu6mgykonGfPaZR8Q6j/4JB+TwvuIHkQMZyTT9BFXBdeSdQXOqJLpEOQT7PEzgFszrSkDXsENlFMn5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754346133; c=relaxed/simple;
	bh=Dn5p2DuKosNzWsO5ifWRe1Ae6wx1PGjXcUmxu50cMos=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=GeNSKkhzEoWNJAGClEYD9OlVHTQUS/BmNOmXeMUAk5zUmo8nepw3vMDSP6ghAE/SbNUQXSdkB5Ora6UF+jG+LMU4ANyP+1MAiRUC3nbIMeR1gF/lDBr8tkbsPrWDpiC5vVBrJvPfwp1AoKxG9Flca6g7mHOC7yXh6WlU1zFaTXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GkolwitE; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754346130;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=F5E3U/trUdUUx6dKnWFWrFF9mfVwnnDI83X6XjlvZJQ=;
	b=GkolwitE86p1ee3l2nIjLZY/d1DDtuB+A0tNsbF1T5hAqjuX7VnMYVtRtS/66W6rqE/GCl
	DM22Z5K+Vzm4WnMXIiR6aEhwjy/WFtMOhm4atjRCJQdFY56E7b5a04uT/cy4SI7qNKUYdJ
	3/yHomajCaPzJGuWoiwuPtncaIHfiJA=
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com
 [209.85.166.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-396-bdQAFo1XOCeSPgTRPPffNA-1; Mon, 04 Aug 2025 18:22:09 -0400
X-MC-Unique: bdQAFo1XOCeSPgTRPPffNA-1
X-Mimecast-MFC-AGG-ID: bdQAFo1XOCeSPgTRPPffNA_1754346125
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3e3fdfa4b39so6069525ab.2
        for <linux-kernel@vger.kernel.org>; Mon, 04 Aug 2025 15:22:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754346124; x=1754950924;
        h=content-transfer-encoding:mime-version:organization:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F5E3U/trUdUUx6dKnWFWrFF9mfVwnnDI83X6XjlvZJQ=;
        b=CNmgSCEcfx9mg1MXXkv/Ki3RU+iEUa6Gl08SQLyfjWZe+87L1Tdaa2zcV67tSZABvA
         lVknqCtxizlsCodPP+frFxL0GW2n34JOuCOjJ98rVALuaIXTS1qvCkzvryW0f09xmEUP
         O1fmvYZotMSxOr6PBqFDSLAQbgFn0n9+gM+jXNtZE2aWXXXS7EgpyRvyU21vVS7LhIn+
         9U+oW/rvb7urE1QV92JbtlubX+PRw9OXMm+RYeiwTHWcm0X1rA7eHCnSbT01TbcHgocE
         xZa4MppZuHbo2BH5o6pQUTMWr7fk98QQF2z1rWr1BfxJO4873LMabGXWC5+zkdQf6HU2
         rb4g==
X-Forwarded-Encrypted: i=1; AJvYcCVrXFaZadOMbEiIg9+nplx+X2JbErjXdr24oKMcsXK9lXQOTtX0w3tXSqpVxWgVw27Y0QO1dsJEFkI+2sw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzwFih4zONOfUcJqz2fFvNnYjtIaUL2mpvzlreUvXOaaS6CUAQp
	oXWguzaD2UeJf1tyBRbB35mYygOEDx1Q70oYf6jg3+xDNN/lBXdwdqUjaBSk5JXL4M6uFAgD0LI
	X+cgCLCzFIGJplPrbjRpuoP7/lzc6BEEJCCxntpwHBu04nSb+oVcm20+L6Y6En222XNw2R95UMA
	==
X-Gm-Gg: ASbGnct2gS/GmovRwFKVpiy5kRB+9B6lMLjOb6o0MNWKkAP8NCjEjb8J/nwnhOQgxur
	KVA1SVIvX4LyM3/jS8MQFOcomJxqfadZvvwEkeo97xARfrzfzfSfZffCW9MaF3d8q23ZRdljlg9
	rrErwQRzmiESYHDRLu6IFG4kCI4n2VLk1AgvzzNTfGHCEsQt1DZqafb0D/2rlG/kyfxWm9f8phL
	UAKMwqrWNF+5zXS0w9/sKFFd/dMaV8kha+cDuiuB4KscESP+bL2IcIGTBbDWoVGz4DyyXhiRXhT
	JQ4fOFvVEG1G/PCGLOBz15VjmY60AzDqDqfflpCi4po=
X-Received: by 2002:a92:c24b:0:b0:3e3:d2eb:52db with SMTP id e9e14a558f8ab-3e41609c100mr61811005ab.0.1754346124554;
        Mon, 04 Aug 2025 15:22:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGH2zVAoDEtPLJzV17HpXe2fDF+PkSDQ1w8BFQmkDQplAPkXAXjmhrdiRK3sFXly2gZ6zCa8A==
X-Received: by 2002:a92:c24b:0:b0:3e3:d2eb:52db with SMTP id e9e14a558f8ab-3e41609c100mr61810885ab.0.1754346124094;
        Mon, 04 Aug 2025 15:22:04 -0700 (PDT)
Received: from redhat.com ([38.15.36.11])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-50ab0bb98d9sm367388173.90.2025.08.04.15.22.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Aug 2025 15:22:03 -0700 (PDT)
Date: Mon, 4 Aug 2025 16:22:01 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] VFIO updates for v6.17-rc1
Message-ID: <20250804162201.66d196ad.alex.williamson@redhat.com>
Organization: Red Hat
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Linus,

The following changes since commit d7b8f8e20813f0179d8ef519541a3527e7661d3a:

  Linux 6.16-rc5 (2025-07-06 14:10:26 -0700)

are available in the Git repository at:

  https://github.com/awilliam/linux-vfio.git tags/vfio-v6.17-rc1

for you to fetch changes up to d2272d898186fa96c6fa4ad067219b45b8c2ef5f:

  vfio/type1: correct logic of vfio_find_vpfn() (2025-07-27 08:20:31 -0600)

----------------------------------------------------------------
VFIO updates for v6.17-rc1

 - Fix imbalance where the no-iommu/cdev device path skips too much
   on open, failing to increment a reference, but still decrements
   the reference on close.  Add bounds checking to prevent such
   underflows. (Jacob Pan)

 - Fill missing detach_ioas op for pds_vfio_pci, fixing probe failure
   when used with IOMMUFD. (Brett Creeley)

 - Split SR-IOV VFs to separate dev_set, avoiding unnecessary
   serialization between VFs that appear on the same bus.
   (Alex Williamson)

 - Fix a theoretical integer overflow is the mlx5-vfio-pci variant
   driver. (Artem Sadovnikov)

 - Use batching on contiguous pages to significantly improve DMA map
   and unmap performance when using hugetlbfs or THP backed memory
   with the legacy vfio type1 IOMMU backend. (Li Zhe)

 - Implement missing VF token checking support via vfio cdev/IOMMUFD
   interface. (Jason Gunthorpe)

 - Update QAT vfio-pci variant driver to claim latest VF devices.
   (Ma=C5=82gorzata Mielnik)

 - Add a cond_resched() call to avoid holding the CPU too long during
   DMA mapping operations. (Keith Busch)

----------------------------------------------------------------
Alex Williamson (1):
      vfio/pci: Separate SR-IOV VF dev_set

Artem Sadovnikov (1):
      vfio/mlx5: fix possible overflow in tracking max message size

Brett Creeley (1):
      vfio/pds: Fix missing detach_ioas op

Jacob Pan (2):
      vfio: Fix unbalanced vfio_df_close call in no-iommu mode
      vfio: Prevent open_count decrement to negative

Jason Gunthorpe (1):
      vfio/pci: Do vf_token checks for VFIO_DEVICE_BIND_IOMMUFD

Keith Busch (1):
      vfio/type1: conditional rescheduling while pinning

Li Zhe (6):
      mm: introduce num_pages_contiguous()
      vfio/type1: optimize vfio_pin_pages_remote()
      vfio/type1: batch vfio_find_vpfn() in function vfio_unpin_pages_remot=
e()
      vfio/type1: introduce a new member has_rsvd for struct vfio_dma
      vfio/type1: optimize vfio_unpin_pages_remote()
      vfio/type1: correct logic of vfio_find_vpfn()

Ma=C5=82gorzata Mielnik (1):
      vfio/qat: add support for intel QAT 6xxx virtual functions

Xin Zeng (1):
      vfio/qat: Remove myself from VFIO QAT PCI driver maintainers

 MAINTAINERS                                    |   1 -
 drivers/vfio/device_cdev.c                     |  38 +++++++-
 drivers/vfio/group.c                           |   7 +-
 drivers/vfio/iommufd.c                         |   4 +
 drivers/vfio/pci/hisilicon/hisi_acc_vfio_pci.c |   1 +
 drivers/vfio/pci/mlx5/cmd.c                    |   4 +-
 drivers/vfio/pci/mlx5/main.c                   |   1 +
 drivers/vfio/pci/nvgrace-gpu/main.c            |   2 +
 drivers/vfio/pci/pds/vfio_dev.c                |   2 +
 drivers/vfio/pci/qat/main.c                    |   5 +-
 drivers/vfio/pci/vfio_pci.c                    |   1 +
 drivers/vfio/pci/vfio_pci_core.c               |  24 +++--
 drivers/vfio/pci/virtio/main.c                 |   3 +
 drivers/vfio/vfio_iommu_type1.c                | 118 ++++++++++++++++++++-=
----
 drivers/vfio/vfio_main.c                       |   3 +-
 include/linux/mm.h                             |  23 +++++
 include/linux/vfio.h                           |   4 +
 include/linux/vfio_pci_core.h                  |   2 +
 include/uapi/linux/vfio.h                      |  12 ++-
 19 files changed, 212 insertions(+), 43 deletions(-)


