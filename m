Return-Path: <linux-kernel+bounces-731249-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 182C5B051B5
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 08:27:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4B25E4E06BF
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 06:27:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA7BB2D3A96;
	Tue, 15 Jul 2025 06:27:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="Y+G6EnEw"
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C47202CA8
	for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 06:27:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752560842; cv=none; b=Zp1ImCNJkUuhg6Auwbow4EW1KL0O8AnQg1GGgLr/X+TrtpFRlMQxAqfgawB8O/JfpjmCGGSnneKBmM1vVHCe9/Ctx+XW5Z8O0aZpqsD2iBsxSQj7gTUlZZke3Uw9vLGGek8cdi1+sEnyD+Q4cRgGkCr0wu8LyQT3D8gpUMIODmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752560842; c=relaxed/simple;
	bh=pYSg7pAIgE6RSglxPJVB14jRhBwPhPOjFk/mSCS+ZPE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 References; b=j4PFlxYDpmnRYXrOKM6rKP0WpoLOGETXRkfKxcCzR5MPaZusMKGBjKoLiVHNOmZq+MO8gK1cL3opMFyv2odzajQIUvedhppBGoRYD/R3aUYbPmUwHCx9ATwQ72kLLnFq4DabnkSJ3Aoc70/dWBp7ZU4I/jEIhrEsHNkSQe+Eb+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=Y+G6EnEw; arc=none smtp.client-ip=203.254.224.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
	by mailout3.samsung.com (KnoxPortal) with ESMTP id 20250715062711epoutp037cdee7fa1f7fb7046a628ea9b61506a6~SWMpkqh5A2976329763epoutp038
	for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 06:27:11 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20250715062711epoutp037cdee7fa1f7fb7046a628ea9b61506a6~SWMpkqh5A2976329763epoutp038
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1752560831;
	bh=Yu9SHAbXQrdd5VAieT9a6TJ+4eyWeGwYWNhRE0NfEIw=;
	h=From:To:Cc:Subject:Date:References:From;
	b=Y+G6EnEwZag2kaehWMbD2QX7jhTnP84u0gvucDnVz/WTZYWMHZfO9u08fqJ4RpiRj
	 rbm/PAYG0rhUcftxg9iEuLvvwY72WOC49/pKFc/gQegf3fL7gs//GkDGg4PpjXD/kL
	 6jxj5WKnPPBs35Qu4nmlxXvhUQXvoC2JVdPqPAMo=
Received: from epsnrtp01.localdomain (unknown [182.195.42.153]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTPS id
	20250715062710epcas5p39e6ff2e44713c32a1c41c93924119de4~SWMo58OGZ2592925929epcas5p3a;
	Tue, 15 Jul 2025 06:27:10 +0000 (GMT)
Received: from epcas5p4.samsung.com (unknown [182.195.38.94]) by
	epsnrtp01.localdomain (Postfix) with ESMTP id 4bh8Ns5sVSz6B9mR; Tue, 15 Jul
	2025 06:27:09 +0000 (GMT)
Received: from epsmtip1.samsung.com (unknown [182.195.34.30]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
	20250715061856epcas5p196a0b67fe58b71e1f81f98a903e429c0~SWFco3pJB0911209112epcas5p1v;
	Tue, 15 Jul 2025 06:18:56 +0000 (GMT)
Received: from green245.samsungds.net (unknown [107.99.41.245]) by
	epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20250715061855epsmtip1850f12c138e95b469866390e02f5ffad~SWFbmC4_G0162901629epsmtip1G;
	Tue, 15 Jul 2025 06:18:55 +0000 (GMT)
From: Nitesh Shetty <nj.shetty@samsung.com>
To: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>
Cc: gost.dev@samsung.com, nitheshshetty@gmail.com, Nitesh Shetty
	<nj.shetty@samsung.com>, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] nvmet: Add support for FDP devices in fabrics passthru path
Date: Tue, 15 Jul 2025 11:48:04 +0530
Message-Id: <20250715061804.1954522-1-nj.shetty@samsung.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20250715061856epcas5p196a0b67fe58b71e1f81f98a903e429c0
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
cpgsPolicy: CPGSC10-542,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20250715061856epcas5p196a0b67fe58b71e1f81f98a903e429c0
References: <CGME20250715061856epcas5p196a0b67fe58b71e1f81f98a903e429c0@epcas5p1.samsung.com>

In nvmet passthru path FDP is disabled, because of failure of
admin_get_features FDP(0x1d) feature command.
Supporting this through nvmet_setup_passthru_command enables FDP.

Signed-off-by: Nitesh Shetty <nj.shetty@samsung.com>
---
 drivers/nvme/target/passthru.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/nvme/target/passthru.c b/drivers/nvme/target/passthru.c
index b7515c53829b..bf27ae4c42dc 100644
--- a/drivers/nvme/target/passthru.c
+++ b/drivers/nvme/target/passthru.c
@@ -460,6 +460,7 @@ static u16 nvmet_passthru_get_set_features(struct nvmet_req *req)
 	case NVME_FEAT_PLM_WINDOW:
 	case NVME_FEAT_HOST_BEHAVIOR:
 	case NVME_FEAT_SANITIZE:
+	case NVME_FEAT_FDP:
 	case NVME_FEAT_VENDOR_START ... NVME_FEAT_VENDOR_END:
 		return nvmet_setup_passthru_command(req);
 

base-commit: 3f31a806a62e44f7498e2d17719c03f816553f11
-- 
2.43.0


