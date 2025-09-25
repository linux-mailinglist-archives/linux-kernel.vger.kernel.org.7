Return-Path: <linux-kernel+bounces-832058-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BE313B9E409
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 11:16:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 97D7B18854A2
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 09:16:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1E2E2EA177;
	Thu, 25 Sep 2025 09:13:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BmqLM1Xd"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6D292E9ED2
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 09:13:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758791638; cv=none; b=YnUlRHiYpNeu6u3Dn4oQ55Z2oVuaG0SSwviGA/uKE3nEzcQKHICzKTq/BWmADlICdif64cbGJ9PUCwbCWxdqYdWY1fPzP2XxyiogGnI9m4UCks5PZY9t7hxFukg4qHaCHCHLT/5HEEaLJyk/ordDRt4zysdipi5LxhbTfRePt/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758791638; c=relaxed/simple;
	bh=pbBzLjrUvy4Jws3IrdIk6Q8D7H91HuRG6YGPY55CtrI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WQrt3bw/udCrY47IzpN5/Nal/9EOfsN+ljQyrM8unrci3TupKDpEFo7L+3RKYu/GRUDusO3XR6rNol7v8MjGPjWDL5BA6+tzhM1GknbnPfR3ESz1Xr1DvOPtRNrIkNItceQFdij/XidXd+p36w/uclAVNAk2eORrbEdsshwAX2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BmqLM1Xd; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758791635;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6Dg27mnkpxY6+wpImWrHzQoz+UEHN7ql4f1eRWWfzQk=;
	b=BmqLM1XdhCzsPACLNr8xH3Rd11drdQ3f+jwxtgMoeP4d7Df34kTbIQNAYDSWsIBVRZBSya
	RURZzqSAOAA571ix+IFzj4g5co4UPbIAkBW8QMNYli2FMqkUGXibXbDTJOVlbMgPqW0QEM
	FoogPHhpdFxBze6lHWDlV3TX7opIeqs=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-649-xTz2R4fpM56w1cMihjkgBg-1; Thu,
 25 Sep 2025 05:13:51 -0400
X-MC-Unique: xTz2R4fpM56w1cMihjkgBg-1
X-Mimecast-MFC-AGG-ID: xTz2R4fpM56w1cMihjkgBg_1758791630
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B5F6E1956095;
	Thu, 25 Sep 2025 09:13:50 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.45.224.91])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 85B9E1956095;
	Thu, 25 Sep 2025 09:13:46 +0000 (UTC)
From: =?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>
To: "Michael S . Tsirkin " <mst@redhat.com>
Cc: Yongji Xie <xieyongji@bytedance.com>,
	Cindy Lu <lulu@redhat.com>,
	jasowang@redhat.com,
	linux-kernel@vger.kernel.org,
	Maxime Coquelin <mcoqueli@redhat.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Laurent Vivier <lvivier@redhat.com>,
	virtualization@lists.linux.dev,
	Stefano Garzarella <sgarzare@redhat.com>
Subject: [PATCH v4 2/6] vduse: add v1 API definition
Date: Thu, 25 Sep 2025 11:13:31 +0200
Message-ID: <20250925091335.1964283-3-eperezma@redhat.com>
In-Reply-To: <20250925091335.1964283-1-eperezma@redhat.com>
References: <20250925091335.1964283-1-eperezma@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

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
2.51.0


