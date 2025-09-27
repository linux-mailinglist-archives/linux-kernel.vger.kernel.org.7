Return-Path: <linux-kernel+bounces-834847-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A264DBA5A2B
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Sep 2025 09:21:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 45D841C20118
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Sep 2025 07:21:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AE402C0267;
	Sat, 27 Sep 2025 07:21:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=mboxify.com header.i=@mboxify.com header.b="ZAP6voQV"
Received: from mail-108-mta218.mxroute.com (mail-108-mta218.mxroute.com [136.175.108.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CADF2BE7AF
	for <linux-kernel@vger.kernel.org>; Sat, 27 Sep 2025 07:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=136.175.108.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758957675; cv=none; b=Uk4TApo2TqFo0wTwn7eJvx6Lsw1DDlajhpxKaWTy7nF+uekLbeCwdSr1+EL8qAWEDrB2wukixXwIgkC2URlhzerjmn79wHt5isWszJc8CEnNjZ7EnlB2Er+72/O/FqJUDqtIiualUIgNEt4tgInwfdGaW85TAJz5fI9lT6fPBVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758957675; c=relaxed/simple;
	bh=09A9hbR16OyBQLolGd1O5YJPEFbjbEDcN+A9olYvQ1w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fublVoMvspesuWwT2vI4WJ1ZtD07AXau2jgj24Il6SL6W+zIBizh7xn3V+Wl3BBSs9HJZrMRikLFnnMyHHXo30IUodp+Xiu8lfmb8rPhB9X24WQGZdFEcgygm1m3QuW/BDarpqymVFofOv2x+yMpDHKAHHQavds0OBsqpmwjt3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mboxify.com; spf=pass smtp.mailfrom=mboxify.com; dkim=pass (2048-bit key) header.d=mboxify.com header.i=@mboxify.com header.b=ZAP6voQV; arc=none smtp.client-ip=136.175.108.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mboxify.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mboxify.com
Received: from filter006.mxroute.com ([136.175.111.3] filter006.mxroute.com)
 (Authenticated sender: mN4UYu2MZsgR)
 by mail-108-mta218.mxroute.com (ZoneMTA) with ESMTPSA id 1998a07584f000c244.005
 for <linux-kernel@vger.kernel.org>
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
 Sat, 27 Sep 2025 07:16:01 +0000
X-Zone-Loop: 1c63484e8c308343eec91e22b499df5a546357c2f41d
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mboxify.com
	; s=x; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Date:
	Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=RdtLXx1P8B/01/srC1DNykDSLnh15MCseAF+aY7h/LI=; b=ZAP6voQVo8lpLS80rWY6J1KYkl
	h01SfdJrPNxVRHLP/uVNDvQE4F9Xoj0TIjpgQX4C+tRuSxFipoHYNM8yLArBfln6eEYMid7b72cZD
	2n3lIwrqwuqkh4rHLAV4O9ePj5CWIVffLXMQOjPErb65qNypZKie+a1en8zgFHX0PgDcIb88Ipj3X
	uGSJC19ORFhg3tAMoq2HpN4Zg/F5jLZbwCMiNbd58qagDFe8kghXhJT265LVNefF2+FOmnInQmtml
	qJPMdW8E6gxStIs+iyZKghAL+zumv1SJyR0Q0dkdlRAy7pmDXhhW5fzIzxNsOUFN7Fcyip1xs1ok/
	pGJnXAMg==;
From: Bo Sun <bo@mboxify.com>
To: sgoutham@marvell.com,
	gakula@marvell.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bo Sun <bo@mboxify.com>,
	stable@vger.kernel.org
Subject: [PATCH 2/2] octeontx2-pf: fix bitmap leak
Date: Sat, 27 Sep 2025 15:15:05 +0800
Message-Id: <20250927071505.915905-3-bo@mboxify.com>
In-Reply-To: <20250927071505.915905-1-bo@mboxify.com>
References: <20250927071505.915905-1-bo@mboxify.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated-Id: bo@mboxify.com

The bitmap allocated with bitmap_zalloc() in otx2_probe() was not
released in otx2_remove(). Unbinding and rebinding the driver therefore
triggers a kmemleak warning:

    unreferenced object (size 8):
      backtrace:
        bitmap_zalloc
        otx2_probe

Call bitmap_free() in the remove path to fix the leak.

Fixes: efabce290151 ("octeontx2-pf: AF_XDP zero copy receive support")
Cc: stable@vger.kernel.org
Signed-off-by: Bo Sun <bo@mboxify.com>
---
 drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
index 5027fae0aa77..e808995703cf 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
@@ -3542,6 +3542,7 @@ static void otx2_remove(struct pci_dev *pdev)
 	otx2_disable_mbox_intr(pf);
 	otx2_pfaf_mbox_destroy(pf);
 	pci_free_irq_vectors(pf->pdev);
+	bitmap_free(pf->af_xdp_zc_qidx);
 	pci_set_drvdata(pdev, NULL);
 	free_netdev(netdev);
 }

