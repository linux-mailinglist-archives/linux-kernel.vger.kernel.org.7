Return-Path: <linux-kernel+bounces-806286-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id E80B4B49497
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 18:00:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D7C584E1DF5
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 16:00:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D9C230E83A;
	Mon,  8 Sep 2025 15:59:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fb.com header.i=@fb.com header.b="OgcpRIK8"
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12FE330E0E9
	for <linux-kernel@vger.kernel.org>; Mon,  8 Sep 2025 15:59:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.145.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757347154; cv=none; b=ZOxVc6WLPRBxL2TN8hQfbuxVutXLQ4MW0e7bjItpibtEGeIX7ToYIAjsFjRd5BEl7Eq49m+kNHo4AsotrRGEcd7fnB7EKOFeUSC6G9Tul1h4QMjI1pXrkjksre3DRoO40re7RwABlVgHMi/waKo+uGpuSo48Tsk3YTtFFIVGRiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757347154; c=relaxed/simple;
	bh=2krKqPDnu6ZoKedmET6XscnfTh9gbAEoU57523IvkRE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:To:CC; b=c8xLLPfBrDQmgTMT/LLzQTb25P8j1lx/W3ZAtaYUZtrUBR+v3d78x08R2cSFw4UZLU7D/UiZCiolA7SvjJyW+j+BhYQOQMlfIL6DpDM6DRT8N3YoO5iK62lphPfHxWsX8yGa3EsZwM7Iv/AJHu4o3qCuE6ehKoXODDClopjVRxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fb.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=fb.com header.i=@fb.com header.b=OgcpRIK8; arc=none smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fb.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 588EqqIm834763
	for <linux-kernel@vger.kernel.org>; Mon, 8 Sep 2025 08:59:12 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=s2048-2025-q2; bh=zsTDAaCNaYJMcxkfyz
	k7W/d4JlbOG/PBayoT8EgoXJ8=; b=OgcpRIK8SUy5pAuiXJ5NEsiJo/t2k8ADfb
	OP+gqeHn/j4qRLp5/Tu8pnMNeyi7k5aEjXZP35VUlw/PzQOzSpEJduDWUCucB+GB
	k5WDlJsAGXkBEXSFXbXU9/8p6UQOk7fNmteQ3gHt4S5DOqXE4neVBBbiPycfgE4Q
	dmZpqtenSbh9btdRioGWV+zJ4NN1bVFxY9oKDWx6WEZ8bxlevN+RXpnzrpRave7o
	8AgJNaKW4gFxljiTX/hp/H1p/WgO13QkulqtgYfCNEh3ZjZWSW+ViXpbRDdwF3oa
	gxGyyp6tzTRZTfukGzcP7JMkGm28n0g5Gr4j52xS1PytSO77O+cA==
Received: from maileast.thefacebook.com ([163.114.135.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 491ss0bn11-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 08 Sep 2025 08:59:12 -0700 (PDT)
Received: from twshared30833.05.prn5.facebook.com (2620:10d:c0a8:1c::11) by
 mail.thefacebook.com (2620:10d:c0a9:6f::8fd4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.20; Mon, 8 Sep 2025 15:59:11 +0000
Received: by devgpu025.cco5.facebook.com (Postfix, from userid 199522)
	id D162688043A; Mon,  8 Sep 2025 08:59:01 -0700 (PDT)
From: Alex Mastro <amastro@fb.com>
Date: Mon, 8 Sep 2025 08:58:40 -0700
Subject: [PATCH] vfio: return -ENOTTY for unsupported device feature
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20250908-vfio-enotty-v1-1-4428e1539e2e@fb.com>
X-B4-Tracking: v=1; b=H4sIAC/9vmgC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDSwNz3bK0zHzd1Lz8kpJKXTPLNAtLo2Rj49S0VCWgjoKi1LTMCrBp0bG
 1tQC5/RgyXQAAAA==
To: Alex Williamson <alex.williamson@redhat.com>
CC: Jason Gunthorpe <jgg@ziepe.ca>, <kvm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Alex Mastro <amastro@fb.com>
X-Mailer: b4 0.13.0
X-FB-Internal: Safe
X-Proofpoint-ORIG-GUID: 6O3nMWXBkoSMnedFeGyUP-94pc9NADRo
X-Proofpoint-GUID: 6O3nMWXBkoSMnedFeGyUP-94pc9NADRo
X-Authority-Analysis: v=2.4 cv=HJHDFptv c=1 sm=1 tr=0 ts=68befd50 cx=c_pps
 a=MfjaFnPeirRr97d5FC5oHw==:117 a=MfjaFnPeirRr97d5FC5oHw==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=FOH2dFAWAAAA:8 a=kKgOmiqXCJOs5vm8OZwA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA4MDE1NyBTYWx0ZWRfX3zxcudc8ayjH
 tmyuTya+OGJ42Gt4igoL9JcHBF4ayX3DGdk3CYcxcJSY9acGwML/aZ6COrn8p++S4doyCSzUVBz
 y9RqLmEJevVWzPfybizqlStfvzoJlJ9BJm26x0k2gF5mHeCJ6dn1fdzJFmAlBWtya+9MkYAPI7R
 rOiDCV3hLq849r0B+BUTa+fcolPvoTFe27I/TSenTaj8ibbSOrvwMk2xkcEkKR2G0MpxtOWsdiy
 zcMCw+S70DtT08jU7Buv1bKEpAVRwQHp5kCKVcP1884F64D6mFtBempuelHXeUhEgLBfH7QV24L
 u7QQf4pxI2AmapaETnmc3xoG3pB2QoBMDujuT04DiRM8xCFlS2OoVji0I9qn1U=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-08_06,2025-09-08_01,2025-03-28_01

The two implementers of vfio_device_ops.device_feature,
vfio_cdx_ioctl_feature and vfio_pci_core_ioctl_feature, return
-ENOTTY in the fallthrough case when the feature is unsupported. For
consistency, the base case, vfio_ioctl_device_feature, should do the
same when device_feature == NULL, indicating an implementation has no
feature extensions.

Signed-off-by: Alex Mastro <amastro@fb.com>
---
The commit message makes the main points, but I'm assuming that it was
intended for ENOTTY and not EINVAL to be the errno to indicate "this
feature is not supported".
---
 drivers/vfio/vfio_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/vfio/vfio_main.c b/drivers/vfio/vfio_main.c
index 91a8eae308ea..38c8e9350a60 100644
--- a/drivers/vfio/vfio_main.c
+++ b/drivers/vfio/vfio_main.c
@@ -1252,7 +1252,7 @@ static int vfio_ioctl_device_feature(struct vfio_device *device,
 			feature.argsz - minsz);
 	default:
 		if (unlikely(!device->ops->device_feature))
-			return -EINVAL;
+			return -ENOTTY;
 		return device->ops->device_feature(device, feature.flags,
 						   arg->data,
 						   feature.argsz - minsz);

---
base-commit: 093458c58f830d0a713fab0de037df5f0ce24fef
change-id: 20250907-vfio-enotty-69f892c33efe

Best regards,
-- 
Alex Mastro <amastro@fb.com>


