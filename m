Return-Path: <linux-kernel+bounces-803445-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ED2F2B45FDD
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 19:20:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9A53D1C21241
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 17:21:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA5E431328B;
	Fri,  5 Sep 2025 17:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="P5u6h584"
Received: from mail-yw1-f228.google.com (mail-yw1-f228.google.com [209.85.128.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB237313286
	for <linux-kernel@vger.kernel.org>; Fri,  5 Sep 2025 17:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757092821; cv=none; b=t3VoC1B6OaqM7hu0RquEaO2oaoPSQHq3hXWiGEfgkYeJklrpLdRQOyEMQko8/MJk8VobWAHx48yVlkXRVxU7qL/+PfS8zPIMJFKg8lOHCwv4ADAF3dwTLI2cmBPXiOm2vU0zrG66TN71g6G4DnIoWthQh3c61fxM/u6p8nI3gRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757092821; c=relaxed/simple;
	bh=G1NiFDz8oZhTB5nWROQ4ml+rvTNq7sXuFIg0das2/hA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nrWHwdTJFn2ZnaEwhZ8hn7qryEegvZpE4jijzZqcJnkh6V5jE8ofKBvaOzXZZpr4uH6CD2vkv5xuZuYOV9ung+nwkT2kfYLz6/LavEocVfGOCPMR9XI4ZbVOhUo8fJryJ8L3H5WIr9MKfShSjwXFrzpGHVgTS+jQ74CUbZ5rOYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=P5u6h584; arc=none smtp.client-ip=209.85.128.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-yw1-f228.google.com with SMTP id 00721157ae682-723960ded6bso26095707b3.3
        for <linux-kernel@vger.kernel.org>; Fri, 05 Sep 2025 10:20:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757092817; x=1757697617;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IUECdZ3lR6R7TzQiSPdeZzqdUGndQHKhb6XoefEvstI=;
        b=cHTxh+h1TAMlM8zRVVE8BeGuCDnJyq5EyshaERb8IcefZuPjUKlTF6F/PBMl1Dig+s
         s5Pmy72KBYkE9tM/u+lmQpkvegDNPpyWLLLxs8FoS1gZhRIPZgj5gzNcsjnkIr8rA/By
         IMVg+212Ub9CJKDjvWCMIabQ7V+PqxRdrWKS6W6XwSrWyPz/wxB/nj7+1hLrGHrr44L6
         U3+3P9pXaiDt9SeBWv0Bg2jXYYCndJB+CearPslV3o6zqGIjsqOAenxRtzOFFHjs9XFo
         tXUl/cGlacIreuQkngMtd1fp6yYdnoS9fghB6vRCvbDZg6N4Yc+cfuJCTdGZmRgMoGUZ
         3DoA==
X-Forwarded-Encrypted: i=1; AJvYcCUzbw7ZU1PHVIYMSVeCWBU03084C+jrJGf7Wz4sME7YHxv2L1M2WwthLtPOMGomeijXhaiVfP57CT/T6rw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyfZbd/cNhAIL4J80Qhg1DEwcT93A33bfLJJY7bJj6RUG4QZuaU
	3Pw6IYSseTUNjgB6CtHNaCHpi6qmn6YsMw9TEk7cSMVFlxv0zhOo6Te3JzGQ5xPzzBZevaDYNBp
	JXfcHsK6csirVy5uL9WgigLVrau5joLDEw3UDaRFyjC9Q12avOlysI4KUkI6CDFyAStrXSgtdHb
	RbSjw3z6Mq+D5m/kY7j8DvGRsB64jqt+yOZSXL/VcrCGrWtwy4OoF0ohY/c6eS89rROsQe0QujI
	Id2TZTqWSpm22iDZwghq9NvL1HX
X-Gm-Gg: ASbGncvRG6s6fM9l/8rYoj/qp6GhbSvB0MTyuk2PAKdyeg7IDsWJwzBk7oWal/R42eP
	teGkXOGALCTjZGsfhmhp9lmzwXAYqS7+g6O5oYA3/zVH1xC4nLO5GDJsmvs5fSLlkXghli5m9Li
	xGphMYptXE6hmLaIShqMHbyclqfEIe9sI/Uq+H5qwKyDcJ4yOeexAfW0wnJrn7ShsZyKDtM1zka
	oCSmFCrx6PCwFzd7Oy4MBQJ1I0UxvCeA1mKSvWEply3b5V8oYNm0hGK/nVxe5bpghYq89wopJuq
	rtUIFWPVuIZrvDbbhHzptPxUrp4ZsJNSsmEWowECWemEAvigLERG5K2INuyh3yxeA9oSzqUwiAn
	LLZRsNBsmpXlz9+tsD6SUcTXGQhNzpXEvG6qX9cYBscTmutpZ/SF57ZqRw8KItdGZTcAqfa07Tj
	63arSZkI1i
X-Google-Smtp-Source: AGHT+IHuo1WSVjAzUjmtz1QELbptaKghl/eC/2NSFbRomUx/GumdipMBSoip7apQ5p2UJjJpXXGrTko2575u
X-Received: by 2002:a05:690c:9985:b0:71f:b624:322e with SMTP id 00721157ae682-722764af341mr274503957b3.26.1757092817383;
        Fri, 05 Sep 2025 10:20:17 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-117.dlp.protect.broadcom.com. [144.49.247.117])
        by smtp-relay.gmail.com with ESMTPS id 00721157ae682-723a834cec2sm8458457b3.19.2025.09.05.10.20.17
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 05 Sep 2025 10:20:17 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-77267239591so4236027b3a.2
        for <linux-kernel@vger.kernel.org>; Fri, 05 Sep 2025 10:20:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1757092816; x=1757697616; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IUECdZ3lR6R7TzQiSPdeZzqdUGndQHKhb6XoefEvstI=;
        b=P5u6h584MGrEZ+k8XMvAO0xatcR7ErlkQ8mP8z/LvPmX5jWRRZYFl2vlEZLYYVH1C+
         l4+OIB/TyWSU+/MyxOMGL9yt7oDZLd8fEHgtjrTOFWYOEAN3LjR/ieckdlBE655r4X4Z
         Cncyn1+rc0M1TUtaw7EEYYoa2ZyHr/IaJ375o=
X-Forwarded-Encrypted: i=1; AJvYcCWG65LtMN72Sw1HftOTQu4Ac6Z120Byv2w+w6clQ6kki27TqIReSTkkmyo9Ldl5TA3fSnjkP7D/5rGv+6Q=@vger.kernel.org
X-Received: by 2002:a05:6a00:3d01:b0:772:736e:6573 with SMTP id d2e1a72fcca58-772736e6857mr16862099b3a.22.1757092816148;
        Fri, 05 Sep 2025 10:20:16 -0700 (PDT)
X-Received: by 2002:a05:6a00:3d01:b0:772:736e:6573 with SMTP id d2e1a72fcca58-772736e6857mr16862077b3a.22.1757092815722;
        Fri, 05 Sep 2025 10:20:15 -0700 (PDT)
Received: from hyd-csg-thor2-h1-server2.dhcp.broadcom.net ([192.19.203.250])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7722a2b78d7sm22678001b3a.30.2025.09.05.10.20.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Sep 2025 10:20:14 -0700 (PDT)
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
	Bhargava Marreddy <bhargava.marreddy@broadcom.com>,
	Vikas Gupta <vikas.gupta@broadcom.com>,
	Rajashekar Hudumula <rajashekar.hudumula@broadcom.com>
Subject: [v6, net-next 01/10] bng_en: make bnge_alloc_ring() self-unwind on failure
Date: Fri,  5 Sep 2025 22:46:43 +0000
Message-ID: <20250905224652.48692-2-bhargava.marreddy@broadcom.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250905224652.48692-1-bhargava.marreddy@broadcom.com>
References: <20250905224652.48692-1-bhargava.marreddy@broadcom.com>
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


