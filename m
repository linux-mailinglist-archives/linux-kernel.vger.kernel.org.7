Return-Path: <linux-kernel+bounces-753387-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A6D27B18235
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 15:13:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 823F83AC846
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 13:13:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A262E251799;
	Fri,  1 Aug 2025 13:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gQS0luzf"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F07F23E35F
	for <linux-kernel@vger.kernel.org>; Fri,  1 Aug 2025 13:13:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754054009; cv=none; b=M9qKDVVVcICM0iLc/4nr+OsaJGoo5TsUsU11aJMHi1WCnZA/5FHAlLr55MYYAjfwIi3++jY/JXZ+BcMIqoxaklryNyH7nPtez07olfi61byoiKP9wdFUI0CBPi4M9kpeSQtIwmzb9mQVaHfP1G03zo4hAbb+px14Sq2QaEgNwZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754054009; c=relaxed/simple;
	bh=NDqaf9lbxEaRm64yxxyEsy03EPkdWuBKt9nEAdu2dVk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=hDc1LcuC0gY+OGk7Z+7VsGBCeGhcOVyTuGGrqQZOI+8CrEHsbl/b+R+PTnm710SLSOTFD/ksgKCL1jtcQsT5/OqALwSrOZ2WKlIFYs9ZhDAG3SPH2rD1LvrvxEW0ZlQ9h1JOuJHg6EMroKPBYndZdB0HVXHrP0nytjfwDQ3GDVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gQS0luzf; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754054006;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=cw5+teQN0AMP87x3H2Uh+QGhf4VtRQnjJ3fqJ5dQbO0=;
	b=gQS0luzfv+My2kIgiC0iDqeiok//hAVNx5PysmwAn3GyIWaZJsLaqQmoeCn5lY4uJs+6BF
	/kzn5HkSY391Yhc60LVoU+Hkg4rBhHC9iwwCxojAIbnGpFMqgEyZ60iv3Z1Fj/RIdY0tBP
	YYFLehiHiaQZEOrtiHltrlG04zYDvH0=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-225-eQBpJodeM3eWmnO1D92wuw-1; Fri, 01 Aug 2025 09:13:25 -0400
X-MC-Unique: eQBpJodeM3eWmnO1D92wuw-1
X-Mimecast-MFC-AGG-ID: eQBpJodeM3eWmnO1D92wuw_1754054004
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-3b7891afb31so537233f8f.2
        for <linux-kernel@vger.kernel.org>; Fri, 01 Aug 2025 06:13:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754054002; x=1754658802;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cw5+teQN0AMP87x3H2Uh+QGhf4VtRQnjJ3fqJ5dQbO0=;
        b=PATZ0u7+z6NEtvFwK3h2TU/4vVfHhgABlQGszQxzzNTzQiV5cS2UpN3SroRgZ6W0zo
         j/cSf00jmAUF89Fsjq/T/KUGtvgyK2uW2sMitUjsZQ0P9lV1+PwnEDhbe3T0Xmvt0KDQ
         DMQjSSJJG4AgJfGTFz2mCp9mMD3w36i93DvUgEGDEAfR7B2vMnCKJptKvPXU2nDFUNEw
         15LEpoWf6JlM/BZ4wgnMQ6dEJegzfDT4ONvWt2qe20YCvXm/qBYBeToeBXijLEDFUrwy
         7QvLQni1TIkZzk6fqyxO3q0wB+AtViNdA9Bg8VHhZWG6xPR7ZLen5p1bKTPGKtui+ssU
         2fYw==
X-Forwarded-Encrypted: i=1; AJvYcCVXD2qejQTStE+93TKCtZ5Y4xkiNzQJK+oKNefw/pKAVN4gXYnxocwTEsPTf0Ew2jbUWuT+A6jYGwS5w4I=@vger.kernel.org
X-Gm-Message-State: AOJu0YyySx8mLWlvhpv1I0SA09pTdFtVkgA2bvTOsmExpaQ695FxciUY
	1uBK9o1w7k5NlgyPwxnXKfKkscG6q2/1uS73EVwf4jnlAq9xTeNICFe6wv1B1tFwYnaDifDnRU9
	M+QoqeM2tufFBaLu8BxBbii4lqKlMmhBTrvavlK9NiKBlYHe8qyei1/EAkXkzVdxUgQ==
X-Gm-Gg: ASbGncvWGluzATfI2LIVo5A5uq9iMFvbD9BDy+vNcq31nQa8TNGJDBWq+OyFTitxlcu
	TZBU9sFgnVmFpjMeiqZpH2HMmC9j9GCMKH2ngKgQh7XyDL2FthjMNSDjD4P+xIo+aom1f5efoyX
	CENJFAz23geINIWPqoaxA73uF4ir4tGKXJ2a+Ou/T6HN8hnl963GPrKntRuUBcJPcSb7ZAXk10e
	EXov6GTmrF9WL3T9DZXlkf8ZhArgNnbYjIUXqCCn+1DWRnTkE22+actBN1uNrLK3sg+SS8WEzEK
	o2kypmu3+BgO3Gt6vCkD60PzT6x8KpU1
X-Received: by 2002:a05:6000:2311:b0:3b7:81a6:45c1 with SMTP id ffacd0b85a97d-3b794fc2b76mr8552827f8f.6.1754054002385;
        Fri, 01 Aug 2025 06:13:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGJ3kgk/LB9Em5/+L4oKnLTGpba8hhaIHh5AL+aBInP59wFrNOjQfBJh5ZGXhgf1vfWGUgM8w==
X-Received: by 2002:a05:6000:2311:b0:3b7:81a6:45c1 with SMTP id ffacd0b85a97d-3b794fc2b76mr8552779f8f.6.1754054001893;
        Fri, 01 Aug 2025 06:13:21 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1515:7300:62e6:253a:2a96:5e3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b79c48de68sm5859929f8f.67.2025.08.01.06.13.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Aug 2025 06:13:21 -0700 (PDT)
Date: Fri, 1 Aug 2025 09:13:18 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: kvm@vger.kernel.org, virtualization@lists.linux-foundation.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	alok.a.tiwari@oracle.com, anders.roxell@linaro.org,
	dtatulea@nvidia.com, eperezma@redhat.com, eric.auger@redhat.com,
	jasowang@redhat.com, jonah.palmer@oracle.com, kraxel@redhat.com,
	leiyang@redhat.com, linux@treblig.org, lulu@redhat.com,
	michael.christie@oracle.com, mst@redhat.com, parav@nvidia.com,
	si-wei.liu@oracle.com, stable@vger.kernel.org,
	viresh.kumar@linaro.org, wangyuli@uniontech.com, will@kernel.org,
	wquan@redhat.com, xiaopei01@kylinos.cn
Subject: [GIT PULL v2] virtio, vhost: features, fixes
Message-ID: <20250801091318-mutt-send-email-mst@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mutt-Fcc: =sent

The following changes since commit 347e9f5043c89695b01e66b3ed111755afcf1911:

  Linux 6.16-rc6 (2025-07-13 14:25:58 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git tags/for_linus

for you to fetch changes up to 6693731487a8145a9b039bc983d77edc47693855:

  vsock/virtio: Allocate nonlinear SKBs for handling large transmit buffers (2025-08-01 09:11:09 -0400)

Changes from v1:
	drop commits that I put in there by mistake. Sorry!

----------------------------------------------------------------
virtio, vhost: features, fixes

vhost can now support legacy threading
	if enabled in Kconfig
vsock memory allocation strategies for
	large buffers have been improved,
	reducing pressure on kmalloc
vhost now supports the in-order feature
	guest bits missed the merge window

fixes, cleanups all over the place

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

----------------------------------------------------------------
Alok Tiwari (4):
      virtio: Fix typo in register_virtio_device() doc comment
      vhost-scsi: Fix typos and formatting in comments and logs
      vhost: Fix typos
      vhost-scsi: Fix check for inline_sg_cnt exceeding preallocated limit

Anders Roxell (1):
      vdpa: Fix IDR memory leak in VDUSE module exit

Cindy Lu (1):
      vhost: Reintroduce kthread API and add mode selection

Dr. David Alan Gilbert (2):
      vhost: vringh: Remove unused iotlb functions
      vhost: vringh: Remove unused functions

Dragos Tatulea (2):
      vdpa/mlx5: Fix needs_teardown flag calculation
      vdpa/mlx5: Fix release of uninitialized resources on error path

Gerd Hoffmann (1):
      drm/virtio: implement virtio_gpu_shutdown

Jason Wang (3):
      vhost: fail early when __vhost_add_used() fails
      vhost: basic in order support
      vhost_net: basic in_order support

Michael S. Tsirkin (2):
      virtio: fix comments, readability
      virtio: document ENOSPC

Mike Christie (1):
      vhost-scsi: Fix log flooding with target does not exist errors

Pei Xiao (1):
      vhost: Use ERR_CAST inlined function instead of ERR_PTR(PTR_ERR(...))

Viresh Kumar (2):
      virtio-mmio: Remove virtqueue list from mmio device
      virtio-vdpa: Remove virtqueue list

WangYuli (1):
      virtio: virtio_dma_buf: fix missing parameter documentation

Will Deacon (9):
      vhost/vsock: Avoid allocating arbitrarily-sized SKBs
      vsock/virtio: Validate length in packet header before skb_put()
      vsock/virtio: Move length check to callers of virtio_vsock_skb_rx_put()
      vsock/virtio: Resize receive buffers so that each SKB fits in a 4K page
      vsock/virtio: Rename virtio_vsock_alloc_skb()
      vsock/virtio: Move SKB allocation lower-bound check to callers
      vhost/vsock: Allocate nonlinear SKBs for handling large receive buffers
      vsock/virtio: Rename virtio_vsock_skb_rx_put()
      vsock/virtio: Allocate nonlinear SKBs for handling large transmit buffers

 drivers/gpu/drm/virtio/virtgpu_drv.c    |   8 +-
 drivers/vdpa/mlx5/core/mr.c             |   3 +
 drivers/vdpa/mlx5/net/mlx5_vnet.c       |  12 +-
 drivers/vdpa/vdpa_user/vduse_dev.c      |   1 +
 drivers/vhost/Kconfig                   |  18 ++
 drivers/vhost/net.c                     |  88 +++++---
 drivers/vhost/scsi.c                    |  24 +-
 drivers/vhost/vhost.c                   | 377 ++++++++++++++++++++++++++++----
 drivers/vhost/vhost.h                   |  30 ++-
 drivers/vhost/vringh.c                  | 118 ----------
 drivers/vhost/vsock.c                   |  15 +-
 drivers/virtio/virtio.c                 |   7 +-
 drivers/virtio/virtio_dma_buf.c         |   2 +
 drivers/virtio/virtio_mmio.c            |  52 +----
 drivers/virtio/virtio_ring.c            |   4 +
 drivers/virtio/virtio_vdpa.c            |  44 +---
 include/linux/virtio.h                  |   2 +-
 include/linux/virtio_vsock.h            |  46 +++-
 include/linux/vringh.h                  |  12 -
 include/uapi/linux/vhost.h              |  29 +++
 kernel/vhost_task.c                     |   2 +-
 net/vmw_vsock/virtio_transport.c        |  20 +-
 net/vmw_vsock/virtio_transport_common.c |   3 +-
 23 files changed, 575 insertions(+), 342 deletions(-)


