Return-Path: <linux-kernel+bounces-831525-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FC62B9CE70
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 02:33:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 15B9C4A65FC
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 00:33:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E4C62D46D6;
	Thu, 25 Sep 2025 00:32:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="cE7IQikM"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7DF02D3EE4
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 00:32:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758760364; cv=none; b=XAGi1RrOkGabWTMo5uc0akxHM6DAV651fYk0aas31zexztNho1TnVLB1a09L1KFjU9U4KC38VQp74EcVUrafc3pwloyhnsjG6YQaljbW4abJ6UoyazMJmFFItEkOnSGFu90oIs3W3bl6sqoWhnc75/ETdpguvRSvu30+D3NHgCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758760364; c=relaxed/simple;
	bh=gcL/fGPQekLTQNIGUzZcdgTs72eyqB3Ncf8Yq2nY0h4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=V0oHf5NQ1mH/svXkPUwsV/WrQ17CHXl5iimtSchh+YKmNdWUtWuulBUDG/96ZWtHGrWIAp0qnGy9gaHSgtdfqcUcN/vW0jC64XKI118rf6/bfkHIb5FqivQMHjnZER4vT1qk7g1br9qDK62Gh3muoY/XWdtJmMaimFRfNaibCok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=cE7IQikM; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58OCseYd002662
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 00:32:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	25vQWjik0NkorLXRn5b4wPZ1S82r4D/v+C/waXiEV9Q=; b=cE7IQikMprJFp6lZ
	UgXV8X3H3aZY/9riLNEzVUnSqXWZEnLgFoRhtqmrhrQ72KTiebjt1x5Cq5GsZAzm
	Dt3ptqdGOmtIHx+zdRLmGKtAaVPpNGdT6NlktpY9QySW72jImNUru1QeuefMgIGU
	rIzKbbRFVyEuA7He8MfVFiFK7GMflZQO0VnSOjPPYOI7ov/Z+m5N8vDd7q00hnU6
	9hAlwEg8vtCvvcGvwk6ok9ssoS7NYp5n72uGLrEE0lCt2fiJ9c5dDBBEuc8la9Yp
	v5w5HbIpbOCDRfLTclRYgFAFNKXbyFb9yWVr7owh/exBfPDLY+w8zQDT3FIAXJkR
	1RXapA==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49bajf0qny-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 00:32:41 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-817ecd47971so394117885a.0
        for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 17:32:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758760360; x=1759365160;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=25vQWjik0NkorLXRn5b4wPZ1S82r4D/v+C/waXiEV9Q=;
        b=OrX83Xj0MSDex7gAc9GJBAOEdGwlNZyKwZyGbZ5UL5tDxt4PbY+1LV/NpoPGBrdMUy
         o8Xq9WM/C4InD4tU3V2cpQU+HTauOQlORnw/2KxR5U9kv7wU8rLRtj1aWpTev0JB6Fjl
         +tg9HEom1bXHRlZUpwW+QXeVwDgWOvxIhX1VrdtaEiggXF2tZdkmxZHMWNUqpItTaVnD
         +llABwbEEkm0tOgcN+0jonMPOLxHZNAdXEEWN+YZUku5MX9BFZs1WnmPnso3HI5GN3je
         eSS9Lg4YTUZv9HBJr3i7WYD8SiSqDQUKU778NysL21FZfb4bSNeCnguquFXDtpjrQ2JR
         acyw==
X-Gm-Message-State: AOJu0Yz3ec5DjbGdrJdoVD8kufQArP3vqIycFLmeHbTi4E2qgMky3EAK
	LV6x4BUNeK2wq0v1JzNPs56VCAWFr8Zzdg+dS3x/aNFER3gd4xGsN04uS6PEDIIMMPgnWHZkD1s
	qpxVBTYk4DGWFTmNqe1h326SbGez391xKFALXqJfoYa6uu06gwumMVodstdn4Il6PNSs=
X-Gm-Gg: ASbGncvUvVPzHUW802gFCe9uiWAnD1sJ6E1/ek/6UpDlrFfebKfLvnZKmERMvemu08Q
	5GYKpQ38iNSuMEnAAMU+Y9npwtXcklqV1Yq4TqYYdDsyYYKBuaoPlsmY0ddjrGiNP3BWHrwOcsE
	V00FUXOKRL0DbTHFTZpOTNkXCG6rQbgzrQo42aCNp3FV1g1p+5wLhXIvnUKD4S9XRFVH28FN4d7
	jgO5r+XliC0RkwgYe0uMKFZpHg0aTkM9XmEHB8wdPxfUwXjzspZXojFaa9TWJdqXo+JgqzjD9M4
	rH0ET7Qa87kftyNmhrNneAKC54TtTzK9DF+AB4H8GXwyC6FqAKhoyWjLgLW8Xc6/GRpu5JxZ7LH
	rjI4T47denhNEZYKAkMZAUexhrc1rJMw=
X-Received: by 2002:a05:620a:8086:b0:858:7b81:330d with SMTP id af79cd13be357-85bc193e680mr115419685a.3.1758760360320;
        Wed, 24 Sep 2025 17:32:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IENLcPXmOhdL6ZhjGn1eZG+iWuGUyv1RQeGt0nmArM641SCP6fUyjPgICIPEVuxguDYt6i8lw==
X-Received: by 2002:a05:620a:8086:b0:858:7b81:330d with SMTP id af79cd13be357-85bc193e680mr115415585a.3.1758760359772;
        Wed, 24 Sep 2025 17:32:39 -0700 (PDT)
Received: from WENMLIU-LAB01.ap.qualcomm.com (Global_NAT1_IAD_FW.qualcomm.com. [129.46.232.65])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4db10872687sm1774501cf.28.2025.09.24.17.32.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Sep 2025 17:32:38 -0700 (PDT)
From: Wenmeng Liu <wenmeng.liu@oss.qualcomm.com>
Date: Thu, 25 Sep 2025 08:32:00 +0800
Subject: [PATCH v4 2/3] media: qcom: camss: Add link support for TPG common
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250925-camss_tpg-v4-2-d2eb099902c8@oss.qualcomm.com>
References: <20250925-camss_tpg-v4-0-d2eb099902c8@oss.qualcomm.com>
In-Reply-To: <20250925-camss_tpg-v4-0-d2eb099902c8@oss.qualcomm.com>
To: Robert Foss <rfoss@kernel.org>, Todor Tomov <todor.too@gmail.com>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Wenmeng Liu <wenmeng.liu@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1758760347; l=7448;
 i=wenmeng.liu@oss.qualcomm.com; s=20250925; h=from:subject:message-id;
 bh=gcL/fGPQekLTQNIGUzZcdgTs72eyqB3Ncf8Yq2nY0h4=;
 b=/gaVAmZ54Sdv0l7nUfaPtCfdWc0f0gdGkZbTAKHvTqv7v+nCW2JjBTmj7NtX+OEP4YMtS1UkS
 78d/wCN3+8mAMKG7zR9t5dtSUISEKcrMS4S/JiM5uCNY8T2ST68q6C+
X-Developer-Key: i=wenmeng.liu@oss.qualcomm.com; a=ed25519;
 pk=fQJjf9C3jGDjE1zj2kO3NQLTbQEaZObVcXAzx5WLPX0=
X-Proofpoint-GUID: n2Bl5HIdF-s9i6mD-rZHl2FCQauss4DT
X-Authority-Analysis: v=2.4 cv=fY2ty1QF c=1 sm=1 tr=0 ts=68d48da9 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=C3Dk8TwHQYyIj7nOf9RCJw==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=D-OMaI2VJto731AKaP4A:9
 a=QEXdDO2ut3YA:10 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIyMDE2OCBTYWx0ZWRfXyHFAH+UPj9Lv
 TJz+ZWcBKKJhYK3N6/bEs/zDP+w4w/OVaL6rUqWRr6mShKHh9ZNI/4BV73EbgjSr6H3tCeqZjmd
 NQduSM9TmYWR7YwvtsBvtuq8DJe4ATbTDFZQ9lO6ZtHEmIXTiEOsU3Dg++uF5D7hLgBHP8GnMIm
 8tAoLsR5F+t6v3NPUDr1ykSZaos9nGgvXxJXsU7rGKQc5GxFH5xKtFLJo8e9oTJrBfsbyziV2Xd
 D687JycT5vgTJ+148h61FTKJpGttsxhjn1CYrt7hKL3FGUoQBJpM9tUdJjwFFZqsIvbRMgLK8hT
 HQXb1xk+LkVe+arWypqKguQApfwKwSZR56oXQtwOV5jCvP6Lctl3d1lEwval/UZH0lKaefItHLj
 DUH5f59U
X-Proofpoint-ORIG-GUID: n2Bl5HIdF-s9i6mD-rZHl2FCQauss4DT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-24_07,2025-09-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 spamscore=0 adultscore=0 impostorscore=0
 phishscore=0 bulkscore=0 priorityscore=1501 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509220168

TPG is connected to the csid as an entity, the link
needs to be adapted.

Signed-off-by: Wenmeng Liu <wenmeng.liu@oss.qualcomm.com>
---
 drivers/media/platform/qcom/camss/camss-csid.c   | 43 +++++++++++++-------
 drivers/media/platform/qcom/camss/camss-csiphy.c |  1 +
 drivers/media/platform/qcom/camss/camss-csiphy.h |  2 +
 drivers/media/platform/qcom/camss/camss.c        | 52 ++++++++++++++++++++++++
 4 files changed, 84 insertions(+), 14 deletions(-)

diff --git a/drivers/media/platform/qcom/camss/camss-csid.c b/drivers/media/platform/qcom/camss/camss-csid.c
index 5284b5857368c37c202cd89dad6ae8042b637537..196cbc0b60e9bf95a06b053c69c967e345ffcd4b 100644
--- a/drivers/media/platform/qcom/camss/camss-csid.c
+++ b/drivers/media/platform/qcom/camss/camss-csid.c
@@ -35,6 +35,8 @@
 #define		HW_VERSION_REVISION	16
 #define		HW_VERSION_GENERATION	28
 
+#define LANE_CFG_BITWIDTH 4
+
 #define MSM_CSID_NAME "msm_csid"
 
 const char * const csid_testgen_modes[] = {
@@ -1227,18 +1229,22 @@ void msm_csid_get_csid_id(struct media_entity *entity, u8 *id)
 }
 
 /*
- * csid_get_lane_assign - Calculate CSI2 lane assign configuration parameter
- * @lane_cfg - CSI2 lane configuration
+ * csid_get_lane_assign - Calculate lane assign by csiphy/tpg lane num
+ * @num: lane num
+ * @pos_array: Array of lane positions
  *
  * Return lane assign
  */
-static u32 csid_get_lane_assign(struct csiphy_lanes_cfg *lane_cfg)
+static u32 csid_get_lane_assign(int num, struct csiphy_lanes_cfg *lane_cfg)
 {
 	u32 lane_assign = 0;
+	int pos;
 	int i;
 
-	for (i = 0; i < lane_cfg->num_data; i++)
-		lane_assign |= lane_cfg->data[i].pos << (i * 4);
+	for (i = 0; i < num; i++) {
+		pos = lane_cfg ? lane_cfg->data[i].pos : i;
+		lane_assign |= pos << (i * LANE_CFG_BITWIDTH);
+	}
 
 	return lane_assign;
 }
@@ -1266,6 +1272,7 @@ static int csid_link_setup(struct media_entity *entity,
 		struct csid_device *csid;
 		struct csiphy_device *csiphy;
 		struct csiphy_lanes_cfg *lane_cfg;
+		struct tpg_device *tpg;
 
 		sd = media_entity_to_v4l2_subdev(entity);
 		csid = v4l2_get_subdevdata(sd);
@@ -1277,18 +1284,26 @@ static int csid_link_setup(struct media_entity *entity,
 			return -EBUSY;
 
 		sd = media_entity_to_v4l2_subdev(remote->entity);
-		csiphy = v4l2_get_subdevdata(sd);
+		if (sd->grp_id == TPG_GUP_ID) {
+			tpg = v4l2_get_subdevdata(sd);
 
-		/* If a sensor is not linked to CSIPHY */
-		/* do no allow a link from CSIPHY to CSID */
-		if (!csiphy->cfg.csi2)
-			return -EPERM;
+			csid->phy.lane_cnt = tpg->res->lane_cnt;
+			csid->phy.csiphy_id = tpg->id;
+			csid->phy.lane_assign = csid_get_lane_assign(csid->phy.lane_cnt, NULL);
+		} else {
+			csiphy = v4l2_get_subdevdata(sd);
 
-		csid->phy.csiphy_id = csiphy->id;
+			/* If a sensor is not linked to CSIPHY */
+			/* do no allow a link from CSIPHY to CSID */
+			if (!csiphy->cfg.csi2)
+				return -EPERM;
 
-		lane_cfg = &csiphy->cfg.csi2->lane_cfg;
-		csid->phy.lane_cnt = lane_cfg->num_data;
-		csid->phy.lane_assign = csid_get_lane_assign(lane_cfg);
+			csid->phy.csiphy_id = csiphy->id;
+
+			lane_cfg = &csiphy->cfg.csi2->lane_cfg;
+			csid->phy.lane_cnt = lane_cfg->num_data;
+			csid->phy.lane_assign = csid_get_lane_assign(lane_cfg->num_data, lane_cfg);
+		}
 	}
 	/* Decide which virtual channels to enable based on which source pads are enabled */
 	if (local->flags & MEDIA_PAD_FL_SOURCE) {
diff --git a/drivers/media/platform/qcom/camss/camss-csiphy.c b/drivers/media/platform/qcom/camss/camss-csiphy.c
index 2de97f58f9ae4f91e8bba39dcadf92bea8cf6f73..680580d7fe46a215777f3fa1b347f4297deea024 100644
--- a/drivers/media/platform/qcom/camss/camss-csiphy.c
+++ b/drivers/media/platform/qcom/camss/camss-csiphy.c
@@ -799,6 +799,7 @@ int msm_csiphy_register_entity(struct csiphy_device *csiphy,
 	sd->flags |= V4L2_SUBDEV_FL_HAS_DEVNODE;
 	snprintf(sd->name, ARRAY_SIZE(sd->name), "%s%d",
 		 MSM_CSIPHY_NAME, csiphy->id);
+	sd->grp_id = CSIPHY_GUP_ID;
 	v4l2_set_subdevdata(sd, csiphy);
 
 	ret = csiphy_init_formats(sd, NULL);
diff --git a/drivers/media/platform/qcom/camss/camss-csiphy.h b/drivers/media/platform/qcom/camss/camss-csiphy.h
index 895f80003c441dcacf98435f91567f90afa29279..b7bcf2bdd2124f77b5354b15b33aa1e0983143e8 100644
--- a/drivers/media/platform/qcom/camss/camss-csiphy.h
+++ b/drivers/media/platform/qcom/camss/camss-csiphy.h
@@ -21,6 +21,8 @@
 #define MSM_CSIPHY_PAD_SRC 1
 #define MSM_CSIPHY_PADS_NUM 2
 
+#define CSIPHY_GUP_ID 1
+
 struct csiphy_lane {
 	u8 pos;
 	u8 pol;
diff --git a/drivers/media/platform/qcom/camss/camss.c b/drivers/media/platform/qcom/camss/camss.c
index 2fbcd0e343aac9620a5a30719c42e1b887cf34ed..2ede19e1347ae32f2f6919905b535352bcd134be 100644
--- a/drivers/media/platform/qcom/camss/camss.c
+++ b/drivers/media/platform/qcom/camss/camss.c
@@ -3691,6 +3691,19 @@ static int camss_init_subdevices(struct camss *camss)
 		}
 	}
 
+	if (camss->tpg) {
+		for (i = 0; i < camss->res->tpg_num; i++) {
+			ret = msm_tpg_subdev_init(camss, &camss->tpg[i],
+						  &res->tpg_res[i], i);
+			if (ret < 0) {
+				dev_err(camss->dev,
+					"Failed to init tpg%d sub-device: %d\n",
+					i, ret);
+				return ret;
+			}
+		}
+	}
+
 	/* note: SM8250 requires VFE to be initialized before CSID */
 	for (i = 0; i < camss->res->vfe_num; i++) {
 		ret = msm_vfe_subdev_init(camss, &camss->vfe[i],
@@ -3779,6 +3792,23 @@ static int camss_link_entities(struct camss *camss)
 		}
 	}
 
+	for (i = 0; i < camss->res->tpg_num; i++) {
+		for (j = 0; j < camss->res->csid_num; j++) {
+			ret = media_create_pad_link(&camss->tpg[i].subdev.entity,
+						    MSM_TPG_PAD_SRC,
+						    &camss->csid[j].subdev.entity,
+						    MSM_CSID_PAD_SINK,
+						    0);
+			if (ret < 0) {
+				camss_link_err(camss,
+					       camss->tpg[i].subdev.entity.name,
+					       camss->csid[j].subdev.entity.name,
+					       ret);
+				return ret;
+			}
+		}
+	}
+
 	if (camss->ispif) {
 		for (i = 0; i < camss->res->csid_num; i++) {
 			for (j = 0; j < camss->ispif->line_num; j++) {
@@ -3883,6 +3913,19 @@ static int camss_register_entities(struct camss *camss)
 		}
 	}
 
+	if (camss->tpg) {
+		for (i = 0; i < camss->res->tpg_num; i++) {
+			ret = msm_tpg_register_entity(&camss->tpg[i],
+						      &camss->v4l2_dev);
+			if (ret < 0) {
+				dev_err(camss->dev,
+					"Failed to register tpg%d entity: %d\n",
+					i, ret);
+				goto err_reg_tpg;
+			}
+		}
+	}
+
 	for (i = 0; i < camss->res->csid_num; i++) {
 		ret = msm_csid_register_entity(&camss->csid[i],
 					       &camss->v4l2_dev);
@@ -3926,6 +3969,10 @@ static int camss_register_entities(struct camss *camss)
 	for (i--; i >= 0; i--)
 		msm_csid_unregister_entity(&camss->csid[i]);
 
+	i = camss->res->tpg_num;
+err_reg_tpg:
+	for (i--; i >= 0; i--)
+		msm_tpg_unregister_entity(&camss->tpg[i]);
 	i = camss->res->csiphy_num;
 err_reg_csiphy:
 	for (i--; i >= 0; i--)
@@ -3947,6 +3994,11 @@ static void camss_unregister_entities(struct camss *camss)
 	for (i = 0; i < camss->res->csiphy_num; i++)
 		msm_csiphy_unregister_entity(&camss->csiphy[i]);
 
+	if (camss->tpg) {
+		for (i = 0; i < camss->res->tpg_num; i++)
+			msm_tpg_unregister_entity(&camss->tpg[i]);
+	}
+
 	for (i = 0; i < camss->res->csid_num; i++)
 		msm_csid_unregister_entity(&camss->csid[i]);
 

-- 
2.34.1


