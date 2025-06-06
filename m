Return-Path: <linux-kernel+bounces-675679-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E4CEDAD017B
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Jun 2025 13:51:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4FD59179F70
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Jun 2025 11:51:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A1C1287507;
	Fri,  6 Jun 2025 11:50:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Bjcbq0BS"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77D4D288525
	for <linux-kernel@vger.kernel.org>; Fri,  6 Jun 2025 11:50:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749210648; cv=none; b=UkBkodnGcIHE7g/8AVBaEUGYTQFqS6i2Jq4MhfT9vrZLKkVm/gpGi1hpGlTFK6kXit+wo6EXcR5YjPURI4cvDAyOk738crqZebSu6z3/TeLsXd4p387jBie3TH3k1M6Vik49mI9ERqzYhk6/CBRi0NpW9UVGxzNFpxkxjVleSmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749210648; c=relaxed/simple;
	bh=rnfH/LG4SOFZzUgJOleYnhArYVI1bRk/qn39vRK7QZw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rrH9D84cnqlBGrY9UOe7RfVESv/mHc9G7WCHIg23GAXIhk6dFhkV9hjbDRBMjs8tvjyid1nzRlN/TbRBqhfdfJBLcTUu4+rmkiDd49XTujRu2HferZT5lzMpujTonV66QheIg/okRGdbKGtAeegz/iSVdCr/yq3NXV1sAK2BaUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Bjcbq0BS; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1749210644;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WqxHAv8IthusYfEbserIn/Muun9xU0nuRy3hl8B74K8=;
	b=Bjcbq0BSt44u5XYbHaWsoONDdl4f8HFlFle2yueVY8qpWa0zbfh1H+S8aNkFgmPNhksOaT
	rH3pxuMxzmGrM6qsn5wxmKN0h1VKIWL8/McRxsFeOKSFolSRsVAn9zlc0hyXm4PVYRr24f
	t2rzK1hoPoFmXBA6uW7a76iuu+VjZbA=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-689-_pxwGeO9Pl6BItm5ke8y2Q-1; Fri,
 06 Jun 2025 07:50:43 -0400
X-MC-Unique: _pxwGeO9Pl6BItm5ke8y2Q-1
X-Mimecast-MFC-AGG-ID: _pxwGeO9Pl6BItm5ke8y2Q_1749210642
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C85371956086;
	Fri,  6 Jun 2025 11:50:41 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.44.33.72])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id E363B19560B2;
	Fri,  6 Jun 2025 11:50:37 +0000 (UTC)
From: =?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>
To: jasowang@redhat.com
Cc: Yongji Xie <xieyongji@bytedance.com>,
	Cindy Lu <lulu@redhat.com>,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Stefano Garzarella <sgarzare@redhat.com>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	Maxime Coquelin <mcoqueli@redhat.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	virtualization@lists.linux.dev,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Laurent Vivier <lvivier@redhat.com>
Subject: [RFC 5/6] vduse: reset group asid in reset
Date: Fri,  6 Jun 2025 13:50:11 +0200
Message-ID: <20250606115012.1331551-6-eperezma@redhat.com>
In-Reply-To: <20250606115012.1331551-1-eperezma@redhat.com>
References: <20250606115012.1331551-1-eperezma@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

Is the expected behavior with vdpa_sim and mlx.

Signed-off-by: Eugenio Pérez <eperezma@redhat.com>
---
 drivers/vdpa/vdpa_user/vduse_dev.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa_user/vduse_dev.c
index 151c6d133e76..5f0032df43b8 100644
--- a/drivers/vdpa/vdpa_user/vduse_dev.c
+++ b/drivers/vdpa/vdpa_user/vduse_dev.c
@@ -445,6 +445,9 @@ static __poll_t vduse_dev_poll(struct file *file, poll_table *wait)
 	return mask;
 }
 
+static int vduse_set_group_asid(struct vdpa_device *vdpa, unsigned int group,
+				unsigned int asid);
+
 static void vduse_dev_reset(struct vduse_dev *dev)
 {
 	int i;
@@ -457,6 +460,9 @@ static void vduse_dev_reset(struct vduse_dev *dev)
 			vduse_domain_reset_bounce_map(domain);
 	}
 
+	for (i = 0; i < dev->ngroups; i++)
+		vduse_set_group_asid(&dev->vdev->vdpa, i, 0);
+
 	down_write(&dev->rwsem);
 
 	dev->status = 0;
-- 
2.49.0


