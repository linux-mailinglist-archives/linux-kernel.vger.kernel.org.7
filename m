Return-Path: <linux-kernel+bounces-773225-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F944B29CE7
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 10:59:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 297D23B8296
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 08:57:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03C69308F06;
	Mon, 18 Aug 2025 08:57:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KlzMiOE5"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B304D307AD4
	for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 08:57:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755507445; cv=none; b=N7Zu1tp1pm8FwNXBSNOxVqMU69vQTKl2m4onBL9qz7vFTdqt3VwGnaj07Xpkt8HETOqiKhb0GTPouW9Cm2TQdHuy/Qcj7VIr1zJZkX4utxP+YSu1WWR/nz8yzFV5E4qs6/FD10OahMxoCORHcOmOg1iZMy3OUVqOCFjzeKmpRTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755507445; c=relaxed/simple;
	bh=1vD0b+NbL7zn+wNw+0SqpL3I9v+5+ESXqgiX0nxgEGY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=sfGgr4DqIUDMLxppiVp/Jk4gPK6MxxwKJOwmmNlMfTk+A1PDisraUpMKFrGctKfVAeDn9eXJ8DbGCNiQ9cbv4lZ6CDZ+65O/O5yoqvpbV5hvfip/rqbWlyTe351FH7U8XvbEkqfIrER9cjmziNnx1CLaiqS7JiVErDRS/14H+eo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KlzMiOE5; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755507442;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=BoHX2gnB2hICa4aYGq3mQ5MkH4urA39vEsLwOdQhShI=;
	b=KlzMiOE5zVFBS0E9G9+IJRH6SnZqmySPFaiImXX70rrKg0cjzjg6HZMPQcA+Oh99qRfjvA
	EXT9pmdTKg3ER977DonaehmBw8gQbtubqOzq3RPdekGbHlhS1iIPsKNI/1xtN7jC/iLtck
	3zj4gVMedQzfppop4V/gY7AQhn7KNDg=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-686-O8rd3TVONVyHOKVfVxtNXA-1; Mon,
 18 Aug 2025 04:57:19 -0400
X-MC-Unique: O8rd3TVONVyHOKVfVxtNXA-1
X-Mimecast-MFC-AGG-ID: O8rd3TVONVyHOKVfVxtNXA_1755507438
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C700F1800289;
	Mon, 18 Aug 2025 08:57:17 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.44.32.213])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 9AC9E180028B;
	Mon, 18 Aug 2025 08:57:13 +0000 (UTC)
From: =?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>
To: "Michael S . Tsirkin " <mst@redhat.com>
Cc: =?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Laurent Vivier <lvivier@redhat.com>,
	virtualization@lists.linux.dev,
	jasowang@redhat.com,
	Cindy Lu <lulu@redhat.com>,
	linux-kernel@vger.kernel.org,
	Maxime Coquelin <mcoqueli@redhat.com>,
	Yongji Xie <xieyongji@bytedance.com>,
	Stefano Garzarella <sgarzare@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Subject: [RFC v3 0/7] Add multiple address spaces support to VDUSE
Date: Mon, 18 Aug 2025 10:57:04 +0200
Message-ID: <20250818085711.3461758-1-eperezma@redhat.com>
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

This is still a RFC as it depends on the series that reworks the virtio mapping
API:
https://lore.kernel.org/all/20250813054831.25865-1-jasowang@redhat.com/

As some changes has been requested to it, these will need to be applied here
too.

Also, to be able to test this patch, the user needs to manually revert
56e71885b034 ("vduse: Temporarily fail if control queue feature requested").

RFC: Not tested, just sent to justify the use of generic tokens in Jason's DMA
rework.

v3:
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

v2:
* Cache group information in kernel, as we need to provide the vq map
  tokens properly.
* Add descs vq group to optimize SVQ forwarding and support indirect
  descriptors out of the box.
* Make iotlb entry the last one of vduse_iotlb_entry_v2 so the first
  part of the struct is the same.
* Fixes detected testing with OVS+VDUSE.

Eugenio Pérez (7):
  vduse: add v1 API definition
  vduse: add vq group support
  vdpa: change map_token from void * to an empty struct
  vduse: return internal vq group struct as map token
  vduse: create vduse_as to make it an array
  vduse: add vq group asid support
  vduse: bump version number

 drivers/vdpa/vdpa_user/vduse_dev.c | 439 ++++++++++++++++++++++-------
 drivers/virtio/virtio_ring.c       |   6 +-
 include/linux/virtio.h             |   8 +-
 include/linux/virtio_config.h      |  34 ++-
 include/uapi/linux/vduse.h         |  73 ++++-
 5 files changed, 438 insertions(+), 122 deletions(-)

-- 
2.50.1


