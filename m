Return-Path: <linux-kernel+bounces-724469-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F8D0AFF34B
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 22:56:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CA6B75A3D82
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 20:56:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99F6B241C89;
	Wed,  9 Jul 2025 20:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Yur/WbOc"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 909F923BCE2
	for <linux-kernel@vger.kernel.org>; Wed,  9 Jul 2025 20:55:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752094540; cv=none; b=o/sA0JbkaYCr6jUfT1rT6TcX8d9xNHNvNQ472RmDIKB2e+5dXNQ04ZvufFBar3xL8pp6MgdjgYH4rLBsdj8eSONY4zw+57C6MUNckirQ9C/JZpYKBMc9eZc1KXBfe8iyLgadQe9ohZ7aBSkKQjj/fwOtBMsyOjt+ymSUHW1n3Vg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752094540; c=relaxed/simple;
	bh=PUGyVN4OJqSqheGuV7u25IOAaInhgOsYis9mxDJwLeY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R1+XEXmI//GxJMViBDkMmscINxL8MBcWhp5ECl5jozp5KaArxdnV0YoKW4rFexD+llM25Yy0CbCWO4khdiYahp5EcM/3/Z/tbSa5SgiGaT00WazFQsfES8zvJ4epYa8tMA+RUTFCkrtm9EDDUI7PYl0lNhD0poaIjijKcQkDWr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Yur/WbOc; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752094536;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Y/PjBes3xfnhRnjsZQuw1IljDm3PZO9lLi6jhdLLbvQ=;
	b=Yur/WbOc0GGe2uQTkZBdvhuhqbTPO+ePWJQq2p/NWJtq9CLCpiBrO4knP8ccw3lKJPt1U/
	am9Yu1yp2E1gjGVq9I+cJFOQ3F1ymjKv2poS7UllYwxTjjPlZFcZ7+azG1cSaCRq1ZbVGg
	bZ8NPGtw9GsDEdo1Wh78FFZZzmyYM0w=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-629-9B7F8_BRPlSbuYo9hEiMyA-1; Wed, 09 Jul 2025 16:55:35 -0400
X-MC-Unique: 9B7F8_BRPlSbuYo9hEiMyA-1
X-Mimecast-MFC-AGG-ID: 9B7F8_BRPlSbuYo9hEiMyA_1752094534
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4538a2f4212so1183155e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jul 2025 13:55:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752094534; x=1752699334;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y/PjBes3xfnhRnjsZQuw1IljDm3PZO9lLi6jhdLLbvQ=;
        b=UoVomPQoQX655rags98v/coUJsMLpAHYrYA/F3G9eVhyf4L5NDQea/Wcoy5gfgSZ1Z
         mStNxJBZXqLteLRnLXZmd4Jtmu46TrAiZJB6dNXgIoukDb6lUjsCB3FQGyxzP13uYBfj
         gT4LsZDEq1+xPBgT+qsVxoTn+/Bsdc+5aNbqMivOJVG/80ub1k0P5PA66+s9YiOHJF0p
         8uiyVTVpbEXeS7EJqqLGYRHb4d88QfIa2GMWh7ScQiq7MC4a2yfNUUgU2aM4gsIBMvDx
         cUhxPyqrjkEA4jkBlEtlBguS0AlLktTX8sbfgAxMr0Ilcx6o2NGYFKwJZso7r3uzjapP
         CeIw==
X-Gm-Message-State: AOJu0Ywid8Dir2TpAMpk7WwtuSwC7x1hk6evhBbaanqR9LzuTpd13G8L
	MrQYY/4IDHcGiCyZnxSmpM8wqcWGtAY0QOPdU7FGCFtFZPatSmuB/cCub8dejK5Gcy/UzwMCuGg
	lx9T0yWIQAvlSDbCOCgG38eCMjrIm8uHbPJdI4Js3CAWDInraJ7xn7al8R8a2uHe23H1VyrDqH6
	U5h1Zavqz68BCCp0MMnc1eR9Edji65v3hjhal7DD9yvCA=
X-Gm-Gg: ASbGncsfpCfLC4tl08kdt+3qh5a5euYbxz04/0bP+DvwmS8R7Qvw1LaCIKlewOhyyCu
	j3BoS2raWa3xeBQitR8Si7ZDAQi/bJoOdX16yCsJ4qdpuXAj9dTiLZYRHkCcM0yNAsvtK2KRIhv
	8BS+pUIQ/XPoTTuY11PP70k6DRxzgZrUN8GJSmoK/gvTKreX39lujGe5TFOufFvHipeqLBk/NsI
	9XxitCJ1beFXlWNqniBKR2JGHJd9Vqyjl8zhrefG5wHRpRFG1lVwqgfWO/vqSq3Fn3Mgbaavlnw
	10fLVBYXKVIHhXI=
X-Received: by 2002:a05:600c:19d1:b0:441:d4e8:76c6 with SMTP id 5b1f17b1804b1-454d53f3136mr41919385e9.30.1752094534200;
        Wed, 09 Jul 2025 13:55:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGvtzRfPYPigjuG7evCZ9GSCMu34t4nH9W9Zvmdr8ctw27FNFQTVrA3clj+tm0lA0zRoYKbtg==
X-Received: by 2002:a05:600c:19d1:b0:441:d4e8:76c6 with SMTP id 5b1f17b1804b1-454d53f3136mr41919085e9.30.1752094533725;
        Wed, 09 Jul 2025 13:55:33 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:150d:fc00:de3:4725:47c6:6809])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b47225a2dcsm17021160f8f.71.2025.07.09.13.55.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Jul 2025 13:55:33 -0700 (PDT)
Date: Wed, 9 Jul 2025 16:55:31 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: Lukas Wunner <lukas@wunner.de>, Keith Busch <kbusch@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Parav Pandit <parav@nvidia.com>, virtualization@lists.linux.dev,
	stefanha@redhat.com, alok.a.tiwari@oracle.com,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>
Subject: [PATCH RFC v5 3/5] virtio: pack config changed flags
Message-ID: <65da7bde75cdd7ca7ecbca7ca10f51277b44f86f.1752094439.git.mst@redhat.com>
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

In anticipation of adding more, use bit-fields instead of bool.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/linux/virtio.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/linux/virtio.h b/include/linux/virtio.h
index 64cb4b04be7a..be0beb16b487 100644
--- a/include/linux/virtio.h
+++ b/include/linux/virtio.h
@@ -149,9 +149,9 @@ struct virtio_admin_cmd {
 struct virtio_device {
 	int index;
 	bool failed;
-	bool config_core_enabled;
-	bool config_driver_disabled;
-	bool config_change_pending;
+	u8 config_core_enabled:1;
+	u8 config_driver_disabled:1;
+	u8 config_change_pending:1;
 	spinlock_t config_lock;
 	spinlock_t vqs_list_lock;
 	struct device dev;
-- 
MST


