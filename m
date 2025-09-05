Return-Path: <linux-kernel+bounces-802584-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AE662B45435
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 12:13:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4A59916D4D0
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 10:13:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A22F2C158A;
	Fri,  5 Sep 2025 10:13:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="R21J42/g"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D643B2C0F84
	for <linux-kernel@vger.kernel.org>; Fri,  5 Sep 2025 10:12:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757067179; cv=none; b=QyGjNLPAdMwNOocngeLFQmuQWb+bJPH5xyH9M4WkyUoLMLvPK/Y0a4PCVzOUlnGYukG29M5rFa4NusoviPFD/Xdn16o+DmmTzsNKZElLsaEimrjp6NeixP5/+/ct30MsuG4ksZvLiYh+JADrI8GrIUELet0+NVnvP1sKuiDyIQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757067179; c=relaxed/simple;
	bh=0a1aeU90EQ+A03GlHHwBOCtK0GG5iwSC4jZv8deRBm4=;
	h=From:To:Cc:Subject:Date:Message-Id; b=aCcIJ96t9cHVQPjbrUfNjoYknpV7IkYbUkRyVov9IE9+O1RkRaM8TLUnWpB3PXhKC7wRKQiGVZTeNg8Qb+fommkc5X0z2mrKNWrdGRLQfn4KWQxz10szjus8XDbTxbrHNwhbuomNWtLFLpTRD5Kp7RenooEpeqzfOLlpwXeBnms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=R21J42/g; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5854p84D018575
	for <linux-kernel@vger.kernel.org>; Fri, 5 Sep 2025 10:12:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:date:from:message-id:subject:to; s=qcppdkim1; bh=BPWrSW4OlmxV
	S+oW/yAP6q3qPb7cDC+1hkUG3VlnF/Q=; b=R21J42/gc/bHLcWdV5WnkB+GVY7l
	vJwvcJ4Fv7TZLVnAAhMXXwH663DqLur4oPbnXx1yhCab1Se1VipHwsleNXCvPyCv
	LTv746TWqABs8alMCvk0D2Y389k9TeG76TSKOwEtPc9io2sSffzpbbN4PTvrZSqn
	s1jrR8f73uSIsSqWl74IiRDl5UkiNH3FSmZ5Unx1s90i5YCtxzub/xBxx5uzbMr3
	QXCdbvS7KFunm5NtlB9jqikpDCh8rfS4MN/JdFzzPt+9xjeOUDnOldRq9R2TrPqh
	ffiRj1AHvsm4ffX9o67tWJ6CE06/2XG/AK9LNFDdKItra8Kox/VB1eubNA==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48yebutmsr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 05 Sep 2025 10:12:55 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-76e6e71f7c6so2026441b3a.0
        for <linux-kernel@vger.kernel.org>; Fri, 05 Sep 2025 03:12:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757067174; x=1757671974;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BPWrSW4OlmxVS+oW/yAP6q3qPb7cDC+1hkUG3VlnF/Q=;
        b=D7N0i213Ls/8N79HtPBKl5LW8yrjhj8n4BMAzTP4Eoj0tuFbThlr90Fu4mjpf56YsB
         IRXnbKeBr+7I+IvnJ6ki6JvzieEjDfW8dM69Zs6ILQ08KHjdQCn5D9KKVk/R8UPkh1P9
         W3wNkqc5WhbnAi10uqxZC0RhjQunjemiu6jpbEK8R4utOOBmtP75g8198XtRvFJUIW4p
         pLbJRnpEqjs1kyHdWndqaWVB+X6htbTrd3M5kCD793VvTidPJawXRMSNcrFWm0T+nVuH
         julLpfOhnkh6uiTHHes9J1f3WTJcnT7y/IDmxBFFiyXxZv4s/NLjIIZLbsFcpz1aHNAA
         FuEw==
X-Forwarded-Encrypted: i=1; AJvYcCVVBIDCo/JGGkDz078gRCqdq02MblGEKgOnrjn11fCeGyZEH/dDuV1qfMDAYCjF8WI4/cnuLxjlsmkDyuI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwAUW54J7/jVbPorOU6MGlS8UpNF9cEn0KKCC1SMESyy6Zq1AaB
	ns/2rjS+tc21pOLlZ4de4qLtEn2Et+RZmnL23dnHZ3ifcatj/eSZ3I0++aigJfP84gWcBzWz4Rb
	qc+zP/0FG2TWYMKrfPRnEHZUhPsRjAh/GyuCF+VIYecBxH5aYXGFxXe3lrzd9VtOZr3w=
X-Gm-Gg: ASbGncsHwkgrbSMhzmpMwBpHkNZ22eeHMRVDnFKtxhzkXgk8a1GnsmbcDlmeI/0Hyvw
	3I8Odx0nzPbXhrizIRrNgn1Lmz33hQ8/tSUzehDoYWVeVQhCh7opyPC4ALD2D6sKzm+rdFCw2FP
	OGR9e5DRJVrO0LM1/91IOef2zE7VBTxsOn/NnfLe6S+pSz8AzRy9s4bOdjotdGs8YWEe5gipPpW
	lqpggQ+4kgu1rwXG+GHUtikdmFcf7AmjXV1GAmEJijhIyIK3GH01s42mmmHQsjNBeXfvZqCc8Z5
	t2QfyOvfLAI5+PqQeEls1XCoPlXZUqFcaFwdPUPC4SHEjWyh4J1j6uQFzXmIKgKavbH5lI7N
X-Received: by 2002:a05:6a00:b84:b0:772:1a18:b8d0 with SMTP id d2e1a72fcca58-7723e3d1d5bmr21965273b3a.30.1757067174258;
        Fri, 05 Sep 2025 03:12:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH8uip5UcAX565qPWYQVvmWp5U2Fhaj75hFuYOARXkIDt89oWgdIYRjf28xKlHYEZosYe2y6w==
X-Received: by 2002:a05:6a00:b84:b0:772:1a18:b8d0 with SMTP id d2e1a72fcca58-7723e3d1d5bmr21965243b3a.30.1757067173742;
        Fri, 05 Sep 2025 03:12:53 -0700 (PDT)
Received: from hu-faisalh-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7722a269f27sm21897417b3a.12.2025.09.05.03.12.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Sep 2025 03:12:53 -0700 (PDT)
From: Faisal Hassan <faisal.hassan@oss.qualcomm.com>
To: Vinod Koul <vkoul@kernel.org>, Kishon Vijay Abraham I <kishon@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Krishna Kurapati <quic_kriskura@quicinc.com>,
        Johan Hovold <johan+linaro@kernel.org>,
        Chenyuan Yang <chenyuan0y@gmail.com>,
        Varadarajan Narayanan <quic_varada@quicinc.com>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc: Faisal Hassan <faisal.hassan@oss.qualcomm.com>
Subject: [PATCH] phy: qcom-qmp-usb: Set regulator load before enabling
Date: Fri,  5 Sep 2025 15:42:43 +0530
Message-Id: <20250905101243.14815-1-faisal.hassan@oss.qualcomm.com>
X-Mailer: git-send-email 2.17.1
X-Proofpoint-GUID: yNO57PqTkO4BXsDA0sr7NJTS_zVtcYm-
X-Authority-Analysis: v=2.4 cv=X+ZSKHTe c=1 sm=1 tr=0 ts=68bab7a7 cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=PsZWotwSXc4B6IEee8oA:9
 a=IoOABgeZipijB_acs4fv:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA0MDE2MyBTYWx0ZWRfX+rAF51XCDSwc
 4QA9ZUfPy5Lz9Le2esGonW4th+kPsy5ARaaxndFObvezNPT0aMRT5NWD1PWce8sZQtWc0quK2Jg
 OXskizFzPe7uQWnCNJnnj1FBG93/skcjnNMiBel0qviqNL8x/n5XEtd1v0mw62s0ImqkOW8ybgd
 Jq5MTcedAFe+AWrsYWsUDkms+ke3Nd8SZ4f9owD2ImngtfWBseqoZYvWZM2kEvnz42zfNgvw0la
 66fyM87xCeeK2kEzWk1i+1pjhWCwhnsRNE5tE6d2bO3M1PCpH597qao7Zyhqd2GF2uWoTVNSlfv
 /FvdCx83Rg4DcMlcQW6nQ6iziCZx/oda5XbVHNDoBIcSXAIPGp9J55qRfbehyAj7rNsmgE6Fu6U
 GkNRCdDR
X-Proofpoint-ORIG-GUID: yNO57PqTkO4BXsDA0sr7NJTS_zVtcYm-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-05_02,2025-09-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 clxscore=1011 impostorscore=0 phishscore=0
 malwarescore=0 adultscore=0 priorityscore=1501 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509040163
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Set the regulator load before enabling the regulators to ensure stable
operation and proper power management on platforms where regulators are
shared between the QMP USB PHY and other IP blocks.

Introduce a regulator data structure with explicit enable load values and
use the regulator framework's `init_load_uA` field along with
`devm_regulator_bulk_get_const()` to ensure that `regulator_set_load()` is
applied automatically before the first enable, providing consistent power
management behavior across platforms.

Signed-off-by: Faisal Hassan <faisal.hassan@oss.qualcomm.com>
---
 drivers/phy/qualcomm/phy-qcom-qmp-usb.c | 27 ++++++-------------------
 1 file changed, 6 insertions(+), 21 deletions(-)

diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-usb.c b/drivers/phy/qualcomm/phy-qcom-qmp-usb.c
index ed646a7e705b..8bc2dc975870 100644
--- a/drivers/phy/qualcomm/phy-qcom-qmp-usb.c
+++ b/drivers/phy/qualcomm/phy-qcom-qmp-usb.c
@@ -1266,7 +1266,7 @@ struct qmp_phy_cfg {
 	int pcs_usb_tbl_num;
 
 	/* regulators to be requested */
-	const char * const *vreg_list;
+	const struct regulator_bulk_data *vreg_list;
 	int num_vregs;
 
 	/* array of registers with different offsets */
@@ -1344,8 +1344,9 @@ static const char * const usb3phy_reset_l[] = {
 };
 
 /* list of regulators */
-static const char * const qmp_phy_vreg_l[] = {
-	"vdda-phy", "vdda-pll",
+static const struct regulator_bulk_data qmp_phy_vreg_l[] = {
+	{ .supply = "vdda-phy", .init_load_uA = 21800, },
+	{ .supply = "vdda-pll", .init_load_uA = 36000, },
 };
 
 static const struct qmp_usb_offsets qmp_usb_offsets_v3 = {
@@ -1986,23 +1987,6 @@ static const struct dev_pm_ops qmp_usb_pm_ops = {
 			   qmp_usb_runtime_resume, NULL)
 };
 
-static int qmp_usb_vreg_init(struct qmp_usb *qmp)
-{
-	const struct qmp_phy_cfg *cfg = qmp->cfg;
-	struct device *dev = qmp->dev;
-	int num = cfg->num_vregs;
-	int i;
-
-	qmp->vregs = devm_kcalloc(dev, num, sizeof(*qmp->vregs), GFP_KERNEL);
-	if (!qmp->vregs)
-		return -ENOMEM;
-
-	for (i = 0; i < num; i++)
-		qmp->vregs[i].supply = cfg->vreg_list[i];
-
-	return devm_regulator_bulk_get(dev, num, qmp->vregs);
-}
-
 static int qmp_usb_reset_init(struct qmp_usb *qmp,
 			      const char *const *reset_list,
 			      int num_resets)
@@ -2251,7 +2235,8 @@ static int qmp_usb_probe(struct platform_device *pdev)
 	if (!qmp->cfg)
 		return -EINVAL;
 
-	ret = qmp_usb_vreg_init(qmp);
+	ret = devm_regulator_bulk_get_const(dev, qmp->cfg->num_vregs,
+					qmp->cfg->vreg_list, &qmp->vregs);
 	if (ret)
 		return ret;
 
-- 
2.17.1


