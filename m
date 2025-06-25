Return-Path: <linux-kernel+bounces-701247-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 76D14AE729E
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jun 2025 00:55:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 691FF3A99E2
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jun 2025 22:54:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA58425E80D;
	Tue, 24 Jun 2025 22:53:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="CcaqReEB"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A58F25DB15
	for <linux-kernel@vger.kernel.org>; Tue, 24 Jun 2025 22:53:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750805621; cv=none; b=G0taS7iNRY5IR/zyvjT7/ZTgr4LLVHVMdi6jKGaC9rIh9f+3dhm4ppRwjUKY0pw2z8cS4NqHpwwJMYWyuMPQy3oUwqN0FCiJY+EUhlLrA8p2uGcpoK0BFGdiSMXBiddQsr5CRud8DofNzIPrLZib3df7w/RENRYpGw92coWW2bU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750805621; c=relaxed/simple;
	bh=10gNgfM3NLul0Lyvp6Astufc/GQTsX03rgRFpk/VXnQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=E+AIeMqPGU4Kqf9+U5GNtLQcsRHO4uJm/SLaTVH/akNtk6YsglbenRIUeVk0OGeQOgEif64XyjG5gRFiihE4WYornnZrifyoMkwqT3kQvxpYfvKGj0TxcAbxtS291hJRbMyForQIJfJXfa7qMS0FEmhXsA5sm5Rnann5cKKodLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=CcaqReEB; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55OFUYNJ014481
	for <linux-kernel@vger.kernel.org>; Tue, 24 Jun 2025 22:53:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	kLyjXarH3NxxVphHpKrSoQJeGy8UWV9LCHE1PIZu+X8=; b=CcaqReEBMOKyP3Y6
	X4BNpgQo59ePfMKqCFVaf80eDWB7uXNgkLPOSQfRTjRlCl1E+3XvJrbwJkNblyN/
	ru0epCWx/gsetknq+L+08HHKuU4xNS/vOsZZ3qIi1pzgDGpZI3M3OL/95CkTdX6g
	ku+1JDxpMnDijpBwkkNuTq99ghw9DL1caziDAacFOBYhT7WMkiJ/Q64ndUi2rjJm
	3TPcp0qf0wu0w8BBKOFF3PhC8jIMoA7PmG7u17M3ZHicHPfrSIXUzIhs695QzqHf
	WUZUKKygVPks5DjRcZbxvIcY/NN+pKN1TszvrVv0qJZwcB0PjhtUXKhAG3usXBZs
	N0mzNA==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47evc5pwwm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 24 Jun 2025 22:53:39 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-7d09ed509aaso143944285a.3
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jun 2025 15:53:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750805618; x=1751410418;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kLyjXarH3NxxVphHpKrSoQJeGy8UWV9LCHE1PIZu+X8=;
        b=hA4empv29YxjEZKpghtwmADWo6r3MVv0grdfPFHE1PZAke229UTolOLscQXfr9K5E5
         tB4gXAhykYG/gdzy3gprXIoy1Tt4rIXPNH/CqB3LCklbKO2TK5wIJdhIMF60Tn0eirbR
         LdtwVkUFkrWPe4sKRNe6nTJ2DG/QrsBxNYD1CpnsOM7zCPAfs2flkNKuh5yUu+bf/rlZ
         Kge09ItUhtP1b6oxQ9hWCX0mFsr+e+JaitcLPn5hVrlmVi7Delpe8EjAo7k/8bo44rSs
         LkaVNG1w+ug+ARmXIVBdDBAx5Y/fO5myAwYhyAghlYvBuo9ELOCXtt2noXYjsaaNwKK4
         55cw==
X-Forwarded-Encrypted: i=1; AJvYcCXyk5jkjZ0MKidFffUEwT2U7/e7oDFjWJnRQQHxJWI+5t0Z73d1NAxnfZxW+YozitbL7m2xnhwcRZIXjrA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyembNUJEaJ7ybIrruXfULhcGFFQuE24kJiUS3Pr7Eu+9jB/byw
	j9p7mITyRKz1W0vGNXnWs02+T5jNa0AybDW3qHylSDR1dM6JfQIiD6BrXaarx1xFA7SSIrQ8rmR
	6vfJOoCYii9i3uunirPDCDqDlx/fg8kWLpgT6ZEzpGNkx+N+tT5pxTLhroqfrR07Oo6A=
X-Gm-Gg: ASbGncvhB6IGKZfQ0RUstM9x5XX+bA6GsBqRfBPULrpLHQtjBCoVj7W+WRvcByixFkw
	NCP5CjZspSCaLLltH/a1fi7fsYSR79tkNQtQmRhgVyZFGOKvxHfYCAjz39pdY2g1zc0yMEMBghq
	QV3K0LmXyCH2WARwPpowQ9oMN5cQoinJlFToWAJ8oko5hnDGURchZ+mgDE1mPcqhcSTTbntIysk
	P1eMMzBaxeIrtxzUPA781K/jhkRGK5vppWgCfG/lyf3aCABie4hLjJ/PVmyBdZUWkKh3UjK0aiT
	QIFimkJyGkMyi8UWXbjPzO+H1B30zXSK2PzR2YVDZltpCab0QvwwYnfos7vQlrOBT4wvuTMgKnz
	VT5wjXdPjaTyjFxsP+bkOo/4f0/ckGE+6yxw=
X-Received: by 2002:a05:620a:8909:b0:7cc:8a39:29df with SMTP id af79cd13be357-7d429682a21mr124612585a.9.1750805617759;
        Tue, 24 Jun 2025 15:53:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEZxK9WPfey371JlMI0Kl4hLep054ivdk3i6Eea6xZKRyLE1cASq3xVBO4HuRkxNhUSWqi4YA==
X-Received: by 2002:a05:620a:8909:b0:7cc:8a39:29df with SMTP id af79cd13be357-7d429682a21mr124610385a.9.1750805617356;
        Tue, 24 Jun 2025 15:53:37 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-32b97f5980bsm17843851fa.7.2025.06.24.15.53.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Jun 2025 15:53:36 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Wed, 25 Jun 2025 01:53:25 +0300
Subject: [PATCH v4 6/8] firmware: qcom: scm: add modparam to control
 QSEECOM enablement
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250625-more-qseecom-v4-6-aacca9306cee@oss.qualcomm.com>
References: <20250625-more-qseecom-v4-0-aacca9306cee@oss.qualcomm.com>
In-Reply-To: <20250625-more-qseecom-v4-0-aacca9306cee@oss.qualcomm.com>
To: Bjorn Andersson <andersson@kernel.org>,
        Maximilian Luz <luzmaximilian@gmail.com>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Ard Biesheuvel <ardb@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: Johan Hovold <johan@kernel.org>, Steev Klimaszewski <steev@kali.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-efi@vger.kernel.org,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3296;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=LSGRg6DIU9mZ8qaOnuLygzuTIKAfgHLBLlkkYZmls7Q=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBoWyxjCwze5H4PJrYGDKeCZ+ZE1H8HAI/i6tIA4
 wCU2yG+GNmJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCaFssYwAKCRCLPIo+Aiko
 1dZFB/sE5W+i0dAxLPDzpyGeTG873x/4R3cwGF2Y9j4Z+buQwj7IE9C6VGiwSlirgQ9fVT8OTyQ
 mll8AB+gUVPIVXEB4I/Bze3t17g5U05usUORTdxcm/jT8VlPTQuW98XPztrdsXrbK+LWrRyb7nc
 r6dazSY4ndz4wC4Vs4lYXxWCwrBgadm5AyMlXhf7ALTBxBrm7y4yFYm6A/iUFGmKP+p28Xxk3zd
 OGkjk03eFtn7tEbX7CTMsXu+8lzUvmWd4+HaV52ryVoOd99TfPJ6+V/iizC8OlCk2bCun98jz3H
 dVoU+UHIb3NxoejIj31WOPylqSpkfIERZYudUT6gnuv5FZ80
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-GUID: ipgKcLruM75-MIQEEh_euExMQPl5xMuC
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjI0MDE4MiBTYWx0ZWRfX+h7a9ZustEjc
 vk/xbG2PMZhc8zqovJngcT4Kkc5q5qSv3GBaND5LN2DvJkwYVraBfe5t6v/BYvm2/vNEwqFnawl
 k6ACNKup+CpwHLoEhHKO4ZSuHoXQiNFfYNAk/YgAEw/0pMWd6LCErBpFgn6gEEbMOpZu6azA4Bn
 jLEfTjvLsJn2rf91FjtSXpZAZdrI/aS2NhqlFicKVUhwKcjHSAkYMDBNlJHsuRWrGh2cCu9OoGf
 ZEvttT2K+hDLhyMY86qBUaKwRllkiLuyJe1xi0x9pL+LkTzh69ftPmheMmJV3appUYLILbM42kH
 ylqvSRHZ9f+QV7HV4JyFZ0ElKfDxqooMh4LkFwF9RbVW0fv4PXXjX7rueXTs4TUyzKKt3qJizbK
 gYUot36bXlvptu/dPqVMZoKyEdcbIUwapbNfStcVFN526aRU6/To/Al1PLSSujRSmJBWz5u8
X-Authority-Analysis: v=2.4 cv=caHSrmDM c=1 sm=1 tr=0 ts=685b2c73 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=6IFa9wvqVegA:10 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=JMKUWE_9wimnfyHsXasA:9
 a=QEXdDO2ut3YA:10 a=NFOGd7dJGGMPyQGDc5-O:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: ipgKcLruM75-MIQEEh_euExMQPl5xMuC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-06-24_06,2025-06-23_07,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 mlxlogscore=999 suspectscore=0 priorityscore=1501
 lowpriorityscore=0 bulkscore=0 adultscore=0 mlxscore=0 spamscore=0
 malwarescore=0 phishscore=0 clxscore=1015 classifier=spam authscore=0
 authtc=n/a authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2506240182

From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

In preparation to enabling QSEECOM for the platforms rather than
individual machines provide a mechanism for the user to override default
selection. Allow users to use qcom_scm.qseecom modparam.

Setting it to 'force' will enable QSEECOM even if it disabled or not
handled by the allowlist.

Setting it to 'off' will forcibly disable the QSEECOM interface,
allowing incompatible machines to function.

Setting it to 'roefivars' will enable the QSEECOM interface, making UEFI
variables read-only.

All other values mean 'auto', trusting the allowlist in the module.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 drivers/firmware/qcom/qcom_scm.c | 27 ++++++++++++++++++++++++---
 1 file changed, 24 insertions(+), 3 deletions(-)

diff --git a/drivers/firmware/qcom/qcom_scm.c b/drivers/firmware/qcom/qcom_scm.c
index 27ef2497089e11b5a902d949de2e16b7443a2ca4..5bf59eba2a863ba16e59df7fa2de1c50b0a218d0 100644
--- a/drivers/firmware/qcom/qcom_scm.c
+++ b/drivers/firmware/qcom/qcom_scm.c
@@ -1983,9 +1983,14 @@ EXPORT_SYMBOL_GPL(qcom_scm_qseecom_app_send);
 
 static unsigned long qcom_qseecom_ro_uefi = QCOM_QSEECOM_QUIRK_RO_UEFIVARS;
 
+static char *qseecom = "auto";
+MODULE_PARM_DESC(qseecom, "Enable QSEECOM interface (force | roefivars | off | auto)");
+module_param(qseecom, charp, 0);
+
 /*
  * We do not yet support re-entrant calls via the qseecom interface. To prevent
- + any potential issues with this, only allow validated machines for now.
+ * any potential issues with this, only allow validated machines for now. Users
+ * still can manually enable or disable it via the qcom_scm.qseecom modparam.
  */
 static const struct of_device_id qcom_scm_qseecom_allowlist[] __maybe_unused = {
 	{ .compatible = "asus,vivobook-s15" },
@@ -2013,11 +2018,27 @@ static const struct of_device_id qcom_scm_qseecom_allowlist[] __maybe_unused = {
 	{ }
 };
 
-static bool qcom_scm_qseecom_machine_is_allowed(unsigned long *quirks)
+static bool qcom_scm_qseecom_machine_is_allowed(struct device *scm_dev,
+						unsigned long *quirks)
 {
 	const struct of_device_id *match;
 	struct device_node *np;
 
+	if (!strcmp(qseecom, "off")) {
+		dev_info(scm_dev, "qseecom: disabled by modparam\n");
+		return false;
+	} else if (!strcmp(qseecom, "force")) {
+		dev_info(scm_dev, "qseecom: forcibly enabled\n");
+		*quirks = 0;
+		return true;
+	} else if (!strcmp(qseecom, "roefivars")) {
+		dev_info(scm_dev, "qseecom: enabling with R/O UEFI variables\n");
+		*quirks = QCOM_QSEECOM_QUIRK_RO_UEFIVARS;
+		return true;
+	} else if (strcmp(qseecom, "auto")) {
+		dev_warn(scm_dev, "qseecom: invalid value for the modparam, ignoring\n");
+	}
+
 	np = of_find_node_by_path("/");
 	if (!np)
 		return false;
@@ -2065,7 +2086,7 @@ static int qcom_scm_qseecom_init(struct qcom_scm *scm)
 
 	dev_info(scm->dev, "qseecom: found qseecom with version 0x%x\n", version);
 
-	if (!qcom_scm_qseecom_machine_is_allowed(&quirks)) {
+	if (!qcom_scm_qseecom_machine_is_allowed(scm->dev, &quirks)) {
 		dev_info(scm->dev, "qseecom: untested machine, skipping\n");
 		return 0;
 	}

-- 
2.39.5


