Return-Path: <linux-kernel+bounces-740324-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 52BE9B0D2CB
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 09:25:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D805B1C24428
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 07:24:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51E1A2C3242;
	Tue, 22 Jul 2025 07:23:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="kwv7lJep"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D40CA2D3EF6
	for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 07:23:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753168989; cv=none; b=QNh/FjmTfyXy38rCFD0WkKQEQW467yX8OqfmhJh1Nk26GSDvzdMO2K4VeEK1oI7cUg3prz+UX1XMueKA4q0FN/DMOcoObNIXzg96ITw+LFhioD68V8Hq67hJ9z37zUHmAKK5d8mlY/H3+cJXKKCPdFhuZ9ZmDn/h6V8a5IXhKoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753168989; c=relaxed/simple;
	bh=fKOEEn238gPnE+qsS8pCjAlw+CFDdTPuR+fL/yjRTNg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=k+glPog+wwoC8kx/rNNN+tURfWKMV66qpgCngcHJC8fgOCnT98pgDq4XXsx1SKJNxOFxetjQCYxzzrSLbrhBcaMXJeXRgnyN/9HimJyzMES23kXlciF9NMldpCbU7AvkH/q2GrbhOmSVY3IzVjnjzyM7dUeoFBMDOOiLBBsEGII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=kwv7lJep; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56M3i63r015833
	for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 07:23:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	VT8b7qBDokN3MLpgkXbIZ23nfVJk/VqcFfWtXlYFuaI=; b=kwv7lJepHxwqBdSh
	fR3I4mzVGm22oceU8lIkqzW5kRgOiwxqOced/r5H7s0QRllLwdeLBwmej/D9zDbq
	NHfS6vUIrOv9iAfx9cD4ny0/QpEbaoLs6z1LAGNvhV7CLDJxIKcyIyVcSkEAK84h
	7ZNNfHaCwEL4arT65gRVDgszJLjdxYo7ecfWSxPla7v8WCskQIHo7kMBpMODxuqj
	U8ibXXNFNk6PtfqH+uE9K37TFAhGfG6jRcI9UobZpomP4LxqtMRhFZNpyxhXjiSn
	ziP77f5GHpYk9uJvs/3NwESnnRfEron8MpKYLUG7tKH1yoQUdZLNLx10vnrgPCS7
	L6WRRQ==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 480451ga8h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 07:23:06 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-311e9b4d254so296390a91.1
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 00:23:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753168985; x=1753773785;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VT8b7qBDokN3MLpgkXbIZ23nfVJk/VqcFfWtXlYFuaI=;
        b=LME2OteiNtEIv1rwbxdOJFLtlVC0FCtXCjllVFeJZt6hCn5B+WUT07pXG1Bx4ewQVC
         nYCT9rH1KmONr5K0vtZpAwDg0GJDJUtalNJfpO7I2Hp03f3cbWHt6loLuDGSyaxVSLOA
         ttmOneChe8PkSiaUOyedYTeWFknaCxIBfxI8b0KgNmV898hgWjzaqgXBOQxqRHGYrXwE
         pQOPplgcG3jUjyamIFfN8rUVhiwNIp0svf7yXRao28l5JAESXkdL8ro4AFmdr6LeGfaf
         SvfvE8If7v84q/xekkr4pnARU8GNnBE9OOX6r1tT9T1WK9YAvhZMLLyos4AcC57jOUSW
         sfog==
X-Forwarded-Encrypted: i=1; AJvYcCWGtTDe2yooq+jNBw1TkjMOVBLP1G2Eiy5Pw4ESwSIXVnhLKGLefStAlY6DL5MrUfvNIA9nig7LSou0X+4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzzYlq28qqR3oyHNWVHDrtr7fJ+05khCSQ1nvb7qIwtaZJ3/ani
	NgMm3a4CxjkuU+3b/LgASoALk/pQhjuprMCbfkB19Gb7T8S/NES7FWOO4d6B5awrU4oL1PsG4pw
	5DDxsUUBYk0TWNQBpA+8AclKyN8lHB5rtnGwHWioW0Uda8Pylc4E88xHksZmHz3GaoIU=
X-Gm-Gg: ASbGncsQuaYEj6q+rv98JNXdXMbJUrP5YRFYuQpUBaJFUt6LA0C9b2TQANe4yTPGMsN
	j5uRm5eYO+KRbQcfOWad6nOQ4hJWWRODjkoyLCxIb1mCfTdopyd44u8dt8aBfbuY8krUyFQIKfl
	uN4zt+P7Go29N3SERoIDDJM1skNoGbItNv/NFPBOZZ5zFoCONkPWKVUOpXvmExpsrw4ENpIOf4w
	Aqje0m3vO1k2qaUu+3Udbzt4maW5NzX9JaaQicKh2OEohkhR2OjI5Gs/z3bi7Sgb1djtqadUHXA
	a7SK9RzDOK0xnDt25Rd8gmcahiqRVJPQBFZ5ngvmvni6HoHr/KlMtaqUar2qw/MbIT0MSw2eajq
	8l+N4STKJ/XSzSsS1ocQPY06c5N6/4HxkMog5o2Z36SGfVnXTjDe/ZIYw
X-Received: by 2002:a17:90b:2b50:b0:314:2d38:3e4d with SMTP id 98e67ed59e1d1-31c9e77383cmr12638608a91.3.1753168985254;
        Tue, 22 Jul 2025 00:23:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFsYuvflrRFQOjPT9Kd44yOZC4H81PfsHvY7KycJKf8BF5a4xjLlYXRHnJJenqyoUqbLnUukg==
X-Received: by 2002:a17:90b:2b50:b0:314:2d38:3e4d with SMTP id 98e67ed59e1d1-31c9e77383cmr12638574a91.3.1753168984765;
        Tue, 22 Jul 2025 00:23:04 -0700 (PDT)
Received: from sziotdisp01-gv.qualcomm.com.ap.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31cc3e45e6csm7490753a91.3.2025.07.22.00.22.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Jul 2025 00:23:04 -0700 (PDT)
From: Xiangxu Yin <xiangxu.yin@oss.qualcomm.com>
Date: Tue, 22 Jul 2025 15:22:07 +0800
Subject: [PATCH v2 06/13] phy: qcom: qmp-usbc: Add DP PHY struct
 definitions
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250722-add-displayport-support-for-qcs615-platform-v2-6-42b4037171f8@oss.qualcomm.com>
References: <20250722-add-displayport-support-for-qcs615-platform-v2-0-42b4037171f8@oss.qualcomm.com>
In-Reply-To: <20250722-add-displayport-support-for-qcs615-platform-v2-0-42b4037171f8@oss.qualcomm.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Jessica Zhang <jessica.zhang@oss.qualcomm.com>,
        Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Kuogee Hsieh <quic_khsieh@quicinc.com>, Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org,
        dmitry.baryshkov@oss.qualcomm.com, konrad.dybcio@oss.qualcomm.com,
        fange.zhang@oss.qualcomm.com, quic_lliu6@quicinc.com,
        quic_yongmou@quicinc.com, Xiangxu Yin <xiangxu.yin@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1753168937; l=3659;
 i=xiangxu.yin@oss.qualcomm.com; s=20241125; h=from:subject:message-id;
 bh=fKOEEn238gPnE+qsS8pCjAlw+CFDdTPuR+fL/yjRTNg=;
 b=zV1gjcxy8pY51xKllTd6Tt7ApQk1amC4wRL9m2Mh/bQnoFpYUnlZaE44CklCsZyMugCPsWIJf
 +QI5UeioP8dAZyd+472EtsKsTcY/DUvabnbohnR8aXnf35DgkeCjXEQ
X-Developer-Key: i=xiangxu.yin@oss.qualcomm.com; a=ed25519;
 pk=F1TwipJzpywfbt3n/RPi4l/A4AVF+QC89XzCHgZYaOc=
X-Authority-Analysis: v=2.4 cv=EIMG00ZC c=1 sm=1 tr=0 ts=687f3c5a cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=EUspDBNiAAAA:8 a=Wh4CJP1ljwJP8B485oAA:9
 a=QEXdDO2ut3YA:10 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-ORIG-GUID: 8j7coH3fG-mZ2oVZOLXhmJpHVm-HFDEy
X-Proofpoint-GUID: 8j7coH3fG-mZ2oVZOLXhmJpHVm-HFDEy
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzIyMDA1OSBTYWx0ZWRfX3o4l+Mr3/ZGJ
 TOomCbZ320aCiN7FkfBtIu+oe3g22I2oYx9mi4VV0H5L2AQi7zcyyMsy++bJpeBUWUzgGfpT7uX
 yrAWH9YKXvgImHa0rePY2Qc/sTJWL3JmNxqNLviXD868U+v3eSRtkzqm/YaGeAw9yOK2f979jrz
 JnMQaVSduZpbWJDpbV4bldpOlWG8OsCwh4j2rwnzznM87y8Cx46tbPEn719/ikHIdmDbYqmGiO0
 SUIDQCnYkZek3i3DSSUI4vbOXuNX8TucaQAAPdVpzq6H4O3Ykz5kxQJv++e1RAT/aY0AE4d/r6d
 9W86rC1cqTlHIV30Pl1+xQyxDSPWj8A4Kt1yxsVwqnWH/w9I63LKT6dAHx5XZ0vSBeZlHnHQSW/
 yzHuEYOxRStWb+Q+vgxANmxXwCfV0N7EXk78r2d31l5vKU5PXqD6Dbunom/2juLGJdBCJmkH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-22_01,2025-07-21_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 lowpriorityscore=0 bulkscore=0 adultscore=0
 priorityscore=1501 mlxlogscore=999 phishscore=0 mlxscore=0 clxscore=1015
 suspectscore=0 malwarescore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507220059

This patch introduces new data structures to support DP functionality:
- `qmp_phy_dp_cfg`: Platform-specific constant configuration for DP PHY,
  including init tables, function callbacks, swing/pre-emphasis tables,
  and regulator definitions.
- `qmp_phy_dp_layout`: Runtime layout for DP PHY, including mapped
  registers, DP options from driver, and dynamically configured clocks.
- `qmp_usbc_dp_offsets`: Platform-defined base offsets for DP
  sub-blocks.

These structures mirror the USB counterparts and enable clean separation
of DP logic.

Signed-off-by: Xiangxu Yin <xiangxu.yin@oss.qualcomm.com>
---
 drivers/phy/qualcomm/phy-qcom-qmp-usbc.c | 70 ++++++++++++++++++++++++++++++++
 1 file changed, 70 insertions(+)

diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-usbc.c b/drivers/phy/qualcomm/phy-qcom-qmp-usbc.c
index 647e2f54b744bf099ea667e672c606dd7aef3bcf..bc0eaa7dba9cb84b54c7c5a264aac613f888cb99 100644
--- a/drivers/phy/qualcomm/phy-qcom-qmp-usbc.c
+++ b/drivers/phy/qualcomm/phy-qcom-qmp-usbc.c
@@ -291,6 +291,12 @@ enum qmp_phy_usbc_type {
 	QMP_PHY_USBC_DP,
 };
 
+/* list of regulators */
+struct qmp_regulator_data {
+	const char *name;
+	unsigned int enable_load;
+};
+
 struct qmp_phy_cfg {
 	int type;
 	const void *cfg;
@@ -341,6 +347,67 @@ struct qmp_phy_usb_layout {
 	struct clk_fixed_rate pipe_clk_fixed;
 };
 
+struct qmp_usbc_dp_offsets {
+	u16 dp_serdes;
+	u16 dp_txa;
+	u16 dp_txb;
+	u16 dp_phy;
+};
+
+struct qmp_usbc;
+
+struct qmp_phy_dp_cfg {
+	const struct qmp_usbc_dp_offsets *offsets;
+
+	const struct qmp_phy_init_tbl *serdes_tbl;
+	int serdes_tbl_num;
+	const struct qmp_phy_init_tbl *tx_tbl;
+	int tx_tbl_num;
+	const struct qmp_phy_init_tbl *rx_tbl;
+	int rx_tbl_num;
+	const struct qmp_phy_init_tbl *pcs_tbl;
+	int pcs_tbl_num;
+	const struct qmp_phy_init_tbl *pcs_usb_tbl;
+	int pcs_usb_tbl_num;
+	const struct qmp_phy_init_tbl *dp_serdes_tbl;
+	int dp_serdes_tbl_num;
+	const struct qmp_phy_init_tbl *dp_tx_tbl;
+	int dp_tx_tbl_num;
+
+	/* Init sequence for DP PHY block link rates */
+	const struct qmp_phy_init_tbl *serdes_tbl_rbr;
+	int serdes_tbl_rbr_num;
+	const struct qmp_phy_init_tbl *serdes_tbl_hbr;
+	int serdes_tbl_hbr_num;
+	const struct qmp_phy_init_tbl *serdes_tbl_hbr2;
+	int serdes_tbl_hbr2_num;
+
+	/* DP PHY swing and pre_emphasis tables */
+	const u8 (*swing_tbl)[4][4];
+	const u8 (*pre_emphasis_tbl)[4][4];
+
+	/* DP PHY callbacks */
+	void (*dp_aux_init)(struct qmp_usbc *qmp);
+	void (*configure_dp_tx)(struct qmp_usbc *qmp);
+	int (*configure_dp_phy)(struct qmp_usbc *qmp);
+	int (*calibrate_dp_phy)(struct qmp_usbc *qmp);
+
+	const struct qmp_regulator_data *vreg_list;
+	int num_vregs;
+};
+
+struct qmp_phy_dp_layout {
+	void __iomem *dp_phy;
+	void __iomem *dp_tx;
+	void __iomem *dp_tx2;
+	void __iomem *dp_serdes;
+
+	unsigned int dp_aux_cfg;
+	struct phy_configure_opts_dp dp_opts;
+	struct clk_hw dp_link_hw;
+	struct clk_hw dp_pixel_hw;
+};
+
 struct qmp_usbc {
 	struct device *dev;
 	int type;
@@ -359,6 +426,7 @@ struct qmp_usbc {
 
 	struct regmap *tcsr_map;
 	u32 vls_clamp_reg;
+	u32 dp_phy_mode_reg;
 
 	struct typec_switch_dev *sw;
 };
@@ -480,7 +548,9 @@ static const struct qmp_phy_cfg sdm660_phy_usb3_cfg = {
 };
 
 #define to_usb_cfg(x) ((struct qmp_phy_usb_cfg *)((x)->cfg))
+#define to_dp_cfg(x) ((struct qmp_phy_dp_cfg *)((x)->cfg))
 #define to_usb_layout(x) ((struct qmp_phy_usb_layout *)((x)->layout))
+#define to_dp_layout(x) ((struct qmp_phy_dp_layout *)((x)->layout))
 
 static int qmp_usbc_generic_init(struct phy *phy)
 {

-- 
2.34.1


