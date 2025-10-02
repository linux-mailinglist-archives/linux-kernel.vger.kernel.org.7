Return-Path: <linux-kernel+bounces-840055-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 08CF3BB36E6
	for <lists+linux-kernel@lfdr.de>; Thu, 02 Oct 2025 11:19:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7BCC23B0284
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Oct 2025 09:19:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CD0C3009FA;
	Thu,  2 Oct 2025 09:18:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eKPfp3QW"
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E9903009C8
	for <linux-kernel@vger.kernel.org>; Thu,  2 Oct 2025 09:18:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759396731; cv=none; b=L5q6LqWXynUIcCPW9M71FeTwaPyStgHdyXtQlWWuzFI9GJjN5DoilNJhgksynLclvyeY9eKgE3F/FV7nOmbrIR8U4uesj/5VvRmU0eVio2UvvDNeQqFGhFBSEZPZT17G9ITdSz0Icje8/NQxluihbLaqXooMH2/1EvhYOjdtHK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759396731; c=relaxed/simple;
	bh=dhtRId+yS+24ykHGLgaA23OvyzQK8FNL2/ZfB26+tTg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GiBn+qq96rvYyPzwTCFUxKln39K4D9cQxh86Ixzq0YZGUL6v09fwUk4c2fqsRsqwiBr282ikOElICo24pPIdofp8oWfv2xXCAX5clB1qH6+xTT0351bTulTPMnMQbvo1brMe4p8qpu25mFOm5P4v25cC0BwBagbersmkdhIhDsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eKPfp3QW; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-3637d6e9923so6443691fa.3
        for <linux-kernel@vger.kernel.org>; Thu, 02 Oct 2025 02:18:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759396728; x=1760001528; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=SFj5JXWho4y7Zr7rxeir5WOXBf1uNyHF1YLvdI/yG4Q=;
        b=eKPfp3QWLlSAU+zzhO5geTPOG34WQlyS50CBzUNjdVW8MI18r/4OztHw5Of2kWuo4f
         gCNfmq1eVKEid+ExDvTLOR7k9RI03cnXp834NHz6nlSZqs+Aidg3kYHmR2GlgngCITgI
         +0WtKTMXHaqAxEGHsQrkXatDF1h3Tuj8dbCrBrbcg0WikcQfegm5xRIZJyV1pvRuSREQ
         19X2NhLRfcPHBIIkWjseE0X1EZ2ShlN4M8d6+TqaO4O/33T3VxdROZmJqhd4qu0bgk/8
         vk+0MJ7NbX1Um8BoXWo2QcL54jMQUQkjqQSlwFCHk8u0J7wu8oI2KkgfgAYDfbxuuMy/
         F77A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759396728; x=1760001528;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SFj5JXWho4y7Zr7rxeir5WOXBf1uNyHF1YLvdI/yG4Q=;
        b=n0uzyCwuRaNIyzKzwNIjLi+HybFEkgvyiCGR02JdtarRIFo8RenQ1Vg0wH/w5cI0LP
         vcR9gvzkdCDbtp5S7iDz+DKyUPANEZpP0KT6eROGC52OwsjOItXOwADEyU2ogP37hEU3
         /T0vta0ynNX+HNNtGFknZqU7bYj6v2/hGWd5WTxuPFSejeEsGnFTV6+cC7ssqrjscTmw
         ZEYFqWeJk433D3JNOU1iklrgEQWimPCjitMNvKMFlFtFE73sTieERJiGGlsUzqg8zUxj
         5GHW+Aa6e+AmdXPKK6Gf20TaySj8ghXYqh6Kgp1IygtKi1CkRDU8k5AZ6Cu1+N16MPgH
         4XjQ==
X-Forwarded-Encrypted: i=1; AJvYcCX3kCVrAX3trB9X2/Z+eqCck2viuZJM7wBWhJ9Skk1upRWD0sqYnT6+vpzgbaKBuxOn3VPijQU/eM2nwfY=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywu6O4wsRGf+kY9InELqpBOa+aghhjfsM6UFUUSEtGUir4VCuBR
	JZE/wCuIEL2CA/ANDAdmwtu0Gj5nmyjXoCKsWUcHnk+VU2e4q404tFtD
X-Gm-Gg: ASbGncsombSluwr/jGyjv8SEqYxYpu+HaNgjOirBVzcuQp44U8qSUZESIi3jqmxs8ga
	uI2wrQBYEM4CH9IaqeAYNRi2K8RLcMj5NDmCOJsC3vSkz8/E7Ku8VAw0Voy7bYwXyNvwLOmEyPF
	kUsDaVBT6stsPDSACGOH7f0Epg3YPHHY482Lp8H97+fzyxtxRYa7yccyTJCDmkCxjieChDt9S/V
	a12bK85fn7dinYefNAQXym5+HipMJJ9Ncp09icSypbZVyOek3v+bkOuq/zP8b68m0KEEyoytUfK
	e3xRVxCN7fAifcMIt+gLD9zffcbuQmMVR5GTUc+hOfiFrrOTjHOQmxb6xNfeZ/asliZUSDCQlpD
	xwOLpJly9hQPna2Lfkmh5sLK7ZkHP2ff7OEKloRPgPTCYVae4JGfwkJ2QhnHmFArpWDDJfYj/1B
	2RGoS5J7ggmhivdArIN60aYF42ZbqNf8OsAEbgHaDx
X-Google-Smtp-Source: AGHT+IGo0cUnHQHcxcOjmzOSKKo/Af/lYMVfK4yFSX4Qzv8Y6i/TYPN9voj8VBfnDDED1vp90psKZw==
X-Received: by 2002:a05:651c:1501:b0:336:d8da:afe2 with SMTP id 38308e7fff4ca-373a70edd87mr17391331fa.4.1759396727908;
        Thu, 02 Oct 2025 02:18:47 -0700 (PDT)
Received: from localhost.localdomain (broadband-109-173-93-221.ip.moscow.rt.ru. [109.173.93.221])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-373ba49fd69sm5543761fa.43.2025.10.02.02.18.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Oct 2025 02:18:47 -0700 (PDT)
From: Alexandr Sapozhnkiov <alsp705@gmail.com>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Cc: Alexandr Sapozhnikov <alsp705@gmail.com>,
	lvc-project@linuxtesting.org
Subject: [PATCH v2] vgem: fix error return in vgem_init()
Date: Thu,  2 Oct 2025 12:18:42 +0300
Message-ID: <20251002091844.11-1-alsp705@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alexandr Sapozhnikov <alsp705@gmail.com>

The dma_coerce_mask_and_coherent function may 
fail to apply a mask due to incorrectly passed parameters. 
However, since this function returns the -EIO error, 
this is an abnormal situation and the error should be logged.

Found by Linux Verification Center (linuxtesting.org) with SVACE.
Signed-off-by: Alexandr Sapozhnikov <alsp705@gmail.com>
---
 drivers/gpu/drm/vgem/vgem_drv.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/vgem/vgem_drv.c b/drivers/gpu/drm/vgem/vgem_drv.c
index c5e3e5457737..dc132dd44b9e 100644
--- a/drivers/gpu/drm/vgem/vgem_drv.c
+++ b/drivers/gpu/drm/vgem/vgem_drv.c
@@ -140,8 +140,10 @@ static int __init vgem_init(void)
 		goto out_unregister;
 	}
 
-	dma_coerce_mask_and_coherent(&pdev->dev,
+	ret = dma_coerce_mask_and_coherent(&pdev->dev,
 				     DMA_BIT_MASK(64));
+	if (ret)
+		goto out_unregister;
 
 	vgem_device = devm_drm_dev_alloc(&pdev->dev, &vgem_driver,
 					 struct vgem_device, drm);
-- 
2.43.0


