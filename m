Return-Path: <linux-kernel+bounces-899046-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 199BCC569DD
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 10:35:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 59CB7347613
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 09:35:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3F50332EA4;
	Thu, 13 Nov 2025 09:34:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="G/s7qV5N";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="KVsG7Tg/"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F5DE3321A8
	for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 09:34:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763026485; cv=none; b=oO2ZCmA/wGx2P26DZZQQIepA2xs6YtJmGE/4QyvaPziCYyVNj3yJw8XUg7XIAqGKNkRfcmtuXLA+QdKP/Xl0CHUnBR5SA1pdLI7jm0Ud/mTV8D1RiVE6AndoexnMc3f1XTeGzaZwoQo57iKFWev4u9vbfJOHSZJhkmKwiBvkCHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763026485; c=relaxed/simple;
	bh=Xruh3Ywcz1D3n7/nuy4V7sDlr0NblGX/5QKZaGOoVAY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tduJg1rpz9b2sOgb+A/wbIb6e1wq08Ehws4z6oglr8hjc4gdiQquTKsosmzytPIpYZ4mrfIu0BFt24qL659ZG3cpVggksA6pktVgZQjCo0iXYEedy2gjwap18wOQ2CJMRgH5s+VJhycgLIXdn4lGGdwOL8UzColmL2P9mtP9t0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=G/s7qV5N; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=KVsG7Tg/; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1763026482;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SsUUwKWRnkOljoqqPyGEmiTbFEa75LNxpqXQAn8U4is=;
	b=G/s7qV5NQSNHvdcdoxlFOpRgWoYCDtA1iHxWweJSytwpO82EdZifnx1eIClHX8fo75mCNL
	47KJNiEeCTZVt4NCF1HXl0dZVKYmeRfC/l42gImDsHGNYjLwoakiDNhICwwSVqzEvKKpni
	zDuxtLHBtQ6p3WdiPFvo32QTO8BSdc4=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-120-6dd9WASGM2O_v--O1VHmnQ-1; Thu, 13 Nov 2025 04:34:40 -0500
X-MC-Unique: 6dd9WASGM2O_v--O1VHmnQ-1
X-Mimecast-MFC-AGG-ID: 6dd9WASGM2O_v--O1VHmnQ_1763026479
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-47786e12f7fso6861775e9.2
        for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 01:34:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1763026479; x=1763631279; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=SsUUwKWRnkOljoqqPyGEmiTbFEa75LNxpqXQAn8U4is=;
        b=KVsG7Tg/HF9M0Q25UN3DKYcQugLRLh+zCZF/Uf/YvU30ranLJzuYCPCUubLmNBX5YA
         iFgEMIbm0eDJZgNly1CklxCCtf29Jlz630qD/Z4XV+JFUEDuypBCTCUmS412mFf3Xek5
         p8/YmoixMh+obsL5QMo9cTLDe2xyTUt52XeKtKPw7sUQllPFD7D3BAI4FYKLgdWeL1KJ
         uvGmXwXOGJ3kpy1EgNnadxpdzzwHkka67x9+qQyQ2jmohS8KMxOjaiWmzc+OL7ayZ95t
         2wNcLiZ0Cy6MmHkG2XOOUBxpzCBSlaUpTU1SVuO/lNk8PmL+8ncb5+LQ20bXN6PkI62r
         eGfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763026479; x=1763631279;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SsUUwKWRnkOljoqqPyGEmiTbFEa75LNxpqXQAn8U4is=;
        b=OSLzb50xlHMq1UGEoBRQCCJyJEa9etiKuiJjrDKFIStiuQL1xprTYaj0TMWl0HH1IF
         /XqCvlVNhabcxn+B+Zzo8C/cbKK8ZcuYBcW8boIx58pwKsa2Z8qCrYasdHITk4ufhhGx
         anwEOdyvmZf/f87JlAqfPlvsv3DUeMW5QGTytomiORKbPowT3688gHHwwLBROOCWoqpC
         qp1yQfq7hWIKn+tqRZwO7HKm8KwBxcgmFOYso5VUnmRfKxj//AoL8YTQfQxAWPWOnDwk
         4vF858knBrTgNfDJcUHDgtRmQeeV+TNDWYezTEfuYHBluCtKzi3wW5RfDNrsSiyy/Ws4
         Qg5w==
X-Gm-Message-State: AOJu0YwoaWaJzuUcrJqByE6dpVC2wbE4aeBdHAk3ZVuzgpbEGPkTFbg0
	srCjFIUGdT5HYc5lo88AKDtUQOIs9U9ZE2QSViah5F6ght2gohi4jgsK/iGtyRgfFEq2NpY/uXl
	OCuqvdwZv0zLDnvrKtHkd5/+ZvodIzXQGYd19eC3PDCzhB7uaKaF5I7Eyp3KhaaC2HUXvMaMFSF
	BkKjffYfphCa+NhDb6OHmX3M17dbvK7B6EwRpxeA8N2sh9qw==
X-Gm-Gg: ASbGncugus77gLplMgV56Iqa3Hkl28O902w4ZNBZ57O6yXE3qOlwjDimoeF2THSKu85
	3pdGnhOMUoVu3so+64ZlLj9LdZStjan/ac7Q4SbvUWQ7yC32kEHs0lPc5jR9YJUJusHWoesvxeU
	oviHVml6axNimKos5/WHz/4o/1fE5/5ykysQ4Rvmt0ecWIusCvme4B4RZ2uxD/kS83Gjv72L7XO
	6/d8kvpZ67F0N7kkbyUzHNwC/FCt20reUxicRne8yCy2wQhWG3o+LXFoN1Gaa0G+bvPLWGaqpr7
	ZS6v77/kn6MUWOoIb3MT5GQDZsn9cI9cwWmMxWW1hHqlzOPq1vGpP5yBTCwmM+QTWhNTW0SUKjA
	vHsi05Vh0QMRs/Ud6P3E=
X-Received: by 2002:a05:600c:8b38:b0:477:c71:1fc1 with SMTP id 5b1f17b1804b1-4778708589emr59187485e9.19.1763026479039;
        Thu, 13 Nov 2025 01:34:39 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGPII++NrZn4Z+gEqXZEfn9usn07cUnqFaMupGk+enop5M03tCCv41vu4D68di3KuTfwLYyTg==
X-Received: by 2002:a05:600c:8b38:b0:477:c71:1fc1 with SMTP id 5b1f17b1804b1-4778708589emr59187025e9.19.1763026478447;
        Thu, 13 Nov 2025 01:34:38 -0800 (PST)
Received: from redhat.com (IGLD-80-230-39-63.inter.net.il. [80.230.39.63])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4778c847c3bsm24629445e9.2.2025.11.13.01.34.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Nov 2025 01:34:38 -0800 (PST)
Date: Thu, 13 Nov 2025 04:34:36 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>,
	Jiri Pirko <jiri@resnulli.us>, virtualization@lists.linux.dev
Subject: [PATCH 3/8] virtio: fix grammar in virtio_queue_info docs
Message-ID: <a5cf2b92573200bdb1c1927e559d3930d61a4af2.1763026134.git.mst@redhat.com>
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

Fix grammar in the description of @ctx

Fixes: c502eb85c34e ("virtio: introduce virtio_queue_info struct and find_vqs_info() config op")
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/linux/virtio_config.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/virtio_config.h b/include/linux/virtio_config.h
index dbc7eff1f101..78cf4119f567 100644
--- a/include/linux/virtio_config.h
+++ b/include/linux/virtio_config.h
@@ -24,7 +24,7 @@ typedef void vq_callback_t(struct virtqueue *);
  *        a virtqueue unused by the driver.
  * @callback: A callback to invoke on a used buffer notification.
  *            NULL for a virtqueue that does not need a callback.
- * @ctx: A flag to indicate to maintain an extra context per virtqueue.
+ * @ctx: whether to maintain an extra context per virtqueue.
  */
 struct virtqueue_info {
 	const char *name;
-- 
MST


