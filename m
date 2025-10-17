Return-Path: <linux-kernel+bounces-857091-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CDE1BE5E52
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 02:31:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C6BFC5E780B
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 00:31:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A71A236435;
	Fri, 17 Oct 2025 00:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Nv/6+oTR"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDE9721C9EA
	for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 00:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760661043; cv=none; b=TN+3oVbDeiXNHtg+cEh2h6sKYdW+NcraqyArACaETAFUZ9+1f3e+NPuYuH6b1H7BebNnoG9LdmevlUIH26bT6xluXzSo9Hs8zvN11yimjhpfUxvuETPM34dkThlIcQXBDqX7AmUeUPYpDSZjdeeqYoVU/ZOqzAZh2raHjapOEN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760661043; c=relaxed/simple;
	bh=RU9u5+e96IskdKy79odK/nlpmnOUEqJHM5ulM9nXXPA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=G4CY3doXgCdwuyJutLPAq33HBeSRbeQF24oPyge9aC/zY/q0hheMiOySeUvU5v4OFiY1BgpJXOJnFG30uRRa09ciXkGt1EihHi7lV2lSb+Ev/0NmcJ7A9n5v4GUnFNfT6S1WLdwWm4NgXxPlyT5dmk+O2ABWq354pjspVrKfjE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Nv/6+oTR; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59GKLRBe002098
	for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 00:30:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=wpu47feRnS3
	JH7+rgGPW+V0fZ+MEpc12dYMVX48Lock=; b=Nv/6+oTRgyYG17bC+QOCQgSY0Nb
	UGlxpdK+31nkQg++9X0lFLRdmwKmTMbp0neZzKPVX27agiOdlzQk/Znl32qMoays
	qAOJ4TDhcKY8nobZYY3rC+VwUjy05v2/jdAiBgkKCVwmx9fK+OHugio0KBz1nBa0
	ySn4E8Jl5YmwwN6gB4FXUN+pa0X/J9hx8aZjncAY7QmOhuVhUi6Tb8mIbbiPdY5a
	9YTKwcS9BqysRE2O1AaEw+Jy5KPG02Kmdqg1VBVc9BmpXo3VSShYohVdYyv9BfIy
	uJMb14fnJD3Gm7CszzK0hVrZZ//UoX7pwxsnNPcmfrQG1yDrhRn317qKM6A==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49qfa8jaen-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 00:30:40 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-7a144677fd9so2446725b3a.3
        for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 17:30:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760661040; x=1761265840;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wpu47feRnS3JH7+rgGPW+V0fZ+MEpc12dYMVX48Lock=;
        b=ixec46yIN8+Yg0+IUsg+f2lOw5IAYdWFuP52nmWoKVBIk70GSiIlsvas4wlnNgZTtM
         ys+L/D0waU+XuY8zrZwvE/u6QuLnJmjZNzaM/+P1l8lqpxhfUQwYWhFOL6byDXqSszBh
         KYl2tfSuEUbxrVwuRBMJGkQh/1pKwAMHmZLkpi1C+WCKbQivdBrNXisrdgaxvxKmZjLa
         9Jo+IZPXqbfIjQQBr9ipBmI0oE8HvaJWY4OdYCyWrCdxIB+m6HVzwUQjtMTZjSv3w4GU
         pYahElRPQ21TBumgdyIBIlyRnQC7qBk+9sufQVUxlvUmdSzbXPiIVaHa7LmYPkH4ynBy
         g8vg==
X-Forwarded-Encrypted: i=1; AJvYcCXYtZBiuN9yte1RDhV6BeVN+OBFp9jRLx+SqsyfE0vdkYJH19UcyamTyubhGOAXX90iK47GXUAbS3JdWiM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzfjUVn+tv+8SeIjB8tA+fgrq1GBjksteO/tvNtriYxo60+e4LH
	Kb+E4l6p+gO0JhtIPltmG6vbY1RihIHX++AgH7D0dXg7HeRS8MwHngLu1ihYuFPxoJVHKv5BC14
	VeNHsm3jKOADyx9XOAhGR6L2wCe6L2Ikr3srEvWFDX6HY4fkuL2yvGKPq1j5Xv6VkIkE=
X-Gm-Gg: ASbGncvr6TK3J9AWqzi2G63lutG5d93ws7Zz8uSsuZgMMLST7ZAqqISm1ZPghlkw7Pk
	sMs0M5vtMXtfsKPZlgIWpdqk8At2hGctsHbzghiSgIM+sDd8oRuXXBlWMG0GR4aS8solLa7nPaw
	zIksR3GIhp0cHkvzDcNmiDQasi/fVrarWgdfcw3ojyu0Vm4flEC/10eNhol3j7CY3iF/qaU/mke
	0W/mZGlbNAA9Ght7EmYp0fwdIZcGqSlGS3SRhyo1+RRCUzar5eIZqqTHwxvhJUQkNU7saxiu/QQ
	CpyB7I+vJGIT9ABHLlkYfSeS4Xci3vvHFaYV11I1DlqMOqhc+rN7EmWKmWrCVUStaoxlXOrA04/
	XRRzIUsA6XUDn/tMKd6gWO4CUVWkwPjMBYEWCAZRp2bBCURwG3MNzLNBlPsql3w==
X-Received: by 2002:a05:6a00:1394:b0:781:2177:1c9b with SMTP id d2e1a72fcca58-7a220d232e6mr2450104b3a.17.1760661039528;
        Thu, 16 Oct 2025 17:30:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG2YuCrZTacPd+e4WwFad3XNi1Thwu/0jwICzedcCNVrK3jC8KhvIoGcsNp34j49mGFrBpEyQ==
X-Received: by 2002:a05:6a00:1394:b0:781:2177:1c9b with SMTP id d2e1a72fcca58-7a220d232e6mr2450074b3a.17.1760661039073;
        Thu, 16 Oct 2025 17:30:39 -0700 (PDT)
Received: from hu-amelende-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7992d0966d7sm23613050b3a.40.2025.10.16.17.30.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Oct 2025 17:30:38 -0700 (PDT)
From: Anjelique Melendez <anjelique.melendez@oss.qualcomm.com>
To: andersson@kernel.org, konradybcio@kernel.org, robh@kernel.org,
        krzk+dt@kernel.org, conor+dt@kernel.org
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] soc: qcom: pmic_glink: Add PDR service path and service name to client data
Date: Thu, 16 Oct 2025 17:30:33 -0700
Message-Id: <20251017003033.268567-4-anjelique.melendez@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251017003033.268567-1-anjelique.melendez@oss.qualcomm.com>
References: <20251017003033.268567-1-anjelique.melendez@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: bm69HleRDwCj13h9qsXvLfYEtZ6US5OK
X-Proofpoint-ORIG-GUID: bm69HleRDwCj13h9qsXvLfYEtZ6US5OK
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDExMDAxNyBTYWx0ZWRfXypLf76OEJBW+
 lvIxzPYWuoLHkBcbALMFxFOIEO1fcvtr/B+Wa+ac6pk9ZYjatWPtZrC4/eTLLQ8LJfvd0zc0gQx
 RVF8U3Rtlbap40yEazfYgM9ZOUq2tlc/40WdrHF/BtLnrtjBgSdHTIMEnTc4v3rF9dl1YxWL4OA
 pHyMEpo7tli5FJgkYP+RGSgp9CuG56cHZV/gs4WqjfBbg/s/z4D2+ZQ7HIFiUOceIVCt4y2UnuT
 cZRAgTUstyBCONbVd1mLo2MX4JU/yus9erca117TeQaQEOjlIGWBMGRPB+Nh8C+3wqWjPZfTgkP
 djTZRwdQE6gL46Pmcfo03fMCKBszrxoiB2w3uo5Bnai4nznqqYDBFMyxBQRXhKqk6deJ39KDdrX
 oYMLk9JoWszkfJYHzYKakb2hcMeysg==
X-Authority-Analysis: v=2.4 cv=JLw2csKb c=1 sm=1 tr=0 ts=68f18e30 cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8
 a=qLYHXgdTuLTpAkILo5MA:9 a=OpyuDcXvxspvyRM73sMx:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-16_04,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 phishscore=0 adultscore=0 bulkscore=0 priorityscore=1501
 impostorscore=0 suspectscore=0 malwarescore=0 spamscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510110017

Currently, the charger PD service path and service name are hard coded
however these paths are not guaranteed to be the same between PMICs. For
example, on Kaanapali, Charger FW runs on SOCCP(another subsystem) which
does not have any specific charger PDs defined.

Define PDR service path and service name as client data so that each
PMIC generation can properly define these paths.

While at it, add the qcom,kaanapali-pmic-glink compatible string.

Signed-off-by: Anjelique Melendez <anjelique.melendez@oss.qualcomm.com>
---
 drivers/soc/qcom/pmic_glink.c | 65 ++++++++++++++++++++++-------------
 1 file changed, 41 insertions(+), 24 deletions(-)

diff --git a/drivers/soc/qcom/pmic_glink.c b/drivers/soc/qcom/pmic_glink.c
index 627f96ca322e..f64449de2305 100644
--- a/drivers/soc/qcom/pmic_glink.c
+++ b/drivers/soc/qcom/pmic_glink.c
@@ -23,13 +23,19 @@ enum {
 	PMIC_GLINK_CLIENT_UCSI,
 };
 
+struct pmic_glink_data {
+	unsigned long	client_mask;
+	char		*pdr_service_name;
+	char		*pdr_service_path;
+};
+
 struct pmic_glink {
 	struct device *dev;
 	struct pdr_handle *pdr;
 
 	struct rpmsg_endpoint *ept;
 
-	unsigned long client_mask;
+	const struct pmic_glink_data *data;
 
 	struct auxiliary_device altmode_aux;
 	struct auxiliary_device ps_aux;
@@ -292,7 +298,6 @@ static struct rpmsg_driver pmic_glink_rpmsg_driver = {
 
 static int pmic_glink_probe(struct platform_device *pdev)
 {
-	const unsigned long *match_data;
 	struct pdr_service *service;
 	struct pmic_glink *pg;
 	int ret;
@@ -309,12 +314,10 @@ static int pmic_glink_probe(struct platform_device *pdev)
 	spin_lock_init(&pg->client_lock);
 	mutex_init(&pg->state_lock);
 
-	match_data = (unsigned long *)of_device_get_match_data(&pdev->dev);
-	if (!match_data)
+	pg->data = of_device_get_match_data(&pdev->dev);
+	if (!pg->data)
 		return -EINVAL;
 
-	pg->client_mask = *match_data;
-
 	pg->pdr = pdr_handle_alloc(pmic_glink_pdr_callback, pg);
 	if (IS_ERR(pg->pdr)) {
 		ret = dev_err_probe(&pdev->dev, PTR_ERR(pg->pdr),
@@ -322,27 +325,30 @@ static int pmic_glink_probe(struct platform_device *pdev)
 		return ret;
 	}
 
-	if (pg->client_mask & BIT(PMIC_GLINK_CLIENT_UCSI)) {
+	if (pg->data->client_mask & BIT(PMIC_GLINK_CLIENT_UCSI)) {
 		ret = pmic_glink_add_aux_device(pg, &pg->ucsi_aux, "ucsi");
 		if (ret)
 			goto out_release_pdr_handle;
 	}
-	if (pg->client_mask & BIT(PMIC_GLINK_CLIENT_ALTMODE)) {
+	if (pg->data->client_mask & BIT(PMIC_GLINK_CLIENT_ALTMODE)) {
 		ret = pmic_glink_add_aux_device(pg, &pg->altmode_aux, "altmode");
 		if (ret)
 			goto out_release_ucsi_aux;
 	}
-	if (pg->client_mask & BIT(PMIC_GLINK_CLIENT_BATT)) {
+	if (pg->data->client_mask & BIT(PMIC_GLINK_CLIENT_BATT)) {
 		ret = pmic_glink_add_aux_device(pg, &pg->ps_aux, "power-supply");
 		if (ret)
 			goto out_release_altmode_aux;
 	}
 
-	service = pdr_add_lookup(pg->pdr, "tms/servreg", "msm/adsp/charger_pd");
-	if (IS_ERR(service)) {
-		ret = dev_err_probe(&pdev->dev, PTR_ERR(service),
-				    "failed adding pdr lookup for charger_pd\n");
-		goto out_release_aux_devices;
+	if (pg->data->pdr_service_name && pg->data->pdr_service_path) {
+		service = pdr_add_lookup(pg->pdr, pg->data->pdr_service_name,
+					 pg->data->pdr_service_path);
+		if (IS_ERR(service)) {
+			ret = dev_err_probe(&pdev->dev, PTR_ERR(service),
+					    "failed adding pdr lookup for charger_pd\n");
+			goto out_release_aux_devices;
+		}
 	}
 
 	mutex_lock(&__pmic_glink_lock);
@@ -352,13 +358,13 @@ static int pmic_glink_probe(struct platform_device *pdev)
 	return 0;
 
 out_release_aux_devices:
-	if (pg->client_mask & BIT(PMIC_GLINK_CLIENT_BATT))
+	if (pg->data->client_mask & BIT(PMIC_GLINK_CLIENT_BATT))
 		pmic_glink_del_aux_device(pg, &pg->ps_aux);
 out_release_altmode_aux:
-	if (pg->client_mask & BIT(PMIC_GLINK_CLIENT_ALTMODE))
+	if (pg->data->client_mask & BIT(PMIC_GLINK_CLIENT_ALTMODE))
 		pmic_glink_del_aux_device(pg, &pg->altmode_aux);
 out_release_ucsi_aux:
-	if (pg->client_mask & BIT(PMIC_GLINK_CLIENT_UCSI))
+	if (pg->data->client_mask & BIT(PMIC_GLINK_CLIENT_UCSI))
 		pmic_glink_del_aux_device(pg, &pg->ucsi_aux);
 out_release_pdr_handle:
 	pdr_handle_release(pg->pdr);
@@ -372,23 +378,34 @@ static void pmic_glink_remove(struct platform_device *pdev)
 
 	pdr_handle_release(pg->pdr);
 
-	if (pg->client_mask & BIT(PMIC_GLINK_CLIENT_BATT))
+	if (pg->data->client_mask & BIT(PMIC_GLINK_CLIENT_BATT))
 		pmic_glink_del_aux_device(pg, &pg->ps_aux);
-	if (pg->client_mask & BIT(PMIC_GLINK_CLIENT_ALTMODE))
+	if (pg->data->client_mask & BIT(PMIC_GLINK_CLIENT_ALTMODE))
 		pmic_glink_del_aux_device(pg, &pg->altmode_aux);
-	if (pg->client_mask & BIT(PMIC_GLINK_CLIENT_UCSI))
+	if (pg->data->client_mask & BIT(PMIC_GLINK_CLIENT_UCSI))
 		pmic_glink_del_aux_device(pg, &pg->ucsi_aux);
 
 	guard(mutex)(&__pmic_glink_lock);
 	__pmic_glink = NULL;
 }
 
-static const unsigned long pmic_glink_sm8450_client_mask = BIT(PMIC_GLINK_CLIENT_BATT) |
-							   BIT(PMIC_GLINK_CLIENT_ALTMODE) |
-							   BIT(PMIC_GLINK_CLIENT_UCSI);
+static const struct pmic_glink_data pmic_glink_sm8450_data = {
+	.client_mask = BIT(PMIC_GLINK_CLIENT_BATT) |
+		       BIT(PMIC_GLINK_CLIENT_ALTMODE) |
+		       BIT(PMIC_GLINK_CLIENT_UCSI),
+	.pdr_service_name = "tms/servreg",
+	.pdr_service_path = "msm/adsp/charger_pd",
+};
+
+static const struct pmic_glink_data pmic_glink_kaanapali_data = {
+	.client_mask = BIT(PMIC_GLINK_CLIENT_BATT) |
+		       BIT(PMIC_GLINK_CLIENT_ALTMODE) |
+		       BIT(PMIC_GLINK_CLIENT_UCSI),
+};
 
 static const struct of_device_id pmic_glink_of_match[] = {
-	{ .compatible = "qcom,pmic-glink", .data = &pmic_glink_sm8450_client_mask },
+	{ .compatible = "qcom,kaanapali-pmic-glink", .data = &pmic_glink_kaanapali_data },
+	{ .compatible = "qcom,pmic-glink", .data = &pmic_glink_sm8450_data },
 	{}
 };
 MODULE_DEVICE_TABLE(of, pmic_glink_of_match);
-- 
2.34.1


