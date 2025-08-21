Return-Path: <linux-kernel+bounces-779059-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA1B9B2EE96
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 08:48:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8D1B93AEFC2
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 06:47:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65E912E88B9;
	Thu, 21 Aug 2025 06:46:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iXeTNRi/"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12E352E339C
	for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 06:46:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755758818; cv=none; b=quiInpIs4tqLKKRgnVSnNWCbmrO0tO8T1wVb/TNLzuqK/83NAHIZUrN5U50V461zNXq8tUlN8F381maESRGhxkvdBGoR/CGZDUPnwzPQWZB/llE5kj+Le4nbnjMnd0DQdqtLPUxw8OyWj5AoIExzCrwq7hPJmQD4Ovgbi0fbIGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755758818; c=relaxed/simple;
	bh=+6yvn0YKKNDiUHlCWquUONeWP3JYOVSD0tnUrZBOAb0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=dAG6yXMPmT7xZ8e2nc0jqRcyKo6PUViPOoLBpp6XQw3cZexQu95RQvAI7wTygFFXXoc8kDOxZDcMiaJbg0W/vJ7AftCDbDTo8xBqYHY9xtPvF4I19te/ZJXRtUjKrrJxyt8Jf0Yt8Xu379oFPAe12FGhjI9t2FiI59gTnrxnbKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iXeTNRi/; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755758815;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=1LNt7Lxc+ABGXS8RVj1hI9eGxGKQG1KQTnyDB4zLACI=;
	b=iXeTNRi/u+oPCv1LweV5jeoE4hDrw+1fi7qDsJ7EXtz7qxWowGRBOZ/OuyihelHweNlFVM
	6ZUtLBXrTz9AwtWO5EatlxjZ6lEuaJy5WwVXgQQUiXBvJqBfl7D5ZzXhY/wlFlEOC4PW05
	s4fJIBGIToFsaCY0FOMu/KeD1dCn5x0=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-10-d-dkKdJSMwSeqqROXS1tPw-1; Thu,
 21 Aug 2025 02:46:52 -0400
X-MC-Unique: d-dkKdJSMwSeqqROXS1tPw-1
X-Mimecast-MFC-AGG-ID: d-dkKdJSMwSeqqROXS1tPw_1755758811
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7AAB71956088;
	Thu, 21 Aug 2025 06:46:50 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.72.112.130])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 7766A19560B0;
	Thu, 21 Aug 2025 06:46:45 +0000 (UTC)
From: Jason Wang <jasowang@redhat.com>
To: mst@redhat.com,
	jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com
Cc: virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	hch@infradead.org
Subject: [PATCH V6 0/9] Refine virtio mapping API
Date: Thu, 21 Aug 2025 14:46:32 +0800
Message-ID: <20250821064641.5025-1-jasowang@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

Hi all:

Virtio used to be coupled with DMA API. This works fine for the device
that do real DMA but not the others. For example, VDUSE nees to craft
with DMA API in order to let the virtio-vdpa driver to work.

This series tries to solve this issue by introducing the mapping API
in the virtio core. So transport like vDPA can implement their own
mapping logic without the need to hack with DMA API. The mapping API
are abstracted with a new map operations in order to be re-used by
transprot or device. So device like VDUSE can implement its own
mapping loigc.

For device that uses DMA (for example PCI device), the virtio core
will still call DMA API directly without the need of implementing map
ops per device/transport.

Please review.

Changes since V5:

- Rename mapping_token to virtio_map
- Do not use opaque void * pointer, just use a forward decalration of
  vduse_iova_domain
- Remove unused variable and typo fixes

Changes since V4:

- Rename map_token to mapping_token
- Introduce a union container for opaque token as well as the DMA
  device so we won't lose the type safety
- Do not try to set DMA mask for VDUSE device
- Introduce a new mapper_error op for API completeness

Changes since V3:

- Fix build error of PDS vDPA driver

Changes since V2:

- Drop VDUSE dependenct for HAS_DMA and ARCH_HAS_DMA_OPS

Changes since V1:

- Fix build error of mlx5_vdpa driver


Jason Wang (9):
  virtio_ring: constify virtqueue pointer for DMA helpers
  virtio_ring: switch to use dma_{map|unmap}_page()
  virtio: rename dma helpers
  virtio: introduce virtio_map container union
  virtio_ring: rename dma_handle to map_handle
  virtio: introduce map ops in virtio core
  vdpa: support virtio_map
  vdpa: introduce map ops
  vduse: switch to use virtio map API instead of DMA API

 drivers/net/virtio_net.c                 |  28 +-
 drivers/vdpa/Kconfig                     |   8 +-
 drivers/vdpa/alibaba/eni_vdpa.c          |   5 +-
 drivers/vdpa/ifcvf/ifcvf_main.c          |   5 +-
 drivers/vdpa/mlx5/core/mr.c              |   4 +-
 drivers/vdpa/mlx5/net/mlx5_vnet.c        |  15 +-
 drivers/vdpa/octeon_ep/octep_vdpa_main.c |   6 +-
 drivers/vdpa/pds/vdpa_dev.c              |   5 +-
 drivers/vdpa/solidrun/snet_main.c        |   8 +-
 drivers/vdpa/vdpa.c                      |   5 +-
 drivers/vdpa/vdpa_sim/vdpa_sim.c         |   4 +-
 drivers/vdpa/vdpa_user/iova_domain.c     |   2 +-
 drivers/vdpa/vdpa_user/iova_domain.h     |   2 +-
 drivers/vdpa/vdpa_user/vduse_dev.c       |  79 ++--
 drivers/vdpa/virtio_pci/vp_vdpa.c        |   5 +-
 drivers/vhost/vdpa.c                     |   6 +-
 drivers/virtio/virtio_ring.c             | 459 ++++++++++++++---------
 drivers/virtio/virtio_vdpa.c             |  20 +-
 include/linux/vdpa.h                     |  25 +-
 include/linux/virtio.h                   |  46 ++-
 include/linux/virtio_config.h            |  72 ++++
 include/linux/virtio_ring.h              |   7 +-
 22 files changed, 531 insertions(+), 285 deletions(-)

-- 
2.31.1


