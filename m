Return-Path: <linux-kernel+bounces-860218-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 70E46BEF9B4
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 09:12:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4B0FD188E98F
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 07:12:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B91C62E266A;
	Mon, 20 Oct 2025 07:10:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="L3BcmfOh"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AEC72E1F02
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 07:10:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760944248; cv=none; b=LTUVosCmRJMiYlyjQsFIIk13ELcE0HLvk6mWj6C23/LQzL4ppKMBwjIQlcX3OGb5He17dkKHZZ0cJf9QEgcg/srgJ2hcYx3R2yBL48HdX4oKdJzhfaUAAXqlX+F8CPK3I78GiHVdr4QdqIqqzISv5sOyHw/GGfb+xoKHDUw5B1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760944248; c=relaxed/simple;
	bh=XEtnrHECrq/n5FpADL3LfMWZyQVu01mbzxn//nz4phE=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=chNzHdFy8mq4m3I3Ap6woSEwHfoWcnUpHyRntTOgqH+yLyMIOlURF+yIz1DVYRbE6iMAlCp+R96a5wIp3nx7aLoKpXXaCtGtbk43huL6oefEMjYQz6xyPMYVrskK2gZuEDgO/99bD0MKJJ7IRCcBnNKEKl16BIzH3k3zoATXRcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=L3BcmfOh; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760944246;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Q4FPBkheUtQFJ5C3vs4XZzaAF/OMZmMv9SqfzyXlOTM=;
	b=L3BcmfOhoV6RIWaVULrbjILHyFJ3imv8vvU23WffNU3gzRc+6Wu2x8xM1J996eKsv2npDi
	fhLNCPKHg/QDRiwbdmMC1ziEGT1SkNFa3A0Whs/Cga24K+MQpGovYGaz2RLiKcDKNngD0Y
	r0/SHaW0kdxM+4BK/irSGb541nFj9lc=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-612-x9lxyAXLMHuoTsKisuWhag-1; Mon,
 20 Oct 2025 03:10:44 -0400
X-MC-Unique: x9lxyAXLMHuoTsKisuWhag-1
X-Mimecast-MFC-AGG-ID: x9lxyAXLMHuoTsKisuWhag_1760944243
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6F3CF18002F5;
	Mon, 20 Oct 2025 07:10:43 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.72.113.29])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 3C53630001A2;
	Mon, 20 Oct 2025 07:10:39 +0000 (UTC)
From: Jason Wang <jasowang@redhat.com>
To: mst@redhat.com,
	jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH V8 08/19] virtio_ring: switch to use vring_virtqueue for enable_cb_prepare variants
Date: Mon, 20 Oct 2025 15:09:52 +0800
Message-ID: <20251020071003.28834-9-jasowang@redhat.com>
In-Reply-To: <20251020071003.28834-1-jasowang@redhat.com>
References: <20251020071003.28834-1-jasowang@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

Those variants are used internally so let's switch to use
vring_virtqueue as parameter to be consistent with other internal
virtqueue helpers.

Acked-by: Eugenio Pérez <eperezma@redhat.com>
Reviewed-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 drivers/virtio/virtio_ring.c | 15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index 9d084ee9f4d6..f46ebc60f911 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -898,9 +898,8 @@ static void virtqueue_disable_cb_split(struct virtqueue *_vq)
 	}
 }
 
-static unsigned int virtqueue_enable_cb_prepare_split(struct virtqueue *_vq)
+static unsigned int virtqueue_enable_cb_prepare_split(struct vring_virtqueue *vq)
 {
-	struct vring_virtqueue *vq = to_vvq(_vq);
 	u16 last_used_idx;
 
 	START_USE(vq);
@@ -914,10 +913,10 @@ static unsigned int virtqueue_enable_cb_prepare_split(struct virtqueue *_vq)
 		vq->split.avail_flags_shadow &= ~VRING_AVAIL_F_NO_INTERRUPT;
 		if (!vq->event)
 			vq->split.vring.avail->flags =
-				cpu_to_virtio16(_vq->vdev,
+				cpu_to_virtio16(vq->vq.vdev,
 						vq->split.avail_flags_shadow);
 	}
-	vring_used_event(&vq->split.vring) = cpu_to_virtio16(_vq->vdev,
+	vring_used_event(&vq->split.vring) = cpu_to_virtio16(vq->vq.vdev,
 			last_used_idx = vq->last_used_idx);
 	END_USE(vq);
 	return last_used_idx;
@@ -1807,10 +1806,8 @@ static void virtqueue_disable_cb_packed(struct virtqueue *_vq)
 	}
 }
 
-static unsigned int virtqueue_enable_cb_prepare_packed(struct virtqueue *_vq)
+static unsigned int virtqueue_enable_cb_prepare_packed(struct vring_virtqueue *vq)
 {
-	struct vring_virtqueue *vq = to_vvq(_vq);
-
 	START_USE(vq);
 
 	/*
@@ -2572,8 +2569,8 @@ unsigned int virtqueue_enable_cb_prepare(struct virtqueue *_vq)
 	if (vq->event_triggered)
 		vq->event_triggered = false;
 
-	return vq->packed_ring ? virtqueue_enable_cb_prepare_packed(_vq) :
-				 virtqueue_enable_cb_prepare_split(_vq);
+	return vq->packed_ring ? virtqueue_enable_cb_prepare_packed(vq) :
+				 virtqueue_enable_cb_prepare_split(vq);
 }
 EXPORT_SYMBOL_GPL(virtqueue_enable_cb_prepare);
 
-- 
2.31.1


