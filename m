Return-Path: <linux-kernel+bounces-757959-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 893B2B1C8D4
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 17:35:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 43DF03B06D2
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 15:35:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FA3F292B45;
	Wed,  6 Aug 2025 15:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PrZg0tBh"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EECC024503C
	for <linux-kernel@vger.kernel.org>; Wed,  6 Aug 2025 15:35:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754494519; cv=none; b=U5+uLV92SXECStQGQ/nNGlFoqGyURhaFMttWqAftjUfLllGlAFLlWWWk3fVJUPJvEvjp2jkTkRsKdWTYT5Jjuok7Gx3BPGSXH8NJfoNsWPbChBRO9WS2lz1WQ+BU/uFEcsaHq92czHm51bkah9bAJKiWxyx2h3BG80+9zXk6VyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754494519; c=relaxed/simple;
	bh=cF98SEkmgLDyuUz5la2IFBq9eSKef3X/kl1+HDLc3So=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=V/IVEPShaTZ70j+iHzNiOOdtxMKiL1wvGUK28aRmjKPdUExpdILNrRmmFuQEJFdD7C+M94//O9oa0gSrnJfKXxYBwRSkGiQLY20hw0DJOLxoSsigmNoRY2wnuKy9fgC1On/mqCcoSmS4f1BzvOxpV+Fwc9aWLgT+HPsHpnhire8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PrZg0tBh; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754494516;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=KdUYeA7YCatcEo56/VENniS5EQAYeVyAwozRoB1GUX4=;
	b=PrZg0tBh5oG4WKgvbB0eyQed3nN6xBLxxbFOJlFoQSlO9iReTeBUAsA12Z3t31JEL/zjRG
	BL32sX4JytPdSF69R0Jh0z0fT3kWPndit5YNkW/NuGBIjxyKGOKGCQHhAuA9GjwVLX/3pl
	CUXDArtPjrNrBBEXcqWNKBH4b3Cm4tM=
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com
 [209.85.166.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-550-ti5M1cX9M_Clvkgns-JvfQ-1; Wed, 06 Aug 2025 11:35:15 -0400
X-MC-Unique: ti5M1cX9M_Clvkgns-JvfQ-1
X-Mimecast-MFC-AGG-ID: ti5M1cX9M_Clvkgns-JvfQ_1754494515
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-88185368a51so26856339f.3
        for <linux-kernel@vger.kernel.org>; Wed, 06 Aug 2025 08:35:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754494515; x=1755099315;
        h=content-transfer-encoding:mime-version:message-id:subject:cc:to
         :from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KdUYeA7YCatcEo56/VENniS5EQAYeVyAwozRoB1GUX4=;
        b=ipi5GEB7U6JmZOx45JO6wjqoNabmjfJenCYRAYO+XbKwHfdqUDISycoSSiSQzCQxPo
         1xx3zBsFj5VjkiOVDjYekPQDJvowRbeEPcEiB3lb0O+rDEmJ9CCU+mL38BQgHeaWfcxr
         p06n8FCeUx9+e7R+ifw//wJJkmrKmq9RU0mHmZn286HYa93kKAl/2PeuLPL7nA0VTtkQ
         ug2nVJH7THcW42VVaaLA1t6hmUWBTsI2U8tuDV84iCmv8Qyc+o1Z77NTdMToRRGMX/rS
         Z9uL/mtgfljcvuVopZW825IYEM2zIdQlJBghoqeyb31BFlSqSjAO8CoZ9EYaIY9cRN7k
         vdig==
X-Gm-Message-State: AOJu0YyeYcPhTgYSNHRA8XTedrj5VY4P+Xcdyw1fKAd9irHzuVe6kikC
	avsIdDUJ4LOLo3khWw3zxSj9Mg+yayKzu/kFFM/OHoU3XuyAe9UCx1Z6MCHFxY3rGadlxhPp6rq
	HFw5D+Y5mnmmWPofbebjaoYyhgr0VJFD0TV1TTKUhq86/BoiCennFzoOPe0fAk1fQvA==
X-Gm-Gg: ASbGncvfAaHdoNGcTDd+Yqr+XyZdHeJFTzU6/DzcJlhL1PJsMvNOBlwP2AKm1sdQjYR
	ORXBK9/lzlC7x4pJqJhEpcXfumzWqDLqqfvbBhu71ZZVrNaam6HR+e+sWxr5lKLQbJ+qL3m9AeE
	9Az+r5fMgvgg8kxMnhP7OwPWZKs03trKxGTf0LJB3OchT3KTG9PMpeR+vOYySTvvXawIeRlcM6P
	kVQsmgvRYxjT5IWLB9r8UFflpdyH8eTNdUhOEWH7HU9skRmy+014bfRic3g7CUImxRuHGxW9xh9
	6NmzIC3kWAvxQQFe76bR2vY/LtzflWy0MpPMiGMUW5s=
X-Received: by 2002:a05:6602:3407:b0:881:982b:9963 with SMTP id ca18e2360f4ac-8819f15d6eamr165283639f.3.1754494514872;
        Wed, 06 Aug 2025 08:35:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEr61K454O/LcAG5ElZj+GaCuS+x7EaUPT+YI54dzPgtM40KpgzZ/COM65VNEppBUAYn+Bk5Q==
X-Received: by 2002:a05:6602:3407:b0:881:982b:9963 with SMTP id ca18e2360f4ac-8819f15d6eamr165281739f.3.1754494514338;
        Wed, 06 Aug 2025 08:35:14 -0700 (PDT)
Received: from redhat.com ([38.15.36.11])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-50a55da3351sm4982001173.87.2025.08.06.08.35.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Aug 2025 08:35:13 -0700 (PDT)
Date: Wed, 6 Aug 2025 09:35:11 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: <linux-kernel@vger.kernel.org>, "kvm@vger.kernel.org"
 <kvm@vger.kernel.org>, David Hildenbrand <david@redhat.com>, Jason
 Gunthorpe <jgg@nvidia.com>, "lizhe.67@bytedance.com"
 <lizhe.67@bytedance.com>
Subject: [GIT PULL] VFIO updates for v6.17-rc1 v2
Message-ID: <20250806093511.2909a521.alex.williamson@redhat.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Linus,

I've dropped the series with the troublesome mm helper in this pull
request.  We'll continue to work towards something acceptable there and
re-target it for v6.18.  Thanks,

Alex

The following changes since commit d7b8f8e20813f0179d8ef519541a3527e7661d3a:

  Linux 6.16-rc5 (2025-07-06 14:10:26 -0700)

are available in the Git repository at:

  https://github.com/awilliam/linux-vfio.git tags/vfio-v6.17-rc1-v2

for you to fetch changes up to b1779e4f209c7ff7e32f3c79d69bca4e3a3a68b6:

  vfio/type1: conditional rescheduling while pinning (2025-08-05 15:41:19 -=
0600)

----------------------------------------------------------------
VFIO updates for v6.17-rc1 v2

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

Ma=C5=82gorzata Mielnik (1):
      vfio/qat: add support for intel QAT 6xxx virtual functions

Xin Zeng (1):
      vfio/qat: Remove myself from VFIO QAT PCI driver maintainers

 MAINTAINERS                                    |  1 -
 drivers/vfio/device_cdev.c                     | 38 ++++++++++++++++++++++=
++--
 drivers/vfio/group.c                           |  7 ++---
 drivers/vfio/iommufd.c                         |  4 +++
 drivers/vfio/pci/hisilicon/hisi_acc_vfio_pci.c |  1 +
 drivers/vfio/pci/mlx5/cmd.c                    |  4 +--
 drivers/vfio/pci/mlx5/main.c                   |  1 +
 drivers/vfio/pci/nvgrace-gpu/main.c            |  2 ++
 drivers/vfio/pci/pds/vfio_dev.c                |  2 ++
 drivers/vfio/pci/qat/main.c                    |  5 +++-
 drivers/vfio/pci/vfio_pci.c                    |  1 +
 drivers/vfio/pci/vfio_pci_core.c               | 24 ++++++++++------
 drivers/vfio/pci/virtio/main.c                 |  3 ++
 drivers/vfio/vfio_iommu_type1.c                |  7 +++++
 drivers/vfio/vfio_main.c                       |  3 +-
 include/linux/vfio.h                           |  4 +++
 include/linux/vfio_pci_core.h                  |  2 ++
 include/uapi/linux/vfio.h                      | 12 +++++++-
 18 files changed, 99 insertions(+), 22 deletions(-)


