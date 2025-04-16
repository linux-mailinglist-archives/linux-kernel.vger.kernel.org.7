Return-Path: <linux-kernel+bounces-604148-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D87E2A89133
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Apr 2025 03:22:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1EC53189B4B9
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Apr 2025 01:23:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB949202995;
	Tue, 15 Apr 2025 01:22:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="AnD4nk6n"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 869881FECAA
	for <linux-kernel@vger.kernel.org>; Tue, 15 Apr 2025 01:22:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744680125; cv=none; b=Swik1WVQDosbMAKvI6MnOSgpmLb2mGGorB6h/BCXpVWIFvWWwWJkBZFZoU08gxCOst8n8YGqRZc8WwIYpUFzvQgdSesJIB4v77YDl6bDfanOuNGdPuB07UJ6s9Xp1u8ai/88yIbYE1/fm0KVNVkUM8kBpEeaVjoCT+3cuHoAPnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744680125; c=relaxed/simple;
	bh=vYsUMJgbTyjqzznNCylAIBppjK85bj7M0Qp0y8bYl0g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=l3kTln4a88Z8ZqFPJ4T7522Y73XSGrXbforbVf03iNnmZqajR1SgOlsTwhBnPcIxbe+WdNdFhi8zMA4ORs8owDxE+LRZFyNydKbZzQQAIzYz/QxcE5X259LehjUP5iDdEceDnk2jAmTk9zsFDcdsnIzXloDlOg5+nWMeXVzXQ+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=AnD4nk6n; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53F16Lrc019432
	for <linux-kernel@vger.kernel.org>; Tue, 15 Apr 2025 01:22:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	BlH1KQY5ygqpqOlYb4vrPueUWUtUKu3N40BtvjB32K4=; b=AnD4nk6neiuIBlsl
	OLpf+HdifdMSHUGMhFzOEKPPJ+gt2kVuDdEppaSHhdLyESBIJtB0fpOjV9hOuGz+
	rXzrS52+Og3rxWVMFF7TxS6Aw6TiuzTz13UnMMZXp4RBIpk9xBSQs2MQNSsRmDfE
	dz1xFFxKG8UkRFlVz34ZXyivl21g160jx2dvNElYkZiWqkHnA+yrPKrxeL3Q355e
	GL6fW1uWlSY3VjxwNSOhtKaUZBrQs7/l+gPvWbIAj6JTy1EVcRWkChTASvCFLPa1
	14e6R6B2kwWnkd4P85MbTI6/lBOVRzJhQ6Q5D3UphOwJYqMF88NW8pyex9sXhgnu
	VsnukQ==
Received: from mail-oa1-f71.google.com (mail-oa1-f71.google.com [209.85.160.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45yg8we748-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 15 Apr 2025 01:22:01 +0000 (GMT)
Received: by mail-oa1-f71.google.com with SMTP id 586e51a60fabf-2c268416ff5so1320595fac.3
        for <linux-kernel@vger.kernel.org>; Mon, 14 Apr 2025 18:22:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744680120; x=1745284920;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BlH1KQY5ygqpqOlYb4vrPueUWUtUKu3N40BtvjB32K4=;
        b=gRzamEL8kI7Y8jC4FZmBJX8TgzqCrPEt0lQkkzhqosHBXhaDMK53U+yOQALq2XxpI1
         zKyy7kq8bdgyqpU1EYVHIOZORAxrEL/4ciqQ1zS3pXjqTus3GMcMLS7eBgDbfc1p7yqa
         LdRK7QQKhA8Y3Z878HrNJ0rV702WXZGeOTjl0UhGvfIGzpFJexqvoFn2gURyMEIYmKNG
         mvvscaDcY+yBKEftDltU3ZHAkuUNqnOjbbovN3sKDwzUqeDe9ifw88Fsji1Cq+9b+Sxu
         QAJkvtBIF6QoMllmgiytFg28DkF4kK7jvXpr0sKQqpNzdMcM8JnntQHxnIThlI5uat/n
         HVSA==
X-Forwarded-Encrypted: i=1; AJvYcCUYB2rpgjASMXxFoc8CA7L6TODdEMSiKcsGYQo2iSVtMQW+Em1nvaGp0NKYJCfMVi2Oac8L4K2c4fbWmPI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxPq9DoLra2G2Wi94obDpOwSDCtw/IF24ZoKMQu9S2UXNrLBBSo
	l3qXhPyTasJ3zE+n8+s9VzxVqQaxH2sNY+Zoi+/2YiKnaz44J0TJy7Zlqehq3y74IQciF3HOKl1
	tUtYPFdkd52drcnAmnNWXa3leLc4qfjDWMMP1PiYV27nvyOTen3ksc11I2gf3ISc=
X-Gm-Gg: ASbGncuG1yqizZfEjdwDRHY8VymtBGHPGzozNeue5ygiEjLGkEkbglw7zealSIXH71u
	Duzlo3WkqgPX0GUUxe4/2fK2+fQopPk5RjTMtA41NVEFJ4jL0rvVZDbFNzqyrOYVSR82D+ANply
	fOxBTlH4l27ILX6dSPA6gdUpXEIsK3/a04kejCOoN8kVbXpumMOrqgNpYQkYHqWEzxkXnzTO56n
	BjP1Cdy6j+luqbQsSA2wKcgBzQL6eBtUxMxKQxW1Ugr2I4ecl3/LmDoDYwsQDwNyLBFj41ixIqS
	bH1LP+ejqOuzVulZnJYyZN8jr2U5TNGxoh2K3TpiUb1pqhuOxS6OtBR3FtlAL+QVi8IuWOlbZMe
	EcxybzapRULg=
X-Received: by 2002:a05:6870:7011:b0:2c1:b39c:c43a with SMTP id 586e51a60fabf-2d0d5d07b09mr8152693fac.22.1744680120077;
        Mon, 14 Apr 2025 18:22:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGB1tuRvZHU/7A5vnDtLU+Rz3jS7LJrzCFZALEDpk029fJxM38VSu/ugIewKI7Z4lDjCPCptg==
X-Received: by 2002:a05:6870:7011:b0:2c1:b39c:c43a with SMTP id 586e51a60fabf-2d0d5d07b09mr8152675fac.22.1744680119622;
        Mon, 14 Apr 2025 18:21:59 -0700 (PDT)
Received: from [192.168.86.65] (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2d0968e090esm2652538fac.6.2025.04.14.18.21.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Apr 2025 18:21:59 -0700 (PDT)
From: Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>
Date: Mon, 14 Apr 2025 20:21:52 -0500
Subject: [PATCH v7 3/6] usb: dwc3: core: Expose core driver as library
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250414-dwc3-refactor-v7-3-f015b358722d@oss.qualcomm.com>
References: <20250414-dwc3-refactor-v7-0-f015b358722d@oss.qualcomm.com>
In-Reply-To: <20250414-dwc3-refactor-v7-0-f015b358722d@oss.qualcomm.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Felipe Balbi <balbi@kernel.org>,
        Wesley Cheng <quic_wcheng@quicinc.com>,
        Saravana Kannan <saravanak@google.com>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Frank Li <Frank.li@nxp.com>
Cc: linux-arm-msm@vger.kernel.org, linux-usb@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=10906;
 i=bjorn.andersson@oss.qualcomm.com; h=from:subject:message-id;
 bh=vYsUMJgbTyjqzznNCylAIBppjK85bj7M0Qp0y8bYl0g=;
 b=owEBgwJ8/ZANAwAIAQsfOT8Nma3FAcsmYgBn/bSzkHlUGSAtlHWFnPMP4bpFiircmkbo4kSCN
 YbiSZoKyW2JAkkEAAEIADMWIQQF3gPMXzXqTwlm1SULHzk/DZmtxQUCZ/20sxUcYW5kZXJzc29u
 QGtlcm5lbC5vcmcACgkQCx85Pw2ZrcUKcg/+JKei4cblD9IS7/VNq8saq0sPTr4A1NFbRmU75Tm
 y8qGCAOiUqbGrDkn+CT9XRrwF4/xplbh3Exm5fYwr7w7FZnpB6UcnHquWx/DxmdOXdvHUSTKyuU
 VLWp5Sw/+x6y0olfYsgBEgxKEsfGBKbORkEqoBziQZnkJuNzy8AKHdEjcyBhd5u1pdNNf0MEsss
 DFbUMz9komAod8qcJ74TVklU7GfV09DUC+B8VqnGSFjbXlXouBg/3ztxSfOVTru/+WfWWqQyy5Z
 6IyCuUuHUEmxIgz0N66W1BRKBCwEPlMEjYHkKdRtRraerOLMqUYFNyPZD/JzuEleMJ7KCNth7BX
 XzcHEZwGAG4F6VOqIUr3zK1c5+hCN03DOokvYu9ct+yfCl5Z6RzuIhJzOWNAWkbfdzTSXL49u6A
 0ch3SUIjc7fm6LitYvAEg/1CWNB80/51ikj6wo6aM81eFdPAXtIiCY0uJsokRkAxqm7SyPpq9jQ
 2+EltQYmhvb1pfEoxv3yfLTlrk794JACieWqsaW5Vh6PdlQMJRqJOQ+5zHuyrjUGJ6KmBz8ynbP
 cI4RPmUiTeBgEArFyTcYJpcRzBg3aZQcO7aE0Wo7r6DKNreG7uDJgQVmq4ZEvZPg9hTwaci7bt0
 0VRLgcUfxiXxm1psoeo1GoReDGydnNqYBVHRCbWooXoQ=
X-Developer-Key: i=bjorn.andersson@oss.qualcomm.com; a=openpgp;
 fpr=05DE03CC5F35EA4F0966D5250B1F393F0D99ADC5
X-Authority-Analysis: v=2.4 cv=E9TNpbdl c=1 sm=1 tr=0 ts=67fdb4b9 cx=c_pps a=CWtnpBpaoqyeOyNyJ5EW7Q==:117 a=DaeiM5VmU20ml6RIjrOvYw==:17 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=jIQo8A4GAAAA:8 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=LGnwQnnVSUjD69BhXoIA:9
 a=QEXdDO2ut3YA:10 a=vh23qwtRXIYOdz9xvnmn:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: 9GgohS_xj2eSeUXccTUruhWFI4h1OBp5
X-Proofpoint-GUID: 9GgohS_xj2eSeUXccTUruhWFI4h1OBp5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-14_08,2025-04-10_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 adultscore=0
 mlxscore=0 bulkscore=0 clxscore=1015 phishscore=0 lowpriorityscore=0
 suspectscore=0 mlxlogscore=999 spamscore=0 priorityscore=1501
 impostorscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504150003

The DWC3 IP block is handled by three distinct device drivers: XHCI,
DWC3 core and a platform specific (optional) DWC3 glue driver.

This has resulted in, at least in the case of the Qualcomm glue, the
presence of a number of layering violations, where the glue code either
can't handle, or has to work around, the fact that core might not probe
deterministically.

An example of this is that the suspend path should operate slightly
different depending on the device operating in host or peripheral mode,
and the only way to determine the operating state is to peek into the
core's drvdata.

The Qualcomm glue driver is expected to make updates in the qscratch
register region (the "glue" region) during role switch events, but with
the glue and core split using the driver model, there is no reasonable
way to introduce listeners for mode changes.

Split the dwc3 core platform_driver callbacks and their implementation
and export the implementation, to make it possible to deterministically
instantiate the dwc3 core as part of the dwc3 glue drivers and to
allow flattening of the DeviceTree representation.

Acked-by: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
Tested-by: Neil Armstrong <neil.armstrong@linaro.org> # on SM8650-QRD
Signed-off-by: Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>
---
 drivers/usb/dwc3/core.c | 155 +++++++++++++++++++++++++++++++++---------------
 drivers/usb/dwc3/glue.h |  33 +++++++++++
 2 files changed, 140 insertions(+), 48 deletions(-)

diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
index b169913172fc5fadb307e188caf935f7467fb413..81324d586c0797a551b188685d7da2a504484e57 100644
--- a/drivers/usb/dwc3/core.c
+++ b/drivers/usb/dwc3/core.c
@@ -37,6 +37,7 @@
 
 #include "core.h"
 #include "gadget.h"
+#include "glue.h"
 #include "io.h"
 
 #include "debug.h"
@@ -2161,27 +2162,16 @@ static struct power_supply *dwc3_get_usb_power_supply(struct dwc3 *dwc)
 	return usb_psy;
 }
 
-static int dwc3_probe(struct platform_device *pdev)
+int dwc3_core_probe(const struct dwc3_probe_data *data)
 {
-	struct device		*dev = &pdev->dev;
-	struct resource		*res, dwc_res;
+	struct dwc3		*dwc = data->dwc;
+	struct device		*dev = dwc->dev;
+	struct resource		dwc_res;
 	unsigned int		hw_mode;
 	void __iomem		*regs;
-	struct dwc3		*dwc;
+	struct resource		*res = data->res;
 	int			ret;
 
-	dwc = devm_kzalloc(dev, sizeof(*dwc), GFP_KERNEL);
-	if (!dwc)
-		return -ENOMEM;
-
-	dwc->dev = dev;
-
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	if (!res) {
-		dev_err(dev, "missing memory resource\n");
-		return -ENODEV;
-	}
-
 	dwc->xhci_resources[0].start = res->start;
 	dwc->xhci_resources[0].end = dwc->xhci_resources[0].start +
 					DWC3_XHCI_REGS_END;
@@ -2245,7 +2235,7 @@ static int dwc3_probe(struct platform_device *pdev)
 		goto err_disable_clks;
 	}
 
-	platform_set_drvdata(pdev, dwc);
+	dev_set_drvdata(dev, dwc);
 	dwc3_cache_hwparams(dwc);
 
 	if (!dwc->sysdev_is_parent &&
@@ -2340,12 +2330,35 @@ static int dwc3_probe(struct platform_device *pdev)
 
 	return ret;
 }
+EXPORT_SYMBOL_GPL(dwc3_core_probe);
 
-static void dwc3_remove(struct platform_device *pdev)
+static int dwc3_probe(struct platform_device *pdev)
 {
-	struct dwc3	*dwc = platform_get_drvdata(pdev);
+	struct dwc3_probe_data probe_data;
+	struct resource *res;
+	struct dwc3 *dwc;
 
-	pm_runtime_get_sync(&pdev->dev);
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!res) {
+		dev_err(&pdev->dev, "missing memory resource\n");
+		return -ENODEV;
+	}
+
+	dwc = devm_kzalloc(&pdev->dev, sizeof(*dwc), GFP_KERNEL);
+	if (!dwc)
+		return -ENOMEM;
+
+	dwc->dev = &pdev->dev;
+
+	probe_data.dwc = dwc;
+	probe_data.res = res;
+
+	return dwc3_core_probe(&probe_data);
+}
+
+void dwc3_core_remove(struct dwc3 *dwc)
+{
+	pm_runtime_get_sync(dwc->dev);
 
 	dwc3_core_exit_mode(dwc);
 	dwc3_debugfs_exit(dwc);
@@ -2353,22 +2366,28 @@ static void dwc3_remove(struct platform_device *pdev)
 	dwc3_core_exit(dwc);
 	dwc3_ulpi_exit(dwc);
 
-	pm_runtime_allow(&pdev->dev);
-	pm_runtime_disable(&pdev->dev);
-	pm_runtime_dont_use_autosuspend(&pdev->dev);
-	pm_runtime_put_noidle(&pdev->dev);
+	pm_runtime_allow(dwc->dev);
+	pm_runtime_disable(dwc->dev);
+	pm_runtime_dont_use_autosuspend(dwc->dev);
+	pm_runtime_put_noidle(dwc->dev);
 	/*
 	 * HACK: Clear the driver data, which is currently accessed by parent
 	 * glue drivers, before allowing the parent to suspend.
 	 */
-	platform_set_drvdata(pdev, NULL);
-	pm_runtime_set_suspended(&pdev->dev);
+	dev_set_drvdata(dwc->dev, NULL);
+	pm_runtime_set_suspended(dwc->dev);
 
 	dwc3_free_event_buffers(dwc);
 
 	if (dwc->usb_psy)
 		power_supply_put(dwc->usb_psy);
 }
+EXPORT_SYMBOL_GPL(dwc3_core_remove);
+
+static void dwc3_remove(struct platform_device *pdev)
+{
+	dwc3_core_remove(platform_get_drvdata(pdev));
+}
 
 #ifdef CONFIG_PM
 static int dwc3_core_init_for_resume(struct dwc3 *dwc)
@@ -2557,9 +2576,8 @@ static int dwc3_runtime_checks(struct dwc3 *dwc)
 	return 0;
 }
 
-static int dwc3_runtime_suspend(struct device *dev)
+int dwc3_runtime_suspend(struct dwc3 *dwc)
 {
-	struct dwc3     *dwc = dev_get_drvdata(dev);
 	int		ret;
 
 	if (dwc3_runtime_checks(dwc))
@@ -2571,10 +2589,11 @@ static int dwc3_runtime_suspend(struct device *dev)
 
 	return 0;
 }
+EXPORT_SYMBOL_GPL(dwc3_runtime_suspend);
 
-static int dwc3_runtime_resume(struct device *dev)
+int dwc3_runtime_resume(struct dwc3 *dwc)
 {
-	struct dwc3     *dwc = dev_get_drvdata(dev);
+	struct device *dev = dwc->dev;
 	int		ret;
 
 	ret = dwc3_resume_common(dwc, PMSG_AUTO_RESUME);
@@ -2584,7 +2603,7 @@ static int dwc3_runtime_resume(struct device *dev)
 	switch (dwc->current_dr_role) {
 	case DWC3_GCTL_PRTCAP_DEVICE:
 		if (dwc->pending_events) {
-			pm_runtime_put(dwc->dev);
+			pm_runtime_put(dev);
 			dwc->pending_events = false;
 			enable_irq(dwc->irq_gadget);
 		}
@@ -2599,10 +2618,11 @@ static int dwc3_runtime_resume(struct device *dev)
 
 	return 0;
 }
+EXPORT_SYMBOL_GPL(dwc3_runtime_resume);
 
-static int dwc3_runtime_idle(struct device *dev)
+int dwc3_runtime_idle(struct dwc3 *dwc)
 {
-	struct dwc3     *dwc = dev_get_drvdata(dev);
+	struct device *dev = dwc->dev;
 
 	switch (dwc->current_dr_role) {
 	case DWC3_GCTL_PRTCAP_DEVICE:
@@ -2620,12 +2640,28 @@ static int dwc3_runtime_idle(struct device *dev)
 
 	return 0;
 }
+EXPORT_SYMBOL_GPL(dwc3_runtime_idle);
+
+static int dwc3_plat_runtime_suspend(struct device *dev)
+{
+	return dwc3_runtime_suspend(dev_get_drvdata(dev));
+}
+
+static int dwc3_plat_runtime_resume(struct device *dev)
+{
+	return dwc3_runtime_resume(dev_get_drvdata(dev));
+}
+
+static int dwc3_plat_runtime_idle(struct device *dev)
+{
+	return dwc3_runtime_idle(dev_get_drvdata(dev));
+}
 #endif /* CONFIG_PM */
 
 #ifdef CONFIG_PM_SLEEP
-static int dwc3_suspend(struct device *dev)
+int dwc3_pm_suspend(struct dwc3 *dwc)
 {
-	struct dwc3	*dwc = dev_get_drvdata(dev);
+	struct device *dev = dwc->dev;
 	int		ret;
 
 	ret = dwc3_suspend_common(dwc, PMSG_SUSPEND);
@@ -2636,10 +2672,11 @@ static int dwc3_suspend(struct device *dev)
 
 	return 0;
 }
+EXPORT_SYMBOL_GPL(dwc3_pm_suspend);
 
-static int dwc3_resume(struct device *dev)
+int dwc3_pm_resume(struct dwc3 *dwc)
 {
-	struct dwc3	*dwc = dev_get_drvdata(dev);
+	struct device *dev = dwc->dev;
 	int		ret = 0;
 
 	pinctrl_pm_select_default_state(dev);
@@ -2658,10 +2695,10 @@ static int dwc3_resume(struct device *dev)
 
 	return ret;
 }
+EXPORT_SYMBOL_GPL(dwc3_pm_resume);
 
-static void dwc3_complete(struct device *dev)
+void dwc3_pm_complete(struct dwc3 *dwc)
 {
-	struct dwc3	*dwc = dev_get_drvdata(dev);
 	u32		reg;
 
 	if (dwc->current_dr_role == DWC3_GCTL_PRTCAP_HOST &&
@@ -2671,10 +2708,11 @@ static void dwc3_complete(struct device *dev)
 		dwc3_writel(dwc->regs, DWC3_GUCTL3, reg);
 	}
 }
+EXPORT_SYMBOL_GPL(dwc3_pm_complete);
 
-static int dwc3_prepare(struct device *dev)
+int dwc3_pm_prepare(struct dwc3 *dwc)
 {
-	struct dwc3	*dwc = dev_get_drvdata(dev);
+	struct device *dev = dwc->dev;
 
 	/*
 	 * Indicate to the PM core that it may safely leave the device in
@@ -2687,22 +2725,43 @@ static int dwc3_prepare(struct device *dev)
 
 	return 0;
 }
+EXPORT_SYMBOL_GPL(dwc3_pm_prepare);
+
+static int dwc3_plat_suspend(struct device *dev)
+{
+	return dwc3_pm_suspend(dev_get_drvdata(dev));
+}
+
+static int dwc3_plat_resume(struct device *dev)
+{
+	return dwc3_pm_resume(dev_get_drvdata(dev));
+}
+
+static void dwc3_plat_complete(struct device *dev)
+{
+	dwc3_pm_complete(dev_get_drvdata(dev));
+}
+
+static int dwc3_plat_prepare(struct device *dev)
+{
+	return dwc3_pm_prepare(dev_get_drvdata(dev));
+}
 #else
-#define dwc3_complete NULL
-#define dwc3_prepare NULL
+#define dwc3_plat_complete NULL
+#define dwc3_plat_prepare NULL
 #endif /* CONFIG_PM_SLEEP */
 
 static const struct dev_pm_ops dwc3_dev_pm_ops = {
-	SET_SYSTEM_SLEEP_PM_OPS(dwc3_suspend, dwc3_resume)
-	.complete = dwc3_complete,
-	.prepare = dwc3_prepare,
+	SET_SYSTEM_SLEEP_PM_OPS(dwc3_plat_suspend, dwc3_plat_resume)
+	.complete = dwc3_plat_complete,
+	.prepare = dwc3_plat_prepare,
 	/*
 	 * Runtime suspend halts the controller on disconnection. It relies on
 	 * platforms with custom connection notification to start the controller
 	 * again.
 	 */
-	SET_RUNTIME_PM_OPS(dwc3_runtime_suspend, dwc3_runtime_resume,
-			dwc3_runtime_idle)
+	SET_RUNTIME_PM_OPS(dwc3_plat_runtime_suspend, dwc3_plat_runtime_resume,
+			   dwc3_plat_runtime_idle)
 };
 
 #ifdef CONFIG_OF
diff --git a/drivers/usb/dwc3/glue.h b/drivers/usb/dwc3/glue.h
new file mode 100644
index 0000000000000000000000000000000000000000..bc446f92ec8b1b6feeb84ab2138516103833b259
--- /dev/null
+++ b/drivers/usb/dwc3/glue.h
@@ -0,0 +1,33 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * glue.h - DesignWare USB3 DRD glue header
+ */
+
+#ifndef __DRIVERS_USB_DWC3_GLUE_H
+#define __DRIVERS_USB_DWC3_GLUE_H
+
+#include <linux/types.h>
+#include "core.h"
+
+/**
+ * dwc3_probe_data: Initialization parameters passed to dwc3_core_probe()
+ * @dwc: Reference to dwc3 context structure
+ * @res: resource for the DWC3 core mmio region
+ */
+struct dwc3_probe_data {
+	struct dwc3 *dwc;
+	struct resource *res;
+};
+
+int dwc3_core_probe(const struct dwc3_probe_data *data);
+void dwc3_core_remove(struct dwc3 *dwc);
+
+int dwc3_runtime_suspend(struct dwc3 *dwc);
+int dwc3_runtime_resume(struct dwc3 *dwc);
+int dwc3_runtime_idle(struct dwc3 *dwc);
+int dwc3_pm_suspend(struct dwc3 *dwc);
+int dwc3_pm_resume(struct dwc3 *dwc);
+void dwc3_pm_complete(struct dwc3 *dwc);
+int dwc3_pm_prepare(struct dwc3 *dwc);
+
+#endif

-- 
2.49.0


