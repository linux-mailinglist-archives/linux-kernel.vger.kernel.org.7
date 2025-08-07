Return-Path: <linux-kernel+bounces-759016-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A72AEB1D71A
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 13:58:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9892B18A7E95
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 11:59:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BCD923D2B4;
	Thu,  7 Aug 2025 11:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="T8a8OjMw"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5F4D23C4F3
	for <linux-kernel@vger.kernel.org>; Thu,  7 Aug 2025 11:58:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754567899; cv=none; b=W9YOa66K2h8KBAKkqWEIfm2GKwGjiTE3mwkvktTEoyRnIqIFWJxXu3GRC+9J3p+csfjlQP4SOTxJ0f075cUTcsNMu+86sc/yodoOVui6MtkFmHYZfSw6Xc4WdJcMGU0xcyFDGE0aZmVguzm/NN+eYvh/RJZGi0SOgeL1xgfaE6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754567899; c=relaxed/simple;
	bh=8D8rIYRVZgKyL2guUQErRnu+k5Of3gzVxEjH0MYjlJQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=U/7+pe9Zqmsatl2Yme5mJAIKmAD1BXj6aP3mrUUZubj33AgC8AawfhAIbxsi2r6OeyINuTbijqQl9pRQdTcXHr9J3ThiYec0LgIXACFId/u1v0jG6I8VUcblRUL+nzjzbckVF83ZVG95QAyCuAcgBPGdB3/+GWKHvhAGiQD3WyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=T8a8OjMw; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754567897;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iR7lP8+A2xwbfvrWFyABp9IJvnMz9zYp8kx8LB/R+t0=;
	b=T8a8OjMwKgjpxaz8oK32reaN4ybYy9+yGV95at+H2kyIxbz8whabYymgW40JSGc+J2DoTN
	qMc3E4pHTTOTiT4CatO3lRH9zn9CoOnpLqiGWm9IRU3SEJHo017NpuYdXW04XopDq1yzAy
	4R0hzMWNNwwvq5KD49WEt/MdJZBmxMY=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-652-JkcvbLJ1PK--3wlTQhrfow-1; Thu,
 07 Aug 2025 07:58:14 -0400
X-MC-Unique: JkcvbLJ1PK--3wlTQhrfow-1
X-Mimecast-MFC-AGG-ID: JkcvbLJ1PK--3wlTQhrfow_1754567893
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D5991180036F;
	Thu,  7 Aug 2025 11:58:12 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.45.225.48])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 21F6430001A5;
	Thu,  7 Aug 2025 11:58:08 +0000 (UTC)
From: =?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>
To: "Michael S . Tsirkin " <mst@redhat.com>
Cc: Cindy Lu <lulu@redhat.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Yongji Xie <xieyongji@bytedance.com>,
	Stefano Garzarella <sgarzare@redhat.com>,
	virtualization@lists.linux.dev,
	Laurent Vivier <lvivier@redhat.com>,
	linux-kernel@vger.kernel.org,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	jasowang@redhat.com,
	Maxime Coquelin <mcoqueli@redhat.com>
Subject: [RFC v2 3/7] vdpa: change get_vq_map_token type to void *(*cb)
Date: Thu,  7 Aug 2025 13:57:48 +0200
Message-ID: <20250807115752.1663383-4-eperezma@redhat.com>
In-Reply-To: <20250807115752.1663383-1-eperezma@redhat.com>
References: <20250807115752.1663383-1-eperezma@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

Mail list requested a better (safer) return type in the DMA rework
series so this is just temporal workaround to develop this RFC.

Signed-off-by: Eugenio Pérez <eperezma@redhat.com>
---
 drivers/vdpa/mlx5/net/mlx5_vnet.c | 2 +-
 include/linux/vdpa.h              | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
index 78421fc709c6..ef39841e6e96 100644
--- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
+++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
@@ -3395,7 +3395,7 @@ static int mlx5_vdpa_reset_map(struct vdpa_device *vdev, unsigned int asid)
 	return err;
 }
 
-static struct device *mlx5_get_vq_map_token(struct vdpa_device *vdev, u16 idx)
+static void *mlx5_get_vq_map_token(struct vdpa_device *vdev, u16 idx)
 {
 	struct mlx5_vdpa_dev *mvdev = to_mvdev(vdev);
 
diff --git a/include/linux/vdpa.h b/include/linux/vdpa.h
index cb51b7e2e569..3846791f6868 100644
--- a/include/linux/vdpa.h
+++ b/include/linux/vdpa.h
@@ -438,7 +438,7 @@ struct vdpa_config_ops {
 	int (*reset_map)(struct vdpa_device *vdev, unsigned int asid);
 	int (*set_group_asid)(struct vdpa_device *vdev, unsigned int group,
 			      unsigned int asid);
-	struct device *(*get_vq_map_token)(struct vdpa_device *vdev, u16 idx);
+	void *(*get_vq_map_token)(struct vdpa_device *vdev, u16 idx);
 	int (*bind_mm)(struct vdpa_device *vdev, struct mm_struct *mm);
 	void (*unbind_mm)(struct vdpa_device *vdev);
 
-- 
2.50.1


