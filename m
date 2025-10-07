Return-Path: <linux-kernel+bounces-844275-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B9100BC16EE
	for <lists+linux-kernel@lfdr.de>; Tue, 07 Oct 2025 15:06:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1C9223C49AD
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Oct 2025 13:06:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30D852E091B;
	Tue,  7 Oct 2025 13:06:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PvCz/hg9"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25B052E090A
	for <linux-kernel@vger.kernel.org>; Tue,  7 Oct 2025 13:06:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759842399; cv=none; b=rgNIIpQS0exByOIQUR5gvALYo1/ipmucz361MfONwuq39e5fjduyydWVYrztMgqHlo08Vedn2xs/+iK1zbYChIB7NvGZmzjYH2MPfP3tA8Jvr4tnE1NDkl0IafCfjPZPE33dW12TCwRNC7mR/jClwUHgA1uB7qg9a09veXJlnio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759842399; c=relaxed/simple;
	bh=CbgSRFpb7XB1O45PNZtV0zJlxnlm5ctiO4bcGsZSTAo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CsbTsHn/IkXqIuOnIu/edmKzFc9bCDNs4xW6uItbx348iso/XKRpo1JlY4kHDSGoyr2nkd/4gqGNw0VJXCIDF8hF6DUDLYZ4iXyYvrlOLEBufxyx7mDzWY1yx5BjWu+a7yvtR2eUD+9D3Fl5s/Pmfs5W9U8VkcFTOKdSS8RQ0f8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PvCz/hg9; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759842397;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iLZdGxsC/2NvnmPmsweBVK3mEMdeM40KbC8BUJ8+sws=;
	b=PvCz/hg9uPX3yIlfD3a9HokaeWlu1Vbdu7MzAhmawcV721w2Fv+zHMLApz8I9Vg79W8zUH
	z3AdLHckHIXN4AeaW+ufUH3seQ7wMryjJLABb4GFNXeBMGO1QCYMHzeh6QGmeXTmYs8Pql
	BgVI0psi+FNzhewddS46s7W+oyhNYRQ=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-477-T0AFbYQsPrSxtP3nkFk38Q-1; Tue,
 07 Oct 2025 09:06:34 -0400
X-MC-Unique: T0AFbYQsPrSxtP3nkFk38Q-1
X-Mimecast-MFC-AGG-ID: T0AFbYQsPrSxtP3nkFk38Q_1759842392
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9307C195609F;
	Tue,  7 Oct 2025 13:06:32 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.45.225.223])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 0F504180141D;
	Tue,  7 Oct 2025 13:06:28 +0000 (UTC)
From: =?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>
To: mst@redhat.com
Cc: Yongji Xie <xieyongji@bytedance.com>,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Maxime Coquelin <mcoqueli@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Dragos Tatulea DE <dtatulea@nvidia.com>,
	jasowang@redhat.com
Subject: [RFC 1/2] virtio_net: timeout control virtqueue commands
Date: Tue,  7 Oct 2025 15:06:21 +0200
Message-ID: <20251007130622.144762-2-eperezma@redhat.com>
In-Reply-To: <20251007130622.144762-1-eperezma@redhat.com>
References: <20251007130622.144762-1-eperezma@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

An userland device implemented through VDUSE could take rtnl forever if
the virtio-net driver is running on top of virtio_vdpa.  Let's break the
device if it does not return the buffer in a longer-than-assumible
timeout.

A less agressive path can be taken to recover the device, like only
resetting the control virtqueue.  However, the state of the device after
this action is taken races, as the vq could be reset after the device
writes the OK.  Leaving TODO anyway.

Signed-off-by: Eugenio Pérez <eperezma@redhat.com>
---
 drivers/net/virtio_net.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 31bd32bdecaf..ed68ad69a019 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -3576,6 +3576,7 @@ static bool virtnet_send_command_reply(struct virtnet_info *vi, u8 class, u8 cmd
 {
 	struct scatterlist *sgs[5], hdr, stat;
 	u32 out_num = 0, tmp, in_num = 0;
+	unsigned long end_time;
 	bool ok;
 	int ret;
 
@@ -3614,11 +3615,20 @@ static bool virtnet_send_command_reply(struct virtnet_info *vi, u8 class, u8 cmd
 
 	/* Spin for a response, the kick causes an ioport write, trapping
 	 * into the hypervisor, so the request should be handled immediately.
+	 *
+	 * Long timeout so a malicious device is not able to lock rtnl forever.
 	 */
+	end_time = jiffies + 30 * HZ;
 	while (!virtqueue_get_buf(vi->cvq, &tmp) &&
 	       !virtqueue_is_broken(vi->cvq)) {
 		cond_resched();
 		cpu_relax();
+
+		if (time_after(end_time, jiffies)) {
+			/* TODO Reset vq if possible? */
+			virtio_break_device(vi->vdev);
+			break;
+		}
 	}
 
 unlock:
-- 
2.51.0


