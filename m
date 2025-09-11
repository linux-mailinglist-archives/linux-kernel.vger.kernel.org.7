Return-Path: <linux-kernel+bounces-812344-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 15ABAB536B0
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 16:59:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2742C582D6E
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 14:58:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10731345747;
	Thu, 11 Sep 2025 14:56:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="aANXaWnH"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C12E352FC8
	for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 14:56:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757602612; cv=none; b=RPXZ9gIjiiilUqwsOfxzr3w6XGbZd+MGvuv3OqH2nF2P/GdmKx0LXVfoGEQIb//f/TXEPvI7OTNBPcE2iTani39EzDf5kKiOkdcA65tJheDaEpwFZfrbJBlm0hvSXpov0zf6d9Jf9SBsjXTo/kwBXyNKBDah/tzKIg+hP1LzlLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757602612; c=relaxed/simple;
	bh=g9Ir7Zqj4Q4z8+mdh4A2GkwyNH8GzAMmXDyXe7Z6swk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qV+7AAml9ztFvv8IGqMUnhjnkogTZaZ3PZXeucwqR8xKt6UKqSmGLXOOLdnhDEBO96Ujeicyzq6ulvkkTA10saUmo0/IjOCgbmMVJbkjykhH8XUzeUcvwl6UsrtwMCDsX/wscB3CY/20UeK/cnNad80w0kCtZdaCiEdSa8tJ3TE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=aANXaWnH; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58BAlF4n002350
	for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 14:56:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	R/i0u1DnuXxgdpameCKVEnYo7itVnONwyzPQHpKD6Jw=; b=aANXaWnHNd0bBEmx
	JolRBQNocvb9jYBXiwV4otosafTRSNJ+SDyPn+7SIte68TZ5NrVC+jE1oE0Qr7FJ
	1+rkjgls8i3AT7kGRrgYh4QpAn1HKyJ2TggJvrmxyVvBN8CkR7cWAwhfTO2wkAwc
	NJdY+hEet/ZFgJTqafSo8GrrwvTRB6Km26gwHGV4d9NZeBrivFbwGhxWLXqbHzYH
	KF6C6+ZL/3tPuQ4WFB7spG+nsk997ObF+Wp9zUQbxUTWNdgkKKoZHAUQqhDJ8Wi/
	rBMQyUUtdMwl7qahL4taoNUps1+DCMrU7B5IvuTetGrCrVHd+6iujvnA/xm0Y6K9
	ZP/H0A==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 490db8r79y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 14:56:49 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-b522934761fso38188a12.2
        for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 07:56:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757602608; x=1758207408;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=R/i0u1DnuXxgdpameCKVEnYo7itVnONwyzPQHpKD6Jw=;
        b=GaNn+TySh5rsJu/DsQ5IQ0sLX300locWmX93J6MquXiH3rpy2pKH9czuS7kvJoZnR6
         X5UHarqfAbzLsfAdDP+7xjhEQGMzqu6QpqVX0FInDWjmchZNSVOTytYcCOdcFIYUxpbg
         GAahFhv7LuTi30uj2P0nFqucxxsz3FooFNnXH1AES2RSvfDcP7H25cOH2oi7TdTACo5C
         OqvIYq+ZaKmrEn2JtbCrMaZ/4metL6tXztSjcLFCmRVehX5yRDtvCQLddQAjX97BGE8M
         C5RhHxPqSHQVib6n9qy/0vCIgHC4blINSe5jji//cKDD+JIcVN3Ep7Z6CnAEt4rTo+Iv
         Pf4w==
X-Forwarded-Encrypted: i=1; AJvYcCWhk3zAk5U6LD+kAEQN4du1SATfgu4X6u8ATS8pGtt8GJFEmm8QRUDGvMdtKLJ4CGzxT/fTCTPB28leoH4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwMU9c3Il8a/CAHjpAGUwXOgo3CclQZwsYupmxqECh/Ty7Ze+Cx
	ojqXZJ3gA6Y/lfalPmDNob7KB3XC4p5zb2I6DA9Ya6t9bz/AagseYNyshWDvBtXT/mEiN3PdrOU
	OdYNCr7yHDNhdghmF7FhDzhtm2dbYCQQBX7RnLSyub4I85YZB+P6/RTW9FYOs9WxMZt4=
X-Gm-Gg: ASbGnctPqW1YfsrH1hq/2YMn7HZRuvZOBskPnVi1OHwslOhNqp3UuHxZId5uPLtvj0i
	/oIc4b526Y8CbOPZ2ssxkdBxM7JHRU46wCnEdv+Zxx/qrnLpaQeBUi0rgjDyIOzaNRiQhBoqvXE
	nho3Q2RvPBgRdDyAz5rSs5D/FoV0c4Bytq1JkbcPT5+nhXTwfNz3dbst/CnU0NMO1RsXYzblXPt
	QUXTG9mumXBqgVSiCTMu84XriTxXqVsxCid88nUeNLn+NQ2HoYJh9rPM8jdqLQmtTqrXTz0jy3C
	H4H71yNISTJyExB4yPw8Egs+261uOkVSn9tjfcQF6Hym8f/Ftp2DtZv5XnHnQO+xajqLdqnWr+r
	KvxcrMNtxv69Z4pFDY3J5g1pvXXxKXVOOEs5mufe9B1J4KN4mXWDiVv33
X-Received: by 2002:a05:6a20:4322:b0:24a:3b34:19cb with SMTP id adf61e73a8af0-2534441f6cdmr16687144637.3.1757602607829;
        Thu, 11 Sep 2025 07:56:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGJdLqhTy32FV7HxAKLg0I05c1SykuXTMvfqc6IROeB1TisqANAWPSDFKILlfoT4H5LPXJ5uA==
X-Received: by 2002:a05:6a20:4322:b0:24a:3b34:19cb with SMTP id adf61e73a8af0-2534441f6cdmr16687125637.3.1757602607368;
        Thu, 11 Sep 2025 07:56:47 -0700 (PDT)
Received: from sziotdisp01-gv.qualcomm.com.ap.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b54a387cd4bsm2107453a12.35.2025.09.11.07.56.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Sep 2025 07:56:47 -0700 (PDT)
From: Xiangxu Yin <xiangxu.yin@oss.qualcomm.com>
Date: Thu, 11 Sep 2025 22:55:08 +0800
Subject: [PATCH v4 11/13] phy: qcom: qmp-usbc: Add USB/DP mutex handling
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250911-add-displayport-support-for-qcs615-platform-v4-11-2702bdda14ed@oss.qualcomm.com>
References: <20250911-add-displayport-support-for-qcs615-platform-v4-0-2702bdda14ed@oss.qualcomm.com>
In-Reply-To: <20250911-add-displayport-support-for-qcs615-platform-v4-0-2702bdda14ed@oss.qualcomm.com>
To: Vinod Koul <vkoul@kernel.org>, Kishon Vijay Abraham I <kishon@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
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
        li.liu@oss.qualcomm.com, tingwei.zhang@oss.qualcomm.com,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Xiangxu Yin <xiangxu.yin@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1757602528; l=1610;
 i=xiangxu.yin@oss.qualcomm.com; s=20241125; h=from:subject:message-id;
 bh=g9Ir7Zqj4Q4z8+mdh4A2GkwyNH8GzAMmXDyXe7Z6swk=;
 b=zShFKpvyuFRXIRnT3yvPFCLUyh2L+HHbKIjDXahHxUeMEbq+jDSj/Gm5JVMNb7D6BthxSFcZI
 PDNrU61G8ZOC9dCZ8/sgo78JVqZE19eXdfvyh2YWG/Q9XQmAFkMAr1r
X-Developer-Key: i=xiangxu.yin@oss.qualcomm.com; a=ed25519;
 pk=F1TwipJzpywfbt3n/RPi4l/A4AVF+QC89XzCHgZYaOc=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA2MDAzMSBTYWx0ZWRfX323WPi04OBC8
 F4GSiwslPGjhv6tiCAHyXSaodvaym8PcYIr09LQDZwfqScu5cbhEOvqngMdcmdf7Xp/mQZcLAH6
 xQCsevJCB+9B/DDmQPisafFx4pm478RBwBAlWCv4qHshDaJ4bKtR5MNpgfJOrktUlnYO+DgPqek
 jLlhvi2LaW3wHhgHEgaElMsceUpFW9uVsRDXyMNN0jxH8QNW7sN61bDb8HeaaN4xv1kO9/kS93H
 qLKpPcc8UWASEuVQFJIVKmwV0WYbKzKrEdKy4FaScS6ZpCC5aPvOJFG8bAaEp+s8WCnVzFiEX2G
 /7rOCLLttk22GtNF9DJfyEic9h/rLuQ0WXK4Js3WMLfNqtgOSUs9w/8pum8CQzylRnr7yqxX6tb
 xeh3p6sf
X-Proofpoint-ORIG-GUID: GwsZWROhCoZz6PTK-t-lLxRG8_5GaY0Z
X-Proofpoint-GUID: GwsZWROhCoZz6PTK-t-lLxRG8_5GaY0Z
X-Authority-Analysis: v=2.4 cv=VIDdn8PX c=1 sm=1 tr=0 ts=68c2e331 cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=_IuPrrw32zr4QVSE3DwA:9
 a=QEXdDO2ut3YA:10 a=_Vgx9l1VpLgwpw_dHYaR:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-11_01,2025-09-11_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 spamscore=0 suspectscore=0 bulkscore=0
 phishscore=0 adultscore=0 clxscore=1015 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509060031

Introduce mutual exclusion between USB and DP PHY modes to prevent
simultaneous activation.

Signed-off-by: Xiangxu Yin <xiangxu.yin@oss.qualcomm.com>
---
 drivers/phy/qualcomm/phy-qcom-qmp-usbc.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-usbc.c b/drivers/phy/qualcomm/phy-qcom-qmp-usbc.c
index 613239d15a6a3bba47a647db4e663713f127c93e..866277036089c588cf0c63204efb91bbec5430ae 100644
--- a/drivers/phy/qualcomm/phy-qcom-qmp-usbc.c
+++ b/drivers/phy/qualcomm/phy-qcom-qmp-usbc.c
@@ -1061,6 +1061,19 @@ static int qmp_usbc_usb_power_off(struct phy *phy)
 	return 0;
 }
 
+static int qmp_check_mutex_phy(struct qmp_usbc *qmp, bool is_dp)
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
@@ -1068,6 +1081,10 @@ static int qmp_usbc_usb_enable(struct phy *phy)
 
 	mutex_lock(&qmp->phy_mutex);
 
+	ret = qmp_check_mutex_phy(qmp, false);
+	if (ret)
+		goto out_unlock;
+
 	ret = qmp_usbc_com_init(phy);
 	if (ret)
 		goto out_unlock;
@@ -1121,6 +1138,10 @@ static int qmp_usbc_dp_enable(struct phy *phy)
 
 	mutex_lock(&qmp->phy_mutex);
 
+	ret = qmp_check_mutex_phy(qmp, true);
+	if (ret)
+		goto dp_init_unlock;
+
 	ret = qmp_usbc_com_init(phy);
 	if (ret)
 		goto dp_init_unlock;

-- 
2.34.1


