Return-Path: <linux-kernel+bounces-863186-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F31DBF732D
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 16:57:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8F0E64072D8
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 14:57:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89A15340DB8;
	Tue, 21 Oct 2025 14:57:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Nd4c5ci7"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 262FD340A70
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 14:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761058625; cv=none; b=hvumOHXE/MWnKQWbOyDtkIuRPVfORvo5mYNOpVPX2TTD/UCccVZ7eIHuxNx05kk05eiKY9PVeoOkvMA2H29rzUg1Cbiythg/d7nm43SMMCwtGBV2UEX037zJuBRzD1VAuQ51igDs6o8xW0qDlXJzY5/i6lT6ArHh/mvQ4YBJKIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761058625; c=relaxed/simple;
	bh=3zLiBpGpx3N7y1mDFocEIkcoo3BHMmz6kvCLUvGCdoo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XrfmKvThzgAtPVr+JsXMhmlnvwI7IC+SSFw/5mpACTul02gli2msW1SyheYrpfgTwgCLIPMb8WNgOGw7LiOZJ6i8DAXEP07tfX/WCASfFlJ5wGZNTTsgodvJKwjg4Vl20U/H0Kc7L9Wj7xa1iXiN8oQbomBJrQaEDMkXtJu8KDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Nd4c5ci7; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761058622;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ON6jaTzp8OadpSErRLgvJU/FcjQ+VbZlFjItkP49EIg=;
	b=Nd4c5ci7KiZJLTyb7Qk4/IHBsLAOIAY/DCjtl/Kq8nq2ICFDd1VmY5N8AhzBbdYVTJoCa4
	OtFT4x/M3nIyaJAIS6yFjPtTj3/vs0HqPlfO2mT8uGic/26GPJli8bKp5dsMV+UgnodU3n
	lLgP9f93eD10Y/Dxc+F9KsU1rTNfAJs=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-226-7GwYDBIFNUyYjkxeWa7Qzw-1; Tue, 21 Oct 2025 10:57:01 -0400
X-MC-Unique: 7GwYDBIFNUyYjkxeWa7Qzw-1
X-Mimecast-MFC-AGG-ID: 7GwYDBIFNUyYjkxeWa7Qzw_1761058620
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-471201dc0e9so45264645e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 07:57:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761058620; x=1761663420;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ON6jaTzp8OadpSErRLgvJU/FcjQ+VbZlFjItkP49EIg=;
        b=r2sBIaFpoc/nRCkk8pwf1VGyxdV3ftNNqQxqeAshsBWcJjAlPAGSUZT8xjw6IK78s5
         oTxwe68PcbRyrqhG+znDWJVBphYPgXkCC1RZgXQrFeRp8ZvxLYxSyK5tvP4yF4hHD6zt
         3nK4a+9XbvyZD9tZplUotCqLmraUfmQg4eiVCvJcI30p0p67EysCXRher1yVbQkouIHt
         Ti7/QI8HFdgBG8KLIwHrGyeWPinHXh/Yi2lyoIJH7y6KD8zGYRRXB7D4S2D/FDFhQzHi
         nPlrjTh9QfgMrjSjByy2ifRgsdExxq/wnATvyEyDNR50Mp3jNy7ukCGfEYJgvOEaiFkc
         JDGQ==
X-Gm-Message-State: AOJu0YyTGkhtiSxYCtV5vBkDvlhKdwaSzyGL8a8zV7P9HfhNUoKkxAW2
	0h1C0wXxa2vGTemH1rNMEmLr/KCMFTqIMirRM4EG1h6dHMnTCjIWK5x1NXbhgYFM6mTpQZ3st2d
	Te1BeYGJq1CZf8X3vSyvklli7QtThF1FT0rBxdv7aOmtp7OznE1DsibtdnkJtBgOG3ai2PJkAeR
	TwxLu7fDPKgA6o3QtHMvCtgls9qVfSDHe5D7BRI7gq/eE=
X-Gm-Gg: ASbGncvZNkKXxL6bb6kIGxfdXEF1mlG511PVJdOU5dK/i10YOAegFgzmbuGUHTPymy0
	fz3lTDSsegf6djGuR1TzJk+kxjbm6tpOoQeh7235PW+IwAIhAnTKCOw16rKxuqRCLxkRf0vlZ4a
	VmD2d7dr1A86KjO1quJlPhnNdbT/oPLydvrgsULrAnxFtOu5RkNCfo44L4F8k+P25xT56iwlaSV
	FRVIubIXz8//1FpoOQ/0t+LPxFm8oIdTp7Kc2rsKl//BuKWW85heY58AFzAzb1R/szuxWkF6EoX
	OYGir+ded6AAz/KM/cR1pO2G5OJirPqNdTAvWJ5MXL+4yrio6riCrB2xGhpDLrb+jeyx
X-Received: by 2002:a05:600c:470d:b0:471:12c2:2025 with SMTP id 5b1f17b1804b1-471179140abmr147851035e9.32.1761058620038;
        Tue, 21 Oct 2025 07:57:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHhlH9J/gDJ2/ok4e+k1pdgybvyjWEgAIxCOLewvwxsR9SE4iH4+h2twWM4wXk1Rh2Mp/BOKg==
X-Received: by 2002:a05:600c:470d:b0:471:12c2:2025 with SMTP id 5b1f17b1804b1-471179140abmr147850765e9.32.1761058619536;
        Tue, 21 Oct 2025 07:56:59 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:152d:b200:2a90:8f13:7c1e:f479])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-471144239bdsm339012145e9.3.2025.10.21.07.56.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Oct 2025 07:56:59 -0700 (PDT)
Date: Tue, 21 Oct 2025 10:56:57 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: Andrew Lunn <andrew@lunn.ch>, netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>, Jason Wang <jasowang@redhat.com>,
	Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, kvm@vger.kernel.org,
	virtualization@lists.linux.dev
Subject: [PATCH v2 2/2] vhost: use checked versions of VIRTIO_BIT
Message-ID: <5423d46e5c6f8a4204f8fe1bcea8bf1e21c10f39.1761058528.git.mst@redhat.com>
References: <492ef5aaa196d155d0535b5b6f4ad5b3fba70a1b.1761058528.git.mst@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <492ef5aaa196d155d0535b5b6f4ad5b3fba70a1b.1761058528.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent

This adds compile-time checked versions of VIRTIO_BIT that set bits in
low and high qword, respectively.  Will prevent confusion when people
set bits in the wrong qword.

Cc: "Paolo Abeni" <pabeni@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 drivers/vhost/net.c             | 4 ++--
 include/linux/virtio_features.h | 8 ++++++++
 2 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/vhost/net.c b/drivers/vhost/net.c
index afabc5cf31a6..e208bb0ca7da 100644
--- a/drivers/vhost/net.c
+++ b/drivers/vhost/net.c
@@ -76,8 +76,8 @@ static const u64 vhost_net_features[VIRTIO_FEATURES_ARRAY_SIZE] = {
 	(1ULL << VIRTIO_F_ACCESS_PLATFORM) |
 	(1ULL << VIRTIO_F_RING_RESET) |
 	(1ULL << VIRTIO_F_IN_ORDER),
-	VIRTIO_BIT(VIRTIO_NET_F_GUEST_UDP_TUNNEL_GSO) |
-	VIRTIO_BIT(VIRTIO_NET_F_HOST_UDP_TUNNEL_GSO),
+	VIRTIO_BIT_HI(VIRTIO_NET_F_GUEST_UDP_TUNNEL_GSO) |
+	VIRTIO_BIT_HI(VIRTIO_NET_F_HOST_UDP_TUNNEL_GSO),
 };
 
 enum {
diff --git a/include/linux/virtio_features.h b/include/linux/virtio_features.h
index 9c99014196ea..2eaee0b7c2df 100644
--- a/include/linux/virtio_features.h
+++ b/include/linux/virtio_features.h
@@ -8,6 +8,14 @@
 #define VIRTIO_BIT(b)		BIT_ULL((b) & 0x3f)
 #define VIRTIO_U64(b)		((b) >> 6)
 
+/* Get a given feature bit in a given u64 entry. */
+#define VIRTIO_BIT_U64(bit, entry) \
+	(BUILD_BUG_ON_ZERO(const_true(VIRTIO_U64(bit) != (qword))) + \
+	 BIT_ULL((bit) - 64 * (entry)))
+
+#define VIRTIO_BIT_LO(b) VIRTIO_BIT_U64(b, 0)
+#define VIRTIO_BIT_HI(b) VIRTIO_BIT_U64(b, 1)
+
 #define VIRTIO_FEATURES_ARRAY_SIZE VIRTIO_U64(VIRTIO_FEATURES_BITS)
 
 #define VIRTIO_DECLARE_FEATURES(name)			\
-- 
MST


