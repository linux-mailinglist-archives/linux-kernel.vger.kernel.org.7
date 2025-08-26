Return-Path: <linux-kernel+bounces-786542-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 68270B35C52
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 13:33:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2882D17E052
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 11:27:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A5F72BF3E2;
	Tue, 26 Aug 2025 11:27:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iAwaggyN"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EAB22BE03C
	for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 11:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756207642; cv=none; b=uvtnYbqodeYxk9N5rqwxy89b7VfzJU7lmaMA1ms5iliGgZV4Ft9BZdDKQvDzPs7wfBaAPE+hLCYTWNIGI+8b1MtvQgVOMap8YqFHpsuhXunI8TxvaSFE5KNct968qYfuG5U2aRY8iehAVf02fesGpy0jyIC1+W+dkoR/IXl3wKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756207642; c=relaxed/simple;
	bh=eqg9zf6FkyB+xl8m+3C1TXAQk0rMYY8paHFYDIi2P7g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=PDBmAqITpcwl33pNy2OR7vkWO4hiE/ffGEuejglv11Nt7NtDmk9uctTOQPFkdU43GrgPVsGL6avvLbwNAz246gqjwtZGoPb+qh1hwtE2/OlhD4SIUzqnOvYhiag1voCoJqbkH1c4JxDdl4Xal6oGU/BjufqweEeoSL/JXomOLUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iAwaggyN; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756207638;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=M+yP6wMJ27OA9eoLlW4sl9d1CWIKuSn4DTaJ9WLwbyI=;
	b=iAwaggyNWbcXzSIgmvWM5zl12pXyBcYc9YEOZy+MXPtRO1/wJonv9+DpGvJIvgWgVEkPtP
	Kw8p5FwYg2pfVSzRoAL9pVDm8sZ5P7WQTb/OyvLgKJgWDS1MvfHFs2qk+zsB0YjDsZIz49
	cEsed1P7X4WTfMp7LV2E9TzFQMUMMuM=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-447-1BDXUOjdOq6czNFu-H_qCQ-1; Tue,
 26 Aug 2025 07:27:17 -0400
X-MC-Unique: 1BDXUOjdOq6czNFu-H_qCQ-1
X-Mimecast-MFC-AGG-ID: 1BDXUOjdOq6czNFu-H_qCQ_1756207636
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E6A09195609F;
	Tue, 26 Aug 2025 11:27:15 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.45.224.67])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 3D6E41800280;
	Tue, 26 Aug 2025 11:27:10 +0000 (UTC)
From: =?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>
To: "Michael S . Tsirkin " <mst@redhat.com>
Cc: =?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Cindy Lu <lulu@redhat.com>,
	Stefano Garzarella <sgarzare@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Laurent Vivier <lvivier@redhat.com>,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	jasowang@redhat.com,
	Yongji Xie <xieyongji@bytedance.com>,
	Maxime Coquelin <mcoqueli@redhat.com>
Subject: [PATCH 0/6] Add multiple address spaces support to VDUSE
Date: Tue, 26 Aug 2025 13:27:03 +0200
Message-ID: <20250826112709.1051172-1-eperezma@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

When used by vhost-vDPA bus driver for VM, the control virtqueue
should be shadowed via userspace VMM (QEMU) instead of being assigned
directly to Guest. This is because QEMU needs to know the device state
in order to start and stop device correctly (e.g for Live Migration).

This requies to isolate the memory mapping for control virtqueue
presented by vhost-vDPA to prevent guest from accessing it directly.

This series add support to multiple address spaces in VDUSE device
allowing selective virtqueue isolation through address space IDs (ASID).

The VDUSE device needs to report:
* Number of virtqueue groups
* Association of each vq group with each virtqueue
* Number of address spaces supported.

Then, the vDPA driver can modify the ASID assigned to each VQ group to
isolate the memory AS.  This aligns VDUSE with gq}vdpa_sim and nvidia
mlx5 devices which already support ASID.

This helps to isolate the environments for the virtqueues that will not
be assigned directly. E.g in the case of virtio-net, the control
virtqueue will not be assigned directly to guest.

This series depends on the series that reworks the virtio mapping API:
https://lore.kernel.org/all/20250821064641.5025-1-jasowang@redhat.com/

Also, to be able to test this patch, the user needs to manually revert
56e71885b034 ("vduse: Temporarily fail if control queue feature requested").

PATCH v1:
* Fix: Remove BIT_ULL(VIRTIO_S_*), as _S_ is already the bit (Maxime)
* Using vduse_vq_group_int directly instead of an empty struct in union
  virtio_map.

RFC v3:
* Increase VDUSE_MAX_VQ_GROUPS to 0xffff (Jason). It was set to a lower
  value to reduce memory consumption, but vqs are already limited to
  that value and userspace VDUSE is able to allocate that many vqs.  Also, it's
  a dynamic array now.  Same with ASID.
* Move the valid vq groups range check to vduse_validate_config.
* Embed vduse_iotlb_entry into vduse_iotlb_entry_v2.
* Use of array_index_nospec in VDUSE device ioctls.
* Move the umem mutex to asid struct so there is no contention between
  ASIDs.
* Remove the descs vq group capability as it will not be used and we can
  add it on top.
* Do not ask for vq groups in number of vq groups < 2.
* Remove TODO about merging VDUSE_IOTLB_GET_FD ioctl with
  VDUSE_IOTLB_GET_INFO.

RFC v2:
* Cache group information in kernel, as we need to provide the vq map
  tokens properly.
* Add descs vq group to optimize SVQ forwarding and support indirect
  descriptors out of the box.
* Make iotlb entry the last one of vduse_iotlb_entry_v2 so the first
  part of the struct is the same.
* Fixes detected testing with OVS+VDUSE.

Eugenio Pérez (6):
  vduse: add v1 API definition
  vduse: add vq group support
  vduse: return internal vq group struct as map token
  vduse: create vduse_as to make it an array
  vduse: add vq group asid support
  vduse: bump version number

 drivers/vdpa/vdpa_user/vduse_dev.c | 385 ++++++++++++++++++++++-------
 include/linux/virtio.h             |   6 +-
 include/uapi/linux/vduse.h         |  73 +++++-
 3 files changed, 373 insertions(+), 91 deletions(-)

-- 
2.51.0


