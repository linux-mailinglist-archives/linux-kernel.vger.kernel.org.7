Return-Path: <linux-kernel+bounces-824699-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 40F16B89F05
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 16:27:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D9BFA1B241C9
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 14:26:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7458E3148DB;
	Fri, 19 Sep 2025 14:25:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="kYoNGJBs"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38B7B3148DF
	for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 14:25:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758291942; cv=none; b=J+Pdu6UIfkFZZ66NmKY9QWI5UW8+zNFRtcuMZBFDtyNL0V0DqCrXcuAxQ/pl18ThQpd9a/Pr6vH//oEoh8Ym9WlVVOwFA7Bn64cZ8CLORL1LsPbKDPeZx7wmOs8QSYZvgIzg/vSm/akBitHQzZ9hwPIokcxQIMzoqr7HbmPqc7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758291942; c=relaxed/simple;
	bh=u9wOAKxkjnamI2H2q1squA5Lj0dD2o8MZknhelsq6I0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fIhMb3jLx+hf1+nmieJDc7AHUxr13JF4JCZw7rEluvrzsWWlNZScqrv9brF1CQ93D+p28NwdRY0NWm517DrjzSUppEim35sJ4hAOZO3ZAK/7fkBEXUHEr42y+kPc3MIhe/iLxp/tNlCdT+j5GEbon8ROoaN0VH/U8o8j1u4uiX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=kYoNGJBs; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58JDXXHT030876
	for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 14:25:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	s8Gat07gp3MRVOt4L/O159z0k7jLmrjqvCt4T7tTz2A=; b=kYoNGJBsNNDc+8ib
	pPKFA6X9HZyMwtM90sOBw4APhI9lfXd4YL9+1TZY71KnolX35ZqJxVcsAWaPogA0
	0j9x9ZjdwYot1Pd1T7OE7xJZNjJnobc4pMH6JY8VzaVhxb8pEnnFnMk8kn8XbZwy
	yQY6t/SYQJN7llRf6NntbdnMfdhQvI99oqoVfSHqdrm6d67zuEhhvOhZTZA2eXXF
	bBe+TosxQdo6HpyR/eDoftakW7g5UcTjL9puKV8arBk8vMxIbQvYMRs2WsEtV3t5
	MGtpB2sk/kX06MNRSnsN4fADMUTNFQ9ek5VqGNS6H/eTD8aaWnvP+yAEtoKo5+lK
	Fawmnw==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49916x1j1v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 14:25:40 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-26dcd7e816fso925835ad.0
        for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 07:25:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758291939; x=1758896739;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=s8Gat07gp3MRVOt4L/O159z0k7jLmrjqvCt4T7tTz2A=;
        b=gQUDsN52YPBC8zdKlf2S49jWpWdM/+yOT1B5cHeza6Ep35i8u2eCkfRMWtmFL4SM1M
         3cW6Ubp3F63haCyTes1izCdPYlv5TJll8/VVWtwsTDTVQb9iiq3bYf7qm6Tie2mM27xc
         EjFQnBkWeH/OvYSWUgeN5X3q3YaaHONFaxabELKgEVfM6LA4xB3LEYtEzSLr7GPeSUBb
         rnZRpGo0XC/xM73J1LpSWsFvrFUNDHfNTDtd6o0kZiqL151di17EiFt23OIoCL8h3DmX
         29dx0fW9cAdcUXPHdUMinWqocl2GDWVRuU/ZZBdvSUzJmISk+78nQ2nuD/Cnwe6qfiNJ
         1oPw==
X-Forwarded-Encrypted: i=1; AJvYcCV/G8BzzQwKebz1HYDAQlrO6HB61d5Kb5986sGH1Vs7J5TdU7HVQPgn8CUDbVzUI4nEFW4x+0rA50hTp3c=@vger.kernel.org
X-Gm-Message-State: AOJu0YweZlbVOotERQLKaSDCw9YGmSTk5uF+OuGAtdkQtHUykdk7CTEQ
	3V1hzm8Cp2QmkHhfmfRZ6aHAbZw/iDYdPlql8uFpqBhAII9vp55dHSz08POLAYNNPYK4Fj9HZYz
	baznyQj6HJ/JFjZcAyg//vqjtak+lPUGhVOWDByIwKjco6qStZ0JUmaENYqugnV0He/Y=
X-Gm-Gg: ASbGnctT8+U1ADYcd/BI0fMoskTbU+GAm63VqEXDIZHACT76BHrjh5xV0PSCHYWQdBD
	wZXj2DKzFh1d0L4S8Ffaoy3UfeZqFqroG2bKI4tda2wXfgvocS5L/uVJDJxLMyfIJmKlYUnOaXP
	Qn3wqWLrAdtrk9w4LyK0TNfeKW6eLdard8yF8BZZ5KMRxztB+QxPW8TTnm3g0qVwIe6EK3t1Mkx
	5WoA0n70T2RQVkWPo0F1mF1oKyjMO9P/eg6d+zaGUnjeIo6ubIkDAMhuBzk7SJl9M/Q4ZxlCxNo
	u2QcfkVlgw3QcuAmCbVYgAkfe9/7CCtHge3Y65GQdZISF0XgN7d4Pzsqwnckboc+mufAkVii07O
	IHUNg7IFsv94Psw==
X-Received: by 2002:a17:902:e783:b0:264:cda8:7fd3 with SMTP id d9443c01a7336-269ba524fcamr23697485ad.6.1758291939370;
        Fri, 19 Sep 2025 07:25:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF1kN5CdBbgtNitx8qEDVbtTkUx50Cb0tShRZ+81fS8AlMsoBbd1UoYI7x3OsJPQoi2b5RSdQ==
X-Received: by 2002:a17:902:e783:b0:264:cda8:7fd3 with SMTP id d9443c01a7336-269ba524fcamr23697235ad.6.1758291938856;
        Fri, 19 Sep 2025 07:25:38 -0700 (PDT)
Received: from sziotdisp01-gv.qualcomm.com.ap.qualcomm.com ([114.94.8.21])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-26e80409ee3sm2210035ad.80.2025.09.19.07.25.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Sep 2025 07:25:38 -0700 (PDT)
From: Xiangxu Yin <xiangxu.yin@oss.qualcomm.com>
Date: Fri, 19 Sep 2025 22:24:22 +0800
Subject: [PATCH v5 05/14] phy: qcom: qmp-usbc: Move reset config into PHY
 cfg
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250919-add-displayport-support-for-qcs615-platform-v5-5-eae6681f4002@oss.qualcomm.com>
References: <20250919-add-displayport-support-for-qcs615-platform-v5-0-eae6681f4002@oss.qualcomm.com>
In-Reply-To: <20250919-add-displayport-support-for-qcs615-platform-v5-0-eae6681f4002@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1758291894; l=3439;
 i=xiangxu.yin@oss.qualcomm.com; s=20241125; h=from:subject:message-id;
 bh=u9wOAKxkjnamI2H2q1squA5Lj0dD2o8MZknhelsq6I0=;
 b=EpbxVqfS5D6TBeLH+5VJDRNxVNdHBlYL1HJL3hVzX00jjVkBmU6I99OLKvT9n5mef4nA5F7SY
 q2yh4lEpjsFChCZm6w6UcLrKNnVneXfAfMOtixmvqW4eKiMpIvPd7MI
X-Developer-Key: i=xiangxu.yin@oss.qualcomm.com; a=ed25519;
 pk=F1TwipJzpywfbt3n/RPi4l/A4AVF+QC89XzCHgZYaOc=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE5MDA0OCBTYWx0ZWRfX3L4mxn6IkQM9
 l+M7889uvBWV7D/XHwHDmrySbRJEdR4tIo/Nokq8KXuxubZ2FXQFGbrfOzA+Zk07Xp9ZsVezvzC
 lwhRMAnLnMvqm2dvQUmZH3EbIHFFFA3Wlg7YkhB32lJpCYM+Y9kAWL1mMWu3zAMYHJMr0XYYMJJ
 aMxmSi+1/rti+cLtQnHEYYgb6J/p0T0xh/VXs4Ej0PIqS2C9QJ0F8iLHUSFbe8L2NMcg6/2cE+4
 HrkOrqmWQgb/7FSAYroiZU8HUkANxsl8uUnMN7/bfUhl5y58uh9lhpkRQe3bgco8ofInccqAfaO
 66tgNgnWoNmy/6u/8575lJIur3S1GPxvL0eZGSGGno+U9xOPRNLzBJ4SDN6C3R+7rkpuYSqRpGr
 H+bre9Ey
X-Proofpoint-GUID: YzEabUaK9760VQHVDVn3X-vn2NaBj7uS
X-Authority-Analysis: v=2.4 cv=LcM86ifi c=1 sm=1 tr=0 ts=68cd67e4 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=Uz3yg00KUFJ2y2WijEJ4bw==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=RqUhitWEW_Btmly2q4YA:9
 a=QEXdDO2ut3YA:10 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-ORIG-GUID: YzEabUaK9760VQHVDVn3X-vn2NaBj7uS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-19_01,2025-09-19_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 phishscore=0 spamscore=0 impostorscore=0
 suspectscore=0 adultscore=0 bulkscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509190048

Move resets to qmp_phy_cfg for per-PHY customization. Keep legacy DT
path on the old hardcoded list; non-legacy path uses cfg->reset_list.

Signed-off-by: Xiangxu Yin <xiangxu.yin@oss.qualcomm.com>
---
 drivers/phy/qualcomm/phy-qcom-qmp-usbc.c | 18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-usbc.c b/drivers/phy/qualcomm/phy-qcom-qmp-usbc.c
index 3b48c69f9c3cb7daec495ebc281b83fe34e56881..3d228db9ef0882eb76e7ab9e82f8122fa9cfe314 100644
--- a/drivers/phy/qualcomm/phy-qcom-qmp-usbc.c
+++ b/drivers/phy/qualcomm/phy-qcom-qmp-usbc.c
@@ -335,7 +335,8 @@ struct qmp_phy_cfg {
 	int (*configure_dp_phy)(struct qmp_usbc *qmp);
 	int (*calibrate_dp_phy)(struct qmp_usbc *qmp);
 
-	/* regulators to be requested */
+	const char * const *reset_list;
+	int num_resets;
 	const struct regulator_bulk_data *vreg_list;
 	int num_vregs;
 
@@ -428,6 +429,10 @@ static const char * const usb3phy_reset_l[] = {
 	"phy_phy", "phy",
 };
 
+static const char * const usb3dpphy_reset_l[] = {
+	"phy_phy", "dp_phy",
+};
+
 static const struct regulator_bulk_data qmp_phy_msm8998_vreg_l[] = {
 	{ .supply = "vdda-phy", .init_load_uA = 68600 },
 	{ .supply = "vdda-pll", .init_load_uA = 14200 },
@@ -464,6 +469,8 @@ static const struct qmp_phy_cfg msm8998_usb3phy_cfg = {
 	.rx_tbl_num             = ARRAY_SIZE(msm8998_usb3_rx_tbl),
 	.pcs_tbl                = msm8998_usb3_pcs_tbl,
 	.pcs_tbl_num            = ARRAY_SIZE(msm8998_usb3_pcs_tbl),
+	.reset_list		= usb3phy_reset_l,
+	.num_resets		= ARRAY_SIZE(usb3phy_reset_l),
 	.vreg_list              = qmp_phy_msm8998_vreg_l,
 	.num_vregs              = ARRAY_SIZE(qmp_phy_msm8998_vreg_l),
 	.regs                   = qmp_v3_usb3phy_regs_layout,
@@ -480,6 +487,8 @@ static const struct qmp_phy_cfg qcm2290_usb3phy_cfg = {
 	.rx_tbl_num		= ARRAY_SIZE(qcm2290_usb3_rx_tbl),
 	.pcs_tbl		= qcm2290_usb3_pcs_tbl,
 	.pcs_tbl_num		= ARRAY_SIZE(qcm2290_usb3_pcs_tbl),
+	.reset_list		= usb3phy_reset_l,
+	.num_resets		= ARRAY_SIZE(usb3phy_reset_l),
 	.vreg_list		= qmp_phy_sm2290_vreg_l,
 	.num_vregs		= ARRAY_SIZE(qmp_phy_sm2290_vreg_l),
 	.regs			= qmp_v3_usb3phy_regs_layout_qcm2290,
@@ -496,6 +505,8 @@ static const struct qmp_phy_cfg sdm660_usb3phy_cfg = {
 	.rx_tbl_num		= ARRAY_SIZE(sdm660_usb3_rx_tbl),
 	.pcs_tbl		= qcm2290_usb3_pcs_tbl,
 	.pcs_tbl_num		= ARRAY_SIZE(qcm2290_usb3_pcs_tbl),
+	.reset_list		= usb3phy_reset_l,
+	.num_resets		= ARRAY_SIZE(usb3phy_reset_l),
 	.vreg_list		= qmp_phy_msm8998_vreg_l,
 	.num_vregs		= ARRAY_SIZE(qmp_phy_msm8998_vreg_l),
 	.regs			= qmp_v3_usb3phy_regs_layout_qcm2290,
@@ -512,6 +523,8 @@ static const struct qmp_phy_cfg qcs615_usb3phy_cfg = {
 	.rx_tbl_num		= ARRAY_SIZE(qcm2290_usb3_rx_tbl),
 	.pcs_tbl		= qcm2290_usb3_pcs_tbl,
 	.pcs_tbl_num		= ARRAY_SIZE(qcm2290_usb3_pcs_tbl),
+	.reset_list		= usb3phy_reset_l,
+	.num_resets		= ARRAY_SIZE(usb3phy_reset_l),
 	.vreg_list		= qmp_phy_qcs615_vreg_l,
 	.num_vregs		= ARRAY_SIZE(qmp_phy_qcs615_vreg_l),
 	.regs			= qmp_v3_usb3phy_regs_layout_qcm2290,
@@ -1051,8 +1064,7 @@ static int qmp_usbc_parse_dt(struct qmp_usbc *qmp)
 				     "failed to get pipe clock\n");
 	}
 
-	ret = qmp_usbc_reset_init(qmp, usb3phy_reset_l,
-				 ARRAY_SIZE(usb3phy_reset_l));
+	ret = qmp_usbc_reset_init(qmp, cfg->reset_list, cfg->num_resets);
 	if (ret)
 		return ret;
 

-- 
2.34.1


