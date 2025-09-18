Return-Path: <linux-kernel+bounces-751834-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED0FCB16E0F
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 11:01:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1AE061670FC
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 09:01:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DC5E28E5F3;
	Thu, 31 Jul 2025 09:01:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ovOyHnIw"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC4972E3711
	for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 09:01:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753952503; cv=none; b=SwFdAxx2GTrGUmjp1SqAxQfBo+GnGPWa+s1/zpT0tM0f8jZLnG0nDyft0zl2A+sd83EdLIcQgDfVEa5FP9W9V+nyEDou8mmgdVnexzgw/tW57nlkjWnH/8N0pRJLfm7MSrsQv1s+zuWNJmZX2Br/u5wQ0dGXu1BWRp1y/M4vaf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753952503; c=relaxed/simple;
	bh=pc8QwqkvgbAiE6arXF8//zl+k7EP7uH5r4jn0sOA2As=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=kurjTu0AWtbRrkqq70wDq7Wl3LRyXsDV3cXj4kZj1Qd7QN5S0c50Kn0fdADkpFSFQ6brWxe7DbKGc1Z8xeGGgThOgml9sZff3dW9UwK+XOSOo9WP9lpqS4+4a/PS+XkyTNvQlTWOqjkZrgu+hu3EvYJIA90o4AF7yt34Y/zZ3Ug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ovOyHnIw; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56V1fOgB020374
	for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 09:01:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=P/OQxWaaWCrJySN7I3elm1
	yuPAF9rLghBbGZ8dHfSw0=; b=ovOyHnIwk9W+Xo2cTvv2B5TmfqJ2vqHXD8HMYB
	NpsWn+9x0LL1F6deGtd831oDOc7BqMs8hVKZSaloKoSXjkRCPFQscoEaJiH711MV
	8IZE4iboIFKq6SA9DicH+Jz8Se6bTIvTS+ZgPlSDb56ULJuc6zjId+x0Bx96glvH
	b/GmCOZOtOk5/CIMeWBvmwsG4YSDH6/J3PsBKwwMOBEfxPYKUFcIHj8aEFDMEGRw
	FIAuSRAcVBG6O/YWHYagS/cJB51YwYdSdWYDODxbU/izCOUYB2BC5CC36xylTll6
	aEfL5q5iBmKrj1z4sK9CYiH53mwGFwdZtWhfYRWxxSsNIyDg==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 484p1apy3b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 09:01:40 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-23ff6e5c131so6361255ad.2
        for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 02:01:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753952499; x=1754557299;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=P/OQxWaaWCrJySN7I3elm1yuPAF9rLghBbGZ8dHfSw0=;
        b=GyLXZ05nl5INNbgF2mY6BHnuGJ1pKzwzjC1p065/izgdgOoaPq2+jQovtia24LHILi
         ifRKP1WYCrCh4Cjm2VyCYqjRsNps76xi71rXGFdS4uVpJ4d0ueKBr4KS/zncvNysoCqi
         JJ4kNZFZ863v5Js4xF4N0R9SFPmvLDNYzt1wFX/2ntsqg1RDud4dU14TWdFdE5yYms9T
         GuSQvFO/owYABhFC4HCwURs4hJumbSZXY4OpJ3WRW9IYxVSDHWhKvZQEVbYv46gRmmKb
         VgGVrWxIHdcrG8M9bDB7VzUiRl/FrEqmXONWNSjxLXKj0jrgXeL6eS+lh3ZBpHAUoDXn
         h28g==
X-Forwarded-Encrypted: i=1; AJvYcCU9CUTYnrfH99cCgCxMn9k2F+MrhdSmlemRKjydAe1mM1gvny9FzwsDxXcnkbeJ2rPSCL36ffuWETkWZ5Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YxjZ/Rsk4Hff+T2Rwr8reB9t2m+UH8pF4Ph/qdvY3lxbcqOWUj7
	MrMLG7YvmKCLNhTD7SEJVWvjkHqtpzLn4nRdmCx9RWMpK4jhflrWeUTNawq2EifC5k09zgInTHf
	8sOyCo6K7C6a9eogB8Otw/udT56ekLudE4AL96g9LxzSLkkix2JIvpIGBJsLSKHLYPi4=
X-Gm-Gg: ASbGncsNJw4RwnDoiPzcoFJw8IOZ66t0ZEGFBDERgfY8DM9/UBlJjeGR4Cy9VSY0J/z
	sD1pAZuC/wlBpJohpsJCP7Hve8pFTtDh+A9kWtaGJuxUJYUk7cI95QDClY4cvg1lzrGvZFjVsY1
	5Kao/Ica16QMCjpvaM6CuG09gTRnQd827JA+oMFRK2P9ONeJsBivNuTbhXHTH/Jx9Q0pmHpZnqb
	Z2HqILZGklXAhNxhyYlmVRbhllx3P/izYqqXJzt9tK7VXTLwDIu6uXtU8hz4YPM1fY3VxUI0PI9
	8xo3Z7fPVHgSXKshnIahr4PWypImJF7vGt9/Wlq1Su+NXnU8alypnRpi0Bn/uB6+PHrI
X-Received: by 2002:a17:902:e5cb:b0:240:3c51:1063 with SMTP id d9443c01a7336-24096a852d0mr87912925ad.23.1753952498942;
        Thu, 31 Jul 2025 02:01:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF+0/RbBaXs3r/GnxSHXVAIgbuKkX2L0ySwykkOAhnPys/ZtwCTf98DM2oa1PEkcjj2IN6/tg==
X-Received: by 2002:a17:902:e5cb:b0:240:3c51:1063 with SMTP id d9443c01a7336-24096a852d0mr87912565ad.23.1753952498308;
        Thu, 31 Jul 2025 02:01:38 -0700 (PDT)
Received: from hu-kbajaj-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-241e899b783sm12153315ad.133.2025.07.31.02.01.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Jul 2025 02:01:37 -0700 (PDT)
From: Komal Bajaj <komal.bajaj@oss.qualcomm.com>
Date: Thu, 31 Jul 2025 14:31:32 +0530
Subject: [PATCH v8] usb: misc: qcom_eud: Access EUD_MODE_MANAGER2 through
 secure calls
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250731-eud_mode_manager_secure_access-v8-1-4a5dcbb79f41@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIAOswi2gC/43OwW6DMBAE0F+JfK6RsVkbcup/RBXamCU4jXFjB
 9Qq4t9rckJqq/Qy0lzezJ0lio4S2+/uLNLskgtjLvXLjtkBxxNx1+XOpJAgTAmcpq71oaPW44g
 nim0iO0Vq0VpKiWsCQ8qakqxkGfmI1LvPx8DhLfc+Bs9vQyTcsKIRGkCpQoKRFS/5e/B4KY54x
 vNrSKm4Tnixwfsix6oOLt1C/Hq8nmG1/31whuyT0c2RlKi7Cn8OrD9nvVFl+VTVWe1JC6UkoBX
 VH6rZqvKparJaCWqwAt3UDfyiLsvyDRVVpkDFAQAA
X-Change-ID: 20250715-eud_mode_manager_secure_access-6e57e3c71ec2
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Souradeep Chowdhury <quic_schowdhu@quicinc.com>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Melody Olvera <quic_molvera@quicinc.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Komal Bajaj <komal.bajaj@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1753952494; l=6146;
 i=komal.bajaj@oss.qualcomm.com; s=20250710; h=from:subject:message-id;
 bh=pc8QwqkvgbAiE6arXF8//zl+k7EP7uH5r4jn0sOA2As=;
 b=C4I+80Pf1JGAdJgaabFPoABi3rfoayrmCG7VTHc8ric/AZt8SwLJBSaxkKbfjyrnj3+keC/w7
 JN34gfvjicsB6Rypp4vbLN5B/sQJyQ+ML+ugpi41tNKIYB9Ai+B1t91
X-Developer-Key: i=komal.bajaj@oss.qualcomm.com; a=ed25519;
 pk=wKh8mgDh+ePUZ4IIvpBhQOqf16/KvuQHvSvHK20LXNU=
X-Proofpoint-ORIG-GUID: xUmVEEtjdinD52LETSEb89wC_632Kn1f
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzMxMDA2MSBTYWx0ZWRfX1fKCU8a446T3
 RscLfucTw4Mcf4KTITgA1NggpHd6bJSQ6QG8kCvEYeMWqLGzDTPP2dmIjCvlDTIJlROOfHqj8aW
 mcy9GtgWpbwqwocbOVgGX3p/QJwb0yO9jMHwYAxhz32dRN8GX1YceI1lRAWun+6LBRdPL5+06mC
 EppXlJ4vUQ8R6crwocpIf0nT53rS2wGQ2iHkSqT+UQatE4v8PJsmfBGDXwovZ/Soth/6if/UNUN
 9BFfGri4KcOrC0WpMgAAdJ0TKH7QEafmfSkiZ3j/w/b+No/GCqZ1q6IEXUvuDhN3qC8/4mTcywm
 xb9IjBH9bsaWwNyMZjcUIxqQm7NyorrcWDlz8vXRj+WYxCQnB8MkkpUEv7Xssc7ibQaNXkqEHpu
 sp5oE+Th240wEdUl7DdT2j1YMCrmmgQOKdTw9qq3cB3ZIehmk3XBsYH+FW6pNj1XWYNgR1aF
X-Proofpoint-GUID: xUmVEEtjdinD52LETSEb89wC_632Kn1f
X-Authority-Analysis: v=2.4 cv=KtNN2XWN c=1 sm=1 tr=0 ts=688b30f4 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=COk6AnOGAAAA:8 a=lmNMGcLygp3pFLK-ZoUA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=uG9DUKGECoFWVXl0Dc02:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-31_01,2025-07-31_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 lowpriorityscore=0 suspectscore=0
 adultscore=0 mlxlogscore=999 bulkscore=0 spamscore=0 impostorscore=0
 mlxscore=0 malwarescore=0 phishscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507310061

EUD_MODE_MANAGER2 register is mapped to a memory region that is marked
as read-only for operating system running at EL1, enforcing access
restrictions that prohibit direct memory-mapped writes via writel().

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
Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Reviewed-by: Souradeep Chowdhury <quic_schowdhu@quicinc.com>
Signed-off-by: Komal Bajaj <komal.bajaj@oss.qualcomm.com>
---
Changes in v8:
- Switched from depends on QCOM_SCM to select QCOM_SCM in Kconfig, as suggested by Dmitry
- Link to v7: https://lore.kernel.org/r/20250722-eud_mode_manager_secure_access-v7-1-40e9a4569895@oss.qualcomm.com

Changes in v7:
- Updated the commit message as per Greg's comment
- Link to v6: https://lore.kernel.org/r/20250721-eud_mode_manager_secure_access-v6-1-fe603325ac04@oss.qualcomm.com

Changes in v6:
- Propagating the error code from disable_eud(), per Dmitry's suggestion
- Link to v5: https://lore.kernel.org/r/20250715-eud_mode_manager_secure_access-v5-1-e769be308d4a@oss.qualcomm.com

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
index 6497c4e81e951a14201ad965dadc29f9888f8254..9bf8fc6247bacaa2499c6aa04e5acb25c02d0e34 100644
--- a/drivers/usb/misc/Kconfig
+++ b/drivers/usb/misc/Kconfig
@@ -147,6 +147,7 @@ config USB_APPLEDISPLAY
 config USB_QCOM_EUD
 	tristate "QCOM Embedded USB Debugger(EUD) Driver"
 	depends on ARCH_QCOM || COMPILE_TEST
+	select QCOM_SCM
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


