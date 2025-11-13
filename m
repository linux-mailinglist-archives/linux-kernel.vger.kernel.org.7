Return-Path: <linux-kernel+bounces-899050-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B478C56A0D
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 10:36:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id BA4FB348196
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 09:36:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25448330B23;
	Thu, 13 Nov 2025 09:34:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hXspHzEG";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="YXgah8Jf"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0827733436D
	for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 09:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763026495; cv=none; b=t3zol/FGRDlBVFQ4vwEAFuw91vEUQNC96YqbcHmnOSN0BXdnjRcD8wJTNuCe/o6v+dg4Va3OHTLlXkYgWYV8neHER4MlRrmBYpKrjI9F4LndRICKpeshmn2suVSWXzYJKJEX0Si1coS5G3tbFxSvhLLM1aPOjpkydRm5TSsbmJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763026495; c=relaxed/simple;
	bh=z60GwjST/zk2QDD1x+EuW4UyxC9I2dr3siMbe0rHDgQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Cj+CayJzpySLx43pHLeDPr6jpQiQHUNrJUoORopfJhPWCCtS+4oL8BGKlfELXSDmKaCZgMJ7QougMRFu6K1taClx8mCsVN0ZzXa8Q7MYZGLozT9kxkLylFIVwyv4bzCYv9LQGfAzYNBw88dAQlQIlUiJxopgbLwg9KO4zXNzu24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hXspHzEG; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=YXgah8Jf; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1763026492;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=m+MHG/qGEvEaekFDzpsq1W609jrOgnKzRH1nvgnjyO4=;
	b=hXspHzEGPP4J8xazOC5b/dai4dym5GYKBl0Db+EWgIC/XDhZW8Vy8hpe9/+gLSzoKxNGdg
	I2y3rRTnrarZ3SqXyu0aAFNA5EPSKsC0QL9l5MLKI575JZKYtPqxBeszH2py/bfP/nDMCk
	pssHEuaF6Ew8+PXmvszmAQ29lrvHQLo=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-83-oUDusDd8Pj-EEiwpiQVd2Q-1; Thu, 13 Nov 2025 04:34:51 -0500
X-MC-Unique: oUDusDd8Pj-EEiwpiQVd2Q-1
X-Mimecast-MFC-AGG-ID: oUDusDd8Pj-EEiwpiQVd2Q_1763026490
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4776b0ada3dso13693005e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 01:34:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1763026490; x=1763631290; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=m+MHG/qGEvEaekFDzpsq1W609jrOgnKzRH1nvgnjyO4=;
        b=YXgah8JfGaLjmCsKsXQLlT+0jvQREEv5GklxEt4eCO462BnqSmJLy0hzQD5q5qkksZ
         QsR6VO/UlFR9BTHHjM3MTNgt5euhYxoiUj9MKgREoMQeZZIjm4is+KiPij5L2wONntsy
         Pz7TrU1V/67keZ8Xqs9wksMF+k4cyWQDX95bDMbJrvlkYWCM8vwzs+M8JRHha/hq64l+
         VWcTe0uDoFFkNQglt0dCxegW2TsrYS2YEDs9P8pW4YSoPLfLmHFxaUdla83fmuvMHjIj
         aQHLM2QJxqKsp89V7ibc+OVXOGTpCuw/C8AjNqTib2Q7by5R3dGhW6cVCO36EKWQ1mKp
         2lnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763026490; x=1763631290;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=m+MHG/qGEvEaekFDzpsq1W609jrOgnKzRH1nvgnjyO4=;
        b=kFIgAP0wx7zAEcV2wmMO6xFOG5rqcK0n8Rbbq60P65T4nbQhPJYEhKlCpw+SAnBb2p
         0UR8qQ8J93CqjMMif2XchBOqc0dn8YzcQWX7xGjPTM94VVZ+nW1685MPqmggFFwJwPb9
         TFgLEgOVBDk4QlIicNQ4JiOc8lQd/6heYaBpqipLer0uc35zcP9T1gQbQQFh6xs/DnBq
         sPBj0X/06N3d/a3W0VEzj8VHDwbMCbiD09gxLK1DO7ZrDes8kenPgfyAGcGAAK1vzXQK
         vUaKc/ayNXYTopY29z4mPG/59/OkkaduZsOXCM6zN+N11GtkZSjH3x0g/ZVyHlj9n/Yt
         sDGA==
X-Gm-Message-State: AOJu0YyOJwVRSCb/Qopto7GABVNj9ad3SA6VXhZRrUdbmxMfSJD+ljVR
	HKRdzFoNF23vIU7gWkS6dEmKH2e9CQZSlUJ3TlS+TZtKCUoIXdYMFJvlOATso/O8a7brbzMC5zC
	2zz9Q6AM/BBk4nrdxgfD1JcpYWzWIyTxNASGajhZzIgNTsqEArwjzYS5L0bCbYzeTEgXzqOid2G
	wZR7Q0EJnmBQDWj7jBbY7QetrxXEp8QGfjbSdEcFDWZ6eymA==
X-Gm-Gg: ASbGncudzd0lCYoTHcE3oO1rdEoeJgAiCKj8y50cFzhzUxxhn5Ik65/5vlrc3iMd3ri
	BEi6SljCXfTrpjPRskDCX4TDlSwv7nTt1cM2Y6FaGJko2qk0CErCueJPT0UyRDZ2UxVPGFahBX8
	NcRIezPhVSx5riLOPmT4QC/GRRzaehDLQwklx+DNlFtWtVrYqTrjC7CcK6V/zrdIX+a1BXrEILB
	rl21yrOphDr11lg1FZs8LygcQ+m2/AHYRaKEh5dLGTq3tJSAI4kVUBIWtyIj57KFtJiCromsLPc
	tCgMO5EhbcakC/cZvvyjwp27qXu/5qBl2hr7to2+D9Vs0LEkJBGQsKMkDHD1XG/zJ8rNSjpN6Y0
	jMQWyBa/jbXWl6pYT43s=
X-Received: by 2002:a05:600c:19ca:b0:477:25c0:798c with SMTP id 5b1f17b1804b1-4778bd833a8mr22275965e9.20.1763026490006;
        Thu, 13 Nov 2025 01:34:50 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEi5BxNgVBwbH2dS2CfdV6ze2yR3gC4sODjJo0GZI3/5JNMQyx7RCd4MzGrjukOIyKetZ5ITw==
X-Received: by 2002:a05:600c:19ca:b0:477:25c0:798c with SMTP id 5b1f17b1804b1-4778bd833a8mr22275535e9.20.1763026489584;
        Thu, 13 Nov 2025 01:34:49 -0800 (PST)
Received: from redhat.com (IGLD-80-230-39-63.inter.net.il. [80.230.39.63])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47787e2ad4csm81404125e9.1.2025.11.13.01.34.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Nov 2025 01:34:48 -0800 (PST)
Date: Thu, 13 Nov 2025 04:34:47 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>,
	virtualization@lists.linux.dev
Subject: [PATCH 7/8] virtio_ring: fix htmldoc warnings
Message-ID: <975dd9115d8160e8a17a4adc6ae39d05b3cff037.1763026134.git.mst@redhat.com>
References: <cover.1763026134.git.mst@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1763026134.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent

We get:
  drivers/virtio/virtio_ring.c:3174 - Missing parameter description for vaddr in virtqueue_map_free_coherent()
  drivers/virtio/virtio_ring.c:3308 - Documentation mismatch: expecting prototype for virtqueue_mapping_error() but the actual

Fix these.

Fixes: bee8c7c24b73 ("virtio: introduce map ops in virtio core")
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 drivers/virtio/virtio_ring.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index 7b6205253b46..1b32aa38d26e 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -3166,6 +3166,7 @@ EXPORT_SYMBOL_GPL(virtqueue_map_alloc_coherent);
  * @vdev: the virtio device we are talking to
  * @map: metadata for performing mapping
  * @size: the size of the buffer
+ * @vaddr: virtual address of the buffer
  * @map_handle: the mapped address that needs to be freed
  *
  */
@@ -3299,7 +3300,7 @@ void virtqueue_unmap_single_attrs(const struct virtqueue *_vq,
 EXPORT_SYMBOL_GPL(virtqueue_unmap_single_attrs);
 
 /**
- * virtqueue_mapping_error - check dma address
+ * virtqueue_map_mapping_error - check dma address
  * @_vq: the struct virtqueue we're talking about.
  * @addr: DMA address
  *
-- 
MST


