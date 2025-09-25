Return-Path: <linux-kernel+bounces-832242-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D0E5B9EBD8
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 12:40:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D966E1C20974
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 10:40:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4E9A2EA159;
	Thu, 25 Sep 2025 10:37:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RxmbRY7Z"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74BF52EFD8C
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 10:37:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758796644; cv=none; b=VukPG2w1mYOKnTCx1hjOOq7pDJVrkgqmF6IPjg7n8uhJn3zqaWG55piWhp4cnDo5xee0k+mD3a7N/14wFPhWY/bDDkieh0lurSwHcw7xO2uj3RtwHeB6IbOpx16wqy5Lb+Tia8WQnuRw/ylH63oDE6h+2gSB2duu6wlOUZ5Luls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758796644; c=relaxed/simple;
	bh=4+zKr2yoqvxat5W1m7gLDcddQ5j6BzIrsDrF/lKuBPA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=YxOv+ZDBvPcHKAWnYn/izp++FA3XZNRfL4L6FQskuk9oA6O7Y3gtaJ1SH3KT5Q25DAq1Ox2bU60tZ5bvN4PgMwdZZB8xKiglcW6ZMZnMQuwrxBrGIu2sPH4wkY9UwWVq+7fBt6VsipfAazHDVpqIAne8AyPICIDOUnVDkX7RCpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RxmbRY7Z; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758796641;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=pXTK8H73rTFtCvf5wagp3rWhk7oI2YrssL3FPDtIawI=;
	b=RxmbRY7Z+Npn2D45V2PFwanRkPPo8prqQmuT1O6Y/3IciLKCby8FBw8QqeB5s6SBxqtG8h
	uYqmAOagfa0L+s6u/ghzm0NLJ/o3sIN9XvtJmvNf8kFxPY3NB21r6d2ckOjTufv2uUscSR
	QF3GthR7KI+71O+vgDTLIpMr5H0JXPs=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-608-ojmW6dMuNeyxk2PVDldh3A-1; Thu,
 25 Sep 2025 06:37:19 -0400
X-MC-Unique: ojmW6dMuNeyxk2PVDldh3A-1
X-Mimecast-MFC-AGG-ID: ojmW6dMuNeyxk2PVDldh3A_1758796638
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 878D1180057F;
	Thu, 25 Sep 2025 10:37:18 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.72.112.10])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 0449119560A2;
	Thu, 25 Sep 2025 10:37:14 +0000 (UTC)
From: Jason Wang <jasowang@redhat.com>
To: mst@redhat.com,
	jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com
Cc: virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH V7 00/19] virtio_ring in order support
Date: Thu, 25 Sep 2025 18:36:49 +0800
Message-ID: <20250925103708.44589-1-jasowang@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

Hello all:

This sereis tries to implement the VIRTIO_F_IN_ORDER to
virtio_ring. This is done by introducing virtqueue ops so we can
implement separate helpers for different virtqueue layout/features
then the in-order were implemented on top.

Tests shows 2%-19% imporvment with packed virtqueue PPS with KVM guest
vhost-net/testpmd on the host.

Changes since V6:

- Rebase on vhost.git linux-next branch
- Fix poking packed virtqueue in more_used_split_in_order()
- Fix calling detach_buf_packed_in_order() unconditonally in
  virtqueue_detach_unused_buf_packed()
- Typo and indentation fixes
- Fix wrong changelog of patch 7

Changes since V5:

- rebase on vhost.git linux-next branch
- reorder the total_len to reduce memory comsuming

Changes since V4:

- Fix build error when DEBUG is enabled
- Fix function duplications
- Remove unnecessary new lines

Changes since V3:

- Re-benchmark with the recent vhost-net in order support
- Rename the batched used id and length
- Other minor tweaks

Changes since V2:

- Fix build warning when DEBUG is enabled

Changes since V1:

- use const global array of function pointers to avoid indirect
  branches to eliminate retpoline when mitigation is enabled
- fix used length calculation when processing used ids in a batch
- fix sparse warnings

Jason Wang (19):
  virtio_ring: rename virtqueue_reinit_xxx to virtqueue_reset_xxx()
  virtio_ring: switch to use vring_virtqueue in virtqueue_poll variants
  virtio_ring: unify logic of virtqueue_poll() and more_used()
  virtio_ring: switch to use vring_virtqueue for virtqueue resize
    variants
  virtio_ring: switch to use vring_virtqueue for virtqueue_kick_prepare
    variants
  virtio_ring: switch to use vring_virtqueue for virtqueue_add variants
  virtio: switch to use vring_virtqueue for virtqueue_get variants
  virtio_ring: switch to use vring_virtqueue for enable_cb_prepare
    variants
  virtio_ring: use vring_virtqueue for enable_cb_delayed variants
  virtio_ring: switch to use vring_virtqueue for disable_cb variants
  virtio_ring: switch to use vring_virtqueue for detach_unused_buf
    variants
  virtio_ring: use u16 for last_used_idx in virtqueue_poll_split()
  virtio_ring: introduce virtqueue ops
  virtio_ring: determine descriptor flags at one time
  virtio_ring: factor out core logic of buffer detaching
  virtio_ring: factor out core logic for updating last_used_idx
  virtio_ring: factor out split indirect detaching logic
  virtio_ring: factor out split detaching logic
  virtio_ring: add in order support

 drivers/virtio/virtio_ring.c | 892 ++++++++++++++++++++++++++---------
 1 file changed, 681 insertions(+), 211 deletions(-)

-- 
2.31.1


