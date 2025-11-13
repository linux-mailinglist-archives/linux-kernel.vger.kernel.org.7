Return-Path: <linux-kernel+bounces-899287-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id C3BF3C5747D
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 12:56:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9BFC84E496F
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 11:56:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4D6B34DCFF;
	Thu, 13 Nov 2025 11:56:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iyuavi2F"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93B3F34DB5F
	for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 11:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763034977; cv=none; b=E3RXzyFSoMoiq4T4+gqXbqwWV1mhdDcYP/ImYA/10Z2gmAm1YJCCi1zV8CxLtdjHpe3Lodqb5QJZTytfv/WA3pGTMPZg8FOpgcloSCtgb4CGJjVT5Duj72YS1vhpcn4hJreAm2Gb26cUn6/gpSxYLzwPz/PdwKn2uTXvYNNDkKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763034977; c=relaxed/simple;
	bh=I6znZiMtZCgHl0v4tDD4WBl2+uL7FSz4r3b2oeCAXWc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nsepk+cnWAynNWGnROjUDr3qTqgrTg/uXcmc0qU7MH3iB805V+4+/L8m5BUz3W/lqaos4c4n1ffgUO+pAz3dz/tyGSrsz+jS2UZPcRvNzzoCJM6yLd+W0f6g4OWbCHAtgSNqPgEZK+WSG28qYyelwP2NZrz2s/CYHTxZy5OakfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iyuavi2F; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1763034974;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zwohY+chQR4kaYuaRg2PTSrv+LR/riceq4DhCdTDphQ=;
	b=iyuavi2F0UzwDjub3iUyo4EKAQAb83vszCICwm6CVZFf0bBOOOruPeTKebk5vrIIcQEOwq
	pqAIibbyWZQ0ILD3XkjQmfN23LDP6cTwtjKN39Hc0MYJlDg5Wyo04i0R5oo0I4ErjvjC6a
	kfEdeG70yXWsA9cFfJvb3R7r+cWwUTo=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-84-gjI9LRflOhybhP-cGA4h3g-1; Thu,
 13 Nov 2025 06:56:11 -0500
X-MC-Unique: gjI9LRflOhybhP-cGA4h3g-1
X-Mimecast-MFC-AGG-ID: gjI9LRflOhybhP-cGA4h3g_1763034970
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 006C81800EF6;
	Thu, 13 Nov 2025 11:56:10 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.45.224.122])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id AE01819560B9;
	Thu, 13 Nov 2025 11:56:05 +0000 (UTC)
From: =?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>
To: "Michael S . Tsirkin " <mst@redhat.com>
Cc: Laurent Vivier <lvivier@redhat.com>,
	virtualization@lists.linux.dev,
	Maxime Coquelin <mcoqueli@redhat.com>,
	Cindy Lu <lulu@redhat.com>,
	jasowang@redhat.com,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Yongji Xie <xieyongji@bytedance.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Stefano Garzarella <sgarzare@redhat.com>
Subject: [PATCH v9 1/6] vduse: add v1 API definition
Date: Thu, 13 Nov 2025 12:55:53 +0100
Message-ID: <20251113115558.1277981-2-eperezma@redhat.com>
In-Reply-To: <20251113115558.1277981-1-eperezma@redhat.com>
References: <20251113115558.1277981-1-eperezma@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

This allows the kernel to detect whether the userspace VDUSE device
supports the VQ group and ASID features.  VDUSE devices that don't set
the V1 API will not receive the new messages, and vdpa device will be
created with only one vq group and asid.

The next patches implement the new feature incrementally, only enabling
the VDUSE device to set the V1 API version by the end of the series.

Acked-by: Jason Wang <jasowang@redhat.com>
Reviewed-by: Xie Yongji <xieyongji@bytedance.com>
Signed-off-by: Eugenio Pérez <eperezma@redhat.com>
---
 include/uapi/linux/vduse.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/uapi/linux/vduse.h b/include/uapi/linux/vduse.h
index 10ad71aa00d6..ccb92a1efce0 100644
--- a/include/uapi/linux/vduse.h
+++ b/include/uapi/linux/vduse.h
@@ -10,6 +10,10 @@
 
 #define VDUSE_API_VERSION	0
 
+/* VQ groups and ASID support */
+
+#define VDUSE_API_VERSION_1	1
+
 /*
  * Get the version of VDUSE API that kernel supported (VDUSE_API_VERSION).
  * This is used for future extension.
-- 
2.51.1


