Return-Path: <linux-kernel+bounces-899048-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id C7CDCC569F8
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 10:36:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 99F3D347244
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 09:36:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4204133375F;
	Thu, 13 Nov 2025 09:34:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SYHMyJ9w";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="FsuSY3OF"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CE1C333444
	for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 09:34:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763026489; cv=none; b=uyYXRp3IlLKwnLn0p5OKQH5xdMqxzKlIteSLS7sbkP7pI0bmu06J39M6uTO/00GPMp5bdr0VW/ZA4OkS5qUPlTKrIPb0XKmOFCPJxBBKiOvMox388/V5dUcw+nsC/D0fPcVJDjHzdZ/M7Y/INekpBFNlVywJKt9eCBpsSKOUMGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763026489; c=relaxed/simple;
	bh=X2MHxzmOtiIQ8ZjSTogxws8F4QugGtz4XXzmDlmK5aU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AnUrOqINrK3/UUDbudCuTQK4kYi/b1ESXuMM2cXU1PesUezn2st0bJHZJIVasN/+vFkdl65XyngsdUpRVdsJW1KBT3s/urjcBRc0vV7CH+fzKJdNbDrUoQaods0LbB5kqktYJFAvNNHpYjbFYV+9mPQf1Oyd/tt20mHvbqJTwLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SYHMyJ9w; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=FsuSY3OF; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1763026486;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ZlOSk77TvYr08CPHtBLqV/3i17PN69Yk5p/etd8KwsA=;
	b=SYHMyJ9w2Io49apWMgZPJzCElKZyNMzUWzS8H8lCuwsW1kUps13vuFKRtNlrPkpyo3gTni
	g0lBPQY6y7O3ytMkZqB5mE2PM5mo0kTn2uoKVwQ+YaXYjLPf0X1rFjum4ZSJLfR6uW+GN2
	z2B8XPWREstpAR60Hx0RoIwkggOHX38=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-481-_BLvvYJIOhm5N70upoU17w-1; Thu, 13 Nov 2025 04:34:45 -0500
X-MC-Unique: _BLvvYJIOhm5N70upoU17w-1
X-Mimecast-MFC-AGG-ID: _BLvvYJIOhm5N70upoU17w_1763026484
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-42b2b9c7ab6so254316f8f.2
        for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 01:34:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1763026484; x=1763631284; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZlOSk77TvYr08CPHtBLqV/3i17PN69Yk5p/etd8KwsA=;
        b=FsuSY3OFNGnUdPDta5MfaCSsQ3/j47RsyveUT7qubQS4R9H3NaH6aaeEkfCM5ipdrJ
         baer0ePNJA+u+D7t/YKdTwy45XJ/B0GGq0DyUpTFWrK+TyBJXsnWA/ytbY9glBB87tNS
         3zFvLIwY92e6pB5VOUVtlseHe+0SgWyZwMMWSWfZi/A3vfvVtrP7IAcr3P9jPHpgKm6j
         5vei6oL3DAYbWefTEAGs6IqzjDLdfF3ESaQBbahBlsQrrXyo6P8RuB96EfKzXVKXrr2l
         YXfIpXad6voJSinZIrTS7TqhHhTlC0FU/SCzKhvYMTKb436NM9fR7ys14r15BVtKg3ON
         vJyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763026484; x=1763631284;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZlOSk77TvYr08CPHtBLqV/3i17PN69Yk5p/etd8KwsA=;
        b=V6i2GQ6C6kftWRwiincxuCqZMGFpwUXZvGhRitmqXdER65rHdCA5rTcq8mw6lHmoU/
         5+XPWBRO+tvTwPzxykObZQg+aIUiWMmHaDci0HNTpi0zkw8FnQ7af/P3SuPz4KkHpHGL
         mAcBUsusx6puckdBBCG4472UG6jMoW5h8okdqz4e1kFoneGFf2Ui4Bdcc3UwXuHqkrCv
         qf+8rMWzKKupOqYpv6/XKgTPlcnK0kMELmRd9YgXC8j5XHmoiw/3YvWSM/O7v8vKh4eN
         Fmj9DOOXQqWXbQQ3j+1/yydyxYzzTo/NHWSnpTFVcGPnPwBsFMlU3hteK8oCgfoL8VeG
         Gj8Q==
X-Gm-Message-State: AOJu0YxAuFF4T3w5X5N15oVWFzMBzGJlkZwZzj+V+ldYTPo6P1DJiJHf
	Hnlqg7LTE4BpisOnqC8UBbj/+DKWO+sJ0agSoDnV1tlUxMoQ2m7q4QfPn169CT0GdW+GKhxiwt1
	q+YTZLnefv2EOgrwXtSCVOivDtg0dtBZImwkPG7bnY2cRR5bghzA7WK2BWBy4Ly9vyAkoinhgQC
	qgLnSeNE1IxTbrjfkbD5UpMGAC9W5CsHx98wx0z4C8dPvVjw==
X-Gm-Gg: ASbGnctMOQhQxroawPB39CZ4GZ99KMYmS6CI4DLDPqQwE9gmsW3osBTF0B8Kjsb4Pjs
	sksyirGiAfxQ0/iMdLoiaHL9BaWuQJ92UaIomFYQzsSeeR0ulArYYfpqUt6O81eGOWyc6ORNrWg
	KGSZQuCq3SxictGoHf7NCCIp8MbfVBWDLaM4ZQsoumYYR8jnqAjWGJGQ4XIE9ATWCYN5ZCKhEbq
	Z7JNvfDNnjru/gDGAgEaks3GP+Z96s1VMPj/WIo+LUhsqvrOQtIOVGJ9Wwv2k68gh8Q87ilJpVR
	NXl7ka2vMnDHQEpQlrX2FKDz6tx9uEKOVL3cybeydngRniDOSu9kkyaGNgNJVhNoCHK6T2d2lc0
	FxwR8J3KVe7tA9pp/PHI=
X-Received: by 2002:a05:6000:420e:b0:42b:43cc:982f with SMTP id ffacd0b85a97d-42b4bdb0267mr5749995f8f.39.1763026483560;
        Thu, 13 Nov 2025 01:34:43 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEtNW2d1OKL8QSOQbEcnkG/4WCI8nXAHj83lbgVXftVz3WJ6bAWcET3xmzjhJXnDc6RTdgBxQ==
X-Received: by 2002:a05:6000:420e:b0:42b:43cc:982f with SMTP id ffacd0b85a97d-42b4bdb0267mr5749954f8f.39.1763026483069;
        Thu, 13 Nov 2025 01:34:43 -0800 (PST)
Received: from redhat.com (IGLD-80-230-39-63.inter.net.il. [80.230.39.63])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42b53e85e6fsm2918118f8f.18.2025.11.13.01.34.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Nov 2025 01:34:42 -0800 (PST)
Date: Thu, 13 Nov 2025 04:34:41 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>,
	virtualization@lists.linux.dev
Subject: [PATCH 5/8] virtio: standardize Returns documentation style
Message-ID: <c262893fa21f4b1265147ef864574a9bd173348f.1763026134.git.mst@redhat.com>
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

Remove colons after "Returns" in virtio_map_ops function
documentation - both to avoid triggering an htmldoc warning
and for consistency with virtio_config_ops.

This affects map_page, alloc, need_sync, and max_mapping_size.

Fixes: bee8c7c24b73 ("virtio: introduce map ops in virtio core")
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/linux/virtio_config.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/linux/virtio_config.h b/include/linux/virtio_config.h
index 6660132258d4..e231147ff92d 100644
--- a/include/linux/virtio_config.h
+++ b/include/linux/virtio_config.h
@@ -150,7 +150,7 @@ struct virtio_config_ops {
  *      size: the buffer size
  *      dir: mapping direction
  *      attrs: mapping attributes
- *      Returns: the mapped address
+ *      Returns the mapped address
  * @unmap_page: unmap a buffer from the device
  *      map: device specific mapping map
  *      map_handle: the mapped address
@@ -172,7 +172,7 @@ struct virtio_config_ops {
  *      size: the size of the buffer
  *      map_handle: the mapping address to sync
  *      gfp: allocation flag (GFP_XXX)
- *      Returns: virtual address of the allocated buffer
+ *      Returns virtual address of the allocated buffer
  * @free: free a coherent buffer mapping
  *      map: metadata for performing mapping
  *      size: the size of the buffer
@@ -182,13 +182,13 @@ struct virtio_config_ops {
  * @need_sync: if the buffer needs synchronization
  *      map: metadata for performing mapping
  *      map_handle: the mapped address
- *      Returns: whether the buffer needs synchronization
+ *      Returns whether the buffer needs synchronization
  * @mapping_error: if the mapping address is error
  *      map: metadata for performing mapping
  *      map_handle: the mapped address
  * @max_mapping_size: get the maximum buffer size that can be mapped
  *      map: metadata for performing mapping
- *      Returns: the maximum buffer size that can be mapped
+ *      Returns the maximum buffer size that can be mapped
  */
 struct virtio_map_ops {
 	dma_addr_t (*map_page)(union virtio_map map, struct page *page,
-- 
MST


