Return-Path: <linux-kernel+bounces-729659-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 512F3B039CC
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 10:48:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A98053BC7AD
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 08:47:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61CF423BCFA;
	Mon, 14 Jul 2025 08:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="T9G8kgBk"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A7401D63E6
	for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 08:48:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752482890; cv=none; b=KqPJBp+f3bzWP0Xkkn3+KiWg3njOmKVkjH+xgUVJbKNsebUZtAIOeFK/cN92sU1+Ob4G/7+r2f/JH0So2NzORHeYkfIErgGv01LEphX6qK7Pw1J06TBTLuL5OT7wUvJpZn37fi4M5LBS9YiAMqPI4m6ysQe34Rlq//qOWSOeWTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752482890; c=relaxed/simple;
	bh=2niaVsTmWeDEc1GLMp2VpCA/RTFr3wbMcCJdr+ANmuA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=HJTqFzjl+K+k5ixD/e5/pHg1QQY6O5ML83DXgd+dasgYHgQ+9ctQDAeybhy66MyRjqY3rVMEa0l01j6pccPOdtrMinTXFcWr28OFN40EKodKuQITajWP46RVnV+1BALGcy6NLK6oQwQ7+EBqJyzLs9NZxv4S56gpuvW5UDf9rcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=T9G8kgBk; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752482888;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=2gVoPhyx6QmIeHT3O2/lEXU8D3dbckG15WcXenmrf30=;
	b=T9G8kgBkL8tgeSWCuVZgGd0tPrTDs9w1XY7cY0uv1DdqvqG6O2kZoVTEIDon8/mezvfaYt
	BHdgA+Prwa3TYFA2urmCUbQ28MPX6anZlV0hx4imysEJx+wedu6pGG+KUsetib2Nbhv4qq
	PINqYA9DmG1uDqEQoTixfrrsYn9FZ6o=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-452-h7jNacrzNwGlmuqQFUoXGw-1; Mon,
 14 Jul 2025 04:48:06 -0400
X-MC-Unique: h7jNacrzNwGlmuqQFUoXGw-1
X-Mimecast-MFC-AGG-ID: h7jNacrzNwGlmuqQFUoXGw_1752482885
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 410711956089;
	Mon, 14 Jul 2025 08:48:05 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.72.112.55])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 2568218002B5;
	Mon, 14 Jul 2025 08:48:00 +0000 (UTC)
From: Jason Wang <jasowang@redhat.com>
To: mst@redhat.com,
	jasowang@redhat.com,
	eperezma@redhat.com
Cc: kvm@vger.kernel.org,
	virtualization@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	jonah.palmer@oracle.com
Subject: [PATCH net-next V2 0/3] in order support for vhost-net
Date: Mon, 14 Jul 2025 16:47:52 +0800
Message-ID: <20250714084755.11921-1-jasowang@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

Hi all,

This series implements VIRTIO_F_IN_ORDER support for vhost-net. This
feature is designed to improve the performance of the virtio ring by
optimizing descriptor processing.

Benchmarks show a notable improvement. Please see patch 3 for details.

Changes since V1:
- add a new patch to fail early when vhost_add_used() fails
- drop unused parameters of vhost_add_used_ooo()
- conisty nheads for vhost_add_used_in_order()
- typo fixes and other tweaks

Thanks

Jason Wang (3):
  vhost: fail early when __vhost_add_used() fails
  vhost: basic in order support
  vhost_net: basic in_order support

 drivers/vhost/net.c   |  88 +++++++++++++++++++++---------
 drivers/vhost/vhost.c | 123 ++++++++++++++++++++++++++++++++++--------
 drivers/vhost/vhost.h |   8 ++-
 3 files changed, 171 insertions(+), 48 deletions(-)

-- 
2.39.5


