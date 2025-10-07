Return-Path: <linux-kernel+bounces-844274-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 17240BC16E5
	for <lists+linux-kernel@lfdr.de>; Tue, 07 Oct 2025 15:06:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1D9241884AF3
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Oct 2025 13:07:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75CEC2DF157;
	Tue,  7 Oct 2025 13:06:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JRMGXsD2"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A6CC21FF48
	for <linux-kernel@vger.kernel.org>; Tue,  7 Oct 2025 13:06:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759842395; cv=none; b=rwoP6Kw66JmSOAdRQxnlf+wLFizbii37Pjn7nC/lDd9GETwLlazzklG2lmJduBAg6OHfSuBvLhId0LPdFnkbFFAuWTS6oD+a2ODvTjT+L1oz76TruKBD+1MHazoaYgCSSCHspvBPXfy2NBk7sOSoBEN/Y5Zl5k7l3Vjf9SigP5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759842395; c=relaxed/simple;
	bh=tn6GuVL66J6lke5vmEBXobrAj7LpyQ5B0lGcPAt7/eI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=sGINqrpJSBhe4eNy5WNiUyxf3f6WA63FCFBSeN+ulIpLtKZMIMpDk9pq5xW0vXO9mE5qyUsv6UgCSdpsTJ8l1KYq8gAhxPC9k40fMfdyNBJCIeYzSU+DktszsUPIHQ6Vk7AI/0ZWOGPHXPIkURrNrfNmJJGcNwXILGPVNTQZ67E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JRMGXsD2; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759842393;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=XqQ7M+W4WVkKfh5bARyQQp289Ro+WFjtpRbM8EALEOc=;
	b=JRMGXsD2P+OgXMppmdorY5erVsIJ49T0pmoIK1Vi2NpWdo2sNZOFFw5uxJMvFR7ONW0V+n
	RECPSFlrEp/RtGXiDW5ccW4GAxmsk8M9RHoZdUczVkOBrZpm8HIABsQWJWT7vtUvUk7gDA
	f1tLKTDNo2UBhhUT/KM0KT80Yl1E1Lc=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-583-xuMw0U-AOKu6sDDTzNGKJw-1; Tue,
 07 Oct 2025 09:06:29 -0400
X-MC-Unique: xuMw0U-AOKu6sDDTzNGKJw-1
X-Mimecast-MFC-AGG-ID: xuMw0U-AOKu6sDDTzNGKJw_1759842388
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 674EE19560A5;
	Tue,  7 Oct 2025 13:06:28 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.45.225.223])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 8A57F1800452;
	Tue,  7 Oct 2025 13:06:23 +0000 (UTC)
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
Subject: [RFC 0/2] Lift restriction about VDUSE net devices with CVQ
Date: Tue,  7 Oct 2025 15:06:20 +0200
Message-ID: <20251007130622.144762-1-eperezma@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

An userland device implemented through VDUSE could take rtnl forever if the
virtio-net driver is running on top of virtio_vdpa.  Let's break the device
if it does not return the buffer in a longer-than-assumible timeout.

A less agressive path can be taken to recover the device, like only resetting
the control virtqueue.  However, the state of the device after this action is
taken races, as the vq could be reset after the device writes the OK.  Leaving
TODO anyway.

Eugenio Pérez (2):
  virtio_net: timeout control virtqueue commands
  vduse: lift restriction about net devices with CVQ

 drivers/net/virtio_net.c           | 10 ++++++++++
 drivers/vdpa/vdpa_user/vduse_dev.c |  3 ---
 2 files changed, 10 insertions(+), 3 deletions(-)

-- 
2.51.0


