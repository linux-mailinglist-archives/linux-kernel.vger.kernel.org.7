Return-Path: <linux-kernel+bounces-781498-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A914BB3132C
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 11:32:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 78F361BA7052
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 09:30:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A16A2F3638;
	Fri, 22 Aug 2025 09:28:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="gLGG8d+q"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F8132F3625
	for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 09:28:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755854892; cv=none; b=blfEA5w33DCe3S0CaxewzfdmG5i+QqMJNc7hxZI3yrlTktl9tcggDAYgAKoD6tZfS1JAuDiT75n1TJKPyT5vW3p6TdSx0iphmK4gA/ivezCpBlyIChXguVlyPh9vuce6/Hyy/f821onBrraBHpW/uARdG14xH4Gcc1bDcGbj0xU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755854892; c=relaxed/simple;
	bh=nFLg5wH8xIrGYdT9z6N4nECdAzi2W08MBmRhPyuekxQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=NiDd+Yxnz2d5jtLZPVzRlHInCo3oHMrVNh3n9gK6O6IXK3FWwuXSIMvafmhxwjfkGy3sxV5IQmxMvFYq8pMN1nNLA1/rEAl54log5qbADei1LOpqmMKHNMxsLd2SIbLW6YZ89IoKyS3gLetBvncDcdmv1cOxHfmMesxUzD4RAdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=gLGG8d+q; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57M8UHxu027201
	for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 09:28:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	UGPmSMrj+Neb0BNEQ1okalh3SAoYshKWEx9mCEgb7/E=; b=gLGG8d+qMpWz9vr6
	mv7hcmU9NYivMERYERElviqTjLTRxxhDUv9iqTLHZ8jU41Y+gh+TKaRhktAiOwZY
	tNUDUahqrEOT41zOTCI2jJE1h4lJQIOWJqEZAuKH2DSMBGN3yRA7Q+ZXaOPwo+Na
	hOoCHIm+ZG44TixGzjGGf0H6+bsxPq/+Bch+Cr+AVfPMTWFYaYZq9t8heQfa0hRs
	t39GDCTCWSD+Mf5OuvHtG3j9UXJjnAow7LR74z8f3qXbCu5uChp75zq1qx8+CvG1
	1wJXriViAU8QNZnVtH7vFEa+CTVo4FWgNCIv1sW+fV72xya7jEUoNauw7kMprjfA
	s3ISyw==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48n5298prg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 09:28:08 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-b4750376ca8so1327796a12.2
        for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 02:28:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755854888; x=1756459688;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UGPmSMrj+Neb0BNEQ1okalh3SAoYshKWEx9mCEgb7/E=;
        b=vbFgncFdhn7F3b7cXzB5AIj5lwdB6TQONNn2sSj5h+hC0a2pvXuNdfZzf0omaX+6X1
         OQHs7nHO63UFCXS2zDF7VBxnfGRsNA+yMwglI+z5HQMs73jaiknXzrBT61YUUwNFh4gu
         gnVRXRiUzbLUVZgCKD6Wb0e0w89kNsQY51rmWx8qvpnJB351mHBGsfXP9+T/pARkeChx
         LvF+gZsWvmQc4x/5YnQyM6UoDgni254Gi1tXlnPNPcliFEfjm2Or86HYjsC8iIi5SI9v
         trNf3mDvUElkDv4gLWXh3rPdFUOqmMv9iUdP6CiwQIUE5NyXCd4U+w2zTUha2bHf3TPU
         8bEw==
X-Forwarded-Encrypted: i=1; AJvYcCXkVCSA48QLqyU+su0WRLrY0C20iFQab1r0RNBXbCYLwgpUVqQoo0gtqs85zC4GCLy6yXmYeSHBA5Ho8aM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwMAwwHxEDGc7sFc7I5/0MreUj20jRy8TTuThzBOLL05bWnVXSm
	LYLjBkZfVdm8bdJ+eoMGxNz0O08QUYx05UTl8pjcbdfM3EkMoEXsgQaFzK1AP5ZgbNuZ46Teg9k
	prRHRL8LsN4wgTHw1iEHJCHa3aqrFNF+oLlO7hCS35ZnMuVFnkGyiciTs99nf2nH+11w=
X-Gm-Gg: ASbGncsm8lTr3qdsEhF3YLRQHRlmqhJ8o98EexyLamXOR5fyS2EEZ24+GqN425MmtUg
	6XBwM6jUs7GukDOsCPr/2F9dWJ9VpUuO1Ri93gH/6Xp6ybAR3x0jSFCIKOB+jcQBB4uz06Mv2lE
	bqZZoMChpj7zFhGEX62TfZE16r2OeVAwfIYVwLX1Q+7jy32fa6OyfKcWreWagwn+5iItX7Gdgdr
	SkRrKUpvz5rmyCht25rzas7zLT/zTWx1XwvwfmfwREwKTvk5f6VvndE0ISxzO4LLVqVDYg7MfTw
	GNcwerXs6/m+E58D2ETFR8eMK1h4A1BVCRKe0lFj5J/+g021MT5llBViwRYIFTTqihGuujR6ajI
	=
X-Received: by 2002:a05:6a20:3c8f:b0:243:78a:829f with SMTP id adf61e73a8af0-24340e4855bmr3682367637.56.1755854888047;
        Fri, 22 Aug 2025 02:28:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGIYst4jdKeCh8OnTlVJBggJPua77/Bqprt9VZ0Teh08jJqTPXVAam405W8hCqKNxsyiI/9EQ==
X-Received: by 2002:a05:6a20:3c8f:b0:243:78a:829f with SMTP id adf61e73a8af0-24340e4855bmr3682329637.56.1755854887593;
        Fri, 22 Aug 2025 02:28:07 -0700 (PDT)
Received: from hu-krichai-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-32525205d1csm549417a91.4.2025.08.22.02.28.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Aug 2025 02:28:07 -0700 (PDT)
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Date: Fri, 22 Aug 2025 14:57:32 +0530
Subject: [PATCH v7 4/5] PCI: dwc: Add ECAM support with iATU configuration
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250822-ecam_v4-v7-4-098fb4ca77c1@oss.qualcomm.com>
References: <20250822-ecam_v4-v7-0-098fb4ca77c1@oss.qualcomm.com>
In-Reply-To: <20250822-ecam_v4-v7-0-098fb4ca77c1@oss.qualcomm.com>
To: cros-qcom-dts-watchers@chromium.org,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>, Jingoo Han <jingoohan1@gmail.com>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        quic_vbadigan@quicinc.com, quic_mrana@quicinc.com,
        quic_vpernami@quicinc.com, mmareddy@quicinc.com,
        Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1755854858; l=9433;
 i=krishna.chundru@oss.qualcomm.com; s=20230907; h=from:subject:message-id;
 bh=nFLg5wH8xIrGYdT9z6N4nECdAzi2W08MBmRhPyuekxQ=;
 b=FmtAM0GbiyuC6JP1x5jgJ4JsvWYfMNAQmhVU8NdT+BdTvTx6GzXBbF66rEgmDsvVRVAxkmipT
 OPpysaDEO3hD8vOSCjyjkrvFq+81sN4sin3c1h3EBHAIfHct5YX0sXD
X-Developer-Key: i=krishna.chundru@oss.qualcomm.com; a=ed25519;
 pk=10CL2pdAKFyzyOHbfSWHCD0X0my7CXxj8gJScmn1FAg=
X-Authority-Analysis: v=2.4 cv=ZJKOWX7b c=1 sm=1 tr=0 ts=68a83829 cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=EUspDBNiAAAA:8 a=KLD09g9XOrCUKH48cnIA:9
 a=QEXdDO2ut3YA:10 a=3WC7DwWrALyhR5TkjVHa:22
X-Proofpoint-ORIG-GUID: Or0dNcQ6mP6H7eZYp2471UXxFQL6v28v
X-Proofpoint-GUID: Or0dNcQ6mP6H7eZYp2471UXxFQL6v28v
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIwMDAxMyBTYWx0ZWRfX/x7KVXOisrHS
 OjT/oUcAHXDDyRe3T9V+lggl4jm0DgxT4NdT2frHe1cW8j7yxcr0R/eS974ifz9lUfpRKo5ii92
 x/yztxrVwRNZS/ewrfaiGn/jFcyRHP6rawPisT4x3sgY9s/8+WDAHZInjrk5mOQkmKEBxYCnIhB
 qAN88yw9oJKTCXCDkYUqMcMvrFumV1l+GMhfXjFsZJg3yYyxStG32ND3S5uv46NcKbEQEkr+4pq
 gc4r0vKvoDIOBV2XWj9PbUqTJ4S1Ea3WL88Hju/qJ9y2rPGURD8kCw0nTf3/S6qUhGUxRFfoxeL
 6aj3xnTM2Oi2ok+dU8gWQ9QcS5F2s6uRhPlt80V78uwCcks6Gq6o6RlwH/B0UFWtWE5fP5q61o1
 l8fcmqYzly/7+5GoF0Xo/Y7wCfI0Nw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-22_03,2025-08-20_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 priorityscore=1501 malwarescore=0 adultscore=0 suspectscore=0
 lowpriorityscore=0 impostorscore=0 phishscore=0 clxscore=1015 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2508110000 definitions=main-2508200013

The current implementation requires iATU for every configuration
space access which increases latency & cpu utilization.

Designware databook 5.20a, section 3.10.10.3 says about CFG Shift Feature,
which shifts/maps the BDF (bits [31:16] of the third header DWORD, which
would be matched against the Base and Limit addresses) of the incoming
CfgRd0/CfgWr0 down to bits[27:12]of the translated address.

Configuring iATU in config shift feature enables ECAM feature to access the
config space, which avoids iATU configuration for every config access.

Add "ctrl2" into struct dw_pcie_ob_atu_cfg  to enable config shift feature.

As DBI comes under config space, this avoids remapping of DBI space
separately. Instead, it uses the mapped config space address returned from
ECAM initialization. Change the order of dw_pcie_get_resources() execution
to achieve this.

Enable the ECAM feature if the config space size is equal to size required
to represent number of buses in the bus range property.

Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
---
 drivers/pci/controller/dwc/Kconfig                |   1 +
 drivers/pci/controller/dwc/pcie-designware-host.c | 131 +++++++++++++++++++---
 drivers/pci/controller/dwc/pcie-designware.c      |   2 +-
 drivers/pci/controller/dwc/pcie-designware.h      |   5 +
 4 files changed, 124 insertions(+), 15 deletions(-)

diff --git a/drivers/pci/controller/dwc/Kconfig b/drivers/pci/controller/dwc/Kconfig
index ff6b6d9e18ecfa44273e87931551f9e63fbe3cba..a0e7ad3fb5afec63b0f919732a50147229623186 100644
--- a/drivers/pci/controller/dwc/Kconfig
+++ b/drivers/pci/controller/dwc/Kconfig
@@ -20,6 +20,7 @@ config PCIE_DW_HOST
 	bool
 	select PCIE_DW
 	select IRQ_MSI_LIB
+	select PCI_HOST_COMMON
 
 config PCIE_DW_EP
 	bool
diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
index 952f8594b501254d2b2de5d5e056e16d2aa8d4b7..abb93265a19fd62d3fecc64f29f37baf67291b40 100644
--- a/drivers/pci/controller/dwc/pcie-designware-host.c
+++ b/drivers/pci/controller/dwc/pcie-designware-host.c
@@ -413,6 +413,81 @@ static void dw_pcie_host_request_msg_tlp_res(struct dw_pcie_rp *pp)
 	}
 }
 
+static int dw_pcie_config_ecam_iatu(struct dw_pcie_rp *pp)
+{
+	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
+	struct dw_pcie_ob_atu_cfg atu = {0};
+	resource_size_t bus_range_max;
+	struct resource_entry *bus;
+	int ret;
+
+	bus = resource_list_first_type(&pp->bridge->windows, IORESOURCE_BUS);
+
+	/*
+	 * Root bus under the host bridge doesn't require any iATU configuration
+	 * as DBI region will be used to access root bus config space.
+	 * Immediate bus under Root Bus, needs type 0 iATU configuration and
+	 * remaining buses need type 1 iATU configuration.
+	 */
+	atu.index = 0;
+	atu.type = PCIE_ATU_TYPE_CFG0;
+	atu.parent_bus_addr = pp->cfg0_base + SZ_1M;
+	/* 1MiB is to cover 1 (bus) * 32 (devices) * 8 (functions) */
+	atu.size = SZ_1M;
+	atu.ctrl2 = PCIE_ATU_CFG_SHIFT_MODE_ENABLE;
+	ret = dw_pcie_prog_outbound_atu(pci, &atu);
+	if (ret)
+		return ret;
+
+	bus_range_max = resource_size(bus->res);
+
+	if (bus_range_max < 2)
+		return 0;
+
+	/* Configure remaining buses in type 1 iATU configuration */
+	atu.index = 1;
+	atu.type = PCIE_ATU_TYPE_CFG1;
+	atu.parent_bus_addr = pp->cfg0_base + SZ_2M;
+	atu.size = (SZ_1M * bus_range_max) - SZ_2M;
+	atu.ctrl2 = PCIE_ATU_CFG_SHIFT_MODE_ENABLE;
+
+	return dw_pcie_prog_outbound_atu(pci, &atu);
+}
+
+static int dw_pcie_create_ecam_window(struct dw_pcie_rp *pp, struct resource *res)
+{
+	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
+	struct device *dev = pci->dev;
+	struct resource_entry *bus;
+
+	bus = resource_list_first_type(&pp->bridge->windows, IORESOURCE_BUS);
+	if (!bus)
+		return -ENODEV;
+
+	pp->cfg = pci_ecam_create(dev, res, bus->res, &pci_generic_ecam_ops);
+	if (IS_ERR(pp->cfg))
+		return PTR_ERR(pp->cfg);
+
+	pci->dbi_base = pp->cfg->win;
+	pci->dbi_phys_addr = res->start;
+
+	return 0;
+}
+
+static bool dw_pcie_ecam_enabled(struct dw_pcie_rp *pp, struct resource *config_res)
+{
+	struct resource *bus_range;
+	u64 nr_buses;
+
+	bus_range = resource_list_first_type(&pp->bridge->windows, IORESOURCE_BUS)->res;
+	if (!bus_range)
+		return false;
+
+	nr_buses = resource_size(config_res) >> PCIE_ECAM_BUS_SHIFT;
+
+	return !!(nr_buses >= resource_size(bus_range));
+}
+
 static int dw_pcie_host_get_resources(struct dw_pcie_rp *pp)
 {
 	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
@@ -422,10 +497,6 @@ static int dw_pcie_host_get_resources(struct dw_pcie_rp *pp)
 	struct resource *res;
 	int ret;
 
-	ret = dw_pcie_get_resources(pci);
-	if (ret)
-		return ret;
-
 	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "config");
 	if (!res) {
 		dev_err(dev, "Missing \"config\" reg space\n");
@@ -435,9 +506,32 @@ static int dw_pcie_host_get_resources(struct dw_pcie_rp *pp)
 	pp->cfg0_size = resource_size(res);
 	pp->cfg0_base = res->start;
 
-	pp->va_cfg0_base = devm_pci_remap_cfg_resource(dev, res);
-	if (IS_ERR(pp->va_cfg0_base))
-		return PTR_ERR(pp->va_cfg0_base);
+	pp->ecam_enabled = dw_pcie_ecam_enabled(pp, res);
+	if (pp->ecam_enabled) {
+		ret = dw_pcie_create_ecam_window(pp, res);
+		if (ret)
+			return ret;
+
+		pp->bridge->ops = (struct pci_ops *)&pci_generic_ecam_ops.pci_ops;
+		pp->bridge->sysdata = pp->cfg;
+		pp->cfg->priv = pp;
+	} else {
+		pp->va_cfg0_base = devm_pci_remap_cfg_resource(dev, res);
+		if (IS_ERR(pp->va_cfg0_base))
+			return PTR_ERR(pp->va_cfg0_base);
+
+		/* Set default bus ops */
+		pp->bridge->ops = &dw_pcie_ops;
+		pp->bridge->child_ops = &dw_child_pcie_ops;
+		pp->bridge->sysdata = pp;
+	}
+
+	ret = dw_pcie_get_resources(pci);
+	if (ret) {
+		if (pp->cfg)
+			pci_ecam_free(pp->cfg);
+		return ret;
+	}
 
 	/* Get the I/O range from DT */
 	win = resource_list_first_type(&pp->bridge->windows, IORESOURCE_IO);
@@ -476,14 +570,10 @@ int dw_pcie_host_init(struct dw_pcie_rp *pp)
 	if (ret)
 		return ret;
 
-	/* Set default bus ops */
-	bridge->ops = &dw_pcie_ops;
-	bridge->child_ops = &dw_child_pcie_ops;
-
 	if (pp->ops->init) {
 		ret = pp->ops->init(pp);
 		if (ret)
-			return ret;
+			goto err_free_ecam;
 	}
 
 	if (pci_msi_enabled()) {
@@ -525,6 +615,14 @@ int dw_pcie_host_init(struct dw_pcie_rp *pp)
 	if (ret)
 		goto err_free_msi;
 
+	if (pp->ecam_enabled) {
+		ret = dw_pcie_config_ecam_iatu(pp);
+		if (ret) {
+			dev_err(dev, "Failed to configure iATU in ECAM mode\n");
+			goto err_free_msi;
+		}
+	}
+
 	/*
 	 * Allocate the resource for MSG TLP before programming the iATU
 	 * outbound window in dw_pcie_setup_rc(). Since the allocation depends
@@ -560,8 +658,6 @@ int dw_pcie_host_init(struct dw_pcie_rp *pp)
 		/* Ignore errors, the link may come up later */
 		dw_pcie_wait_for_link(pci);
 
-	bridge->sysdata = pp;
-
 	ret = pci_host_probe(bridge);
 	if (ret)
 		goto err_stop_link;
@@ -587,6 +683,10 @@ int dw_pcie_host_init(struct dw_pcie_rp *pp)
 	if (pp->ops->deinit)
 		pp->ops->deinit(pp);
 
+err_free_ecam:
+	if (pp->cfg)
+		pci_ecam_free(pp->cfg);
+
 	return ret;
 }
 EXPORT_SYMBOL_GPL(dw_pcie_host_init);
@@ -609,6 +709,9 @@ void dw_pcie_host_deinit(struct dw_pcie_rp *pp)
 
 	if (pp->ops->deinit)
 		pp->ops->deinit(pp);
+
+	if (pp->cfg)
+		pci_ecam_free(pp->cfg);
 }
 EXPORT_SYMBOL_GPL(dw_pcie_host_deinit);
 
diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
index 4684c671a81bee468f686a83cc992433b38af59d..6826ddb9478d41227fa011018cffa8d2242336a9 100644
--- a/drivers/pci/controller/dwc/pcie-designware.c
+++ b/drivers/pci/controller/dwc/pcie-designware.c
@@ -576,7 +576,7 @@ int dw_pcie_prog_outbound_atu(struct dw_pcie *pci,
 		val = dw_pcie_enable_ecrc(val);
 	dw_pcie_writel_atu_ob(pci, atu->index, PCIE_ATU_REGION_CTRL1, val);
 
-	val = PCIE_ATU_ENABLE;
+	val = PCIE_ATU_ENABLE | atu->ctrl2;
 	if (atu->type == PCIE_ATU_TYPE_MSG) {
 		/* The data-less messages only for now */
 		val |= PCIE_ATU_INHIBIT_PAYLOAD | atu->code;
diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
index ceb022506c3191cd8fe580411526e20cc3758fed..f770e160ce7c538e0835e7cf80bae9ed099f906c 100644
--- a/drivers/pci/controller/dwc/pcie-designware.h
+++ b/drivers/pci/controller/dwc/pcie-designware.h
@@ -20,6 +20,7 @@
 #include <linux/irq.h>
 #include <linux/msi.h>
 #include <linux/pci.h>
+#include <linux/pci-ecam.h>
 #include <linux/reset.h>
 
 #include <linux/pci-epc.h>
@@ -169,6 +170,7 @@
 #define PCIE_ATU_REGION_CTRL2		0x004
 #define PCIE_ATU_ENABLE			BIT(31)
 #define PCIE_ATU_BAR_MODE_ENABLE	BIT(30)
+#define PCIE_ATU_CFG_SHIFT_MODE_ENABLE	BIT(28)
 #define PCIE_ATU_INHIBIT_PAYLOAD	BIT(22)
 #define PCIE_ATU_FUNC_NUM_MATCH_EN      BIT(19)
 #define PCIE_ATU_LOWER_BASE		0x008
@@ -387,6 +389,7 @@ struct dw_pcie_ob_atu_cfg {
 	u8 func_no;
 	u8 code;
 	u8 routing;
+	u32 ctrl2;
 	u64 parent_bus_addr;
 	u64 pci_addr;
 	u64 size;
@@ -425,6 +428,8 @@ struct dw_pcie_rp {
 	struct resource		*msg_res;
 	bool			use_linkup_irq;
 	struct pci_eq_presets	presets;
+	bool			ecam_enabled;
+	struct pci_config_window *cfg;
 };
 
 struct dw_pcie_ep_ops {

-- 
2.34.1


