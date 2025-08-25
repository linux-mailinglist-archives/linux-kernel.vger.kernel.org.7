Return-Path: <linux-kernel+bounces-784932-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 47130B3439F
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 16:26:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5C4811881E4E
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 14:26:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 653D926F2BF;
	Mon, 25 Aug 2025 14:19:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Bhue0yg5"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CC453090C2
	for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 14:19:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756131586; cv=none; b=PKkxIqv7Bcu0XoEGhzRP/YxVknDLCqpgyLlC59Lp7ekvk6IF4VIeNvXAyHjjpl7L6PSe4U84odHUZ36lEjVdq/n4Gtck2BCAtqGeZ3bPVruJuLpE78UA+3GrgVhp+HEl95QOmsZyRey4u+MAPSID9/Q71pIfc2/my6w8VSONvvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756131586; c=relaxed/simple;
	bh=mHMs9rQvBxpZb1gSSofJaWBlOYD/Q406IEbVvBakP40=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FRaGcc2EuiwE7Fi4XzFv0pyf4sntlsISMAnWZaX0kJuCckutKlTj4YPzoBxkKa61DH8vvYbT/CkPA6ekVpBBUnsBsJ/S2oZ6auKIOLmI7eJDNZ8ZYAkebripnFYDnrIh1UL9frmoHe+MLCTIFSp5/Px/tNeDVj9+lfTPy7Q4LGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Bhue0yg5; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57P8MF1a004082
	for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 14:19:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	CF1VNUZFWAoTkwVdcq3ZpR3SjUV1mxisKlAEosuGRMI=; b=Bhue0yg5FDRIXFC1
	wPqcZv/YSp/WB76gmJD0u2KYBaIlqhvsXdxjnokaAoRN+xYOLpsmgjypizHBSEZn
	J0d3TBoBPuqncIaHrdxoMts0M7c1/TfUS2PvJrCVMB3YshDS5iocP3h0qjEQnhQD
	BsISUmT5nDv4G8tRcMEyONWeKjdyjfDc0KWQfxsCrhFRR8jiqV3k10FDv+EHkUvD
	UI4JzMDn6H6gL+A+sSreOtiPt2R70EcDuYvTYIa/IWHhmyTnmVhsU6YT4GZcPw5R
	HbO4qXx61xDrtLb6QR457FDDQHde/qlX+abpuPSpzdQaU9TGXnsmJrjR/hgquUWA
	Ji001w==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48q5xpnf2m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 14:19:41 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-76e2eb787f2so4615350b3a.3
        for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 07:19:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756131580; x=1756736380;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CF1VNUZFWAoTkwVdcq3ZpR3SjUV1mxisKlAEosuGRMI=;
        b=sjMLYbayROQjdyc/LrmuQ9m9VlRkaSVtRoEqXhIHo0UPbxfVnsPV7DfHGhSlRm/64p
         BU7znFcbDMcaWYPOZ3Tu3przAzpTI6fYxqTLlRfGubBhNCRNNWNi38b0/pcfQhzPy7o/
         PPvthmhx3a8KZudT+wzS7pyGVeuNAdHfeCz1VZaw6qLx5mre4Ot72lGbpmRsIk5LgE3Y
         wYlAkXxAO3LJDFf3uNXPS2wnNuEF/wkOWMxtF4qJtsvhGPidBTOmAoNnXoj3UK9jKQce
         GjoIAzv8A1MJvy+d5N3nHnIrKlt2rWwBkGJpVEAVlegBxntAjKUb1DbWPNgEPqifhi7S
         +LzQ==
X-Forwarded-Encrypted: i=1; AJvYcCWYHIkNd/aQPqVcBQZfZrAT+6hQxUyO1wWClcqYOiXrpRxZb1AUbnujChgBabrbXA0BWk/R6LtP7kBn+Sc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwuRuKoT2Dn71oMDWXt4ToQwDiqNAF44n2usTbhFyByKPL8dCNw
	che5iqiWhO3f9OMJiGkhRoUxQeVDh7S14dak6LYqSNy2mmiJSCG4RVstyMNkJd525nwUjKrbpWd
	s5X5e7aCYvsFVz6Gmm43vAGK0Sg5baMHrQcOLPnY3JWOPm+uxFQrxorM/XON8mTWkD7k=
X-Gm-Gg: ASbGncuASAJg+NmQ4y7+K8b24E2/MpdITDgk/apwOVpNweKQr74KX3Z1sB9Qzk5kd4R
	YE46yOGT3omVXX7oIkR8GkaHZd/OPnug3499umDs3VpGpiwtkGmagFZmnMvHkHq7YPDjyCbW+/r
	3ryT1rZCeZVOE6grWaCYGfuq830i28dtfwDsq80SHAaCfgjEe2afni599aQT5ZpNyTqru17os7E
	6XvLpzdWbk4JdCvsCB608tuuneGbMXxpsMt0/2osJpW0OCEnnn2WV8pirrSO/ChnxDVy+F4oVhV
	z+ew8JoNs2sAXBCWU/34uBcp4DFcA27TdW5TpG5f1VBFYm6HR6RzcDnAJ2Jhg/rA04fxdiY=
X-Received: by 2002:a05:6a20:a10e:b0:23f:f5bf:35d7 with SMTP id adf61e73a8af0-24340dc88cemr18191272637.45.1756131580381;
        Mon, 25 Aug 2025 07:19:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFPAmA6KgMGWrk9NgRt8J2RIgsVMiMidd+39K0LNZbVzR37+jqMhfxfP0sgzD6hGlVlZlnp7g==
X-Received: by 2002:a05:6a20:a10e:b0:23f:f5bf:35d7 with SMTP id adf61e73a8af0-24340dc88cemr18191190637.45.1756131579394;
        Mon, 25 Aug 2025 07:19:39 -0700 (PDT)
Received: from cse-cd01-lnx.ap.qualcomm.com ([114.94.8.21])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-770401eb20dsm7672339b3a.79.2025.08.25.07.19.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Aug 2025 07:19:39 -0700 (PDT)
From: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
Date: Mon, 25 Aug 2025 22:16:22 +0800
Subject: [PATCH v3 36/38] drm/msm/dpu: use msm_dp_get_mst_intf_id() to get
 the intf id
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250825-msm-dp-mst-v3-36-01faacfcdedd@oss.qualcomm.com>
References: <20250825-msm-dp-mst-v3-0-01faacfcdedd@oss.qualcomm.com>
In-Reply-To: <20250825-msm-dp-mst-v3-0-01faacfcdedd@oss.qualcomm.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Jessica Zhang <jessica.zhang@oss.qualcomm.com>,
        Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Yongxing Mou <yongxing.mou@oss.qualcomm.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1756131424; l=3583;
 i=yongxing.mou@oss.qualcomm.com; s=20241121; h=from:subject:message-id;
 bh=uY2Iv++yN1m/94AgtNBgb5m01vTsGsicz0WYoBHYze0=;
 b=7yeZmvLqu/95G3RjFS9sZCcTWmjF6qHI1lm/pJRJHhLnmxHSYXpzgCI7P7hY0zP6dSheSEsyL
 HbjSfT6HzE4BwEVbOLkw7S5Iw7pEiOG3mPahNG+AH4mt5E0PZdjA6nW
X-Developer-Key: i=yongxing.mou@oss.qualcomm.com; a=ed25519;
 pk=zeCnFRUqtOQMeFvdwex2M5o0Yf67UHYfwCyBRQ3kFbU=
X-Authority-Analysis: v=2.4 cv=KOlaDEFo c=1 sm=1 tr=0 ts=68ac70fd cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=Uz3yg00KUFJ2y2WijEJ4bw==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8
 a=73Fxo_05DylMrM8smIAA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=IoOABgeZipijB_acs4fv:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: IRkUiIWgj0__PVBKk5wpjuRlM-CEjhNv
X-Proofpoint-ORIG-GUID: IRkUiIWgj0__PVBKk5wpjuRlM-CEjhNv
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIzMDAzMyBTYWx0ZWRfX0YUyv7AXLidd
 hMxnmVNCVV/t2JRrFJ3maGqKm8QAc1mDEOhCytns4e/sG10jd55zT/fjPU+hhQNlNXnUIJ7dOD1
 ZpWEjeEff8dkw4MCpOMBBg/tNpMqVzYNzKR4aTtaMiHCrDlf7EXHSWEIjDiTC+o0Y1MGQAbKT5B
 biI6pgxXtBq0dx2ag5tSKROZL2zjA/nVglXWV1iue9zQkDqIcHA0B6vnlw/PF+NR+WHVhfgMW2c
 s2XD1YM4HPIQtX/2sWQ0402lYU3V/fa20QBMKu0LnhOXbM0vTrgbGQOTK11Glowk9WnOJsE6sjq
 H20OVPZui27b9PeQXM8kRhDaW7OTMPfvOS1LSd6wmmgb3+V1KVV7YsUwAQWR98gyCa5p7tT0r8B
 pBZRmGiV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-25_07,2025-08-20_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015 bulkscore=0 adultscore=0 phishscore=0
 impostorscore=0 spamscore=0 suspectscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508230033

From: Abhinav Kumar <quic_abhinavk@quicinc.com>

Use msm_dp_get_mst_intf_id() to get the interface ID for the DP MST
controller as the intf_id is unique for each MST stream of each
DP controller.

Signed-off-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c | 51 +++++++++++++++++++++++++----
 1 file changed, 44 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
index 05e5f3463e30c9a6bd5b740580720ae2bf6b3246..2eb5397d15732b224372c68d0b2b7167da9f2896 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
@@ -1429,17 +1429,52 @@ static void dpu_encoder_virt_atomic_disable(struct drm_encoder *drm_enc,
 
 static struct dpu_hw_intf *dpu_encoder_get_intf(const struct dpu_mdss_cfg *catalog,
 		struct dpu_rm *dpu_rm,
-		enum dpu_intf_type type, u32 controller_id)
+		enum dpu_intf_type type, int enc_type, u32 id)
 {
-	int i = 0;
+	int i = 0, cnt = 0;
+	int controller_id = id >> 16;
+	int stream_id = id & 0x0F;
 
 	if (type == INTF_WB)
 		return NULL;
 
-	for (i = 0; i < catalog->intf_count; i++) {
-		if (catalog->intf[i].type == type
-		    && catalog->intf[i].controller_id == controller_id) {
-			return dpu_rm_get_intf(dpu_rm, catalog->intf[i].id);
+	if (enc_type == DRM_MODE_ENCODER_DPMST) {
+		/* The intf order in dpu_intf_cfg matches the mapping in the DP HPG.
+		 * example:
+		 * DPU_8_4_0 - DP Controller intf to stream Mapping
+		 *
+		 * +-------------+----------+----------+----------+----------+
+		 * | stream_id   |    0     |    1     |    2     |    3     |
+		 * +-------------+----------+----------+----------+----------+
+		 * | DP0         | INTF_0   | INTF_3   | INTF_6   | INTF_7   |
+		 * | DP1         | INTF_4   | INTF_8   |          |          |
+		 * +-------------+----------+----------+----------+----------+
+		 *
+		 * DPU_9_2_0 - DP Controller intf to stream Mapping
+		 *
+		 * +-------------+----------+----------+
+		 * | Controller  |    0     |    1     |
+		 * +-------------+----------+----------+
+		 * | DP0         | INTF_0   | INTF_3   |
+		 * | DP1         | INTF_4   | INTF_8   |
+		 * | DP2         | INTF_6   | INTF_7   |
+		 * +-------------+----------+----------+
+		 */
+		DPU_DEBUG("controller_id %d for stream_id = %d\n", controller_id, stream_id);
+		for (i = 0; i < catalog->intf_count; i++) {
+			if (catalog->intf[i].type == INTF_DP
+			&& controller_id == catalog->intf[i].controller_id) {
+				if (cnt == stream_id)
+					return dpu_rm_get_intf(dpu_rm, catalog->intf[i].id);
+				cnt++;
+			}
+		}
+	} else {
+		for (i = 0; i < catalog->intf_count; i++) {
+			if (catalog->intf[i].type == type
+			&& catalog->intf[i].controller_id == controller_id) {
+				return dpu_rm_get_intf(dpu_rm, catalog->intf[i].id);
+			}
 		}
 	}
 
@@ -2670,7 +2705,9 @@ static int dpu_encoder_setup_display(struct dpu_encoder_virt *dpu_enc,
 
 		phys_params.hw_intf = dpu_encoder_get_intf(dpu_kms->catalog, &dpu_kms->rm,
 							   disp_info->intf_type,
-							   controller_id);
+							   dpu_enc->base.encoder_type,
+							   controller_id << 16
+							   | disp_info->stream_id);
 
 		if (disp_info->intf_type == INTF_WB && controller_id < WB_MAX)
 			phys_params.hw_wb = dpu_rm_get_wb(&dpu_kms->rm, controller_id);

-- 
2.34.1


