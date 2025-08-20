Return-Path: <linux-kernel+bounces-777385-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B3F2B2D8CB
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 11:44:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A723F5E01E3
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 09:39:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0285223324;
	Wed, 20 Aug 2025 09:36:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="VHfvRoyy"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A5FB2DEA93
	for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 09:36:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755682609; cv=none; b=g+z2tWRSwFxcdWTbDqx+JrXbTefkS2VWwh7vgsdth8CqPmlg6qxLUZQ7NW3MJ2rWyVCxDbWMY2Fc/j7LN9TylBMuyx2qjsuzyBHTU2DRY0ccSvEdkRooFqi2AxAYRQ8VJwoMPiaGvTWnjf3IMQXbCus8abnj9LOZXgYBpxtGfbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755682609; c=relaxed/simple;
	bh=MA02P7ToNuvVIaZfkK2UxK8YE+l2KzZCvXz7pjmIzh4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=IgwiMFJ3X5jk+1irhyBTTj+F9G1usjiFkMGHC4w6c6EKBBxKTirrB7PgED2VopfWJA66X3xNj5C4u6UsCeobqpHyyvyDTpV+okOTP6HlK/ukd59uOEbHAipjEx1c828TDn10eim8fCNT5kasovFqPyc04ioPPExd5PqxwFPhIXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=VHfvRoyy; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57K1ofe8025326
	for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 09:36:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	DrkMy5L7tD6QVTxF1NEKKWbi4e+hmDyRQI1J1n+A2q4=; b=VHfvRoyy68K37/my
	7ea+5gHfMClctLI5d7snSYwOJQ0tL343Gq8YlRkk9B3owhk5w2mZ2DTzs+vrdqIh
	JkHDwo3Ej0VaG6uxmxF8CeDAwCJrYm49tMopWqJGCdzQiz7KCOfrxYFrb3aV2jeA
	LMEYumS6Ewtibw0EXdfy48za5Rlp5E7xNejIe7EQEvyskCf8iIV25nWmnvXbQKjX
	YO+jb0zVNRLSIf3BADrciQ44/hoBf4XTjsvfoWlnocIWgZjJU+vqnIfoloIjG3yd
	SSoDkOFMg520r/EP045rNiHtqp7WZZmxNIR6i91NrlnZweJOOfJBV9Av0Z0HZMRl
	UGrPKw==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48n52a980w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 09:36:47 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-244581a191bso13205075ad.2
        for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 02:36:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755682606; x=1756287406;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DrkMy5L7tD6QVTxF1NEKKWbi4e+hmDyRQI1J1n+A2q4=;
        b=laNzWyuUchVo2XJx38to8xB5NBDNG4lVkrN/dKW5+kNBOH8c+Hrwv3IFK209w5O4O0
         s+VgNCjJrdmMmv9RFFWJoTBZ0vKCfaKcfy050JK4mCPvmmJEuSUM+IGTxjKkD1ys+T/u
         375J+2BqZGEejA7BrBi+ZXfed1BTtTXHJ5682zsnuDIOTTPQAJ05V8eUS1m/40IOFQHP
         tn7ZawJzmDGqIjEiWqkzC0054Jc3iTlNXonkMbTX20hFIm1oxqVXBrHVV7nv6OyfGlfG
         f4SZQZKN0RgMx5T+PZjzRa9+SaTaJh0DgSvcNGzWnTieWJwgPfz6fMSYdgQ8FuUfyRz+
         vIjA==
X-Forwarded-Encrypted: i=1; AJvYcCUeG4SaHF1nopVh01+gYhFBQu0wmaKa10o9KIe7EZVRAeemfptbt6FHc8ukCxmMiEyJ8b9NIrIxk89ZVXI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwgzPccK4+aI4ol3F4DAsqQ2AF27d5xbSFsA+vJmGGdA9PSQ5fF
	GHJezdea3AbnZ1SUtKntc5tGhtlnLzH8vFgdBFvBwMmKMVMpseZ/mfnwRgco35JUPUhbN/GA99q
	31r96X8RwcUb4SIV1iDZc2lVV53Z8RHzeJsUw6Hkh0HGxYeAYRG5n+heTB/G+YXxqD6k=
X-Gm-Gg: ASbGncskEEzm2PwuHBKVW4oa//oD2eGuFO8ou8eZ8Af89q9eTC7xDBdPI4N1zKx2QTI
	81wOjJPWxfxTv2Ob53CcRp4duweBlC08Pn6Z8sMuCWQaRhxdjMJkPILmW9tX8YWtDSNOBE88/qW
	6A5OpZr2oOSJ1iSiLCzKKGYqZ3uDF0/hBNHmlfTtCMiWRgZ04GKdfF9+KtDexrm3iU2Mk7HbWhw
	K5e1KzKBJqorKpvahe3cTAGSkSyxitgaxfUIr9fFm243Xhk1sm7d9kkCShr0s6RVvRjs4SVgIxx
	fLARj/UdEIvAGoqCS5P7beJHuH/OaAdH9jMMJYyLbT1poQYl2jdxHXL45lNqqYgzYO3THugzf2L
	Ndi0jsC1ggs9reFSW5ia2637cqiOWGKxuy+YAHmvIUfEErnevhVpe0ejE
X-Received: by 2002:a17:903:2301:b0:245:f85c:8c6f with SMTP id d9443c01a7336-245f85c8f03mr897565ad.3.1755682605680;
        Wed, 20 Aug 2025 02:36:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHuqv0P/Rn8ScCOne0RSW/g1R4MWiSbtsdqocz2z7Sl3Z/tnXkAEbGml6AHCTkyZG68qndwIQ==
X-Received: by 2002:a17:903:2301:b0:245:f85c:8c6f with SMTP id d9443c01a7336-245f85c8f03mr897265ad.3.1755682605205;
        Wed, 20 Aug 2025 02:36:45 -0700 (PDT)
Received: from sziotdisp01-gv.qualcomm.com.ap.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-245ed4ec100sm20954305ad.116.2025.08.20.02.36.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Aug 2025 02:36:44 -0700 (PDT)
From: Xiangxu Yin <xiangxu.yin@oss.qualcomm.com>
Date: Wed, 20 Aug 2025 17:34:51 +0800
Subject: [PATCH v3 09/14] phy: qcom: qmp-usbc: Add DP PHY ops for USB/DP
 switchable Type-C PHYs
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250820-add-displayport-support-for-qcs615-platform-v3-9-a43bd25ec39c@oss.qualcomm.com>
References: <20250820-add-displayport-support-for-qcs615-platform-v3-0-a43bd25ec39c@oss.qualcomm.com>
In-Reply-To: <20250820-add-displayport-support-for-qcs615-platform-v3-0-a43bd25ec39c@oss.qualcomm.com>
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
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org,
        fange.zhang@oss.qualcomm.com, yongxing.mou@oss.qualcomm.com,
        tingwei.zhang@oss.qualcomm.com, Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        quic_lliu6@quicinc.com, Xiangxu Yin <xiangxu.yin@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1755682521; l=5080;
 i=xiangxu.yin@oss.qualcomm.com; s=20241125; h=from:subject:message-id;
 bh=MA02P7ToNuvVIaZfkK2UxK8YE+l2KzZCvXz7pjmIzh4=;
 b=3mIfCNECdOIGbPwnHgFAMuETdXD0fuBwSYatvAYqRaOBnHvToCc2rBpbbUBHZ4RDlv571OlVW
 x3dauhgXAbrAMwhNv6iLIBGh7yzaX8IiOTES9qZasdUtyz/4MOC8kON
X-Developer-Key: i=xiangxu.yin@oss.qualcomm.com; a=ed25519;
 pk=F1TwipJzpywfbt3n/RPi4l/A4AVF+QC89XzCHgZYaOc=
X-Proofpoint-ORIG-GUID: C-H856PTNaYxNJYlmaEm2BgJgx4qWSiE
X-Authority-Analysis: v=2.4 cv=B83gEOtM c=1 sm=1 tr=0 ts=68a5972f cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=EUspDBNiAAAA:8 a=CY_kl0BFdDKtcBMMbFsA:9
 a=QEXdDO2ut3YA:10 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-GUID: C-H856PTNaYxNJYlmaEm2BgJgx4qWSiE
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIwMDAxMyBTYWx0ZWRfXyXOvwADTeTMT
 l/ZB3xyXCHu1c12clw/6t0RKgh3cUJ7fRqaTck6/EmxgLTw4KjGFMLGXvs0nTQgUOWxO/VzB+pQ
 PpwWDYc1SlF1byZ9l8gAmW0LjhE9DNzhtc8h6qAiPoU/PXcE24cOXu53G+Sgc+tpgzb9hK1imGu
 Fb0eVBRPnYsx9+GLCzcLyT62ioxzkEOM3bKUMgG43sfAdqIvj/6SAiZygxP8kFhONPHQgqZXraz
 2v1vh2J2kWRRV4zU+9lXKvCzt67jUyJ4C+RTQoNed4A43Lw/DD/6/nvFep8cZhsbM5G96igIyFf
 AI85t8WismxmEvEkOee76FfmAJaOGRAT76Bj3WhGpE2ydSDGR4y4yaE0ZcLFz7eRI6z4H5PP0r0
 9LyL3wDGnXopEPaTrZsH3//Nq430bg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-20_03,2025-08-20_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 bulkscore=0 priorityscore=1501 suspectscore=0 malwarescore=0
 lowpriorityscore=0 adultscore=0 impostorscore=0 clxscore=1015 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2508110000 definitions=main-2508200013

Define qmp_usbc_dp_phy_ops struct to support DP mode on USB/DP
switchable PHYs.

Signed-off-by: Xiangxu Yin <xiangxu.yin@oss.qualcomm.com>
---
 drivers/phy/qualcomm/phy-qcom-qmp-usbc.c | 163 +++++++++++++++++++++++++++++++
 1 file changed, 163 insertions(+)

diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-usbc.c b/drivers/phy/qualcomm/phy-qcom-qmp-usbc.c
index 1508a4a5f57aff85318485b79528325f28a825a4..a1495a2029cf038bb65c36e42d0a4f633e544558 100644
--- a/drivers/phy/qualcomm/phy-qcom-qmp-usbc.c
+++ b/drivers/phy/qualcomm/phy-qcom-qmp-usbc.c
@@ -22,6 +22,8 @@
 #include <linux/slab.h>
 #include <linux/usb/typec.h>
 #include <linux/usb/typec_mux.h>
+#include <dt-bindings/phy/phy-qcom-qmp.h>
+#include <drm/bridge/aux-bridge.h>
 
 #include "phy-qcom-qmp-common.h"
 
@@ -1088,6 +1090,157 @@ static int qmp_usbc_usb_set_mode(struct phy *phy, enum phy_mode mode, int submod
 	return 0;
 }
 
+static int qmp_usbc_dp_enable(struct phy *phy)
+{
+	struct qmp_usbc *qmp = phy_get_drvdata(phy);
+	const struct qmp_phy_cfg *cfg = qmp->cfg;
+	int ret;
+
+	if (qmp->dp_init_count) {
+		dev_err(qmp->dev, "DP already inited\n");
+		return 0;
+	}
+
+	mutex_lock(&qmp->phy_mutex);
+
+	ret = qmp_usbc_com_init(phy);
+	if (ret)
+		goto dp_init_unlock;
+
+	cfg->dp_aux_init(qmp);
+
+	qmp->dp_init_count++;
+
+dp_init_unlock:
+	mutex_unlock(&qmp->phy_mutex);
+	return ret;
+}
+
+static int qmp_usbc_dp_disable(struct phy *phy)
+{
+	struct qmp_usbc *qmp = phy_get_drvdata(phy);
+
+	mutex_lock(&qmp->phy_mutex);
+
+	qmp_usbc_com_exit(phy);
+
+	qmp->dp_init_count--;
+
+	mutex_unlock(&qmp->phy_mutex);
+
+	return 0;
+}
+
+static int qmp_usbc_dp_configure(struct phy *phy, union phy_configure_opts *opts)
+{
+	const struct phy_configure_opts_dp *dp_opts = &opts->dp;
+	struct qmp_usbc *qmp = phy_get_drvdata(phy);
+	const struct qmp_phy_cfg *cfg = qmp->cfg;
+
+	mutex_lock(&qmp->phy_mutex);
+
+	memcpy(&qmp->dp_opts, dp_opts, sizeof(*dp_opts));
+	if (qmp->dp_opts.set_voltages) {
+		cfg->configure_dp_tx(qmp);
+		qmp->dp_opts.set_voltages = 0;
+	}
+
+	mutex_unlock(&qmp->phy_mutex);
+
+	return 0;
+}
+
+static int qmp_usbc_dp_calibrate(struct phy *phy)
+{
+	struct qmp_usbc *qmp = phy_get_drvdata(phy);
+	const struct qmp_phy_cfg *cfg = qmp->cfg;
+	int ret = 0;
+
+	mutex_lock(&qmp->phy_mutex);
+
+	if (cfg->calibrate_dp_phy) {
+		ret = cfg->calibrate_dp_phy(qmp);
+		if (ret) {
+			dev_err(qmp->dev, "dp calibrate err(%d)\n", ret);
+			mutex_unlock(&qmp->phy_mutex);
+			return ret;
+		}
+	}
+
+	mutex_unlock(&qmp->phy_mutex);
+	return 0;
+}
+
+static int qmp_usbc_dp_serdes_init(struct qmp_usbc *qmp)
+{
+	const struct qmp_phy_cfg *cfg = qmp->cfg;
+	void __iomem *serdes = qmp->dp_serdes;
+	const struct phy_configure_opts_dp *dp_opts = &qmp->dp_opts;
+
+	qmp_configure(qmp->dev, serdes, cfg->dp_serdes_tbl,
+		      cfg->dp_serdes_tbl_num);
+
+	switch (dp_opts->link_rate) {
+	case 1620:
+		qmp_configure(qmp->dev, serdes, cfg->serdes_tbl_rbr,
+			      cfg->serdes_tbl_rbr_num);
+		break;
+	case 2700:
+		qmp_configure(qmp->dev, serdes, cfg->serdes_tbl_hbr,
+			      cfg->serdes_tbl_hbr_num);
+		break;
+	case 5400:
+		qmp_configure(qmp->dev, serdes, cfg->serdes_tbl_hbr2,
+			      cfg->serdes_tbl_hbr2_num);
+		break;
+	default:
+		/* Other link rates aren't supported */
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int qmp_usbc_dp_power_on(struct phy *phy)
+{
+	struct qmp_usbc *qmp = phy_get_drvdata(phy);
+	const struct qmp_phy_cfg *cfg = qmp->cfg;
+
+	void __iomem *tx = qmp->dp_tx;
+	void __iomem *tx2 = qmp->dp_tx2;
+
+	mutex_lock(&qmp->phy_mutex);
+
+	qmp_usbc_dp_serdes_init(qmp);
+
+	qmp_configure_lane(qmp->dev, tx, cfg->dp_tx_tbl, cfg->dp_tx_tbl_num, 1);
+	qmp_configure_lane(qmp->dev, tx2, cfg->dp_tx_tbl, cfg->dp_tx_tbl_num, 2);
+
+	/* Configure special DP tx tunings */
+	cfg->configure_dp_tx(qmp);
+
+	/* Configure link rate, swing, etc. */
+	cfg->configure_dp_phy(qmp);
+
+	mutex_unlock(&qmp->phy_mutex);
+
+	return 0;
+}
+
+static int qmp_usbc_dp_power_off(struct phy *phy)
+{
+	struct qmp_usbc *qmp = phy_get_drvdata(phy);
+
+	mutex_lock(&qmp->phy_mutex);
+
+	/* Assert DP PHY power down */
+	writel(DP_PHY_PD_CTL_PSR_PWRDN, qmp->dp_dp_phy + QSERDES_DP_PHY_PD_CTL);
+
+	mutex_unlock(&qmp->phy_mutex);
+
+	return 0;
+}
+
 static const struct phy_ops qmp_usbc_usb_phy_ops = {
 	.init		= qmp_usbc_usb_enable,
 	.exit		= qmp_usbc_usb_disable,
@@ -1095,6 +1248,16 @@ static const struct phy_ops qmp_usbc_usb_phy_ops = {
 	.owner		= THIS_MODULE,
 };
 
+static const struct phy_ops qmp_usbc_dp_phy_ops = {
+	.init		= qmp_usbc_dp_enable,
+	.exit		= qmp_usbc_dp_disable,
+	.configure	= qmp_usbc_dp_configure,
+	.calibrate	= qmp_usbc_dp_calibrate,
+	.power_on	= qmp_usbc_dp_power_on,
+	.power_off	= qmp_usbc_dp_power_off,
+	.owner		= THIS_MODULE,
+};
+
 static void qmp_usbc_enable_autonomous_mode(struct qmp_usbc *qmp)
 {
 	const struct qmp_phy_cfg *cfg = qmp->cfg;

-- 
2.34.1


