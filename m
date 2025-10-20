Return-Path: <linux-kernel+bounces-860209-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E77ABEF994
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 09:10:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F1E693E1266
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 07:10:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E5C72D97A4;
	Mon, 20 Oct 2025 07:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="K+SXB1Tg"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A579027B34F
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 07:10:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760944221; cv=none; b=daK+WljBwY/MnH4INkFmsSAx2gVQVVmnGaUIQKD5BKDetNvqn2rqAWOXadHqkKmIMwaX7nCx8RKx7wXtwk63BNznyxnRSz6TC1K0AculWT+177fdyZX5SPtwZhQjQ7wqTBe0cb2fF6pJwuRRD2v8vJ8ESKlDLFoiSjv8yF4Xcos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760944221; c=relaxed/simple;
	bh=KOU9GyDaASWKisx8BmLM99cBgeucuzjzt0jChLtWuNw=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Vzr/J8IuD+QjEXJq2oGHYshebkKcJfs1nX4NtVZDbCpasQkJZOh/gScNdKeGDVCt5+gOIfTe5aaDpFHuGhXbJbc99K/+NQwso/PrzGQXnxN+fZ2rVNvCQX+oQXl8aSSrTQ1lW4y/rLexlY8iwt5rOJYSJdToe6auSjGx4Syxv6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=K+SXB1Tg; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760944217;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=hJbazs23YnXcdtzatFb21nkxkEatw0SF03fWxtNheFs=;
	b=K+SXB1Tg1NFtdvQz8Yr54Y3au7Nn3L7o/AdyW/lBjSpzEB/dBcR1cSNw14pfkXqu3Nm6fO
	K+rpdEgr32lNdmlBmTaVsITTUbE00rdVlAmdRWPQMg2X43XGAe/JiApR23JiSf0MbYNlqY
	LJpP2HfM7FwyiBWVV2jueQC6pNQWmAk=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-680-JVnNU5PBPJunJIjy0olk-g-1; Mon,
 20 Oct 2025 03:10:14 -0400
X-MC-Unique: JVnNU5PBPJunJIjy0olk-g-1
X-Mimecast-MFC-AGG-ID: JVnNU5PBPJunJIjy0olk-g_1760944213
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 0250F1956089;
	Mon, 20 Oct 2025 07:10:13 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.72.113.29])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 1C90530001A2;
	Mon, 20 Oct 2025 07:10:09 +0000 (UTC)
From: Jason Wang <jasowang@redhat.com>
To: mst@redhat.com,
	jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH V8 00/19] virtio_ring in order support
Date: Mon, 20 Oct 2025 15:09:44 +0800
Message-ID: <20251020071003.28834-1-jasowang@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

Hello all:

This sereis tries to implement the VIRTIO_F_IN_ORDER to
virtio_ring. This is done by introducing virtqueue ops so we can
implement separate helpers for different virtqueue layout/features
then the in-order were implemented on top.

Tests shows 2%-19% imporvment with packed virtqueue PPS with KVM guest
vhost-net/testpmd on the host.

Changes since v7:

- Rebase on vhost.git linux-next branch
- Tweak the comment to explain the usage of free_head

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
  virtio_ring: switch to use unsigned int for virtqueue_poll_packed()
  virtio_ring: introduce virtqueue ops
  virtio_ring: determine descriptor flags at one time
  virtio_ring: factor out core logic of buffer detaching
  virtio_ring: factor out core logic for updating last_used_idx
  virtio_ring: factor out split indirect detaching logic
  virtio_ring: factor out split detaching logic
  virtio_ring: add in order support

 drivers/virtio/virtio_ring.c | 905 ++++++++++++++++++++++++++---------
 1 file changed, 692 insertions(+), 213 deletions(-)

-- 
2.31.1


