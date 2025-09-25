Return-Path: <linux-kernel+bounces-831768-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 123AFB9D84B
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 08:04:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 21D2D7A2DD3
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 06:02:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 113A82DE6E6;
	Thu, 25 Sep 2025 06:04:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KUn+rXDW"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1A356FC3
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 06:04:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758780257; cv=none; b=KDEPCVdLG2xk8ca7/qL9rxQ7PJ9paMCHRqa3uQg5NgRAzqcqeNcuAhSqKI+xSLMD/i0cl75IG0LYrQ3monE/0xz4kfJM/cEck33LLE87lGXSMt9bHxzmXxnJ2XqVIO+7LbZJC1o/A4dvv70QWU+h43AtzW3dyQ8SP8EbVtSNrIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758780257; c=relaxed/simple;
	bh=o0VNqoePQ9Fxc7vePL+KVWDFK3PNoSh+8m9moiHOP0E=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=sqzDEpqQTZUSZMqnBbInsuspxo49yTd6cC5jpEUvuuq5kZS+moyIjs3dI084wf2gRNQONFksvvXJRkEBdmWePaejPiba6Zkg1uaSkbNs2dQHgWb9M923tgNyG4fAj85o8Rl/NgPy2Xv144/ScqrnTPuvlXJz+8jPw52U17Z4msE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KUn+rXDW; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758780254;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=aFGTlM/AfVM6UoD7+6D0K+JKl8i8C5klHuPNmVycESE=;
	b=KUn+rXDWI146AW21Mmas//VI6a9PcOGmNaTNVNhwH7crKupGYiPKiXw1j3Mkq2mEP1/D62
	B/zE9voWAzLLAJT5eamxMFjzFtjUuymUbLzuJqo+yn6f7zncxlaRQUS5CU0dtizl/YiWFU
	qhYDm53DgHcQWIIXdnkbf8DmodYqLZg=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-619-ACOUhj6EOauTFnkUZB6hUA-1; Thu, 25 Sep 2025 02:04:12 -0400
X-MC-Unique: ACOUhj6EOauTFnkUZB6hUA-1
X-Mimecast-MFC-AGG-ID: ACOUhj6EOauTFnkUZB6hUA_1758780251
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-3f6b44ab789so300227f8f.3
        for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 23:04:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758780251; x=1759385051;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aFGTlM/AfVM6UoD7+6D0K+JKl8i8C5klHuPNmVycESE=;
        b=lr7QowBmOPK8bIkLra3gJ4sj3arm/3Yp5ZBswz92TvIpRweUDeQ3kBjsXr8QFM724C
         PZiy9xODeULF5aV/4cMxtkmN5NlVEHW62Su1vgVuvwyrhMtGK1cPsarsBxt9YjJmSjvv
         3AQK0jVrNDiY6B2Knko8UA3lLBLxPJ2SnC6pxObH5mF1V1C6GWePw3fPYq5A/rCMM81o
         TE79McKN4kdLXAwBDL5oawmqTRhTPfnA05g6A7SLIT532y1NYSv12OpviPg/RETxatSL
         GJRSZoVpL75DLbhv7F/ErGP6gBCUroRhcQqE/bEgNcnz17Fzm4PEmsgl01Zq6uZEbImG
         jGwQ==
X-Gm-Message-State: AOJu0YyLSvPaFygo+g7T61Il5VQnll3GCgmOL2ou2x9z6GsQsuXu3/cK
	GTqN8tgotNwy4VEQkztrrxvt9BRQOjCzLj3tLNlQuTi5rCot6xxEhE6ES2HtXswG71dWISDjPCi
	DbgxRixgPbs8T9Ui2Lqsd2S9eeZFYiUqib3FYQGqCELgyda/7mQaZF0pG0XzN20MlVN+Zyem/d6
	el7PhnVyK0H2HgMekmsObvu+mzELeR8JHb4SU0izXOKy4=
X-Gm-Gg: ASbGnctHjPnGS3hz1PofVlKpSYGqR5GKDaaRI5xiCDZhkJz4GCDUyXAnm8i0BvF2KO1
	XfgZYU0QskNYJWw/PC3HZLwNSCI5pskoRbY6phT9yn2ctaQJE31NvlFLedfyUlC7cEhIp+ag+Mn
	talbB0dmLm8KlAnpD/qX4Pvs8CyouWHNaRyEmukB05HLrJbaJmsHZfB2LL3GBX7X6ID/xqEC0vQ
	nifIiDhvf79ov7VdsbD9ERnzq3BzWhefAAWsvEKtjORMzFdfJzh7fMyFwAfaZSsyCcJiOz6/yRb
	VodF+v//sraj/6BDeSr/M2LBx2HaxMe1Fw==
X-Received: by 2002:a05:6000:2912:b0:3eb:f3de:1a87 with SMTP id ffacd0b85a97d-40e49e725f0mr2176058f8f.56.1758780250962;
        Wed, 24 Sep 2025 23:04:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEzXROWH0HheOoR3C9U+J8DhuDXRcMrs5JaiB8XcConfDaf/URbl6oeL/NMdqI1Vf+S1XrqWA==
X-Received: by 2002:a05:6000:2912:b0:3eb:f3de:1a87 with SMTP id ffacd0b85a97d-40e49e725f0mr2176012f8f.56.1758780250483;
        Wed, 24 Sep 2025 23:04:10 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1538:2200:56d4:5975:4ce3:246f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-40fc5603365sm1463946f8f.37.2025.09.24.23.04.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Sep 2025 23:04:09 -0700 (PDT)
Date: Thu, 25 Sep 2025 02:04:08 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: zhang jiao <zhangjiao2@cmss.chinamobile.com>,
	Jason Wang <jasowang@redhat.com>,
	Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>,
	kvm@vger.kernel.org, virtualization@lists.linux.dev,
	netdev@vger.kernel.org
Subject: [PATCH net] vhost: vringh: Fix copy_to_iter return value check
Message-ID: <cd637504a6e3967954a9e80fc1b75e8c0978087b.1758723310.git.mst@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent

The return value of copy_to_iter can't be negative, check whether the
copied length is equal to the requested length instead of checking for
negative values.

Cc: zhang jiao <zhangjiao2@cmss.chinamobile.com>
Link: https://lore.kernel.org/all/20250910091739.2999-1-zhangjiao2@cmss.chinamobile.com
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 drivers/vhost/vringh.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/vhost/vringh.c b/drivers/vhost/vringh.c
index 0c8a17cbb22e..925858cc6096 100644
--- a/drivers/vhost/vringh.c
+++ b/drivers/vhost/vringh.c
@@ -1162,6 +1162,7 @@ static inline int copy_to_iotlb(const struct vringh *vrh, void *dst,
 		struct iov_iter iter;
 		u64 translated;
 		int ret;
+		size_t size;
 
 		ret = iotlb_translate(vrh, (u64)(uintptr_t)dst,
 				      len - total_translated, &translated,
@@ -1179,9 +1180,9 @@ static inline int copy_to_iotlb(const struct vringh *vrh, void *dst,
 				      translated);
 		}
 
-		ret = copy_to_iter(src, translated, &iter);
-		if (ret < 0)
-			return ret;
+		size = copy_to_iter(src, translated, &iter);
+		if (size != translated)
+			return -EFAULT;
 
 		src += translated;
 		dst += translated;
-- 
MST


