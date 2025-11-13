Return-Path: <linux-kernel+bounces-899043-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E0EEC56A7F
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 10:42:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BC3BF3BE4E8
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 09:34:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D85532ED20;
	Thu, 13 Nov 2025 09:34:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fnW6iPQM";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="U6v/TzT9"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3340D2D73B5
	for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 09:34:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763026479; cv=none; b=uj4UmEgqrg/nQ2tO6e0ty0RS5FDACacjubiw5tK0fUwe/+Av4MfoC8p7ZKN8JNlD2GDXWNUBrtYoPk8bTNswkhIjFu7/yfgF0l+AwJhbeuspt79fVqy/cnAjf6o6Jca14EV6EoPXJ1B6rN4DBL5AsRenNxQ0hW12W5XBL9vpG0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763026479; c=relaxed/simple;
	bh=kjrUKosoH2VXUs3fSIWEtTAoeG02LoiL///bz2ZXM4Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LHaoe1GSsFbYALOv5Uev5laqD687mfmQSY8X9qcgsHrqTUFheI8znQ0rvD0wf7b5nmy8JE2j0eOBHrLo5g7t5grZC0tBwqMUMel2CSG3ClSjaKiYGuZ8hcmLYLoPOx5wS2qBehAOcc0YiSwJ3wu9VCcdr4GBjVEpcjNvwsFY4LY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fnW6iPQM; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=U6v/TzT9; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1763026477;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FN+8TdeE9rBb1ts17t7km+0CBPBVtlQA4WgPCGrmer4=;
	b=fnW6iPQMoc4iP+StgWG6ynPvWlZBRCL8AwpU5iujjpx64XHR1TdsxWNS72n0+dYntcl9mt
	bjDpBuBjIxHqplcWx/P9y4q1NVdqqZZHgtMSPQZr/1E+ydcYVAD4TzbXvOh98IUy/kpy3e
	vdz8r4cFb58fC++lj1qKTTGkRo6R/vo=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-571-eI6IQEU_N4qCAS9geaBMbw-1; Thu, 13 Nov 2025 04:34:35 -0500
X-MC-Unique: eI6IQEU_N4qCAS9geaBMbw-1
X-Mimecast-MFC-AGG-ID: eI6IQEU_N4qCAS9geaBMbw_1763026475
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-477212937eeso3630925e9.2
        for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 01:34:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1763026474; x=1763631274; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=FN+8TdeE9rBb1ts17t7km+0CBPBVtlQA4WgPCGrmer4=;
        b=U6v/TzT93zXb6JmQHTHKUalugapKnmSIDZhlCmLNw9qI4pmRdxDh1tFb/hMafeCSZL
         JK5o8WP4WPjh5jcaK1ZHHw/kFPC4e/OkwLTMZ1x9dkIpKVrOPB2ckMKa2H1eBGXvVI7g
         07+uAYE7rs4vLr0a0dpFuJrrob7/g2fHmHTI0k9+JZjzkTP2JeSvLaVR83WD5dRenCoW
         NlLtV86aAF3EXdkAzlD1V05HqKyiYy6Z1+vMzgTJTaXfuyu5mVErjYAOa4N1mup/6aYq
         Ajz+ua6BoML0E6jcJPSdgzbFsKAZ0i93h7MjbGQJysKP0FYcZ9eXV7N26fnHunyY0bNn
         eySA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763026474; x=1763631274;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FN+8TdeE9rBb1ts17t7km+0CBPBVtlQA4WgPCGrmer4=;
        b=vALFw+IqB1Oc2wvop5nue7/6XFpFvK68lwUoBN3XU7P9BhCqWoCVYGYh9TwREgFsXy
         mhzZIBxqqiVEqYigfMki/TKfGi6EcbaSvASEYjvR2BSwQq8Ci8BCxBtRK3bD6AXeaXwX
         ITezBVhfqNLQxQJmVb7tanU1gyzzKFWY6Z2FEH1H+LoLfMT4YjMMSsMf1lt4Gt+EIBf7
         hPMHc8yZohWXLQjZu+vH6+oZ2c9KHql4L7g4igFKC/10EWgX79JDNADnymJZgU/hnouB
         rPOGytmsUw1RdyGou/+sjZQ6644BhmPVIFhcl2vqcb5He7kUNTyUqHDDTwfDtc5V43s2
         01BQ==
X-Gm-Message-State: AOJu0YzGytDWxhRw4czJtGoBrpIE1WbnU/pzGsPpTKTVlmR8y3rsjOJH
	DRFMKNa7+Hh3JeNXzg14EAnkC6GIAqqDAyB0i8lFxqr9/IfBX4QOfihz/N2qTAcmC0TR/L+v93r
	obBmd99jgYONySdZFG/MuOnPUcHm/B9KkVl8T0rOPidtmQf14u4bBJQQEWbvbtTaoiZNX8exPY7
	OJxXMcGKAAd+4SXPzVJvVWrFWcHtwOjGITB182kzaFBiWUQw==
X-Gm-Gg: ASbGncvMd4qe3IFgnC+t0qk7NIsDFFX4TRP+XGk9IrU+GebsSSa6dSRi65Wv1NGXG5+
	1d4NpvZqucJGtxA+0hXg5e1LxdELzoPKec9LF+ZuWlgqSiCjRSRGZV5X2EBSPwu6RLznXA8HcRr
	kNWrWkqAxUFSD0CdBBnNGPlwzMjKS3FmrbZAa96s+w4FAHkuB/ORJv672oqao4kekC243Mis0Ij
	MfzyByrWsFRsI+E9Ogs+JtkDH8Sfvk4vH/gcU7FCjDPHwynttZXyd8JhusBREW8h+QrzxaEH+P5
	5wNsdF2wCRfAWHeY6eybFQNPiyV6BgqaIyUqJudcJWC6ArJzLh6ih6IKYu7FfDedjsElDeTAeXj
	QDUut1hkScIxLdKAkl1k=
X-Received: by 2002:a05:600c:a41:b0:477:589e:6c2f with SMTP id 5b1f17b1804b1-477870c6610mr55286315e9.22.1763026474361;
        Thu, 13 Nov 2025 01:34:34 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG4WCYMpLpC8f9yzg1P8DvxA/UpKXTqph+vWP9aurFB6/f8uzYw+O0yjkaAHN+c9PD8/Fj0fQ==
X-Received: by 2002:a05:600c:a41:b0:477:589e:6c2f with SMTP id 5b1f17b1804b1-477870c6610mr55286015e9.22.1763026473808;
        Thu, 13 Nov 2025 01:34:33 -0800 (PST)
Received: from redhat.com (IGLD-80-230-39-63.inter.net.il. [80.230.39.63])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4778bd27ad5sm15790875e9.16.2025.11.13.01.34.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Nov 2025 01:34:33 -0800 (PST)
Date: Thu, 13 Nov 2025 04:34:31 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>,
	virtualization@lists.linux.dev
Subject: [PATCH 1/8] virtio: fix typo in virtio_device_ready() comment
Message-ID: <db286e9a65449347f6584e68c9960fd5ded2b4b0.1763026134.git.mst@redhat.com>
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

"coherenct" -> "coherent"

Fixes: 8b4ec69d7e09 ("virtio: harden vring IRQ")
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/linux/virtio_config.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/virtio_config.h b/include/linux/virtio_config.h
index 16001e9f9b39..1ea5baa62141 100644
--- a/include/linux/virtio_config.h
+++ b/include/linux/virtio_config.h
@@ -362,7 +362,7 @@ void virtio_device_ready(struct virtio_device *dev)
 	 * specific set_status() method.
 	 *
 	 * A well behaved device will only notify a virtqueue after
-	 * DRIVER_OK, this means the device should "see" the coherenct
+	 * DRIVER_OK, this means the device should "see" the coherent
 	 * memory write that set vq->broken as false which is done by
 	 * the driver when it sees DRIVER_OK, then the following
 	 * driver's vring_interrupt() will see vq->broken as false so
-- 
MST


