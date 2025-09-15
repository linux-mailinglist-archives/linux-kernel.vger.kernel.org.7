Return-Path: <linux-kernel+bounces-816032-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 40984B56E66
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 04:47:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CCE4D16A079
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 02:47:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9183222585;
	Mon, 15 Sep 2025 02:47:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gWbZW3Cv"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D4251DF248
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 02:47:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757904443; cv=none; b=Oxb6Hn6uj5jf2MZ7Au3ssGVfe7WNWUk2+pTBtXHd9+ahJJaCSlckgVyiymgUFuqZTMUpKtbNP9/eBmfQ87jJK4UHEJkbqkfPfqRibtaNLqLWV2zvbPgYxG4eu4KVzozCCdLiLYc+OUMZlZc0t6ywVk7MelV12nb9201ZfWFg8jY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757904443; c=relaxed/simple;
	bh=OOFDWJmS/f2uGkz6mS7atM5O/HZ8ia2l4cQssj9gFGE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aJ7ENgvdkXLaSvGgABM1o6r1R1ng62uwlX5dRrCIDGKEG8bVk5Di+9OAGvhUShMmrls11kNhB2UCr6DVj7hfqKODc5vbWz+UaAozdnGnCQvOzwr82wNwXSQxwhz/QUfBlUsXL3EGp50Wk6F2y3TGgqNJ4trCqjRGXZ0RzlmBcBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gWbZW3Cv; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757904440;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=tXbb4k0WVEIXwl73Se7rsi16GpKXRhgcEypjnLnCxSQ=;
	b=gWbZW3CvMqfKYq6PSKwlhMIpvPPizrvccZYKNVn1RWkgL5dcy9tEqBQOgsp88RYRXGVI6u
	qnS9cbYlzE6Io7dkcrCxOavgSB7U3OH+c7f3h/RLVTAwzs+gwdcQUeAKtB2DQyGRBdpI1A
	gdVVsv5fy4uiCt6P6bW5n1gLx4K6Wq0=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-12-7lvU5FqcOUyefsuZCnGIAA-1; Sun,
 14 Sep 2025 22:47:15 -0400
X-MC-Unique: 7lvU5FqcOUyefsuZCnGIAA-1
X-Mimecast-MFC-AGG-ID: 7lvU5FqcOUyefsuZCnGIAA_1757904434
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5D40B1956050;
	Mon, 15 Sep 2025 02:47:14 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.72.112.230])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 71AEC1800447;
	Mon, 15 Sep 2025 02:47:06 +0000 (UTC)
From: Jason Wang <jasowang@redhat.com>
To: mst@redhat.com,
	jasowang@redhat.com,
	eperezma@redhat.com
Cc: jonah.palmer@oracle.com,
	kuba@kernel.org,
	jon@nutanix.com,
	kvm@vger.kernel.org,
	virtualization@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH net V2 1/2] vhost-net: unbreak busy polling
Date: Mon, 15 Sep 2025 10:47:02 +0800
Message-ID: <20250915024703.2206-1-jasowang@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

Commit 67a873df0c41 ("vhost: basic in order support") pass the number
of used elem to vhost_net_rx_peek_head_len() to make sure it can
signal the used correctly before trying to do busy polling. But it
forgets to clear the count, this would cause the count run out of sync
with handle_rx() and break the busy polling.

Fixing this by passing the pointer of the count and clearing it after
the signaling the used.

Acked-by: Michael S. Tsirkin <mst@redhat.com>
Cc: stable@vger.kernel.org
Fixes: 67a873df0c41 ("vhost: basic in order support")
Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 drivers/vhost/net.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/vhost/net.c b/drivers/vhost/net.c
index c6508fe0d5c8..16e39f3ab956 100644
--- a/drivers/vhost/net.c
+++ b/drivers/vhost/net.c
@@ -1014,7 +1014,7 @@ static int peek_head_len(struct vhost_net_virtqueue *rvq, struct sock *sk)
 }
 
 static int vhost_net_rx_peek_head_len(struct vhost_net *net, struct sock *sk,
-				      bool *busyloop_intr, unsigned int count)
+				      bool *busyloop_intr, unsigned int *count)
 {
 	struct vhost_net_virtqueue *rnvq = &net->vqs[VHOST_NET_VQ_RX];
 	struct vhost_net_virtqueue *tnvq = &net->vqs[VHOST_NET_VQ_TX];
@@ -1024,7 +1024,8 @@ static int vhost_net_rx_peek_head_len(struct vhost_net *net, struct sock *sk,
 
 	if (!len && rvq->busyloop_timeout) {
 		/* Flush batched heads first */
-		vhost_net_signal_used(rnvq, count);
+		vhost_net_signal_used(rnvq, *count);
+		*count = 0;
 		/* Both tx vq and rx socket were polled here */
 		vhost_net_busy_poll(net, rvq, tvq, busyloop_intr, true);
 
@@ -1180,7 +1181,7 @@ static void handle_rx(struct vhost_net *net)
 
 	do {
 		sock_len = vhost_net_rx_peek_head_len(net, sock->sk,
-						      &busyloop_intr, count);
+						      &busyloop_intr, &count);
 		if (!sock_len)
 			break;
 		sock_len += sock_hlen;
-- 
2.34.1


