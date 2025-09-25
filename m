Return-Path: <linux-kernel+bounces-831886-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DF7E5B9DCF0
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 09:09:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C9F131BC2A01
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 07:09:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F6842EC08C;
	Thu, 25 Sep 2025 07:07:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="mMGpCaAJ"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F6F62EA754
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 07:06:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758784021; cv=none; b=rnUyd6tavwCt1B/ZA0qpv6CkRBz3CYUuT/FwJu8SBANwoh0I+0aM7NeFGxYvKMiICY78BG0T05sAuDhp61PrYAdHqeoAZvcsXkfCfoBtvMow/9lguwiwPa7A/5N/m9gzM5Jch0Qh8ohFleDMOh/uopD2RK9bQ4raxXNwzfb18Ww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758784021; c=relaxed/simple;
	bh=MBFao/DJ+AvQFYkIXOckenkzKbeQrB9uXWrKsMRXuzM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FFwIjZGAMtSISfj4T4R7T9Nufxnnb4ZO0fKsV8jjeP266tLllNoIEazkDgj/rdHbvwyjDb5ohgNFSy6lJ1l0Y2MgsmZ+rweazSIFThvQQ668lOsfBlghCNhjfr3GW1+wmDnjO3PWnvd5LaWQKogN3V4MHiM669X+7uilfdo+KYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=mMGpCaAJ; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58P0uuqV018200
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 07:06:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	U/ewAsdzTC0PEPN+SodRZso/2oAjrX6us73TZlYVliA=; b=mMGpCaAJo7kAEKW3
	4Rz1d3MIekz/Se5y7db3XavqVR6R8YnFUxdyAFBqP9qIkb6cREra3l6beejY9VRR
	O2lbD6Uf3ybNancu3Bh4hgnhI8zX5X8P/0Lw6HxObKEzn8fVEZCdAJGn6o3D8uCv
	ejUolD7VKIFOd45nHqqRYl2hfIMVoOHjJCfsWY30uU+3022qTY3ehFa8GU6LIvy/
	ebZSIvA0JjW3FimFhZ9JXCComSx1wFvW7dLRCeQkyh2jzQjaP1WRezUpMQPtBYJf
	tZ8CfWI757gNu9hP9qcXRbBH/h658H4CbLMIv1IyCWmRLfoSAHkY9ZWmv9Nw5L7J
	BoZwOw==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49b3kkb3u9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 07:06:58 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-32ed9dbba55so191592a91.2
        for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 00:06:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758784017; x=1759388817;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U/ewAsdzTC0PEPN+SodRZso/2oAjrX6us73TZlYVliA=;
        b=OQcCM01usKhSCRjLftAGNxZAjydMlT8Hk3syJOAvCCebRz/QkakFYxWyPr0gwvOqpu
         AUY428y2Zqbnqids1yAeINQzj13hebbZsxOrS0eED902xxhflwV/s5EBf4PABKrQ71B6
         TC8EjsTfgeCWi19Ytbg+xCylmZ9HcVv881dXlNTfr/4wvhd1OpiPx+xC4J4d+Us6DuOq
         ki8HOyHs1g73h/IjQa6Cjo2BAfendmkXNo8aOSrPvoL0ISnhleXWYa6NUnTVEylEZNQC
         UbYPqjfqFIIpowPUyx7hRvKbYtzM7FnzQY8ffkcLCQ03Da3tbTyOkx06i84VYBbaA/i3
         QaYw==
X-Forwarded-Encrypted: i=1; AJvYcCXVDH1FEX+5Hk2fqEGQJZxRb6uFewjZaM+a2uAGiBAUT1YGyXUemh3tRW9hYpueRexQu+Vv26J60bdRfNQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzsAGf3gJvPZGU1gTUOeWUsGr5rCxLrZs8n+CbM/Vy8sQ84FTFh
	RHUnXkx5HyuwaBAiqaNA8K8Tft1itJ0U4SEyKZVi7UTHnaMetOJT19wPzAxKS2xk8dtBbn7989g
	c42vgXDJO60C5fNzq5IhYJAyLR6+l7i5C0uHuAdLXXt9Xnd5CmL+vc4ATvg3frKefv6U=
X-Gm-Gg: ASbGncv8JOt9LK2n9Cj95XgoFTcgbiMphQU3fry3Ehk4vBVBxDplJWb1uZVFt5VkaKq
	9Rb7To53GPEZktveQArcmIkezfs0RGlZuYeD2EtvpOo90YbVr2IZ8zJ/jp+FyA+bBqFnn0/Uiqr
	pHFQO3pyKPv05UJA47kiUq17mI5v4UA4PH9u2zSLdNOGJY6x4EX604LR3TJUwoTfugRoBdQEBUh
	Q2HA95RRPdfSuBaZPcvvEpia+kQJyGnKI92AWrH7BMtolCmaXIOK/o3nwpF0wPSntwDGhd8ILPJ
	9jvQcrhazFSKqlpVJze6KMj9LAMm/wJndcgM8AOvQC2vKKXNEOXODHMBAsLzBTjeQMb4Kpl9RH9
	tvE6s5BcTdB5waawHqoZqwtmsILaztK8PEQKv8ttRB4lC7j8RE/KJ9vQZ
X-Received: by 2002:a17:90b:1d0d:b0:330:68e3:ce7e with SMTP id 98e67ed59e1d1-3342a230ddcmr1393208a91.2.1758784017012;
        Thu, 25 Sep 2025 00:06:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEydyBxQvXFLvLbGCWUVusQvnXuEZsG7rVXNdU7irf5Kov39+iOrak8phy/uzwVcIMlnzogKQ==
X-Received: by 2002:a17:90b:1d0d:b0:330:68e3:ce7e with SMTP id 98e67ed59e1d1-3342a230ddcmr1393166a91.2.1758784016593;
        Thu, 25 Sep 2025 00:06:56 -0700 (PDT)
Received: from sziotdisp01-gv.qualcomm.com.ap.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3342a2bd584sm914253a91.0.2025.09.25.00.06.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Sep 2025 00:06:56 -0700 (PDT)
From: Xiangxu Yin <xiangxu.yin@oss.qualcomm.com>
Date: Thu, 25 Sep 2025 15:05:00 +0800
Subject: [PATCH v6 14/14] drm/msm/dp: Add support for lane mapping
 configuration
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250925-add-displayport-support-for-qcs615-platform-v6-14-419fe5963819@oss.qualcomm.com>
References: <20250925-add-displayport-support-for-qcs615-platform-v6-0-419fe5963819@oss.qualcomm.com>
In-Reply-To: <20250925-add-displayport-support-for-qcs615-platform-v6-0-419fe5963819@oss.qualcomm.com>
To: Vinod Koul <vkoul@kernel.org>, Kishon Vijay Abraham I <kishon@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Rob Clark <robin.clark@oss.qualcomm.com>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Jessica Zhang <jessica.zhang@oss.qualcomm.com>,
        Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        fange.zhang@oss.qualcomm.com, yongxing.mou@oss.qualcomm.com,
        li.liu@oss.qualcomm.com,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Xiangxu Yin <xiangxu.yin@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1758783911; l=5055;
 i=xiangxu.yin@oss.qualcomm.com; s=20241125; h=from:subject:message-id;
 bh=MBFao/DJ+AvQFYkIXOckenkzKbeQrB9uXWrKsMRXuzM=;
 b=YZKXR2CUgP470JDI7PJrgUO29J0aV1Yic0DGd9ehh5weifTEt5JJWmf+3GOoo3E2tGiGMEgMj
 6544KOTHvvyBOCE2TTE4IquwBx+8p6+dceUEZ6AHk2AYuDxi5cPfytC
X-Developer-Key: i=xiangxu.yin@oss.qualcomm.com; a=ed25519;
 pk=F1TwipJzpywfbt3n/RPi4l/A4AVF+QC89XzCHgZYaOc=
X-Proofpoint-GUID: zwKenqmlHyFJvTfyQVrKkr48EY2q98WZ
X-Proofpoint-ORIG-GUID: zwKenqmlHyFJvTfyQVrKkr48EY2q98WZ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIyMDA4OSBTYWx0ZWRfX0fNMsU0uKtvs
 En6UX0aw628TDUhLs9us4B2XSiUWhtJskC4fBE9g3AZ3x7/NzJVg5zbtVwrX5IjMW4FK9tFhFO2
 jwNE/PWgLi2cdmIzL63aqcB9x+fR0Xjaf80Z2YISFabgcTZEG7ZVCpszUIOzyeo0qUlhoMzixur
 PmZR1ZZDzvHrxbv7/gEf1Gf4lnmYl3OcXpzDsfrs4l2PWjID3k2aZchwkbyYWEZ9A0PwxG6hZX2
 VkBq235c7lvyV78uJQ/QDCufKDhkqku41Ei282lXPQI480B3a5sGDXMNe7jpgS/XiX2eOXc9ZiO
 RY9p6fPGrdpwPLV792MGzUTnwq2Dn1mZFBdKS/SUx7wj8DMTQpWbFtJHrqdwp12uzATXBW8JxEZ
 dMI6F50G
X-Authority-Analysis: v=2.4 cv=BabY0qt2 c=1 sm=1 tr=0 ts=68d4ea12 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=TnvzUFuqcobRuy42eWwA:9
 a=QEXdDO2ut3YA:10 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-24_07,2025-09-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1015 phishscore=0 bulkscore=0 priorityscore=1501
 adultscore=0 malwarescore=0 spamscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509220089

QCS615 platform requires non-default logical-to-physical lane mapping due
to its unique hardware routing. Unlike the standard mapping sequence
<0 1 2 3>, QCS615 uses <3 2 0 1>, which necessitates explicit
configuration via the data-lanes property in the device tree. This ensures
correct signal routing between the DP controller and PHY.

For partial definitions, fill remaining lanes with unused physical lanes
in ascending order.

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Signed-off-by: Xiangxu Yin <xiangxu.yin@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/dp/dp_ctrl.c | 10 +++----
 drivers/gpu/drm/msm/dp/dp_link.c | 61 ++++++++++++++++++++++++++++++++++++++++
 drivers/gpu/drm/msm/dp/dp_link.h |  1 +
 3 files changed, 67 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/msm/dp/dp_ctrl.c b/drivers/gpu/drm/msm/dp/dp_ctrl.c
index c42fd2c17a328f6deae211c9cd57cc7416a9365a..cbcc7c2f0ffc4696749b6c43818d20853ddec069 100644
--- a/drivers/gpu/drm/msm/dp/dp_ctrl.c
+++ b/drivers/gpu/drm/msm/dp/dp_ctrl.c
@@ -423,13 +423,13 @@ static void msm_dp_ctrl_config_ctrl(struct msm_dp_ctrl_private *ctrl)
 
 static void msm_dp_ctrl_lane_mapping(struct msm_dp_ctrl_private *ctrl)
 {
-	u32 ln_0 = 0, ln_1 = 1, ln_2 = 2, ln_3 = 3; /* One-to-One mapping */
+	u32 *lane_map = ctrl->link->lane_map;
 	u32 ln_mapping;
 
-	ln_mapping = ln_0 << LANE0_MAPPING_SHIFT;
-	ln_mapping |= ln_1 << LANE1_MAPPING_SHIFT;
-	ln_mapping |= ln_2 << LANE2_MAPPING_SHIFT;
-	ln_mapping |= ln_3 << LANE3_MAPPING_SHIFT;
+	ln_mapping = lane_map[0] << LANE0_MAPPING_SHIFT;
+	ln_mapping |= lane_map[1] << LANE1_MAPPING_SHIFT;
+	ln_mapping |= lane_map[2] << LANE2_MAPPING_SHIFT;
+	ln_mapping |= lane_map[3] << LANE3_MAPPING_SHIFT;
 
 	msm_dp_write_link(ctrl, REG_DP_LOGICAL2PHYSICAL_LANE_MAPPING,
 			ln_mapping);
diff --git a/drivers/gpu/drm/msm/dp/dp_link.c b/drivers/gpu/drm/msm/dp/dp_link.c
index 2aeb3ecf76fab2ee6a9512b785ca5dceebfc3964..2ae78d33fffd7c49190983952ee8f5a249f2b69d 100644
--- a/drivers/gpu/drm/msm/dp/dp_link.c
+++ b/drivers/gpu/drm/msm/dp/dp_link.c
@@ -1236,6 +1236,62 @@ static u32 msm_dp_link_link_frequencies(struct device_node *of_node)
 	return frequency;
 }
 
+/*
+ * Always populate msm_dp_link->lane_map with 4 lanes.
+ * - Use DTS "data-lanes" if present; otherwise fall back to default mapping.
+ * - For partial definitions, fill remaining entries with unused lanes in
+ *   ascending order.
+ */
+static int msm_dp_link_lane_map(struct device *dev, struct msm_dp_link *msm_dp_link)
+{
+	struct device_node *of_node = dev->of_node;
+	struct device_node *endpoint;
+	int cnt = msm_dp_link->max_dp_lanes;
+	u32 tmp[DP_MAX_NUM_DP_LANES];
+	u32 map[DP_MAX_NUM_DP_LANES] = {0, 1, 2, 3}; /* default 1:1 mapping */
+	bool used[DP_MAX_NUM_DP_LANES] = {false};
+	int i, ret = -EINVAL;
+
+	endpoint = of_graph_get_endpoint_by_regs(of_node, 1, -1);
+	if (endpoint) {
+		ret = of_property_read_u32_array(endpoint, "data-lanes", tmp, cnt);
+		if (ret)
+			dev_dbg(dev, "endpoint data-lanes read failed (ret=%d)\n", ret);
+	}
+
+	if (ret) {
+		ret = of_property_read_u32_array(of_node, "data-lanes", tmp, cnt);
+		if (ret) {
+			dev_info(dev, "data-lanes not defined, set to default\n");
+			goto out;
+		}
+	}
+
+	for (i = 0; i < cnt; i++) {
+		if (tmp[i] >= DP_MAX_NUM_DP_LANES) {
+			dev_err(dev, "data-lanes[%d]=%u out of range\n", i, tmp[i]);
+			return -EINVAL;
+		}
+		used[tmp[i]] = true;
+		map[i] = tmp[i];
+	}
+
+	/* Fill the remaining entries with unused physical lanes (ascending) */
+	i = cnt;
+	for (int j = 0; i < DP_MAX_NUM_DP_LANES && j < DP_MAX_NUM_DP_LANES; j++) {
+		if (!used[j])
+			map[i++] = j;
+	}
+
+out:
+	if (endpoint)
+		of_node_put(endpoint);
+
+	dev_dbg(dev, "data-lanes count %d <%d %d %d %d>\n", cnt, map[0], map[1], map[2], map[3]);
+	memcpy(msm_dp_link->lane_map, map, sizeof(map));
+	return 0;
+}
+
 static int msm_dp_link_parse_dt(struct device *dev, struct msm_dp_link *msm_dp_link)
 {
 	struct device_node *of_node = dev->of_node;
@@ -1255,6 +1311,11 @@ static int msm_dp_link_parse_dt(struct device *dev, struct msm_dp_link *msm_dp_l
 	else
 		msm_dp_link->max_dp_lanes = DP_MAX_NUM_DP_LANES; /* 4 lanes */
 
+	if (msm_dp_link_lane_map(dev, msm_dp_link)) {
+		dev_err(dev, "failed to parse data-lanes\n");
+		return -EINVAL;
+	}
+
 	msm_dp_link->max_dp_link_rate = msm_dp_link_link_frequencies(of_node);
 	if (!msm_dp_link->max_dp_link_rate)
 		msm_dp_link->max_dp_link_rate = DP_LINK_RATE_HBR2;
diff --git a/drivers/gpu/drm/msm/dp/dp_link.h b/drivers/gpu/drm/msm/dp/dp_link.h
index 0684a962d4ec93f7da764c4af2e2154c7050329c..b1eb2de6d2a7693f17aa2f256657110af839533d 100644
--- a/drivers/gpu/drm/msm/dp/dp_link.h
+++ b/drivers/gpu/drm/msm/dp/dp_link.h
@@ -74,6 +74,7 @@ struct msm_dp_link {
 	struct msm_dp_link_phy_params phy_params;
 	struct msm_dp_link_info link_params;
 
+	u32 lane_map[DP_MAX_NUM_DP_LANES];
 	u32 max_dp_lanes;
 	u32 max_dp_link_rate;
 };

-- 
2.34.1


