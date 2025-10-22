Return-Path: <linux-kernel+bounces-864082-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 85A05BF9DDB
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 05:44:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 027844EAD22
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 03:44:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F6B72D1F7E;
	Wed, 22 Oct 2025 03:44:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AOJkOaG9"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AC2E27FD49
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 03:44:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761104678; cv=none; b=Ri2GcurQ2MWyNQ4BHmPzFi7aNzdcIAOfkhQwJr12v+Ca2tgGsn5gKiR1UAQBBT+ntsq3J9hBBJaBVXZ7Mm7ihVYsO70UycpGJS+/hKSS4EinowfQlNcOLqNAEjq7S4hHFFqLUGWrKBojxprfkhR0DCKjCEM1QntqmxSLWufS3C8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761104678; c=relaxed/simple;
	bh=GSf7P5eeM6DUVSbiDUnm9pzJvTlKHLcPcHgt1685c6g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-type; b=GMEs4fwI2BuBiZyE7EHPknrg++LjNdrj+ZJ02H0hDhak6dx8i19ZsLUgna84+va3tHPAKDwixqZhXkzup3FNhzQWUPg2g7yYssuQr7IdGWo4q9R7cd2PtFnHzyEDIzGSpCx7w2tg6bsn5udBaMtVXN/uc5y3qbedFAP2xz3rHYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AOJkOaG9; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761104676;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Y4YJ9DUknv9IQ4DZMUZL0RfnKpN3mq1st9g8ZzhMtYo=;
	b=AOJkOaG9RlfUOw+bt5YRIFFEZJCUtljs/nUPKAq4jQAmUkFT34dz+lMJsiGsdQ9AF8aJzA
	gKUL/QxUk5O+JzazqAL5WkRNqSS5tjeU8nBaTKugk41qtuYbpBmaOLdZbe5j4lwQGmkFBk
	KZjQGdaGcXpUJRBab/i6zcqv52ejEoU=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-613-N4HUP1niPQSCwWAd55P3OA-1; Tue,
 21 Oct 2025 23:44:35 -0400
X-MC-Unique: N4HUP1niPQSCwWAd55P3OA-1
X-Mimecast-MFC-AGG-ID: N4HUP1niPQSCwWAd55P3OA_1761104673
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6ED0118002F9;
	Wed, 22 Oct 2025 03:44:32 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.72.112.88])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id D71A219560B2;
	Wed, 22 Oct 2025 03:44:27 +0000 (UTC)
From: Jason Wang <jasowang@redhat.com>
To: mst@redhat.com,
	jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com,
	pabeni@redhat.com,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: netdev@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH net V2] virtio-net: zero unused hash fields
Date: Wed, 22 Oct 2025 11:44:21 +0800
Message-ID: <20251022034421.70244-1-jasowang@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

When GSO tunnel is negotiated virtio_net_hdr_tnl_from_skb() tries to
initialize the tunnel metadata but forget to zero unused rxhash
fields. This may leak information to another side. Fixing this by
zeroing the unused hash fields.

Acked-by: Michael S. Tsirkin <mst@redhat.com>
Fixes: a2fb4bc4e2a6a ("net: implement virtio helpers to handle UDP GSO tunneling")
Cc: <stable@vger.kernel.org>
Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 include/linux/virtio_net.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/linux/virtio_net.h b/include/linux/virtio_net.h
index 20e0584db1dd..4d1780848d0e 100644
--- a/include/linux/virtio_net.h
+++ b/include/linux/virtio_net.h
@@ -401,6 +401,10 @@ virtio_net_hdr_tnl_from_skb(const struct sk_buff *skb,
 	if (!tnl_hdr_negotiated)
 		return -EINVAL;
 
+        vhdr->hash_hdr.hash_value = 0;
+        vhdr->hash_hdr.hash_report = 0;
+        vhdr->hash_hdr.padding = 0;
+
 	/* Let the basic parsing deal with plain GSO features. */
 	skb_shinfo(skb)->gso_type &= ~tnl_gso_type;
 	ret = virtio_net_hdr_from_skb(skb, hdr, true, false, vlan_hlen);
-- 
2.42.0


