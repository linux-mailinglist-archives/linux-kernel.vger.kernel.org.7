Return-Path: <linux-kernel+bounces-827361-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F21DAB918B7
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 15:59:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D64B31897B54
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 13:59:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 090DD30EF99;
	Mon, 22 Sep 2025 13:59:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="NcG1WwbQ"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99D17259C80
	for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 13:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758549555; cv=none; b=CLna8vmWONPIzf30ZeY1Rzq+QKRmxuO6wWD58VZNxr5N4dOlMpnRrUft7GCh7ntF4rwQLO6YgPagPOkkahGqkWgjdFcl7xIXc9yUTEtaV5dwWCCEGYI9yDlQqmG7sX7vvx5CHvdrpItDuPpfZX2BlQWdDqE3jqSpJHjvntePT3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758549555; c=relaxed/simple;
	bh=HVub2/piy1VUMYvxQxsshwSwKxOnIHSxs7lcFKkSD4w=;
	h=From:To:Cc:Subject:Date:Message-Id; b=NRsHGHcp7uatpctVRuaROLS7Q4OxI5C9YDy9C7PKqv9M4BRE4ogfN+cD5zxiwlvgMybVWsb47pWuP2qHxRd4EFPT9mnbVxeJ+X27NPNZNyKg5hfZdBCYquX6O7YwLHrbX3D5KyuZQlXkwoF1dk4691h5AoHYN47GIXde7/z0JUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=NcG1WwbQ; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58M8uoHD012252
	for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 13:59:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:date:from:message-id:subject:to; s=qcppdkim1; bh=IpgB3zPzcPe6
	ZDiYXLYhy9/xVWLJ7IMcJUiL6titr3U=; b=NcG1WwbQKT5c/kFiX2ggTjLYarv/
	WJhPCF98UZabopI8zIer+08xeiB16DEaSQMApiEhEdHhuMrlgBFY0fKZ0ajZSqLj
	aVgQMAzkk1XMTJpVDSnvTRWd/MzPtzeD3ZLXWqwIWmaTnan5951w7XsQ7Uo05ned
	3YQ9RonBValJV20uabY1+2MUFySK2G4Hq+X21JcjlT3i54rqbRm6JNky2hs8cEwQ
	T4yZ95gi+Xo8R6xkXaTZK2w5E01MdwuXwci1XUDHNTSxba3b4vBzP6eeNNomTmsi
	2Y6dBSxgsriIXHZLJzDnsibELdAjeLAWXM4r3BXpDMy7gMHwCBvE4Fl3zg==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 499mn7cy5p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 13:59:12 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2445806b18aso53601465ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 06:59:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758549551; x=1759154351;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IpgB3zPzcPe6ZDiYXLYhy9/xVWLJ7IMcJUiL6titr3U=;
        b=Hz7lFGvCZwDFQ17fdLF+JrDGfc2W2o5oqe3/bWXYT3LLEJIKR1W8VjD86Nu5ZAHpn0
         WRolW/ZBV8eoGlUMjmZSf7fmQE1wBLX9BNKWoow5ABZVjJWhug5ZKiv1q/J4g1TahinO
         AvsPthXKpwVDF5VSOGR7o/PmDl+isFRUOMBdXP/7sI6PmNb74DaVpXu5BceFZKj5bP86
         1GlVfVNESFkU1KXbdg7EdY1MDqMQ1Zc1CEz/YJwd25WBR4/T23ewxieYRBPjfH/TPKl9
         JAVPx2FZiHVnJvKvdfTnaoM6V/Q4vV4JPEzq999jpAI9ivWeJqzBR98B3BgsgdOX/nzv
         RuBA==
X-Forwarded-Encrypted: i=1; AJvYcCWFbx5gZqAf8kY05hVmkV+brp9TFP0KggCN3MmcXfLA/stDw85QWnCkzJVoc73u41j+/cIj6HSwmFLZDks=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5Igqy2HVt8pB8DEGO11/cHmtr/aNNeVdYVMxD/N5baDhAgtri
	jCEif+T5ItbkItFoFwcG433MfDBBqjY0Rcc/tyBVruISEoo9DhnaFnfyw+bsT7TH6G0hOtnk982
	wJh5HhBp/jZBNSGHQoGtKBConEtEz9zfF7Zqp1Ftis8PEt3waV0VQqdRpg41TK4shXNI=
X-Gm-Gg: ASbGnctNvLvDeYxR+BkIcpy1CeCn7B2ZdLz26fdUWFdlxhAtECLA4zqo2WnMbFV2YAi
	9kvN3mNZ9uf+Ubhp3zhaMBcfNcTC3j/Z23wNepwGaWAK4jO7Z5rWkmjgOtwV4OeSc0hGT7BAYAg
	4abADBzl5n0RBy3JK4HZKYULvLc13dCVpImQ0TJvRcJiVFv4MHP5mTjcvDkh+yJXYp6c9GEJuxD
	G5Wlw9tNeFlmx2VfQEw1uBGbh9O1uH8nC+vKtZlhdLZWKrt4XosE4+m37/kpQyQZSZ4DEH2LZj6
	M5jMdYYVUTvHbJWRGrxWHmSqWXB9YX6iYekUWKaKpVCL5NAh75vMbxAedsOsDGfGmADMDXdn
X-Received: by 2002:a17:903:2284:b0:269:9adf:839 with SMTP id d9443c01a7336-269ba427cb8mr164728015ad.19.1758549550893;
        Mon, 22 Sep 2025 06:59:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH7luoA89guXrr9ub3Zh3LgeWzUbhEuNH6u8kg2V5EoIg9JrZytByOaIZkx6xOS635HoUdItA==
X-Received: by 2002:a17:903:2284:b0:269:9adf:839 with SMTP id d9443c01a7336-269ba427cb8mr164727545ad.19.1758549550262;
        Mon, 22 Sep 2025 06:59:10 -0700 (PDT)
Received: from hu-faisalh-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-26980368fe3sm130638805ad.151.2025.09.22.06.59.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Sep 2025 06:59:09 -0700 (PDT)
From: Faisal Hassan <faisal.hassan@oss.qualcomm.com>
To: Vinod Koul <vkoul@kernel.org>, Kishon Vijay Abraham I <kishon@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Johan Hovold <johan+linaro@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Wesley Cheng <quic_wcheng@quicinc.com>,
        Konrad Dybcio <quic_kdybcio@quicinc.com>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc: Faisal Hassan <faisal.hassan@oss.qualcomm.com>
Subject: [PATCH] phy: qcom-qmp-combo: Use regulator_bulk_data with init_load_uA for regulator setup
Date: Mon, 22 Sep 2025 19:29:01 +0530
Message-Id: <20250922135901.2067-1-faisal.hassan@oss.qualcomm.com>
X-Mailer: git-send-email 2.17.1
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIwMDAzMyBTYWx0ZWRfX0Vy57LxnZPIR
 YGblu8HjpS5YA0RQLYJQwdFylLizpWBaYCuo4YcNOMom6x8uEFPXkflaVj+TJH50f3DsU4hViU6
 0Tu4XSiwNE7sU31BuN2bxTshRaf5ihRJdhVTR/HU6R+Mjq9kW9r/Q3A/xkzNkVP2KV4NlmiW2mK
 9JS/HtZkWdPUTQ70Onnhez5n5OwJPpINe6gfZLVTs3CLZMogRVrWd34GvBIBSwPXKRDALrdXZhS
 MbiN7KbUnfvsRLw0NUxZgVcGAgrGWfeATc2UQL0fC3DTcG5wXMkbS7iSuRlP8esSHIa0FZejoYi
 ydLxCcc301n2ffbJjNx6wN7W6tzxRPmbnBQxPAvj2Gtsc4TSRyGq+PyAegxFN/bqYQonmhc8Mi+
 qG4RxNOt
X-Proofpoint-GUID: YdV7qGtQOjW9I-syzyjICJqKV1J5xvlj
X-Proofpoint-ORIG-GUID: YdV7qGtQOjW9I-syzyjICJqKV1J5xvlj
X-Authority-Analysis: v=2.4 cv=EZrIQOmC c=1 sm=1 tr=0 ts=68d15630 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=L7zAn2INS1o54O8sslIA:9
 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-22_01,2025-09-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1015 phishscore=0 suspectscore=0 priorityscore=1501
 impostorscore=0 bulkscore=0 spamscore=0 malwarescore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2509200033
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Replace the custom qmp_regulator_data structure with the standard
regulator_bulk_data and use the init_load_uA field to set regulator
load during initialization.

This change simplifies the regulator setup by removing manual
allocation and load configuration logic, and leverages
devm_regulator_bulk_get_const() to automatically apply load settings
before enabling regulators.

Signed-off-by: Faisal Hassan <faisal.hassan@oss.qualcomm.com>
---
 drivers/phy/qualcomm/phy-qcom-qmp-combo.c | 49 +++--------------------
 1 file changed, 6 insertions(+), 43 deletions(-)

diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-combo.c b/drivers/phy/qualcomm/phy-qcom-qmp-combo.c
index f07d097b129f..97262ed63700 100644
--- a/drivers/phy/qualcomm/phy-qcom-qmp-combo.c
+++ b/drivers/phy/qualcomm/phy-qcom-qmp-combo.c
@@ -1636,14 +1636,9 @@ static const struct qmp_phy_init_tbl x1e80100_usb43dp_pcs_usb_tbl[] = {
 };
 
 /* list of regulators */
-struct qmp_regulator_data {
-	const char *name;
-	unsigned int enable_load;
-};
-
-static struct qmp_regulator_data qmp_phy_vreg_l[] = {
-	{ .name = "vdda-phy", .enable_load = 21800 },
-	{ .name = "vdda-pll", .enable_load = 36000 },
+static struct regulator_bulk_data qmp_phy_vreg_l[] = {
+	{ .supply = "vdda-phy", .init_load_uA = 21800, },
+	{ .supply = "vdda-pll", .init_load_uA = 36000, },
 };
 
 static const u8 qmp_dp_v3_pre_emphasis_hbr3_hbr2[4][4] = {
@@ -1801,7 +1796,7 @@ struct qmp_phy_cfg {
 	const char * const *reset_list;
 	int num_resets;
 	/* regulators to be requested */
-	const struct qmp_regulator_data *vreg_list;
+	const struct regulator_bulk_data *vreg_list;
 	int num_vregs;
 
 	/* array of registers with different offsets */
@@ -3403,39 +3398,6 @@ static const struct dev_pm_ops qmp_combo_pm_ops = {
 			   qmp_combo_runtime_resume, NULL)
 };
 
-static int qmp_combo_vreg_init(struct qmp_combo *qmp)
-{
-	const struct qmp_phy_cfg *cfg = qmp->cfg;
-	struct device *dev = qmp->dev;
-	int num = cfg->num_vregs;
-	int ret, i;
-
-	qmp->vregs = devm_kcalloc(dev, num, sizeof(*qmp->vregs), GFP_KERNEL);
-	if (!qmp->vregs)
-		return -ENOMEM;
-
-	for (i = 0; i < num; i++)
-		qmp->vregs[i].supply = cfg->vreg_list[i].name;
-
-	ret = devm_regulator_bulk_get(dev, num, qmp->vregs);
-	if (ret) {
-		dev_err(dev, "failed at devm_regulator_bulk_get\n");
-		return ret;
-	}
-
-	for (i = 0; i < num; i++) {
-		ret = regulator_set_load(qmp->vregs[i].consumer,
-					cfg->vreg_list[i].enable_load);
-		if (ret) {
-			dev_err(dev, "failed to set load at %s\n",
-				qmp->vregs[i].supply);
-			return ret;
-		}
-	}
-
-	return 0;
-}
-
 static int qmp_combo_reset_init(struct qmp_combo *qmp)
 {
 	const struct qmp_phy_cfg *cfg = qmp->cfg;
@@ -4003,7 +3965,8 @@ static int qmp_combo_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
-	ret = qmp_combo_vreg_init(qmp);
+	ret = devm_regulator_bulk_get_const(dev, qmp->cfg->num_vregs,
+					qmp->cfg->vreg_list, &qmp->vregs);
 	if (ret)
 		return ret;
 
-- 
2.17.1


