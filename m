Return-Path: <linux-kernel+bounces-773000-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BB79FB29A51
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 08:58:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CC5CF189A875
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 06:57:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6E8727B4EB;
	Mon, 18 Aug 2025 06:56:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="N45gZS2B"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EABA279331
	for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 06:56:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755500181; cv=none; b=T6pPef8UO5o+OaO5hmihgNR6ok6uZHgmpMe6DE0fac6/hnwOAxyBtW6yHXw4r1mV6SgiXN5ZGcZhBI5SxTrEyfsFLmJWRVfnuqUas+v3wywOqkj/2LJwlI2zaeMIvl+UFQmu7nqCayIeMBEF1Q/wdENvy3Qg70Lg+9EYbjs/AVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755500181; c=relaxed/simple;
	bh=5Wl9UvnqdPSYwIEMxJ5A0h7SCvl2ekS9J7645gxNgrA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=EGSRFjU3CQfWe4jbqx99Hl3uDItpSrl3bh+yWVwqh++kWhYHKHIckGe05PK3UacKXb9JtkFSqYc5LZ0yZzDxsKGuJAhK7OgX2CCpqmtqMNOBBhCC9/AdwhQ7yEjJmq/oDA6CppO3g8Irk8yqs3hDvWtpOdl2KmaXtKyUGpOupl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=N45gZS2B; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57HMWDqV009207
	for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 06:56:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	8e4z+gf/aWpPlnu9UM4/QNjfkW0jDz1JekqtIfup3UU=; b=N45gZS2BPv8KlZ8o
	6KKpgMMmuhrRuYN/RuLeJ8FaVY+k1Ydw2mDMUk/4dr5gHTJC5Z6Whkx/l+SPaw3s
	gxIfatENG7QdYNGiN10IlbxynvlMTmo7qMvzuSVQyXrjXviMWhTRBIh0ou9ybQh3
	neytKeU++bxYapv8zM685vxwIJdWw3bYXxLwFJSLYoqLKGBP2E4Sczt+hfbn7zwJ
	DPXltSrJMWfUrZCMdeCyTmAMOwRDAsVxv29gGCDxnmkyJHy9BJKigXl7E9wwhuT3
	w48LNr/5PNkDW2yq91fTQAX2Td5F1KAQMfTtCzeqgwSvBHLCAa0Yk79nuiwxRvxd
	I8//9w==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48jk5mbg50-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 06:56:19 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-321cfa79cb3so5001029a91.1
        for <linux-kernel@vger.kernel.org>; Sun, 17 Aug 2025 23:56:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755500178; x=1756104978;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8e4z+gf/aWpPlnu9UM4/QNjfkW0jDz1JekqtIfup3UU=;
        b=MzJ4gz9HIwWmt5BnggDzRlLg7Bu0K4OQ5EG/0azuTWpVBb/pbwVF/jyiIq8hGKCBXz
         a3/leomIrvx3cTQghSyWXPnDx0MmNq0egK4PRqthtp3ue5WGfb27xh9i4u4T15zL/T14
         M5IqOTq14rbbEUXFbZvtTdIeRRDrQ67s2h+d/rM43+WtVjuMN/uhgFwEgNydSm0Q4j0b
         MDYZdz5avgoUsronU4k3tKc01gjxDZBTDmd/cTG3MGJ/jrap/W/yDH5PrmudU/TX1vGG
         p3aw3FH7AF7sVmVGn7fGU1OnetB7TokCJNeKktT2FdUQNPJtcPumf7+eMToSAY8JJy/v
         4S6Q==
X-Forwarded-Encrypted: i=1; AJvYcCXJeXcjoTYgp0qOmLjYrXQ/CVMy/R1Z+T8oA/ctSvJNm5I9iMdgA95FotNVHoeBk/iQzu1/rcAQ7a205Fg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzVvlTuUlEvpVazkvM7ugzyLWInJ4MmSi5E2u5iN0i56yhA82yD
	vrzuwAHXvFsIbU8Wn0qprx7HhoCC2QESDuKhG0FTQNLO+KlpL4DjjNfv67+jD+uGnWYgjD1W2iy
	5J4L/gQK+BiXAPDRyuA3OamgAFKT1vWK0O2SPdDBbo5QWGQwAsyIR6F86TA8YNC3vfM0=
X-Gm-Gg: ASbGncv+6RmYzdLor7KlIc2GXFLiXBs74CxETH3+G8qGzmlQ5vR1pkj/aJhgLwvK9nr
	Vypjv7wpLyVFlu0xo7UYsJRp+/dZYn590lUqHnSixWiwRXfhgQRi97HYfwIWaVUQ6JEBC7GJCKa
	qKDJlkBouMkL2cjKDV8A/VMfTFRTN7e1tGF3DmzkSZxaxjYR/8cMaODcNFUdkcgE/CJoDjP26e7
	OH8NfyI7G6vbo/lO7CNLaEushX1Xl0RT2T9NtnDugGVhDDppIFaAqfnTsiizqaEHLArcmPVRkZy
	+wonjr73LF+ZXki9AU65UCh7oEsiCP85A4BfFhtRjHzLF8IxqRB9cDMOucvVkoTWUaYzg33DYs0
	=
X-Received: by 2002:a17:903:2307:b0:240:8381:45b9 with SMTP id d9443c01a7336-2446bd131ddmr163984205ad.8.1755500178132;
        Sun, 17 Aug 2025 23:56:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGpqM+mGk/RiAx9BWXGjDpBgWThok2W8IwGmi3ZbBQ77hdKXhW9CnBvLhWaOuaZYx5UEkP3dw==
X-Received: by 2002:a17:903:2307:b0:240:8381:45b9 with SMTP id d9443c01a7336-2446bd131ddmr163983775ad.8.1755500177608;
        Sun, 17 Aug 2025 23:56:17 -0700 (PDT)
Received: from hu-krichai-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2446d50f664sm70240105ad.75.2025.08.17.23.56.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Aug 2025 23:56:17 -0700 (PDT)
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Date: Mon, 18 Aug 2025 12:25:48 +0530
Subject: [PATCH 3/5] bus: mhi: pci_generic: Add support for 64 bit register
 read & write
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250818-tsc_time_sync-v1-3-2747710693ba@oss.qualcomm.com>
References: <20250818-tsc_time_sync-v1-0-2747710693ba@oss.qualcomm.com>
In-Reply-To: <20250818-tsc_time_sync-v1-0-2747710693ba@oss.qualcomm.com>
To: Manivannan Sadhasivam <mani@kernel.org>,
        Richard Cochran <richardcochran@gmail.com>
Cc: mhi@lists.linux.dev, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        taniya.das@oss.qualcomm.com, imran.shaik@oss.qualcomm.com,
        quic_vbadigan@quicinc.com, quic_mrana@quicinc.com,
        Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1755500162; l=1575;
 i=krishna.chundru@oss.qualcomm.com; s=20230907; h=from:subject:message-id;
 bh=5Wl9UvnqdPSYwIEMxJ5A0h7SCvl2ekS9J7645gxNgrA=;
 b=Aa0FKv0m+4xEHETJytTE62MY9NZx7FSScx8slkfImQIpt7JLASHmhuRBxzLlZUDJ/FUYIXcoC
 0WvnTeFEQeTBczlgqTZUTRR1gFNiRvIX+S5CO5/dSngz5Nq73J7fNZq
X-Developer-Key: i=krishna.chundru@oss.qualcomm.com; a=ed25519;
 pk=10CL2pdAKFyzyOHbfSWHCD0X0my7CXxj8gJScmn1FAg=
X-Authority-Analysis: v=2.4 cv=Sdn3duRu c=1 sm=1 tr=0 ts=68a2ce93 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=EUspDBNiAAAA:8 a=MXGvhfJtNsboA4ndukAA:9
 a=QEXdDO2ut3YA:10 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-ORIG-GUID: 2Yag4F4SS4eqzfkwEACrJdVsqoIeHhnP
X-Proofpoint-GUID: 2Yag4F4SS4eqzfkwEACrJdVsqoIeHhnP
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODE2MDA0MiBTYWx0ZWRfXyA7UO2i/NUKY
 hph4lmOF7nGQGYKyZBUzTWZzz7HK34e+WFsqH/qRizSfjcN0uWs81a+YO7SUnDthfaRENxx0ieo
 0Eh/+skC47iSwGVmhU377eF6OKFk7Q+RqAVgJiDll5zujUm5AFJynA6tEnF2N/V66M4bSZogqwT
 /ZxaIezSAAbGTrmgeuxtseP4WqCd8UQ6NxM6YG+/fhUVD7QZy/jlz2+2DH4r8vmezGgnAVXuMLa
 tDjA/AgvH98FQWJ53Dgv314Z9YO4Y4Yp9U2BUg5ijHUkJrDEKvFi8Upx8dv7P7gYlk5I5+H1kJC
 eC4lum1DRINcj0LEyrq8W78MJBpPvQvOdI2b+9PA7mxLXQvMjhomWA5r/YK0aWb2T7ga+ipbo7H
 X3XyKeoO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-18_03,2025-08-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 suspectscore=0 priorityscore=1501 spamscore=0
 adultscore=0 malwarescore=0 bulkscore=0 phishscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508160042

Add functions which does read and write on 64 bit registers.

Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
---
 drivers/bus/mhi/host/pci_generic.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/drivers/bus/mhi/host/pci_generic.c b/drivers/bus/mhi/host/pci_generic.c
index 4edb5bb476baf02af02aed00be0d6bacf9e92634..e6c13c1a35253e6630b193827f8dadcd22a6198a 100644
--- a/drivers/bus/mhi/host/pci_generic.c
+++ b/drivers/bus/mhi/host/pci_generic.c
@@ -1039,6 +1039,27 @@ struct mhi_pci_device {
 	unsigned long status;
 };
 
+#ifdef readq
+static int mhi_pci_read_reg64(struct mhi_controller *mhi_cntrl,
+			      void __iomem *addr, u64 *out)
+{
+	*out = readq(addr);
+	return 0;
+}
+#else
+#define mhi_pci_read_reg64 NULL
+#endif
+
+#ifdef writeq
+static void mhi_pci_write_reg64(struct mhi_controller *mhi_cntrl,
+				void __iomem *addr, u64 val)
+{
+	writeq(val, addr);
+}
+#else
+#define mhi_pci_write_reg64 NULL
+#endif
+
 static int mhi_pci_read_reg(struct mhi_controller *mhi_cntrl,
 			    void __iomem *addr, u32 *out)
 {
@@ -1324,6 +1345,8 @@ static int mhi_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 
 	mhi_cntrl->read_reg = mhi_pci_read_reg;
 	mhi_cntrl->write_reg = mhi_pci_write_reg;
+	mhi_cntrl->read_reg64 = mhi_pci_read_reg64;
+	mhi_cntrl->write_reg64 = mhi_pci_write_reg64;
 	mhi_cntrl->status_cb = mhi_pci_status_cb;
 	mhi_cntrl->runtime_get = mhi_pci_runtime_get;
 	mhi_cntrl->runtime_put = mhi_pci_runtime_put;

-- 
2.34.1


