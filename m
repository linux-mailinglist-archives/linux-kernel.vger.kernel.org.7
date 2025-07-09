Return-Path: <linux-kernel+bounces-723265-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2956AAFE51A
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 12:08:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DA9EC1C45828
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 10:07:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08460289E31;
	Wed,  9 Jul 2025 10:05:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=imgtec.com header.i=@imgtec.com header.b="u3NsDJsd"
Received: from mx07-00376f01.pphosted.com (mx07-00376f01.pphosted.com [185.132.180.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93E27289813
	for <linux-kernel@vger.kernel.org>; Wed,  9 Jul 2025 10:04:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.132.180.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752055501; cv=none; b=fehaBLAlRZHLpTOdTNIz1FRuUcsW6YagKT5HocHMdv+fVh8+bwy4gcXG8fr5MzjYiO9+ZdLwKaWPab6C3ITROAuvPot/2FtKXf2WXc9djvfgkDoEOmYAQK8PgGyVjLMYM2P83sf/7Sy06h3NJyNSWUIvf4T5iAxleXO1tanMJ40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752055501; c=relaxed/simple;
	bh=559mbCe5J65flHxiWnUSLTNbYYOcLpcFKpWUoBDYwd4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=cmEvri3QJT4Ac4RQcnEevZYeBw4piUnObXU2SjKgMOxxDz0YNkCJU6n4a4UiUX8x35cz0WRDYKJ6nV+QOFKko4UjfmN3MMx9+18yuAN/aVDL7nDPs+D0d1NSeN5iEfgZzLB05dGslh0PV1rAXo+1yFTVu4lT98+Z+GOcU4dSXis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=imgtec.com; spf=pass smtp.mailfrom=imgtec.com; dkim=pass (2048-bit key) header.d=imgtec.com header.i=@imgtec.com header.b=u3NsDJsd; arc=none smtp.client-ip=185.132.180.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=imgtec.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=imgtec.com
Received: from pps.filterd (m0168889.ppops.net [127.0.0.1])
	by mx07-00376f01.pphosted.com (8.18.1.8/8.18.1.8) with ESMTP id 5694tX8h317115;
	Wed, 9 Jul 2025 11:04:33 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=imgtec.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=dk201812; bh=e
	bBahp1u6fukKBmrXs/Vce9cUQXPry/EVPhJCxWK1vQ=; b=u3NsDJsdS8EH6++tK
	okd4u1hPBHU82jQs4ZKkPN8f7CF827MP6SlvUukRLh+Ph/G25VQ7jpfU6x7pWndV
	fPBpyhpC+5pBI3Yu2+veOBV198PYyifzp4ZyFlK4vLB9je8RL3Gm8QE7O/ciS2P2
	03LREqB5bJO2RXQq3N3qIh3WUhSGlMQ2wTKhMtzJMZsS2Nuh2g0R965yqfCJyoO8
	7eeAyalF3UoDBWwDJQvMDVGRGtw7Y0tzhg2q7C6wXg2QYyzFoIRjbzdKBwoe6Sno
	EuOPaBoiOE7Cy1OyEAgWFXDCgMuofbSUyXeUX2eTjQtWm/RgF7oNcHe5T/AAz0j0
	bBarg==
Received: from hhmail05.hh.imgtec.org (83-244-153-141.cust-83.exponential-e.net [83.244.153.141])
	by mx07-00376f01.pphosted.com (PPS) with ESMTPS id 47pv4t3q37-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Wed, 09 Jul 2025 11:04:33 +0100 (BST)
Received: from
 1.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.ip6.arpa
 (172.25.2.134) by HHMAIL05.hh.imgtec.org (10.100.10.120) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Wed, 9 Jul 2025 11:04:32 +0100
From: Matt Coster <matt.coster@imgtec.com>
Date: Wed, 9 Jul 2025 11:04:09 +0100
Subject: [PATCH 1/2] drm/imagination: Add and use FLEX_ARRAY_CHECK()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20250709-flex-array-check-v1-1-8adeb0bf0cde@imgtec.com>
References: <20250709-flex-array-check-v1-0-8adeb0bf0cde@imgtec.com>
In-Reply-To: <20250709-flex-array-check-v1-0-8adeb0bf0cde@imgtec.com>
To: Frank Binns <frank.binns@imgtec.com>,
        Maarten Lankhorst
	<maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
CC: <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
        "Matt
 Coster" <matt.coster@imgtec.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2549;
 i=matt.coster@imgtec.com; h=from:subject:message-id;
 bh=559mbCe5J65flHxiWnUSLTNbYYOcLpcFKpWUoBDYwd4=;
 b=owGbwMvMwCFWuUfy8817WRsYT6slMWTk2a23efRsywlDa0nZZrt5KtNXPxbIkOnceD05o2jNr
 lkTJ8+K6ChlYRDjYJAVU2TZscJyhdofNS2JG7+KYeawMoEMYeDiFICJCHsx/OF7LyD8iynF7OO5
 88/Yj66KrPu+7nxSdy2TxmH9a/Vcu7gZ/nCw/WpR1tJezC0v7Hg4ISXjm+/Z63emxoqGVH1PWTN
 LlQ8A
X-Developer-Key: i=matt.coster@imgtec.com; a=openpgp;
 fpr=05A40CFCE7269D61D97100A1747F0A9036F90DFA
X-EXCLAIMER-MD-CONFIG: 15a78312-3e47-46eb-9010-2e54d84a9631
X-Proofpoint-GUID: KzMuMMKPDDcPzvyVvBe9KXooXV7X4Mcc
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzA1MDAyMCBTYWx0ZWRfX9XcK7WJNDi93
 8S3Yxc3cHHkH8oZEEKYACxcx2fRIe0tHQbc910oWePO1Y19cfBz5h18/k0y4eE8WL8oKOzERL26
 KozKKkQIgDArIEIS0Ja7rRDD/a/+OacUMeLxu9nbY0ml1qrBqwj9cmP/hHFHwB20Qr91SK7CGUm
 aQuzZDP0iiQktNe2t0RiDEU5f2q8VFd0euKE2il8dykCj3IPzUyMGuujmGYCwbtSd43PhgCzXGu
 2omO85W1mq0b+GqVNXwtnNG7vTQN2SIl5m2RtawUg1Lcx5CnRLizfgwhElgB8fxxgEg7Vyqvqt0
 Zd5o5tLk4q4z8UzWotHp6n/0MbAwN+5cgh5Bdx8ftafZTedrKN0epPWDtMkNJi5LGuKlv4uUbZW
 CrHhPKvU
X-Proofpoint-ORIG-GUID: KzMuMMKPDDcPzvyVvBe9KXooXV7X4Mcc
X-Authority-Analysis: v=2.4 cv=fMw53Yae c=1 sm=1 tr=0 ts=686e3eb1 cx=c_pps
 a=AKOq//PuzOIrVTIF9yBwbA==:117 a=AKOq//PuzOIrVTIF9yBwbA==:17
 a=OXfeAiaCWNgA:10 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=r_1tXGB3AAAA:8
 a=Oty1861rPJMKSIVDV7gA:9 a=QEXdDO2ut3YA:10 a=t8nPyN_e6usw4ciXM-Pk:22

It makes little to no sense to use SIZE_CHECK() on flexible structures, so
let's validate something that actually matters instead.

Signed-off-by: Matt Coster <matt.coster@imgtec.com>
---
 drivers/gpu/drm/imagination/pvr_rogue_fwif_check.h | 19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/imagination/pvr_rogue_fwif_check.h b/drivers/gpu/drm/imagination/pvr_rogue_fwif_check.h
index 51dc37e78f41d7bdf45d1f434dd1aa5b9eca700a..e72f4064af187e2be3e26722e1ee1ac632087d3d 100644
--- a/drivers/gpu/drm/imagination/pvr_rogue_fwif_check.h
+++ b/drivers/gpu/drm/imagination/pvr_rogue_fwif_check.h
@@ -5,6 +5,8 @@
 #define PVR_ROGUE_FWIF_CHECK_H
 
 #include <linux/build_bug.h>
+#include <linux/overflow.h>
+#include <linux/stddef.h>
 
 #define OFFSET_CHECK(type, member, offset) \
 	static_assert(offsetof(type, member) == (offset), \
@@ -13,6 +15,21 @@
 #define SIZE_CHECK(type, size) \
 	static_assert(sizeof(type) == (size), #type " is incorrect size")
 
+/*
+ * Where the last member of a struct is a flexible array member, using
+ * SIZE_CHECK() is pointless. If the structure is not already padded to
+ * alignment without the flexible array member, sizeof() will not match the
+ * offset of the flexible array member and the "correct" sizeof() value is
+ * completely meaningless.
+ *
+ * In those instances, use FLEX_ARRAY_CHECK() instead to assert that the final
+ * field is a flexible array member and that it behaves as expected.
+ */
+#define FLEX_ARRAY_CHECK(type, member)                            \
+	static_assert(flex_array_size((type *)NULL, member, 1) == \
+			      sizeof_field(type, member[0]),      \
+		      #type "->" #member " is incorrect size")
+
 OFFSET_CHECK(struct rogue_fwif_file_info_buf, path, 0);
 OFFSET_CHECK(struct rogue_fwif_file_info_buf, info, 200);
 OFFSET_CHECK(struct rogue_fwif_file_info_buf, line_num, 400);
@@ -157,7 +174,7 @@ OFFSET_CHECK(struct rogue_fwif_frag_ctx_state, frag_reg_pm_deallocated_mask_stat
 OFFSET_CHECK(struct rogue_fwif_frag_ctx_state, frag_reg_dm_pds_mtilefree_status, 4);
 OFFSET_CHECK(struct rogue_fwif_frag_ctx_state, ctx_state_flags, 8);
 OFFSET_CHECK(struct rogue_fwif_frag_ctx_state, frag_reg_isp_store, 12);
-SIZE_CHECK(struct rogue_fwif_frag_ctx_state, 16);
+FLEX_ARRAY_CHECK(struct rogue_fwif_frag_ctx_state, frag_reg_isp_store);
 
 OFFSET_CHECK(struct rogue_fwif_compute_ctx_state, ctx_state_flags, 0);
 SIZE_CHECK(struct rogue_fwif_compute_ctx_state, 4);

-- 
2.50.1


