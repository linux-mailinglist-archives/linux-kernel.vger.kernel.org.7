Return-Path: <linux-kernel+bounces-824704-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 27A78B89F29
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 16:28:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 92170189B871
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 14:28:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E9253168FE;
	Fri, 19 Sep 2025 14:26:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="SwB0s+Wy"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4637C313E31
	for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 14:26:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758291979; cv=none; b=t1gwq2Wqp2yJvzG154IVYarAoDdkyXwmJdPqmAiQ+ppi4zTWNWrzU8LJ5b/h9wGi+v/gcaGPYAKBUPmIBfuBRZNIBP39HNlZ3loNxZ35LsiYCgU+PABeH4hjM2W/nsrK1DcMwfA6P2A817tSd/xdmUIyuqvrbDaEk2XWdxBI7cI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758291979; c=relaxed/simple;
	bh=ZqkBdkbuOLKjKhpqL+qVKtuac3iLEKvjgh8IWhxZI7c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FzFVm/BVhp75LyF9WpXOl/9mzEEqqI3uaq8YjASro7xIdcejJ1RK1OQLkBViLizcPDhjAG7pVpv+Q6YOlNCRS5EFXe1L8QA+2uTtZukjNSHbxK0waVxb1bY60hOI/og6jtMi45EeIowirvXIOBEIWvp7BgY1Lvvd9CiupaXKrcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=SwB0s+Wy; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58J9Qvei011110
	for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 14:26:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	zCtPUXVGiI4OAMFxMM1v+W6OUs1HWL6gOP86Ti0GuRw=; b=SwB0s+WyW6KvaWL9
	MJlJlqhzBPohuawXRb2OtMdO7hYBzKO47yZ5mVXFGvUH8NYgnjXsC0jfI/uwYqax
	42C3B4RxEOzFl37QYjx4b3X58v6QAuLcqBaqrTool+bBEctS4kn9Z5SuvaLftLmd
	bIhH3xLqpFRpm8YCof1QwmSgqS80D73RZuUd8JPKOOJOuJdTr7EJgHK4cBTFB7tq
	KVM2mH1ZO/1imFqGV9MWY+KKRZE/r7KtJUg+KNrsjhwU+Mf4ohptGthzxtvizz9s
	+0lq17nJVsHnFfdqQWSnu4ta4qdvdzsv1DW3D2tevlEexYlLrRFhRVxlbr7Y+JqV
	0iR0Rg==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4985wx6pj6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 14:26:16 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-269b2d8af0cso2826985ad.2
        for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 07:26:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758291975; x=1758896775;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zCtPUXVGiI4OAMFxMM1v+W6OUs1HWL6gOP86Ti0GuRw=;
        b=nyhXXcSUWR7QlAoBcntWvP0IYBivh2ARSjyM6tyQEl3JNrGBmjvwt3hNCEmFHAdE40
         OnjIQnO+KF0zr/x7P2crTodHOLUtx1Tt7ycpZRzpaJloEK01HMdnDKPUlYIoQ4jo+wcc
         Uj5z8yu5Bh8nZ5VHRREAnS2FwBzmcN7w00tXB80ZDVv6wmW8FOiDYokWcOkb4AHgJBr6
         HaF+EUpZXkSsmnfAta/9AdbbnYI1egTl/TO0yCGUGHtjdvE30x/7upNym3I6FrLPzhIW
         maLg/TqFDvdcmPqXIDvx3DJQ7pPGOSroRD3jMvbq3dglXB8XBNTyqwE15XG+DMpTGlgx
         SOfQ==
X-Forwarded-Encrypted: i=1; AJvYcCXoTUsJSqgJlOzz59/gEP3Mm/eqn7+qZGa8sJxm7uy6xLipj3mZXzDoDSYXlcALjzfw7UjeT7MMYeB1LMk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3NnaeGcOJAoF+9XwG+PmoaBlF+slEazzCmNLQdRh8PX9Nf9ie
	L5z+gnS6sC+GeXHhAEYGQtWL/vDUgPMV+CS2rXGVlLccbUIr20SJzJHbxHEG8ZklA/1bvoHT9+a
	hgDG8lamOseh1rLsvN5SRQ1PuD3+cT3j/I9DainozJ10u9+myB/7xdPKMNRU3SbJwmUM=
X-Gm-Gg: ASbGnct52VudCTxhUwKd/9y9gFU8y4WT8evcAoJAAPoWaG72bF8vC/bZy0s/fh6WyUJ
	ExVnHyqhVZcIC1YR5mtEnUmqTH38Fi2VPTqXtlpSKYVbUBPC93trRpxJ0kxryldKMlH5QIHWank
	srGkI6IEwHItA1zleU2qT+obuBE0I3U5wiJOaJ1PEz46NmKhyWr344AqMcMyeSt/cGdT/D7z5o/
	DHHmKKS3hHi7w3IboF3q1+ABaNaMowBbS0gMX42pSaWWMdecs69BosCwvZPxVGCBGLTf6xPh5f1
	w0owQcTml1CdiV9RKL16Omzc5/yaCLzT4ujWPfJWj7GW4Z8Rba9++UVfFUsG5ol3EHERb7nOWtr
	4V7rTk0yJMuTTLQ==
X-Received: by 2002:a17:903:60f:b0:269:af66:5e70 with SMTP id d9443c01a7336-269ba53ab71mr18398965ad.9.1758291975555;
        Fri, 19 Sep 2025 07:26:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHjyPEK1QysizToe/QvWiGmgoytkSIQmldJZSwEnBeedNOnUc+qD02mwjMOxWcY1o8sbdk5Ew==
X-Received: by 2002:a17:903:60f:b0:269:af66:5e70 with SMTP id d9443c01a7336-269ba53ab71mr18398725ad.9.1758291974951;
        Fri, 19 Sep 2025 07:26:14 -0700 (PDT)
Received: from sziotdisp01-gv.qualcomm.com.ap.qualcomm.com ([114.94.8.21])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-26e80409ee3sm2210035ad.80.2025.09.19.07.26.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Sep 2025 07:26:14 -0700 (PDT)
From: Xiangxu Yin <xiangxu.yin@oss.qualcomm.com>
Date: Fri, 19 Sep 2025 22:24:27 +0800
Subject: [PATCH v5 10/14] phy: qcom: qmp-usbc: Add USB/DP exclude handling
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250919-add-displayport-support-for-qcs615-platform-v5-10-eae6681f4002@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1758291895; l=1866;
 i=xiangxu.yin@oss.qualcomm.com; s=20241125; h=from:subject:message-id;
 bh=ZqkBdkbuOLKjKhpqL+qVKtuac3iLEKvjgh8IWhxZI7c=;
 b=O5F9/yXwTXdOv/GVyK3wv2N1g/rrnmq7IdOhKWoKm5ItBn+rhZs3wgEhpB2OqKYvn36rwXC0W
 BAB4OJbv2SFD08xVW9qM0ZS7Z5kv7ryh+7xs6mqcF8r1i83eHo/SKIp
X-Developer-Key: i=xiangxu.yin@oss.qualcomm.com; a=ed25519;
 pk=F1TwipJzpywfbt3n/RPi4l/A4AVF+QC89XzCHgZYaOc=
X-Proofpoint-ORIG-GUID: LWPaqWdDLWvTJyajranV8PqMcWMHHjma
X-Proofpoint-GUID: LWPaqWdDLWvTJyajranV8PqMcWMHHjma
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE3MDIxOSBTYWx0ZWRfXxZ7T3poCdHIj
 GKc2HSTmhRX1L1YUUQsMbKjc5xCMlLE7wRT3eghUrxT/fZYmgzPL9na5zdlWttv326XwB1fePTi
 /j2zOzWaAXYVYOUD8LMnZxJ3WtlaoFw4U5AOa/BRwEeayroIC22cp3tyJg5wvxiiSC7NxSX4O2E
 yoOvCUa9/shIznUP7lcHTVn580qfwNNhgDxIiUVfw1QPbamYS69wnPm/hwwfVqkL/zIp/PgwSAv
 Di9PWU8M9edFs+c5+WUCgFNHUtBdJrhejpOEF2AbDqLY0iBBjwTqksGmKhdNN2s67rX3rSvoVbP
 eA98a02PIM3pR+Eu3QgNl5eCciycShlJqO9jRNFZYDXcCYm9BkkF2MLUNVKuQU+uaWgSBlqnJt9
 VUoY4qxf
X-Authority-Analysis: v=2.4 cv=Fq8F/3rq c=1 sm=1 tr=0 ts=68cd6808 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=Uz3yg00KUFJ2y2WijEJ4bw==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=RloG_8Ug8mropJZ47ewA:9
 a=QEXdDO2ut3YA:10 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-19_01,2025-09-19_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 impostorscore=0 phishscore=0 priorityscore=1501
 bulkscore=0 spamscore=0 suspectscore=0 adultscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2509170219

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
index 74dcf954845bcf8209202b75e9db10c3f6bdebd9..8030422d64382aa231d69dec9788778cdb0f218e 100644
--- a/drivers/phy/qualcomm/phy-qcom-qmp-usbc.c
+++ b/drivers/phy/qualcomm/phy-qcom-qmp-usbc.c
@@ -670,6 +670,19 @@ static int qmp_usbc_usb_power_off(struct phy *phy)
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
@@ -677,6 +690,10 @@ static int qmp_usbc_usb_enable(struct phy *phy)
 
 	mutex_lock(&qmp->phy_mutex);
 
+	ret = qmp_usbc_check_phy_status(qmp, false);
+	if (ret)
+		goto out_unlock;
+
 	ret = qmp_usbc_com_init(phy);
 	if (ret)
 		goto out_unlock;
@@ -730,6 +747,10 @@ static int qmp_usbc_dp_enable(struct phy *phy)
 
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


