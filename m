Return-Path: <linux-kernel+bounces-899045-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1440FC56A91
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 10:44:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 72322421A5C
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 09:35:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2F17331A6F;
	Thu, 13 Nov 2025 09:34:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ANC4pweQ";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="LmlxEEqP"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60B0B329C45
	for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 09:34:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763026481; cv=none; b=EoHIMoYWc6HDE8fC8gSdJ1k0bwrMvYEKvwRa2GSlCbyv0l7Ep3CmEihTWxH0GJ2PYRt7ruNrFd64SJQyt5yhdIPfK60VndWiNj0WzUDh+6k3SzQZ1OgmaeSyJvrqVsSTSP16mOCITbtDLQ522zMudOYBzp3iZJtNFYpgvg51+bA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763026481; c=relaxed/simple;
	bh=tyYSURQXeVxNp/4vyFisyXOs2A6aYVxtncwl6UimOqo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ceSEDQhtc0SML8BLQPNnqSfxukMScXyayIbfs0YGWDbgde48ikcMjVRmDVsjuHauils0hI7VD7HX0+ob7yOENplgwUh/orxWJ04njUhJN70IutMjszToCzkm/rRVOTFQmZmn9ASvPrRWsrSHL4izJ54rFzaO+w76wEl7L4eoAzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ANC4pweQ; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=LmlxEEqP; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1763026479;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=q/+HLsDOj8lVO2SBlw/DVfzinJavO+RsEnhPif6jD0c=;
	b=ANC4pweQR1fnLFaVGs3jrHcmGb7WjbBrb+bIOyus7y3J3H26Sh+IWjtxWb+2jeDlfy6l9y
	xal0S5LbazaqAXH6LlzxXf+12ZC30JRk3IYmngJ0aUD2UCp/rr3TLv7Sa7LTcfNI/PImGu
	gI630nGpAFj50Zp8eiy4O+VVzzrHwVc=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-684-LVV44v_YPQ2gl-jaICvSWQ-1; Thu, 13 Nov 2025 04:34:38 -0500
X-MC-Unique: LVV44v_YPQ2gl-jaICvSWQ-1
X-Mimecast-MFC-AGG-ID: LVV44v_YPQ2gl-jaICvSWQ_1763026477
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-477171bbf51so3316035e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 01:34:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1763026477; x=1763631277; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=q/+HLsDOj8lVO2SBlw/DVfzinJavO+RsEnhPif6jD0c=;
        b=LmlxEEqP6P8bLQ/DzaNI5AdwXzkGbRj2boIzqq3neItcWxpiWwG8oKbhRSjx18HNDb
         d73CyEEbCqmnFrhs/jVBVba+L/h7fn/hDC8iG3c9KQBdk6Nb72/MTHGWYkD8XHPR6OK7
         s+HXNrXg7apUWZVUvtjL//lR1mGHFPDONZzyeQPWlGTm8ctiKjx4slC6ncCQzePskNS7
         gzVeDyRgDKj6ppZQOkkSKq7lWHz653HZoeTyJ0FpMJJk9R1/Jqlcr0qHE7H151WfXgcN
         Yl4cV98llYVeSHVxv0XhUSNc2+favl9TMF1FCOaGcdokuOSK7zbqOl/m38C24GzbQAi3
         jioA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763026477; x=1763631277;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=q/+HLsDOj8lVO2SBlw/DVfzinJavO+RsEnhPif6jD0c=;
        b=C0LIgxBkDZ/eNXUPJPIlNbZewuCSlltfOlhYRbthaKZpFwaXB3Qi+GuU2M6zT6tyQr
         F7lJATdH6JUs9SaaS+2LMDpsC1qYHEj07JCcKtol9DR0BEi1Cr2sXe/t/6h4jQxsT5H3
         lrx0uQ8f1YjFm3OX+pW7+e/KHy1A3ldjUyTZyUuzdI1U7lVK0EpaNyojPFQPFC7mbFK+
         6a1ZAmSmNMh0v86P1D4KJlF9uTZlXXawpXmmlSPv5UD742ZlNbKf4a4XjUFGWA3KcLsI
         kDMcXy+kt3pI+BZur8pkwvi7s1XFTX7LJl5nCrIJPBt3HVgfduiomRqXEQ+ZGzRJIDia
         odag==
X-Gm-Message-State: AOJu0Yzwae/SSK+u9iyUSrt3AexUlyLqbALSokzT27h7WxjBoP1FMkwd
	bwB6O0bNiMnFkArbmII+Okh87eyj2O4v4QLtfco7pUilIcvSjnv9jqOMC7ikykKLnkdsvjgOAeg
	IUo53ztn8GySVjYpaVesvdEd+izQYgVvShsVfkSSNM2HDKOrHb24gtGzJ/2dHjyJX1M/dCmtcMW
	XldP2IyIZx3kQIIWx5/q1wjGbygf3V0WeVSBUukt8ecKSHAw==
X-Gm-Gg: ASbGncu6pvc6oPGYmwJLQ8SYWQyOcq7cY/uUwo1azjRWGJ9kBsqR1qXGdH1yhQJ7MpM
	0XUIPy6biqtpWNzoIal5tXu6VBldymFqRzR9Hb+e+oCtk7AnBhGODyW2JhKXRZxizTOku0uRtPW
	iiL9w2MTTAluJJ6YpApusGSpdapcvqBFKCysC6y7IP2lJeJ/S7DRwDkMjRk2d9/e9s8FdbUXunU
	XjozULIXzNUpdKDdyst77SKNQ30yGkwnfftIOdHdrbxjfYiFFSNmoOPtvy/U4lqfzIkeJGTUXgJ
	TeuzXtKfZmQvZKSnKAlcezPieJHxRiUbtuK6gD+WQ9eYRfYJQmVCPAwYFL+fdWoTFKdGYYWZNLl
	1AhFqcmz8+WUM64Ouo4A=
X-Received: by 2002:a05:6000:2104:b0:42b:2f79:755e with SMTP id ffacd0b85a97d-42b4bb8af8fmr4787387f8f.3.1763026476637;
        Thu, 13 Nov 2025 01:34:36 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGb0qa2odsCLZpXfvEMIlpyqYfQSp2xbqJIge8MQT27yKgJ09CD50eDjKDkXPnMfyvcv6s79A==
X-Received: by 2002:a05:6000:2104:b0:42b:2f79:755e with SMTP id ffacd0b85a97d-42b4bb8af8fmr4787348f8f.3.1763026476194;
        Thu, 13 Nov 2025 01:34:36 -0800 (PST)
Received: from redhat.com (IGLD-80-230-39-63.inter.net.il. [80.230.39.63])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42b53f174afsm2824098f8f.33.2025.11.13.01.34.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Nov 2025 01:34:35 -0800 (PST)
Date: Thu, 13 Nov 2025 04:34:34 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>,
	Bagas Sanjaya <bagasdotme@gmail.com>,
	Ricardo =?utf-8?Q?Ca=C3=B1uelo?= <ricardo.canuelo@collabora.com>,
	Cornelia Huck <cohuck@redhat.com>, virtualization@lists.linux.dev
Subject: [PATCH 2/8] virtio: fix whitespace in virtio_config_ops
Message-ID: <39d7685c82848dc6a876d175e33a1407f6ab3fc1.1763026134.git.mst@redhat.com>
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

The finalize_features documentation uses a tab between words.
Use space instead.

Fixes: d16c0cd27331 ("docs: driver-api: virtio: virtio on Linux")
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/linux/virtio_config.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/virtio_config.h b/include/linux/virtio_config.h
index 1ea5baa62141..dbc7eff1f101 100644
--- a/include/linux/virtio_config.h
+++ b/include/linux/virtio_config.h
@@ -86,7 +86,7 @@ struct virtqueue_info {
  *	vdev: the virtio_device
  *	This sends the driver feature bits to the device: it can change
  *	the dev->feature bits if it wants.
- *	Note that despite the name this	can be called any number of
+ *	Note that despite the name this can be called any number of
  *	times.
  *	Returns 0 on success or error status
  * @bus_name: return the bus name associated with the device (optional)
-- 
MST


