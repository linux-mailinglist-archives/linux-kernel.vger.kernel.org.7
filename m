Return-Path: <linux-kernel+bounces-690145-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 02CFAADCC73
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jun 2025 15:06:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C25E84003B0
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jun 2025 13:03:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FFA72E2668;
	Tue, 17 Jun 2025 13:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="REbDqV+P"
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB6BC2EB5C8
	for <linux-kernel@vger.kernel.org>; Tue, 17 Jun 2025 13:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750165214; cv=none; b=EIyRXtspNK+QMH1R151BIhahf4CZb0yakUgM5bG5IqRp+NcxR4qu85xfO9koT6C+f1frTMP82o3/Cip8IgLAwaAs9ilRKuTK80uV9tHzroKS0759Id5eg19hOBCbhr55UVWQDTHoG+LsyVAUyM49NDB1LaaiX+JuS9mEuuuWWyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750165214; c=relaxed/simple;
	bh=QPRyqi00g3KJ9J3/BOtH9ar5XWUEC5GSFTuURVygUrE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:MIME-Version:
	 Content-Type:References; b=YdBvFJBifGsV+XkIVcYwI4HbG3kr/tnDblIErA2pdTpivybjFovZWYfiM7w+qa2RuAsAiWBhN01tmqsbX8DWUidHBDS4ewlyIrwFoABwMxvIBuwaGJ8eonyDoUJ/OupZuLQkVNyVJWOqNoJP1i60WwuJ06I9fOu1Wo4JHutzBUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=REbDqV+P; arc=none smtp.client-ip=203.254.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
	by mailout4.samsung.com (KnoxPortal) with ESMTP id 20250617130005epoutp04e28fb94d9cdca576fa5a5832db9b7c2f~J1ftXJDQ22167821678epoutp04O
	for <linux-kernel@vger.kernel.org>; Tue, 17 Jun 2025 13:00:05 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20250617130005epoutp04e28fb94d9cdca576fa5a5832db9b7c2f~J1ftXJDQ22167821678epoutp04O
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1750165205;
	bh=mGOKRZhuRng8+G/QThk2A3VRJikf51QSXgSzCEdjU8o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=REbDqV+PmFzICJsQc5XQrgbdJ5p3WtEewJef+wrSjfc5YNp0B6Rreqt/I0b9GmL+x
	 31Yk4EoinjqNaNfFoCpPp+7gj+pfH1BjNlu/ZQ3rVvS51e0zwaoAKSVgsu0tK6xj+B
	 K8LOeoIdeVNgsiBVe0OjmucDkLTwyCT15J0Z1kfE=
Received: from epsnrtp03.localdomain (unknown [182.195.42.155]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTPS id
	20250617130005epcas5p20cff7e0ab5ca5607ee6edae7abf2485d~J1fs3AobM1917719177epcas5p2N;
	Tue, 17 Jun 2025 13:00:05 +0000 (GMT)
Received: from epcpadp1new (unknown [182.195.40.141]) by
	epsnrtp03.localdomain (Postfix) with ESMTP id 4bM6R90n2qz3hhT4; Tue, 17 Jun
	2025 13:00:05 +0000 (GMT)
Received: from epsmtip2.samsung.com (unknown [182.195.34.31]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
	20250617124031epcas5p3542c2fc6d946f3cdcbc06dbfc65743e2~J1On-HuCs2102821028epcas5p33;
	Tue, 17 Jun 2025 12:40:31 +0000 (GMT)
Received: from test-PowerEdge-R740xd.samsungds.net (unknown [107.99.41.79])
	by epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20250617124028epsmtip2fae8871e5bf5e82a4abc397ffd8e6dde~J1Ole78oP2555425554epsmtip2H;
	Tue, 17 Jun 2025 12:40:28 +0000 (GMT)
From: Neeraj Kumar <s.neeraj@samsung.com>
To: dan.j.williams@intel.com, dave@stgolabs.net,
	jonathan.cameron@huawei.com, dave.jiang@intel.com,
	alison.schofield@intel.com, vishal.l.verma@intel.com, ira.weiny@intel.com
Cc: a.manzanares@samsung.com, nifan.cxl@gmail.com, anisa.su@samsung.com,
	vishak.g@samsung.com, krish.reddy@samsung.com, arun.george@samsung.com,
	alok.rathore@samsung.com, s.neeraj@samsung.com, neeraj.kernel@gmail.com,
	linux-kernel@vger.kernel.org, linux-cxl@vger.kernel.org,
	nvdimm@lists.linux.dev, gost.dev@samsung.com, cpgs@samsung.com
Subject: [RFC PATCH 09/20] nvdimm/namespace_label: Skip region label during
 ns label DPA reservation
Date: Tue, 17 Jun 2025 18:09:33 +0530
Message-Id: <306123060.201750165205099.JavaMail.epsvc@epcpadp1new>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250617123944.78345-1-s.neeraj@samsung.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20250617124031epcas5p3542c2fc6d946f3cdcbc06dbfc65743e2
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
X-CPGSPASS: Y
X-Hop-Count: 3
X-CMS-RootMailID: 20250617124031epcas5p3542c2fc6d946f3cdcbc06dbfc65743e2
References: <20250617123944.78345-1-s.neeraj@samsung.com>
	<CGME20250617124031epcas5p3542c2fc6d946f3cdcbc06dbfc65743e2@epcas5p3.samsung.com>

If Namespace label is present in LSA during nvdimm_probe then DPA
reservation is required. But this reservation is not required by region
label. Therefore if LSA scanning finds any region label, skip it.

Signed-off-by: Neeraj Kumar <s.neeraj@samsung.com>
---
 drivers/nvdimm/label.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/nvdimm/label.c b/drivers/nvdimm/label.c
index 22e13db1ca20..3a870798a90c 100644
--- a/drivers/nvdimm/label.c
+++ b/drivers/nvdimm/label.c
@@ -450,6 +450,10 @@ int nd_label_reserve_dpa(struct nvdimm_drvdata *ndd)
 		nd_label = to_label(ndd, slot);
 		ns_label = &nd_label->ns_label;
 
+		/* skip region label, dpa reservation for ns label only */
+		if (is_region_label(ndd, nd_label))
+			continue;
+
 		if (!slot_valid(ndd, nd_label, slot))
 			continue;
 
-- 
2.34.1



