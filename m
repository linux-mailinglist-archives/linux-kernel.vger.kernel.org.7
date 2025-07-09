Return-Path: <linux-kernel+bounces-724468-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 276E8AFF349
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 22:56:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 783425A31E1
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 20:56:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E036724676F;
	Wed,  9 Jul 2025 20:55:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cKZZ/7WV"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD5EE241C89
	for <linux-kernel@vger.kernel.org>; Wed,  9 Jul 2025 20:55:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752094537; cv=none; b=MTJf0WLz0/MC2rod+ocyObQbnvsMnzwNcSY4C96FyGlFn3An3KiLifMDnU9wPnoCjEa8oyq9znVRuIZYEINPgOReaRH+4BJ44txj5muGnaSv+ih1TL+J8Waz9xEgfgQMDDx0Mt1tRhq9b5otyOO9EIRXNjPizCRG4M+TMbZ9zFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752094537; c=relaxed/simple;
	bh=fM0VFuiMREMNY+584mngGa0LdaJ7mBTcKY8yQT4Zb4I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a67EBxUU61Snq+pomEO57/ljwx+X9BgSBsRc8LjMgGvx+nF13EQ4TA3FjX34A/xq7A1jUdIwEg1SApb9VjamWkl+fa9cvXgfn3HE9mEMN5yv249+3JcdD0cUJa0iI5ydgKEdm9p7ivAxWiQez1WPLHCuClWoJZH3LkZDRucpPMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cKZZ/7WV; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752094534;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zmW6YKzoCEgs1ffMR1uB9KKsFPVquRoas1pcF/ETX4A=;
	b=cKZZ/7WVut/lrD8/7j4TRUR+KCt9nse13+/ROXjv5n25oDTBwUpK9qgY4a1ToP4c4LoDFT
	z6amiwiqfIm1iiwCsUxDoZcOhPn+1TjPh0uijrboiup3wK3bJlIFrObTjJhlbntUQpA+wX
	v3m4rmUxAJf+4eRoanm2SyFfvNAdJCI=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-392-zPrwApLaOIS0gce2saqxNQ-1; Wed, 09 Jul 2025 16:55:33 -0400
X-MC-Unique: zPrwApLaOIS0gce2saqxNQ-1
X-Mimecast-MFC-AGG-ID: zPrwApLaOIS0gce2saqxNQ_1752094532
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-450de98b28eso6126545e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jul 2025 13:55:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752094532; x=1752699332;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zmW6YKzoCEgs1ffMR1uB9KKsFPVquRoas1pcF/ETX4A=;
        b=O9vTCK9Q2HIQqNU/ASREIllDwhh2ZvSN9045WoxvelRP0+RqYmedWqvpFMsFGSG5sA
         LS72ZVyJ53CaRRyKSuSAcMlPI8UqRPv6dawAzXmwoJFmguC8mz+cD7nzs4FtJ0kDKftD
         0nehG/GsxJYmYJaBHPFtDVa+lOJYBLrcPuehwat8ihielT7K0vjZkQCls9prLG6V3aPg
         oVlGS/asiK7XUbUlHBBNqIcdU9pXM2FuX0W2dmbCiZt+m1CgTSKEw2/q0RSgRPIlan53
         pyhIZ8JPq5mnrq2TKfBQWph2rXX5Aln5RgPIRLOZFlzz10y2Zw4UJ4ybgvjKlqkrBpjb
         iT6A==
X-Gm-Message-State: AOJu0YxQs90eHEZW3w08rVcvmV6Rj284jH8JLfD37+mTOT0aoi9Y6s8Z
	x2BW3hKNQIibdzF1AFYSN8HWiWUmFlporh9+ciGpG4lVOiCH9+phE3JpvKz8sW1E+ypbAxC/mlm
	IhmeLmsCo+06s+ejo1GQFCdzZREAhvENurmDfwTZQIG/FILnnSoT/D44BYLYU56tie/PCQAEP4N
	vdUKBkFB/IW5I07agohd1YUh/Z0WAeXBhvAyB/0cv6g6I=
X-Gm-Gg: ASbGncsiDIwIFBt5bjhX7V993bECKejsherrgOSEuM684in2ZBHd4jXnrh+MAbZLI4/
	DvGvNWKnzD4vkEqVf4X4aa4nlH/fUB1LSIC9i1WyAgX9MOEfMdhljKUS1KkWQO8rniZFtNgSPfY
	LdOQ24asui1yX2RocxlUnBOpfk7nfTP5FW+s+zVwzeF+E+ZT7uj4kuWbwJiYLFx7chH84/ef2a1
	qJMjX/fEuPUhQud5nMFSNjiJ2Xxg0XCewUllzIfMqgm68Z2Og4k9m10MgL3O0u43048qHS+AlST
	hBnlGEL5kKmhuDc=
X-Received: by 2002:a05:6000:2c02:b0:3a0:b565:a2cb with SMTP id ffacd0b85a97d-3b5e7f0fa20mr1068455f8f.1.1752094531961;
        Wed, 09 Jul 2025 13:55:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IELRCPBRiwlO7UWH2UvIq0Agob7X2Ahog6Ap+1+2gzcAlXmS2/uyF9cmiofhMLKAIdBSTyk9A==
X-Received: by 2002:a05:6000:2c02:b0:3a0:b565:a2cb with SMTP id ffacd0b85a97d-3b5e7f0fa20mr1068418f8f.1.1752094531470;
        Wed, 09 Jul 2025 13:55:31 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:150d:fc00:de3:4725:47c6:6809])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b471b966c0sm17407320f8f.52.2025.07.09.13.55.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Jul 2025 13:55:31 -0700 (PDT)
Date: Wed, 9 Jul 2025 16:55:28 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: Lukas Wunner <lukas@wunner.de>, Keith Busch <kbusch@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Parav Pandit <parav@nvidia.com>, virtualization@lists.linux.dev,
	stefanha@redhat.com, alok.a.tiwari@oracle.com,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>
Subject: [PATCH RFC v5 2/5] virtio: fix comments, readability
Message-ID: <7b74a55a5f3dc066d954472f5b68c29022f11b43.1752094439.git.mst@redhat.com>
References: <cover.1752094439.git.mst@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1752094439.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent

Fix a couple of comments to match reality.
Initialize config_driver_disabled to be consistent with
other fields (note: the structure is already zero initialized,
so this is not a bugfix as such).

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 drivers/virtio/virtio.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/virtio/virtio.c b/drivers/virtio/virtio.c
index 95d5d7993e5b..c441c8cc71ef 100644
--- a/drivers/virtio/virtio.c
+++ b/drivers/virtio/virtio.c
@@ -147,7 +147,7 @@ EXPORT_SYMBOL_GPL(virtio_config_changed);
 
 /**
  * virtio_config_driver_disable - disable config change reporting by drivers
- * @dev: the device to reset
+ * @dev: the device to disable
  *
  * This is only allowed to be called by a driver and disabling can't
  * be nested.
@@ -162,7 +162,7 @@ EXPORT_SYMBOL_GPL(virtio_config_driver_disable);
 
 /**
  * virtio_config_driver_enable - enable config change reporting by drivers
- * @dev: the device to reset
+ * @dev: the device to enable
  *
  * This is only allowed to be called by a driver and enabling can't
  * be nested.
@@ -530,6 +530,7 @@ int register_virtio_device(struct virtio_device *dev)
 		goto out_ida_remove;
 
 	spin_lock_init(&dev->config_lock);
+	dev->config_driver_disabled = false;
 	dev->config_core_enabled = false;
 	dev->config_change_pending = false;
 
-- 
MST


