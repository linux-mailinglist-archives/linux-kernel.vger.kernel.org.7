Return-Path: <linux-kernel+bounces-602155-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F472A8777E
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Apr 2025 07:40:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 92A511890CAB
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Apr 2025 05:40:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA2D41A3A80;
	Mon, 14 Apr 2025 05:39:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="LvBqoxuv"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 392CD1A315D
	for <linux-kernel@vger.kernel.org>; Mon, 14 Apr 2025 05:39:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744609184; cv=none; b=bYfBI25nsQKt77bEPLNOC9xPK9u/B6kCzaoaiGc6c6V649oqPW1uWoq98j8QXGT2WCfauXJz/teSddIL2JcnLj/YooMz+cnSa73nEqkRatjb+YGdaWyINujw/DPsUmnm25r6t8hskWpq2iWDBSwgzHOKX+qGapnsF4dWuZsk/f0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744609184; c=relaxed/simple;
	bh=WC5wKRvcYuSwXR7Izdx25mVC4LSMyYyIUrLgoxUWBas=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=AEk80YsK09bp0AcqCXLnv3fHewP4Zywkhn8cXXmkmgkspFR5Rp4NXO2kSJSWbrxQx+7Gq7qZqBrUeVG9EITWelYb15Ckp3MQb4b4iigob+mjShQ2CkYuFmVppHm5dYZXA2BVLdrsh2sT7YTAZtc0k3lIRaow7KrdyniuZ2/4wt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=LvBqoxuv; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53DLZuA3014611
	for <linux-kernel@vger.kernel.org>; Mon, 14 Apr 2025 05:39:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	qG2kUNarrqP9lMavMts7qNZl8UluSE4dZqY7JK6NYfE=; b=LvBqoxuvI8ERBn51
	JxfazQMKKM16rrYj1km848N82F8uKd4XyvjKF+TZrNDFu1C4JUTHK8Q5FM4U9u0r
	glZTk5yZu1e4sIJPS5kMkBhFsUlQgZHLCnEuOQcetGl+StgX/zaPuW7aS85N+MDP
	TturSPY3D6PSUKnFWuqC+XGrlrTapeXgGZ746f9Sk3x+J0Yy+6W9T8pjFi0KRX3H
	oXmNRhuO3+L5pCdLoZCCXNlHJ2/t+YGmF0PM+MhB2BTurdotL2ihvEMdmH4ZLi48
	vZOJrB6Nb9sQA8AOpLDzbBSj9Iu4aEhQ4I0pP2LFwIB60BUHaifZSHmxX9aGquyu
	hyF54Q==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45yfgjbejh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 14 Apr 2025 05:39:40 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-b048d1abbbfso3296706a12.0
        for <linux-kernel@vger.kernel.org>; Sun, 13 Apr 2025 22:39:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744609179; x=1745213979;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qG2kUNarrqP9lMavMts7qNZl8UluSE4dZqY7JK6NYfE=;
        b=sMPtyywiSvzA1Cwj+cK36w7nuB2qQReeZcbxbWKhRjPJzu7U4T7RAFHGQrVMo034yB
         0lONhz1fR+dvpGF4rnlm1ldCw2fX0gqAiOqaWXr/RH1TPRmeIHT+h87C2PmMUQA64vJz
         9Xv8nwYvJDfLSCQzpa0j4BtZgobX+K8+xUhoKQGziOHi/TB1d/tsLOPxMj1cPXb592PE
         XNAHGWZl0DG0B1uitUlUBWUB9QQq8fTi1Ww4XY9YROzlZDhs8sHPtASQJeW9/au321V5
         HAJWRms2EHYyR7yNiepB9RxeDSGIzAbVQ8a4NbcAz6awOJLj+lHEI3V1XdX6wWBaOmND
         N+5Q==
X-Forwarded-Encrypted: i=1; AJvYcCULrd9N8IEkJyFh960Dq30hnlhVzRHuQf2mervCC8/4VeTHxDNosTKZM7+MdG9pPzD7c9q8MbrTkRHMteo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwIDU3KBpficiBGP4dbEc6Jk914DjkfV/lGz9o7W1Gp54i+PHJj
	MO1leLUHwonm/LVEqAFEaRqH/ZX51Ht0EFIeDVj6XqZTGmfs8AZkBvYsrS4uES1v4bH77Ybfw3s
	dfV9vf/WHBPpHqh+x/Kd/SmAdMORLlnwi67EsolWedeO4v8dCpuQklPcVNd9EdQ8=
X-Gm-Gg: ASbGncuRWxQJWtHx8gobCbUdUAELBAdEmE/ChDuia3X74vB4zjhQnkwPTPvv/qjzfSL
	IxJZx0RflrGmd/pFO/Z4tn3lAUqiVCKYUWmhlvKQmdlo/lrAgcwxWdwXHMffXjLXoa/odZLjX8C
	CPvIkZOmdfhvnAED76g/MI70uoIReEMDnh3M6BNvEpRjhTZweAmEruI2xopH8hMOM+52Ha/fHAO
	jyeNHhYUn2GQ2J7B+bHNRIqbLtbfftbKDHLFsVg5+LrwbxEwlwrTd5ZbOGJoeDdxlkNNc+GEAzl
	aQBndPaUfkYToGTBoVZi7qOyLUa2Ja+3tUDPI45mX23vx/4=
X-Received: by 2002:a05:6a20:d525:b0:1f5:7873:304b with SMTP id adf61e73a8af0-2017996fbfdmr14224133637.26.1744609179322;
        Sun, 13 Apr 2025 22:39:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF7i2E+yUtPthN8Zj0a3CulLjT99OAsG6h/Rr0m+qBzSGvFBz+WVcNzfzjKGoti/SP51/cpqw==
X-Received: by 2002:a05:6a20:d525:b0:1f5:7873:304b with SMTP id adf61e73a8af0-2017996fbfdmr14224088637.26.1744609178723;
        Sun, 13 Apr 2025 22:39:38 -0700 (PDT)
Received: from hu-krichai-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73bd23332d2sm5824559b3a.159.2025.04.13.22.39.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Apr 2025 22:39:38 -0700 (PDT)
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Date: Mon, 14 Apr 2025 11:09:14 +0530
Subject: [PATCH v2 3/3] PCI: qcom: Add support for multi-root port
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250414-perst-v2-3-89247746d755@oss.qualcomm.com>
References: <20250414-perst-v2-0-89247746d755@oss.qualcomm.com>
In-Reply-To: <20250414-perst-v2-0-89247746d755@oss.qualcomm.com>
To: Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        cros-qcom-dts-watchers@chromium.org
Cc: linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        quic_vbadigan@quicinc.com, quic_mrana@quicinc.com,
        Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1744609160; l=7942;
 i=krishna.chundru@oss.qualcomm.com; s=20230907; h=from:subject:message-id;
 bh=WC5wKRvcYuSwXR7Izdx25mVC4LSMyYyIUrLgoxUWBas=;
 b=Uh3eu8AQrCP/1w+anhue+7slJ8ehb8F7LfDcOmm4ZnKrm4cfNxd7BXpF8rpedC9vXnlU2iBn8
 eDeDzkMnvCCCcbuW3sUij6qLXOxPZWSa3XK/BriuEGupc9KF7d7aZ3y
X-Developer-Key: i=krishna.chundru@oss.qualcomm.com; a=ed25519;
 pk=10CL2pdAKFyzyOHbfSWHCD0X0my7CXxj8gJScmn1FAg=
X-Proofpoint-GUID: Xa9M1WWalSUMOuPvFuh09L7e4bw1WUtm
X-Proofpoint-ORIG-GUID: Xa9M1WWalSUMOuPvFuh09L7e4bw1WUtm
X-Authority-Analysis: v=2.4 cv=Cve/cm4D c=1 sm=1 tr=0 ts=67fc9f9c cx=c_pps a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=EUspDBNiAAAA:8 a=KZ4ZsdeBRq2BojHjq4kA:9 a=QEXdDO2ut3YA:10
 a=3WC7DwWrALyhR5TkjVHa:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-14_01,2025-04-10_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 clxscore=1015
 malwarescore=0 lowpriorityscore=0 bulkscore=0 spamscore=0 phishscore=0
 suspectscore=0 impostorscore=0 mlxlogscore=999 mlxscore=0
 priorityscore=1501 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504140039

Move phy, perst handling to root port and provide a way to have multi-port
logic.

Currently, qcom controllers only support single port, and all properties
are present in the controller node itself. This is incorrect, as
properties like phy, perst, wake, etc. can vary per port and should be
present in the root port node.

pci-bus-common.yaml uses reset-gpios property for representing PERST, use
same property instead of perst-gpios.

Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
---
 drivers/pci/controller/dwc/pcie-qcom.c | 149 +++++++++++++++++++++++++++------
 1 file changed, 123 insertions(+), 26 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
index dc98ae63362db0422384b1879a2b9a7dc564d091..5566c8aa7f9a9928c06aa6284ca4de21cc411874 100644
--- a/drivers/pci/controller/dwc/pcie-qcom.c
+++ b/drivers/pci/controller/dwc/pcie-qcom.c
@@ -262,6 +262,11 @@ struct qcom_pcie_cfg {
 	bool no_l0s;
 };
 
+struct qcom_pcie_port {
+	struct list_head list;
+	struct gpio_desc *reset;
+	struct phy *phy;
+};
 struct qcom_pcie {
 	struct dw_pcie *pci;
 	void __iomem *parf;			/* DT parf */
@@ -276,21 +281,36 @@ struct qcom_pcie {
 	struct dentry *debugfs;
 	bool suspended;
 	bool use_pm_opp;
+	struct list_head ports;
 };
 
 #define to_qcom_pcie(x)		dev_get_drvdata((x)->dev)
 
 static void qcom_ep_reset_assert(struct qcom_pcie *pcie)
 {
-	gpiod_set_value_cansleep(pcie->reset, 1);
+	struct qcom_pcie_port *port, *tmp;
+
+	if (list_empty(&pcie->ports))
+		gpiod_set_value_cansleep(pcie->reset, 1);
+	else
+		list_for_each_entry_safe(port, tmp, &pcie->ports, list)
+			gpiod_set_value_cansleep(port->reset, 1);
+
 	usleep_range(PERST_DELAY_US, PERST_DELAY_US + 500);
 }
 
 static void qcom_ep_reset_deassert(struct qcom_pcie *pcie)
 {
+	struct qcom_pcie_port *port, *tmp;
+
 	/* Ensure that PERST has been asserted for at least 100 ms */
 	msleep(100);
-	gpiod_set_value_cansleep(pcie->reset, 0);
+	if (list_empty(&pcie->ports))
+		gpiod_set_value_cansleep(pcie->reset, 0);
+	else
+		list_for_each_entry_safe(port, tmp, &pcie->ports, list)
+			gpiod_set_value_cansleep(port->reset, 0);
+
 	usleep_range(PERST_DELAY_US, PERST_DELAY_US + 500);
 }
 
@@ -1229,10 +1249,19 @@ static int qcom_pcie_link_up(struct dw_pcie *pci)
 	return !!(val & PCI_EXP_LNKSTA_DLLLA);
 }
 
+static void qcom_pcie_port_phy_off(struct qcom_pcie *pcie)
+{
+	struct qcom_pcie_port *port, *tmp;
+
+	list_for_each_entry_safe(port, tmp, &pcie->ports, list)
+		phy_power_off(port->phy);
+}
+
 static int qcom_pcie_host_init(struct dw_pcie_rp *pp)
 {
 	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
 	struct qcom_pcie *pcie = to_qcom_pcie(pci);
+	struct qcom_pcie_port *port, *tmp;
 	int ret;
 
 	qcom_ep_reset_assert(pcie);
@@ -1241,13 +1270,27 @@ static int qcom_pcie_host_init(struct dw_pcie_rp *pp)
 	if (ret)
 		return ret;
 
-	ret = phy_set_mode_ext(pcie->phy, PHY_MODE_PCIE, PHY_MODE_PCIE_RC);
-	if (ret)
-		goto err_deinit;
+	if (list_empty(&pcie->ports)) {
+		ret = phy_set_mode_ext(pcie->phy, PHY_MODE_PCIE, PHY_MODE_PCIE_RC);
+		if (ret)
+			goto err_deinit;
 
-	ret = phy_power_on(pcie->phy);
-	if (ret)
-		goto err_deinit;
+		ret = phy_power_on(pcie->phy);
+		if (ret)
+			goto err_deinit;
+	} else {
+		list_for_each_entry_safe(port, tmp, &pcie->ports, list) {
+			ret = phy_set_mode_ext(port->phy, PHY_MODE_PCIE, PHY_MODE_PCIE_RC);
+			if (ret)
+				goto err_deinit;
+
+			ret = phy_power_on(port->phy);
+			if (ret) {
+				qcom_pcie_port_phy_off(pcie);
+				goto err_deinit;
+			}
+		}
+	}
 
 	if (pcie->cfg->ops->post_init) {
 		ret = pcie->cfg->ops->post_init(pcie);
@@ -1268,7 +1311,10 @@ static int qcom_pcie_host_init(struct dw_pcie_rp *pp)
 err_assert_reset:
 	qcom_ep_reset_assert(pcie);
 err_disable_phy:
-	phy_power_off(pcie->phy);
+	if (list_empty(&pcie->ports))
+		phy_power_off(pcie->phy);
+	else
+		qcom_pcie_port_phy_off(pcie);
 err_deinit:
 	pcie->cfg->ops->deinit(pcie);
 
@@ -1281,7 +1327,10 @@ static void qcom_pcie_host_deinit(struct dw_pcie_rp *pp)
 	struct qcom_pcie *pcie = to_qcom_pcie(pci);
 
 	qcom_ep_reset_assert(pcie);
-	phy_power_off(pcie->phy);
+	if (list_empty(&pcie->ports))
+		phy_power_off(pcie->phy);
+	else
+		qcom_pcie_port_phy_off(pcie);
 	pcie->cfg->ops->deinit(pcie);
 }
 
@@ -1579,11 +1628,41 @@ static irqreturn_t qcom_pcie_global_irq_thread(int irq, void *data)
 	return IRQ_HANDLED;
 }
 
+static int qcom_pcie_parse_port(struct qcom_pcie *pcie, struct device_node *node)
+{
+	struct device *dev = pcie->pci->dev;
+	struct qcom_pcie_port *port;
+	struct gpio_desc *reset;
+	struct phy *phy;
+
+	reset = devm_fwnode_gpiod_get(dev, of_fwnode_handle(node),
+				      "reset", GPIOD_OUT_HIGH, "PERST#");
+	if (IS_ERR(reset))
+		return PTR_ERR(reset);
+
+	phy = devm_of_phy_get(dev, node, NULL);
+	if (IS_ERR(phy))
+		return PTR_ERR(phy);
+
+	port = devm_kzalloc(dev, sizeof(*port), GFP_KERNEL);
+	if (!port)
+		return -ENOMEM;
+
+	port->reset = reset;
+	port->phy = phy;
+	INIT_LIST_HEAD(&port->list);
+	list_add_tail(&port->list, &pcie->ports);
+
+	return 0;
+}
+
 static int qcom_pcie_probe(struct platform_device *pdev)
 {
 	const struct qcom_pcie_cfg *pcie_cfg;
 	unsigned long max_freq = ULONG_MAX;
+	struct qcom_pcie_port *port, *tmp;
 	struct device *dev = &pdev->dev;
+	struct device_node *of_port;
 	struct dev_pm_opp *opp;
 	struct qcom_pcie *pcie;
 	struct dw_pcie_rp *pp;
@@ -1611,6 +1690,8 @@ static int qcom_pcie_probe(struct platform_device *pdev)
 	if (ret < 0)
 		goto err_pm_runtime_put;
 
+	INIT_LIST_HEAD(&pcie->ports);
+
 	pci->dev = dev;
 	pci->ops = &dw_pcie_ops;
 	pp = &pci->pp;
@@ -1619,12 +1700,6 @@ static int qcom_pcie_probe(struct platform_device *pdev)
 
 	pcie->cfg = pcie_cfg;
 
-	pcie->reset = devm_gpiod_get_optional(dev, "perst", GPIOD_OUT_HIGH);
-	if (IS_ERR(pcie->reset)) {
-		ret = PTR_ERR(pcie->reset);
-		goto err_pm_runtime_put;
-	}
-
 	pcie->parf = devm_platform_ioremap_resource_byname(pdev, "parf");
 	if (IS_ERR(pcie->parf)) {
 		ret = PTR_ERR(pcie->parf);
@@ -1647,12 +1722,6 @@ static int qcom_pcie_probe(struct platform_device *pdev)
 		}
 	}
 
-	pcie->phy = devm_phy_optional_get(dev, "pciephy");
-	if (IS_ERR(pcie->phy)) {
-		ret = PTR_ERR(pcie->phy);
-		goto err_pm_runtime_put;
-	}
-
 	/* OPP table is optional */
 	ret = devm_pm_opp_of_add_table(dev);
 	if (ret && ret != -ENODEV) {
@@ -1699,9 +1768,31 @@ static int qcom_pcie_probe(struct platform_device *pdev)
 
 	pp->ops = &qcom_pcie_dw_ops;
 
-	ret = phy_init(pcie->phy);
-	if (ret)
-		goto err_pm_runtime_put;
+	for_each_child_of_node(dev->of_node, of_port) {
+		ret = qcom_pcie_parse_port(pcie, of_port);
+		of_node_put(of_port);
+		if (ret)
+			break;
+	}
+
+	/* Fallback to previous method */
+	if (ret) {
+		pcie->phy = devm_phy_optional_get(dev, "pciephy");
+		if (IS_ERR(pcie->phy)) {
+			ret = PTR_ERR(pcie->phy);
+			goto err_pm_runtime_put;
+		}
+
+		pcie->reset = devm_gpiod_get_optional(dev, "perst", GPIOD_OUT_HIGH);
+		if (IS_ERR(pcie->reset)) {
+			ret = PTR_ERR(pcie->reset);
+			goto err_pm_runtime_put;
+		}
+
+		ret = phy_init(pcie->phy);
+		if (ret)
+			goto err_pm_runtime_put;
+	}
 
 	platform_set_drvdata(pdev, pcie);
 
@@ -1746,10 +1837,16 @@ static int qcom_pcie_probe(struct platform_device *pdev)
 err_host_deinit:
 	dw_pcie_host_deinit(pp);
 err_phy_exit:
-	phy_exit(pcie->phy);
+	if (list_empty(&pcie->ports))
+		phy_exit(pcie->phy);
+	else
+		list_for_each_entry_safe(port, tmp, &pcie->ports, list)
+			phy_exit(port->phy);
 err_pm_runtime_put:
 	pm_runtime_put(dev);
 	pm_runtime_disable(dev);
+	list_for_each_entry_safe(port, tmp, &pcie->ports, list)
+		list_del(&port->list);
 
 	return ret;
 }

-- 
2.34.1


