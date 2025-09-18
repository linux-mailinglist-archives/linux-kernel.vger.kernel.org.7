Return-Path: <linux-kernel+bounces-820876-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 35303B7F93D
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 15:52:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ADB8D18942A3
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 13:47:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B84C5333A97;
	Wed, 17 Sep 2025 13:41:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="hsgJL7Gz"
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2E3533594D
	for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 13:41:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758116519; cv=none; b=gkLK6N5vb4CWW6WBSKKMdY1FUKpXTK15t4lM8PqzkrZSoeTXO37782J5xVDEgJTOHgtC8DTNDeEACns7xo10IJBtbNX53PnWnUHzhb2Ly2lelfE5g+a1/i77R/9TjL2ooIZ6+BFao+V+cSxQ1jm5P0bN7TvUtGveg2s3jWuOeGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758116519; c=relaxed/simple;
	bh=aAT36OD6sazighOfpzQSmftqbC9DnJOQdrbUq9T0Bvk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:MIME-Version:
	 Content-Type:References; b=d2SgAJwWudkkwBGQvtDMpsLd4X9KCG65FxLp86fbQ21lJNCoxnxL/8JvfQYnvsLvuU1QPwBiuS0rStG0uBVAUXopr2f5F7fluJzTCu3LdRjE+GyafIM1biIxTf2j0/0YuFtoi0WALec1aSYgku3MuHsQhRxtBLJbssEqgnuubw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=hsgJL7Gz; arc=none smtp.client-ip=203.254.224.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
	by mailout3.samsung.com (KnoxPortal) with ESMTP id 20250917134155epoutp03aa0149d62a7291b63e0b3a8441f21398~mFafiX2y00946809468epoutp03F
	for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 13:41:55 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20250917134155epoutp03aa0149d62a7291b63e0b3a8441f21398~mFafiX2y00946809468epoutp03F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1758116515;
	bh=EvHiPrSCwDV9YFoLErNp7XwahEpYXRahMYHe/BeQwrI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hsgJL7Gz0dW0OSYplh1klVc5wB1LfJQMFRSZ6UgvRDAHvnR5VInploAo1/16d6QW7
	 6V2v+QoICh2Y40oWr7dMkHb53vUpg6RVytkI0pLb4QXfM9Z5iNl6bjk0P4tZLRgJZR
	 uO4uktnFXShsES/jpem08drtRCbfoPpHJJAw1tY4=
Received: from epsnrtp01.localdomain (unknown [182.195.42.153]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTPS id
	20250917134154epcas5p20d3515258023be49296af30e22b27630~mFae6SDpf0912409124epcas5p2c;
	Wed, 17 Sep 2025 13:41:54 +0000 (GMT)
Received: from epcas5p1.samsung.com (unknown [182.195.38.92]) by
	epsnrtp01.localdomain (Postfix) with ESMTP id 4cRg0x52Qwz6B9m4; Wed, 17 Sep
	2025 13:41:53 +0000 (GMT)
Received: from epsmtip2.samsung.com (unknown [182.195.34.31]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
	20250917134153epcas5p1e1f7a7a19fb41d12b9397c3e6265f823~mFadm6i5E2209422094epcas5p1R;
	Wed, 17 Sep 2025 13:41:53 +0000 (GMT)
Received: from test-PowerEdge-R740xd.samsungds.net (unknown [107.99.41.79])
	by epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20250917134151epsmtip27d672a0b6f0f07066cde9dc3c3ba8a26~mFabrhxfP0833808338epsmtip2O;
	Wed, 17 Sep 2025 13:41:50 +0000 (GMT)
From: Neeraj Kumar <s.neeraj@samsung.com>
To: linux-cxl@vger.kernel.org, nvdimm@lists.linux.dev,
	linux-kernel@vger.kernel.org, gost.dev@samsung.com
Cc: a.manzanares@samsung.com, vishak.g@samsung.com, neeraj.kernel@gmail.com,
	cpgs@samsung.com, Neeraj Kumar <s.neeraj@samsung.com>
Subject: [PATCH V3 12/20] nvdimm/region_label: Export routine to fetch
 region information
Date: Wed, 17 Sep 2025 19:11:08 +0530
Message-Id: <20250917134116.1623730-13-s.neeraj@samsung.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250917134116.1623730-1-s.neeraj@samsung.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20250917134153epcas5p1e1f7a7a19fb41d12b9397c3e6265f823
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
X-CPGSPASS: Y
cpgsPolicy: CPGSC10-542,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20250917134153epcas5p1e1f7a7a19fb41d12b9397c3e6265f823
References: <20250917134116.1623730-1-s.neeraj@samsung.com>
	<CGME20250917134153epcas5p1e1f7a7a19fb41d12b9397c3e6265f823@epcas5p1.samsung.com>

CXL region information preserved from the LSA needs to be exported for
use by the CXL driver for CXL region re-creation.

Signed-off-by: Neeraj Kumar <s.neeraj@samsung.com>
---
 drivers/nvdimm/dimm_devs.c | 18 ++++++++++++++++++
 include/linux/libnvdimm.h  |  2 ++
 2 files changed, 20 insertions(+)

diff --git a/drivers/nvdimm/dimm_devs.c b/drivers/nvdimm/dimm_devs.c
index 918c3db93195..619c8ce56dce 100644
--- a/drivers/nvdimm/dimm_devs.c
+++ b/drivers/nvdimm/dimm_devs.c
@@ -280,6 +280,24 @@ void *nvdimm_provider_data(struct nvdimm *nvdimm)
 }
 EXPORT_SYMBOL_GPL(nvdimm_provider_data);
 
+bool nvdimm_has_cxl_region(struct nvdimm *nvdimm)
+{
+	if (nvdimm)
+		return nvdimm->is_region_label;
+
+	return false;
+}
+EXPORT_SYMBOL_GPL(nvdimm_has_cxl_region);
+
+void *nvdimm_get_cxl_region_param(struct nvdimm *nvdimm)
+{
+	if (nvdimm)
+		return &nvdimm->cxl_region_params;
+
+	return NULL;
+}
+EXPORT_SYMBOL_GPL(nvdimm_get_cxl_region_param);
+
 static ssize_t commands_show(struct device *dev,
 		struct device_attribute *attr, char *buf)
 {
diff --git a/include/linux/libnvdimm.h b/include/linux/libnvdimm.h
index 07ea2e3f821a..3ffd50ab6ac4 100644
--- a/include/linux/libnvdimm.h
+++ b/include/linux/libnvdimm.h
@@ -330,6 +330,8 @@ int nvdimm_in_overwrite(struct nvdimm *nvdimm);
 bool is_nvdimm_sync(struct nd_region *nd_region);
 int nd_region_label_update(struct nd_region *nd_region);
 int nd_region_label_delete(struct nd_region *nd_region);
+bool nvdimm_has_cxl_region(struct nvdimm *nvdimm);
+void *nvdimm_get_cxl_region_param(struct nvdimm *nvdimm);
 
 static inline int nvdimm_ctl(struct nvdimm *nvdimm, unsigned int cmd, void *buf,
 		unsigned int buf_len, int *cmd_rc)
-- 
2.34.1


