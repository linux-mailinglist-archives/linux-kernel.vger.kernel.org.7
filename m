Return-Path: <linux-kernel+bounces-820829-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D707BB7F6D3
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 15:40:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4A8E7189963A
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 13:34:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 067BD29E116;
	Wed, 17 Sep 2025 13:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="EduPP8jQ"
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 275C6330D5C
	for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 13:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758115858; cv=none; b=Y6dmcaPyP56GjJ+BmQaUcmTqqm+RFbnR1a87ghIXZ3tI0MLpcou5qZDHCt4aiPx5MfjAcSYJgq0vRrehR9HEPhg9fnDWEDwpWNjKmKv9VumSFT5XicnOIMRMJsa2wHzMkUHVhSEOysZJIy7YdVQxgLwaBt5zu2Al0LkV+C4m8PA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758115858; c=relaxed/simple;
	bh=KFoRj9mZvTUE6PPXaSVUQhJJ9OCKEsjumD8QM6HYavM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:MIME-Version:
	 Content-Type:References; b=loIjt2sSuIqPpPsirqFP7FtENxFEy+yL9VjRAsnAuPa7S5llbr5zggQ8fc8ls7axKgtgu2YlX4j7Pn2a0PS8IfUJpdPlcFmDH25bbUlkwUZzRRVZ7V2UByuSaMQp77aYA53sTbRAjlHq1X1XiVBeNgn4zBQPQz0M/n+KbJ3A3Ww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=EduPP8jQ; arc=none smtp.client-ip=203.254.224.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
	by mailout2.samsung.com (KnoxPortal) with ESMTP id 20250917133054epoutp02b1546ad716c3d42d980ff0e9ee82a5e9~mFQ4JFo1P0519205192epoutp02e
	for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 13:30:54 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20250917133054epoutp02b1546ad716c3d42d980ff0e9ee82a5e9~mFQ4JFo1P0519205192epoutp02e
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1758115854;
	bh=ruMW/DmvKo1W3pEP4KsORZ6lIfMB2xwID5AWAJCvEL0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EduPP8jQOkQxXERCVHqm1pZgFPj4TrH4LImIj/QAzGYzd1FCO7zlUpfDbC58qugiG
	 hhqCIcPsEaSBFF3UhunStFidy6S2l/SO9wYV0+4XwlPd1hWT/rFXTrNpmieVoUWgwz
	 ZcIj1Q/e/YrhuD+TbtNgyRsKXRmqNarAl6du/wHk=
Received: from epsnrtp01.localdomain (unknown [182.195.42.153]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTPS id
	20250917133054epcas5p3693ce60d3c7c49c30bb2b400b3a9c710~mFQ35UqXs3265832658epcas5p3r;
	Wed, 17 Sep 2025 13:30:54 +0000 (GMT)
Received: from epcas5p2.samsung.com (unknown [182.195.38.90]) by
	epsnrtp01.localdomain (Postfix) with ESMTP id 4cRfmF1w2xz6B9m5; Wed, 17 Sep
	2025 13:30:53 +0000 (GMT)
Received: from epsmtip1.samsung.com (unknown [182.195.34.30]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
	20250917133052epcas5p41b823d7730db4e2a527a1de870842825~mFQ2kqIiP1259712597epcas5p47;
	Wed, 17 Sep 2025 13:30:52 +0000 (GMT)
Received: from test-PowerEdge-R740xd.samsungds.net (unknown [107.99.41.79])
	by epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20250917133051epsmtip180b75e7897a3c8ac325c17c701cdb339~mFQ1hyk-90528305283epsmtip1m;
	Wed, 17 Sep 2025 13:30:51 +0000 (GMT)
From: Neeraj Kumar <s.neeraj@samsung.com>
To: linux-cxl@vger.kernel.org, nvdimm@lists.linux.dev,
	linux-kernel@vger.kernel.org, gost.dev@samsung.com
Cc: a.manzanares@samsung.com, vishak.g@samsung.com, neeraj.kernel@gmail.com,
	Neeraj Kumar <s.neeraj@samsung.com>
Subject: [PATCH V3 16/20] cxl/mem: Preserve cxl root decoder during mem
 probe
Date: Wed, 17 Sep 2025 18:59:36 +0530
Message-Id: <20250917132940.1566437-17-s.neeraj@samsung.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250917132940.1566437-1-s.neeraj@samsung.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20250917133052epcas5p41b823d7730db4e2a527a1de870842825
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
cpgsPolicy: CPGSC10-542,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20250917133052epcas5p41b823d7730db4e2a527a1de870842825
References: <20250917132940.1566437-1-s.neeraj@samsung.com>
	<CGME20250917133052epcas5p41b823d7730db4e2a527a1de870842825@epcas5p4.samsung.com>

Saved root decoder info is required for cxl region persistency

Signed-off-by: Neeraj Kumar <s.neeraj@samsung.com>
---
 drivers/cxl/cxlmem.h | 1 +
 drivers/cxl/mem.c    | 2 ++
 2 files changed, 3 insertions(+)

diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
index 434031a0c1f7..25cb115b72bd 100644
--- a/drivers/cxl/cxlmem.h
+++ b/drivers/cxl/cxlmem.h
@@ -59,6 +59,7 @@ struct cxl_memdev {
 	struct cxl_nvdimm_bridge *cxl_nvb;
 	struct cxl_nvdimm *cxl_nvd;
 	struct cxl_port *endpoint;
+	struct cxl_root_decoder *cxlrd;
 	int id;
 	int depth;
 	u8 scrub_cycle;
diff --git a/drivers/cxl/mem.c b/drivers/cxl/mem.c
index 54501616ff09..1a0da7253a24 100644
--- a/drivers/cxl/mem.c
+++ b/drivers/cxl/mem.c
@@ -152,6 +152,8 @@ static int cxl_mem_probe(struct device *dev)
 		return -ENXIO;
 	}
 
+	cxlmd->cxlrd = cxl_find_root_decoder_by_port(parent_port);
+
 	if (dport->rch)
 		endpoint_parent = parent_port->uport_dev;
 	else
-- 
2.34.1


