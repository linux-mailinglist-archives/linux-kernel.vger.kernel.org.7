Return-Path: <linux-kernel+bounces-833698-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 64905BA2C1F
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 09:29:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BB5484C4958
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 07:29:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 882C029BDB0;
	Fri, 26 Sep 2025 07:27:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="MZrHsPoM"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B1D4286D72
	for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 07:27:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758871646; cv=none; b=qHT4BAx9wcNYhRcaP/xSqua48SwXGJTLduDlK0cZju+vc72PZZkUZTtv7Pn1OdS+U8Hqc6YZR3foVc1ryGc2vyTDn+fudhAkcOtELwtuO+XZpYo+uxKJaibmzcczzptzmNdlZN/HKjJG2H7eHJYUvbewSi/pnSk7NvXudBR17Lc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758871646; c=relaxed/simple;
	bh=DPKLxEacqPPVPld/3Cw3ossBUvxFPG/ElRs6jI9aG+g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FRi0oBkcZ2POx/Mg1DN+m3t/F1BjOBg8UL9MM3Me0UeXazuVGPmIb8w3tf5Xtke0L33ETSmiiXksjUi7WZoSZqFdYLLRhGXZ5txYW+RBioKdRA7yqNQT5IyEyl6sbkb5JiFsXYE4aQgWOP1O0dpcjRadSTXtDehk5+m4fwDTasM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=MZrHsPoM; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58Q7DuV5024911
	for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 07:27:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	BBnKAQHtJIUzOuuf/k4xFN6GQiHRN0JpTaejw5fAgk8=; b=MZrHsPoMJRf4Qv7t
	g/gyESw15cUBoBQ0NM7U0rvmGcaabIU1i9HsyOExSPgwZ1Y0OFNx93A0GNbAvuaR
	C7ahVwfEwmv2FxHxBhTza2NEKZ3uHzYqJbf5qOdFRcvu/q2y1nvr3qI6sf4T8paD
	JbYZyLtyU2abpbrfU292PyoBMkzcplJedsbXatYBZYPWY0qpN6CG8DuPmfJ60YNR
	ZybP9POnattamOTLDX53KBNx5nOEz6POTf2oG9L4xDuBoBiLkOv3RQt8OsAi9/N3
	KL/OyY1vw9KzgcIJrDLIOltl5Ksz5Yj6fThvRDApV3cfj20RFODrTIDLe9EjJLVL
	FFx2NA==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49db34hvbt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 07:27:24 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-26b7fc4b7e3so4836965ad.0
        for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 00:27:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758871643; x=1759476443;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BBnKAQHtJIUzOuuf/k4xFN6GQiHRN0JpTaejw5fAgk8=;
        b=ddJHqBGjQecJzYIL0xLpyTSg9ePO6fa2IYJYK2uYg2fqVwnHnvpy+2/v4LN2Y+Frqe
         d04zSVO+ZjetbcS3nt3K+8QbFt6c0iH7IUBHmuUNwMegR27zxwX4jVF/9sJSEwpMnQW9
         SYHT5H8W54uuIvB1PgTImF1ogpYC7TB6+yV4YYBZT5rJoP1ZMWR0RtXGTmJKnEljkjTA
         uTuE9AL7JYG0u560V1ljXuNq08SrOruFH1dkk+EiVnyyaCfA1cCOPEzDNedTKwNJjZRB
         bvunnCzWFtoPz74s1hZHVJcp/ciRb0YZnrC5gJqosc4hVZ9vVwVhRNI4Hyj4xTJfNJBG
         Wmbw==
X-Forwarded-Encrypted: i=1; AJvYcCVpK/RjZk1cFlRFSLrifzdJz1IlhrF3N1xq4msvmOL2+uKWMqj1w5yroeuM6FIv/Z2cSRo/+8pV7Xwe3cw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwL7llKzj6yOOc7Iip8WZwHI/PgLwJOBdeQR9cxym0PbLisscP6
	AIhjsE5jZHXDWjeM1GpCcwoTC8nBGGGW+sAgsI/KwwENQRsAz9pnohuWCq/jaeqBYC8pl5SZ7in
	ZvjfbJTmSmpfg/NJ18CIavnjuY77LyoDOQdrU5tV626YHfHecF1p25BvC37vxNVO3fYg=
X-Gm-Gg: ASbGncvQocCTklP6n/1fvtabzMcQNYioqGc/8LIA3MTsKD/wnuEfXEdKA9cRqAsFGE2
	JGaok7KKoBZUrSi+Zzkmu3DUemigCVWMWFoFPtX6tjA5Qn4zSx//m2BFAcmw9GhfFfBCFTgTSRb
	ZMEK0P2CF4CxWpOLzAg+zV3dvA+CD/wlS6vRboEdU1SJRI2RXeCS2GleiMBo0HbHc09BjBxbV0W
	K4faMR3mPI/bqcVXVBI+HsfXH9w+/JejHpfJdQ4D9vzM/+h803gJIw7j19dduk/s/6XL57K3Kw7
	uqCYrIkucdztz17ZaFNpitz4SAqq2DxyPA3DeRgw/NtyI66SwLXUovFnD+wj00YbJJMGruQrhZv
	Wscz5QzXXKPQe8Wh30N3opuYZgfj6AWsTPXFddQA7vg7UPt4X51vf1x4y
X-Received: by 2002:a17:902:db11:b0:26b:1871:1f70 with SMTP id d9443c01a7336-27ed49df69fmr43571235ad.5.1758871642874;
        Fri, 26 Sep 2025 00:27:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHTX2igDAbPEs0gasTbZkRY3PEKRg6iD3OO1BbSDu+8oSgdmgCgwl1nIHEcronmpOxG6BZOag==
X-Received: by 2002:a17:902:db11:b0:26b:1871:1f70 with SMTP id d9443c01a7336-27ed49df69fmr43571025ad.5.1758871642379;
        Fri, 26 Sep 2025 00:27:22 -0700 (PDT)
Received: from sziotdisp01-gv.qualcomm.com.ap.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-27ed671d8a2sm45117985ad.55.2025.09.26.00.27.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Sep 2025 00:27:21 -0700 (PDT)
From: Xiangxu Yin <xiangxu.yin@oss.qualcomm.com>
Date: Fri, 26 Sep 2025 15:25:46 +0800
Subject: [PATCH v7 10/14] phy: qcom: qmp-usbc: Add USB/DP exclude handling
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250926-add-displayport-support-for-qcs615-platform-v7-10-dc5edaac6c2b@oss.qualcomm.com>
References: <20250926-add-displayport-support-for-qcs615-platform-v7-0-dc5edaac6c2b@oss.qualcomm.com>
In-Reply-To: <20250926-add-displayport-support-for-qcs615-platform-v7-0-dc5edaac6c2b@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1758871564; l=1933;
 i=xiangxu.yin@oss.qualcomm.com; s=20241125; h=from:subject:message-id;
 bh=DPKLxEacqPPVPld/3Cw3ossBUvxFPG/ElRs6jI9aG+g=;
 b=LKwRqi1oGH1DuHLM7E16LiWfNw5DOeR+8o8s9eF6SZvkMm3iSdaWji+J524cD6f83xQZU7P4x
 jx9iHVmnqEvCOsMZMAFLUJLwoQrBPzoPBnQelsJeE52ZLRbP7VKfXfm
X-Developer-Key: i=xiangxu.yin@oss.qualcomm.com; a=ed25519;
 pk=F1TwipJzpywfbt3n/RPi4l/A4AVF+QC89XzCHgZYaOc=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI1MDE3MiBTYWx0ZWRfXzeTiclNCK7As
 Lp0RFB9KAyLJJLS2mrthc5tlOzKmz0GqmHfK/2UqnenXPSesJBXCTCBcbATMVYOXhZfEzQ6P/rS
 E3DucjP8I++kgvuiWCAmwcPvLiUZ90VFsN/nlbRvfoUTao2NJavMQ4UKIS8dInEYQnglE7/Qs90
 mvam/ZTjVBHcIRgVxY34G7sirClYhn8CX0fIf5z7vZvN0ELFuOyi3EFCM/BLF07RxBhMU+4KWmD
 gEYE9ayEJeTuxogkqocIda6bpZRn5mny6D1j/tkCYgjB3yKVlrlGEjDtv5A+XmipQ4sdqqRrK5l
 3ynRrgKWQbbCq3fGSq9fqDDXGAMBjZ+/PVat2DzZO92gJdsmaGtJsa7ZSJFnkpogVZZbXtXY7/L
 R3JEimc7eIgM6GYtqW1mbDdjYLgYSg==
X-Authority-Analysis: v=2.4 cv=Hb0ZjyE8 c=1 sm=1 tr=0 ts=68d6405c cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=RloG_8Ug8mropJZ47ewA:9
 a=QEXdDO2ut3YA:10 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-ORIG-GUID: KH05nZ1DInFjSvCO0uV8nNdjMHbRNpYO
X-Proofpoint-GUID: KH05nZ1DInFjSvCO0uV8nNdjMHbRNpYO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-26_02,2025-09-26_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 adultscore=0 bulkscore=0 impostorscore=0
 spamscore=0 lowpriorityscore=0 suspectscore=0 malwarescore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2509150000 definitions=main-2509250172

When both USB and DP PHY modes are enabled simultaneously on the same
QMP USBC PHY, it can lead to hardware misconfiguration and undefined
behavior. This happens because the PHY resources are not designed to
operate in both modes at the same time.

To prevent this, introduce a mutual exclusion check between USB and DP
PHY modes.

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Signed-off-by: Xiangxu Yin <xiangxu.yin@oss.qualcomm.com>
---
 drivers/phy/qualcomm/phy-qcom-qmp-usbc.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-usbc.c b/drivers/phy/qualcomm/phy-qcom-qmp-usbc.c
index 3580c19fd62e02aa373cec42e9f53143f39214df..d84bf68940043bce13565503bb34796e653adbb7 100644
--- a/drivers/phy/qualcomm/phy-qcom-qmp-usbc.c
+++ b/drivers/phy/qualcomm/phy-qcom-qmp-usbc.c
@@ -666,6 +666,19 @@ static int qmp_usbc_usb_power_off(struct phy *phy)
 	return 0;
 }
 
+static int qmp_usbc_check_phy_status(struct qmp_usbc *qmp, bool is_dp)
+{
+	if ((is_dp && qmp->usb_init_count) ||
+	    (!is_dp && qmp->dp_init_count)) {
+		dev_err(qmp->dev,
+			"PHY is configured for %s, can not enable %s\n",
+			is_dp ? "USB" : "DP", is_dp ? "DP" : "USB");
+		return -EBUSY;
+	}
+
+	return 0;
+}
+
 static int qmp_usbc_usb_enable(struct phy *phy)
 {
 	struct qmp_usbc *qmp = phy_get_drvdata(phy);
@@ -673,6 +686,10 @@ static int qmp_usbc_usb_enable(struct phy *phy)
 
 	mutex_lock(&qmp->phy_mutex);
 
+	ret = qmp_usbc_check_phy_status(qmp, false);
+	if (ret)
+		goto out_unlock;
+
 	ret = qmp_usbc_com_init(phy);
 	if (ret)
 		goto out_unlock;
@@ -726,6 +743,10 @@ static int qmp_usbc_dp_enable(struct phy *phy)
 
 	mutex_lock(&qmp->phy_mutex);
 
+	ret = qmp_usbc_check_phy_status(qmp, true);
+	if (ret)
+		goto dp_init_unlock;
+
 	ret = qmp_usbc_com_init(phy);
 	if (ret)
 		goto dp_init_unlock;

-- 
2.34.1


