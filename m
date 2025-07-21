Return-Path: <linux-kernel+bounces-738769-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 36C2DB0BCCE
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 08:40:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AD2DE7A0595
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 06:37:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C6A427C150;
	Mon, 21 Jul 2025 06:38:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="FX94H6SP"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CCCF1A23B5
	for <linux-kernel@vger.kernel.org>; Mon, 21 Jul 2025 06:38:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753079935; cv=none; b=uGbNd5AQ/C0C1pZ9scL+7HUO9JXKnOCmp/p8SdslrWXrSXKI2SDqtu7obiWBYgPJX1o+2jKm/5YSNW+ihrZLbp+TRJtt5NgCZaQhItaOto3G6dfMrE+5B2NJZ5Pb5V1DFuzohOt2mWIBaOxNcYPtuQDxs3APGylFeS6V3+md70w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753079935; c=relaxed/simple;
	bh=2xg0NV/M3b1B1hjZbwFKdPDsyamKVf1rmwKufVJSzuU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=eQmmjMG9HC5E187Tpe56vuu/KhdFSCHsjnQ1dDg4PeUvHU4NyjylSHkypeULHdh8vz7YgUvn0txmIljWrcOvXl4gSDvBSxQUEuNn+A2b9YW5kMCgJ3UrWPPY2bnrcJXncBfCPZGb75Qa5yz7WSb/nEhJ4tQKpPv3VcG3xVX+Wzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=FX94H6SP; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56L40m6W005221
	for <linux-kernel@vger.kernel.org>; Mon, 21 Jul 2025 06:38:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=fYHYCnRlqnA8SARi373nD6
	538xoAzXeqruNe6iQgZOI=; b=FX94H6SPHQj4sMft4J4ZhdRBTMkYvNVrP3iHsI
	h8i2TCBj4mlfzqZygKKlTd0/L8fNIGHcbVbKmzVYnRvJJtTEhsPn/9NCQErqvG5H
	OGfMbsEVUM3TkPJ3tLZheZE7pfGDgWt6Iim9WpKwpFc3u1brlc8qIxW5TIZCJlbS
	26SYtt5uLAsAKTdt78e81BNl/DOhjpkgE7hgZijPvzMZnOHk9yF8VIeMZDAqmNYg
	MnstvD2CWZkmNDqRIjyNlVN/BzDqTYJKBvfPCBgnypg9Mym1KUaQBKGEL6nK9kzF
	0SbWpXpDQ3EhKzZbi9hQIwGAstSQBGVGxXdxRxUcnN74dQQg==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4804n9ujbu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 21 Jul 2025 06:38:52 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-7491814d6f2so3209069b3a.3
        for <linux-kernel@vger.kernel.org>; Sun, 20 Jul 2025 23:38:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753079931; x=1753684731;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fYHYCnRlqnA8SARi373nD6538xoAzXeqruNe6iQgZOI=;
        b=s92YYY6VVXArJsUgbYK1hkNqOjxIjMGNGVO78zJX2wQIiIsf7Y0Ob5Jjbjcxk9Q7ig
         LmJP8GpHYcLW2W0kVK1BQRA50YaZZx3x5wGKJqbDS/6Bha4kBqdIJDydeFqWNSXHf0xE
         PI4AZwDAFs25AEWgEYhS5tF+tGJpP8bJbJ13LPsr+O8annxWIvFAX1+bBrokRKbcUMX0
         WQPl5k6WV32fgXJpg4ubYjYG9x9Yc2qHNjYWVtT1czUNvqxgEehDBkFUziVHNuTNSauw
         Wt3wEa2kj1fS3PbP5c05VOMR/tB6jbaQLO5GQxrKuz8AKeHHF8+uwLnMlhAkwLcp35VH
         CDcQ==
X-Forwarded-Encrypted: i=1; AJvYcCUqN8+z+aqZ08PD+52zJ8Zr0PJXrggGfswYLvN+zEOd3LEfPEsCUMJeK4dk6xMi3hXalg7ci4lrZltYMxM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxIP/VkQpngKD/GChRuQPnJmL8NTZjhizV2iQ+UuC+7fiecgU3e
	XFVVaV0kGW5u+yv5tuPmrc6cK5pIlubce99bclxkroTTMlEO8BSzSJX7nJ28Mzg5udZB5XDXmxm
	MtW+lrWdYwzC5nRrhKZckqiT4FeKwu+PPJxIsbN3YUtEdQywunvyjihgp5fT8h7EhLuk=
X-Gm-Gg: ASbGncvyLccwQQxWCS1+xQg8+nhQuk9y5IksKH5McNmv9j5hwLOtsKWvyU7JtIAvR6b
	lL1h9B7qTLEeGY6TYHKiJxtuAeeEi8RGEm5dLDo3K2RpQxrbPz5WP8l31ss2tsQJj54ZTNUwahS
	cc4+gGnpraaFeqTOPVqfNiWU6gGkEZYYTQfDePJ3LaBurSKJL5mPxmDn5btD6zJdx6las3t5c/9
	UNLpXKotFzpgGJhFqRQ8sEDqDEnN1Fn1CEfALYsn3OWPgSBmCYtnybmj+N/SF2SHJWC7yWGxECq
	+gia0+NS1H4f9/U691AqRlj4DTDkJNdTgzEsk6kLs9Wbt2auP8KZ5amTXlW7zy5ykOWh
X-Received: by 2002:a05:6a00:1488:b0:736:6043:69f9 with SMTP id d2e1a72fcca58-7584b13905dmr21777751b3a.19.1753079931072;
        Sun, 20 Jul 2025 23:38:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHe3084qTMHfewaxpTs+H7S7dY/TNvKUMB/eyZxsYUU44g7Ux5hgQk/0nK2V1m3gP2ZCscKDw==
X-Received: by 2002:a05:6a00:1488:b0:736:6043:69f9 with SMTP id d2e1a72fcca58-7584b13905dmr21777730b3a.19.1753079930597;
        Sun, 20 Jul 2025 23:38:50 -0700 (PDT)
Received: from hu-kbajaj-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-759cb154745sm5149329b3a.91.2025.07.20.23.38.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Jul 2025 23:38:50 -0700 (PDT)
From: Komal Bajaj <komal.bajaj@oss.qualcomm.com>
Date: Mon, 21 Jul 2025 12:08:41 +0530
Subject: [PATCH v6] usb: misc: qcom_eud: Access EUD_MODE_MANAGER2 through
 secure calls
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250721-eud_mode_manager_secure_access-v6-1-fe603325ac04@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIAHDgfWgC/42OMY7CMBQFr4Jc48hxcAxU3GOFoo/zIIY4Bn8S7
 Qrl7muokGhonjTNzHsIRvJgsV08RMLk2cchQ71cCNfRcIL0bWahlTbKlkZibJsQWzSBBjohNQw
 3JjTkHJhlDWNROVvCaZEl14Sj/30FfvaZjykGee8S6E2rNqo2pqoKbaxeyVJeYqC+ONCZzrvIX
 NxG6l0MocjztHae7zH9vV5P5un++uBksh+23hxQqXW7os/Afp7nfxHRjRkZAQAA
X-Change-ID: 20250715-eud_mode_manager_secure_access-6e57e3c71ec2
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Souradeep Chowdhury <quic_schowdhu@quicinc.com>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Melody Olvera <quic_molvera@quicinc.com>,
        Komal Bajaj <komal.bajaj@oss.qualcomm.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1753079927; l=5653;
 i=komal.bajaj@oss.qualcomm.com; s=20250710; h=from:subject:message-id;
 bh=2xg0NV/M3b1B1hjZbwFKdPDsyamKVf1rmwKufVJSzuU=;
 b=NyR8KHH4oexneKEyVAQGrT4A+qpwhmKpQbvYXNLTleW6BHByNB6K3SHd3DxZiS+uplKzAaXhP
 tAgt0Ag8tjmA7C/pRvsHkqtwaVZq4CNcH9vcZJLnG1yyMFS8fZkDFl5
X-Developer-Key: i=komal.bajaj@oss.qualcomm.com; a=ed25519;
 pk=wKh8mgDh+ePUZ4IIvpBhQOqf16/KvuQHvSvHK20LXNU=
X-Proofpoint-GUID: UDvgXfmMJa0vH_pTU2QCKXNwbo9Of7fi
X-Proofpoint-ORIG-GUID: UDvgXfmMJa0vH_pTU2QCKXNwbo9Of7fi
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzIxMDA1NiBTYWx0ZWRfX31yPfa2tr3SU
 IVCXfoSrD8CHZr2apd+FlTmiEkLs/PDB9sPd9qQTco17P6uzMljmJ0CpOELEWTQLSDYVOf38FW1
 FNazHeHpuqInLsOlme6++bwzKc8/V0Czxm8+ZiZbBTxFO27SgRXjBvFQXG3cV4687DFUVk9/B+f
 IYiorFMn57FaUHralPK31GmTLs+/gsQPdAp0we+FHhNrxkhAAA+P3VQKAMBaEVspPagkgidYyC1
 RxDjYwWrresGv5H3svLbxvuXh2KqJxoBvH/Iu/P/hnK9Xutc6tZ+qkedcD/00jiiwtonXNRDINn
 58u6E79sOZe4UsLcP8hrPuqLno7fu2FaV9tiyqc7VkFPqzOIX/y4KOsitMXmKhw7tLLStRGInKb
 3rxGeJoxpSnDSRyKx1m6Wh/hB4uRAiP6qxjfYT2v2Q3kpjOW+OGHxN7yvn5BWJ35ogV7DqQC
X-Authority-Analysis: v=2.4 cv=DoFW+H/+ c=1 sm=1 tr=0 ts=687de07c cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=COk6AnOGAAAA:8 a=lmNMGcLygp3pFLK-ZoUA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=2VI0MkxyNR6bbpdq8BZq:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-21_02,2025-07-17_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 clxscore=1015 mlxscore=0 mlxlogscore=999
 bulkscore=0 impostorscore=0 malwarescore=0 lowpriorityscore=0 adultscore=0
 spamscore=0 priorityscore=1501 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507210056

EUD_MODE_MANAGER2 register is mapped to a memory region that is marked
as read-only for HLOS, enforcing access restrictions that prohibit
direct memory-mapped writes via writel().

Attempts to write to this region from HLOS can result in silent failures
or memory access violations, particularly when toggling EUD (Embedded
USB Debugger) state. To ensure secure register access, modify the driver
to use qcom_scm_io_writel(), which routes the write operation to Qualcomm
Secure Channel Monitor (SCM). SCM has the necessary permissions to access
protected memory regions, enabling reliable control over EUD state.

SC7280, the only user of EUD is also affected, indicating that this could
never have worked on a properly fused device.

Fixes: 9a1bf58ccd44 ("usb: misc: eud: Add driver support for Embedded USB Debugger(EUD)")
Signed-off-by: Melody Olvera <quic_molvera@quicinc.com>
Signed-off-by: Komal Bajaj <komal.bajaj@oss.qualcomm.com>
Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
---
Changes in v6:
- Propagating the error code from disable_eud(), per Dmitry's suggestion
- Link to v5: https://lore.kernel.org/r/20250715-eud_mode_manager_secure_access-v5-1-e769be308d4a@oss.qualcomm.com

usb: misc: qcom_eud: Access EUD_MODE_MANAGER2 through secure calls

Changes in v5:
* Changed select QCOM_SCM to depends on QCOM_SCM in Kconfig per Greg's review
* Link to v4: https://lore.kernel.org/all/20250709065533.25724-1-komal.bajaj@oss.qualcomm.com/

Changes in v4:
* Added error logging in disable_eud() for SCM write failures, per Konrad’s suggestion
* Link to v3: https://lore.kernel.org/all/20250708085208.19089-1-komal.bajaj@oss.qualcomm.com/

Changes in v3:
* Moved secure write before normal writes
* Added error checking in disable_eud()
* Use ENOMEM error code if platform_get_resource() fails
* Select QCOM_SCM driver if USB_QCOM_EUD is enabled
* Link to v2: https://lore.kernel.org/all/20250627125131.27606-1-komal.bajaj@oss.qualcomm.com/

Changes in v2:
* Drop separate compatible to be added for secure eud
* Use secure call to access EUD mode manager register
* Link to v1: https://lore.kernel.org/all/20240807183205.803847-1-quic_molvera@quicinc.com/
---
 drivers/usb/misc/Kconfig    |  1 +
 drivers/usb/misc/qcom_eud.c | 33 ++++++++++++++++++++++++---------
 2 files changed, 25 insertions(+), 9 deletions(-)

diff --git a/drivers/usb/misc/Kconfig b/drivers/usb/misc/Kconfig
index 6497c4e81e951a14201ad965dadc29f9888f8254..73ebd3257625e4567f33636cdfd756344b9ed4e7 100644
--- a/drivers/usb/misc/Kconfig
+++ b/drivers/usb/misc/Kconfig
@@ -147,6 +147,7 @@ config USB_APPLEDISPLAY
 config USB_QCOM_EUD
 	tristate "QCOM Embedded USB Debugger(EUD) Driver"
 	depends on ARCH_QCOM || COMPILE_TEST
+	depends on QCOM_SCM
 	select USB_ROLE_SWITCH
 	help
 	  This module enables support for Qualcomm Technologies, Inc.
diff --git a/drivers/usb/misc/qcom_eud.c b/drivers/usb/misc/qcom_eud.c
index 83079c414b4f281b2136d0d1eb39418c7f94ff8c..05c8bdc943a88dab6159a05c2d770484c084f7b7 100644
--- a/drivers/usb/misc/qcom_eud.c
+++ b/drivers/usb/misc/qcom_eud.c
@@ -15,6 +15,7 @@
 #include <linux/slab.h>
 #include <linux/sysfs.h>
 #include <linux/usb/role.h>
+#include <linux/firmware/qcom/qcom_scm.h>
 
 #define EUD_REG_INT1_EN_MASK	0x0024
 #define EUD_REG_INT_STATUS_1	0x0044
@@ -34,7 +35,7 @@ struct eud_chip {
 	struct device			*dev;
 	struct usb_role_switch		*role_sw;
 	void __iomem			*base;
-	void __iomem			*mode_mgr;
+	phys_addr_t			mode_mgr;
 	unsigned int			int_status;
 	int				irq;
 	bool				enabled;
@@ -43,18 +44,29 @@ struct eud_chip {
 
 static int enable_eud(struct eud_chip *priv)
 {
+	int ret;
+
+	ret = qcom_scm_io_writel(priv->mode_mgr + EUD_REG_EUD_EN2, 1);
+	if (ret)
+		return ret;
+
 	writel(EUD_ENABLE, priv->base + EUD_REG_CSR_EUD_EN);
 	writel(EUD_INT_VBUS | EUD_INT_SAFE_MODE,
 			priv->base + EUD_REG_INT1_EN_MASK);
-	writel(1, priv->mode_mgr + EUD_REG_EUD_EN2);
 
 	return usb_role_switch_set_role(priv->role_sw, USB_ROLE_DEVICE);
 }
 
-static void disable_eud(struct eud_chip *priv)
+static int disable_eud(struct eud_chip *priv)
 {
+	int ret;
+
+	ret = qcom_scm_io_writel(priv->mode_mgr + EUD_REG_EUD_EN2, 0);
+	if (ret)
+		return ret;
+
 	writel(0, priv->base + EUD_REG_CSR_EUD_EN);
-	writel(0, priv->mode_mgr + EUD_REG_EUD_EN2);
+	return 0;
 }
 
 static ssize_t enable_show(struct device *dev,
@@ -82,11 +94,12 @@ static ssize_t enable_store(struct device *dev,
 			chip->enabled = enable;
 		else
 			disable_eud(chip);
+
 	} else {
-		disable_eud(chip);
+		ret = disable_eud(chip);
 	}
 
-	return count;
+	return ret < 0 ? ret : count;
 }
 
 static DEVICE_ATTR_RW(enable);
@@ -178,6 +191,7 @@ static void eud_role_switch_release(void *data)
 static int eud_probe(struct platform_device *pdev)
 {
 	struct eud_chip *chip;
+	struct resource *res;
 	int ret;
 
 	chip = devm_kzalloc(&pdev->dev, sizeof(*chip), GFP_KERNEL);
@@ -200,9 +214,10 @@ static int eud_probe(struct platform_device *pdev)
 	if (IS_ERR(chip->base))
 		return PTR_ERR(chip->base);
 
-	chip->mode_mgr = devm_platform_ioremap_resource(pdev, 1);
-	if (IS_ERR(chip->mode_mgr))
-		return PTR_ERR(chip->mode_mgr);
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 1);
+	if (!res)
+		return -ENODEV;
+	chip->mode_mgr = res->start;
 
 	chip->irq = platform_get_irq(pdev, 0);
 	if (chip->irq < 0)

---
base-commit: 347e9f5043c89695b01e66b3ed111755afcf1911
change-id: 20250715-eud_mode_manager_secure_access-6e57e3c71ec2

Best regards,
-- 
Komal Bajaj <komal.bajaj@oss.qualcomm.com>


