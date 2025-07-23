Return-Path: <linux-kernel+bounces-742576-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8284DB0F3E3
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 15:24:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CEB4516F79F
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 13:24:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43D0638DDB;
	Wed, 23 Jul 2025 13:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="BbU9twkP"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAC2433DF
	for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 13:23:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753277026; cv=none; b=fc3UV5kITkW50umLVy2lUi0M1FekLFeM3o2PRLdqoo33bFJ9FhhnaFHsZUHBngLojOuyV4bdKexty+jKmzJWVTYk7S1dZOy3FCa/+hHMYZYq7dmwh/icR5FetYOE0dvKtVKAKMgaxp/aYJgakwhCj4RcX2z2c+81o3sTY8Kg7jM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753277026; c=relaxed/simple;
	bh=anIv7UBD8VLP4vJM5h2MZC00iJTIhwQ67w6K2o8NnI8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=p28igaS8BaDbke8Bd6a0T4hpELCTpWvx31QMhC/kYAQ/JNLaMR62UD4AlTadd+IHIyrop3XCFNmp3PBC+XkQH5IB6Nrx6DvstiWAbCGWpH0GMgCve51wWkrV8cspwOJvrRcjSil+P74PqRkFMt5OWjpY0y9SOK8Ee6i9GBKPWDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=BbU9twkP; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56N9Skon008040
	for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 13:23:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=tWG9Dumj/u2sl28Vz4MuVl
	d5C6QI9r+ImLKTNYl6w7s=; b=BbU9twkPFMHVO/SFlrrP3+Ksf/2+0K8h5zZ3BH
	s3iws3Tl8SCPAp/+Y4amI53WANmwyx2vmC+QA4S+ObxDiU03FvjQv8rvvX9qP87c
	0NIUpyYr7VWk32olhsRNnYJnKHe6mQL3UVUhJ0q8LHISEHynmIdH9wMhPeyMZJ90
	gOQyAPkRIR4z8jwYZTyOYJ7XLNJRqmn95PExRiANjCBsYmE+J8v3KzQPajWT9ZeT
	MEgXG4cqipvvRWvAg0iKukmgGkZ+ADUSXXEg/5WvW095c3idUU6tghwvZpZlN5W1
	C+KbHQp+GTfmNr5wpAzY0yd/0GOevyiIhvA/awRunHiTN5uw==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com [209.85.219.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48047qd8fj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 13:23:42 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-6fb3487d422so101582356d6.0
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 06:23:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753277022; x=1753881822;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tWG9Dumj/u2sl28Vz4MuVld5C6QI9r+ImLKTNYl6w7s=;
        b=Q80qApYmOdTRhikOCI7drWC6VVqzDC9/mdvN0/Wrbgqw18UrK3r3CMGC824o5BVZw9
         yCX8sqwkv+xdpP0j1c5p3g43bRGsJPTdhzSk70Y2QKQc9l5CV/jgDwU7gZYq0H8dcssF
         4OlDlDQQRb2C/vdcXTrNmcict+uHF1SiG6mo2vDtF1ITiWYCDxd4lO3hNYw6mBlL7bDH
         tZtGXKz7iiveYDG/297Xk7QROXKm3VBDdLTBNWfSpahCswPfA8IkVSLKz2lNPgrGIEiK
         CN3w85D/cWxYhfG1ajlIH5Vf07KRuKrlq+aGoVCeT1/SEJ7us9hLuNzunDqZhVQMmj4U
         b0XQ==
X-Forwarded-Encrypted: i=1; AJvYcCWVBBgiEacLjvY7hh6FIejs8cnadxDGrcUhfSGGKGkFjCjZmB76IBatB8NGPwpVy7ocva02zRTpRNisRUc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7u/Pww0Y8EJtsInp2d+Ne3LDPqL9eDwLTPyThDzc9cCVvC212
	aCnyN+/Rwkm+IGIVM3KVyMfxvVRFdMVeLc6AMI+KUEwdDsAsliXwUD8eLbIivelxw6m4oQ/nx4S
	QiXJdD7xptKm2RYkcw3y5/zKhT9KtcsqldNttIHVAlyZAM0VRgNR55ex/jjAFGQb84H4=
X-Gm-Gg: ASbGncs6i3f9iMOcRQZHVr9OPtMMo6sFv9a6Xf/Xr/vFpL608HtJPYVX9qaSlHFXKuJ
	5pljpPqpujNlS9j1ZtMc0q76ASOWZR8TXyJR1Tol0ZOPLcItkKW9EOfqRbqdgIC593we9BBtx6Y
	XY3y0NpL9q3xgIycmegquQaSdx5oJ2qLy9yXtNyEmFQy9iTG+hFC2qUppLltdjn4zOqAfZVoJh7
	nB/8jqJmu+lOqC5WOB1JRZkcKhhZTfGy8Svi0/r48cGJ4ZXoE3uBb5SogkZXhaFmEqKXzmMLDLg
	6xZfUqLgrdi6mTLULuPWei32zQ94pWYu3MVv7s1e8u+Ks9gyb+mYyCPDCjqac+F/vizhsKqJW4j
	8jBrNSKCLN15YS6r+aiy7jSSx87ULyFf/PCExW7tkI3shUbIXQVuK
X-Received: by 2002:ad4:4524:0:b0:707:9b0:e5d6 with SMTP id 6a1803df08f44-70709b0ea25mr11477746d6.25.1753277021133;
        Wed, 23 Jul 2025 06:23:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE9onlt4Azln72h1nDQG0ZF4ChtAfnqCYnLW93SKDW+UJYzjfRVMDoSUYaJ5uhPs4CUJcl8FQ==
X-Received: by 2002:ad4:4524:0:b0:707:9b0:e5d6 with SMTP id 6a1803df08f44-70709b0ea25mr11477336d6.25.1753277020608;
        Wed, 23 Jul 2025 06:23:40 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55a4ee536ccsm387931e87.179.2025.07.23.06.23.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Jul 2025 06:23:38 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Wed, 23 Jul 2025 16:23:37 +0300
Subject: [PATCH v2] soc: qcom: ubwc: provide no-UBWC configuration
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250723-ubwc-no-ubwc-v2-1-825e1ee54ba5@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIAFjigGgC/3WMyw6CMBREf4XctSV9WEld+R+GRS0XaSIUe6VqS
 P/dims3MzmTzFmBMHokOFYrREyefJgKyF0FbrDTFZnvCoPkUvOGH9hyeTo2hV8rp40wslHIFZT
 LHLH3r013bgsPnh4hvjd7Et/1jygJJhgqo7W0lu+7/hSI6vtiby6MY10C2pzzB6AKU5CvAAAA
X-Change-ID: 20250706-ubwc-no-ubwc-3c5919273e03
To: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Rob Clark <robin.clark@oss.qualcomm.com>
Cc: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2548;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=anIv7UBD8VLP4vJM5h2MZC00iJTIhwQ67w6K2o8NnI8=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBogOJaxaCr/gcCZWyHuVgzn/MgGo//mAlSYqc6X
 HFfMWJc15SJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCaIDiWgAKCRCLPIo+Aiko
 1ceJB/4xh1Vu3lQYPxaXIi48J72Xok30pM63ksfuWfGthvySMgGbAcQYPIUvf9S00BGBXPRHJX2
 pOPZ7+tKVnnlJjTCrbJ+QGijPcp+Y1hdN+h6QIO9sZi1X0BqSF6aoAWPz+vphJN/1floLXmFqM3
 zc2by4aBVCZgzQBrX5LpKRtjfUfQryJJdhQ24lLnWtxSC07olg+nrTGowKG2ohKQSk8cFeJf2/z
 Zca+1Tld0AjzbA3HsP6T9BQQA9BQy9QgQU2cGcCJkLPLqP2nrJdelJ49C4mjO6aDp1cqKs046jt
 pUteGkrTOb1KQoncaPackjaFXSxAq27VYTVi1foDgRiC2K5h
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzIzMDExNSBTYWx0ZWRfX1jORrdwzUHAc
 vYaUx2dzNms6Q71S/r4nxQFAaR9f0KfGJ/l2bUJKA//zzO8uJ/2ZLVJuBJkaKINkn4qaJ2pTVGg
 9jLM9+ks6Pao+qixO3R/OaSP4CDGt4IqZbh4MQshVCg15kPjYl1B9gcF3GG5E3B7U2BVyitl8/8
 DTzEYYyyJoCxZo1dw1wP5/JwNGRKFGJjy2kahTg2n9q3zQAQWrVfTdvroBvbVgSBzKecZ0MhXZU
 7zotI886BCzaNi773r3k0qwA88dqwxma24V0NhG3YAPwYqHwWuXExTRiH0Qe513cX6CAUZZwNlI
 pO9gU/BdlVyb9ARLe2DTUVgP1JBoXReiEylb55Y9g6cf+Qq7cDq+EpaWgaYggJhAG0edn0VZm9p
 UpeNhwq+6/v2RhqwdsfoHZBemCh0o7IXJUNGyMNO8S0y1MAq9m08vVHYpEuTIHfyPfOD4065
X-Proofpoint-ORIG-GUID: a1u_MvTbyjs9cXV5TH64VkV41f0faC-X
X-Proofpoint-GUID: a1u_MvTbyjs9cXV5TH64VkV41f0faC-X
X-Authority-Analysis: v=2.4 cv=IrMecK/g c=1 sm=1 tr=0 ts=6880e25e cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Wb1JkmetP80A:10 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=KmBlSpI0m1EwYyTWySQA:9
 a=QEXdDO2ut3YA:10 a=1HOtulTD9v-eNWfpl4qZ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-23_02,2025-07-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 malwarescore=0 adultscore=0 clxscore=1015
 priorityscore=1501 spamscore=0 mlxscore=0 mlxlogscore=999 phishscore=0
 impostorscore=0 bulkscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507230115

After the commit 45a2974157d2 ("drm/msm: Use the central UBWC config
database") the MDSS driver errors out if UBWC database didn't provide it
with the UBWC configuration. Make UBWC database return zero data for
MSM8916 / APQ8016, MSM8974 / APQ8074, MSM8226 and MSM8939.

Fixes: 1924272b9ce1 ("soc: qcom: Add UBWC config provider")
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
Note: the driver is a part of drivers/soc, but as it got merged through
drm/msm tree, this fix should also go through the drm/msm tree.
---
Changes in v2:
- Added APQ8026 to the list (Luca Weiss)
- Link to v1: https://lore.kernel.org/r/20250706-ubwc-no-ubwc-v1-1-e39552aa04df@oss.qualcomm.com
---
 drivers/soc/qcom/ubwc_config.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/soc/qcom/ubwc_config.c b/drivers/soc/qcom/ubwc_config.c
index bd0a98aad9f3b222abcf0a7af85a318caffa9841..9002fc9373ce349c129889ab58f87cd59591de63 100644
--- a/drivers/soc/qcom/ubwc_config.c
+++ b/drivers/soc/qcom/ubwc_config.c
@@ -12,6 +12,10 @@
 
 #include <linux/soc/qcom/ubwc.h>
 
+static const struct qcom_ubwc_cfg_data no_ubwc_data = {
+	/* no UBWC, no HBB */
+};
+
 static const struct qcom_ubwc_cfg_data msm8937_data = {
 	.ubwc_enc_version = UBWC_1_0,
 	.ubwc_dec_version = UBWC_1_0,
@@ -215,11 +219,18 @@ static const struct qcom_ubwc_cfg_data x1e80100_data = {
 };
 
 static const struct of_device_id qcom_ubwc_configs[] __maybe_unused = {
+	{ .compatible = "qcom,apq8016", .data = &no_ubwc_data },
+	{ .compatible = "qcom,apq8026", .data = &no_ubwc_data },
+	{ .compatible = "qcom,apq8074", .data = &no_ubwc_data },
 	{ .compatible = "qcom,apq8096", .data = &msm8998_data },
+	{ .compatible = "qcom,msm8226", .data = &no_ubwc_data },
+	{ .compatible = "qcom,msm8916", .data = &no_ubwc_data },
 	{ .compatible = "qcom,msm8917", .data = &msm8937_data },
 	{ .compatible = "qcom,msm8937", .data = &msm8937_data },
+	{ .compatible = "qcom,msm8939", .data = &no_ubwc_data },
 	{ .compatible = "qcom,msm8953", .data = &msm8937_data },
 	{ .compatible = "qcom,msm8956", .data = &msm8937_data },
+	{ .compatible = "qcom,msm8974", .data = &no_ubwc_data },
 	{ .compatible = "qcom,msm8976", .data = &msm8937_data },
 	{ .compatible = "qcom,msm8996", .data = &msm8998_data },
 	{ .compatible = "qcom,msm8998", .data = &msm8998_data },

---
base-commit: a933d3dc1968fcfb0ab72879ec304b1971ed1b9a
change-id: 20250706-ubwc-no-ubwc-3c5919273e03

Best regards,
-- 
With best wishes
Dmitry


