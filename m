Return-Path: <linux-kernel+bounces-772914-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D4622B29948
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 08:02:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 416821891954
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 06:00:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B172194A60;
	Mon, 18 Aug 2025 06:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="FkVcqSvC"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B658C2571BD
	for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 06:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755496822; cv=none; b=YFENGyNsSsU74FinMPX0gIsOJrkPFxCwCXBC7ud0SEZA9KDTdd2p1akq/G2km4er0IPVeH93d5Vm+ershpyoPQMhKTtjCeyxQ46cZciHUCIfdBVHX0CF2jo9CpMhHV/A/Y20yT0wCwhje0j69lHVKNI8zEfT4xcFD5NxQD0iH9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755496822; c=relaxed/simple;
	bh=F8W7pnSzxxbFpP22xDacdLqMipVXYgAypDOPeBmG/zI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=JelUDx4qHQ+WEsBNuwi6b+xKOWmeMk9o1nx93ZW7n0/oE4eR6wn4RrWBb6qdAWbOrm1Z0cF0y+IZw9h4CqMVCknvSih08qA32LPdzCw9EpbhQG4enltIEY3wM0cOVS/zvAfJWqLGapuwy7J8VAvMdhbzlWE/GV0SUb4wBwpqfns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=FkVcqSvC; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57I0UKJZ026944
	for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 06:00:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=HosJoKM/3v22jTxYkb/f30
	edvlQMcxY9RWDDqJeGD9w=; b=FkVcqSvC0gAlL6D8S1sE0Ns5nwuxR+ZIHPHHJy
	tinLm/BqVNxjvoTh3aAcCfm4bcPrS0MC8YtrIQ1ZalZniwjB+QLYc1lBpa+NWeAk
	RR+yC1eQIHdOGG9mM+LSGhKCZukhFdkVFf/+ZkRi5Xq2FbzQb9pUDNsNO73swm8E
	mfXx3OCbBELt15SqiZIRldXOT4UkNQlzSs8v9fQhLxCyb5Il7XTYkAHxhx5zSWm+
	HFYm9On4o4dHsapuj3fi3lz4lzGY3jEUfPiVSlphU5Z/b4yg/jPazm+58pkf2yvS
	M7Vh1s1D90HR77UAxkgErKK4GAPy16JW/y+L59rKUCbsWC6w==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48jh073g20-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 06:00:19 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-76e2e5c4734so3557684b3a.0
        for <linux-kernel@vger.kernel.org>; Sun, 17 Aug 2025 23:00:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755496813; x=1756101613;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HosJoKM/3v22jTxYkb/f30edvlQMcxY9RWDDqJeGD9w=;
        b=kC7iwz5gWwjKs/55xzTHCrl+LmBLZXpwQNnQSGORtHWjQRSPGAVgmd8kbn7MmOa5TE
         l8rkK4j0RMlXCJs7EWArgT4JEyzBmHU8kDF7J4a5wfWGo/kIHZngudxGvUm3JsHxuafm
         twOn89IwmLyM5ouJcb+AjSVxqgCWosBAEJD8bCGCM6FPij+sYvBTRbE1Y3/f2CdHoEar
         hxZpmYXqB6XvV7sx4rlDJn3gYHighIHkrvTUg1wmti8VCJqx9IPz6uh3/aMemZCmZFp1
         +4t8ud6KELxO6AFblB/BnJ/20UnwHKY8XHQfagriTaKyJYNEAUzz5Q4y3ksj5Y0Oeim8
         pi8A==
X-Forwarded-Encrypted: i=1; AJvYcCWGzFQItrAt6EE4NLG68681FXxRGIYn3SK2aKeuAlssJiHucfx1mN55iBhRslcLHN3QcGl4Q8aGJ4e5jIA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxRXPOSvrTXlHO6cr3NjhGLXpX9amfoLXSHGVKxTaCe2WzLPul0
	cvN6yE5GJhQ1Skag8xSmddvFGJSc/Gp9TLc/d0rVC9zvHNy0vwEdZfvTMmV1KIk1zEFt/nB54uv
	Ffnn8SfkQo/Z0BJEKEpgPqy5c8uZVHfeiC0BjLzizkGTQrPswPHTq2A+gfBqgAVzI2oo=
X-Gm-Gg: ASbGncuXNktdWTz34VCx9PaoV3KfJSvC/L1NSpFzPrp3X8RoJvuDoQa+NTKtjtj4pMz
	+x8bS1T0jxgKrieAIaDXxiOwFORskEpXDnkGq1jztrQdz551XAYNCNyR/l4Pf9J4w/qsX608tVn
	G1dhn2uOUaXkkZvrg6WWyfKPhAEyMuV0gE2BDj2gKntZxv9WLXhF9YeP3oVsG7zmPa3RcsAEo1t
	0g705RZbfRaSVZlAzY2th5iLLPUke+AD8wTm6hkUubUlZO8scupOd1CUN/eI5AmfQk01xA0ouj4
	OS3bjISQSS8zNn6BqZCpoqDTChA92yugkOVYaOr/qAPCe/V5S+2qXNGi5CG+EkCYlUv9R2mcXr8
	=
X-Received: by 2002:a05:6a20:6c89:b0:240:2473:57c5 with SMTP id adf61e73a8af0-240d2ecc720mr11926191637.26.1755496813380;
        Sun, 17 Aug 2025 23:00:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF4/5ZwWb3aSu4+/VV+IMCOaNujyenjSRsaWQTDyn3KCuxRcqSn0UG2QjyzJxk0PnowgcIypg==
X-Received: by 2002:a05:6a20:6c89:b0:240:2473:57c5 with SMTP id adf61e73a8af0-240d2ecc720mr11926156637.26.1755496812913;
        Sun, 17 Aug 2025 23:00:12 -0700 (PDT)
Received: from hu-krichai-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76e45292dc1sm6213571b3a.50.2025.08.17.23.00.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Aug 2025 23:00:12 -0700 (PDT)
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Date: Mon, 18 Aug 2025 11:30:04 +0530
Subject: [PATCH v5] bus: mhi: host: Add support to read MHI capabilities
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250818-mhi_cap-v5-1-5e2d69aa2ace@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIAGPBomgC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyTHUUlJIzE
 vPSU3UzU4B8JSMDI1MDC0ML3dyMzPjkxAJd4ySjpCQDUzMz4zQTJaDqgqLUtMwKsEnRsbW1AAY
 m19VZAAAA
X-Change-ID: 20250818-mhi_cap-3b2bb05663f4
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: mhi@lists.linux.dev, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_vbadigan@quicinc.com,
        quic_mrana@quicinc.com, Vivek Pernamitta <quic_vpernami@quicinc.com>,
        Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1755496810; l=3492;
 i=krishna.chundru@oss.qualcomm.com; s=20230907; h=from:subject:message-id;
 bh=NzrCCHg/7/xjlUJgz4D1POmTqgzev+1R3Ks8F/TGUvE=;
 b=xNJ+4lbMbkZgYrGsa7fqebiMj8syHfu7NiasxU6HiVutBGlIuZfqDT0pvoXBWwS47uUHwlH32
 QwA2RJIxk4CBUtSnlMFZiDsiMqKDINziBXutSQm3YqNpEIvM0F+W7Rq
X-Developer-Key: i=krishna.chundru@oss.qualcomm.com; a=ed25519;
 pk=10CL2pdAKFyzyOHbfSWHCD0X0my7CXxj8gJScmn1FAg=
X-Proofpoint-ORIG-GUID: zo8ZEvzUNIRDKmEycGkeaLUdAauMGO_e
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODE2MDAyMCBTYWx0ZWRfXznvStz2UKUaa
 h+QTSFGyGKnZbWT/4hWJQL9kg5RMXsjxkwfyZffBL5W1f1yesjCgmK0u1+2ZZhjSlv+PYXh4EZ8
 5OFOqaZFLYK/W5NqDj1BKPTtyJTQmsAgabwkn9Q7O1vsV8Uh2bKJg5ncVbeSJyNFf36qA2QEPEk
 2LHRJSidXrNByd3myjWZQX//I3UISuzQfzzL64MjH24LY4jGhu3g7b+++NRnD4I689NwYyKd1BX
 1M6oVIGsw8e2OSS7LhKTrDOhuP1z0aZdDSCiUbiAzEiwvUbgd8j8lygy179Fm4yrxqNrsBiNKkl
 WNTx06gF7utZ+Nx+D6ncIXn189DodzYqSMepJmtdUb+6QCRkDRFoNkpdFEfITUxMfHqoqLCBRkf
 k8GYxFP7
X-Authority-Analysis: v=2.4 cv=a+Mw9VSF c=1 sm=1 tr=0 ts=68a2c173 cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8
 a=rmrCh1LTSIpWmPtgo7UA:9 a=QEXdDO2ut3YA:10 a=zc0IvFSfCIW2DFIPzwfm:22
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: zo8ZEvzUNIRDKmEycGkeaLUdAauMGO_e
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-18_02,2025-08-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 malwarescore=0 suspectscore=0 impostorscore=0 phishscore=0
 adultscore=0 priorityscore=1501 clxscore=1015 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508160020

From: Vivek Pernamitta <quic_vpernami@quicinc.com>

As per MHI spec v1.2,sec 6.6, MHI has capability registers which are
located after the ERDB array. The location of this group of registers is
indicated by the MISCOFF register. Each capability has a capability ID to
determine which functionality is supported and each capability will point
to the next capability supported.

Add a basic function to read those capabilities offsets.

Signed-off-by: Vivek Pernamitta <quic_vpernami@quicinc.com>
Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
---
This patch is required by MHI TSC time sync also, for that reason
sending this seperately.
Changes from v4:
- Removed the le32_to_cpu conversions as these will be taken care by the
readl API's (Mani)
---
 drivers/bus/mhi/common.h    | 13 +++++++++++++
 drivers/bus/mhi/host/init.c | 32 ++++++++++++++++++++++++++++++++
 2 files changed, 45 insertions(+)

diff --git a/drivers/bus/mhi/common.h b/drivers/bus/mhi/common.h
index dda340aaed95a5573a2ec776ca712e11a1ed0b52..58f27c6ba63e3e6fa28ca48d6d1065684ed6e1dd 100644
--- a/drivers/bus/mhi/common.h
+++ b/drivers/bus/mhi/common.h
@@ -16,6 +16,7 @@
 #define MHICFG				0x10
 #define CHDBOFF				0x18
 #define ERDBOFF				0x20
+#define MISCOFF				0x24
 #define BHIOFF				0x28
 #define BHIEOFF				0x2c
 #define DEBUGOFF			0x30
@@ -113,6 +114,9 @@
 #define MHISTATUS_MHISTATE_MASK		GENMASK(15, 8)
 #define MHISTATUS_SYSERR_MASK		BIT(2)
 #define MHISTATUS_READY_MASK		BIT(0)
+#define MISC_CAP_MASK			GENMASK(31, 0)
+#define CAP_CAPID_MASK			GENMASK(31, 24)
+#define CAP_NEXT_CAP_MASK		GENMASK(23, 12)
 
 /* Command Ring Element macros */
 /* No operation command */
@@ -204,6 +208,15 @@
 #define MHI_RSCTRE_DATA_DWORD1		cpu_to_le32(FIELD_PREP(GENMASK(23, 16), \
 							       MHI_PKT_TYPE_COALESCING))
 
+enum mhi_capability_type {
+	MHI_CAP_ID_INTX = 0x1,
+	MHI_CAP_ID_TIME_SYNC = 0x2,
+	MHI_CAP_ID_BW_SCALE = 0x3,
+	MHI_CAP_ID_TSC_TIME_SYNC = 0x4,
+	MHI_CAP_ID_MAX_TRB_LEN = 0x5,
+	MHI_CAP_ID_MAX,
+};
+
 enum mhi_pkt_type {
 	MHI_PKT_TYPE_INVALID = 0x0,
 	MHI_PKT_TYPE_NOOP_CMD = 0x1,
diff --git a/drivers/bus/mhi/host/init.c b/drivers/bus/mhi/host/init.c
index 7f72aab38ce92fea9e875e65c69d9a4714ecbc13..b5f23336eb6afe249c07932bc4182fafdf1f2a19 100644
--- a/drivers/bus/mhi/host/init.c
+++ b/drivers/bus/mhi/host/init.c
@@ -467,6 +467,38 @@ static int mhi_init_dev_ctxt(struct mhi_controller *mhi_cntrl)
 	return ret;
 }
 
+static int mhi_find_capability(struct mhi_controller *mhi_cntrl, u32 capability, u32 *offset)
+{
+	u32 val, cur_cap, next_offset;
+	int ret;
+
+	/* Get the first supported capability offset */
+	ret = mhi_read_reg_field(mhi_cntrl, mhi_cntrl->regs, MISCOFF, MISC_CAP_MASK, offset);
+	if (ret)
+		return ret;
+
+	do {
+		if (*offset >= mhi_cntrl->reg_len)
+			return -ENXIO;
+
+		ret = mhi_read_reg(mhi_cntrl, mhi_cntrl->regs, *offset, &val);
+		if (ret)
+			return ret;
+
+		cur_cap = FIELD_GET(CAP_CAPID_MASK, val);
+		next_offset = FIELD_GET(CAP_NEXT_CAP_MASK, val);
+		if (cur_cap >= MHI_CAP_ID_MAX)
+			return -ENXIO;
+
+		if (cur_cap == capability)
+			return 0;
+
+		*offset = next_offset;
+	} while (next_offset);
+
+	return -ENXIO;
+}
+
 int mhi_init_mmio(struct mhi_controller *mhi_cntrl)
 {
 	u32 val;

---
base-commit: c17b750b3ad9f45f2b6f7e6f7f4679844244f0b9
change-id: 20250818-mhi_cap-3b2bb05663f4

Best regards,
-- 
Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>


