Return-Path: <linux-kernel+bounces-786543-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 54398B35C5B
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 13:33:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A9ECB3664A2
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 11:27:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26C3331280D;
	Tue, 26 Aug 2025 11:27:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Fkg4gXd9"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0679F29D26A
	for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 11:27:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756207647; cv=none; b=GRYetuiO1Goe8PcKsKBKJiu3AJZFFmi4jgX5vApiRTajmCbLZ/v3qHdf2L1Ek5ptY//gxYV9N8Bm3XpGIa86neLgUyOX6lFWX8Qqb9hA3aNWhG/AnArMH+EEMKOmaeGY57T6BpI0XVRFEciGlgC1OFc/ze7rjX749YYXiCse6fM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756207647; c=relaxed/simple;
	bh=L9q1m9CtNlhgChDvcgNwi+HhAOc8fJ9V+nf/txfRDPk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gy+97zUYAgtGkuggRH6gbCpcZHgUcqlUaJVtW6jGsiw+Cv/QLMgoei1HChvNl2Mln4XUn9R4M83AfpkzznBu6W2b85F/tEAQJAi/mIlUsHN8UuV39vipkvvqTOpbASsSWREw9xS3liKEkrUbK7/CaAB/IdWGIovx2p+KMdz5VnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Fkg4gXd9; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756207645;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jgIUz6Q5sS/rQUHeGlq36B08BX4dcUMxKfvHNOBbzXE=;
	b=Fkg4gXd9RKn/fgzyHgd3BM0jhxde7TzHLfIAs3bYrr3JAOxJNOn6kcmaAIKMUqlR6GRowJ
	/tbT9bldsiaNemfKoVr/s0shyY0Wrk1bkS70gD9XcQ8yup8xPfg0rr2WDJwVNsgjcEp8QI
	5KItDLytNvz3MWLTuFmKCCjw6/+EJaw=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-224-clajb460MrmjZIdTnnav6w-1; Tue,
 26 Aug 2025 07:27:21 -0400
X-MC-Unique: clajb460MrmjZIdTnnav6w-1
X-Mimecast-MFC-AGG-ID: clajb460MrmjZIdTnnav6w_1756207640
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 852271800446;
	Tue, 26 Aug 2025 11:27:20 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.45.224.67])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 773811800280;
	Tue, 26 Aug 2025 11:27:16 +0000 (UTC)
From: =?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>
To: "Michael S . Tsirkin " <mst@redhat.com>
Cc: =?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Cindy Lu <lulu@redhat.com>,
	Stefano Garzarella <sgarzare@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Laurent Vivier <lvivier@redhat.com>,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	jasowang@redhat.com,
	Yongji Xie <xieyongji@bytedance.com>,
	Maxime Coquelin <mcoqueli@redhat.com>
Subject: [PATCH 1/6] vduse: add v1 API definition
Date: Tue, 26 Aug 2025 13:27:04 +0200
Message-ID: <20250826112709.1051172-2-eperezma@redhat.com>
In-Reply-To: <20250826112709.1051172-1-eperezma@redhat.com>
References: <20250826112709.1051172-1-eperezma@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

This allows the kernel to detect whether the userspace VDUSE device
supports the VQ group and ASID features.  VDUSE devices that don't set
the V1 API will not receive the new messages, and vdpa device will be
created with only one vq group and asid.

The next patches implement the new feature incrementally, only enabling
the VDUSE device to set the V1 API version by the end of the series.

Signed-off-by: Eugenio Pérez <eperezma@redhat.com>
---
 include/uapi/linux/vduse.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/uapi/linux/vduse.h b/include/uapi/linux/vduse.h
index 68a627d04afa..9a56d0416bfe 100644
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
2.51.0


