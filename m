Return-Path: <linux-kernel+bounces-831882-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EA98B9DCC6
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 09:08:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BF9F61B264FC
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 07:08:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 632CB2EA165;
	Thu, 25 Sep 2025 07:06:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="N32WQhdq"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 349ED2EB86A
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 07:06:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758783992; cv=none; b=UbFItJhAkfBDLjOf+LAqVFhEdMmgk5/MtAwGeYzuqX96VN96hosH/BlqUlWF4k9f8MUmhIdMl1hYy4fZzv5ILrNCsw65VspCZABFq2cdPI7XLU8oy623NBftuLYZPBEiIKw3/VesLZeidLUegEyzGWhetr05suW+GUABsr6K0D4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758783992; c=relaxed/simple;
	bh=X4PFHrUfP0rzxFwmdjEfi+hC/7SrgdK5syWA8qItXag=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lJmfIhm43m04r1LaqzOuPRRqXIxfgk7Dg/Rt/12dAZVF4B1rv92eto1n0UhpDAjEAwAYAafIcKPQhqes/2wgUVZwr1q26QzhGHbIgUT7nWFv8Ch2cE6oqSCxJKfIDspbjsPLrI9efzL+oxbuJEWjpEsA9XrGz80r9f5huccPpz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=N32WQhdq; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58P0KfEs024042
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 07:06:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	sOHfeo7BhLeEryk+wi9AeSYQSxkknTWJ2p+RSrBRhUI=; b=N32WQhdq3ymRD3Zo
	i4qGopQmu+qbIGWgAlWPAKBRLjAyD+amd3AK1kTYO7nMAgcFZDLsIDafvzHyKRL+
	AmL7lroXwB35S+aHUKb5sZWzv80k0QoXCDw80ae4yRo/eNCh4FndPB+ruIHdK24W
	8NUkW13KHN6EdNYsU2fCynL4Hm5GTi1wk5ukRP2YBtIx/kbZqP5Q+fvD9hGpvRAQ
	Rxfbdo15Tv7AFRE+RBCWShwyLYRDxIZcpCmYrycuVAWHir6ylBV7SiB6yvdtWg//
	jIzaVumtPYmyYFoqoHWpQR2+YxIoh2gHBD4kMJAk8FACQ64bcWTrPfPf6A+ah0mS
	pxGqiA==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49bwp0e5mf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 07:06:29 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-3308c669152so189487a91.0
        for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 00:06:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758783989; x=1759388789;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sOHfeo7BhLeEryk+wi9AeSYQSxkknTWJ2p+RSrBRhUI=;
        b=Tcy4GRJIA87YnbUvBrDcicxKo5LCx1ygD1TiyM3L/NGgNpA+g363s3ptJlypykGPWp
         0wmiXJQp0GI6ypTb1fExmst23f0V9K195rfu1Zc5gVbRAc/t9g/kMCU/j63XWOwEfPAK
         cEnFxVqNknWkX4vpateufdVkZk/sJnmlM8mlZOUcxLGZVGZ6XpeTGpoB7Cxy5Y/f81C2
         7OuOPkFBhyaGx4AMvSQ5DtKyd0eVHnHugTjrtEY1fIzoKuj4muBpoHicQv9ctsfsPK8Q
         Yz+vku6nEeuDnrr0wzhYjMMaeup7DVt74M2xWM2AAQdJ2arRQBkpZb0QmaHWrezrlJnh
         +7mQ==
X-Forwarded-Encrypted: i=1; AJvYcCWuujlRWiDnXmvdAvyKpXFU1JC7i1pILPoePY8BpKgslTroQ4d5eqI8PsGxzFGPRqhXVXE8U6/2QC9/gF4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxrRhi7zjEB4fu8VsTl+iPw/ooljYUVy4KgWZQQhRcjn6sCJ0kR
	e7sdNUthPAUQbhzL1oOSQWw5oSm3tLZyhdnzdNQaFgSExlsaDmy3rcScUvSV66ApneZ6L+Y9hlt
	YnM8GHEfz8Hy2ZdlQ8xcJ7PhocSdAGKEo/UJbQlnIwz9AxTD7mcztwdJA7sJdv48Vm1o=
X-Gm-Gg: ASbGnctQMa1vJ48QIurYzD/hSNM18YXPIemyNlFgTetZPUDgLgpN4YaaAHQDtduh+HA
	yAgevC5xFwMcXpI5FcBr2THuOK6I8AX1MV2QInRTqg6A25s6C5/tPBm++0ex8rB7JlFH9HBnXF4
	S9/bcZYyjQ9ff4A2SEsUl/3rY2QPyHArjhyj5iM7Rt+vYpNI63I6To1oe7/I9PenOTbND6aNoC4
	VcdiJ9LIvY8F54ZD0YsCSZppiAYJBEX87+UKvnrRqpwKar0rguQwDqVjlVs7QBpxYSM8F1M1qe4
	2+59cbJZz73w9AbUJyvhH5I2wbE8xMx1i8nxjgnRXHPeSyL/12smXXrhQ4BeIsSXy1WtxJQaS73
	7TkXyvhK2pZJ6DbQzG4ZIjJO7JksMH/w/pJBAvpwGFL7UfTKxDHSD2uAb
X-Received: by 2002:a17:90b:1642:b0:32a:8b55:5b82 with SMTP id 98e67ed59e1d1-3342a138dafmr1622716a91.0.1758783988688;
        Thu, 25 Sep 2025 00:06:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHFMPsmZvnd6dVbwELL53pC8yqLIr3147s8iCrXFpjob11Il+gTCOSC49HD8pbmJr5jpEtF9w==
X-Received: by 2002:a17:90b:1642:b0:32a:8b55:5b82 with SMTP id 98e67ed59e1d1-3342a138dafmr1622701a91.0.1758783988144;
        Thu, 25 Sep 2025 00:06:28 -0700 (PDT)
Received: from sziotdisp01-gv.qualcomm.com.ap.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3342a2bd584sm914253a91.0.2025.09.25.00.06.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Sep 2025 00:06:27 -0700 (PDT)
From: Xiangxu Yin <xiangxu.yin@oss.qualcomm.com>
Date: Thu, 25 Sep 2025 15:04:56 +0800
Subject: [PATCH v6 10/14] phy: qcom: qmp-usbc: Add USB/DP exclude handling
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250925-add-displayport-support-for-qcs615-platform-v6-10-419fe5963819@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1758783910; l=1866;
 i=xiangxu.yin@oss.qualcomm.com; s=20241125; h=from:subject:message-id;
 bh=X4PFHrUfP0rzxFwmdjEfi+hC/7SrgdK5syWA8qItXag=;
 b=w15jBmT/se5LKcZFvbQZtG5NncJK6g9/eYBpM53QIj2XHBW23jnAJfjZfDdu8EV5FM/icrIMI
 BaasMjAbiAKAsRn7tS72IxN0cw52XUOulIwMc629p4TQfSAOO9IN5Po
X-Developer-Key: i=xiangxu.yin@oss.qualcomm.com; a=ed25519;
 pk=F1TwipJzpywfbt3n/RPi4l/A4AVF+QC89XzCHgZYaOc=
X-Authority-Analysis: v=2.4 cv=KNxaDEFo c=1 sm=1 tr=0 ts=68d4e9f6 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=RloG_8Ug8mropJZ47ewA:9
 a=QEXdDO2ut3YA:10 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-GUID: jnhjtxFCE-kSdkBOF3x7colDbuBepQTO
X-Proofpoint-ORIG-GUID: jnhjtxFCE-kSdkBOF3x7colDbuBepQTO
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIzMDEzOCBTYWx0ZWRfX2w/wFcqupeF8
 ECC24Y3z2vYLP/c3hbEwf9ogo0uGWIL/JHqFEIbDTAlqQRyBqeDBn7DioSqDTWdl5Bv7ZOZ1SQ9
 cos6vkwzEHOQ4Am55DVJVEhKgOTAyyBqDGfvUPWxcBl/zhXZ/Skp/j8pn6y9NJCyFnJZ94kI3DZ
 g+vNWxtesVqOBZjFYu0WogYOf2k4GZC4Re6dKSq/GFvOTqlFLYhpF3rXE39qouyfNYymatfwKXd
 OBsibDtBCBmgDFNAUorMf9XOcfXkGXIOgRzFsU8y4LX4QMpXMy9wJktBZaSot/VIGhErKk8Gymj
 OT6iQbo2bzLYTYLng4yYHGsntSCE+Zq81e14RGgfVXLuulC0hTuXj+KgY4YiPMxeDDWrYL3JYZ7
 1R1zhM0+
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-24_07,2025-09-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 clxscore=1015 phishscore=0 suspectscore=0
 adultscore=0 bulkscore=0 spamscore=0 malwarescore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2509230138

When both USB and DP PHY modes are enabled simultaneously on the same
QMP USBC PHY, it can lead to hardware misconfiguration and undefined
behavior. This happens because the PHY resources are not designed to
operate in both modes at the same time.

To prevent this, introduce a mutual exclusion check between USB and DP
PHY modes.

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


