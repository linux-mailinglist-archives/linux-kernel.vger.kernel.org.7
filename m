Return-Path: <linux-kernel+bounces-722914-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C12AAFE09E
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 08:55:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 13A051BC74C9
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 06:56:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34ED41C84D5;
	Wed,  9 Jul 2025 06:55:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="OppS0zo2"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2FB026B955
	for <linux-kernel@vger.kernel.org>; Wed,  9 Jul 2025 06:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752044142; cv=none; b=C9Gr1Q4gMZHvgildZecqUPAVNRglF4SrqU663NfPsxZL6r05sQyTbFbh481xEYAwuyCJjyBP7CxxzoN9Pwk4Rb1sSfgCKJEaW8kQaP2ARKmtShv8NJYfwDO4HG7GXj36ZFg4uIka19RI57N05JHvJGOGlY+5DAUHP20eRMsF+vU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752044142; c=relaxed/simple;
	bh=aStpdlLyG/6MtjjNhbFEJ4UHFKsyDfXe+V08u1Vqp4g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=FWbDUw1+wQr8mX5/fP/dJ3yhAkMywhbYuYAZFk+M/b+B04k9lVm4OS3JH8kXq8ggRAc7Eh2PQKuAOU2QgJcCZAyKxtxYE48ctQDkwDNBSvP4PZy1H999RdTUu+jZz9Hbv0VF5rrh5GSjWfkEEiBzkwpBjbifNTO5Rh1VYO/3B8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=OppS0zo2; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 568Ik6JY029330
	for <linux-kernel@vger.kernel.org>; Wed, 9 Jul 2025 06:55:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=+GJzZgUqMI2hbbRTEmaNiN
	bgqXt+YXuLS9oqBkPXt7A=; b=OppS0zo20JIOP80NQBVebFOdvtxWBw4BWRLgEA
	Otp3qLURRChF0OWQ6WYABHHdoLafukmveeit0Ben/UnOd/pFV6gIsobb2mbWjBfT
	UnpS7HSSsz0l6sOZu49jG8PzpN0jTWZiMHMp28jVp7K5xHMWcVXTkL9FP+VzXYZE
	6f3YgASBLcZx1zdrezS0mAe++LxGdesokUAeGO/ZAGxQxmP2pgcm/5LlEeociraO
	dPmH+a4PDS7vEsFXRMtbWh4d4oFB6QY3Zn0flqlMPS76XiikP3TyUaYkP/euY+Gy
	YwFJcXK0zHbf50RE9Aqxld5acGR3DCQcwzpzvB7peXfO8ILA==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47pv4y3p0f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 09 Jul 2025 06:55:39 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-3132c8437ffso7271368a91.1
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jul 2025 23:55:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752044138; x=1752648938;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+GJzZgUqMI2hbbRTEmaNiNbgqXt+YXuLS9oqBkPXt7A=;
        b=vMOuXHxLQq9j0mOlylXWasy6azOGLXCQa/BOVTeRC4yNZxhYNDKuw1S+yeTNRwV3Os
         Z10AYwbMKEraVGe3Gtrn99dwEeo3IkPYDpkcRhSiIoEHdYER8+YdABb9nl5RKh1ntxue
         9nc8ir+EdaCYZxvkPXm2ZIO8weWUHV0Sq1xGzuC6dMz6kFiEPyTIPVAR0l7IHrahe729
         kbdjxQzQr5GrvMXdftYOqWq3vRfDWFw3InWHP9M2hA4vd0FwXzmtSu2jglrbzWHKwK9J
         1DuwnKsBcvszViYSfsXAOuW9/UKAVQc7StYUp6gkKIsvR25/3WGdftHX2pkckgYk98P0
         9bvw==
X-Forwarded-Encrypted: i=1; AJvYcCU3JJAbIHuHqbAiG7l9so2ECiKOfic3OePqwAkGfqjBfkRDONdV7YhP35H0i7y1b2k2yeVLhEkjPZ/Wwck=@vger.kernel.org
X-Gm-Message-State: AOJu0YyvAybLXCuDHYuyAGl5yQDbl8tGz8G4Jo/2O206k8ZXGlN3n/rG
	ABY1BL9ROAvFgI0L5k4qobmAT+dCrsCuZRBESeaPlsv+IpDJJRMGd+eGRLXDGXh5L9HKfWbKVNp
	pVeDKHU4N6/ZjWXOtLMqvIkOhL4LPkYmVoI7nUVAWvdWuTU62dDUpcMpTEDolqH3SY8McQp8QIt
	cMxj0x
X-Gm-Gg: ASbGncs4zg+4XNoA0NlYKWdqd1IglT9cMsShBmQk+slEyMB/kI6URtcJTRfDFrvAXMM
	bxoCGDqZYH1kJtStfeChAJudkiETklXdU88CQzUlyhtM8oHkILqhq4XfgUz5ZRQgBwvd6GhN9KA
	30va9q9KIonTAom360Xe5hfniNcEB/gshkIEJc0T8TVXioxhj/LmX3+u1YQr+Ef/2kengr+PgYV
	BKqoTfVdugIz38hqsMirtOqXpW8WjUTYM/mL4rjtvNe6Fr9UoWmESV8CeNId2Vq7XcPFg3WerC1
	24xBogyWivHXamz/99IKk1lDF4++glxeYbSycJ52vLmqnPb5fho=
X-Received: by 2002:a17:90a:da83:b0:311:a4d6:30f8 with SMTP id 98e67ed59e1d1-31c2fcf3c51mr2422593a91.13.1752044137811;
        Tue, 08 Jul 2025 23:55:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF5yfc8Y2jDpZ/E660q3B9XX34ak9hBxhvIIKY9LijykXgX0MytbGPEN8DCwPrxFMRyaT5q+Q==
X-Received: by 2002:a17:90a:da83:b0:311:a4d6:30f8 with SMTP id 98e67ed59e1d1-31c2fcf3c51mr2422559a91.13.1752044137334;
        Tue, 08 Jul 2025 23:55:37 -0700 (PDT)
Received: from hu-kbajaj-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31c3017cc3bsm1191192a91.24.2025.07.08.23.55.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jul 2025 23:55:36 -0700 (PDT)
From: Komal Bajaj <komal.bajaj@oss.qualcomm.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-arm-msm@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Souradeep Chowdhury <quic_schowdhu@quicinc.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Subject: [PATCH v4] usb: misc: qcom_eud: Access EUD_MODE_MANAGER2 through secure calls
Date: Wed,  9 Jul 2025 12:25:14 +0530
Message-ID: <20250709065533.25724-1-komal.bajaj@oss.qualcomm.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzA5MDA2MSBTYWx0ZWRfX9rGrqSnQ74gk
 CSnwDliHn6s/VMOp4UfK/DBslUs7qTWgMUGzbPY31nj+J2i60x6hsqcvzkyCdJvS0OUgB3sui8I
 zDfLNqhJCc/ItL/Ih3mrHUu3K+vNidn/B1parf1lN9xQxhfa4rDxhzL14u/gVZFfi12mekdmIsk
 2GMjn27MDksEPUn8FUJU1Kyp2o4RjYln+oahaZRxPT+Huv2w0+D7Ewuw/WpjVU1+3L1kd4yuio2
 Jd2emDaa8e9ClXFLTviFiDwBeVGjUcvrvbDltui4CXerYcCBUUqN4eZ2vIgctTUnsLSw/jdo9vZ
 G1jKGq5WskpdhBgFtP2IKY6tGiyJLDUrzXsNWtJ11j8fTcZ/pzrWAIJfSeOCdUFQ3lWnq26qQ8q
 x0EX1gcQSH+3pjsmiH1LgxxYyDNfEsmLVMJ8EThIQj7bN9HIDlVbBq9DNVkLTrXSEDaFJlmD
X-Proofpoint-ORIG-GUID: yoYPDdhPG0_W6HKfoC7Z8tYaTPwCBidc
X-Authority-Analysis: v=2.4 cv=DNCP4zNb c=1 sm=1 tr=0 ts=686e126b cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=COk6AnOGAAAA:8 a=eSh0DRBKNElbVECXfMQA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=uKXjsCUrEbL0IQVhDsJ9:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: yoYPDdhPG0_W6HKfoC7Z8tYaTPwCBidc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-09_02,2025-07-08_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 adultscore=0 spamscore=0 clxscore=1015 phishscore=0
 malwarescore=0 mlxlogscore=999 mlxscore=0 lowpriorityscore=0 bulkscore=0
 impostorscore=0 suspectscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507090061

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

 drivers/usb/misc/Kconfig    |  1 +
 drivers/usb/misc/qcom_eud.c | 27 +++++++++++++++++++++------
 2 files changed, 22 insertions(+), 6 deletions(-)

diff --git a/drivers/usb/misc/Kconfig b/drivers/usb/misc/Kconfig
index 6497c4e81e95..f49d5ac0e957 100644
--- a/drivers/usb/misc/Kconfig
+++ b/drivers/usb/misc/Kconfig
@@ -148,6 +148,7 @@ config USB_QCOM_EUD
 	tristate "QCOM Embedded USB Debugger(EUD) Driver"
 	depends on ARCH_QCOM || COMPILE_TEST
 	select USB_ROLE_SWITCH
+	select QCOM_SCM
 	help
 	  This module enables support for Qualcomm Technologies, Inc.
 	  Embedded USB Debugger (EUD). The EUD is a control peripheral
diff --git a/drivers/usb/misc/qcom_eud.c b/drivers/usb/misc/qcom_eud.c
index 83079c414b4f..a58081f53db3 100644
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
@@ -43,18 +44,30 @@ struct eud_chip {
 
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
 
 static void disable_eud(struct eud_chip *priv)
 {
+	int ret;
+
+	ret = qcom_scm_io_writel(priv->mode_mgr + EUD_REG_EUD_EN2, 0);
+	if (ret) {
+		dev_err(priv->dev, "failed to disable eud\n");
+		return;
+	}
+
 	writel(0, priv->base + EUD_REG_CSR_EUD_EN);
-	writel(0, priv->mode_mgr + EUD_REG_EUD_EN2);
 }
 
 static ssize_t enable_show(struct device *dev,
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
-- 
2.48.1


