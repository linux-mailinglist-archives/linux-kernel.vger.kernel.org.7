Return-Path: <linux-kernel+bounces-825049-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B9500B8ACE4
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 19:48:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3F8E6A02110
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 17:48:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AAA0322C80;
	Fri, 19 Sep 2025 17:48:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="DjYPDON/"
Received: from mail-pf1-f228.google.com (mail-pf1-f228.google.com [209.85.210.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BF27322A26
	for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 17:48:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758304099; cv=none; b=AWHwzaOpgffSHFNOsbfeU5XRHckBL2IBiVdBOFSg11mSn25EoZEeyzC7LxEEM9Amv0blD782agapfNvB6Rdoo2A3vGyy2CuRYfCOG/bJ1saneefdJRvTYw6U5uCr9NAZecGR8Wlzf9fptooudIgjS2CHBxBxWe4UA81zNB4g74U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758304099; c=relaxed/simple;
	bh=G1NiFDz8oZhTB5nWROQ4ml+rvTNq7sXuFIg0das2/hA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lTM626nerVkq+HuxPC56DOIyWHwAhw2HQAdsWi0WNrh+fJG+gxlujzB/kz+gPVRq1qrHYwubb/UsjEUOQzenVOTF+bXds2ZgrAtclubea8OnL4ImFvqlQm9qDI38uB1sF4HO6AxLPAe+2ssDNg8EV8OGP3L3O13fdyb5+xUy6rU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=DjYPDON/; arc=none smtp.client-ip=209.85.210.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pf1-f228.google.com with SMTP id d2e1a72fcca58-77d94c6562fso2153274b3a.2
        for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 10:48:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758304097; x=1758908897;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IUECdZ3lR6R7TzQiSPdeZzqdUGndQHKhb6XoefEvstI=;
        b=QTjJFrfrJySCcrJtezX/rp16/Ua7NVX3dI/70tSWj4SAD40eFDLjDb7LgaF6RY1XDC
         ggDx66tFGHXsDYnBb90CHCltY7SUcOfLFE2Hae0TkkTAKppqwV2K2oB/6R1d61OEjxTl
         kISvCFMWKgHdBt2iPPjsUY+TH0TFe6YTnEfGvLyQWpMYRsec0y/VFt8xvl8e8Bje8a+H
         L6baA3ZmXOpI27fIx98Q27mF5ySJ64ba8SOdrYDAI/4uEFY2Sh3XCEK/tmrQZcJ8JWXM
         zj0CziL2vxUK00N06eceobBGv8fcM5YI+A6hQjbOAq29+DjkH5qU9c+79cJTJr+vjIGb
         xRnw==
X-Forwarded-Encrypted: i=1; AJvYcCXdDqiiDjOgNRq84KHaRKfr5TbP1V0HTr2mbR9gSr/CJ+kJR0E8cLqAzrIdIjV2KoRXRaKHZMjfjoHiESc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyaNUz2Fi5EJwygruWjBuDKt3/+gPBT0uUnI5fE4hchcs91LY60
	Dcqfq5haYCrYN+tszzGwfX4b9B5pExC4cSDouu/gmGgRWBo5f+VGLX69TVrdu2fnXG7yhETPfbn
	qedIfJhRWHeMxD+guXBD9VY7HAcaEZHCCtu+U2KkTL0sZYnDDg9OFSMoYd9+rTU+vGh61vKyeSr
	EuO68hYKLFsO6kzqSnKHuVhXEsVSCaMcpJLRzVvE6OXR3p8axWV+R6gk3TdX8yp2KRm8tZDVb2r
	ypZrtNQ/rcI6LcbG0Bx2s+Y5cpo
X-Gm-Gg: ASbGncsbDaHEzOJFO/hppOQOv2yJGNmiPH7lQLs+7ZS/lLNpL6tiIO+fQtntcUfkBm8
	mfNedONyllIamrDNw06nBGrU5NOIcOETE0Qy9VIF8KjHVhstYe4pXdNExE9CxVVNjid2ZEMEk/E
	7a9JaqCrOI3SI1qaGe9daaMJZ7mihlvGvrFMk9QqiChCVwDz1Ko0K9zL8+6mbqgzzrmMC1ryj3x
	8uiM5z4D1C40zaQM7hVV+Rurf87o2Jb+HcsnWun587sK21WEiQXE8/78gZfqIjHyilpMtkEuNIH
	hQNxrzdLnCfZaslUSq9t5sqmLinmUl37/X2eRFVhmsvbHWgx8G3f5/QS/w6w+W7d5AbfsuIFRhI
	jn9Sz1+1kJ98ztfQ/9mSzoXqup29qwtNvPBb5TKi2De8q0HBvjeoYmKUYVF8yx13pOETH/Keh1m
	nN4oNwe/wG
X-Google-Smtp-Source: AGHT+IGq4aZkpXu1Juryb4xeYkgXUV6KQdQpPprxeEcF86IehYwxs+GkOQ2K9bqteKC5TCPVAlUwYgmdsMYa
X-Received: by 2002:a05:6a20:431f:b0:248:4d59:93e6 with SMTP id adf61e73a8af0-2925bacdf47mr6412710637.19.1758304096750;
        Fri, 19 Sep 2025 10:48:16 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-118.dlp.protect.broadcom.com. [144.49.247.118])
        by smtp-relay.gmail.com with ESMTPS id 41be03b00d2f7-b54ff35e6fcsm330256a12.5.2025.09.19.10.48.16
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 19 Sep 2025 10:48:16 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-244581ce13aso45385935ad.2
        for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 10:48:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1758304095; x=1758908895; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IUECdZ3lR6R7TzQiSPdeZzqdUGndQHKhb6XoefEvstI=;
        b=DjYPDON/9WC3qYN/pMI9IbVrR1dgMMHtl5odkKYlVNesngznbmm4ha2nTiV3x3krEn
         CG+b7RgglE8CcqrJVmYt+QArt7wnEaJEmIvplM9YlVeUGW40ON94gR86JWF2BxxSF6uB
         HTMp+n4qDXATwhLSWMbkS/cyWHBY6mphYKzds=
X-Forwarded-Encrypted: i=1; AJvYcCUXpPRAEiDng7MXtgpF98gFhcVJs+6SCtIfbZturykN6gF2uxCPyr1wAEqGFJSV3A3LUayUitk3YRp+fyE=@vger.kernel.org
X-Received: by 2002:a17:902:d511:b0:24c:ce43:e60b with SMTP id d9443c01a7336-269ba45c0a8mr65982305ad.18.1758304094998;
        Fri, 19 Sep 2025 10:48:14 -0700 (PDT)
X-Received: by 2002:a17:902:d511:b0:24c:ce43:e60b with SMTP id d9443c01a7336-269ba45c0a8mr65982075ad.18.1758304094681;
        Fri, 19 Sep 2025 10:48:14 -0700 (PDT)
Received: from hyd-csg-thor2-h1-server2.dhcp.broadcom.net ([192.19.203.250])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b55138043b6sm3513119a12.26.2025.09.19.10.48.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Sep 2025 10:48:14 -0700 (PDT)
From: Bhargava Marreddy <bhargava.marreddy@broadcom.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	michael.chan@broadcom.com,
	pavan.chebbi@broadcom.com,
	vsrama-krishna.nemani@broadcom.com,
	vikas.gupta@broadcom.com,
	Bhargava Marreddy <bhargava.marreddy@broadcom.com>,
	Rajashekar Hudumula <rajashekar.hudumula@broadcom.com>
Subject: [v8, net-next 01/10] bng_en: make bnge_alloc_ring() self-unwind on failure
Date: Fri, 19 Sep 2025 23:17:32 +0530
Message-ID: <20250919174742.24969-2-bhargava.marreddy@broadcom.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250919174742.24969-1-bhargava.marreddy@broadcom.com>
References: <20250919174742.24969-1-bhargava.marreddy@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

Ensure bnge_alloc_ring() frees any intermediate allocations
when it fails. This enables later patches to rely on this
self-unwinding behavior.

Signed-off-by: Bhargava Marreddy <bhargava.marreddy@broadcom.com>
Reviewed-by: Vikas Gupta <vikas.gupta@broadcom.com>
Reviewed-by: Rajashekar Hudumula <rajashekar.hudumula@broadcom.com>
---
 drivers/net/ethernet/broadcom/bnge/bnge_rmem.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_rmem.c b/drivers/net/ethernet/broadcom/bnge/bnge_rmem.c
index 52ada65943a..98b4e9f55bc 100644
--- a/drivers/net/ethernet/broadcom/bnge/bnge_rmem.c
+++ b/drivers/net/ethernet/broadcom/bnge/bnge_rmem.c
@@ -95,7 +95,7 @@ int bnge_alloc_ring(struct bnge_dev *bd, struct bnge_ring_mem_info *rmem)
 						     &rmem->dma_arr[i],
 						     GFP_KERNEL);
 		if (!rmem->pg_arr[i])
-			return -ENOMEM;
+			goto err_free_ring;
 
 		if (rmem->ctx_mem)
 			bnge_init_ctx_mem(rmem->ctx_mem, rmem->pg_arr[i],
@@ -116,10 +116,13 @@ int bnge_alloc_ring(struct bnge_dev *bd, struct bnge_ring_mem_info *rmem)
 	if (rmem->vmem_size) {
 		*rmem->vmem = vzalloc(rmem->vmem_size);
 		if (!(*rmem->vmem))
-			return -ENOMEM;
+			goto err_free_ring;
 	}
-
 	return 0;
+
+err_free_ring:
+	bnge_free_ring(bd, rmem);
+	return -ENOMEM;
 }
 
 static int bnge_alloc_ctx_one_lvl(struct bnge_dev *bd,
-- 
2.47.3


