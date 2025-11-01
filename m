Return-Path: <linux-kernel+bounces-881110-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A678C277AB
	for <lists+linux-kernel@lfdr.de>; Sat, 01 Nov 2025 05:30:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E50004E79E5
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Nov 2025 04:30:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61D6C288C2B;
	Sat,  1 Nov 2025 04:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="RecnS/G3";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="CM/she/9"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D14E62877E3
	for <linux-kernel@vger.kernel.org>; Sat,  1 Nov 2025 04:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761971422; cv=none; b=JuNvyi6ba+krkX9rNkHVNOCDCRoC+SJIUsxkPIC6wpevtXH+vtgr/qhR3bUolHCt1IDh+KFulzb71FwbsEocfdWuUq3OSA35LKSNSxl9+ChlkyrTHcsUbhdVJq5kU0/hJ29VLCGJJJJFOPPpUpK29dXDvTCAeoJAzCWzctd5ZQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761971422; c=relaxed/simple;
	bh=z6Ma1tu8vEZQke3NjkVPJHb01xM4bsdEHhx7cBiREVQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gN05fiy4tuOyBOFGNZ59L/7BHQYK1X1Sy5Z2yYcNgvx9gj421BqPMRGs/BKlVgp6Lj41sX5VVGpVYV5cRfafBWuu+RwB3bIT4N1hBwFVb7l9GMr2kiOKo/h8B81zMRPhYl2UFoJ1B5H/3rd6fqG7nku0ARhF9wHDeEBNxmEvH/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=RecnS/G3; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=CM/she/9; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5A13YnML428426
	for <linux-kernel@vger.kernel.org>; Sat, 1 Nov 2025 04:30:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	/qVs9Q8bbIIjhgXIhLzUmZHcUu/XIpCZrPOB7b/VeVM=; b=RecnS/G3GBUtr5sn
	0pgi0zH4N0oEH5hRWMkSNXc/6hZzq5ceyfpRNFy7Nt3gTjsVNCYb4uAFFxZZkkzU
	o3vUIkg6nZ3oxH9EIgBrYqKEAaOJbkaRquqZgeFNSNvweh7dWRkJBqcJDl1DJ3V3
	5qw+dTA0Hx2N/wrctsew1WbkBVhWpcg1oLhX17KmPwXugMUvr+bpYiD/ZgOQ8x32
	0AKKl/88Ju94SEkZ/xaSqWhzWd/e2GF78B/06lRImmUY3OXRNO5a8ce7j2VXBDw5
	SZSDZGRUJ4UE3vsCoWtgfsdwA+hMyGEZ2aDsBaLaRkDmmbWtfszTkaEqklbGvYvD
	/vfZ5Q==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a5ae30255-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Sat, 01 Nov 2025 04:30:19 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-290e4fade70so36210005ad.2
        for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 21:30:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1761971416; x=1762576216; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/qVs9Q8bbIIjhgXIhLzUmZHcUu/XIpCZrPOB7b/VeVM=;
        b=CM/she/93Bz0K+pvTNrQ9NXuVFmDsxQkTKwiaQQ26JwUypTZ3Ki/2M9VBW2vSqBRN9
         gOaVEIGgT6JpcFawKtkG2OsLaZ8SJfgj8Eon59B1mBKESVgLpn8/Ij9qvH18BrEN3C1V
         YM9o2rpd7oq8VPRYBTrnRUEYZit2z4Cndf4i9B50frzu7opH8wl8SspLTt4RpmjYJ1Ih
         UE3873Uux8CMddzC/KEEUtwpPNzyrVHtsTfTlyce+scHZXl52P950kDddGPzKhCg3F4K
         fXDLOjVZtXft7zP9uHhYEjt2a5vSbPgmrKHcCXLZo6EjvZ3AJ5nyKymsCll5n6Lu4KNA
         lefg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761971416; x=1762576216;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/qVs9Q8bbIIjhgXIhLzUmZHcUu/XIpCZrPOB7b/VeVM=;
        b=Wt62vVZmZlCvCGx3QpWzaE33kps4t5dcWnkOa2ODu27r2s8v39QdUE/oXPPmTwAXop
         2l7aUK+iN3tyHn6RFjQrDcBejXEKGS3zvhs6N3a82FuDPmIOl0txOj0jpLFcageIGcKe
         K9cAJelT3ZT0HwedLr1z/Q/wZYht1dtp5QEh1bKZatNPltXAz38BnIUAAIaFy1oGZWYs
         8KzNxCWiy7eHxMjU4BCvTB4gi5NOfGfUoAIf3k652gPfcOnnd6Widv5H7X5LCKEOzxZk
         SPyClk6k73cSp6GvJGPV6CHY3P9raWl5HpTy06H9borJ5lYrxcHKFRt/IIy2sY+lL+Xb
         4oNw==
X-Forwarded-Encrypted: i=1; AJvYcCV53Si5zoGTx52twtm59jRTtJbvOKruxAk4VdYg4twLANftk8WAB+7rzaxkFxBjUFjtrvW/V8V8GzpSWQs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzvw9G0zlci4Dfv0f0iJRvfUq76V5bBZ1yjVTJiW/9KbQUDr4Un
	C5pAggLpNbWptcuYjLfbAbCF39e/ZnGc+WxmGsLqp3pbbmc08juOfbgET7o/D5ZzVmP/lyKykdx
	5EV3vqo47pUvMqa0p44iZW2aWuIJrATYPztSsh7VL3QZL6b26AuD6/NPcYPbSxfNExpo=
X-Gm-Gg: ASbGncvaRy2g4njZl7Ii8otMqGbh5PD2MLUOQ8Z4rYfaYc0klJSsW3setSr4eSD4/PP
	awaJ0He7S9G6Nab3UW42VEjNpDdYqoIM1Gs5iwfRR3YrrbI3soGjP9fcM2tdnpKE5oSm0ne4mrr
	sWEd8Bo6oKu08UHh1QoZqz3wsNansAZVTwYMDJ2Clx5xwG6jGWFlZ9NIBtERweDnBkyaTf2fC8n
	OC486KqCeqyxaosuUO8iCl2Re4gfUI4aLpH7I3jBGlwdihfqkHFTFQsXk2ler4VG6SW2GXqk1l3
	nXfPTvy5or517ieBR1GjwUEw4MWtE0ovoOcUtcpbmIoElxVLW8rbP49lpYmRZLRBgcur9trZR9t
	U1ajCD26hIOgm4aW0rdaOgjYS
X-Received: by 2002:a17:902:dac7:b0:295:2c8e:8e50 with SMTP id d9443c01a7336-2952c8e96d9mr46357465ad.31.1761971415814;
        Fri, 31 Oct 2025 21:30:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IERXDukIavO9PR4//phPyGJduf0lbjAG/4vEikdn++zQ0+zjHP/5yiGYQHVqvMFXMVQNa2R6A==
X-Received: by 2002:a17:902:dac7:b0:295:2c8e:8e50 with SMTP id d9443c01a7336-2952c8e96d9mr46356885ad.31.1761971415224;
        Fri, 31 Oct 2025 21:30:15 -0700 (PDT)
Received: from work.lan ([2409:4091:a0f4:6806:9857:f290:6ecf:344f])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-295268717ffsm42273285ad.2.2025.10.31.21.30.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Oct 2025 21:30:15 -0700 (PDT)
From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
Date: Sat, 01 Nov 2025 09:59:42 +0530
Subject: [PATCH RESEND 3/3] PCI: meson: Fix parsing the DBI register region
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251101-pci-meson-fix-v1-3-c50dcc56ed6a@oss.qualcomm.com>
References: <20251101-pci-meson-fix-v1-0-c50dcc56ed6a@oss.qualcomm.com>
In-Reply-To: <20251101-pci-meson-fix-v1-0-c50dcc56ed6a@oss.qualcomm.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Hanjie Lin <hanjie.lin@amlogic.com>, Yue Wang <yue.wang@amlogic.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Andrew Murray <amurray@thegoodpenguin.co.uk>,
        Jingoo Han <jingoohan1@gmail.com>,
        Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Cc: linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>,
        stable@vger.kernel.org, Linnaea Lavia <linnaea-von-lavia@live.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3414;
 i=manivannan.sadhasivam@oss.qualcomm.com; h=from:subject:message-id;
 bh=z6Ma1tu8vEZQke3NjkVPJHb01xM4bsdEHhx7cBiREVQ=;
 b=owEBbQGS/pANAwAKAVWfEeb+kc71AcsmYgBpBYy++GDC2FdF4Z/6/YuKrqvsPRDzSYzArhNo/
 +csT538cMWJATMEAAEKAB0WIQRnpUMqgUjL2KRYJ5dVnxHm/pHO9QUCaQWMvgAKCRBVnxHm/pHO
 9Wl9B/4lJRWgp4jLVDF1SYqDPGUDzcb472y2yeMmk2rkFfb2Uv1hlk/XcpOEfQgBpX/u8ZpXBEq
 T7H5Bx2EFq4Soc4HdtjIYaui17kadQmI7NRJFmmxhC1xko8FftZXxZfEtoP7KnqUP81m2N60jRI
 lMArC53Nmr1Sf+hjpHeorOGbMovA2mC7P2H7k9M4hLM015Lj6soWc5ViRjg3fdJyHkz/sZ9YvNN
 uoQp8w6yVTVJW+fZ5JSvDDRb/4HVStZmmu0VCObZK3EqVhOq8mGy7HXd5724d3JaWSl+0Ldj3N6
 zW3Xk0bmCRmxWBjbPLOoTUS+M5L+oB3GOZ2L9kk3WUiDVkYR
X-Developer-Key: i=manivannan.sadhasivam@oss.qualcomm.com; a=openpgp;
 fpr=C668AEC3C3188E4C611465E7488550E901166008
X-Proofpoint-ORIG-GUID: Vh5pWZBRerUJImy-tZlAB3H-k7Jp3wlm
X-Proofpoint-GUID: Vh5pWZBRerUJImy-tZlAB3H-k7Jp3wlm
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTAxMDAzNSBTYWx0ZWRfXyHENbkwLdqvq
 RacHk9IVCKPy9ndgY/Up4m8RgvJQsl36zPY7ABJIFAPMdY6sG/EtruLN+0iuUCB0S+OI6n17+bt
 U/azfeBZ0M1Y4uKrol4TYl2sHCtKiQ6zOl/3w8JCr/f7apZ664wKz1Lltdni8pdvhKPHaXZfCeG
 Apy/qqUihXr1FtdiyILZ0MbVb8OP4eGgbl/P44hQsdlubwuGTL1KRhYQOV7ncLnitSOOCXYjG9E
 hRodLYUBb7nbQDcEoqan2u8+5+bEEFS1imX80foY7UZz+wnacK+zG9drTE4t4mr4KWdEccu/X/v
 864/L3WMJwlK31DoTuN52mhN8UAqEHaHBnzDnq6M0HcdcFNusit2lNaUiKJp+RI5Cpi2Z/MV9G1
 QJgXuzbQIdIuZsmiwQgLmDzyczzFSA==
X-Authority-Analysis: v=2.4 cv=CfUFJbrl c=1 sm=1 tr=0 ts=69058cdb cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=UqCG9HQmAAAA:8 a=Zk3OmFfbAAAA:8 a=EUspDBNiAAAA:8
 a=szRsftEmMXlY6Mt0pVQA:9 a=QEXdDO2ut3YA:10 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-10-31_08,2025-10-29_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 impostorscore=0 spamscore=0 bulkscore=0
 adultscore=0 phishscore=0 lowpriorityscore=0 priorityscore=1501 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511010035

First of all, the driver was parsing the 'dbi' register region as 'elbi'.
This was due to DT mistakenly passing 'dbi' as 'elbi'. Since the DT is
now fixed to supply 'dbi' region, this driver can rely on the DWC core
driver to parse and map it.

However, to support the old DTs, if the 'elbi' region is found in DT, parse
and map the region as both 'dw_pcie::elbi_base' as 'dw_pcie::dbi_base'.
This will allow the driver to work with both broken and fixed DTs.

Also, skip parsing the 'elbi' region in DWC core if 'pci->elbi_base' was
already populated.

Cc: <stable@vger.kernel.org> # 6.2
Reported-by: Linnaea Lavia <linnaea-von-lavia@live.com>
Closes: https://lore.kernel.org/linux-pci/DM4PR05MB102707B8CDF84D776C39F22F2C7F0A@DM4PR05MB10270.namprd05.prod.outlook.com/
Fixes: 9c0ef6d34fdb ("PCI: amlogic: Add the Amlogic Meson PCIe controller driver")
Fixes: c96992a24bec ("PCI: dwc: Add support for ELBI resource mapping")
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
---
 drivers/pci/controller/dwc/pci-meson.c       | 18 +++++++++++++++---
 drivers/pci/controller/dwc/pcie-designware.c | 12 +++++++-----
 2 files changed, 22 insertions(+), 8 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-meson.c b/drivers/pci/controller/dwc/pci-meson.c
index 787469d1b396d4c7b3e28edfe276b7b997fb8aee..54b6a4196f1767a3c14c6c901bfee3505588134c 100644
--- a/drivers/pci/controller/dwc/pci-meson.c
+++ b/drivers/pci/controller/dwc/pci-meson.c
@@ -108,10 +108,22 @@ static int meson_pcie_get_mems(struct platform_device *pdev,
 			       struct meson_pcie *mp)
 {
 	struct dw_pcie *pci = &mp->pci;
+	struct resource *res;
 
-	pci->dbi_base = devm_platform_ioremap_resource_byname(pdev, "elbi");
-	if (IS_ERR(pci->dbi_base))
-		return PTR_ERR(pci->dbi_base);
+	/*
+	 * For the broken DTs that supply 'dbi' as 'elbi', parse the 'elbi'
+	 * region and assign it to both 'pci->elbi_base' and 'pci->dbi_space' so
+	 * that the DWC core can skip parsing both regions.
+	 */
+	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "elbi");
+	if (res) {
+		pci->elbi_base = devm_pci_remap_cfg_resource(pci->dev, res);
+		if (IS_ERR(pci->elbi_base))
+			return PTR_ERR(pci->elbi_base);
+
+		pci->dbi_base = pci->elbi_base;
+		pci->dbi_phys_addr = res->start;
+	}
 
 	mp->cfg_base = devm_platform_ioremap_resource_byname(pdev, "cfg");
 	if (IS_ERR(mp->cfg_base))
diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
index c644216995f69cbf065e61a0392bf1e5e32cf56e..06eca858eb1b3c7a8a833df6616febcdbe854850 100644
--- a/drivers/pci/controller/dwc/pcie-designware.c
+++ b/drivers/pci/controller/dwc/pcie-designware.c
@@ -168,11 +168,13 @@ int dw_pcie_get_resources(struct dw_pcie *pci)
 	}
 
 	/* ELBI is an optional resource */
-	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "elbi");
-	if (res) {
-		pci->elbi_base = devm_ioremap_resource(pci->dev, res);
-		if (IS_ERR(pci->elbi_base))
-			return PTR_ERR(pci->elbi_base);
+	if (!pci->elbi_base) {
+		res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "elbi");
+		if (res) {
+			pci->elbi_base = devm_ioremap_resource(pci->dev, res);
+			if (IS_ERR(pci->elbi_base))
+				return PTR_ERR(pci->elbi_base);
+		}
 	}
 
 	/* LLDD is supposed to manually switch the clocks and resets state */

-- 
2.48.1


