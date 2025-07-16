Return-Path: <linux-kernel+bounces-733882-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EF06B07A34
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 17:47:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5AB0A188244F
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 15:45:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D66EE26E143;
	Wed, 16 Jul 2025 15:45:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="fGxUP9Cb"
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BE0023815F
	for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 15:45:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752680728; cv=none; b=t2/ZmSWE5GSJ1KDV34+8TtM9/ktNv0JiXxdw4btvUuu3dTW+OTbZoVBUCrHwcbCQC1Xw+NUMs3u9SLsj56rgvvRmZIFbidmk92wdypksCmmA5m54OTpAVYM2O9gdjfPyHUEeFs8HeS7kNp434w21Jvdjkl15t2unNvAQf+nq03I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752680728; c=relaxed/simple;
	bh=yZhK7FXnQZdfVxHhx9rKoESBfaQjXCh+dJBZRoRUI6E=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 References; b=czlZm2XNAXBodAWrodA8PHISIuaFEB3h5yckvHzsC5aVQjmegdO5gu82SXb8hiWf3A05rcd6JoTG7xGWAJwGjZoJxb/CA8AvDNcG+XFOCjdzRiFovsEh1ajvuwaZlIPJAdi5wCVfCK/a+Ho/nCl8MKEyIvy6ItEYEaXnNqY9Kc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=fGxUP9Cb; arc=none smtp.client-ip=203.254.224.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
	by mailout3.samsung.com (KnoxPortal) with ESMTP id 20250716154524epoutp03cdb8362c46af575e587ea0986233633e~SxdUXq1mZ1000810008epoutp03N
	for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 15:45:24 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20250716154524epoutp03cdb8362c46af575e587ea0986233633e~SxdUXq1mZ1000810008epoutp03N
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1752680724;
	bh=fwZylXI3okQLUPc6hDhgW0pAde1Fdy0aaEfskXcST5o=;
	h=From:To:Cc:Subject:Date:References:From;
	b=fGxUP9CbcIWGD81VQJo0pqTB7nt09ePkPpEWsyx+K51081vYONfJ1/o087na0HPOm
	 f4DFTmZ+1ImB7Q/KDPyRnqMlo5KF68LXQ3DQc38cvwlcy5sM5VYpAtFUZv+tIU/LY1
	 RTbCn+dRxpfPCqcQuCgEabRZfPOUrPtRHlMoHug8=
Received: from epsnrtp03.localdomain (unknown [182.195.42.155]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTPS id
	20250716154523epcas5p4d26b403c6818ea6318e916cf1ff9334a~SxdTwbaQv1705917059epcas5p4n;
	Wed, 16 Jul 2025 15:45:23 +0000 (GMT)
Received: from epcas5p2.samsung.com (unknown [182.195.38.89]) by
	epsnrtp03.localdomain (Postfix) with ESMTP id 4bj0kV2s42z3hhT4; Wed, 16 Jul
	2025 15:45:22 +0000 (GMT)
Received: from epsmtip2.samsung.com (unknown [182.195.34.31]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
	20250716134010epcas5p1c7ca7bcc7addf12c4cab2e4aefb7e020~Svv_y4uST0313803138epcas5p1N;
	Wed, 16 Jul 2025 13:40:10 +0000 (GMT)
Received: from green245.samsungds.net (unknown [107.99.41.245]) by
	epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20250716134009epsmtip288b7b68c230c6fe662e014dd030f526b~Svv9xDfc31999519995epsmtip23;
	Wed, 16 Jul 2025 13:40:09 +0000 (GMT)
From: Nitesh Shetty <nj.shetty@samsung.com>
To: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>
Cc: gost.dev@samsung.com, nitheshshetty@gmail.com, Nitesh Shetty
	<nj.shetty@samsung.com>, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] nvmet: Add support for FDP in fabrics passthru path
Date: Wed, 16 Jul 2025 19:09:44 +0530
Message-Id: <20250716133944.1384388-1-nj.shetty@samsung.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20250716134010epcas5p1c7ca7bcc7addf12c4cab2e4aefb7e020
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
cpgsPolicy: CPGSC10-542,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20250716134010epcas5p1c7ca7bcc7addf12c4cab2e4aefb7e020
References: <CGME20250716134010epcas5p1c7ca7bcc7addf12c4cab2e4aefb7e020@epcas5p1.samsung.com>

Add support for admin_get_feature FDP(0x1d) feature id, thus enabling
FDP at the initiator side for the target controller and namespaces
attached to it.

Signed-off-by: Nitesh Shetty <nj.shetty@samsung.com>
---
 drivers/nvme/target/passthru.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/nvme/target/passthru.c b/drivers/nvme/target/passthru.c
index b7515c53829b..0fd49f9f6542 100644
--- a/drivers/nvme/target/passthru.c
+++ b/drivers/nvme/target/passthru.c
@@ -533,6 +533,8 @@ u16 nvmet_parse_passthru_admin_cmd(struct nvmet_req *req)
 		case NVME_FEAT_HOST_ID:
 			req->execute = nvmet_execute_get_features;
 			return NVME_SC_SUCCESS;
+		case NVME_FEAT_FDP:
+			return nvmet_setup_passthru_command(req);
 		default:
 			return nvmet_passthru_get_set_features(req);
 		}

base-commit: 347e9f5043c89695b01e66b3ed111755afcf1911
-- 
2.43.0


