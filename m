Return-Path: <linux-kernel+bounces-606797-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6318EA8B3E1
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Apr 2025 10:30:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 534457ABF3E
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Apr 2025 08:29:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 710EF2309A7;
	Wed, 16 Apr 2025 08:29:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="T0zPaJlI"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A3D523497B
	for <linux-kernel@vger.kernel.org>; Wed, 16 Apr 2025 08:29:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744792190; cv=none; b=k6PgZ3ezWbA3jj8lMUcdUWCu0oZPGRfm3sZfnjxLJqQv+YnkUEfPltPs8XNKkd/DZPSMGPN0c6GPKUKQz678iti+AXGTa6BuCDFh7X+RgVeyRFqRRZolrrIBIGNv6VqmrOsCubdOxCUOZ1hwAzl2aSMUD7X8Vw9jtZh0CakE4BM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744792190; c=relaxed/simple;
	bh=ytjddDlDLQ/8ZhINpkiVdnU51G61thVjIytF6cPUlJ0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=suOyqOKY0Ds4JManPfQtgZl14aUzpOclCAcJTiKDjB+JOtLKEV5B8J+dZS5xinp+PITBFA4OfClZ1eTYvhZhsJqa6KZef9YL56/ndOGv6f4gt2AVVCSHGvSlrYQNz4k7yuEAjARg7bZdqSO0yI6FYgKPn7iDyQBH8/QxZIWeKh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=T0zPaJlI; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53G7JdFd022289
	for <linux-kernel@vger.kernel.org>; Wed, 16 Apr 2025 08:29:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	MKA+11KQqfheT7Wz2GDi7n8Q3oKUBzTXAExifnDWoKM=; b=T0zPaJlI78mzRMpq
	xUq2D2j8RVHyeB/Omaq9kpAL43SYDXRK0E7GqrREMgn3v4BC9ww3yKyDAeEbbkSn
	94QkDx1WsTuCbOH2dYySLgHL/hEi3K6rFiqXbe7z9a4c+OiX9m2LiuHt02NSM95i
	JHzSF/CWndsLlXZxu/LD/c7iaediCoR0DT3lmxdG3r0lNKzNHra89x0E+oJADCSm
	LgvPlXRI3no789EfJeC04tivJmAzbqNSHjr18jlgDOcVr1Mn+E/kAad76GFbzdBb
	nGM93yoZqalvd1aP+QunJ4AYZmu/71dHFszDtnKAUmbAuDd25HcUIygx/Jou29xd
	0lrGmA==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45yfgjjt12-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 16 Apr 2025 08:29:47 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2242ce15cc3so51367575ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 16 Apr 2025 01:29:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744792186; x=1745396986;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MKA+11KQqfheT7Wz2GDi7n8Q3oKUBzTXAExifnDWoKM=;
        b=DZJV05t2SzMicH/bh1fVZoS2DCqCnxtW+0Vfm1B0phUzUjOUaD0Nen+rFh9eIbvseE
         Df+bJLajITx6DxdXJSZX+Bal3olTYRR56l7pEdGdkkUno4QtBuOIilrATvPGBVKKrkT4
         U09YxQF3ljnFjs/AmvB/KuvimCurlyL1HeQQfzhEwXsVAutAOibumAtHlpMhGby8tMVc
         rv953EHizr28+CAoEc2zcAk7UWqiAzH1T3h6YROn16gtdR32VDVndMtGlBTaIE98trVb
         w9YXzPVdwYXBnwdxXVNOV9UhEiOrducotwoJCA/jliwZIQET8JOP5YNYrBGG+6f7AURW
         yjtQ==
X-Forwarded-Encrypted: i=1; AJvYcCWqe3IHqb13aS/P0oCqzf1DCW7tLiC6DUpLZOcUHFwSMa2qChjQEqQb+jpkx5E1uqs1zb1hBMemF3hoPII=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+9xvIqLomuKi6f6dHpJxdQULetFWtYj1lqsasgbLJPlxPYCwm
	vPU3AotmEg0hkw4NGJ6UIJ0psl//kDwRv2BZMDxvAyXjOlG7ZNgjATEW+dK/4auP7dmSeyD0eJv
	YX3vPpsdUZYEJ3x4tOPOKVLx5CTKAK5Z8mmgsFxhjGeDGIDZHpAZGchnfBRtcDUA=
X-Gm-Gg: ASbGncucTIAG1ym1fZrG7pDhejm7BNUyz8N2vPdoWVRPigq7oa4NxVhUkAHQOm8vQ/E
	9xdU0hHD3ohzjRPy9M7M3LtpN2VhjKAlO7nsAEMhBuAoZb85PyHrRnQlgh2eKUQ7/BwMNeeRmRz
	BpDXdls6EPS3Uh93ayXM/fMmRM8WcPaN/AIiPZ1l73eyw55dLaP5kSEx6cGwRajkqDDufd8fsN9
	FaYmfYp3jzxX7BhDPSokUouT2JdqP/0V1AXCtd6cm4LhcFGerl3BcWpLcPwyGjltMvHAnaRpxgu
	gJ/Dy4crIYdYa92hVO6zTLg9evalFKWFy9MJiLb4Ax1yiPq5zy4x3r2KboP/q2Zy1OPgFmW0Yfe
	vOy/yIVFml2DTf16dXJ6/QsGxQK8QL5AwHUk9MEGY9Mq7ZRw=
X-Received: by 2002:a17:902:da83:b0:223:f9a4:3f9c with SMTP id d9443c01a7336-22c358bbdf9mr14514805ad.9.1744792186474;
        Wed, 16 Apr 2025 01:29:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG3pcMt5U1EN7FCjKKhJyIT50U/IIjw5E3rMWpOM0wSmt5tTi5CGBcwl+plKMdCq100w+nt1g==
X-Received: by 2002:a17:902:da83:b0:223:f9a4:3f9c with SMTP id d9443c01a7336-22c358bbdf9mr14514575ad.9.1744792186045;
        Wed, 16 Apr 2025 01:29:46 -0700 (PDT)
Received: from hu-kathirav-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22c33fcee11sm8340125ad.191.2025.04.16.01.29.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Apr 2025 01:29:45 -0700 (PDT)
From: Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>
Date: Wed, 16 Apr 2025 13:59:22 +0530
Subject: [PATCH v2 5/5] watchdog: qcom: add support to read the restart
 reason from IMEM
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250416-wdt_reset_reason-v2-5-c65bba312914@oss.qualcomm.com>
References: <20250416-wdt_reset_reason-v2-0-c65bba312914@oss.qualcomm.com>
In-Reply-To: <20250416-wdt_reset_reason-v2-0-c65bba312914@oss.qualcomm.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Rajendra Nayak <quic_rjendra@quicinc.com>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-watchdog@vger.kernel.org,
        Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1744792162; l=4047;
 i=kathiravan.thirumoorthy@oss.qualcomm.com; s=20230906;
 h=from:subject:message-id; bh=ytjddDlDLQ/8ZhINpkiVdnU51G61thVjIytF6cPUlJ0=;
 b=CQWcBTVynagdFkbqMrTFg6GZJlZnsJ34H8F1ZalZ6w/ATArdt5JN7t58rbtwnn1bZQTLOSlUX
 Y3EIlsYDicDDEWHuvPUAXe2tbVDIhKADp90LT/XPc6p7NoFSfUORP84
X-Developer-Key: i=kathiravan.thirumoorthy@oss.qualcomm.com; a=ed25519;
 pk=xWsR7pL6ch+vdZ9MoFGEaP61JUaRf0XaZYWztbQsIiM=
X-Proofpoint-GUID: 2bbt88baZAuF0GPzhf6DkomgLFtMklkp
X-Proofpoint-ORIG-GUID: 2bbt88baZAuF0GPzhf6DkomgLFtMklkp
X-Authority-Analysis: v=2.4 cv=Cve/cm4D c=1 sm=1 tr=0 ts=67ff6a7b cx=c_pps a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=EUspDBNiAAAA:8 a=k9rVL4j6ehUBw9fbeBUA:9 a=QEXdDO2ut3YA:10
 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-16_03,2025-04-15_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 clxscore=1015
 malwarescore=0 lowpriorityscore=0 bulkscore=0 spamscore=0 phishscore=0
 suspectscore=0 impostorscore=0 mlxlogscore=999 mlxscore=0
 priorityscore=1501 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504160068

When the system boots up after a watchdog reset, the EXPIRED_STATUS bit
in the WDT_STS register is cleared. To identify if the system was restarted
due to WDT expiry, bootloaders update the information in the IMEM region.
Update the driver to read the restart reason from IMEM and populate the
bootstatus accordingly.

For backward compatibility, keep the EXPIRED_STATUS bit check. Add a new
function qcom_wdt_get_restart_reason() to read the restart reason from
IMEM.

Signed-off-by: Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>
---
Changes in v2:
	- Use the syscon API to access the IMEM region
	- Handle the error cases returned by qcom_wdt_get_restart_reason
	- Define device specific data to retrieve the IMEM compatible,
	  offset and the value for non secure WDT, which allows to
	  extend the support for other SoCs
---
 drivers/watchdog/qcom-wdt.c | 47 +++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 45 insertions(+), 2 deletions(-)

diff --git a/drivers/watchdog/qcom-wdt.c b/drivers/watchdog/qcom-wdt.c
index 006f9c61aa64fd2b4ee9db493aeb54c8fafac818..94ba9ec9907a19854cd45a94f8da17d6e6eb33bc 100644
--- a/drivers/watchdog/qcom-wdt.c
+++ b/drivers/watchdog/qcom-wdt.c
@@ -7,9 +7,11 @@
 #include <linux/interrupt.h>
 #include <linux/io.h>
 #include <linux/kernel.h>
+#include <linux/mfd/syscon.h>
 #include <linux/module.h>
 #include <linux/of.h>
 #include <linux/platform_device.h>
+#include <linux/regmap.h>
 #include <linux/watchdog.h>
 
 enum wdt_reg {
@@ -39,6 +41,9 @@ static const u32 reg_offset_data_kpss[] = {
 };
 
 struct qcom_wdt_match_data {
+	const char *compatible;
+	unsigned int restart_reason_offset;
+	unsigned int non_secure_wdt_val;
 	const u32 *offset;
 	bool pretimeout;
 	u32 max_tick_count;
@@ -175,6 +180,15 @@ static const struct watchdog_info qcom_wdt_pt_info = {
 	.identity	= KBUILD_MODNAME,
 };
 
+static const struct qcom_wdt_match_data match_data_ipq5424 = {
+	.compatible = "qcom,ipq5424-imem",
+	.restart_reason_offset = 0x7b0,
+	.non_secure_wdt_val = 0x5,
+	.offset = reg_offset_data_kpss,
+	.pretimeout = true,
+	.max_tick_count = 0xFFFFFU,
+};
+
 static const struct qcom_wdt_match_data match_data_apcs_tmr = {
 	.offset = reg_offset_data_apcs_tmr,
 	.pretimeout = false,
@@ -187,6 +201,29 @@ static const struct qcom_wdt_match_data match_data_kpss = {
 	.max_tick_count = 0xFFFFFU,
 };
 
+static int  qcom_wdt_get_restart_reason(struct qcom_wdt *wdt,
+					const struct qcom_wdt_match_data *data)
+{
+	struct regmap *imem;
+	unsigned int val;
+	int ret;
+
+	imem = syscon_regmap_lookup_by_compatible(data->compatible);
+	if (IS_ERR(imem))
+		return PTR_ERR(imem);
+
+	ret = regmap_read(imem, data->restart_reason_offset, &val);
+	if (ret) {
+		dev_err(wdt->wdd.parent, "failed to read the restart reason info\n");
+		return ret;
+	}
+
+	if (val == data->non_secure_wdt_val)
+		wdt->wdd.bootstatus = WDIOF_CARDRESET;
+
+	return 0;
+}
+
 static int qcom_wdt_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
@@ -267,8 +304,13 @@ static int qcom_wdt_probe(struct platform_device *pdev)
 	wdt->wdd.parent = dev;
 	wdt->layout = data->offset;
 
-	if (readl(wdt_addr(wdt, WDT_STS)) & 1)
-		wdt->wdd.bootstatus = WDIOF_CARDRESET;
+	ret = qcom_wdt_get_restart_reason(wdt, data);
+	if (ret == -ENODEV) {
+		if (readl(wdt_addr(wdt, WDT_STS)) & 1)
+			wdt->wdd.bootstatus = WDIOF_CARDRESET;
+	} else if (ret) {
+		return ret;
+	}
 
 	/*
 	 * If 'timeout-sec' unspecified in devicetree, assume a 30 second
@@ -322,6 +364,7 @@ static const struct dev_pm_ops qcom_wdt_pm_ops = {
 };
 
 static const struct of_device_id qcom_wdt_of_table[] = {
+	{ .compatible = "qcom,apss-wdt-ipq5424", .data = &match_data_ipq5424 },
 	{ .compatible = "qcom,kpss-timer", .data = &match_data_apcs_tmr },
 	{ .compatible = "qcom,scss-timer", .data = &match_data_apcs_tmr },
 	{ .compatible = "qcom,kpss-wdt", .data = &match_data_kpss },

-- 
2.34.1


