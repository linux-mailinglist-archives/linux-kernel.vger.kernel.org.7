Return-Path: <linux-kernel+bounces-812761-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1270FB53C57
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 21:35:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B95765A73A0
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 19:35:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EF6531B10D;
	Thu, 11 Sep 2025 19:35:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="emibbQwN"
Received: from mail-il1-f226.google.com (mail-il1-f226.google.com [209.85.166.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F01A26CE2E
	for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 19:35:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757619327; cv=none; b=IarIxrGRjbvhK+jxXXZAJfwSFeyXi6tutMNcF2LVjiJf6rfqUTYPbbBhVJQ90N2bDunTOIVPObcrCghq9MX+xG/aEPjKDKTRg/WDvJoGcS0tXS/7DMrIcLh7sq95+R8c4XzTMOoq0NH3GsZa8y1EJIEB7MMdT8kr238BHhpcpfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757619327; c=relaxed/simple;
	bh=G1NiFDz8oZhTB5nWROQ4ml+rvTNq7sXuFIg0das2/hA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Vkactl3KbP0f1DBp37xwt/ZSXYsYCTLniDR7qEHomyLzdRfOrS308QllbTe0CdKtSCiywH/6hUg3RIkyV/B+lnB0VrwhRD8wrpLBtD4ROzKbP0CJlUHXvVYnG4xSk2pzMm+BGIQa/gGx/1PeRPekVxunZIJSRcWskAXPVUvZjkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=emibbQwN; arc=none smtp.client-ip=209.85.166.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-il1-f226.google.com with SMTP id e9e14a558f8ab-410c884decfso10922785ab.2
        for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 12:35:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757619325; x=1758224125;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IUECdZ3lR6R7TzQiSPdeZzqdUGndQHKhb6XoefEvstI=;
        b=l6w/Bv79vzW9vo0/gqAiaItyp12cU5Vg5Co68rZ9xasNbqvYmn7Jz6MYdFKLTJxmwo
         XVGE8Wg2nNEQC3wQjr+lZLqnqItnl9lYWM1xA9XPc4DPuYwOpJAIPAIzRkSKrKNovcXX
         /1kC0bewIkJXrR6JD7ggF2ksYDS9jzZ5+P+QHr+DAnTh0q+koC0Jy7mHzB7TTHNJHYeD
         JsIj6qubalC6nECWAwFbqMfdujK3seMszw0pa+M2k3AKy5AZXQ90Jk5y5ZEZeaoGM1GI
         hSVrOJCQ3CdT1/DvNkhH18F+0VpEyjUcr5BsdOuLActrZnXo6QaJwZyG03JpN4bHPW2v
         3CDg==
X-Forwarded-Encrypted: i=1; AJvYcCUPXKZrm/sB9dGhQRTx5Oe5w2SJ6NxP5nP+PzfuV4+Tq08ZQluon+tgZxoKgkqf7iz7J0KgHEFCNbxyxeo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzFwD/YqwhvhicdxeTNbR1x8moDgUR/crZQPv51LZak7JJK8gb9
	Zci6ObjbOYx5L85lXGw1wPm239Zi42Il9KO0DUH32LUxzQTz8j2EhFHA+ZAu2O9KFCJ39uPOV+w
	H1uxyz2mFuPVVjKGNGyKwQE1ym8qcRpwzY+Jz9pM0RgUKDXOlxQwP7UrnyOSC/OWfOaRYteeWvz
	cXoSZRzf/hWLBPzoCNPvWgsq/ezm9htKQ0+ZU+Xl/p5F9Bw4bnmwOlLbkZKDhP6lqPILRspDfGH
	s7mJuRzRc88LcuUJhNeA6lUC+bq
X-Gm-Gg: ASbGncsqHhvwaZEmrZj2lHl5gRvsaiNZ60FoxS1pQhbk7X++Q88aPCFPa2Wjwerr6qQ
	tE0LoP6CP9G2HgjuNKmgBtSkYF4hDb5/q9cbq1dYQLmTi5ZADp1/uVBJEQngkHrByXJd9j+r2n/
	HncKduK07BiTL0+D3BvzCE3/1DJTo30JUiwl7cyryF58/TmCJi1UFawoMW0hZZSiOeE3dHPJOjt
	KzS7hX9uvNooOYsNr73PzMvLN+0MhDiCeHUfM0yBSamUxsxX2qVIbXJ7/1xbjP/q+XXok9OJZTx
	Nrd8ryNCNzmpdE+f46+YhFkOLZXBSwDWMAfh/o0xeRsv7RnD1lZNayKoV8FIdNJGUiYAykfvnfr
	zX8TmjaB/7fn98WVQooLxPWi8fWh1l+6YHm8ooshnQyxx3gxCQ+O3mKArnrkl3r9RwtwAw0fuuO
	AnfJ7x5w==
X-Google-Smtp-Source: AGHT+IGxr/wPEm58nGwJSDzxQSxtWvtyghjkNRMY14L5kZxXwhhCXPcDsDrjn96MG+tL8Bb4k3vXQLic+m/b
X-Received: by 2002:a05:6e02:160c:b0:40c:c955:b67d with SMTP id e9e14a558f8ab-420a4dec2f8mr11941325ab.28.1757619325433;
        Thu, 11 Sep 2025 12:35:25 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-25.dlp.protect.broadcom.com. [144.49.247.25])
        by smtp-relay.gmail.com with ESMTPS id e9e14a558f8ab-41df8ae2838sm1851735ab.42.2025.09.11.12.35.25
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 11 Sep 2025 12:35:25 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-25d449089e8so1395115ad.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 12:35:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1757619324; x=1758224124; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IUECdZ3lR6R7TzQiSPdeZzqdUGndQHKhb6XoefEvstI=;
        b=emibbQwNR5ANtylk/Fg7nozSRC3LmbE+jNFooTV5nQ5qATD1j92iuaOAI3XZsgmfpH
         3N1lDOaAzYTQ/pKOSjvTE0DBnevyMp4BUbUhqxRuUfRTcqYmWdti8BL5gokx4t5yIVqY
         KYUmXAoAqFEGUjVWbaOit21gr0EaKKNawdCJA=
X-Forwarded-Encrypted: i=1; AJvYcCVXIT79uzYv3/CiWT+XcsKxcgGZBKk3Fea6s8x8qBypb5y1zPINtMSxRzP1iQ7xGNIgpGYdd4E6GG5Ec2E=@vger.kernel.org
X-Received: by 2002:a17:902:ea0d:b0:24c:f15c:a692 with SMTP id d9443c01a7336-25d27c21b85mr5780635ad.42.1757619324043;
        Thu, 11 Sep 2025 12:35:24 -0700 (PDT)
X-Received: by 2002:a17:902:ea0d:b0:24c:f15c:a692 with SMTP id d9443c01a7336-25d27c21b85mr5780335ad.42.1757619323656;
        Thu, 11 Sep 2025 12:35:23 -0700 (PDT)
Received: from hyd-csg-thor2-h1-server2.dhcp.broadcom.net ([192.19.203.250])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-25c3ad3404csm25839285ad.113.2025.09.11.12.35.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Sep 2025 12:35:22 -0700 (PDT)
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
Subject: [v7, net-next 01/10] bng_en: make bnge_alloc_ring() self-unwind on failure
Date: Fri, 12 Sep 2025 01:04:56 +0530
Message-ID: <20250911193505.24068-2-bhargava.marreddy@broadcom.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250911193505.24068-1-bhargava.marreddy@broadcom.com>
References: <20250911193505.24068-1-bhargava.marreddy@broadcom.com>
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


